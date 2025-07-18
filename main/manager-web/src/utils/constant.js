const HAVE_NO_RESULT = 'None'
export default {
    HAVE_NO_RESULT, // Project configuration information
    PAGE: {
        LOGIN: '/login',
    },
    STORAGE_KEY: {
        TOKEN: 'TOKEN',
        PUBLIC_KEY: 'PUBLIC_KEY',
        USER_TYPE: 'USER_TYPE'
    },
    Lang: {
        'zh_cn': 'zh_cn', 'zh_tw': 'zh_tw', 'en': 'en'
    },
    FONT_SIZE: {
        'big': 'big',
        'normal': 'normal',
    }, // Get a specific key from the map
    get(map, key) {
        return map[key] || HAVE_NO_RESULT
    }
}
