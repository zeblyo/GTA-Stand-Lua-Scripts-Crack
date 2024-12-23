local memory_name = "RhymeBear"
--local memory_rid = tostring(math.random(100000000, 999999999))
--------------GT改为RhymeBear--------------
--------------daidai改为az3zpz--------------

local function read_memory(address, offsets)
    local current_address = address
    for _, offset in ipairs(offsets) do
        current_address = memory.read_long(current_address)
        if current_address == 0 then return nil end
        current_address = current_address + offset
    end
    return current_address
end

local function write_memory(base, addresses)
    for _, addr in ipairs(addresses) do 
        memory.write_string(base + addr, memory_name)
    end
end

local gta5_base, socialclub_base = memory.scan("GTA5.exe", "4D 5A"), memory.scan("socialclub.dll", "4D 5A")

-- 偏移表
local offsets = {
    main = {0x209D810, 0x830, 0x60, 0x2E8, 0xFC},
    gta = {0x2A44444, 0x2F22B4C, 0x2F27D8C, 0x2F25BBF, 0x203C80B, 0x2F2A244, 0x2F29F3F},
    socialclub = {0x463B26, 0x4B8467, 0x4C45E8, 0x4C4730, 0x4CD2C8, 0x4CD410, 0x4DA2EC}
}

memory.write_string(read_memory(gta5_base + offsets.main[1], {table.unpack(offsets.main, 2)}), memory_name)
write_memory(gta5_base, offsets.gta)
write_memory(socialclub_base, offsets.socialclub)
memory.write_long(gta5_base + 0x2F27CC0, 227946978)

util.toast("修改成功")
