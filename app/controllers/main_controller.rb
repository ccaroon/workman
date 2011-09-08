################################################################################
# $Id: main_controller.rb 2237 2010-12-14 15:21:30Z ccaroon $
################################################################################
class MainController < ApplicationController

    helper :all;

    @@cache = {
            :tickets         => { :timeout => (2*60) },
            :release_tickets => { :timeout => (15*60) }
    };

    ############################################################################
    def home
        # todos with due dates
        todos1 = Todo.find(:all, 
                           :order => 'due_on, priority',
                           :conditions => "completed = 0 and due_on is not null and list_id is null");

        # todos without due dates
        todos2 = Todo.find(:all, 
                           :order => 'priority',
                           :conditions => "completed = 0 and due_on is null and list_id is null");
        @todos = todos1 + todos2;

        @goals = Goal.find(:all, 
                           :conditions => 'completed != 1', 
                           :order => 'priority');
                           
        @recent_notes = Note.find(:all,
                                  :conditions => "is_favorite = 0 and deleted_on is null",
                                  :order => 'created_on desc',
                                  :limit => 5);
                              
        @favorite_notes = Note.find(:all,
                                  :conditions => 'is_favorite = 1 and deleted_on is null',
                                  :order => 'created_on asc');
#                                  :limit => 0);

        @countdowns = Countdown.find(:all, 
            :conditions => 'on_homepage = 1',
            :order      => 'target_date');

        wday = Time.now.wday;
        mon = Time.now() - ((wday - 0) * 86400);
        @entries = Entry.find(:all, :conditions => "task_date >= '#{mon.to_s(:db)}'", :order => 'task_date,entry_date');

        begin
            # Default set of tickets, uses Jira Filter set in prefs.
            tix_cache = @@cache[:tickets];
            if (Time.now.to_i - tix_cache[:cached_time].to_i > tix_cache[:timeout])
                @tickets = JiraTicket.find();

                tix_cache[:cached_time] = Time.now();
                tix_cache[:tickets]     = @tickets;
            else
                @tickets = tix_cache[:tickets];
            end

            # 11224 == 'Current Release' filter
            rt_cache = @@cache[:release_tickets];
            if (Time.now.to_i - rt_cache[:cached_time].to_i > rt_cache[:timeout])
                @release_tickets = JiraTicket.find("filter=11224 AND assignee=#{User.user.jira_username}");
                @ready_points = 0;
                @total_points = 0;
                @release_tickets.each do |t|
                    @total_points = @total_points + t.points.to_i;
                    if (t.status =~ /(Ready for release|Closed|Rejected)/)
                        @ready_points = @ready_points + t.points.to_i;
                    end
                end

                rt_cache[:cached_time]     = Time.now();
                rt_cache[:release_tickets] = @release_tickets;
                rt_cache[:ready_points]    = @ready_points;
                rt_cache[:total_points]    = @total_points;
            else
                @release_tickets = rt_cache[:release_tickets];
                @ready_points    = rt_cache[:ready_points];
                @total_points    = rt_cache[:total_points];
            end

        @current_release_name = (@release_tickets.length != 0) ?
            @release_tickets[0].fixVersion[0] : '?????';

        rescue Exception => e
            @tickets = [];
            @release_tickets = [];
            logger.error "Failed to get Jira Tickets: #{e}";
        end

    end
end
