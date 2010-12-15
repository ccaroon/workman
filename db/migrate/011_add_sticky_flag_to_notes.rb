################################################################################
# $Id: 011_add_sticky_flag_to_notes.rb 1265 2008-05-19 16:06:05Z ccaroon $
################################################################################
class AddStickyFlagToNotes < ActiveRecord::Migration
    def self.up
        add_column :notes, :is_sticky, :boolean, :null => false, :default => false;
    end

    def self.down
        remove_column :notes, :is_sticky;
    end
end
