# Medjedb

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/medjedb`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'medjedb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install medjedb

## Usage

所定の場所に以下のCSVファイルを用意してください。
```
master.csv
eki.csv
```

DB(sqlite3)に接続します。
DBが存在しない場合は生成されます。
```ruby
Medjedb.load("PATH_TO_DATABASE")
```

CSVからDBにデータを読み込みます。
結果はDBで保持されるため、毎回読み直す必要はありません。
CSVのデータが更新されたとき、読み直す必要があります。
```ruby
# default
# - {CURRENT_DIR}/csv/master.csv
# - {CURRENT_DIR}/csv/eki.csv
Medjedb.read_csv()

# Use other path to dir 
# - {PATH_TO_DIR}/master.csv
# - {PATH_TO_DIR}/eki.csv
Medjedb.read_csv("PATH_TO_DIR")
```

DBに登録されている駅情報を全てDBから取得します。
駅名とデータID(駅に紐づく情報へアクセスするためのID)のハッシュを配列として取得します。
```ruby
#ex.
Medjedb.get_all_station_data()
#=> [{"駅名"=>"station0", "データID"=>0}, {"駅名"=>"station1", "データID"=>1}, {"駅名"=>"station2", "データID"=>0}]
```

データIDに関連する情報をDBから取得します。
得られるデータはハッシュ形式で、読み込んだmaster.csvに依存します。
```ruby
#ex.
Medjedb.get_information(0)
#=> {"ID"=>0, "パラメータ1"=>"test0", "sample1"=>"test1", "sample2"=>"test2", "sample3"=>"test3"}
```

データの個数は `get_infomation_count()` で取得できます。
```ruby
#ex.
Medjedb.get_information(1)
#=> {"id"=>"1", "パラメータ1"=>"test0", "sample1"=>"test1", "sample2"=>"test2", "sample3"=>"test3"}
Medjedb.get_information(2)
#=> {"id"=>"2", "パラメータ1"=>"test0", "sample1"=>"test1", "sample2"=>"test2", "sample3"=>"test3"}
Medjedb.get_information(3)
#=> {}
Medjedb.get_information_count()
#=> 3
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/medjedb.
