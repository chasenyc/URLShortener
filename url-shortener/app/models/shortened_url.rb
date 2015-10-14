class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  validates :short_url, presence: true, uniqueness: true

  belongs_to :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id


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
  end

end
