
SCRIPT_VERSION = 12.6
INT_MIN = -2147483648
INT_MAX = 2147483647

--script_globals
Global_Base = {--https://github.com/YimMenu/YimMenu/blob/master/src/core/scr_globals.hpp

    Default = 262145, --(1.69) --Global_262145   util.joaat("CHARACTER_APPEARANCE_CHARGE")(freemode_global)

    SessionSwitchType = 1575035, --(1.69)  session2(Yimmenu)    NETWORK::NETWORK_SESSION_SET_UNIQUE_CREW_LIMIT(1)
    SessionSwitchCache = 1574589 + 2, --(1.69) --退回故事模式
    SessionSwitchState = 1574589, --(1.69)
    
    BullShark = 2672855, --(1.69) 牛鲨睾酮
    gpbd_fm_1 = 1845281, --派遣劫匪(1.69) (https://github.com/YimMenu/YimMenu/blob/master/src/core/scr_globals.hpp)
    gpbd_fm_3 = 1887305,--(1.69)
    launcher_global = 2699171, --召唤古奇gooch(1.69)
    Notification = -642704387, --虚假通知
    VehicleKick = -503325966, --载具踢出 PIM_RFMOC
    gun_van = 1949748, --厢型车(1.69)
    in_multiplayer = 79389, --允许当前车辆进入车库(1.69)  --g_bInMultiplayer (https://github.com/YimMenu/YimMenu/blob/6ec9d247431c7ca776122955125f6b60e796e9d9/src/core/scr_globals.hpp#L31)
    
    island_team_lives = 56798, --团队生命数(1.69) team_lives func_712 (https://github.com/TCRoid/Stand-Lua-RScript/blob/bdea45c70e097db0a6b140cabdefcb272f6fe4fe/lib/RScript/variables.lua#L787)
    global_team_lives = 26172, --团队生命数(1.69) iAdditionalTeamLives (https://github.com/TCRoid/Stand-Lua-RS-Missions/blob/main/RS_Missions.lua)

    --Vehicle Menus Globals(梅利威瑟服务类型)
    oVMYCar = 2738934,-- (1.69) --"freemode_global"
    vehicle_global = 1586521, -- (1.69) 索赔载具 https://github.com/YimMenu/YimMenu/blob/master/src/core/scr_globals.hpp
    NanoDrone = 1956920, -- (1.69) 纳米无人机 [cellphone_flashhand.c (func7)] https://github.com/4d72526f626f74/MrRobot/blob/main/MrRobot/utils/script_globals

    --其他全局
    Transaction_Global = 4537311, --事务处理程序 (1.69) trigger transaction global （https://github.com/SilentSal0/Silent-Night/blob/35ef151f9df3801bae6c0d804c5ed8c6b06e6430/Silent%20Night%20v1.69.lua#L300）

    --任务分红
    Cayo_cut = 1971648, -- (1.69) (https://github.com/CrazyZhang666/GTA5OnlineTools/tree/c2bf00804661a81917bd7656f6d306dc591ab795/GTA5MenuExtra/Views/HeistsEditor)
    Casino_Cut = 1964849, -- (1.69)
    Doomsday_Cut = 1960755, -- (1.69)
}
--战局名 & id
session_name = {
    {name = "加入 公开战局",session_id = 0},
    {name = "创建 公开战局",session_id = 1},
    {name = "创建 私人帮会战局",session_id = 2},
    {name = "创建 帮会战局",session_id = 3},
    {name = "创建 私人好友战局",session_id = 6},
    {name = "加入 加入好友",session_id = 9},
    {name = "创建 单人战局",session_id = 10},
    {name = "创建 仅限邀请战局",session_id = 11},
    {name = "加入 帮会战局",session_id = 12}
}


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

--Lua配置
LuaConfigName = {
    "host_sequence",
    "host_sequence_x",
    "host_sequence_y",
    "show_time",
    "script_name",
    "numfps",
    "show_entityinfo",
    "players_info",
    "infoverlay_x",
    "infoverlay_y",
    "auto_kick_adBot",
    "players_bar",
    "ped_Invincible_detection",
    "Watch_detection",
    "Voice_detection",
    "transport_detection",
    "use_wea_int",
    "self_Invincible",
    "veh_Invincible_detection",
    "block_transaction_error",
    "disable_world_limit",
    "change_mod_detection"
}

--自动加入游戏
invite_string = {
    "NT_INV",
    "NT_INV_FREE",
    "NT_INV_PARTY_INVITE",
    "NT_INV_PARTY_INVITE_MP",
    "NT_INV_PARTY_INVITE_MP_SAVE",
    "NT_INV_PARTY_INVITE_SAVE",
    "NT_INV_MP_SAVE",
    "NT_INV_SP_SAVE",
}

----获取导弹
obj_pp = {
    name = {{1,"小导弹"}, {2,"中导弹"}, {3,"大导弹"}, {4,"航空导弹"}, {5,"移除导弹"}},
    value = {"prop_cs_dildo_01", "prop_ld_bomb_01", "prop_sam_01" ,"h4_prop_h4_airmissile_01a"}
}


----载具附加
veh_attach_options = {{1,"附加到他载具上"}, {2,"他的载具附加到我的载具"}, {3,"我的载具附加到他的载具"}, {4,"分离载具"}}

----武器表
weapon_list = {
    {name = "骇入设备", hash = 485882440, model_hash = nil, max_ammo = 0},
    {name = "危害性汽油桶", hash = -1168940174, model_hash = nil, max_ammo = 0},
    {name = "肥料桶", hash = 406929569, model_hash = nil, max_ammo = 0},
    {name = "致幻剂包裹", hash = -135142818, model_hash = nil, max_ammo = 0},
    {name = "陶瓷手枪", hash = 727643628, model_hash = nil, max_ammo = 250},
    {name = "海军左轮手枪", hash = -1853920116, model_hash = nil, max_ammo = 250},
    {name = "佩里科手枪", hash = 1470379660, model_hash = nil, max_ammo = 250},
    {name = "WM 29 手枪", hash = 465894841, model_hash = nil, max_ammo = 250},
    {name = "战术冲锋枪", hash = 350597077, model_hash = nil, max_ammo = 250},
    {name = "军用步枪", hash = -1658906650, model_hash = nil, max_ammo = 250},
    {name = "重型步枪", hash = -947031628, model_hash = nil, max_ammo = 250},
    {name = "特制卡宾步枪", hash = -774507221, model_hash = nil, max_ammo = 250},
    {name = "战斗霰弹枪", hash = 94989220, model_hash = nil, max_ammo = 250},
    {name = "精确步枪", hash = 1853742572, model_hash = nil, max_ammo = 250},
    {name = "紧凑型电磁脉冲发射器", hash = -618237638, model_hash = nil, max_ammo = 250},
    {name = "拐杖糖", hash = 1703483498, model_hash = nil, max_ammo = 250},
    {name = "MK2 冲锋枪", hash = 2024373456, model_hash = -1747543897, max_ammo = 250},
    {name = "冲锋枪", hash = 736523883, model_hash = -500057996, max_ammo = 250},
    {name = "弹簧刀", hash = -538741184, model_hash = -963831200, max_ammo = 0},
    {name = "老式手枪", hash = 137902532, model_hash = -1124046276, max_ammo = 250},
    {name = "棒球棒", hash = -1786099057, model_hash = 32653987, max_ammo = 0},
    {name = "匕首", hash = -1834847097, model_hash = 601713565, max_ammo = 0},
    {name = "电击棒", hash = -624951259, model_hash = 0, max_ammo = 0},
    {name = "射手手枪", hash = -598887786, model_hash = -103789861, max_ammo = 250},
    {name = "信号枪", hash = 1198879012, model_hash = 1349014803, max_ammo = 20},
    {name = "古森柏冲锋枪", hash = 1627465347, model_hash = 574348740, max_ammo = 250},
    {name = "酒瓶", hash = -102323637, model_hash = 1150762982, max_ammo = 0},
    {name = "泵式霰弹枪", hash = 487013001, model_hash = 689760839, max_ammo = 250},
    {name = "微型冲锋枪", hash = -1121678507, model_hash = -972823051, max_ammo = 250},
    {name = "灭火器", hash = 101631238, model_hash = -171327159, max_ammo = 2000},
    {name = "突击步枪", hash = -1074790547, model_hash = 273925117, max_ammo = 250},
    {name = "寡妇制造者", hash = -1238556825, model_hash = -1450059032, max_ammo = 250},
    {name = "0.5口径手枪", hash = -1716589765, model_hash = -178484015, max_ammo = 250},
    {name = "双管霰弹枪", hash = -275439685, model_hash = 222483357, max_ammo = 250},
    {name = "战斗手枪", hash = 1593441988, model_hash = 403140669, max_ammo = 250},
    {name = "MK2卡宾利", hash = -86904375, model_hash = 1520780799, max_ammo = 250},
    {name = "撬棍", hash = -2067956739, model_hash = 1862268168, max_ammo = 0},
    {name = "手斧", hash = -102973651, model_hash = 1653948529, max_ammo = 0},
    {name = "火箭炮", hash = -1312131151, model_hash = -218858073, max_ammo = 20},
    {name = "电磁步枪", hash = -22923932, model_hash = -1876506235, max_ammo = 20},
    {name = "MK2 手枪", hash = -1075685676, model_hash = 995074671, max_ammo = 250},
    {name = "MK2 重型狙击步枪", hash = 177293209, model_hash = 619715967, max_ammo = 250},
    {name = "手电筒", hash = -1951375401, model_hash = -2016486256, max_ammo = 0},
    {name = "小刀", hash = -1716189206, model_hash = -1982443329, max_ammo = 0},
    {name = "邪恶冥王", hash = 1198256469, model_hash = 377247090, max_ammo = 250},
    {name = "MK2步枪", hash = 1785463520, model_hash = -1858300370, max_ammo = 250},
    {name = "烟花", hash = 2138347493, model_hash = 491091384, max_ammo = 20},
    {name = "掷弹手烟雾", hash = 1305664598, model_hash = -606683246, max_ammo = 20},
        --{name = "徒手", hash = -1569615261, model_hash = 0, max_ammo = 0},
    {name = "球", hash = 600439132, model_hash = -383950123, max_ammo = 1},
    {name = "重型手枪", hash = -771403250, model_hash = 1927398017, max_ammo = 250},
    {name = "重型霰弹枪", hash = 984333226, model_hash = -1209868881, max_ammo = 250},
    {name = "MK2突击步枪", hash = 961495388, model_hash = 1762764713, max_ammo = 250},
    {name = "台球杆", hash = -1810795771, model_hash = 559432947, max_ammo = 0},
    {name = "MK2 无托式步枪", hash = -2066285827, model_hash = 1415744902, max_ammo = 250},
    {name = "火神机枪", hash = 1119849093, model_hash = 422658457, max_ammo = 250},
    {name = "警棍", hash = 1737195953, model_hash = -1634978236, max_ammo = 0},
    {name = "重型左轮手枪", hash = -1045183535, model_hash = 914615883, max_ammo = 250},
    {name = "无托式步枪", hash = 2132975508, model_hash = -1288559573, max_ammo = 250},
    {name = "石斧", hash = 940833800, model_hash = -904678363, max_ammo = 0},
    {name = "高级步枪", hash = -1357824103, model_hash = -1707584974, max_ammo = 250},
    {name = "突击冲锋枪", hash = -270015777, model_hash = -473574177, max_ammo = 250},
    {name = "汽油桶", hash = 883325847, model_hash = 242383520, max_ammo = 4500},
    {name = "高尔夫球杆", hash = 1141786504, model_hash = -580196246, max_ammo = 0},
    {name = "战斗机枪", hash = 2144741730, model_hash = -739394447, max_ammo = 250},
    {name = "双动式左轮手枪", hash = -1746263880, model_hash = 2050882666, max_ammo = 250},
    {name = "土制炸弹", hash = -1169823560, model_hash = -173454011, max_ammo = 10},
    {name = "信号弹", hash = 1233104067, model_hash = -1564193152, max_ammo = 25},
    {name = "MK2 特制卡宾步枪", hash = -1768145561, model_hash = -1915245535, max_ammo = 250},
        --{name = "降落伞", hash = -72657034, model_hash = 1746997299, max_ammo = 0},
    {name = "催泪瓦斯", hash = -37975472, model_hash = 1591549914, max_ammo = 25},
    {name = "MK2 劣质手枪", hash = -2009644972, model_hash = -73050335, max_ammo = 250},
    {name = "雪球", hash = 126349499, model_hash = 1297482736, max_ammo = 10},
    {name = "铁锤", hash = 1317494643, model_hash = 64104227, max_ammo = 0},
    {name = "短管霰弹枪", hash = 2017895192, model_hash = -675841386, max_ammo = 250},
    {name = "卡宾步枪", hash = -2084633992, model_hash = 1026431720, max_ammo = 250},
    {name = "作战自卫冲锋枪", hash = 171789620, model_hash = -1393014804, max_ammo = 250},
    {name = "汽油弹", hash = 615608432, model_hash = -880609331, max_ammo = 25},
    {name = "黏弹", hash = 741814745, model_hash = -1110203649, max_ammo = 25},
    {name = "感应地雷", hash = -1420407917, model_hash = 1876445962, max_ammo = 5},
    {name = "突击霰弹枪", hash = -494615257, model_hash = 1255410010, max_ammo = 250},
    {name = "毒气弹", hash = -1600701090, model_hash = 1591549914, max_ammo = 25},
    {name = "手榴弹", hash = -1813897027, model_hash = 290600267, max_ammo = 25},
    {name = "狙击步枪", hash = 100416529, model_hash = 346403307, max_ammo = 250},
    {name = "MK2 战斗机枪", hash = -608341376, model_hash = -1325136207, max_ammo = 250},
    {name = "制导火箭发射器", hash = 1672152130, model_hash = 1901887007, max_ammo = 10},
    {name = "手指虎", hash = -656458692, model_hash = -1288968684, max_ammo = 0},
    {name = "榴弹发射器", hash = -1568386805, model_hash = -606683246, max_ammo = 20},
    {name = "射手步枪", hash = -952879014, model_hash = -1711248638, max_ammo = 250},
    {name = "重型狙击步枪", hash = 205991906, model_hash = -746966080, max_ammo = 250},
    {name = "微型冲锋枪", hash = 324215364, model_hash = -1056713654, max_ammo = 250},
    {name = "紧凑型榴弹发射器", hash = 125959754, model_hash = -1523553483, max_ammo = 20},
    {name = "雪球发射器", hash = 62870901, model_hash = 0, max_ammo = 20},
    {name = "机枪", hash = -1660422300, model_hash = -2056364402, max_ammo = 250},
    {name = "战斗斧", hash = -853065399, model_hash = -888555534, max_ammo = 0},
    {name = "紧凑型步枪", hash = 1649403952, model_hash = 1931114084, max_ammo = 250},
    {name = "手枪", hash = 453432689, model_hash = 1467525553, max_ammo = 250},
    {name = "特制卡宾枪", hash = -1063057011, model_hash = -1745643757, max_ammo = 250},
    {name = "穿甲手枪", hash = 584646201, model_hash = 905830540, max_ammo = 250},
    {name = "老式火枪", hash = -1466123874, model_hash = 1652015642, max_ammo = 250},
    {name = "冲锋霰弹枪", hash = -1654528753, model_hash = -1598212834, max_ammo = 250},
    {name = "开山刀", hash = -581044007, model_hash = -1713889927, max_ammo = 0},
    {name = "MK2 泵动时霰弹枪", hash = 1432025498, model_hash = -1100561005, max_ammo = 250},
    {name = "电击枪", hash = 1171102963, model_hash = 1609356763, max_ammo = 250},
    {name = "冲锋手枪", hash = -619010992, model_hash = -331545829, max_ammo = 250},
    {name = "扳手", hash = 419712736, model_hash = -1145324273, max_ammo = 0},
    {name = "原子能枪", hash = -1355376991, model_hash = -697859071, max_ammo = 20},
    {name = "MK2 重型左轮手枪", hash = -879347409, model_hash = -229787679, max_ammo = 250},
    {name = "劣质手枪", hash = -1076751822, model_hash = 339962010, max_ammo = 250},
    {name = "冲锋霰弹枪", hash = 317205821, model_hash = 1380588314, max_ammo = 250}
}

--交易事务
transactions = {
    {name = "15M (Bend Job)", hash = 0x176D9D54, amount = 15000000},
    {name = "15M (Bend Bonus)", hash = 0xA174F633, amount = 15000000},
    {name = "15M (Criminal Mastermind)", hash = 0x3EBB7442, amount = 15000000},
    {name = "15M (Gangpos Mastermind)", hash = 0x23F59C7C, amount = 15000000},
    {name = "7M (Gang)", hash = 0xED97AFC1, amount = 7000000},
    {name = "3.6M (Casino Heist)", hash = 0xB703ED29, amount = 3619000},
    {name = "3M (Agency Story)", hash = 0xBD0D94E3, amount = 3000000},
    {name = "3M (Gangpos Mastermind)", hash = 0x370A42A5, amount = 3000000},
    {name = "2.5M (Gang)", hash = 0x46521174, amount = 2550000},
    {name = "2.5M (Island Heist)", hash = 0xDBF39508, amount = 2550000},
    {name = "2M (Gangpos Award Order)", hash = 0x32537662, amount = 2000000},
    {name = "2M (Heist Awards)", hash = 0x8107BB89, amount = 2000000},
    {name = "2M (Tuner Robbery)", hash = 0x921FCF3C, amount = 2000000},
    {name = "2M (Business Hub)", hash = 0x4B6A869C, amount = 2000000},
    {name = "1.5M (Gangpos Loyal Award)", hash = 0x33E1D8F6, amount = 1500000},
    {name = "1.2M (Boss Agency)", hash = 0xCCFA52D, amount = 1200000},
    {name = "1M (Music Trip)", hash = 0xDF314B5A, amount = 1000000},
    {name = "1M (Daily Objective Event)", hash = 0x314FB8B0, amount = 1000000},
    {name = "1M (Daily Objective)", hash = 0xBFCBE6B6, amount = 1000000},
    {name = "1M (Juggalo Story Award)", hash = 0x615762F1, amount = 1000000},
    {name = "700K (Gangpos Loyal Award)", hash = 0xED74CC1D, amount = 700000},
    {name = "680K (Betting)", hash = 0xACA75AAE, amount = 680000},
    {name = "620K (Vehicle Export)", hash = 0xEE884170, amount = 620000},
    {name = "500K (Casino Straight Flush)", hash = 0x059E889DD, amount = 500000},
    {name = "500K (Juggalo Story)", hash = 0x05F2B7EE, amount = 500000},
    {name = "400K (Cayo Heist Award Professional)", hash = 0xAC7144BC, amount = 400000},
    {name = "400K (Cayo Heist Award Cat Burglar)", hash = 0xB4CA7969, amount = 400000},
    {name = "400K (Cayo Heist Award Elite Thief)", hash = 0xF5AAD2DE, amount = 400000},
    {name = "400K (Cayo Heist Award Island Thief)", hash = 0x1868FE18, amount = 400000},
    {name = "350K (Casino Heist Award Elite Thief)", hash = 0x7954FD0F, amount = 350000},
    {name = "300K (Casino Heist Award All Rounder)", hash = 0x234B8864, amount = 300000},
    {name = "300K (Casino Heist Award Pro Thief)", hash = 0x2EC48716, amount = 300000},
    {name = "300K (Ambient Job Blast)", hash = 0xC94D30CC, amount = 300000},
    {name = "300K (Premium Job)", hash = 0xFD2A7DE7, amount = 300000},
    {name = "270K (Smuggler Agency)", hash = 0x1B9AFE05, amount = 270000},
    {name = "250K (Casino Heist Award Professional)", hash = 0x5D7FD908, amount = 250000},
    {name = "250K (Fixer Award Agency Story)", hash = 0x87356274, amount = 250000},
    {name = "200K (DoomsDay Finale Bonus)", hash = 0x9145F938, amount = 200000},
    {name = "200K (Action Figures)", hash = 0xCDCF2380, amount = 200000},
    {name = "190K (Vehicle Sales)", hash = 0xFD389995, amount = 190000},
    {name = "180K (Jobs)", hash = -0x3D3A1CC7, amount = 180000},
    {name = "50K (unknow)", hash = 0x610F9AB4, amount = 50000}
}
task_transactions = {
    {name = "Unknow(15M)", task_name = "SERVICE_EARN_BEND_JOB", value = 15000000},
    {name = "公寓抢劫(15M)", task_name = "SERVICE_EARN_JOB_BONUS",value = 15000000},-- 公寓抢劫
    {name = "公寓抢劫首次登场(10W)", task_name = "SERVICE_EARN_JOB_BONUS_FIRST_TIME_BONUS",value = 100000},--公寓抢劫首次登场
    {name = "按部就班&忠诚伙伴(2M)", task_name = "SERVICE_EARN_JOB_BONUS_HEIST_AWARD",value = 2000000},-- 按部就班&忠诚伙伴
    {name = "按部就班2(1M)", task_name = "SERVICE_EARN_GANGOPS_AWARD_ORDER",value = 1000000},-- 按部就班2
    {name = "忠诚伙伴2(15W)", task_name = "SERVICE_EARN_GANGOPS_AWARD_LOYALTY_AWARD_2",value = 150000}, --忠诚伙伴2
    {name = "忠诚伙伴3(35W)", task_name = "SERVICE_EARN_GANGOPS_AWARD_LOYALTY_AWARD_3",value = 350000},--忠诚伙伴3
    {name = "忠诚伙伴4(75W)", task_name = "SERVICE_EARN_GANGOPS_AWARD_LOYALTY_AWARD_4",value = 750000},--忠诚伙伴4
    {name = "犯罪之神(10M)", task_name = "SERVICE_EARN_JOB_BONUS_CRIMINAL_MASTERMIND",value = 10000000},-- 犯罪之神
    {name = "犯罪之神2(1.5M)", task_name = "SERVICE_EARN_GANGOPS_AWARD_MASTERMIND_2",value = 1500000}, --犯罪之神2
    {name = "犯罪之神3(7M)", task_name = "SERVICE_EARN_GANGOPS_AWARD_MASTERMIND_3",value = 7000000},--犯罪之神3
    {name = "犯罪之神4(7.5M)", task_name = "SERVICE_EARN_GANGOPS_AWARD_MASTERMIND_4",value = 7500000},--犯罪之神4
    {name = "末日豪劫(2.5M)", task_name = "SERVICE_EARN_GANGOPS_FINALE",value = 2550000},--末日豪劫
    {name = "末日豪劫 -数据泄露首次登场(10W)", task_name = "SERVICE_EARN_GANGOPS_AWARD_FIRST_TIME_XM_BASE",value = 100000},--末日豪劫 -数据泄露首次登场
    {name = "末日豪劫 - 波格丹危机首次登场(10W)", task_name = "SERVICE_EARN_GANGOPS_AWARD_FIRST_TIME_XM_SUBMARINE",value = 100000}, --末日豪劫 - 波格丹危机首次登场
    {name = "末日豪劫 -末日将至首次登场(10W)", task_name = "SERVICE_EARN_GANGOPS_AWARD_FIRST_TIME_XM_SILO", value = 100000}, --末日豪劫 -末日将至首次登场
    {name = "配角也疯狂2(10W)", task_name = "SERVICE_EARN_GANGOPS_AWARD_SUPPORTING",value = 100000},--配角也疯狂2
    {name = "名钻赌场豪劫(3.6M)", task_name = "SERVICE_EARN_CASINO_HEIST_FINALE",value = 3619000}, --名钻赌场豪劫
    {name = "佩里科岛(2.5M)", task_name = "SERVICE_EARN_ISLAND_HEIST_FINALE",value = 2550000}, --佩里科岛
    {name = "改装铺合约(2M)", task_name = "SERVICE_EARN_TUNER_ROBBERY_FINALE",value = 2000000}, --改装铺合约
    {name = "别惹德瑞(2.5M)", task_name = "SERVICE_EARN_AGENCY_STORY_FINALE",value = 2500000} --别惹德瑞
}

----设置玩家等级
player_levels = {
    level0 = 1,
    level30 = 177100,
    level60 = 625400,
    level90 = 1308100,
    level120 = 2165850,
    level150 = 3075600,
    level180 = 4030350
}

car_club_levels = {
    level0 = 5,
    level50 = 10540,
    level100 = 33665,
    level150 = 67830,
    level200 = 117430
}

----行走风格
movement_style = {
    name = {
        {1, "正常"},
        {2, "Brisk Walk"},
        {3, "Garbageman"},
        {4, "跑步"},
        {5, "Garbageman 2"},
        {6, "Lean Forward"},
        {7, "Slow Lean Forward"},
        {8, "Michael"},
        {9, "Female flee"},
        {10, "害怕"},
        {11, "Sexy"},
        {12, "莱斯特抢劫"},
        {13, "Injured"},
        {14, "莱斯特手杖"},
        {15, "Fast Wide Arms"},
        {16, "Tipsy 2"},
        {17, "Tazered"},
        {18, "Brave"},
        {19, "Casual"},
        {20, "Moderately Drunk"},
        {21, "Drunk 1"},
        {22, "Moderately Drunk"},
        {23, "Slightly Drunk"},
        {24, "Very Drunk"},
        {25, "Male fire"},
        {26, "Upright"},
        {27, "Head Down"},
        {28, "Speed Walk"},
        {29, "Jog (when jogging)"},
        {30, "Prison guard"},
        {31, "Regular Alternate"},
        {32, "MOVE_P_M_ONE_BRIEFCASE"},
        {33, "Jantior"},
        {34, "傲慢"},
        {35, "move_ped_bucket"},
        {36, "蹲伏"},
        {37, "move_ped_mop"},
        {38, "Femme Masculine"},
        {39, "Femme Feminine"},
        {40, "Gangster 1 Masculine"},
        {41, "Gangster 1 Feminine"},
        {42, "Posh Masculine"},
        {43, "Posh Feminine"},
        {44, "Tough Masculine"},
        {45, "Tough Feminine"},
        {46, "Wide Stance"}
    },
    value = {
        "normal",--自定义名字(用于重设风格)
        "ANIM_GROUP_MOVE_LEMAR_ALLEY",
        "clipset@move@trash_fast_turn",
        "FEMALE_FAST_RUNNER",
        "missfbi4prepp1_garbageman",
        "move_characters@franklin@fire",
        "move_characters@Jimmy@slow@",
        "move_characters@michael@fire",
        "move_f@flee@a",
        "move_f@scared",
        "move_f@sexy@a",
        "move_heist_lester",
        "move_injured_generic",
        "move_lester_CaneUp",
        "move_m@bag",
        "MOVE_M@BAIL_BOND_NOT_TAZERED",
        "MOVE_M@BAIL_BOND_TAZERED",
        "move_m@brave",
        "move_m@casual@d",
        "move_m@drunk@moderatedrunk",
        "MOVE_M@DRUNK@MODERATEDRUNK",
        "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP",
        "MOVE_M@DRUNK@SLIGHTLYDRUNK",
        "MOVE_M@DRUNK@VERYDRUNK",
        "move_m@fire",
        "move_m@gangster@var_e",
        "move_m@gangster@var_f",
        "move_m@gangster@var_i",
        "move_m@JOG@",
        "MOVE_M@PRISON_GAURD",
        "MOVE_P_M_ONE",
        "MOVE_P_M_ONE_BRIEFCASE",
        "move_p_m_zero_janitor",
        "move_p_m_zero_slow",
        "move_ped_bucket",
        "move_ped_crouched",
        "move_ped_mop",
        "MOVE_M@FEMME@",
        "MOVE_F@FEMME@",
        "MOVE_M@GANGSTER@NG",
        "MOVE_F@GANGSTER@NG",
        "MOVE_M@POSH@",
        "MOVE_F@POSH@",
        "MOVE_M@TOUGH_GUY@",
        "MOVE_F@TOUGH_GUY@",
        "ANIM_GROUP_MOVE_BALLISTIC"
    }
}

TransitionState = {
    [0] = "EMPTY",
    [1] = "单人模式上升",
    [2] = "多人模式上升",
    [3] = "创造模式上升",
    [4] = "HUD预检查",
    [5] = "等待HUD退出",
    [6] = "等待传送",
    [7] = "单人模式下降",
    [8] = "多人模式下降",
    [9] = "取消加入",
    [10] = "重试加载",
    [11] = "重试加载1",
    [12] = "重试加载2",
    [13] = "重试加载3",
    [14] = "重试加载4",
    [15] = "等待邀请",
    [16] = "加入自由模式前检查",
    [17] = "寻找新自由模式战局",
    [18] = "预加入新自由模式战局",
    [19] = "确认加入自由模式战局",
    [20] = "等待加入自由模式战局",
    [21] = "创建并进入战局",
    [22] = "自由模式启动脚本",
    [23] = "自由模式满员检查",
    [24] = "启动自由模式脚本",
    [25] = "自由模式创建玩家",
    [26] = "自由模式准备就绪",
    [27] = "自由模式下降",
    [28] = "视频结束",
    [29] = "自由模式配置玩家",
    [30] = "自由模式迁移运行",
    [31] = "自由模式如何终止",
    [32] = "创造模式启动脚本前检查",
    [33] = "启动创造模式脚本",
    [34] = "创造模式创建玩家",
    [35] = "创造模式准备就绪",
    [36] = "创造模式下降",
    [37] = "创造模式配置玩家",
    [38] = "创造模式迁移运行",
    [39] = "加入测试战局前检查",
    [40] = "寻找新测试战局",
    [41] = "寻找新测试主机",
    [42] = "预加入新测试战局",
    [43] = "尝试主机测试战局",
    [44] = "确认加入测试战局",
    [45] = "等待加入测试战局",
    [46] = "启动测试战局脚本",
    [47] = "测试战局创建玩家",
    [48] = "测试战局准备就绪",
    [49] = "测试战局下降",
    [50] = "测试战局配置玩家",
    [51] = "测试战局迁移运行",
    [52] = "测试战局如何终止",
    [53] = "退出当前战局",
    [54] = "等待设置战局",
    [55] = "终止单人模式",
    [56] = "等待终止单人模式",
    [57] = "踢出并终止战局",
    [58] = "终止战局",
    [59] = "等待终止战局",
    [60] = "终止战局并保持",
    [61] = "终止战局并进入保持状态",
    [62] = "团队交换检查",
    [63] = "返回单人模式",
    [64] = "等待单人模式开始",
    [65] = "等待外部终止调用",
    [66] = "终止主过渡",
    [67] = "等待不完整加载确认",
    [68] = "DLC介绍视频",
    [69] = "加载个人载具"    
}

----实体附加枪
Objn = {
    name = {
        {1,'义警'},
        {2,'斜面魔宝'},
        {3,'乔氏 尖锥魅影'},
        {4,'BR8'},
        {5,'袒胸女性'},
        {6,'裸体教徒'},
        {7,'丁卡 微托经典版'},
        {8,'太空码头工'},
        {9,'天煞'},
        {10,'假阳具'},
        {11,'圣诞树'},
        {12,'黄色油桶'},
        {13,'圣诞怪兽'},
        {14,'兔子'},
        {15,'兽人'}
    },
    value = {
        'vigilante',
        'dune4',
        'phantom2',
        'openwheel1',
        'a_f_y_topless_01',
        'a_m_m_acult_01',
        'veto',
        'dune2',
        'lazer',
        'prop_cs_dildo_01',
        'xm_prop_x17_xmas_tree_int',
        'prop_barrel_03d',
        'U_M_M_YuleMonster',
        'A_C_Rabbit_02',
        'IG_Furry',
    }
}


----移除所有摄像头
CamList = {
    MISC.GET_HASH_KEY("prop_cctv_cam_01a"),
    MISC.GET_HASH_KEY("prop_cctv_cam_01b"),
    MISC.GET_HASH_KEY("prop_cctv_cam_02a"),
    MISC.GET_HASH_KEY("prop_cctv_cam_03a"),
    MISC.GET_HASH_KEY("prop_cctv_cam_04a"),
    MISC.GET_HASH_KEY("prop_cctv_cam_04c"),
    MISC.GET_HASH_KEY("prop_cctv_cam_05a"),
    MISC.GET_HASH_KEY("prop_cctv_cam_06a"),
    MISC.GET_HASH_KEY("prop_cctv_cam_07a"),
    MISC.GET_HASH_KEY("prop_cs_cctv"),
    MISC.GET_HASH_KEY("p_cctv_s"),
    MISC.GET_HASH_KEY("hei_prop_bank_cctv_01"),
    MISC.GET_HASH_KEY("hei_prop_bank_cctv_02"),
    MISC.GET_HASH_KEY("ch_prop_ch_cctv_cam_02a"),
    MISC.GET_HASH_KEY("xm_prop_x17_server_farm_cctv_01"),
    MISC.GET_HASH_KEY("prop_cctv_pole_04"),
}

----NPC选项
pedToggleLoops = {
    {name = '摔倒NPC', command = 'ragdollPeds', description = '让附近的所有NPC都摔倒.', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        PED.SET_PED_TO_RAGDOLL(ped, 2000, 2000, 0, true, true, true)
    end},
    {name = '死亡接触', command = 'deathTouch', description = '杀死所有碰到您的NPC', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) or PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not ENTITY.IS_ENTITY_TOUCHING_ENTITY(ped, PLAYER.PLAYER_PED_ID()) then return end
        ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
    end},
    {name = '寒冷NPC', command = 'coldPeds', description = '移除附近NPC的热特征', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        PED.SET_PED_HEATSCALE_OVERRIDE(ped, 0)
    end},
    {name = 'NPC喇叭加速', command = 'npcHornBoost', description = '当NPC按喇叭的时候加速它们的载具.', action = function(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not AUDIO.IS_HORN_ACTIVE(vehicle) then return end
        AUDIO.SET_AGGRESSIVE_HORNS(true) --Makes pedestrians sound their horn longer, faster and more agressive when they use their horn.
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
    end, onStop = function()
        AUDIO.SET_AGGRESSIVE_HORNS(false)
    end},
    {name = 'NPC警笛加速', command = 'npcSirenBoost', description = '当NPC响起警车的警笛的时候加速它们的载具.', action = function(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not VEHICLE.IS_VEHICLE_SIREN_ON(vehicle) then return end
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
    end}
}


----藏匿屋密码
hidden_house_password = {
    [-73329357]  = "01-23-45", --xm3_prop_xm3_code_01_23_45
    [1433270535] = "02-12-87",
    [944906360]  = "05-02-91",
    [-1248906748] = "24-10-81",
    [1626709912] = "28-03-98",
    [921471402]  = "28-11-97",
    [-646417257] = "44-23-37",
    [-158146725] = "72-68-83",
    [1083248297] = "73-27-38",
    [2104921722] = "77-79-73",
}

----载具导弹
vehweapon_name = {
    {1,util.get_label_text("WT_V_SPACERKT")},
    {2,util.get_label_text("WT_RAYPISTOL")},
    {3,util.get_label_text("WT_FWRKLNCHR")},
    {4,util.get_label_text("WT_V_TANK")},
    {5,util.get_label_text("WT_V_PLRBUL")}
}

--投掷物发射器
throwablesTable = {
    name = {
        {1, "手榴弹"},
        {2, '黏弹'},
        {3, '感应地雷'},
        {4, '烟雾弹'},
        {5, '催泪瓦斯'},
        {6, '燃烧瓶'},
        {7, '信号弹'},
        {8, '雪球'},
        {9, '球'},
        {10, '土制炸弹'}
    },
    hash = {
        [1]  = util.joaat('weapon_grenade'),
        [2]  = util.joaat('weapon_stickybomb'),
        [3]  = util.joaat('weapon_proxmine'),
        [4]  = util.joaat('weapon_bzgas'),
        [5]  = util.joaat('weapon_smokegrenade'),
        [6]  = util.joaat('weapon_molotov'),
        [7]  = util.joaat('weapon_flare'),
        [8]  = util.joaat('weapon_snowball'),
        [9]  = util.joaat('weapon_ball'),
        [10] = util.joaat('weapon_pipebomb'),
    }
}

----冰淇凌盛宴
ice_entity = {
    name = {"钻石圣诞树","宝石圣诞树","五角星圣诞树","啤酒桶杯"},
    value = {"ch_prop_ch_diamond_xmastree","ch_prop_tree_01a","ch_prop_tree_02a","ch_prop_tree_03a"}
}


----设置天气
weather = {
    name = {"不更改","阳光明媚","晴朗","云","环境污染","雾天","阴天","雨天","雷雨天","雨晴天","温室天气","雪天","暴风雪","雪雾天","圣诞节","万圣节"},
    value = {"reset","EXTRASUNNY","CLEAR","CLOUDS","SMOG","FOGGY","OVERCAST","RAIN","THUNDER","CLEARING","NEUTRAL","SNOW","BLIZZARD","SNOWLIGHT","XMAS","HALLOWEEN"}
}

----电台
radio_station = {
    name = {
        {1,"布莱恩郡之声"}, {2,"蓝色方舟"},{3,"全球电台"},{4,"飞莲电台"},{5,"真相 91.1"},{6,"实验室电台"},
        {7,"明镜公园之音"},{8,"103.2 空间"},{9,"好麦坞大道电台"},{10,"金发洛圣都 97.8 电台"},{11,"洛圣都地下电台"},
        {12,"iFruit 电台"},{13,"自电台"},{14,"洛圣都摇滚台"},{15,"无止境流行乐电台"},{16,"洛圣都广播电台"},{17,"X 频道"},
        {18,"西海岸谈话电台"},{19,"叛逆电台"}, {20,"灵魂之蜡电台"},{21,"东洛电台"},{22,"西海岸经典"},
        {23,"媒体播放器"},{24,"音乐柜"},{25,"库尔特 FM"},{26,"放松依旧洛圣都"}
    },
    value = {
        "RADIO_11_TALK_02", "RADIO_12_REGGAE","RADIO_13_JAZZ", "RADIO_14_DANCE_02","RADIO_15_MOTOWN",
        "RADIO_20_THELAB","RADIO_16_SILVERLAKE","RADIO_17_FUNK","RADIO_18_90S_ROCK","RADIO_21_DLC_XM17",
        "RADIO_22_DLC_BATTLE_MIX1_RADIO","RADIO_23_DLC_XM19_RADIO","RADIO_19_USER","RADIO_01_CLASS_ROCK",
        "RADIO_02_POP","RADIO_03_HIPHOP_NEW","RADIO_04_PUNK","RADIO_05_TALK_01","RADIO_06_COUNTRY", 
        "RADIO_07_DANCE_01","RADIO_08_MEXICAN","RADIO_09_HIPHOP_OLD","RADIO_36_AUDIOPLAYER",
        "RADIO_35_DLC_HEI4_MLR", "RADIO_34_DLC_HEI4_KULT","RADIO_27_DLC_PRHEI4"
    }
}


----预设模型
my_model_list = {
    {"消防员", "-1229853272"},
    {"警察", "1581098148"},
    {"小狗戴恩", "1344679353"},
    {"太空游骑兵", "1011059922"},
    {"圣诞怪兽", "-751898707"},
    {"莱斯特", "2013139108"},
    {"麦克", "225514697"},
    {"富兰克林", "2602752943"},
    {"崔佛", "-1686040670"},
    {"丧尸", "-1404353274"},
    {"埃万重甲", "2431602996"},
    {"太空人", "3887273010"},
    {"宇航员", "-407694286"},
    {"肥婆", "1004114196"},
    {"医疗护理", "-1286380898"},
    {"大猴子", "-598109171"},
    {"FIB", "2072724299"},
    {"消防员", "-1229853272"},
    {"公路警察", "1939545845"},
    {"公路警察2", "1456041926"},
    {"警察女", "368603149"},
    {"警察男", "1581098148"},
    {"警察男1", "2141384740"},
    {"警察男2", "666086773"},
    {"囚犯", "2073775040"},
    {"海军人员1", "-220552467"},
    {"海军人员2", "1702441027"},
    {"海军人员3", "1925237458"},
    {"黑色行动", "2047212121"},
    {"装甲人员1", "-1782092083"},
    {"装甲人员2", "1669696074"},
    {"肌肉男", "-636391810"},
    {"海军陆战队", "1490458366"},
    {"超人", "880829941"},
    {"下头男", "1413662315"},
    {"耶稣", "-835930287"},
    {"小丑", "71929310"},
    {"SWAT", "-1920001264"}
}

----人物降落伞
Pparachute = {
    "Rainbow","Red","SeasideStripes","WidowMaker","Patriot","Blue","Black","Hornet","AirFocce","Desert","Shadow","HighAltitude","Airbone","Sunrise"
}
----载具降落伞
Vparachute = {
    name = {"降落伞1","降落伞2","降落伞3","降落伞4","雨伞1","雨伞2","雨伞3","雨伞4","路牌"},
    value = {
        [1] = "sr_prop_specraces_para_s_01",
        [2] = "p_parachute1_mp_dec",
        [3] = "gr_prop_gr_para_s_01",
        [4] = "imp_prop_impexp_para_s",
        [5] = "prop_beach_parasol_03",
        [6] = "prop_beach_parasol_02",
        [7] = "prop_beach_parasol_07",
        [8] = "prop_beach_parasol_09",
        [9] = "prop_sign_road_01a"
    }
}


----发送妓女
custom_hooker_options = {{1,"克隆玩家"}, {2,"莱斯特"}, {3,"特蕾西"}, {4,"贝克女士"}, {5,"裸女"}}

----粒子枪
particle_gund ={
    name = {
        {1,"小丑出现"},
        {2,"小丑死亡"},
        {3,"鬼火"},
        {4,"灭火器"}
    },
    value = {
        {lib = 'scr_rcbarry2', name = 'scr_clown_appears'},
        {lib = 'scr_rcbarry2', name = 'scr_clown_death'},
        {lib = 'core', name = 'ent_sht_petrol_fire'},
        {lib = 'core', name = 'ent_sht_extinguisher'} 
    }
}



----娱乐粒子效果
funptfx = {
    name = {
        {1,"小丑出现"},
        {2,"糖块"},
        {3,"金属碎片"},
        {4,"火焰"},
        {5,"赌场筹码"},
        {6,"香烟"},
        {7,"橙子雨"},
        {8,"火花"},
        {9,"泡沐雨"},
        {10,"硬币"},
        {11,"电线杆故障"},
        {12,"电器箱故障"},
        {13,"充气羽毛"},
        {14,"飘叶"},
        {15,"枫叶"},
        {16,"爆竹"},
        {17,"小丑喷射"},
        {18,"小丑花"},
        {19,"星空"},
        {20,"摇曳烟花"},
        {21,"光遇"}
    },
    value = {
        {"scr_rcbarry2","scr_clown_appears","5"},
        {"core","ent_dst_gen_gobstop","5"},
        {"core","ent_brk_metal_frag","5"},
        {"core","ent_sht_flame","5"},
        {"core","ent_dst_casino_chips","5"},
        {"core","ent_dst_cig_packets","5"},
        {"core","ent_col_tree_oranges","5"},
        {"core","ent_brk_sparking_wires","5"},
        {"core","water_boat_exit","5"},
        {"core","ent_brk_coins","5"},
        {"core","ent_sht_telegraph_pole","5"},
        {"core","ent_sht_electrical_box","5"},
        {"core","ent_dst_inflate_ring","2"},
        {"core","ent_sht_bush_foliage","5"},
        {"core","ent_col_bush_leaves","5"},
        {"scr_sm_counter","scr_sm_counter_chaff","1"},
        {"scr_rcbarry2", "muz_clown","1.5"},
        {"scr_rcbarry2", "scr_clown_bul","1.5"},
        {"scr_rcpaparazzo1","scr_mich4_firework_burst_spawn","1"},
        {"scr_indep_fireworks","scr_indep_firework_trail_spawn","1"},
        {"scr_ie_tw", "scr_impexp_tw_take_zone","1"}
    }
}

----手办背包
plushiepack_list = {
    {
        name = "Purple Cat",
        Prop = 'ch_prop_arcade_claw_plush_01a',
        PropPlacement =  {0.19, -0.15, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Green Cat",
        Prop = 'ch_prop_arcade_claw_plush_02a',
        PropPlacement =  {0.19, -0.15, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Blue Cat",
        Prop = 'ch_prop_arcade_claw_plush_03a',
        PropPlacement =  {0.19, -0.15, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Brown Cat",
        Prop = 'ch_prop_arcade_claw_plush_04a',
        PropPlacement =  {0.19, -0.15, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Yellow Cat",
        Prop = 'ch_prop_arcade_claw_plush_05a',
        PropPlacement =  {0.19, -0.15, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Red Cat",
        Prop = 'ch_prop_arcade_claw_plush_06a',
        PropPlacement =  {0.19, -0.15, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Princess",
        Prop = 'ch_prop_princess_robo_plush_07a',
        PropPlacement =  {0.19, -0.15, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Wasabi Cat",
        Prop = 'ch_prop_shiny_wasabi_plush_08a',
        PropPlacement =  {0.19, -0.15, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Space Ranger",
        Prop = 'xs_prop_trinket_republican_01a',
        PropPlacement =  {-0.0, -0.25, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Princess Figure",
        Prop = 'vw_prop_vw_colle_prbubble',
        PropPlacement =  {0.0, -0.2, 0.0, 0.0, 90.0, 0.0},
    },
    {
        name = "Plushie Sensei",
        Prop = 'sum_prop_sum_arcade_plush_09a',
        PropPlacement =  {0.19, -0.15, 0.0, 0.0, 90.0, 0.0},
    },
}


-----北杨克顿
North_Yankton = {
    "plg_01", "prologue01", "prologue01_lod", "prologue01c", "prologue01c_lod", "prologue01d", "prologue01d_lod", "prologue01e", "prologue01e_lod", "prologue01f", "prologue01f_lod", "prologue01g",
    "prologue01h", "prologue01h_lod", "prologue01i", "prologue01i_lod", "prologue01j", "prologue01j_lod", "prologue01k", "prologue01k_lod", "prologue01z", "prologue01z_lod", "plg_02", "prologue02", "prologue02_lod", 
    "plg_03", "prologue03", "prologue03_lod", "prologue03b", "prologue03b_lod", "prologue03_grv_dug", "prologue03_grv_dug_lod", "prologue_grv_torch", "plg_04", "prologue04", "prologue04_lod", "prologue04b", 
    "prologue04b_lod", "prologue04_cover", "des_protree_end", "des_protree_start", "des_protree_start_lod", "plg_05", "prologue05", "prologue05_lod", "prologue05b", "prologue05b_lod", "plg_06", "prologue06", 
    "prologue06_lod", "prologue06b", "prologue06b_lod", "prologue06_int", "prologue06_int_lod", "prologue06_pannel", "prologue06_pannel_lod", "prologue_m2_door", "prologue_m2_door_lod", "plg_occl_00", "prologue_occl", 
    "plg_rd", "prologuerd", "prologuerdb", "prologuerd_lod"
}


----粒子效果轰炸
Fxcore = {
    name = {
        {1,"混凝土碎块"},
        {2,"手榴弹"},
        {3,"闪光弹"},
        {4,"糖块"},
        {5,"血块"},
        {6,"金属碎片"},
        {7,"超大喷泉"},
        {8,"油"},
        {9,"相机快闪"},
        {10,"汽油泵爆炸"},
        {11,"燃烧瓶"},
        {12,"香烟(吐烟)"},
        {13,"木屑"},
        {14,"火花闪电"},
        {15,"大瀑布"},
        {16,"聚苯乙烯"},
        {17,"汽油"},
        {18,"火焰"},
        {19,"赌场筹码"},
        {20,"飞翔的香烟"},
        {21,"橙子雨"},
        {22,"载具刹车烟雾"},
        {23,"火花"},
        {24,"大爆炸"},
        {25,"灰尘"},
        {26,"垃圾报纸"},
        {27,"灭火器"},
        {28,"泼洒尿液"},
        {29,"泡沐雨"},
        {30,"水雾"},
        {31,"硬币"},
        {32,"铸造飞溅的铁水"},
        {33,"邮件"},
        {34,"蓝色射线"},
        {35,"灭火器水"},
        {36,"烟雾弹"},
        {37,"电线杆故障"},
        {38,"电磁脉冲"},
        {39,"电器箱故障"}
    },
    value = {
        "ent_dst_concrete_large",
        "exp_grd_grenade_lod",
        "exp_arc_grd_flashbang_lod",
        "ent_dst_gen_gobstop",
        "blood_stab",
        "ent_brk_metal_frag",
        "bul_water_heli",
        "ent_sht_oil",
        "ent_anim_paparazzi_flash",
        "exp_grd_petrol_pump",
        "exp_air_molotov",
        "ent_anim_cig_exhale_mth_car",
        "ent_dst_wood_chunky",
        "ent_dst_elec_fire_sp",
        "water_splash_plane_in",
        "ent_dst_polystyrene",
        "ent_sht_petrol",
        "ent_sht_flame",
        "ent_dst_casino_chips",
        "ent_dst_cig_packets",
        "ent_col_tree_oranges",
        "veh_respray_smoke",
        "ent_brk_sparking_wires",
        "exp_grd_sub_large",
        "ent_anim_dusty_hands",
        "ent_dst_rubbish",
        "exp_extinguisher",
        "liquid_splash_pee",
        "water_boat_exit",
        "ent_anim_bm_water_mist",
        "ent_brk_coins",
        "ent_amb_foundry_steam_spawn",
        "ent_dst_mail",
        "exp_xs_ray",
        "ent_sht_extinguisher_water",
        "weap_smoke_grenade",
        "ent_sht_telegraph_pole",
        "exp_sec_launched_emp",
        "ent_sht_electrical_box",
    }
}


-----水印
marklabel_name = {{1,'无'}, {2,'Sakura'}, {3,'Version'}, {4,'Stand'}, {5,'^_-'}, {6,'OwO'}}


----绘制血量条
drawoptions = {
    {1,"玩家"},
    {2,"行人"},
    {3,"玩家和行人"},
    {4,"主动瞄准时"}
}


----掉落足球
soccerball_models = {
    "stt_prop_stunt_soccer_sball",
    "stt_prop_stunt_soccer_lball",
    "stt_prop_stunt_soccer_ball"
}


----NPC在玩家面前自杀
traumatize = {
    name = {{1,"克隆玩家"},{2,"莱斯特"},{3,"西部马仔"}},
    value = {"self",1302784073,-927261102}
}


----重力实体枪
gravity_entity_gun = {
    name = {{1,"蔡徐坤"}, {2,"足球"}, {3,"水桶"}},
    value = {-422877666, -717142483, 1786752042}
}

----物体笼子
obj_table = {}
objsetcage = {
    name = {
        {1,'路牌1'},{2,'路牌2'},{3,'路牌3'},{4,'路牌4'},{5,'路牌5'},{6,'路牌6'},
        {7,'路牌7'},{8,'路牌8'},{9,'路牌9'},{10,'门1'},{11,'门2'},{12,'门3'},{13,'门4'},
        {14,'门5'},{15,'门6'},{16,'门7'},{17,'门8'},{18,'门9'},{19,'门10'},{20,'门11'},{21,'门12'},
        {22,'门13'},{23,'门14'},{24,'门15'},{25,'门16'},{26,'门17'},{27,'门18'},{28,'门19'}
    },
    value = {
        'prop_sign_road_01b','prop_sign_road_03b','prop_airport_sale_sign',
        'poro_06_sig1_c_source','prop_sign_road_03w','prop_sign_road_04zb',
        'prop_sign_road_04za','prop_sign_road_06s','prop_sign_road_restriction_10',
        'prop_mineshaft_door','ch_prop_ch_tunnel_door01a','apa_prop_ss1_mpint_garage2',
        'ch_prop_ch_vault_slide_door_lrg','ch_prop_ch_vault_slide_door_sm','v_ilev_carmod3door',
        'v_ilev_fh_slidingdoor','prop_ch2_05d_g_door','prop_com_ls_door_01',
        'prop_ql_revolving_door','prop_sc1_06_gate_l','prop_sec_gate_01d','gr_prop_gr_doorpart',
        'gr_prop_gr_fnclink_03e','ch_prop_arcade_fortune_door_01a','sum_prop_hangerdoor_01a',
        'h4_prop_office_elevator_door_01','p_gate_prison_01_s','prop_lrggate_02'
    }
}



----ped笼子
ped_cage_table = {}
pedset_cage = {
    name = {{1,"悲伤的耶稣"},{2,"莱斯特"},{3,"崔弗"}},
    value = {'u_m_m_jesus_01',"ig_lestercrest","player_two"}
}


----在车内生成NPC
full_with_options = {{1,"随机PED"}, {2,"警察"}, {3,"脱衣舞娘"}, {4,"拉马"}, {5,"莱斯特"}}


----敌对行人
Enemy_Weapons = {
	-- Shotguns
	VAULT_WMENUI_2 =
	{
		WT_SG_PMP = "weapon_pumpshotgun",
		WT_SG_PMP2 = "weapon_pumpshotgun_mk2",
		WT_SG_SOF = "weapon_sawnoffshotgun",
		WT_SG_BLP = "weapon_bullpupshotgun",
		WT_SG_ASL = "weapon_assaultshotgun",
		WT_MUSKET = "weapon_musket",
		WT_HVYSHOT = "weapon_heavyshotgun",
		WT_DBSHGN = "weapon_dbshotgun",
		WT_AUTOSHGN = "weapon_autoshotgun",
		WT_CMBSHGN = "weapon_combatshotgun",
	},
	-- Machine guns
	VAULT_WMENUI_3 =
	{
		WT_SMG_MCR = "weapon_microsmg",
		WT_MCHPIST = "weapon_machinepistol",
		WT_MINISMG = "weapon_minismg",
		WT_SMG = "weapon_smg",
		WT_SMG2 = "weapon_smg_mk2",
		WT_SMG_ASL = "weapon_assaultsmg",
		WT_COMBATPDW = "weapon_combatpdw",
		WT_MG = "weapon_mg",
		WT_MG_CBT = "weapon_combatmg",
		WT_MG_CBT2 = "weapon_combatmg_mk2",
		WT_GUSENBERG = "weapon_gusenberg",
		WT_RAYCARBINE = "weapon_raycarbine",
	},
	-- Rifles
	VAULT_WMENUI_4 =
	{
		WT_RIFLE_ASL = "weapon_assaultrifle",
		WT_RIFLE_ASL2 = "weapon_assaultrifle_mk2",
		WT_RIFLE_CBN = "weapon_carbinerifle",
		WT_RIFLE_CBN2 = "weapon_carbinerifle_mk2",
		WT_RIFLE_ADV = "weapon_advancedrifle",
		WT_RIFLE_SCBN = "weapon_specialcarbine",
		WT_SPCARBINE2 = "weapon_specialcarbine_mk2",
		WT_BULLRIFLE = "weapon_bullpuprifle",
		WT_BULLRIFLE2 = "weapon_bullpuprifle_mk2",
		WT_CMPRIFLE = "weapon_compactrifle",
		WT_MLTRYRFL = "weapon_militaryrifle",
		WT_HEAVYRIFLE = "WEAPON_HEAVYRIFLE",
		WT_TACRIFLE = "WEAPON_TACTICALRIFLE",
	},
	-- Sniper rifles
	VAULT_WMENUI_5 =
	{
		WT_SNIP_RIF = "weapon_sniperrifle",
		WT_SNIP_HVY = "weapon_heavysniper",
		WT_SNIP_HVY2 = "weapon_heavysniper_mk2",
		WT_MKRIFLE = "weapon_marksmanrifle",
		WT_MKRIFLE2 = "weapon_marksmanrifle_mk2",
		WT_PRCSRIFLE = "WEAPON_PRECISIONRIFLE",
	},
	-- Heavy weapons
	VAULT_WMENUI_6 =
	{
		WT_GL = "weapon_grenadelauncher",
		WT_RPG = "weapon_rpg",
		WT_MINIGUN = "weapon_minigun",
		WT_FWRKLNCHR = "weapon_firework",
		WT_RAILGUN = "weapon_railgun",
		WT_HOMLNCH = "weapon_hominglauncher",
		WT_CMPGL = "weapon_compactlauncher",
		WT_RAYMINIGUN = "weapon_rayminigun",
	},
	-- Melee weapons
	VAULT_WMENUI_8 =
	{
		WT_UNARMED = "weapon_unarmed",
		WT_KNIFE = "weapon_knife",
		WT_NGTSTK = "weapon_nightstick",
		WT_HAMMER = "weapon_hammer",
		WT_BAT = "weapon_bat",
		WT_CROWBAR = "weapon_crowbar",
		WT_GOLFCLUB = "weapon_golfclub",
		WT_BOTTLE = "weapon_bottle",
		WT_DAGGER = "weapon_dagger",
		WT_SHATCHET = "weapon_stone_hatchet",
		WT_KNUCKLE = "weapon_knuckle",
		WT_MACHETE = "weapon_machete",
		WT_FLASHLIGHT = "weapon_flashlight",
		WT_SWTCHBLDE = "weapon_switchblade",
		WT_BATTLEAXE = "weapon_battleaxe",
		WT_POOLCUE = "weapon_poolcue",
		WT_WRENCH = "weapon_wrench",
		WT_HATCHET = "weapon_hatchet",
	},
	-- Pistols
	VAULT_WMENUI_9 =
	{
		WT_PIST = "weapon_pistol",
		WT_PIST2  = "weapon_pistol_mk2",
		WT_PIST_CBT = "weapon_combatpistol",
		WT_PIST_50 = "weapon_pistol50",
		WT_SNSPISTOL = "weapon_snspistol",
		WT_SNSPISTOL2 = "weapon_snspistol_mk2",
		WT_HEAVYPSTL = "weapon_heavypistol",
		WT_VPISTOL = "weapon_vintagepistol",
		WT_CERPST = "weapon_ceramicpistol",
		WT_MKPISTOL = "weapon_marksmanpistol",
		WT_REVOLVER = "weapon_revolver",
		WT_REVOLVER2 = "weapon_revolver_mk2",
		WT_REV_DA = "weapon_doubleaction",
		WT_REV_NV= "weapon_navyrevolver",
		WT_GDGTPST = "weapon_gadgetpistol",
		WT_STUN = "weapon_stungun",
		WT_FLAREGUN = "weapon_flaregun",
		WT_RAYPISTOL = "weapon_raypistol",
		WT_PIST_AP = "weapon_appistol",
	},
}



----敌对载具
enemy_options = {"迷你坦克", "秃鹰", "天煞"}
enemy_veh = {"Minitank", "Buzzard", "Lazer"}
minitankModIds = {
	stockWeapon = -1,
	plasmaCannon = 1,
	rocket = 2,
}
gunnerWeaponNames = {{1,"机枪"},{2,"火箭发射器"},{3,"离子炮"}}
gunnerWeapons = {"weapon_mg", "weapon_rpg"}
enemVehOptions = {{1,"机枪"}, {2,"火箭炮"}}




----在车内生成NPC
some_ped_list = {
    "a_m_m_bevhills_02",    --1
    "a_m_m_business_01",    --2
    "a_m_m_bevhills_01",    --3
    "a_m_m_farmer_01",      --4
    "a_m_m_paparazzi_01",   --5
    "a_m_m_prolhost_01",    --6
    "a_m_m_stlat_02"        --7
}


----移动笼子
kidnap_types = {{1,"卡车"}, {2,"直升机"}}


----力场pro
s_forcefield_names = {
    {1,"推"},
    {2,"发射"},
    {3,"拉"}
}


-----保镖直升机
heli_list = {} --生成的直升机
heli_ped_list = {} --直升机内的保镖
bodyguard_heli = {
    name = "buzzard",
    heli_godmode = false,
    ped_godmode = false
}
sel_heli_name_list = { {1,"秃鹰"}, {2,"女武神"}, {3,"猎杀者"}, {4,"野蛮人"} }
sel_heli_model_list = { "buzzard", "valkyrie", "hunter", "savage" }


----给予爆炸子弹
explosion_names = {
    {1,"默认"},
    {2,"手榴弹"},
    {3,"榴弹发射器"},
    {4,"粘性炸弹"},
    {5,"燃烧瓶"},
    {6,"火箭弹"},
    {7,"坦克炮弹"},
    {8,"火球爆炸"},
    {9,"汽车爆炸"},
    {10,"飞机爆炸"},
    {11,"加油站爆炸"},
    {12,"摩托车爆炸"},--no.12,
    {13,"蒸汽"},
    {14,"火焰"},
    {15,"消火栓"},
    {16,"煤气罐"},
    {17,"小艇"},
    {18,"船只"},
    {19,"卡车爆炸"},
    {20,"MK2爆炸子弹"},
    {21,"烟雾弹发射器"},
    {22,"烟雾弹"},
    {23,"毒气弹"},
    {24,"信号弹"},
    {25,"气体罐"},
    {26,"灭火器"},
    {27,"可调榴弹"},
    {28,"火车爆炸"},
    {29,"油桶"},
    {30,"丙烷"},
    {31,"飞艇"},
    {32,"火焰爆炸"},
    {33,"油罐车"},
    {34,"飞机导弹"},
    {35,"汽车导弹"},
    {36,"然油泵"},
    {37,"鸟屎"},
    {38,"电磁步枪"},
    {39,"飞艇爆炸2"},
    {40,"烟花"},
    {41,"雪球"},
    {42,"地雷"},
    {43,"女武神机炮"},
    {44,"游艇防御"},
    {45,"爆破桶"},
    {46,"汽车炸弹"},
    {47,"MK2定向炸弹"},
    {48,"APC炮弹"},
    {49,"集束炸弹"},
    {50,"飞机瓦斯"},
    {51,"飞机燃烧弹"},
    {52,"飞机炸弹"},
    {53,"鱼雷"},
    {54,"水下鱼雷"},
    {55,"邦布须卡炮"},
    {56,"第二集束炸弹"},
    {57,"猎杀者连发导弹"},
    {58,"FH-1猎杀者机炮"},
    {59,"流氓大炮"},
    {60,"水下地雷"},
    {61,"天基炮"},
    {62,"轨道炮"},
    {63,"MK2爆炸子弹霰弹枪"},
    {64,"MK2导弹"},
    {65,"武装坦帕迫击炮"},
    {66,"追踪地雷"},
    {67,"电磁脉冲地雷"},
    {68,"尖刺式地雷"},
    {69,"感应式地雷"},
    {70,"定时地雷"},
    {71,"无人机爆炸"},
    {72,"原子能枪"},
    {73,"跳雷"},
    {74,"脚本化导弹"},
    {75,"RC坦克火箭"},
    {76,"爆炸水"},
    {77,"二次爆炸水"},
    {78,"灭火器1"},
    {79,"灭火器2"},
    {80,"灭火器3"},
    {81,"灭火器4"},
    {82,"灭火器5"},
    {83,"大脚本导弹"},
    {84,"潜艇导弹"},
    {85,"EMP发射器"},
    {86,"轨道炮MX3"},
    {87,"无伤害爆炸"}
}


----世界重力
World_gravity_option = {
    {1,"正常"},
    {2,"低"},
    {3,"非常低"},
    {4,"无重力"},
}


--RPG自动瞄准器
AIM_WHITELIST = {}
MISSILE_ENTITY_TABLE = {}
missile_settings = {
    radius = 300,
    speed = 100,
    los = true,
    cam = false,
    ptfx = true,
    ptfx_scale = 1,
    air_target = false,
    multitarget = false,
    multiped = false
}
missile_particles = {
    name = "exp_grd_rpg_lod",
    dictionary = "core"
}


--射击效果
Shoot_effect_options = {
	{1,"小丑喷射"},
	{2,"小丑花"}
}

--命中效果
hiteffectColour = {r = 0.5, g = 0.0, b = 0.5, a = 1.0}
hit_effect_options = {
    {1,"小丑爆炸"},
    {2,"小丑出现"},
    {3,"开拓者FW"},
    {4,"星爆FW"},
    {5,"喷泉FW"},
    {6,"外星解体"},
    {7,"小丑花"},
    {8,"外星冲击波FW"},
    {9,"小丑木兹"}
}

----清空奖章挑战记录
--末日豪杰
DoomsdayMedalRecord = {
    name = {
        {1, "按部就班2"},
        {2, "忠诚伙伴2"},
        {3, "忠诚伙伴3"},
        {4, "忠诚伙伴4"},
        {5, "犯罪之神2"},
        {6, "犯罪之神3"},
        {7, "犯罪之神4"},
        {8, "配角也疯狂"}
    },
    key = {
        [1] = { "MPPLY_GANGOPS_ALLINORDER", "MPPLY_AWD_GANGOPS_ALLINORDER" },
        [2] = { "MPPLY_GANGOPS_LOYALTY2", "MPPLY_AWD_GANGOPS_LOYALTY2" },
        [3] = { "MPPLY_GANGOPS_LOYALTY3", "MPPLY_AWD_GANGOPS_LOYALTY3" },
        [4] = { "MPPLY_GANGOPS_LOYALTY", "MPPLY_AWD_GANGOPS_LOYALTY" },
        [5] = { "MPPLY_GANGOPS_CRIMMASMD2", "MPPLY_AWD_GANGOPS_CRIMMASMD2" },
        [6] = { "MPPLY_GANGOPS_CRIMMASMD3", "MPPLY_AWD_GANGOPS_CRIMMASMD3" },
        [7] = { "MPPLY_GANGOPS_CRIMMASMD", "MPPLY_AWD_GANGOPS_CRIMMASMD" },
        [8] = { "MPPLY_GANGOPS_SUPPORT", "MPPLY_AWD_GANGOPS_SUPPORT" }
    }
}
--公寓
ClassicMedalRecord = {
    name = {
        {1, "按部就班"},
        {2, "忠诚伙伴"},
        {3, "犯罪之神"},
        {4, "全身视角"},
        {5, "绿叶扶持"}
    },
    key = {
        [1] = { "MPPLY_HEISTFLOWORDERPROGRESS", "MPPLY_AWD_HST_ORDER" },
        [2] = { "MPPLY_HEISTTEAMPROGRESSBITSET", "MPPLY_AWD_HST_SAME_TEAM" },
        [3] = { "MPPLY_HEISTNODEATHPROGREITSET", "MPPLY_AWD_HST_ULT_CHAL" },
        [4] = { "MPPLY_HEIST_1STPERSON_PROG", "MPPLY_AWD_COMPLET_HEIST_1STPER" },
        [5] = { "MPPLY_HEISTMEMBERPROGRESSBITSET", "MPPLY_AWD_COMPLET_HEIST_MEM" }
    }
}

----立即移除冷却时间
CooldownStatList = {
    { name = "公寓抢劫 手机匹配", stat = "HESIT_LAUNCH_TIME" },

    { name = "末日豪劫", stat = { "HEISTCOOLDOWNTIMER0", "HEISTCOOLDOWNTIMER1", "HEISTCOOLDOWNTIMER2" } },
    { name = "末日豪劫 手机匹配", stat = "GANGOPS_LAUNCH_TIME" },

    { name = "赌场抢劫", stat = "H3_COMPLETEDPOSIX" },
    { name = "赌场抢劫 手机匹配", stat = "MPPLY_H3_COOLDOWN" },

    { name = "佩里科岛抢劫", stat = { "H4_COOLDOWN", "H4_COOLDOWN_HARD" } },
    { name = "佩里科岛抢劫 手机匹配", stat = "MPPLY_H4_COOLDOWN" },

    {
        name = "改装铺抢劫",
        stat = { "TUNER_CONTRACT0_POSIX", "TUNER_CONTRACT1_POSIX", "TUNER_CONTRACT2_POSIX", "TUNER_CONTRACT3_POSIX", "TUNER_CONTRACT4_POSIX", "TUNER_CONTRACT5_POSIX", "TUNER_CONTRACT6_POSIX", "TUNER_CONTRACT7_POSIX" }
    },
    { name = "改装铺合约 刷新", stat = "TUNER_REFRESH_POSIX" },

    { name = "合约德瑞博士", stat = "FIXER_STORY_COOLDOWN" },
    { name = "回收站抢劫", stat = "SALV23_VEHROB_CD" },
    { name = "当当钟农场突袭", stat = "SALV23_CFR_COOLDOWN" },

    { name = "富兰克林 请求电话暗杀", stat = "PAYPHONE_HIT_CDTIMER" },
    { name = "达克斯 蠢人帮差事", stat = "XM22JUGGALOWORKCDTIMER" },
    { name = "14号探员 请求地堡研究", stat = "SOURCE_RESEARCH_CDTIMER" },
    { name = "尤汗 请求夜总会货物", stat = "SOURCE_GOODS_CDTIMER" },
    { name = "地堡 武器零件", stat = "BUNKER_CRATE_COOLDOWN" },
    { name = "夜总会 人气任务", stat = "NCLUB_EVENT_POSSIX" },
    { name = "办公室 出口混合货物", stat = "EXEC_EXP_CARGO_CD" },
    { name = "贝克女士 赌场工作任务", stat = "CASINO_MISSION_CDTIMER" },
}

----移除首次进入资产的动画教程
BusinessCutsceneBitList = {
    { name = "办公室",          bits = { 13 } }, -- biFmCut_OfficeCutscene
    { name = "特种货物货物",    bits = { 14 } },
    { name = "摩托帮会所",      bits = { 15 } },
    { name = "冰毒实验室",      bits = { 16, 21 } },
    { name = "可卡因作坊",      bits = { 17, 22 } },
    { name = "大麻种植场",      bits = { 18, 23 } },
    { name = "证件伪造办公室",  bits = { 19, 24 } },
    { name = "假钞工厂",        bits = { 20, 25 } },
    { name = "载具仓库",        bits = { 26 } },
    { name = "地堡",            bits = { 27, 28 } },
    { name = "机库",            bits = { 29, 30 } },
    { name = "设施",            bits = { 31 } }
}

----自动CEO/首领
CEOLabels = {
    "HIP_HELP_BBOSS",
    "HIP_HELP_BBOSS2",
    "HPBOARD_REG",
    "HPBOARD_REGB",
    "HT_NOT_BOSS",
    "HUB_PC_BLCK",
    "NHPG_HELP_BBOSS",
    "OFF_COMP_REG",
    "TRUCK_PC_BLCK",
    "TUN_HELP_BBOSS",
    "BUNK_PC_BLCK",
    "CH_FINALE_REG",
    "CH_PREP_REG",
    "CH_SETUP_REG",
    "FHQ_PC_BLCK",
    "HANG_PC_BLCK",
    "HFBOARD_REG",
    "HIBOARD_REG",
    "HIBOARD_REGB",
    "MP_OFF_LAP_1",
    "MP_OFF_LAP_PC",
    "OFF_COMP_REG",
    "ARC_PC_BLCK",
    "ARC_HT_0",
    "ARC_HT_0B",
    "ACID_SLL_HLP2",
    "HRBOARD_REG",
    "HRBOARD_REGB",
}
MCLabels = {
    "CLBHBKRREG",
    "ARC_HT_1",
    "ARC_HT_1B",
}


----环境光
glow_color = {r = 1, g = 0, b = 0, a = 1}

----彩色翅膀
fireWing_v2color = {r = 1, g = 0.865, b = 0, a = 0}


----轨迹
bones = {
    0x49D9,	
    0xDEAD,	
    0x3779,	
    0xCC4D	
}

----免疫伤害
proofstbl = {
    [1] = {name = "子弹", bullet = true},
    [2] = {name = "火烧", fire = true},
    [3] = {name = "爆炸", explosion = true},
    [4] = {name = "撞击", collision = true},
    [5] = {name = "近战", melee = true},
    [6] = {name = "蒸汽", steam = true}
}


----MK-2拦截
optionsMK2Karma = {{1, "[删除]" }, {2, "[爆炸]" }, {3, "[删除+爆炸]" }}
gm = { "[Remove]", "[Kill]", "[Remove + Kill]"}


----UFO
objModels = {"imp_prop_ship_01a","sum_prop_dufocore_01a", "gr_prop_damship_01a"}
ufo_name = {"外星UFO", "军用UFO", "废弃UFO"}


-----自动驾驶
style_names = {{1,"正常"}, {2,"半冲刺"}, {3,"反向"}, {4,"无视红绿灯"}, {5,"避开交通"}, {6,"极度避开交通"}, {7,"采用最短路径"}, {8,"有时超车"}}
drivestyletables = {786603, 1074528293, 1076, 2883621, 786468, 6, 262144, 5}



-----载具效果
v_eff_options = {
    {1,"外星人冲击"},
    {2,"小丑出现"},
    {3,"蓝色火花"},
    {4,"外星人解体"},
    {5,"火热颗粒"},
}
veffects = {
    {"scr_rcbarry1", "scr_alien_impact_bul", 1.0, 50},
    {"scr_rcbarry2", "scr_clown_appears", 0.3, 500},
    {"core", "ent_dst_elec_fire_sp", 1.0, 100},
    {"scr_rcbarry1", "scr_alien_disintegrate", 0.1, 400},
    {"scr_rcbarry1", "scr_alien_teleport", 0.1, 400}
}

----粒子拖尾
vehparticle_name = {{1,"烟花拖尾1"},{2,"烟花拖尾2"}}
vehparticle_tb = {"scr_mich4_firework_trail_spawn","scr_mich4_firework_sparkle_spawn"}


----附加恶搞模型
spoof_attachd = {
    name = {
        {1, "橙子"},
        {2, "篝火"},
        {3, "UFO"},
        {4, "马桶"},
        {5, "垃圾桶"},
        {6, "仙人掌"},
        {7, "太阳伞"},
        {8, "圣诞树"}
    },
    value = {
        148511758,
        3229200997,
        1241740398,
        1872312775,
        1143474856,
        -194496699,
        -2108662770,
        238789712
    }
}



------生成坡道
ramps_names = {"普通坡道", "高坡道", "摩托艇坡道"}
ramps_names1 = {"竞技场跳板","特技坡道","Small ramp","Big ramp"}
ramps_hashes = {
    util.joaat("prop_mp_ramp_02_tu"), 
    util.joaat("prop_mp_ramp_03_tu"), 
    util.joaat("prop_jetski_ramp_01"),
    "2108723836",
    "677027815",
    util.joaat("xs_prop_arena_jump_xxl_01a_sf"),
    util.joaat("xs_prop_arena_jump_02b")
}



------火翅膀
fireWings = {
    [1] = {pos = {[1] = 120, [2] =  75}},
    [2] = {pos = {[1] = 120, [2] = -75}},
    [3] = {pos = {[1] = 135, [2] =  75}},
    [4] = {pos = {[1] = 135, [2] = -75}},
    [5] = {pos = {[1] = 180, [2] =  75}},
    [6] = {pos = {[1] = 180, [2] = -75}},
    [7] = {pos = {[1] = 190, [2] =  75}},
    [8] = {pos = {[1] = 190, [2] = -75}},
    [9] = {pos = {[1] = 130, [2] =  75}},
    [10] = {pos = {[1] = 130, [2] = -75}},
    [11] = {pos = {[1] = 140, [2] =  75}},
    [12] = {pos = {[1] = 140, [2] = -75}},
    [13] = {pos = {[1] = 150, [2] =  75}},
    [14] = {pos = {[1] = 150, [2] = -75}},
    [15] = {pos = {[1] = 210, [2] =  75}},
    [16] = {pos = {[1] = 210, [2] = -75}},
    [17] = {pos = {[1] = 195, [2] =  75}},
    [18] = {pos = {[1] = 195, [2] = -75}},
    [19] = {pos = {[1] = 160, [2] =  75}},
    [20] = {pos = {[1] = 160, [2] = -75}},
    [21] = {pos = {[1] = 170, [2] =  75}},
    [22] = {pos = {[1] = 170, [2] = -75}},
    [23] = {pos = {[1] = 200, [2] =  75}},
    [24] = {pos = {[1] = 200, [2] = -75}},
}


-----水印
watermark_pos = {
    x = 0.992,
    y = 0.008
}
watermark_settings = {
	show_name = true,
	show_date = true,
	show_players = true,
    show_firstl = 2,

    add_x = 0.0055,
    add_y = 0.0,
    
    bg_color = {
        ["r"] = 0.8,
        ["g"] = 0.35,
        ["b"] = 0.8,
        ["a"] = 0.8
    },
    tx_color = {
        ["r"] = 1.0,
        ["g"] = 1.0,
        ["b"] = 1.0,
        ["a"] = 1.0
    }
}
stand_version = {
    edition = menu.get_edition(),
    editions = {
        'Free',
        'Basic',
        'Regular',
        'Ultimate'
    }
}


------附加国旗
country_flags_name = {
    {1,"阿根廷"},
    {2,"澳大利亚"},
    {3,"奥地利"},
    {4,"比利时"},
    {5,"巴西"},
    {6,"加拿大"},
    {7,"中国"},
    {8,"哥伦比亚"},
    {9,"克罗地亚"},
    {10,"捷克"},
    {11,"丹麦"},
    {12,"英国"},
    {13,"欧盟"},
    {14,"芬兰"},
    {15,"法国"},
    {16,"德国"},
    {17,"匈牙利"},
    {18,"爱尔兰"},
    {19,"以色列"},
    {20,"意大利"},
    {21,"牙买加"},
    {22,"日本"},
    {23,"列支敦士登"},
    {24,"马耳他"},
    {25,"墨西哥"},
    {26,"荷兰"},
    {27,"纽西兰"},
    {28,"尼日利亚联邦"},
    {29,"挪威"},
    {30,"巴勒斯坦"},
    {31,"波兰"},
    {32,"葡萄牙"},
    {33,"波多黎各"},
    {34,"俄罗斯联邦"},
    {35,"苏格兰"},
    {36,"黑旗"},
    {37,"斯洛伐克"},
    {38,"斯洛文尼亚"},
    {39,"南非"},
    {40,"韩国"},
    {41,"西班牙"},
    {42,"瑞典"},
    {43,"瑞士"},
    {44,"土耳其"},
    {45,"英国"},
    {46,"美国"},
    {47,"威尔士"}
}
country_flags = {
    "apa_prop_flag_argentina", 
    "apa_prop_flag_australia", 
    "apa_prop_flag_austria", 
    "apa_prop_flag_belgium", 
    "apa_prop_flag_brazil", 
    "apa_prop_flag_canada_yt", 
    "apa_prop_flag_china", 
    "apa_prop_flag_columbia", 
    "apa_prop_flag_croatia", 
    "apa_prop_flag_czechrep", 
    "apa_prop_flag_denmark", 
    "apa_prop_flag_england", 
    "apa_prop_flag_eu_yt", 
    "apa_prop_flag_finland", 
    "apa_prop_flag_france", 
    "apa_prop_flag_german_yt", 
    "apa_prop_flag_hungary", 
    "apa_prop_flag_ireland", 
    "apa_prop_flag_israel", 
    "apa_prop_flag_italy", 
    "apa_prop_flag_jamaica", 
    "apa_prop_flag_japan_yt", 
    "apa_prop_flag_lstein", 
    "apa_prop_flag_malta", 
    "apa_prop_flag_mexico_yt", 
    "apa_prop_flag_netherlands", 
    "apa_prop_flag_newzealand", 
    "apa_prop_flag_nigeria", 
    "apa_prop_flag_norway", 
    "apa_prop_flag_palestine", 
    "apa_prop_flag_poland", 
    "apa_prop_flag_portugal", 
    "apa_prop_flag_puertorico", 
    "apa_prop_flag_russia_yt", 
    "apa_prop_flag_scotland_yt", 
    "apa_prop_flag_script", 
    "apa_prop_flag_slovakia", 
    "apa_prop_flag_slovenia", 
    "apa_prop_flag_southafrica", 
    "apa_prop_flag_southkorea", 
    "apa_prop_flag_spain", 
    "apa_prop_flag_sweden", 
    "apa_prop_flag_switzerland", 
    "apa_prop_flag_turkey", 
    "apa_prop_flag_uk_yt", 
    "apa_prop_flag_us_yt", 
    "apa_prop_flag_wales"
}



---dc刷钱
casinoconfig = {
    debug_mode = false,
    test_mode = false,
    never_rig = false,
    delay_between_button_press = 500,
    delay_sitting_at_slot_machine = 5000,
    delay_between_spins = 3000,
    delay_after_entering_casino = 4000,
    default_spin_delay_time = 1000,
    loss_ratio = 2,
    max_allowed_daily_winnings = 45,
    max_daily_winnings = 40000000,
    millis_in_day = 86400000,
    seconds_in_day = 86400,
}


-----手指枪,子弹类型
weapon_stuff = {
    {"烟花", "weapon_firework"}, 
    {"原子能枪", "weapon_raypistol"},
    {"邪恶冥王", "weapon_raycarbine"},
    {"电磁步枪", "weapon_railgun"},
    {"红色激光", "vehicle_weapon_enemy_laser"},
    {"绿色激光", "vehicle_weapon_player_laser"},
    {"天煞机炮", "vehicle_weapon_player_lazer"},
    {"火箭炮", "weapon_rpg"},
    {"制导火箭发射器", "weapon_hominglauncher"},
    {"紧凑型电磁脉冲发射器", "weapon_emplauncher"},
    {"信号弹", "weapon_flaregun"},
    {"霰弹枪", "weapon_bullpupshotgun"},
    {"电击枪", "weapon_stungun"},
    {"催泪瓦斯", "weapon_smokegrenade"},
}




-------视觉增强
visual_stuff = {
    {"提升亮度", "AmbientPush"},
    {"提升饱和度", "rply_saturation"},
    {"提升曝光度", "LostTimeFlash"},
    {"雾之夜", "casino_main_floor_heist"},
    {"更好的夜晚", "dlc_island_vault"},
    {"正常雾天", "Forest"},
    {"大雾天", "nervousRON_fog"},
    {"黄昏天", "MP_Arena_theme_evening"},
    {"暖色调", "mp_bkr_int01_garage"},
    {"死气沉沉", "MP_deathfail_night"},
    {"石化", "stoned"},
    {"水下", "underwater"},
}

-------药物过滤器
drugged_effects = {
    "药品 1",
    "药品 2",
    "药品 3",
    "药品 4",
    "药品 5",
    "药品 6",
    "药品 7",
    "药品 8",
}

------屏幕效果
effect_stuff = {
    {"吸毒驾车", "DrugsDrivingIn"}, 
    {"吸毒的崔佛", "DrugsTrevorClownsFight"},
    {"吸毒的麦克", "DrugsMichaelAliensFight"},
    {"小查视角(红绿色盲)", "ChopVision"},
    {"默片", "DeathFailOut"},
    {"黑白", "HeistCelebPassBW"},
    {"横冲直撞", "Rampage"},
    {"我的眼镜在哪里？", "MenuMGSelectionIn"},
    {"梦境", "DMT_flight_intro"},
}

----光线投影
TraceFlag ={
	everything = 4294967295,
	none = 0,
	world = 1,
	vehicles = 2,
	pedsSimpleCollision = 4,
	peds = 8,
	objects = 16,
	water = 32,
	foliage = 256,
}

-----HudColour颜色表[function.lib已包含]
HudColour =
{
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



----可视化速度表
--默认颜色背景
sp_colour = {				
    r = 0.9,
    g = 0.9,
    b = 0.9,
    a = 1
}
--默认文本颜色
cartxt_colour = {				
    r = 1.0,
    g = 1.0,
    b = 1.0,
    a = 1.0
}

----在玩家身上下雨
Weaplist = {
    {1,'烟花发射器'},
    {2,'榴弹发射器'},
    {3,'重型狙击Mk II'},
    {4,'燃烧瓶'},
    {5,'轨道枪'},
    {6,'火箭'},
    {7,'雪球'},
    {8,'邪恶冥王'},
    {9,'脉冲'}
}
Weap = {
    'weapon_firework',
    'weapon_grenadelauncher',
    'weapon_heavysniper_mk2',
    'WEAPON_MOLOTOV',
    'weapon_railgun',
    'WEAPON_RPG',
    'WEAPON_SNOWBALL',
    'weapon_raycarbine',
    'weapon_raypistol',
}


----鬼畜玩家
object_stuff = {
    names = {
        {1,"UFO"},
        {2,"摩天轮"},
        {3,"风车"},
        {4,"水泥搅拌车"},
        {5,"脚手架"},
        {6,"车库门"},
        {7,"保龄球"},
        {8,"足球"},
        {9,"橘子"},
        {10,"特技坡道"}
    },
    objects = {
        "p_spinning_anus_s",
        "prop_ld_ferris_wheel",
        "prop_windmill_01",
        "prop_staticmixer_01",
        "prop_towercrane_02a",
        "des_scaffolding_root",
        "prop_sm1_11_garaged",
        "stt_prop_stunt_bowling_ball",
        "stt_prop_stunt_soccer_ball",
        "prop_juicestand",
        "stt_prop_stunt_jump_l"
    }
}


----homer粒子
homer_ptxf = {
    "scr_sum2_hal_hunted_respawn",
    "scr_sum2_hal_rider_weak_blue",
    "scr_sum2_hal_rider_weak_green",
    "scr_sum2_hal_rider_weak_orange",
    "scr_sum2_hal_rider_weak_greyblack"
}

----传送载具
tp_playerveh_coord = {
    maze = {x = -75.261375,y = -818.674,z = 326.17517},
    underwater = {x = 4497.2207,y = 8028.3086,z = -32.635174},
    highair = {x = -75,y = -818,z = 2400},
    lsc = {x = -353.84512,y = -135.59108,z = 39.009624},
    scp = {x = 1642.8401,y = 2570.7695,z = 45.564854},
    cell = {x = 1737.1896,y = 2634.897,z = 45.56497}
}

-------愤怒的飞机
planes = {
	"besra",
	"dodo",
	"avenger",
	"microlight",
	"molotok",
	"bombushka",
	"howard",
	"duster",
	"luxor2",
	"lazer",
	"nimbus",
	"shamal",
	"stunt",
	"titan",
	"velum2",
	"miljet",
	"mammatus",
	"besra",
	"cuban800",
	"seabreeze",
	"alphaz1",
	"mogul",
	"nokota",
	"strikeforce",
	"vestra",
	"tula",
	"rogue",
}

----伪装
disguise_objects = {
    "prop_bush_med_03",
    "prop_tree_lficus_06",
    "prop_palm_fan_03_b",
    "prop_streetlight_01",
    "prop_recyclebin_04_b"
}
disguise_names = {
    {1,"灌木丛"},
    {2,"树"},
    {3,"棕榈树"},
    {4,"路灯"},
    {5,"垃圾桶"}
}


----防笼子
cageModels = {
    MISC.GET_HASH_KEY('v_ilev_ph_cellgate'),
    MISC.GET_HASH_KEY('v_ret_fh_doorframe'),
    MISC.GET_HASH_KEY('hei_prop_station_gate'),
    MISC.GET_HASH_KEY('p_v_43_safe_s'),
    MISC.GET_HASH_KEY('prop_logpile_01'),
    MISC.GET_HASH_KEY('prop_cs_dumpster_01a'),
    MISC.GET_HASH_KEY('prop_xmas_tree_int'),
    MISC.GET_HASH_KEY('prop_food_van_01'),
    MISC.GET_HASH_KEY('prop_test_elevator'),
    MISC.GET_HASH_KEY('u_m_m_jesus_01'),
    MISC.GET_HASH_KEY("ig_lestercrest"),
    MISC.GET_HASH_KEY("player_two"),
    MISC.GET_HASH_KEY("s_m_y_factory_01"),
    MISC.GET_HASH_KEY("cargobob"),
    MISC.GET_HASH_KEY("ch_prop_tree_03a"),
    MISC.GET_HASH_KEY("ch_prop_tree_02a"),
    MISC.GET_HASH_KEY("prop_gascage01"),
    MISC.GET_HASH_KEY("prop_coffin_02b"),
    MISC.GET_HASH_KEY("boxville3"),
    MISC.GET_HASH_KEY("prop_container_ld_pu"),
    MISC.GET_HASH_KEY("p_cablecar_s"),
    MISC.GET_HASH_KEY("prop_gold_cont_01"),
    MISC.GET_HASH_KEY("prop_gold_cont_01b"),
    MISC.GET_HASH_KEY("prop_feeder1_cr"),
    MISC.GET_HASH_KEY("prop_rub_cage01a"),
    MISC.GET_HASH_KEY("stt_prop_stunt_tube_s"),
    MISC.GET_HASH_KEY("stt_prop_stunt_tube_end"),
    MISC.GET_HASH_KEY("prop_jetski_ramp_01"),
    MISC.GET_HASH_KEY("stt_prop_stunt_tube_xs"),
    MISC.GET_HASH_KEY("prop_fnclink_03e"),
    MISC.GET_HASH_KEY("prop_container_05a"),
    MISC.GET_HASH_KEY("prop_jetski_ramp_01"),
    MISC.GET_HASH_KEY("prop_cs_dumpster_01a"),
    MISC.GET_HASH_KEY("p_v_43_safe_s"),
    MISC.GET_HASH_KEY("bkr_prop_moneypack_03a"),
    MISC.GET_HASH_KEY("prop_elecbox_12")
}

------载具枪
Objoptions_all = {
    {1,"灵蛇"},
    {2,"天煞"},
    {3,"叛乱分子"},
    {4,"尖锥魅影"},
    {5,'BR8'},
    {6,'丁卡'},
    {7,'太空码头工'}
}
Objvehicles = {
	"adder",
	"lazer",
	"insurgent2",
	"phantom2",
    'openwheel1',
    'veto',
    'dune2',
}
----------------------


----v3函数
vector3 = {
    --创建一个新的v3
	['new'] = function(x, y, z)
		return {x = x or 0, y = y or 0, z = z or 0}
	end,
    --计算两个 v3 向量的差
	['sub'] = function(a, b)
		return vector3.new(a.x-b.x, a.y-b.y, a.z-b.z)
	end,
    -- 计算两个 v3 向量的和
	['add'] = function(a, b)
		return vector3.new(a.x+b.x, a.y+b.y, a.z+b.z)
	end,
    -- 计算 v3 向量的长度（模长）
	['mag'] = function(a)
		return math.sqrt(a.x^2 + a.y^2 + a.z^2)
	end,
	['norm'] = function(a)
		local mag = vector3.mag(a)
		return vector3.div(a, mag)
	end,
    -- 计算两个 v3 向量的乘积（点乘）
	['mul'] = function(a, b)
		return vector3.new(a.x*b.x, a.y*b.y, a.z*b.z)
	end, 
    -- 将 v3 乘以一个标量
    ['mulScalar'] = function(vec, scalar)
		return vector3.new(vec.x*scalar, vec.y*scalar, vec.z*scalar)
	end, 
    -- 计算两个 v3 向量的除法
	['div'] = function(a, b)
		return vector3.new(a.x/b.x, a.y/b.y, a.z/b.z)
	end, 
    --返回两个 v3 向量的距离
	['distance'] = function(a, b) 
		return vector3.mag(vector3.sub(a, b) )
	end,
    -- 将 v3 向量转为一个单位向量
    ['toDir'] = function(rotation) 
        local retz = math.rad(rotation.z)
        local retx = math.rad(rotation.x)
        local absx = math.abs(math.cos(retx))
        return vector3.new(-math.sin(retz) * absx, math.cos(retz) * absx, math.sin(retx))
	end,
    -- 将 v3 向量转换为欧拉角
    ['toRot'] = function(vec) 
        local yaw = math.atan2(vec.z, vec.x)
        local pitch = math.asin(vec.y)
        local roll = 0 -- 在这个示例中将 roll 设为 0,你可以根据需要自行计算
        return {x = yaw, y = pitch, z = roll}
	end
}


----memory
write_global = {
	byte = function(global, value)
		local address = memory.script_global(global)
		memory.write_byte(address, value)
	end,
	int = function(global, value)
		local address = memory.script_global(global)
		memory.write_int(address, value)
	end,
	float = function(global, value)
		local address = memory.script_global(global)
		memory.write_float(address, value)
	end
}
read_global = {
	byte = function(global)
		local address = memory.script_global(global)
		return memory.read_byte(address)
	end,
	int = function(global)
		local address = memory.script_global(global)
		return memory.read_int(address)
	end,
	float = function(global)
		local address = memory.script_global(global)
		return memory.read_float(address)
	end,
	string = function(global)
		local address = memory.script_global(global)
		return memory.read_string(address)
	end
}

Mem = {}
function Mem:new(addr)
	local obj = {}
		obj.addr = addr or 0
	
	function obj:offset(offset)
        offset = offset or 0
		local addr = memory.read_long(obj.addr)
		if addr == 0 then
			return self
		end
		obj.addr = addr + offset
		return self
	end
    function obj:readLong(offset)
        offset = offset or 0
        if obj.addr == 0 then return nil end
        local res = memory.read_long(obj.addr + offset)
        return res
    end

    function obj:isNil()
        if obj.addr == 0 then return true end
        if memory.read_long(obj.addr) == 0 then return true end
        return false
    end



	setmetatable(obj, self)
    self.__index = self; return obj
end





----终极用户检测
BlockAttackUltimateUser = "无法攻击Sakura UltimateUser"
appmenu = {Ultion = {}, Ultioff = {}, useron = {}, useroff = {}}
--[[ UltimateUser = {
    [2816390189] = {"D_ducker", "cxk_amgil"},
    [1725853108] = "JACKEY3399",--20241003
    [497014673]  = "chenxikun666",--20241001
    [852206740]  = "VKingTxwsWangVC2",--20241001
    [2335671665] = "moxz030",--20241001
    [216159868]  = "oaklandau",--20241001
    [2810233868] = "oaklandau",--20241001
    [3141014521] = "3141014521",--20241001
    [2715708933] = "achun2354657986",--20241001
    [1759655185] = "Hilovewould",--20241001
    [2390168159] = "wdnmd351203",--20241001
    [1363069741] = "qingtian-dev",--20241001
    [1773688182] = "QiuQuDonLai",--20241001
    [2403432664] = "Ai_Ke_LA",--20241001
    [2634295025] = "hiifff",--20241001
    [1031015908] = "yuanrongshiwoer",--20241001
    [1151171114] = "haohaozuiNB",--20241001
    [3653915141] = "fhdsgy1",--20241003
    [2391813554] = "Dream-MF",--20241001
    [2821519710] = "Darlingawa",--20241001
    [2981506377] = "monoybox",--20241001
    [1621383733] = "mubeii",--20241001
    [2792955289] = "rainfog1",--20241001
    [1399019298] = "an-eager-beaver",--20241001
    [1914215343] = "BVNManLYS",--20241004
} ]]