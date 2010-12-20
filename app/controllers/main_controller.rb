################################################################################
# $Id: main_controller.rb 1350 2008-10-06 16:41:48Z ccaroon $
################################################################################
class MainController < ApplicationController
    
    layout 'streamlined';
    acts_as_streamlined;

    ############################################################################
    def home
    
#        todo_range = Time.now() - (3 * 86400);
        @todos = Todo.find(:all, 
                           :order => 'completed, priority, created_on',
#                            :conditions => "completed_on is null or completed_on > '#{todo_range.to_s(:db)}'"
                            :conditions => "completed = 0");
                           
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
        
        wday = Time.now.wday;
        mon = Time.now() - ((wday - 0) * 86400);
        @entries = Entry.find(:all, :conditions => "task_date >= '#{mon.to_s(:db)}'", :order => 'task_date,entry_date');

        @tickets = [];
        begin
            @tickets = JiraTicket.find();
        rescue Exception => e
            logger.error "Failed to get Jira Tickets: #{e}";
        end

    end
end
