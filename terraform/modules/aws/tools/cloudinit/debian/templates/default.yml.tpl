#cloud-config
hostname: ${hostname}
bootcmd:
  - echo "127.0.0.1 localhost" > /etc/hosts
apt_sources:
  - source: deb http://apt.puppetlabs.com $RELEASE PC1
    keyid: 7F438280EF8D349F
    filename: puppetlabs.list
apt_update: true
apt_upgrade: true
packages:
  - puppet-agent=${puppet_version}
locale: en_US.UTF-8
timezone: UTC
runcmd:
  - /opt/puppetlabs/puppet/bin/puppet agent -t --server=${puppet_server} --environment=${puppet_env}
final_message: "The system is finally up, after $UPTIME seconds"
