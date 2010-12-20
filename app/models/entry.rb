################################################################################
# $Id: entry.rb 1266 2008-05-19 21:03:21Z ccaroon $
################################################################################
require 'goal';

class Entry < ActiveRecord::Base

    CATEGORIES = 
    [
        'Code Review',
        'Goal Progress',
        'Ticket',
        'Meeting',
        'Operational',
        'Other'
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
