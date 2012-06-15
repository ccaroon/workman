################################################################################
# $Id: goal.rb 1255 2008-05-14 18:20:26Z ccaroon $
################################################################################
class Goal < ActiveRecord::Base

    PRIORITIES = [1,2,3,4,5,6,7,8,9,10];
    PERCENT    = [0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100];
    
    has_many :entries;
    has_many :obstacles;

    validates_presence_of :priority;
    validates_presence_of :name;
    
    ############################################################################
    def self.find_uncompleted_goals
        goals = Goal.find(:all, :conditions => "completed != 1",
                                :order => "priority asc");
        return (goals);
    end
    ############################################################################
    def outstanding_obstacles
        outstanding = Obstacle.find(:all,
            :conditions => "goal_id = #{self.id} and is_overcome = false",
            :order => "created_at");
        return (outstanding);
    end
    ############################################################################
    def self.uncompleted_goals_for_select
       find_uncompleted_goals.collect! { |g| [g.name, g.id] };
    end

end
