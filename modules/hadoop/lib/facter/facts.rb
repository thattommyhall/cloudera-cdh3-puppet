Facter.add("hadoop_hdfs_data_dirs") do
  path = Dir.glob('/data*/hdfs/data/').join(',')
  setcode { path.empty? ? "/tmp/hadoop" : path }
end

Facter.add("hadoop_mapred_local_dirs") do
  path = Dir.glob('/data*/mapred/local/').join(',')
  setcode { path.empty? ? "/tmp/hadoop" : path }
end

mapper_ratio = 0.8
oversubscription = 0.2
total_slots = (Facter.processorcount.to_i * (1+oversubscription)).ceil

Facter.add("mapred_tasktracker_reduce_tasks_maximum") do
  setcode { (total_slots * (1-mapper_ratio)).ceil }
end

Facter.add("mapred_tasktracker_map_tasks_maximum") do
  setcode { (total_slots * mapper_ratio).ceil }
end
