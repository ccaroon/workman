################################################################################
# $Id: 009_create_user_stories.rb 1144 2008-02-29 21:16:41Z ccaroon $
################################################################################
class CreateUserStories < ActiveRecord::Migration
    def self.up
        create_table :user_stories do |t|
            t.string  :title,       :null => false;
            t.integer :priority,    :null => false;
            t.integer :estimate,    :null => false;
            t.string  :role,        :null => false;
            t.string  :feature,     :null => false;
            t.string  :benefit,     :null => false;
            t.string  :jira_ticket, :null => true, :default => nil;
            t.belongs_to :user_story_category, :null => false;
            t.timestamps
        end
    end

    def self.down
        drop_table :user_stories
    end
end
