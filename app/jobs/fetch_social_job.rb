class FetchSocialJob < ApplicationJob
  queue_as :default

  def perform(request)
    request.fetch
  end
end
