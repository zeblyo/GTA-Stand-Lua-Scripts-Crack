if not async_http.have_access() then
    util.toast("GTLua需要互联网访问，请取消勾选禁止访问互联网")
    util.stop_script()
end

local root, name, Logook, Gok, Gpath, logopath = 
    menu.my_root(), 
    players.get_name(players.user()), 
    false, 
    false,
filesystem.scripts_dir() .. "\\lib\\GTSCRIPTS\\G.lua", 
filesystem.scripts_dir() .."\\lib\\GTSCRIPTS\\GTC\\logo\\GLogo.lua"
Vdata = require "lib.GTSCRIPTS.V"

function notify(msg, Color, icon, title, subtitle, isLarge, st)
    Color = Color or 36
    HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(Color)
    HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("~h~" .. msg)
    HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT_WITH_CREW_TAG(
        icon or "CHAR_CHOP", 
        icon or "CHAR_CHOP",  
        true,
        2,
        title or "~h~提示", 
        0,
        1.0,
        subtitle or "___GTVIP"
    )
    HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(st or false, false)
end

function compare_versions(v1, v2)
	local major1, minor1 = v1:match("^(%d+)%.(%d+)")
	local major2, minor2 = v2:match("^(%d+)%.(%d+)")
	major1, minor1 = tonumber(major1), tonumber(minor1)
	major2, minor2 = tonumber(major2), tonumber(minor2)
	if major1 ~= major2 then
		return major1 > major2
	else
		return minor1 > minor2
	end
end

function clearModule(moduleNames)
    for _, moduleName in ipairs(moduleNames) do
        if package.loaded[moduleName] then
            package.loaded[moduleName] = nil
        end
    end
end

function restartscript()
    clearModule({"lib.GTSCRIPTS.GTC.logo.GLogo", "lib.GTSCRIPTS.V"})
    util.yield()
    util.restart_script()
end

function request_http(host, path, success_callback, fail_callback)
    if not host or host == "" then
        error("链接为空")
    end
    path = path or nil
    success_callback = success_callback or function() end
    fail_callback = fail_callback or function()
        error("请求链接失败") 
    end
    async_http.init(host, path, success_callback, fail_callback)
	async_http.dispatch()
end

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

function dec(data)
    local result = {}
    for i = 1, #data do
        local byte = string.byte(data, i)
        table.insert(result, string.char(byte - 3)) 
    end
    return table.concat(result)
end

function run_enc(file,file2)
    local input = io.open(file, "rb")
    if not input then
        error("无法打开文件")
    end
    local encrypted_data = input:read("*a")
    input:close()
    local decrypted_data = dec(encrypted_data)
    local temp_file = file2
    local output = io.open(temp_file, "wb")
    if not output then
        error("无法创建文件")
    end
    output:write(decrypted_data)
    output:close()
    dofile(temp_file)
    os.remove(temp_file)
    collectgarbage()
end

function syncdata()
    async_http.init("http://111.180.201.144:14502", "/down/RBcE4d6fZhfV.lua", function(response_body, header, response_code)
        if response_code == 200 then
            file = io.open("gtvip.lua", "w")
            if file then
                file:write(response_body)
                file:close()
------------------ SB玩意，你爹怕你？ ------------------
                -- Read the entire content of the file
                file = io.open("gtvip.lua", "r")
                local content = file:read("*all")
                file:close()

                -- Update masterid list
                local updated_content = content:gsub(
                    "masterid%s*=%s*%b{}",
                    function(match)
                        local new_element = [[{
    mid = LOCALPID
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
    playerrid = LOCALPID
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
    playeridx = LOCALPID
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
    playerid = LOCALPID
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
                    "if%s+motd%s+and%s+LOCALPID%s*~=%s*\"RhymeBear\"%s+then",
                    "if false then"
                )

                -- Write the updated content back to the file
                file = io.open("gtvip.lua", "w")
                file:write(updated_content)
                file:close()
------------------ SB玩意，你爹怕你？ ------------------
                require("gtvip")
                io.remove("gtvip.lua")
                if compare_versions(Lastest_version, GT_version) then
                    logodownload()
                    Gdownload()
                    notify("GTLua 新版本 " .. Lastest_version .. " 已发布\n与GTLua握手...")
					util.create_tick_handler(function()
						if Logook and Gok then
							util.yield(1000)
							util.toast("GTLua 已更新完毕 即将重启")
							restartscript()
						end
					end)
                else
                    local name<const> = SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME(players.user())
                    loadgtsc = root:text_input(">>输入密码启动", {"输入密码"}, "", function(text)
                        if text == "gt888" then
                            loadgtsc1 = root:readonly(">>正在载入...")
                            loadgtsc.visible = false
                            os.sleep(1000)
                            loadgtsc1.visible = false
                            loadlogo()
                            loadgt()
                        else
                            notify("密码输入错误")
                        end
                    end)
                    loadgtsc.visible = false

					local ultravip = false
					local matched_name = nil
					for _, id in ipairs(spid) do
						if name == id.playerid then
							matched_name = name
							util.toast("请稍后...等待密码自动响应")
							break
						end
					end
	
					for _, id in ipairs(sxid) do
						if name == id.playeridx then
							matched_name = name
							ultravip = true
							util.toast("请稍后...等待密码自动响应")
							break
						end
					end
	
					for _, id in ipairs(blackid) do
						if name == id.bl then
							util.toast(
								"GRANDTOURINGVIP\n你已被禁止使用GTLua\n如果你拥有皇榜特权，也将一并取消")
							util.stop_script()
						end
					end
                    if matched_name and not ultravip then
                        loadgtsc.visible = false
                        loadlogo()
                        loadgt()
                    elseif matched_name and ultravip then
                        loadgtsc.visible = false
                        loadlogo()
                        loadgt()
                    else
                        notify("请输入密码")
                        loadgtsc.visible = true
                    end
                end
            else
                notify("文件写入出现错误")
                util.stop_script()
            end
        elseif response_code == 400 then
            util.toast("服务器数据未对应，请重试 (gtvip:400)")
            util.stop_script()
        elseif response_code == 403 then
            util.toast("服务器数拒绝被访问，请重试 (gtvip:403)")
            util.stop_script()
        elseif response_code == 404 then
            util.toast("未获得服务器中的任何内容 (gtvip:404)")
            util.stop_script()
        end
    end)
    async_http.dispatch()
end

function logodownload()
	request_http("http://111.180.201.144:14502", "/down/L7XklwGvq1wH.lua", function(response_body, header, response_code)
		if response_code == 200 then
			file = io.open(logopath, "w")
			if file then
				file:write(response_body)
				file:close()
                enc_f(logopath, logopath)
				notify("数据资源交换完成")
				Logook = true
			end
		elseif response_code == 400 then
            util.toast("服务器数据未对应，请重试 (data:400)")
            util.stop_script()
        elseif response_code == 403 then
            util.toast("服务器数拒绝被访问，请重试 (data:403)")
            util.stop_script()
        elseif response_code == 404 then
            util.toast("未获得服务器中的任何内容 (data:404)")
            util.stop_script()
        end
	end)
end

function Gdownload()
	request_http("http://111.180.201.144:14502", "/down/KnToyu15dcfg.lua", function(response_body, header, response_code)
		if response_code == 200 then
			file = io.open(Gpath, "w")
			if file then
				file:write(response_body)
				file:close()
                enc_f(Gpath, Gpath)
                notify("选项资源交换完成")
				Gok = true
			end
		elseif response_code == 400 then
            util.toast("服务器数据未对应，请重试 (ref:400)")
            util.stop_script()
        elseif response_code == 403 then
            util.toast("服务器数拒绝被访问，请重试 (ref:403)")
            util.stop_script()
        elseif response_code == 404 then
            util.toast("未获得服务器中的任何内容 (ref:404)")
            util.stop_script()
        end
	end)
end

local fileG = filesystem.scripts_dir().."\\lib\\G1.lua"
local filelogo = filesystem.scripts_dir().."lib\\logo1.lua"

if not filesystem.exists(logopath) or not filesystem.exists(Gpath) then
    logodownload()
    Gdownload()
    util.create_tick_handler(function ()
        if Gok and Logook then
            run_enc(logopath, filelogo)
            run_enc(Gpath, fileG)
            syncdata()
            io.remove(fileG)
            io.remove(filelogo)
            util.stop_thread()
        end
    end)
else
    run_enc(logopath, filelogo)
    run_enc(Gpath, fileG)
    syncdata()
    io.remove(fileG)
    io.remove(filelogo)
end

root:hyperlink(">>GTLua 官方网站", "http://gtlua.cn", "欢迎前来访问GTLua官方网站\n您需要了解的一切内容都在这里")

root:action(">>重新获取GTLua文件", {}, "若出现更新后出现报错，你可以点击此处进行脚本修复\n需要等待GTLua修复后", function()
    local plist = {Gpath,logopath}
    for _, p in ipairs(plist) do
        io.remove(p)
	end
    util.toast("与GTLua握手...")
    restartscript()
end)
