class MusicLibraryController
  
  attr_reader :music_importer

  def initialize(path='./db/mp3s')
    @music_importer = MusicImporter.new(path)
    @music_importer.import
  end

  def list_songs
    sorted = Song.all.sort_by{|song|song.name}
    sorted.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted = Artist.all.sort_by { |artist| artist.name }
    sorted.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end

  def list_genres
    sorted = Genre.all.sort_by { |genre| genre.name }
    sorted.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    choice = gets.chomp
    artist = Artist.all.find { |artist| artist.name == choice }
    if artist
      sorted = artist.songs.sort_by { |song| song.name }
      sorted.each_with_index { |song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    choice = gets.chomp
    genre = Genre.all.find { |genre| genre.name == choice }
    if genre
      sorted = genre.songs.sort_by { |song| song.name }
      sorted.each_with_index { |song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    choice = gets.chomp.to_i
    songs = Song.all.sort_by{|song|song.name}
    if choice > 0 && choice <= songs.size
      puts "Playing #{songs[choice-1].name} by #{songs[choice-1].artist.name}"
    end
  end

  def run_selection(choice)
    case choice
    when 'list songs'   then list_songs
    when 'list artists' then list_artists
    when 'list genres'  then list_genres
    when 'list artist'  then list_songs_by_artist
    when 'list genre'   then list_songs_by_genre
    when 'play song'    then play_song
    end
  end

  def call
    loop do
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      choice = gets

      break if choice.chomp == 'exit'
      run_selection(choice.chomp)
    end
  end
end