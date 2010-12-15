################################################################################
# $Id: 20090529142551_add_smtp_config_to_users.rb 1521 2009-05-29 17:26:24Z ccaroon $
################################################################################
class AddSmtpConfigToUsers < ActiveRecord::Migration
    def self.up
        add_column :users, :email_type, :string, :null => false, :default => 'smtp';
        add_column :users, :smtp_host,  :string, :null => true;
        add_column :users, :smtp_user,  :string, :null => true;
        add_column :users, :smtp_pass,  :string, :null => true;
        add_column :users, :smtp_auth,  :string, :null => true;
    end

    def self.down
        remove_column :users, :email_type;
        remove_column :users, :smtp_host;
        remove_column :users, :smtp_user;
        remove_column :users, :smtp_pass;
        remove_column :users, :smtp_auth;
    end
end
