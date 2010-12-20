################################################################################
# $Id: 005_create_work_days_table.rb 940 2007-12-17 15:19:35Z ccaroon $
################################################################################
class CreateWorkDaysTable < ActiveRecord::Migration
    def self.up
        create_table :work_days do |t|
            t.column :work_date, :date,   :null => false;
            t.column :in,        :time,   :null => false;
            t.column :out,       :time,   :null => false;
            t.column :note,      :string, :null => true;
        end
    end

    def self.down
        drop_table :work_days;
    end
end
