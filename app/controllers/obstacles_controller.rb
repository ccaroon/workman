################################################################################
# $Id: obstacles_controller.rb 1363 2008-11-14 19:06:05Z ccaroon $
################################################################################
class ObstaclesController < ApplicationController
  
    respond_to :html;
    ############################################################################
    def index
        @obstacles = Obstacle.find(:all);
    end
    ############################################################################
    def show
        @obstacle = Obstacle.find(params[:id]);
    end
    ############################################################################
    def new
        @obstacle = Obstacle.new;
    end
    ############################################################################
    def edit
        @obstacle = Obstacle.find(params[:id]);
    end
    ############################################################################
    def create
        @obstacle = Obstacle.new(params[:obstacle])

        respond_to do |format|
            if @obstacle.save
                flash[:notice] = 'Obstacle was successfully created.'
                format.html { redirect_to(@obstacle) }
            else
                format.html { render :action => "new" }
            end
        end
    end
    ############################################################################
    def update
        @obstacle = Obstacle.find(params[:id])

        respond_to do |format|
            if @obstacle.update_attributes(params[:obstacle])
                flash[:notice] = 'Obstacle was successfully updated.'
                format.html { redirect_to(@obstacle) }
            else
                format.html { render :action => "edit" }
            end
        end
    end
    ############################################################################
    def destroy
        @obstacle = Obstacle.find(params[:id])
        @obstacle.destroy

        respond_to do |format|
            format.html { redirect_to(obstacles_url) }
        end
    end
    ############################################################################
    def mark_complete
        ob = Obstacle.find(params[:id]);

        ob.is_overcome = true;

        if (ob.save())
            flash[:notice] = 'Obstacle was successfully marked complete.'
        else
            flash[:notice] = 'ERROR: Obstacle was NOT marked complete.'
        end

        redirect_to :back;
    end
end
