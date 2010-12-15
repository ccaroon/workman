################################################################################
# $Id: 20090211174753_create_lists.rb 1413 2009-02-11 19:38:41Z ccaroon $
################################################################################
class CreateLists < ActiveRecord::Migration
    def self.up
        create_table :lists do |t|
            t.string :name, :null => false;
        end
    end

    def self.down
        drop_table :lists
    end
end
