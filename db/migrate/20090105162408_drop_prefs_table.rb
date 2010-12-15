################################################################################
# $Id: 20090105162408_drop_prefs_table.rb 1388 2009-01-05 17:44:29Z ccaroon $
################################################################################
class DropPrefsTable < ActiveRecord::Migration

    def self.up
        drop_table :prefs;
        remove_column :users, :pref_id;
    end

    def self.down
        CreatePrefs.up;
        add_column :users, :pref_id, :integer, :null => false;
    end

end
