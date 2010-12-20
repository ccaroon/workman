################################################################################
# $Id: entry_ui.rb 1320 2008-08-28 14:32:05Z ccaroon $
################################################################################
require 'bluecloth';

module EntryAdditions

    def pretty_task_date
        return self.task_date.strftime("%b %d, %Y");
    end
    
    def pretty_entry_date
        return self.entry_date.strftime("%b %d, %Y %I:%M%p");
    end
    
    def pretty_desc
        return (BlueCloth.new(self.description).to_html);
    end

    def ticket_link
        link = "";
        if (!self.ticket_num.empty?)
            link = "<a href='#{JiraTicket.link_from_num(self.ticket_num)}'>#{self.ticket_num}</a>";
        end

        return (link); 
    end
    
end

Entry.class_eval {include EntryAdditions}

class EntryUI < Streamlined::UI
    
    default_order_options :order => 'task_date desc, entry_date desc';
    
    list_columns :pretty_task_date, {:human_name => 'Task Date'},
                 :category,
                 :ticket_link, {:human_name => 'Ticket', :allow_html => true},
                 :subject, {:link_to => {:action => 'edit'}};

    edit_columns :task_date,
                 :ticket_num,
                 :category, {:enumeration => Entry::CATEGORIES},
                 :goal, {:options_for_select => :uncompleted_goals_for_select},
                 :subject,
                 :description, {:html_options => {:rows => 25, :cols => 80, :wrap => 'physical'}};

    show_columns :pretty_entry_date, {:human_name => 'Entry Date'},
                 :pretty_task_date,  {:human_name => 'Task Date'},
                 :ticket_link, {:human_name => 'Ticket', :allow_html => true},
                 :category,
                 :goal,
                 :subject,
                 :pretty_desc, {:human_name => 'Description', :allow_html => true};

end   
