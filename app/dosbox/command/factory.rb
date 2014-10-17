module DOSBox
	module Command
		class Factory
      attr_reader :commands

      # :nocov:
			def initialize(drive)
				@commands = Array.new

				@commands << CmdCd.new("cd", drive)
        @commands << CmdDir.new("dir", drive)
        @commands << CmdMkDir.new("mkdir", drive)
        @commands << CmdMkFile.new("mkfile", drive)
        @commands << CmdMkFile.new("mf", drive)
			end
      # :nocov:
		end
	end
end