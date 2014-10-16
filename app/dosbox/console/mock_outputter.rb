module DOSBox
  module Console
    class MockOutputter
      attr_reader :number_of_printed_chars, :output

      def initialize
        @output = ''
        @number_of_printed_chars = 0
      end

      def println(text)
        self.analyse_printed_chars(text)
      end

      def newline
        # do nothing
      end

      def printnl(text)
        self.analyse_printed_chars(text)
      end

      def has_characters_printed
        return @number_of_printed_chars > 0
      end

      def reset_stats
        @number_of_printed_chars = 0
      end

      def analyse_printed_chars(text)
        @number_of_printed_chars += text.length
        @output += text
      end
    end
  end
end