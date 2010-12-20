################################################################################
# $Id: user_story_category_ui.rb 1144 2008-02-29 21:16:41Z ccaroon $
################################################################################
module UserStoryCategoryAdditions

end
UserStoryCategory.class_eval { include UserStoryCategoryAdditions }

Streamlined.ui_for(UserStoryCategory) do

end   
