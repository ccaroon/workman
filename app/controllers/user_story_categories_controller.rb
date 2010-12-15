################################################################################
# $Id: user_story_categories_controller.rb 1374 2008-11-26 19:22:48Z ccaroon $
################################################################################
class UserStoryCategoriesController < ApplicationController
    ############################################################################
    def index

        conditions = nil;
        unless (params[:filter_text].nil? || params[:filter_text].empty?)
            conditions = "name regexp '#{params[:filter_text]}'";
        end

        @user_story_categories = UserStoryCategory.paginate(
            :page => params[:page],
            :conditions => conditions);

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @user_story_categories }
        end
    end
    ############################################################################
    def show
        @user_story_category = UserStoryCategory.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @user_story_category }
        end
    end
    ############################################################################
    def new
        @user_story_category = UserStoryCategory.new

        respond_to do |format|
            format.html { render :template => 'user_story_categories/new_edit'}
            format.xml  { render :xml => @user_story_category }
        end
    end
    ############################################################################
    def edit
        @user_story_category = UserStoryCategory.find(params[:id]);

        render :template => 'user_story_categories/new_edit';
    end
    ############################################################################
    def create
        @user_story_category = UserStoryCategory.new(params[:user_story_category])

        respond_to do |format|
            if @user_story_category.save
                flash[:notice] = 'UserStoryCategory was successfully created.'
                format.html { redirect_to(@user_story_category) }
                format.xml  { render :xml => @user_story_category, :status => :created, :location => @user_story_category }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @user_story_category.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def update
        @user_story_category = UserStoryCategory.find(params[:id])

        respond_to do |format|
            if @user_story_category.update_attributes(params[:user_story_category])
                flash[:notice] = 'UserStoryCategory was successfully updated.'
                format.html { redirect_to(@user_story_category) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @user_story_category.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def destroy
        @user_story_category = UserStoryCategory.find(params[:id])
        @user_story_category.destroy

        respond_to do |format|
            format.html { redirect_to(user_story_categories_url) }
            format.xml  { head :ok }
        end
    end
end
