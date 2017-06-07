require("pry-byebug")
require_relative("../models/artist")
require_relative("../models/album")

# Album.delete_all()
# Artist.delete_all()

artist1 = Artist.new({
  "name" => "Guns and Roses"
  })

artist2 = Artist.new({
  "name" => "Primal Scream"
  })

artist1.save
artist2.save

album1 = Album.new({
  "title" => "Appetite for destruction",
  "genre" => "Rock",
  "artist_id" => artist1.id
  })

album2 = Album.new({
  "title" => "Use your illusions 2",
  "genre" => "Rock",
  "artist_id" => artist1.id
  })

 album3 = Album.new({
  "title" => "Screamadellica",
  "genre" => "Alternative",
  "artist_id" => artist2.id
  }) 

 album1.save
 album2.save
 album3.save

binding.pry
nil