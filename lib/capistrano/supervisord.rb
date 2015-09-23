require 'capistrano/supervisord/supervisord'

load File.expand_path('../tasks/deploy.rake', __FILE__)

namespace :load do
  task :defaults do
    load 'capistrano/supervisord/defaults.rb'
  end
end
