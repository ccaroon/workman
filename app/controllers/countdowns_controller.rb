################################################################################
# $Id: countdowns_controller.rb 1736 2009-12-17 18:58:35Z ccaroon $
################################################################################
class CountdownsController < ApplicationController
    ############################################################################
    def index
        @countdowns = Countdown.order('target_date').all;

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @countdowns }
        end
    end
    ############################################################################
    def show
        @countdown = Countdown.where(:id => params[:id]).first;

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @countdown }
        end
    end
    ############################################################################
    def new
        @countdown = Countdown.new(:target_date => Time.now());

        respond_to do |format|
            format.html {render :template => 'countdowns/new_edit'}
            format.xml  { render :xml => @countdown }
        end
    end
    ############################################################################
    def edit
        @countdown = Countdown.where(:id => params[:id]).first;

        render :template => 'countdowns/new_edit';
    end
    ############################################################################
    def create
        params[:countdown][:target_date] = parse_out_target_date(params);
        @countdown = Countdown.new(params[:countdown]);

        respond_to do |format|
            if @countdown.save
                flash[:notice] = 'Countdown was successfully created.'
                format.html { redirect_to(@countdown) }
                format.xml  { render :xml => @countdown, :status => :created, :location => @countdown }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @countdown.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def update
        params[:countdown][:target_date] = parse_out_target_date(params);
        @countdown = Countdown.where(:id => params[:id]).first;

        respond_to do |format|
            if @countdown.update_attributes(params[:countdown])
                flash[:notice] = 'Countdown was successfully updated.'
                format.html { redirect_to(@countdown) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @countdown.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def destroy
        @countdown = Countdown.where(:id => params[:id]).first;
        @countdown.destroy;

        respond_to do |format|
            format.html { redirect_to(countdowns_url) }
            format.xml  { head :ok }
        end
    end
    ############################################################################
    private
    ############################################################################
    def parse_out_target_date(params)
        date_str = params['countdown__target_date'];
        date_str << " #{params[:countdown]['target_date(4i)']}:";
        date_str << params[:countdown]['target_date(5i)'];

        # delete all values put in by/used by form.time_select() method
        params[:countdown].delete_if {|key,value| key =~ /^target_date\(\di\)$/};

        return (date_str);
    end
end
