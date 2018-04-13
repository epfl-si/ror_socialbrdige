class Youtube < Source
  AUTH_TYPE=:devkey

  def url(path)
    t=self.uid
    p=path.empty? ? "" : "/#{path}"
    "https://www.googleapis.com/youtube/v3#{p}?key=#{t}"
  end
  def doc_url
    "https://developers.google.com/youtube/v3/docs/channels/list"
  end
end
