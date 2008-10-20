# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

require 'gettext/utils'

desc "Update pot/po files to match new version."
task :updatepo do
  GetText.update_pofiles(
    "cbp",
    Dir.glob("{app,lib}/**/*.{rb,rhtml,erb,rjs}"),
    "cbp version"
  )
end

desc "Create mo-files for L10n"
task :makemo do
  GetText.create_mofiles(true, "po", "locale")
end