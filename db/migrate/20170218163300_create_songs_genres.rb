class CreateSongsGenres < ActiveRecord::Migration[5.0]
  def change
    create_join_table :songs, :genres do |t|
      t.index :song_id
      t.index :genre_id
    end
  end
end
