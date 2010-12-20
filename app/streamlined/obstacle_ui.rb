################################################################################
# $Id: obstacle_ui.rb 1337 2008-09-05 16:15:24Z ccaroon $
################################################################################
module ObstacleAdditions

end
Obstacle.class_eval { include ObstacleAdditions }

Streamlined.ui_for(Obstacle) do

    user_columns :title,
                 :goal, {:options_for_select => :uncompleted_goals_for_select},
                 :description,
                 :is_overcome, {:check_box => true};
end   
