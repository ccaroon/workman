################################################################################
# $Id: obstacles_controller.rb 1336 2008-09-04 13:49:44Z ccaroon $
################################################################################
class ObstaclesController < ApplicationController
    layout 'streamlined';
    acts_as_streamlined;

    ############################################################################
    def mark_complete
        ob = Obstacle.find(params[:id]);
        
        ob.is_overcome = true;
        
        if (ob.save())
            flash[:notice] = 'Obstacle was successfully marked complete.'
        else
            flash[:notice] = 'ERROR: Obstacle was NOT marked complete.'
        end
        
        redirect_to :controller => 'goals', :action => 'list';
    end
end
