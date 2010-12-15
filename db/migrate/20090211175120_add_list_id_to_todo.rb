################################################################################
# $Id: 20090211175120_add_list_id_to_todo.rb 1413 2009-02-11 19:38:41Z ccaroon $
################################################################################
class AddListIdToTodo < ActiveRecord::Migration
    def self.up
        add_column :todos, :list_id, :integer, :null => true;
        # TODO: add reference to list.id
    end

    def self.down
        remove_column :todos, :list_id;
    end
end
