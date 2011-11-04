#! /usr/bin/env ruby
`mkdir -p /etc/puppet/`
`echo '[main]' > /etc/puppet/puppet.conf`
`echo 'pluginsync = true' >> /etc/puppet/puppet.conf`
`echo '33.33.66.1 puppet' >> /etc/hosts`

(0..5).each do |disk_num|
  `mkdir -p /data#{disk_num}/mapred/local`
  `mkdir -p /data#{disk_num}/hdfs/data/`
end