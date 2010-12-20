################################################################################
# $Id: entries_controller.rb 1333 2008-09-03 14:14:58Z ccaroon $
################################################################################
class EntriesController < ApplicationController
    
    layout 'streamlined';
    acts_as_streamlined;

    def new_from_jira_ticket
        entry = Entry.new(
            :task_date   => Time.now(),
            :ticket_num  => params[:ticket_num],
            :subject     => params[:subject],
            :description => '---> EDIT ME <---',
            :category    => Entry::CATEGORIES[2]
        );

        entry.save!;
        
        redirect_to :action => 'edit', :id => entry;
    end
end
