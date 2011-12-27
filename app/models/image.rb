class Image < ActiveRecord::Base
	include Rails.application.routes.url_helpers
	belongs_to :story
	mount_uploader :file, ImageUploader
	
	def to_jq_upload
  {
  	"id" => id,
  	"title" => title,
    "name" => read_attribute(:file),
    "size" => file.size,
    "url" => file.url,
    "thumbnail_url" => file.thumb.url,
    "delete_url" => image_path(:id => id),
    "delete_type" => "DELETE" 
   }
  end

end
