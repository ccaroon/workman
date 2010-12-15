################################################################################
# $Id: lists_controller.rb 1413 2009-02-11 19:38:41Z ccaroon $
################################################################################
class ListsController < ApplicationController
    def index

        conditions = nil;
        unless (params[:filter_text].nil? || params[:filter_text].empty?)
            conditions = "name regexp '#{params[:filter_text]}'";
        end

        @lists = List.paginate(:page => params[:page],
            :conditions => conditions,
            :order => nil);

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @lists }
        end
    end
    ############################################################################
    def show
        @list = List.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @list }
        end
    end
    ############################################################################
    def new
        @list = List.new

        respond_to do |format|
            format.html { render :template => 'lists/new_edit' }
            format.xml  { render :xml => @list }
        end
    end
    ############################################################################
    def edit
        @list = List.find(params[:id]);

        render :template => 'lists/new_edit';
    end
    ############################################################################
    def create
        @list = List.new(params[:list])

        respond_to do |format|
            if @list.save
                flash[:notice] = 'List was successfully created.'
                format.html { redirect_to(@list) }
                format.xml  { render :xml => @list, :status => :created, :location => @list }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def update
        @list = List.find(params[:id])

        respond_to do |format|
            if @list.update_attributes(params[:list])
                flash[:notice] = 'List was successfully updated.'
                format.html { redirect_to(@list) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def destroy
        @list = List.find(params[:id])
        @list.destroy

        respond_to do |format|
            format.html { redirect_to(lists_url) }
            format.xml  { head :ok }
        end
    end
end
