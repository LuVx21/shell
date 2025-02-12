opt_home=/opt
HOMEBREW_HOME=/opt/homebrew

export PATH=$HOMEBREW_HOME/bin:$PATH

export PATH=$HOME/OneDrive/Code/shell/bin:$PATH

# Java
export JAVA_HOME=$opt_home/java/Contents/Home
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib
export PATH=$JAVA_HOME/bin:$PATH

export KOTLIN_HOME=/Applications/IntelliJ\ IDEA.app/Contents/plugins/Kotlin/kotlinc
export PATH=$KOTLIN_HOME/bin:$PATH

# Maven
export M2_HOME=$opt_home/mvnd
export PATH=$M2_HOME/bin:$M2_HOME/mvn/bin:$PATH

# GO
export GO_HOME=$opt_home/go
export PATH=$GO_HOME/bin:$PATH
export PATH=$HOME/go/bin:$PATH

# Rust
# export RUSTUP_HOME=$HOME/.rustup
# export CARGO_HOME=$HOME/.cargo
# export PATH=$CARGO_HOME/bin:$PATH

# Python
# export PATH=$opt_home/python3/bin:$PATH

# Redis
# export PATH=$opt_home/redis/bin:$PATH

# MongoDB
# export PATH=$opt_home/mongodb/bin:$PATH

# Gradle
# export GRADLE_HOME=$opt_home/gradle
# export PATH=$GRADLE_HOME/bin/:$PATH

# MySQL
# export MYSQL_HOME=$opt_home/mysql
# export PATH=$MYSQL_HOME/bin:$PATH

# Oracle
# export PATH=$opt_home/instantclient_12_1:$PATH

# NodeJS
# export PATH=$opt_home/nodejs/bin:$PATH

# Hadoop
# export HADOOP_HOME=$opt_home/hadoop
# export PATH=$HADOOP_HOME/bin:$PATH

# RabbitMQ
# export RABBITMQ_HOME=$opt_home/rabbitmq
# export PATH=$RABBITMQ_HOME/bin:$RABBITMQ_HOME/sbin:$PATH

# Kafka
# export KAFKA_HOME=$opt_home/kafka
# export PATH=$KAFKA_HOME/bin:$PATH

# ZooKeeper
# export ZOOKEEPER_HOME=$opt_home/zookeeper
# export PATH=$ZOOKEEPER_HOME/bin:$PATH

# Flink
# export FLINK_HOME=$opt_home/flink
# export PATH=$FLINK_HOME/bin:$PATH
