set :application, "cbpoggle"
set :repository, "deploy@cbpoggle.ath.cx:/var/git/#{application}.git"
set :server_name, "cbpoggle.ath.cx"
set :scm, "git"
set :checkout, "export"
set :deploy_via, :remote_cache
set :branch, "master"
set :base_path, "/var/apps/"
set :deploy_to, "/var/apps/#{application}"
set :apache_site_folder, "/etc/apache2/sites-enabled"
set :user, 'deploy'
set :runner, 'deploy'
set :use_sudo, true
set :keep_releases, 3 

role :web, server_name
role :app, server_name
role :db,  server_name, :primary => true

ssh_options[:paranoid] = false
default_run_options[:pty] = true

after "deploy:setup", "init:set_permissions"
after "deploy:setup", "init:database_yml"
after "deploy:update_code", "config:copy_shared_configurations"

# Overrides for Phusion Passenger
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

# Configuration Tasks
namespace :config do
  desc "copy shared configurations to current"
  task :copy_shared_configurations, :roles => [:app] do
    %w[database.yml].each do |f|
      run "ln -nsf #{shared_path}/config/#{f} #{release_path}/config/#{f}"
    end
  end
end

namespace :init do

  desc "setting proper permissions for deploy user"
  task :set_permissions do
    sudo "chown -R deploy #{base_path}/#{application}"
  end

  desc "create mysql db"
  task :create_database do
    #create the database on setup
    set :db_user, Capistrano::CLI.ui.ask("database user: ") unless defined?(:db_user)
    set :db_pass, Capistrano::CLI.password_prompt("database password: ") unless defined?(:db_pass)
    run "echo \"CREATE DATABASE #{application}_production\" | mysql -u #{db_user} –password=#{db_pass}"
  end

  desc "enable site"
  task :enable_site do
    sudo "ln -nsf #{shared_path}/config/apache_site.conf #{apache_site_folder}/#{application}"

  end

  desc "create database.yml"
  task :database_yml do
    set :db_user, Capistrano::CLI.ui.ask("database user: ")
    set :db_pass, Capistrano::CLI.password_prompt("database password: ")
    database_configuration = %(
—
login: &login
  adapter: sqlite3
  encoding: utf8
  database: db/#{application}_production
  host: localhost
  timeout: 5000

production:
  <<: *login
)
    run "mkdir -p #{shared_path}/config"
    put database_configuration, "#{shared_path}/config/database.yml"
  end

  desc "create vhost file"
  task :create_vhost do

    vhost_configuration = %(

  ServerName #{server_name}
  DocumentRoot #{base_path}/#{application}/current/public

)

    put vhost_configuration, "#{shared_path}/config/apache_site.conf"

  end

end