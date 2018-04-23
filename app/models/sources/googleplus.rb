# TODO: can be oauthized: https://developers.google.com/+/web/api/rest/oauth
class Googleplus < Source
  AUTH_TYPE=:key

  def url(path)
    t=self.uid
    p=path.empty? ? "" : "/#{path}"
    "https://www.googleapis.com/plus/v1#{p}?key=#{t}"
  end

  def doc_url
    "https://developers.google.com/+/web/api/rest/latest/"
  end
end


    # epfl_google_plus_id = '109621066282825581538'
    # api_key = 'AIzaSyBD1NRcrOY0acsRnuXTV_3KFic_d5KvamM'

    # api_url = r"https://www.googleapis.com/plus/v1/people/%(id)s?fields=plusOneCount&key=%(api_key)s" % {
    #     'id': epfl_google_plus_id,
    #     'api_key': api_key
    # }

