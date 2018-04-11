Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # avail scopes: https://developers.facebook.com/docs/facebook-login/permissions
  fb_opts={
    scope: "email,public_profile,user_friends"
  }
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], fb_opts #,
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'] #,
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'] #, :scope => 'r_fullprofile r_emailaddress r_network'

    #   {
    #   :secure_image_url => 'true',
    #   :image_size => 'original',
    #   :authorize_params => {
    #     :force_login => 'true',
    #     :lang => 'pt'
    #   }
    # }

end
