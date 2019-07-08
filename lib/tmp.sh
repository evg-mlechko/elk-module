vi /opt/tomcat/logs/localhost_access_log.2019-07-08.txt

vi /var/log/logstash/logstash-plain.log

vi /opt/tomcat/logs/localhost_access_log.2019-07-08.txt

/etc/logstash/conf.d/tomcat.conf
#
input {
    file {
        path => "/usr/share/tomcat/slogs/catalina.*.log"
        start_position => "beginning"
    }
}
output {
    elasticsearch {
        hosts => ["172.31.31.254:9200"]----19.20
        index => "tomcat"
    }
}

######
/etc/logstash/logstash.yml
http.host: 172.31.31.100  ----19.10


/etc/elasticsearch/elasticsearch.yml
'node.name: node-1'
cluster.initial_master_nodes: node-1
network.host: 172.31.31.254  ----19.20
http.port: 9200

/etc/kibana/kibana.yml
#kibana
server.host: 172.31.31.254  ----19.20
elasticsearch.hosts: ["http://172.31.31.254:9200"] ----19.20
