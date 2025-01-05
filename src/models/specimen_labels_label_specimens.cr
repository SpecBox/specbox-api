# 標本ラベルと標本の多対多アソシエーションを作るための中間テーブル用モデル
class SpecimenLabelLabelSpecimen < BaseModel
  skip_default_columns
  table :specimen_labels_label_specimens do
    primary_key id : Int32
    belongs_to specimen : Specimen
    belongs_to specimen_label : SpecimenLabel, foreign_key: :specimenlabel_id
  end
end
