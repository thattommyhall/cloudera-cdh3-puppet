class hbase::master {
  require hbase::common
  package { "hadoop-hbase-master":
    ensure  => "latest",
  }
}

class hbase::regionserver {
  require hbase::common
  package { "hadoop-hbase-regionserver":
    ensure  => "latest",
  }
}

class hbase::common {
  require hadoop::base
  Package["hadoop-hbase"] -> File["/etc/hbase/conf"]

  File {
    owner => "root",
    group => "root",
    mode => 0660,
  }

  line { "enable limits":
    file => "/etc/pam.d/common-session",
    line => "session required pam_limits.so",
  }

  file { "/etc/security/limits.d/hbase.conf":
    content => "
hdfs - nofile  65536
hbase - nofile  65536
  "
  }
  file { "/etc/hbase/conf":
    ensure => directory,
    owner  => 'hbase',
    source => 'puppet:///modules/hbase/etc/hbase/conf',
    recurse => true
  }

  file { "hbase-env":
    owner  => 'hbase',
    path    => "/etc/hbase/conf/hbase-env.sh",
    ensure  => file,
    content => template("hbase/hbase-env.sh.erb"),
  }

  package { "hadoop-hbase":
    ensure => 'latest',
  }
}
