# Target: 

Detect a large number of machines in batch (the scale is about several thousand) to obtain the survival status

# Architecture:

![Architecture](https://github.com/ieasydevops/ping-host/blob/main/docs/images/ping-hosts-arch.png)


# Deploy

```

1. Write the list of target ip that need Ping into the scripts/ping-targets.txt file, One record per line. as flows:

www.baidu.com
www.google.com

2. bash build.sh build

3. docker-compose up -d

4. http://localhost:3000/d/ping/pingda-pan?orgId=1

   grafana user/pwd: admin/ieasydevops

```

# Effect picture

## Ping dashboard
![ping-dashboard](https://github.com/ieasydevops/ping-host/blob/main/docs/images/ping-dashboard.png)

## container monitor  dashboard

![contianer-dashboard](https://github.com/ieasydevops/ping-host/blob/main/docs/images/contianer-dashboard.png)


## db (victira-metrics) monitor dashboard

![vm-dashboard](https://github.com/ieasydevops/ping-host/blob/main/docs/images/vm-dashboard.png)










