################################################################################
# $Id: work_days_helper.rb 1575 2009-09-10 14:37:37Z ccaroon $
################################################################################
module WorkDaysHelper

    ############################################################################
    def display_work_day(attr)
        value = nil;

        case attr
        when :work_date
            value = work_day_work_date_for_display(@work_day);
        when :in
            value = work_day_time_for_display(@work_day.in);
        when :out
            value = work_day_time_for_display(@work_day.out);
        when :lunch
            value = work_day_lunch_for_display(@work_day.lunch);
        when :day_type
            value = work_day_day_type_for_display(@work_day);
        when :total_hours
            value = work_day_total_hours_for_display(@work_day);
        else
            value = @work_day.send(attr);
        end
        
        if (@work_day.is_today?)
            value = "<b>#{value}</b>";
        end

        return(value);
    end
    ############################################################################
    def work_day_work_date_for_display(day)
        date_str = day.work_date.strftime("%A (%b %d, %Y)");
        if (day.is_today?)
            date_str = "<b>#{date_str}</b>";
        end
        return (date_str);
    end
    ############################################################################
    def work_day_time_for_display(time)
        return time.strftime("%I:%M%p");
    end
    ############################################################################
    def work_day_lunch_for_display(time)
        return time.strftime("%H:%M");
    end
    ############################################################################
    def work_day_day_type_for_display(day)
        dtype = "Regular Day";

        if (day.is_holiday)
            dtype = "Holiday";
        elsif (day.is_vacation)
            dtype = "Vacation Day";
        elsif (day.is_sick_day)
            dtype = "Sick Day"
        end

        return (dtype);
    end
    ############################################################################
    def work_day_day_type_actions(day)
        actions =<<EOF
<a href='/work_days/set_regular/#{day.id}'>R</a>
<a href='/work_days/set_holiday/#{day.id}'>H</a>
<a href='/work_days/set_vacation/#{day.id}'>V</a>
<a href='/work_days/set_sick_day/#{day.id}'>S</a>
EOF

        return (actions);
    end
    ############################################################################
    def work_day_total_hours_for_display(day)
        value = sprintf("%0.2f", day.total_hours);
        return (value);
    end
end
