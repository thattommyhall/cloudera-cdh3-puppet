mkdir -p /tmp/cdh3-puppet
puppet master --no-daemon --confdir ../ --vardir=/tmp/chd3-puppet/var --verbose --certname=puppet --ssldir=/tmp/cdh3-puppet/ssl
