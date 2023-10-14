#!/bin/bash
# 你的喵提醒Key
key="t4qb1aL"

while true; do
    # 使用nvidia-smi命令获取每块GPU的显存使用情况（单位：MiB）
    gpu_mem_usage=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
    # 将显存使用情况转换为数组
    gpu_mem_usage_array=($gpu_mem_usage)
    for i in "${!gpu_mem_usage_array[@]}"; do
        mem=${gpu_mem_usage_array[$i]}
        if (( mem < 1024 )); then  # 使用curl命令发送喵提醒通知
            curl "http://miaotixing.com/trigger?id=$key&text=""显卡$i空闲！！！" | tr -d "\n" | xxd -plain | sed "s/\(..\)/%\1/g"
            # 成功发送一次提醒之后，休眠6个小时
            sleep 21600
        else  # 如果显存占用大于或等于1GB，打印一条信息
            echo "GPU is being used. Current memory usage: $mem MiB"
        fi
    done
    sleep 300  # 每300秒检查一次
done
