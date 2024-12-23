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
