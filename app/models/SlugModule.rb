module SlugModule
  def slug
    self.name.downcase.split(" ").join("-")
  end

  module SlugExtension
    def unslug(slug)
      slug.split("-").join(" ")
    end
  
    def find_by_slug_using_sql(slug, sql)
      # "SELECT * FROM artists WHERE name LIKE ?"
      something = self.find_by_sql [sql, self.unslug(slug)]
      something.first
    end
  end
end