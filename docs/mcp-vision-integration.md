# Vision Model Usage Guide
This tutorial is divided into two parts:
- Part 1: Running xiaozhi-server in single module mode to enable vision models
- Part 2: How to enable vision models when running in full module mode

Before enabling vision models, you need to prepare three things:
- You need to prepare a device with a camera, and this device must already be in XiaGe's repository with camera calling functionality implemented. For example, `LCEDA ESP32-S3 Development Board`
- Your device firmware version should be upgraded to 1.6.6 or above
- You have successfully run the basic dialogue module

## Running xiaozhi-server in Single Module Mode to Enable Vision Models

### Step 1: Confirm Network
Since vision models will start on port 8003 by default.

If you are running with Docker, please confirm whether your `docker-compose.yml` has port `8003` configured. If not, update to the latest `docker-compose.yml` file.

If you are running from source code, confirm that the firewall allows port `8003`.

### Step 2: Choose Your Vision Model
Open your `data/.config.yaml` file and set your `selected_module.VLLM` to a vision model. Currently we support vision models with `openai` type interfaces. `ChatGLMVLLM` is one of the models compatible with `openai`.

```
selected_module:
  VAD: ..
  ASR: ..
  LLM: ..
  VLLM: ChatGLMVLLM
  TTS: ..
  Memory: ..
  Intent: ..
```

Assuming we use `ChatGLMVLLM` as the vision model, we need to first log in to the [Zhipu AI](https://bigmodel.cn/usercenter/proj-mgmt/apikeys) website to apply for an API key. If you have previously applied for a key, you can reuse this key.

Add this configuration to your configuration file. If this configuration already exists, set your api_key.

```
VLLM:
  ChatGLMVLLM:
    api_key: your_api_key
```

### Step 3: Start xiaozhi-server Service
If you are running from source code, enter the command to start:
```
python app.py
```
If you are running with Docker, restart the container:
```
docker restart xiaozhi-esp32-server
```

After startup, the following log content will be output:

```
2025-06-01 **** - OTA interface is           http://192.168.4.7:8003/xiaozhi/ota/
2025-06-01 **** - Vision analysis interface is        http://192.168.4.7:8003/mcp/vision/explain
2025-06-01 **** - WebSocket address is       ws://192.168.4.7:8000/xiaozhi/v1/
2025-06-01 **** - =======The above address is a websocket protocol address, do not access with browser=======
2025-06-01 **** - To test websocket, use Google Chrome to open test_page.html in the test directory
2025-06-01 **** - =============================================================
```

启动后，使用使用浏览器打开日志里`视觉分析接口`连接。看看输出了什么？如果你是linux,没有浏览器，你可以执行这个命令：
```
curl -i 你的视觉分析接口
```

正常来说会这样显示
```
MCP Vision 接口运行正常，视觉解释接口地址是：http://xxxx:8003/mcp/vision/explain
```

请注意，如果你是公网部署，或者docker部署，一定要改一下你的`data/.config.yaml`里这个配置
```
server:
  vision_explain: http://你的ip或者域名:端口号/mcp/vision/explain
```

为什么呢？因为视觉解释接口需要下发到设备，如果你的地址是局域网地址，或者是docker内部地址，设备是无法访问的。

假设你的公网地址是`111.111.111.111`，那么`vision_explain`应该这么配

```
server:
  vision_explain: http://111.111.111.111:8003/mcp/vision/explain
```

如果你的MCP Vision 接口运行正常，且你也试着用浏览器访问正常打开下发的`视觉解释接口地址`，请继续下一步

### 第四步 设备唤醒开启

对设备说“请打开摄像头，说你你看到了什么”

留意xiaozhi-server的日志输出，看看有没有报错。


## How to Enable Vision Models When Running in Full Module Mode

### Step 1: Confirm Network
Since vision models will start on port 8003 by default.

If you are running with Docker, please confirm whether your `docker-compose_all.yml` has port `8003` mapped. If not, update to the latest `docker-compose_all.yml` file.

If you are running from source code, confirm that the firewall allows port `8003`.

### Step 2: Confirm Your Configuration File

Open your `data/.config.yaml` file and confirm whether your configuration file structure is the same as `data/config_from_api.yaml`. If it's different or missing items, please complete them.

### Step 3: Configure Vision Model API Key

We need to first log in to the [Zhipu AI](https://bigmodel.cn/usercenter/proj-mgmt/apikeys) website to apply for an API key. If you have previously applied for a key, you can reuse this key.

Log in to the `Control Panel`, click `Model Configuration` in the top menu, click `Vision Language Model` in the left sidebar, find `VLLM_ChatGLMVLLM`, click the modify button, in the popup dialog, enter your key in `API Key`, and click save.

After successful saving, go to the agent you need to test, click `Configure Role`, in the opened content, check whether `Vision Large Language Model (VLLM)` has selected the vision model just configured. Click save.

### 第三步 启动xiaozhi-server模块
如果你是源码，就输入命令启动
```
python app.py
```
如果你是docker运行，就重启容器
```
docker restart xiaozhi-esp32-server
```

启动后会输出以下内容的日志。

```
2025-06-01 **** - 视觉分析接口是        http://192.168.4.7:8003/mcp/vision/explain
2025-06-01 **** - Websocket地址是       ws://192.168.4.7:8000/xiaozhi/v1/
2025-06-01 **** - =======上面的地址是websocket协议地址，请勿用浏览器访问=======
2025-06-01 **** - 如想测试websocket请用谷歌浏览器打开test目录下的test_page.html
2025-06-01 **** - =============================================================
```

启动后，使用使用浏览器打开日志里`视觉分析接口`连接。看看输出了什么？如果你是linux,没有浏览器，你可以执行这个命令：
```
curl -i 你的视觉分析接口
```

正常来说会这样显示
```
MCP Vision 接口运行正常，视觉解释接口地址是：http://xxxx:8003/mcp/vision/explain
```

请注意，如果你是公网部署，或者docker部署，一定要改一下你的`data/.config.yaml`里这个配置
```
server:
  vision_explain: http://你的ip或者域名:端口号/mcp/vision/explain
```

为什么呢？因为视觉解释接口需要下发到设备，如果你的地址是局域网地址，或者是docker内部地址，设备是无法访问的。

假设你的公网地址是`111.111.111.111`，那么`vision_explain`应该这么配

```
server:
  vision_explain: http://111.111.111.111:8003/mcp/vision/explain
```

如果你的MCP Vision 接口运行正常，且你也试着用浏览器访问正常打开下发的`视觉解释接口地址`，请继续下一步

### 第四步 设备唤醒开启

对设备说“请打开摄像头，说你你看到了什么”

留意xiaozhi-server的日志输出，看看有没有报错。
