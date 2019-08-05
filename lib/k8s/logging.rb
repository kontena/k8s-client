# frozen_string_literal: true

require 'logger'

module K8s
  # Logging utilities
  #
  # This provides a per-class Logger that uses the class name as a logging prefix.
  # Instances can optionally also use logger! to define a per-instance Logger using a custom prefix.
  module Logging
    # Default log target
    LOG_TARGET = $stderr

    # Default log level: show warnings.
    #
    # Use K8s::Logging.quiet! to supress warnings.
    # Note that the K8s::Transport defaults to quiet!
    LOG_LEVEL = Logger::WARN

    # methods defined on both the global K8s::Logging module, as well as class methods on each class including K8s::Logging
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

    # methods defined on each class including K8s::Logging
    module ClassMethods
      # @return [Logger]
      def logger(target: LOG_TARGET, level: nil)
        @logger ||= Logger.new(target).tap do |logger|
          logger.progname = name
          logger.level = level || log_level || K8s::Logging.log_level || LOG_LEVEL
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
