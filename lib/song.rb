class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) ? find_by_name(name) : create(name)
  end

  def self.new_from_filename(name)
    song = name.gsub(".mp3", "").split(" - ")
    artist_name = Artist.find_or_create_by_name(song[0])
    song_name = song[1]
    genre_name = Genre.find_or_create_by_name(song[2])
    new_song = Song.new(song_name, artist_name, genre_name)
  end

  def self.create_from_filename(name)
    @@all << self.new_from_filename(name)
  end
end