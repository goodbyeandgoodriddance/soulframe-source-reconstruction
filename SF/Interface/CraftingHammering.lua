local module = require("EE.Interface.Utilities")
require("SF.Interface.Components.Button")
local flag = false
local v = nil
local v2 = Vector()
local v3 = 0
local v4 = 0
local v5 = __wf_atom_10cd16b2(0, 0.1)
local v6 = __wf_atom_10cd16b2(0, 0.1)
local v7 = Vector(1, 1, 1)
local v8 = 1
local v9 = nil
local position = Vector()
local v10 = Rotation()
local v11 = nil
local v12 = {
	Symbol("TopBone11"),
	Symbol("TopBone12"),
	Symbol("TopBone13"),
	Symbol("TopBone14"),
	Symbol("TopBone15"),
	Symbol("MidBone11"),
	Symbol("MidBone12"),
	Symbol("MidBone13"),
	Symbol("MidBone14"),
	Symbol("MidBone15"),
	Symbol("BotBone11"),
	Symbol("BotBone12"),
	Symbol("BotBone13"),
	Symbol("BotBone14"),
	Symbol("BotBone15")
}
local v13 = {
	Symbol("TopBone16"),
	Symbol("TopBone17"),
	Symbol("TopBone18"),
	Symbol("TopBone19"),
	Symbol("TopBone20"),
	Symbol("MidBone16"),
	Symbol("MidBone17"),
	Symbol("MidBone18"),
	Symbol("MidBone19"),
	Symbol("MidBone20"),
	Symbol("BotBone16"),
	Symbol("BotBone17"),
	Symbol("BotBone18"),
	Symbol("BotBone19"),
	Symbol("BotBone20")
}
local v14 = {
	Symbol("TopBone21"),
	Symbol("TopBone22"),
	Symbol("TopBone23"),
	Symbol("TopBone24"),
	Symbol("TopBone25"),
	Symbol("MidBone21"),
	Symbol("MidBone22"),
	Symbol("MidBone23"),
	Symbol("MidBone24"),
	Symbol("MidBone25"),
	Symbol("BotBone21"),
	Symbol("BotBone22"),
	Symbol("BotBone23"),
	Symbol("BotBone24"),
	Symbol("BotBone25")
}
local v15 = {}
local v16 = {}

local function fn(p, data)
	local v17 = __wf_atom_5c87ef66(p, data, Vector(data.x, data.y, data.z - 1))
	table.insert(v16, { n = Vector(v17[1], v17[2], v17[3]), w = v17[4] })
end

local function fn2()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("AnvilCameraSpot"))
	__wf_atom_0a6a5887:__wf_atom_802e6d6a(99999)
	__wf_atom_0a6a5887:Activate()
	v9 = gRegion:__wf_atom_0a6a5887(Symbol("BlacksmithVendor"))
	v9:__wf_atom_921c1a5f(hammeringWaitAnim, false, true, 20)
	v9:__wf_atom_921c1a5f(hammeringAnim, false, true, 21)
	v9:SetVisibility(true, true)
	v9:Attach(hammerDeco, Symbol("GAME_R1_WEAPON1"), Vector(), Rotation(90, 0, 0))
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("AnvilStart"))
	v9:Teleport(__wf_atom_0a6a5887_2:GetPosition(), __wf_atom_0a6a5887_2:__wf_atom_dc309f8a())
	gRegion:__wf_atom_c4f78a8f():SetVisibility(false, true)
	v = gRegion:__wf_atom_0a6a5887(Symbol("BlacksmithIron"))
	v:__wf_atom_e6ed03c8()
	local __wf_atom_f582136d = v:__wf_atom_f582136d(__wf_atom_7e616794)

	for i = 1, #__wf_atom_f582136d do
		if __wf_atom_f582136d[i] ~= v then
			gRegion:__wf_atom_dd1e4d10(__wf_atom_f582136d[i])
		end
	end

	v10 = v:__wf_atom_dc309f8a()
	v10.bank = 0
	position = v:GetPosition()

	for i = 1, #v14 do
		v15[i] = Vector(0, 0, 0)
		v:__wf_atom_83fac646(v14[i], Rotation(), v15[i], Vector(1, 1, 1))
	end

	for i = 1, #v12 do
		v:__wf_atom_83fac646(v12[i], Rotation(), Vector(0, 0, 0), Vector(1, 1, 1))
	end

	for i = 1, #v13 do
		v:__wf_atom_83fac646(v13[i], Rotation(), Vector(0, 0, 0), Vector(1, 1, 1))
	end

	local v17 = {
		Vector(-0.03, 0, -0.15),
		Vector(0, 0.02, -0.15),
		Vector(0.03, 0, -0.15),
		Vector(0, -0.02, -0.15)
	}
	v:Attach(edgeLineType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_ff43aa5a({ v17[1], v17[2] })
	fn(v17[1], v17[2])
	v:Attach(edgeLineType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_ff43aa5a({ v17[2], v17[3] })
	fn(v17[2], v17[3])
	v:Attach(edgeLineType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_ff43aa5a({ v17[3], v17[4] })
	fn(v17[3], v17[4])
	v:Attach(edgeLineType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_ff43aa5a({ v17[4], v17[1] })
	fn(v17[4], v17[1])
end

function Initialize()
	module.PlaySound(openSound)

	if not __wf_atom_7e8ad928(loopingMusic) and __wf_atom_7e8ad928(v11) then
		v11 = module.PlaySound(loopingMusic)
	end

	mMovie:__wf_atom_2dedec1a("CraftingBarInst", 13, false)
	mMovie:__wf_atom_2dedec1a("Metal", 13, false)
	mMovie:__wf_atom_2dedec1a("CraftingRank", 13, false)
	mMovie:__wf_atom_50d60589("SimpleTitleBar.Title", 36, "Smithing")
	mMovie:__wf_atom_e57658c2("SimpleTitleBar.Bg", 11, 0)
	mMovie:__wf_atom_e57658c2("SimpleTitleBar.Bg", 12, 75)
	mMovie:__wf_atom_50d60589("Quality.Text", 36, "0")
	fn2()
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v) then
		if Engine.IsPlayingWithController() then
			v3 = __wf_atom_421b01aa(v3 - tonumber(v2.x) * 0.05, -1, 1)
			v4 = __wf_atom_421b01aa(v4 - tonumber(v2.y) * 0.2, -0.35, 0.35)
		end

		local v17 = v3
		local v18 = v4
		local __wf_atom_9e368823 = v5:__wf_atom_9e368823()
		v5:__wf_atom_09294a87(v17)
		v5:Update(__wf_atom_fa1258d0())
		local __wf_atom_9e368823_2 = v5:__wf_atom_9e368823()
		local __wf_atom_9e368823_3 = v6:__wf_atom_9e368823()
		v6:__wf_atom_09294a87(v18)
		v6:Update(__wf_atom_fa1258d0())
		local __wf_atom_9e368823_4 = v6:__wf_atom_9e368823()
		local v19 = Vector(position.x, position.y, position.z)

		if __wf_atom_9e368823 ~= __wf_atom_9e368823_2 or __wf_atom_9e368823_3 ~= __wf_atom_9e368823_4 then
			local v20 = Rotation(
				v10.heading + __wf_atom_9e368823_2 * 180 * v7.x,
				v10.pitch - __wf_atom_9e368823_4 * 90 * v7.y,
				v10.bank
			)
			v20.bank = __wf_atom_9e368823_2 * 180 * v7.x
			v20.heading = v10.heading
			v20.pitch = v10.bank
			local y = 9999

			for i = 1, #v14 do
				local __wf_atom_1c374cc9 = v:__wf_atom_1c374cc9(v14[i], false)

				if __wf_atom_1c374cc9.y < y then
					y = __wf_atom_1c374cc9.y
				end
			end

			v:Teleport(v19, v20)
		end

		v:SetMaterialParam(Symbol("EmissiveMapAtten"), math.pow(v8, 0.25) * 3)

		if v8 > 0 then
			v8 = math.max(0, v8 - __wf_atom_084b3e93() / 30)

			if v8 <= 0 then
				v9:__wf_atom_2af89db3(21)

				if not __wf_atom_7e8ad928(v11) then
					v11:Stop(false)
				end

				module.PlaySound(showScoreMusic)
			end
		end
	end
end

function AdvanceAndShutdown()
	if flag then
		return
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:Stop(false)
	end

	flag = true
	gRegion:__wf_atom_0a6a5887(Symbol("AnvilCameraSpot")):Deactivate()
	module.PlaySound(selectSound)
	__wf_atom_ec43d06e(mMovie, "_root", 1, { 12 }, { 0 }, 2, 0, function()
		gRegion:__wf_atom_c4f78a8f():SetVisibility(true, true)
		mMovie:Close()
	end)
end

function onKeyDown_MENU_MOUSE_X(_, p)
	if not flag then
		v3 = __wf_atom_421b01aa(v3 - tonumber(p) * 0.00025, -1, 1)
	end

	return true
end

function onKeyDown_MENU_MOUSE_Y(_, p)
	if not flag then
		v4 = __wf_atom_421b01aa(v4 - tonumber(p) * 0.002, -0.35, 0.35)
	end

	return true
end

function onKeyDown_MENU_X(_, p)
	v2.x = tonumber(p)
	return true
end

function onKeyUp_MENU_X(_, p)
	v2.x = tonumber(p)
	return true
end

function onKeyDown_MENU_Y(_, p)
	v2.y = tonumber(p)
	return true
end

function onKeyUp_MENU_Y(_, p)
	v2.y = tonumber(p)
	return true
end

function onKeyDown_MENU_SELECT(_, _) end

function onKeyDown_MENU_CANCEL()
	AdvanceAndShutdown()
	module.PlaySound(exitSound)
	return true
end

function NotifyHammerStrike(_)
	local __wf_atom_dc309f8a = v:__wf_atom_dc309f8a()
	local v17 = __wf_atom_9341614d(Vector(0, 1, 0), __wf_atom_dc309f8a)
	local v18 = Vector()
	local y = -9999
	local v19 = 1

	for i = 1, #v14 do
		local __wf_atom_1c374cc9 = v:__wf_atom_1c374cc9(v14[i], false)

		if not (y < __wf_atom_1c374cc9.y) then
			continue
		end

		y = __wf_atom_1c374cc9.y
		v18 = __wf_atom_1c374cc9
		v19 = i
	end

	local v20 = v15[v19] - v17 * 0.025 * math.pow(v8, 0.25)
	v15[v19] = v20
	v:__wf_atom_83fac646(v14[v19], Rotation(), v20, Vector(1, 1, 1))
	v:__wf_atom_83fac646(v12[v19], Rotation(), v20, Vector(1, 1, 1))
	v:__wf_atom_83fac646(v13[v19], Rotation(), v20, Vector(1, 1, 1))
	gRegion:CreateEntity(hammerFX, v18, Rotation())
	local total = 0

	for i = 1, #v14 do
		local __wf_atom_1c374cc9 = v:__wf_atom_1c374cc9(v14[i], false)
		local __wf_atom_c60eb6bc = v:__wf_atom_c60eb6bc(__wf_atom_1c374cc9)

		for j = 1, #v16 do
			local n = v16[j].n
			local w = v16[j].w
			local v21 = __wf_atom_7cff1779(__wf_atom_c60eb6bc, n, w)

			if v21 > 0 then
				total += v21
			end
		end
	end

	local v21 = math.floor(math.pow(__wf_atom_421b01aa(1 - total / 0.322, 0, 1), 0.5) * 100 + 0.5)
	local v22

	if v21 >= 95 then
		v22 = "A+"
	elseif v21 >= 90 then
		v22 = "A"
	elseif v21 >= 85 then
		v22 = "B+"
	elseif v21 >= 80 then
		v22 = "B"
	elseif v21 >= 75 then
		v22 = "C+"
	elseif v21 >= 70 then
		v22 = "C"
	elseif v21 >= 65 then
		v22 = "D+"
	elseif v21 >= 60 then
		v22 = "D"
	else
		v22 = "F"
	end

	mMovie:__wf_atom_50d60589("Quality.Text", 36, v22)
end