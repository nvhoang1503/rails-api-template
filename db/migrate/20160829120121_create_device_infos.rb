class CreateDeviceInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :device_infos do |t|
      t.integer :user_id
      t.string :device_type
      t.string :device_name
      t.string :device_id
      t.string :device_token
      t.string :os_version
      t.string :screen_dpi
      t.string :app_version
      t.string :authentication_token
      t.string :app_name
      t.string :country_code
      t.string :locale, default: "en"
      t.boolean :is_playing

      ## Trackable
      t.integer  :play_in_count, default: 0, null: false
      t.datetime :current_play_in_at
      t.datetime :last_play_off_at
      t.inet     :current_play_in_ip
      t.inet     :last_play_in_ip

      t.timestamps
    end
    add_index :device_infos, :device_id,                unique: true
    add_index :device_infos, :device_token,             unique: true
  end
end
