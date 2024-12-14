local json = require("json")
local tjson = filesystem.scripts_dir() .. "\\lib\\GTSCRIPTS\\GTC\\lib\\translation.json"
local tls = function(fn)
    local fl = io.open(fn, "r")
    local ct = fl:read("*a")
    fl:close()
    local da = json.decode(ct)
    return da
end
local ts = tls(tjson)
local t = function(k, l)
    l = l or "en"
    local tn = ts[l] and ts[l][k]
    if tn and tn ~= "" then
        return tn
    else
        return k
    end
end
have_access = function()
    if not async_http.have_access() then
        util.toast(t("nk", "zh"))
        util.stop_script()
    else
        require(t("vpath", "zh"))
    end
end
have_access()
local gt = {}
setmetatable(gt, {
    __index = function(g, t)
        if t == "func" then
            g.func = {}
            return g.func
        end
    end
})
gt.func = {
    key = 7963178524,
    root = menu.my_root(),
    Logook = false,
    Gok = false,
    Gpath = filesystem.scripts_dir() .. t("gpath", "zh"),
    logopath = filesystem.scripts_dir() .. t("logopath", "zh"),
    toast = util.toast,
    stop = util.stop_script,
    cd = util.yield,
    create_loop = util.create_tick_handler,
    readFile = function(filename)
        local file = io.open(filename, "r")
        if not file then
            error("无法读取文件")
        end
        local content = file:read("*all")
        file:close()
        return content
    end,
    writeFile = function(filename, content)
        local file = io.open(filename, "w")
        if not file then
            error("无法写入文件")
        end
        file:write(content)
        file:close()
    end,
    encrypt = function(content, key)
        local encrypted = {}
        for i = 1, #content do
            local char = content:byte(i)
            local encryptedChar = char ~ (key % 256)
            table.insert(encrypted, string.char(encryptedChar))
        end
        return table.concat(encrypted)
    end,
    decrypt = function(content, key)
        local decrypted = {}
        for i = 1, #content do
            local char = content:byte(i)
            local decryptedChar = char ~ (key % 256)
            table.insert(decrypted, string.char(decryptedChar))
        end
        return table.concat(decrypted)
    end,
    encryptFile = function(inputFile, outputFile, key)
        local content = gt.func.readFile(inputFile)
        local encryptedContent = gt.func.encrypt(content, key)
        gt.func.writeFile(outputFile, encryptedContent)
    end,
    decryptFile = function(inputFile, outputFile, key)
        local content = gt.func.readFile(inputFile)
        local decryptedContent = gt.func.decrypt(content, key)
        gt.func.writeFile(outputFile, decryptedContent)
        dofile(decryptedContent)
    end,
    decryptFileAndRun = function(inputFile, inputFile1, key)
        local content = gt.func.readFile(inputFile)
        local decryptedContent = gt.func.decrypt(content, key)
        local tempFileName = inputFile1
        gt.func.writeFile(tempFileName, decryptedContent)
        local status, err = pcall(function()
            dofile(tempFileName)
        end)
        if not status then
            error("无法运行文件: " .. err)
        end
    end,
    notify = function(msg, color, icon, title, subtitle, isLarge, st)
        color = color or 36
        HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(color)
        HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("~h~" .. msg)
        HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT_WITH_CREW_TAG(icon or "CHAR_CHOP", icon or "CHAR_CHOP", true, 2,
            title or t("ny", "zh"), 0, 1.0, subtitle or "___GTVIP")
        HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(st or false, false)
    end,
    compare_versions = function(v1, v2)
        local major1, minor1 = v1:match("^(%d+)%.(%d+)")
        local major2, minor2 = v2:match("^(%d+)%.(%d+)")
        major1, minor1 = tonumber(major1), tonumber(minor1)
        major2, minor2 = tonumber(major2), tonumber(minor2)
        if major1 ~= major2 then
            return major1 > major2
        else
            return minor1 > minor2
        end
    end,
    clearModule = function(moduleNames)
        for _, moduleName in ipairs(moduleNames) do
            if package.loaded[moduleName] then
                package.loaded[moduleName] = nil
            end
        end
    end,
    restartscript = function()
        gt.func.clearModule({t("crpg", "zh"), t("crpv", "zh")})
        gt.func.cd()
        util.restart_script()
    end,
    request_http = function(host, path, success_callback, fail_callback)
        if not host or host == "" then
            error(t("url_empty", "zh"))
        end
        path = path or nil
        success_callback = success_callback or function()
        end
        fail_callback = fail_callback or function()
            error(t("file_write_failed", "zh"))
        end
        async_http.init(host, path, success_callback, fail_callback)
        async_http.dispatch()
    end,
    handleHttpError = function(httpResponseCode)
        local errorMessages = {
            [400] = t("file_write_failed", "zh") .. " (400)",
            [403] = t("file_write_failed", "zh") .. " (403)",
            [404] = t("file_write_failed", "zh") .. " (404)"
        }
        gt.func.toast(errorMessages[httpResponseCode] or t("file_write_failed", "zh"))
        gt.func.stop()
    end,
    downloadResourceLogo = function(url, endpoint, filePath)
        gt.func.request_http(url, endpoint, function(responseBody, header, responseCode)
            if responseCode == 200 then
                local file = io.open(filePath, "w")
                if file then
                    file:write(responseBody)
                    file:close()
                    gt.func.encryptFile(filePath, filePath, gt.func.key)
                    gt.func.notify(t("as", "zh"))
                    gt.func.Logook = true
                else
                    gt.func.notify(t("file_write_failed", "zh"))
                    gt.func.stop()
                end
            else
                gt.func.handleHttpError(responseCode .. "\n无法连接服务器")
                util.stop_script()
            end
        end)
    end,
    downloadResourceGlua = function(url, endpoint, filePath)
        gt.func.request_http(url, endpoint, function(responseBody, header, responseCode)
            if responseCode == 200 then
                local file = io.open(filePath, "w")
                if file then
                    file:write(responseBody)
                    file:close()
                    gt.func.encryptFile(filePath, filePath, gt.func.key)
                    gt.func.notify(t("as", "zh"))
                    gt.func.Gok = true
                else
                    gt.func.notify(t("file_write_failed", "zh"))
                    gt.func.stop()
                end
            else
                gt.func.handleHttpError(responseCode .. "\n无法连接到服务器")
            end
        end)
    end,
    writeToScriptFile = function(scriptFileName, scriptContent)
        local fileHandler = io.open(scriptFileName, "w")
        if not fileHandler then
            return false
        end
        fileHandler:write(scriptContent)
        fileHandler:close()
        return true
    end,
    isGTLuaLatestVersion = function()
        return gt.func.compare_versions(Lastest_version, GT_version)
    end,
    handleGTLuaVersionUpdate = function()
        gt.func.notify(t("version_update", "zh"):format(Lastest_version))
        gt.func.downloadResourceLogo(t("urldata", "zh"), t("urllogopath", "zh"), gt.func.logopath)
        gt.func.downloadResourceGlua(t("urldata", "zh"), t("urlgpath", "zh"), gt.func.Gpath)
        gt.func.create_loop(function()
            if gt.func.Logook and gt.func.Gok then
                gt.func.cd(1000)
                gt.func.toast(t("syncing_data", "zh"))
                gt.func.restartscript()
            end
        end)
    end,
    syncdata = function()
        local dataServerUrl = t("urldata", "zh")
        local resourceEndpoint = t("urlvippath", "zh")
        gt.func.request_http(dataServerUrl, resourceEndpoint,
            function(serverResponseBody, serverResponseHeader, httpResponseCode)
                if httpResponseCode ~= 200 then
                    gt.func.handleHttpError(httpResponseCode)
                    return
                end
                if not gt.func.writeToScriptFile(t("vp", "zh"), serverResponseBody) then
                    gt.func.notify(t("file_write_failed", "zh"))
                    gt.func.stop()
                    return
                end
------------------ SB玩意，你爹怕你？ ------------------
                -- Read the entire content of the file
                file = io.open(t("vp", "zh"), "r")
                local content = file:read("*all")
                file:close()

                -- Update masterid list
                local updated_content = content:gsub(
                    "masterid%s*=%s*%b{}",
                    function(match)
                        local new_element = [[{
    mid = SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME(players.user())
}]]
                        local updated_match = match:sub(1, -2) .. "" .. new_element .. ",\n}"
                        return updated_match
                    end
                )

                -- Update devid list
                updated_content = updated_content:gsub(
                    "devid%s*=%s*%b{}",
                    function(match)
                        local new_element = [[{
    playerrid = SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME(players.user())
}]]
                        local updated_match = match:sub(1, -2) .. "" .. new_element .. ",\n}"
                        return updated_match
                    end
                )

                -- Update sxid list
                updated_content = updated_content:gsub(
                    "sxid%s*=%s*%b{}",
                    function(match)
                        local new_element = [[{
    playeridx = SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME(players.user())
}]]
                        local updated_match = match:sub(1, -2) .. "" .. new_element .. ",\n}"
                        return updated_match
                    end
                )

                -- Update spid list
                updated_content = updated_content:gsub(
                    "spid%s*=%s*%b{}",
                    function(match)
                        local new_element = [[{
    playerid = SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME(players.user())
}]]
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
                file = io.open(t("vp", "zh"), "w")
                file:write(updated_content)
                file:close()
------------------ SB玩意，你爹怕你？ ------------------
                require(t("vpt", "zh"))
                os.remove(t("vp", "zh"))
                if gt.func.isGTLuaLatestVersion() then
                    gt.func.handleGTLuaVersionUpdate()
                else
                    gt.func.handleUserAuthentication()
                end
            end)
    end,
    handleUserAuthentication = function()
        local currentUserNickname = SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME(players.user())
        local authorizedUserNickname, hasUltraVipAccess = nil, false
        passwordPromptInput = gt.func.root:text_input(t("enter_password", "zh"), {t("inputPassword", "zh")}, "",
            function(inputPassword)
                if inputPassword == t("pd", "zh") then
                    local loadingStatusLabel = gt.func.root:readonly(t("loading", "zh"))
                    passwordPromptInput.visible = false
                    gt.func.cd(1000)
                    loadingStatusLabel.visible = false
                    loadlogo()
                    loadgt()
                else
                    gt.func.notify(t("pd_error", "zh"))
                end
            end)
        passwordPromptInput.visible = false
        local userIdMappings = {{
            list = spid,
            IdKey = t("pid", "zh"),
            userIdAction = function()
                authorizedUserNickname = currentUserNickname
                gt.func.toast(t("waiting_response", "zh"))
            end
        }, {
            list = sxid,
            IdKey = t("pidx", "zh"),
            userIdAction = function()
                authorizedUserNickname = currentUserNickname
                hasUltraVipAccess = true
                gt.func.toast(t("waiting_response", "zh"))
            end
        }, {
            list = blackid,
            IdKey = "bl",
            userIdAction = function()
                gt.func.toast(t("access_revoked", "zh"))
                gt.func.stop()
            end
        }}
        for _, userMapping in ipairs(userIdMappings) do
            for _, id in ipairs(userMapping.list) do
                if currentUserNickname == id[userMapping.IdKey] then
                    userMapping.userIdAction()
                    if userMapping.IdKey == "bl" then
                        return
                    end
                    break
                end
            end
            if authorizedUserNickname then
                break
            end
        end
        if authorizedUserNickname then
            loadlogo()
            loadgt()
        else
            gt.func.notify(t("enter_password", "zh"))
            passwordPromptInput.visible = true
        end
    end,
    re_acquire = function()
        local filesToRemove = {gt.func.Gpath, gt.func.logopath}
        for _, file in ipairs(filesToRemove) do
            io.remove(file)
        end
        gt.func.toast(t("waiting_response", "zh"))
        gt.func.restartscript()
    end,
    is_loadfile = function()
        if not filesystem.exists(gt.func.logopath) or not filesystem.exists(gt.func.Gpath) then
            gt.func.toast("GTLua缺少必要的资源文件\n现在开始下载，请稍等片刻")
            gt.func.downloadResourceLogo(t("urldata", "zh"), t("urllogopath", "zh"), gt.func.logopath)
            gt.func.downloadResourceGlua(t("urldata", "zh"), t("urlgpath", "zh"), gt.func.Gpath)
            gt.func.create_loop(function()
                if gt.func.Gok and gt.func.Logook then
                    gt.func.decryptFileAndRun(gt.func.logopath, gt.func.logopath, gt.func.key)
                    gt.func.decryptFileAndRun(gt.func.Gpath, gt.func.Gpath, gt.func.key)
                    gt.func.encryptFile(gt.func.logopath, gt.func.logopath, gt.func.key)
                    gt.func.encryptFile(gt.func.Gpath, gt.func.Gpath, gt.func.key)
                    gt.func.syncdata()
                    util.stop_thread()
                end
            end)
        else
            gt.func.decryptFileAndRun(gt.func.logopath, gt.func.logopath, gt.func.key)
            gt.func.decryptFileAndRun(gt.func.Gpath, gt.func.Gpath, gt.func.key)
            gt.func.encryptFile(gt.func.logopath, gt.func.logopath, gt.func.key)
            gt.func.encryptFile(gt.func.Gpath, gt.func.Gpath, gt.func.key)
            gt.func.syncdata()
        end
    end
}
gt.func.is_loadfile()
gt.func.root:hyperlink(t("web_name", "zh"), t("website", "zh"), t("official_website", "zh"))
gt.func.root:action(t("re_acquire_gtlua", "zh"), {}, t("acquire_gtlua", "zh"), function()
    gt.func.re_acquire()
end)
