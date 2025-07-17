[![Banners](docs/images/banner1.png)](https://github.com/xinnan-tech/xiaozhi-esp32-server)

<h1 align="center">Xiaozhi Backend Service xiaozhi-esp32-server</h1>

<p align="center">
This project provides backend services for the open-source smart hardware project
<a href="https://github.com/78/xiaozhi-esp32">xiaozhi-esp32</a><br/>
Implemented using Python, Java, and Vue according to the <a href="https://ccnphfhqs21z.feishu.cn/wiki/M0XiwldO9iJwHikpXD5cEx71nKh">Xiaozhi Communication Protocol</a><br/>
Helps you quickly set up a Xiaozhi server
</p>

<p align="center">
<a href="./README.md">中文</a>
· <a href="./docs/FAQ.md">FAQ</a>
· <a href="https://github.com/xinnan-tech/xiaozhi-esp32-server/issues">Report Issues</a>
· <a href="./README.md#%E9%83%A8%E7%BD%B2%E6%96%87%E6%A1%A3">Deployment Docs</a>
· <a href="https://github.com/xinnan-tech/xiaozhi-esp32-server/releases">Changelog</a>
</p>
<p align="center">
  <a href="https://github.com/xinnan-tech/xiaozhi-esp32-server/releases">
    <img alt="GitHub Contributors" src="https://img.shields.io/github/v/release/xinnan-tech/xiaozhi-esp32-server?logo=docker" />
  </a>
  <a href="https://github.com/xinnan-tech/xiaozhi-esp32-server/graphs/contributors">
    <img alt="GitHub Contributors" src="https://img.shields.io/github/contributors/xinnan-tech/xiaozhi-esp32-server?logo=github" />
  </a>
  <a href="https://github.com/xinnan-tech/xiaozhi-esp32-server/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/xinnan-tech/xiaozhi-esp32-server?color=0088ff" />
  </a>
  <a href="https://github.com/xinnan-tech/xiaozhi-esp32-server/pulls">
    <img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/xinnan-tech/xiaozhi-esp32-server?color=0088ff" />
  </a>
  <a href="https://github.com/xinnan-tech/xiaozhi-esp32-server/blob/main/LICENSE">
    <img alt="GitHub pull requests" src="https://img.shields.io/badge/license-MIT-white?labelColor=black" />
  </a>
  <a href="https://github.com/xinnan-tech/xiaozhi-esp32-server">
    <img alt="stars" src="https://img.shields.io/github/stars/xinnan-tech/xiaozhi-esp32-server?color=ffcb47&labelColor=black" />
  </a>
</p>

---

## Target Users 👥

This project needs to be used with ESP32 hardware devices. If you have already purchased ESP32-related hardware, successfully connected to the backend service deployed by Xiage, and want to independently build your own `xiaozhi-esp32` backend service, then this project is perfect for you.

Want to see the effect? Click on the videos 🎥

<table>
  <tr>
    <td>
        <a href="https://www.bilibili.com/video/BV1FMFyejExX" target="_blank">
         <picture>
           <img alt="Xiaozhi ESP32 connecting to your own backend model" src="docs/images/demo1.png" />
         </picture>
        </a>
    </td>
    <td>
        <a href="https://www.bilibili.com/video/BV1CDKWemEU6" target="_blank">
         <picture>
           <img alt="Custom voice" src="docs/images/demo2.png" />
         </picture>
        </a>
    </td>
    <td>
        <a href="https://www.bilibili.com/video/BV12yA2egEaC" target="_blank">
         <picture>
           <img alt="Communicating in Cantonese" src="docs/images/demo3.png" />
         </picture>
        </a>
    </td>
    <td>
        <a href="https://www.bilibili.com/video/BV1pNXWYGEx1" target="_blank">
         <picture>
           <img alt="Controlling home appliances" src="docs/images/demo5.png" />
         </picture>
        </a>
    </td>
    <td>
        <a href="https://www.bilibili.com/video/BV1kgA2eYEQ9" target="_blank">
         <picture>
           <img alt="Lowest cost configuration" src="docs/images/demo4.png" />
         </picture>
        </a>
    </td>
  </tr>
  <tr>
    <td>
        <a href="https://www.bilibili.com/video/BV1Vy96YCE3R" target="_blank">
         <picture>
           <img alt="Custom voice" src="docs/images/demo6.png" />
         </picture>
        </a>
    </td>
    <td>
        <a href="https://www.bilibili.com/video/BV1VC96Y5EMH" target="_blank">
         <picture>
           <img alt="Playing music" src="docs/images/demo7.png" />
         </picture>
        </a>
    </td>
    <td>
        <a href="https://www.bilibili.com/video/BV1Z8XuYZEAS" target="_blank">
         <picture>
           <img alt="Weather plugin" src="docs/images/demo8.png" />
         </picture>
        </a>
    </td>
    <td>
        <a href="https://www.bilibili.com/video/BV178XuYfEpi" target="_blank">
         <picture>
           <img alt="IOT command control device" src="docs/images/demo9.png" />
         </picture>
        </a>
    </td>
    <td>
        <a href="https://www.bilibili.com/video/BV17LXWYvENb" target="_blank">
         <picture>
           <img alt="News broadcasting" src="docs/images/demo0.png" />
         </picture>
        </a>
    </td>
  </tr>
  <tr>
    <td>
      <a href="https://www.bilibili.com/video/BV12J7WzBEaH" target="_blank">
         <picture>
           <img alt="Real-time interruption" src="docs/images/demo10.png" />
         </picture>
        </a>
    </td>
    <td>
      <a href="https://www.bilibili.com/video/BV1Co76z7EvK" target="_blank">
         <picture>
           <img alt="Taking photos to identify items" src="docs/images/demo12.png" />
         </picture>
        </a>
    </td>
    <td>
      <a href="https://www.bilibili.com/video/BV1TJ7WzzEo6" target="_blank">
         <picture>
           <img alt="Multi-command tasks" src="docs/images/demo11.png" />
         </picture>
        </a>
    </td>
    <td>
          <a href="https://www.bilibili.com/video/BV1ZQKUzYExM" target="_blank">
         <picture>
           <img alt="MCP access point" src="docs/images/demo13.png" />
         </picture>
        </a>
    </td>
    <td>
    </td>
  </tr>
</table>

---

## Warning ⚠️

1. This project is open-source software. This software does not have any commercial cooperation relationship with any third-party API service providers (including but not limited to speech recognition, large models, speech synthesis platforms, etc.) that it connects with, and does not provide any form of guarantee for their service quality and financial security. It is recommended that users prioritize service providers that hold relevant business licenses and carefully read their service agreements and privacy policies. This software does not host any account keys, does not participate in fund transfers, and does not bear the risk of recharge fund loss.

2. This project's functionality is not complete and has not passed network security evaluation. Please do not use it in a production environment. If you deploy this project in a public network environment for learning purposes, please make sure to implement necessary protections.

---

## Deployment Documentation

![Banners](docs/images/banner2.png)

This project provides two deployment methods. Please choose according to your specific needs:

#### 🚀 Deployment Method Selection
| Deployment Method | Features | Applicable Scenarios | Deployment Docs | Configuration Requirements | Video Tutorial | 
|---------|------|---------|---------|---------|---------|
| **Minimal Installation** | Smart dialogue, IOT, MCP, visual perception | Low configuration environments, data stored in configuration files, no database needed | [①Docker Version](./docs/Deployment.md#%E6%96%B9%E5%BC%8F%E4%B8%80docker%E5%8F%AA%E8%BF%90%E8%A1%8Cserver) / [②Source Code Deployment](./docs/Deployment.md#%E6%96%B9%E5%BC%8F%E4%BA%8C%E6%9C%AC%E5%9C%B0%E6%BA%90%E7%A0%81%E5%8F%AA%E8%BF%90%E8%A1%8Cserver)| 2 cores 4GB if using `FunASR`, 2 cores 2GB if using all API | - | 
| **Full Module Installation** | Smart dialogue, IOT, MCP access point, visual perception, OTA, Smart Console | Complete feature experience, data stored in database |[①Docker Version](./docs/Deployment_all.md#%E6%96%B9%E5%BC%8F%E4%B8%80docker%E8%BF%90%E8%A1%8C%E5%85%A8%E6%A8%A1%E5%9D%97) / [②Source Code Deployment](./docs/Deployment_all.md#%E6%96%B9%E5%BC%8F%E4%BA%8C%E6%9C%AC%E5%9C%B0%E6%BA%90%E7%A0%81%E8%BF%90%E8%A1%8C%E5%85%A8%E6%A8%A1%E5%9D%97) / [③Source Code Deployment Auto-Update Tutorial](./docs/dev-ops-integration.md) | 4 cores 8GB if using `FunASR`, 2 cores 4GB if using all API| [Local Source Code Startup Video Tutorial](https://www.bilibili.com/video/BV1wBJhz4Ewe) | 


> 💡 Tip: The following is a test platform deployed with the latest code. You can burn it for testing if needed. Concurrency is 6, and data will be cleared daily.

```
Smart Console Address: https://2662r3426b.vicp.fun

Service Test Tool: https://2662r3426b.vicp.fun/test/
OTA Interface Address: https://2662r3426b.vicp.fun/xiaozhi/ota/
Websocket Interface Address: wss://2662r3426b.vicp.fun/xiaozhi/v1/
```

#### 🚩 Configuration Description and Recommendations
> [!Note]
> This project provides two configuration options:
> 
> 1. `Entry-level All Free` configuration: Suitable for personal and home use, all components use free solutions, no additional payment required.
> 
> 2. `Streaming Configuration`: Suitable for demonstrations, training, more than 2 concurrent users, etc. Uses streaming processing technology for faster response and better experience.
> 
> Since version `0.5.2`, the project supports streaming configuration, which improves response speed by about `2.5 seconds` compared to earlier versions, significantly enhancing user experience.

| Module Name | Entry-level All Free Setting | Streaming Configuration |
|:---:|:---:|:---:|
| ASR (Speech Recognition) | FunASR (Local) | 👍FunASRServer or 👍DoubaoStreamASR |
| LLM (Large Language Model) | ChatGLMLLM (Zhipu glm-4-flash) | 👍DoubaoLLM (Volcano doubao-1-5-pro-32k-250115) |
| VLLM (Visual Large Language Model) | ChatGLMVLLM (Zhipu glm-4v-flash) | 👍QwenVLVLLM (Qwen qwen2.5-vl-3b-instructh) |
| TTS (Text-to-Speech) | ✅LinkeraiTTS (Lingxi Streaming) | 👍HuoshanDoubleStreamTTS (Volcano Double Streaming Speech Synthesis) |
| Intent (Intent Recognition) | function_call (Function Call) | function_call (Function Call) |
| Memory (Memory Function) | mem_local_short (Local Short-term Memory) | mem_local_short (Local Short-term Memory) |

#### 🔧 Testing Tools
This project provides the following testing tools to help you verify the system and choose suitable models:

| Tool Name | Location | Usage Method | Function Description |
|:---:|:---|:---:|:---:|
| Audio Interaction Test Tool | main》xiaozhi-server》test》test_page.html | Open directly with Google Chrome | Test audio playback and reception functions, verify if Python-side audio processing is normal |
| Model Response Test Tool 1 | main》xiaozhi-server》performance_tester.py | Execute `python performance_tester.py` | Test the response speed of three core modules: ASR (Speech Recognition), LLM (Large Language Model), and TTS (Text-to-Speech) |
| Model Response Test Tool 2 | main》xiaozhi-server》performance_tester_vllm.py | Execute `python performance_tester_vllm.py` | Test the response speed of VLLM (Visual Model) |

> 💡 Tip: When testing model speed, only models with configured keys will be tested.

---
## Feature List ✨
### Implemented ✅

| Feature Module | Description |
|:---:|:---|
| Core Service Architecture | Based on WebSocket and HTTP servers, providing complete console management and authentication system |
| Voice Interaction System | Supports streaming ASR (Speech Recognition), streaming TTS (Text-to-Speech), VAD (Voice Activity Detection), supports multilingual recognition and voice processing |
| Intelligent Dialogue System | Supports various LLMs (Large Language Models) for intelligent dialogue |
| Visual Perception System | Supports various VLLMs (Visual Large Language Models) for multimodal interaction |
| Intent Recognition System | Supports LLM intent recognition, Function Call function calling, provides plugin-based intent processing mechanism |
| Memory System | Supports local short-term memory, mem0ai interface memory, has memory summarization capability |
| Tool Calling | Supports client IOT protocol, client MCP protocol, server MCP protocol, MCP access point protocol, custom tool functions |
| Management Backend | Provides Web management interface, supports user management, system configuration, and device management |
| Testing Tools | Provides performance testing tools, visual model testing tools, and audio interaction testing tools |
| Deployment Support | Supports Docker deployment and local deployment, provides complete configuration file management |
| Plugin System | Supports function plugin extension, custom plugin development, and plugin hot loading |

### Under Development 🚧

To learn about the specific development plan progress, [click here](https://github.com/users/xinnan-tech/projects/3)

If you are a software developer, here is an [Open Letter to Developers](docs/contributor_open_letter.md). Welcome to join!

---

## Product Ecosystem 👬
Xiaozhi is an ecosystem. When using this product, you can also check out other excellent projects in this ecosystem.

| Project Name | Project Address | Project Description |
|:---------------------|:--------|:--------|
| Xiaozhi Android Client | [xiaozhi-android-client](https://github.com/TOM88812/xiaozhi-android-client) | An Android and iOS voice dialogue application based on xiaozhi-server, supporting real-time voice interaction and text dialogue.<br/>Now it's a Flutter version, connecting both iOS and Android platforms. |
| Xiaozhi Computer Client | [py-xiaozhi](https://github.com/Huang-junsen/py-xiaozhi) | This project provides a Xiaobai AI client implemented in Python, allowing users to experience Xiaozhi AI functionality through code<br/>even without physical hardware conditions. |
| Xiaozhi Java Server | [xiaozhi-esp32-server-java](https://github.com/joey-zhou/xiaozhi-esp32-server-java) | The Xiaozhi open-source backend service Java version is an open-source project based on Java.<br/>It includes front-end and back-end services, aiming to provide users with a complete backend service solution. |

---

## Platforms/Components Supported by This Project 📋

### LLM Language Models

| Usage Method | Supported Platforms | Free Platforms |
|:---:|:---:|:---:|
| openai API Call | Alibaba Bailian, Volcano Engine Doubao, DeepSeek, Zhipu ChatGLM, Gemini | Zhipu ChatGLM, Gemini |
| ollama API Call | Ollama | - |
| dify API Call | Dify | - |
| fastgpt API Call | Fastgpt | - |
| coze API Call | Coze | - |

In fact, any LLM that supports openai API calls can be integrated and used.

---

### VLLM Visual Models

| Usage Method | Supported Platforms | Free Platforms |
|:---:|:---:|:---:|
| openai API Call | Alibaba Bailian, Zhipu ChatGLMVLLM | Zhipu ChatGLMVLLM |

In fact, any VLLM that supports openai API calls can be integrated and used.

---

### TTS Text-to-Speech

| Usage Method | Supported Platforms | Free Platforms |
|:---:|:---:|:---:|
| API Call | EdgeTTS, Volcano Engine Doubao TTS, Tencent Cloud, Alibaba Cloud TTS, CosyVoiceSiliconflow, TTS302AI, CozeCnTTS, GizwitsTTS, ACGNTTS, OpenAITTS, Lingxi Streaming TTS | Lingxi Streaming TTS, EdgeTTS, CosyVoiceSiliconflow (partial) |
| Local Service | FishSpeech, GPT_SOVITS_V2, GPT_SOVITS_V3, MinimaxTTS | FishSpeech, GPT_SOVITS_V2, GPT_SOVITS_V3, MinimaxTTS |

---

### VAD Voice Activity Detection

| Type | Platform Name | Usage Method | Pricing Model | Notes |
|:---:|:---------:|:----:|:----:|:--:|
| VAD | SileroVAD | Local Use | Free | |

---

### ASR Speech Recognition

| Usage Method | Supported Platforms | Free Platforms |
|:---:|:---:|:---:|
| Local Use | FunASR, SherpaASR | FunASR, SherpaASR |
| API Call | DoubaoASR, FunASRServer, TencentASR, AliyunASR | FunASRServer |

---

### Memory Storage

| Type | Platform Name | Usage Method | Pricing Model | Notes |
|:------:|:---------------:|:----:|:---------:|:--:|
| Memory | mem0ai | API Call | 1000 times/month quota | |
| Memory | mem_local_short | Local Summary | Free | |

---

### Intent Recognition

| Type | Platform Name | Usage Method | Pricing Model | Notes |
|:------:|:-------------:|:----:|:-------:|:---------------------:|
| Intent | intent_llm | API Call | Based on LLM pricing | Recognizes intent through large models, strong universality |
| Intent | function_call | API Call | Based on LLM pricing | Completes intent through large model function calls, faster, better effect |

---

## Acknowledgements 🙏

| Logo | Project/Company | Description |
|:---:|:---:|:---|
| <img src="./docs/images/logo_bailing.png" width="160"> | [Bailing Voice Dialogue Robot](https://github.com/wwbin2017/bailing) | This project was inspired by [Bailing Voice Dialogue Robot](https://github.com/wwbin2017/bailing) and implemented based on it |
| <img src="./docs/images/logo_tenclass.png" width="160"> | [Tenclass](https://www.tenclass.com/) | Thanks to [Tenclass](https://www.tenclass.com/) for establishing standard communication protocols, multi-device compatibility solutions, and high-concurrency scenario practice demonstrations for the Xiaozhi ecosystem; providing full-chain technical documentation support for this project |
| <img src="./docs/images/logo_xuanfeng.png" width="160"> | [Xuanfeng Technology](https://github.com/Eric0308) | Thanks to [Xuanfeng Technology](https://github.com/Eric0308) for contributing the function call framework, MCP communication protocol, and plugin-based calling mechanism implementation code, significantly improving the interaction efficiency and functional extensibility of front-end devices (IoT) through standardized instruction scheduling system and dynamic extension capabilities |
| <img src="./docs/images/logo_huiyuan.png" width="160"> | [Huiyuan Design](http://ui.kwd988.net/) | Thanks to [Huiyuan Design](http://ui.kwd988.net/) for providing professional visual solutions for this project, empowering the product user experience of this project with their design practical experience serving thousands of enterprises |
| <img src="./docs/images/logo_qinren.png" width="160"> | [Xi'an Qinren Information Technology](https://www.029app.com/) | Thanks to [Xi'an Qinren Information Technology](https://www.029app.com/) for deepening the visual system of this project, ensuring the consistency and scalability of the overall design style in multi-scenario applications |


<a href="https://star-history.com/#xinnan-tech/xiaozhi-esp32-server&Date">

 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=xinnan-tech/xiaozhi-esp32-server&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=xinnan-tech/xiaozhi-esp32-server&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=xinnan-tech/xiaozhi-esp32-server&type=Date" />
 </picture>
</a>