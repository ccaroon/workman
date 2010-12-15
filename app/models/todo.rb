################################################################################
# $Id: todo.rb 1413 2009-02-11 19:38:41Z ccaroon $
################################################################################
class Todo < ActiveRecord::Base
    PRIORITIES = [1,2,3,4,5,6,7,8,9,10];
    PERCENT    = [0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100];

    belongs_to :list;

    validates_presence_of :priority;
    validates_presence_of :title;
end
