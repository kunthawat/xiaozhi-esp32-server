-- VLLM model provider
delete from `ai_model_provider` where id = 'SYSTEM_ASR_DoubaoStreamASR';
INSERT INTO `ai_model_provider` (`id`, `model_type`, `provider_code`, `name`, `fields`, `sort`, `creator`, `create_date`, `updater`, `update_date`) VALUES
('SYSTEM_ASR_DoubaoStreamASR', 'ASR', 'doubao_stream', 'Volcano Engine Speech Recognition (Streaming)', '[{"key":"appid","label":"Application ID","type":"string"},{"key":"access_token","label":"Access Token","type":"string"},{"key":"cluster","label":"Cluster","type":"string"},{"key":"boosting_table_name","label":"Hot Word File Name","type":"string"},{"key":"correct_table_name","label":"Replacement Word File Name","type":"string"},{"key":"output_dir","label":"Output Directory","type":"string"}]', 3, 1, NOW(), 1, NOW());


-- VLLM model configuration
delete from `ai_model_config` where id = 'ASR_DoubaoStreamASR';
INSERT INTO `ai_model_config` VALUES ('ASR_DoubaoStreamASR', 'ASR', 'DoubaoStreamASR', 'Doubao Speech Recognition (Streaming)', 0, 1, '{\"type\": \"doubao_stream\", \"appid\": \"\", \"access_token\": \"\", \"cluster\": \"volcengine_input_common\", \"output_dir\": \"tmp/\"}', NULL, NULL, 3, NULL, NULL, NULL, NULL);


-- Update Doubao ASR configuration description
UPDATE `ai_model_config` SET 
`doc_link` = 'https://console.volcengine.com/speech/app',
`remark` = 'Doubao ASR Configuration Instructions:
1. Difference between Doubao ASR and Doubao Streaming ASR: Doubao ASR charges per request, Doubao Streaming ASR charges per time
2. Generally, per-request charging is cheaper, but Doubao Streaming ASR uses large model technology with better results
3. Need to create application in Volcano Engine console and get appid and access_token
4. Supports Chinese speech recognition
5. Requires network connection
6. Output files saved in tmp/ directory
Application Steps:
1. Visit https://console.volcengine.com/speech/app
2. Create new application
3. Get appid and access_token
4. Fill in configuration file
For hot word settings, please refer to: https://www.volcengine.com/docs/6561/155738
' WHERE `id` = 'ASR_DoubaoASR';

UPDATE `ai_model_config` SET 
`doc_link` = 'https://console.volcengine.com/speech/app',
`remark` = 'Doubao ASR Configuration Instructions:
1. Difference between Doubao ASR and Doubao Streaming ASR: Doubao ASR charges per request, Doubao Streaming ASR charges per time
2. Generally, per-request charging is cheaper, but Doubao Streaming ASR uses large model technology with better results
3. Need to create application in Volcano Engine console and get appid and access_token
4. Supports Chinese speech recognition
5. Requires network connection
6. Output files saved in tmp/ directory
Application Steps:
1. Visit https://console.volcengine.com/speech/app
2. Create new application
3. Get appid and access_token
4. Fill in configuration file
For hot word settings, please refer to: https://www.volcengine.com/docs/6561/155738
' WHERE `id` = 'ASR_DoubaoStreamASR';
