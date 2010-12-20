################################################################################
# $Id: scenario_ui.rb 1159 2008-03-10 16:40:31Z ccaroon $
################################################################################
module ScenarioAdditions

    def user_story_link
        return "<a href=\"/user_stories/view/#{self.user_story.id}\">#{self.user_story.title}</a>";
    end
    
end
Scenario.class_eval { include ScenarioAdditions }

Streamlined.ui_for(Scenario) do

    user_columns :user_story_link, {:human_name => 'User Story', :allow_html => true},
                 :title, {:human_name => 'Scenario'},
                 :given,
                 :when,
                 :then
             
    edit_columns :user_story,
                 :title, {:human_name => 'Scenario', :html_options => {:size => 80}},
                 :given, {:html_options => {:rows => 5, :cols => 80, :wrap => 'physical'}},
                 :when, {:html_options => {:size => 80}},
                 :then, {:html_options => {:rows => 5, :cols => 80, :wrap => 'physical'}}

    list_columns :user_story_link, {:human_name => 'User Story', :allow_html => true},
                 :title
end
