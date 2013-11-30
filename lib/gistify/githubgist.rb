require 'httparty'
require 'hirb'

module Gistify
  class GithubGist

    include HTTParty

    def self.list
      response = get GISTS_API_URL, headers: {
          'Authorization' => "token #{user_token}",
          'User-Agent'   =>  'garciadanny'
      }
      print_response parse(response)
    end

    def self.file file_name
      pwd = FileUtils.pwd
      file_location = File.join pwd, "/#{file_name}"
      if File.exists?(file_location)
        file_contents = read_file_contents file_location
        create_gist file_name, file_contents
      else
        file_not_found
      end
    end

    private
    def self.user_token
      File.read TOKEN_LOCATION
    end

    def self.parse response
      response.map do |gist|
        url = gist['html_url']
        file_names = gist['files'].map(&:first)
        description = gist['description']

        {'Filename(s)' => file_names, 'Description' => description, 'URL' => url}
      end
    end

    def self.print_response parsed_response
      puts Hirb::Helpers::Table.render parsed_response, number: true, resize: false
    end

    def self.read_file_contents path
      File.read path
    end

    def self.create_gist file_name, file_contents
      headers = {'Authorization' => "token #{user_token}", 'User-Agent' => 'garciadanny'}
      body = {
          description: "did this work",
          public: true,
          files: {
            "#{file_name}" => {
              content: file_contents
            }
          }
      }
      response = post GISTS_API_URL, {
          headers: headers,
          body: body.to_json
      }
       p response['html_url']
    end

    def self.file_not_found
      raise FileNotFound, "File not found. Please make sure to `cd` into the file's directory"
    end
  end

  class FileNotFound < StandardError; end
end