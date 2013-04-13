module UsersHelper

  # Returns the gravatar image for the given user (based on email).
  def gravatar_for(user, options = { size: 50 })
    # Generate the MD5 hash upon which the url is based.
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    # Create a full url for the location of the gravatar image.
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # Create an html image of the gravatar with alt text
    # of the user's name and an appropriate class.
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
