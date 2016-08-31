class DeviceInfo < ApplicationRecord

  include DeviceInfoBase

end

# == Schema Information
#
# Table name: device_infos
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  device_type          :string
#  device_name          :string
#  device_id            :string
#  device_token         :string
#  os_version           :string
#  screen_dpi           :string
#  app_version          :string
#  authentication_token :string
#  app_name             :string
#  country_code         :string
#  locale               :string           default("en")
#  is_playing           :boolean
#  play_in_count        :integer          default(0), not null
#  last_play_off_at     :datetime
#  last_play_in_ip      :inet
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  last_play_in_at      :datetime
#  last_play_off_ip     :inet
#
# Indexes
#
#  index_device_infos_on_device_id     (device_id) UNIQUE
#  index_device_infos_on_device_token  (device_token) UNIQUE
#
