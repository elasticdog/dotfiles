complete -c ipa -x -a (echo api-{stage,prod}-api-{server,worker} api-prod-{consul-server,consul-webui,elasticsearch,jenkins-master,kibana,logstash} newport-prod-jenkins-master newport-{stage,prod}-web-server live-prod-jenkins-master live-{social,stage,prod}-live-server) --description 'Instance name'