module DOSBox
  module Console
    class MockOutputter < ConsoleOutputter

      def println(text)
        self.analyse_printed_chars(text)
      end

      def newline
        # do nothing
      end

      def printnl(text)
        self.analyse_printed_chars(text)
      end

    end
  end
end