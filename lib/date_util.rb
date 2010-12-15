################################################################################
# $Id: date_util.rb 1362 2008-11-14 16:22:06Z ccaroon $
################################################################################
class DateUtil

    def self.params_date_to_time(params, obj_name, obj_attr)
        
        date = nil;
        unless (params[obj_name][obj_attr]['month'].empty? ||
            params[obj_name][obj_attr]['day'].empty?       ||
            params[obj_name][obj_attr]['year'].empty?)
            date = Time.mktime(
                params[obj_name][obj_attr]['year'],
                params[obj_name][obj_attr]['month'],
                params[obj_name][obj_attr]['day']);
        end

        return(date);
    end

end
