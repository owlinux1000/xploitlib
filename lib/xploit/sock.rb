# coding: ascii-8bit

require 'socket'
require 'hexdump'

module Xploit
  
  class SendError < StandardError; end
  class RecvError < StandardError; end
   
  class Sock
   
    attr_accessor :debug, :timeout
    
    def initialize(host, port, timeout = nil, debug = false)
      @sock = TCPSocket.open(host, port)
      @timeout = 0.5
      @debug = debug
      puts "[\e[32m*\e[0m] Connect to #{host}:#{port}"
    end
   
    def self.open(host, port, timeout = nil, debug = false)
      if block_given?
        s = Sock.new(host, port, timeout, debug)
        yield(s)
        s.close
      else
        Sock.new(host, port, timeout, debug)
      end
    end
   
    def send(data, debug = false)
      
      @debug = debug
      
      puts "[\e[34m SEND \e[0m]" if @debug
      len = @sock.write(data)
      raise SendError if len != data.bytesize
                 
      Hexdump.dump(data) if @debug
   
      return len
   
    end
   
    def sendline(msg, debug = false)
      send(msg + "\n", debug = debug)
    end
   
    def recv(n = nil, delim = nil, debug = false)
      
      @debug = debug
      puts "[ \e[35mRECV\e[0m ]" if @debug
      
      unless n.nil?
        res = @sock.read(n)
        Hexdump.dump(res) if @debug
        return res
      end
      
      res = ""
      while select([@sock], nil, nil,timeout=@timeout)
        s = @sock.read(1)
        raise RecvError if s.length != 1
        res << s
        break res if not delim.nil? and res.include?(delim)
      end
      
      Hexdump.dump(res) if @debug
      
      res
      
    end
   
    def recvuntil(delim, debug = false)
      self.recv(n = nil, delim, debug)
    end
   
    def recvline(debug = false)
      recvuntil("\n", debug)
    end
    
    def shell
      STDOUT.sync = true
      while s = STDIN.gets
        self.send(s, @debug)
        puts self.recv(n = nil, delim = nil, debug = @debug)
      end
    end
   
    def close
      puts "[\e[32m*\e[0m] Close the connection"
      @sock.close
    end
    
  end
end
