################################################################################
# $Id: scenario.rb 1374 2008-11-26 19:22:48Z ccaroon $
################################################################################
class Scenario < ActiveRecord::Base
    
    belongs_to :user_story;

    validates_presence_of :title;
    validates_presence_of :given;
    validates_presence_of :when;
    validates_presence_of :then;
    validates_presence_of :user_story_id;

end
