################################################################################
# $Id: countdown.rb 1900 2010-05-12 14:53:49Z ccaroon $
################################################################################
class Countdown < ActiveRecord::Base
    UNIT_YEAR   = 'year';
    UNIT_MONTH  = 'month';
    UNIT_WEEK   = 'week';
    UNIT_DAY    = 'day';
    UNIT_HOUR   = 'hour';
    UNIT_MINUTE = 'minute';
    UNIT_SECOND = 'second';

    UNITS =
    [
        UNIT_YEAR,
        UNIT_MONTH,
        UNIT_WEEK,
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
        when UNIT_YEAR
            time_left = secs_diff / (86400*365);
        when UNIT_MONTH
            time_left = secs_diff / (86400*30);
        when UNIT_WEEK
            time_left = secs_diff / (86400*7);
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
        else #Round to the nearest quarter unit
            #time_left = time_left.ceil;
            is_neg = (time_left < 0.0) ? true : false;

            base = time_left.abs.to_i;
            frac = time_left.abs - base;

            time_left =
            case
                when frac >= 0.00 && frac < 0.25: base + 0.00;
                when frac >= 0.25 && frac < 0.50: base + 0.25;
                when frac >= 0.50 && frac < 0.75: base + 0.50;
                when frac >= 0.75 && frac < 1.00: base + 0.75;
                #else base;
            end

            time_left = time_left * -1 if is_neg;
        end

        return (time_left);
    end
    ############################################################################
    def display_units

        display_units = nil;

        if (self.time_left.abs > 1.00)
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
end
