################################################################################
# $Id: user_stories_controller.rb 1161 2008-03-10 18:06:12Z ccaroon $
################################################################################
class UserStoriesController < ApplicationController
    layout 'streamlined';
    acts_as_streamlined;
    
    ############################################################################
    def index
        stories = UserStory.find(:all, :include => [:user_story_category],
                                 :order => "user_story_categories.name, user_stories.id");
                              
        @user_stories = {};
        stories.each do |s|
            @user_stories[s.user_story_category.name] = [] if 
                @user_stories[s.user_story_category.name].nil?
            @user_stories[s.user_story_category.name] << s; 
        end
    end
    ############################################################################
    def list
        render :action => "index";
    end
    ############################################################################
    def view
        @story = UserStory.find(params[:id]);
    end

end
