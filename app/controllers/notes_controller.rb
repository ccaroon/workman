################################################################################
# $Id: notes_controller.rb 1350 2008-10-06 16:41:48Z ccaroon $
################################################################################
class NotesController < ApplicationController
    
    layout 'streamlined';
    acts_as_streamlined;
    
    ############################################################################
    def destroy
        note = Note.find(params[:id]);

        if (note.deleted_on)
            note.deleted_on = nil;
        else
            note.deleted_on = Time.now();
        end

        note.save!;

        return(list());
    end
    ############################################################################
    def print
        note = Note.find(params[:id]);

        note_str =<<EOF
# #{note.title} #

-----------------------------

#{note.body}
EOF
        p_note = BlueCloth.new(note_str);

        respond_to do |format|
            format.html {render :layout => false, :text => p_note.to_html}
            format.text {render :layout => false, :text => p_note.to_s}
        end
    end
    ############################################################################
    def toggle_favorite
        note = Note.find(params[:id]);
        
        if (note.is_favorite)
            note.is_favorite = false;
        else
            note.is_favorite = true;
        end
        
        note.save!;

        return(list());
    end
    ############################################################################
    def toggle_encrypted
        note = Note.find(params[:id]);
        
        if (note.is_encrypted)
            note.is_encrypted = false;
        else
            note.is_encrypted = true;
        end
        
        note.save!;

        return(list());
    end

end
