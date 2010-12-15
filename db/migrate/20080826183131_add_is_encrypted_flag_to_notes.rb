################################################################################
# $Id: 20080826183131_add_is_encrypted_flag_to_notes.rb 1318 2008-08-26 20:39:20Z ccaroon $
################################################################################
class AddIsEncryptedFlagToNotes < ActiveRecord::Migration
    def self.up
        add_column :notes, :is_encrypted, :boolean, :null => false, :default => false;
    end

    def self.down
        remove_column :notes, :is_encrypted;
    end
end
