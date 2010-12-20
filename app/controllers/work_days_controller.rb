################################################################################
# $Id: work_days_controller.rb 1333 2008-09-03 14:14:58Z ccaroon $
################################################################################
class WorkDaysController < ApplicationController
    layout 'streamlined';
    acts_as_streamlined;
    ############################################################################
    def index
        self.crud_context = :list;

        date = params[:date].nil? ? Date.today : Date.strptime(params[:date], '%Y%m%d');
        
        @streamlined_items = WorkDay.find_week(date);
        @streamlined_item_pages = [];
        
        render :action => "list";
    end
    ############################################################################
    def generate_week
        date = params[:date].nil? ? Date.today : Date.strptime(params[:date], '%Y%m%d');
        WorkDay.generate_week(date);
        
#        render :action => 'list';
        return index();
    end
    ############################################################################
    def set_regular
        day = WorkDay.find(params[:id]);
        
        day.in = '9:00:00';
        day.out = '17:00:00';
        
        day.is_holiday  = false;
        day.is_vacation = false;
        day.is_sick_day = false;
        
        day.note = nil;
        
        day.save!();
        
        return index();        
    end
    ############################################################################
    def set_holiday
        set_day_type :holiday;
    end
    ############################################################################
    def set_vacation
        set_day_type :vacation;
    end
    ############################################################################
    def set_sick_day
        set_day_type :sick_day;
    end
    ############################################################################
    def set_day_type(dtype)
        day = WorkDay.find(params[:id]);
        
        day.in = 0;
        day.out = 0;
        
        day.is_holiday  = false;
        day.is_vacation = false;
        day.is_sick_day = false;

        day.send("is_#{dtype}=",true);
        
        day.note = dtype.to_s().capitalize!;
        
        day.save!();
        
        return index();
    end
    
end
