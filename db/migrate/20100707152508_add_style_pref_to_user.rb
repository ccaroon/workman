################################################################################
# $Id: 20100707152508_add_style_pref_to_user.rb 1972 2010-07-07 16:35:00Z ccaroon $
################################################################################
class AddStylePrefToUser < ActiveRecord::Migration
    def self.up
        add_column :users, :style_main,     :string, :null => false, :default => 'default';
        add_column :users, :style_calendar, :string, :null => false, :default => 'system';
    end

    def self.down
        remove_column :users, :style_main;
        remove_column :users, :style_calendar;
    end
end
