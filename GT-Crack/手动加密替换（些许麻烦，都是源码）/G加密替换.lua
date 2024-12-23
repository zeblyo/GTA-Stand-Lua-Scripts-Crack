-- 读取输入文件
local inputFilePath = filesystem.scripts_dir() .. "G.lua"  -- 请替换为您要加密的文件路径
local file = assert(io.open(inputFilePath, "r"), "无法打开输入文件")
local content = file:read("*all")
file:close()

-- 加密过程
local function encrypt(con, k)
    local ebd = {}
    for i = 1, #con do
        local cr = con:byte(i)
        local ept = cr ~ (k % 256)
        table.insert(ebd, string.char(ept))
    end
    return table.concat(ebd)
end

local encrypted = encrypt(content, 7963178524)

-- 将加密结果写入输出文件
local outputFilePath = filesystem.scripts_dir() .. "\\lib\\GTLuaVIP\\G.lua"
local outputFile = assert(io.open(outputFilePath, "w"), "无法创建输出文件")
outputFile:write(encrypted)
outputFile:close()

print("加密完成，结果已保存到 " .. outputFilePath)
