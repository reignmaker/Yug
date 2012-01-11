class Story < ActiveRecord::Base
  STATUS_DRAFT = 'draft'
  STATUS_MODERATING = 'moderating'
  STATUS_DELETED = 'deleted'
  STATUS_PUBLISHED = 'published'
  STATUS_APPROVED = 'approved'
  STATUS_UNAPPROVED = 'unapproved'
  STATUSES = {draft:'draft', moderating:'moderating', deleted:'deleted', approved:'approved', published:'published', unapproved:'unapproved'}
  
  is_impressionable :counter_cache => true

  validates_presence_of :title, :content, :subject_id
  has_many :images

  belongs_to :subject

  delegate :title, :description, :to => :subject, :prefix => true

# get all published stories  
  scope :published, where(:status => Story::STATUS_PUBLISHED).where("published_at <=(?)",Time.now)

# get last N stories  
  scope :last_n, lambda {|n| published.limit(n)} 

# get N popular stories 
  scope :popular_n, lambda {|n|published.order('impressions_count DESC').limit(n)}
 
# get main story
  scope :main, published.where(:is_main => true)

# ActiveAdmin helper methods
  
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
