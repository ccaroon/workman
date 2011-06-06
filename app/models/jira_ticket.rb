################################################################################
# $Id: jira_ticket.rb 2237 2010-12-14 15:21:30Z ccaroon $
################################################################################
require 'net/http';
require 'rexml/document';
require 'uri';
require 'pp';
require 'user';

class JiraTicket
    JIRA_URL = "http://_JIRA_HOST_/sr/jira.issueviews:searchrequest-xml/temp/SearchRequest.xml?jqlQuery=_JIRA_QUERY_&tempMax=1000&os_username=_JIRA_USER_&os_password=_JIRA_PASS_";
    attr_accessor :key, :summary, :type, :priority, :status,
                  :link, :description, :sub_tickets, :points,
                  :assignee, :fixVersion;

    SUB_TASK_TYPES = {'Sub-task' => 1, 'Spec Review' => 1, 'Bug found' => 1};
    ############################################################################          
    def initialize
        @sub_tickets = [];
    end
    ############################################################################
    def self.link_from_num(ticket_num)
        link = "http://#{User.user.jira_host}/browse/#{ticket_num}";

        return (link);
    end
    ############################################################################
    def self.find(query = nil)
        tickets = {};

        query = query.nil? ? "filter=#{User.user.jira_filter_id}" : query;
        query.gsub!(/\s+/,'+');

        url = JIRA_URL.dup;
        url.gsub!(/_JIRA_HOST_/, User.user.jira_host);
        url.gsub!(/_JIRA_USER_/, User.user.jira_username);
        url.gsub!(/_JIRA_PASS_/, User.user.jira_password);
        url.gsub!(/_JIRA_QUERY_/, query);

        uri = URI.parse(url);
        res = Net::HTTP.start(uri.host, uri.port) do |http|
            http.get("#{uri.path}?#{uri.query}");
        end

        if (res.code.to_i == 200)
            doc = REXML::Document.new(res.body);

            # Load all parent tickets
            doc.elements.each("rss/channel/item") do |item|
                # Skip Sub tasks, only want parents this iteration.
                next if self.is_sub_task?(item.elements['type'].text);
                t = self.from_item_element(item);
                tickets[t.key] = t;
            end

            # Load all sub-tickets
            doc.elements.each("rss/channel/item") do |item|
                # Skip parent tasks, only want sub-tasks
                next unless self.is_sub_task?(item.elements['type'].text);

                parent_key = item.elements['parent'].text;
                parent = tickets[parent_key];
                
                t = self.from_item_element(item);
                if (!parent.nil?)
                    parent.sub_tickets << t;
                else
                    tickets[t.key] = t;
                end
            end
        else
            raise "#{res.code}: #{res.body}";
        end

        return (tickets.values);
    end
    ############################################################################
    def self.from_item_element(item)
        t = JiraTicket.new();

        item.each do |field|
            next unless field.is_a?(REXML::Element);

            if (t.respond_to?("#{field.name}="))
                # If it's already set, make it into an array and/or push new
                # value onto existing array.
                if (!t.send("#{field.name}").nil?)
                    fld_val = t.send("#{field.name}");
                    unless (fld_val.is_a?(Array))
                        new_val = Array.new();
                        new_val.push(fld_val); # Add current val.
                        t.send("#{field.name}=", new_val);
                        fld_val =  new_val;
                    end
                    fld_val.push(field.text); # Add New val.
                else
                    t.send("#{field.name}=", field.text);
                end
            end
        end
        
        item.elements.each('customfields/customfield') do |cf|
            if (cf.elements['customfieldname'].text == 'Points')
                t.points = cf.elements['customfieldvalues/customfieldvalue'].text;
            end
        end

        return (t);
    end
    ############################################################################
    def self.is_sub_task?(type_name)
        return (SUB_TASK_TYPES[type_name]);
    end    
    ############################################################################
    def color
        color = case self.status
        when 'Design/Verify': '#999900'
        when 'Coding': 'green'
        when 'In Progress': 'green'
        when 'Hold': 'red'
        when 'Code Review': 'blue'
        when 'Ready for QA': 'purple'
        else 'black'
        end
        
        return (color);
    end

end
