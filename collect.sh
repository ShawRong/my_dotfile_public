#!/bin/bash

# 确保仓库目录存在
mkdir -p {.config,.config/nvim,.obsidian}  # 按需添加其他分类目录

# 复制配置文件到仓库，保持结构
cp ~/.zshrc .
cp -r ~/.config/nvim .config/
cp -r ~/.config/karabiner .config/
cp -r ~/.config/raycast .config/
cp -r ~/Documents/obsidian-library/October/.obsidian .


