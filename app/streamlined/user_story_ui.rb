################################################################################
# $Id: user_story_ui.rb 1159 2008-03-10 16:40:31Z ccaroon $
################################################################################
module UserStoryAdditions
    
#    def should_display_column_in_context?(col=nil, context=nil)
#        return (true);
#    end

    def scenario_actions
        return <<EOF;
<a href="/scenarios/new"><img src="/images/streamlined/add_16.png" border="0" title="Add Scenario"></a>
EOF
    end
    
    def scenario_list
        scenarios = [];
        self.scenarios.each do |s|
            scenarios << "<li><a href='/scenarios/show/#{s.id}'>#{s.title}</a>";
        end
        
        return scenarios.join("<br>");
    end

    def jira_ticket_link
        return <<EOF;
<a href="http://jira.mcclatchyinteractive.com/browse/#{self.jira_ticket}">#{self.jira_ticket}</a>
EOF
    end

end
UserStory.class_eval { include UserStoryAdditions }
################################################################################
Streamlined.ui_for(UserStory) do
    
    default_order_options :order => 'priority';
    
    user_columns :user_story_category, {:human_name => 'Category'},
                 :title, {:human_name => 'Story', :html_options => {:size => 80}, :link_to => {:action => 'view'}},
                 :priority, {:html_options => {:size => 3}},
                 :estimate, {:html_options => {:size => 3}},
                 :role,    {:human_name => 'As A',    :html_options => {:size => 40}},
                 :feature, {:human_name => 'I Want',  :html_options => {:size => 80}},
                 :benefit, {:human_name => 'So That', :html_options => {:size => 80}},
                 :jira_ticket,
                 :scenario_list, {:human_name => 'Scenarios', :allow_html => true}

    list_columns :user_story_category, {:human_name => 'Category'},
                 :title, {:link_to => {:action => 'view'}},
                 :priority,
                 :estimate,
                 :jira_ticket_link, {:human_name => 'Jira Ticket', :allow_html => true},
                 :scenario_actions, {:allow_html => true}

end   
