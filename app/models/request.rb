class Request < ApplicationRecord

  belongs_to :source
  before_create :set_token

  after_create :fetch!
  serialize :raw_result, JSON

  def result
    if self.raw_result.nil? or self.raw_result.empty? or self.updated_at < self.agemax.seconds.ago
      FetchSocialJob.perform_later self
      return nil
    end
    r = self.raw_result
    unless self.selection.nil? or self.selection.empty?
      selection.split(" ").each do |ki|
        k,i = ki.split(":")
        return nil unless r.key?(k)
        r = r[k]
        if r.is_a?(Array)
          i = i.nil? ? 0 : i.to_i
          r = r[i]
        end
      end
    end
    return r
  end

  def short_result
    (self.selection.nil? or self.selection.empty?) ? "" : self.result
  end

  def url
    @url ||= begin
      p = self.path_string
      q=self.query_string
      u = self.source.url(p)
      u << "&#{q}" unless q.empty?
      u
    end
  end

  def path_string
    (self.path.nil? or self.path.empty?) ? "" : self.path
  end

  def query_string
    (self.query.nil? or self.query.empty?) ? "" : self.query.split(" ").join("&")
  end

  def expired?
    self.updated_at < self.agemax.seconds.ago
  end

  def age
    (Time.now - self.updated_at).to_i
  end

  def age_percent
    f=100.0*(Time.now - self.updated_at)/self.agemax
    f < 0 ? 0 : ( f > 100 ? 100 : f.to_i)
  end


  # TODO: check result!!!
  def fetch(force=false)
    # q = (self.query.nil? or self.query.empty?) ?  "" : self.query.split(" ").join("&")
    # p = (self.path.nil? or self.path.empty?) ? "" : self.path
    # url = self.oatoken.url(p, q)
    if expired? or force
      if self.source.respond_to?(:fetch)
        res=self.source.fetch(self.url)
      else
        res = `curl '#{self.url}'`
      end
      self.raw_result = JSON.parse(res)
      true
    else
      false
    end
  end

  def fetch!
    if fetch(true)
      save
    else
      false
    end
  end

  def set_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Request.exists?(token: random_token)
    end
  end

end
