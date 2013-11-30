require 'thor'
require 'io/console'

module Gistify
  class CLI < Thor
    package_name "Gistify"
    desc 'login', 'Creates an oauth token'
    def login
      GithubAuth.login username, password
    end

    desc 'list', 'Lists all your gists'
    def list
      GithubGist.list
    end

    desc 'file [FILENAME]', 'Creates a gist of the specified file'
    method_option :description, type: :string, aliases: '-d'
    def file file_name
      GithubGist.file file_name, options[:description]
    end

    private
    def username
      ask 'GitHub username: '
    end

    def password
      $stdin.noecho { ask 'Password: ' }
    end
  end
end

