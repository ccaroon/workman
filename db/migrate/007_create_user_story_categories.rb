################################################################################
# $Id: 007_create_user_story_categories.rb 1144 2008-02-29 21:16:41Z ccaroon $
################################################################################
class CreateUserStoryCategories < ActiveRecord::Migration
    def self.up
        create_table :user_story_categories do |t|
            t.string :name, :limit => 32, :null => false;
            t.timestamps
        end
    end

    def self.down
        drop_table :user_story_categories
    end
end
