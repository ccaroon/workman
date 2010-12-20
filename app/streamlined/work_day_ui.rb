################################################################################
# $Id: work_day_ui.rb 1333 2008-09-03 14:14:58Z ccaroon $
################################################################################
module WorkDayAdditions
    ############################################################################
    def pretty_work_date
        date_str = self.work_date.strftime("%A (%b %d, %Y)");
        if (self.is_today?)
            date_str = "<b>#{date_str}</b>";
        end
        return (date_str);
    end
    ############################################################################
    def pretty_in
        return pretty_time(self.in);
    end
    ############################################################################
    def pretty_out
        return pretty_time(self.out);
    end
    ############################################################################
    def pretty_time(time)
        return time.strftime("%I:%M%p");
    end
    ############################################################################
    def day_type
        dtype = "Regular Day";
        
        if (self.is_holiday)
            dtype = "Holiday";
        elsif (self.is_vacation)
            dtype = "Vacation";
        elsif (self.is_sick_day)
            dtype = "Sick Day"
        end
        
        actions = self.actions();
        dtype = dtype + " (#{actions})";
        
        return (dtype);
    end
    ############################################################################
    def actions
        actions =<<EOF
<a href='/work_days/set_regular/#{self.id}'>R</a>
<a href='/work_days/set_holiday/#{self.id}'>H</a>
<a href='/work_days/set_vacation/#{self.id}'>V</a>
<a href='/work_days/set_sick_day/#{self.id}'>S</a>
EOF

        return (actions);
    end

end
################################################################################
WorkDay.class_eval {include WorkDayAdditions}
################################################################################
class WorkDayUI < Streamlined::UI

    default_order_options :order => 'work_date, in';

    user_columns :work_date,
                 :pretty_in, {:human_name => 'In'},
                 :pretty_out, {:human_name => 'Out'},
                 :note, {:allow_html => true},
                 :is_holiday,
                 :is_vacation,
                 :is_sick_day;

    edit_columns :work_date,
                 :in,
                 :out,
                 :note, {:allow_html => true},
                 :is_holiday,
                 :is_vacation,
                 :is_sick_day;
                 
             
    list_columns :pretty_work_date, {:human_name => 'Date', :allow_html => true},
                 :pretty_in, {:human_name => 'In'},
                 :pretty_out, {:human_name => 'Out'},
                 :day_type, {:allow_html => true},
                 :note, {:allow_html => true};
end   
