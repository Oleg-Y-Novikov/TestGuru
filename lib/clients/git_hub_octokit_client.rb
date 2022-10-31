# frozen_string_literal: true

class GitHubOctokitClient

  def initialize
    Octokit.configure do |c|
      c.connection_options = {
        request: {
          open_timeout: 5,
          timeout: 5
        }
      }
    end
    @http_client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end

  def create_gist(gist_params)
    @http_client.create_gist(gist_params)
  rescue Octokit::Error
    false
  end
end
