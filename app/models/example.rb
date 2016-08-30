class Example < ApplicationRecord
  translates :name, :content, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations, allow_destroy: true
end

# == Schema Information
#
# Table name: examples
#
#  id         :integer          not null, primary key
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
