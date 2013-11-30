require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'fileutils'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['--backtrace']
end

task :default => :spec

namespace :setup do
  desc 'creates a spec/fixtures/vcr_cassettes directory for testing'
  task :vcr_directory do
   FileUtils.mkpath 'spec/fixtures/vcr_cassettes/'
  end
end