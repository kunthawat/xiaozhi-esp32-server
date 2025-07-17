#!/bin/bash
# This script automates the setup process for the Xiaozhi ESP32 Server
# It creates the necessary directory structure, downloads required files,
# and prepares the environment for running with Docker Compose

# Set colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Xiaozhi ESP32 Server Setup ===${NC}"
echo -e "${GREEN}This script will set up the Xiaozhi ESP32 Server with Whisper ASR support${NC}"

# Create base directory
echo -e "\n${GREEN}Creating directory structure...${NC}"
mkdir -p xiaozhi-server
cd xiaozhi-server || { echo -e "${RED}Failed to enter xiaozhi-server directory${NC}"; exit 1; }

# Create subdirectories
mkdir -p data models/SenseVoiceSmall whisper_cache mysql/data uploadfile

# Clone the repository
echo -e "\n${GREEN}Cloning the repository...${NC}"
if ! git clone https://github.com/kunthawat/xiaozhi-esp32-server.git repo; then
    echo -e "${RED}Failed to clone repository. Please make sure git is installed and you have internet access.${NC}"
    exit 1
fi

# Copy Docker files
echo -e "\n${GREEN}Copying configuration files...${NC}"
cp repo/main/xiaozhi-server/docker-compose_all.yml docker-compose.yml
cp repo/main/xiaozhi-server/config.yaml data/.config.yaml

# Download speech recognition model
echo -e "\n${GREEN}Downloading speech recognition model...${NC}"
echo -e "${BLUE}This may take some time depending on your internet connection...${NC}"

if command -v curl &> /dev/null; then
    if ! curl -L -o models/SenseVoiceSmall/model.pt "https://modelscope.cn/models/iic/SenseVoiceSmall/resolve/master/model.pt"; then
        echo -e "${RED}Model download failed.${NC}"
        MODEL_FAILED=true
    fi
elif command -v wget &> /dev/null; then
    if ! wget -O models/SenseVoiceSmall/model.pt "https://modelscope.cn/models/iic/SenseVoiceSmall/resolve/master/model.pt"; then
        echo -e "${RED}Model download failed.${NC}"
        MODEL_FAILED=true
    fi
else
    echo -e "${RED}Neither curl nor wget is installed. Please install one of them and try again.${NC}"
    MODEL_FAILED=true
fi

if [ "$MODEL_FAILED" = true ]; then
    echo -e "${RED}Please download the model manually from:${NC}"
    echo -e "1. https://modelscope.cn/models/iic/SenseVoiceSmall/resolve/master/model.pt"
    echo -e "2. Baidu Netdisk: https://pan.baidu.com/share/init?surl=QlgM58FHhYv1tFnUT_A8Sg (Extraction code: qvna)"
    echo -e "After downloading, place the file in xiaozhi-server/models/SenseVoiceSmall/model.pt"
fi

# Check if files exist
echo -e "\n${GREEN}Checking file integrity...${NC}"
FILES_TO_CHECK="docker-compose.yml data/.config.yaml"
ALL_FILES_EXIST=true

for FILE in $FILES_TO_CHECK; do
    if [ ! -f "$FILE" ]; then
        echo -e "${RED}Error: $FILE does not exist${NC}"
        ALL_FILES_EXIST=false
    fi
done

if [ "$ALL_FILES_EXIST" = false ]; then
    echo -e "${RED}Some files are missing. Setup cannot continue.${NC}"
    exit 1
fi

# Setup complete
echo -e "\n${GREEN}Setup complete!${NC}"
echo -e "\n${BLUE}Next steps:${NC}"
echo -e "1. Edit the ${BLUE}data/.config.yaml${NC} file to configure your API keys"
echo -e "2. Run ${BLUE}docker-compose up -d${NC} to start the services"
echo -e "3. The Docker images will be built automatically during the first run"
echo -e "4. To view logs, run ${BLUE}docker logs -f xiaozhi-esp32-server${NC}"

echo -e "\n${RED}Important notes:${NC}"
echo -e "1. Make sure to configure the necessary API keys in data/.config.yaml"
echo -e "2. Especially the keys for ChatGLM and mem0ai must be configured"
echo -e "3. Only start the docker service after configuration is complete"
echo -e "4. Whisper ASR is now supported. To use it, configure the ASR provider in the Control Panel"
echo -e "5. The first build may take some time as it needs to download and build all dependencies"

echo -e "\n${GREEN}Thank you for using Xiaozhi ESP32 Server!${NC}"