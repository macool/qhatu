class UserDecorator < LittleDecorator
  ##
  # default image for gravatar https://en.gravatar.com/site/implement/images#default-image
  GRAVATAR_DEFAULT = "retro"
  GRAVATAR_SIZE = "80"

  def name_short
    @name_short ||= record.name.split(" ").first(2).join(" ")
  end

  ##
  # @!group avatar

  ##
  # size: 35px
  def avatar(opts = {})
    options = opts.merge(class: "avatar #{opts[:class]}")
    image_tag gravatar_url, options
  end

  ##
  # size: 150px
  def avatar_small
    image_tag gravatar_url(size: 300),
              class: "avatar avatar-big"
  end

  def avatar_with_link
    link_to avatar, record_path
  end

  ##
  # @param options [Hash]
  # @option options [Integer] :size eg 300
  def gravatar_url(options = {})
    size = options[:size] || GRAVATAR_SIZE
    "http://www.gravatar.com/avatar/#{email_hexdigest}?d=#{GRAVATAR_DEFAULT}&s=#{size}"
  end

  # @!endgroup
  ##

  private

  def email_hexdigest
    @email_hexdigest ||= Digest::MD5.hexdigest(email)
  end
end
