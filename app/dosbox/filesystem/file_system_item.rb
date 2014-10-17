module DOSBox
	module FileSystem
		class FileSystemItem
      attr_reader :name
      attr_accessor :parent

      ILLEGAL_ARGUMENT_TEXT = "Error: A file or directory name may not contain '/', '\\', ',', ' ' or ':'"

			def initialize(name, parent)
        self.name= name

				@parent= parent
			end

			def path
				unless @parent.nil?
					path = @parent.path + "\\" + @name
				else # For root directory
					path = @name;
				end
			
				return path
      end

      def name=(name)
        unless check_name(name)
          raise ArgumentError, ILLEGAL_ARGUMENT_TEXT
        end

        @name = name
      end

      def check_name(name)
        if /[\\\/,[:blank:]]/.match(name)
          return false
        end
        return true
      end

      def to_s
        self.path
      end

		end
	end
end