require "gistify/version"

require 'gistify/githubauth'
require 'gistify/githubgist'
require 'cli'

module Gistify
  TOKEN_LOCATION = File.expand_path '~/.gistify'
  GISTS_API_URL = 'https://api.github.com/gists'
  AUTHORIZATIONS_URL = 'https://api.github.com/authorizations'
end
