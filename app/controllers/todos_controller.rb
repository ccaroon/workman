################################################################################
# $Id: todos_controller.rb 1333 2008-09-03 14:14:58Z ccaroon $
################################################################################
class TodosController < ApplicationController
    
    layout 'streamlined';
    acts_as_streamlined;

    ############################################################################
    def mark_complete
        @todo = Todo.find(params[:id]);

        @todo.completed = true;
        @todo.completed_on = Time.now();

        if (@todo.save())
            flash[:notice] = 'Todo was successfully marked complete.'
        else
            flash[:notice] = 'ERROR: Todo was NOT marked complete.'
        end
        
        redirect_to :controller => 'main', :action => 'home';
    end
end
