require 'logger'

module Pharos
  module Kube
    module Logging
      LOG_TARGET = STDERR
      LOG_LEVEL = Logger::WARN

      module ModuleMethods
        # global log_level shared across all including classes
        def log_level
          @log_level
        end
        def log_level=(level)
          @log_level = level
        end
        def debug!
          self.log_level = Logger::DEBUG
        end
        def verbose!
          self.log_level = Logger::INFO
        end
        def quiet!
          self.log_level = Logger::ERROR
        end
      end

      extend ModuleMethods # global @log_level

      module ClassMethods
        def logger(target: LOG_TARGET, level: nil)
          @logger ||= Logger.new(target).tap do |logger|
            logger.progname = self.name
            logger.level = level || self.log_level || Pharos::Kube::Logging.log_level || LOG_LEVEL
          end
        end
      end

      def self.included(base)
        base.extend(ModuleMethods) # per-class @log_level
        base.extend(ClassMethods)
      end

      # Use per-instance logger
      def logger!(progname: self.class.name, target: LOG_TARGET, level: nil, debug: false)
        @logger = Logger.new(target).tap do |logger|
          level = Logger::DEBUG if debug

          logger.progname = "#{self.class.name}<#{progname}>"
          logger.level = level || self.class.log_level || Pharos::Kube::Logging.log_level || LOG_LEVEL
        end
      end

      # @return [Logger]
      def logger
        @logger || self.class.logger
      end
    end
  end
end
