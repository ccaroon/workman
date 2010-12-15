################################################################################
# $Id: scenarios_controller.rb 1374 2008-11-26 19:22:48Z ccaroon $
################################################################################
class ScenariosController < ApplicationController
    ############################################################################
#    def index
#        @scenarios = nil;
#        if (!params[:user_story].nil? and !params[:user_story].empty?)
#            user_story = UserStory.find(params[:user_story]);
#            @scenarios = user_story.scenarios;
#        else
#            @scenarios = Scenario.find(:all);
#        end
#
#        respond_to do |format|
#            format.html # index.html.erb
#            format.xml  { render :xml => @scenarios }
#        end
#    end
#    ############################################################################
#    def show
#        @scenario = Scenario.find(params[:id])
#
#        respond_to do |format|
#            format.html # show.html.erb
#            format.xml  { render :xml => @scenario }
#        end
#    end
#    ############################################################################
#    def new
#        @scenario = Scenario.new
#
#        respond_to do |format|
#            format.html { render :template => 'scenarios/new_edit'}
#            format.xml  { render :xml => @scenario }
#        end
#    end
#    ############################################################################
#    def edit
#        @scenario = Scenario.find(params[:id]);
#
#        render :template => 'scenarios/new_edit';
#    end
    ############################################################################
    def create
        @scenario = Scenario.new(params[:scenario])

        respond_to do |format|
            if @scenario.save
                flash[:notice] = 'Scenario was successfully created.'
                format.html { redirect_to :back }
                format.xml  { render :xml => @scenario, :status => :created, :location => @scenario }
            else
                format.html { redirect_to :back }
                format.xml  { render :xml => @scenario.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
#    def update
#        @scenario = Scenario.find(params[:id])
#
#        respond_to do |format|
#            if @scenario.update_attributes(params[:scenario])
#                flash[:notice] = 'Scenario was successfully updated.'
#                format.html { redirect_to(@scenario) }
#                format.xml  { head :ok }
#            else
#                format.html { render :action => "edit" }
#                format.xml  { render :xml => @scenario.errors, :status => :unprocessable_entity }
#            end
#        end
#    end
    ############################################################################
    def destroy
        @scenario = Scenario.find(params[:id])
        @scenario.destroy

        respond_to do |format|
            format.html { redirect_to :back }
            format.xml  { head :ok }
        end
    end
end
