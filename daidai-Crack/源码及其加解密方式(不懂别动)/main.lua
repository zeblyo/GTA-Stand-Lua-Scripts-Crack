--[[⣠⠤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀
⠀⠀⡜⠁⠀⠈⢢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠋⠷⠶⠱⡄
⠀⢸⣸⣿⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠫⢀⣖⡃⢀⣸⢹
⠀⡇⣿⣿⣶⣤⡀⠀⠀⠙⢆⠀⠀⠀⠀⠀⣠⡪⢀⣤⣾⣿⣿⣿⣿⣸
⠀⡇⠛⠛⠛⢿⣿⣷⣦⣀⠀⣳⣄⠀⢠⣾⠇⣠⣾⣿⣿⣿⣿⣿⣿⣽
⠀⠯⣠⣠⣤⣤⣤⣭⣭⡽⠿⠾⠞⠛⠷⠧⣾⣿⣿⣯⣿⡛⣽⣿⡿⡼
⠀⡇⣿⣿⣿⣿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣿⣮⡛⢿⠃
⠀⣧⣛⣭⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣷⣎⡇
⠀⡸⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣷⣟⡇
⣜⣿⣿⡧⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⣄⠀⠀⠀⠀⠀⣸⣿⡜⡄
⠉⠉⢹⡇⠀⠀⠀⢀⣞⠡⠀⠀⠀⠀⠀⠀⡝⣦⠀⠀⠀⠀⢿⣿⣿⣹
⠀⠀⢸⠁⠀⠀⢠⣏⣨⣉⡃⠀⠀⠀⢀⣜⡉⢉⣇⠀⠀⠀⢹⡄⠀⠀
⠀⠀⡾⠄⠀⠀⢸⣾⢏⡍⡏⠑⠆⠀⢿⣻⣿⣿⣿⠀⠀⢰⠈⡇⠀⠀
⠀⢰⢇⢀⣆⠀⢸⠙⠾⠽⠃⠀⠀⠀⠘⠿⡿⠟⢹⠀⢀⡎⠀⡇⠀⠀
⠀⠘⢺⣻⡺⣦⣫⡀⠀⠀⠀⣄⣀⣀⠀⠀⠀⠀⢜⣠⣾⡙⣆⡇⠀⠀
⠀⠀⠀⠙⢿⡿⡝⠿⢧⡢⣠⣤⣍⣀⣤⡄⢀⣞⣿⡿⣻⣿⠞⠀⠀⠀
⠀⠀⠀⢠⠏⠄⠐⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠳⢤⣉⢳⠀⠀⠀
⢀⡠⠖⠉⠀⠀⣠⠇⣿⡿⣿⡿⢹⣿⣿⣿⣿⣧⣠⡀⠀⠈⠉⢢⡀⠀
⢿⠀⠀⣠⠴⣋⡤⠚⠛⠛⠛⠛⠛⠛⠛⠛⠙⠛⠛⢿⣦⣄⠀⢈⡇⠀
⠈⢓⣤⣵⣾⠁⣀⣀⠤⣤⣀⠀⠀⠀⠀⢀⡤⠶⠤⢌⡹⠿⠷⠻⢤⡀
⢰⠋⠈⠉⠘⠋⠁⠀⠀⠈⠙⠳⢄⣀⡴⠉⠀⠀⠀⠀⠙⠂⠀⠀⢀⡇
⢸⡠⡀⠀⠒⠂⠐⠢⠀⣀⠀⠀⠀⠀⠀⢀⠤⠚⠀⠀⢸⣔⢄⠀⢾⠀
⠀⠑⠸⢿⠀⠀⠀⠀⢈⡗⠭⣖⡒⠒⢊⣱⠀⠀⠀⠀⢨⠟⠂⠚⠋⠀
⠀⠀⠀⠘⠦⣄⣀⣠⠞⠀⠀⠀⠈⠉⠉⠀⠳⠤⠤⡤⠞]]
util.keep_running()
require "lib.SakuraScript.main.natives"
require "lib.SakuraScript.location"
load_code(lua_tables)
load_code(lua_MainLib)
require "lib.SakuraScript.bodyguards.bodyguard"

scaleform = require('SakuraScript.ScaleformLib')
sf = scaleform('instructional_buttons')
sfchat = scaleform('multiplayer_chat')
sfchat:draw_fullscreen()

local UFO = require "lib.SakuraScript.ufo"
local GuidedMissile = require "lib.SakuraScript.guided_missile"
local HomingMissiles = require "lib.SakuraScript.homing_missiles"
local OrbitalCannon = require "lib.SakuraScript.orbital_cannon"

local UltimateAword = "如果你想升级Ultimate,点击此处即刻前往.Ultimate包含但不限于移除lua广告,额外的lua功能,免受sakura用户的lua攻击,1对1售后,优先获得体验版"
appmenu.Ultioff.shop = menu.hyperlink(menu.my_root(), "升级Ultimate", "https://blog.cnsakura.top/article/20", UltimateAword)

self_option = menu.list(menu.my_root(), "自我选项", {}) 
online = menu.list(menu.my_root(), "战局选项", {}) 
chat_msg = menu.list(menu.my_root(), "聊天选项", {}) 
vehicle = menu.list(menu.my_root(), "载具选项", {})
weapons = menu.list(menu.my_root(), "武器选项", {})
funfeatures = menu.list(menu.my_root(), "娱乐选项", {})
Recovery_list = menu.list(menu.my_root(), "恢复选项", {})
module_list = menu.list(menu.my_root(), "模组选项", {})
protection = menu.list(menu.my_root(), "保护选项", {})
tp_world = menu.list(menu.my_root(), "传送选项", {})
worldlist = menu.list(menu.my_root(), "世界选项", {})
cheater_detection = menu.list(menu.my_root(), "作弊检测", {})
otherlist = menu.list(menu.my_root(), "其他选项", {})
ResourceList = menu.list(menu.my_root(), "资源列表", {}, "友人帐");appmenu.Ultioff.ResourceList = ResourceList
check_game_version() -- 游戏版本检测

--自我选项
health_opt = menu.list(self_option, "生命选项", {}, "")
    self_Invincible = menu.toggle(health_opt, "无敌", {}, "[配置]", function(toggled)
        invincible_self(toggled)
    end);set_menu_value(self_Invincible, luaConfig.self_Invincible, false)
    menu.toggle_loop(health_opt, "半无敌", {}, "不等于无敌,可由高致命性武器击杀", function()
        ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), 328)
    end)
    menu.toggle(health_opt, "允许更高处跌落", {}, "将设置为从10米以上坠落时不会立即死亡", function(toggled)
        PED.SET_DISABLE_HIGH_FALL_DEATH(PLAYER.PLAYER_PED_ID(), toggled)
    end)
    SetMaxHealth = menu.list(health_opt, "设置最大生命值", {}, "")
        menu.toggle_loop(SetMaxHealth, "最大生命值", {}, "", function ()
            max_health_loop()
        end)
        menu.slider(SetMaxHealth, "设置数值", {"moddedhealth"}, "", 100, 9000, 328, 50, function(value)
            set_max_health(value)
        end)
    menu.click_slider(health_opt, "自定义血量", {"setblood"}, "血量低于100会死亡", 1, 1000, 328, 1, function(val)
        ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), val)
    end)
    menu.toggle_loop(health_opt, "无限氧气", {}, "", function()
        PLAYER.SET_PLAYER_UNDERWATER_BREATH_PERCENT_REMAINING(PLAYER.PLAYER_ID(), 100.0)
    end)
    menu.action(health_opt, "补充血量", {}, "", function()
        ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), PED.GET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID()), 0)
    end)
    menu.action(health_opt, "补充护甲", {}, "", function()
        PED.SET_PED_ARMOUR(PLAYER.PLAYER_PED_ID(), 50)
    end)
    menu.toggle_loop(health_opt, "自动复活", {}, "", function ()
        if ENTITY.GET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID()) < 1.0 then
			local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
			PED.RESURRECT_PED(PLAYER.PLAYER_PED_ID())
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, false, false, false)
		end
    end)
    menu.toggle_loop(health_opt, "在死亡点重生", {}, "", function ()
        local my_ped = PLAYER.PLAYER_PED_ID()
        if ENTITY.GET_ENTITY_HEALTH(my_ped) == 0 then
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, false, false, false)
        end
    end)
    menu.toggle_loop(health_opt, "隐形牛鲨睾酮", {}, "没有画效和音效,但属性已经强化", function ()
        PLAYER.SET_PLAYER_WEAPON_DAMAGE_MODIFIER(PLAYER.PLAYER_ID(), 1.44) --0.72
        PLAYER.SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(PLAYER.PLAYER_ID(), 2.0) --1.0
        PLAYER.SET_PLAYER_MELEE_WEAPON_DEFENSE_MODIFIER(PLAYER.PLAYER_ID(), 0.5) --1.0
        util.yield(1000)
    end)

    restock_items = menu.list(health_opt, "补充物品", {}, "")
        menu.action(restock_items, "补满全部零食", {}, "", function()
            STAT_SET_INT("NO_BOUGHT_YUM_SNACKS", 30)
            STAT_SET_INT("NO_BOUGHT_HEALTH_SNACKS", 15)
            STAT_SET_INT("NO_BOUGHT_EPIC_SNACKS", 5)
            STAT_SET_INT("NUMBER_OF_ORANGE_BOUGHT", 10)
            STAT_SET_INT("NUMBER_OF_BOURGE_BOUGHT", 10)
            STAT_SET_INT("NUMBER_OF_CHAMP_BOUGHT", 5)
            STAT_SET_INT("CIGARETTES_BOUGHT", 20)
            STAT_SET_INT("NUMBER_OF_SPRUNK_BOUGHT", 10)
            util.toast("完成！")
        end)
        menu.action(restock_items, "补满护甲装备", {}, "", function()
            STAT_SET_INT("MP_CHAR_ARMOUR_1_COUNT", 10)
            STAT_SET_INT("MP_CHAR_ARMOUR_2_COUNT", 10)
            STAT_SET_INT("MP_CHAR_ARMOUR_3_COUNT", 10)
            STAT_SET_INT("MP_CHAR_ARMOUR_4_COUNT", 10)
            STAT_SET_INT("MP_CHAR_ARMOUR_5_COUNT", 10)
            util.toast("完成！")
        end)
        menu.action(restock_items, "补满呼吸器", {}, "", function()
            STAT_SET_INT("BREATHING_APPAR_BOUGHT", 20)
            util.toast("完成！")
        end)
        
    menu.toggle_loop(health_opt, '自动加血', {}, '一直加血直到您的血被加满.', function()
        autoBloodReture()
    end)
    menu.toggle(health_opt, "在掩体后时补充生命值", {}, "", function(toggled)
        healthincover(toggled)
    end)

movement_opt = menu.list(self_option, "移动选项", {}, "")
    menu.toggle(movement_opt, "悬浮模式", {}, "", function(toggled)
        levitate_mode(toggled)
    end)
    menu.toggle(movement_opt, "禁用摔倒", {}, "使你的人物无法摔倒", function(toggled)
        disable_ragdoll(toggled)
    end)
    menu.toggle(movement_opt, "安全带", {}, "防止你从两轮车上摔下来或从挡风玻璃上飞出去", function(toggled)
        seat_belt(toggled)
    end)
    menu.toggle_loop(movement_opt, "穿墙", {}, "", function()
        PED.SET_PED_CAPSULE(PLAYER.PLAYER_PED_ID(), 0.001)
    end)
    menu.toggle(movement_opt, "无碰撞", {}, "完全失去碰撞", function(toggle)
        ENTITY.SET_ENTITY_COLLISION(PLAYER.PLAYER_PED_ID(), not toggle, true)
    end)
    menu.toggle(movement_opt, "推伞", {}, "按住空格时改变跳伞时的推力速度", function(toggled)
        push_parachute(toggled)
    end)
    menu.list_action(movement_opt, "行走风格", {}, "", movement_style.name, function(index)
        if index == 1 then
            PED.RESET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), 0.5)
        else
            local style = movement_style.value[index]
            request_anim_set(style)
            PED.SET_PED_MOVEMENT_CLIPSET(PLAYER.PLAYER_PED_ID(), style, 0.5)
        end
    end)
    menu.toggle_loop(movement_opt,'软趴趴移动', {}, '关闭禁用摔倒', function()
        soft_moving()
    end)
    appmenu.Ultion.SupermanFly = menu.toggle(movement_opt, "蜘蛛侠飞行", {}, "", function(on)
        superman_fly(on)
    end)
    ls_walkwater = menu.toggle(movement_opt, "在水上行走", {}, "",  function(on)
        walkonwater = on
        if on then
            menu.set_value(ls_driveonwater, false)
            menu.set_value(ls_driveonair, false)
        end
    end)
    menu.toggle(movement_opt, "空中行走", {}, "仅适用于线上默认角色", function(on)
        walk_on_air(on)
    end)

aspect_opt = menu.list(self_option, "外观选项", {}, "")
    menu.action(aspect_opt, "读取外观", {}, "将保存一个A-test.txt文件位于预设服装库,供给服装制作使用", function()
        read_appearance()
    end)
    Face_Editor = menu.list(aspect_opt, "面部编辑器", {}, "仅适用于线上角色")
        menu.slider_float(Face_Editor, "鼻子宽度 (Thin/Wide)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 0, Value)
        end)
        menu.slider_float(Face_Editor, "鼻峰 (Up/Down)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 1, Value)
        end)
        menu.slider_float(Face_Editor, "鼻子宽度 (Long/Short)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 2, Value)
        end)
        menu.slider_float(Face_Editor, "鼻骨 Curveness (Crooked/Curved)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 3, Value)
        end)
        menu.slider_float(Face_Editor, "鼻尖 (Up/Down)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 4, Value)
        end)
        menu.slider_float(Face_Editor, "鼻骨扭曲 (Left/Right)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 5, Value)
        end)
        menu.slider_float(Face_Editor, "眉毛 (Up/Down)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 6, Value)
        end)
        menu.slider_float(Face_Editor, "眉毛 (In/Out)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 7, Value)
        end)
        menu.slider_float(Face_Editor, "颧骨 (Up/Down)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 8, Value)
        end)
        menu.slider_float(Face_Editor, "脸颊侧面骨骼 (In/Out)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 9, Value)
        end)
        menu.slider_float(Face_Editor, "颧骨宽度 (Puffed/Gaunt)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 10, Value)
        end)
        menu.slider_float(Face_Editor, "眼廓 (Wide/Squinted)", {}, "", -100, 100, 0, 10, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 11, Value)
        end)
        menu.slider_float(Face_Editor, "唇厚度 (Fat/Thin)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 12, Value)
        end)
        menu.slider_float(Face_Editor, "颌骨宽度 (Narrow/Wide)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 13, Value)
        end)
        menu.slider_float(Face_Editor, "颌骨形状 (Round/Square)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 14, Value)
        end)
        menu.slider_float(Face_Editor, "颏骨 (Up/Down)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 15, Value)
        end)
        menu.slider_float(Face_Editor, "颏骨长度 (In/Out or Backward/Forward)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 16, Value)
        end)
        menu.slider_float(Face_Editor, "颏骨形状 (Pointed/Square)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 17, Value)
        end)
        menu.slider_float(Face_Editor, "颏骨洞 (Chin Bum)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 18, Value)
        end)
        menu.slider_float(Face_Editor, "颈部厚度 (Thin/Thick)", {}, "", -100, 100, 0, 1, function(Value)
            PED.SET_PED_MICRO_MORPH(PLAYER.PLAYER_PED_ID(), 19, Value)
        end)

    menu.toggle_loop(aspect_opt, "清洁全身", {}, "清洁全身污渍", function()
        PED.CLEAR_PED_BLOOD_DAMAGE(PLAYER.PLAYER_PED_ID())
        PED.CLEAR_PED_WETNESS(PLAYER.PLAYER_PED_ID())
        PED.CLEAR_PED_ENV_DIRT(PLAYER.PLAYER_PED_ID())
    end)
    menu.toggle_loop(aspect_opt, "清除血迹", {}, "仅清洁自身的血迹", function()
        PED.CLEAR_PED_BLOOD_DAMAGE(PLAYER.PLAYER_PED_ID())
    end)
    menu.click_slider(aspect_opt, "设置湿度", {}, "使PED在水中浸泡到指定的高度", 0, 2000, 0, 10, function(value)
        if value == 0 then PED.CLEAR_PED_WETNESS(PLAYER.PLAYER_PED_ID()) else PED.SET_PED_WETNESS_HEIGHT(PLAYER.PLAYER_PED_ID(), (value-1000) / 1000) end
    end)
    menu.toggle_loop(aspect_opt, "全身湿透", {}, "", function()
        PED.SET_PED_WETNESS_HEIGHT(PLAYER.PLAYER_PED_ID(), 1)
		PED.SET_PED_WETNESS_ENABLED_THIS_FRAME(PLAYER.PLAYER_PED_ID())
    end)
    menu.action(aspect_opt, "随机外观", {}, "", function()
        PED.SET_PED_RANDOM_COMPONENT_VARIATION(PLAYER.PLAYER_PED_ID(), 0)
    end)
    menu.action(aspect_opt, "恢复默认套装", {}, "", function()
        PED.SET_PED_DEFAULT_COMPONENT_VARIATION(PLAYER.PLAYER_PED_ID())
        PED.CLEAR_ALL_PED_PROPS(PLAYER.PLAYER_PED_ID())
    end)
    changemodel_list = menu.list(aspect_opt, "预设模型", {}, "")
        for _, tab in pairs(my_model_list) do
            menu.action(changemodel_list, tab[1], {}, "", function()
                change_model(PLAYER.PLAYER_ID(), tab[2])
            end)
        end
        menu.action(changemodel_list, "胡桃", {}, "", function()
            become_walnuts()
        end)

    my_cloth = menu.list(aspect_opt, "预设服装", {}, "", function()
            Preset_outfits()
        end,function()
            endPreset_outfits()
    end)
    menu.toggle(aspect_opt, "人物缩小", {}, "", function(toggled)
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 223, toggled)
    end)
    menu.toggle_loop(aspect_opt, "彩虹头发", {}, "", function()
        PED1._SET_PED_HAIR_COLOR(PLAYER.PLAYER_PED_ID(), math.random(33, 53), math.random(33, 53))--发型颜色
        util.yield(100)
    end)
    menu.click_slider(aspect_opt, '幽灵', {}, '修改您人物的不透明度.', 0, 255, 255, 51, function(value)
        ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), value, false)
    end)
    menu.list_select(aspect_opt, "不可见", {}, "当你在载具时,其他玩家仍能看到你,除非你也开启了载具内的不可见", {{1,'关闭'},{2,'本地可见'},{3,'开启'}}, 1,function(value)
        invisible(PLAYER.PLAYER_PED_ID(), value)
    end)

action_list = menu.list(self_option, "人物行为", {}, "")
    menu.toggle(action_list, '允许下蹲', {}, '通过ctrl', function(toggle)
        allow_ducking(toggle)
    end)
    menu.toggle_loop(action_list, "举起手来",{}, "长按x",function()
        raise_hand()
    end)
    menu.toggle_loop(action_list, '自转', {}, '', function()
        ENTITY.APPLY_FORCE_TO_ENTITY(PLAYER.PLAYER_PED_ID(), 5, 200, 8200, 89000, 10, 10, 100, 10000, false, true)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
    end)
    menu.toggle_loop(action_list, '超级跳跃', {}, '', function()
        if PAD.IS_CONTROL_PRESSED(0, 22) and PAD.IS_CONTROL_PRESSED(0, 32) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) and not ENTITY.IS_ENTITY_IN_AIR(PLAYER.PLAYER_PED_ID()) then
			if WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) ~= 1119849093 then -- 火神机枪
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PLAYER.PLAYER_PED_ID(), 0, 0, 500, 500, false, true, true, false)
            end
        end
    end)
    menu.toggle_loop(action_list, '野兽跳跃', {}, '', function()
        MISC.SET_SUPER_JUMP_THIS_FRAME(PLAYER.PLAYER_ID())
        --[[ if PAD.IS_CONTROL_JUST_PRESSED(0, 22) and not ENTITY.IS_ENTITY_IN_AIR(PLAYER.PLAYER_PED_ID()) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
            TASK.TASK_JUMP(PLAYER.PLAYER_PED_ID(), true, true, true)
        end ]]
    end)
    menu.toggle(action_list, '超级跑', {}, '', function(toggled)
        local speed = toggled and 1.49 or 1.0
        PLAYER.SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(PLAYER.PLAYER_ID(), speed)
    end)
    menu.toggle(action_list, '快速游泳', {}, '', function(toggled)
        local speed = toggled and 1.49 or 1.0
        PLAYER.SET_SWIM_MULTIPLIER_FOR_PLAYER(PLAYER.PLAYER_ID(), speed)
    end)
    menu.toggle_loop(action_list, '抽搐野兽跳跃', {}, '', function()
        MISC.SET_BEAST_JUMP_THIS_FRAME(PLAYER.PLAYER_ID())
    end)
    menu.toggle_loop(action_list, "快速上下车", {}, "更快地进入/离开车辆.", function()
        if (TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 160) or TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 167) or TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 165)) and not TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 195) then
            PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(PLAYER.PLAYER_PED_ID())
        end
    end)
    menu.toggle_loop(action_list, "快速翻越", {}, "更快的翻越一些东西\n例如: 汽车、障碍物等.", function()
        if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 50) or TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 51) then
            PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(PLAYER.PLAYER_PED_ID())
        end
    end)
    menu.toggle_loop(action_list, "空中游泳", {}, "", function()
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 65, 81)
    end)
    menu.toggle_loop(action_list, "太空步", {}, "", function()
        Space_walk()
    end)
    menu.toggle(action_list, "忍者跑",{}, "忍者跑步动作",function(on)
        renzhepao(on)
    end)
    presets_action = menu.list(action_list, "预设动作", {}, "")
        menu.action(presets_action, "前空翻", {}, "表演一个前空翻", function()
            forward_somersault()
        end)
        menu.toggle(presets_action, "弹吉他", {}, "", function(on)
            Play_guitar(on)
        end)
        menu.toggle(presets_action, "掌旋球", {}, "", function(on)----GT
            Palm_spin_ball(on)
        end)
        menu.toggle(presets_action, "乞求", {}, "", function(on)
            seek_help(on)
        end)
        menu.toggle(presets_action, "献花", {}, "", function(on)
            offer_flower(on)
        end)
        menu.toggle(presets_action, "打伞", {}, "", function(on)
            hold_umbrella(on)
        end)
        menu.toggle_loop(presets_action, "前滚翻", {}, "", function()
                forward_roll()
            end, function()
                end_forward_roll()
        end)
        menu.toggle_loop(presets_action, "街舞", {}, "", function()
                breakdance()
            end, function()
                end_breakdance()
        end)
        menu.textslider(presets_action, "表演", {}, "", {"翻跟斗","后空翻","飞腿"}, function (index)
            Performing_actions(index)
        end)
    
    action_list_lua = menu.list(action_list, "动作选项", {}, "")
        require "lib.SakuraScript.actions"

menu.toggle(self_option, "快速重生", {}, "", function(toggled) --Update tag(1.69) (https://github.com/TupoyeMenu/TupoyeMenu/blob/5c9bcabe799caac1c10edefb4d9aaf1cf8df1a4d/src/backend/looped/self/fast_respawn.cpp#L18)
    fastrespawn_toggled = toggled  --freemode_properties
    local gwobaw = memory.script_global(2672855 + 1728 + 756) --Global_2672855.f_1728.f_756
    while fastrespawn_toggled do
        if PED.IS_PED_DEAD_OR_DYING(PLAYER.PLAYER_PED_ID()) then
            memory.write_int(gwobaw, memory.read_int(gwobaw) | 1 << 1)
        end
        util.yield()
    end
    memory.write_int(gwobaw, memory.read_int(gwobaw) &~ (1 << 1)) 
end)

menu.toggle_loop(self_option, '超级飞行', {}, '按下跳跃的时间越长,继续走得更高（也可用于飞行）', function()
    if PAD.IS_CONTROL_PRESSED(0, 22) and PAD.IS_CONTROL_PRESSED(0, 32) then
        PED.SET_PED_CAN_RAGDOLL(PLAYER.PLAYER_PED_ID(), false)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PLAYER.PLAYER_PED_ID(), 1, 0, 0.6, 0.6, true, true, true, true)
        if ENTITY.IS_ENTITY_IN_AIR(PLAYER.PLAYER_PED_ID()) then
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(PLAYER.PLAYER_PED_ID(), 1, 0, 0, 0.6, true, true, true, true)
        end
    end
end)

----火人
Burning_Man = menu.toggle(self_option, "火人", {}, "", function(on)
    fireself(on)
end)
menu.toggle_loop(self_option, "光环", {}, "", function()
    personllight()
end)   

attach_self = menu.list(self_option, "附加选项", {})
    attach_snowman = menu.list(attach_self, "雪人", {})
        menu.toggle(attach_snowman, "雪人v1",{}, "",function(on)
            local zhangzi = "prop_gumball_03"
            local sonwman = "prop_prlg_snowpile"
            if on then
                attach_to_player(sonwman, 0, 0.0, 0, 0, 0, 0,0)
                attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)
                attach_to_player(sonwman, 0, 0.0, 0, -1, 0, 0,0)
                attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 50,0)
                attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 125,0)
                attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -50,0)
                attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -125,0)
            else
                delete_object(sonwman)
                delete_object(zhangzi)
            end
        end)
        menu.toggle(attach_snowman, "雪人v2",{}, "",function(on)
            local sonwman = "xm3_prop_xm3_snowman_01b"
            if on then
                attach_to_player(sonwman, 0, 0, 0, -0.7, 0, 0, 180)
                ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 0, false)
            else
                delete_object(sonwman)
                ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 255, false)
            end
        end)
        menu.toggle(attach_snowman, "雪人v3",{}, "",function(on)
            local sonwman = "xm3_prop_xm3_snowman_01c"
            if on then
                attach_to_player(sonwman, 0, 0, 0, -0.7, 0, 0, 180)
                ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 0, false)
            else
                delete_object(sonwman)
                ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 255, false)
            end
        end)
        menu.toggle(attach_snowman, "雪人v4",{}, "",function(on)
            local sonwman = "xm3_prop_xm3_snowman_01a"
            if on then
                attach_to_player(sonwman, 0, 0, 0, -0.7, 0, 0, 180)
                ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 0, false)
            else
                delete_object(sonwman)
                ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), 255, false)
            end
        end)

        attach_Handmade = menu.list(attach_self, "手办背包", {})
            for k, v in pairs(plushiepack_list) do
                menu.toggle(attach_Handmade, v.name, {}, "", function (toggled)
                    add_props(toggled, v)
                end)
            end


    menu.toggle(attach_self, "娃娃熊挂件",{}, "",function(on)
        obj = "v_ilev_mr_rasberryclean"
        if on then     
            attach_to_player(obj, 0, 0, -0.2, 0.25, 0, 30,0)
        else
            delete_object(obj)
        end
    end)
    menu.toggle(attach_self, "剑圣", {}, "", function(state)
        local obj = "prop_cs_katana_01"
        if state then
            attach_to_player(obj, 0, 0, -0.13, 0.5, 0, -150,0)
            attach_to_player(obj, 0, 0, -0.13, 0.5, 0, 150,0)
            attach_to_player(obj, 0, 0.23, 0, 0, 0, -180,100)
        else
            delete_object(obj)
        end
    end)
    menu.toggle(attach_self, "666",{}, "",function(on)
        obj = "prop_mp_num_6"
        if on then     
            attach_to_player(obj, 0, 0, 0, 1.7, 0, 0, 180)
            attach_to_player(obj, 0, 1, 0, 1.7, 0, 0, 180)
            attach_to_player(obj, 0, -1, 0, 1.7, 0, 0, 180)
        else
            delete_object(obj)
        end
    end)
    menu.toggle(attach_self, "冲浪板",{}, "",function(on)
        obj = "prop_surf_board_ldn_03"
        if on then     
            attach_to_player(obj, 0, 0, -0.2, 0.25, 0, -30,0)
        else
            delete_object(obj)
        end
    end)
    menu.toggle(attach_self, "小书包",{}, "",function(on)
        obj = "tr_prop_tr_bag_djlp_01a"
        if on then     
            attach_to_player(obj, 0, 0, -0.2, 0.1, 0, 0,0)
        else
            delete_object(obj)
        end
    end)
    menu.toggle(attach_self, "泳圈",{}, "",function(on)
        obj = "prop_beach_ring_01"
        if on then     
            attach_to_player(obj, 0, 0, 0, 0, 0, 0,0)
        else
            delete_object(obj)
        end
    end)
    guitar_obj = menu.list(attach_self, "吉他")
        menu.toggle(guitar_obj, "吉他1",{}, "",function(on)
            local obj = "prop_acc_guitar_01"
            if on then     
                attach_to_player(obj, 0, 0, -0.15, 0.25, 0, -50,0)
            else
                delete_object(obj)
            end
        end)
        menu.toggle(guitar_obj, "吉他2",{}, "",function(on)
            local obj = "prop_el_guitar_03"
            if on then     
                attach_to_player(obj, 0, 0, -0.15, 0.25, 0, -50,0)
            else
                delete_object(obj)
            end
        end)
        menu.toggle(guitar_obj, "吉他3",{}, "",function(on)
            local obj = "prop_el_guitar_01"
            if on then     
                attach_to_player(obj, 0, 0, -0.15, 0.25, 0, -50,0)
            else
                delete_object(obj)
            end
        end)
        menu.toggle(guitar_obj, "吉他4",{}, "",function(on)
            local obj = "prop_el_guitar_02"
            if on then     
                attach_to_player(obj, 0, 0, -0.15, 0.25, 0, -50,0)
            else
                delete_object(obj)
            end
        end)
    menu.toggle_loop(attach_self, "镜子", {}, "", function()
        if GRAPHICS.UI3DSCENE_IS_AVAILABLE() then
            if GRAPHICS.UI3DSCENE_PUSH_PRESET("CELEBRATION_WINNER") then
                GRAPHICS.UI3DSCENE_ASSIGN_PED_TO_SLOT("CELEBRATION_WINNER", PLAYER.PLAYER_PED_ID(), 0, 0.0, 0.0, 0.0);
            end
        end
    end)

menu.toggle_loop(self_option, '金钱追踪', {}, '', function()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
    request_ptfx_asset('scr_exec_ambient_fm')
    if TASK.IS_PED_WALKING(PLAYER.PLAYER_PED_ID()) or TASK.IS_PED_RUNNING(PLAYER.PLAYER_PED_ID()) or TASK.IS_PED_SPRINTING(PLAYER.PLAYER_PED_ID()) then
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('scr_ped_foot_banknotes', pos.x, pos.y, pos.z - 1, 0, 0, 0, 1.0, true, true, true)
    end
end)
tripped = menu.list(self_option, '摔倒', {}, '')
    menu.toggle_loop(tripped, '笨拙', {}, '让您的人物很容易摔倒.', function()
        clumsy()
    end)
    menu.action(tripped, '绊倒', {}, '让你绊倒,很可能会摔倒.', function()
        stumble()
    end)
    menu.toggle(tripped, '摔倒v1', {}, '', function(toggle)
        tripped1(toggle)
    end)
    menu.toggle_loop(tripped, '摔倒v2', {}, '', function()
        PED.SET_PED_TO_RAGDOLL(PLAYER.PLAYER_PED_ID(), 2000, 2000, 0, true, true, true)
    end)

trailsOpt = menu.list(self_option,"轨迹", {}, "")
    menu.toggle_loop(trailsOpt,"轨迹", {"trails"}, "", function()
        Character_locus()
    end)
    menu.rainbow(menu.colour(trailsOpt,"颜色", {"trailcolour"}, "",{r = 1.0, g = 0.0, b = 1.0, a = 1.0}, false, function(newColour)
        locus_color(newColour)
    end))


fire_wings = menu.list(self_option, '翅膀', {})
    menu.toggle(fire_wings, "金色翅膀", {}, "", function(on)
        Golden_wings(on)
    end)
    menu.toggle(fire_wings, "银色翅膀", {}, "", function(on)
        argent_wings(on)
    end)
    appmenu.Ultion.FireWing = menu.toggle(fire_wings, '火翅膀', {}, '2t同款翅膀', function(toggled)
        fireWing(toggled)
    end)
    appmenu.Ultion.XPFireWing = menu.toggle(fire_wings, 'XP火翅膀', {}, '', function(toggled)
        xp_fireWing(toggled)
    end)
    appmenu.Ultion.ColorfulFireWing = menu.toggle(fire_wings, '彩虹翅膀', {}, '', function(toggled)
        colorful_fireWing(toggled)
    end)
    appmenu.Ultion.DragonBreath = menu.toggle_loop(self_option, "龙息", {}, "键盘按E/手柄RB", function()
        Dragon_Breath()
    end)

firebreath = menu.list(self_option, '喷火', {}, '')
    menu.toggle(firebreath, '喷火', {}, '', function(toggle)
        firebreathxxx(toggle)
    end)
    menu.slider(firebreath, '喷火比例', {'JSfireBreathScale'}, '', 1, 100, fireBreathSettings.scale * 10, 1, function(value)
        firebreathscale(value)
    end)
    menu.rainbow(menu.colour(firebreath, '喷火颜色', {'JSfireBreathColour'}, '', fireBreathSettings.colour, 1, function(colour)
        firebreathcolour(colour)
    end))

menu.action(self_option, "拉便便", {}, "", function()
    personlshit()
end)
menu.action(self_option, "打飞机", {}, "", function()
    personlhitplane()
end)
menu.action(self_option, "起飞", {}, "", function()
	local myPos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
	ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), myPos.x, myPos.y, myPos.z + 250.0, 1, 0, 0, 1)
end)

menu.textslider(self_option, "修改降落伞", {}, "",Pparachute, function(index)
    PLAYER.SET_PLAYER_PARACHUTE_TINT_INDEX(PLAYER.PLAYER_ID(), index-1)
end)
menu.action(self_option, "给予降落伞", {}, "", function()
	WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), util.joaat("gadget_parachute"), 1, false)
end)
menu.action(self_option, "强制打开降落伞", {}, "", function()
	PED.FORCE_PED_TO_OPEN_PARACHUTE(PLAYER.PLAYER_PED_ID())
end)


wanted_level = menu.list(self_option, '通缉选项', {}, '')
    menu.click_slider(wanted_level, '通缉等级', {}, '', 0, 5, 0, 1, function(value)
        PLAYER.SET_PLAYER_WANTED_LEVEL(PLAYER.PLAYER_ID(), value, false)
        PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(PLAYER.PLAYER_ID(),  false)
    end)
    menu.toggle_loop(wanted_level, '永不通缉', {}, '', function()
        PLAYER.SET_PLAYER_WANTED_LEVEL(PLAYER.PLAYER_ID(), 0, false)
        PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(PLAYER.PLAYER_ID(),  false)
    end)
    menu.click_slider(wanted_level, '虚假通缉等级', {}, '', 0, 6, 0, 1, function(value)
        MISC.SET_FAKE_WANTED_LEVEL(value)
    end)

menu.list_action(self_option, "获取导弹", {}, "选择导弹", obj_pp.name, function(index, value, click_type)
    dd02(index, value, click_type)
end)

menu.action(self_option, "低射炮", {}, "从某个位置发射一枚火炮", function()
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trailburst"
    request_ptfx_asset(ptfx_asset)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, PLAYER.PLAYER_PED_ID(), 0.0, 0.0, -0.3, -90.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
    for i=1, 10 do 
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, i, 0.0)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 67, 0.0, false, false, 0.0, true)
    end
end)
menu.toggle(self_option, '启用脚印', {}, '留下雪地脚印', function(toggle)
    GRAPHICS.USE_SNOW_FOOT_VFX_WHEN_UNSHELTERED(toggle)
end)
menu.toggle(self_option, "假死", {}, "地图上不会出现你", function(on)
    if on then
        ENTITY.SET_ENTITY_MAX_HEALTH(PLAYER.PLAYER_PED_ID(), 0)
    else
        ENTITY.SET_ENTITY_MAX_HEALTH(PLAYER.PLAYER_PED_ID(), 328)
    end
end)
menu.action(self_option, "自杀", {}, "", function()
	ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), 0, 0)
end)


----战局选项
local new_session = menu.list(online, "新的战局", {}, "")--Update tag(1.69)
    for idx, tab in pairs(session_name) do
        new_session:action(tab.name, {}, "", function()
            switch_session(Global_Base.SessionSwitchType, tab.session_id)
        end)
    end
    new_session:action("退回 故事模式", {}, "", function()
        switch_session(Global_Base.SessionSwitchCache, -1)
    end)

players_list = menu.list(online, "在线玩家", {}, "")
    players.on_join(player_list)
    players.on_leave(handle_player_list)

frendlist = menu.list(online, "好友列表", {}, "")
    menu.divider(frendlist, "好友:)")
    get_friend_list() 

local enhance_list = menu.list(online, "增强选项", {}, "")
    menu.action(enhance_list,"跳过线上教程", {""}, "", function()
        NETWORK.NETWORK_END_TUTORIAL_SESSION()
    end)
    local Host_Tools_list = menu.list(enhance_list, "主机工具", {}, "")
        menu.click_slider(Host_Tools_list, "战局玩家上限", {}, "战局中的最大玩家数仅在您担任主持人时有效", 1, 32, 32, 1, function (value)
            NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(0, value)
            util.toast("free slots: " .. NETWORK.NETWORK_SESSION_GET_MATCHMAKING_GROUP_FREE(0))
        end)
        menu.click_slider(Host_Tools_list, "观看者上限", {}, "最大观众数仅在您担任主持人时有效", 0, 2, 2, 1, function (value)
            NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(4, value)
            util.toast("free slots: " .. NETWORK.NETWORK_SESSION_GET_MATCHMAKING_GROUP_FREE(4))
        end)
        appmenu.Ultion.AutoReadyHost = menu.toggle_loop(Host_Tools_list, "自动就绪主机", {}, "当你在队列中是下位主机时踢出当前主机",function()
            AutoReadyHost()
        end)

    menu.toggle_loop(enhance_list, "过渡状态", {}, "更换战局时显示当前过渡状态", function()
        show_transition_active()
    end)
    menu.toggle_loop(enhance_list, "移除天基炮冷却", {}, "",function()
        STAT_SET_INT("ORBITAL_CANNON_COOLDOWN", 0)
    end)
    menu.toggle_loop(enhance_list, "移除筹码购买冷却", {}, "",function()
        STAT_SET_INT("MPPLY_CASINO_CHIPS_PUR_GD", 0)
    end)
    menu.toggle(enhance_list, "移除虎鲸导弹冷却", {}, "", function(toggled)--Update tag(1.69)
        SET_INT_GLOBAL(Global_Base.Default + 29635, toggled and 0 or 60000)
    end)
    menu.toggle_loop(enhance_list, "解除老虎机限制", {}, "",function()
        STAT_SET_INT("MPPLY_CASINO_CHIPS_WON_GD", 0)
    end)

--战局信息
online_other = menu.list(online, "战局信息", {}, "")
    play_info =menu.list(online_other, "玩家信息", {}, "")
        require "lib.SakuraScript.InfOverlay"
        menu.toggle_loop(play_info, "绘制玩家模型", {}, "当选中玩家时预览玩家模型",function()
            Draw_player_model()
        end)

    menu.toggle_loop(online_other, "玩家加入通知", {}, "", function ()
        player_join(function(pid, name)
            util.toast("[加入游戏] " .. PLAYER.GET_PLAYER_NAME(pid))
        end)
    end)
    menu.toggle_loop(online_other, "玩家离开通知", {}, "", function ()
        player_leave(function(pid, name)
            util.toast("[离开游戏] " .. name)
        end)
    end)
    menu.toggle_loop(online_other, "关闭电台", {}, "",function()
        AUDIO.SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY(false)
        AUDIO.SET_RADIO_TO_STATION_NAME("OFF")
    end)
    menu.toggle(online_other, "移动电台", {}, "让你步行的时候也能听电台",function(toggled)
        AUDIO.SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY(toggled)
    end)
    menu.toggle_loop(online_other, '同步时间', {}, '与现实时间同步', function()
        Real_world_time()
    end)
    menu.toggle_loop(online_other,"绘制海拔", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local strg = "~b~ Elevation ~w~"..math.ceil(pos.z) / 1000 .."KM"
        draw_string(strg, 0.03, 0.1, 0.6, 4)
    end)
    menu.toggle_loop(online_other,"绘制到导航点的距离", {}, "", function()
        if HUD.IS_WAYPOINT_ACTIVE() then
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
            local waypoint = HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID()))
            local dis = Get_distance(pos, waypoint, false)
            local strg = "~b~ Distance ~w~"..math.ceil(dis).." m"
            draw_string(strg, 0.03, 0.15, 0.6, 4)
        else
            local strg = "~b~ Distance ~w~ -N-"
            draw_string(strg, 0.03, 0.15, 0.6, 4)
        end
    end)
    menu.toggle_loop(online_other,"绘制游戏时间", {}, "", function()
        local Time1 = CLOCK.GET_CLOCK_HOURS()
        local Time2 = CLOCK.GET_CLOCK_MINUTES()
        local h = string.format("%02d", Time1)
        local m = string.format("%02d", Time2)
        local strg = "~b~ Time ~w~"..h.." : "..m
        draw_string(strg, 0.03, 0.2, 0.6, 4)
    end)
    menu.toggle_loop(online_other,"绘制区域", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        draw_string(string.format("~b~ Zone ~w~"..ZONE.GET_NAME_OF_ZONE(pos.x,pos.y,pos.z)), 0.03, 0.25, 0.6, 4)
    end)

    menu.toggle_loop(online_other,"绘制坐标", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local strg = "~b~ pos x:  ~w~"..pos.x.."\n~b~ pos y:  ~w~"..pos.y.."\n~b~ pos z:  ~w~"..pos.z
        draw_string(strg, 0.85, 0.1, 0.5, 4)
    end)

    show_time = menu.toggle_loop(online_other, "现实时间", {}, "[配置]", function()
        real_time()
    end);set_menu_value(show_time, luaConfig.show_time, true)

    host_sequence_list = menu.list(online_other,"主机序列",{},"")
        host_sequence = menu.toggle_loop(host_sequence_list, "主机序列", {}, "[配置]", function()
            zhujixvlie()
        end);set_menu_value(host_sequence, luaConfig.host_sequence, true)
        host_sequence_x = menu.slider(host_sequence_list, "x坐标", {"watermark-x"}, "[配置]", -1000, 1000, (luaConfig.host_sequence_x or 175), 1, function(x_)
            zhujixvlie_x(x_)
        end)
        host_sequence_y = menu.slider(host_sequence_list, "y坐标", {"watermark-y"}, "[配置]", -1000, 1000, (luaConfig.host_sequence_y or 720), 1, function(y_)
            zhujixvlie_y(y_)
        end)

    numfps = menu.toggle(online_other, "显示fps", {}, "[配置]", function(toggled)
        get_fps(toggled)
    end);set_menu_value(numfps, luaConfig.numfps, false)

    show_entityinfo = menu.toggle_loop(online_other, "实体池信息", {}, "[配置]", function()
        entityinfo()
    end);set_menu_value(show_entityinfo, luaConfig.show_entityinfo, false)

    script_name = menu.toggle_loop(online_other, "显示脚本名称", {}, "[配置]", function()
        scriptname()
    end);set_menu_value(script_name, luaConfig.script_name, true)

    players_bar = menu.toggle_loop(online_other, "玩家栏", {}, "[配置]", function()
        player_bar()
    end);set_menu_value(players_bar, luaConfig.players_bar, false)


request_services = menu.list(online, "请求服务", {}, "")
    request_weather = menu.list(request_services, "请求天气", {}, "")
        menu.action(request_weather, "请求雷雨天气", {}, "", function()
            menu.trigger_commands("thunderon")
        end)
        menu.action(request_weather, "关闭雷雨天气", {}, "", function()
            menu.trigger_commands("thunderoff")
        end)
    menu.action(request_services, "请求古奇", {}, "", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.launcher_global + 5, 171)
        SET_INT_GLOBAL(Global_Base.launcher_global + 3, 6)
    end)
    menu.action(request_services, "纳米无人机", {}, "", function()--Update tag(1.69)
        local address = memory.script_global(Global_Base.NanoDrone)
        memory.write_int(address, memory.read_int(address) | 0x1C00000)
    end)
    menu.action(request_services, "RC匪徒", {}, "拥有才可正常使用", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 6957, 1)
    end)
    menu.action(request_services, "RC坦克", {}, "拥有才可正常使用", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 6958, 1)
    end)
    menu.action(request_services, "请求空袭", {}, "", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 4508, 1)
    end)
    menu.action(request_services, "请求支援直升机", {}, "", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 4507, 1)
    end)
    menu.action(request_services, "请求直升机接送", {}, "", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 909, 1)
    end)
    menu.action(request_services, "请求出租车", {}, "", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 869, 1)
    end)
    menu.action(request_services, "请求船只接送", {}, "需在海上", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 908, 1)
    end)
    menu.action(request_services, "请求送货摩托车", {}, "", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 1010, 1)
    end)
    menu.action(request_services, "重型防弹装甲", {}, "", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 917, 1)
    end)
    menu.action(request_services, "请求弹药空投", {}, "", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 907, 1)
    end)
    menu.action(request_services, "机动作战中心", {}, "不可同时请求多种服务载具", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 946, 1)
    end)
    menu.action(request_services, "复仇者", {}, "不可同时请求多种服务载具", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 954, 1)
    end)
    menu.action(request_services, "恐霸", {}, "不可同时请求多种服务载具", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 959, 1)
    end)
    menu.action(request_services, "请求致幻剂实验室", {}, "不可同时请求多种服务载具", function()--Update tag(1.69-3351)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 960, 1)
    end)

online_services = menu.list(online, "线上服务", {}, "")
    menu.action(online_services, "随机名字", {}, "", function()
        menu.trigger_commands("spoofedname " .. random_string(math.random(1, 16)))
        menu.trigger_commands("spoofname on")
    end)
    online_unlock = menu.list(online_services, "解锁选项", {}, "")
        menu.action(online_unlock, "解锁服饰", {}, "", function()--Update tag(1.69)
            for i = 35629, 35684 do
                SET_INT_GLOBAL(Global_Base.Default + i, 1)
            end
        end)
        menu.action(online_unlock, "解锁车牌", {}, "", function()--Update tag(1.69)
            for i = 29658, 29659 do
                SET_INT_GLOBAL(Global_Base.Default + i, 1)
            end
        end)
        menu.action(online_unlock, "解锁原子能枪", {}, "", function()--Update tag(1.69)
            SET_INT_GLOBAL(104496, 90) -- freemode.c
        end)
        menu.action(online_unlock, "解锁富兰克林涂饰", {}, "", function()--Update tag(1.69)
            SET_INT_GLOBAL(Global_Base.Default + 34682, 1)  --Global_262145.f_34682
        end)
        menu.action(online_unlock, "解锁麦克涂饰", {}, "", function()--Update tag(1.69)
            SET_INT_GLOBAL(Global_Base.Default + 34683, 1)  --Global_262145.f_34683
        end)
        menu.action(online_unlock, "解锁崔佛叔叔涂饰", {}, "", function()--Update tag(1.69)
            SET_INT_GLOBAL(Global_Base.Default + 34684, 1)  --Global_262145.f_34684
        end)
        menu.action(online_unlock, "解锁小刀&棒球棒涂饰", {}, "", function()--Update tag(1.69)
            SET_INT_GLOBAL(Global_Base.Default + 33309, 1)  --Global_262145.f_33309
        end)
        menu.action(online_unlock, "解锁地堡所有研究 (临时)", {}, "", function()--Update tag(1.69)
            SET_INT_GLOBAL(Global_Base.Default + 21895, 1)
        end)
        menu.toggle(online_unlock, "免费更改角色外观", {}, "", function(toggled)--Update tag(1.69)
            SET_INT_GLOBAL(Global_Base.Default + 18918, toggled and 0 or 100000)
        end)
        menu.click_slider(online_unlock, '设置等级', {}, '更换战局生效', 0, 180, 120, 30, function(value)
            STAT_SET_INT("CHAR_SET_RP_GIFT_ADMIN", player_levels["level"..value])
            util.toast("完成！")
        end)
        menu.click_slider(online_unlock, '设置车友会等级', {}, '更换战局生效', 0, 200, 100, 50, function(value)
            STAT_SET_INT("CAR_CLUB_REP", car_club_levels["level"..value])
            util.toast("完成！")
        end)
        menu.action(online_unlock, "解锁所有成就", {}, "", function()
            for i = 1, 77 do
                PLAYER.GIVE_ACHIEVEMENT_TO_PLAYER(i)
            end
        end)

    menu.toggle_loop(online_services, "强制可见", {}, "强制玩家可见", function()
        force_visible()
    end)
    menu.action(online_services, "赢得刑事毁坏", {}, "", function()
        Win_criminal_damage()
    end)
    menu.toggle_loop(online_services, "赢得检查点", {}, "赢得检查点[战局的吃点活动]", function()
        Win_checkpoints()
    end)
    appmenu.Ultion.HiddenHous = menu.action(online_services,"通知藏匿屋密码", {}, "先进入藏匿屋", function()
        notify_password()
    end)
    appmenu.Ultion.GeraldPackage = menu.action(online_services,"获取杰拉德包裹位置", {}, "先进入杰拉德包裹区域", function()
        get_package()
    end)

    BadSport_opt = menu.list(online_services, "恶劣玩家", {}, "白帽子玩家");appmenu.Ultion.BadSportOpt = BadSport_opt
        menu.action(BadSport_opt, "解锁", {}, "让你成为恶劣玩家", function()
            BadSportSetter(-1, 60000, true)
        end)
        menu.action(BadSport_opt, "移除", {}, "", function()
            BadSportSetter(0, 0, false)
        end)
    menu.action(online_services,"允许当前车辆进入车库", {}, "允许您将任何车辆驶入车库", function()
        carinto()
    end)
    block_transaction_error  = menu.toggle_loop(online_services,"阻止交易错误", {}, "[配置]", function()--Update tag(1.69)
        if NETWORK.NETWORK_IS_SESSION_STARTED() then
            if GET_INT_GLOBAL(4537461) == 4 or GET_INT_GLOBAL(4537461) == 20 then
                SET_INT_GLOBAL(4537455, 0)
            end
        end 
    end);set_menu_value(block_transaction_error, luaConfig.block_transaction_error, false)
    menu.click_slider(online_services, "设置精神状态", {}, "切换战局生效",0, 100, 0, 1, function(val)
        STATS.STAT_SET_FLOAT(MISC.GET_HASH_KEY("MPPLY_PLAYER_MENTAL_STATE"), val, true)
        STATS.STAT_SET_FLOAT(MISC.GET_HASH_KEY("MP0_PLAYER_MENTAL_STATE"), val, true)
        STATS.STAT_SET_FLOAT(MISC.GET_HASH_KEY("MP1_PLAYER_MENTAL_STATE"), val, true)
    end)
    menu.toggle(online_services, "显示余额", {}, "", function(toggled)
        show_credit(toggled)
    end)
    menu.toggle_loop(online_services, '虚假金钱', {}, "100%的假钱", function()
        HUD.CHANGE_FAKE_MP_CASH(0, math.random(10000000, 30000000))
        util.yield(500)
    end)
    menu.action(online_services, "从银行取出钱", {}, "", function()
        bank_to_wallet()
    end)
    menu.action(online_services, "将钱存入银行", {}, "", function()
        wallet_to_bank()
    end)
    menu.toggle_loop(online_services, '自动存款', {}, "", function()
        auto_deposit()
    end)
    menu.action(online_services, "获得牛鲨睾酮", {}, "", function()--Update tag(1.69)
        SET_INT_GLOBAL(Global_Base.BullShark + 3733, 1)
        --menu.trigger_commands("bstonce")
    end)
    menu.action(online_services, "移除悬赏", {}, "", function()
        menu.trigger_commands("removebounty")
    end)
    menu.toggle(online_services, "人间蒸发", {}, "",function(state)
        menu.set_value(menu.ref_by_path("Online>Off The Radar", 38), state)
    end)
    menu.action(online_services, "立刻完成刑事破坏", {}, "", function()
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_criminal_damage")) ~= 0 then
            SET_INT_LOCAL('am_criminal_damage', 105,  10000)
            util.yield(3000)
            SET_INT_LOCAL('am_criminal_damage', 110 + 39, 0)
        end
    end)
    menu.action(online_services, "清除举报", {}, "", function()
        remove_reports()
    end)

local story_mode = menu.list(online, "故事模式", {}, "")
    menu.action(story_mode,"跳过序章", {}, "", function()
        STATS.SET_PROFILE_SETTING_PROLOGUE_COMPLETE()
    end)
    menu.action(story_mode, '一键满钱', {}, '设置三个角色拥有最大资金', function()
        STATS.STAT_SET_INT(MISC.GET_HASH_KEY("SP0_TOTAL_CASH"), 2147483647, 1)
        STATS.STAT_SET_INT(MISC.GET_HASH_KEY("SP1_TOTAL_CASH"), 2147483647, 1)
        STATS.STAT_SET_INT(MISC.GET_HASH_KEY("SP2_TOTAL_CASH"), 2147483647, 1)
    end)
    menu.action(story_mode, "卡回故事模式", {}, "", function()
        NETWORK.NETWORK_BAIL(0, 0, 0)
    end)
    menu.action(story_mode, "强制退回故事模式", {}, "", function()
        NETWORK1._SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE()
    end)
    menu.action(story_mode, '强制启动故事模式序章', {}, '', function()
        NETWORK.SHUTDOWN_AND_LAUNCH_SINGLE_PLAYER_GAME()
    end)


--全局选项
all_option = menu.list(online, "全局选项", {});appmenu.Ultion.AllOption = all_option
    all_recreation = menu.list(all_option, "全局娱乐", {})
        menu.toggle(all_recreation,  "全局幽灵", {}, "对所有人开启幽灵模式", function(toggled)
            give_all_ghost(toggled)
        end)
        menu.action(all_recreation, '雪球大战', {}, '圣诞快乐', function()
            snowball_War()
        end)
        menu.action(all_recreation, '烟花大战', {}, '新年快乐', function()
            Fireworks_War()
        end)
        menu.action(all_recreation, "给予所有玩家MK-2", {}, "", function()
            give_oppressor()
        end)

    all_spoof = menu.list(all_option, "全局恶搞", {}, "")
        menu.divider(all_spoof, "全局恶搞")
        menu.action(all_spoof,"全局送披萨", {""}, "全局送披萨", function()
            util.trigger_script_event(util.get_session_players_bitflag(), {1450115979, players.user(), 340, -1})
        end)
        menu.toggle_loop(all_spoof,  "禁止进入天基炮室", {}, "生成一个物体 挡住天基炮的门", function()
            local mdd = util.joaat("h4_prop_h4_garage_door_01a")
            if orb_obj_smc == nil or not ENTITY.DOES_ENTITY_EXIST(orb_obj_smc) then
                orb_obj_smc = entities.create_object(mdd, v3(335.9, 4833.9, -59.0))
                ENTITY.SET_ENTITY_HEADING(orb_obj_smc, 125.0)
                ENTITY.FREEZE_ENTITY_POSITION(orb_obj_smc, true)
            end;end,function()
            if orb_obj_smc ~= nil then
                delete_entity(orb_obj_smc)
            end
        end)
        menu.toggle_loop(all_spoof,  "禁止进入高跟鞋", {}, "生成一个物体 挡住高跟鞋的门", function()
            local mdd = util.joaat("h4_prop_h4_garage_door_01a")
            local pos = players.get_position(PLAYER.PLAYER_ID())
            if orb_obj_hh == nil or not ENTITY.DOES_ENTITY_EXIST(orb_obj_hh) then
                orb_obj_hh = entities.create_object(mdd, v3(128, -1298.5, 29.5))
                ENTITY.SET_ENTITY_ROTATION(orb_obj_hh, 0.0, 0.0, 30, 1, true)
                ENTITY.FREEZE_ENTITY_POSITION(orb_obj_hh, true)
            end;end,function()
            if orb_obj_hh ~= nil then
                delete_entity(orb_obj_hh)
            end
        end)
        menu.toggle_loop(all_spoof, "脚本主机轮盘", {}, "循环给予所有人脚本主机\n可能破坏战局", function()
            for _, pid in ipairs(players.list(false, true, true)) do
                menu.trigger_commands("givesh" .. players.get_name(pid))
                util.yield(1500)
            end
        end)
        auto_bounty = menu.list(all_spoof, "全局悬赏", {}, "")
            local session_bounty_amount = 10000
            menu.toggle_loop(auto_bounty,"自动悬赏",{},"循环向每个人提供悬赏",function()
                for pid = 0, 31 do
                    if pid ~= PLAYER.PLAYER_ID() and players.get_bounty(pid) ~= session_bounty_amount and PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                        menu.trigger_commands("bounty"..players.get_name(pid).." "..session_bounty_amount)
                    end
                end
                util.yield(5000)
            end)
            auto_bounty:slider("悬赏金额",{"autobountyamount"},"选择自动提供的赏金金额",1,10000,10000,1000,function(amount)
                session_bounty_amount = amount
            end)

        menu.action(all_spoof, "劫持所有载具", {}, "生成一个劫匪NPC,把他们从车里带出来并开走开.", function()
            for _, pid in players.list(false, true, true) do
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local pos = players.get_position(pid)
                local ped_dist = v3.distance(players.get_position(PLAYER.PLAYER_ID()), players.get_position(pid))
                local cam_dist = v3.distance(pos, players.get_cam_pos(PLAYER.PLAYER_ID()))

                if ped_dist < 1000.0 and cam_dist < 1000.0 and PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
                    menu.trigger_commands("hijack " .. players.get_name(pid))
                end
            end
        end)
        menu.toggle_loop(all_spoof, "锁定全部载具", {}, "", function()
            for _, pid in players.list(false, true, true) do
                for i, vehicle in entities.get_all_vehicles_as_handles() do
                    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, pid, true)
                    util.yield()
                end
            end
        end)
        menu.toggle_loop(all_spoof,  "赌场陷阱", {}, "", function() 
                local mdl = util.joaat("hei_prop_ss1_mpint_garage2")
                request_model(mdl)
                if trap_obj == nil or trap_obj2 == nil or not ENTITY.DOES_ENTITY_EXIST(trap_obj) or not ENTITY.DOES_ENTITY_EXIST(trap_obj2) then
                    trap_obj = entities.create_object(mdl, v3(1089.62, 206.334, -48.473))
                    trap_obj2 = entities.create_object(mdl, v3(1090.0166, 213.826, -48.473))
                    ENTITY.SET_ENTITY_HEADING(trap_obj2, 31.0)
                    local objs = {trap_obj, trap_obj2}
                    for _, obj in objs do
                        entities.set_can_migrate(entities.handle_to_pointer(obj), false)
                        ENTITY.FREEZE_ENTITY_POSITION(obj, true)
                        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(PLAYER.PLAYER_PED_ID(), obj, false)
                    end
                end
                util.yield()
            end, function()
                local objs = {trap_obj, trap_obj2}
                for _, obj in objs do
                    if obj ~= nil then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(obj)
                        delete_entity(obj)
                    end
                end
        end)
        penitentiary = menu.list(all_spoof, "监狱")
            menu.action(penitentiary, "创建监狱", {}, "仿2t监狱", function()
                local hash = 779277682
                local cage = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, 970, -1020, 40, true, false, false)
                ENTITY.SET_ENTITY_ROTATION(cage, 0.0, -90.0, 0.0, 1, true)
            end)
            menu.action(penitentiary, "创建监狱2", {}, "2t监狱", function()
                local hash = 267648181
                local cage1 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, 980, -1025, 41.5, true, false, false)
                ENTITY.SET_ENTITY_ROTATION(cage1, 0.0, 0.0, -88.0, 1, true)
                ENTITY.FREEZE_ENTITY_POSITION(cage1, true)
                local cage2 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, 976, -1033, 41.5, true, false, false)
                ENTITY.SET_ENTITY_ROTATION(cage2, 0.0, 0.0, -143.0, 1, true)
                ENTITY.FREEZE_ENTITY_POSITION(cage2, true)
                local cage3 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, 967, -1035, 41.5, true, false, false)
                ENTITY.SET_ENTITY_ROTATION(cage3, 0.0, 0.0, 170.0, 1, true)
                ENTITY.FREEZE_ENTITY_POSITION(cage3, true)
                local cage4 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, 976, -1016, 41.5, true, false, false)
                ENTITY.SET_ENTITY_ROTATION(cage4, 0.0, 0.0, -44, 1, true)
                ENTITY.FREEZE_ENTITY_POSITION(cage4, true)
                local cage5 = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, 967, -1012, 41.5, true, false, false)
                ENTITY.SET_ENTITY_ROTATION(cage5, 0.0, 0.0, -5, 1, true)
                ENTITY.FREEZE_ENTITY_POSITION(cage5, true)
            end)
            menu.action(penitentiary, "发送所有玩家到监狱", {}, "", function()
                menu.trigger_commands("apt24all")
            end)
            menu.action(penitentiary, "将自己传送到监狱外侧", {}, "", function()
                teleport(994, -1013, 42, true)
            end)

        menu.action(all_spoof, "匿名杀人", {}, "匿名杀死所有人", function()
            nimingsharen()
        end)
        menu.action(all_spoof, '爆炸所有人', {}, '爆炸所有玩家.', function()
            for k, pid in pairs(players.list(false, true, true)) do
                kill_player(pid)
            end
        end)
        menu.toggle_loop(all_spoof, '循环爆炸所有人', {}, '不断的爆炸所有玩家.', function()
            for k, pid in pairs(players.list(false, true, true)) do
                kill_player(pid)
            end
        end)
        menu.action(all_spoof, "车辆电磁脉冲", {}, "让每个人的车都熄火", function()
            veh_EMP()
        end)
        menu.toggle_loop(all_spoof, '禁飞区', {}, '强迫所有乘坐飞行载具的玩家回到地面.', function()
            for _, pid in pairs(players.list(false, true, true)) do
                local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
                if ENTITY.IS_ENTITY_IN_AIR(playerVehicle) then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(playerVehicle)
                    ENTITY.APPLY_FORCE_TO_ENTITY(playerVehicle, 1, 0, 0, -0.8, 0, 0, 0.5, 0, false, false, true)
                    uitl.toast('已应用强制返回地面')
                end
            end
        end)
        menu.action(all_spoof, "困住所有玩家", {}, "", function () 
            for _, pid in pairs(players.list(false, true, true)) do
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
                pos.z = pos.z + 0.95  
                local pos1 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
                pos1.z = pos1.z - 0.90
                local cage = util.joaat("prop_feeder1_cr")
                request_model(cage)
                OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos.x, pos.y ,pos.z , true, true)
                OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos1.x, pos1.y ,pos1.z , true, true)
            end
        end)
    all_crash = menu.list(all_option, "全局崩溃", {}, "")
        menu.action(all_crash, "无效降落伞", {}, "", function ()
            Invalid_parachute()
        end)
        menu.action(all_crash, "载具伞崩全局", {}, "崩溃全局", function ()
            veh_ubl_carsh()
        end)
        menu.toggle_loop(all_crash, "飞机模型崩溃", {}, "", function()
            airplane_collapsed1()
        end)
        menu.action(all_crash, "崩溃主机", {}, "使用前请确认自己是否为主机", function(pid)
            hostcrash(pid)
        end)
        menu.action(all_crash, "人物伞崩V1", {}, "", function()
            ped_ubl_crashv1()
        end)
        menu.action(all_crash,"人物伞崩V2", {}, "", function()
            ped_ubl_crashv2()
        end)
        menu.action(all_crash,"人物伞崩V3",{},"",function()
            ped_ubl_crashv3()
        end)
        menu.action(all_crash,"人物伞崩V4",{},"",function()
            ped_ubl_crashv4()
        end)
        menu.action(all_crash,"CARGO崩溃",{},"崩溃所有玩家",function()
            CARGO()
        end)
        menu.action(all_crash, "大自然全局崩溃", {}, "", function()
            nature()
        end)
        menu.action(all_crash, "懂哥崩溃", {}, "", function()
            dongge_crash()
        end)
        menu.action(all_crash, "全局顶崩", {}, "", function()
            unknown()
        end)
        menu.action(all_crash, "5G崩溃", {}, "", function()
            G5_crash()
        end)
        menu.action(all_crash,"冷战崩溃",{},"崩崩崩",function()
            shiver_crash()
        end)
        menu.action(all_crash,"声音崩溃", {}, "", function()
            sound_crash()
        end)
    all_kick = menu.list(all_option, "全局踢出", {}, "")
        menu.toggle_loop(all_kick, "自动踢出无敌玩家", {}, "", function()
            for pid = 0, 31 do
                if players.is_godmode(pid) and players.get_name(pid) ~= players.get_name(PLAYER.PLAYER_ID()) then
                    menu.trigger_commands("kick" .. players.get_name(pid))
                    util.toast("已踢出 " .. players.get_name(pid) .. " 无敌 :D")
                end
            end
        end)
        menu.action(all_kick, "踢出所有玩家", {}, "", function () 
            for k, pid in pairs(players.list(false, true, true)) do
                local name = PLAYER.GET_PLAYER_NAME(pid)
                menu.trigger_commands("kick "..name)
            end
        end)


musiclist = menu.list(online, "音乐", {}, "")
    menu.toggle(musiclist, "播放", {}, "音乐文件放置: '文档\\Rockstar Games\\GTA V\\User Music'中", function(on)
        music(on)
    end)
    menu.toggle_loop(musiclist, "蹦迪", {}, "", function()
        HUD.FLASH_MINIMAP_DISPLAY_WITH_COLOR(math.random(26))
        util.yield(100)
    end)

personal_vehicle = menu.list(online, '个人载具', {}, '')
    --[[ menu.action(personal_vehicle, "请求个人载具", {}, "", function()
        SET_INT_GLOBAL(Global_Base.oVMYCar + 992, 1)
        SET_INT_GLOBAL(Global_Base.oVMYCar + 989, 1)
    end) ]]
    menu.action(personal_vehicle, "传送载具到我", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local vehicle = entities.get_user_personal_vehicle_as_handle()
        local vpos = ENTITY.GET_ENTITY_COORDS(vehicle)
        request_control(vehicle)
        if vpos.x == 0 and vpos.y == 0 and vpos.z == 0 then
            util.toast('未找到个人载具')
        else
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, pos.x, pos.y, pos.z, true, false, false)
        end
    end)
    menu.action(personal_vehicle, "传送我到载具", {}, "", function()
        local vehicle = entities.get_user_personal_vehicle_as_handle()
        local pos = ENTITY.GET_ENTITY_COORDS(vehicle)
        if pos.x == 0 and pos.y == 0 and pos.z == 0 then
            util.toast('未找到个人载具')
        else
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, true, false, false)
        end
    end)
    menu.action(personal_vehicle, "驾驶个人载具", {}, "", function()
        local vehicle = entities.get_user_personal_vehicle_as_handle()
        local pos = ENTITY.GET_ENTITY_COORDS(vehicle)
        if pos.x == 0 and pos.y == 0 and pos.z == 0 then
            util.toast('未找到个人载具')
        else
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
        end
    end)
    menu.action(personal_vehicle, "索赔所有车辆", {}, "", function() --Update tag(1.69)
        reclaimVehicles()
    end)

auto_host = menu.toggle_loop(online, "自动获取主机", {}, "", function()
    autogethost()
end)
menu.action(online, "获得脚本主机", {}, "获取脚本主机(加载战局会变快)", function()
    force_script_host("freemode")
end)
menu.toggle_loop(online, "自动获取脚本主机", {}, "", function()
    if NETWORK.NETWORK_GET_HOST_OF_SCRIPT("freemode", -1, 0) ~= PLAYER.PLAYER_ID() then
        force_script_host("freemode")
    end
end)
menu.toggle_loop(online, "自动加入游戏", {}, "将自动接受加入任务", function()
    autoaccept()
end)




----聊天选项
menu.action(chat_msg, "全局聊天", {}, "全部聊天", function()
    local label = util.register_label("输入文本")
	local input = get_input_from_screen_keyboard(label, 254, "")
    if input == "" then return end
    chat.send_message(input,false,true,true)
end)

Advanced_chat = menu.list(chat_msg, "高级聊天", {}, "")
    require "lib.SakuraScript.chatPlus"

chat_transl = menu.list(chat_msg, "聊天翻译", {}, "")
    require "lib.SakuraScript.translator"

menu.textslider(chat_msg, "便捷聊天", {}, "", {"R星认证已通过", "Rockstar"}, function(idx)
    local icon = idx == 2 and "∑" or "¦"
    chat.ensure_open_with_empty_draft(false)--打开聊天框
    chat.add_to_draft(icon .. " ")--输入内容
end)

menu.action(chat_msg, "快捷怼人", {}, "前往daidaiScript/AttackText.txt即可修改内容", function()
    local file_path = filesystem.scripts_dir() .. 'daidaiScript/AttackText.txt'
    local tbl = read_txtfile(file_path)
    if #tbl > 0 then
        local text = tbl[math.random(#tbl)]
        chat.send_message(text,false,true,true)
    end
end)

menu.action(chat_msg, "清除聊天历史", {}, "", function()
    sfchat.RESET()
end)

----载具选项列表
veh_movement = menu.list(vehicle, '移动选项', {}, '')
    menu.toggle(veh_movement, "失控驾驶",{},"", function(toggled)
        incontrollable_driving(toggled)
    end)
    menu.toggle_loop(veh_movement, '快速刹车', {}, '允许你快速停车', function()
        Quick_brake()
    end)
    menu.toggle_loop(veh_movement, "漂移模式", {}, "按住shift键进行漂移", function()
        Drift_mode()
    end)
    menu.toggle_loop(veh_movement, '落地弹跳', {}, '载具落地时增加一些弹性', function()
        Landing_bounce()
    end)
    appmenu.Ultion.MuscleCar = menu.toggle_loop(veh_movement, "载具敲头", {}, "起步时按Ctrl和W", function()
        muscle_car()
    end)

    local veh_special_capacity = menu.list(vehicle, '特殊能力', {}, '');appmenu.Ultion.VehSpecialCapacity = veh_special_capacity
        menu.toggle(veh_special_capacity, '载具跳跃' ,{},"", function(toggled)
            vehcap_jump_toggled = toggled
            veh_capacity("vehcap_jump_toggled", 0x58B, 0x20)
        end)
        menu.toggle(veh_special_capacity, '火箭推进' ,{},"", function(toggled)
            vehcap_push_toggled = toggled
            veh_capacity("vehcap_push_toggled", 0x58B, 0x40)
        end)
        menu.toggle(veh_special_capacity, '载具跳跃+火箭推进' ,{},"", function(toggled)
            vehcap_JP_toggled = toggled
            veh_capacity("vehcap_JP_toggled", 0x58B, 0x60)
        end)
        menu.toggle(veh_special_capacity, '载具降落伞' ,{},"", function(toggled)
            vehcap_parachute_toggled = toggled
            veh_capacity("vehcap_parachute_toggled", 0x58C, 0x01)
        end)

    cruise_control = menu.list(veh_movement, "定速巡航", {}, "")
        local cruise_speed_value = 30
        menu.toggle_loop(cruise_control, "开启", {}, "",function()
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(entities.get_user_vehicle_as_handle(), cruise_speed_value / 3.6)
        end)
        menu.slider(cruise_control, "速度设置", {}, "", 0, 300, 30, 10, function (s)
            cruise_speed_value = s
        end)
    veh_max_speed = menu.list(veh_movement, "最大速度限制", {}, "")
        local max_speed_value = 200
        menu.toggle_loop(veh_max_speed, "开启", {}, "",function()
            ENTITY.SET_ENTITY_MAX_SPEED(entities.get_user_vehicle_as_handle(), max_speed_value / 3.6)
        end)
        menu.slider(veh_max_speed, "速度设置", {}, "", 0, 300, 200, 10, function (s)
            max_speed_value = s
        end)
    Torque_switching = menu.list(veh_movement, '扭矩切换', {}, '')
        local num_for_torque = 51
        menu.slider(Torque_switching, "扭矩速度", {"torquespeed"}, "", 1, 500, 51, 1, function(s)
            num_for_torque = s
        end)
        menu.toggle_loop(Torque_switching, "开启", {}, "", function()
            local veh = entities.get_user_vehicle_as_handle()
            if veh ~= nil then
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                end
                VEHICLE.MODIFY_VEHICLE_TOP_SPEED(veh, num_for_torque)
                ENTITY.SET_ENTITY_MAX_SPEED(veh, num_for_torque)
            end
        end)
    nitrogen_acceleration = menu.list(veh_movement, '氮气加速', {}, '')
        menu.toggle_loop(nitrogen_acceleration, "氮气加速", {}, "按X使用", function()
            nnitrogen_acceleration()
        end)
        menu.slider(nitrogen_acceleration, "氮气时间", {"nitroduration"}, "", 1, 20, 2, 1, function(val)
            nnitro_duration(val)
        end)
        menu.slider(nitrogen_acceleration, "氮气速度", {"nitropower"}, "", 1, 10000, 2000, 50, function(val)
            nnitro_power(val)
        end)
        menu.toggle_loop(nitrogen_acceleration,"排气管喷火", {}, "", function()
            local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            if car ~= 0 then
                local user_vehicle_pointer = entities.handle_to_pointer(car)
                entities.set_rpm(user_vehicle_pointer, 2.0)
            end
            util.yield(100)
        end)

    menu.toggle_loop(veh_movement, '贴地/贴墙行驶', {}, '车辆粘在地上/墙上行驶', function ()
        local curcar = entities.get_user_vehicle_as_handle()
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(curcar, 1, 0, 0, - 0.5, 0, true, true, true, true)
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(curcar, 40)
        end
    end)
    menu.toggle_loop(veh_movement, "粘在地上", {}, "完全贴在地上", function()
        ground_driving()
    end)
    menu.toggle(veh_movement, "更高的跳跃", {}, "载具需支持竞技场跳跃", function(toggled)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        VEHICLE.SET_USE_HIGHER_CAR_JUMP(vehicle,toggled)
    end)
    
    local veh_jump = menu.list(veh_movement, "载具跳跃")
        local force = 25.00
        menu.slider_float(veh_jump, "跳跃倍率", {"jumpiness"}, "", 0, 10000, 2500, 100, function(value)
            force = value / 100
        end)
        menu.toggle_loop(veh_jump, "启动", {}, "按空格键跳跃.", function()
            local veh = entities.get_user_vehicle_as_handle()
            if veh ~= 0 and ENTITY.DOES_ENTITY_EXIST(veh) and PAD.IS_CONTROL_JUST_RELEASED(0, 102) then
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, force/1.5, force, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                repeat
                    util.yield()
                until not ENTITY.IS_ENTITY_IN_AIR(veh)
            end
        end)

    menu.toggle(veh_movement, "反向控制", {}, "", function(state)
        car_crash(state)
    end)
    
    dow_block = 0
    driveonwater = false
    ls_driveonwater = menu.toggle(veh_movement, "水上驾驶", {"driveonwater"}, "", function(on)
        driveonwater = on
        if on then
            menu.set_value(ls_driveonair, false)
            menu.set_value(ls_walkwater, false)
        else
            if not driveonair and not walkonwater then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
            end
        end
    end)
    
    doa_ht = 0
    driveonair = false
    ls_driveonair = menu.toggle(veh_movement, "空中驾驶", {"driveonair"}, "", function(on)
        driveonair = on
        if on then
            local pos = players.get_position(PLAYER.PLAYER_ID())
            doa_ht = pos['z']
            notification("~y~~bold~使用空格键和ctrl键微调驾驶高度!", HudColour.blue)
            if driveonwater or walkonwater then
                menu.set_value(ls_driveonwater, false)
                menu.set_value(ls_walkwater, false)
            end
        end
    end)
    menu.toggle_loop(veh_movement, "水下驾驶", {}, "", function ()
        menu.trigger_commands("waterwheels")
    end)
    menu.toggle_loop(veh_movement, "载具平移", {}, "使用左右箭头键使车辆水平移动", function(toggle)
        local player_cur_car = entities.get_user_vehicle_as_handle()
        if player_cur_car ~= 0 then
            local rot = ENTITY.GET_ENTITY_ROTATION(player_cur_car, 0)
            if PAD.IS_CONTROL_PRESSED(0, 175) then
                ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 1, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
                ENTITY.SET_ENTITY_ROTATION(player_cur_car, rot['x'], rot['y'], rot['z'], 0, true)
            end
            if PAD.IS_CONTROL_PRESSED(0, 174) then
                ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 1, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
                ENTITY.SET_ENTITY_ROTATION(player_cur_car, rot['x'], rot['y'], rot['z'], 0, true)
            end
        end
    end)
    menu.toggle_loop(veh_movement, "车辆下降", {}, "按ctrl", function(toggle)
        local player_cur_car = entities.get_user_vehicle_as_handle()
        if player_cur_car ~= 0 then
            if PAD.IS_CONTROL_JUST_PRESSED(36,36) then
                ENTITY.APPLY_FORCE_TO_ENTITY(player_cur_car, 1, 0.0, 0.0, -20, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
            end
        end
    end)
    menu.toggle_loop(veh_movement, "喇叭加速", {}, "", function()
        horn_boost(PLAYER.PLAYER_ID())
    end)
    menu.toggle_loop(veh_movement, "喇叭跳跳车", {}, "", function()
        car_jump(PLAYER.PLAYER_ID())
    end)
    vehflyroot = menu.list(veh_movement, "载具飞行模式", {}, "自由控制你的载具再天上飞行")
        menu.toggle(vehflyroot, '开启', {}, '', function (toggled)
            veh_fly(toggled)
        end)
        menu.slider(vehflyroot, '改变飞行速度', {'vehflyspeed'}, '改变载具飞行的速度', 10, 1000, 150, 10, function (s)
            veh_fly_speed(s)
        end)
        menu.toggle(vehflyroot, '无碰撞', {}, '飞行时禁止与其他物体产生碰撞', function (on)
            veh_fly_coll(on)
        end)
        menu.toggle(vehflyroot, '禁用停止', {}, '放开按键后禁止停止载具', function (on)
            veh_fly_stop(on)
        end)

veh_performance = menu.list(vehicle, '外观和性能', {}, '')
    menu.action(veh_performance, "修复载具", {}, "", function()
        repair_vehicle(PLAYER.PLAYER_ID())
    end)
    menu.toggle(veh_performance, "载具无敌", {}, "", function(toggled)
        veh_godmode(toggled)
    end)
    menu.action(veh_performance, "升级载具", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        upgrade_vehicle(vehicle)
    end)
    menu.action(veh_performance, '随机轮胎', {}, '', function ()
        local vmod = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vmod, math.random(0, 7))
        VEHICLE.SET_VEHICLE_MOD(vmod, 23, math.random(-1, 50))
    end)
    menu.toggle_loop(veh_performance, "随机升级", {}, "", function()
        randomupdatcar(PLAYER.PLAYER_ID())
        util.yield(500)
    end)
    menu.toggle_loop(veh_performance, "清洁载具", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        request_control(vehicle)
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, 0)
    end)
    menu.click_slider(veh_performance, "设置载具属性最高时速", {}, "改变载具属性", 0, 100000, 0, 25, function(value)
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            ENTITY.SET_ENTITY_MAX_SPEED(vehicle, value)
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, value)
        end
    end)
    menu.toggle(veh_performance, '减少翘头', {}, '使载具不容易翘头,主要针对于肌肉车的翘头减速', function (toggle)
        PHYSICS.SET_IN_ARENA_MODE(toggle)
    end)
    menu.toggle_loop(veh_performance,"自动充能", {}, "自动恢复载具火箭助推", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        if not VEHICLE.IS_ROCKET_BOOST_ACTIVE(vehicle) then
            request_control(vehicle)
            VEHICLE.SET_ROCKET_BOOST_FILL(vehicle, 100.0)
        end
    end)
    menu.toggle_loop(veh_performance, "无限载具跳跃", {}, "自动恢复载具垂直火箭助推", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        if VEHICLE.GET_CAR_HAS_JUMP(vehicle) then
            local vehicle_ptr = entities.handle_to_pointer(vehicle)
            memory.write_float(vehicle_ptr + 0x3a0, 5.0) -- m_jump_boost_charge
        end
    end)
    menu.toggle_loop(veh_performance, "指示灯", {}, "载具的一些指示灯光", function()
        pilot_lamp()
    end)
    menu.toggle(veh_performance, "载具室灯", {}, "", function(toggled)
        VEHICLE.SET_VEHICLE_FORCE_INTERIORLIGHT(entities.get_user_vehicle_as_handle(), toggled)
    end)
    menu.toggle_loop(veh_performance, '3D环绕灯', {}, '让霓虹灯绕着汽车转一圈', function ()
        veh_circle_light()
    end)
    carcolor = menu.list(veh_performance, '随机变色', {}, '')
        menu.toggle_loop(carcolor, '载具颜色', {}, '可使车辆变色', function ()
            zjbs()
        end)
        menu.slider(carcolor, '变色速度', {''}, '改变变色速度', 10, 200, 100, 10, function (c)
            colorspeed(c)
        end)
        menu.toggle_loop(carcolor, '前照灯', {}, '改变前灯', function ()
            qzd()
        end)
        menu.slider(carcolor, '前照灯速度', {''}, '前照灯速度', 10, 200, 100, 10, function (c)
            qzdcolorspeed(c)
        end)
    menu.toggle_loop(veh_performance, "彩虹轮胎烟雾", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local timer = MISC.GET_GAME_TIMER()
        local rgb = gradient_colour(timer, 2)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, rgb.r, rgb.g, rgb.b)
    end)
    menu.toggle_loop(veh_performance, "彩虹大灯", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
        VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle, math.random(0, 12))  
        util.yield(500)
    end)
    menu.toggle_loop(veh_performance, "彩虹霓虹灯", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local timer = MISC.GET_GAME_TIMER()
        local rgb = gradient_colour(timer, 2)
        for i = 0, 3 do
            VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(veh, i) 
            VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, rgb.r, rgb.g, rgb.b)
        end
    end)
    menu.toggle_loop(veh_performance, "彩虹载具", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local timer = MISC.GET_GAME_TIMER()
        local rgb = gradient_colour(timer, 2)
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, rgb.r, rgb.g, rgb.b)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, rgb.r, rgb.g, rgb.b)
    end)
    menu.toggle(veh_performance, "烧焦外形", {}, "使你的车烧焦", function(toggle)
        local player_cur_car = entities.get_user_vehicle_as_handle()
        if player_cur_car ~= 0 then 
            ENTITY.SET_ENTITY_RENDER_SCORCHED(player_cur_car, toggle)
        end
    end)
    menu.click_slider(veh_performance, "设置污垢等级", {}, "", 0, 15, 0, 1, function(num)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, num)
    end)
    menu.textslider(veh_performance, "载具降落伞", {}, "",Vparachute.name, function(index)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local hash = util.joaat(Vparachute.value[index])
        request_model(hash)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(vehicle,hash)
    end)
    menu.toggle(veh_performance, '启用车辆轨迹', {}, '在所有表面上留下车辆的轨迹', function(toggle)
        GRAPHICS1._SET_FORCE_VEHICLE_TRAILS(toggle)
    end)
    menu.click_slider(veh_performance, "载具透明度", {}, "", 0, 255, 255, 51, function (s)
        ENTITY.SET_ENTITY_ALPHA(entities.get_user_vehicle_as_handle(), s, false)
    end)
    menu.list_select(veh_performance, "不可见", {}, "", {{1,'关闭'},{2,'本地可见'},{3,'开启'}}, 1,function(value)
        invisible(entities.get_user_vehicle_as_handle(), value)
    end)

    set_self_license = menu.list(veh_performance, "自定义车牌", {}, "")
        local default_license = "Sakura"
        menu.text_input(set_self_license, "自定义车牌", {"setcarlicense"}, "", function(value)
            default_license = value
        end,"Sakura")
        menu.toggle_loop(set_self_license, "设置车牌", {}, "", function()
            local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()), true)
            if car ~= 0 then
                request_control(car)
                VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(car, default_license)
            end
        end)
        menu.toggle_loop(set_self_license, "渐变车牌", {}, "", function()
            local car_card = {"l","lu","luc","luck","lucky"}
            for i = 1, #car_card do
                local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()), true)
                if car ~= 0 then
                    request_control(car)
                    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(car, car_card[i])
                end
                util.yield(100)
            end
            util.yield(200)
        end)
        menu.toggle_loop(set_self_license, "速度车牌", {}, "显示速度", function()
            local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()), true)
            if car ~= 0 then
                local speede = ENTITY.GET_ENTITY_SPEED(car) * 3.6
                local myspeed = math.ceil(speede)
                VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(car, myspeed.." kmh")
            end
        end)
    menu.toggle_loop(veh_performance, "载具引擎快速开启", {}, "减少载具启动引擎时间", function()
        fastoncar()
    end)
    menu.toggle_loop(veh_performance, "解锁正在进入的载具", {}, "解锁你正在进入的载具。对于锁住的玩家载具也有效果。", function()
        unlockcar()
    end)
    car_part = menu.list(veh_performance, "配件控制", {}, "")
        menu.textslider(car_part,"打开车门", {}, "", {"左前门", "右前门", "后左门", "后右门", "引擎盖", "后备箱"}, function (num)
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, num - 1, false, false)
        end)
        menu.toggle(car_part, "所有门", {}, "", function(on_toggle)
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            if on_toggle then
                for i = 0, 5 do
                    VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, false)
                end
            else
                VEHICLE.SET_VEHICLE_DOORS_SHUT(vehicle, false)
            end
        end)
        menu.textslider(car_part,"打开车窗", {}, "", {"左前窗", "右前窗", "后左窗", "后右窗", "左中", "右中"}, function (num)
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            VEHICLE.ROLL_DOWN_WINDOW(vehicle, num - 1)
        end)
        menu.toggle(car_part, "所有窗", {}, "", function(on)
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            if on then
                VEHICLE.ROLL_DOWN_WINDOWS(vehicle)
            else
                for i = 0, 7 do
                    VEHICLE.ROLL_UP_WINDOW(vehicle, i)
                end
            end
        end)

    menu.toggle(veh_performance, "关闭湍流", {}, "", function(on)
        VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), 0), on and 1.0 or 0.0)
    end)

veh_UI = menu.list(vehicle, '载具UI', {}, '')
    menu.toggle_loop(veh_UI, "绘制时速", {}, "", function()
        speedinfo()
    end)
    Veh_AR_GPS = menu.list(veh_UI, 'AR导航', {}, '')
        require "lib.SakuraScript.ArGps"

    speedometer_car = menu.list(veh_UI, "速度表", {}, "")
        menu.toggle_loop(speedometer_car, '开启', {}, "", function()
            speedometer()
        end)
        menu.divider(speedometer_car, "位置")
        menu.slider(speedometer_car, "位置X", {"spX"}, "", 1, 100, 84, 1, function(x)
            speedometer_X(x)
        end)
        menu.slider(speedometer_car, "位置Y", {"spY"}, "", 1, 100, 75, 1, function(y)
            speedometer_Y(y)
        end)
    menu.toggle_loop(veh_UI, "载具识别", {}, "", function(on)
        Vehicle_identify()
    end)
    planehud = menu.list(veh_UI, "飞机HUD", {})
        require "lib.SakuraScript.flightredux"
        getentityinfo()
    menu.toggle_loop(veh_UI, "显示车辆角度", {}, "", function()
        local player_cur_car = entities.get_user_vehicle_as_handle()
        if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
            local ang = math.abs(math.ceil(math.abs(ENTITY.GET_ENTITY_ROTATION(player_cur_car, 0).z, 0) - math.abs(CAM.GET_GAMEPLAY_CAM_ROT(0).z)))
            directx.draw_text(0.5, 1.0, tostring(ang) .. '°', 5, 1.4, {r=1, g=1, b=1, a=1}, true)
        end
    end)

veh_action = menu.list(vehicle, '载具行为', {}, '')
    menu.toggle(veh_action, "自动锁门",{},"当你进入载具后自动上锁,下车不受影响", function(toggled)
        auto_locked(toggled)
    end)
    menu.toggle(veh_action, "禁用驾驶", {}, "", function(toggled)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        VEHICLE.SET_VEHICLE_UNDRIVEABLE(vehicle, toggled)
    end)
    menu.toggle(veh_action, "战损载具", {}, "能够被明显损坏", function(toggled)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(vehicle, toggled)
    end)
    menu.toggle(veh_action, "载具内不可被射击", {}, "防止在载具内被击杀或恶搞", function(on)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), not on)
    end)
    menu.action(veh_action, "颠倒载具", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local rotation = ENTITY.GET_ENTITY_ROTATION(vehicle, 2)
        ENTITY.SET_ENTITY_ROTATION(vehicle, rotation.x, rotation.y + 180, rotation.z, 2, true)
    end)
    menu.toggle_loop(veh_action, "禁用载具碰撞", {}, "禁止与其他载具发生碰撞", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        if vehicle ~= 0 then 
            for _, v in pairs(entities.get_all_vehicles_as_handles()) do 
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(v, vehicle, true)
            end 
        end
    end)
    menu.toggle(veh_action, "防止载具被锁定", {}, "", function(toggled)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        VEHICLE1._SET_VEHICLE_CAN_BE_LOCKED_ON(vehicle, not toggled, false)
    end)
    menu.toggle_loop(veh_action, "载具自动无敌", {}, "自动设置驾驶载具无敌,下车关闭无敌", function()
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
            local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            ENTITY.SET_ENTITY_INVINCIBLE(car,true)
        else
            local lastcar = PLAYER.GET_PLAYERS_LAST_VEHICLE()
            ENTITY.SET_ENTITY_INVINCIBLE(lastcar,false)
        end
    end)
    menu.toggle_loop(veh_action, "下车不熄火", {}, "", function()
        local lastcar = PLAYER.GET_PLAYERS_LAST_VEHICLE()
        VEHICLE.SET_VEHICLE_ENGINE_ON(lastcar, true, true, false)
    end)
    menu.toggle_loop(veh_action, "引擎始终启动", {}, "", function()
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
            VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
            VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 0)
            VEHICLE.SET_VEHICLE_HEADLIGHT_SHADOWS(vehicle, 2)
        end
    end)
    menu.toggle_loop(veh_action, "禁用载具喇叭", {}, "", function()
            local vehicle = entities.get_user_vehicle_as_handle()
            AUDIO.SET_HORN_ENABLED(vehicle, false)
        end, function()
            local vehicle = entities.get_user_vehicle_as_handle()
            AUDIO.SET_HORN_ENABLED(vehicle, true)
    end)
    menu.toggle_loop(veh_action, "自动翻转", {}, "如果你的车辆颠倒或侧面将自动翻转回正", function()
        vehicle_automatically()
    end)


vehicleWeaponRoot = menu.list(vehicle, "载具武器", {}, "")
    menu.toggle_loop(vehicleWeaponRoot, "直升机自动瞄准器", {}, "让直升机瞄准最近的玩家,适用于飞机，但效果不好\n当瞄准就绪时通过鼠标右键or空格触发", function ()
        helicopter_automatic_sight()
    end)
    menu.toggle_loop(vehicleWeaponRoot, "载具导弹自瞄", {}, "当玩家在可视范围内发射导弹自动锁定玩家", function()
        veh_missile_aimbit()
    end)
    menu.toggle_loop(vehicleWeaponRoot, "载具快速射击", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        request_control(vehicle)
        VEHICLE.SET_VEHICLE_FIXED(vehicle)
        VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(vehicle)
        util.yield(50)
    end)
    menu.toggle_loop(vehicleWeaponRoot, "喇叭爆炸", {}, "", function()
        horn_bomb()
    end)
    vehicleWeaponmissile = menu.list(vehicleWeaponRoot, "载具导弹", {}, "")
        menu.toggle_loop(vehicleWeaponmissile, "载具导弹", {}, "", function()
            vehweapon_veh()
        end, function () 
            Vw_state = 0 
        end)
        menu.toggle_loop(vehicleWeaponmissile, "载具激光", {}, "", function ()
            vehlaser()
        end)
        menu.list_select(vehicleWeaponmissile, "设置载具武器", {}, "", vehweapon_name, 1, function (value, menu_name, prev_value, click_type)
            setvehweapon(value, menu_name, prev_value, click_type)
        end)
        vehicleWeaponsControl = menu.list(vehicleWeaponmissile, "更改按键", {}, "")
            for name, control in pairs(Imputs_vehweapon) do
                local keyboard, controller = control[1]:match('^(.+)%s?;%s?(.+)$')
                local strg = ("%s: %s, %s: %s"):format(trans_plane.Keyboard, keyboard, trans_plane.Controller, controller)
                menu.action(vehicleWeaponsControl, strg, {}, "", function()
                    funConfig.controls.vehicleweapons = control[2]
                    util.show_corner_help(trans_plane.VehicleWeapons:format(name))
                end)
            end
    list_homingMissiles = menu.list(vehicleWeaponRoot, "先进追踪导弹", {}, "允许您在任何载具上使用追踪导弹,并一次射出最多六个目标 ..")
        mistoggle = menu.toggle_loop(list_homingMissiles, "先进追踪导弹", {}, "", function ()
            if not UFO.exists() and not GuidedMissile.exists() then
                HomingMissiles.mainLoop()
            else
                menu.set_value(mistoggle, false)
            end
        end)
        whiteList = menu.list(list_homingMissiles, "白名单", {}, "")
            menu.toggle(whiteList, "朋友", {}, "", HomingMissiles.SetIgnoreFriends)
            menu.toggle(whiteList, "组织成员", {}, "", HomingMissiles.SetIgnoreOrgMembers)
            menu.toggle(whiteList, "帮会成员", {}, "", HomingMissiles.SetIgnoreCrewMembers)
        menu.slider(list_homingMissiles, "最大目标数" , {}, "", 1, 6, 6, 1, HomingMissiles.SetMaxTargets)
    menu.toggle(vehicleWeaponRoot, "空袭飞机", {}, "使用任何飞机或直升机进行空袭", function (toggled)
        air_strike_plane(toggled)
    end)
    menu.toggle_loop(vehicleWeaponRoot, "无限载具武器弹药", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
        if VEHICLE.DOES_VEHICLE_HAVE_WEAPONS(vehicle) then
            for i = 0, 3 do
                local ammo = VEHICLE.GET_VEHICLE_WEAPON_RESTRICTED_AMMO(vehicle, i)
                VEHICLE.SET_VEHICLE_WEAPON_RESTRICTED_AMMO(vehicle, i, -1)
            end
        end
    end)

workshop = menu.list(vehicle, '洛圣都改车王', {}, '')
    require "lib.SakuraScript.Repairshop"

----载具选项
menu.list_action(vehicle, "广播电台", {}, "", radio_station.name, function(index)
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    AUDIO.SET_VEH_RADIO_STATION(vehicle, radio_station.value[index])
end)
menu.list_action(vehicle, "附加国旗", {}, "", country_flags_name, function(index)
    attach_flag(index)
end)
menu.action(vehicle, "复制载具", {}, "复制当前载具并驾驶", function()
    copy_vehicle(PLAYER.PLAYER_ID())
end)

local horn_music_list = menu.list(vehicle, '载具喇叭音乐', {}, '')
    local horn_dir = filesystem.store_dir() .. "SakuraScript/SakuraAudio/HornSongs"
    local horn_songs = load_songs(horn_dir)
    for _, song in pairs(horn_songs) do
        menu.action(horn_music_list, "播放 "..song.name, {}, song.description .. "\n音乐速度: " .. song.bpm, function()
            play_song(song)
        end)
    end

menu.toggle_loop(vehicle, "自定义转弯", {}, "用A/D键快速转动载具.", function ()
    custom_TurnVehicle()
end)

chauffeur_root = menu.list(vehicle, "司机服务", {}, "呼叫您的私人司机.")
    menu.list_action(chauffeur_root, "传唤司机", {"summonchauffeur"}, "", {{1,"Stretch"}, {2,"T20"}, {3,"Kuruma"}}, function(index, value, click_type)
        summ_car(index, value)
    end)
    menu.action(chauffeur_root, "驾车前往航点", {}, "", function()
        summ_car_topoint()
    end)
    menu.action(chauffeur_root, "传送到驾驶室", {}, "", function()
        summ_car_tp()
    end)
    menu.action(chauffeur_root, "自我毁灭", {}, "", function()
        summ_car_bmob()
    end)

menu.click_slider(vehicle, "垂直堆叠", {}, "", 1, 10, 3, 1, function(s)
    setstacky(s)
end)
menu.click_slider(vehicle, "水平堆叠", {}, "", 1, 10, 3, 1, function(s)
    setstackx(s)
end)

ff9car = menu.list(vehicle, "道奇战马", {}, "")
    Spawn = menu.toggle_loop(ff9car, '道奇战马', {}, '按E使用', function ()
        daoqizhanma()
    end,function()
        stop_daoqizhanma()
    end)
    menu.list_select(ff9car, '电磁脉冲样式', {}, '更改样式为推开或炸毁', maglist, 1, function(value, menu_name, prev_value, click_type)
        daoqizhanma_style(value, menu_name, prev_value, click_type)
    end)
    
sdroot = menu.list(vehicle, '魔幻激光战马', {}, '')
    menu.toggle(sdroot, '生成魔幻激光战马', {}, '魔幻战马可以发出激光', function(toggled)
        Lazer_Space_Car(toggled)
    end)
    menu.list_select(sdroot, '魔幻战马武器', {},'更改魔幻激光战马的武器', {{1,'邪恶冥王'},{2,'原子能枪'}}, 1, function(value, menu_name, prev_value, click_type)
        Magic_Warhorse_W(value, menu_name, prev_value, click_type)
    end)

menu.click_slider(vehicle, "换座位", {}, "", 1, 6, 1, 1, function(value)
    if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, value - 2)
    end
end)
menu.toggle(vehicle, "阻止挪座", {}, "防止在驾驶座空闲时自动移到驾驶座上", function(toggled)
	PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 184, toggled)
end)
menu.toggle_loop(vehicle, '部分载具无限海底挤压深度', {}, '潜水艇,虎鲸...', function ()
    local subs = {'submersible','submersible2','avisa','kosatka', 'toreador'}
    local cursub = ENTITY.GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle())
    for _, s in ipairs(subs) do
        if cursub == util.joaat(s) then
            VEHICLE.SET_SUBMARINE_CRUSH_DEPTHS(entities.get_user_vehicle_as_handle(), false, 2000, 2000, 2000)
        end
    end
end)
menu.action(vehicle, "强制离开载具", {}, "", function()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
    TASK.TASK_LEAVE_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), 0, 16)
end)

acceleration_pads = menu.list(vehicle, "加(减)速带", {}, "")
    menu.action(acceleration_pads, "单个加速带", {}, "", function() 
        jiasudian(PLAYER.PLAYER_ID())
    end)
    menu.action(acceleration_pads, "四个加速带", {}, "", function()
        sigejiasudian(PLAYER.PLAYER_ID())
    end) 
    menu.action(acceleration_pads, "单个减速带", {}, "", function()
        jiansudai(PLAYER.PLAYER_ID())
    end)

vehicle_effect = menu.list(vehicle, "载具效果", {}, "")
    menu.toggle_loop(vehicle_effect, "开关", {}, "", function ()
        vehicle_effectt()
    end)
    menu.list_select(vehicle_effect,"设置载具效果", {}, "", v_eff_options, 1, function (value, menu_name, prev_value, click_type)
        selectedOptt(value, menu_name, prev_value, click_type)
    end)
    ptfx_trails_lt = menu.list(vehicle_effect,"粒子拖尾")
        menu.toggle_loop(ptfx_trails_lt, "粒子拖尾", {}, "", function()
                particle_tail()
            end, function()
                STREAMING.REMOVE_NAMED_PTFX_ASSET("scr_rcpaparazzo1")
        end)
        menu.list_select(ptfx_trails_lt,"设置拖尾效果", {}, "", vehparticle_name, 1, function (value, menu_name, prev_value, click_type)
            selectparticle(value, menu_name, prev_value, click_type)
        end)

jesus_main = menu.list(vehicle, "自动驾驶", {}, "")
    menu.list_select(jesus_main, "驾驶风格", {}, "", style_names, 1, function(value, menu_name, prev_value, click_type)
        drivestylee(value, menu_name, prev_value, click_type)
    end)
    menu.slider(jesus_main, "最高时速", {}, "调整自动驾驶的最高速度(只适用于车)", 0, 500, 70, 10, function(value)
        drivespeedd(value)
    end)
    jesus_toggle = menu.toggle(jesus_main, "自动驾驶", {}, "标记点后触发", function(toggle)
        Auto_driving(toggle)
    end)


menu.toggle(vehicle, "特斯拉自动驾驶", {}, "", function(toggled)
    Tesla_Autopilot(toggled)
end)

menu.toggle_loop(vehicle, "强制生成反制系统", {}, "让所有载具都有反制系统", function()
    if PAD.IS_CONTROL_PRESSED(0, 46) then
        local target = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-5, 5), -30.0, math.random(-5, 5))
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z'], 100.0, true, 1198879012, PLAYER.PLAYER_PED_ID(), true, false, 100.0)
    end
end)

vf = menu.list(vehicle, "冻结选项", {}, "")
    menu.action(vf, "冻结载具", {}, "冻结当前载具", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        if vehicle then
            add_frozen_vehicle(vehicle)
        end
    end)
    frozen_vehicles_menu_list = menu.list(vf, "已冻结的载具")
        local tick_counter = 0
        util.create_tick_handler(function()
            if tick_counter % 1000 == 0 then
                update_frozen_vehicles()
            end
            tick_counter = tick_counter + 1
            return true
        end)

menu.action(vehicle, "摧毁载具", {}, "摧毁正在驾驶的载具", function ()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.PLAYER_PED_ID())
    for i = 1, 20 do
        local pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 2, 1.0, true, false, 0, false)
        util.yield(50)
    end
end)

------模组选项
    require "lib.SakuraScript.Constructor"

----恢复选项
    HeistControlList = menu.list(Recovery_list, "任务选项", {}, "")
        local Cayo_list = menu.list(HeistControlList, "佩里科岛", {}, "")
            menu.action(Cayo_list, "呼叫虎鲸", {}, "", function()--Update tag(1.69-3351)
                SET_INT_GLOBAL(Global_Base.oVMYCar + 976, 1)--Kosatka
                notification("~y~~bold~已呼叫虎鲸", HudColour.blue)
            end)	   
            local Cayo_position = menu.list(Cayo_list, "地点传送", {}, "")    
                menu.action(Cayo_position, "任务面板(虎鲸)", {}, "先呼叫潜艇,如果没有进入虎鲸请快速多按几次", function()
                    PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), 1561.2369, 385.8771, -49.689915)
                end)
                menu.action(Cayo_position, "传送到大门(外侧)", {}, "", function()
                    teleport(4974.189, -5703.279, 19.898539, true)
                end)
                menu.action(Cayo_position, "传送到大门(内测)", {}, "", function()
                    teleport(4993.189, -5720.279, 19.898539, false)
                end)
                menu.action(Cayo_position, "主要目标", {}, "", function()
                    teleport(5006.7, -5756.2, 14.8, false)
                end)
                menu.action(Cayo_position, "次要目标", {}, "", function()
                    teleport(4999.764160, -5749.863770, 14.840000, false)
                end)
                menu.action(Cayo_position, "机场(逃离)", {}, "", function()
                    teleport(4443.189, -4510.279, 4.898539, true)
                end)
                menu.action(Cayo_position, "传送到大海", {}, "", function()
                    while not CUTSCENE.IS_CUTSCENE_PLAYING() do
                        teleport(3235, -4938, 56, true)
                        util.yield(200)
                    end
                end)
            local Cayo_setting = menu.list(Cayo_list, "任务设定", {}, "")
                local Cayo_default = menu.list(Cayo_setting, "任务预设", {}, "")
                    menu.action(Cayo_default, "完成前置任务", {}, "", function()
                        STAT_SET_INT("H4CNF_TARGET", 5)--主要目标
                        STAT_SET_INT("H4_MISSIONS", -1)--解锁所有接近载具
                        STAT_SET_INT("H4_PROGRESS", 126823)--难度:正常
                        STAT_SET_INT("H4CNF_APPROACH", -1)
                        STAT_SET_INT("H4CNF_BS_ENTR", 63)
                        STAT_SET_INT("H4CNF_BS_GEN", 63)
                        STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                        STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                        STAT_SET_INT("H4CNF_HEL_DISRP", 3)

                        SET_INT_LOCAL("heist_island_planning", 1546, 2)
                    end)
                    menu.action(Cayo_default, "重置面板", {}, "", function()
                        STAT_SET_INT("H4_MISSIONS", 0) --locked
                        STAT_SET_INT("H4_PROGRESS", 0) --locked
                        STAT_SET_INT("H4CNF_APPROACH", 0)
                        STAT_SET_INT("H4CNF_BS_ENTR", 0)
                        STAT_SET_INT("H4CNF_BS_GEN", 0)
                        STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 0)
                        STAT_SET_INT("H4CNF_TARGET", -1)
            
                        SET_INT_LOCAL("heist_island_planning", 1546, 2)
                    end)

                menu.textslider(Cayo_setting, "主要目标", {}, "", {"龙舌兰兰酒","红宝石项链","不记名债券","粉钻","玛德拉索文件","猎豹雕像"}, function (index)
                    STAT_SET_INT("H4CNF_TARGET", index - 1)
                    SET_INT_LOCAL("heist_island_planning", 1546, 2)
                end)
                menu.action(Cayo_setting, "次要目标", {}, "混合所有次要目标", function()
                    STAT_SET_INT("H4LOOT_CASH_I", 1319624)
                    STAT_SET_INT("H4LOOT_CASH_C", 18)
                    STAT_SET_INT("H4LOOT_CASH_V", 89400)
                    STAT_SET_INT("H4LOOT_WEED_I", 2639108)
                    STAT_SET_INT("H4LOOT_WEED_C", 36)
                    STAT_SET_INT("H4LOOT_WEED_V", 149000)
                    STAT_SET_INT("H4LOOT_COKE_I", 4229122)
                    STAT_SET_INT("H4LOOT_COKE_C", 72)
                    STAT_SET_INT("H4LOOT_COKE_V", 221200)
                    STAT_SET_INT("H4LOOT_GOLD_I", 8589313)
                    STAT_SET_INT("H4LOOT_GOLD_C", 129)
                    STAT_SET_INT("H4LOOT_GOLD_V", 322600)
                    STAT_SET_INT("H4LOOT_PAINT", 127)
                    STAT_SET_INT("H4LOOT_PAINT_V", 186800)
                    STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 1319624)
                    STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 18)
                    STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 2639108)
                    STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 36)
                    STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 4229122)
                    STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 72)
                    STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 8589313)
                    STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 129)
                    STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                end)
                menu.textslider(Cayo_setting, "武器装备", {}, "", {"侵略者", "阴谋者", "神枪手", "破坏者", "神射手"}, function(index)
                    STAT_SET_INT("H4CNF_WEAPONS", index)
                    SET_INT_LOCAL("heist_island_planning", 1546, 2)
                end)
                menu.textslider(Cayo_setting, "抢劫难度", {}, "", {"正常","困难"}, function(Index)
                    if Index == 1 then
                        STAT_SET_INT("H4_PROGRESS", 126823) --locked
                    elseif Index == 2 then
                        STAT_SET_INT("H4_PROGRESS", 131055)
                    end
                    SET_INT_LOCAL("heist_island_planning", 1546, 2)
                end)
                menu.action(Cayo_setting, "刷新任务面板", {}, "", function()--Update tag(1.69)
                    SET_INT_LOCAL("heist_island_planning", 1546, 2)-------刷新(https://github.com/TCRoid/Stand-Lua-RS-Missions/blob/main/lib/RS_Missions/variables.lua#L397)
                end)


            local Cayo_cut = menu.list(Cayo_list, "分红调整", {}, "分红界面出现时再修改")--佩里科岛
                local cayo_cut_p = menu.list(Cayo_cut, "玩家[1-4]", {}, "")
                    menu.click_slider(cayo_cut_p, "玩家1", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 1, value)
                    end)
                    menu.click_slider(cayo_cut_p, "玩家2", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 2, value)
                    end)
                    menu.click_slider(cayo_cut_p, "玩家3", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 3, value)
                    end)
                    menu.click_slider(cayo_cut_p, "玩家4", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 4, value)
                    end)
                menu.action(Cayo_cut, "自保分红", {}, "全员135%,自己60%", function()
                    SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 1, 60)
                    SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 2, 135)
                    SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 3, 135)
                    SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 4, 135)
                end)
                menu.click_slider(Cayo_cut, "全员分红", {}, "(%)", 0, 1000, 25, 5, function(value)
                    SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 1, value)
                    SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 2, value)
                    SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 3, value)
                    SET_INT_GLOBAL(Global_Base.Cayo_cut + 831 + 56 + 4, value)
                end)

            menu.toggle_loop(Cayo_list, "跳过下水道切割", {}, "", function() 
                if IS_HELP_MSG_DISPLAYED("UT_WELD_PROMPT") then 
                    PAD2._SET_CONTROL_NORMAL(2, 51, 1)
                elseif GET_INT_LOCAL("fm_mission_controller_2020", 26746) == 4 then 
                    SET_INT_LOCAL("fm_mission_controller_2020", 26746, 6)
                end
            end)
            menu.action(Cayo_list, "删除排水管", {}, "", function() 
                DELETE_OBJECT_BY_HASH(-1297635988)
            end)
            menu.toggle_loop(Cayo_list, "跳过指纹锁", {}, "", function() --Update tag(1.69)
                if GET_INT_LOCAL("fm_mission_controller_2020", 24880) == 4 then -- https://www.unknowncheats.me/forum/3418914-post13398.html
                    SET_INT_LOCAL("fm_mission_controller_2020", 24880, 5)
                end
            end)
            menu.action(Cayo_list, "跳过切割玻璃", {}, "切割时使用", function()--Update tag(1.69)
                    SET_FLOAT_LOCAL("fm_mission_controller_2020", 30939 + 3, 100)
                end, function()
                    SET_FLOAT_LOCAL("fm_mission_controller_2020", 30939 + 3, 0)
            end)
            menu.toggle_loop(Cayo_list, "绕过切割机发热", {}, "切割前开启", function()--Update tag(1.69)
                SET_FLOAT_LOCAL("fm_mission_controller_2020", 30939 + 4, 0)
            end)
            menu.action(Cayo_list, "杀死队友", {}, "炸死队友(无敌可免疫)", function()
                for k, pid in pairs(players.list(false, true, true)) do
                    kill_player(pid)
                end
            end)

            local Cayo_senior = menu.list(Cayo_list, "高级选项", {}, "")--佩里科岛
                menu.action(Cayo_senior, "强制准备", {}, "", function() --Update tag(1.69)
                    SET_INT_GLOBAL(1972760 + 1 + (1 * 27) + 8 + 1, 1) -- Thanks to @vithiam on Discord
                    SET_INT_GLOBAL(1972760 + 1 + (2 * 27) + 8 + 2, 1) 
                    SET_INT_GLOBAL(1972760 + 1 + (3 * 27) + 8 + 3, 1) 
                end)
                menu.click_slider(Cayo_senior, "设置任务生命数", {}, "确保你是任务脚本主机", 0, 100, 3, 1, function(value)
                    SET_INT_LOCAL("fm_mission_controller_2020", Global_Base.island_team_lives + 868 + 1, value)
                end)
                menu.click_slider(Cayo_senior, "设置背包容量", {}, "默认为1800", 0, 5000, 1800, 200, function(value)
                    SET_INT_TUNABLE_GLOBAL(1859395035, value)
                end)
                menu.action(Cayo_senior, "快速完成", {}, "确保你是任务脚本主机", function()--Update tag(1.69)
                    menu.trigger_commands("scripthost")
                    SET_INT_LOCAL("fm_mission_controller_2020", 50150, 9) -- 'fm_mission_controller_2020' instant finish variable?
                    SET_INT_LOCAL("fm_mission_controller_2020", 50150 + 1770 + 1, 50) -- 'fm_mission_controller_2020' instant finish variable?
                end)
            
        --赌场选项
        local casino_list = menu.list(HeistControlList, "名钻赌场", {}, "")
            local casino_setting = menu.list(casino_list, "任务设定", {}, "")
                local casino_default = menu.list(casino_setting, "任务预设", {}, "")
                    menu.action(casino_default, "完成前置任务", {}, "目标：钻石\n方式:气势汹汹", function()
                        STAT_SET_INT("CAS_HEIST_FLOW", -1)
                        STAT_SET_INT("H3_LAST_APPROACH", 0)
                        STAT_SET_INT("H3OPT_APPROACH", 3)
                        STAT_SET_INT("H3_HARD_APPROACH", 0)
                        STAT_SET_INT("H3OPT_TARGET", 3)
                        STAT_SET_INT("H3OPT_POI", 1023)
                        STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                        STAT_SET_INT("H3OPT_CREWWEAP", 4)
                        STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                        STAT_SET_INT("H3OPT_CREWHACKER", 4)
                        STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                        STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                        STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                        STAT_SET_INT("H3OPT_BITSET1", 799)
                        STAT_SET_INT("H3OPT_BITSET0", 3670102)
                    end)
                    menu.action(casino_default, "重置面板", {}, "", function()
                        STAT_SET_INT("H3_LAST_APPROACH", 0)
                        STAT_SET_INT("H3OPT_APPROACH", 0)
                        STAT_SET_INT("H3_HARD_APPROACH", 0)
                        STAT_SET_INT("H3OPT_TARGET", 0)
                        STAT_SET_INT("H3OPT_POI", 0)
                        STAT_SET_INT("H3OPT_ACCESSPOINTS", 0)
                        STAT_SET_INT("H3OPT_BITSET1", 0)
                        STAT_SET_INT("H3OPT_CREWWEAP", 0)
                        STAT_SET_INT("H3OPT_CREWDRIVER", 0)
                        STAT_SET_INT("H3OPT_CREWHACKER", 0)
                        STAT_SET_INT("H3OPT_WEAPS", 0)
                        STAT_SET_INT("H3OPT_VEHS", 0)        
                        STAT_SET_INT("H3OPT_DISRUPTSHIP", 0)
                        STAT_SET_INT("H3OPT_BODYARMORLVL", 0)
                        STAT_SET_INT("H3OPT_KEYLEVELS", 0)
                        STAT_SET_INT("H3OPT_MASKS", 0)
                        STAT_SET_INT("H3OPT_BITSET0", 0)
                    end)

                menu.textslider(casino_setting, "选择方式", {}, "你可能需要刷新面板", {"隐迹潜踪","兵不厌诈","气势汹汹"}, function (index)
                    STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STAT_SET_INT("H3OPT_APPROACH", index)
                end)
                menu.textslider(casino_setting, "选择难度", {}, "你可能需要刷新面板", {"正常","困难"}, function (index)
                    if index == 1 then
                        STAT_SET_INT("H3_HARD_APPROACH", 0)
                    else
                        for i = 1, 3 do
                            if STAT_GET_INT("H3OPT_APPROACH") == i then
                                STAT_SET_INT("H3_HARD_APPROACH", i)
                            end
                        end
                    end
                end)
                menu.textslider(casino_setting, "选择目标", {}, "你可能需要刷新面板", {"现金","黄金","艺术作品","钻石"}, function (index)
                    STAT_SET_INT("H3OPT_TARGET", index - 1)
                end)
                menu.action(casino_setting, "刷新任务面板", {}, "", function()
                    STAT_SET_INT("H3OPT_BITSET0", math.random(INT_MAX))
                    STAT_SET_INT("H3OPT_BITSET1", math.random(INT_MAX))
                    util.yield_once()
                    STAT_SET_INT("H3OPT_BITSET0", STAT_GET_INT("H3OPT_BITSET0"))
                    STAT_SET_INT("H3OPT_BITSET1", STAT_GET_INT("H3OPT_BITSET1"))
                end)
            local casino_position = menu.list(casino_list, "地点传送", {}, "")
                menu.action(casino_position, "游戏厅入口", {}, "", function()
                    local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(740))
                    teleport(pos.x, pos.y, pos.z, false)
                end)
                menu.action(casino_position, "计划面板(游戏厅)", {}, "先进游戏厅", function()
                    teleport(2711.773, -369.458, -54.781, false)
                end)
                local casino_observe_position = menu.list(casino_position, "拍照观察地点", {}, "")
                    menu.action(casino_observe_position, "赌场门口(外部)", {}, "", function()
                        teleport(907.237, 41.494, 80.187, false)
                    end)
                menu.action(casino_position, "车库出口(游戏厅)", {}, "先进游戏厅", function()
                    teleport(2677.237, -361.494, -55.187, false)
                end)
                menu.action(casino_position, "下水道", {}, "", function()
                    teleport(993.21, -146.21, 34.59, true)
                end)
                menu.action(casino_position, "门口(赌场)", {}, "", function()
                    teleport(917.24634, 48.989567, 80.89892, true)
                end)
                menu.action(casino_position, "员工大厅(赌场)", {}, "", function()
                    teleport(965.14856, -9.05023, 80.63045, false)
                end)
                menu.action(casino_position, "音乐柜", {}, "", function()
                    teleport(997.5346, 84.51491, 80.990555, true)
                end)
                menu.action(casino_position, "废物处理间(赌场)", {}, "", function()
                    teleport(2542.052, -214.3084, -58.722965, false)
                end)
                menu.action(casino_position, "员工大门(赌场)", {}, "", function()
                    teleport(2547.9192, -273.16754, -58.723003, false)
                end)
                menu.action(casino_position, "双人刷卡点(赌场)", {}, "", function()
                    teleport(2465.4746, -279.2276, -70.694145, true)
                end)
                menu.action(casino_position, "金库内部(赌场)", {}, "", function()
                    teleport(2515.1252, -238.91661, -70.73713, true)
                end)
                menu.action(casino_position, "库外部(赌场)", {}, "", function()
                    teleport(2497.5098, -238.50768, -70.7388, true)
                end)
                menu.action(casino_position,"小金库(赌场)", {}, "", function()
                    teleport(2520.8645, -286.30685, -58.723007, true)
                end)

            local Casino_cut = menu.list(casino_list, "分红调整", {}, "")--赌场
                local casino_cut_p = menu.list(Casino_cut, "玩家[1-4]", {}, "")
                    menu.click_slider(casino_cut_p, "玩家1", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 1, value)
                    end)
                    menu.click_slider(casino_cut_p, "玩家2", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 2, value)
                    end)
                    menu.click_slider(casino_cut_p, "玩家3", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 3, value)
                    end)
                    menu.click_slider(casino_cut_p, "玩家4", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 4, value)
                    end)
                menu.action(Casino_cut, "自保分红", {}, "全员146%, 自己60%", function()
                    SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 1, 60)
                    SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 2, 146)
                    SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 3, 146)
                    SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 4, 146)
                end)
                menu.click_slider(Casino_cut, "自定义分红", {}, "(%)", 0, 1000, 25, 5, function(value)
                    SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 1, value)
                    SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 2, value)
                    SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 3, value)
                    SET_INT_GLOBAL(Global_Base.Casino_Cut + 1497 + 736 + 92 + 4, value)
                end)

            menu.action(casino_list, "杀死队友", {}, "炸死队友(无敌可免疫)", function()
                for k, pid in pairs(players.list(false, true, true)) do
                    kill_player(pid)
                end
            end)
            local Casino_senior = menu.list(casino_list, "高级选项", {}, "")--赌场
                menu.action(Casino_senior, "强制准备", {}, "", function() --Update tag(1.69)
                    SET_INT_GLOBAL(1969212 + 1 + (1 * 68) + 8 + 1, 1) -- Thanks to @vithiam on Discord
                    SET_INT_GLOBAL(1969212 + 1 + (2 * 68) + 8 + 2, 1) 
                    SET_INT_GLOBAL(1969212 + 1 + (3 * 68) + 8 + 3, 1)
                end)
                menu.toggle_loop(Casino_senior, "自动鼠标左键点击", {}, "用于拿取目标财物时",function()
                    if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 135) then
                        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1)
                        util.yield(50)
                    end
                end)
                menu.toggle_loop(Casino_senior, "单人强制启动", {}, "允许你在没有其他玩家的情况下独自进行抢劫", function()--Update tag(1.69)
                    allow_play_alone()
                end)
                menu.action(Casino_senior, "跳到下一个检查点", {}, "解决单人进行任务卡关问题", function()
                    SET_LOCAL_BIT("fm_mission_controller", 19746 + 2, 17)
                end)
                menu.click_slider(Casino_senior, "设置金库倒计时", {}, "单位: 秒",0, 6000, 300, 10, function(value)
                    -- g_FMMC_STRUCT_ENTITIES.sPlacedZones[iZone].iZoneTimer_EnableTime
                    SET_INT_GLOBAL(4718592 + 210289 + 1 + 0 * 190 + 41, value * 1000)
                end)
                menu.click_slider(Casino_senior, "设置任务生命数", {}, "确保你是任务脚本主机", 0, 100, 0, 1, function(value)
                    SET_INT_LOCAL("fm_mission_controller", Global_Base.global_team_lives + 1325 + 1, value)
                end)
                menu.action(Casino_senior, "快速完成", {}, "确保你是任务脚本主机", function()--Update tag(1.69)
                    menu.trigger_commands("scripthost") 
                    SET_INT_LOCAL("fm_mission_controller", 19746 + 1741, 80) -- Casino Aggressive Kills & Act 3
                    SET_INT_LOCAL("fm_mission_controller", 19746 + 2686, 10000000) -- How much did you take in the casino and pacific standard heist
                    SET_INT_LOCAL("fm_mission_controller", 27489 + 859 + 18, 99999) -- 'fm_mission_controller' instant finish variable?
                    SET_INT_LOCAL("fm_mission_controller", 31621 + 69, 99999) -- 'fm_mission_controller' instant finish variable?
                end)
    --末日豪杰
        local doomsday_list = menu.list(HeistControlList, "末日豪杰", {}, "")
            local doomsday_setting = menu.list(doomsday_list, "任务设定", {}, "")
                menu.action(doomsday_setting, "数据泄露 I", {}, "", function()
                    STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 503)
                    STAT_SET_INT("GANGOPS_HEIST_STATUS", -229383)
                    STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
                    SET_INT_LOCAL("gb_gang_ops_planning", 184, 6)
                end)
                menu.action(doomsday_setting, "波格丹危机 II", {}, "", function()
                    STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
                    STAT_SET_INT("GANGOPS_HEIST_STATUS", -229378)
                    STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
                    SET_INT_LOCAL("gb_gang_ops_planning", 184, 6)
                end)
                menu.action(doomsday_setting, "末日降临 III", {}, "", function()
                    STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 16368)
                    STAT_SET_INT("GANGOPS_HEIST_STATUS", -229380)
                    STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
                    SET_INT_LOCAL("gb_gang_ops_planning", 184, 6)
                end)
                menu.action(doomsday_setting, "重置任务面板", {}, "", function()
                    STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
                    STAT_SET_INT("GANGOPS_HEIST_STATUS", 0)
                    STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
                    SET_INT_LOCAL("gb_gang_ops_planning", 184, 6)
                end)
                menu.action(doomsday_setting, "刷新任务面板", {}, "", function()--Update tag(1.69)
                    SET_INT_LOCAL("gb_gang_ops_planning", 184, 6)-------刷新(https://github.com/TCRoid/Stand-Lua-RS-Missions/blob/main/lib/RS_Missions/variables.lua#L394)
                end)
                
            local doomsday_position = menu.list(doomsday_list, "地点传送", {}, "")
                menu.action(doomsday_position, "设施", {}, "", function()
                    local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(590))
                    teleport(pos.x, pos.y, pos.z, false)
                end)
                menu.action(doomsday_position, "抢劫屏幕", {}, "先进入设施", function()
                    teleport(350.69284, 4872.308, -60.794243, false)
                    ENTITY.SET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID(), -50)
                end)

            local doomsday_cut = menu.list(doomsday_list, "分红设置", {}, "")--末日
                local doomsday_cut_p = menu.list(doomsday_cut, "玩家[1-4]", {}, "")
                    menu.click_slider(doomsday_cut_p, "玩家1", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Doomsday_Cut + 812 + 50 + 1, value)
                    end)
                    menu.click_slider(doomsday_cut_p, "玩家2", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Doomsday_Cut + 812 + 50 + 2, value)
                    end)
                    menu.click_slider(doomsday_cut_p, "玩家3", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Doomsday_Cut + 812 + 50 + 3, value)
                    end)
                    menu.click_slider(doomsday_cut_p, "玩家4", {}, "(%)", 0, 1000, 25, 5, function(value)
                        SET_INT_GLOBAL(Global_Base.Doomsday_Cut + 812 + 50 + 4, value)
                    end)
                menu.click_slider(doomsday_cut, "全员分红", {}, "(%)", 0, 1000, 25, 5, function(value)
                    SET_INT_GLOBAL(Global_Base.Doomsday_Cut + 812 + 50 + 1, value)
                    SET_INT_GLOBAL(Global_Base.Doomsday_Cut + 812 + 50 + 2, value)
                    SET_INT_GLOBAL(Global_Base.Doomsday_Cut + 812 + 50 + 3, value)
                    SET_INT_GLOBAL(Global_Base.Doomsday_Cut + 812 + 50 + 4, value)
                end)

            local doomsday_senior = menu.list(doomsday_list, "高级选项", {}, "")--末日
                menu.click_slider(doomsday_senior, "设置任务生命数", {}, "确保你是任务脚本主机", 0, 100, 0, 1, function(value)
                    SET_INT_LOCAL("fm_mission_controller", Global_Base.global_team_lives + 1325 + 1, value)
                end)
                menu.action(doomsday_senior, "快速完成", {}, "确保你是任务脚本主机", function()--Update tag(1.69)
                    menu.trigger_commands("scripthost")
                    SET_INT_LOCAL("fm_mission_controller", 19746, 12) -- ???, 'fm_mission_controller' instant finish variable?
                    SET_INT_LOCAL("fm_mission_controller", 19746 + 1741, 150) -- Casino Aggressive Kills & Act 3
                    SET_INT_LOCAL("fm_mission_controller", 27489 + 859 + 18, 99999) -- 'fm_mission_controller' instant finish variable?
                    SET_INT_LOCAL("fm_mission_controller", 31621 + 69, 99999) -- 'fm_mission_controller' instant finish variable?
                    SET_INT_LOCAL("fm_mission_controller", 31621 + 97, 80) -- Act 1 Kills? Seem not to work
                end)
                menu.toggle_loop(doomsday_senior, "单人强制启动", {}, "允许你在没有其他玩家的情况下独自进行抢劫", function()--Update tag(1.69)
                    allow_play_alone()
                end)
                menu.list_action(doomsday_senior, "清空奖章挑战记录", {}, "", DoomsdayMedalRecord.name, function(index)
                    local stats = DoomsdayMedalRecord.key[index]
                    STAT_SET_INT(stats[1], 0)
                    STAT_SET_BOOL(stats[2], false)
                end)


    --公寓抢劫
        local Classic_list = menu.list(HeistControlList, "公寓抢劫", {}, "")
            local Classic_setting = menu.list(Classic_list, "任务设定", {}, "")
                menu.action(Classic_setting, "完成前置任务", {}, "有任务面板时才可使用", function()
                    STAT_SET_INT("HEIST_PLANNING_STAGE", -1)
                    util.toast("设置完成, 你可能需要重新进入公寓来刷新面板")
                end)
                menu.action(Classic_setting, "重置前置任务", {}, "有任务面板时才可使用", function()
                    STAT_SET_INT("HEIST_PLANNING_STAGE", 0)
                    util.toast("设置完成, 你可能需要重新进入公寓来刷新面板")
                end)
            local Classic_senior = menu.list(Classic_list, "高级选项", {}, "")
                menu.toggle_loop(Classic_senior, "移除冷却", {}, "这不会绕过服务器端的冷却时间,即 20分钟. 这只是绕过无法在抢劫面板上发起抢劫", function()--Update tag(1.69)
                    SET_INT_GLOBAL(1877285 + 1 + (PLAYER.PLAYER_ID() * 77) + 76, -1) -- Thanks to @vithiam on Discord
                end)
                menu.toggle_loop(Classic_senior, "单人强制启动", {}, "允许你在没有其他玩家的情况下独自进行抢劫", function()--Update tag(1.69)
                    allow_play_alone()
                end)
                menu.action(Classic_senior, "强制准备", {}, "让所有玩家做好准备", function()--Update tag(1.69)
                    SET_INT_GLOBAL(2657971 + 1 + (1 * 465) + 267, 6) -- Thanks to @vithiam on Discord
                    SET_INT_GLOBAL(2657971 + 1 + (2 * 465) + 267, 6)
                    SET_INT_GLOBAL(2657971 + 1 + (3 * 465) + 267, 6)
                end)
                menu.click_slider(Classic_senior, "设置任务生命数", {}, "确保你是任务脚本主机", 0, 100, 3, 1, function(value)--Update tag(1.69)
                    SET_INT_LOCAL("fm_mission_controller", 19746 + 1765 + 1, value - 1)
                end)
                menu.list_action(Classic_senior, "清空奖章挑战记录", {}, "", ClassicMedalRecord.name, function(index)
                    local stats = ClassicMedalRecord.key[index]
                    STAT_SET_INT(stats[1], 0)
                    STAT_SET_BOOL(stats[2], false)
                    if index == 2 then
                        STAT_SET_INT("MPPLY_HEISTTEAMPROGRESSCOUNTER", 0)
                    end
                end)

    --新抢劫
        local otherheist_list = menu.list(HeistControlList, "其他抢劫", {}, "")
            local LS_ROBBERY = menu.list(otherheist_list, "改装铺抢劫", {}, "", function(); end)
                menu.textslider(LS_ROBBERY, "改装铺抢劫", {}, "", {"联合储蓄","大钞交易","银行合约","电控单元","监狱合约","IAA 交易","摩托帮交易","数据合约"}, function (index)
                    if index ~= 2 then
                        STAT_SET_INT("TUNER_GEN_BS", 12543)
                    else
                        STAT_SET_INT("TUNER_GEN_BS", 4351)
                    end
                        STAT_SET_INT("TUNER_CURRENT", index - 1)
                end)
                menu.action(LS_ROBBERY, "完成准备任务", {}, "", function()
                    STAT_SET_INT("TUNER_GEN_BS", -1)
                end)
                menu.action(LS_ROBBERY, "重置准备任务", {}, "", function()
                    STAT_SET_INT("TUNER_GEN_BS", 12467)
                end)
                menu.action(LS_ROBBERY, "重置合同", {}, "", function()
                    STAT_SET_INT("TUNER_GEN_BS", 8371)
                    STAT_SET_INT("TUNER_CURRENT", -1)
                end)
                menu.action(LS_ROBBERY, "重置总收益和完成任务", {}, "", function()
                    STAT_SET_INT("TUNER_COUNT", 0)
                    STAT_SET_INT("TUNER_EARNINGS", 0)
                end)

            local TH_CONTRACT = menu.list(otherheist_list, "合约: 德瑞博士", {}, "")
                local CONTRACT_VIP = menu.list(TH_CONTRACT, "合约抢劫", {}, "")
                    menu.textslider(CONTRACT_VIP, "夜生活泄密", {}, "", {"夜总会","码头","夜生活泄密"}, function (index)
                        if index ~= 3 then
                            STAT_SET_INT("FIXER_STORY_BS", index + 2)
                        else
                            STAT_SET_INT("FIXER_STORY_BS", 12)
                        end
                        STAT_SET_INT("FIXER_GENERAL_BS", -1)
                        STAT_SET_INT("FIXER_COMPLETED_BS", -1)
                        STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
                    end)
                    menu.textslider(CONTRACT_VIP, "上流社会泄密", {}, "", {"乡村俱乐部","宾客列表","上流社会"}, function (index)
                        if index == 1 then
                            STAT_SET_INT("FIXER_STORY_BS", 28)
                        elseif index == 2 then
                            STAT_SET_INT("FIXER_STORY_BS", 60)
                        elseif index == 3 then
                            STAT_SET_INT("FIXER_STORY_BS", 124)
                        end
                        STAT_SET_INT("FIXER_GENERAL_BS", -1)
                        STAT_SET_INT("FIXER_COMPLETED_BS", -1)
                        STAT_SET_INT("FIXER_STORY_STRAND", -1)
                        STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
                    end)
                    menu.textslider(CONTRACT_VIP, "上流社会泄密", {}, "", {"戴维斯","巴勒帮","代理工作室","别惹德瑞"}, function (index)
                        if index == 1 then
                            STAT_SET_INT("FIXER_STORY_BS", 252)
                        elseif index == 2 then
                            STAT_SET_INT("FIXER_STORY_BS", 508)
                        elseif index == 3 then
                            STAT_SET_INT("FIXER_STORY_BS", 2044)
                        elseif index == 4 then
                            STAT_SET_INT("FIXER_STORY_BS", 4092)
                        end
                        STAT_SET_INT("FIXER_GENERAL_BS", -1)
                        STAT_SET_INT("FIXER_COMPLETED_BS", -1)
                        STAT_SET_INT("FIXER_STORY_STRAND", -1)
                        STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
                    end)
                    menu.textslider(CONTRACT_VIP, "录音 A 工作室", {}, "", {"种子资金","点着它","元老大麻"}, function (index)
                        STAT_SET_INT("FIXER_SHORT_TRIPS", index)
                        STAT_SET_INT("FIXER_GENERAL_BS", -259160457)
                    end)
                menu.action(TH_CONTRACT, "完成所有任务", {}, "", function()
                    STAT_SET_INT("FIXER_GENERAL_BS", -1)
                    STAT_SET_INT("FIXER_COMPLETED_BS", -1)
                    STAT_SET_INT("FIXER_STORY_BS", -1)
                    STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
                end)

            local CHOP_SHOP_ROB = menu.list(otherheist_list, "赃车店抢劫", {}, "")
                menu.textslider(CHOP_SHOP_ROB, "赃车店抢劫", {}, "", {"货船抢劫","小混混抢劫","杜根抢劫","展台抢劫","麦托尼抢劫"}, function (index)
                    STAT_SET_INT("SALV23_VEH_ROB", index - 1)
                    STAT_SET_INT("MOST_TIME_ON_3_PLUS_STARS ", 300000)
                    STAT_SET_INT("SALV23_PLAN_DIALOGUE", 4131109)
                    STAT_SET_INT("SALV23_FM_PROG", 126)
                    STAT_SET_INT("SALV23_GEN_BS", -10241)
                    STAT_SET_INT("SALV23_DISRUPT", 3)
                    STAT_SET_INT("SALV23_VEH_MODS", 0)
                    STAT_SET_INT("SALV23_SCOPE_BS", -1)
                    STAT_SET_BOOL("SALV23_CAN_KEEP", true)
                end)
                menu.toggle_loop(CHOP_SHOP_ROB, "跳过 指纹锁", {}, "适用于光束拼图和暴力破解", function()--Update tag(1.69)
                    SET_INT_LOCAL("fm_content_vehrob_casino_prize", 1045 + 135, 3) -- Beam Puzzle Hack
                    SET_INT_LOCAL("fm_content_vehrob_police", 7511, 536871425) -- Brute Force
                end)
            
        local Heist_tools_list = menu.list(HeistControlList, "工具", {}, "")
            local Stat_Cooldown = menu.list(Heist_tools_list, "立即移除冷却时间", {}, "")
                for _, item in pairs(CooldownStatList) do
                    menu.action(Stat_Cooldown, item.name, {}, "", function()
                        local stats = { item.stat }
                        if type(item.stat) == "table" then
                            stats = item.stat
                        end
                        for _, stat in pairs(stats) do
                            STAT_SET_INT(stat, 0)
                        end
                        util.toast("完成!")
                    end)
                end
    --------------------------------------

    Musiness_Banager = menu.list(Recovery_list, "自动资产", {}, "");appmenu.Ultion.MusinessBanager = Musiness_Banager
        require "lib.SakuraScript.MusinessBanager"

    --赌场刷钱
    local brush_money = menu.list(Recovery_list, "刷钱选项", {}, "");appmenu.Ultion.BrushMoney = brush_money
        casino_Slot_Machine = menu.list(brush_money, "全自动赌场老虎机", {}, "")
            require "lib.SakuraScript.SlotBot"

        TransactionSetter_opt = menu.list(brush_money, "事务交易刷钱", {}, "")
            for i, v in ipairs(transactions) do
                menu.action(TransactionSetter_opt, v.name, {}, "", function()
                    TransactionSetter(v.hash, v.amount)
                end)
            end
        task_transaction_opt = menu.list(brush_money, "任务交易刷钱", {}, "需要冷却时间")
            task_transaction_money()
        appmenu.Ultion.NewDropMoney = menu.toggle_loop(brush_money, "新掉钱袋", {}, "", function()
            new_drop_money()
        end)
        local ped_cash = menu.list(brush_money, "NPC金钱掉落", {})
            local pedmoney = 520
            menu.slider(ped_cash, '修改金额', {'pcfixed'}, 'NPC现金掉落数量', 1, 2000, 520, 1, function(val)
                pedmoney = val
            end)
            menu.toggle_loop(ped_cash, '启用', {}, '修改击杀NPC后可拾取的金钱数量', function() 
                local peds = entities.get_all_peds_as_handles()
                PED.SET_AMBIENT_PEDS_DROP_MONEY(true)
                for _index, ped in pairs(peds) do
                    PED.SET_PED_MONEY(ped, pedmoney)
                end
            end)
        local custom_money_remove = menu.list(brush_money, "自定义金钱删除", {}, "")--Update tag(1.69)
            menu.action(custom_money_remove, "删除金钱", {}, "", function()
                remove_money()
            end)
            menu.slider(custom_money_remove, "金钱数额", {"moneyremoveamount"}, "", 0, 2000000000, 10000, 10000, function(value)
                set_remove_money_acc(value)
            end)
        menu.toggle_loop(brush_money, "作弊码刷钱", {}, "输入你想得到的金钱", function()
            if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 243) then
                local label = util.register_label("作弊码")
                local input = get_input_from_screen_keyboard(label, 20, "")
                if type(tonumber(input)) ~= "number" or not isNumberInRange(tonumber(input), 0, 15000000) then
                    util.toast("无效数字,最大区间0-15000000")
                    return
                end
                TransactionSetter(0x176D9D54, input)
            end
        end)
        menu.textslider(brush_money, "快速刷钱", {}, "无冷却到账一笔资金", {"ToBank","ToWallet"}, function (index)
            quick_brush_money(index)
        end)
        menu.textslider(brush_money, "快速删钱", {}, "前提你需要拥有大额资金", {"FromBank","FromWallet"}, function (index)
            quick_remove_money(index)
        end)

    --Master_Unlocker 解锁大师
        require "lib.SakuraScript.MasterUnlocker"

    local game_tools_list = menu.list(Recovery_list, "游戏工具", {}, "")
        menu.action(game_tools_list, "将所有拾取物传送到我", {}, "", function()
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            for _, pickup in entities.get_all_pickups_as_handles() do
                ENTITY.SET_ENTITY_COORDS(pickup, pos.x, pos.y, pos.z, false, false, false, false)
            end
        end)
        menu.action(game_tools_list, "将我依次传送到拾取物", {}, "传送到时按住E直到结束", function()
            for _, pickup in entities.get_all_pickups_as_handles() do
                if PAD.IS_CONTROL_PRESSED(0,46) then
                    util.taost("已停止")
                    return
                end
                local pos = ENTITY.GET_ENTITY_COORDS(pickup, false)
                ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, false, false, false, false)
                util.yield(1000)
            end
        end)
        Stat_Editor = menu.list(game_tools_list, "GTAHaXUI统计编辑器", {}, "如果你对编辑器不熟悉我们不建议您使用");appmenu.Ultion.StatEditor = Stat_Editor
            require "lib.SakuraScript.StatEditor"

        appmenu.Ultion.RemoveBooks = menu.action(game_tools_list, "移除收支差", {}, "将存在一个2w以内的差额, 它是合法的", function()
            balancing_books()
        end)
        local control_screen_list = menu.list(game_tools_list, "远控屏幕", {}, "")
            menu.action(control_screen_list, "远控地堡", {""}, "", function()
                START_SCRIPT("appbunkerbusiness")
            end)
            menu.action(control_screen_list, "远控机库", {""}, "", function()
                START_SCRIPT("appsmuggler")
            end)
            menu.action(control_screen_list, "远控夜总会", {""}, "", function()
                START_SCRIPT("appbusinesshub")
            end)
            menu.action(control_screen_list, "远控摩托帮", {""}, "", function()
                START_SCRIPT("appbikerbusiness")
            end)
            menu.action(control_screen_list, "远控莱斯特面板", {""}, "", function()
                START_SCRIPT("apparcadebusinesshub")
            end)
            menu.action(control_screen_list, "远控恐霸", {""}, "", function()
                START_SCRIPT("apphackertruck")
            end)
            menu.action(control_screen_list, "远控事务所", {""}, "", function()
                START_SCRIPT("appfixersecurity")
            end)
        local Stat_Cutscene = menu.list(game_tools_list, "移除首次进入资产的动画教程", {}, "")
            for _, item in pairs(BusinessCutsceneBitList) do
                menu.textslider(Stat_Cutscene, item.name, {}, "", {"设置", "重设"}, function(value)
                    local iStatInt = STAT_GET_INT("FM_CUT_DONE")
                    if value == 1 then
                        iStatInt = SET_BIT(iStatInt, table.unpack(item.bits))
                    else
                        iStatInt = CLEAR_BIT(iStatInt, table.unpack(item.bits))
                    end
                    STAT_SET_INT("FM_CUT_DONE", iStatInt)
                    util.toast("完成!")
                end)
            end

    menu.action(Recovery_list, "玩家属性全满", {}, "", function()
        STAT_SET_INT("SCRIPT_INCREASE_STAM", 100)
        STAT_SET_INT("SCRIPT_INCREASE_STRN", 100)
        STAT_SET_INT("SCRIPT_INCREASE_LUNG", 100)
        STAT_SET_INT("SCRIPT_INCREASE_DRIV", 100)
        STAT_SET_INT("SCRIPT_INCREASE_FLY", 100)
        STAT_SET_INT("SCRIPT_INCREASE_SHO", 100)
        STAT_SET_INT("SCRIPT_INCREASE_STL", 100)
        util.toast("完成！")
    end)
    menu.action(Recovery_list, "补满夜总会人气", {}, "", function()
        STAT_SET_INT("CLUB_POPULARITY", 1000)
        util.toast("完成！")
    end)
    menu.action(Recovery_list, "移除达克斯工作冷却", {}, "", function()
        STAT_SET_INT("XM22JUGGALOWORKCDTIMER", -1, true)
    end)

--[[ local cat_doll = {
    name = {
        [1] = "紫色毛绒小猫",
        [2] = "绿色毛绒小猫",
        [3] = "蓝色毛绒小猫",
        [4] = "棕色毛绒小猫",
        [5] = "黄色毛绒小猫",
        [6] = "红色毛绒小猫",
        [7] = "粉色毛绒小猫",
        [8] = "Wasabi Cat",
        [9] = "Plushie Sensei",
    },
    prop = {
        [1] = "ch_prop_arcade_claw_plush_01a",
        [2] = "ch_prop_arcade_claw_plush_02a",
        [3] = "ch_prop_arcade_claw_plush_03a",
        [4] = "ch_prop_arcade_claw_plush_04a",
        [5] = "ch_prop_arcade_claw_plush_05a",
        [6] = "ch_prop_arcade_claw_plush_06a",
        [7] = "ch_prop_princess_robo_plush_07a",
        [8] = "ch_prop_shiny_wasabi_plush_08a",
        [9] = "ch_prop_master_09a",
    }
}

    menu.textslider(Recovery_list, "小猫娃娃机", {}, "抓住指定娃娃\n建议点击开始游玩闪亮芥末小猫娃娃机后再选择小猫毛绒玩具", cat_doll.name, function(index)
        local grapple, doll
        local dollhash = MISC.GET_HASH_KEY(cat_doll.prop[index])
        for _, obj in pairs(entities.get_all_objects_as_handles()) do

            --抓钩
            if ENTITY.GET_ENTITY_MODEL(obj) == 948740834 then
                grapple = obj
            end
            --娃娃
            if ENTITY.GET_ENTITY_MODEL(obj) == dollhash then
                doll = obj
            end
        end

        if ENTITY.DOES_ENTITY_EXIST(grapple) and ENTITY.DOES_ENTITY_EXIST(doll) then

            local pos1 = ENTITY.GET_ENTITY_COORDS(grapple, false)
            local pos2 = ENTITY.GET_ENTITY_COORDS(doll, false)

            ENTITY.ATTACH_ENTITY_TO_ENTITY(doll, grapple, 0, 0, 0, pos2.z-pos1.z, 0, 0, 0, true, true, true, true, 0, true, 0)

            while ENTITY.IS_ENTITY_ATTACHED(doll) do

                SET_INT_GLOBAL(291015, 0)
                SET_INT_GLOBAL(291016, 0)
                SET_INT_GLOBAL(291017, 0)
                SET_INT_GLOBAL(291018, 0)

                if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 191) then
                    ENTITY.DETACH_ENTITY(doll, true, true)
                    --ENTITY.SET_ENTITY_COLLISION(doll, true, true)
                    ENTITY.APPLY_FORCE_TO_ENTITY(doll, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, true, true, true)
                end
                util.yield()
            end
            util.toast("分离")
        else
            util.yield("未找到指定娃娃")
        end

    end) ]]

    local auto_taxi_list = menu.list(Recovery_list, '自动出租车', {}, '')
        menu.toggle(auto_taxi_list, '自动出租车', {}, '通过出租车自动接送人员', function (toggled)
            auto_taxi(toggled)
        end)
        menu.textslider(auto_taxi_list, "出租出行为", {}, "选择一种方式\n点击切换", {"驾驶","传送"}, function (index)
            check_taxi_way(index)
        end)
        
    local Task_senior_list = menu.list(Recovery_list, '高级功能', {}, '')
        menu.action(Task_senior_list, "跳过一句NPC对话", {}, "", function()
            AUDIO.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE()
        end)
        menu.toggle_loop(Task_senior_list, "自动跳过NPC对话", {}, "", function()
            if AUDIO.IS_SCRIPTED_CONVERSATION_ONGOING() then
                AUDIO.STOP_SCRIPTED_CONVERSATION(false)
                AUDIO.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE()
            end
        end)
        menu.toggle_loop(Task_senior_list, "自动跳过过场动画", {}, "", function()
            if CUTSCENE.IS_CUTSCENE_ACTIVE() or CUTSCENE.IS_CUTSCENE_PLAYING() then
                CUTSCENE.STOP_CUTSCENE_IMMEDIATELY()
                CUTSCENE.REMOVE_CUTSCENE()
            end
        end)
        menu.toggle_loop(Task_senior_list, "自动CEO/首领", {},"", function()
            auto_CEO()
        end)
        appmenu.Ultion.AutoTaskScriptHost = menu.toggle_loop(Task_senior_list, "自动任务脚本主机", {}, "", function()
            auto_task_script_host()
        end)
------------------------------------------------------


----武器选项
weaponsetting = menu.list(weapons, '武器设置', {}, '')
    menu.action(weaponsetting, "给予所有武器", {}, "", function()
        give_all_weapon(PLAYER.PLAYER_PED_ID())
    end)
    menu.action(weaponsetting, "移除所有武器", {}, "", function()
        remove_all_weapon(PLAYER.PLAYER_PED_ID())
    end)
    menu.action(weaponsetting, "强制丢弃武器", {}, "强制丢弃当前武器", function()
        force_discard_weapon()
    end)
    menu.action(weaponsetting, "补充弹夹弹药",{}, "",function()
        WEAPON.REFILL_AMMO_INSTANTLY(PLAYER.PLAYER_PED_ID())
    end)
    menu.action(weaponsetting, "补充所有弹药",{}, "",function()
        for _, weapon in ipairs(util.get_weapons()) do
            WEAPON.SET_PED_AMMO(PLAYER.PLAYER_PED_ID(), weapon.hash, 9999, false)
        end
    end)
    menu.toggle_loop(weaponsetting, "无限弹药", {}, "", function()
        local hash = WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID())
        WEAPON.SET_PED_AMMO(PLAYER.PLAYER_PED_ID(), hash, 9999, false)
    end)
    menu.toggle_loop(weaponsetting, '无需装弹', {}, '', function()
        if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
            WEAPON.REFILL_AMMO_INSTANTLY(PLAYER.PLAYER_PED_ID())
        end
    end)
    menu.click_slider(weaponsetting, "添加弹药", {}, "添加指定武器弹药", 1, 9999, 1, 20, function(value)
        local hash = WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID())
        WEAPON.ADD_AMMO_TO_PED(PLAYER.PLAYER_PED_ID(), hash, value)
    end)
    menu.list_select(weaponsetting,"弹药效果", {}, "", explosion_names, 1, function (index)
        change_bullet_style(index)
    end)
    menu.toggle_loop(weaponsetting, "快速射击", {}, "", function()
        rapidfire()
    end)
    menu.toggle(weaponsetting, '无后坐力', {}, '使用武器射击时不会抖动游戏画面.', function(toggled)
        No_Recoil(toggled)
    end)
    menu.toggle(weaponsetting, '无限射程', {}, '', function(toggled)
        max_range(toggled)
    end)
    menu.toggle(weaponsetting, '无扩散', {}, '', function(toggled)
        no_spread(toggled)
    end)
    menu.toggle(weaponsetting, '移除前摇', {}, '移除加特林和寡妇制造者的前摇.', function(toggled)
        no_spinup(toggled)
    end)
    menu.click_slider_float(weaponsetting, "近战伤害修改", {}, "", 100, 1000, 100, 10, function(value)
        PLAYER.SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(PLAYER.PLAYER_ID(), value / 100)
    end)
    menu.toggle(weaponsetting, '子弹伤害修改', {}, '从正面射击载具时效果最佳.\n显示的值以百分比为单位.', function(toggled)
        damagemoded(toggled)
    end)
    menu.divider(weaponsetting, '瞄准视野')
    menu.toggle(weaponsetting, '瞄准视野缩放', {}, '让您在瞄准放大时修改视野大小.', function(toggled)
        enablezoomfov(toggled)
    end)
    menu.slider_float(weaponsetting, '瞄准视野范围', {'AimFov'}, '', 100, 100000000, 100, 1, function(value)
        zoomaimfov(value)
    end)

weapon_save = menu.list(weapons, '自定义武器', {}, '')
    dofile(filesystem.scripts_dir() .."lib/SakuraScript/CustomWeapon/customweapon.lua")

weapon_hud = menu.list(weapons, '武器HUD', {}, '')
    require "lib.SakuraScript.WeaponHUD"

special_weapons = menu.list(weapons, "特殊武器", {}, "")
    menu.toggle(special_weapons, "大锤", {}, "", function(on)
        hammer(on)
    end)
    menu.toggle(special_weapons, "雷神锤", {}, "", function(on)
        thunder_hammer(on)
    end)
    menu.toggle(special_weapons, "流星锤", {}, "", function(on)
        meteorhammer(on)
    end)
    menu.toggle(special_weapons, "原子锤", {}, "", function(on)
        atomhammer(on)
    end)
    menu.toggle(special_weapons, "小熊", {}, "", function(on)
        bearhammer(on)
    end)
    menu.toggle(special_weapons, "独角兽", {}, "", function(on)
        unicorn(on)
    end)
    menu.toggle(special_weapons, "太刀",{}, "",function(on)
        knife(on)
    end)

entity_control = menu.list(weapons, "实体控制枪", {}, "控制你所瞄准的实体")
    require "lib.SakuraScript.Entity_control"

weapon_fun = menu.list(weapons, "武器娱乐", {}, "")
    local shotgun_list = menu.list(weapon_fun, "霰弹枪", {}, "")
        menu.toggle_loop(shotgun_list, "霰弹爆炸枪", {}, "如果你感觉射程不够远可以打开无限范围", function()
            super_shotgun()
        end)
        menu.toggle_loop(shotgun_list, '霰弹导弹枪', {}, '如果你感觉射程不够远可以打开无限范围',function()
            cluster_shotgun()
        end)
    menu.toggle_loop(weapon_fun, '蜡烛枪', {}, '别尝试生成太多', function()
        candle_gun()
    end)
    menu.action(weapon_fun, "绳索枪", {}, "绳子连接两个实体", function()
        rope_gun()
    end)
    menu.toggle_loop(weapon_fun, "吸附枪", {}, "射击后吸附", function ()
        Adsorption_gun()
    end)
    menu.toggle(weapon_fun, "小狗枪", {}, "", function(toggle)
        poodle_gun(toggle)
    end)
    magnetic_gun = menu.list(weapon_fun, "磁力枪", {}, "")
        menu.toggle_loop(magnetic_gun, "磁力枪", {}, "具有磁力的枪,可控制车辆去向", function ()
            ciliqiang()
        end)
        menu.list_select(magnetic_gun, "设置磁力枪", {}, "选择后才生效", {{1,"平滑模式"}, {2,"混沌模式"}}, 1,function(value, menu_name, prev_value, click_type)
            szclq(value, menu_name, prev_value, click_type)
        end)
    menu.toggle_loop(weapon_fun, "彩弹枪", {}, "射击更改载具颜色", function()
        Paintball_gun()
    end)
    particle_gun_list = menu.list(weapon_fun, "粒子枪", {}, "")
        menu.toggle_loop(particle_gun_list, "粒子枪", {}, "", function()
            particle_gun()
        end)
        menu.list_select(particle_gun_list, "设置粒子", {}, "选择后才生效", particle_gund.name, 1,function(value, menu_name, prev_value, click_type)
            selete_particle_gun(value, menu_name, prev_value, click_type)
        end)
    menu.toggle_loop(weapon_fun, "端粒枪", {}, "", function()
        Telomere_gun()
    end)
    menu.toggle_loop(weapon_fun, "空袭枪", {}, "", function()
        kxq()
    end)
    menu.toggle_loop(weapon_fun, "传送枪", {}, "", function()
        csq()
    end)
    menu.toggle_loop(weapon_fun, "偷车枪", {}, "", function()
        steal_car_gun()
    end)
    menu.toggle_loop(weapon_fun, "死亡之眼", {}, "当然,这对玩家无效", function()
        dead_eye()
    end)
    graffiti = menu.list(weapon_fun, "涂鸦枪", {}, "")
        menu.toggle(graffiti, "开启", {}, "", function(toggled)
            Graffiti_weapon(toggled)
        end)
        menu.slider(graffiti, "亮度", {"graffitiness"}, "光亮强度.", 0, 1000, 100, 10, function(value)
            graffiti_bright(value)
        end)
        menu.slider(graffiti, "半径", {"graffitiradius"}, "光束半径.", 0, 20, 5, 1, function(value)
            graffiti_radiu(value)
        end)
        menu.rainbow(menu.colour(graffiti, "颜色", {"graffiticolour"}, "", {r = 0, g = 0, b = 1, a = 0}, true, function(value)
            graffiti_color(value)
        end))

    entity_gun = menu.list(weapon_fun, "实体枪", {}, "")
        menu.toggle_loop(entity_gun, "重力实体枪", {}, "", function()
            eentity_gun()
        end)
        menu.list_select(entity_gun, "重力选择实体", {}, "选择重力实体枪的模型", gravity_entity_gun.name, 1,function(value, menu_name, prev_value, click_type)
            shootent = gravity_entity_gun.value[value]
        end)
        menu.toggle_loop(entity_gun, '沙块枪', {}, '', function()
            local pos = v3.new()
            if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
                create_object(util.joaat('prop_mb_sandblock_01'), pos.x, pos.y, pos.z)
            end
        end)
        menu.toggle_loop(entity_gun, "目标靶", {}, "", function() 
            local pos = v3.new()
            if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) and not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) then
                create_shooting_target(pos.x, pos.y, pos.z)
            end
        end)
        menu.toggle_loop(entity_gun, "手办枪", {}, "", function() 
            local pos = v3.new()
            if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
                create_ambient_pickup(pos.x, pos.y, pos.z, -1009939663, MISC.GET_HASH_KEY("vw_prop_vw_colle_prbubble"))
            end
        end)
        menu.toggle_loop(entity_gun, "卡片枪", {}, "", function() 
            local pos = v3.new()
            if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
                create_ambient_pickup(pos.x, pos.y, pos.z, -1009939663, 3030532197)
            end
        end)
        menu.toggle_loop(entity_gun, "粑粑枪", {}, "", function() 
            local pos = v3.new()
            if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
                create_object(-2071359746, pos.x, pos.y, pos.z)
            end
        end)
        menu.toggle_loop(entity_gun,"陨石枪", {}, "", function()
            local pos = v3.new()
            if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
                create_object(3751297495, pos.x, pos.y, pos.z)
            end
        end)
    attach_entity_fun = menu.list(weapon_fun, "载具附加枪", {}, "")
        menu.toggle_loop(attach_entity_fun, "开启", {}, "", function ()
            attach_entity_gun()
        end)
        menu.list_select(attach_entity_fun, "选择实体", {}, "", Objn.name, 1, function (value, menu_name, prev_value, click_type)
            selete_attach_entity_gun(value, menu_name, prev_value, click_type)
        end)
        
    menu.toggle_loop(weapon_fun, "喷火枪", {}, "", function() 
        local pos = v3.new()
        if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 12, 1, true, false, 0, false)
        end
    end)
    menu.toggle_loop(weapon_fun, "喷水枪", {}, "", function() 
        local pos = v3.new()
        if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 13, 1, true, false, 0, false)
        end
    end)
    menu.toggle_loop(weapon_fun, "神风炮", {}, "", function()
        Kamikaze_Gun()
    end)
    menu.toggle_loop(weapon_fun,"烟花枪", {}, "拿着烟花发射器时将发射自定义载具烟花", function()
        Firework_Gun()
    end)
    menu.toggle_loop(weapon_fun,"抓钩枪", {}, "", function()
        grappling_gun()
    end)
    menu.toggle_loop(weapon_fun,"鲨鱼枪", {}, "", function()
        Shark_gun()
    end)
    menu.toggle_loop(weapon_fun, "实体引力", {}, "射击两个实体以让它们互相吸引", function()
        ctst()
    end, function ()
        ctst_stop()
    end)
    menu.toggle(weapon_fun, "RPG自动瞄准器", {}, "发射后自动追踪视野内玩家", function (on)
        RPG_Automatic_sight(on)
    end)
    nuclear_weapon = menu.list(weapon_fun, "核武器", {}, "");appmenu.Ultion.NuclearWeapon = nuclear_weapon
        menu.toggle_loop(nuclear_weapon,"天基炮", {}, "", function()
            nuclear_weapon1()
        end)
        menu.toggle_loop(nuclear_weapon, '核弹枪', {}, "", function()
            nukegunmode()
        end)
        menu.toggle_loop(nuclear_weapon,"超级核弹", {}, "", function()
            nuclear_weapon2()
        end)
    menu.toggle_loop(weapon_fun,"推进载具", {}, "", function()
        if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
            local entity = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
            if entity ~= 0 then
                if ENTITY.IS_ENTITY_A_VEHICLE(entity) then
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity, 100)
                end
            end
        end
    end)
    menu.toggle_loop(weapon_fun,"冻结实体", {}, "", function()
        if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
            local entity = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
            if entity ~= 0 then
                ENTITY.FREEZE_ENTITY_POSITION(entity, true)
            end
        end
    end)
    menu.toggle_loop(weapon_fun, "转魂枪", {}, "", function()
        Soul_Gun()
    end)
    menu.action(weapon_fun, "发射引导导弹", {}, "", function()
        if not UFO.exists() then 
            GuidedMissile.create()
        end
    end)
    menu.toggle(weapon_fun, "背藏武器", {}, "按Tab键", function(on)
        Back_weapons(on)
    end)
    vehicleGun = menu.list(weapon_fun,"载具枪", {}, "")
        menu.toggle_loop(vehicleGun,"开启", {}, "", function ()
            Vehicle_gun()
        end)
        menu.list_select(vehicleGun,"选择载具", {}, "", Objoptions_all, 1, function (value, menu_name, prev_value, click_type)
            Vehicle_gun_opt(value, menu_name, prev_value, click_type)
        end)
        menu.toggle(vehicleGun,"进入车辆", {}, "", function(toggle)
            Vehicle_gun_into(toggle)
        end)
    menu.toggle(weapon_fun, "女武神导弹",  {}, "", function(toggle)
        nvwushen(toggle)
    end)

silent_aimbotroot = menu.list(weapons, "武器自瞄", {}, "")
    require "lib.SakuraScript.Aimbot"

menu.toggle(weapons, "锁定玩家", {}, "允许使用制导发射器锁定玩家", function(toggled)
    lock_player(toggled)
end)
menu.toggle_loop(weapons, "增强武器锁定", {}, "导弹锁定范围和自动瞄准设置为最大", function()
	PHYSICS.SET_PLAYER_LOCKON_RANGE_OVERRIDE(players.user(), 99999999.0)
end)
menu.toggle_loop(weapons, "双发", {}, "在同一时间内射出两枪", function()
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(PLAYER.PLAYER_PED_ID())
    end
end)
menu.toggle_loop(weapons, "导弹雷达", {}, "", function()
    Missile_radar()
end)
menu.toggle_loop(weapons, "近战爆炸", {}, "", function()
    local pos = v3.new()
    if WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()) == -1569615261 and WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), pos) then
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 18, 100, true, false, 0, false)
    end
end)

menu.toggle_loop(weapons, "瞄准信息", {}, "显示您瞄准的实体的信息", function()
    local ent = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
    local info = get_entity_info(ent)
    if info ~= 0 then
        local text = "哈希: " .. info['hash'] .. "\n生命值: " .. info['health'] .. "\n类型: " .. info['type_name'] .. "\n速度: " .. info['speed']
        directx.draw_text(0.5, 0.3, text, 5, 0.5, {r=1, g=1, b=1, a=1}, true)
    end
end)

menu.toggle_loop(weapons, "显示准星", {}, '', function()
    HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
end)

weapon_bullet = menu.list(weapons, "更改子弹类型", {}, "")
    change_bullet_type()

menu.toggle_loop(weapons, "移除爆炸物", {}, "移除玩家所有爆炸性弹药,甚至是火箭弹", function()
    remove_explosive()
end)
menu.toggle_loop(weapons, "随机武器色调", {}, "", function(on)
    local last_tint = WEAPON.GET_PED_WEAPON_TINT_INDEX(PLAYER.PLAYER_PED_ID(), WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()))
    WEAPON.SET_PED_WEAPON_TINT_INDEX(PLAYER.PLAYER_PED_ID(),WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()), math.random(0, 7))
end)
damage_numbers_list = menu.list(weapons, "伤害数字")
    require "lib.SakuraScript.damage_numbers"

menu.toggle_loop(weapons, "踢出枪", {}, "", function()
    local ent = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) and PED.IS_PED_A_PLAYER(ent) then
        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
        if players.get_host() == pid then 
            util.toast("您正试图踢出的玩家是主机")
            return
        end
        menu.trigger_commands("kick" .. players.get_name(pid))
    end
end)
menu.toggle_loop(weapons, "崩溃枪", {}, "", function()
    local ent = get_entity_player_is_aiming_at(PLAYER.PLAYER_ID())
    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) and PED.IS_PED_A_PLAYER(ent) then
        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
        menu.trigger_commands("crash" .. players.get_name(pid))
    end
end)

sticky_bomb_explosion = menu.list(weapons, '自动粘弹', {}, '')
    menu.toggle_loop(sticky_bomb_explosion, '粘弹自动爆炸', {}, '使您的粘弹在玩家或NPC附近时自动引爆.', function()
        proxyStickys()
    end)
    local detonate_players = true
    menu.toggle(sticky_bomb_explosion, '引爆附近的玩家', {}, '', function(toggle)
        detonate_players = toggle
    end,true)
    menu.toggle(sticky_bomb_explosion, '引爆附近的NPC', {}, '', function(toggle)
        detonate_npcs = toggle
    end)
    menu.slider(sticky_bomb_explosion, '触发半径', {}, '', 1, 10, 2, 1, function(value)
        detonate_radius = value
    end)
    menu.action(sticky_bomb_explosion, '移除所有粘性炸弹', {}, '移除所有存在的粘性炸弹', function()
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(util.joaat('weapon_stickybomb'))
    end)

menu.action(weapons, '移除所有感应地雷', {}, '移除所有存在的感应地雷', function()
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(util.joaat('weapon_proxmine'))
end)

local throwables = menu.list(weapons, '投掷物发射器', {}, '')
    menu.toggle_loop(throwables, '投掷物发射器', {}, '使榴弹发射器能够发射可选的投掷物', function()
        throwablebullet()
    end)
    menu.list_select(throwables, '当前投掷物', {}, '选择榴弹发射器发射的投掷物', throwablesTable.name, 1, function (value, menu_name, prev_value, click_type)
        bulletset(value)
    end)

menu.toggle_loop(weapons, "武器隐形", {}, "关闭后切枪恢复", function(toggled)
    --WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not toggled, false, false, false)
    ENTITY.SET_ENTITY_VISIBLE(WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(PLAYER.PLAYER_PED_ID(), 0), false)
end)
menu.toggle_loop(weapons, "快速切枪", {}, "武器更换速度更快.", function()
    if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 56) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(PLAYER.PLAYER_PED_ID())
    end
end)
menu.toggle_loop(weapons, '热成像枪', {}, '当您瞄准时按"E"可以启用热成像功能.', function()
    thermalgun()
end)
menu.toggle_loop(weapons, "快速热成像", {}, "更快地在热成像之间进行切换.", function()
    if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 92) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(PLAYER.PLAYER_PED_ID())
    end
end)
menu.toggle_loop(weapons, "快速近战", {}, "近战速度更快.", function()
    if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 130) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(PLAYER.PLAYER_PED_ID())
    end
end)

menu.toggle_loop(weapons, "NPC枪", {}, "随机射出NPC", function()
    shechuNPC()
end)
menu.toggle_loop(weapons, '喷火器', {}, '将加特林改为喷火枪', function()
    flamegun()
end)
menu.toggle(weapons, "允许射击队友", {}, '使你在游戏中能够射击队友', function(toggle)
    PED.SET_CAN_ATTACK_FRIENDLY(PLAYER.PLAYER_PED_ID(), toggle, false)
end)

shooting_effects = menu.list(weapons, "射击特效", {}, "")
    menu.toggle_loop(shooting_effects, "射击效果", {}, "", function ()
        Shoot_effect()
    end)
    menu.list_select(shooting_effects, "设置效果", {}, "", Shoot_effect_options, 1, function (value, menu_name, prev_value, click_type)
        Shoot_effect_option(value, menu_name, prev_value, click_type)
    end)

hitEffectRoot = menu.list(weapons, "命中效果", {}, "")
    menu.toggle_loop(hitEffectRoot, "开启效果", {}, "", function()
        Hit_effect()
    end)
    menu.list_select(hitEffectRoot, "设置效果", {}, "", hit_effect_options, 1, function (value, menu_name, prev_value, click_type)
        hit_effect_option(value, menu_name, prev_value, click_type)
    end)
    hit_menuColour = menu.colour(hitEffectRoot, "设置颜色", {"dwuahjudhau"}, "仅对某些效果有效", hiteffectColour, false, function(colour)
        set_effectColour(colour)
    end)
    menu.rainbow(hit_menuColour)

menu.toggle_loop(weapons, "删除枪", {}, "", function()
    delete_gun()
end)
menu.toggle_loop(weapons, '翻滚换弹', {}, '', function()
    fghd()
end)

----------娱乐选项
classic_fun_list = menu.list(funfeatures, "经典娱乐", {}, "")
    menu.action(classic_fun_list, '崔佛的车', {}, '', function()
        trevor_car()
    end)
    menu.action(classic_fun_list, '彭狗棺材', {}, 'cv之王弗利萨', function()
        Frieza_coffin()
    end)
    appmenu.Ultion.bean = menu.toggle(classic_fun_list, "憨豆的车", {}, '', function(toggled)
        Bean_fun(toggled)
    end)
    menu.toggle(classic_fun_list, "球形化术", {}, '', function(toggled)
        become_ball(toggled)
    end)
    menu.toggle(classic_fun_list, "战斗陀螺", {}, '按W可移动', function(toggled)
        Beyblade(toggled)
    end)
    appmenu.Ultion.FlyingAxe = menu.toggle(classic_fun_list, "飞行斧", {}, '按E召唤斧子,右键调整方向并通过左键丢出斧子', function(toggled)
        flying_axe(toggled)
    end)
    menu.toggle(classic_fun_list, "祖国人", {}, "按E使用技能", function(toggled)
        the_homelander(toggled)
    end)
    appmenu.Ultion.ResSkateboard = menu.toggle(classic_fun_list, "新型滑板车", {}, "W向前,shift加速,空格跳板,x转板", function(toggled)
        res_skateboard(toggled)
    end)
    menu.action(classic_fun_list, '火箭发射', {}, '', function()
        launching_rocket()
    end)
    Superhuman = menu.list(classic_fun_list, "超能者", {}, "")
        appmenu.Ultion.Super_Wings = menu.toggle(Superhuman, "超级飞侠", {}, '', function(toggled)
            Super_Wings(toggled)
        end)
        menu.toggle_loop(Superhuman, "星光", {}, '艾尔登法环同款星光魔法', function()
            request_ptfx_asset("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY('ent_anim_paparazzi_flash', PLAYER.PLAYER_PED_ID(), 0, 0, 1.5, 0, 0, 0, 1.0, false, false, false)
        end)
        menu.toggle_loop(Superhuman, "闪电侠", {}, '', function()
            flash_man()
        end)
        menu.toggle_loop(Superhuman, "外星人", {}, '', function()
            alien_man()
        end)
        menu.toggle_loop(Superhuman, "白月光", {}, '', function()
            moonlight_man()
        end)
        menu.toggle_loop(Superhuman, "太阳花", {}, '', function()
            sunflower_man()
        end)
    menu.toggle_loop(classic_fun_list, "万象天征", {}, '按E触发\n一股神秘的冲击波,不知道会发生什么...', function()
        vientiane_explosion()
    end)
    menu.action(classic_fun_list, '野兽模式', {}, '当然,这是虚假的野兽', function()
        beast_mode()
    end)
    menu.toggle(classic_fun_list, "丧尸模式", {}, '', function(toggle)
        Zombie_Mode(toggle)
    end)
    menu.action(classic_fun_list, '911事件', {}, '让它成为GTA宇宙中的经典\n一架飞机撞向花园银行', function()
        attacks_911()
    end)
    menu.toggle_loop(classic_fun_list, "鱼雨", {}, '', function()
        fish_rain()
    end)
    menu.action(classic_fun_list, "通往天堂", {}, "", function()
        To_Heaven()
    end)
    menu.action(classic_fun_list, "空中梯队", {}, "", function()
        escort()
    end)
    menu.action(classic_fun_list, "军演阅兵", {}, "", function()
        parade()
    end)
    menu.action(classic_fun_list, "地雷", {}, "对导弹尾部进行射击以触发", function()
        spawn_mine()
    end)
    appmenu.Ultion.TransportNuke = menu.action(classic_fun_list, "运输核弹", {}, "", function()
        transport_nuke()
    end)
    menu.toggle_loop(classic_fun_list, "极地轰炸", {}, "射击你要轰炸的地点", function()
        Military_exercises()
    end)
    menu.list_action(classic_fun_list, "骑乘动物", {}, "按F停止骑行\n如果他们受到惊吓或许会乱跑", {{1,"鹿"}, {2,"公猪"}, {3,"牛"},{4,"兔子"}}, function(index)
        riding_animals(index)
    end)
    menu.list_action(classic_fun_list, "附加恶搞模型", {}, "仅适用于自己", spoof_attachd.name, function(index)
        Attachd_Self(index)
    end)
    menu.action(classic_fun_list, "世界轰炸", {}, "", function()
        World_Bombing()
    end)
    appmenu.Ultion.Surf = menu.action(classic_fun_list, "冲浪", {}, "", function()
        surf()
    end)
    menu.action(classic_fun_list, "猴王", {}, "", function()
        monkey_king()
    end)
    menu.toggle(classic_fun_list, '钢铁侠', {}, '', function(toggled)
        Iron_Man1(toggled)
    end)
    menu.action(classic_fun_list, "炸弹车", {}, "", function ()
        bomb_car()
    end)
    menu.toggle_loop(classic_fun_list, "一拳超人", {}, "", function()
        supermanpersonl()
    end)
    menu.toggle(classic_fun_list, "原力", {}, "通过鼠标左键或右键来控制", function(toggled)
        atom_force(toggled)
    end)
    menu.action(classic_fun_list, "定点打击", {}, "打击地图标记地点", function ()
        targeted_strike()
    end)
    menu.toggle_loop(classic_fun_list, "定点循环轰炸", {}, "打击地图标记地点", function ()
        targeted_loop_strike()
    end)
    menu.toggle(classic_fun_list, "地毯飞行", {}, "", function(toggled)
        carpetride(toggled)
    end)

vehicle_fun = menu.list(funfeatures, "载具娱乐", {}, "")
    police_vehicle = menu.list(vehicle_fun, "警车模式", {}, "")
        require "lib.SakuraScript.Policify"

    menu.toggle_loop(vehicle_fun, "避免事故", {}, "可避免车祸,仍然需要具备一定的驾驶能力", function()
        aa_thread()
    end)
    menu.action(vehicle_fun, "召回载具", {}, "让你的载具自动驶向你", function()
        recall_vehicle()
    end)
    menu.toggle(vehicle_fun, "GPS导航", {}, "", function(value)
        GPS_navigation(value)
    end)
    menu.toggle(vehicle_fun,"恶灵骑士" ,{}, "", function(on)
        elqss(on)
    end)
    menu.action(vehicle_fun, "牛车", {}, "",function()
        ride_cow()
    end)
    menu.action(vehicle_fun, "驾驶购物车", {}, "", function ()
        drive_shopping_cart()
    end)
    menu.action(vehicle_fun, "洛奇斯怪兽mk2", {}, "", function()
        lochness_mk2()
    end)
    menu.action(vehicle_fun, "驾驶飞天扫帚", {}, "", function()
        flying_broom()
    end)
    menu.action(vehicle_fun, "驾驶超级飞机", {}, "德罗索飞行模式", function()
        super_phane()
    end)
    menu.action(vehicle_fun, "驾驶超级游艇", {}, "在水面上生成", function ()
        super_yacht()
    end)
    menu.textslider(vehicle_fun, "极限跳跃", {}, "再现地平线", {"低","中","高"}, function(index)
        extreme_jump(index)
    end)
    local UFO_vehicles = menu.list(vehicle_fun, "UFO载具", {}, "");appmenu.Ultion.UFOVehicles = UFO_vehicles
        menu.textslider(UFO_vehicles, "UFO", {}, "驾驶UFO,使用牵引光束和大炮", ufo_name, function (index)
            local obj = objModels[index]
            UFO.setObjModel(obj)
            if not (GuidedMissile.exists() or UFO.exists()) then 
                UFO.create() 
            end
        end)
        local ufoSettings = menu.list(UFO_vehicles, "设置", {}, "")
            menu.toggle(ufoSettings,"禁用玩家框", {}, "", function(toggle)
                funConfig.ufo.disableboxes = toggle
            end)
            menu.toggle(ufoSettings, "仅吸引玩家载具", {},"使牵引光束忽略带有非玩家驾驶员的车辆", function(toggle)
                funConfig.ufo.targetplayer = toggle
            end)
    local spawn_truck = menu.list(vehicle_fun, "拉车")
        local spawn_truck_car = menu.list(spawn_truck, "货运载具")
            menu.action(spawn_truck_car, "废土", {}, "生成一个废土人进行拖曳", function()
                menu.trigger_commands("wastelander")
            end)
            menu.action(spawn_truck_car, "猛击卡车", {}, "生成一辆猛击卡车进行牵引", function()
                menu.trigger_commands("slamtruck")
            end)
            menu.toggle(spawn_truck_car, "附加", {}, "任何近距离车辆都将连接到您当前的车辆上", function(on)
                if on then
                    attach_nearest_vehicle()
                else
                    detach_attached_vehicle() 
                end
            end)
        local cargobobMenu = menu.list(spawn_truck, "货运直升机", {})
            menu.action(cargobobMenu, "磁吸运兵直升机", {}, "按E使用吊挂", function()
                spawn_cargobob_with_magnet()
            end)
            menu.action(cargobobMenu, "运兵直升机", {}, "按H键连接载具,按E丢弃载具",function()
                spawn_cargobob()
            end)
            menu.action(cargobobMenu, "吊挂直升机", {}, "按E使用", function()
                spawn_skylift()
            end)       
    local acrobatics = menu.list(vehicle_fun, "车辆跳跃", {}, "")
        menu.action(acrobatics, "豚跳", {}, "", function()
            local vehicle = get_vehicle_player_is_in(PLAYER.PLAYER_ID())
            if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
            request_control(vehicle, 1000) then
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
            end
        end)
        menu.action(acrobatics, "左侧空翻", {}, "", function()
            local vehicle = get_vehicle_player_is_in(PLAYER.PLAYER_ID())
            if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
            request_control(vehicle, 1000) then
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, 5.0, 0.0, 0.0, 1, false, true, true, true, true)
            end
        end)
        menu.action(acrobatics, "双左侧空翻", {}, "", function()
            local vehicle = get_vehicle_player_is_in(PLAYER.PLAYER_ID())
            if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
            request_control(vehicle, 1000) then
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 21.43, 20.0, 0.0, 0.0, 1, false, true, true, true, true)
            end
        end)
        menu.action(acrobatics, "右侧空翻", {}, "", function()
            local vehicle = get_vehicle_player_is_in(PLAYER.PLAYER_ID())
            if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
            request_control(vehicle, 1000) then
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, -5.0, 0.0, 0.0, 1, false, true, true, true, true)
            end
        end)

    --看门狗模式
        require "lib.SakuraScript.WatchDogs"

    local p_eff_fun = menu.list(funfeatures, "娱乐粒子效果", {}, "")
        menu.toggle_loop(p_eff_fun, '开启', {}, '', function ()
            ptfx_fun()
        end)
        menu.list_select(p_eff_fun, '设置粒子效果', {}, '发送您选择的粒子效果', funptfx.name, 1, function (value, menu_name, prev_value, click_type)
            sel_ptfx_fun(value, menu_name, prev_value, click_type)
        end)

    menu.action(funfeatures, "传送到最近玩家", {}, "", function()
        tp_closest_player()
    end)
    tpnearcar_list = menu.list(funfeatures, "驾驶最近的载具", {}, "")
        menu.action(tpnearcar_list, "传送一次", {}, "", function()
            drive_closest_vehicle()
        end)
        menu.toggle(tpnearcar_list, "无限传送", {}, "按E传送", function(toggled)
            horn_tp(toggled)
        end)

    gridspawn = menu.list(funfeatures, "批量载具生成", {}, "")--oppressor2
        dofile(filesystem.scripts_dir() .."lib/SakuraScript/GridSpawn.lua")

    menu.toggle_loop(funfeatures, "蹦床", {}, "在水上蹦蹦乐", function()
        trampoline()
    end)
    menu.action(funfeatures, "火箭人", {}, "", function()
        Rocket_Man()
    end)
    menu.action(funfeatures, "黑人抬棺", {}, "", function ()
        blacks_coffins()
    end)
    menu.toggle_loop(funfeatures, "罪城的水", {}, "碰水就死", function()
        VicecityWater()
    end)
    menu.action(funfeatures, "堆叠行人", {}, "", function()
        stack_npc()
    end)

    bodyguardMenu = BodyguardMenu.new(funfeatures, "生成保镖", {})--NPC保镖
    bodyguard_heli_options = menu.list(funfeatures, "保镖直升机", {}, "")--直升机保镖
        menu.list_select(bodyguard_heli_options, "直升机类型", {}, "", sel_heli_name_list, 1,function(value, menu_name, prev_value, click_type)
            Bodyguard_helicopter(value, menu_name, prev_value, click_type)
        end)
        menu.toggle(bodyguard_heli_options, "直升机无敌", {}, "", function(toggle)
            Bodyguard_helicopter_invincible(toggle)
        end)
        menu.action(bodyguard_heli_options, "生成保镖直升机", {}, "", function()
            Spawn_bodyguard_helicopter()
        end)
        menu.action(bodyguard_heli_options, "删除所有保镖直升机", {}, "", function()
            delete_bodyguard_helicopter()
        end)

    menu.action(funfeatures, "天空岛", {}, "", function()
        create_object(1054678467, 0, 0, 500)
        PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), 0, 0, 503)
    end)

    flappygame = menu.list(funfeatures, "flappybird")
        require "lib.SakuraScript.flappybird"

    menu.toggle(funfeatures, "保护球", {}, "", function(on)
        Protect_ball(on)
    end)
    menu.action(funfeatures, "仓鼠球", {}, "", function()
        Hamster_Ball(PLAYER.PLAYER_ID())
    end)

    menu.toggle(funfeatures,"抛掷载具", {}, "在载具附近按E将载具抬起来,在按E将载具投掷出去.", function(toggled)
        throw_vehs(toggled)
    end)
    menu.toggle(funfeatures,"抛掷NPC", {}, "在NPC附近按E将NPC抬起来,在按E将NPC投掷出去.", function(toggled)
        throw_peds(toggled)
    end)

    Shooting_practice = menu.list(funfeatures, "射击馆")
        menu.divider(Shooting_practice,"射击训练场")
        create_lab = menu.action(Shooting_practice,"创建训练场", {}, "", function()
            load_lab()
        end)
        menu.action(Shooting_practice,"传送到训练场", {}, "", function()
            teleport_to_lab()
            clear_all_peds()
        end)
        menu.action(Shooting_practice,"结束训练", {}, "", function()
            Clean_training_ground()
        end)
        menu.divider(Shooting_practice,"射击类型")
        simple_3d = menu.list(Shooting_practice,"3D射击", {}, "")
            menu.divider(simple_3d,"3D射击")
            simple_3d_toggle = menu.toggle(simple_3d,"开始", {}, "", function(toggle)
                Shooting_simulation_3D(toggle)
            end)
            menu.divider(simple_3d,"游戏设置")
            menu.list_action(simple_3d,"设定状况", {}, "", ped_health_selector.display_options, function(index)
                Set_condition_3D(index)
            end)
            menu.list_action(simple_3d,"游戏时间", {}, "", time_selector.display_options, function(index)
                Set_shoot_time_3D(index)
            end)
            menu.list_action(simple_3d,"目标最大生成高度", {}, "", simple3d_target_max_height.display_options, function(index)
                Target_build_height_3D(index)
            end)
            menu.toggle(simple_3d, "允许PED移动", {}, "", function(toggle)
                target_move(toggle)
            end)

        simple_2d = Shooting_practice:list("2D射击", {}, "")
            menu.divider(simple_2d,"2D射击")
            simple_2d_toggle = menu.toggle(simple_2d,"开始", {}, "", function(toggle)
                Shooting_simulation_2D(toggle)
            end)
            menu.divider(simple_2d,"游戏设置")
            menu.list_action(simple_2d,"设定状况", {}, "", ped_health_selector.display_options, function(index)
                Set_condition_2D(index)
            end)
            menu.list_action(simple_2d,"游戏时间", {}, "", time_selector.display_options, function(index)
                Set_shoot_time_2D(index)
            end)

    green_soda = menu.list(funfeatures, "绿汽水")
        require "lib.SakuraScript.SprunkStop"

    menu.toggle(funfeatures, "灵魂出窍", {}, "", function(toggle)
        Out_body(toggle)
    end)
    menu.toggle_loop(funfeatures, "homer粒子", {}, "", function()
        homer_particle()
    end)
    menu.toggle(funfeatures, "火拳",{}, "",function(on)
        Fire_Fist(on)
    end)
    menu.toggle(funfeatures, "血拳",{}, "",function(on)
        Blood_Fist(on)
    end)
    menu.toggle(funfeatures, "雷电拳",{}, "",function(on)
        Raiden_Fist(on)
    end)

    Hell_Undead = menu.list(funfeatures, "地狱亡灵", {}, "")
        menu.toggle(Hell_Undead, "地狱亡灵", {}, "", function(on)
            if on then
                menu.trigger_commands("grace on")
                menu.set_value(Burning_Man, true)
                menu.set_value(runspeed, true)
                menu.set_value(superjump, true)
                menu.trigger_commands("trails on")
                menu.trigger_commands("trailcolourrainbow 1")
            else
                menu.set_value(Burning_Man, false)
                menu.set_value(runspeed, false)
                menu.set_value(superjump, false)
                menu.trigger_commands("trails off")
                menu.trigger_commands("trailcolourrainbow 0")
            end
        end)

        menu.divider(Hell_Undead,"设置")
            runspeed = menu.toggle(Hell_Undead, "奔跑速度", {}, "", function(on)
                if on then
                    menu.trigger_commands("walkspeed 1.5")
                    menu.trigger_commands("gracefullanding on")
                    menu.trigger_commands("superrun 1.2")
                else
                    menu.trigger_commands("walkspeed 1")
                    menu.trigger_commands("gracefullanding off")
                    menu.trigger_commands("superrun 0")
                end
            end)
            superjump = menu.toggle_loop(Hell_Undead, "亡灵跳跃", {}, "", function()
                if PAD.IS_CONTROL_PRESSED(1, 22) then
                    ENTITY.APPLY_FORCE_TO_ENTITY(PLAYER.PLAYER_PED_ID(), 1, 0.0, 0.0, 1.5, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
                end
            end)

    headlamp = menu.list(funfeatures, "头灯", {}, "仅本地可见")
        menu.toggle_loop(headlamp, "开启", {}, "", function()
            local head_pos = PED.GET_PED_BONE_COORDS(PLAYER.PLAYER_PED_ID(), 31086, 0.0, 0.0, 0.0)
            local cam_rot = players.get_cam_rot(PLAYER.PLAYER_ID())
            GRAPHICS1.DRAW_SPOT_LIGHT(head_pos, cam_rot:toDir(), math.floor(headlamp_color.r * 255), math.floor(headlamp_color.g * 255), math.floor(headlamp_color.b * 255), distance * 1.5, brightness, 0.0, radius, distance)
        end)
        distance = 25.0
        menu.slider_float(headlamp, "距离", {"distance"}, "光照距离.", 100, 10000, 1500, 100, function(value)
            distance = value / 100
        end)
        brightness = 10.0
        menu.slider_float(headlamp, "亮度", {"brightness"}, "光亮强度.", 100, 10000, 1000, 100, function(value)
            brightness = value / 100
        end)
        radius = 15.0
        menu.slider_float(headlamp, "半径", {"radius"}, "光束半径.", 100, 5000, 2000, 100, function(value)
            radius = value / 100
        end)
        headlamp_color = {r = 0, g = 1, b = 1, a = 0}
        menu.rainbow(menu.colour(headlamp, "颜色", {"colour"}, "", headlamp_color, true, function(value)
            headlamp_color = value 
        end))

    appearance = menu.list(funfeatures, "伪装")
        menu.toggle(appearance, "开始伪装", {}, "", function(state)
            player_disguise(state)
        end)
        menu.list_select(appearance, "伪装选择", {}, "", disguise_names, 1, function(value, menu_name, prev_value, click_type)
            player_disguise_select(value, menu_name, prev_value, click_type)
        end)

    ----黑洞
    black_hole_lt = menu.list(funfeatures, "黑洞", {}, "")
        menu.toggle_loop(black_hole_lt, "黑洞", {}, "", function()
            black_hole()
        end)
        menu.toggle_loop(black_hole_lt, "视觉帮助", {}, "绘制一个黑洞圈", function()
            show_balckhole()
        end)
        menu.list_select(black_hole_lt, "黑洞类型", {}, "", {{1,"吸引"}, {2,"排斥"}}, 1, function(value, menu_name, prev_value, click_type)
            black_hole_type(value, menu_name, prev_value, click_type)
        end)
        menu.slider(black_hole_lt, "设置黑洞强度", {}, "", 1, 100, 1, 1, function(a)
            black_hole_Sth(a)
        end)
        black_hole_coord = menu.list(black_hole_lt, "设定位置", {}, "")
            menu.action(black_hole_coord, "在自身处设置黑洞位置", {}, "", function()
                black_hole_posuser()
            end)
            blackHolePosX = menu.slider(black_hole_coord, "黑洞位置 X", {"coordBlackHoleX"}, "", -100000, 100000, 0, 1, function(a)
                black_hole_posx(a)
            end)
            blackHolePosY = menu.slider(black_hole_coord, "黑洞位置 Y", {"coordBlackHoleY"}, "", -100000, 100000, 0, 1, function(a)
                black_hole_posy(a)
            end)
            blackHolePosZ = menu.slider(black_hole_coord, "黑洞位置 Z", {"coordBlackHoleZ"}, "", -100000, 100000, 0, 1, function(a)
                black_hole_posz(a)
            end)

    menu.toggle_loop(funfeatures, "神指", {"godfinger"}, "按B使用", function()
        godfinger()
    end)

    --------NPC雨 
    menu.toggle_loop(funfeatures, "NPC雨", {}, "", function()
        Npc_Rain()
    end)
    menu.toggle_loop(funfeatures, "载具雨", {}, "", function()
        Vehicle_Rain()
    end)
    menu.toggle_loop(funfeatures, "陨落的飞机", {},"", function()
        start_angryplanes_thread()
    end)
    menu.toggle(funfeatures, "移除交通", {}, "对其它玩家生效", function(on)
        if on then
            pop_multiplier_id = MISC.ADD_POP_MULTIPLIER_SPHERE(1.1, 1.1, 1.1, 15000.0, 0, 0, false, true)
            MISC.CLEAR_AREA(1.1, 1.1, 1.1, 19999.9, true, false, false, true)
        else
            MISC.REMOVE_POP_MULTIPLIER_SPHERE(pop_multiplier_id, false);
        end
    end)
    menu.action(funfeatures,"生成多米诺骨牌", {}, "", function()
        local hash = util.joaat("prop_boogieboard_01")
        request_model(hash)
        local last_ent = PLAYER.PLAYER_PED_ID()
        for i= 2, 25 do 
            local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(last_ent, 0, i, 0)
            local d = entities.create_object(hash, c)
            ENTITY.SET_ENTITY_HEADING(d, ENTITY.GET_ENTITY_HEADING(last_ent))
            OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(d)
        end
    end)

    drop_soccer = menu.list(funfeatures, "足球", {}, "")
        menu.action(drop_soccer, "掉落足球", {}, "", function()
            ball_drop(players.get_position(PLAYER.PLAYER_ID()))
        end)
        menu.toggle_loop(drop_soccer, "混乱足球", {}, "", function()
            ball_drop(players.get_position(PLAYER.PLAYER_ID()))
            util.yield(250)
        end)
        menu.action(drop_soccer, "清理", {}, "Clean up your mess",function()
            delete_all_soccer()
        end)

    menu.action(funfeatures, "自定义假R*警告", {}, "", function()
        local label = util.register_label("输入自定义文本")
        local input = get_input_from_screen_keyboard(label, 254, "")
        if input == "" then return end 
        custom_alert(input)
    end)

    local explosion_circle_angle = 0
    menu.toggle_loop(funfeatures, "爆炸圈", {}, "在周围生成爆炸圈", function ()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        explosion_circle(ped, explosion_circle_angle, 25)
        explosion_circle_angle = explosion_circle_angle + 0.15
        util.yield(50)
    end)

    menu.toggle_loop(funfeatures, "UFO勇闯洛城", {}, "在你的周围随机生成UFO", function()
        UFO_Los_Angeles()
    end)

    menu.toggle(funfeatures, "洛城暴乱", {}, "开启后,周围的npc会进入无差别攻击模式!", function(toggle)
        MISC.SET_RIOT_MODE_ENABLED(toggle)
    end)

    ped_cats = menu.list(funfeatures, "宠物猫", {}, "")
        menu.toggle_loop(ped_cats, "宠物猫", {}, "招一只可爱的小猫咪\n跟着你喵喵叫!", function()
                if not cat_pedp or not ENTITY.DOES_ENTITY_EXIST(cat_pedp) then
                    local cathash = util.joaat("a_c_cat_01")
                    request_model(cathash)
                    local pos = players.get_position(PLAYER.PLAYER_ID())
                    cat_pedp = entities.create_ped(28, cathash, pos, 0)
                    PED.SET_PED_COMPONENT_VARIATION(cat_pedp, 0, 0, 1, 0)
                    ENTITY.SET_ENTITY_INVINCIBLE(cat_pedp, true)
                end
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(cat_pedp)
                TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(cat_pedp, PLAYER.PLAYER_PED_ID(), 0, -0.3, 0, 7.0, -1, 1.5, true)
                util.yield(2500)
            end, function()
                delete_entity(cat_pedp)
        end)
        menu.action(ped_cats, "找到猫猫", {}, "将猫猫传送到你身边", function()
                local player = PLAYER.PLAYER_PED_ID()
                local pos = ENTITY.GET_ENTITY_COORDS(player, false)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(cat_pedp, pos.x, pos.y, pos.z, false, false, false)
            end)

        local cat_army = {}
        local army = menu.list(ped_cats, "宠物猫猫军队", {}, "哈哈哈,一群小猫猫")
            menu.click_slider(army, "生成数量", {}, "选吧,多生成点,最多256只", 1, 256, 30, 1, function(val)
                local ped = PLAYER.PLAYER_PED_ID()
                local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
                pos.y = pos.y - 5
                pos.z = pos.z + 1
                local jinx = util.joaat("a_c_cat_01")
                request_model(jinx)
                for i = 1, val do
                    cat_army[i] = entities.create_ped(28, jinx, pos, 0)
                    ENTITY.SET_ENTITY_INVINCIBLE(cat_army[i], true)
                    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(cat_army[i], true)
                    PED.SET_PED_COMPONENT_VARIATION(cat_army[i], 0, 0, 1, 0)
                    TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(cat_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
                    util.yield()
                end 
            end)
            menu.action(army, "清除宠物猫", {}, "", function()
                for i, ped in ipairs(entities.get_all_peds_as_handles()) do
                    if PED.IS_PED_MODEL(ped, util.joaat("a_c_cat_01")) then
                        delete_entity(ped)
                    end
                end
            end)


    menu.toggle_loop(funfeatures, "激光眼", {}, "按住E键", function(on)
        laser_eyes()
    end)
    menu.toggle_loop(funfeatures, "镭射炮", {}, "", function()
        Laser_cannon()
    end)

    finger_thing = menu.list(funfeatures, "手指枪", {}, "按B键")
        shouzhiqiang()

    menu.toggle(funfeatures, "力场", {}, "", function(on)
        force_Field(on)
    end)

    force_field = menu.list(funfeatures, "力场Pro", {}, "")
        menu.toggle_loop(force_field, "开启", {}, "", function()
            force_Field_pro()
        end)
        menu.list_select(force_field, "力场方向", {}, "", s_forcefield_names, 1, function(value, menu_name, prev_value, click_type)
            force_Field_direction(value, menu_name, prev_value, click_type)
        end)
        menu.slider_float(force_field, "力场范围", {"sforcefieldrange"}, "", 100, 10000, 2000, 100, function(value)
            force_Field_range(value)
        end)
        menu.toggle_loop(force_field, "绘制力场范围", {}, "", function()
            Plot_force_field_range()
        end)











---------------玩家选项
players.on_join(function(pid)--玩家离开后列表存在,循环执行时判断玩家是否存在
    Player_list = menu.player_root(pid):getChildren()[1]:attachBefore(menu.shadow_root():list('Sakura选项'))
    --local Player_list = menu.list(menu.player_root(pid), "daidai脚本", {}, "")

    menu.divider(Player_list, "Sakura")
        menu.toggle(Player_list, "观看玩家", {}, "", function(toggled)
            spectator_mode(pid, toggled)
        end)
        menu.toggle(Player_list, '上帝视角', {}, '', function(toggled)
            god_cam(toggled, pid)
        end)
        menu.action(Player_list, "宣布玩家", {}, "公宣布玩家信息", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            chat.send_message("玩家"..PLAYER.GET_PLAYER_NAME(pid)..": "..
            "\nRID: "..players.get_rockstar_id(pid)..
            "\nPID: "..pid..
            "\nIP: "..intToIp(players.get_connect_ip(pid))..
            "\n主机令牌: "..players.get_host_token(pid)..
            "\n人物模型: "..int_to_uint(ENTITY.GET_ENTITY_MODEL(PLAYER.GET_PLAYER_PED(pid)))..
            "\n生命值: "..ENTITY.GET_ENTITY_HEALTH(PLAYER.GET_PLAYER_PED(pid)),false,true,true)
        end)

        menu.action(Player_list, "IP查询", {}, "", function()
            local IP = intToIp(players.get_connect_ip(pid))
            QueryIP(IP)
        end)
        menu.toggle_loop(Player_list, "自动传送到玩家", {}, "当与玩家的距离大于3时自动传送到玩家", function()
            local playerpos = players.get_position(pid)
            local mypos = players.get_position(PLAYER.PLAYER_ID())
            local distance = math.ceil(Get_distance(playerpos, mypos, true))
            if distance > 3 and PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                teleport(playerpos.x, playerpos.y, playerpos.z, true)
            end
        end)

    friendly = menu.list(Player_list, "友好选项", {}, "")
    trolling = menu.list(Player_list, "恶搞选项", {}, "")
    kickplayer = menu.list(Player_list, "踢出玩家", {}, "")
    crashplayer = menu.list(Player_list, "崩溃玩家", {}, "")


    ------友好选项
    menu.toggle(friendly, "幽灵模式", {}, "对他开启幽灵模式", function(toggled)
        NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid, toggled)
    end)
    menu.action(friendly, "降落到玩家", {}, "全自动跳伞", function()
        landing_on_player(pid)
    end)
    menu.toggle_loop(friendly, "反击敌人", {}, "炸掉杀死该玩家的凶手", function()
        retaliate_enemy(pid)
    end)
    menu.toggle_loop(friendly, "导航锁定", {}, "玩家移动时导航条会闪烁", function()
        set_waypoint(pid)
    end)
    menu.action(friendly, "保存玩家信息", {}, "Lua Scripts/daidaiScript/profiles", function()
        save_player_info(pid)
    end)
    menu.action(friendly, "掉落足球", {}, "", function()
        ball_drop(players.get_position(pid))
    end)
    menu.toggle_loop(friendly, "混乱足球", {}, "", function()
        ball_drop(players.get_position(pid))
        util.yield(250)
    end)
    menu.action(friendly, "传送到他的载具", {}, "", function()
        tp_p_car(pid)
    end)
    menu.action(friendly, "给予所有武器", {}, "", function()
        give_all_weapon(PLAYER.GET_PLAYER_PED(pid))
    end)

    safe_nuke = menu.toggle(friendly,"护送核弹车", {}, "将生成一辆装有核弹的卡车,当卡车爆炸时核弹也会爆炸,这样任何玩家都可以引爆核弹", function(on)
        escort_nuke(on,pid)
    end)
    menu.toggle_loop(friendly,"自动充能", {}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        if VEHICLE.IS_ROCKET_BOOST_ACTIVE(vehicle) then
            repeat
                util.yield()
            until not VEHICLE.IS_ROCKET_BOOST_ACTIVE(vehicle)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            VEHICLE.SET_ROCKET_BOOST_FILL(vehicle, 100.0)
        end
    end)
    menu.action(friendly, "送只猫", {}, "送一只猫一直跟着他", function()
        local ped = PLAYER.GET_PLAYER_PED(pid)
        local cathash = util.joaat("a_c_cat_01")
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        local cat_ped = create_ped(28, cathash, pos.x, pos.y, pos.z, 1)
        ENTITY.SET_ENTITY_INVINCIBLE(cat_ped, true)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(cat_ped, ped, 0, -0.3, 0, 7.0, -1, 1.5, true)
    end)
    menu.action(friendly, "复制服饰", {}, "", function()
        copy_outfit(pid)
    end)
    menu.action(friendly, "复制载具", {}, "靠近玩家或者观看玩家后再复制", function()
        copy_vehicle(pid)
    end)
    menu.toggle_loop(friendly, "自动给予脚本主机", {}, "", function()
        if players.get_script_host() ~= pid then
            menu.trigger_commands("givesh" .. players.get_name(pid))
        end
    end)
    menu.action(friendly,"给予载具", {}, "", function()
        give_vehicle(pid)
    end)
    menu.action(friendly,"升级载具", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(PLAYER.GET_PLAYER_PED(pid))
        request_control(vehicle)
        upgrade_vehicle(vehicle)
    end)
    green_soda_player = menu.list(friendly, "绿汽水", {}, "")
        menu.action(green_soda_player, "绿~汽水！", {}, "生成随机一辆绿载具和少数的汽水罐", function()
            local sprunk_vehicle = random_spawn_vehicles[math.random(1, #random_spawn_vehicles)]
            local vehicle = spawn_vehicle_for_player(pid, sprunk_vehicle.model)
            sprunkify_vehicle(vehicle)
            for i = 1,10,1 do
                sprunk_raindrop_vehicle(vehicle)
            end
        end)
        menu.action(green_soda_player, "喷上绿漆", {}, "把他的载具染成绿色!", function()
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
            request_control(vehicle)
            sprunkify_vehicle(vehicle)
        end)
        menu.action(green_soda_player, "汽水罐", {}, "在玩家附近掉落一罐汽水", function()
            sprunk_raindrop_player(pid)
        end)
        menu.toggle_loop(green_soda_player, "汽水暴雨", {}, "在玩家附近下起汽水暴雨", function()
            sprunk_raindrop_player(pid)
            util.yield(sodaconfig.can_rain_delay)
        end)
        menu.action(green_soda_player, "倾倒垃圾罐", {}, "", function()
            trash_dump_player(pid)
        end)

    menu.toggle_loop(friendly, "天降RP", {}, "RP天降,但延迟可调", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local coords = players.get_position(pid)
        coords.z = coords.z + 1.5
        local figure = MISC.GET_HASH_KEY("vw_prop_vw_colle_prbubble")
        request_model(figure)
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, figure, false, true)
        util.yield(150)
    end)
    menu.toggle_loop(friendly, "天降收集牌", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local coords = players.get_position(pid)
        coords.z = coords.z + 1.5
        local card = MISC.GET_HASH_KEY("vw_prop_vw_lux_card_01a")
        request_model(card)
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, card, false, true)
        util.yield(150)
    end)

----玩家恶搞选项
    kill_godmode = menu.list(trolling, "击杀玩家", {}, "")
    classic_trolling = menu.list(trolling, "经典恶搞", {}, "")
    lz = menu.list(trolling, "套笼子", {}, "")
    npc_trolling = menu.list(trolling, "NPC恶搞", {}, "")
    weapon_trolling = menu.list(trolling, "武器恶搞", {}, "")
    vehicle_car = menu.list(trolling, "载具恶搞", {}, "")
    tp_player_trolling = menu.list(trolling, "发送玩家", {}, "")


    ----击杀玩家
    menu.action(kill_godmode, "无人机投掷炸弹", {}, "", function()
        drone_drop(pid)
    end)
    menu.action(kill_godmode, "地图杀", {}, "", function()
        the_Map_Kill(pid)
    end)
    appmenu.Ultion.OrbitalCannon = menu.action(kill_godmode, "用天基炮杀死玩家", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        if not OrbitalCannon.exists() and PLAYER.IS_PLAYER_PLAYING(pid) then
            OrbitalCannon.create(pid)
        end
    end)
    menu.action(kill_godmode, "nigger爆炸", {}, "", function()
        niggers_bomb(pid)
    end)
    menu.action(kill_godmode, "鲨鱼吃掉玩家", {}, "", function()
        Shark_eating(pid)
    end)
    menu.action(kill_godmode, "集束炸弹", {}, "", function()
        cluster_bomb(pid)
    end)
    menu.action(kill_godmode, "砸死", {}, "", function()
        Smashdead_player(pid)
    end)
    menu.action(kill_godmode, "死亡屏障击杀", {}, "", function()
        Death_barrier(pid)
    end)
    menu.toggle_loop(kill_godmode,"移除玩家无敌", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        util.trigger_script_event(1 << pid, {0xAD36AA57, pid, 0x96EDB12F, math.random(0, 0x270F)})
    end)
    menu.action(kill_godmode, "杀死无敌玩家v1", {}, "普通击杀", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 99999, true, util.joaat("weapon_stungun"), PLAYER.PLAYER_PED_ID(), false, true, 1.0)
    end)
    menu.textslider(kill_godmode, "杀死无敌玩家v2", {}, "强制击杀", {"Khanjali", "APC"}, function(index, veh)
        Force_kill(index, veh, pid)
    end)   


    ----经典恶搞
    False_notification = menu.list(classic_trolling, "虚假通知", {}, "")
        menu.action(False_notification, "注册CEO", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, 514341487, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "注册VIP", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, 514341487, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "注册摩托帮", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, 514341487, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "隐藏标记点", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 1, -1496350145, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "激活幽灵组织", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 1, 688031806, 0, 0, 0, 7953752157564464705, 31084746152966761, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "被劫匪打劫", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, -1079941038, 10000, 0, 0, 0, 0, 0, 0, 2954937499648, 0, 0, 0})
        end)
        menu.action(False_notification, "劫匪被杀死", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, -578453253, 0, 0, 0, 0, 0, 0, 0, 2954937499648, 0, 0, 0})
        end)
        menu.action(False_notification, "袭击装甲运钞车", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, 1964206081, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "存入现金", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, 94410750, 10000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "窃取现金", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, -295926414, 10000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "移除现金", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, -242911964, 10000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "激活导弹锁定干扰器", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, -1957780196, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end)
        menu.action(False_notification, "取得车主证明文件", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, 1919354072, 0, 0, 0, 0, 0, 0, 0, pid, 0, 0, 0})
        end)
        menu.action(False_notification, "开启幽灵模式", {}, "", function()
            util.trigger_script_event(1 << pid, {Global_Base.Notification, 0, -1233120647, 0, 0, 0, 0, 0, 0, 0, pid, 0, 0, 0})
        end)

    menu.toggle_loop(classic_trolling, "循环爬楼梯", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local LadderHash = 1122863164 --3469023669
        local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local SpawnOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(pedm, 0, 2, 2.5)
        if not ENTITY.DOES_ENTITY_EXIST(staircas_loop) then
            staircas_loop = entities.create_object(LadderHash, SpawnOffset)
        end
        SpawnOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(pedm, 0, 2, 2.5)
        local Player_Rot = ENTITY.GET_ENTITY_ROTATION(pedm, 2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(staircas_loop, SpawnOffset.x, SpawnOffset.y, SpawnOffset.z, false, false, false)
        ENTITY.SET_ENTITY_ROTATION(staircas_loop, Player_Rot.x, Player_Rot.y, Player_Rot.z, 2, true)
        end, function()
        delete_entity(staircas_loop)
    end)
    menu.action(classic_trolling, "B-11攻击", {}, "", function()
        B11_attack(pid)
    end)
    menu.action(classic_trolling, "发送神风炮", {}, "", function()
        Send_Kamikaze_Gun(pid)
    end)
    menu.action(classic_trolling, "派遣警车", {}, "", function()
        spawn_police_car(pid)
	end)
    menu.action(classic_trolling, "仓鼠球", {}, "", function()
        Hamster_Ball(pid)
    end)
    menu.action(classic_trolling, "粉碎机", {}, "", function()
        shredder(pid)
    end)
    menu.toggle(classic_trolling, "升天电梯", {}, "", function(on)
        biker_lift(on,pid)
    end)
    menu.toggle_loop(classic_trolling, "载具武器锁定玩家", {}, "载具导弹自动瞄准玩家", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_dist = v3.distance(players.get_position(PLAYER.PLAYER_ID()), players.get_position(pid))
        if not PED.IS_PED_DEAD_OR_DYING(ped) and PAD.IS_CONTROL_PRESSED(0, 25) and ped_dist < 300.0 then
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
            VEHICLE1.SET_VEHICLE_SHOOT_AT_TARGET(PLAYER.PLAYER_PED_ID(), ped, pos.x, pos.y, pos.z)
        end
    end)
    p_eff_troll = menu.list(classic_trolling, "粒子效果轰炸", {}, "")
        menu.toggle_loop(p_eff_troll, '开启', {}, '', function ()
            p_eff_bomb(pid)
        end)
        menu.list_select(p_eff_troll, '设置粒子效果', {}, '发送您选择的粒子效果', Fxcore.name, 1, function (value, menu_name, prev_value, click_type)
            sel_p_eff_bomb(value, menu_name, prev_value, click_type)
        end)

    menu.action(classic_trolling,"金钱掉落", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local pos = players.get_position(pid)
        local objHash = util.joaat("prop_cash_pile_01")
        request_model(objHash)
        local pickupHash = 4263048111
        local pickup = OBJECT.CREATE_PICKUP(pickupHash, pos.x, pos.y, pos.z + 1, 1, 100, false, objHash)
        util.yield(100)
    end)
    menu.toggle_loop(classic_trolling, '掉落假钱袋', {}, '', function ()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid),false)
        local obj = create_object(MISC.GET_HASH_KEY("p_poly_bag_01_s"), pos.x, pos.y, pos.z + 1.5)
        ENTITY.APPLY_FORCE_TO_ENTITY(obj, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, true, true, true)
        util.yield(50)
    end)
    menu.action(classic_trolling, "公寓邀请通知", {}, "", function() --https://github.com/4d72526f626f74/MrRobot/blob/3186d22dbcf5093f72e8a8a6a479bf37e858e616/MrRobot/utils/shared#L459
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        util.trigger_script_event(1 << pid, {996099702, 0, 0})
    end)
    menu.toggle_loop(classic_trolling,"烟雾屏幕", {}, "让黑色烟雾布满他们的屏幕.", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_as_trans")
            GRAPHICS.USE_PARTICLE_FX_ASSET("scr_as_trans")
            if ptfx == nil or not GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(ptfx) then
                ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("scr_as_trans_smoke", ped, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, false, false, false, 0, 0, 0, 255)
            end
        end, function()
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            GRAPHICS.REMOVE_PARTICLE_FX(ptfx)
            STREAMING.REMOVE_NAMED_PTFX_ASSET("scr_as_trans")
    end)
    menu.action(classic_trolling, "消防栓大喷水", {}, "", function()
        firefighting(pid)
    end)
    menu.action(classic_trolling, "强制打开降落伞", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        PED.FORCE_PED_TO_OPEN_PARACHUTE(PLAYER.GET_PLAYER_PED(pid))
    end)

    trolly_Vehicles = menu.list(classic_trolling, "恶搞载具", {}, "")
        menu.textslider(trolly_Vehicles, "发送恶搞载具", {}, "", {"Bandito", "Go-Kart"}, function (index, opt)
            send_veh_attack(opt, index, pid)
        end)
        menu.toggle(trolly_Vehicles, "设置无敌", {}, "",function(toggle) 
            send_veh_attack_god(toggle)
        end)
        menu.action(trolly_Vehicles, "派武装匪徒", {}, "", function()
            send_veh_attacker(pid)
        end)
        menu.textslider_stateful(trolly_Vehicles, "武装匪徒武器", {}, "", {util.get_label_text("BAND_BOMB"), util.get_label_text("TOP_MINE")}, function (index, value)
            send_veh_attacker_weapon(index, value)
        end)
        mineSlider = menu.textslider_stateful(trolly_Vehicles, "地雷", {}, "", {util.get_label_text("KINET_MINE"), util.get_label_text("EMP_MINE")}, function (index, value)
            send_veh_attacker_weapon_mine(index, value)
        end)
        menu.slider(trolly_Vehicles, "数量", {}, "", 1, 10, 1, 1, function(value)
            send_veh_attacker_number(value)
        end)
        menu.action(trolly_Vehicles, "删除", {}, "", function()
            dele_all_veh_attacker()
        end)
    enemyVehiclesOpt = menu.list(classic_trolling, "敌对载具", {}, "")
        menu.textslider(enemyVehiclesOpt, "生成敌对载具", {}, "", enemy_options, function(index, option)
            send_enemy_veh(index, option, pid)
        end)
        menu.list_select(enemyVehiclesOpt, "迷你坦克武器", {}, "", gunnerWeaponNames, 1, function(value, menu_name, prev_value, click_type)
            mini_tank_weapon(value, menu_name, prev_value, click_type)
        end)
        menu.list_select(enemyVehiclesOpt, "枪手的武器", {}, "", enemVehOptions, 1, function(value, menu_name, prev_value, click_type)
            enemy_gunman_weapon(value, menu_name, prev_value, click_type)
        end)
        menu.slider(enemyVehiclesOpt, "生成数量", {}, "",1, 10, 1, 1, function (value)
            set_enemy_count(value)
        end)
        menu.toggle(enemyVehiclesOpt, "无敌", {}, "",function(toggle)
            set_enemy_Godmode(toggle)
        end)
        menu.action(enemyVehiclesOpt, "删除", {}, "", function()
            delete_enemy_veh()
        end)

    menu.toggle_loop(classic_trolling, "摇晃镜头", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(pid) and PLAYER.GET_PLAYER_PED(pid) ~= 0 then
            local pos = players.get_position(pid)
            FIRE.ADD_OWNED_EXPLOSION(PLAYER.GET_PLAYER_PED(pid), pos.x, pos.y, pos.z, 0, 0.0, false, true, 80.0)
            util.yield(150)
        end
    end)
    menu.action(classic_trolling, "清除任务", {}, "可将玩家踢出载具", function ()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local pedp = PLAYER.GET_PLAYER_PED(pid)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(pedp)
    end)
    menu.action(classic_trolling, "炸鱼", {}, "", function ()
        fried_fish(pid)
    end)
    menu.action(classic_trolling,"泰坦号轰炸", {}, "", function()
        Titan_bombing(pid)
    end)
    menu.toggle_loop(classic_trolling, "渲染粒子", {}, "", function()
        Render_particles(pid)
    end)

    tp_entity = menu.list(classic_trolling, "传送实体", {}, "")
        menu.toggle_loop(tp_entity, "传送所有PED给玩家", {}, "", function ()
            TpAllPeds(pid)
        end)
        menu.toggle_loop(tp_entity, "传送所有载具给玩家", {}, "", function ()
            TpAllVehs(pid)
        end)
        menu.toggle_loop(tp_entity, "传送所有物体给玩家", {}, "", function ()
            TpAllObjects(pid)
        end)

    menu.action(classic_trolling, "生成怪兽军队", {}, "",function()
        Create_Monster_Army(pid)
    end)

    glitch_player = menu.list(classic_trolling, "鬼畜玩家", {}, "")
        menu.list_select(glitch_player, "物体", {}, "选择鬼畜玩家使用的物体.", object_stuff.names, 1, function(value, menu_name, prev_value, click_type)
            obj_creat(value, menu_name, prev_value, click_type)
        end)
        menu.slider(glitch_player, "物体生成延迟", {"spawndelay"}, "", 0, 3000, 150, 10, function(amount)
            obj_creat_speed(amount)
        end)
        glitchplayer = menu.toggle_loop(glitch_player,"鬼畜玩家", {}, "", function()
            Ghost_Beast_Player(pid)
        end)

    menu.action(classic_trolling, "核弹1", {}, "", function()
        nuclear_bomb_player(pid)
    end)
    menu.action(classic_trolling, "核弹2", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local hash = util.joaat("prop_military_pickup_01")
        request_model(hash)
        local pos = players.get_position(pid)
        local nuke = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos.x, pos.y, pos.z + 20, true, false, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(nuke, 3, 0.0, 0.0, -50, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
        ENTITY.SET_ENTITY_HAS_GRAVITY(nuke, true)
        while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(nuke) and not ENTITY.IS_ENTITY_IN_WATER(nuke) do
            util.yield(0)
        end
        local nukePos = ENTITY.GET_ENTITY_COORDS(nuke, true)
        delete_entity(nuke)
        create_nuke_explosion(nukePos)
    end)
    bountyplayer = menu.list(classic_trolling, "给予悬赏", {}, "")
        local bounty_amount = 10000
        menu.action(bountyplayer,"悬赏",{},"",function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local name = PLAYER.GET_PLAYER_NAME(pid)
            menu.trigger_commands("bounty"..name.." "..bounty_amount)
        end)
        bountyplayer:slider("悬赏金额",{"Bountyamountplayer"},"",1,10000,10000,1000,function(amount)
            bounty_amount = amount
        end)
    menu.action(classic_trolling,  "踢出室内", {}, "强制将玩家踢出室内.", function()
        Kick_room(pid)
    end)
    menu.toggle(classic_trolling, "撒尿", {}, "随地大小便应该遭到谴责", function(on)
        peeloop_player(pid,on)
    end)
    menu.toggle(classic_trolling, "骑乘玩家1", {}, "仅本地有效", function(on)
        ride_player1(pid,on)
    end)
    menu.toggle(classic_trolling, "骑乘玩家2", {}, "仅本地有效", function(on)
        ride_player2(pid,on)
    end)
    menu.action(classic_trolling, "UFO引力", {}, "使用UFO将它们拉起一秒钟", function()
        UFO_gravitation(pid)
    end)


    ----武器恶搞
        menu.action(weapon_trolling,"移除玩家武器", {}, "", function()
            remove_all_weapon(PLAYER.GET_PLAYER_PED(pid))
        end)
        menu.toggle_loop(weapon_trolling, "重型狙击枪攻击", {}, "", function()
            Heavy_gun_to_player(pid)
        end)
        menu.toggle_loop(weapon_trolling, "烟花攻击", {"Fireworksdownward"}, "", function()
            firework_to_player(pid)
        end)
        menu.toggle_loop(weapon_trolling, "原子波攻击", {}, "", function()
            atom_waves_to_player(pid)
        end)
        menu.toggle_loop(weapon_trolling, "燃烧弹攻击", {}, "", function()
            Incendiary_to_player(pid)
        end)
        menu.toggle_loop(weapon_trolling, "电磁脉冲攻击", {}, "", function()
            ElectroMagnetic_Pulse_to_player(pid)
        end)
        menu.toggle_loop(weapon_trolling, "电击玩家", {}, "对自己无效", function()
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 0.1, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_stungun"), PLAYER.PLAYER_PED_ID(), true, false, 2000.0)
            util.yield(1000)
        end)

        menu.toggle_loop(trolling, "强制画面向前", {}, "可移除部分菜单无敌", function()--Update tag(1.69)
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            util.trigger_script_event(1 << pid, {800157557, PLAYER.PLAYER_ID(), 225624744, math.random(0, 9999)})
        end)
    menu.toggle_loop(trolling, "烟花发射玩家", {}, "", function()
        firework_send_player(pid)
    end)
    fire_work_show = menu.list(trolling, "烟火秀", {}, "")
        local firw = {speed = 1000}
        menu.toggle_loop(fire_work_show, '头顶烟火', {}, '开始一场烟火秀', function ()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
            local weap = util.joaat('weapon_firework')
            WEAPON.REQUEST_WEAPON_ASSET(weap)
            for y = 0, 1 do
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(10, 15), 200, 0, weap, 0, false, false, firw.speed)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 4.0, tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(10, 15), 200, 0, weap, 0, false, false, firw.speed)
                FIRE.ADD_EXPLOSION(tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(50, 75), 38, 1, false, false, 0, false)
                FIRE.ADD_EXPLOSION(tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(50, 75), 38, 1, false, false, 0, false) 
            end
        end)
        menu.toggle_loop(fire_work_show, '脚下烟火', {}, '', function ()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
            local weap = util.joaat('weapon_firework')
            WEAPON.REQUEST_WEAPON_ASSET(weap)
            for y = 0, 1 do
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + -1.0, tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(10, 15), 200, 0, weap, 0, false, false, firw.speed)
                --MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 2.0, tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(10, 15), 200, 0, weap, 0, false, false, firw.speed)
                FIRE.ADD_EXPLOSION(tar1.x + math.random(-100, 100), tar1.y + math.random(-100, 100), tar1.z + math.random(50, 75), 38, 1, false, false, 0, false)
                FIRE.ADD_EXPLOSION(tar1.x - math.random(-100, 100), tar1.y - math.random(-100, 100), tar1.z + math.random(50, 75), 38, 1, false, false, 0, false) 
            end
        end)
    menu.toggle_loop(trolling, '假钱雨', {}, '', function ()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        request_ptfx_asset('core')
        --GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( 'ent_brk_banknotes', tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 3.0, true, true, true)
        if not players.exists(pid) then
            util.stop_thread()
        end
    end)

    ------笼子
    ped_cage_lt = menu.list(lz, "Ped笼子", {}, "")
        menu.toggle_loop(ped_cage_lt, '开启', {}, '将玩家困在Ped笼子里', function ()
            auto_ped_cage(pid)
        end)
        menu.list_select(ped_cage_lt,"选择Ped笼子", {}, "", pedset_cage.name, 1, function (value, menu_name, prev_value, click_type)
            select_ped_cage(value, menu_name, prev_value, click_type)
        end)
    obj_cage_lt = menu.list(lz, "物体笼子", {}, "")
        menu.toggle_loop(obj_cage_lt, '开启', {}, '将玩家困在物体笼子里', function ()
            auto_obj_cage(pid)
        end)
        menu.list_select(obj_cage_lt,"选择物体笼子", {}, "", objsetcage.name, 1, function (value, menu_name, prev_value, click_type)
            select_obj_cage(value, menu_name, prev_value, click_type)
        end)
    menu.action(lz, "试验升降机", {}, "", function()
        test_elevator(pid)
    end)
    menu.action(lz, "监狱笼子", {}, "", function()
        Prison_cages(pid)
    end)
    menu.action(lz, "柱形笼", {}, "", function()
        pillar_cage(pid)
    end)
    menu.action(lz, "栅栏", {}, "", function()
        fence_cage(pid)
    end)
    menu.action(lz, "地狱笼子", {}, "", function()
        hell_cage(pid)
    end)
    menu.list_action(lz, "移动笼子", {}, "", kidnap_types, function(index, value)
        kidnapplayer(pid, index, value)
    end)
    menu.action(lz, "缆车笼子", {}, "", function()
        tramway_cage(pid)
    end)
    menu.action(lz, "小桶笼子", {}, "", function()
        Kegs_cage(pid)
    end)
    menu.action(lz, "电击笼子", {}, "", function()
        Shock_cage(pid)
    end)
    menu.action(lz, "集装箱笼子", {}, "", function()
        Container_cage(pid)
    end)
    menu.action(lz, "隐形笼子", {}, "", function()
        Vehicle_cage(pid)
    end)
    menu.action(lz, "树木笼子", {}, "", function()
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        spam_entity_on_player(target_ped, -37176073)
    end)
    menu.action(lz, "关门放狗", {}, "", function()
        Close_dog(pid)
    end)
    menu.action(lz, "恐怖之牢", {}, "听说半夜能吓死人", function()
        Terror_Prison(pid)
    end)
    menu.action(lz, "普通笼子", {}, "", function ()
        ptlz(pid)
    end)
    menu.action(lz, "小的竞技管", {}, "", function()
        Small_athletics(pid)
    end)
    menu.action(lz, "竖向货机笼子", {}, "", function()
        Vertical_freighter_cage(pid)
    end)
    menu.action(lz, "横行货机笼子", {}, "", function()
        Rampage_plane_cage(pid)
    end)
    menu.action(lz, "支柱笼子", {}, "", function ()
        rub_cage(pid)
    end)
    menu.toggle_loop(lz, "全自动笼子", {}, "每一秒套一次", function ()
        rub_cage(pid)
        util.yield(1000)
    end)
    menu.action(lz, "英国女王笼子", {}, "", function(cl)
        gueencage(pid)
    end)
    menu.action(lz, "燃气笼", {}, "", function()
        gascage(pid)
    end)
    menu.action(lz, "七度空间", {}, "", function ()
        qdkj(pid)
    end)
    menu.action(lz, "钱笼子", {}, "", function ()
        zdlz(pid)
    end)
    menu.action(lz, "垃圾箱", {}, "", function ()
        yylz(pid)
    end)
    menu.action(lz, "小车车", {}, "", function ()
        cclz(pid)
    end)
    menu.action(lz, "圣诞树", {}, "", function ()
        sdkl1(pid)
    end)
    menu.action(lz, "圣诞快乐pro", {}, "", function ()
        sdkl2(pid)
    end)
    menu.action(lz, "圣诞快乐promax", {}, "", function ()
        sdkl3(pid)
    end)
    menu.action(lz, "竞技管", {}, "", function ()
        jjglz(pid)
    end)

    ----------NPC恶搞
    menu.action(npc_trolling, "派只雪怪", {}, "", function()
        send_snow_monster(pid)
    end)
    menu.textslider(npc_trolling, "NPC电击玩家", {}, "", {"电击枪", "电击棒"}, function (index)
        send_ped_stun(pid, index)
    end)
    menu.action(npc_trolling, "消防车攻击", {}, "消防车对着玩家一直洒水", function()
        Firetruck_attack(pid)
    end)
    menu.list_action(npc_trolling, "NPC在玩家面前自杀", {}, "在玩家面前生成一个自杀的ped", traumatize.name, function(index)
        npc_suicide(index,pid)
    end)
    menu.toggle_loop(npc_trolling, "敌对行人", {}, "周围的npc干他", function()
        Enemy_NPCS(pid)
    end)
    menu.action(npc_trolling, "NPC杀", {}, "", function()
        NPC_kill(pid)
    end)
    menu.action(npc_trolling, "派遣劫匪", {}, "", function()--Update tag(1.68)
        sendmugger_npc(pid)
    end)
    menu.action(npc_trolling, "苦力怕小丑(MC里的爬行者)", {}, "", function()
        creep(pid)
    end)
    menu.action(npc_trolling, "发送崔佛", {}, "派崔佛去撞他们或碾压他们", function()
        send_Angry_Trevor(pid)
    end)

    attackers_root = menu.list(npc_trolling, "攻击者", {}, "")
        menu.action(attackers_root, "狗子攻击者", {}, "arf uwu", function()
            send_attacker(-1788665315, pid)
        end)
        menu.action(attackers_root, "丧尸攻击者", {}, "rawr", function()
            send_attacker(-1404353274, pid)
        end)
        menu.action(attackers_root, "布拉德攻击者", {}, "恐怖的\n没有下体", function()
            send_attacker(util.joaat("CS_BradCadaver"), pid)
        end)
        menu.action(attackers_root, "悲伤的耶稣", {}, "产生一个不可战胜的耶稣和一个轨道枪,将不断攻击玩家,即使他们死后。如果他们太远,传送到他们。这有时会非常容易出错,但通常是由于网络", function()
            dispatch_griefer_jesus(pid)
        end)
        menu.action(attackers_root, "天煞战斗机", {}, "", function()
            Celestial_Fighter(pid)
        end)
        menu.action(attackers_root, "A10轰炸机", {}, "", function()
            send_aircraft_attacker(1692272545, -163714847, pid)
        end)
        menu.action(attackers_root, "派货机", {}, "", function()
            send_aircraft_attacker(util.joaat("cargoplane"), -163714847, pid)
        end)

    create_garbage_entities = menu.list(trolling, "生成实体", {}, "")
        attach_entity_obj = {"-1268267712","148511758"}
        menu.action(create_garbage_entities, "生成UFO", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local pos = players.get_position(pid)
            local hash = -1268267712
            for i = 1,30 do
                local dust = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, pos.x+math.random(0, 5), pos.y+math.random(0, 5), pos.z+math.random(0, 5), true, false, false)
                FIRE.ADD_EXPLOSION(pos.x+math.random(0, 5), pos.y+math.random(0, 5), pos.z+math.random(0, 5), 4, 100, true, false, 1, false)
                util.yield(100)
            end
        end)
        menu.textslider(create_garbage_entities, "冰淇凌盛宴", {}, "在他们面前生成一个类似冰淇凌的实体", ice_entity.name, function (index)
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local obj = ice_entity.value[index]
            local container_hash = util.joaat(obj)
            local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 4, 0)--偏移量坐标,前后,左右,上下
            entities.create_object(container_hash, v3(pos.x, pos.y, pos.z - 1))
        end)
        menu.action(create_garbage_entities, "生成竞技场", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local coords = players.get_position(pid)
            local hash = util.joaat("xs_terrain_set_dystopian_06")
            request_model(hash)
            local dust = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z']-4, true, false, false)
            ENTITY.FREEZE_ENTITY_POSITION(dust, true)
        end)
        menu.action(create_garbage_entities, "生成黄土高坡", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local coords = players.get_position(pid)
            local hash = util.joaat("xs_terrain_dyst_ground_07")
            request_model(hash)
            local dust = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z']-36, true, false, false)
            local hash2 = util.joaat("apa_prop_flag_brazil")
            request_model(hash2)
            local flag = OBJECT.CREATE_OBJECT_NO_OFFSET(hash2, coords['x'], coords['y'], coords['z'], true, false, false)
            ENTITY.FREEZE_ENTITY_POSITION(dust, true)
        end)
        menu.list_action(create_garbage_entities, "生成小实体", {},"", {{1,"斜坡"}, {2,"路障"}, {3,"风车"},{4,"卫星"}}, function (index)
            create_small_entities(pid, index)
        end)
        menu.action(create_garbage_entities, "肿瘤", {}, "", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, 148511758)
        end)
        menu.action(create_garbage_entities, "肿瘤2", {}, "", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, -26957549)
        end)
        menu.action(create_garbage_entities, "肿瘤3", {}, "", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, 1467574459)
        end)
        menu.action(create_garbage_entities, "树木", {}, "", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, -37176073)
        end)
        menu.action(create_garbage_entities, "交通锥", {}, "生成交通锥", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, 3760607069)
        end)
        menu.action(create_garbage_entities, "假鸡巴", {}, "给爷冲", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, 3872089630)
        end)
        menu.action(create_garbage_entities, "热狗", {}, "", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, 2565741261)
        end)
        menu.action(create_garbage_entities, "热狗摊", {}, "", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, 2713464726)
        end)
        menu.action(create_garbage_entities, "摩天轮", {}, "", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, 3291218330)
        end)
        menu.action(create_garbage_entities, "过山车", {}, "欢乐时光", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, 3413442113)
        end)
        menu.action(create_garbage_entities, "空中雷达", {}, "让他们旋转", function()
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            spam_entity_on_player(target_ped, 2306058344)
        end)

    pteleportEntities = menu.list(trolling, "发送垃圾", {}, "给他生成一推垃圾玩意")
        menu.action(pteleportEntities, "NPC", {}, "", function ()
            TpAllPeds(pid)
        end)
        menu.action(pteleportEntities, "载具", {}, "", function ()
            TpAllVehs(pid)
        end)
        menu.action(pteleportEntities, "实体", {}, "", function ()
            TpAllObjects(pid)
        end)
        menu.action(pteleportEntities, "拾取物", {}, "", function ()
            TpAllPickups(pid)
        end)

    menu.action(trolling, "送进监狱", {}, "将此玩家传送到博林布鲁克监狱", function()
        --[[ local car = PED.GET_VEHICLE_PED_IS_USING(PLAYER.GET_PLAYER_PED(pid), true)
        if car ~= 0 then
            request_control(car)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(car, 1628.5234, 2570.5613, 45.56485, false, false, false)
        else
            --MCTeleport
            util.trigger_script_event(1 << pid, {1103127469, PLAYER.PLAYER_ID(), 1, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1})
            util.yield(2000)
            request_control(PED.GET_VEHICLE_PED_IS_USING(PLAYER.GET_PLAYER_PED(pid), true))
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PED.GET_VEHICLE_PED_IS_USING(PLAYER.GET_PLAYER_PED(pid), true), 1628.5234, 2570.5613, 45.56485, false, false, false)
        end ]]
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local my_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        local my_ped = PLAYER.PLAYER_PED_ID()
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my_ped, 1628.5234, 2570.5613, 45.56485, true, false, false, false)
        menu.trigger_commands("givesh " .. players.get_name(pid))
        menu.trigger_commands("summon " .. players.get_name(pid))
        menu.trigger_commands("invisibility on")
        menu.trigger_commands("otr")
        util.yield(5000)
        menu.trigger_commands("invisibility off")
        menu.trigger_commands("otr")
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my_ped, my_pos.x, my_pos.y, my_pos.z)
    end)

    menu.action(trolling, "喷射", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)
        request_ptfx_asset("core_snow")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core_snow")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("cs_mich1_spade_dirt_throw", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false, 0, 0, 0, 0) 
    end)
    menu.toggle_loop(trolling, "范围删除", {}, "将玩家附近的模型删除", function()
        Scope_deletion(pid)
    end)
    menu.toggle_loop(trolling,"弹飞玩家", {}, "也适用于载具", function()
        Bounce_Flying_Player(pid)
    end)

    -------玩家载具恶搞
    kick_car = menu.list(vehicle_car, "踢出载具", {}, "")
        menu.action(kick_car, "踢出载具v1", {}, "踢出当前载具所有人\n且当前载具不能再上", function()
            kickcar(pid)
        end)
        menu.action(kick_car, "踢出载具v2", {}, "脚本踢出", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            util.trigger_script_event(1 << pid, {Global_Base.VehicleKick})
        end)
        menu.action(kick_car, "踢出载具v3", {}, "从载具里踢出玩家", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            menu.trigger_commands("vehkick".. players.get_name(pid))
        end)
    menu.action(vehicle_car, "载具地刺", {}, "在载具前方生成尖刺带", function()
        veh_prickle(pid)
    end)
    menu.toggle_loop(vehicle_car, "载具沥青", {}, "使玩家载具打滑", function()
        Vehicle_asphalt(pid)
    end)
    menu.action(vehicle_car, "屠杀载具", {}, "", function()
        massacre_vehicle(pid)
    end)
    menu.action(vehicle_car, "漂移轮胎", {}, "车辆漂移", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
        VEHICLE.SET_DRIFT_TYRES(vehicle, true)
    end)
    menu.action(vehicle_car, "劫持载具", {}, "生成一个劫匪NPC,把他们从车里扔出来,锁上车,然后开走。(注意:在高ping的玩家身上也可能不一致)", function()
        hijacking_vehicles(pid)
    end)
    menu.list_action(vehicle_car,"载具附加", {}, "", veh_attach_options, function(index)
        vehicle_attach(index,pid)
    end)
    menu.toggle(vehicle_car, "儿童锁", {}, "", function(on)
        Child_Lock(on,pid)
    end)
    menu.toggle_loop(vehicle_car, "敌对交通", {}, "使附近NPC载具恶意撞击玩家载具", function()
        Hostile_traffic(pid)
    end)
    menu.action(vehicle_car, "变成恐龙", {}, "", function()
        changemodel(pid)
    end)
    menu.action(vehicle_car, "给载具套笼子", {}, "", function()
        longzi_veh(pid)
    end)
    menu.action(vehicle_car, "放置墙壁", {}, "在玩家前面放置墙壁,半秒后删除", function ()
        Place_wall(pid)
    end)
    
    menu.list_action(vehicle_car, "在车内生成NPC", {}, "用附近的行人填充玩家的车", full_with_options, function(index, value, click_type)
        npcfillthecar(pid, index,value)
    end)
    menu.list_action(vehicle_car, "拖车", {}, "将他们的车拖走", {{1,"从前面"}, {2,"从后面"}}, function(index, value, click_type)
        towcarpro(pid, index, value)
    end)

    menu.action(vehicle_car, "移除车门", {}, "", function ()
        remove_doors(pid)
    end)
    menu.action(vehicle_car, "分离载具零件", {}, "", function()
        detach_vehicle_parts(pid)
    end)
    menu.textslider(vehicle_car, "生成普通坡道", {}, "", ramps_names, function(ramps)
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local ramp = ramps_hashes[ramps]
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0, 5, 0)
        local heading = ENTITY.GET_ENTITY_HEADING(vehicle)
        local ramp_obj = create_object(ramp, pos.x, pos.y, pos.z-0.8)
        ENTITY.SET_ENTITY_HEADING(ramp_obj, heading)
        ENTITY.FREEZE_ENTITY_POSITION(ramp_obj, true)
    end)
    menu.textslider(vehicle_car, "生成竞技坡道", {}, "", ramps_names1, function(ramps)
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local ramp = ramps_hashes[ramps+3]
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(pid), false)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0, 30, 0)
        local heading = ENTITY.GET_ENTITY_HEADING(vehicle)
        local ramp_obj = create_object(ramp, pos.x, pos.y, pos.z-0.8)
        ENTITY.SET_ENTITY_HEADING(ramp_obj, heading+90)
        ENTITY.FREEZE_ENTITY_POSITION(ramp_obj, true)
    end)

    menu.toggle_loop(vehicle_car, "载具爆炸", {}, "爆炸目标进入的任何车辆", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local playerVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
        if PED.IS_PED_IN_VEHICLE(playerPed, playerVehicle, false) then 
            if ENTITY.IS_ENTITY_DEAD(playerPed, false) == false then
                local coords = players.get_position(pid)
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 100, true, false, 1, false)
            end
        end
    end)

    acrobatics = menu.list(vehicle_car, "车辆跳跃", {}, "")
        menu.action(acrobatics, "豚跳", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local vehicle = get_vehicle_player_is_in(pid)
            if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
            request_control(vehicle, 1000) then
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
            end
        end)
        menu.action(acrobatics, "左侧空翻", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local vehicle = get_vehicle_player_is_in(pid)
            if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
            request_control(vehicle, 1000) then
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, 5.0, 0.0, 0.0, 1, false, true, true, true, true)
            end
        end)
        menu.action(acrobatics, "双左侧空翻", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local vehicle = get_vehicle_player_is_in(pid)
            if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
            request_control(vehicle, 1000) then
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 21.43, 20.0, 0.0, 0.0, 1, false, true, true, true, true)
            end
        end)
        menu.action(acrobatics, "右侧空翻", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local vehicle = get_vehicle_player_is_in(pid)
            if ENTITY.DOES_ENTITY_EXIST(vehicle) and VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) and
            request_control(vehicle, 1000) then
                ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, -5.0, 0.0, 0.0, 1, false, true, true, true, true)
            end
        end)

    set_license_plates = menu.list(vehicle_car, "设置车牌", {}, "")
        menu.action(set_license_plates, "将车牌设置为Sakura", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
            if car ~= 0 then
                request_control(car)
                VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(car, "Sakura")
            end
        end)
        menu.action(set_license_plates, "将车牌设置为i am SB", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
            if car ~= 0 then
                request_control(car)
                VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(car, "i am SB")
            end
        end)

    menu.toggle(vehicle_car, "手刹", {}, "", function(on)
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control(car)
            VEHICLE.SET_VEHICLE_HANDBRAKE(car, on)
        end
    end)
    menu.toggle_loop(vehicle_car, "随机制动", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        if car ~= 0 then
            request_control(car)
            VEHICLE.SET_VEHICLE_HANDBRAKE(car, true)
            util.yield(1000)
            request_control(car)
            VEHICLE.SET_VEHICLE_HANDBRAKE(car, false)
            util.yield(math.random(3000, 15000))
        end
    end)
    menu.toggle_loop(vehicle_car, "冻结", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
        ENTITY.SET_ENTITY_MAX_SPEED(car, 0)
    end)

    menu.toggle_loop(vehicle_car, "移除载具无敌", {}, "", function()
        if players.exists(pid) then
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if PED.IS_PED_IN_ANY_VEHICLE(ped, false) and not PED.IS_PED_DEAD_OR_DYING(ped) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
                ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
                ENTITY.SET_ENTITY_PROOFS(veh, false, false, false, false, false, 0, 0, false)
            end
        end
    end)

    menu.action(trolling, "外星人爆炸", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        local ufo = util.joaat("sum_prop_dufocore_01a")
        request_model(ufo)
        menu.trigger_commands("freeze".. players.get_name(pid).. " on")
        c.z = c.z + 10
        local spawnedufo = entities.create_object(ufo, c)
        util.yield(2000)
        local c2 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        FIRE.ADD_EXPLOSION(c2.x, c2.y, c2.z, 1, 100.0, true, false, 3.0, false)
        util.yield(1000)
        delete_entity(spawnedufo)
        menu.trigger_commands("freeze".. players.get_name(pid).. " off")
    end)

    menu.action(vehicle_car, "删除载具", {}, "删除此玩家正在驾驶的载具", function()
        deleplayercar(pid)
    end)
    menu.toggle_loop(vehicle_car, "禁用载具", {}, "当玩家打开车门时删除载具", function()
        disable_vehicle(pid)
    end)
    menu.toggle(vehicle_car, "禁用驾驶", {}, "", function(toggled)
        disable_drive(toggled, pid)
    end)
    menu.toggle_loop(vehicle_car, "喇叭加速", {}, "当他们按喇叭时,推动汽车前进.", function() 
        horn_boost(pid)
    end)
    menu.toggle_loop(vehicle_car, "喇叭跳跳车", {}, "", function()
        car_jump(pid)
    end)
    menu.action(vehicle_car, "修复载具", {}, "给他们修车.", function() 
        repair_vehicle(pid)
    end)
    menu.action(vehicle_car, "爆胎", {}, "", function ()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        menu.trigger_commands("poptires".. players.get_name(pid))
    end)
    menu.action(vehicle_car, "摧毁螺旋桨", {}, "使螺旋桨失效", function ()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        menu.trigger_commands("destroyprop".. players.get_name(pid))
    end)
    menu.action(vehicle_car, "引擎控制", {}, "如果他们的发动机打开,它就会关闭,反之亦然.", function() 
        toggle_player_vehicle_engine(pid) 
    end)
    menu.action(vehicle_car, "摧毁引擎", {}, "让他们的引擎起火.", function() 
        break_player_vehicle_engine(pid) 
    end)
    menu.action(vehicle_car, "向前推进", {}, "大力推动车辆前进.", function() 
        boost_player_vehicle_forward(pid) 
    end)
    menu.action(vehicle_car, "弹飞载具", {}, "", function() 
        launch_up_player_vehicle(pid) 
    end)
    menu.action(vehicle_car, "停止车辆", {}, "", function() 
        stop_player_vehicle(pid) 
    end) 
    menu.action(vehicle_car, "倒置车辆", {}, "", function() 
        flip_player_vehicle(pid) 
    end)
    menu.action(vehicle_car, "车辆翻转180度", {}, "", function()
        turn_player_vehicle(pid)
    end)

    menu.toggle_loop(trolling, "爆炸圈", {}, "在他周围生成爆炸圈", function ()
        explosion_range(pid)
    end)

    menu.action(trolling, "爆炸", {}, "", function ()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        menu.trigger_commands("explode".. players.get_name(pid))
    end)
    menu.toggle_loop(trolling, '循环爆炸', {''}, '', function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        menu.trigger_commands("explode".. players.get_name(pid))
    end)
    menu.toggle_loop(trolling, "无损伤爆炸", {"tossplayers"}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 1, 1, true, false, 0, true)
    end)
    menu.toggle_loop(trolling, "原子弹轰炸", {}, "", function()
        orbital(pid)
    end)         
    menu.toggle_loop(trolling,"火箭雨", {}, '', function()
        rain_rockets(pid)
    end)
    menu.toggle_loop(trolling,"子弹雨", {}, '', function()
        rain_bullet(pid)
    end)
    menu.toggle_loop(trolling, "火箭撞击", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local coords = players.get_position(pid)
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x, coords.y, coords.z+10, coords.x, coords.y, coords.z, 1, true, -1312131151, playerPed, true, false, 50)
        util.yield(1500)
    end)
    menu.textslider(trolling, "神风敢死队", {}, "", {"天煞", "天行巨兽",  "古邦800"}, function (index)
        kamikaze_dare(index,pid)
    end)
    menu.textslider(trolling, "撞击玩家", {}, "", {"叛乱", "幻影楔形",  "蝰蛇"}, function (index)
        Impact_player(index,pid)
    end)

    menu.toggle_loop(trolling, "粒子轰炸", {}, "", function ()
        if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), false)
            request_ptfx_asset("scr_sm_counter")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD('scr_sm_counter_chaff', pos.x, pos.y, pos.z, 0, 0, 0, 1.0, false, false, false, false)
        end
    end)

    mrplaym = menu.list(trolling, '在玩家身上下雨', {}, '')
        mirloop =  menu.toggle_loop(mrplaym, '类型:雪球', {}, '启用下雨', function ()
            Rain_on_players(pid)
        end)
        menu.list_action(mrplaym, '类型', {''}, '更改在玩家身上下雨的类型', Weaplist, function(weapsel, text)
            Rain_on_players_type(weapsel, text)
        end)

    menu.action(vehicle_car, "加速带", {}, "在他们面前产生车辆加速带", function() 
        jiasudian(pid)
    end)
    menu.action(vehicle_car, "减速带", {}, "在他们面前产生车辆减速带", function() 
        jiansudai(pid)
    end)


    vehicle_impact = menu.list(trolling, "载具压倒", {}, "")
        menu.action(vehicle_impact, "小丑车", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
            coords.x = coords['x']
            coords.y = coords['y']
            coords.z = coords['z'] + 20.0
            request_model(util.joaat("speedo2"))
            local truck = entities.create_vehicle(util.joaat("speedo2"), coords, 0.0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
            ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
            util.yield(700)
            delete_entity(truck)
        end)
        menu.action(vehicle_impact, "隐形车", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
            coords.x = coords['x']
            coords.y = coords['y']
            coords.z = coords['z'] + 20.0
            request_model(1917016601)
            local truck = entities.create_vehicle(1917016601, coords, 0.0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
            ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
            ENTITY.SET_ENTITY_VISIBLE(truck, false, 0)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
            util.yield(2000)
            delete_entity(truck)
        end)
        menu.action(vehicle_impact, "直接压倒", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
            coords.x = coords['x']
            coords.y = coords['y']
            coords.z = coords['z'] + 20.0
            request_model(util.joaat("faggio2"))
            local truck = entities.create_vehicle(util.joaat("faggio2"), coords, 0.0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
            ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
            ENTITY.SET_ENTITY_VISIBLE(truck, false, 0)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
            util.yield(2000)
            delete_entity(truck)
        end)
        menu.action(vehicle_impact, "大卡车", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
            coords.x = coords['x']
            coords.y = coords['y']
            coords.z = coords['z'] + 20.0
            request_model(1917016601)
            local truck = entities.create_vehicle(1917016601, coords, 0.0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
            ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -100.0)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
            util.yield(700)
            delete_entity(truck)
        end)
        menu.action(vehicle_impact, "小绵羊", {}, "", function()
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
            coords.x = coords['x']
            coords.y = coords['y']
            coords.z = coords['z'] + 20.0
            request_model(util.joaat("faggio2"))
            local truck = entities.create_vehicle(util.joaat("faggio2"), coords, 0.0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(vel)
            ENTITY.SET_ENTITY_VELOCITY(truck, vel['x'], vel['y'], -200.0)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(truck, 3)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(truck, true)
            util.yield(700)
            delete_entity(truck)
        end)

    player_veh_teleport = menu.list(vehicle_car, "传送载具", {}, "")
        menu.action(player_veh_teleport, "传送载具到我", {}, "传送玩家最后一个载具\n或当前乘坐的载具", function()
            tp_player_car_to_coords(pid, ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true))
        end)
        menu.action(player_veh_teleport, "传送载具到导航点", {}, "传送玩家最后一个载具\n或当前乘坐的载具", function()
            tp_player_car_to_point(pid)
        end)
        menu.action(player_veh_teleport, "传送到地下", {}, "", function()
            tp_player_car_to_underground(pid)
        end)
        menu.action(player_veh_teleport, "传送载具到花园银行停机坪", {}, "传送玩家最后一个载具\n或当前乘坐的载具", function()
            tp_player_car_to_coords(pid, tp_playerveh_coord.maze)
        end)
        menu.action(player_veh_teleport, "传送载具到深海底", {}, "传送玩家最后一个载具\n或当前乘坐的载具", function()
            tp_player_car_to_coords(pid, tp_playerveh_coord.underwater)
        end)
        menu.action(player_veh_teleport, "传送载具到高空", {}, "传送玩家最后一个载具\n或当前乘坐的载具", function()
            tp_player_car_to_coords(pid, tp_playerveh_coord.highair)
        end)
        menu.action(player_veh_teleport, "传送载具到洛圣都改车王", {}, "传送玩家最后一个载具\n或当前乘坐的载具", function()
            tp_player_car_to_coords(pid, tp_playerveh_coord.lsc)
        end)
        menu.action(player_veh_teleport, "传送载具到监狱SCP-173单元", {}, "传送玩家最后一个载具\n或当前乘坐的载具", function()
            tp_player_car_to_coords(pid, tp_playerveh_coord.scp)
        end)
        menu.action(player_veh_teleport, "传送载具到大牢房中", {}, "传送玩家最后一个载具\n或当前乘坐的载具", function()
            tp_player_car_to_coords(pid, tp_playerveh_coord.cell)
        end)

    menu.toggle_loop(vehicle_car, "随机升级", {}, "玩家必须有乘坐过的载具", function(state)
        randomupdatcar(pid)
    end)
    menu.action(vehicle_car, "电磁脉冲炸弹", {}, "", function(on)
        caremp(pid)
    end)
    menu.toggle_loop(vehicle_car, "快乐的小陀螺", {}, "", function(on)
        carspin(pid)
    end)
    glitchVehCmd = menu.toggle(vehicle_car, "鬼畜载具", {}, "", function(toggle)
        Demon_veh(pid,toggle)
    end)

    ------续接
    menu.toggle_loop(trolling, "冻结玩家", {}, "", function()
        if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED(pid))
        end
    end)
    menu.toggle_loop(trolling, "黑屏", {}, "", function()--Update tag(1.69)
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local handle = NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid)
        util.trigger_script_event(1 << pid, {-1604421397, players.user(), 1, 4, handle, handle, handle, handle, 1, 1})
        util.yield(10000)
    end)
    menu.toggle_loop(trolling, "推动玩家", {}, "", function()
        Driving_Player(pid)  
    end)

    menu.action(trolling, "小行星攻击", {}, "用小行星来攻击他", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local hash = 3751297495
        request_model(hash)
        local coords = players.get_position(pid)
        coords.z = coords['z'] + 15.0
        local asteroid = entities.create_object(3751297495, coords)
        ENTITY.SET_ENTITY_DYNAMIC(asteroid, true)
    end)
    menu.toggle_loop(trolling, "向Ta发送垃圾邮件", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        menu.trigger_commands("commendfriendly".. PLAYER.GET_PLAYER_NAME(pid))
        util.yield(250)
    end)

--发送玩家
    menu.action(tp_player_trolling, "发送到赌场动画", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        util.trigger_script_event( 1 << pid, {-1951335381, 0, 0})
    end)
    menu.action(tp_player_trolling, "发送到GTA5介绍界面", {}, "", function()--Update tag(1.69)
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local int = memory.read_int(memory.script_global(1887305 + 1 + (pid * 610) + 512)) --Global_1886967[PLAYER::PLAYER_ID() /*609*/].f_511;
        util.trigger_script_event(1 << pid, {-366707054, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    menu.action(tp_player_trolling, "发送到高尔夫", {}, "派遣玩家去打高尔夫.", function()--Update tag(1.69)
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local int = memory.read_int(memory.script_global(1887305 + 1 + (pid * 610) + 512))
        util.trigger_script_event(1 << pid, {-366707054, players.user(), 193, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    menu.action(tp_player_trolling, "发送到飞镖", {}, "派遣玩家去玩飞镖", function()--Update tag(1.69)
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local int = memory.read_int(memory.script_global(1887305 + 1 + (pid * 610) + 512))
        util.trigger_script_event(1 << pid, {-366707054, players.user(), 192, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    menu.action(tp_player_trolling, "强制1V1", {}, "", function()--Update tag(1.69)
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local int = memory.read_int(memory.script_global(1887305 + 1 + (pid * 610) + 512))
        util.trigger_script_event(1 << pid, {-366707054, players.user(), 197, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    menu.action(tp_player_trolling, "强制进入自由模式任务", {}, "强制玩家进入自由模式任务", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        menu.trigger_commands("mission".. players.get_name(pid))
    end)

--NPC恶搞
    menu.action(npc_trolling, "猫猫炸弹", {}, "", function()
        cat_bomb(pid)
    end)
    menu.action(npc_trolling, "墨西哥乐队", {}, "", function()
        dispatch_mariachi(pid)
    end)
    menu.action(npc_trolling, "克隆玩家", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local new_clone = PED.CLONE_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true, false, true)
    end)
    
    menu.list_action(npc_trolling, "发送妓女", {}, "", custom_hooker_options, function(index)
        send_hooker(index, pid)
    end)

    menu.toggle_loop(trolling, "切碎", {}, "", function()
        Finely_chopped(pid)
    end)

    menu.toggle_loop(trolling, "玩偶循环", {}, "目标会保持", function()
        if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local coords = players.get_position(pid)
            coords.z = coords['z'] - 2.0
            FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 0, true)
            util.yield(10)
        end
    end)
    menu.toggle_loop(trolling, "烟雾掉帧", {}, "", function()
        fumes(pid)
    end)
        
    menu.toggle_loop(trolling, "将附近载具吸到他身上",{}, "", function()
        if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local p_c = players.get_position(pid)
            for _, v in pairs(entities.get_all_vehicles_as_handles()) do 
                if not PED.IS_PED_A_PLAYER(VEHICLE.GET_PED_IN_VEHICLE_SEAT(v, -1, false)) then 
                    local v_c = ENTITY.GET_ENTITY_COORDS(v)
                    local c = {}
                    c.x = (p_c.x - v_c.x)*2
                    c.y = (p_c.y - v_c.y )*2
                    c.z = (p_c.z - v_c.z)*2
                    ENTITY.APPLY_FORCE_TO_ENTITY(v, 1, c.x, c.y, c.z, 0, 0, 0, 0, false, false, true, false, false)
                end
            end
        end
    end)  

    firepillar = menu.list(trolling, "火柱", {}, "")
        menu.toggle_loop(firepillar, "循环喷火v1", {"flameloop"}, "火焰攻击！！！", function()
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
                local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
                FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 12, 100.0, true, false, 0.0)
            end
        end)
        menu.toggle_loop(firepillar, "循环喷火v2", {}, "火焰攻击！！！", function()
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
                local coords = players.get_position(pid)
                coords.z = coords['z'] - 2.0
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 12, 1, true, false, 0, false)
                util.yield(25)
            end
        end)
    waterpillar = menu.list(trolling, "水柱", {}, "")
        menu.toggle_loop(waterpillar, "循环喷水1", {}, "水柱攻击！！！", function()
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
                local coords = players.get_position(pid)
                coords.z = coords['z'] - 2.0
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 13, 1, true, false, 0, false)
                util.yield(25)
            end
        end)
        menu.toggle_loop(waterpillar, "循环喷水2", {"waterloop"}, "水柱攻击！！！", function()
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
                local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
                FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 13, 100.0, true, false, 0.0)
            end
        end)

    menu.toggle_loop(trolling, "追踪", {}, "地下有痕迹", function()
        if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local coords = players.get_position(pid)
            coords.z = coords['z'] + 1.5
            FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 35, 0, false, false, 0, false)
            util.yield(65)
        end
    end)
    menu.toggle_loop(trolling, "让他走路带火", {}, "跑起来吧！！!", function()
        if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local coords = players.get_position(pid)
            FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 38, 0, false, false, 0, false)
            util.yield(65)
        end
    end)
    menu.toggle_loop(trolling, "在他头上浇水", {}, "", function()
        if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
            if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
            local coords = players.get_position(pid)
            coords.z = coords['z'] + 1
            util.yield(65)
            FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 79, 0, false, false, 0, false)
        end
    end)
    menu.action(trolling, "发射玩家", {"launch"}, "适用于大多数菜单.", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        local mdl = util.joaat("boxville3")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        request_model(mdl)   
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast(players.get_name(pid) .. " 在载具中. :/")
            return 
        end
        boxville = entities.create_vehicle(mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
        ENTITY.SET_ENTITY_VISIBLE(boxville, false)
        util.yield(250)
        repeat
            if v3.distance(players.get_position(pid), ENTITY.GET_ENTITY_COORDS(boxville)) < 10.0 then
                if boxville ~= 0 and ENTITY.DOES_ENTITY_EXIST(boxville)then
                    ENTITY.APPLY_FORCE_TO_ENTITY(boxville, 1, 0.0, 0.0, 25.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                end
                util.yield()
            else
                delete_entity(boxville)
            end
            util.yield()
            pos = ENTITY.GET_ENTITY_COORDS(ped)
        until pos.z > 10000.0
        util.yield(100)
        if boxville ~= 0 and ENTITY.DOES_ENTITY_EXIST(boxville) then 
            delete_entity(boxville)
        end
    end)
    local sounds = menu.list(trolling, "声音恶搞", {}, "")
        menu.toggle_loop(sounds, "让他听到循环爆炸死亡声音", {}, "吵死了", function()
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
                local coords = players.get_position(pid)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "BED", coords.x, coords.y, coords.z, "WASTEDSOUNDS", true, 5, false)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Crash", coords.x, coords.y, coords.z, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 5, false)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "BASE_JUMP_PASSED", coords.x, coords.y, coords.z, "HUD_AWARDS", true, 5, false)
                util.yield(20)
            end
        end)
        menu.toggle_loop(sounds, "循环死亡的声音", {}, "", function()
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
                local coords = players.get_position(pid)
                AUDIO.PLAY_SOUND_FROM_COORD(1, "BED", coords.x, coords.y, coords.z, "WASTEDSOUNDS", true, 5, false)
                util.yield(5800)
            end
        end)
        menu.toggle_loop(sounds, "循环游艇声音", {}, "", function()
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
                local coords = players.get_position(pid)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Horn", coords.x, coords.y, coords.z, "DLC_Apt_Yacht_Ambient_Soundset", true, 5, false)
                util.yield(3000)
            end
        end)
        menu.toggle_loop(sounds, "嗡嗡声", {}, "", function()
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
                local coords = players.get_position(pid)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Crash", coords.x, coords.y, coords.z, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, 5, false)
                util.yield(1700)
            end
        end)
        menu.toggle_loop(sounds, "任务成功声音", {}, "", function()
            if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
                if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
                local coords = players.get_position(pid)
                AUDIO.PLAY_SOUND_FROM_COORD(1, "BASE_JUMP_PASSED", coords.x, coords.y, coords.z, "HUD_AWARDS", true, 5, false)
                util.yield(1250)
            end
        end)

    ----踢出玩家
    menu.action(kickplayer, "智能踢", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        util.trigger_script_event(1 << pid, {0xB9BA4D30, pid, 0x4, -1, 1, 1, 1})
        util.trigger_script_event(1 << pid, {0x6A16C7F, pid, memory.script_global(0x2908D3 + 1 + (pid * 0x1C5) + 0x13E + 0x7)})
        util.trigger_script_event(1 << pid, {0x63D4BFB1, PLAYER.PLAYER_ID(), memory.read_int(memory.script_global(0x1CE15F + 1 + (pid * 0x257) + 0x1FE))})
        menu.trigger_commands("kick" .. players.get_name(pid))
    end)
    menu.action(kickplayer, "阻止加入踢", {}, "将该玩家踢出后加入到stand阻止加入的列表中.", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        menu.trigger_commands("historyblock " .. players.get_name(pid))
        menu.trigger_commands("kick" .. players.get_name(pid))
    end)
    menu.action(kickplayer, "主机踢", {}, "", function()
        if is_UltimateUser(pid) and pid ~= PLAYER.PLAYER_ID() then util.toast(BlockAttackUltimateUser) return end
        NETWORK.NETWORK_SESSION_KICK_PLAYER(pid)
    end)

    -----崩溃玩家

    menu.action(crashplayer,"新火车崩", {},"",function()
        local hash = 0x06C3F072
        local hash1 = 0x781A3CF8      
        request_model(hash)
        change_model(PLAYER.PLAYER_ID(), hash)

        util.yield(500)
        request_model(hash1)
        change_model(PLAYER.PLAYER_ID(), hash1)

    end)

    menu.action(crashplayer,"新火车崩", {},"",function()
        new_train_crash(pid)
    end)
    menu.action(crashplayer,"无效直升机崩溃", {},"",function()
        Invalid_heli_protect(pid)
    end)
    menu.action(crashplayer, "火车崩溃", {}, "", function()
        train_crash(pid)
    end)
    menu.action(crashplayer, "动画崩溃", {}, "", function()
        anim_dict_crash(pid)
    end)
    menu.action(crashplayer, "动画崩溃2", {}, "", function()
        anim_dict_crash2(pid)
    end)
    menu.action(crashplayer, "无效爆炸", {}, "", function()
        Invalid_explosion(pid)
    end)
    menu.action(crashplayer, "任务载具崩溃", {}, "", function()
        task_veh_crash(pid)
    end)
    menu.action(crashplayer, "无效实体崩溃", {}, "一定要远离", function()
        Invalid_entcrash(pid)
    end)
    menu.action(crashplayer, "道具草崩溃", {}, "", function()
        prop_grass(pid)
    end)
    menu.action(crashplayer, "PED崩溃", {}, "", function()
        PED_crash(pid)
    end)
    menu.action(crashplayer, "无效绳索崩溃", {}, "", function()
        Invalid_rope(pid)
    end)
    menu.action(crashplayer, "新鬼崩", {}, "", function()
        new_guibeng(pid)
    end)
    menu.action(crashplayer, "鬼崩", {}, "", function()
        guibeng(pid)
    end)
    menu.action(crashplayer, "XF崩溃", {}, "", function()
        XF_crash(pid)
    end)
    menu.action(crashplayer, "布尔值崩溃", {}, "", function()
        boolean_crash(pid)
    end)
    menu.toggle_loop(crashplayer, "无效载具崩溃", {}, "", function ()
        Invalid_vehicle_crashes(pid)
    end)
    menu.action(crashplayer, "XP终结者", {}, "", function()
        xp_over(pid)
    end)
    menu.action(crashplayer, "AIO崩", {}, "", function()
        aaaio(pid)
    end)
    menu.action(crashplayer, "OX崩", {}, "", function()
        OXcrashgg(pid)
    end)
    menu.action(crashplayer, "北域崩溃", {}, "", function()
        Northern_crash(pid)
    end)
    menu.action(crashplayer, "回弹崩溃", {}, "", function()
        Rebound_crash(pid)
    end)
    menu.action(crashplayer, "黄昏崩溃", {}, "", function()
        nightfull_crash(pid)
    end)
    menu.action(crashplayer, "Inshallah crash", {}, "", function()
        Inshallah_crash(pid)
    end)
    menu.action(crashplayer, "碎片崩溃", {}, "", function()
        v1_frag(pid)
    end)
    menu.action(crashplayer, "大自然崩溃", {}, "", function()
        naturecrashv1(pid)
    end)
    menu.action(crashplayer, "悲伤的耶稣崩溃", {}, "", function()
        Jesus_crash(pid)
    end)
    menu.action(crashplayer, "崩溃v3", {}, "", function()
        Memoir(pid)
    end)


menu.action(Player_list, "玩家自检", {}, "检测玩家是否触发作弊者检测", function() 
    is_player_modder(pid) 
end)

end)--玩家选项end
----------------


-----保护选项(防护选项)
clear_list = menu.list(protection, "清除选项", {}, "")
    menu.textslider(clear_list,"清理实体", {}, "", {"PED","载具","物体","拾取物","绳索","投掷物","相机"}, function(val)
        clean_select_entities(val)
    end)
    menu.action(clear_list, "普通清除", {}, "只清除PED和载具", function()
        Normal_clearance()
    end)
    menu.action(clear_list, "超级清除", {}, "清除所有", function()
        super_clear()
    end)
    menu.toggle_loop(clear_list, "循环清理实体", {}, "", function()
        loop_clear_entity()
    end)

menu.action(protection, "分离元素", {}, "分离所有附加元素", function()
    detach_all_entities()
end)
menu.action(protection, "恢复形态", {}, "恢复玩家正常状态,姿势等", function()
    TASK.CLEAR_PED_TASKS(PLAYER.PLAYER_PED_ID())
    TASK.CLEAR_PED_SECONDARY_TASK(PLAYER.PLAYER_PED_ID()) --次要
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
    ENTITY.DETACH_ENTITY(PLAYER.PLAYER_PED_ID(), false, false)
    ENTITY.SET_ENTITY_COLLISION(PLAYER.PLAYER_PED_ID(), true, true)
    ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
end)
menu.action(protection, "恢复相机", {}, "恢复相机正常状态", function()
    NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, PLAYER.PLAYER_PED_ID())
	HUD.SET_MINIMAP_IN_SPECTATOR_MODE(false, PLAYER.PLAYER_PED_ID())
    STREAMING.SET_RESTORE_FOCUS_ENTITY(PLAYER.PLAYER_PED_ID())
    CAM.RENDER_SCRIPT_CAMS(false, true, 100, true, true, 0)
end)
    
deathlog_lt = menu.list(protection,'死亡日志', {}, '记录谁杀了你')
    menu.toggle_loop(deathlog_lt,'开启', {}, '', function ()
        death_log()
    end)
    menu.action(deathlog_lt,'打开文件夹', {}, '', function ()
        open_dea_log()
    end)
    menu.action(deathlog_lt,'清除日志', {}, '', function ()
        clear_dea_log()
    end)

menu.toggle(protection, "防崩视角", {}, "", function(toggled)
    anti_crash_cam(toggled)
end)
disable_world_limit = menu.toggle_loop(protection,'禁用世界限制', {}, '[配置]\n防止越过世界限制而触发死亡', function ()
    PLAYER.EXTEND_WORLD_BOUNDARY_FOR_PLAYER(-9000.0, -11000.0, 30.0)
	PLAYER.EXTEND_WORLD_BOUNDARY_FOR_PLAYER(10000.0, 12000.0, 30.0)
end);set_menu_value(disable_world_limit, luaConfig.disable_world_limit, false);appmenu.Ultion.BlockWorldLimit = disable_world_limit

menu.toggle(protection, "阻止锁定", {}, "阻止玩家用拳头或瞄准辅助等锁定你", function(toggled)
	PED.SET_PED_CAN_BE_TARGETTED(PLAYER.PLAYER_PED_ID(), not toggled)
end)
menu.toggle_loop(protection, "禁止镜头抖动", {}, "", function()
    block_cam_shake()
end)

local vehprotex = menu.list(protection, "载具保护", {}, "")
    menu.toggle_loop(vehprotex, "禁用拖出", {}, "防止被PED拉出车外", function()
        if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then 
            for k, ped in pairs(entities.get_all_peds_as_handles()) do
                PED.SET_PED_CONFIG_FLAG(ped, 342, true)
            end
        end
    end)
    local mk2protex = menu.list(vehprotex, "MK-2拦截", {}, "")
        menu.toggle_loop(mk2protex, "开启报应", {},"自动处理附近mk2用户载具",function()
            oppKarma()
        end)
        menu.toggle(mk2protex, "目标朋友", {},"这也将针对你的朋友.",function(on)
            set_mk2_friend(on)
        end)
        menu.toggle(mk2protex, "目标你自己", {},"这也将针对你自己.",function(on)
            set_mk2_self(on)
        end)
        menu.list_select(mk2protex, "报应方式", {}, "选择一种方式",optionsMK2Karma, 1, function(value)
            set_mk2_select(value)
        end)

-------事件保护
event_protex_list = menu.list(protection, "事件保护", {}, ""); appmenu.Ultion.EventProtexList = event_protex_list
    menu.action(event_protex_list, "清除火焰效果", {}, "", function()
        blockfireeffect()
    end)
    menu.toggle_loop(event_protex_list, "拦截粒子效果", {}, "", function()
        blockcrasheffect()
    end)
    menu.toggle(event_protex_list, "防止爆头", {}, "", function(toggled)
        PED.SET_PED_SUFFERS_CRITICAL_HITS(PLAYER.PLAYER_PED_ID(), not toggled)
    end)
    menu.toggle(event_protex_list, "阻止电击", {}, "阻止电击​​伤害", function(toggled)
        PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 461, toggled)
    end)

    auto_kick_adBot = menu.toggle(protection, "自动踢出广告机", {}, "[配置]\n当你是主机时自动踢出广告机/事件检测玩家", function(on)
        kick_adBot = on
    end);set_menu_value(auto_kick_adBot, luaConfig.auto_kick_adBot, false)

    ridicule_list = menu.list(event_protex_list, "攻击嘲讽", {}, "")
        menu.action(ridicule_list, "修改内容", {}, "", function()
            change_ridicule()
        end)
        menu.toggle_loop(ridicule_list, "攻击嘲讽", {}, "在同一战局只会对同一玩家触发一次", function()
            Attack_ridicule()
        end)

	menu.action(event_protex_list, "强制停止所有声音", {}, "", function()
		for i=-1,100 do
			AUDIO.STOP_SOUND(i)
			AUDIO.RELEASE_SOUND_ID(i)
		end
	end)
    menu.action(event_protex_list, "移除黑屏", {}, "", function()
        CAM.DO_SCREEN_FADE_IN(0)
        CAM.RENDER_SCRIPT_CAMS(false, true, 100, true, true, 0)
        PLAYER.SET_PLAYER_CONTROL(PLAYER.PLAYER_ID(), true, 0)
        ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), false)
        MISC.FORCE_GAME_STATE_PLAYING()
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        HUD.DISPLAY_RADAR(true)
        HUD.DISPLAY_HUD(true)
	end)

    menu.toggle_loop(event_protex_list, "阻止附加模型", {}, "分离所有附加到当前载具的模型", function()
        Block_attached_models()
    end)

    pool_limiter = menu.list(event_protex_list, "自动节流器", {}, "")
        menu.toggle_loop(pool_limiter, "启用节流器", {}, "", function()
            entity_limit()
        end)
        menu.slider(pool_limiter, "Ped池", {"pedslimit"}, "默认为175", 0, 256, 100, 1, function(amount)
            ped_limit = amount
        end)
        menu.slider(pool_limiter, "载具池", {"vehlimit"}, "默认为127", 0, 300, 180, 1, function(amount)
            veh_limit = amount
        end)
        menu.slider(pool_limiter, "物体池", {"objlimit"}, "默认为500", 0, 2300, 500, 1, function(amount)
            obj_limit = amount
        end)

    r_admin = menu.list(event_protex_list, "R*管理人员加入反应", {}, "")
        menu.toggle_loop(r_admin, "R*管理人员加入提示", {}, "", function()
            if NETWORK.NETWORK_IS_SESSION_STARTED() then
                for _, pid in players.list(false, true, true) do 
                    if players.is_marked_as_admin(pid) then 
                        util.toast("检测到管理员加入哦！")
                    end    
                end
            end
        end)
        menu.toggle_loop(r_admin, "R*管理人员加入反应", {}, "当管理员加入时自动加入新战局", function()
            if NETWORK.NETWORK_IS_SESSION_STARTED() then
                for _, pid in players.list(false, true, true) do 
                    if players.is_marked_as_admin(pid) then 
                        util.toast("检测到管理员!5秒后加入新战局!")
                        util.yield(5000)
                        menu.trigger_commands("go public")
                    end    
                end
            end
        end)

    menu.toggle_loop(event_protex_list, "阻止掉落拾取物", {}, "", function()
        for k, pickup in pairs(entities.get_all_pickups_as_handles()) do
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pickup, false, false)
            delete_entity(pickup)
            util.yield(1)
        end
    end)
    menu.toggle_loop(event_protex_list, "禁用阻止实体轰炸", {}, "将在任务中自动禁用阻止实体轰炸,防止任务卡关.", function()
        local EntitySpam = menu.ref_by_path("Online>Protections>Block Entity Spam>Block Entity Spam")
        if NETWORK.NETWORK_IS_ACTIVITY_SESSION() == true then
            if not menu.get_value(EntitySpam) then return end
            menu.trigger_command(EntitySpam, "off")
        else
            if menu.get_value(EntitySpam) then return end
            menu.trigger_command(EntitySpam, "on")
        end
    end)
    menu.toggle_loop(event_protex_list, "阻止过场动画", {}, "", function()
        if CUTSCENE.IS_CUTSCENE_PLAYING() then
            CUTSCENE.STOP_CUTSCENE_IMMEDIATELY()
            CUTSCENE.REMOVE_CUTSCENE()
        end
    end)
    menu.toggle_loop(event_protex_list, "阻止玩家观看", {}, "阻止所有观看你的人的同步.", function()
        block_spectate()
    end)
    menu.toggle_loop(event_protex_list, "阻止脚本交易错误", {}, "阻止一些脚本,利用破坏车辆的方法,让你出现交易错误", function()
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_destroy_veh")) > 0 then
            MISC.TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME("am_destroy_veh")
            util.toast("已阻止销毁车辆事件生成")
        end
    end)
    anti_mugger = menu.list(event_protex_list, "拦截劫匪")
        menu.toggle_loop(anti_mugger, "拦截劫匪", {}, "防止被抢劫", function()
            block_mugger()
        end)
        menu.toggle_loop(anti_mugger, "劫匪检测", {}, "给劫匪绘制2D方框", function ()
            show_mugger()
        end)
    menu.toggle_loop(event_protex_list, "野兽防护", {}, "防止你被变成野兽,但也会阻止其他人的战局事件", function()
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_hunt_the_beast")) > 0 then
            MISC.TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME("am_hunt_the_beast")
            util.toast("已阻止野兽事件")
        end
    end)
    menu.toggle_loop(event_protex_list, "阻止古奇", {}, "阻止古奇事件", function()
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("fm_content_xmas_mugger")) > 0 then
            --local amLauncherHost = NETWORK.NETWORK_GET_HOST_OF_SCRIPT("am_launcher", -1, 0)
            MISC.TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME("fm_content_xmas_mugger")
            util.toast("已阻止古奇事件")
        end
    end)
    menu.toggle_loop(event_protex_list, "阻止克隆", {}, "阻止生成的克隆", function()
        for _, ped in ipairs(entities.get_all_peds_as_handles()) do
            if (ENTITY.GET_ENTITY_MODEL(ped) == util.joaat("mp_f_freemode_01") or ENTITY.GET_ENTITY_MODEL(ped) == util.joaat("mp_m_freemode_01")) and not PED.IS_PED_A_PLAYER(ped) then
                delete_entity(ped)
                util.toast("已删除克隆")
            end
        end
    end)
    
    menu.divider(event_protex_list, "网络事件")
    menu.toggle(event_protex_list, "全局超时", {}, "超时所有人", function(toggled)
		if toggled then
            NETWORK.NETWORK_START_SOLO_TUTORIAL_SESSION()--创建新手教程战局以取消与其他玩家同步
        else                  
            NETWORK.NETWORK_END_TUTORIAL_SESSION()
        end
	end)
	menu.toggle(event_protex_list, "阻止网络事件", {}, "阻止网络事件传输", function(on_toggle)
		local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
		local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockNetEvents)
		else
			menu.trigger_command(UnblockNetEvents)
		end
	end)
	menu.toggle(event_protex_list, "阻止传入", {}, "阻止网络事件传入", function(on_toggle)
		local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
		local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
		if on_toggle then
			menu.trigger_command(BlockIncSyncs)
		else
			menu.trigger_command(UnblockIncSyncs)
		end
	end)
	menu.toggle(event_protex_list, "阻止传出", {}, "阻止网络事件传出", function(on_toggle)
		if on_toggle then
			menu.trigger_commands("desyncall on")
		else
			menu.trigger_commands("desyncall off")
		end
	end)


appmenu.Ultion.BlockCage = menu.toggle_loop(protection, "防笼子", {}, "你不该长时间开启此功能", function()
    Cage_proof()
end)
menu.toggle(protection, "自闭模式", {}, "没错就是自闭", function(on)
    chickenmode(on)
end)

local aimkarma = menu.list(protection, '瞄准惩罚', {}, '对瞄准您的玩家做一些事情.')
    menu.toggle_loop(aimkarma, '套笼子', {}, '打你就关起来', function()
        local userPed = PLAYER.PLAYER_PED_ID()
        if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
            ptlz(karma[userPed].pid)
        end
    end)
    menu.toggle_loop(aimkarma, '射击', {}, '射击瞄准您的玩家.', function()
        local userPed = PLAYER.PLAYER_PED_ID()
        if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
            local pos = ENTITY.GET_ENTITY_COORDS(karma[userPed].ped)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 0.1, 100, true, 100416529, userPed, true, false, 100.0)
            util.yield()
        end
    end)
    menu.toggle_loop(aimkarma, '电击', {}, '电击瞄准您的玩家.', function()
        local userPed = PLAYER.PLAYER_PED_ID()
        if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
            local pos = ENTITY.GET_ENTITY_COORDS(karma[userPed].ped)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), PLAYER.PLAYER_PED_ID(), true, false, 1.0)
            util.yield()
        end
    end)
    menu.toggle_loop(aimkarma, '爆炸', {}, '使用您的自定义爆炸设置爆炸玩家.', function()
        local userPed = PLAYER.PLAYER_PED_ID()
        if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
            local pos = ENTITY.GET_ENTITY_COORDS(karma[userPed].ped, true)
            FIRE.ADD_OWNED_EXPLOSION(karma[userPed].ped, pos.x, pos.y, pos.z, 2, 50, true, false, 0.0)
        end
    end)

local proofsList = menu.list(protection, "免疫伤害", {}, "无敌类型自定义选项")
    for _, data in pairs(proofstbl) do
        menu.toggle(proofsList, data.name, {}, "让您对"..data.name:lower().."伤害避免", function(toggled)
            _G[data.name] = toggled
            while _G[data.name] do
                ENTITY.SET_ENTITY_PROOFS(PLAYER.PLAYER_PED_ID(), data.bullet, data.fire, data.explosion, data.collision, data.melee, data.steam, true, true)
                util.yield()
            end
            PLAYER.SET_PLAYER_INVINCIBLE(PLAYER.PLAYER_PED_ID(), false)
        end)
    end


----传送选项
menu.action(tp_world, "传送到标记点", {}, "", function()
    tp_waypoint()
end)
menu.action(tp_world, "过渡传送", {}, "", function()
    transit_tp()
end)
menu.action(tp_world, "随机位置", {}, "", function()
    random_position()
end)
menu.action(tp_world, "自定义传送", {}, "", function()
    Custom_teleport()
end)
menu.toggle_loop(tp_world, "自动传送到标记点", {}, "", function()
    tp_waypoint()
end)
menu.toggle_loop(tp_world, "自动传送到任务点", {}, "", function()
    auto_tp_task_points()
end)

local save_pos = menu.list(tp_world, '保存坐标传送', {}, '')
    local savepos, poslist = {}, {}
    menu.action(save_pos, "保存当前坐标", {}, "仅供临时使用", function()
        local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        savepos[#savepos + 1] = mypos
        local saveposlong = #savepos

        poslist[saveposlong] = menu.textslider(save_pos, "坐标 " .. saveposlong, {}, "", {"传送","删除"}, function(val)
            if val == 1 then
                teleport(savepos[saveposlong]["x"],savepos[saveposlong]["y"],savepos[saveposlong]["z"], true)
            elseif val == 2 then
                menu.delete(poslist[saveposlong])
                savepos[saveposlong] = nil
            end
        end)
    end)

TP_movement = menu.list(tp_world, '方向移动', {}, '')
    local tpf_units = 1
    menu.action(TP_movement, "向前移动", {}, "向前移动~个单位", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local head = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
        head = math.rad((head - 180) * -1)
        pos.x = pos.x + math.sin(head) * -tpf_units
        pos.y = pos.y + math.cos(head) * -tpf_units
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z'], true, false, false)
    end)
    menu.action(TP_movement, "向后移动", {}, "向前移动~个单位", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local head = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
        head = math.rad((head - 360) * -1)
        pos.x = pos.x + math.sin(head) * -tpf_units
        pos.y = pos.y + math.cos(head) * -tpf_units
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z'], true, false, false)
    end)
    menu.action(TP_movement, "向左移动", {}, "向前移动~个单位", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local head = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
        head = math.rad((head - 90) * -1)
        pos.x = pos.x + math.sin(head) * -tpf_units
        pos.y = pos.y + math.cos(head) * -tpf_units
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z'], true, false, false)
    end)
    menu.action(TP_movement, "向右移动", {}, "向前移动~个单位", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        local head = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
        head = math.rad((head + 90) * -1)
        pos.x = pos.x + math.sin(head) * -tpf_units
        pos.y = pos.y + math.cos(head) * -tpf_units
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z'], true, false, false)
    end)
    menu.action(TP_movement, "向上移动", {}, "向前移动~个单位", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        pos.z = pos.z + tpf_units
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z'], true, false, false)
    end)
    menu.action(TP_movement, "向下移动", {}, "向前移动~个单位", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        pos.z = pos.z - tpf_units
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), pos['x'], pos['y'], pos['z'], true, false, false)
    end)
    menu.slider(TP_movement, "移动距离", {}, "向前传送的距离", 1, 100, 1, 1, function(s)
        tpf_units = s
    end)

Property_pos = menu.list(tp_world, '资产传送', {}, '')
    for i = 1, #ownedprops do
        menu.action(Property_pos, ownedprops[i]["name"], {}, "", function()
            local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(ownedprops[i]["blid"]))
            if pos.x == 0 and pos.y == 0 and pos.z == 0 then
                util.toast('未找到坐标')
            else
                ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, false, false, false, false)
            end
        end)
    end

scene_place = menu.list(tp_world, "场景地点", {}, "")
    scene_tp = menu.list(scene_place, "场景", {}, "故事模式场景区域")
        for index, data in pairs(interiors) do
            local location_name = data[1]
            local location_coords = data[2]
            menu.action(scene_tp, location_name, {}, "", function()
                menu.trigger_commands("doors on")
                menu.trigger_commands("nodeathbarriers on")
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), location_coords.x, location_coords.y, location_coords.z, false, false, false)
            end)
        end

    IPL_tp = menu.list(scene_place, "IPL地点", {}, "")--https://github.com/YimMenu/YimMenu/blob/a5fb18c06b7c6991965eafc984a2378411ca413d/src/core/data/ipls.hpp#L20
        menu.textslider(IPL_tp, "北杨克顿", {}, "", {"加载","卸载"}, function(val)
            load_IPL(North_Yankton, 3360.1, -4849.67, 111.8, val)
        end)
        menu.textslider(IPL_tp, "UFO", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"UFO"}
            load_IPL(IPL_list, 2490.47729, 3774.84351, 2414.035, val)
        end)
        menu.textslider(IPL_tp, "堡垒UFO", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"UFO"}
            load_IPL(IPL_list, -2051.99463, 3237.05835, 1456.97021, val)
        end)
        menu.textslider(IPL_tp, "货船", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"cargoship"}
            load_IPL(IPL_list, -90.0, -2365.8, 14.3, val)
        end)
        menu.textslider(IPL_tp, "航空母舰", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = { "hei_carrier", "hei_Carrier_int1", "hei_Carrier_int2", "hei_Carrier_int3", "hei_Carrier_int4", "hei_Carrier_int5", "hei_Carrier_int6", "hei_carrier_DistantLights", "hei_carrier_LODLights"}
            load_IPL(IPL_list, 3016.46, -4534.09, 14.84, val)
        end)
        menu.textslider(IPL_tp, "失事的飞机", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"Plane_crash_trench"}
            load_IPL(IPL_list, 2814.7, 4758.5, 50.0, val)
        end)
        menu.textslider(IPL_tp, "色情游艇", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"smboat", "hei_yacht_heist", "hei_yacht_heist_Bar", "hei_yacht_heist_Bedrm", "hei_yacht_heist_Bridge", "hei_yacht_heist_DistantLights", "hei_yacht_heist_enginrm", "hei_yacht_heist_LODLights", "hei_yacht_heist_Lounge" }
            load_IPL(IPL_list, -2045.8, -1031.2, 11.9, val)
        end)
        menu.textslider(IPL_tp, "火车撞车", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"canyonriver01_traincrash","railing_end" }
            load_IPL(IPL_list, -532.1309, 4526.187, 88.7955, val)
        end)
        menu.textslider(IPL_tp, "停尸房", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"Coroner_Int_on"}
            load_IPL(IPL_list, 244.9, -1374.7, 39.5, val)
        end)
        menu.textslider(IPL_tp, "被毁的医院", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"RC12B_Destroyed", "RC12B_HospitalInterior"}
            load_IPL(IPL_list, 356.8, -590.1, 43.3, val)
        end)
        menu.textslider(IPL_tp, "LifeInvader", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"facelobby","facelobbyfake","facelobbyfake"}
            load_IPL(IPL_list, -1082.77, -258.67, 37.76, val)
        end)
        menu.textslider(IPL_tp, "珠宝店", {}, "", {"加载","卸载"}, function(val) 
            local IPL_list = {"post_hiest_unload","jewel2fake","jewel2fake","bh1_16_refurb"}
            load_IPL(IPL_list, -630.4, -236.7, 40.0, val)
        end)
    
    Poster_list = menu.list(scene_place, "海报", {}, "海报地点,每日刷新5个")
        for idx, coords in pairs(poster_coords) do
            Poster_list:action("海报 " .. idx, {}, "传送到海报", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    GraffitiJar_list = menu.list(scene_place, "涂鸦罐", {}, "涂鸦罐地点,每日刷新1个")
        for idx, coords in pairs(graffiti_jar_coords) do
            GraffitiJar_list:action("涂鸦罐 " .. idx, {}, "传送到涂鸦罐", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    pump_list = menu.list(scene_place, "南瓜灯", {}, "万圣节南瓜灯地点")
        for idx, coords in pairs(pumps_from_gtaweb_eu) do
            pump_list:action("南瓜灯 " .. idx, {}, "传送到南瓜灯", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    Snow_Monster_list = menu.list(scene_place, "雪怪", {}, "圣诞雪怪地点")
        for idx, coords in pairs(Snow_Monster) do
            Snow_Monster_list:action("雪怪 " .. idx, {}, "传送到雪怪", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    slumber_askari = menu.list(scene_place, "沉睡的保安地点", {}, "")
        for idx, coords in pairs(slumber_askari_list) do
            slumber_askari:action("保安 " .. idx, {}, "传送到保安", function()
                teleport(coords.x, coords.y, coords.z, true)
            end)
        end
    local ghost_exposure = menu.list(scene_place, "幽灵曝光地点", {}, "")
        local ghost_exposure1 = menu.list(ghost_exposure, "幽灵曝光1", {}, "")
            for idx, coords in pairs(ghost_exposure_list1) do
                ghost_exposure1:action("幽灵 " .. idx, {}, "", function()
                    teleport(coords[1], coords[2], coords[3], true)
                end)
            end
        local ghost_exposure2 = menu.list(ghost_exposure, "幽灵曝光2", {}, "")
            for idx, coords in pairs(ghost_exposure_list2) do
                ghost_exposure2:action("幽灵 " .. idx, {}, "", function()
                    teleport(coords[1], coords[2], coords[3], true)
                end)
            end
    Halloween_UFO = menu.list(scene_place, "UFO地点", {}, "")
        for idx, coords in pairs(Halloween_UFO_list) do
            Halloween_UFO:action("UFO " .. idx, {}, "", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    nuclear_waste = menu.list(scene_place, "核废料地点", {}, "")
        for idx, coords in pairs(nuclear_waste_list) do
            nuclear_waste:action("核废料 " .. idx, {}, "", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    snow_loca = menu.list(scene_place, "雪人地点", {}, "")
        for idx, coords in pairs(snowmens) do
            snow_loca:action("雪人 " .. idx, {}, "传送到圣诞节地点", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    revolver_loca = menu.list(scene_place, "左轮手枪地点", {}, "")
        for idx, coords in pairs(revolver) do
            revolver_loca:action("左轮 " .. idx, {}, "", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    snow_loca = menu.list(scene_place, "武器厢型车地点", {}, "这个只是厢型车可能会产出的地点,如果你想生成厢型车,请使用'线上活动地点'>'传送到厢型车'")
        for idx, coords in pairs(weaponvan) do
            snow_loca:action("厢型车 " .. idx, {}, "传送到厢型车", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    figures_loca = menu.list(scene_place, "手办地点", {}, "")
        for idx, coords in pairs(figures) do
            figures_loca:action("手办 " .. idx, {}, "传送到手办", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    cactus_list = menu.list(scene_place, "迷幻仙人掌地点", {}, "")
        for idx, coords in pairs(half_cactus) do
            cactus_list:action("仙人掌 " .. idx, {}, "传送到仙人掌", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    jammers_loca = menu.list(scene_place, "信号干扰器地点", {}, "")
        for idx, coords in pairs(jammers) do
            jammers_loca:action("信号干扰器 " .. idx, {}, "传送到信号干扰器", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    movie_props = menu.list(scene_place, "电影道具地点", {}, "")
        for idx, coords in pairs(movie_prop1) do
            movie_props:action("电影道具 " .. idx, {}, "传送到电影道具", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    workshop_products = menu.list(scene_place, "拉玛有机作坊产品地点", {}, "")
        for idx, coords in pairs(ld_product) do
            workshop_products:action("产品 " .. idx, {}, "传送到产品", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end
    tp_card = menu.list(scene_place, "纸牌", {}, "纸牌地点")
        for idx, coords in pairs(cards1) do
            tp_card:action("纸牌 " .. idx, {}, "传送到纸牌", function()
                teleport(coords[1], coords[2], coords[3], true)
            end)
        end

tp_online = menu.list(tp_world, "线上活动地点", {}, "")
    menu.action(tp_online, "传送到厢型车", {}, "如果没有或者太远会直接生成一个新的", function()
        tp_gun_van()
    end)
    for i = 1 , #tp_online_pos do
        menu.action(tp_online, tp_online_pos[i]["Name"], {}, "", function()
            local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(tp_online_pos[i]["value"]))
            teleport(pos.x, pos.y, pos.z, false)
        end)
    end

tp_address = menu.list(tp_world, "预设地点", {}, "")
    for i = 1 , #tp_address_pos do
        menu.action(tp_address, tp_address_pos[i]["Name"], {}, "", function()
            teleport(tp_address_pos[i]["x"],tp_address_pos[i]["y"],tp_address_pos[i]["z"], true)
        end)
    end



------世界选项
local game_list = menu.list(worldlist, "游戏", {}, "")
    local cam_list = menu.list(game_list, "游戏相机", {}, "")
        free_cam = menu.list(cam_list, "自由相机", {}, "")
            require "lib.SakuraScript.aperture"

        menu.toggle(cam_list, '上帝视角', {}, '', function(toggled)
            god_cam(toggled, PLAYER.PLAYER_ID())
        end)
        menu.toggle_loop(cam_list, "锁定游戏视角", {}, "", function()
            CAM.SET_GAMEPLAY_CAM_RELATIVE_HEADING(0)
        end)
        menu.toggle_loop(cam_list, "禁用空闲画面", {}, "", function()
            CAM.INVALIDATE_IDLE_CAM()
        end)
        menu.toggle_loop(cam_list, "禁用空闲车辆画面", {}, "", function()
            CAM.INVALIDATE_CINEMATIC_VEHICLE_IDLE_MODE()
        end)

    local Disable_option = menu.list(game_list, "禁用选项", {}, "")
        menu.toggle_loop(Disable_option, "禁用画效", {}, "", function()
            GRAPHICS.ANIMPOSTFX_STOP_ALL()
        end)
        local audio_option = menu.list(Disable_option, "音效禁用", {}, "")
            menu.toggle(audio_option, "禁用脚步声", {}, "", function(state)
                AUDIO1.SET_PED_AUDIO_FOOTSTEP_LOUD(PLAYER.PLAYER_PED_ID(), not state)
                AUDIO.SET_PED_CLOTH_EVENTS_ENABLED(PLAYER.PLAYER_PED_ID(), not state)
                AUDIO.SET_PED_FOOTSTEPS_EVENTS_ENABLED(PLAYER.PLAYER_PED_ID(), not state)
            end)
            menu.toggle_loop(audio_option, "禁用尖叫", {}, "禁用NPC尖叫声", function()	
                for k, ped in pairs (entities.get_all_peds_as_handles()) do
                    if ped ~= PLAYER.PLAYER_PED_ID() then
                        AUDIO.DISABLE_PED_PAIN_AUDIO(ped, true)
                    end
                end
            end)
            menu.toggle_loop(audio_option, "禁用对话", {}, "禁用NPC对话声", function()	
                for k, ped in pairs (entities.get_all_peds_as_handles()) do
                    if ped ~= PLAYER.PLAYER_PED_ID() then
                        AUDIO.STOP_CURRENT_PLAYING_SPEECH(ped)
                    end
                end
            end)
            menu.toggle_loop(audio_option, "禁用提示", {}, "禁用由任务或帮派攻击等引起的音效", function()
                if AUDIO.AUDIO_IS_MUSIC_PLAYING() and not NETWORK.NETWORK_IS_ACTIVITY_SESSION() then
                    AUDIO.TRIGGER_MUSIC_EVENT("GLOBAL_KILL_MUSIC")
                end
                yield(500)
            end)
            menu.toggle(audio_option, "禁用警笛", {}, "禁用自由模式下听到的远处警笛声", function(toggled)
                AUDIO.DISTANT_COP_CAR_SIRENS(not toggled)
            end)
            menu.toggle_loop(audio_option, "禁用警报", {}, "禁用偷车时发出的警报", function()
                local vehicle = VEHICLE.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(PLAYER.PLAYER_PED_ID())
                if VEHICLE.IS_VEHICLE_ALARM_ACTIVATED(vehicle) then
                    VEHICLE.SET_VEHICLE_ALARM(vehicle, false)
                end
            end)
            menu.toggle_loop(audio_option, "禁用鸣笛", {}, "禁用NPC在车内死亡时的鸣笛", function()
                for k, ped in pairs (entities.get_all_peds_as_handles()) do
                    PED.SET_PED_CONFIG_FLAG(ped, 46, true)
                end
            end)
            menu.toggle(audio_option, "禁用扫描", {}, "禁用警察扫描仪声音", function(toggled)
                AUDIO.SET_AUDIO_FLAG("PoliceScannerDisabled", toggled)
            end)

    local phone_list = menu.list(game_list, "电话选项", {},"")
        menu.toggle(phone_list, "禁用手机", {}, "", function(toggle)
            cellphone_state(not toggle)
        end)
        menu.toggle(phone_list, "拿出手机", {}, "当你使用手机时玩家模型也会拿出手机", function(toggled)
            PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 242, not toggled)
            PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 243, not toggled)
            PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), 244, not toggled)
        end)
        menu.toggle_loop(phone_list, "移除电话图形界面", {}, "", function()
            local phonePos = v3.new()
            MOBILE.GET_MOBILE_PHONE_POSITION(phonePos) --Vector3* is param
            local phoneTable = {x=v3.getX(phonePos), y=v3.getY(phonePos), z=v3.getZ(phonePos)}
            MOBILE.SET_MOBILE_PHONE_POSITION(phoneTable.x - 10000, phoneTable.y, phoneTable.z)
        end)

    menu.action(game_list,"刷新室内地图", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        local interior = INTERIOR.GET_INTERIOR_AT_COORDS(pos.x, pos.y, pos.z)
        INTERIOR.REFRESH_INTERIOR(interior)
    end)
    menu.action(game_list,"加载线上地图", {}, "", function()
        DLC.ON_ENTER_MP()
    end)
    menu.action(game_list,"加载线下地图", {}, "", function()
        DLC.ON_ENTER_SP()
    end)
    menu.action(game_list,"移除所有摄像头", {}, "", function()
        remove_all_camera()
    end)
    menu.toggle_loop(game_list, "透视无人机", {}, "", function ()
        show_nano_drone()
    end)

    local overrideHud = menu.list(game_list, "武器轮", {}, "改变武器轮和其他一些东西的颜色")
        menu.toggle(overrideHud, '强制显示武器轮', {}, '', function(toggled)
            HUD.HUD_FORCE_WEAPON_WHEEL(toggled)
        end)
        menu.divider(overrideHud, "武器轮颜色");local overrideHudColor = -1
        menu.list_select(overrideHud, "颜色", {}, "", {{-1, "默认"},{28, "浅红"},{26, "蓝"},{18, "绿"},{21, "紫"},{30, "粉红"},{12, "黄"},{15, "橙"}}, -1, function(color)
            overrideHudColor = color
        end)
        menu.toggle_loop(overrideHud, "更改", {}, "", function()
            HUD.SET_CUSTOM_MP_HUD_COLOR(overrideHudColor)
            util.yield(1000)
        end)

    menu.toggle(game_list, '强制所有潜艇浮出水面', {}, '强制让所有虎鲸浮出水面', function(toggled)
        Force_surface_all_subs(toggled)
    end)
    menu.toggle_loop(game_list, "移除所有防空领域", {}, "", function()
        WEAPON.REMOVE_ALL_AIR_DEFENCE_SPHERES()
    end)
    menu.toggle(game_list, "暂停世界", {}, "", function(on)
        MISC.SET_GAME_PAUSED(on)
    end)
    menu.click_slider(game_list, "距离比例尺", {}, "", 0, 200, 1, 1, function(val)
        override_lodscale(val)
    end)

local weather_list = menu.list(worldlist,"天气",{},"")
    menu.toggle(weather_list, '禁用雾', {}, '', function(toggled)
        disable_fog(toggled)
    end)
    menu.click_slider(weather_list, "设置风速", {}, "", -1, 12, 0, 1, function(val)
        MISC.SET_WIND_SPEED(val)
    end)
    menu.textslider(weather_list, "设置天气", {}, "仅本地更改", weather.name, function (index)
        if index == 1 then MISC.CLEAR_OVERRIDE_WEATHER() else MISC.SET_OVERRIDE_WEATHER(weather.value[index]) end
    end)
    menu.toggle(weather_list, "雪天", {}, "仅本地可见", function(toggled)--Update tag(1.69)
        SET_INT_GLOBAL(Global_Base.Default + 4413, toggled and 1 or 0)--menu.trigger_commands("weather xmas")
    end)
    menu.toggle_loop(weather_list, "随机天气", {}, "", function()
        MISC.SET_OVERRIDE_WEATHER(weather.value[math.random(1,15)])
    end)
    menu.toggle_loop(weather_list, "闪电生成", {}, "", function()
        MISC.FORCE_LIGHTNING_FLASH()
    end)
    menu.toggle_loop(weather_list, "局部下雨", {}, "", function()
        local player_pos = players.get_position(PLAYER.PLAYER_ID())
        request_ptfx_asset("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("water_boat_exit", player_pos.x, player_pos.y, player_pos.z+5, 0, 0, 0, 2.5, false, false, false)
    end)

local time_list = menu.list(worldlist,"时间",{},"")
    menu.slider(time_list, "小时", {"sethours"}, "", 0, 23, 0, 1, function(val)
        NETWORK.NETWORK_OVERRIDE_CLOCK_TIME(val, CLOCK.GET_CLOCK_MINUTES(), CLOCK.GET_CLOCK_SECONDS())
    end)
    menu.slider(time_list, "分钟", {"setminutes"}, "", 0, 59, 0, 1, function(val)
        NETWORK.NETWORK_OVERRIDE_CLOCK_TIME(CLOCK.GET_CLOCK_HOURS(), val, CLOCK.GET_CLOCK_SECONDS())
    end)
    menu.slider(time_list, "秒数", {"setseconds"}, "", 0, 59, 0, 1, function(val)
        NETWORK.NETWORK_OVERRIDE_CLOCK_TIME(CLOCK.GET_CLOCK_HOURS(), CLOCK.GET_CLOCK_MINUTES(), val)
    end)
    menu.toggle_loop(time_list, "锁定时间", {}, "", function()
        NETWORK.NETWORK_OVERRIDE_CLOCK_TIME(CLOCK.GET_CLOCK_HOURS(), CLOCK.GET_CLOCK_MINUTES(), CLOCK.GET_CLOCK_SECONDS())
    end)
    menu.toggle_loop(time_list, "同步现实时间", {}, "", function()
        NETWORK.NETWORK_OVERRIDE_CLOCK_TIME(os.date("%H"), os.date("%M"), os.date("%S"))
    end)
    menu.click_slider(time_list, "设置时间刻度", {}, "减慢时间", 0, 10, 10, 1, function(val)
        MISC.SET_TIME_SCALE(val/10)
    end)

water_list = menu.list(worldlist, "水", {}, "")
    menu.slider(water_list, '波浪强度', {"setwaveintensity"}, '', 0, 10000, 1, 1, function(val)
        WATER.SET_DEEP_OCEAN_SCALER(val)
    end)
    menu.click_slider(water_list, '神奇的水坑', {}, '', 0, 10, 0, 1, function(val)
        MISC.SET_RAIN(val)
    end)
    menu.toggle_loop(water_list, "水体漩涡", {}, "靠近水", function()
        water_vortex()
    end)

    all_npc = menu.list(worldlist, "NPC选项", {})
    menu.toggle_loop(all_npc, "禁用帮派骚扰", {}, "", function()
        PLAYER.SET_PLAYER_CAN_BE_HASSLED_BY_GANGS(PLAYER.PLAYER_ID(), false)
    end)
    menu.toggle(all_npc, "禁用调度警察", {}, "不会继续刷出新的警察",function(toggled)
        PLAYER.SET_DISPATCH_COPS_FOR_PLAYER(players.user(), not toggled)
    end)
    menu.action(all_npc, "移除尸体", {}, "", function()
        Remove_dead_body()
    end)
    menu.action(all_npc, "移除丧尸", {}, "", function()
        Remove_zombies()
    end)
    menu.action(all_npc, "给予NPC所有武器", {}, "", function()
        give_AllNPC_weapon()
    end)
    menu.action(all_npc, "移除NPC所有武器", {}, "", function()
        remove_AllNPC_waepon()
    end)
    menu.toggle_loop(all_npc, "NPC无视玩家", {}, "", function()
        NPC_Ignore_player()
    end)
    menu.toggle_loop(all_npc, "冷静NPC", {}, "", function()
        calm_all_npc()
    end)
    menu.toggle_loop(all_npc, "敌意NPC", {}, "", function()
        enmity_npc()
    end)
    menu.toggle_loop(all_npc, "友好的NPC", {}, "NPC不会攻击你.", function()
        PED.SET_PED_RESET_FLAG(PLAYER.PLAYER_PED_ID(), 124, true)
    end)
    menu.toggle_loop(all_npc, "自动杀死附近NPC", {}, "", function()
        auto_kill_NPC()
    end)
    menu.toggle_loop(all_npc, "自动杀死敌人", {}, "", function()
        auto_kill_enemy()
    end)
    menu.toggle(all_npc, "缩小NPC", {}, "", function(on)
        shrink_peds(on)
    end)
    menu.toggle_loop(all_npc, '反向驾驶', {}, '强制所有NPC反向行驶', function()
        force_npc_reverse_travel()
    end)
    menu.toggle_loop(all_npc, "强制冻结NPC", {}, "完全冻结", function()
        force_freeze_npc()
    end)
    menu.toggle_loop(all_npc, "冻结NPC", {}, "禁止npc移动", function()
        freeze_npc()
    end)
    menu.toggle_loop(all_npc, "禁止走火", {}, "禁止npc武器掉落时走火", function()
        block_npc_misfire()
    end)
    menu.toggle_loop(all_npc, "禁止受伤行为", {}, "禁止npc受伤倒地的一些动作", function()
        block_npc_injury()
    end)
    menu.action(all_npc, "强化所有NPC", {}, "", function()
        increase_allnpc()
    end)
    for i = 1, #pedToggleLoops do
        menu.toggle_loop(all_npc, pedToggleLoops[i].name, {pedToggleLoops[i].command}, pedToggleLoops[i].description, function()
                local pedHandles = entities.get_all_peds_as_handles()
                for j = 1, #pedHandles do
                    pedToggleLoops[i].action(pedHandles[j])
                end
                util.yield(10)
            end, function()
                if pedToggleLoops[i].onStop then pedToggleLoops[i].onStop() end
        end)
    end


menu.action(worldlist,"导航至最近的加油站", {}, "", function()
    GetClosestGasStation()
end)


cus_respawn = menu.list(worldlist, '自定义复活位置', {}, '')
    menu.toggle_loop(cus_respawn, '开启', {}, '设置你死后重生的位置', function()
        custom_respawn()
    end)
    custom_respawn_location = menu.action(cus_respawn, '保存位置', {}, '未设置位置', function()
        save_custom_respawn()
    end)

world_veh = menu.list(worldlist, "世界载具", {}, "")
    menu.toggle_loop(world_veh,"彩虹渐变所有载具", {}, "", function()
        for k, veh in pairs(entities.get_all_vehicles_as_handles()) do
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, math.random(0, 255), math.random(0, 255), math.random(0, 255))
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, math.random(0, 255), math.random(0, 255), math.random(0, 255))
            VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(veh, math.random(0, 255), math.random(0, 255), math.random(0, 255))
        end
        util.yield(100)
    end)
    menu.toggle_loop(world_veh,"爆炸所有载具", {}, "", function()
        local user_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
        for k, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
            if vehicle ~= user_vehicle then
                local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, true)
                FIRE.ADD_EXPLOSION(vehicle_pos.x, vehicle_pos.y, vehicle_pos.z, 0, 1, true, false, 0, false)
            end
        end
        util.yield(100)
    end)
    menu.toggle_loop(world_veh,"冻结所有载具", {}, "", function()
            local user_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
            for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
                if vehicle ~= user_vehicle then
                    ENTITY.FREEZE_ENTITY_POSITION(vehicle, true)
                end
            end
        end, function()
            local vehicles = entities.get_all_vehicles_as_handles()
            for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
                ENTITY.FREEZE_ENTITY_POSITION(vehicle, false)
            end
    end)
    menu.toggle_loop(world_veh,"倒置所有载具", {}, "", function()
            local vehicles = entities.get_all_vehicles_as_handles()
            local user_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
            for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
                if vehicle ~= user_vehicle then
                    ENTITY.SET_ENTITY_ROTATION(vehicle, 0, 180, 0, 1, true)
                end
            end
        end, function()
            local vehicles = entities.get_all_vehicles_as_handles()
            local user_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
            for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
                if vehicle ~= user_vehicle then
                    ENTITY.SET_ENTITY_ROTATION(vehicle, 0, 0, 0, 1, true)
                end
            end
    end)
    menu.toggle_loop(world_veh, "世界跳跳车", {}, "", function()
        local entities = GET_NEARBY_VEHICLES(PLAYER.PLAYER_ID(), 150)
	    for _, vehicle in ipairs(entities) do
		    request_control(vehicle)
		    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0, 0, 6.5, 0, 0, 0, 0, false, false, true)
	    end
	    util.yield(1500)
    end)
    menu.toggle_loop(world_veh, "喇叭轰炸", {}, "使附近的所有车辆激活喇叭", function() 
        AUDIO.SET_AGGRESSIVE_HORNS(true)
        for i, vehs in pairs(entities.get_all_vehicles_as_handles()) do
            VEHICLE.START_VEHICLE_HORN(vehs, 1000, 0, false)
        end
        util.yield(1000)
    end)
    menu.toggle_loop(world_veh,"删除所有载具", {}, "", function()
        local my_pos = players.get_position(PLAYER.PLAYER_ID())
        MISC.CLEAR_AREA_OF_VEHICLES(my_pos.x, my_pos.y, my_pos.z, 10000, false, false, false, false, false, false, false)
        util.yield(1000)
    end)

misclightmenu = menu.list(worldlist, "环境光")
    local Radiuslight = 100
    local intenslight = 100
    menu.toggle_loop(misclightmenu, "开启", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        GRAPHICS.DRAW_LIGHT_WITH_RANGE(pos.x, pos.y, pos.z, glow_color.r, glow_color.g, glow_color.b, Radiuslight, intenslight)
    end)
    menu.slider(misclightmenu, "设置半径" ,{}, "", 0, 200, 100, 5, function(s)
        Radiuslight = s
    end)
    menu.slider(misclightmenu, "设置强度", {}, "", 0, 200, 100, 5, function(s)
        intenslight = s
    end)
    menu.divider(misclightmenu,"颜色")
    menu.rainbow(menu.colour(misclightmenu,"颜色", {"glowcolour"}, "",glow_color, false, function(newColour)
        glow_color = newColour
    end))

menu.toggle_loop(worldlist, "红绿灯混乱", {}, "",function()
    for _, light in pairs(entities.get_all_objects_as_handles()) do
        if light == 1043035044 or 862871082 or 3639322914 then
            ENTITY.SET_ENTITY_TRAFFICLIGHT_OVERRIDE(light, math.random(0, 2))--3可重置红绿灯
        end
    end
end)
menu.list_select(worldlist, "世界重力", {},"改变世界的引力", World_gravity_option, 1,function(value, menu_name, prev_value, click_type)
    World_gravity(value, menu_name, prev_value, click_type)
end)
menu.toggle_loop(worldlist, "世界混乱", {}, "使附近的汽车进入哥布林-妖精模式",function()
    for i, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0.0, 10.0, 0.0, true, true, true, true)
    end
end)

menu.action(worldlist, "爆炸动物", {}, "炸毁所有附近的动物", function()
    animalFound = false
    for i, aPed in pairs(entities.get_all_peds_as_handles()) do 
       if PED.IS_PED_HUMAN(aPed) ~= true then 
        animalFound = true
        local pedPos = ENTITY.GET_ENTITY_COORDS(aPed)
        FIRE.ADD_EXPLOSION(pedPos.x, pedPos.y, pedPos.z, 0, 1, true, false, 0, false)
       end
    end
    if animalFound == false then 
        util.toast("附近没有动物")
    end
end)

Plot_health = menu.list(worldlist, "绘制血量条", {})
    menu.toggle_loop(Plot_health, "开启", {}, "", function ()
        PedHealthBarmainLoop()
    end)
    menu.list_select(Plot_health, "绘制方式", {}, "", drawoptions, 1, function (value, menu_name, prev_value, click_type)
        ped_draw_method(value, menu_name, prev_value, click_type)
    end)
    
menu.toggle(worldlist, "愤怒的飞机", {}, "", function (toggled)
    Angry_plane(toggled)
end)

custom_fireworks = menu.list(worldlist, "烟花", {})
    menu.action(custom_fireworks,"珍珠烟花",{},"",function()
        Pearl_fireworks()
    end)
    fireworks_bucket = menu.list(custom_fireworks, "烟花桶", {}, "")
        menu.action(fireworks_bucket,"安放烟花桶",{},"",function()
            anfangyanhua()
        end)	
        menu.action(fireworks_bucket,"发射烟花",{},"",function()
            yanhuafashe()
        end)
    menu.toggle_loop(custom_fireworks, "满天烟花", {}, "", function()
        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        coords['x'] = coords['x'] + math.random(-100, 100)
        coords['y'] = coords['y'] + math.random(-100, 100)
        coords['z'] = coords['z'] + math.random(30, 100)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 38, 100.0, true, false, 0.0)
        util.yield(100)
    end)
    menu.toggle_loop(custom_fireworks, "大烟花", {}, "", function ()
        big_fireworks()
    end)
    menu.toggle_loop(custom_fireworks, "炫彩烟花", {}, "", function ()
        new_firework()
    end)
    menu.toggle_loop(custom_fireworks, "礼花桶", {}, "", function ()
        new_firework2()
    end)
    menu.action(custom_fireworks, "散射烟花", {}, "", function()
        for i = 1, 5 do
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), math.random(-10,10), math.random(40,50), math.random(10,20))

            for i = 1, 8 do
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x, coords.y, coords.z, coords.x+math.random(-10,10), coords.y+math.random(-10,10), coords.z+math.random(-10,10), 1, true, 2138347493, PLAYER.PLAYER_PED_ID(), true, false, 50)
            end
        end
    end)
    
menu.toggle(worldlist, "圣诞树", {}, "面向目标按B可以移动目标位置", function(on)
    if on then
        menu.trigger_commands("godfinger on")
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 8, -1)--偏移量坐标,前后,左右,上下
        local broomstick = util.joaat("prop_xmas_ext")
        request_model(broomstick)
        xmas_obj = OBJECT.CREATE_OBJECT(broomstick, pos.x, pos.y, pos.z, true, true, true)
    else
        delete_entity(xmas_obj)
        menu.trigger_commands("godfinger off")
    end
end)
menu.toggle(worldlist, "小圣诞树", {}, "面向目标按B可以移动目标位置", function(on)
    if on then
        menu.trigger_commands("godfinger on")
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 4, -1)--偏移量坐标,前后,左右,上下
        local broomstick = util.joaat("prop_xmas_tree_int")
        request_model(broomstick)
        mas_obj = OBJECT.CREATE_OBJECT(broomstick, pos.x, pos.y, pos.z, true, true, true)
    else
        delete_entity(mas_obj)
        menu.trigger_commands("godfinger off")
    end
end)

menu.toggle(worldlist, "土豆模式", {"fpsnsboost"}, "提高FPS", function(on_toggle)
	if on_toggle then
		menu.trigger_commands("weather" .. " extrasunny")---设置天气
		menu.trigger_commands("clouds" .. " clear01")---设置云
        menu.trigger_commands("potatomode ")---开启土豆
        menu.trigger_commands("nosky ")---移除天空
        menu.trigger_commands("noidlecam ")---禁用挂机镜头
	else
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
        menu.trigger_commands("potatomode ")
        menu.trigger_commands("nosky ")
        menu.trigger_commands("noidlecam ")
	end
end)

menu.toggle_loop(worldlist,"轰炸区", {}, "", function()
    bomb_area()
end)


train_list = menu.list(worldlist, "列车选项", {}, "")
    train_build = menu.list(train_list, "火车生成", {}, "如附近未找到火车,可前往铁轨附近重新生成")
        menu.click_slider(train_build, "火车生成类型", {}, "点击生成不同类型火车", 1, 23, 1, 1, function(variation)
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), 1)
            spawn_train(variation - 1, pos)
        end)
        menu.action(train_build, "生成地铁", {}, "", function()
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), 1)
            spawn_train(21, pos)
        end)
        menu.action(train_build, "删除所有火车", {}, "", function()
            local vehicles = entities.get_all_vehicles_as_handles()
            for k, veh in pairs(vehicles) do
                delete_entity(veh)
            end
        end)
    menu.action(train_list, "驾驶附近的火车", {}, "", function()
        local train = get_closest_train()
        if train ~= 0 then
            delete_entity(VEHICLE.GET_PED_IN_VEHICLE_SEAT(train, -1))
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), train, -1)
            AUDIO.SET_VEHICLE_RADIO_ENABLED(train, true)
        end
    end)
    set_train_speed = menu.list(train_list,"设置列车速度", {}, "")
        local train_speed = 55/3.6
        menu.toggle_loop(set_train_speed,"设置列车速度", {}, "", function()
            for _, veh in pairs(entities.get_all_vehicles_as_pointers()) do 
                if entities.get_model_hash(veh) == util.joaat("freight") then
                    train_hdl = entities.pointer_to_handle(veh)
                    request_control(train_hdl)
                    VEHICLE.SET_TRAIN_SPEED(train_hdl, train_speed)
                    VEHICLE.SET_TRAIN_CRUISE_SPEED(train_hdl, train_speed)
                end
            end
        end)
        menu.slider(set_train_speed,"设置列车速度", {}, "", -100, 290, 55, 5, function(s)
            train_speed = s/3.6      
        end)
    menu.action(train_list, "下车", {}, "", function()
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
        TASK.TASK_LEAVE_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), 0, 16)
    end)
    menu.toggle(train_list, "脱轨", {}, "", function(on)
        local vehicles = entities.get_all_vehicles_as_handles()
        for k, veh in pairs(vehicles) do
            VEHICLE.SET_RENDER_TRAIN_AS_DERAILED(veh, on)
        end
    end)
    train_position = menu.list(train_list, "列车站点传送", {}, "")
        menu.action(train_position, "大洋公路站点", {}, "", function()
            teleport(-86, 6198, 31, true)
        end)
        menu.action(train_position, "维斯普奇大道站点", {}, "", function()
            teleport(674, -1048, 22, true)
        end)

hudminimapmenu = menu.list(worldlist, "小地图")
    local mapzoom = 1
    menu.click_slider(hudminimapmenu, "小地图缩放", {"minimapzoom"}, "", 0, 100, 0, 1, function(s)
        HUD.SET_RADAR_ZOOM_PRECISE(s)
    end)

    local mapangle = 0
    menu.slider(hudminimapmenu,"小地图角度", {"minimapanglme"}, "结合下面锁定地图角度", 0, 360, 0, 1, function(s)
        mapangle = s
    end)
    menu.toggle(hudminimapmenu,"锁定地图角度", {}, "", function(toggled)
        mapangle_toggled = toggled
        while mapangle_toggled do
            HUD.LOCK_MINIMAP_ANGLE(mapangle)
            util.yield()
        end
        HUD.UNLOCK_MINIMAP_ANGLE()
    end)
    menu.toggle(hudminimapmenu,"显示声呐", {}, "", function(on)
        HUD1._SET_MINIMAP_SONAR_ENABLED(on)
    end)
    menu.toggle(hudminimapmenu,"显示佩里科岛地图", {}, "", function(on)
        HUD1._SET_TOGGLE_MINIMAP_HEIST_ISLAND(on)
    end)
    menu.toggle(hudminimapmenu,"显示北扬克顿地图", {}, "", function(on)
        HUD.SET_MINIMAP_IN_PROLOGUE(on)
    end)
    menu.toggle_loop(hudminimapmenu, "以你为中心的地图", {}, "", function()
        HUD.DONT_TILT_MINIMAP_THIS_FRAME()
    end)

menu.toggle(worldlist, "哲学的美", {}, "", function(on)
    local a_toggle = menu.ref_by_path('World>Aesthetic Light>Aesthetic Light')
    if on then 
        menu.trigger_commands("shader glasses_purple")-----屏幕效果
        menu.trigger_commands("aestheticcolourred 255")
        menu.trigger_commands("aestheticcolourgreen 0")
        menu.trigger_commands("aestheticcolourblue 255")
        menu.trigger_commands("aestheticrange 10000")
        menu.trigger_commands("aestheticintensity 30")----强度30
        menu.trigger_commands("time 0")
        menu.set_value(a_toggle, true)
    else
        menu.set_value(a_toggle, false)
        menu.trigger_commands("shader off")
    end
end)
menu.action(worldlist, "时间流逝", {}, "",function()
    menu.trigger_commands("timesmoothing on")
        menu.trigger_commands("time 0")
        util.yield(1000)
        menu.trigger_commands("time 12")
end)
menu.toggle(worldlist, "停电", {}, "", function(toggled)
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
end)
menu.toggle(worldlist, "世界末日", {}, "", function(toggled)
    menu.trigger_commands("time 1")
    GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(toggled)
    if toggled then
        GRAPHICS.SET_TIMECYCLE_MODIFIER("dlc_island_vault")
    else
        GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    end
end)


visuallist = menu.list(worldlist, "视觉效果", {})
    menu.click_slider(visuallist, "醉酒模式", {}, "", 0, 5, 0, 1, function(val)
        if val > 0 then
            CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", val)
            GRAPHICS.SET_TIMECYCLE_MODIFIER("Drunk")
        else
            GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
            CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0)
        end
    end)

    visual_fidelity = menu.list(visuallist, "视觉增强", {}, "")
        for id, data in pairs(visual_stuff) do
            local visual_name = data[1]
            local visual_thing = data[2]
            local visual = false
            local visual_toggle
            visual_toggle = menu.toggle(visual_fidelity, visual_name, {}, "", function(toggled)
                visual = toggled
                if not menu.get_value(visual_toggle) then
                    GRAPHICS.ANIMPOSTFX_STOP_ALL()
                return end

                while visual do
                    GRAPHICS.SET_TIMECYCLE_MODIFIER(visual_thing)
                    menu.trigger_commands("shader off")
                    util.yield(250)
                end
                GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
            end)
        end 

    drug_mode = menu.list(visuallist, "药物过滤器", {}, "")
        for id, data in pairs(drugged_effects) do
            menu.toggle(drug_mode, data, {}, "", function(toggled)
                if toggled then
                    GRAPHICS.SET_TIMECYCLE_MODIFIER(data)
                    menu.trigger_commands("shader off")
                else
                    GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
                end
            end)
        end

    visions = menu.list(visuallist, "屏幕效果", {}, "")
        for id, data in pairs(effect_stuff) do
            local effect_name = data[1]
            local effect_thing = data[2]
            local effect = false
            local effect_toggle
            effect_toggle = menu.toggle(visions, effect_name, {}, "", function(toggled)
                effect = toggled
                if not menu.get_value(effect_toggle) then
                    GRAPHICS.ANIMPOSTFX_STOP_ALL()
                return end

                while effect do
                    GRAPHICS.ANIMPOSTFX_PLAY(effect_thing, 5, true)
                    util.yield(1000)
                end
            end)
        end



----作弊者检测
menu.divider(cheater_detection,"检测列表")
Voice_detection = menu.toggle_loop(cheater_detection, "玩家语音检测", {}, "[配置]\n检测谁在游戏聊天中说话", function()
    talking_detection()
end);set_menu_value(Voice_detection, luaConfig.Voice_detection, false)

ped_Invincible_detection = menu.toggle_loop(cheater_detection, "玩家无敌检测", {}, "[配置]\n检测是否在使用无敌.", function()
    god_detection()
end);set_menu_value(ped_Invincible_detection, luaConfig.ped_Invincible_detection, false)

veh_Invincible_detection = menu.toggle_loop(cheater_detection, "载具无敌检测", {}, "[配置]\n检测载具是否在使用无敌.", function()
    car_god_detection()
end);set_menu_value(veh_Invincible_detection, luaConfig.veh_Invincible_detection, false)

use_wea_int = menu.toggle_loop(cheater_detection, "室内使用武器检测", {}, "[配置]\n检测玩家是否在室内使用武器.", function()
    usingweapon_detection()
end);set_menu_value(use_wea_int, luaConfig.use_wea_int, false)

Watch_detection = menu.toggle_loop(cheater_detection, "观看检测", {}, "[配置]\n检测是否有人在观看你.", function()
    lookingyou_detection()
end);set_menu_value(Watch_detection, luaConfig.Watch_detection, false)

transport_detection = menu.toggle_loop(cheater_detection, "传送检测", {}, "[配置]\n检测玩家是否使用了传送", function()
    tp_detection()
end);set_menu_value(transport_detection, luaConfig.transport_detection, false)

change_mod_detection = menu.toggle_loop(cheater_detection, "切换模型检测", {}, "[配置]\n检测玩家是否切换了模型", function()
    changedMOD_detection()
end);set_menu_value(change_mod_detection, luaConfig.change_mod_detection, false)



------其他选项
menu.toggle_loop(otherlist, "死亡警告", {}, "当你死亡时触发警告", function()
    dead_warning()
end)
menu.toggle_loop(otherlist, "禁用通知", {}, "将禁止小地图上方通知", function()
    HUD.THEFEED_HIDE_THIS_FRAME()
end)
menu.toggle(otherlist, "隐藏GUI", {}, "", function(on)
	if on then
		menu.trigger_commands("screenshot on")
	else
		menu.trigger_commands("screenshot off")
	end
end)
appmenu.Ultion.ForceCloudSave = menu.action(otherlist, "强制云保存", {}, "强制进行云同步", function()
    STATS.STAT_SAVE(0, false, 3, 0)
end)
watermark = menu.list(otherlist, '游戏水印', {}, '为视频图片添加水印保护你的成果')
    menu.toggle_loop(watermark, "开启", {}, "", function()
        watermark_toggle()
    end)
    menu.divider(watermark, "设置")
        pos_settings = menu.list(watermark, "位置", {}, "")
            menu.slider(pos_settings, "x坐标", {"watermark-x"}, "", -100000, 100000, watermark_pos.x * 10000, 10, function(x_)
                watermark_x(x_)
            end)
            menu.slider(pos_settings, "y坐标", {"watermark-y"}, "", -100000, 100000, watermark_pos.y * 10000, 10, function(y_)
                watermark_y(y_)
            end)
            menu.slider(pos_settings, "背景长度", {"watermark-addx"}, "", -100000, 100000, watermark_settings.add_x * 10000, 10, function(x_)
                watermark_bgx(x_)
            end)
            menu.slider(pos_settings, "背景宽度", {"watermark-addy"}, "", -100000, 100000, watermark_settings.add_y * 10000, 10, function(y_)
                watermark_bgy(y_)
            end)
        watermarkcolor_settings = menu.list(watermark, "颜色", {}, "")
            local rgb_background = menu.colour(watermarkcolor_settings, '背景颜色', {'watermark-bg_color'}, '', watermark_settings.bg_color, true, function(col)
                watermark_bgc(col)
            end)
            local rgb_text = menu.colour(watermarkcolor_settings, '文本颜色', {'watermark-tx_color'}, '', watermark_settings.tx_color, true, function(col)
                watermark_txtc(col)
            end)
    menu.divider(watermark, "附加")
        menu.list_select(watermark, '第一标签', {}, '更改水线中的第一个标签', marklabel_name, watermark_settings.show_firstl, function (value, menu_name, prev_value, click_type)
            watermark_lable(value, menu_name, prev_value, click_type)
        end)
        menu.toggle(watermark, '昵称', {}, '在水印中显示您的昵称', function(val)
            watermark_name(val)
        end, watermark_settings.show_name)
        menu.toggle(watermark, '玩家人数', {}, '在水印中显示玩家人数', function(val)
            watermark_players(val)
        end, watermark_settings.show_players)
        menu.toggle(watermark, '时间', {}, '在水印中显示系统时间', function(val)
            watermark_time(val)
        end, watermark_settings.show_date)

        menu.action(otherlist, "IP查询", {}, "", function()
            local label = util.register_label("请正确输入IP地址")
	        local input = get_input_from_screen_keyboard(label, 16, "")
            if input == "" then return end
            QueryIP(input)
        end)


menu.toggle_loop(otherlist, "显示轴向", {}, "", function()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, pos.x + 2, pos.y, pos.z, 255, 0, 0, 255) --x
    GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, pos.x, pos.y + 2, pos.z, 0, 255, 0, 255) --y
    GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 2, 0, 0, 255, 255) --z
end)

wasdww = menu.list(otherlist, '按键显示', {}, '')
    menu.toggle_loop(wasdww, '打开', {}, '', function() 
        key_display()
    end)
    menu.slider(wasdww, 'X轴', {''}, '',1 , 10000, overlay_x * 10000, 20, function(value)
        overlay_x = value / 10000
    end)
    menu.slider(wasdww, 'Y轴', {''}, '',1 , 10000, overlay_y * 10000, 20, function(value)
        overlay_y = value / 10000
    end)
    menu.slider(wasdww, '大小', {''}, '',1 , 10000, 300, 20, function(value)
        size = value / 10000
        boxMargin = size / 7
    end)

kongzhitai = menu.list(otherlist, "控制台", {}, "")
    menu.toggle_loop(kongzhitai, "绘制控制台", {}, "", function()
        Draw_console()
    end)
    menu.slider(kongzhitai, "最大显示字数", {}, "", 1, 200, 110, 1, function(s)
        console_max_chars(s)
    end)
    menu.slider(kongzhitai, "最大显示行数", {}, "", 1, 60, 25, 1, function(s)
        console_max_lines(s)
    end)
    menu.slider_float(kongzhitai, "字体大小", {}, "", 1, 100, 45, 1, function(s)
        console_font_size(s)
    end)
    menu.colour(kongzhitai, "字体颜色", {"nconsoletextcolor"}, "", 0.27, 1, 1, 1, true, function(on_change)
        console_text_color = on_change
    end)
    menu.colour(kongzhitai, "背景颜色", {"nconsolebgcolor"}, "", 0, 0, 0, 0.5, true, function(on_change)
        console_bg_color = on_change
    end)

pendants = menu.list(otherlist, '小挂件', {}, '')
    menu.toggle(pendants, "显示logo", {}, "", function(toggled)
        show_logo(toggled)
    end)
    menu.toggle(pendants, "Tom&Jerry", {}, "", function(toggled)
        show_Tom(toggled)
    end)
    illustration = menu.list(pendants, '插图', {}, '')
        local illustration_num = 1
        local ill_x = 0.5
        local ill_y = 0.5
        local ill_size = 0.1
        local scrx, scry = directx.get_client_size()
        local illus_header = directx.create_texture(filesystem.resources_dir() .. "/SakuraScript/illustrations/1.png")
        menu.toggle_loop(illustration, "开启", {}, "", function()
            directx.draw_texture(illus_header, ill_size, ill_size, 0.5, 0.5, ill_x, ill_y, 0, 1, 1, 1, 1)
        end)
        menu.slider(illustration, "X位置", { "illx" }, "", 0, math.floor(scrx), math.floor(scrx/2), 10, function(s)
            ill_x = s/scrx
        end)
        menu.slider(illustration, "Y位置", { "illy" }, "", 0, math.floor(scry), math.floor(scry/2), 10, function(s)
            ill_y = s/scry
        end)
        menu.slider_float(illustration, "尺寸", { "illsize" }, "", 0, 200, 80, 1, function(s)
            ill_size = s/800
        end)
        menu.click_slider(illustration, "序号", {}, "", 1, 14, 1, 1, function(s)
            illus_header = directx.create_texture(filesystem.resources_dir() .. "/SakuraScript/illustrations/"..s..".png")
        end)

    kanalogo = menu.list(pendants, '康娜', {}, '')
        menu.toggle(kanalogo, "开启", {}, "", function(on)
            GIF_kana(on)
        end)
        menu.slider(kanalogo, "x坐标", {"logocoord-x"}, "", -100, 100, 86, 1, function(x_)
            logocoord.x = x_ / 100
        end)
        menu.slider(kanalogo, "y坐标", {"logocoord-y"}, "", -100, 100, 57, 1, function(y_)
            logocoord.y = y_ / 100
        end)
        menu.slider(kanalogo, "图标过渡帧率", {}, "", 1, 60, 10, 1, function(value)
            logocoord.fps = 1000 / value
        end)
    xiaohuangrenlogo = menu.list(pendants, '小黄人', {}, '')
        menu.toggle(xiaohuangrenlogo, "开启", {}, "", function(on)
            GIF_xiaohuangren(on)
        end)
        menu.slider(xiaohuangrenlogo, "x坐标", {"logocoord1-x"}, "", -100, 100, 86, 1, function(x_)
            logocoord1.x = x_ / 100
        end)
        menu.slider(xiaohuangrenlogo, "y坐标", {"logocoord1-y"}, "", -100, 100, 57, 1, function(y_)
            logocoord1.y = y_ / 100
        end)
        menu.slider(xiaohuangrenlogo, "图标过渡帧率", {}, "", 1, 60, 15, 1, function(value)
            logocoord1.fps = 1000 / value
        end)

menu.action(otherlist, "关闭GTAV", {}, "退出游戏并在下次重新启动时下载新的社交俱乐部更新", function()
    MISC.QUIT_GAME()
end)
menu.action(otherlist, "重启GTAV", {}, "", function()
    MISC1._RESTART_GAME()
end)
menu.action(otherlist, "快速关闭GTAV", {}, "正如你所见,秒关GTA5", function()
    exit_game()
end)

menu.hyperlink(otherlist, "官方网站", "https://blog.cnsakura.top", "")
menu.action(otherlist, "保存配置", {}, "仅支持部分功能(即帮助文本中包含'[配置]')", function()
    save_config()
end)

----资源列表
menu.hyperlink(ResourceList, "沙耶卡网", "https://sycheats.com/", "")
menu.hyperlink(ResourceList, "西瓜卡网", "https://xggg.online/", "")
menu.hyperlink(ResourceList, "不笑猫卡网", "https://buxiaomao.top/", "")
menu.hyperlink(ResourceList, "旧梦卡网", "https://fuzhuzhijia.vip/", "")


--在线玩家
players.dispatch_on_join()

----结束
util.on_stop(function()
    --ufo
    if UFO.exists() then
        UFO.destroy()
    end
    if GuidedMissile.exists() then
        GuidedMissile.destroy()
    end
    if OrbitalCannon.exists() then
        OrbitalCannon.destroy()
    end
----
    util.log("[Sakura] 脚本已关闭")
end)

lockapp()
while true do --此处的函数循环中不能存在wait,否则导致其他函数收到阻碍
    --保镖方框绘制
        bodyguardMenu:onTick()
    --Guided,ufo,
        GuidedMissile.mainLoop()
        UFO.mainLoop()
        OrbitalCannon.mainLoop()
    --water,air,walk
        all_drive_style()
    --blacklist
        Black_list()
----
    util.yield()
end