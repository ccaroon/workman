################################################################################
# $Id: notes_helper.rb 1391 2009-01-12 16:22:22Z ccaroon $
################################################################################
require 'bluecloth';

module NotesHelper

    ############################################################################
    def display_note(note, attr)
        value = nil;

        case attr
        when :title
            value = note_title_for_display(note)
        when :body
            value = (BlueCloth.new(note.body).to_html);
        when :print
            value = note_print(note);
        when :edit
            value = note_edit(note);
        when :favorite_toggle
            value = note_favorite_toggle(note);
        when :encrypted_toggle
            value = note_encrypted_toggle(note);
        when :modifiers
            value = "#{note_favorite_toggle(note)}&nbsp;#{note_encrypted_toggle(note)}";
        else
            value = note.send(attr);
        end

        return(value);
    end
    ############################################################################
    def note_title_for_display(note)
        title = note.title;
        if (note.deleted_on)
            title = "<s>#{title}</s>";
        end

        return (title);
    end
    ############################################################################
    def note_print(note)
        html = link_to image_tag("themes/default/printer.png", {:border => 0}),
            :controller => 'notes', :action => 'print', :id => note;

        return (html);
    end
    ############################################################################
    def note_edit(note)
        html = link_to image_tag("themes/default/edit.png", {:border => 0}),
            :controller => 'notes', :action => 'edit', :id => note;

        return (html);
    end
    ############################################################################
    def note_favorite_toggle(note)
        image = note.is_favorite ? 'star_on.png' : 'star_off.png';

        html = link_to image_tag("themes/default/#{image}", {:border => 0}),
            :controller => 'notes', :action => 'toggle_favorite', :id => note;

        return (html);
    end
    ############################################################################
    def note_encrypted_toggle(note)
        image = note.is_encrypted ? 'lock_on.png' : 'lock_off.png';

        html = link_to image_tag("themes/default/#{image}", {:border => 0}),
            :controller => 'notes', :action => 'toggle_encrypted', :id => note;

        return (html);
    end

end
