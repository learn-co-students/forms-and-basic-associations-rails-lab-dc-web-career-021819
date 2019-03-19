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
    #@song.notes.build
    # @song.artist.build
  end

  def create
    #probably going to need to create this in form?
    # artist = Artist.new
    # artist.name = song_params[:artist]
    # song_params[:artist] = artist
    @song = Song.new(params.require(:song).permit(:title, :genre))
    artist_name_hash = params.require(:song).permit(:artist)
    @song.artist_name = artist_name_hash[:artist]
    note_content_array = []
    note_content_array <<  params.require(:song).permit(:song_notes_1)
    note_content_array <<  params.require(:song).permit(:song_notes_2)
    # binding.pry
    @song.note_contents = note_content_array

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
    params.require(:song).permit(:title, :artist, :genre, notes_attributes: [:content])
  end
end
