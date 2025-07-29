# Translation Guide for Xiaozhi ESP32 Server

## Overview

This document provides guidelines for maintaining the English-only codebase of the Xiaozhi ESP32 Server project. All Chinese text has been systematically translated to English to improve international accessibility and maintainability.

## Translation Principles

### 1. Consistency
- Use consistent terminology across all files
- Maintain technical accuracy in translations
- Follow established naming conventions

### 2. Clarity
- Prioritize clear, understandable English over literal translations
- Use standard technical terminology where applicable
- Avoid ambiguous or overly complex phrasing

### 3. Context Preservation
- Maintain the original meaning and intent
- Preserve technical specifications and requirements
- Keep functional behavior unchanged

## Key Translation Mappings

### Technical Terms
- `设备管理` → `Device Management`
- `用户管理` → `User Management`
- `参数管理` → `Parameter Management`
- `OTA管理` → `OTA Management`
- `服务端管理` → `Server Management`
- `固件管理` → `Firmware Management`
- `声纹识别` → `Voice Print Recognition`
- `语音识别` → `Speech Recognition`
- `智控台` → `Control Panel`

### Common UI Elements
- `搜索` → `Search`
- `添加` → `Add`
- `编辑` → `Edit`
- `删除` → `Delete`
- `保存` → `Save`
- `取消` → `Cancel`
- `确认` → `Confirm`
- `选择` → `Select`
- `查看` → `View`
- `配置` → `Configuration`

### Status Messages
- `成功` → `Success`
- `失败` → `Failed`
- `错误` → `Error`
- `警告` → `Warning`
- `加载中` → `Loading`
- `处理中` → `Processing`

## File Types Translated

### 1. Documentation Files
- **README.md**: Main project documentation
- **README_en.md**: English documentation (cleaned up)
- **docs/**: All markdown files in documentation directory

### 2. Frontend Code (Vue.js)
- **Vue Components**: All `.vue` files
- **JavaScript Files**: All `.js` files
- **Router Configuration**: Navigation and routing
- **UI Text**: Buttons, labels, messages, placeholders

### 3. Backend Code (Java)
- **Service Classes**: Comments and JavaDoc
- **Controller Classes**: API documentation and comments
- **Entity Classes**: Field descriptions and comments
- **Configuration Files**: YAML and properties files
- **Test Files**: Test descriptions and assertions

### 4. Database Schema
- **SQL Migration Files**: Comments and descriptions
- **Table Comments**: Column and table descriptions
- **Configuration Data**: System parameters and descriptions

### 5. Python Server Code
- **Function Descriptions**: API and function documentation
- **Comments**: Inline and block comments
- **Log Messages**: Error and info messages
- **Configuration**: YAML comments and descriptions

### 6. Build and Deployment
- **Dockerfiles**: Build stage descriptions and comments
- **Shell Scripts**: Comments and echo messages
- **Docker Compose**: Service descriptions and comments

## Guidelines for Future Development

### 1. New Code Requirements
- **All new code MUST be written in English**
- Comments, documentation, and user-facing text must be in English
- Variable names and function names should use English terminology
- Error messages and log outputs must be in English

### 2. Code Review Checklist
- [ ] No Chinese characters in comments or strings
- [ ] Consistent terminology with existing codebase
- [ ] Clear and understandable English
- [ ] Proper grammar and spelling
- [ ] Technical accuracy maintained

### 3. Documentation Standards
- Use clear, concise English
- Follow standard technical writing conventions
- Include examples where appropriate
- Maintain consistent formatting and style

### 4. User Interface Guidelines
- Use standard UI terminology
- Keep text concise and actionable
- Ensure accessibility compliance
- Test with English-speaking users

## Translation Tools and Resources

### Recommended Tools
- **IDE Extensions**: Grammar and spell checkers
- **Translation Memory**: Maintain consistency across translations
- **Technical Dictionaries**: For specialized terminology

### Reference Resources
- **Technical Documentation**: Industry-standard terminology
- **Style Guides**: Consistent writing style
- **Accessibility Guidelines**: Inclusive language practices

## Quality Assurance

### Testing Requirements
- **Functional Testing**: Ensure all features work correctly
- **UI Testing**: Verify proper display of English text
- **Integration Testing**: Test complete user workflows
- **Accessibility Testing**: Ensure compliance with standards

### Review Process
1. **Code Review**: Check for Chinese text in new code
2. **Translation Review**: Verify accuracy and consistency
3. **Functional Testing**: Ensure no broken functionality
4. **User Acceptance**: Test with English-speaking users

## Maintenance

### Regular Audits
- Periodic scans for Chinese text in codebase
- Review of new dependencies for language issues
- Update of translation mappings as needed
- Documentation updates for new features

### Issue Resolution
- **Chinese Text Found**: Immediate translation required
- **Inconsistent Terminology**: Update to match established mappings
- **Unclear Translations**: Revise for clarity and accuracy

## Contact and Support

For questions about translations or to report Chinese text found in the codebase:
1. Create an issue in the project repository
2. Tag with "translation" label
3. Provide specific file and line references
4. Suggest appropriate English translation

## Conclusion

Maintaining an English-only codebase improves:
- **International Accessibility**: Broader developer community
- **Code Maintainability**: Easier for global teams
- **Documentation Quality**: Clearer technical communication
- **Professional Standards**: Industry best practices

All contributors are expected to follow these guidelines to maintain the quality and accessibility of the Xiaozhi ESP32 Server project.