-- 读取输入文件
local inputFilePath = filesystem.scripts_dir() .. "GLogo.lua"  -- 请替换为您要加密的文件路径
local file = assert(io.open(inputFilePath, "r"), "无法打开输入文件")
local content = file:read("*all")
file:close()

-- 加密过程
local enc = function(data)
    local result = {}
    for i = 1, #data do
        local byte = string.byte(data, i)
        table.insert(result, string.char(byte + 3)) 
    end
    return table.concat(result)
end

function enc_f(ipf, opf)
    local file = io.open(ipf, "rb")
    if not file then
        error("无法打开文件")
    end
    local data = file:read("*a")
    file:close()
    local encrypted_data = enc(data)
    local output = io.open(opf, "wb")
    if not output then
        error("无法创建文件")
    end
    output:write(encrypted_data)
    output:close()
end

-- 将加密结果写入输出文件
local outputFilePath = filesystem.scripts_dir() .. "\\lib\\GTSCRIPTS\\GTC\\logo\\GLogo.lua"
local outputFile = assert(io.open(outputFilePath, "w"), "无法创建输出文件")
outputFile:write(content)
outputFile:close()
enc_f(outputFilePath, outputFilePath)
print("加密完成，结果已保存到 " .. outputFilePath)


