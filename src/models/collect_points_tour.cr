# 採集地点と採集行の多対多アソシエーションを作るための中間テーブル用モデル
class CollectPointsTour < BaseModel
  skip_default_columns
  table :collect_points_tour do
    primary_key id : Int32
    belongs_to collect_point : CollectPoint, foreign_key: :collectpoint_id
    belongs_to tour : Tour
  end
end
