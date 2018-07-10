# PuppetConf 2016 - Scaling Puppet on AWS using Terraform and ECS

Here is the source code I used in order to illustrate my talk at **PuppetConf 2016**.

Recording of the talk can be found here : https://www.youtube.com/watch?v=aSwsbWCPFUs

## Docker images

### puppetserver

This image is used for both `CA` and `Server`

https://github.com/mvisonneau/docker-puppetserver

Here is the sidekick I made in order to fetch my puppet configuration packages

https://github.com/mvisonneau/docker-pptcb

### puppetdb

https://github.com/mvisonneau/docker-puppetdb

### puppetboard

https://github.com/mvisonneau/docker-puppetboard

### sweety app

https://github.com/mvisonneau/docker-sweety

## Thanks!

- AWS
- Camptocamp
- HashiCorp
- Puppet
- Trainline
- Voxpupuli
