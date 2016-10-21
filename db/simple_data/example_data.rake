puts "=========== Create simple data for example ==========="

examples = []
10.times do 
  examples << {
      name: Faker::Name.name,
      content: Faker::Lorem.sentence
    }
end
Example.create(examples)


puts "=========== Example data has been created !!! ==========="