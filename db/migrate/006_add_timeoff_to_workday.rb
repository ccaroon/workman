class AddTimeoffToWorkday < ActiveRecord::Migration
    def self.up
        add_column :work_days, :is_vacation, :boolean, :null => false, :default => false;
        add_column :work_days, :is_holiday,  :boolean, :null => false, :default => false;
        add_column :work_days, :is_sick_day, :boolean, :null => false, :default => false;
    end

    def self.down
        remove_column :work_days, :is_vacation;
        remove_column :work_days, :is_holiday;
        remove_column :work_days, :is_sick_day;
    end
end
