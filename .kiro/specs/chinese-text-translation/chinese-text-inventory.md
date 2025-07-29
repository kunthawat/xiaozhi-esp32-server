# Chinese Text Inventory

## Summary
This document provides a comprehensive inventory of all Chinese text found in the xiaozhi-esp32-server project.

## Files Containing Chinese Text

### 1. Documentation Files
- **README.md**
  - Line 3: `小智后端服务xiaozhi-esp32-server` (Project title)
  - Line 6: `本项目基于人机共生智能理论和技术研发智能终端软硬件体系<br/>为开源智能硬件项目` (Project description)

- **README_en.md**
  - Line 13: `中文` (Language link)
  - Line 43: `刘思源教授团队研发（华南理工大学）` (Research team credit)
  - Line 236: `![请参考-全模块安装架构图](docs/images/deploy2.png)` (Image alt text)

### 2. Java Source Code
- **main/manager-api/src/main/java/xiaozhi/modules/device/service/OtaService.java**
  - Line 10: `OTA固件管理` (Class comment)

- **main/manager-api/src/main/java/xiaozhi/modules/device/service/DeviceService.java**
  - Line 18: `检查设备是否激活` (Method comment)
  - Line 24: `获取用户指定智能体的设备列表，` (Method comment)
  - Line 29: `解绑设备` (Method comment)
  - Line 34: `设备激活` (Method comment)
  - Line 39: `删除此用户的所有设备` (Method comment)
  - Line 41: `用户id` (Parameter comment)
  - Line 46: `删除指定智能体关联的所有设备` (Method comment)

### 3. Vue.js Frontend Files
- **main/manager-web/src/store/index.js**
  - Line 12: `添加用户信息存储` (Comment)
  - Line 13: `添加superAdmin状态` (Comment)
  - Line 14: `添加公共配置存储` (Comment)
  - Line 64: `添加 logout action` (Comment)
  - Line 69: `彻底重置状态` (Comment)
  - Line 72: `添加获取公共配置的 action` (Comment)

- **main/manager-web/src/router/index.js**
  - Line 56: `设备管理页面路由` (Comment)
  - Line 64: `添加用户管理路由` (Comment)
  - Line 87: `参数管理` (Route title)
  - Line 99: `服务端管理` (Route title)
  - Line 110: `OTA管理` (Route title)
  - Line 133: `全局处理重复导航，改为刷新页面` (Comment)
  - Line 138: `如果是重复导航，刷新页面` (Comment)

### 4. Internationalization Files
- **main/manager-api/src/main/resources/i18n/messages_zh_CN.properties**
  - Contains 42 Chinese error messages and system messages (Unicode encoded)

- **main/manager-api/src/main/resources/i18n/messages_zh_TW.properties**
  - Contains 42 Traditional Chinese error messages and system messages (Unicode encoded)

### 5. Configuration Files
- **Docker Compose Files**
  - Line 1: `Docker安装全模块` (Comment)
  - Line 5: `Server模块` (Comment)
  - Line 16: `ws服务端` (Comment)
  - Line 18: `http服务的端口，用于视觉分析接口` (Comment)
  - Line 25: `配置文件目录` (Comment)
  - Line 27: `模型文件挂接，很重要` (Comment)
  - Line 30: `manager-api和manager-web模块` (Comment)
  - Line 43: `智控台` (Comment)
  - Line 54: `配置文件目录` (Comment)

- **main/manager-api/src/main/resources/db/changelog/db.changelog-master.yaml**
  - Line 1: `规范约定：` (Comment)
  - Line 2: `id生成根据时间时分，文件名对应id，常变数据可以根据模块命名自定义` (Comment)
  - Line 3: `每次对数据表进行改动时，只允许新建新对changeSet，不允许对上一个changeSet配置及文件进行修改` (Comment)

## Total Count by Category
- **Documentation**: 4 instances
- **Java Comments**: 8 instances
- **Vue.js Comments**: 8 instances
- **i18n Properties**: 84 instances (42 each in CN and TW)
- **Configuration Comments**: 10 instances

**Total Chinese Text Instances**: 114