module Constantinopolis
  module RailsReloader
    extend self

    def register(klass, yml)
      unless Rails.env.production?
        reloader = file_update_checker.new([yml]) do
          klass.reload!
        end
        Rails.application.reloaders << reloader

        active_reloader.to_prepare do
          reloader.execute_if_updated
        end
      end
    end

    def file_update_checker
      case Rails.version[0]
      when '4' then ActiveSupport::FileUpdateChecker
      when '5' then Rails.application.config.file_watcher || ActiveSupport::FileUpdateChecker
      else raise 'Unsupported rails version!'
      end
    end

    def active_reloader
      case Rails.version[0]
      when '4' then ActionDispatch::Reloader
      when '5' then ActiveSupport::Reloader
      else raise 'Unsupported rails version!'
      end
    end
  end
end
