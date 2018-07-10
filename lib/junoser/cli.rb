require 'parslet'
require 'junoser/display'
require 'junoser/input'
require 'junoser/parser'


module Junoser
  module Cli
    class << self
      def commit_check(io_or_string)
        config = Junoser::Input.new(io_or_string).read

        if Junoser::Display.display_set?(config)
          commit_check_display_set config
        else
          commit_check_structured config
        end
      end

      def commit_check_lines(io_or_string)
        input = Junoser::Input.new(io_or_string)
        config = input.read

        unless Junoser::Display.display_set?(config)
          abort 'This option supports "display-set" format only'
        end

        commit_check_lines_display_set(config, input.read(false))
      end

      def display_set(io_or_string)
        Junoser::Display::Set.new(io_or_string).transform
      end

      def struct(io_or_string)
        Junoser::Display::Structure.new(io_or_string).transform
      end


      private

      def commit_check_structured(config)
        Junoser::Display::Set.new(config).commit_check
      end

      def commit_check_display_set(config)
        parser = Junoser::Parser.new
        parser.parse_lines(config)
      end

      def commit_check_lines_display_set(config, original_config)
        parser = Junoser::Parser.new
        parser.parse_and_report_lines(config, original_config)
      end
    end
  end
end
