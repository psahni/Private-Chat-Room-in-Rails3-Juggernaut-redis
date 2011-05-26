class CreateChannels < ActiveRecord::Migration
  def self.up
    create_table :channels do |t|
      t.string     :channel_id
      t.integer    :sender_id
      t.integer    :receiver_id

      t.timestamps
    end
  end

  def self.down
    drop_table :channels
  end
end
