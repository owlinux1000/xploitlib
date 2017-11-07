# coding: ascii-8bit

module Xploit

  NULL                = 0
  STDIN_FILENO        = 0
  STDOUT_FILENO       = 1
  STDERR_FINENO       = 2
  SEEK_SET            = 0
  SEEK_CUR            = 1
  SEEK_END            = 2
  O_RDONLY            = 00000
  O_WRONLY            = 00001
  O_RDWR              = 00002
  O_CREAT             = 00100
  O_APPEND            = 02000
  PROT_NONE           = 0b000
  PROT_READ           = 0b001
  PROT_WRITE          = 0b010
  PROT_EXEC           = 0b100
  PROT_RWX            = 0b111
  MAP_SHARED          = 0b001
  MAP_PRIVATE         = 0b010
  MAP_ANONYMOUS       = 0x20
  PREV_INUSE          = 0b001
  IS_MMAPED           = 0b010
  IS_NON_MAINARENA    = 0b100

end
