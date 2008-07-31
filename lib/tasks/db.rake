# :dump_all and :dump_references are from http://snippets.dzone.com/posts/show/4729
# (an alternative approach is at http://snippets.dzone.com/posts/show/2525)

namespace :db do
  namespace :fixtures do

    desc 'Create YAML test fixtures from data in an existing database.
Defaults to development database. Set RAILS_ENV to override.'
    task :dump_all => :environment do
      sql = "SELECT * FROM %s"
      skip_tables = ["schema_info", "schema_migrations"]
      ActiveRecord::Base.establish_connection(:development)
      (ActiveRecord::Base.connection.tables - skip_tables).each do |table_name|
        i = "000"
        File.open("#{RAILS_ROOT}/test/fixtures/#{table_name}.yml", 'w') do |file|
          data = ActiveRecord::Base.connection.select_all(sql % table_name)
          file.write data.inject({}) { |hash, record|
            hash["#{table_name}_#{i.succ!}"] = record
            hash
          }.to_yaml
        end
      end
    end
  end
  
  namespace :fixtures do
    desc 'Create YAML test fixtures for references. Defaults to development database. 
    Set RAILS_ENV to override.'
    task :dump_references => :environment do
      sql = "SELECT * FROM %s"
      dump_tables = ["areas","countries"]
      ActiveRecord::Base.establish_connection(:development)
      dump_tables.each do |table_name|
        i = "000"
        file_name = "#{RAILS_ROOT}/test/fixtures/#{table_name}.yml"
        p "Fixture save for table #{table_name} to #{file_name}"
        File.open(file_name, 'w') do |file|
          data = ActiveRecord::Base.connection.select_all(sql % table_name)
          file.write data.inject({}) { |hash, record|
            hash["#{table_name}_#{i.succ!}"] = record
            hash
          }.to_yaml
        end
      end
    end
  end
end 


