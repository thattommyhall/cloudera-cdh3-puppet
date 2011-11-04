node /slave\d+/ {
  include hadoop::datanode
  include hadoop::tasktracker
  include hbase::regionserver

}

node master {
  include hadoop::namenode
  include hadoop::jobtracker
  include hbase::master
}
