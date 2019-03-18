class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    g = Genre.find_or_create_by(:name => name)
    self.genre = g
  end

  def genre_name
    self.genre.name
  end

  def artist_name=(name = "Unknown Artist")
    a = Artist.find_or_create_by(:name => name)
    self.artist = a
  end

  def artist_name
    if (self.artist)
      return self.artist.name
    else
      return "Unknown Artist"
    end
  end

  def note_contents
    return_contents = []
    self.notes.each do |note|
      return_contents << note.content
    end
    return_contents
  end

  def note_contents=(note_string_array)
    note_string_array.each do |note_string|
      if (note_string != "")
        note = Note.find_or_create_by(content: note_string)
        self.notes << note
      end
    end
  end
end
