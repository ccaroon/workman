################################################################################
# $Id: 20080902165751_create_prefs.rb 1330 2008-09-02 18:19:06Z ccaroon $
################################################################################
class CreatePrefs < ActiveRecord::Migration
    def self.up
        create_table :prefs do |t|
            t.string :avatar, :null => false, :default => 'avatar1.png';
            t.string :theme,  :null => false, :default => 'default';
            t.timestamps
        end
    end

    def self.down
        drop_table :prefs
    end
end
