# Frequently Asked Questions ❓

### 1. Why does Xiaozhi recognize a lot of Korean, Japanese, and English when I speak? 🇰🇷

Suggestion: Check if you have the `model.pt` file in `models/SenseVoiceSmall`.
If not, you need to download it. See [Download Speech Recognition Model Files](Deployment.md#模型文件)

### 2. Why do I get "TTS task error: File does not exist"? 📁

Suggestion: Check if you have correctly installed the `libopus` and `ffmpeg` libraries using `conda`.

If not installed, install them:

```
conda install conda-forge::libopus
conda install conda-forge::ffmpeg
```

### 3. TTS frequently fails or times out ⏰

Suggestion: If `EdgeTTS` frequently fails, first check if you are using a proxy. If so, try turning off the proxy and try again.  
If you are using Volcano Engine's Doubao TTS and it frequently fails, consider using the paid version, as the test version only supports 2 concurrent connections.

### 4. Can connect to self-built server using WiFi, but can't connect in 4G mode 🔐

Reason: Xiage's firmware requires a secure connection in 4G mode.

Solutions: There are currently two methods to solve this. Choose one:

1. Modify the code. Refer to this video for a solution: https://www.bilibili.com/video/BV18MfTYoE85

2. Use nginx to configure an SSL certificate. Refer to this tutorial: https://icnt94i5ctj4.feishu.cn/docx/GnYOdMNJOoRCljx1ctecsj9cnRe

### 5. How to improve Xiaozhi's dialogue response speed? ⚡

The default configuration of this project is a low-cost solution. It is recommended that beginners first use the default free models to solve the "running" problem, then optimize for "running fast".  
To improve response speed, you can try replacing various components. Below are response speed test data for various components (for reference only, not a commitment):

| Factor | Value |
|:-----:|:----------------:|
| Test Location | Haizhu District, Guangzhou, Guangdong Province |
| Test Time | February 19, 2025, 12:52 |
| Broadband Provider | China Unicom |

Test Method:

1. Configure the keys for each component. Only components with configured keys participate in the test.

2. After configuring the keys, execute the following method:

```
# Navigate to the project root directory and execute the following command:
conda activate xiaozhi-esp32-server
python performance_tester.py 
```

The generated report is as follows:

LLM Performance Ranking:

| Module Name | Average First Token Time | Average Total Response Time |
|:-----------|:-----------|:--------|
| AliLLM     | 0.547s     | 1.485s  |
| ChatGLMLLM | 0.677s     | 3.057s  |

TTS Performance Ranking:

| Module Name | Average Synthesis Time |
|----------------------|--------|
| EdgeTTS              | 1.019s |
| DoubaoTTS            | 0.503s |
| CosyVoiceSiliconflow | 3.732s |

Recommended Configuration Combinations (Comprehensive Response Speed):

| Combination | Comprehensive Score | LLM First Token | TTS Synthesis |
|-------------------------------|-------|-----------|--------|
| AliLLM + DoubaoTTS            | 0.539 | 0.547s    | 0.503s |
| AliLLM + EdgeTTS              | 0.642 | 0.547s    | 1.019s |
| ChatGLMLLM + DoubaoTTS        | 0.642 | 0.677s    | 0.503s |
| ChatGLMLLM + EdgeTTS          | 0.745 | 0.677s    | 1.019s |
| AliLLM + CosyVoiceSiliconflow | 1.184 | 0.547s    | 3.732s |

### Conclusion 🔍

As of `February 19, 2025`, if my computer is in `Haizhu District, Guangzhou, Guangdong Province` and I'm using `China Unicom` network, I would prioritize using:

- LLM: `AliLLM`
- TTS: `DoubaoTTS`

### 6. I speak slowly with pauses, but Xiaozhi keeps interrupting 🗣️

Suggestion: Find the following section in the configuration file and increase the value of `min_silence_duration_ms` (for example, change it to `1000`):

```yaml
VAD:
  SileroVAD:
    threshold: 0.5
    model_dir: models/snakers4_silero-vad
    min_silence_duration_ms: 700  # If speech pauses are longer, increase this value
```

### 7. I want to control lights, air conditioners, remote power on/off, etc. through Xiaozhi 💡

Refer to the tutorial [ESP32 Device and HomeAssistant Integration Guide](./homeassistant-integration.md)

### 8. How to enable mobile phone registration for the Smart Console 📱

Refer to the tutorial [Alibaba Cloud SMS Integration Guide](./ali-sms-integration.md)

### 9. How to enable the vision model for photo recognition 📷

Refer to the tutorial [Vision Model Usage Guide](./mcp-vision-integration_en.md)

### 10. For more questions, you can contact us for feedback 💬

You can submit your questions in [issues](https://github.com/xinnan-tech/xiaozhi-esp32-server/issues).

You can also contact us by email: huangrongzhuang@xin-nan.com