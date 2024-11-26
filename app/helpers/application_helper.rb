module ApplicationHelper

  def gravator_for(user, options = {size: 80}) # If no size is passed at the time of calling then the default size is 80.
    email_address = user.email.downcase
    hash = Digest::SHA256.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"

    image_tag(gravatar_url, alt: user.username)
  end
end
