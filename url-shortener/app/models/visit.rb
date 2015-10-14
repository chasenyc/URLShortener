class Visit < ActiveRecord::Base
  validates :visitor_id, presence: true, inclusion: {in: User.ids}
  validates :short_url_id, presence: true, inclusion: {in: ShortenedUrl.ids}

  has_many :visitors,
    class_name: "User",
    foreign_key: :visitor_id,
    primary_key: :id

  has_many :visited_urls,
    class_name: "ShortenedUrl",
    foreign_key: :short_url_id,
    primary_key: :id

end
