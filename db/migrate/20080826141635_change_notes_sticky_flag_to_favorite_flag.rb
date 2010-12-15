################################################################################
# $Id: 20080826141635_change_notes_sticky_flag_to_favorite_flag.rb 1318 2008-08-26 20:39:20Z ccaroon $
################################################################################
class ChangeNotesStickyFlagToFavoriteFlag < ActiveRecord::Migration
    def self.up
        rename_column :notes, :is_sticky, :is_favorite;
        change_column :notes, :is_favorite, :boolean, :null => false, :default => false;
    end

    def self.down
        rename_column :notes, :is_favorite, :is_sticky;
        change_column :notes, :is_sticky, :boolean, :null => false, :default => false;
    end
end
