################################################################################
# $Id: countdown.rb 1900 2010-05-12 14:53:49Z ccaroon $
################################################################################
class Countdown < ActiveRecord::Base
    UNIT_DAY    = 'day';
    UNIT_HOUR   = 'hour';
    UNIT_MINUTE = 'minute';
    UNIT_SECOND = 'second';

    UNITS =
    [
        UNIT_DAY,
        UNIT_HOUR,
        UNIT_MINUTE,
        UNIT_SECOND,
    ];
    ############################################################################
    def time_left
        now = Time.now();
        secs_diff = self.target_date - now;

        case self.units
        when UNIT_DAY
            time_left = secs_diff / 86400;
        when UNIT_HOUR
            time_left = secs_diff / 3600;
        when UNIT_MINUTE
            time_left = secs_diff / 60;
        when UNIT_SECOND
            time_left = secs_diff;
        end

        # Auto-adjust units
        if (self.units != UNIT_SECOND && time_left.abs < 1)
            u_index = UNITS.index(self.units) + 1;
            self.units = UNITS[u_index];
            time_left = self.time_left();
        else
            time_left = time_left.ceil;
        end

        return (time_left);
    end
    ############################################################################
    def display_units

        display_units = nil;

        if (self.time_left.abs != 1)
            display_units = self.units.capitalize.pluralize;
        else
            display_units = self.units.capitalize;
        end

        return (display_units);
    end
    ############################################################################
    def to_s
        left = self.time_left;

        str = "#{left.abs} #{display_units} ";
        str << ((left >= 0) ? 'Until' : 'Since');
        str << " #{title}";

        return(str);
    end
    ############################################################################
    def to_html
        left = self.time_left;

        str = "<strong>#{left.abs}</strong> #{display_units} ";
        str << ((left >= 0) ? 'Until' : 'Since');
        str << " <strong>#{title}</strong>";

        return(str);
    end
end
