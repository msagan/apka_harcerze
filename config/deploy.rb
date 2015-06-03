# config valid only for Capistrano 3.1
lock '3.2.1'

set :repo_url, 'git@github.com:msagan/apka_harcerze.git'

set :rvm_type, :system
set :rvm_ruby_version, '2.1.4'

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# Default value for keep_releases is 5
set :keep_releases, 3

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do

  desc 'Restart application'
  task :stop do
    on roles(:app), in: :sequence, wait: 10 do
      execute "/etc/init.d/unicorn stop #{fetch(:full_app_name)}"
    end
  end
  task :start do
    on roles(:app), in: :sequence, wait: 10 do
      execute "/etc/init.d/unicorn start #{fetch(:full_app_name)}"
    end
  end

  after :publishing, :stop
  after :stop, :start

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
