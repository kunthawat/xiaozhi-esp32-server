-- Add Aliyun Streaming ASR provider
delete from `ai_model_provider` where id = 'SYSTEM_ASR_AliyunStreamASR';
INSERT INTO `ai_model_provider` (`id`, `model_type`, `provider_code`, `name`, `fields`, `sort`, `creator`, `create_date`, `updater`, `update_date`) VALUES
('SYSTEM_ASR_AliyunStreamASR', 'ASR', 'aliyun_stream', 'Aliyun Speech Recognition (Streaming)', '[{"key":"appkey","label":"Application AppKey","type":"string"},{"key":"token","label":"Temporary Token","type":"string"},{"key":"access_key_id","label":"AccessKey ID","type":"string"},{"key":"access_key_secret","label":"AccessKey Secret","type":"string"},{"key":"host","label":"Service Address","type":"string"},{"key":"max_sentence_silence","label":"Sentence Break Detection Time","type":"number"},{"key":"output_dir","label":"Output Directory","type":"string"}]', 6, 1, NOW(), 1, NOW());

-- Add Aliyun Streaming ASR model configuration
delete from `ai_model_config` where id = 'ASR_AliyunStreamASR';
INSERT INTO `ai_model_config` VALUES ('ASR_AliyunStreamASR', 'ASR', 'AliyunStreamASR', 'Aliyun Speech Recognition (Streaming)', 0, 1, '{\"type\": \"aliyun_stream\", \"appkey\": \"\", \"token\": \"\", \"access_key_id\": \"\", \"access_key_secret\": \"\", \"host\": \"nls-gateway-cn-shanghai.aliyuncs.com\", \"max_sentence_silence\": 800, \"output_dir\": \"tmp/\"}', NULL, NULL, 8, NULL, NULL, NULL, NULL);

-- Update Aliyun Streaming ASR configuration description
UPDATE `ai_model_config` SET 
`doc_link` = 'https://nls-portal.console.aliyun.com/',
`remark` = 'Aliyun Streaming ASR Configuration Instructions:
1. Difference between Aliyun ASR and Aliyun Streaming ASR: Aliyun ASR is one-time recognition, Aliyun Streaming ASR is real-time streaming recognition
2. Streaming ASR has lower latency and better real-time performance, suitable for voice interaction scenarios
3. Need to create application in Aliyun Intelligent Speech Interaction console and obtain authentication information
4. Supports Chinese real-time speech recognition, punctuation prediction and inverse text normalization
5. Requires network connection, output files saved in tmp/ directory
Application Steps:
1. Visit https://nls-portal.console.aliyun.com/ to enable Intelligent Speech Interaction service
2. Visit https://nls-portal.console.aliyun.com/applist to create project and get appkey
3. Visit https://nls-portal.console.aliyun.com/overview to get temporary token (or configure access_key_id and access_key_secret for automatic retrieval)
4. For dynamic token management, recommend configuring access_key_id and access_key_secret
5. max_sentence_silence parameter controls sentence break detection time (milliseconds), default 800ms
For more parameter configuration information, please refer to: https://help.aliyun.com/zh/isi/developer-reference/real-time-speech-recognition
' WHERE `id` = 'ASR_AliyunStreamASR';
