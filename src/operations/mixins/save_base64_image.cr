require "uuid"
require "uri"

module Base64Image
  JPG = "image/jpeg;base64"
  PNG = "image/png;base64"
  GIF = "image/gif;base64"
  SVG = "image/svg+xml;base64"
  LOCAL_MEDIA_PATH = ENV["LOCAL_MEDIA_PATH"]

  def self.base64_to_image(base64_image, parent_id, image_id = UUID.random)
    uri = URI.parse(base64_image)
    type, body = uri.path.split(',')
    parent_dir_path = "#{LOCAL_MEDIA_PATH}/image-#{parent_id}"

    file_extension = if type == JPG
                       "jpg"
                     elsif type == PNG
                       "png"
                     elsif type = GIF
                       "gif"
                     else
                       raise Exception.new("Image file type is invalid!")
                     end

    file_name = "#{image_id}.#{file_extension}"
    file_path = "image-#{parent_id}/#{file_name}"

    unless Dir.exists?(parent_dir_path)
      Dir.mkdir(parent_dir_path)
    end
    File.write("#{parent_dir_path}/#{file_name}", Base64.decode(body))
    file_path
  end

  macro save_base64_images(*image_params)
    {% for image in image_params %}
      {{image}}.value = Base64Image.base64_to_image({{image}}.value.not_nil!, id.value) if {{image}}.value.nil?.! && {{image}}.changed?
    {% end %}
  end
end
