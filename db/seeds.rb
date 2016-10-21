puts "============== Create addmin account ============"

admins = [
  # admin
  {
    email: 'admin@tool.com',
    password: '1234qwer'
  }
]

# Admin.destroy_all

admins.each do |admin|
  count = Admin.where(email: admin[:email]).count
  Admin.create(admin) if count == 0
end
# if Rails.env == "development"
# end
  

puts "============== Finished to create addmin account ============"