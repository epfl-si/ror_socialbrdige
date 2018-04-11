class Linkedin < Source
  AUTH_TYPE=:oauth

  def url(path)
    # For some reason, I cannot get v2 api to work: "Not enough permissions to access /me GET"
    # return "https://api.linkedin.com/v2/#{path}?"
    return "https://api.linkedin.com/v1/#{path}?format=json"
  end
  def fetch(url)
    ctk=ENV['LINKEDIN_KEY']
    cts=ENV['LINKEDIN_SECRET']
    at = {access_token: self.data["credentials"]["token"]}
    consumer = OAuth2::Client.new(ctk, cts)
    access_token = OAuth2::AccessToken.from_hash(consumer, at)
    response = access_token.request(:get, url)
    response.body
  end
  def doc_url
    "https://developer.linkedin.com/docs/rest-api"
  end
end
