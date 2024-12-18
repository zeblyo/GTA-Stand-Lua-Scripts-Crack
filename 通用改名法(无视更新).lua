local memory_name = "RhymeBear"
--------------GT改为RhymeBear--------------
--------------daidai改为az3zpz--------------

local gta_addr, socialclub_addr = {0x2A44444, 0x2F22B4C, 0x2F27D8C, 0x2F25BBF}, {0x463B26, 0x4B8467, 0x4C45E8, 0x4C4730, 0x4CD2C8, 0x4CD410, 0x4DA2EC}
local gta5_base, socialclub_base = memory.scan("GTA5.exe", "4D 5A"), memory.scan("socialclub.dll", "4D 5A")
local function write_memory(base, addresses)
    for _, addr in ipairs(addresses) do memory.write_string(base + addr, memory_name) end
end
write_memory(gta5_base, gta_addr)
write_memory(socialclub_base, socialclub_addr)
util.toast("修改成功")
