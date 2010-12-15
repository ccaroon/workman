################################################################################
# $Id: 010_create_obstacles_table.rb 1255 2008-05-14 18:20:26Z ccaroon $
################################################################################
class CreateObstaclesTable < ActiveRecord::Migration
    def self.up
        create_table :obstacles do |t|
            t.string  :title,        :null => false;
            t.text    :description,  :null => true;
            t.boolean :is_overcome,  :null => false;
            t.belongs_to :goal, :null => false;
            t.timestamps
        end
    end

    def self.down
        drop_table :obstacles
    end
end
