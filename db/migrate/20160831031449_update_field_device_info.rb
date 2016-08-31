class UpdateFieldDeviceInfo < ActiveRecord::Migration[5.0]
  def change
    remove_column :device_infos, :current_play_in_at
    add_column :device_infos, :last_play_in_at, :datetime

    remove_column :device_infos, :current_play_in_ip
    add_column :device_infos, :last_play_off_ip, :inet

  end
end
