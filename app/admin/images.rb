ActiveAdmin.register Image do
  # form do |f|
  #   f.inputs do
  #     f.input :title
  #     f.input :file, :as => :file
  #   end
  #   f.buttons
  # end
  
  form :partial => "image"

  index do
    column :id
    column :title
    column "Image" do |file|
      image_tag file.file.url(:thumb) 
    end
    column :file
    column :created_at
  end

  controller do
    def create
      @image = Image.new(params[:image])
      if @image.save
        render :json => [@image.to_jq_upload].to_json
      else
        render :json => [{:error => "custom_failure"}], :status => 304
      end
    end
  end

end
