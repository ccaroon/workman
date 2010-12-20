################################################################################
# $Id: note_ui.rb 1350 2008-10-06 16:41:48Z ccaroon $
################################################################################
require 'bluecloth';

module NoteAdditions

    def pretty_body
        return (BlueCloth.new(self.body).to_html);
    end

    def list_title
        title = self.title;
        if (self.deleted_on)
            title = "<s>#{title}</s>";
        end

        return (title);
    end

    def pretty_favorite
        image = self.is_favorite ? 'star_on.png' : 'star_off.png';

        return ("<a href='/notes/toggle_favorite/#{self.id}'><img src='/images/themes/default/#{image}' border='0'></a>");
    end
    
    def pretty_encrypted
        image = self.is_encrypted ? 'lock_on.png' : 'lock_off.png';

        return ("<a href='/notes/toggle_encrypted/#{self.id}'><img src='/images/themes/default/#{image}' border='0'></a>");
    end

    def modifiers
        return ("#{pretty_favorite}&nbsp;#{pretty_encrypted}");
    end
    
end
################################################################################
Note.class_eval {include NoteAdditions}
################################################################################
class NoteUI < Streamlined::UI
    
    default_order_options :order => 'created_on, title';
    
    list_columns :modifiers,  {:allow_html => true,
                               :human_name => ''},
                 :list_title, {:link_to => {:action => 'show'},
                               :allow_html => true,
                               :human_name => 'Title'};
    
    edit_columns :is_favorite,  {:human_name => 'Favorite'},
                 :is_encrypted, {:human_name => 'Encrypted'},
                 :title,
                 :body, {:html_options => {:rows => 35, :cols => 80, :wrap => 'physical'}};
             
    show_columns :pretty_favorite, {:human_name => 'Favorite',
                                    :allow_html => true},
                 :pretty_encrypted, {:human_name => 'Encrypted',
                                    :allow_html => true},
                 :title, {:link_to => {:action => 'print'}},
                 :pretty_body, {:allow_html => true, 
                                :human_name => 'Body'},
                 :deleted_on;
end
