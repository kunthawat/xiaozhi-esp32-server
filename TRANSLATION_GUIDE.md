# Translation Guide

## Overview

This document provides guidance for maintaining the English-only codebase of the xiaozhi-esp32-server project. All Chinese text has been systematically translated to English to ensure international accessibility.

## Translation Principles

### 1. Technical Accuracy
- Preserve technical terminology and functionality
- Maintain API contract integrity
- Ensure database relationships remain intact

### 2. Consistency
- Use standardized translations for common terms
- Maintain consistent UI/UX terminology
- Follow established naming conventions

### 3. Functionality Preservation
- All features must continue to work after translation
- No breaking changes to existing integrations
- Maintain backward compatibility where possible

## Key Translation Mappings

### Common UI Terms
- `登录` → `Login`
- `用户名` → `Username`
- `密码` → `Password`
- `验证码` → `Verification Code`
- `注册` → `Register`
- `忘记密码` → `Forgot Password`

### System Management Terms
- `设备管理` → `Device Management`
- `用户管理` → `User Management`
- `参数管理` → `Parameter Management`
- `OTA管理` → `OTA Management`
- `服务端管理` → `Server Management`
- `固件管理` → `Firmware Management`

### Technical Terms
- `数据库` → `Database`
- `配置` → `Configuration`
- `服务` → `Service`
- `接口` → `Interface/API`
- `模型` → `Model`
- `控制器` → `Controller`

## File Categories Translated

### 1. Documentation
- `README.md` - Main project documentation
- `README_en.md` - English documentation
- All markdown files in `docs/` directory

### 2. Backend Code
- Java source files (`main/manager-api/src/**/*.java`)
- Internationalization files (`i18n/*.properties`)
- Database migration files (`db/changelog/*.sql`)

### 3. Frontend Code
- Vue.js components (`main/manager-web/src/**/*.vue`)
- JavaScript utilities (`main/manager-web/src/**/*.js`)
- Router configurations

### 4. Configuration Files
- YAML configuration files
- Shell scripts and deployment files
- Docker configurations

## Guidelines for Contributors

### Adding New Features
1. **Use English Only**: All new code, comments, and documentation must be in English
2. **Follow Naming Conventions**: Use descriptive English names for variables, functions, and classes
3. **Update Documentation**: Ensure all new features are documented in English

### Code Comments
- Write clear, concise comments in English
- Explain complex business logic
- Document API endpoints and parameters
- Include examples where helpful

### UI Text
- Use clear, user-friendly English for all UI elements
- Maintain consistency with existing terminology
- Consider text length for responsive design
- Test with different screen sizes

### Error Messages
- Provide clear, actionable error messages in English
- Include relevant context for debugging
- Use consistent error message formats
- Avoid technical jargon in user-facing messages

## Testing Checklist

When adding new features or modifying existing code:

- [ ] All text is in English
- [ ] UI elements display correctly
- [ ] Error messages are clear and helpful
- [ ] Documentation is updated
- [ ] No Chinese characters in code or comments
- [ ] Functionality works as expected
- [ ] Responsive design is maintained

## Common Pitfalls to Avoid

1. **Mixed Languages**: Don't mix Chinese and English in the same context
2. **Literal Translations**: Avoid word-for-word translations that don't make sense in English
3. **Technical Accuracy**: Don't change technical terms that have established English equivalents
4. **UI Layout**: Consider that English text may be longer than Chinese text
5. **Cultural Context**: Adapt content for international audiences

## Maintenance

### Regular Checks
- Scan codebase for any new Chinese text: `grep -r "[\u4e00-\u9fff]" src/`
- Review pull requests for language consistency
- Update translation mappings as needed
- Test UI with English text lengths

### Tools and Resources
- Use regex pattern `[\u4e00-\u9fff]` to find Chinese characters
- Leverage IDE search and replace for bulk translations
- Use translation tools for technical accuracy
- Consult technical dictionaries for specialized terms

## Contact

For questions about translation decisions or to report issues with existing translations, please create an issue in the project repository with the label "translation".