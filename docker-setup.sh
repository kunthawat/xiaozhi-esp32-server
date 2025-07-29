#!/bin/sh
# This file is used for one-click automatic download of required files for this project and automatic directory creation
# Required conditions (otherwise cannot be used):
# 1. Please ensure your environment can access GitHub normally, otherwise the script cannot be downloaded
#
# Detect operating system type
case "$(uname -s)" in
    Linux*)     OS=Linux;;
    Darwin*)    OS=Mac;;
    CYGWIN*)    OS=Windows;;
    MINGW*)     OS=Windows;;
    MSYS*)      OS=Windows;;
    *)          OS=UNKNOWN;;
esac

# Set colors (Windows CMD doesn't support, but doesn't affect usage)
if [ "$OS" = "Windows" ]; then
    GREEN=""
    RED=""
    NC=""
else
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NC='\033[0m'
fi

echo "${GREEN}Starting installation of Xiaozhi server...${NC}"

# Create necessary directories
echo "Creating directory structure..."
mkdir -p xiaozhi-server/data xiaozhi-server/models/SenseVoiceSmall
cd xiaozhi-server || exit

# Select download command based on operating system
if [ "$OS" = "Windows" ]; then
    DOWNLOAD_CMD="curl -L -o"
    if ! command -v curl >/dev/null 2>&1; then
        DOWNLOAD_CMD="powershell -Command Invoke-WebRequest -Uri"
        DOWNLOAD_CMD_SUFFIX="-OutFile"
    fi
else
    if command -v curl >/dev/null 2>&1; then
        DOWNLOAD_CMD="curl -L -o"
    elif command -v wget >/dev/null 2>&1; then
        DOWNLOAD_CMD="wget -O"
    else
        echo "${RED}Error: curl or wget needs to be installed${NC}"
        exit 1
    fi
fi

# Download speech recognition model
echo "Downloading speech recognition model..."
if [ "$DOWNLOAD_CMD" = "powershell -Command Invoke-WebRequest -Uri" ]; then
    $DOWNLOAD_CMD "https://modelscope.cn/models/iic/SenseVoiceSmall/resolve/master/model.pt" $DOWNLOAD_CMD_SUFFIX "models/SenseVoiceSmall/model.pt"
else
    $DOWNLOAD_CMD "models/SenseVoiceSmall/model.pt" "https://modelscope.cn/models/iic/SenseVoiceSmall/resolve/master/model.pt"
fi

if [ $? -ne 0 ]; then
    echo "${RED}Model download failed. Please manually download from the following addresses:${NC}"
    echo "1. https://modelscope.cn/models/iic/SenseVoiceSmall/resolve/master/model.pt"
    echo "2. Baidu Netdisk: https://pan.baidu.com/share/init?surl=QlgM58FHhYv1tFnUT_A8Sg (extraction code: qvna)"
    echo "After downloading, please place the file at models/SenseVoiceSmall/model.pt"
fi

# Download configuration files
echo "Downloading configuration files..."
if [ "$DOWNLOAD_CMD" = "powershell -Command Invoke-WebRequest -Uri" ]; then
    $DOWNLOAD_CMD "https://raw.githubusercontent.com/xinnan-tech/xiaozhi-esp32-server/main/main/xiaozhi-server/docker-compose.yml" $DOWNLOAD_CMD_SUFFIX "docker-compose.yml"
    $DOWNLOAD_CMD "https://raw.githubusercontent.com/xinnan-tech/xiaozhi-esp32-server/main/main/xiaozhi-server/config.yaml" $DOWNLOAD_CMD_SUFFIX "data/.config.yaml"
else
    $DOWNLOAD_CMD "docker-compose.yml" "https://raw.githubusercontent.com/xinnan-tech/xiaozhi-esp32-server/main/main/xiaozhi-server/docker-compose.yml"
    $DOWNLOAD_CMD "data/.config.yaml" "https://raw.githubusercontent.com/xinnan-tech/xiaozhi-esp32-server/main/main/xiaozhi-server/config.yaml"
fi

# Check if files exist
echo "Checking file integrity..."
FILES_TO_CHECK="docker-compose.yml data/.config.yaml models/SenseVoiceSmall/model.pt"
ALL_FILES_EXIST=true

for FILE in $FILES_TO_CHECK; do
    if [ ! -f "$FILE" ]; then
        echo "${RED}Error: $FILE does not exist${NC}"
        ALL_FILES_EXIST=false
    fi
done

if [ "$ALL_FILES_EXIST" = false ]; then
    echo "${RED}Some files failed to download, please check the error messages above and manually download the missing files.${NC}"
    exit 1
fi

echo "${GREEN}File download completed!${NC}"
echo "Please edit the data/.config.yaml file to configure your API keys."
echo "After configuration is complete, run the following command to start the service:"
echo "${GREEN}docker-compose up -d${NC}"
echo "To view logs, run:"
echo "${GREEN}docker logs -f xiaozhi-esp32-server${NC}"

# Prompt user to edit configuration file
echo "\n${RED}Important Notice:${NC}"
echo "1. Please ensure you edit the data/.config.yaml file to configure necessary API keys"
echo "2. Especially the ChatGLM and mem0ai keys must be configured"
echo "3. Start the docker service only after configuration is complete"
