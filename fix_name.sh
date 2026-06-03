#!/bin/bash

# 1. 定义源字符串和目标字符串（查找时将忽略 source 的大小写）
declare -A replace_pairs=(
    ["xray "]="xcon "
    [" xray"]=" xcon"
    ['"xray"']='"xcon"'
    ["'xray'"]="'xcon'"
    ["xray. "]="xcon. "
)

# 2. 指定扫描目录
TARGET_DIR="${1:-.}"

echo "Starting bulk replacement in: $TARGET_DIR (Case-Insensitive)"
echo "------------------------------------------------------------------"

# 3. 遍历数组
for source in "${!replace_pairs[@]}"; do
    dest="${replace_pairs[$source]}"
    
    echo "Replacing '$source' (any case) with '$dest' everywhere..."

    # 4. 递归查找文件并进行不区分大小写的替换
    # 末尾的 'gI' 中：g 代表全局替换，I 代表忽略大小写 (GNU sed 特性)
    find "$TARGET_DIR" -type f ! -name "$0" -exec sed -i "s|$source|$dest|gI" {} +
done

echo "------------------------------------------------------------------"
echo "Replacement complete!"
