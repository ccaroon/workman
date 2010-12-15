################################################################################
# $Id: goals_controller.rb 1370 2008-11-18 21:57:09Z ccaroon $
################################################################################
class GoalsController < ApplicationController
    ############################################################################
    def index

        conditions = nil;
        unless (params[:filter_text].nil? || params[:filter_text].empty?)
            conditions = "name regexp '#{params[:filter_text]}' or description regexp '#{params[:filter_text]}'";
        end

#        @goals = Goal.find(:all,
#            :conditions => conditions,
#            :order => 'completed, priority, completed_on desc');
        @goals = Goal.paginate(:page => params[:page],
            :conditions => conditions,
            :order => 'completed, priority, completed_on desc');

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @goals }
        end
    end
    ############################################################################
    def show
        @goal = Goal.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @goal }
        end
    end
    ############################################################################
    def new
        @goal = Goal.new

        respond_to do |format|
            format.html { render :template => 'goals/new_edit' }
            format.xml  { render :xml => @goal }
        end
    end
    ############################################################################
    def edit
        @goal = Goal.find(params[:id]);

        render :template => 'goals/new_edit';
    end
    ############################################################################
    def create
        @goal = Goal.new(params[:goal])

        respond_to do |format|
            if @goal.save
                flash[:notice] = 'Goal was successfully created.'
                format.html { redirect_to(@goal) }
                format.xml  { render :xml => @goal, :status => :created, :location => @goal }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def update
        @goal = Goal.find(params[:id])

        respond_to do |format|
            if @goal.update_attributes(params[:goal])
                flash[:notice] = 'Goal was successfully updated.'
                format.html { redirect_to(@goal) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def destroy
        @goal = Goal.find(params[:id])
        @goal.destroy

        respond_to do |format|
            format.html { redirect_to(goals_url) }
            format.xml  { head :ok }
        end
    end
    ############################################################################
    def new_obstacle

        obstacle = Obstacle.new(
            :title       => 'New Obstacle',
            :goal_id     => params[:id],
            :is_overcome => false
        );

        obstacle.save!;

        redirect_to :controller => 'obstacles', :action => 'edit', :id => obstacle;
    end
    ############################################################################
    def mark_complete
        @goal = Goal.find(params[:id]);

        @goal.completed = true;
        @goal.percent_complete = 100;
        @goal.completed_on = Time.now();

        if (@goal.save())
            flash[:notice] = 'Goal was successfully marked complete.'
        else
            flash[:notice] = 'ERROR: Goal was NOT marked complete.'
        end

        @goal.outstanding_obstacles.each do |o|
            o.is_overcome = true;
            o.save!;
        end

        redirect_to :back;
    end
end
