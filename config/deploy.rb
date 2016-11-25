set :application, 'acti'
set :repo_url, 'git@github.com:renhe1990/acti.git'
set :branch, 'master'
set :deploy_to, '/home/amwaysite4/rails_apps/acti'
set :scm, :git
set :keep_releases, 10

# Default value for :pty is false
# set :pty, true

set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

require 'capistrano-db-tasks'

# if you haven't already specified
set :rails_env, "production"

# if you want to remove the local dump file after loading
set :db_local_clean, true

# if you want to remove the dump file from the server after downloading
set :db_remote_clean, true

# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
set :assets_dir, 'public/uploads'
set :local_assets_dir, 'public'

set :puma_init_active_record, true
set :puma_workers, 2

# if you want to work on a specific local environment (default = ENV['RAILS_ENV'] || 'development')
# set :locals_rails_env, "production"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
