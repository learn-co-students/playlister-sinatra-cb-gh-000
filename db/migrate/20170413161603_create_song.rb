class CreateSong < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.belongs_to :artist, index: true
      t.string :name
    end
  end
end
