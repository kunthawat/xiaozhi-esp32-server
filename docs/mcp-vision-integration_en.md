# Vision Model Usage Guide
This tutorial is divided into two parts:
- Part One: Running xiaozhi-server as a single module with vision model enabled
- Part Two: How to enable the vision model when running all modules

Before enabling the vision model, you need to prepare three things:
- You need a device with a camera, and this device has already implemented camera functionality in Xiage's repository. For example, `LiChuan·Practical ESP32-S3 Development Board`
- Your device firmware version is upgraded to 1.6.6 or above
- You have successfully run the basic dialogue module

## Running xiaozhi-server as a Single Module with Vision Model Enabled

### Step 1: Confirm Network
The vision model will start on port 8003 by default.

If you are running Docker, please check if your `docker-compose.yml` has exposed port `8003`. If not, update to the latest `docker-compose.yml` file.

If you are running from source code, make sure your firewall allows port `8003`.

### Step 2: Choose Your Vision Model
Open your `data/.config.yaml` file, set your `selected_module.VLLM` to a vision model. Currently, we support vision models with `openai` type interfaces. `ChatGLMVLLM` is one of the models compatible with `openai`.

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

Assuming we use `ChatGLMVLLM` as the vision model, we need to first log in to the [Zhipu AI](https://bigmodel.cn/usercenter/proj-mgmt/apikeys) website and apply for a key. If you have already applied for a key before, you can reuse it.

Add this configuration to your configuration file. If you already have this configuration, just set your api_key.

```
VLLM:
  ChatGLMVLLM:
    api_key: your_api_key
```

### Step 3: Start the xiaozhi-server Service
If you are running from source code, enter the command to start:
```
python app.py
```
If you are running Docker, restart the container:
```
docker restart xiaozhi-esp32-server
```

After starting, the following log content will be output:

```
2025-06-01 **** - OTA interface is           http://192.168.4.7:8003/xiaozhi/ota/
2025-06-01 **** - Vision analysis interface is        http://192.168.4.7:8003/mcp/vision/explain
2025-06-01 **** - Websocket address is       ws://192.168.4.7:8000/xiaozhi/v1/
2025-06-01 **** - =======The above address is a websocket protocol address, please do not access it with a browser=======
2025-06-01 **** - If you want to test websocket, please use Google Chrome to open test_page.html in the test directory
2025-06-01 **** - =============================================================
```

After starting, use a browser to open the `Vision analysis interface` link from the log. What does it output? If you are using Linux without a browser, you can execute this command:
```
curl -i your_vision_analysis_interface
```

Normally, it should display:
```
MCP Vision interface is running normally, the vision explanation interface address is: http://xxxx:8003/mcp/vision/explain
```

Please note, if you are deploying on a public network or using Docker, you must modify this configuration in your `data/.config.yaml`:
```
server:
  vision_explain: http://your_ip_or_domain:port/mcp/vision/explain
```

Why? Because the vision explanation interface needs to be sent to the device, and if your address is a local network address or a Docker internal address, the device cannot access it.

Suppose your public network address is `111.111.111.111`, then `vision_explain` should be configured as:

```
server:
  vision_explain: http://111.111.111.111:8003/mcp/vision/explain
```

If your MCP Vision interface is running normally, and you have also tried to access the `vision explanation interface address` with a browser and it opens normally, please continue to the next step.

### Step 4: Device Wake-up and Activation

Say to the device: "Please turn on the camera and tell me what you see."

Pay attention to the xiaozhi-server log output to see if there are any errors.


## How to Enable the Vision Model When Running All Modules

### Step 1: Confirm Network
The vision model will start on port 8003 by default.

If you are running Docker, please check if your `docker-compose_all.yml` has mapped port `8003`. If not, update to the latest `docker-compose_all.yml` file.

If you are running from source code, make sure your firewall allows port `8003`.

### Step 2: Confirm Your Configuration File

Open your `data/.config.yaml` file and check if the structure of your configuration file is the same as `data/config_from_api.yaml`. If it's different or missing certain items, please complete it.

### Step 3: Configure Vision Model Key

We need to first log in to the [Zhipu AI](https://bigmodel.cn/usercenter/proj-mgmt/apikeys) website and apply for a key. If you have already applied for a key before, you can reuse it.

Log in to the `Smart Console`, click on `Model Configuration` in the top menu, click on `Vision to Language Model` in the left sidebar, find `VLLM_ChatGLMVLLM`, click the edit button, enter your key in the `API Key` field in the popup, and click save.

After saving successfully, go to the intelligent agent you need to test, click `Configure Role`, in the opened content, check if the `Vision Large Language Model (VLLM)` has selected the vision model you just configured. Click save.

### Step 3: Start the xiaozhi-server Module
If you are running from source code, enter the command to start:
```
python app.py
```
If you are running Docker, restart the container:
```
docker restart xiaozhi-esp32-server
```

After starting, the following log content will be output:

```
2025-06-01 **** - Vision analysis interface is        http://192.168.4.7:8003/mcp/vision/explain
2025-06-01 **** - Websocket address is       ws://192.168.4.7:8000/xiaozhi/v1/
2025-06-01 **** - =======The above address is a websocket protocol address, please do not access it with a browser=======
2025-06-01 **** - If you want to test websocket, please use Google Chrome to open test_page.html in the test directory
2025-06-01 **** - =============================================================
```

After starting, use a browser to open the `Vision analysis interface` link from the log. What does it output? If you are using Linux without a browser, you can execute this command:
```
curl -i your_vision_analysis_interface
```

Normally, it should display:
```
MCP Vision interface is running normally, the vision explanation interface address is: http://xxxx:8003/mcp/vision/explain
```

Please note, if you are deploying on a public network or using Docker, you must modify this configuration in your `data/.config.yaml`:
```
server:
  vision_explain: http://your_ip_or_domain:port/mcp/vision/explain
```

Why? Because the vision explanation interface needs to be sent to the device, and if your address is a local network address or a Docker internal address, the device cannot access it.

Suppose your public network address is `111.111.111.111`, then `vision_explain` should be configured as:

```
server:
  vision_explain: http://111.111.111.111:8003/mcp/vision/explain
```

If your MCP Vision interface is running normally, and you have also tried to access the `vision explanation interface address` with a browser and it opens normally, please continue to the next step.

### Step 4: Device Wake-up and Activation

Say to the device: "Please turn on the camera and tell me what you see."

Pay attention to the xiaozhi-server log output to see if there are any errors.