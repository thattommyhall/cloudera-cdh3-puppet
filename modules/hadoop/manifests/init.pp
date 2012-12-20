#The only dependency outside the hadoop module is java in hadoop::package
class hadoop::datanode {
  require hadoop::base
  package { "hadoop-0.20-datanode":
    ensure => "latest",
  }
}

class hadoop::tasktracker {
  require hadoop::base
  package { "hadoop-0.20-tasktracker":
    ensure => "latest",
  }
}

class hadoop::namenode {
  require hadoop::base
  package { "hadoop-0.20-namenode":
    ensure => "latest",
  }
  file { ["/var/hadoop","/var/hadoop/dfs", "/var/hadoop/dfs/name"]:
    ensure => directory,
    owner  => 'hdfs'
  }
}

class hadoop::jobtracker {
  require hadoop::base
  package { "hadoop-0.20-jobtracker":
    ensure => "latest",
  }
}

class hadoop::ganglia {
  file { "/etc/ganglia/gmond.conf":
    content => template("hadoop/gmond.erb"),
  }
}

class hadoop::hosts_file {
  file { "/etc/hosts":
    owner => root,
    group => root,
    mode => 644,
    source  => 'puppet:///modules/hadoop/etc/hosts',
    ensure => present,
  }
}

class hadoop::base {
  require hadoop::package
  File {
    owner => root,
    group => root,
    mode  => 755,
  }
  file { "/usr/lib/hadoop-0.20/conf/":
    ensure  => directory,
    source  => 'puppet:///modules/hadoop/usr/lib/hadoop-0.20/conf/',
    recurse => true,
  }
  file { "hdfs-site":
    path    => "/usr/lib/hadoop-0.20/conf/hdfs-site.xml",
    ensure  => file,
    content => template("hadoop/hdfs-site.xml.erb"),
  }
  file { "mapred-site":
    path    => "/usr/lib/hadoop-0.20/conf/mapred-site.xml",
    ensure  => file,
    content => template("hadoop/mapred-site.xml.erb"),
  }
  file { "core-site":
    path    => "/usr/lib/hadoop-0.20/conf/core-site.xml",
    ensure  => file,
    content => template("hadoop/core-site.xml.erb"),
  }
  file { "hadoop-env":
    path    => "/usr/lib/hadoop-0.20/conf/hadoop-env.sh",
    ensure  => file,
    content => template("hadoop/hadoop-env.sh.erb"),
  }
  file { "/etc/sysctl.d/60-reboot":
    ensure  => file,
    content => "kernel.panic=10",
  }
  file { "/etc/sysctl.d/60-swappyness":
    ensure  => file,
    content => "vm/swappiness=0",
  }
}

class hadoop::package {
  require hadoop::apt,java
  package { "hadoop-0.20":
    ensure => "latest",
  }
}

class hadoop::apt {
  Package['curl'] -> Exec["add_cloudera_repokey"]
  File["/etc/apt/sources.list.d/cloudera.list"] ~> Exec["add_cloudera_repokey"]  ~> Exec["apt-get update"]

  package { "curl":
    ensure => "latest",
  }

  file { "/etc/apt/sources.list.d/cloudera.list":
    owner  => "root",
    group  => "root",
    mode   => "0440",
    source => "puppet:///modules/hadoop/etc/apt/sources.list.d/cloudera.list",
  }

  exec { "add_cloudera_repokey":
    command     => "/usr/bin/curl -s http://archive.cloudera.com/debian/archive.key | sudo apt-key add -",
    refreshonly => true
  }

  exec { "apt-get update":
    command     => "/usr/bin/apt-get -q -q update",
    logoutput   => false,
    refreshonly => true,
  }
}

