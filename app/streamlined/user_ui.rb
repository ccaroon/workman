################################################################################
# $Id: user_ui.rb 1337 2008-09-05 16:15:24Z ccaroon $
################################################################################
module UserAdditions
end
################################################################################
User.class_eval { include UserAdditions }
################################################################################
Streamlined.ui_for(User) do

    default_order_options :order => 'name';
    
    user_columns :name,
                 :user_name;
             
    edit_columns :name;

end   
