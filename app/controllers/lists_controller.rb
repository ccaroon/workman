################################################################################
# $Id: lists_controller.rb 1413 2009-02-11 19:38:41Z ccaroon $
################################################################################
class ListsController < ApplicationController

    respond_to :html;
    ############################################################################
    def index

        conditions = nil;
        unless (params[:filter_text].nil? || params[:filter_text].empty?)
            conditions = "name regexp '#{params[:filter_text]}'";
        end

        @lists = List.paginate(:page => params[:page],
            :conditions => conditions,
            :order => nil);
    end
    ############################################################################
    def show
        @list = List.find(params[:id]);
    end
    ############################################################################
    def new
        @list = List.new;
    end
    ############################################################################
    def edit
        @list = List.find(params[:id]);
    end
    ############################################################################
    def create
        @list = List.new(params[:list]);

        respond_to do |format|
            if @list.save
                flash[:notice] = 'List was successfully created.'
                format.html { redirect_to(@list) }
            else
                format.html { render :action => "new" }
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
            else
                format.html { render :action => "edit" }
            end
        end
    end
    ############################################################################
    def destroy
        @list = List.find(params[:id])
        @list.destroy

        respond_to do |format|
            format.html { redirect_to(lists_url) }
        end
    end
end
