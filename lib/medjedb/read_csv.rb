require 'csv'

# 文字コードはUTF8を想定
module ReadCsv
  # CSVの読み込み
  def self.each_row(csv_path)
    fail("対象のファイルは存在しません.") unless File.exist?(csv_path)

    CSV.foreach(csv_path, headers: true) do |row|
      # 処理は実行側で受け持つこと
      yield(row)
    end
  end
end
