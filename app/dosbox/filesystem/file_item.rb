module DOSBox
  module FileSystem
    class FileItem < FileSystemItem
      attr_reader :content

      def initialize(name, content)
        super(name, nil)
        @content = content
      end

      def size
        @content.length
      end

      def is_directory?
        false
      end
    end
  end
end