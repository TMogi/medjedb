require "medjedb/version"
require "medjedb/medjedb_core.rb"

module Medjedb
  # DBを読み込む
  def self.load(db_path)
    @medjedb_core = MedjedbCore.new(File.expand_path(db_path))
  end

  # CSVデータの読み込み
  def self.read_csv(csv_dir = "csv/")
    raise "DBが初期化されていません." if (!@medjedb_core)

    @medjedb_core.init_table()
    master_csv_path = File.expand_path(File.join(csv_dir, "master.csv"))
    eki_csv_path = File.expand_path(File.join(csv_dir, "eki.csv"))

    raise "#{master_csv_path} が存在しません." if (!File.exist?(master_csv_path))
    raise "#{eki_csv_path} が存在しません." if (!File.exist?(eki_csv_path))

    @medjedb_core.load_data_master(master_csv_path)
    @medjedb_core.load_eki_code_index_data(eki_csv_path)
  end

  # 最寄駅情報を全て取得する(Hash)
  def self.get_all_station_data()
    raise "DBが初期化されていません." if (!@medjedb_core)

    @medjedb_core.find_target_eki_codes().map do |eki|
      {station_name: eki.get_station_name(), info_id: eki.get_master_id()}
    end
  end

  # 対象IDのデータを取得する(Hash)
  def self.get_information(info_id)
    raise "DBが初期化されていません." if (!@medjedb_core)

    @medjedb_core.find_information(info_id)
  end
end
