RSpec.describe Medjedb do
  it "has a version number" do
    expect(Medjedb::VERSION).not_to be nil
  end

  it "データ取得" do
    Medjedb.load("spec/test_db")
    Medjedb.read_csv("spec/")

    expect(Medjedb.get_all_station_data().length).to_not eq 0
    expect(Medjedb.get_information(0)).not_to be nil
  end
end
