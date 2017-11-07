# coding: ascii-8bit

module Xploitlib
  
  class Libc

    def initialize(path)
      
      @func = {}
      @string = {}
      
      res = `nm -t d -D #{path}`.split("\n")
      res.each do |line|
        offset, name = line.match(/(.+) . (.+)/)[1,2]
        @func[name] = offset.to_i
      end
      
      res = `strings -tx -a -t d #{path}`.split("\n")
      res.each do |line|
        offset, name = line.match(/(.+) (.+)/)[1,2]
        @string[name] = offset.to_i
      end
      
    end
     
    def symbol(key)
      
      if key.class != String
        raise ArgumentError
      end
      
      if @func.keys.include?(key)
        @func[key]
      else
        raise ArgumentError, "Not found symbol: #{key}"
      end
      
    end
     
    def string(key)
      
      if key.class != String
        raise ArgumentError
      end
      
      if @string.keys.include?(key)
        @string[key]
      else
        raise ArgumentError, "Not found string: #{key}"
      end
      
    end
    
  end

end
