HUD={
    ["END_TEXT_COMMAND_THEFEED_POST_TICKER"]=--[[int]] function(--[[BOOL (bool)]] blink,--[[BOOL (bool)]] p1)native_invoker.begin_call()native_invoker.push_arg_bool(blink)native_invoker.push_arg_bool(p1)native_invoker.end_call_2(0x2ED7843F8F801023)return native_invoker.get_return_value_int()end,
    ["END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT"]=--[[int]] function(--[[string]] txdName,--[[string]] textureName,--[[BOOL (bool)]] flash,--[[int]] iconType,--[[string]] sender,--[[string]] subject)native_invoker.begin_call()native_invoker.push_arg_string(txdName)native_invoker.push_arg_string(textureName)native_invoker.push_arg_bool(flash)native_invoker.push_arg_int(iconType)native_invoker.push_arg_string(sender)native_invoker.push_arg_string(subject)native_invoker.end_call_2(0x1CCD9A37359072CF)return native_invoker.get_return_value_int()end,
    ["ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME"]=--[[void]] function(--[[string]] text)native_invoker.begin_call()native_invoker.push_arg_string(text)native_invoker.end_call_2(0x6C188BE134E074AA)end,
    ["BEGIN_TEXT_COMMAND_THEFEED_POST"]=--[[void]] function(--[[string]] text)native_invoker.begin_call()native_invoker.push_arg_string(text)native_invoker.end_call_2(0x202709F4C58A0424)end,
    ["THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST"]=--[[void]] function(--[[int]] hudColorIndex)native_invoker.begin_call()native_invoker.push_arg_int(hudColorIndex)native_invoker.end_call_2(0x92F0DA1E27DB96DC)end,
}

function restartscript()
    package.loaded["luacrack"] = nil
    util.yield()
    util.restart_script() 
end

----全局UI颜色
HudColour ={
	pureWhite = 0,
	white = 1,
	black = 2,
	grey = 3,
	greyLight = 4,
	greyDrak = 5,
	red = 6,
	redLight = 7,
	redDark = 8,
	blue = 9,
	blueLight = 10,
	blueDark = 11,
	yellow = 12,
	yellowLight = 13,
	yellowDark = 14,
	orange = 15,
	orangeLight = 16,
	orangeDark = 17,
	green = 18,
	greenLight = 19,
	greenDark = 20,
	purple = 21,
	purpleLight = 22,
	purpleDark = 23,
	radarHealth = 25,
	radarArmour = 26,
	friendly = 118,
}

function check_version()
    notification("正在检查更新~", HudColour.friendly, "Crack")

    -- 定义 GitHub 和本地服务器的版本信息 URL
    local daidai_github_url = "https://gh.jasonzeng.dev/https://raw.githubusercontent.com/zeblyo/GTA-Stand-Lua-Scripts-Crack/refs/heads/main/versions.txt"
    local daidai_version_url = "http://check.cnsakura.top/stand/versions.txt"

    local GT_github_url = "https://gh.jasonzeng.dev/https://raw.githubusercontent.com/zeblyo/GTA-Stand-Lua-Scripts-Crack/refs/heads/main/versions.txt"
    local GT_version_url = "http://111.180.201.144:14502/down/RBcE4d6fZhfV.lua"

    -- 定义变量以存储版本信息
    local daidai_github_version = nil
    local daidai_version = nil
    local daidai_completed_requests = 0

    local GT_github_version = nil
    local GT_version = nil
    local GT_completed_requests = 0

    -- 定义回调函数以处理版本信息
    local function daidai_handle_versions()
        if daidai_completed_requests == 2 then
            if daidai_github_version and daidai_version then
                local message = (daidai_version ~= daidai_github_version) and "~y~~bold~检测到daidai更新请加交流群957853968反馈或等待更新=.=" or "~y~~bold~daidai-Crack已是最新版本=.="
                notification(message, HudColour.orangeDark, "Crack")
                if daidai_version == daidai_github_version then
                    menu.action(menu.my_root(), ">>daidai-Crack文件替换破解", {}, "", function () daidai_download() end)
                end
            else
                if not daidai_github_version then
                    notification("daidai-Crack从 GitHub 获取版本信息失败", HudColour.orangeDark, "Crack")
                end
                if not daidai_version then
                    notification("daidai-Crack从服务器获取版本信息失败", HudColour.orangeDark, "Crack")
                end
            end
        end
    end
    
    local function GT_handle_versions()
        if GT_completed_requests == 2 then
            if GT_github_version and GT_version then
                local message = (GT_version ~= GT_github_version) and "~y~~bold~检测到GT更新请加交流群957853968反馈或等待更新=.=" or "~y~~bold~GT-Crack已是最新版本=.="
                notification(message, HudColour.orangeDark, "Crack")
                if GT_version == GT_github_version then
                    menu.action(menu.my_root(), ">>GT-Crack文件替换破解", {}, "", function () GT_download() end)
                end
            else
                if not GT_github_version then
                    notification("GT-Crack从 GitHub 获取版本信息失败", HudColour.orangeDark, "Crack")
                end
                if not GT_version then
                    notification("GT-Crack从服务器获取版本信息失败", HudColour.orangeDark, "Crack")
                end
            end
        end
    end
    

    -- 从 GitHub 获取版本信息
    async_http.init(daidai_github_url, nil, function(body, header_fields, status)
        if status == 200 and body then
            daidai_github_version = tonumber(body:match("([^\n]+)"))  -- 提取并转换为数字
        else
            notification("GitHub 服务器 HTTP 请求失败，状态码:".. status, HudColour.redDark, "Crack")
        end
        daidai_completed_requests = daidai_completed_requests + 1
        daidai_handle_versions()
    end)
    async_http.dispatch()

    async_http.init(GT_github_url, nil, function(body, header_fields, status)
        if status == 200 and body then
            GT_github_version = tonumber(body:match("^[^\n]*\n([^\n]+)"))  -- 提取并转换为数字
        else
            notification("GitHub 服务器 HTTP 请求失败，状态码:".. status, HudColour.redDark, "Crack")
        end
        GT_completed_requests = GT_completed_requests + 1
        GT_handle_versions()
    end)
    async_http.dispatch()

    -- 从本地服务器获取版本信息
    async_http.init(daidai_version_url, nil, function(body, header_fields, status)
        if status == 200 and body then
            daidai_version = tonumber(body:match("([^:]+):.*"))  -- 提取冒号前的部分并转换为数字
        else
            notification("daidai 服务器 HTTP 请求失败，状态码:".. status, HudColour.redDark, "Crack")
        end
        daidai_completed_requests = daidai_completed_requests + 1
        daidai_handle_versions()
    end)
    async_http.dispatch()

    async_http.init(GT_version_url, nil, function(body, header_fields, status)
        if status == 200 and body then
            -- 精确匹配 Lastest_version 的值
            GT_version = tonumber(body:match('Lastest_version%s*=%s*"([%d%.]+)"'))
        else
            notification("GT 服务器 HTTP 请求失败，状态码:".. status, HudColour.redDark, "Crack")
        end
        GT_completed_requests = GT_completed_requests + 1
        GT_handle_versions()
    end)
    async_http.dispatch()
end

function daidai_download()
end

function GT_download()
end


function notification(format, colour, title)
    local titled = title or "通知"
	local msg = string.format(format)
	HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(colour or HudColour.blue)
    HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(msg)
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT("CHAR_SOCIAL_CLUB", "CHAR_SOCIAL_CLUB", true, HudColour.purpleLight, "Stand Lua Scripts", "~b~"..titled) -- youtube "CHAR_YOUTUBE"  https://pastebin.com/XdpJVbHz
	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(false, false)
end

menu.action(menu.my_root(), ">>重新检查更新", {}, "", function () restartscript() end)
-- 检查是否有网络访问权限
if not async_http.have_access() then
    util.toast("无法访问网络，请关闭禁止互联网访问选项。")
    util.stop_script()
end
check_version()
