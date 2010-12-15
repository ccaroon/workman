################################################################################
# $Id: 20080829183306_create_users_table.rb 1333 2008-09-03 14:14:58Z ccaroon $
################################################################################
class CreateUsersTable < ActiveRecord::Migration
    def self.up
        create_table :users do |t|
            t.string     :name,      :length => 64, :null => false;
            t.string     :user_name, :length => 32, :null => false;
            t.string     :password,                 :null => false;
            t.references :pref,                     :null => false;
        end
    end

    def self.down
        drop_table :users;
    end
end
