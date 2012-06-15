class RemoveUserStoriesAndScenarios < ActiveRecord::Migration
  def up
    drop_table :scenarios;
    drop_table :user_stories;
    drop_table :user_story_categories;    
  end

  def down
  end
end
