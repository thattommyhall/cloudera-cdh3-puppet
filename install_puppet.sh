#install on ubuntu
wget -nc http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_1.8.7-2011.03_amd64_ubuntu10.04.deb
dpkg -i ruby-enterprise_1.8.7-2011.03_amd64_ubuntu10.04.deb

mkdir -p /etc/puppet
echo '[main]' > /etc/puppet/puppet.conf
echo 'pluginsync = true' >> /etc/puppet.conf
/usr/local/bin/gem install --no-ri --no-rdoc puppet
/usr/local/bin/puppet agent --no-daemonize --verbose --server=ask-puppet-master.forward.co.uk --onetime


#Remove ssl cert stuff
sudo rm -rf /etc/puppet/ssl && sudo rm -rf /var/lib/puppet

#running inside vagrasnt
/opt/ruby/bin/ruby /opt/ruby/bin/puppetd --server puppet  --no-daemonize --verbose --onetime --certname MACHINENAME