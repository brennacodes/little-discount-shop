require 'httparty'

class GithubService
  attr_reader :base_url

  def initialize
    @token = get_token
    @base_url = "https://api.github.com/repos/brennacodes/little-esty-shop"
  end

  def get_info(path)
    response = HTTParty.get(github_url(path), headers: {"User-Agent" => "brennacodes", "Authorization" => "token #{@token}"})
    JSON.parse(response.body, symbolize_names: true)
  end

  private
    def get_token
      "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"
    end

    def github_url(path)
      url = base_url.concat(path)
      url
    end
end
