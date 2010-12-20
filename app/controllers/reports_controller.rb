################################################################################
# $Id: reports_controller.rb 1333 2008-09-03 14:14:58Z ccaroon $
################################################################################
require 'date';
require 'entry';
require 'bluecloth';

class ReportsController < ApplicationController

    ############################################################################
    def by_day
        load_report_data();

        @entries = Entry.find(:all, 
                              :conditions => "task_date #{@this_week_range}",
                              :order => "task_date, entry_date");

        render_report();
    end
    ############################################################################
    def by_category

        load_report_data();
       
        @entries_map = {};
        Entry::CATEGORIES.each do |cat|
            @entries_map[cat] = 
                Entry.find(:all, 
                           :conditions => "task_date #{@this_week_range} and category = '#{cat}'",
                           :order => "task_date, entry_date");
        end

        render_report();
    end
    
    private
    ############################################################################
    def compute_date_range(date)
        wday = date.wday;
        
        sun = date - wday;
        sat = date + (6 - wday);

        return ([sun,sat]);
    end
    ############################################################################
    def load_report_data
        date = params[:date].nil? ? Date.today : Date.strptime(params[:date], '%Y%m%d');

        @range = compute_date_range(date);
        @this_week_range = (@range[0]..@range[1]).to_s(:db);

        @comp_goals = Goal.find(:all, 
            :conditions => "completed = 1 and completed_on #{@this_week_range}",
            :order => 'priority');
        @incomp_goals = Goal.find(:all,
            :conditions => "completed = 0",
            :order => 'priority,percent_complete');

        @work_days = WorkDay.find_week(date);
    end
    ############################################################################
    def render_report
        report = BlueCloth.new(render_to_string(:layout => false));
        
        respond_to do |format|
            format.html {render :layout => false, :text => report.to_html}
            format.text {render :layout => false, :text => report.to_s}
        end
    end
end
