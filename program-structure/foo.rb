#!/usr/bin/env ruby
#
#

#def save_file(filename, contents)
#  File.open(filename, "w+"){|file| file.puts contents }
#end
#
#
#def append_to_file(filename, msg)
#  contents = File.read filename
#  save_file(filename, contents << msg)
#end
#
#
#now = Time.now
#append_to_file "bingo.txt", now.to_s


class Thing
    attr_reader :filename
    def initialize(filename)
        @filename = filename
    end
    def append(msg)
        contents = File.read filename
        save_file(msg)
    end
    def save_file(contents)
        File.open(filename, "a"){|f| f.puts contents }
    end
end

thing = Thing.new("bingo.txt")
thing.append Time.now
thing.append Time.now
thing.append Time.now
thing.append Time.now
