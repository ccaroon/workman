################################################################################
# $Id: 20081006150404_add_deleted_on_to_notes.rb 1350 2008-10-06 16:41:48Z ccaroon $
################################################################################
class AddDeletedOnToNotes < ActiveRecord::Migration
    def self.up
        add_column :notes, :deleted_on, :datetime;
    end

    def self.down
        remove_column :notes, :deleted_on;
    end
end
