#!/bin/bash
#Script references auditbeat.yml as if it was stored in tmp folder with the script
#Add your version of auditbeat.yml in same dir as bash script
#add your version of auditbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.17.9-x86_64.rpm
sudo rpm -vi auditbeat-7.17.9-x86_64.rpm
mkdir /etc/auditbeat/certs
echo '-----BEGIN CERTIFICATE-----
Your_Cert_here
-----END CERTIFICATE-----
' > /etc/auditbeat/certs/elastic.crt
echo '-----BEGIN CERTIFICATE-----
Your_Cert_here
-----END CERTIFICATE-----
' > /etc/auditbeat/certs/kibana.crt
mv /etc/auditbeat/auditbeat.yml /etc/auditbeat/auditbeat.yml.bak
#be sure to add your updated version of your yaml template configured for your environment
mv auditbeat.yml /etc/auditbeat/auditbeat.yml
auditbeat keystore create
#add your passwd for elastic
echo 'Your_Password' | auditbeat keystore add ES_PWD --stdin --force 
auditbeat setup -e
/bin/systemctl enable auditbeat.service
service auditbeat start
