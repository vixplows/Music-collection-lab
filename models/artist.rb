require('pg')
require_relative('../db/sql_runner')
require_relative('album')

class Artist

  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "
    INSERT INTO artists (
    name
    ) VALUES (
      '#{@name}'
    )
    RETURNING id;"
    @id = SqlRunner.run(sql)[0]["id"].to_i
  end

  def Artist.all
    sql = "SELECT * FROM artists"
    all_artists = SqlRunner.run(sql)
    return all_artists.map { |artist| Artist.new(artist)}
  end

  def albums
    sql = "SELECT * FROM albums WHERE artist_id = #{id}"
    results = SqlRunner.run(sql)
    albums = results.map { |album| Album.new(album)}
    return albums
  end

end