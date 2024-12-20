-- 读取输入文件
local inputFilePath = filesystem.scripts_dir() .. "GLogo.lua"  -- 请替换为您要加密的文件路径
local file = assert(io.open(inputFilePath, "r"), "无法打开输入文件")
local content = file:read("*all")
file:close()

-- 加密过程
local function encrypt(text, key)
    local result = {}
    local mask = key % 256
    for i = 1, #text do
        result[i] = string.char(text:byte(i) ~ mask)
    end
    return table.concat(result)
end

local encrypted = encrypt(content, 7963178524)

-- 将加密结果写入输出文件
local outputFilePath = filesystem.scripts_dir() .. "\\lib\\GTLuaVIP\\GTC\\logo\\GLogo.lua"
local outputFile = assert(io.open(outputFilePath, "w"), "无法创建输出文件")
outputFile:write(encrypted)
outputFile:close()

print("加密完成，结果已保存到 " .. outputFilePath)
