if ['development', 'test'].include?(Rails.env)
  if ENV.fetch('ENABLE_REMOTE_DEBUG', "0") == "1"
    require 'ruby-debug-ide'
    require 'debase'

    Rails.logger.info "loaded: ruby-debug-ide"
  else
    require 'pry-rails'
    require 'pry-byebug'

    Rails.logger.info "loaded: pry-byebug"
  end
end
