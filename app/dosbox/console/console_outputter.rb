module DOSBox
	module Console
		class ConsoleOutputter
      attr_reader :number_of_printed_chars

      def initialize
        @number_of_printed_chars = 0
      end

			def println(text)
				puts text
        self.analyse_printed_chars(text)
			end

			def newline
				puts
			end

			def printnl(text)
				print text
				STDOUT.flush
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
      end
		end
	end
end