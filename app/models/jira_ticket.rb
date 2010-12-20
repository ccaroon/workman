################################################################################
# $Id: jira_ticket.rb 1300 2008-08-13 19:31:49Z ccaroon $
################################################################################
require 'net/http';
require 'rexml/document';
require 'uri';
require 'pp';

class JiraTicket
    JIRA_FILTER_ID = 10012;
    #JIRA_FILTER_ID = 10141;

    JIRA_HOST = 'jira.mcclatchyinteractive.com';
    JIRA_USER = 'ccaroon';
    JIRA_PASS = 'nu%24@11';
    JIRA_URL  = "http://#{JIRA_HOST}/sr/jira.issueviews:searchrequest-xml/#{JIRA_FILTER_ID}/SearchRequest-#{JIRA_FILTER_ID}.xml?tempMax=1000&os_username=#{JIRA_USER}&os_password=#{JIRA_PASS}";
    
    attr_accessor :key, :summary, :type, :priority, :status,
                  :link, :description, :sub_tickets;

    ############################################################################          
    def initialize
        @sub_tickets = [];
    end
    ############################################################################
    def self.link_from_num(ticket_num)
        link = "http://#{JIRA_HOST}/browse/#{ticket_num}";

        return (link);
    end
    ############################################################################
    def self.find
        tickets = {};

        uri = URI.parse(JIRA_URL);
        res = Net::HTTP.start(uri.host, uri.port) do |http|
            http.get("#{uri.path}?#{uri.query}");
        end

        if (res.code.to_i == 200)
            doc = REXML::Document.new(res.body);

            # Load all parent tickets
            doc.elements.each("rss/channel/item") do |item|
                # Skip Sub tasks, only want parents this iteration.
                next if item.elements['type'].text == 'Sub-task';
                t = self.from_item_element(item);
                tickets[t.key] = t;
            end

            # Load all sub-tickets
            doc.elements.each("rss/channel/item") do |item|
                # Skip parent tasks, only want sub-tasks
                next unless item.elements['type'].text == 'Sub-task';
                
                parent_key = item.elements['parent'].text;
                parent = tickets[parent_key];
                
                t = self.from_item_element(item);
                parent.sub_tickets << t;
            end
            
        else
            logger.error "Failed to retrieve Jira tickets. #{res.code}";
        end

        return (tickets.values);
    end
    ############################################################################
    def self.from_item_element(item)
        t = JiraTicket.new();

        item.each do |field|
            next unless field.is_a?(REXML::Element);
            if (t.respond_to?("#{field.name}="))
                t.send("#{field.name}=", field.text);
            end
        end

        return (t);
    end
    ############################################################################
    def color
        color = case self.status
        when 'Assigned': '#999900'
        when 'Hold': 'red'
        when 'Coding': 'green'
        when 'In Progress': 'green'
        when 'Code Review': 'blue'
        else 'black'
        end
        
        return (color);
    end

end
