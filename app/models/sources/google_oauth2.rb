class Google_oauth2 < Source
  AUTH_TYPE=:oauth
  def self.nice_name
    "Google"
  end

  def url(path)
    # For some reason, I cannot get v2 api to work: "Not enough permissions to access /me GET"
    # return "https://api.linkedin.com/v2/#{path}?"
    return "https://www.googleapis.com/plus/v1/#{path}?#{self.data['credentials']['token']}"
  end
  def fetch(url)
    ctk=ENV['GOOGLE_KEY']
    cts=ENV['GOOGLE_SECRET']
    at = {access_token: self.data["credentials"]["token"]}
    consumer = OAuth2::Client.new(ctk, cts)
    access_token = OAuth2::AccessToken.from_hash(consumer, at)
    response = access_token.request(:get, url)
    response.body
  end
  def doc_url
    "https://developers.google.com/apis-explorer/#p/plus/v1/"
  end
  def name
    "Google"
  end

  def expire_at
    self.data["credentials"]["expires_at"]
  end

end
