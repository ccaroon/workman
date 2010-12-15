################################################################################
# $Id: 20101213193842_add_email_address_to_users.rb 2235 2010-12-13 19:54:42Z ccaroon $
################################################################################
class AddEmailAddressToUsers < ActiveRecord::Migration
    def self.up
        add_column :users, :email, :string, :null => false, :default => '';
    end

    def self.down
        remove_column :users, :email;
    end
end
