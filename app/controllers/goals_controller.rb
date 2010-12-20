################################################################################
# $Id: goals_controller.rb 1336 2008-09-04 13:49:44Z ccaroon $
################################################################################
class GoalsController < ApplicationController

    layout 'streamlined';
    acts_as_streamlined;
    
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

        redirect_to :action => 'list';
    end
end
