Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = true
Sequel::Model.db = case Padrino.env
  when :development then Sequel.connect("postgres://localhost/bw_development", :loggers => [logger])
  when :production  then Sequel.connect(ENV['PRODUCTION_DB'],                  :loggers => [logger])
  when :test        then Sequel.connect("postgres://localhost/bw_test",        :loggers => [logger])
end