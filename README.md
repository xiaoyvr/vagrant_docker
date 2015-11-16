###Start mesos cluster
```
docker run -d \
-e MYID=1 \
-e SERVERS=192.168.50.4 \
--name=zookeeper --net=host --restart=always mesoscloud/zookeeper:3.4.6-ubuntu-14.04

docker run -d \
-e MESOS_HOSTNAME=192.168.50.4 \
-e MESOS_IP=192.168.50.4 \
-e MESOS_QUORUM=1 \
-e MESOS_ZK=zk://127.0.0.1:2181/mesos \
--name mesos-master --net host --restart always mesoscloud/mesos-master:0.24.1-ubuntu-14.04  /usr/sbin/mesos-master --log_dir=/var/log/mesos --logging_level=INFO


docker run -d \
-e MESOS_HOSTNAME=192.168.50.4 \
-e MESOS_IP=192.168.50.4  \
-e MESOS_MASTER=zk://192.168.50.4:2181/mesos \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
--name slave --net host --privileged --restart always \
mesoscloud/mesos-slave:0.24.1-ubuntu-14.04 /usr/sbin/mesos-slave --log_dir=/var/log/mesos --logging_level=INFO


docker run -d \
-e MARATHON_HOSTNAME=192.168.50.4 \
-e MARATHON_HTTPS_ADDRESS=192.168.50.4 \
-e MARATHON_HTTP_ADDRESS=192.168.50.4 \
-e MARATHON_MASTER=zk://192.168.50.4:2181/mesos \
-e MARATHON_ZK=zk://192.168.50.4:2181/marathon \
--name marathon --net host --restart always mesoscloud/marathon:0.11.0-ubuntu-15.04 marathon --logging_level debug
```
