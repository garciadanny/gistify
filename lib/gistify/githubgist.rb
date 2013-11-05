require 'httparty'
require 'hirb'

module Gistify
  class GithubGist
    GISTS_URL = 'https://api.github.com/gists'

    include HTTParty
    def self.list
      response = get GISTS_URL, headers: {
        'Authorization' => "token #{user_token}"
      }
      print_response parse(response)
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

    def self.parse response
      response.map do |gist|
        url         = gist['html_url']
        file_names  = gist['files'].map(&:first)
        description = gist['description']

        {'Filename(s)' => file_names, 'Description' => description, 'URL' => url}
      end
    end

    def self.print_response parsed_response
      puts Hirb::Helpers::Table.render parsed_response, number: true, resize: false
    end
  end
end