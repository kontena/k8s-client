require 'logger'

module K8s
  module Logging
    LOG_TARGET = STDERR
    LOG_LEVEL = Logger::WARN

    module ModuleMethods
      # global log_level shared across all including classes
      # @return Logger::*
      def log_level
        @log_level
      end

      # @param level Logger::*
      def log_level=(level)
        @log_level = level
      end

      # Set log_level to Logger::DEBUG
      def debug!
        self.log_level = Logger::DEBUG
      end

      # Set log_level to Logger::INFO
      def verbose!
        self.log_level = Logger::INFO
      end

      # Set log_level to Logger::ERROR, surpressing any warnings logged by default
      def quiet!
        self.log_level = Logger::ERROR
      end
    end

    extend ModuleMethods # global @log_level

    module ClassMethods
      # @return [Logger]
      def logger(target: LOG_TARGET, level: nil)
        @logger ||= Logger.new(target).tap do |logger|
          logger.progname = self.name
          logger.level = level || self.log_level || K8s::Logging.log_level || LOG_LEVEL
        end
      end
    end

    # extend class/intance methods for per-class logger
    def self.included(base)
      base.extend(ModuleMethods) # per-class @log_level
      base.extend(ClassMethods)
    end

    # Use per-instance logger instead of the default per-class logger
    #
    # Sets the instance variable returned by #logger
    #
    # @return [Logger]
    def logger!(progname: self.class.name, target: LOG_TARGET, level: nil, debug: false)
      @logger = Logger.new(target).tap do |logger|
        level = Logger::DEBUG if debug

        logger.progname = "#{self.class.name}<#{progname}>"
        logger.level = level || self.class.log_level || K8s::Logging.log_level || LOG_LEVEL
      end
    end

    # @return [Logger]
    def logger
      @logger || self.class.logger
    end
  end
end
