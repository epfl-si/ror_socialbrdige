OmniAuth.config.path_prefix = "/socialbridge/auth"
Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # avail scopes: https://developers.facebook.com/docs/facebook-login/permissions
  root_path="/socialbridge"
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: "email,public_profile,user_friends"
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'] #, :scope => 'r_fullprofile r_emailaddress r_network'

  # https://developers.google.com/identity/protocols/googlescopes
  provider :google_oauth2,   ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'],
    {
      include_granted_scopes: true,
      scope: 'email, profile, userinfo.profile, plus.me, plus.login, plus.circles.read, http://gdata.youtube.com',
      prompt: 'select_account',
      # image_aspect_ratio: 'square',
      # image_size: 50
    }
end
