require('pg')
require_relative('../db/sql_runner')
require_relative('artist')

class Album

  attr_reader :id, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "
    INSERT INTO albums (
    title,
    genre,
    artist_id)
    VALUES (
    '#{@title}',
    '#{@genre}',
    #{artist_id}
    )
    RETURNING id;"
    @id = SqlRunner.run(sql)[0]["id"].to_i()
  end

  def Album.all()
    sql = "SELECT * FROM albums"
    all_albums = SqlRunner.run(sql)
    return all_albums.map { |album| Album.new(album)}
  end

  def Album.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = #{artist_id}"
    results = SqlRunner.run(sql)
    album_artist = results[0]
    artist = Artist.new(album_artist)
    return artist
  end

end