# coding: ascii-8bit
module Xploitlib

  module Pack
    
    PACK_HASH = {
      byte: ['c', 1],
      ubyte: ['C', 1],
      word: ['s', 2],
      uword: ['S', 2],
      dword: ['l', 4],
      udword: ['L', 4],
      qword: ['q', 8],
      uqword: ['Q', 8]
    }

    def p8(*data)
      pack(data, :ubyte)
    end

    def pi8(*data)
      pack(data, :byte)
    end

    def p16(*data)
      pack(data, :uword)
    end

    def pi16(*data)
      pack(data, :word)
    end
    
    def p32(*data)
      pack(data, :udword)
    end

    def pi32(*data)
      pack(data, :dword)
    end
     
    def p64(*data)
      pack(data, :uqword)
    end

    def pi64(*data)
      pack(data, :qword)
    end

    def u8(*data)
      unpack(data, :ubyte)
    end

    def ui8(*data)
      unpack(data, :byte)
    end

    def u16(*data)
      unpack(data, :uword)
    end

    def ui16(*data)
      unpack(data, :word)
    end

    def u32(*data)
      unpack(data, :udword)
    end
     
    def ui32(*data)
      unpack(data, :dword)
    end

    def u64(*data)
      unpack(data, :uqword)
    end
     
    def ui64(*data)
      unpack(data, :qword)
    end
    
    def pack(data, type)
      data.flatten.pack("#{PACK_HASH[type][0]}*")
    end
    
    def unpack(data, type)
      
      tempchar, tempbyte = PACK_HASH[type]
      
      data = data.flatten.map do |d|
        unless (pad_size = d.bytesize % tempbyte) == 0
          pad_size = d.bytesize + tempbyte - (d.bytesize % tempbyte)
        end
        d.ljust(pad_size, "\x00").unpack("#{tempchar}*")
      end
      
      data.flatten
      
    end
    
  end
  
end
