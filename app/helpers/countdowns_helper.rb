################################################################################
# $Id: countdowns_helper.rb 1736 2009-12-17 18:58:35Z ccaroon $
################################################################################
module CountdownsHelper
    ############################################################################
    def countdown_to_html(countdown)
        left = countdown.time_left;
        
        fract =
        case
            when left.to_s =~ /\.25$/ then '&frac14;';
            when left.to_s =~ /\.50?$/ then '&frac12;';
            when left.to_s =~ /\.75$/ then '&frac34;';
            else '';
        end
    
        str = "<strong>#{number_with_delimiter(left.abs.to_i)}#{fract}</strong> #{countdown.display_units} ";
        str << ((left >= 0) ? 'Until' : 'Since');
        str << " <strong>#{countdown.title}</strong>";

        return(str);
    end
    ############################################################################
end
