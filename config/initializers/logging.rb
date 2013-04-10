require 'formatted_rails_logger'

FormattedRailsLogger.patch_rails
Rails.logger.formatter = FormattedRailsLogger::Formatter.new