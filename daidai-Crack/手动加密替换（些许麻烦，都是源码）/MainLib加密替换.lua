-- 读取输入文件
local inputFilePath = filesystem.scripts_dir() .. "MainLib.lua"  -- 请替换为您要加密的文件路径
local file = assert(io.open(inputFilePath, "r"), "无法打开输入文件")
local content = file:read("*all")
file:close()

-- 加密过程
function requlre(input)
    local result = {}
    for i = 1, #input do
        local char = input:sub(i, i)
        table.insert(result, string.char(char:byte() + 3))
    end
    local lua = table.concat(result)
    return lua
end

-- 将加密结果写入输出文件
local outputFilePath = filesystem.scripts_dir() .. "lib\\SakuraScript\\MainLib.lua"
local outputFile = assert(io.open(outputFilePath, "w"), "无法创建输出文件")
outputFile:write(requlre(content))
outputFile:close()

print("加密完成，结果已保存到 " .. outputFilePath)
