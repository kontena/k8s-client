require 'logger'

module Pharos
  module Kube
    module Logging
      LOG_TARGET = STDERR
      LOG_LEVEL = Logger::WARN

      # global log_level shared across all including classes
      def self.log_level
        @log_level ||= LOG_LEVEL
      end
      def self.log_level=(level)
        @log_level = level
      end
      def self.debug!
        self.log_level = Logger::DEBUG
      end
      def self.verbose!
        self.log_level = Logger::INFO
      end
      def self.quiet!
        self.log_level = Logger::ERROR
      end

      module ClassMethods
        def logger(target: LOG_TARGET, level: Pharos::Kube::Logging.log_level)
          @logger ||= Logger.new(target).tap do |logger|
            logger.progname = self.name
            logger.level = level
          end
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      # Use per-instance logger
      def logger!(progname: self.class.name, target: LOG_TARGET, level: Pharos::Kube::Logging.log_level, debug: false)
        @logger = Logger.new(target).tap do |logger|
          logger.progname = "#{self.class.name}<#{progname}>"
          logger.level = debug ? Logger::DEBUG : level
        end
      end

      # @return [Logger]
      def logger
        @logger || self.class.logger
      end
    end
  end
end
