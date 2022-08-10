class GithubSearch
  def repo_name
    @_repo_name ||= fetch_info[:name]
  end

  def collaborators
    @_collaborators ||= fetch_info("/assignees").map { |data| data[:login] }
  end

  def commits_count(contributor)
    names = @_collaborators.to_h { |name| [name.to_sym, name]}
    @_commits ||= fetch_info("/stats/contributors").map do |data|
      person = data[:author][:login]
      if names.keys.include?(person.to_sym)
        names[person.to_sym] = data[:total]
      end
    end
    names[contributor.to_sym] ? names[contributor.to_sym] : 0
  end

  def pull_request_count
    @_pull_request_count ||= fetch_info("/pulls?state=all").first[:number] 
  end

  private
    def service
      GithubService.new
    end

    def fetch_info(info = "")
      service.get_info(info)
    end
end