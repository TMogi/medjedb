require 'spec_helper.rb'
require_relative '../lib/medjedb/medjedb_core.rb'

RSpec.describe MedjedbCore do
  before :all do
    # データ初期化
    @db = MedjedbCore.new("spec/test_db")
    @db.init_table
    @db.load_data_master("spec/master.csv")
    @db.load_eki_code_index_data("spec/eki.csv")
  end
  
  context "駅データテスト" do
    it "登録されているデータを全て読み込む" do
      expect(@db.find_target_eki_codes().length()).to eq(3)
    end
  end

  context "マスタテスト" do
    it "キーが存在するときはHash形式でデータを返す" do
      data = @db.find_information(0)
      expect(data["sample0"]).to eq("test0")
      expect(data["sample1"]).to eq("test1")
      expect(data["sample2"]).to eq("test2")
      expect(data["sample3"]).to eq("test3")
    end

    it "キーが存在しない場合は空のHashを返す" do
      expect(@db.find_information(99).empty?).to be_truthy
    end
  end
end
