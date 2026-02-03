require 'yaml'
require_relative '../config/elastic-search-client'
class IndexManager
  # loading our index configurations from yml file
  INDICES = YAML.load_file("config/Elastic_Indices.yml")['development']
  # puts INDICES


  # creating new index in elasticsearch using the predefined configuration
  def self.setup!
    INDICES.each_value do |index_conf|

      IndexManager.create_index_if_not_exists(index_conf)

    end
  end

  def self.create_index_if_not_exists(index_conf)
    index_name = "#{index_conf['alias']}_v#{index_conf['version']}"
    alias_name = index_conf['alias']
    # puts index_name
    return if ELASTIC_CLIENT.indices.exists?(index: index_name)

    ELASTIC_CLIENT.indices.create(
      index: index_name,
      body: {
        settings: {
          number_of_shards: index_conf['shards'],
          number_of_replicas: 0
        },
        mappings: index_conf['mappings'],
        aliases: {
          # this means setting alias_name as alias for this index and not providing any special behavior only default behavior
          alias_name => {}
        }
      }
    )

  end

end
