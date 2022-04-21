#!/bin/bash
soruce maven-hosted.sh
help() {
    echo "the way you executed scripted was wrong"\
    echo "mention any of these count, hosted or proxy"
    echo "example to run this script is bash sample.sh count"
}

if [ $1 = "count" ]
then
curl -s -u admin:admin -X 'GET' 'http://44.200.5.49:8081/service/rest/v1/repositories' -H 'accept: application/json' | jq .[].name | sed 's/"//g' | wc -l
elif [ $1 = "hosted" ]
then
curl -s -u admin:admin -X 'GET' 'http://44.200.5.49:8081/service/rest/v1/repositories' -H 'accept: application/json' | jq ' .[] | select ( .type == "hosted" ) ' | jq .name | sed 's/"//g'
elif [ $1 = "proxy" ]
then
curl -s -u admin:admin -X 'GET' 'http://44.200.5.49:8081/service/rest/v1/repositories' -H 'accept: application/json' | jq ' .[] | select ( .type == "porxy" ) | .name + "," + .attributes.proxy.remoteUrl ' | sed '/"//g'
elif [[ $1 = "mvn" && $2 = "hosted" ]]
then
echo "please enter maven repo name"
read repo
sed -i 's/changeme/$repo/g' maven-hosted.json
curl -s -X 'POST' \
  'http://44.200.5.49:8081/service/rest/v1/repositories/maven/hosted' \
  -H 'accept: application/json' -H 'Content-Type: application/json' -d@maven-hosted.json
  if [ $? -eq 0 ]
    then
    echo "repo creaation is successfull"
    else
    echo "repo creation is failyre"
  fi
sed -i s+'s/$repo/changeme/g' maven-hosted.json
fi
