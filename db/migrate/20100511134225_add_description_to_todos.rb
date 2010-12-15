################################################################################
# $Id: 20100511134225_add_description_to_todos.rb 1897 2010-05-11 20:46:37Z ccaroon $
################################################################################
class AddDescriptionToTodos < ActiveRecord::Migration
    def self.up
        add_column :todos, :description,  :string, :limit => 1024, :null => true;
    end

    def self.down
        remove_column :todos, :description;
    end
end
