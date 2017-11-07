# Xploit

## Usage

```
require 'xploit'

host = 'localhost'
port = 8888

if ARGV[0] == "r" # remote
  host = 'remote.host'
  port = 9999
end

Sock.open(host, port) do |s|

  s.debug = true # default false	

  puts s.recvline
  
  s.sendline("Here is shellcode")
  
  s.shell
  
end
```

## Dependency

* [GNU Binutils](https://www.gnu.org/software/binutils/)
