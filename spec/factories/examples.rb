# == Schema Information
#
# Table name: examples
#
#  id         :integer          not null, primary key
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :example do
    name "MyString"
content "MyText"
photo "MyString"
  end

end
