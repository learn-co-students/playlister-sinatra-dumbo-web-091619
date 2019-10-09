class Genre < ActiveRecord::Base
  include SlugModule
  extend SlugModule::SlugExtension

  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def self.find_by_slug(slug)
    self.find_by_slug_using_sql(slug, "SELECT * FROM genres WHERE name LIKE ?")
  end

end