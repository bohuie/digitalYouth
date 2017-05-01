# config valid only for current version of Capistrano
lock '3.8.0'

require "whenever/capistrano"

set :application, 'digitalYouth'
set :repo_url, 'https://github.com/bohuie/digitalYouth'
set :deploy_to, '/srv/www/vhosts/ubc.ca/ok/jobcannon/html/public'
#set :tmp_dir, '/srv/www/vhosts/ubc.ca/ok/jobcannon/html/public/tmp'
#set :tmp_dir, '~/tmp'
set :branch, "admin"
#set :branch, ENV.fetch('REVISION', 'admin')

set :linked_files, %w(config/application.yml)
set :linked_dirs, %w{public}

set :stages, "production"

#set :rvm_type, :system

#set :default_environment, {
# 'PATH' =>  "/home/edgemap/.rvm/gems/ruby-2.3.0/bin:/home/edgemap/.rvm/gems/ruby-2.3.0@global/bin:/home/edgemap/.rvm/rubies/ruby-2.3.0/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/edgemap/.rvm/bin:/home/edgemap/bin:/home/edgemap/.rvm/bin",
# 'RUBY_VERSION' => 'ruby 2.3.0@default',
# 'GEM_HOME' => "/home/edgemap/.rvm/gems/ruby-2.3.0",
# 'GEM_PATH' => "/home/edgemap/.rvm/gems/ruby-2.3.0:/home/edgemap/.rvm/gems/ruby-2.3.0@global"
#}
#set :rvm_type, :user
#set :rvm_ruby_version, '2.3.0-p0'
#set :rvm_custom_path, '/usr/local/rvm'

#set :user, "rodnearl"
#set :scm_password, ENV['SERVER_PASSWORD']

set :rails_env, "production"
set :deploy_via, :copy
set :keep_releases, 5

set :assets_roles, [:web, :app] 

server "edgemap.ok.ubc.ca", :roles => [:app, :web, :db], :primary => true, user: 'edgemap'


namespace :deploy do

  desc "Symlink the application.yml file"
  task :symlink_config do
    on roles(:app) do
      execute "ln -s /srv/www/vhosts/ubc.ca/ok/jobcannon/application.yml #{current_path}/application.yml"
    end

    desc "reload the database with seed data"
    task :seed do
      run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
    end
  end
 # after :restart, :clear_cache do
  #  on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
   # end
  #end

end
