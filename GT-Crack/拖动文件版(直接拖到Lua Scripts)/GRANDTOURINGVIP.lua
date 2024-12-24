local files_content = [[
local R0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1
R0_1 = nil
L1_1 = nil
L2_1 = nil
L3_1 = nil
L4_1 = nil
L5_1 = nil
L6_1 = nil
L7_1 = nil
L8_1 = nil
L9_1 = nil
L10_1 = nil
L11_1 = nil
L12_1 = nil
L13_1 = nil
L14_1 = nil
L15_1 = nil
L16_1 = nil
L17_1 = nil
L18_1 = nil
L19_1 = nil
L20_1 = nil
L21_1 = nil
L22_1 = nil
L23_1 = nil
L24_1 = nil
L25_1 = nil
L26_1 = nil
L27_1 = nil
L28_1 = nil
L29_1 = nil
L30_1 = nil
L31_1 = nil
R0_1 = "\\GTLuaVIP"
L1_1 = "[GRANDTOURINGVIP]\n"
L2_1 = "选中禁止访问互联网时,GTLua将不可用 不知道怎么办?启动脚本下面的禁止访问互联网开关看到没?"
L3_1 = "把它关掉\n还不知道在哪?启动脚本按钮往下数到最后一个按钮"
L4_1 = "加载失败"
L5_1 = "发生错误"
function L32_1(A0_2)
  local L1_2, L2_2
  L1_2 = error
  L2_2 = A0_2
  L1_2(L2_2)
end
L6_1 = 24
L7_1 = filesystem
function L33_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = io
  L1_2 = L1_2.open
  L2_2 = A0_2
  L3_2 = "r"
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L2_2 = L32_1
    L3_2 = L5_1
    L2_2(L3_2)
  end
  return L1_2
end
L8_1 = 256
function L34_1(A0_2)
  local L1_2, L2_2, L3_2
  L2_2 = A0_2
  L1_2 = A0_2.read
  L3_2 = "*all"
  return L1_2(L2_2, L3_2)
end
function L35_1(A0_2)
  local L1_2, L2_2
  L2_2 = A0_2
  L1_2 = A0_2.close
  L1_2(L2_2)
end
function L36_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = io
  L1_2 = L1_2.open
  L2_2 = A0_2
  L3_2 = "w"
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L2_2 = L32_1
    L3_2 = L5_1
    L2_2(L3_2)
  end
  return L1_2
end
L10_1 = loadfile
L11_1 = util
function L37_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L3_2 = A0_2
  L2_2 = A0_2.write
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
function L38_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L37_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = L35_1
  L3_2 = A0_2
  L2_2(L3_2)
end
L12_1 = async_http
L13_1 = 858
function L39_1(A0_2, A1_2)
  local L2_2
  L2_2 = L8_1
  L2_2 = A1_2 % L2_2
  L2_2 = A0_2 ~ L2_2
  return L2_2
end
L40_1 = "/json.php"
L14_1 = "\\GTA\\tr.lua"
function L41_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = ""
  L3_2 = 1
  L4_2 = #A0_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L8_2 = A0_2
    L7_2 = A0_2.byte
    L9_2 = L6_2
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = L39_1
    L9_2 = L7_2
    L10_2 = A1_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = L2_2
    L10_2 = string
    L10_2 = L10_2.char
    L11_2 = L8_2
    L10_2 = L10_2(L11_2)
    L9_2 = L9_2 .. L10_2
    L2_2 = L9_2
  end
  return L2_2
end
L31_1 = 796
L42_1 = L7_1.scripts_dir
L42_1 = L42_1()
L9_1 = L42_1
L15_1 = L11_1.toast
L42_1 = L1_1
L43_1 = L2_1
L44_1 = L3_1
L42_1 = L42_1 .. L43_1 .. L44_1
L16_1 = L42_1
function L42_1(A0_2, A1_2)
  local L2_2
  L2_2 = L8_1
  L2_2 = A1_2 % L2_2
  L2_2 = A0_2 ~ L2_2
  return L2_2
end
function L43_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = ""
  L3_2 = 1
  L4_2 = #A0_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L8_2 = A0_2
    L7_2 = A0_2.byte
    L9_2 = L6_2
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = L42_1
    L9_2 = L7_2
    L10_2 = A1_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = L2_2
    L10_2 = string
    L10_2 = L10_2.char
    L11_2 = L8_2
    L10_2 = L10_2(L11_2)
    L9_2 = L9_2 .. L10_2
    L2_2 = L9_2
  end
  return L2_2
end
L17_1 = L10_1
L18_1 = L15_1
L19_1 = "\\lib"
L44_1 = "111.180.201.144"
L20_1 = "have_access"
L30_1 = 31
L45_1 = L31_1
L46_1 = L30_1
L45_1 = L45_1 .. L46_1
L21_1 = L45_1
L45_1 = L9_1
L46_1 = L19_1
L45_1 = L45_1 .. L46_1
function L46_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = L33_1
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L34_1
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = L41_1
  L6_2 = L4_2
  L7_2 = A2_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = L36_1
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L7_2 = L38_1
  L8_2 = L6_2
  L9_2 = L5_2
  L7_2(L8_2, L9_2)
end
L47_1 = L21_1
L48_1 = L13_1
L49_1 = L6_1
L47_1 = L47_1 .. L48_1 .. L49_1
L22_1 = L47_1
function L47_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = L33_1
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L34_1
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = L43_1
  L6_2 = L4_2
  L7_2 = A2_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = L36_1
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L7_2 = L38_1
  L8_2 = L6_2
  L9_2 = L5_2
  L7_2(L8_2, L9_2)
end
L48_1 = "http://"
L23_1 = L17_1
L24_1 = L18_1
L49_1 = L12_1[L20_1]
L49_1 = L49_1()
L25_1 = L49_1
function L49_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2
  if not A0_2 or "" == A0_2 then
    return
  end
  if not A1_2 then
    A1_2 = nil
  end
  if not A2_2 then
    function L4_2()
      local R0_3, L1_3
    end
    A2_2 = L4_2
  end
  if not A3_2 then
    function L4_2()
      local R0_3, L1_3
      return
    end
    A3_2 = L4_2
  end
  L4_2 = async_http
  L4_2 = L4_2.init
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = A3_2
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = async_http
  L4_2 = L4_2.dispatch
  L4_2()
end
L50_1 = L45_1
L51_1 = R0_1
L50_1 = L50_1 .. L51_1
L26_1 = L50_1
function L50_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = L33_1
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L34_1
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = L43_1
  L6_2 = L4_2
  L7_2 = A2_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = A1_2
  L7_2 = L36_1
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  L8_2 = L38_1
  L9_2 = L7_2
  L10_2 = L5_2
  L8_2(L9_2, L10_2)
  L8_2 = pcall
  function L9_2()
    local R0_3, L1_3
    R0_3 = L23_1
    L1_3 = L6_2
    R0_3 = R0_3(L1_3)
    R0_3()
  end
  L8_2, L9_2 = L8_2(L9_2)
  if not L8_2 then
    L10_2 = L32_1
    L11_2 = L4_1
    L10_2(L11_2)
  end
end
L27_1 = L26_1
L28_1 = L22_1
function L51_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = A0_2
  L4_2 = A1_2
  L3_2 = L3_2 .. L4_2
  L4_2 = L50_1
  L5_2 = L3_2
  L6_2 = L3_2
  L7_2 = A2_2
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = L46_1
  L5_2 = L3_2
  L6_2 = L3_2
  L7_2 = A2_2
  L4_2(L5_2, L6_2, L7_2)
end
function L52_1()
  local R0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  function R0_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    if 200 == A2_3 then
      L3_3 = L27_1
      L4_3 = L14_1
      L3_3 = L3_3 .. L4_3
      L4_3 = io
      L4_3 = L4_3.open
      L5_3 = L3_3
      L6_3 = "w"
      L4_3 = L4_3(L5_3, L6_3)
      if L4_3 then
        L6_3 = L4_3
        L5_3 = L4_3.write
        L7_3 = A0_3
        L5_3(L6_3, L7_3)
        L6_3 = L4_3
        L5_3 = L4_3.close
        L5_3(L6_3)
        L5_3 = L51_1
        L6_3 = L5_3
        L7_3 = L27_1
        L8_3 = L14_1
        L9_3 = L28_1
        L6_3(L7_3, L8_3, L9_3)
      end
    end
  end
  L1_2 = L48_1
  L2_2 = L44_1
  L1_2 = L1_2 .. L2_2
  L2_2 = L49_1
  L3_2 = L1_2
  L4_2 = L40_1
  L5_2 = R0_2
  L2_2(L3_2, L4_2, L5_2)
end
L29_1 = L25_1
if L29_1 then
  L53_1 = L52_1
  L53_1()
else
  L53_1 = L24_1
  L54_1 = L16_1
  L53_1(L54_1)
  return
end
]]

local outfile = assert(io.open(filesystem.scripts_dir() .. "gtfuckyou.lua", "w"), "无法创建输出文件")
outfile:write(files_content)
outfile:close()

function showError(message)
  error(message)
end

function openFileForReading(filename)
  local file = io.open(filename, "r")
  if not file then showError("发生错误") end
  return file
end

function readFileContent(file)
  return file:read("*all")
end

function closeFile(file)
  file:close()
end

function openFileForWriting(filename)
  local file = io.open(filename, "w")
  if not file then showError("发生错误") end
  return file
end

function writeToFile(file, content)
  file:write(content)
end

function writeAndCloseFile(file, content)
  writeToFile(file, content)
  closeFile(file)
end

function transformByte(value, key)
  local result = 256
  result = key % result
  result = value ~ result
  return result
end

function encryptContent(input, key)
  local result = ""
  for i = 1, #input, 1 do
    local byte = input:byte(i)
    local transformed = transformByte(byte, key)
    result = result .. string.char(transformed)
  end
  return result
end

function decryptByte(value, key)
  local modulus = 256
  local result = key % modulus
  result = value ~ result
  return result
end

function decryptContent(input, key)
  local result = ""
  for i = 1, #input, 1 do
    local byte = input:byte(i)
    local transformed = decryptByte(byte, key)
    result = result .. string.char(transformed)
  end
  return result
end

function encryptFile(sourceFile, destFile, key)
  local file = openFileForReading(sourceFile)
  local content = readFileContent(file)
  local transformedContent = encryptContent(content, key)
  local outputFile = openFileForWriting(destFile)
  writeAndCloseFile(outputFile, transformedContent)
end

function decryptFile(sourceFile, destFile, key)
  local file = openFileForReading(sourceFile)
  local content = readFileContent(file)
  local transformedContent = decryptContent(content, key)
  local outputFile = openFileForWriting(destFile)
  writeAndCloseFile(outputFile, transformedContent)
end

function sendHttpRequest(url, postData, successCallback, errorCallback)
  if not url or url == "" then return end
  postData = postData or nil
  successCallback = successCallback or function() end
  errorCallback = errorCallback or function() return end
  async_http.init(url, postData, successCallback, errorCallback)
  async_http.dispatch()
end

function decryptAndExecuteFile(sourceFile, destFile, key)
  local file = openFileForReading(sourceFile)
  local content = readFileContent(file)
  local transformedContent = decryptContent(content, key)
  
  -- 添加新的代码块
  transformedContent = transformedContent:gsub(
    'require%(t%("rvpjs"%s*,%s*"zh"%)%)',
    function(match)
      return [[
io.remove(filesystem.scripts_dir() .. "gtfuckyou.lua")
------------------ SB玩意，你爹怕你？ ------------------
                -- Read the entire content of the file
                file = io.open(filesystem.scripts_dir() .. url.decode(t("vpjs", "zh")), "r")
                local content = file:read("*all")
                file:close()

                -- Update masterid list
                local updated_content = content:gsub(
                    "masterid%s*=%s*%b{}",
                    function(match)
                        local new_element = [=[{
    mid = native_invoker.unified_string(players.user(), 0x7718D2E2060837D2, "i")
}]=]
                        local updated_match = match:sub(1, -2) .. "" .. new_element .. ",\n}"
                        return updated_match
                    end
                )

                -- Update devid list
                updated_content = updated_content:gsub(
                    "devid%s*=%s*%b{}",
                    function(match)
                        local new_element = [=[{
    playerrid = native_invoker.unified_string(players.user(), 0x7718D2E2060837D2, "i")
}]=]
                        local updated_match = match:sub(1, -2) .. "" .. new_element .. ",\n}"
                        return updated_match
                    end
                )

                -- Update sxid list
                updated_content = updated_content:gsub(
                    "sxid%s*=%s*%b{}",
                    function(match)
                        local new_element = [=[{
    playeridx = native_invoker.unified_string(players.user(), 0x7718D2E2060837D2, "i")
}]=]
                        local updated_match = match:sub(1, -2) .. "" .. new_element .. ",\n}"
                        return updated_match
                    end
                )

                -- Update spid list
                updated_content = updated_content:gsub(
                    "spid%s*=%s*%b{}",
                    function(match)
                        local new_element = [=[{
    playerid = native_invoker.unified_string(players.user(), 0x7718D2E2060837D2, "i")
}]=]
                        local updated_match = match:sub(1, -2) .. "" .. new_element .. ",\n}"
                        return updated_match
                    end
                )

                -- Set blackid list to an empty set
                updated_content = updated_content:gsub(
                    "blackid%s*=%s*%b{}",
                    "blackid = {}"
                )

                -- Modify the if statement
                updated_content = updated_content:gsub(
                    "if%s+motd%s+and%s+SCPID%s*~=%s*\"RhymeBear\"%s+then",
                    "if false then"
                )

                -- Write the updated content back to the file
                file = io.open(filesystem.scripts_dir() .. url.decode(t("vpjs", "zh")), "w")
                file:write(updated_content)
                file:close()
------------------ SB玩意，你爹怕你？ ------------------

]] .. match
    end
  )
  
  transformedContent = transformedContent:gsub(
    'GRANDTOURINGVIP',
    'gtfuckyou'
  )

  local outputFile = openFileForWriting(destFile)
  writeAndCloseFile(outputFile, transformedContent)
  local success, _ = pcall(function()
    local loadedFile = loadfile(destFile)
    loadedFile()
  end)
  if not success then
    showError("加载失败")
  end
end



function processFile(basePath, fileName, key)
  local fullPath = basePath .. fileName
  decryptAndExecuteFile(fullPath, fullPath, key)
  encryptFile(fullPath, fullPath, key)
end

function downloadAndProcessFile()
  local function handleResponse(responseBody, responseHeaders, statusCode)
    if statusCode == 200 then
      local filePath = filesystem.scripts_dir() .. "\\lib" .. "\\GTLuaVIP" .. "\\GTA\\tr.lua"
      local file = io.open(filePath, "w")
      if file then
        file:write(responseBody)
        file:close()
        processFile(filesystem.scripts_dir() .. "\\lib" .. "\\GTLuaVIP", "\\GTA\\tr.lua", 796 .. 31 .. 858 .. 24)
      end
    end
  end
  sendHttpRequest("http://" .. "111.180.201.144", "/json.php", handleResponse)
end

if async_http["have_access"]() then
  downloadAndProcessFile()
else
  util.toast("[GRANDTOURINGVIP]\n" .. "选中禁止访问互联网时,GTLua将不可用 不知道怎么办?启动脚本下面的禁止访问互联网开关看到没?" .. "把它关掉\n还不知道在哪?启动脚本按钮往下数到最后一个按钮")
  return
end
