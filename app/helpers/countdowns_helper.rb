################################################################################
# $Id: countdowns_helper.rb 1736 2009-12-17 18:58:35Z ccaroon $
################################################################################
module CountdownsHelper
    ############################################################################
    def countdown_to_html(countdown)
        left = countdown.time_left;

        str = "<strong>#{number_with_delimiter(left.abs)}</strong> #{countdown.display_units} ";
        str << ((left >= 0) ? 'Until' : 'Since');
        str << " <strong>#{countdown.title}</strong>";

        return(str);
    end
    
end
