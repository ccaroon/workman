################################################################################
# $Id: todo_ui.rb 1350 2008-10-06 16:41:48Z ccaroon $
################################################################################
module TodoAdditions
    ############################################################################
    def title
        t = super;
        

        if (self.completed != true)
            if (!self.due_on.nil?)
                if (self.due_on <= DateTime.now())
                    t = "<font color='red'><b>#{t}</b></font>";
                elsif (self.due_on > DateTime.now() && self.due_on <= DateTime.now()+7)
                    t = "<font color='orange'><b>#{t}</b></font>";
                end
            else
                t = "<b>#{t}</b>";
            end
        else
            t = "<s>#{t}</s>";
        end
        
        return (t);
    end
    ############################################################################
    def due_date
        date = nil;

        if (!self.due_on.nil?)
            date = self.due_on.strftime("%b %d, %Y");
        end

        return (date);
    end
    ############################################################################
    def completed_date
        return (self.completed_on.nil? ? 'Pending' : self.completed_on.strftime("%b %d, %Y %I:%M%p"));
    end
    ############################################################################
    def actions
        
        actions =<<EOF
<a href="/todos/show/#{self.id}"><img src="/images/themes/default/show.png" title="Show" border="0"></a>
<a href="/todos/edit/#{self.id}"><img src="/images/themes/default/edit.png" title="Edit" border="0"></a>
<a href="/todos/destroy/#{self.id}"><img src="/images/themes/default/delete.png" title="Delete" border="0"></a>
EOF
        unless (self.completed)
            actions += "<a href='/todos/mark_complete/#{self.id}'><img alt='Complete Todo' title='Mark Complete' src='/images/themes/default/checkmark.png' border='0'></a>";
        end

        return (actions);
    end
end
################################################################################
Todo.class_eval {include TodoAdditions}
################################################################################
class TodoUI < Streamlined::UI

    default_order_options :order => 'completed, completed_on desc, priority';
    
    user_columns :priority, {:enumeration => Todo::PRIORITIES},
                 :title, {:allow_html => true},
                 :completed_date,
                 :due_date,
                 :actions, {:human_name => "", :allow_html => true};
             
    show_columns :priority, {:enumeration => Todo::PRIORITIES},
                 :title, {:allow_html => true},
                 :due_date,
                 :completed_date;

    edit_columns :completed, {:check_box => true},
                 :priority, {:enumeration => Todo::PRIORITIES},
                 :due_on, {:update_only => true},
                 :title;

    table_row_buttons false;
end
