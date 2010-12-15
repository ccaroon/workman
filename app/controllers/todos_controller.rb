################################################################################
# $Id: todos_controller.rb 1535 2009-07-14 15:03:50Z ccaroon $
################################################################################
class TodosController < ApplicationController
    ############################################################################
    def index

        conditions = "list_id is null";
        unless (params[:filter_text].nil? || params[:filter_text].empty?)
            conditions = conditions + " and title regexp '#{params[:filter_text]}'";
        end

        @todos = Todo.paginate(:page => params[:page],
            :conditions => conditions,
            :order => 'completed, completed_on desc, priority');

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @todos }
        end
    end
    ############################################################################
    def show
        @todo = Todo.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @todo }
        end
    end
    ############################################################################
    def new
        @todo = Todo.new();
        
        if(params[:list_id])
          @todo.list = List.find(params[:list_id]);
        end

        respond_to do |format|
            format.html { render :template => 'todos/new_edit'}
            format.xml  { render :xml => @todo }
        end
    end
    ############################################################################
    def edit
        @todo = Todo.find(params[:id]);

        render :template => 'todos/new_edit';
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
                format.xml  { render :xml => @todo, :status => :created, :location => @todo }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
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
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def destroy
        @todo = Todo.find(params[:id])
        @todo.destroy

        respond_to do |format|
            format.html { redirect_to :back }
            format.xml  { head :ok }
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
