class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  validates :short_url, presence: true, uniqueness: true

  belongs_to :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits,
    class_name: 'Visit',
    foreign_key: :short_url_id,
    primary_key: :id

  has_many :visitors,
    through: :visits,
    source: :visitor

  has_many :distinct_visitors,
    -> { self.distinct },
    through: :visits,
    source: :visitor

    # User.joins(:visits).where("visits.shortened_url_id = ?", self.id).distinct


  def self.random_code
    new_short = nil
    loop do
      new_short = SecureRandom.urlsafe_base64

      break unless ShortenedUrl.exists?(short_url: new_short)
    end

    new_short
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: self.random_code)

    # user.submitted_urls.create!(
    #   long_url: long_url,
    #   short_url: self.random_code
    # )
  end

  def num_visits
    self.visitors.length
  end

  def num_uniques
    self.distinct_visitors.length
  end

  def num_recent_uniques
    # distinct_visitors.where(created_at: 10.minutes.ago..Time.now).count
    Visit.select(:visitor_id).where(["created_at > ? AND short_url_id = ?", 10.minutes.ago, self.id]).count
  end
end
