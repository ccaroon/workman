################################################################################
# $Id: goal_ui.rb 1336 2008-09-04 13:49:44Z ccaroon $
################################################################################
module GoalAdditions
    ############################################################################
    def pretty_name
        n = self.name;
        
        if (self.completed != true)
            n = "<b>#{n}</b>";
        else
            n = "<s>#{n}</s>";
        end
        
        return (n);
    end
    ############################################################################
    def actions
        actions =<<EOF
<a href="/goals/show/#{self.id}"><img src="/images/themes/default/show.png" title="Show" border="0"></a>
<a href="/goals/edit/#{self.id}"><img src="/images/themes/default/edit.png" title="Edit" border="0"></a>
<a href="/goals/destroy/#{self.id}"><img src="/images/themes/default/delete.png" title="Delete" border="0"></a>
EOF

        unless (self.completed)
            actions += " | <a href='/goals/mark_complete/#{self.id}'><img title='Mark Complete' src='/images/themes/default/checkmark.png' border='0'></a>";
            actions += "<a href='/goals/new_obstacle?id=#{self.id}'><img src='/images/themes/default/warning.png' title='New Obstacle' border='0'></a>";
        end

        return (actions);
    end
    ############################################################################
    def pretty_obstacles
        html = "";
        self.outstanding_obstacles.each do |o|
            html += "<a href='/obstacles/mark_complete/#{o.id}'><img align='absmiddle' src='/images/themes/default/checkmark.png' border='0' title='Completed'></a><a href='/obstacles/show/#{o.id}'>#{o.title}</a><br>";
        end
        
        return (html);
    end
end
################################################################################
Goal.class_eval {include GoalAdditions}
################################################################################
module GoalWrappers
    PERCENT = Proc.new {|h| "#{h}"};
end
################################################################################
class GoalUI < Streamlined::UI
    
    default_order_options :order => 'completed, priority, completed_on desc';
    
    user_columns :priority,         {:enumeration => Goal::PRIORITIES},
                 :percent_complete, {:human_name => 'Percent',
                                     :enumeration => Goal::PERCENT,
                                     :wrapper => GoalWrappers::PERCENT},
                 :pretty_name,      {:human_name => 'Name',
                                     :allow_html => true},
                 :description,
                 :pretty_obstacles, {:human_name => 'Obstacles',
                                     :allow_html => true},
                 :actions, {:human_name => "", :allow_html => true};
             
    show_columns :priority,         {:enumeration => Goal::PRIORITIES},
                 :percent_complete, {:human_name => 'Percent',
                                     :enumeration => Goal::PERCENT,
                                     :wrapper => GoalWrappers::PERCENT},
                 :pretty_name,      {:human_name => 'Name',
                                     :allow_html => true},
                 :description,
                 :pretty_obstacles, {:human_name => 'Obstacles',
                                     :allow_html => true};

    edit_columns :priority,         {:enumeration => Goal::PRIORITIES},
                 :percent_complete, {:human_name => 'Percent',
                                     :enumeration => Goal::PERCENT,
                                     :wrapper => GoalWrappers::PERCENT},
                 :name,
                 :description;

#    quick_edit_button false;
#    quick_delete_button false;
#    quick_show_button false;

    table_row_buttons false;

end
