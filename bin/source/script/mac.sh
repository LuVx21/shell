#!/bin/bash

cmd=$1
sub_cmd=$2
op2=$3
if [ "$cmd" = "" ]; then
    cat << HELP
macs: 命令行操作mac
    vol: 调节音量
        set <num>: 设置音量百分比
        get:       当前音量
        muted:     静音
        unmuted:   取消静音
    clean: 清理磁盘
    update: 日常更新
HELP
    # echo -e "需指定操作"
    return
elif [ "$cmd" = "vol" ]; then
    case "$sub_cmd" in
        up|down)
            step=10
            if [[ -n "$op2" && "$op2" != " " ]]; then
                if [[ "$op2" =~ ^[0-9]+$ ]]; then
                    step="$op2"
                else
                    echo "音量调节步长必须是数字, 使用默认10"
                fi
            fi
            cur_volume=$(osascript -e 'output volume of (get volume settings)')
            if [[ "$sub_cmd" == "up" ]]; then
                new_volume=$((cur_volume + step))
            else
                new_volume=$((cur_volume - step))
            fi
            if (( new_volume > 100 )); then
                new_volume=100
            elif (( new_volume < 0 )); then
                new_volume=0
            fi
            osascript -e "set volume output volume $new_volume"
            osascript -e 'output volume of (get volume settings)'
            ;;
        set)
            osascript -e "set volume output volume $op2"
            osascript -e 'output volume of (get volume settings)'
            ;;
        get)
            osascript -e 'output volume of (get volume settings)'
            ;;
        muted)
            osascript -e 'set volume with output muted'
            # osascript -e "set volume output muted true"
            ;;
        unmuted)
            osascript -e 'set volume without output muted'
            ;;
        *)
            osascript -e 'output volume of (get volume settings)'
            ;;
    esac
elif [ "$cmd" = "sleep" ]; then
    pmset sleepnow
elif [ "$cmd" = "shutdown" ]; then
    osascript -e 'tell app "loginwindow" to «event aevtrsdn»'
elif [ "$cmd" = "restart" ]; then
    osascript -e 'tell app "loginwindow" to «event aevtrrst»'
elif [ "$cmd" = "clean" ]; then
    echo "go clean..."
    go clean -cache
    go clean -fuzzcache
    go clean -modcache

    pip3 cache purge

    echo "delete......"
    # rm -r $HOME/Library/Caches/{go-build,JetBrains,gopls}
    # rm -r $HOME/Library/Caches/{GeoServices,Homebrew}
    rm -r $HOME/Library/Application\ Support/apifox/{logs,Cache}
    rm -r $HOME/Library/Application\ Support/Caches/*
    rm -r $HOME/Library/Application\ Support/Microsoft/EdgeUpdater/apps/msedge-{dev,updater}
    rm -r $HOME/Library/Application\ Support/Microsoft\ Edge\ Dev/*/Application\ Cache/*
    rm -r $HOME/Library/Application\ Support/Microsoft\ Edge\ Dev/*/GPUCache/*
    rm -r $HOME/Library/Caches/cherrystudio-updater
    rm -r $HOME/Library/Caches/Microsoft\ Edge\ Dev/*
    rm -r $HOME/Library/Logs/OneDrive/Personal/*
    rm -r $HOME/Library/Logs/JetBrains/*

    echo "docker......"
    docker builder prune -f
    docker image prune -f
elif [ "$cmd" = "update" ]; then
    echo "copy....."
    cp $HOME/Library/Application\ Support/Microsoft\ Edge\ Dev/Default/Cookies $HOME/data/sqlite

    echo "delete......"
    rm $HOME/Library/Application\ Support/Beyond\ Compare*/registry.dat
    rm ~/docker/freshrss/data/cache/*.spc

    echo "brew......"
    brew update && brew upgrade && brew cu -af && brew cleanup && brew autoremove

    rm -fr $HOME/Library/Caches/Homebrew/downloads

    # omz update &
elif [ "$cmd" = "dmg" ]; then
    DMG_PATH=$sub_cmd
    VOLUME_NAME=$(hdiutil attach "$DMG_PATH" | grep -o '/Volumes/.*' | cut -f 3- -d '/')
    APP_NAME=$(find "/Volumes/$VOLUME_NAME" -name "*.app" -maxdepth 1 -exec basename {} \; | head -n 1)
    OLD_APP_PATH="/Applications/$APP_NAME"
    BACKUP_PATH="/Applications/${APP_NAME%.app}_old.app"
    if [ -d "$OLD_APP_PATH" ]; then
        echo "发现旧版本，重命名为备份..."
        mv "$OLD_APP_PATH" "$BACKUP_PATH" 2>/dev/null || sudo mv "$OLD_APP_PATH" "$BACKUP_PATH"
    fi
    find "/Volumes/$VOLUME_NAME" -name "*.app" -maxdepth 1 -exec cp -R {} /Applications/ \;
    hdiutil detach "/Volumes/$VOLUME_NAME"
    if [ -d "$BACKUP_PATH" ]; then
        echo "删除旧版本..."
        rm -rf "$BACKUP_PATH" 2>/dev/null || sudo rm -rf "$BACKUP_PATH"
    fi
else
    echo -e "无指定操作: $sub_cmd"
fi