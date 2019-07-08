
#java installation
yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64
sudo yum install wget -y

# tomcat installation

wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.42/bin/apache-tomcat-8.5.42.tar.gz
tar -xzvf apache-tomcat-8.5.42.tar.gz -C /opt
cd /opt
mv apache-tomcat-8.5.42 tomcat
groupadd tomcat
useradd -g tomcat -d /opt/tomcat -s /bin/nologin tomcat
chown -R tomcat:tomcat /opt/tomcat/
cp -f /vagrant/lib/tomcat.service /etc/systemd/system/tomcat.service
cp /vagrant/lib/sample.war /opt/tomcat/webapps/
sleep 3
systemctl enable tomcat
systemctl restart tomcat
chmod -R 755 /opt/tomcat/logs/

# Logstash installation
# Download and install the public signing key
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
# add l repo
cat > /etc/yum.repos.d/logstash.repo <<EOF
[logstash-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum install logstash -y
cat > /etc/logstash/conf.d/logstash.conf <<EOF
input {
  file {
    path => "/opt/tomcat/logs/*"
    start_position => "beginning"
  }
}

output {
  elasticsearch {
    hosts => ["192.168.19.20:9200"]
  }
stdout { codec => rubydebug }
}
EOF
systemctl enable logstash
systemctl restart logstash
chmod -R 755 /opt/tomcat/logs
