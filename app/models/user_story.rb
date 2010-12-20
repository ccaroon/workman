################################################################################
# $Id: user_story.rb 1144 2008-02-29 21:16:41Z ccaroon $
################################################################################
class UserStory < ActiveRecord::Base
    
    belongs_to :user_story_category;
    has_many   :scenarios;
    
    validates_presence_of :user_story_category;
end
