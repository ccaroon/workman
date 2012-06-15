################################################################################
# $Id: notes_controller.rb 1370 2008-11-18 21:57:09Z ccaroon $
################################################################################
require 'bluecloth';

class NotesController < ApplicationController

    respond_to :html, :text;

    ############################################################################
    def index

        conditions = nil;
        unless (params[:filter_text].nil? || params[:filter_text].empty?)
            conditions = "title regexp '#{params[:filter_text]}' or body regexp '#{params[:filter_text]}'";
        end

        @notes = Note.paginate(:page => params[:page], :conditions => conditions);
    end
    ############################################################################
    def show
        @note = Note.find(params[:id]);
    end
    ############################################################################
    def new
        @note = Note.new;
    end
    ############################################################################
    def edit
        @note = Note.find(params[:id]);
    end
    ############################################################################
    def create
        @note = Note.new(params[:note])

        respond_to do |format|
            if @note.save
                flash[:notice] = 'Note was successfully created.'
                format.html { redirect_to(@note) }
            else
                format.html { render :action => "new" }
            end
        end
    end
    ############################################################################
    def update
        @note = Note.find(params[:id])

        respond_to do |format|
            if @note.update_attributes(params[:note])
                flash[:notice] = 'Note was successfully updated.'
                format.html { redirect_to(@note) }
            else
                format.html { render :action => "edit" }
            end
        end
    end
    ############################################################################
    def destroy
        note = Note.find(params[:id]);

        if (note.deleted_on)
            note.deleted_on = nil;
        else
            note.deleted_on = Time.now();
        end

        note.save!;

        respond_to do |format|
            format.html { redirect_to(notes_url) }
        end
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
            format.text {render :layout => false, :text => note_str}
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

        redirect_to :back;
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

        redirect_to :back;
    end

end
