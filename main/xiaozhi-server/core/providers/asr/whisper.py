import time
import os
import sys
import io
import tempfile
import wave
from config.logger import setup_logging
from typing import Optional, Tuple, List
from core.providers.asr.base import ASRProviderBase
from core.providers.asr.dto.dto import InterfaceType

TAG = __name__
logger = setup_logging()

MAX_RETRIES = 2
RETRY_DELAY = 1  # Retry delay (seconds)

try:
    import whisper
    WHISPER_AVAILABLE = True
except ImportError:
    logger.bind(tag=TAG).warning("Whisper not installed. Please install it using 'pip install -r requirements-whisper.txt'")
    WHISPER_AVAILABLE = False


class ASRProvider(ASRProviderBase):
    def __init__(self, config: dict, delete_audio_file: bool):
        super().__init__()
        
        self.interface_type = InterfaceType.LOCAL
        self.model_name = config.get("model_name", "base")
        self.output_dir = config.get("output_dir", "tmp/")
        self.delete_audio_file = delete_audio_file
        self.language = config.get("language", None)  # Language code or None for auto-detection
        
        # Ensure output directory exists
        os.makedirs(self.output_dir, exist_ok=True)
        
        if not WHISPER_AVAILABLE:
            logger.bind(tag=TAG).error(
                "Whisper is not installed. Please install it using 'pip install -r requirements-whisper.txt'"
            )
            return
        
        # Load Whisper model
        logger.bind(tag=TAG).info(f"Loading Whisper model: {self.model_name}")
        try:
            self.model = whisper.load_model(self.model_name)
            logger.bind(tag=TAG).info(f"Whisper model loaded successfully")
        except Exception as e:
            logger.bind(tag=TAG).error(f"Failed to load Whisper model: {e}")
            self.model = None

    async def speech_to_text(
        self, opus_data: List[bytes], session_id: str, audio_format="opus"
    ) -> Tuple[Optional[str], Optional[str]]:
        """Convert speech to text using Whisper"""
        file_path = None
        retry_count = 0

        if not WHISPER_AVAILABLE or self.model is None:
            logger.bind(tag=TAG).error("Whisper is not available or model failed to load")
            return "", None

        while retry_count < MAX_RETRIES:
            try:
                # Combine all opus data packets
                if audio_format == "pcm":
                    pcm_data = opus_data
                else:
                    pcm_data = self.decode_opus(opus_data)

                combined_pcm_data = b"".join(pcm_data)
                
                # Save audio to a temporary file for Whisper processing
                with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as temp_file:
                    temp_path = temp_file.name
                    
                    # Write WAV header and data
                    with wave.open(temp_path, "wb") as wf:
                        wf.setnchannels(1)
                        wf.setsampwidth(2)  # 2 bytes = 16-bit
                        wf.setframerate(16000)
                        wf.writeframes(combined_pcm_data)
                
                # Save permanent copy if needed
                if not self.delete_audio_file:
                    file_path = self.save_audio_to_file(pcm_data, session_id)
                
                # Perform speech recognition
                start_time = time.time()
                
                # Use Whisper to transcribe
                result = self.model.transcribe(
                    temp_path,
                    language=self.language,
                    task="transcribe"
                )
                
                text = result["text"].strip()
                
                logger.bind(tag=TAG).debug(
                    f"Speech recognition time: {time.time() - start_time:.3f}s | Result: {text}"
                )
                
                # Clean up temporary file
                try:
                    os.unlink(temp_path)
                except Exception as e:
                    logger.bind(tag=TAG).warning(f"Failed to delete temporary file: {e}")
                
                return text, file_path

            except Exception as e:
                retry_count += 1
                if retry_count >= MAX_RETRIES:
                    logger.bind(tag=TAG).error(
                        f"Speech recognition failed (after {retry_count} retries): {e}", exc_info=True
                    )
                    return "", file_path
                logger.bind(tag=TAG).warning(
                    f"Speech recognition failed, retrying ({retry_count}/{MAX_RETRIES}): {e}"
                )
                time.sleep(RETRY_DELAY)

            finally:
                # File cleanup logic
                if self.delete_audio_file and file_path and os.path.exists(file_path):
                    try:
                        os.remove(file_path)
                        logger.bind(tag=TAG).debug(f"Deleted temporary audio file: {file_path}")
                    except Exception as e:
                        logger.bind(tag=TAG).error(
                            f"File deletion failed: {file_path} | Error: {e}"
                        )