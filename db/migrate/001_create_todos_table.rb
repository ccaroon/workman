################################################################################
# $Id: 001_create_todos_table.rb 940 2007-12-17 15:19:35Z ccaroon $
################################################################################
class CreateTodosTable < ActiveRecord::Migration
    def self.up
        create_table :todos do |t|
            t.column :priority,     :integer, :null => false;
            t.column :title,        :string,  :null => false;
            t.column :created_on,   :datetime, :null => false;
            t.column :completed,    :boolean, :default => 0, :null => false;
            t.column :completed_on, :datetime;
        end
    end
    
    def self.down
        drop_table :todos;
    end
end
