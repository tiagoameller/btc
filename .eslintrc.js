module.exports = {
    "parser": "@babel/eslint-parser",
    "extends": "eslint:recommended",
    "rules": {
      "semi": ["error", "never"],
      "quotes": ["error", "double"],
      "no-unused-vars": ["error", { "vars": "all", "args": "none" }],
      "no-trailing-spaces": ["error"],
      "no-multiple-empty-lines": ["error", { "max": 2 }],
      "prefer-const": ["error"],
      "getter-return": ["error"],
      "curly": ["error", "multi-line"],
      "space-before-function-paren": ["error", "always"],
      "no-debugger": "error",
      "no-alert": "error",
      "no-console": "error",
    },
    "env": {
      "browser": true,
      "node": true,
      "es6": true,
      "jquery": true
    },
    "globals": {
      "App": "readonly",
      "ApplicationController": "readonly",
      "I18n": "readonly",
      "coreui": "readonly",
    },
    "plugins": [
        "ignore-erb"
    ]
  }
