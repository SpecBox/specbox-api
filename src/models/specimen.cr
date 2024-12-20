class Specimen < BaseModel
  skip_default_columns
  table :specimens do
    primary_key id : UUID
    column date_last_modified : Time, autogenerated: true
    column user_id : Int32?
    # 標本ID
    column collection_code : Int32 = 0
    # 同定者
    column identified_by : String = "", allow_blank: true
    # 同定年月日
    # 年月日がセットになっているDC最新版に準拠
    column date_identified : Time = Time.local
    # 採集者
    column collecter : String = "", allow_blank: true
    # 採集年
    # 項目名のシンプルなDC最新版に準拠
    column year : Int32 = 0
    # 採集月
    # 同上
    column month : Int32 = 0
    # 採集日
    # 同上
    column day : Int32 = 0
    # 標本の性別
    # M=オス、F=メス、H=両性、I=不確定、U=不明、T=転移
    column sex : String = "U", allow_blank: true
    # 標本の種類(乾燥、液浸など)
    column preparation_type : String = "dry specimens", allow_blank: true
    # 現在の標本の状況 DC最新版準拠
    column disposition : String = "", allow_blank: true
    # 採集方法 DC最新版準拠
    column sampling_protocol : String = "", allow_blank: true
    # 採集中の作業メモ DC最新版準拠
    column sampling_effort : String = "", allow_blank: true
    # ライフステージ DC最新版準拠
    column lifestage : String = "", allow_blank: true
    # 生成プロセス(wildなど)
    column establishment_means : String = "", allow_blank: true
    # ライセンス
    column rights : String = "", allow_blank: true

    # 以上でGBIFベースのカラム定義終了
    # 以下はオリジナルの定義
    # カスタム分類情報
    belongs_to custom_taxon_info : Taxon?
    # デフォルト分類情報
    belongs_to default_taxon_info : Taxon?
    # 採集地点情報
    belongs_to collect_point_info : CollectPoint?
    # コレクション設定情報
    belongs_to collection_settings_info : CollectionSetting?
    # 所属する採集行
    belongs_to tour : Tour?
    # 備考
    column note : String = "", allow_blank: true
    # 個人収蔵.com様への投稿の可否
    column allow_kojin_shuzo : Bool = false
    # 個人収蔵.com様へ投稿済みか?
    column published_kojin_shuzo : Bool = false
    # 画像
    column image1 : String?
    column image2 : String?
    column image3 : String?
    column image4 : String?
    column image5 : String?
  end

  # 分類群別集計用サブタイプクラス
  class PercentageTaxon
    include DB::Serializable
    property taxon_name : String
    property taxon_count : Int64
    property taxon_percentage : Float64
  end

  # 採集地点別集計用サブタイプクラス
  class PercentageCollectPoint
    include DB:: Serializable
    property collect_point_name : String
    property collect_point_count : Int64
    property collect_point_percentage : Float64
  end
end
