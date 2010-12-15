################################################################################
# $Id: entries_controller.rb 1535 2009-07-14 15:03:50Z ccaroon $
################################################################################
class EntriesController < ApplicationController

    before_filter :load_recent_entries, :only => [:new, :edit];

    ############################################################################
    def index
        conditions = nil;
        unless (params[:filter_text].nil? || params[:filter_text].empty?)
            conditions = "subject regexp '#{params[:filter_text]}' or description regexp '#{params[:filter_text]}'";
        end

        @entries = Entry.paginate(:page => params[:page],
            :conditions => conditions,
            :order => 'task_date desc, entry_date desc');

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @entries }
        end
    end
    ############################################################################
    def show
        @entry = Entry.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @entry }
        end
    end
    ############################################################################
    def new
        @entry = Entry.new(:task_date => Time.now().strftime("%Y-%m-%d"));

        respond_to do |format|
            format.html { render :template => 'entries/new_edit'}
            format.xml  { render :xml => @entry }
        end
    end
    ############################################################################
    def new_from_jira_ticket

        # This is mainly targeted at the "Code Review" category/status
        category = Entry::CATEGORIES.find {|cat| cat == params[:status]};
        category = "Ticket" if category.nil?;

        entry = Entry.new(
            :task_date   => Time.now().strftime("%Y-%m-%d"),
            :ticket_num  => params[:ticket_num],
            :subject     => params[:subject],
            :description => '---> EDIT ME <---',
            :category    => category
        );

        entry.save!;

        redirect_to :action => 'edit', :id => entry;
    end
    ############################################################################
    def edit
        @entry = Entry.find(params[:id]);

        render :template => 'entries/new_edit';
    end
    ############################################################################
    def create

        params['entry']['task_date'] = params['entry_task_date'];
        @entry = Entry.new(params[:entry]);

        respond_to do |format|
            if @entry.save
                flash[:notice] = 'Entry was successfully created.'
                format.html { redirect_to(@entry) }
                format.xml  { render :xml => @entry, :status => :created, :location => @entry }
            else
                format.html { render :action => "new_edit" }
                format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def update
        @entry = Entry.find(params[:id])

        params['entry']['task_date'] = params['entry_task_date'];

        respond_to do |format|
            if @entry.update_attributes(params[:entry])
                flash[:notice] = 'Entry was successfully updated.'
                format.html { redirect_to(@entry) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
            end
        end
    end
    ############################################################################
    def destroy
        @entry = Entry.find(params[:id])
        @entry.destroy

        respond_to do |format|
            format.html { redirect_to(entries_url) }
            format.xml  { head :ok }
        end
    end
    ############################################################################
    private
    def load_recent_entries
        @recent_entries = Entry.find(:all,
            :select     => "distinct(subject)",
            :conditions => "task_date >= '#{Date.today - 31}'");
    end
    
end
