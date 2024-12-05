opt_home=/opt

export PATH=$PATH:$HOME/OneDrive/Code/shell/bin

# Java
export JAVA_HOME=$opt_home/java/Contents/Home
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib
export PATH=$PATH:$JAVA_HOME/bin

export KOTLIN_HOME=/Applications/IntelliJ\ IDEA.app/Contents/plugins/Kotlin/kotlinc
export PATH=$PATH:$KOTLIN_HOME/bin

# Maven
export M2_HOME=$opt_home/mvnd
export PATH=$PATH:$M2_HOME/bin:$M2_HOME/mvn/bin

# GO
export GO_HOME=$opt_home/go
export PATH=$PATH:$GO_HOME/bin
export PATH=$PATH:$HOME/go/bin
export GO111MODULE=on
# export GONOSUMDB=*
# export GOPROXY=https://goproxy.io,direct
export GOPROXY=https://goproxy.cn,direct
# export GOPROXY=https://repo.huaweicloud.com/repository/goproxy/
# export GOPROXY=https://mirrors.aliyun.com/goproxy/

# Rust
# export RUSTUP_HOME=$HOME/.rustup
# export CARGO_HOME=$HOME/.cargo
# export PATH=$PATH:$CARGO_HOME/bin

# Python
# export PATH=$PATH:$opt_home/python3/bin

# Redis
# export PATH=$PATH:$opt_home/redis/bin

# MongoDB
# export PATH=$PATH:$opt_home/mongodb/bin

# Gradle
# export GRADLE_HOME=$opt_home/gradle
# export PATH=$PATH:$GRADLE_HOME/bin/

# MySQL
# export MYSQL_HOME=$opt_home/mysql
# export PATH=$PATH:$MYSQL_HOME/bin

# Oracle
# export PATH=$PATH:$opt_home/instantclient_12_1

# NodeJS
# export PATH=$PATH:$opt_home/nodejs/bin

# Hadoop
# export HADOOP_HOME=$opt_home/hadoop
# export PATH=$PATH:$HADOOP_HOME/bin

# RabbitMQ
# export RABBITMQ_HOME=$opt_home/rabbitmq
# export PATH=$PATH:$RABBITMQ_HOME/bin:$RABBITMQ_HOME/sbin

# Kafka
# export KAFKA_HOME=$opt_home/kafka
# export PATH=$PATH:$KAFKA_HOME/bin

# ZooKeeper
# export ZOOKEEPER_HOME=$opt_home/zookeeper
# export PATH=$PATH:$ZOOKEEPER_HOME/bin

# Flink
# export FLINK_HOME=$opt_home/flink
# export PATH=$PATH:$FLINK_HOME/bin
