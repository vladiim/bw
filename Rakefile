require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:sequel)
PadrinoTasks.init
require File.dirname(__FILE__) + '/config/boot.rb'
require 'thor'
require 'padrino-core/cli/rake'

PadrinoTasks.init

namespace :heroku do
  task :console do
    Bundler.with_clean_env { sh 'heroku run -a blackwhite padrino console' }
  end
  task c: [:console]

  task :migrate do
    Bundler.with_clean_env { sh 'heroku run sq:migrate' }
  end
  task m: [:migrate]

  task :push do
    Bundler.with_clean_env do
      sh 'git push heroku master'
      Rake::Task['heroku:migrate'].invoke
    end
  end
end