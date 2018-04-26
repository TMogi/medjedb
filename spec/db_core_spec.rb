require 'spec_helper.rb'
require_relative '../lib/medjedb/db_core.rb'

RSpec.describe DbCore do
  

  it "DataMasterの動作確認" do

    # データ初期化
    test_db = DbCore.new("spec/test_db")

    test_db.create_data_master_table()
    test_db.create_eki_code_index_table()

    DataMaster.add(0, {name: "テスト0", text: "サンプルデータ0"})
    DataMaster.add(1, {name: "テスト1", text: "サンプルデータ1"})
    DataMaster.add(2, {name: "テスト2", text: "サンプルデータ2"})
    DataMaster.add(3, {name: "テスト3", text: "サンプルデータ3"})

    EkiCodeIdx.add(0, 0)
    EkiCodeIdx.add(1, 1)
    EkiCodeIdx.add(2, 2)
    EkiCodeIdx.add(3, 3)

    dm = DataMaster.find_data(0)
    p dm.get_hash
    expect(dm.get_hash["name"]).to eq("テスト0")
    expect(dm.get_hash["text"]).to eq("サンプルデータ0")

    test_db.delete_table(:data_masters)
    test_db.delete_table(:eki_code_idxes)
  end
end
