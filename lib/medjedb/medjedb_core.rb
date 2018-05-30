require_relative 'db_core.rb'
require_relative 'read_csv.rb'

class MedjedbCore
  def initialize(db_path)
    @db_core = DbCore.new(db_path)
  end

  # テーブルを空の状態に初期化
  def init_table()
    @db_core.create_data_master_table
    @db_core.create_eki_code_index_table
  end

  # CSVからデータマスタに登録
  def load_data_master(csv_path)
    ReadCsv.each_row(csv_path) do |row|
      unless row.header_row?
        # キーはカラム0
        # データは対象の行をハッシュで登録
        DataMaster.add(row[0], row.to_hash)
      end
    end
  end

  # CSVから駅データテーブルに登録
  def load_eki_code_index_data(csv_path)
    ReadCsv.each_row(csv_path) do |row|
      unless row.header_row?
        # キーはカラム0
        # 対象の駅名はカラム1
        # 対象のマスタIDはカラム2
        EkiCodeIdx.add(row[0], row[1], row[2])
      end
    end
  end

  # 駅コードを全て取得
  def find_target_eki_codes()
    EkiCodeIdx.get_all_index
  end

  # 対象キーのデータを取得する(Hash)
  def find_information(eki_id)
    dm = DataMaster.find_data(eki_id)

    return {} if dm.nil?
    return dm.get_hash()
  end

  # データの要素数を取得する
  def get_information_length()
    DataMaster.count
  end
end
