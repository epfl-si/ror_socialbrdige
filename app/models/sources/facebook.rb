class Facebook < Source
  AUTH_TYPE = :oauth

  def url(path)
    t=self.data["credentials"]["token"]
    p=path.empty? ? "" : "/#{path}"
    u="https://graph.facebook.com/#{self.uid}#{p}?redirect=false&access_token=#{t}"
  end
  def expired?
    self.data["credentials"]["expires_at"] < Time.now
  end
  def doc_url
    "https://developers.facebook.com/docs/graph-api/reference"
  end
end
