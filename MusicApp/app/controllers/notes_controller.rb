class NotesController < ApplicationController
  def create
    note = Note.new(note_params)

    note.save
    redirect_to track_url(note.track_id)
  end

  def destroy
    note = Note.find(params[:id])
    if note.user_id == current_user.id
      note.destroy
      redirect_to track_url(note.track_id)
    end
  end

  private

  def note_params
    params.require(:note).permit(:text, :track_id, :user_id)
  end
end
