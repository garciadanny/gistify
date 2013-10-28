require 'httparty'

module Gistify
  class GithubGist
    GISTS_URL = 'https://api.github.com/gists'

    include HTTParty
    def self.list
      response = get GISTS_URL, headers: {
        'Authorization' => "token #{user_token}"
      }
      p response
      response
    end

  private
    def self.user_token
      token = ''
      File.open home_directory, 'r' do |f|
        f.each_line { |t| token = t}
      end
      token
    end

    def self.home_directory
      File.expand_path '~/.gistify'
    end
  end
end