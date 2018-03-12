
yum install vsftpd

# 开机自启
chkconfig vsftpd on

# 启动服务
service vsftpd start
# service vsftpd stop
# service vsftpd restart

vi /etc/sysconfig/iptables
# REJECT行之前
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT
service iptables start


vi /etc/vsftpd/vsftpd.conf

# 设定不允许匿名访问
# anonymous_enable=NO
# 设定本地用户可以访问.注:如使用虚拟宿主用户，在该项目设定为NO的情况下所有虚拟用户将无法访问
# local_enable=YES
# 使用户不能离开主目录
# chroot_list_enable=YES
# chroot_list_file=/etc/vsftpd/chroot_list
# 设定支持ASCII模式的上传和下载功能
# ascii_upload_enable=YES
# ascii_download_enable=YES
# 设定启用虚拟用户功能
# guest_enable=YES
# 指定虚拟用户的宿主用户
# guest_username=ftp
# 设定虚拟用户个人vsftp的CentOS FTP服务文件存放路径
# user_config_dir=/etc/vsftpd/vuser_conf