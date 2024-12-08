local encodingTable = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
    "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", "\n", "\t",
    "-", "_", "=", "+", "[", "]", "{", "}", "(", ")", ",", ".", ":", ";",
    "\"", "'", "/", "\\", "|", "?"
}

-- 创建反向查找表
local reverseTable = {}
for i, v in ipairs(encodingTable) do
    reverseTable[v] = i - 1
end

-- 读取输入文件
local inputFilePath = filesystem.scripts_dir() .. "C.lua"  -- 请替换为您要加密的文件路径
local file = assert(io.open(inputFilePath, "r"), "无法打开输入文件")
local content = file:read("*all")
file:close()

-- 加密过程
local encrypted = {}
for i = 1, #content do
    local char = content:sub(i, i)
    local code = reverseTable[char]
    if code then
        table.insert(encrypted, tostring(code))
    else
        table.insert(encrypted, "-1")
        table.insert(encrypted, tostring(string.byte(char)))
    end
end

-- 将加密结果写入输出文件
local outputFilePath = filesystem.scripts_dir() .. "lib\\GTSCRIPTS\\C.lua"
local outputFile = assert(io.open(outputFilePath, "w"), "无法创建输出文件")
outputFile:write(table.concat(encrypted, "|/|/|/|/|/|"))
outputFile:close()

print("加密完成，结果已保存到 " .. outputFilePath)
