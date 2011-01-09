class AddLunchToWorkDays < ActiveRecord::Migration
  def self.up
    add_column :work_days, :lunch, :time, :default => '00:00:00'
  end

  def self.down
    remove_column :work_days, :lunch
  end
end
