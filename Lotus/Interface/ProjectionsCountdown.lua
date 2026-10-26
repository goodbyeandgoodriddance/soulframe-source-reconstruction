local module = require("Lotus.Interface.UIStyleUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("EE.Interface.AnchorMgr")
local v = Resource("/Lotus/Sounds/UI/NewUI/Projections/ProjectionCountDown")
local v2 = nil
local v3 = false
local flag = false
local flag2 = false
local flag3 = false
local v4 = nil
local v5 = true
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = false
local v10 = {}
local v11 = 5

local function fn()
	local color = module.GetColor(6, true)
	local color2 = module.GetColor(2, true)
	local color3 = module.GetColor(9, true)
	local color4 = module.GetColor(10, true)
	mMovie:__wf_atom_e57658c2("Countdown.RankShadow", 11, color2)
	mMovie:__wf_atom_e57658c2("Countdown.RankHeader", 11, color3)
	mMovie:__wf_atom_e57658c2("Countdown.Time", 11, color)
	mMovie:__wf_atom_e57658c2("Countdown.Hint", 11, color4)
end

local function fn2()
	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_dd9a0bb8) then
		return
	end

	if flag2 then
		gGameRules:__wf_atom_4827188a(0.3, 2)
	elseif flag3 then
		if gRegion:IsMaster() then
			gGameRules:__wf_atom_4c1dcb7d(false)
		end

		gGameRules:__wf_atom_9709a80e(2)
	end
end

local function fn3()
	flag = true
end

local function fn4(p, p2)
	return p.Time > p2.Time
end

local function fn5(p, p2)
	v6 = p
	local v12 = math.ceil(p)

	if v7 ~= v12 or p2 then
		local v13 = v7
		v7 = v12

		if v7 <= v11 and v7 > 0 then
			module2.PlaySound(v)
		end

		mMovie:__wf_atom_e57658c2("Countdown.Time2", 12, 100)
		mMovie:__wf_atom_50d60589("Countdown.Time2.Label", 36, v13)
		mMovie:__wf_atom_50d60589("Countdown.Time.Label", 36, v7)
		mMovie:__wf_atom_e57658c2("Countdown.Time", 12, 0)
		mMovie:__wf_atom_e57658c2("Countdown.Time", 5, 10)
		mMovie:__wf_atom_e57658c2("Countdown.Time", 6, 10)
		__wf_atom_ec43d06e(mMovie, "Countdown.Time", 2, { 12, 5, 6 }, { 100, 80, 80 }, 0.15, 0, function()
			__wf_atom_ec43d06e(mMovie, "Countdown.Time", 0, { 5, 6 }, { 110, 110 }, 0.85)
		end)
		__wf_atom_ec43d06e(mMovie, "Countdown.Time2", 2, { 12 }, { 0 }, 0.1)

		if p2 then
			table.sort(v10, fn4)
			v8 = v7 + 0.5
			v9 = false
		end

		local time = v8

		for i = 1, #v10 do
			local time2 = v10[i].Time
			local v14 = v10[i].Function
			local flag4

			if v7 <= time2 and time2 < v8 then
				if type(v14) == "string" then
					local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

					if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
						__wf_atom_2ad5cd23:Execute(v14, "")
					end
				else
					v14()
				end

				flag4 = true
			else
				flag4 = false
			end

			if flag4 then
				time = v10[i].Time
			end
		end

		v8 = time
	end
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v3 then
		return
	end

	local v12 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v12)
	local v13 = v6

	if v5 then
		v13 -= v12
	end

	fn5(v13, v9)

	if flag then
		print("Countdown timer expired")
		mMovie:Close()
	end
end

function Shutdown()
	print("Relic timer closed")

	if
		flag2
		and not __wf_atom_7e8ad928(gRegion)
		and not __wf_atom_7e8ad928(gGameRules)
		and gGameRules:IsA(__wf_atom_dd9a0bb8)
		and gRegion:IsMaster()
	then
		gGameRules:__wf_atom_4c1dcb7d(true)
	end

	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) and v4 ~= nil then
		__wf_atom_2ad5cd23:Execute(v4, "")
	end
end

local function fn6()
	v10 = {
		{ Time = 2, Function = fn2 },
		{ Time = 0, Function = fn3 }
	}
end

function Initialize()
	v3 = true
	fn()
	fn6()
	fn5(defaultTime, true)
	mMovie:__wf_atom_e57658c2("Countdown.RankShadow", 12, 50)
	mMovie:__wf_atom_e57658c2("Countdown.Time2", 12, 0)
	mMovie:__wf_atom_e57658c2("Countdown.Hint", 12, 0)
end

function AddCallback(p, p2)
	local time = tonumber(p)

	if time ~= nil and p2 ~= nil then
		table.insert(v10, { Time = time, Function = p2 })
		v9 = true
	end
end

function ResetCallbacks()
	fn6()
end

function SetUnpauseCountdown(p, p2)
	local v12 = tonumber(p) or defaultTime
	v7 = nil
	flag3 = true
	flag2 = false
	v4 = p2
	fn5(v12, true)
	print("Initialize timer " .. tostring(false), v12)
end

function SetPauseCountdown(p, p2)
	local v12 = tonumber(p) or defaultTime
	v7 = nil
	flag3 = false
	flag2 = true
	v4 = p2
	fn5(v12, true)
	print("Initialize timer " .. tostring(true), v12)
end

function SetCountdown(p, p2)
	if not v5 then
		fn5((tonumber(p)))
		return
	end

	local v12 = tonumber(p) or defaultTime
	v7 = nil
	flag3 = false
	flag2 = false
	v4 = p2
	fn5(v12, true)
	print("Initialize timer " .. tostring(nil), v12)
end

function SetCountdownSoundThreshold(p)
	v11 = tonumber(p)
end

function SetCountdownSound(p)
	v = Resource(p)
end

function EnableAutoCountdown(p)
	v5 = p ~= "false"
end

function SetPosition(p, p2, p3, p4)
	if __wf_atom_7e8ad928(v2) then
		if p3 ~= nil and p4 ~= nil then
			v2 = module3.Create(mMovie)
		end
	else
		v2:Unregister(mMovie, "Countdown")
	end

	mMovie:__wf_atom_e57658c2("Countdown", 0, p)
	mMovie:__wf_atom_e57658c2("Countdown", 1, p2)

	if p3 ~= nil and p4 ~= nil then
		v2:Register(mMovie, "Countdown", { tonumber(p3), (tonumber(p4)) })
	end

	local __wf_atom_d5a50cb5 = mMovie:__wf_atom_d5a50cb5()
	local __wf_atom_c4f6543f = mMovie:__wf_atom_c4f6543f()

	if not __wf_atom_7e8ad928(v2) then
		v2:Update(__wf_atom_d5a50cb5, __wf_atom_c4f6543f)
	end
end

function SetScale(p, p2)
	mMovie:__wf_atom_e57658c2("Countdown", 5, p)
	mMovie:__wf_atom_e57658c2("Countdown", 6, p2)
end

function SetHint(p, p2)
	if p == "nil" then
		mMovie:__wf_atom_e57658c2("Countdown.Hint", 12, 0)
	else
		mMovie:__wf_atom_e57658c2("Countdown.Hint", 12, 100)
		mMovie:__wf_atom_7d7314f1("Countdown.Hint.text", p)
	end

	local v12 = p2 ~= "false"
	mMovie:__wf_atom_2dedec1a("Countdown.Time", 13, v12)
	mMovie:__wf_atom_2dedec1a("Countdown.Time2", 13, v12)
	mMovie:__wf_atom_2dedec1a("Countdown.RankHeader", 13, v12)
	mMovie:__wf_atom_2dedec1a("Countdown.RankShadow", 13, v12)
end

function SupportsThemes()
	return true
end

function OnStyleChangedCallback()
	fn()
end

function onViewportSizeChanged(p, p2)
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(p, p2)
	end
end

function SetCorpus()
	mMovie:__wf_atom_e57658c2("Countdown.RankHeader", 11, 8188159)
	mMovie:__wf_atom_e57658c2("Countdown.Time", 1, -28)
	mMovie:__wf_atom_e57658c2("Countdown.Time2", 1, -28)
end