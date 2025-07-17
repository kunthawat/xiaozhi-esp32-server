# Deployment Architecture Diagram
![Reference - Full Module Installation Architecture Diagram](../docs/images/deploy2.png)

# Method 1: Docker Full Module Deployment
Docker images support x86 architecture, arm64 architecture CPUs, and can run on various operating systems.

## 1. Install Docker

If you haven't installed Docker on your computer yet, you can follow this tutorial: [Docker Installation](https://docs.docker.com/engine/install/)

#### 1.1 Create Directories

After installation, you need to find a directory to store the configuration files for this project. For example, we can create a new folder called `xiaozhi-server`.

After creating the directory, you need to create `data`, `models`, and `whisper_cache` folders under `xiaozhi-server`. Under the `models` folder, create another folder called `SenseVoiceSmall`.

The final directory structure should look like this:

```
xiaozhi-server
  ├─ data
  ├─ models
     ├─ SenseVoiceSmall
  ├─ whisper_cache
```

#### 1.2 Download Speech Recognition Model Files

This project uses the `SenseVoiceSmall` model for speech-to-text by default. Because the model is large, it needs to be downloaded separately. After downloading, place the `model.pt` file in the `models/SenseVoiceSmall` directory. Choose one of the following download routes:

- Route 1: Download from Alibaba ModelScope [SenseVoiceSmall](https://modelscope.cn/models/iic/SenseVoiceSmall/resolve/master/model.pt)
- Route 2: Download from Baidu Netdisk [SenseVoiceSmall](https://pan.baidu.com/share/init?surl=QlgM58FHhYv1tFnUT_A8Sg&pwd=qvna) Extraction code: `qvna`

#### 1.3 Download Configuration Files

You need to download two configuration files: `docker-compose_all.yaml` and `config_from_api.yaml`. These files need to be downloaded from the project repository.

##### 1.3.1 Download docker-compose_all.yaml

Open [this link](../main/xiaozhi-server/docker-compose_all.yml) in your browser.

On the right side of the page, find the `RAW` button. Next to the `RAW` button, find the download icon, click the download button, and download the `docker-compose_all.yml` file. Save the file to your `xiaozhi-server` directory.

Alternatively, you can directly execute `wget https://raw.githubusercontent.com/xinnan-tech/xiaozhi-esp32-server/refs/heads/main/main/xiaozhi-server/docker-compose_all.yml` to download it.

After downloading, continue with this tutorial.

##### 1.3.2 Download config_from_api.yaml

Open [this link](../main/xiaozhi-server/config_from_api.yaml) in your browser.

On the right side of the page, find the `RAW` button. Next to the `RAW` button, find the download icon, click the download button, and download the `config_from_api.yaml` file. Save the file to the `data` folder in your `xiaozhi-server` directory, then rename `config_from_api.yaml` to `.config.yaml`.

Alternatively, you can directly execute `wget https://raw.githubusercontent.com/xinnan-tech/xiaozhi-esp32-server/refs/heads/main/main/xiaozhi-server/config_from_api.yaml` to download it.

After downloading the configuration files, let's confirm that the entire `xiaozhi-server` directory structure looks like this:

```
xiaozhi-server
  ├─ docker-compose_all.yml
  ├─ data
    ├─ .config.yaml
  ├─ models
     ├─ SenseVoiceSmall
       ├─ model.pt
  ├─ whisper_cache
```

If your directory structure matches the above, continue to the next step. If not, carefully check if you missed any operations.

## 2. Backup Data

If you have previously successfully run the Control Panel and have important key information stored there, please copy the important data first. During the upgrade process, there is a possibility that the original data may be overwritten.

## 3. Clear Historical Version Images and Containers
Next, open a command line tool, use the `terminal` or `command line` tool to enter your `xiaozhi-server` directory, and execute the following commands:

```
docker compose -f docker-compose_all.yml down

docker stop xiaozhi-esp32-server
docker rm xiaozhi-esp32-server

docker stop xiaozhi-esp32-server-web
docker rm xiaozhi-esp32-server-web

docker stop xiaozhi-esp32-server-db
docker rm xiaozhi-esp32-server-db

docker stop xiaozhi-esp32-server-redis
docker rm xiaozhi-esp32-server-redis

docker rmi ghcr.nju.edu.cn/xinnan-tech/xiaozhi-esp32-server:server_latest
docker rmi ghcr.nju.edu.cn/xinnan-tech/xiaozhi-esp32-server:web_latest
```

## 4. Run the Program
Execute the following command to start the new version containers:

```
docker compose -f docker-compose_all.yml up -d
```

After execution, run the following command to view the log information:

```
docker logs -f xiaozhi-esp32-server-web
```

When you see the output logs, it means your `Control Panel` has started successfully:

```
2025-xx-xx 22:11:12.445 [main] INFO  c.a.d.s.b.a.DruidDataSourceAutoConfigure - Init DruidDataSource
2025-xx-xx 21:28:53.873 [main] INFO  xiaozhi.AdminApplication - Started AdminApplication in 16.057 seconds (process running for 17.941)
http://localhost:8002/xiaozhi/doc.html
```

Please note that at this point, only the `Control Panel` is running. If the `xiaozhi-esp32-server` on port 8000 reports an error, don't worry about it yet.

Now, you need to use a browser to open the `Control Panel` at: http://127.0.0.1:8002, and register the first user. The first user is the super administrator; subsequent users are regular users. Regular users can only bind devices and configure agents; super administrators can perform model management, user management, parameter configuration, and other functions.

Next, there are three important things to do:

### First Important Task

Using the super administrator account, log in to the Control Panel, find `Parameter Management` in the top menu, locate the first item in the list with parameter code `server.secret`, and copy its `Parameter Value`.

Let me explain `server.secret`: this `Parameter Value` is very important as it allows our `Server` to connect to the `manager-api`. The `server.secret` is a randomly generated key each time the manager module is deployed from scratch.

After copying the `Parameter Value`, open the `.config.yaml` file in the `data` directory of your `xiaozhi-server`. At this point, your configuration file should look like this:

```
manager-api:
  url:  http://127.0.0.1:8002/xiaozhi
  secret: your_server.secret_value
```
1. Paste the `server.secret` `Parameter Value` you just copied from the `Control Panel` into the `secret` field in the `.config.yaml` file.

2. Since you're using Docker deployment, change the `url` to `http://xiaozhi-esp32-server-web:8002/xiaozhi`

3. Since you're using Docker deployment, change the `url` to `http://xiaozhi-esp32-server-web:8002/xiaozhi`

4. Since you're using Docker deployment, change the `url` to `http://xiaozhi-esp32-server-web:8002/xiaozhi`

The result should look something like this:
```
manager-api:
  url: http://xiaozhi-esp32-server-web:8002/xiaozhi
  secret: 12345678-xxxx-xxxx-xxxx-123456789000
```

After saving, continue to the second important task.

### Second Important Task

Using the super administrator account, log in to the Control Panel, find `Model Configuration` in the top menu, then click on `Large Language Model` in the left sidebar. Find the first item `Zhipu AI`, click the `Modify` button, and in the popup dialog, enter your registered `Zhipu AI` key in the `API Key` field. Then click save.

## 5. Restart xiaozhi-esp32-server

Next, open a command line tool, use the `terminal` or `command line` tool and enter:
```
docker restart xiaozhi-esp32-server
docker logs -f xiaozhi-esp32-server
```
If you can see logs similar to the following, it indicates that the Server has started successfully:

```
25-02-23 12:01:09[core.websocket_server] - INFO - Websocket address is      ws://xxx.xx.xx.xx:8000/xiaozhi/v1/
25-02-23 12:01:09[core.websocket_server] - INFO - =======The above address is a websocket protocol address, please do not access it with a browser=======
25-02-23 12:01:09[core.websocket_server] - INFO - If you want to test websocket, please use Google Chrome to open test_page.html in the test directory
25-02-23 12:01:09[core.websocket_server] - INFO - =============================================================
```

Since you're doing a full module deployment, you have two important interfaces that need to be entered into the ESP32:

OTA interface:
```
http://your_computer_local_network_ip:8002/xiaozhi/ota/
```

Websocket interface:
```
ws://your_computer_local_network_ip:8000/xiaozhi/v1/
```

### Third Important Task

Using the super administrator account, log in to the Control Panel, find `Parameter Management` in the top menu, locate the parameter code `server.websocket`, and enter your `Websocket interface`.

Using the super administrator account, log in to the Control Panel, find `Parameter Management` in the top menu, locate the parameter code `server.ota`, and enter your `OTA interface`.

Now, you can start operating your ESP32 device. You can either `compile your own ESP32 firmware` or configure using `firmware version 1.6.1 or above compiled by Xia Ge`. Choose one of the two:

1. [Compile your own ESP32 firmware](firmware-build.md).

2. [Configure a custom server based on firmware compiled by Xia Ge](firmware-setting.md).

# Method 2: Local Source Code Full Module Deployment

## 1. Install MySQL Database

If MySQL is already installed on your machine, you can directly create a database named `xiaozhi_esp32_server`:

```sql
CREATE DATABASE xiaozhi_esp32_server CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

If you don't have MySQL yet, you can install it using Docker:

```
docker run --name xiaozhi-esp32-server-db -e MYSQL_ROOT_PASSWORD=123456 -p 3306:3306 -e MYSQL_DATABASE=xiaozhi_esp32_server -e MYSQL_INITDB_ARGS="--character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci" -e TZ=Asia/Shanghai -d mysql:latest
```

## 2. Install Redis

If you don't have Redis yet, you can install it using Docker:

```
docker run --name xiaozhi-esp32-server-redis -d -p 6379:6379 redis
```

## 3. Run the manager-api Program

3.1 Install JDK21 and set up JDK environment variables

3.2 Install Maven and set up Maven environment variables

3.3 Use VSCode programming tool and install Java environment-related plugins

3.4 Use VSCode programming tool to load the manager-api module

Configure database connection information in `src/main/resources/application-dev.yml`:

```
spring:
  datasource:
    username: root
    password: 123456
```
Configure Redis connection information in `src/main/resources/application-dev.yml`:
```
spring:
    data:
      redis:
        host: localhost
        port: 6379
        password:
        database: 0
```

3.5 Run the main program

This project is a SpringBoot project. To start it:
Open `Application.java` and run the `Main` method:

```
Path:
src/main/java/xiaozhi/AdminApplication.java
```

When you see the output logs, it means your `manager-api` has started successfully:

```
2025-xx-xx 22:11:12.445 [main] INFO  c.a.d.s.b.a.DruidDataSourceAutoConfigure - Init DruidDataSource
2025-xx-xx 21:28:53.873 [main] INFO  xiaozhi.AdminApplication - Started AdminApplication in 16.057 seconds (process running for 17.941)
http://localhost:8002/xiaozhi/doc.html
```

## 4. Run the manager-web Program

4.1 Install Node.js

4.2 Use VSCode programming tool to load the manager-web module

In the terminal, navigate to the manager-web directory:

```
npm install
```
Then start:
```
npm run serve
```

Please note, if your manager-api interface is not at `http://localhost:8002`, modify the path in `main/manager-web/.env.development` during development.

After running successfully, you need to use a browser to open the `Control Panel` at: http://127.0.0.1:8001, and register the first user. The first user is the super administrator; subsequent users are regular users. Regular users can only bind devices and configure agents; super administrators can perform model management, user management, parameter configuration, and other functions.

Important: After successful registration, using the super administrator account, log in to the Control Panel, find `Model Configuration` in the top menu, then click on `Large Language Model` in the left sidebar. Find the first item `Zhipu AI`, click the `Modify` button, and in the popup dialog, enter your registered `Zhipu AI` key in the `API Key` field. Then click save.

## 5. Install Python Environment

This project uses `conda` to manage dependency environments. If it's not convenient to install `conda`, you need to install `libopus` and `ffmpeg` according to your operating system.
If you decide to use `conda`, after installation, start executing the following commands:

Important note! For Windows users, you can manage environments by installing `Anaconda`. After installing `Anaconda`, search for `anaconda` related keywords in the `Start` menu, find `Anaconda Prompt`, and run it as administrator. As shown below:

![conda_prompt](./images/conda_env_1.png)

After running, if you can see a (base) prefix in front of the command line window, it means you have successfully entered the `conda` environment. Then you can execute the following commands:

![conda_env](./images/conda_env_2.png)

```
conda remove -n xiaozhi-esp32-server --all -y
conda create -n xiaozhi-esp32-server python=3.10 -y
conda activate xiaozhi-esp32-server

# Add Tsinghua mirror channel
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge

conda install libopus -y
conda install ffmpeg -y
```

Please note that the above commands should not be executed all at once. You need to execute them step by step and check the output logs after each step to see if it was successful.

## 6. Install Project Dependencies

First, you need to download the source code of this project. The source code can be downloaded using the `git clone` command. If you are not familiar with the `git clone` command:

You can open this address in your browser: `https://github.com/xinnan-tech/xiaozhi-esp32-server.git`

After opening, find a green button labeled `Code`, click it, and you'll see a `Download ZIP` button.

Click it to download the project source code as a ZIP file. After downloading to your computer, extract it. At this point, it might be named `xiaozhi-esp32-server-main`.
You need to rename it to `xiaozhi-esp32-server`, enter the `main` folder, then enter the `xiaozhi-server` folder. Please remember this directory: `xiaozhi-server`.

```
# Continue using the conda environment
conda activate xiaozhi-esp32-server
# Enter your project root directory, then enter main/xiaozhi-server
cd main/xiaozhi-server
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/
pip install -r requirements.txt
pip install -r requirements-whisper.txt
```

### 7. Download Speech Recognition Model Files

This project uses the `SenseVoiceSmall` model for speech-to-text by default. Because the model is large, it needs to be downloaded separately. After downloading, place the `model.pt` file in the `models/SenseVoiceSmall` directory. Choose one of the following download routes:

- Route 1: Download from Alibaba ModelScope [SenseVoiceSmall](https://modelscope.cn/models/iic/SenseVoiceSmall/resolve/master/model.pt)
- Route 2: Download from Baidu Netdisk [SenseVoiceSmall](https://pan.baidu.com/share/init?surl=QlgM58FHhYv1tFnUT_A8Sg&pwd=qvna) Extraction code: `qvna`

## 8. Configure Project Files

Using the super administrator account, log in to the Control Panel, find `Parameter Management` in the top menu, locate the first item in the list with parameter code `server.secret`, and copy its `Parameter Value`.

Let me explain `server.secret`: this `Parameter Value` is very important as it allows our `Server` to connect to the `manager-api`. The `server.secret` is a randomly generated key each time the manager module is deployed from scratch.

If your `xiaozhi-server` directory doesn't have a `data` directory, you need to create one.
If you don't have a `.config.yaml` file under `data`, you can copy the `config_from_api.yaml` file from the `xiaozhi-server` directory to `data` and rename it to `.config.yaml`.

After copying the `Parameter Value`, open the `.config.yaml` file in the `data` directory of your `xiaozhi-server`. At this point, your configuration file should look like this:

```
manager-api:
  url: http://127.0.0.1:8002/xiaozhi
  secret: your_server.secret_value
```

Paste the `server.secret` `Parameter Value` you just copied from the `Control Panel` into the `secret` field in the `.config.yaml` file.

The result should look something like this:
```
manager-api:
  url: http://127.0.0.1:8002/xiaozhi
  secret: 12345678-xxxx-xxxx-xxxx-123456789000
```

## 9. Run the Project

```
# Make sure to execute in the xiaozhi-server directory
conda activate xiaozhi-esp32-server
python app.py
```

If you can see logs similar to the following, it indicates that the project service has started successfully:

```
25-02-23 12:01:09[core.websocket_server] - INFO - Server is running at ws://xxx.xx.xx.xx:8000/xiaozhi/v1/
25-02-23 12:01:09[core.websocket_server] - INFO - =======The above address is a websocket protocol address, please do not access it with a browser=======
25-02-23 12:01:09[core.websocket_server] - INFO - If you want to test websocket, please use Google Chrome to open test_page.html in the test directory
25-02-23 12:01:09[core.websocket_server] - INFO - =======================================================
```

Since you're doing a full module deployment, you have two important interfaces:

OTA interface:
```
http://your_computer_local_network_ip:8002/xiaozhi/ota/
```

Websocket interface:
```
ws://your_computer_local_network_ip:8000/xiaozhi/v1/
```

Please make sure to enter these two interface addresses into the Control Panel: they will affect websocket address distribution and automatic upgrade functionality.

1. Using the super administrator account, log in to the Control Panel, find `Parameter Management` in the top menu, locate the parameter code `server.websocket`, and enter your `Websocket interface`.

2. Using the super administrator account, log in to the Control Panel, find `Parameter Management` in the top menu, locate the parameter code `server.ota`, and enter your `OTA interface`.

Now, you can start operating your ESP32 device. You can either `compile your own ESP32 firmware` or configure using `firmware version 1.6.1 or above compiled by Xia Ge`. Choose one of the two:

1. [Compile your own ESP32 firmware](firmware-build.md).

2. [Configure a custom server based on firmware compiled by Xia Ge](firmware-setting.md).

# Whisper ASR Setup

This project now supports OpenAI's Whisper model for multilingual speech recognition. Whisper is an automatic speech recognition (ASR) system trained on 680,000 hours of multilingual and multitask supervised data collected from the web. It offers robust speech recognition across many languages and can translate those languages into English.

## Installation

To use Whisper ASR, you need to install additional dependencies:

```bash
# For Docker deployment, these are already included in the container
# For source code deployment, run:
pip install -r requirements-whisper.txt
```

You also need FFmpeg installed on your system:

```bash
# For Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y ffmpeg

# For macOS
brew install ffmpeg

# For Windows
# Download from https://ffmpeg.org/download.html
```

## Configuration

The Whisper ASR provider can be configured in the Control Panel. Log in as an administrator, go to "Model Configuration" and select "Speech Recognition" in the left sidebar. Find the Whisper ASR provider and configure it with the following settings:

- **Model Name**: Choose from tiny, base, small, medium, or large (default is base)
- **Language**: Set to a specific language code or leave as null for auto-detection
- **Output Directory**: Directory to store temporary files (default is tmp/)

Alternatively, you can configure Whisper directly in the config.yaml file:

```yaml
ASR:
  WhisperASR:
    type: whisper
    model_name: base
    language: null
    output_dir: tmp/
```

## Model Options

Whisper offers several model sizes:

| Model Size | Parameters | Required VRAM | Relative Speed |
|------------|------------|---------------|---------------|
| tiny       | 39 M       | ~1 GB         | ~32x          |
| base       | 74 M       | ~1 GB         | ~16x          |
| small      | 244 M      | ~2 GB         | ~6x           |
| medium     | 769 M      | ~5 GB         | ~2x           |
| large      | 1550 M     | ~10 GB        | 1x            |

Choose the model size based on your hardware capabilities and accuracy requirements.

## Language Support

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

Once configured, select Whisper as your ASR provider in the Control Panel:

1. Log in as an administrator
2. Go to "Parameter Management"
3. Find the parameter "selected_module.ASR" 
4. Set its value to "WhisperASR"

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

# Frequently Asked Questions

Here are some common questions for reference:

[1. Why does Xiaozhi recognize a lot of Korean, Japanese, and English when I speak?](./FAQ.md)

[2. Why does "TTS task error: File does not exist" appear?](./FAQ.md)

[3. TTS frequently fails and times out](./FAQ.md)

[4. Can connect to self-built server using WiFi, but can't connect in 4G mode](./FAQ.md)

[5. How to improve Xiaozhi's dialogue response speed?](./FAQ.md)

[6. I speak slowly, but Xiaozhi keeps interrupting when I pause](./FAQ.md)

[7. I want to control lights, air conditioners, remote power on/off, and other operations through Xiaozhi](./FAQ.md)