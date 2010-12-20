################################################################################
# $Id: scenarios_controller.rb 1159 2008-03-10 16:40:31Z ccaroon $
################################################################################
class ScenariosController < ApplicationController
    layout 'streamlined';
    acts_as_streamlined;
    
    ############################################################################
    def index
        
        scenarios = nil;
        if (!params[:user_story].nil? and !params[:user_story].empty?)
            user_story = UserStory.find(params[:user_story]);
            scenarios = user_story.scenarios;
        else
            scenarios = Scenario.find(:all);
        end
        
        
        self.crud_context = :list;

        @streamlined_items = scenarios;
        @streamlined_item_pages = [];
        
        render :action => "list";
    end
    ############################################################################
#    def list
#        render :action => 'index';
#    end
end
