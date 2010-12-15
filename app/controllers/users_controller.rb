################################################################################
# $Id: users_controller.rb 1521 2009-05-29 17:26:24Z ccaroon $
################################################################################
class UsersController < ApplicationController

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

        if (params[:user_name] && params[:password])
            user = User.authenticate(params[:user_name], params[:password]);

            if (!user.nil?)
                session[:user_id] = user.id;
                redirect_to :controller => 'main', :action => 'home';
            else
                @message = "Login Failed!";
                render; # login.html.erb
            end
        else
            render; # login.html.erb
        end

    end
    ############################################################################
    def logout
        [:user_id].each do |var|
            session[var] = nil;
        end

        User.user = nil;

        render :action => :login;
    end
    ############################################################################
    def update

        user = User.user; #User.find(params[:id])

        respond_to do |format|
            if user.update_attributes(params[:user])
                flash[:notice] = 'User was successfully updated.'
                user.update_email_config();
                format.html { redirect_to(:controller => 'main', :action => 'home') }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => user.errors, :status => :unprocessable_entity }
            end
        end
    end
end
