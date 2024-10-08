# frozen_string_literal: true

threads_count = Integer(ENV["RAILS_MAX_THREADS"] || 3)
threads threads_count, threads_count

rails_env = ENV.fetch("RAILS_ENV", "development")
environment rails_env

case rails_env
when "production"
  require "concurrent-ruby"
  workers_count = Integer(ENV.fetch("WEB_CONCURRENCY") { Concurrent.available_processor_count })
  workers workers_count if workers_count > 1

  preload_app!
when "development"
  worker_timeout 3600
end

# To restart: `bin/pwpush restart`
plugin :tmp_restart

port ENV.fetch("PORT", 5100)
