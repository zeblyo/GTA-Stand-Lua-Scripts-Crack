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

local function write_string_memory(base, addresses, data)
    for _, addr in ipairs(addresses) do 
        memory.write_string(base + addr, data.name)
    end
end

local function write_long_memory(base, addresses, data)
    for _, addr in ipairs(addresses) do 
        memory.write_long(base + addr, data.rid)
    end
end

local gta5_base, socialclub_base = memory.scan("GTA5.exe", "4D 5A"), memory.scan("socialclub.dll", "4D 5A")

-- 偏移表
local offsets = {
    main = {0x01DB10D8, 0xB58, 0x1108, 0x10A8, 0xFC},
    main1 = {0x0270CAB0, 0x5C8, 0xCD0, 0x12C0, 0x1350, 0xE8},
    main2 = {0x02AD98E8, 0x1480, 0xB78, 0x60, 0x7E0, 0xE8},
    gta = {0x2A44444, 0x2F22B4C, 0x2F27D8C, 0x2F25BBF, 0x203C80B, 0x2F2A244, 0x2F29F3F},
    socialclub = {0x463B26, 0x4B8467, 0x4C45E8, 0x4C4730, 0x4CD2C8, 0x4CD410, 0x4DA2EC},
    gta_rid = {0x2F27CC0, 0x2F2EE48, 0x2F29F88, 0x2F27D78, 0x2F25C08, 0x2D91850, 0x2A44430, 0x2A44378, 0x48},
    socialclub_rid = {0x4DD138, 0x4DA2D8, 0x4DA278, 0x4B84B0, 0x3BE8E0},
}


menu.action(menu.my_root(), "改名为GT开发", {"破解GT"}, "", function()
    local GT_data = memory_GT_data[math.random(#memory_GT_data)]
    memory.write_string(read_memory(gta5_base + offsets.main[1], {table.unpack(offsets.main, 2)}), GT_data.name)
    memory.write_long(read_memory(gta5_base + offsets.main1[1], {table.unpack(offsets.main1, 2)}), GT_data.rid)
    memory.write_long(read_memory(gta5_base + offsets.main2[1], {table.unpack(offsets.main2, 2)}), GT_data.rid)
    write_string_memory(gta5_base, offsets.gta, GT_data)
    write_string_memory(socialclub_base, offsets.socialclub, GT_data)
    write_long_memory(gta5_base, offsets.gta_rid, GT_data)
    write_long_memory(socialclub_base, offsets.socialclub_rid, GT_data)
    util.toast("修改成功")
end)

menu.action(menu.my_root(), "改名为daidai Ultimate", {"破解daidai"}, "", function()
    local daidai_data = memory_daidai_data[1]
    memory.write_string(read_memory(gta5_base + offsets.main[1], {table.unpack(offsets.main, 2)}), daidai_data.name)
    write_string_memory(gta5_base, offsets.gta, daidai_data)
    write_string_memory(socialclub_base, offsets.socialclub, daidai_data)
    util.toast("修改成功")
end)
