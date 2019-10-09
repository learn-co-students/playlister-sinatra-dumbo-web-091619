class Song < ActiveRecord::Base
  include SlugModule
  extend SlugModule::SlugExtension
  
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def self.find_by_slug(slug)
    self.find_by_slug_using_sql(slug, "SELECT * FROM songs WHERE name LIKE ?")
  end
end