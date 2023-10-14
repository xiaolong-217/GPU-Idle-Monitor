#!/bin/bash
key="t9Omz10"
# 你的会话名称列表
declare -a session_names=("gpu_monitor" "session1" )


while true; do
    # 获取当前tmux的所有会话名称
    tmux_sessions=$(tmux list-sessions -F "#S")

    # 检查每一个会话名称是否存在
    for session_name in "${session_names[@]}"
    do
        if [[ $tmux_sessions != *"$session_name"* ]]; then
            echo "$session_name"
            curl "http://miaotixing.com/trigger?id=$key&text=""$session_name窗口不存在！！！" | tr -d "\n" | xxd -plain | sed "s/\(..\)/%\1/g"
        fi
    done

    # 等待5秒
    sleep 1800
done
