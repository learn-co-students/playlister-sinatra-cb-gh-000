# Add seed data here. Seed your database with `rake db:seed`

class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
  end

  def import
    files.each{ |f| self.create_from_filename(f) }
  end

  def create_from_filename(filename)
    parts = filename.split(/\s-\s|\[(.*)\]/ )
    artist_name, song_name, genre_name = parts[0].strip, parts[1].strip, parts[2].strip

    artist = Artist.find_or_create_by(name: artist_name)
    g = genre = Genre.find_or_create_by(name: genre_name)

    s = Song.create(name: song_name, artist: artist)
    SongGenre.create(song_id: s.id, genre_id: g.id)
  end

end

m = MusicImporter.new("./db/data")
m.import