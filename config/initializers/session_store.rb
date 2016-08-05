# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_acti_session', domain: ENV['DOMAIN']
Rails.application.config.session_store :redis_session_store, {
  key: '_a_c_t_i_session',
  redis: {
    db: 2,
    expire_after: 6.months,
    key_prefix: 'acti:session:'
  }
}
