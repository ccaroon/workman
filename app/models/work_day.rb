################################################################################
# $Id: work_day.rb 2181 2010-11-01 20:31:51Z ccaroon $
################################################################################
require 'date';

DEFAULT_IN_TIME  = '09:00';
DEFAULT_OUT_TIME = '17:00';

class WorkDay < ActiveRecord::Base

    ############################################################################
    def self.generate_week(date)
        day = monday_for(date);
        
        (1..5).each do
            count = WorkDay.count(:all, :conditions => "work_date = '#{day}'");
            
            if (count == 0)
                wday = WorkDay.new(:work_date => day, :in => DEFAULT_IN_TIME,
                                   :out => DEFAULT_OUT_TIME, :note => nil);
                wday.save!();
            end

            day += 1;
        end
    end
    ############################################################################
    def self.find_week(date = Date.today)
        mon = self.monday_for(date);
        fri = self.friday_for(date);
        range = (mon..fri).to_s(:db);
        
        days = self.find(:all,
            :conditions => "work_date #{range}",
            :order      => 'work_date, work_days.in');

        return (days);
    end
    ############################################################################
    def is_today?
        is_today = false;
        
        # FIXME: a better way to do this?
        if (self.work_date.strftime("%Y%m%d") == Time.now().strftime("%Y%m%d"))
            is_today = true;
        end
        
        return (is_today);
    end
    ############################################################################
    def self.today
        today = Date.today();
        return (today)
    end
    ############################################################################
#    private
    def self.monday_for(date = Date.today)
        monday = date;
        while (monday.wday != 1)
            monday = monday + 1 if monday.wday < 1;
            monday = monday - 1 if monday.wday > 1;
        end

        return (monday);
    end
    ############################################################################
    def self.friday_for(date = Date.today)
        fri = date;
        while (fri.wday != 5)
            fri = fri + 1 if fri.wday < 5;
            fri = fri - 1 if fri.wday > 5;
        end

        return (fri);
    end
    ############################################################################
    def total_hours
        return (self.out.to_f() - self.in.to_f()) / 3600.0;
    end

end
