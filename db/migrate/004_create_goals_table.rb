################################################################################
# $Id: 004_create_goals_table.rb 940 2007-12-17 15:19:35Z ccaroon $
################################################################################
class CreateGoalsTable < ActiveRecord::Migration
    def self.up
        create_table :goals do |t|
            t.column :priority,     :integer,  :null => false;
            t.column :name,         :string,   :null => false;
            t.column :description,  :text,     :null => true;
            t.column :created_on,   :datetime, :null => false;
            t.column :updated_on,   :datetime, :null => false;
            t.column :completed,    :boolean,  :null => false, :default => false;
            t.column :completed_on, :datetime, :null => true;
            t.column :percent_complete, :integer, :null => false, :default => 0;
        end
    end

    def self.down
        drop_table :goals; 
    end
end
