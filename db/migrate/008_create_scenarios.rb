################################################################################
# $Id: 008_create_scenarios.rb 1144 2008-02-29 21:16:41Z ccaroon $
################################################################################
class CreateScenarios < ActiveRecord::Migration
    def self.up
        create_table :scenarios do |t|
            t.string :title, :null => false;
            t.text   :given, :null => false;
            t.string :when,  :null => false;
            t.text   :then,  :null => false;
            t.belongs_to :user_story, :null => false;
            t.timestamps
        end
    end

    def self.down
        drop_table :scenarios
    end
end
