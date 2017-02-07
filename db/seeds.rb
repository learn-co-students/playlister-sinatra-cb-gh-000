# Add seed data here. Seed your database with `rake db:seed`
artist = Artist.create(name: "Mondo")
Genre.create(name: "Pop")
Genre.create(name: "Plue")
Song.create(name: "Sing Loud", artist: artist, genre_ids: [1, 2])
