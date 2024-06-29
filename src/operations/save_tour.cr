require "./mixins/regex"
require "./mixins/save_base64_image"

# 採集行の保存オペレーション
class SaveTour < Tour::SaveOperation
  permit_columns(
    id,
    user_id,
    title,
    start_date,
    end_date,
    note,
    image1,
    image2,
    image3,
    image4,
    image5
  )

  before_save do
    validate_size_of title, max: 30
    validate_size_of note, max: 200

    Base64Image.save_base64_images(image1, image2, image3, image4, image5)
  end
end
