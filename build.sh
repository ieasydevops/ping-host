#!/bin/bash
set -x
WORKSPACE=$(cd $(dirname $0)/; pwd)
cd $WORKSPACE
ping_hosts=./scripts/ping-targets.txt
telegraf_cfg=./etc/telegraf/agent.yml

function build_telegraf_cfg_header(){
cat << EOF
[agent]
interval = "30s"
round_interval = false
metric_batch_size = 1000
metric_buffer_limit = 10000
collection_jitter = "0s"
flush_interval = "10s"
flush_jitter = "0s"
precision = "s"
debug = true
quiet = false
logtarget = ""
logfile = ""
logfile_rotation_max_archives = 5
hostname = ""
omit_hostname = false
[[outputs.influxdb]]
urls = ["http://victoriametrics:8428"]
database = "ccagent"
timeout = "10s"

[global_tags]
point_name = "agent"

EOF
}



function build_ping_instance_once(){
cat << EOF
[[inputs.ping]]
  urls = ["$1"]
  count = 5
  ping_interval = 0.5 
  timeout = 1.0
EOF
}

function build_ping_instances(){
cat $ping_hosts | while read line
do
   instance=`echo $line | awk -F ';' '{print $1}'`
   build_ping_instance_once $instance  >> $telegraf_cfg
done
}






function build(){
    build_telegraf_cfg_header >> $telegraf_cfg
    build_ping_instances
}


function clean(){
    
    rm -rf ./etc/telegraf/*
}


function help() {
    echo "$0 build|version"
}

if [ "$1" == "" ]; then
    help
elif [ "$1" == "build" ];then
    build
elif [ "$1" == "clean" ];then
    clean
else
    help
fi
