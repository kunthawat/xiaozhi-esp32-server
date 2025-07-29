-- Fix ai_tts_voice name column size for English translations
-- The current VARCHAR(20) is too small for English names like "EdgeTTS Female - Liaoning Xiaobei"

ALTER TABLE `ai_tts_voice` MODIFY COLUMN `name` VARCHAR(100) COMMENT '音色名称';