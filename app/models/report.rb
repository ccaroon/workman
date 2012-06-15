################################################################################
# $Id: report.rb 1724 2009-12-11 21:35:34Z ccaroon $
################################################################################
class Report

    attr_accessor :start_date, :end_date, :complete_goals, :incomplete_goals,
                  :work_days, :entries, :type;
    ############################################################################
    def initialize(type, start_date, end_date = nil)
        if (!start_date.nil? && !end_date.nil?)
            self.start_date = start_date;
            self.end_date   = end_date;
        else
            dates = Report.compute_date_range(start_date);
            self.start_date = dates[0];
            self.end_date   = dates[1];
        end

        days = WorkDay.find_week(start_date);

        self.type      = type;
        self.work_days = days;
    end
    ############################################################################
    def date_range
        date_range = (start_date..end_date).to_s(:db);
        return(date_range);
    end
    ############################################################################
    def run(params = {})

        self.complete_goals = Goal.find(:all,
            :conditions => "completed = 1 and completed_on #{date_range}",
            :order => 'priority');
        self.incomplete_goals = Goal.find(:all,
            :conditions => "completed = 0",
            :order => 'priority,percent_complete');

        case self.type
        when :by_category then
            entries_by_category();
        when :by_day then
            entries_by_day();
        when :summary then
            entries_for_summary(params);
        when :extended_summary then
            entries_for_summary(params);
        end
    end
    ############################################################################
    private
    ############################################################################
    def self.compute_date_range(date)
        wday = date.wday;

        sun = date - wday;
        sat = date + (6 - wday);

        return ([sun,sat]);
    end
    ############################################################################
    def entries_by_category
        entries_map = {};
        Entry::CATEGORIES.each do |cat|
            entries_map[cat] =
                Entry.find(:all,
                           :conditions => "task_date #{self.date_range} and category = '#{cat}'",
                           :order => "task_date, entry_date");
        end

        self.entries = entries_map;
    end
    ############################################################################
    def entries_by_day

        entry_list = Entry.find(:all,
                                :conditions => "task_date #{self.date_range}",
                                :order => "task_date, entry_date");

        self.entries = entry_list;
    end
    ############################################################################
    def entries_for_summary(params)
        
        cat_exclude_cond = "(1 ";
        if (!params[:exclude_categories].nil?)
            params[:exclude_categories].each do |cat|
                cat_exclude_cond << " and category != '#{cat}' ";
            end
        end

        cat_exclude_cond << ")";
        
        entry_list = Entry.find(:all,
            :conditions => "task_date #{self.date_range} and #{cat_exclude_cond}",
            :order => "task_date, entry_date");

        # Filter by subject. Only want to show each entry by subject once.
        entry_summary = {};
        entry_list.each do |entry|
            if (entry_summary[entry.subject].nil?)
                entry_summary[entry.subject] = {
                    :date => entry.task_date,
                    :ticket => entry.ticket_num,
                    :subject => entry.subject,
                    :description => [entry.description]
                };
            else
                entry_summary[entry.subject][:description] << entry.description;
            end
        end

        self.entries = entry_summary.values.sort {|a,b| a[:date] <=> b[:date]};
    end
    ############################################################################
end
