module DOSBox
	module FileSystem
		class Directory < FileSystemItem
      attr_reader :content

      def initialize(name)
				super(name, nil)
        @content = Array.new
      end

      def add(file_system_item)
        if has_another_parent(file_system_item)
          remove_parent(file_system_item)
        end

        @content << file_system_item
        file_system_item.parent= self
      end

      def remove(file_system_item)
        if @content.include? file_system_item
          file_system_item.parent= nil
          @content.delete(file_system_item)
        end
      end

      def num_of_contained_dirs
        num_of_dirs = 0

        @content.each do |item|
          if item.is_directory?
            num_of_dirs+=1
          end
        end

        num_of_dirs
      end

      def num_of_contained_files
        num_of_files = 0

        @content.each do |item|
          unless item.is_directory?
            num_of_files+=1
          end
        end

        num_of_files
      end

      def is_directory?
        true
      end

      def size
        0
      end

      private

        def remove_parent(file_system_item)
          file_system_item.parent.content.delete(file_system_item)
        end

        def has_another_parent(file_system_item)
          not file_system_item.parent.nil?
        end
    end
	end
end