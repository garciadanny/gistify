require "gistify/version"

require 'gistify/cli'
require 'gistify/githubauth'
require 'gistify/githubgist'

module Gistify
  TOKEN_LOCATION = File.expand_path '~/.gistify'
  GISTS_URL = 'https://api.github.com/gists'
  AUTHORIZATIONS_URL = 'https://api.github.com/authorizations'
end
