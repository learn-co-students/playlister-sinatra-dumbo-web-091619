class Artist < ActiveRecord::Base
  include SlugModule
  extend SlugModule::SlugExtension
  
  has_many :songs
  has_many :genres, through: :songs

  def self.find_by_slug(slug)
    self.find_by_slug_using_sql(slug, "SELECT * FROM artists WHERE name LIKE ?")
  end
end