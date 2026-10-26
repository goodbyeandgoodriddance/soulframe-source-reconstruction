local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.Libs.TimerMgr")
local module3 = require("SF.Interface.Libs.OdeCipher")
local module4 = require("SF.Scripts.Libs.EncounterLib")
local v = nil
local v2 = nil
local v3 = {}
local v4 = true

function LocationDiscovered(p, p2, p3, p4, p5, p6)
	local v5 = tonumber(p2)
	local v6 = tonumber(p3)
	local v7 = p4 == "true"
	local v8 = not p5 and 0 or tonumber(p5) or 0
	local v9 = not (v6 > 0) and 0 or 1 - v5 / v6

	if v6 > 0 and (v7 or v5 < v6) then
		local v10 = 40 * (v6 + 1) / 2

		for i = 1, v6 do
			__wf_atom_86cbd68d(mMovie, "Location.LorePip.duplicateMovieClip", "LorePip" .. i, 500 + i)
			local v11 = "Location.LorePip" .. i
			mMovie:__wf_atom_e57658c2("Location.LorePip" .. i, 0, i * 40 - v10)
			local v12 = i <= v5
			mMovie:__wf_atom_7f57ab2f(v11, "Glow", 13, false)
			mMovie:__wf_atom_7f57ab2f(v11, "Highlight", 13, false)
			mMovie:__wf_atom_7f57ab2f(v11, "Full", 13, v12)
			mMovie:__wf_atom_7f57ab2f(v11, "Empty", 13, not v12)
			mMovie:__wf_atom_7f57ab2f(v11, "Mote", 13, false)

			if not v12 and v8 > 0 then
				mMovie:__wf_atom_7f57ab2f(v11, "Mote", 13, true)
				v8 -= 1
				local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v11, "Mote", 0)
				local __wf_atom_cfc41e35_2 = mMovie:__wf_atom_cfc41e35(v11, "Mote", 1)
				local __wf_atom_cfc41e35_3 = mMovie:__wf_atom_cfc41e35(v11, "Mote", 5)
				table.insert(v3, {
					v11 .. ".Mote",
					__wf_atom_cfc41e35,
					__wf_atom_cfc41e35_2,
					__wf_atom_cfc41e35_3
				})
			end

			if not (i == v5 and v7) then
				continue
			end

			v2 = v11 .. ".Glow"
			mMovie:__wf_atom_7d7314f1("Location.LorePipTitle.Title.text", "/SF/Language/Locations/LorePipObtained")
			mMovie:__wf_atom_e57658c2("Location.LorePipTitle", 12, 0)
			mMovie:__wf_atom_7f57ab2f(v11, "Full", 13, true)
			mMovie:__wf_atom_7f57ab2f(v11, "Empty", 13, true)
			mMovie:__wf_atom_4c1c1986(v11, "Full", 12, 0)
			mMovie:__wf_atom_4c1c1986(v11, "Empty", 12, 100)
			mMovie:__wf_atom_4c1c1986(v11, "Glow", 12, 0)
			mMovie:__wf_atom_4c1c1986(v11, "Highlight", 12, 0)
			__wf_atom_ec43d06e(mMovie, v11 .. ".Full", 8, { 12 }, { 100 }, 2, 1)
			__wf_atom_ec43d06e(mMovie, v11 .. ".Empty", 8, { 12 }, { 0 }, 2, 1)
			v:AddTimer(1.5, function()
				module.PlaySound(lorePipSound)
			end)
			__wf_atom_ec43d06e(mMovie, "Location.LongGlow", 8, { 12 }, { 100 }, 2, 1, function()
				__wf_atom_ec43d06e(mMovie, "Location.LongGlow", 8, { 12 }, { 0 }, 2, 2)
			end)
			__wf_atom_ec43d06e(mMovie, "Location.LorePipTitle", 8, { 12 }, { 100 }, 2, 1, function()
				__wf_atom_ec43d06e(mMovie, "Location.LorePipTitle", 8, { 12 }, { 0 }, 2, 2)
			end)
			__wf_atom_ec43d06e(mMovie, v11 .. ".Glow", 8, { 12 }, { 100 }, 2, 1, function()
				__wf_atom_ec43d06e(mMovie, v11 .. ".Glow", 8, { 12 }, { 0 }, 2, 2)
			end)
			__wf_atom_ec43d06e(mMovie, v11 .. ".Highlight", 8, { 12 }, { 100 }, 2, 1, function()
				__wf_atom_ec43d06e(mMovie, v11 .. ".Highlight", 8, { 12 }, { 0 }, 2, 2)
			end)
			mMovie:__wf_atom_7f57ab2f(v11, "Glow", 13, true)
			mMovie:__wf_atom_7f57ab2f(v11, "Highlight", 13, true)
		end
	end

	gRegion:PlaySound(stingerMusic, Vector(), false)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(p, false)
	local odeCipher = module3.OdeCipher(__wf_atom_8e9ac384, v9, p)
	mMovie:__wf_atom_50d60589("Location.Title", 36, odeCipher)
	local v10 = math.max(0, tonumber(p6) - 4)
	__wf_atom_ec43d06e(mMovie, "Location", 8, { 12, 1 }, { 100, 100 }, 2, 0, function()
		CloseNotification(v10)
	end)
end

function AncestorDiscovered(p, p2)
	gRegion:PlaySound(stingerMusic, Vector(), false)
	module.PlaySound(ancestorDiscoveredSound)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/SystemMessages/AncestorDiscovered", false)
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(p, false)
	mMovie:__wf_atom_50d60589("Location.Title", 36, __wf_atom_8e9ac384_2)
	mMovie:__wf_atom_7d7314f1("Location.LorePipTitle.Title.text", __wf_atom_8e9ac384)
	mMovie:__wf_atom_e57658c2("Location.LorePipTitle", 12, 100)
	local v5 = math.max(0, tonumber(p2) - 4)
	__wf_atom_ec43d06e(mMovie, "Location", 8, { 12, 1 }, { 100, 50 }, 2, 0, function()
		CloseNotification(v5)
	end)
end

local function fn(p, callback, p2)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("SiegePopUp.SiegePipTitle.Header", 40)
	mMovie:__wf_atom_e57658c2("SiegePopUp.SiegePipTitle.SiegePipsLeft", 0, -__wf_atom_5e6e15c8 / 2 - 8)
	mMovie:__wf_atom_e57658c2("SiegePopUp.SiegePipTitle.SiegePipsRight", 0, __wf_atom_5e6e15c8 / 2 + 8)
	local v5 = tonumber(p)
	local v6 = p2 == nil and 2 or tonumber(p2)
	mMovie:OverrideMaterial("SiegePopUp.Cloud", siegePopupCloudMaterial)
	local v7 = math.max(0, v6 / 2)
	local v8 = math.max(0, v5 - v6 * 2)
	mMovie:__wf_atom_e57658c2("SiegePopUp", 1, 50)
	mMovie:__wf_atom_e57658c2("SiegePopUp.WavyDecos", 5, 90)
	mMovie:__wf_atom_e57658c2("SiegePopUp.WavyDecos", 6, 90)
	__wf_atom_ec43d06e(mMovie, "SiegePopUp.WavyDecos", 0, { 5, 6 }, { 100, 100 }, v8 + v6 * 2)
	__wf_atom_ec43d06e(mMovie, "SiegePopUp", 8, { 12, 1 }, { 100, 79 }, v7, 0, function()
		if callback ~= nil then
			callback()
		end

		__wf_atom_ec43d06e(mMovie, "SiegePopUp.Cloud", 0, { 5, 6 }, { 120, 120 }, v8 - 0.2, 0, function()
			__wf_atom_ec43d06e(mMovie, "SiegePopUp.Cloud", 8, { 5, 6 }, { 400, 400 }, v6, 0)
		end)
		__wf_atom_ec43d06e(mMovie, "SiegePopUp", 8, { 12, 1 }, { 0, 79 }, v6 / 2, v8, function()
			mMovie:Close()
		end)
	end)
end

function SiegeStart(p, p2)
	local v5 = tonumber(p2)
	mMovie:__wf_atom_50d60589(
		"SiegePopUp.SiegePipTitle.Header",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/SiegeStarted", true)
	)
	mMovie:__wf_atom_50d60589("SiegePopUp.Header2", 36, mMovie:__wf_atom_8e9ac384(p, true))
	module.PlaySound(siegeStartUISound)
	fn(v5)
end

function PolluterStart(p, p2)
	local v5 = tonumber(p2)
	mMovie:__wf_atom_50d60589(
		"SiegePopUp.SiegePipTitle.Header",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/PolluterTowerStarted", true)
	)
	mMovie:__wf_atom_50d60589("SiegePopUp.Header2", 36, mMovie:__wf_atom_8e9ac384(p, true))
	module.PlaySound(polluterStartUISound)
	fn(v5)
end

function SiegeEnd(p, p2, p3, p4)
	local v5 = tonumber(p) or 0
	local v6 = tonumber(p3)
	local v7 = tonumber(p4)
	module.PlaySound(siegeEndUISound)
	__wf_atom_86cbd68d(mMovie, "SiegePopUp.gotoAndStop", 20)
	mMovie:__wf_atom_50d60589(
		"SiegePopUp.SiegePipTitle.Header",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/SiegeEnded", true)
	)
	mMovie:__wf_atom_50d60589("SiegePopUp.Header2", 36, mMovie:__wf_atom_8e9ac384(p2, true))
	local v8 = math.max(1, #siegePopupRankIcons - v5)
	local siegePopupRankIcon = siegePopupRankIcons[v8]
	mMovie:__wf_atom_c90af43a("SiegePopUp.Rank", siegePopupRankIcon)
	fn(v6, function()
		__wf_atom_86cbd68d(mMovie, "SiegePopUp.gotoAndPlay", 20)
	end, v7)
end

function SiegeAbandoned(p, p2, p3)
	local v5 = tonumber(p2)
	local v6 = tonumber(p3)
	mMovie:__wf_atom_50d60589(
		"SiegePopUp.SiegePipTitle.Header",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/SiegeAbandoned", true)
	)
	mMovie:__wf_atom_50d60589("SiegePopUp.Header2", 36, mMovie:__wf_atom_8e9ac384(p, true))
	module.PlaySound(siegeAbandonedUISound)
	fn(v5, nil, v6)
end

function SubbossKilled(p, p2, p3)
	local v5 = tonumber(p2)
	local v6 = tonumber(p3)
	mMovie:__wf_atom_50d60589(
		"SiegePopUp.SiegePipTitle.Header",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Objectives/SubbossKilled", true)
	)
	mMovie:__wf_atom_50d60589("SiegePopUp.Header2", 36, mMovie:__wf_atom_8e9ac384(p, true))
	mMovie:__wf_atom_c90af43a("SiegePopUp.OdeIcon", subbossIcon)
	mMovie:__wf_atom_2dedec1a("SiegePopUp.OdeIcon", 13, module4.IsHardModeActive())
	mMovie:__wf_atom_2dedec1a("SiegePopUp.CenterDot", 13, false)

	if module4.IsHardModeActive() then
		mMovie:__wf_atom_c90af43a("SiegePopUp.Cloud", subbossCloudTexture)
		module.PlaySound(bossKilledStingerHardModeSound)
		module.PlaySound(bossKilledHardModeMusicSound)
	else
		module.PlaySound(bossKilledStingerSound)
		module.PlaySound(bossKilledMusicSound)
	end

	fn(v5, nil, v6)
end

function Initialize()
	if _T.DisableLocationNotifications then
		mMovie:Close()
		return
	end

	v = module2.CreateTimerMgr()
	mMovie:__wf_atom_e57658c2("Location", 12, 0)
	mMovie:__wf_atom_e57658c2("Location", 1, -100)
	mMovie:__wf_atom_e57658c2("Souls", 12, 0)
	mMovie:__wf_atom_e57658c2("Location.LorePipTitle", 12, 0)
	mMovie:__wf_atom_e57658c2("Location.LongGlow", 12, 0)
	mMovie:__wf_atom_2dedec1a("Location.LorePip", 13, false)
	mMovie:__wf_atom_e57658c2("SiegePopUp", 12, 0)
	__wf_atom_86cbd68d(mMovie, "SiegePopUp.gotoAndStop", 1)
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v) then
		v:Update(__wf_atom_084b3e93())
	end

	if v2 then
		local v5 = math.abs((math.sin(__wf_atom_4658d645(Time() * 0.7) * 2 * 3.141592653589793)))
		local v6 = __wf_atom_24a82b69(v5)
		mMovie:__wf_atom_e57658c2(v2, 5, __wf_atom_104bfe98(18.6, 25, v6))
		mMovie:__wf_atom_e57658c2(v2, 6, __wf_atom_104bfe98(18.6, 25, v6))
		mMovie:__wf_atom_e57658c2(v2, 16, __wf_atom_4658d645(Time() * 0.15) * 360)
	end

	local v5 = Time()

	for i = 1, #v3 do
		local v6 = v3[i][1]
		local v7 = v3[i][2]
		local v8 = v3[i][3]
		local v9 = v3[i][4]
		local v10 = i * 17
		local v11 = Noise(v10 + v5 * 0.3)
		local v12 = Noise(v10 + 3.3 + v5 * 0.3)
		mMovie:__wf_atom_e57658c2(v6, 0, v7 + v11 * 20)
		mMovie:__wf_atom_e57658c2(v6, 1, v8 + v12 * 20)
		local v13 = __wf_atom_104bfe98(0.3, 0.6, Noise(v10 + 17 + v5 * 0.2))
		mMovie:__wf_atom_e57658c2(v6, 5, v9 + v13 * 100)
		mMovie:__wf_atom_e57658c2(v6, 6, v9 + v13 * 100)
		local v14 = __wf_atom_104bfe98(0.5, 1, (math.sin(v10 + 6.283185307179586 * __wf_atom_4658d645(v5 * 0.3))))
		mMovie:__wf_atom_e57658c2(v6, 12, v14 * 100)
	end

	local v6

	if _T.HideHud == nil then
		v6 = false
	else
		v6 = _T.HideHud > 0
	end

	if v4 ~= v6 then
		v4 = v6
		mMovie:SetVisible(not v6)
	end
end

function CloseNotification(p)
	local v5 = tonumber(p)
	local v6 = __wf_atom_7e8ad928(v5) and 0 or v5
	mMovie:__wf_atom_290807ee("_root")
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 2, v6, function()
		mMovie:Close()
	end)
end