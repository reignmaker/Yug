class Subject < ActiveRecord::Base
  extend FriendlyId
  validates_presence_of :title
  attr_accessible :title, :description
  has_many :stories
  #has_many :images
  accepts_nested_attributes_for :stories, :reject_if => :all_blank
  friendly_id :transliterate_title, :use => :slugged

  def self.popular
    connection.select_all("select subjects.* , count(stories.id) as count from subjects left join stories on stories.subject_id = subjects.id where stories.status = 'published' group by subjects.title order by count desc limit 5")
  end

  def last_three_story
    stories.where(:status => Story::STATUS_PUBLISHED).limit(3).order("updated_at DESC")   
  end

  def all_published
    stories.where(:status => Story::STATUS_PUBLISHED)
  end

  def transliterate_title
    (Russian::transliterate title).parameterize
    
  end

  def stories_count
    stories.count
  end

  def published_stories_count
    stories.where(:status => Story::STATUS_PUBLISHED).count
  end

  def new_title
    title = Subject.new
  end
end
