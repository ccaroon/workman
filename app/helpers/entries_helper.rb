################################################################################
# $Id: entries_helper.rb 1368 2008-11-18 15:17:00Z ccaroon $
################################################################################
require 'bluecloth';

module EntriesHelper
    ############################################################################
    def display_entry(e, attr)
        value = nil;

        case attr
        when :entry_date
            value = e.entry_date.strftime("%b %d, %Y %I:%M%p");
        when :task_date
            value = e.task_date.strftime("%b %d, %Y");
        when :description
            value = (BlueCloth.new(e.description).to_html);
        when :ticket
            value = entry_ticket_link(e);
        else
            value = e.send(attr);
        end

        return(value);
    end
    ############################################################################
    def entry_ticket_link(entry)
        link = nil;
        unless(entry.ticket_num.nil? || entry.ticket_num.empty?)
            link = "<a href='#{JiraTicket.link_from_num(entry.ticket_num)}'>#{entry.ticket_num}</a>";
        end

        return (link);
    end

end
