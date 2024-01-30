#!/bin/bash

cat > /etc/systemd/system/frps.service << EOF
[Unit]
# 服务名称，可自定义
Description = frp server
After = network.target syslog.target
Wants = network.target

[Service]
Type = simple
# 启动frps的命令，需修改为您的frps的安装路径
ExecStart = /opt/frp/frps -c /opt/frp/frps.toml

[Install]
WantedBy = multi-user.target
EOF

systemctl start frps
systemctl status frps
