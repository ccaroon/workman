################################################################################
# $Id: todos_controller.rb 1535 2009-07-14 15:03:50Z ccaroon $
################################################################################
class TodosController < ApplicationController
  
    respond_to :html;
    ############################################################################
    def index

        conditions = "list_id is null";
        unless (params[:filter_text].nil? || params[:filter_text].empty?)
            conditions = conditions + " and title regexp '#{params[:filter_text]}'";
        end

        @todos = Todo.paginate(:page => params[:page],
            :conditions => conditions,
            :order => 'completed, completed_on desc, priority');
    end
    ############################################################################
    def show
        @todo = Todo.find(params[:id])
    end
    ############################################################################
    def new
        @todo = Todo.new();
        
        if(params[:list_id])
          @todo.list = List.find(params[:list_id]);
        end
    end
    ############################################################################
    def edit
        @todo = Todo.find(params[:id]);
    end
    ############################################################################
    def create

        params['todo']['due_on'] = params['todo_due_on'];
        @todo = Todo.new(params[:todo])

        respond_to do |format|
            if @todo.save
                flash[:notice] = 'Todo was successfully created.'
                format.html {
                    if(!@todo.list.nil?)
                        redirect_to(@todo.list)
                    else
                        redirect_to(@todo)
                    end
                }
            else
                format.html { render :action => "new" }
            end
        end
    end
    ############################################################################
    def update

        params['todo']['due_on'] = params['todo_due_on'];
        @todo = Todo.find(params[:id])

        respond_to do |format|
            if @todo.update_attributes(params[:todo])
                flash[:notice] = 'Todo was successfully updated.'
                format.html {
                    if(!@todo.list.nil?)
                        redirect_to(@todo.list)
                    else
                        redirect_to(@todo)
                    end
                }
            else
                format.html { render :action => "edit" }
            end
        end
    end
    ############################################################################
    def destroy
        @todo = Todo.find(params[:id])
        @todo.destroy

        respond_to do |format|
            format.html { redirect_to :back }
        end
    end
    ############################################################################
    def mark_complete
        @todo = Todo.find(params[:id]);

        @todo.completed = true;
        @todo.completed_on = Time.now();

        @todo.save!();

        redirect_to :back;
    end
end
