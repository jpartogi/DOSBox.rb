module DOSBox
	module FileSystem
		class Drive
      attr_accessor :label
      attr_reader :current_dir, :root_dir

			def initialize(drive_letter)
				@drive_letter = drive_letter[0,1].upcase
				@label = ''
				@root_dir = Directory.new(drive_letter + ':')
				@current_dir = @root_dir
			end

			def prompt
				@current_dir.path + '\>'
      end

      def drive_letter
        @drive_letter + ':'
      end

      def change_current_dir(dir)
        if item_from_path(dir.path) == dir
          @current_dir = dir
          return true
        end
        false
      end

      def item_from_path(item_path)
        item_path.gsub! /\//, "\\"
        item_path.strip!

        # Remove '\' from the end of the path
        if item_path[item_path.length-1].eql? '\\' and item_path.length >= 2
          item_path = item_path[0..item_path.length-2]
        end

        return @root_dir if item_path.eql? '\\'

        if item_path.eql? '..'
          parent_dir = @current_dir.parent
          if parent_dir.nil?
            parent_dir = @root_dir
          end
          return parent_dir
        end

        return @current_dir if item_path.eql? '.'

        if item_path.length >= 2 and item_path[0..1].eql? ".\\"
          item_path = item_path[2..item_path.length]
        end

        if item_path.length >= 3 and item_path[0..2].eql? "..\\"
          item_path = @current_dir.parent.path + "\\" + item_path[3..item_path.length]
        end

        item_path = @drive_letter + ":" + item_path if item_path[0].eql? '\\'

        item_path = @current_dir.path + "\\" + item_path if item_path.length.eql? 1 or not item_path[1].eql? ':'

        return @root_dir if item_path.eql? @root_dir.path

        return item_from_dir(item_path, @root_dir)
      end

      def save
        # Not yet implemented
      end

      def restore
        # Not yet implemented
      end

      def create_from_real_dir(path)
        # Not yet implemented
      end

      def to_s
        @drive_letter
      end

      private
        def item_from_dir(item_name, dir)
          content = dir.content # Array

          content.each do |item|
            path = item.path

            return item if path.downcase.eql? item_name.downcase

            if item.is_directory?
              value = item_from_dir(item_name, item)

              return value unless value.nil?
            end
          end

          nil
        end
		end
	end
end