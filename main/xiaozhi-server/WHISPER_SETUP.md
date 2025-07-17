# Whisper ASR Setup Guide

This guide explains how to set up OpenAI's Whisper model for multilingual speech recognition in the Xiaozhi ESP32 Server.

## Overview

Whisper is an automatic speech recognition (ASR) system trained on 680,000 hours of multilingual and multitask supervised data collected from the web. It offers robust speech recognition across many languages and can translate those languages into English.

## Installation

1. Install the required dependencies:

```bash
pip install -r requirements-whisper.txt
```

2. Make sure you have FFmpeg installed on your system:

```bash
# For Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y ffmpeg

# For macOS
brew install ffmpeg

# For Windows
# Download from https://ffmpeg.org/download.html
```

## Configuration

The Whisper ASR provider is already configured in the `config.yaml` file. The default configuration uses the "base" model, which offers a good balance between accuracy and performance.

```yaml
ASR:
  WhisperASR:
    # OpenAI's Whisper model for multilingual speech recognition
    type: whisper
    # Model name can be one of: tiny, base, small, medium, large
    # Smaller models are faster but less accurate
    # Larger models are more accurate but require more resources
    model_name: base
    # Language can be set to a specific language code or null for auto-detection
    # Examples: en, es, fr, de, ja, zh, etc.
    language: null
    output_dir: tmp/
```

### Model Options

Whisper offers several model sizes:

| Model Size | Parameters | Required VRAM | Relative Speed |
|------------|------------|---------------|---------------|
| tiny       | 39 M       | ~1 GB         | ~32x          |
| base       | 74 M       | ~1 GB         | ~16x          |
| small      | 244 M      | ~2 GB         | ~6x           |
| medium     | 769 M      | ~5 GB         | ~2x           |
| large      | 1550 M     | ~10 GB        | 1x            |

Choose the model size based on your hardware capabilities and accuracy requirements.

### Language Support

Whisper supports a wide range of languages. You can either:

1. Set `language: null` for automatic language detection
2. Specify a language code for better accuracy in that language

Supported language codes include:
- English: `en`
- Spanish: `es`
- French: `fr`
- German: `de`
- Japanese: `ja`
- Chinese: `zh`
- And many more

## Usage

Once installed and configured, the Whisper ASR provider will be used automatically when selected in the `config.yaml` file:

```yaml
selected_module:
  # Voice activity detection module
  VAD: SileroVAD
  # Speech recognition module
  ASR: WhisperASR
```

## Troubleshooting

If you encounter issues with Whisper:

1. Check the logs for any error messages
2. Ensure you have installed all dependencies correctly
3. Verify that FFmpeg is installed and accessible
4. Try a smaller model if you're experiencing memory issues

## Performance Considerations

- The first time you use Whisper, it will download the model, which may take some time depending on your internet connection
- Larger models provide better accuracy but require more memory and processing power
- For devices with limited resources, use the "tiny" or "base" models
- Processing time depends on the length of the audio and the model size