class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name
    self.genre.name
  end

  def genre_name=(genre_name_string)
    genre = Genre.find_or_create_by(name: genre_name_string)
    # genre.name = genre_name_string
    genre.songs << self
    genre.save
    #binding.pry
    genre_name_string
  end

  def artist_name
    self.artist.name
  end

  def artist_name=(artist_name_string)
    artist = Artist.new
    artist.name = artist_name_string
    artist.songs << self
    artist_name_string
  end

  def note_contents
    note_content = []
    self.notes.each do |note|
      note_content << note.content
    end
    note_content = note_content.reject {|n| n.empty?}
  end

  def note_contents=(array_of_note_contents)
    array_of_note_contents.each do |content|
      note = Note.new
      note.content = content
      self.notes << note
    end
  end
end
