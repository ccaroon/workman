################################################################################
# $Id: list.rb 1513 2009-05-26 19:21:08Z ccaroon $
################################################################################
class List < ActiveRecord::Base
    validates_presence_of :name;

    has_many :todos, :order     => "completed, due_on, priority",
                     :dependent => :destroy;

    has_many :complete_todos, :class_name => 'Todo',
                                :conditions => "completed > 0",
                                :order => "due_on, priority";
end
