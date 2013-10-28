require 'rubygems' if RUBY_VERSION <= "1.8.7"

$:.unshift File.expand_path("../../lib", __FILE__)
$:.unshift File.expand_path("../../spec", __FILE__)

require 'gistify'
require 'vcr'
require 'support/helper_methods'

spec_dir = File.join(FileUtils.pwd, 'spec/fixtures')
VCR.configure do |c|
  c.cassette_library_dir = File.join(spec_dir, 'vcr_cassettes')
  c.hook_into :webmock
end


RSpec.configure do |c|
  c.include Gistify::HelperMethods
end