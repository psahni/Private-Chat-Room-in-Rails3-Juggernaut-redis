class AddLastActivityFieldToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_time_activity, :datetime
  end

  def self.down
    remove_column :users, :last_time_activity
  end
end
