# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ArelLab::Application.load_tasks

desc "Starts up a Pry console"
task :console do
	Pry.start
end