################################################################################
# $Id: user_stories_controller.rb 1374 2008-11-26 19:22:48Z ccaroon $
################################################################################
class UserStoriesController < ApplicationController
    ############################################################################
    def index
        stories = UserStory.paginate(:page => params[:page],
            :include => [:user_story_category],
            :order => "user_story_categories.name, user_stories.id");

        @user_stories = {};
        stories.each do |s|
            @user_stories[s.user_story_category.name] = [] if
                @user_stories[s.user_story_category.name].nil?
            @user_stories[s.user_story_category.name] << s;
        end

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @user_stories }
        end
    end
    ############################################################################
    def show
        @user_story = UserStory.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @user_story }
        end
    end
    ############################################################################
    def new
        @user_story = UserStory.new

        respond_to do |format|
            format.html { render :template => 'user_stories/new_edit' }
            format.xml  { render :xml => @user_story }
        end
    end
    ############################################################################
    def edit
        @user_story = UserStory.find(params[:id]);

        render :template => 'user_stories/new_edit';
    end
    ############################################################################
    def create
        @user_story = UserStory.new(params[:user_story])

        respond_to do |format|
            if @user_story.save
                flash[:notice] = 'UserStory was successfully created.'
                format.html { redirect_to(@user_story) }
                format.xml  { render :xml => @user_story, :status => :created, :location => @user_story }
            else
                format.html { render :action => "new_edit" }
                format.xml  { render :xml => @user_story.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def update
        @user_story = UserStory.find(params[:id])

        respond_to do |format|
            if @user_story.update_attributes(params[:user_story])
                flash[:notice] = 'UserStory was successfully updated.'
                format.html { redirect_to(@user_story) }
                format.xml  { head :ok }
            else
                format.html { render :action => "new_edit" }
                format.xml  { render :xml => @user_story.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def destroy
        @user_story = UserStory.find(params[:id])
        @user_story.destroy

        respond_to do |format|
            format.html { redirect_to(user_stories_url) }
            format.xml  { head :ok }
        end
    end
end
