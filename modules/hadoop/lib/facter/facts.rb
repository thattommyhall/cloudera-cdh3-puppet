Facter.add("hadoop_hdfs_data_dirs") do
  setcode { Dir.glob('/data*/hdfs/data/').join(',') }
end

Facter.add("hadoop_mapred_local_dirs") do
  setcode { Dir.glob('/data*/mapred/local/').join(',') }
end