################################################################################
# $Id: todos_helper.rb 1897 2010-05-11 20:46:37Z ccaroon $
################################################################################
require 'bluecloth';

module TodosHelper

    PRIORITY_IMAGE_MAP = {
        1 => 'circle_red.png',
        2 => 'circle_orange.png',
        3 => 'circle_yellow.png',
    };

    def display_todo(attr, opts = {})
        value = nil;

        case attr
        when :title
            value = todo_title_for_display(@todo);
        when :description
            unless (@todo.description.nil?)
                value = (BlueCloth.new(@todo.description).to_html);
                if (opts[:flatten])
                    value.gsub!(/<p>/, '');
                    value.gsub!(/<\/p>/, '');
                end
            end
        when :due_date
            value = todo_due_date_for_display(@todo);
        when :completed_date
            value = todo_completed_date_for_display(@todo);
        when :priority
            value = todo_priority_for_display(@todo);
        else
            value = @todo.send(attr);
        end

        return(value);
    end
    ############################################################################
    def todo_title_for_display(todo)
        t = todo.title;

        if (todo.completed != true)
            if (!todo.due_on.nil?)
                if (todo.due_on <= DateTime.now())
                    t = "<font color='red'><b>#{t}</b></font>";
                elsif (todo.due_on > DateTime.now() && todo.due_on <= DateTime.now()+7)
                    t = "<font color='orange'><b>#{t}</b></font>";
                end
            end
        else
            t = "<s>#{t}</s>";
        end
        
        return (t);
    end
    ############################################################################
    def todo_due_date_for_display(todo)
        date = nil;

        if (!todo.due_on.nil?)
            date = todo.due_on.strftime("%b %d, %Y");
        end

        return (date);
    end
    ############################################################################
    def todo_completed_date_for_display(todo)
        return (todo.completed_on.nil? ? 'Pending' : todo.completed_on.strftime("%b %d, %Y %I:%M%p"));
    end
    ############################################################################
    def todo_priority_for_display(todo)
        image = (todo.priority > 3) ? 'circle_blue.png' : PRIORITY_IMAGE_MAP[todo.priority];
        link_to image_tag("themes/default/#{image}", {:title=>'Mark Complete', :border=>0}), :controller => 'todos', :action => 'mark_complete', :id => todo.id;
    end

end
