################################################################################
# $Id: obstacles_controller.rb 1363 2008-11-14 19:06:05Z ccaroon $
################################################################################
class ObstaclesController < ApplicationController
    ############################################################################
    def index
        @obstacles = Obstacle.find(:all)

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @obstacles }
        end
    end
    ############################################################################
    def show
        @obstacle = Obstacle.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @obstacle }
        end
    end
    ############################################################################
    def new
        @obstacle = Obstacle.new

        respond_to do |format|
            format.html { render :template => 'obstacles/new_edit'}
            format.xml  { render :xml => @obstacle }
        end
    end
    ############################################################################
    def edit
        @obstacle = Obstacle.find(params[:id]);

        render :template => 'obstacles/new_edit';
    end
    ############################################################################
    def create
        @obstacle = Obstacle.new(params[:obstacle])

        respond_to do |format|
            if @obstacle.save
                flash[:notice] = 'Obstacle was successfully created.'
                format.html { redirect_to(@obstacle) }
                format.xml  { render :xml => @obstacle, :status => :created, :location => @obstacle }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @obstacle.errors, :status => :unprocessable_entity }
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
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @obstacle.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def destroy
        @obstacle = Obstacle.find(params[:id])
        @obstacle.destroy

        respond_to do |format|
            format.html { redirect_to(obstacles_url) }
            format.xml  { head :ok }
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
