################################################################################
# $Id: 20081006153346_add_due_on_to_todos.rb 1350 2008-10-06 16:41:48Z ccaroon $
################################################################################
class AddDueOnToTodos < ActiveRecord::Migration
    def self.up
        add_column :todos, :due_on, :date;
    end

    def self.down
        remove_column :todos, :due_on;
    end
end
