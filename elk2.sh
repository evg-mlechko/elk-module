yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64

# inst keys
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
# Installing elasticsearch
# add repo
cat >> /etc/yum.repos.d/elasticsearch.repo <<EOF
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF
yum install elasticsearch -y
cat >> /etc/elasticsearch/elasticsearch.yml <<EOF
network.host: 192.168.19.20
discovery.type: single-node
EOF
systemctl enable elasticsearch
systemctl daemon-reload
systemctl restart elasticsearch

# installing kibana

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat >> /etc/yum.repos.d/kibana.repo <<EOF
[kibana-7.x]
name=Kibana repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum install kibana -y
systemctl enable kibana
cat >> /etc/kibana/kibana.yml <<EOF
server.host: 192.168.19.20
elasticsearch.hosts: ["http://192.168.19.20:9200"]
EOF
systemctl daemon-reload
systemctl restart kibana
