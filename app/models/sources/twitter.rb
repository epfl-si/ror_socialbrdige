class Twitter < Source
  AUTH_TYPE=:oauth

  def url(path)
    return "https://api.twitter.com/1.1/#{path}.json?"
  end
  def fetch(url)
    at=self.data["credentials"]
    ct=self.data["extra"]["access_token"]["consumer"]
    consumer = OAuth::Consumer.new(ct["key"], ct["secret"])
    access_token = OAuth::AccessToken.from_hash(consumer, {
      oauth_token:        at["token"],
      oauth_token_secret: at["secret"],
    })
    response = access_token.request(:get, url)
    response.body
  end
  def doc_url
    "https://developer.twitter.com/en/docs/accounts-and-users/follow-search-get-users/overview"
  end
  def public_data
    self.data["raw_info"]
  end
end
