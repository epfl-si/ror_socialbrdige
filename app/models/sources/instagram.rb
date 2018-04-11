class Instagram < Source
  AUTH_TYPE=:devkey

  def url(path="")
    return "https://www.instagram.com/epflcampus/?__a=1"
  end
  # def fetch(url)
  #   at=self.data["credentials"]
  #   ct=self.data["extra"]["access_token"]["consumer"]
  #   consumer = OAuth::Consumer.new(ct["key"], ct["secret"])
  #   access_token = OAuth::AccessToken.from_hash(consumer, {
  #     oauth_token:        at["token"],
  #     oauth_token_secret: at["secret"],
  #   })
  #   response = access_token.request(:get, url)
  #   response.body
  # end

  def create_default_requests
    self.requests.create(description: "Eerything")
    self.requests.create(description: "Followers count", selection: "graphql user edge_followed_by count")
    self.requests.create(description: "Following count", selection: "graphql user edge_follow count")
  end

end
