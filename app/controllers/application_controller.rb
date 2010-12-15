################################################################################
# $Id: application_controller.rb 1905 2010-05-17 14:12:54Z ccaroon $
################################################################################
require 'user';

class ApplicationController < ActionController::Base

    before_filter :authorize;

    #NOTE: see Agile Web Devel...pg159
    def authorize
        
        if user = authenticate_with_http_basic{ |u,p| User.authenticate(u,p); }
        else
            user = User.find_by_id(session[:user_id]);
        end

        if(user.nil?)
            redirect_to :controller => 'users', :action => 'login', :id => '-';
        else
            User.user = user;
            user.update_email_config();
        end
    end
end
