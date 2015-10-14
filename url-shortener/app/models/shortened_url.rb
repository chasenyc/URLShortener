class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
end
