require 'pry'
class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    @song.notes.build
    # @song.artist.build
  end

  def create

    @song = Song.new(song_params)
    artist_name_hash = params.require(:song).permit(:artist)
    @song.artist_name = artist_name_hash[:artist]
    # note_content_array = []
    note_content_array = params.require(:song).permit(note_contents: [])
    note_content_array.delete("note_contents")
    @song.note_contents = note_content_array

    genre_name_hash = params.require(:song).permit(:genre_id)
    @song.genre_name = genre_name_hash[:genre_id]

    #binding.pry

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
    # @song.notes.build
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :genre, note_contents: [])
  end
end
