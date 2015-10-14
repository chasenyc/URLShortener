class TagTopic < ActiveRecord::Base
  has_many :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_topic_id,
    primary_key: :id

  has_many :short_urls,
    through: :taggings,
    source: :short_url
end
