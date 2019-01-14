GravatarImageTag.configure do |config|
  config.include_size_attributes = true  # The height and width attributes of the generated img will be set to avoid page jitter as the gravatars load.  Set to false to leave these attributes off.
  config.size                    = 150   # Set this to globally set the size of the gravatar image returned (1..512). Gravatar's default is 80
end
