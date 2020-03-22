class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :name
    end

    create_table :song_genres do |t|
      t.integer :genre_id
      t.integer :song_id
    end
  end
end
