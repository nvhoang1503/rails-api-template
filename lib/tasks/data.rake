namespace :db do
  desc 'Drop, re-create and seed, populate sample data'

  task :simple_data => [:sample_data_for_example]


  task :sample_data_for_example => :environment do
    seed_file = File.join(Rails.root, 'db', 'simple_data/example_data.rb')
    load(seed_file) if File.exist?(seed_file)
  end

end