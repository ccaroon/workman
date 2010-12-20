################################################################################
# $Id: pref_ui.rb 1337 2008-09-05 16:15:24Z ccaroon $
################################################################################
module PrefAdditions

    def user_name
        return (self.user.user_name);
    end

    def avatar_as_icon
        return ("<img src='/images/themes/default/#{self.avatar}' title='#{self.avatar}'/>");
    end
end
################################################################################
Pref.class_eval { include PrefAdditions }
################################################################################
Streamlined.ui_for(Pref) do

    list_columns :user_name,
                 :theme,
                 :avatar_as_icon, {:human_name => 'Avatar',
                                   :allow_html => true};

    show_columns :user_name,
                 :theme,
                 :avatar_as_icon, {:human_name => 'Avatar',
                                   :allow_html => true};

    edit_columns :theme,
                 :avatar, {:enumeration => %w(avatar1.png avatar2.png 
                                              avatar3.png avatar4.png
                                              avatar5.png avatar6.png)};

    table_row_buttons false;
end   
