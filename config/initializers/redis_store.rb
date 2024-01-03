# Rails.application.config.session_store :redis_store

# option 2
#   config.session_store :redis_store,
#   servers: ["#{ENV['REDIS_URL']}/session"],
#   expire_after: 90.minutes,
#   key: "_#{Rails.application.class.module_parent_name.downcase}_session",
#   secure: true,
#   class: Session