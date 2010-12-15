################################################################################
# $Id: work_days_controller.rb 1539 2009-07-30 14:22:54Z ccaroon $
################################################################################
require 'work_day';

class WorkDaysController < ApplicationController
    ############################################################################
    def index
        date = params[:date].nil? ? Date.today : Date.strptime(params[:date], '%Y%m%d');
        @work_days = WorkDay.find_week(date);

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @work_days }
        end
    end
    ############################################################################
    def show
        @work_day = WorkDay.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @work_day }
        end
    end
    ############################################################################
    def new
        @work_day = WorkDay.new(:work_date => Time.now().strftime("%Y-%m-%d"),
                                :in        => WorkDay::DEFAULT_IN_TIME,
                                :out       => WorkDay::DEFAULT_OUT_TIME);

        respond_to do |format|
            format.html {render :template => 'work_days/new_edit'}
            format.xml  { render :xml => @work_day }
        end
    end
    ############################################################################
    def edit
        @work_day = WorkDay.find(params[:id]);

        render :template => 'work_days/new_edit';
    end
    ############################################################################
    def create
        params[:work_day][:work_date] = params['work_day_work_date'];
        @work_day = WorkDay.new(params[:work_day])

        respond_to do |format|
            if @work_day.save
                flash[:notice] = 'WorkDay was successfully created.'
                format.html { redirect_to(@work_day) }
                format.xml  { render :xml => @work_day, :status => :created, :location => @work_day }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @work_day.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def update
        params[:work_day][:work_date] = params['work_day_work_date'];
        @work_day = WorkDay.find(params[:id])

        respond_to do |format|
            if @work_day.update_attributes(params[:work_day])
                flash[:notice] = 'WorkDay was successfully updated.'
                format.html { redirect_to(@work_day) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @work_day.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def destroy
        @work_day = WorkDay.find(params[:id])
        @work_day.destroy

        respond_to do |format|
            format.html { redirect_to(work_days_url) }
            format.xml  { head :ok }
        end
    end
    ############################################################################
    def generate_week
        date = params[:date].nil? ? Date.today : Date.strptime(params[:date], '%Y%m%d');
        WorkDay.generate_week(date);

        redirect_to :back;
    end
    ############################################################################
    def set_regular
        day = WorkDay.find(params[:id]);

        day.in  = WorkDay::DEFAULT_IN_TIME;
        day.out = WorkDay::DEFAULT_OUT_TIME;

        day.is_holiday  = false;
        day.is_vacation = false;
        day.is_sick_day = false;

        day.note = nil;

        day.save!();

        redirect_to :back;
    end
    ############################################################################
    def set_holiday
        set_day_type :holiday;

        redirect_to :back;
    end
    ############################################################################
    def set_vacation
        set_day_type :vacation;

        redirect_to :back;
    end
    ############################################################################
    def set_sick_day
        set_day_type :sick_day;

        redirect_to :back;
    end
    ############################################################################
    def set_day_type(dtype)
        day = WorkDay.find(params[:id]);

        day.in = 0;
        day.out = 0;

        day.is_holiday  = false;
        day.is_vacation = false;
        day.is_sick_day = false;

        day.send("is_#{dtype}=",true);

        day.note = dtype.to_s().capitalize!;

        day.save!();
    end

end
