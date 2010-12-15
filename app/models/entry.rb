################################################################################
# $Id: entry.rb 1720 2009-12-10 16:39:14Z ccaroon $
################################################################################
require 'goal';

class Entry < ActiveRecord::Base

    CATEGORY_CODE_REVIEW   = 'Code Review';
    CATEGORY_MEETING       = 'Meeting';
    CATEGORY_GOAL_PROGRESS = 'Goal Progress';
    CATEGORY_TICKET        = 'Ticket';
    CATEGORY_OPERATIONAL   = 'Operational';
    CATEGORY_OTHER         = 'Other';

    CATEGORIES = 
    [
        CATEGORY_CODE_REVIEW,
        CATEGORY_GOAL_PROGRESS,
        CATEGORY_TICKET,
        CATEGORY_MEETING,
        CATEGORY_OPERATIONAL,
        CATEGORY_OTHER,
    ];

    belongs_to :goal;

    validates_presence_of :task_date;
    validates_presence_of :subject;
    validates_presence_of :description;
    validates_presence_of :category;

    def before_create
        self.entry_date = Time.now() if self.entry_date.nil?
    end
end
