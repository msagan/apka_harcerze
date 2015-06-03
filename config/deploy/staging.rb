role :app, %w{193.107.90.136}
role :web, %w{193.107.90.136}
role :db,  %w{193.107.90.136}

server '193.107.90.136', user: 'apka-harcerze', roles: %w{web app db}

set :application, "apka-harcerze"
set :rails_env, 'production'
set :branch, "master"
set :full_app_name, 'apka-harcerze'
set :deploy_to,  "/home/#{fetch(:full_app_name)}/www/"
