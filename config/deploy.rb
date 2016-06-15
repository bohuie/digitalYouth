# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'digitalYouth'
set :repo_url, 'https://github.com/bohuie/digitalYouth'
set :deploy_to, '/srv/www/vhosts/ubc.ca/ok/jobcannon/html/public'
#set :tmp_dir, '/srv/www/vhosts/ubc.ca/ok/jobcannon/html/public/tmp'

set :scm, :git
set :branch, "master"

set :linked_files, %w(config/application.yml)


#set :default_environment, {
#	'PATH' => "/usr/local/rvm/gems/ruby-2.3.0/bin:/usr/local/rvm/gems/ruby-2.3.0@global/bin:/usr/local/rvm/rubies/ruby-2.3.0/bin:/usr/local/rvm/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/UBC-O/rodnearl/bin",
#	'RUBY_VERSION' => 'ruby 2.3.0',
#	'GEM_HOME' => "/usr/local/rvm/gems/ruby-2.3.0",
#	'GEM_PATH' => "/usr/local/rvm/gems/ruby-2.3.0:/usr/local/rvm/gems/ruby-2.3.0@global"
#}
#set :rvm_type, :user
#set :rvm_ruby_version, '2.3.0-p0'
#set :rvm_custom_path, '/usr/local/rvm'

#set :user, "rodnearl"
#set :scm_password, ENV['SERVER_PASSWORD']

set :rails_env, "production"
set :deploy_via, :copy
set :keep_releases, 5

server "jobcannon.ok.ubc.ca", :roles => [:app, :web, :db], :primary => true, user: 'rodnearl'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

	desc "Symlink the application.yml file"
	task :symlink_config do
		on roles(:app) do
			execute "ln -s /srv/www/vhosts/ubc.ca/ok/jobcannon/application.yml #{current_path}/application.yml"
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
