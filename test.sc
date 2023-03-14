using import C.stdio
using import .capnproto-codec

local file = (fopen "msg.bin" "rb")
local message = (Message.from-fd file)
let date = ('getRoot message)
let year = ('get message date 0 i16)
let month = ('get message date 2 u8)
let day = ('get message date 3 u8)

print year month day
