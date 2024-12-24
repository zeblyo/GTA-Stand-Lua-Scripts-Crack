local memory_GT_data = {
    {name = "SmallGodGirlo3o", rid = 175334217},
    {name = "Brook-Hill", rid = 102631625},
    {name = "Mag7777V", rid = 242332672},
    {name = "Magicswordstar", rid = 130940398},
    {name = "Selee555", rid = 227734475}
}

local memory_daidai_data = {
    {name = "az3zpz", rid = 0},
}

local function read_memory(address, offsets)
    local current_address = address
    for _, offset in ipairs(offsets) do
        current_address = memory.read_long(current_address)
        if current_address == 0 then return nil end
        current_address = current_address + offset
    end
    return current_address
end

local function write_memory(base, addresses, data)
    for _, addr in ipairs(addresses) do 
        memory.write_string(base + addr, data.name)
    end
end

local gta5_base, socialclub_base = memory.scan("GTA5.exe", "4D 5A"), memory.scan("socialclub.dll", "4D 5A")

-- 偏移表
local offsets = {
    main = {0x209D810, 0x830, 0x60, 0x2E8, 0xFC},
    gta = {0x2A44444, 0x2F22B4C, 0x2F27D8C, 0x2F25BBF, 0x203C80B, 0x2F2A244, 0x2F29F3F},
    socialclub = {0x463B26, 0x4B8467, 0x4C45E8, 0x4C4730, 0x4CD2C8, 0x4CD410, 0x4DA2EC}
}


menu.action(menu.my_root(), "改名为GT开发", {"破解GT"}, "", function()
    local GT_data = memory_GT_data[math.random(#memory_GT_data)]
    memory.write_string(read_memory(gta5_base + offsets.main[1], {table.unpack(offsets.main, 2)}), GT_data.name)
    write_memory(gta5_base, offsets.gta, GT_data)
    write_memory(socialclub_base, offsets.socialclub, GT_data)
    memory.write_long(gta5_base + 0x2F27CC0, GT_data.rid)
    util.toast("修改成功")
end)

menu.action(menu.my_root(), "改名为daidai Ultimate", {"破解daidai"}, "", function()
    local daidai_data = memory_daidai_data[1]
    memory.write_string(read_memory(gta5_base + offsets.main[1], {table.unpack(offsets.main, 2)}), daidai_data.name)
    write_memory(gta5_base, offsets.gta, daidai_data)
    write_memory(socialclub_base, offsets.socialclub, daidai_data)
    util.toast("修改成功")
end)
