################################################################################
# $Id: goals_controller.rb 1370 2008-11-18 21:57:09Z ccaroon $
################################################################################
class GoalsController < ApplicationController

    respond_to :html;

    ############################################################################
    def index

        conditions = nil;
        unless (params[:filter_text].nil? || params[:filter_text].empty?)
            conditions = "name regexp '#{params[:filter_text]}' or description regexp '#{params[:filter_text]}'";
        end

        @goals = Goal.paginate(:page => params[:page],
            :conditions => conditions,
            :order => 'completed, priority, completed_on desc');
    end
    ############################################################################
    def show
        @goal = Goal.find(params[:id])
    end
    ############################################################################
    def new
        @goal = Goal.new
    end
    ############################################################################
    def edit
        @goal = Goal.find(params[:id]);
    end
    ############################################################################
    def create
        @goal = Goal.new(params[:goal])

        respond_to do |format|
            if @goal.save
                flash[:notice] = 'Goal was successfully created.'
                format.html { redirect_to(@goal) }
            else
                format.html { render :action => "new" }
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
            else
                format.html { render :action => "edit" }
            end
        end
    end
    ############################################################################
    def destroy
        @goal = Goal.find(params[:id])
        @goal.destroy

        respond_to do |format|
            format.html { redirect_to(goals_url) }
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
