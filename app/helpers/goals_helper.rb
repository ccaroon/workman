################################################################################
# $Id: goals_helper.rb 2117 2010-09-07 15:37:01Z ccaroon $
################################################################################
require 'bluecloth';

module GoalsHelper

    ############################################################################
    def display_goal(goal, attr)
        value = nil;

        case attr
        when :name
            value = goal_name_for_display(goal);
        when :obstacles
            value = goal_obstacles_for_display(goal);
        when :description
            unless (goal.description.nil?)
                value = (BlueCloth.new(goal.description).to_html);
            end            
        else
            value = goal.send(attr);
        end

        return(value);
    end
    ############################################################################
    def goal_name_for_display(goal)
        n = goal.name;

        if (goal.completed == true)
            n = "<s>#{n}</s>";
        end

        return (n);
    end
    ############################################################################
    def goal_obstacles_for_display(goal)
        html = "";
        goal.outstanding_obstacles.each do |o|
            html += link_to image_tag("themes/default/checkmark.png", {:title => 'Completed', :border => 0, :align=>'absmiddle'}), :controller => 'obstacles', :action => 'mark_complete', :id => o;
            html += link_to o.title, :controller => 'obstacles', :action => 'show', :id => o;
            html += '<br>';
        end

        return (html);
    end

end
