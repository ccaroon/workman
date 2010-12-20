################################################################################
# $Id: application.rb 1324 2008-08-29 20:25:51Z ccaroon $
################################################################################
require 'user';
class ApplicationController < ActionController::Base
    before_filter :authorize;

    #NOTE: see Agile Web Devel...pg159
    def authorize
        user = User.find_by_id(session[:user_id]);
        if(user.nil?)
            redirect_to :controller => 'users', :action => 'login';
        end
    end
end
