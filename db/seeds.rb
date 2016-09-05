puts "============== Create addmin account ============"

admins = [
  # admin
  {
    email: 'admin@satv.com',
    password: '1234qwer'
  },
  {
    email: 'quan@supperawesome.tv',
    password: '1234qwer'
  },
  {
    email: 'hoang.nguyen@supperawesome.tv',
    password: '1234qwer'
  },
  {
    email: 'wilber.nguyen@superawesome.tv',
    password: '1234qwer'
  },
  {
    email: 'huu.ngo@supperawesome.tv',
    password: '1234qwer'
  },
  {
    email: 'phuong.nguyen@superawesome.tv',
    password: '1234qwer'
  },
  {
    email: 'tung.an@superawesome.tv',
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