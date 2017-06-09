require('pg')
require_relative('../db/sql_runner')
require_relative('album')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @deleted = options['deleted']
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
    sql = "SELECT * FROM artists WHERE deleted = FALSE"
    all_artists = SqlRunner.run(sql)
    return all_artists.map { |artist| Artist.new(artist)}
  end

  def Artist.delete_all()
    sql = "UPDATE artists SET deleted = TRUE"
    SqlRunner.run(sql)
  end

## Refactored code 
  # def delete_but_keep_record()
  #   sql = "UPDATE artists SET
  #   (
  #   name,
  #   deleted   
  #   ) = (
  #   '#{@name}',
  #   TRUE
  #   )
  #   WHERE id = #{@id}"
  #   SqlRunner.run(sql)
  # end

  def delete()
    sql = "UPDATE artists SET deleted = TRUE WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{id}"
    results = SqlRunner.run(sql)
    albums = results.map { |album| Album.new(album)}
    return albums
  end

  def find(id)
    sql = "SELECT * FROM artists WHERE id = #{id} AND deletedd = FALSE"
    artist = SqlRunner.run(sql)
    result = artist.first
    return Artist.new(result)
  end

  def edit()
    sql = "UPDATE artists SET
    (
    name,
    deleted
    ) = (
    '#{@name}',
    '#{@deleted}'
    )
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

end