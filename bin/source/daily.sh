#!/bin/bash

function daily-copy() {
    if [ -d "/Volumes/WD" ]; then
        echo "rsync......"
        rsync -arlvP --exclude={'.DS_Store','*.tmp'} $HOME/Music/Music/Media.localized/Music/ /Volumes/WD/00.Music
        rsync -arlvP --exclude={'.DS_Store','*.tmp'} $HOME/Pictures/DCIM/ /Volumes/WD/00.相册
        rsync -arlvP --exclude={'.DS_Store','*.tmp'} $HOME/Pictures/Picture/ /Volumes/WD/01.Picture
        rsync -arlvP --exclude={'.DS_Store','*.tmp'} $HOME/code/ /Volumes/WD/code
        # $HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application Support/com.tencent.xinWeChat/2.0b4.0.9/Backup/61d2f9a1c3629df6a8138c1898e81f6e/两个文件夹
        # $HOME/Library/Containers/com.tencent.xinWeChat/Data/Documents/xwechat_files/Backup/wxid_8855798557612
        # $HOME/Documents/weixin/xwechat_backup
    fi
}
