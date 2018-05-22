require "json"
require "active_record"
 
class DbCore < ActiveRecord::Migration[4.2]
  def initialize(db_name)
    @name = db_name
 
    # DBの接続
    # self.abstract_class = true
    ActiveRecord::Base.establish_connection(
      "adapter" => "sqlite3",
      "database" => db_name)
  end
 
  # テーブル削除
  def delete_table(table_name)
    if (table_exists?(table_name))
      drop_table(table_name)
    end
  end
 
  # マスタテーブルを作成
  def create_data_master_table()
    # 既に存在していたら削除する
    if (table_exists?(:data_masters))
      drop_table(:data_masters)
    end

    create_table(:data_masters, primary_key: :master_id) do |t|
      t.text :json_string
    end
  end
 
  # 駅コードのインデックステーブルを作成する
  def create_eki_code_index_table()
    # 既に存在していたら削除する
    if (table_exists?(:eki_code_idxes))
      drop_table(:eki_code_idxes)
    end

    create_table(:eki_code_idxes, primary_key: :eki_id) do |t|
      t.text :station_name
      t.references(:data_masters)
    end
  end
 
  # デバッグ用(SQLを直接実行)
  def exec_sql(sql)
    execute sql
  end
end
 
# データマスタテーブルのモデル
class DataMaster < ActiveRecord::Base
  # クラスメソッド
  def self.add(master_id, data_hash)
    self.create(master_id: master_id, json_string: data_hash.to_json)
  end

  def self.find_data(master_id)
    begin
      return self.find(master_id)
    rescue => e
      return nil
    end
  end

  # インスタンスメソッド
  def get_hash()
    JSON.parse(json_string)
  end
end
 
# 駅インデックステーブルのモデル
# TODO(mogi) : 複合キー対応した方がよいかも
class EkiCodeIdx < ActiveRecord::Base
  # クラスメソッド
  def self.add(eki_id, station_name, master_id)
    self.create(eki_id: eki_id, station_name: station_name, data_masters_id: master_id)
  end

  def self.get_all_index()
    all
  end

  # インスタンスメソッド
  def get_eki_id()
    eki_id
  end

  def get_station_name()
    station_name
  end

  def get_master_id()
    data_masters_id
  end
end
