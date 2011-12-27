class Story < ActiveRecord::Base
  STATUS_DRAFT = 'draft'
  STATUS_MODERATING = 'moderating'
  STATUS_DELETED = 'deleted'
  STATUS_PUBLISHED = 'published'
  STATUS_APPROVED = 'approved'
  STATUS_UNAPPROVED = 'unapproved'
  
  is_impressionable :counter_cache => true

  validates_presence_of :title, :content, :subject_id
  has_many :images

  belongs_to :subject

  delegate :title, :description, :to => :subject, :prefix => true
  
  def self.last_ten
    where(:status => Story::STATUS_PUBLISHED)\
    .where("published_at <=(?)",Time.now).limit(10)
  end

  # ActiveAdmin helper methods
  def self.popular
    where(:status => Story::STATUS_PUBLISHED)\
    .where("published_at <=(?)",Time.now).order('impressions_count DESC').limit(10)
  end

  def self.main
    where(:status => Story::STATUS_PUBLISHED)\
    .where("published_at <=(?)",Time.now).where(:is_main => true)
  end
  def status_tag
    case self.status
      when STATUS_DELETED then :error
      when STATUS_UNAPPROVED then :error
      when STATUS_APPROVED then :ok
      when STATUS_PUBLISHED then :published
      when STATUS_MODERATING then :warn
    end
  end

  def self.status_collection
    {
      "Draft" => STATUS_DRAFT, "Moderating" => STATUS_MODERATING,
      "Deleted" => STATUS_DELETED, "Published" => STATUS_PUBLISHED,
      "Approved" => STATUS_APPROVED, "Unapproved" => STATUS_UNAPPROVED
    }
  end
end
