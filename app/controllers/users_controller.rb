################################################################################
# $Id: users_controller.rb 1334 2008-09-03 17:00:14Z ccaroon $
################################################################################
class UsersController < ApplicationController
    layout 'streamlined';
    acts_as_streamlined;

    before_filter :authorize, :except => :login;

    ############################################################################
    def login
        session[:user_id] = nil;

        if (User.count == 0)
            if (params[:user_name] && params[:password])
                user = User.new(:user_name => params[:user_name],
                    :password => params[:password],
                    :name => params[:user_name].humanize);
                user.save!;
            else
                @message = "Create Initial User";
                @button_text = "Create";
            end
        end

        user = User.authenticate(params[:user_name], params[:password]);
        if (!user.nil?)
            session[:user_id] = user.id;
            redirect_to :controller => 'main', :action => 'home';
        else
            render; # login.html.erb
        end
    end
    ############################################################################
    def logout
        [:user_id].each do |var|
            session[var]   = nil;
        end

        render :action => :login;
    end

end
