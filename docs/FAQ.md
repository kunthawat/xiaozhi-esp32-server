# Frequently Asked Questions ❓

### 1. Why does XiaoZhi recognize my speech as Korean, Japanese, or English? 🇰🇷

Suggestion: Check if `models/SenseVoiceSmall` already has the `model.pt` file. If not, you need to download it. See here: [Download Speech Recognition Model Files](Deployment.md#模型文件)

### 2. Why does "TTS task error file does not exist" appear? 📁

Suggestion: Check if you have correctly installed the `libopus` and `ffmpeg` libraries using `conda`.

If not installed, install them:

```
conda install conda-forge::libopus
conda install conda-forge::ffmpeg
```

### 3. TTS frequently fails and times out ⏰

Suggestion: If `EdgeTTS` frequently fails, first check if you are using a proxy (VPN). If so, try disabling the proxy and try again.  
If you are using Volcano Engine's Doubao TTS and it frequently fails, it is recommended to use the paid version, as the test version only supports 2 concurrent connections.

### 4. Can connect to self-built server using WiFi, but cannot connect in 4G mode 🔐

Reason: XiaGe's firmware requires secure connections in 4G mode.

Solution: There are currently two methods to solve this. Choose one:

1. Modify the code. Refer to this video for solution: https://www.bilibili.com/video/BV18MfTYoE85

2. Use nginx to configure SSL certificate. Refer to tutorial: https://icnt94i5ctj4.feishu.cn/docx/GnYOdMNJOoRCljx1ctecsj9cnRe

### 5. How to improve XiaoZhi's dialogue response speed? ⚡

This project's default configuration is a low-cost solution. It is recommended that beginners first use the default free models to solve the "can run" problem, then optimize for "runs fast".  
To improve response speed, you can try replacing various components. The following are response speed test data for each component (for reference only, not a commitment):

| Influencing Factor |       Factor Value        | 
|:-----:|:----------------:|
| Test Location  |    Haizhu District, Guangzhou, Guangdong Province     |
| Test Time  | February 19, 2025 12:52 |
| Broadband Provider |       China Unicom       |

Test Method:

1. Configure the API keys for each component. Only components with configured keys will participate in the test.

2. After configuring the keys, execute the following method:

```
# Enter the project root directory and execute the following commands:
conda activate xiaozhi-esp32-server
python performance_tester.py 
```

Generated report as follows:

LLM Performance Ranking:

| Module Name    | Average First Token Time | Average Total Response Time |
|:-----------|:-----------|:--------|
| AliLLM     | 0.547s     | 1.485s  |
| ChatGLMLLM | 0.677s     | 3.057s  |

TTS Performance Ranking:

| Module Name              | Average Synthesis Time |
|----------------------|--------|
| EdgeTTS              | 1.019s |
| DoubaoTTS            | 0.503s |
| CosyVoiceSiliconflow | 3.732s |

Recommended Configuration Combinations (Overall Response Speed):

| Combination Solution                  | Overall Score  | LLM First Token | TTS Synthesis  |
|-------------------------------|-------|-----------|--------|
| AliLLM + DoubaoTTS            | 0.539 | 0.547s    | 0.503s |
| AliLLM + EdgeTTS              | 0.642 | 0.547s    | 1.019s |
| ChatGLMLLM + DoubaoTTS        | 0.642 | 0.677s    | 0.503s |
| ChatGLMLLM + EdgeTTS          | 0.745 | 0.677s    | 1.019s |
| AliLLM + CosyVoiceSiliconflow | 1.184 | 0.547s    | 3.732s |

### Conclusion 🔍

As of `February 19, 2025`, if my computer is in `Haizhu District, Guangzhou, Guangdong Province` and using `China Unicom` network, I would prioritize using:

- LLM: `AliLLM`
- TTS: `DoubaoTTS`

### 6. I speak slowly, and XiaoZhi always interrupts during pauses 🗣️

Suggestion: Find the following section in the configuration file and increase the value of `min_silence_duration_ms` (for example, change it to `1000`):

```yaml
VAD:
  SileroVAD:
    threshold: 0.5
    model_dir: models/snakers4_silero-vad
    min_silence_duration_ms: 700  # If speech pauses are long, increase this value
```

### 7. I want to control lights, air conditioning, remote power on/off through XiaoZhi 💡

Refer to tutorial: [ESP32 Device and Home Assistant Integration Guide](./homeassistant-integration.md)

### 8. How to enable mobile phone registration for the control panel 📱

Refer to tutorial: [Alibaba Cloud SMS Integration Guide](./ali-sms-integration.md)

### 9. How to enable vision models for photo object recognition 📷

Refer to tutorial: [Vision Model Usage Guide](./mcp-vision-integration.md)

### 10. How to enable MCP access points 🔧

1. First refer to tutorial: [MCP Access Point Deployment Usage Guide](./mcp-endpoint-enable.md)

2. Then refer to tutorial: [MCP Access Point Usage Guide](./mcp-endpoint-integration.md)

### 12. How to enable voiceprint recognition 🔊

Refer to tutorial: [Voiceprint Recognition Enablement Guide](./voiceprint-integration.md)

### 13. For more questions, you can contact us for feedback 💬

You can submit your questions in [issues](https://github.com/xinnan-tech/xiaozhi-esp32-server/issues).

You can also contact us by email: huangrongzhuang@xin-nan.com