Install Cloudera CDH3 with puppet
=================================

Puppet modules to install hadoop, hbase and java.

The slave stuff is more tested than the master at the moment as we had a master before I started moving the config to puppet.

Testing with Vagrant
====================

> $ cd vagrant
> $ ./run_puppet_master.sh

You can clear the ssl certs of the temporary puppet master with 

> $ ./remove_sll.sh

Might be useful if you want to learn to administer hadoop 