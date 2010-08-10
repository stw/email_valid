require 'bundler'
Bundler.setup

#require 'rspec/core/rake_task'
#Rspec::Core::RakeTask.new(:spec)

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => [:clean, :test]

desc 'Test the email_valid plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'profile'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Clean up files.'
task :clean do |t|
  FileUtils.rm_rf "doc"
  FileUtils.rm_rf "tmp"
  FileUtils.rm_rf "pkg"
  FileUtils.rm "test/test.log" rescue nil
  Dir.glob("email_valid-*.gem").each{|f| FileUtils.rm f }
end

desc 'Generate documentation for the email_valid plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'Email::Valid'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

gemspec = eval(File.read("email_valid.gemspec"))

task :gem   => "#{gemspec.full_name}.gem"
task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["email_valid.gemspec"] do
  system "gem build email_valid.gemspec"
  system "gem install email_valid-#{Email::VERSION}.gem"
end
