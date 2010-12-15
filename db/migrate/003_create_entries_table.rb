################################################################################
# $Id: 003_create_entries_table.rb 940 2007-12-17 15:19:35Z ccaroon $
################################################################################
class CreateEntriesTable < ActiveRecord::Migration
    def self.up
        create_table :entries do |t|
            t.column :task_date,   :date,     :null => false;
            t.column :entry_date,  :datetime, :null => false;
            t.column :ticket_num,  :string,   :null => true;
            t.column :subject,     :string,   :null => false;
            t.column :description, :text,     :null => false;
            t.column :category,    :string,   :null => false, :default => 'Other';
            t.column :goal_id,     :integer,  :null => true;
        end
    end

    def self.down
        drop_table :entries; 
    end
end
