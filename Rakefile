require 'rake'

task :rake_run_test do
  puts "rake task is running"
end
# this rake task starts my elastic search
# avoids command repetition
# usual commands - cd Desktop
#                  cd elasticsearch-9.2.4
#                  bin/elasticsearch
task :elasticsearch_start_task do
  # puts "hello world"

  # abort "This task is only for development" unless ENV['RACK_ENV'] == 'development' || ENV['RACK_ENV'] == 'test'
  elastic_path = File.expand_path('~/Desktop/elasticsearch-9.2.4/bin/elasticsearch')
  unless File.exist?(elastic_path)
    abort("file not found in path #{elastic_path}")
  end

  puts "elasticsearch is starting......"
  exec elastic_path
end
