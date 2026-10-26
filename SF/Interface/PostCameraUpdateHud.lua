local module = require("Lotus.Interface.UIUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("EE.Interface.AnchorMgr")
local v = Type("/SF/Types/Game/HealthShieldDisplay")
local v2 = Type("/Lotus/Types/Game/Hints/HealthBarAnchor")
local v3 = WeakResource("/Lotus/Types/Restoratives/Consumable/Scanner")
local v4 = WeakResource("/Lotus/Types/Restoratives/Consumable/LibraryScanner")
local v5 = WeakResource("/Lotus/Types/Game/MarkerInfos/AreaExtractionMarker")
local v6 = WeakResource("/Lotus/Types/Game/MarkerInfos/SpaceEnemyCrewShipMarkerInfo")
local v7 = WeakResource("/Lotus/Types/Game/MarkerInfos/SpaceTurretMarkerInfo")
local v8 = { "UIMaterial_SpaceMarker", "UIMaterial_SpaceMarkerCrewShip", "UIMaterial_SpaceMarkerCircle" }
Symbol("SecondChance")
local v9 = (function(...)
	local result = {}

	for i, raw in ipairs({ ... }) do
		result[i] = { Raw = raw }
	end

	return result
end)("DT_IMPACT", "DT_PUNCTURE", "DT_SLASH", "DT_FIRE", "DT_FREEZE", "DT_ELECTRICITY", "DT_POISON", "DT_EXPLOSION", "DT_RADIATION", "DT_GAS", "DT_MAGNETIC", "DT_VIRAL", "DT_CORROSIVE")
local _ = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12
}
local v10 = nil
local v11 = false
local v12 = false
local v13 = false
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local gGameRules2 = nil
local v20 = nil
local v21 = {}
local v22 = false
local v23 = 0
local v24 = 0
local v25 = -1
local v26 = -1
local v27 = 1280
local v28 = 720
local v29 = 1
local v30 = { nil, nil }
v30[1], v30[2] = 0, 0
local v31 = 1
local v32 = 1
local v33 = 0
local v34 = 0
local v35 = {}
local v36 = {}
local v37 = {}
local v38 = true
local v39 = {}
local v40 = {}
local v41 = 1
local v42 = false
local v43 = true
local v44 = true
local v45 = nil
local v46 = {}
local v47 = {}
local v48 = nil
local v49 = nil
local v50 = nil
local flag = false
local v51 = nil
local v52 = nil
local v53 = false
local v54 = nil
local v55 = nil
local v56 = nil
local v57 = {}
local v58 = {}
local v59 = {}
local v60 = {}
local v61 = false
local v62 = false
local v63 = false
local v64 = 0
local v65 = nil
local v66 = nil
local v67 = 0.3
local v68 = true
local v69 = 0
local v70 = 0
local v71 = nil
local v72 = nil

local function fn(p)
	local __wf_atom_76657dba = mMovie:__wf_atom_76657dba(p, "_initialY")

	if __wf_atom_7e8ad928(__wf_atom_76657dba) or tostring(__wf_atom_76657dba) == "undefined" then
		__wf_atom_76657dba = mMovie:__wf_atom_5e6e15c8(p, 1)
		mMovie:__wf_atom_976dcedd(p, "_initialY", __wf_atom_76657dba)
	end

	return (tonumber(__wf_atom_76657dba))
end

local function fn2(p)
	v71 = p
end

local function fn3()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	v71 = nil
	mMovie:__wf_atom_e57658c2("HintMessage", 0, v69)
	mMovie:__wf_atom_e57658c2("HintMessage", 1, v70)
end

local function fn4(text, replace)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	v72 = { text = text, replace = replace }
end

local function fn5(p)
	if v44 then
		return
	end

	local v73 = fn("TargetStatus1")
	mMovie:__wf_atom_290807ee("TargetStatus1")
	local v74 = v73 + module2.Ternary(p, 100, 0)
	local y = v10:GetOriginalCoords("TargetStatus1").y
	local v75 = { function(p2)
			v10:ChangeOriginalCoords("TargetStatus1", nil, y + (v74 - y) * p2)
			v10:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true, v30)
		end }
	__wf_atom_ec43d06e(mMovie, "TargetStatus1", 2, v75, { 1 }, 0.25)
end

local function fn6(p)
	v50:Update(p)

	if v50:__wf_atom_071063d0() <= 0 then
		__wf_atom_ec43d06e(mMovie, "BossStatus", 0, { 12 }, { 0 }, 0.25, 1, function()
			fn5(false)
		end)
		flag = false
		v55 = nil
		v56 = nil
	elseif not __wf_atom_7e8ad928(v51) then
		if v55 == nil then
			local __wf_atom_68de036a = v51:__wf_atom_68de036a()

			if __wf_atom_68de036a ~= v56 then
				v56 = __wf_atom_68de036a
				mMovie:__wf_atom_48bd5a59("BossStatus", "Level", 36, v56)
			end
		end

		local v73 = nil

		for i = 1, #v9 do
			local __wf_atom_846af4f8 = v54:__wf_atom_846af4f8(i - 1)

			if not (__wf_atom_846af4f8 > 0 and v9[i] ~= nil) then
				continue
			end

			if v73 == nil then
				v73 = v9[i].Icon .. __wf_atom_846af4f8
			else
				v73 ..= " " .. v9[i].Icon .. __wf_atom_846af4f8
			end
		end

		mMovie:__wf_atom_48bd5a59("BossStatus", "Status", 36, v73)
	end

	if v53 and not __wf_atom_7e8ad928(v52) then
		local __wf_atom_6a5c92a7 = v52:__wf_atom_6a5c92a7()
		local v73 = v52:__wf_atom_f3044fe0() / __wf_atom_6a5c92a7
		mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar.FillMask", 14, (math.max(0.01, v73 * 440)))
	end
end

local function fn7()
	local v73 = gRegion:IsMaster() and 3 or 4
	mMovie:__wf_atom_7f57ab2f("BossStatus", "Segment", 13, false)
	v50 = gRegion:CreateObject(v, nil, v73)
	v50:Setup(mMovie, nil, 508, "BossStatus", "")
	v50:__wf_atom_94a0e155(true)
	v50:__wf_atom_95b8d07d(false)
	v50:__wf_atom_2dcbceda(true)
	mMovie:__wf_atom_4c1c1986("BossStatus", "ShieldBar", 0, -254)
	mMovie:__wf_atom_4c1c1986("BossStatus", "ShieldBar.Trough", 14, 508)
	mMovie:__wf_atom_4c1c1986("BossStatus", "ShieldBar.RightCap", 0, 505)
	mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar", 0, -254)
	mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar.DetailRight", 0, 444)
	mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar.TroughRight", 0, 459)
	mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar.TroughMid", 14, 410)
	mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar.BgFillRight", 0, 459)
	mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar.BgFillMid", 14, 410)
	mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar.FillRight", 0, 459)
	mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar.FillMid", 14, 410)
	mMovie:__wf_atom_4c1c1986("BossStatus", "EnergyBar.FillMask", 14, 440)
	mMovie:__wf_atom_e57658c2("BossStatus.EnergyBar.BgFillLeft", 12, 20)
	mMovie:__wf_atom_e57658c2("BossStatus.EnergyBar.BgFillMid", 12, 20)
	mMovie:__wf_atom_e57658c2("BossStatus.EnergyBar.BgFillRight", 12, 20)
	mMovie:OverrideMaterial("BossStatus", _G.UIMaterial_Plain)
	mMovie:OverrideMaterial("BossStatus.LevelFrame", _G.UIMaterial_Plain)
	mMovie:OverrideMaterial("BossStatus.EnergyBar.BgFillLeft", _G.UIMaterial_Plain)
	mMovie:OverrideMaterial("BossStatus.EnergyBar.BgFillMid", _G.UIMaterial_Plain)
	mMovie:OverrideMaterial("BossStatus.EnergyBar.BgFillRight", _G.UIMaterial_Plain)
	mMovie:OverrideMaterial("BossStatus.EnergyBar.FillLeft", bossEnergyMaterial)
	mMovie:OverrideMaterial("BossStatus.EnergyBar.FillMid", bossEnergyMaterial)
	mMovie:OverrideMaterial("BossStatus.EnergyBar.FillRight", bossEnergyMaterial)
end

local function fn8()
	for i = 1, #v47 do
		mMovie:__wf_atom_e57658c2(v47[i].mClipName, 12, 0)
	end

	if __wf_atom_72884638("HUD.UseAlternateHud") or __wf_atom_72884638("HUD.HideStatusBars") then
		return
	end

	v47 = {}
	local v73 = gRegion:IsMaster() and 3 or 4

	for i = 1, module2.Ternary(v44, 3, 1) do
		local mClipName = "TargetStatus" .. i

		if not mMovie:__wf_atom_253d7085(mClipName) then
			__wf_atom_86cbd68d(mMovie, "TargetStatus1.duplicateMovieClip", mClipName, 11000 + i)
		end

		local v75 = {
			mClipName = mClipName,
			mActive = false,
			["mPtr"] = nil,
			mDeco = nil,
			mAvatar = nil,
			mHitProxy = nil,
			mPersist = 0,
			mActiveProcs = {},
			mActiveImmunities = {}
		}

		for j = 1, #v9 do
			v75.mActiveProcs[j] = 0
			v75.mActiveImmunities[j] = false
		end

		v75.mHpShieldDisplayWidth = 110
		v75.mHpShieldDisplay = gRegion:CreateObject(v, nil, v73)
		v75.mHpShieldDisplay:Setup(mMovie, nil, v75.mHpShieldDisplayWidth, mClipName .. ".Target", "")
		v75.mHpShieldDisplay:__wf_atom_fe4bd1af(true)
		mMovie:__wf_atom_48bd5a59(v75.mClipName, "Name", 46, "bottom")
		mMovie:__wf_atom_50d60589(v75.mClipName .. ".Name", 36, "")
		mMovie:__wf_atom_50d60589(v75.mClipName .. ".Immunities", 36, "")
		mMovie:__wf_atom_7f57ab2f(v75.mClipName, "Immunities", 89, true)
		mMovie:__wf_atom_4c1c1986(mClipName, "Name", 44, v46.Text)
		mMovie:__wf_atom_4c1c1986(mClipName, "Level", 44, v46.Text)
		mMovie:__wf_atom_4c1c1986(mClipName, "UnderLotus", 11, v46.Text)
		v75.mHpShieldDisplay:__wf_atom_95b8d07d(false)
		mMovie:__wf_atom_4c1c1986(v75.mClipName, "Target", 0, v75.mHpShieldDisplayWidth * -0.5)
		mMovie:__wf_atom_e57658c2(mClipName, 12, 0)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Target", 13, v12 ~= module3.UI_MODE_IN_SPACE_HUB)
		mMovie:__wf_atom_4c1c1986(v75.mClipName, "Target.Right", 0, v75.mHpShieldDisplayWidth)
		table.insert(v47, v75)
	end

	if v10 ~= nil then
		v10:Unregister(mMovie, "TargetStatus1")

		if not v44 then
			local v74 = fn("TargetStatus1")
			mMovie:__wf_atom_e57658c2("TargetStatus1", 0, mMovie:__wf_atom_97cd8326() * 0.5)
			mMovie:__wf_atom_e57658c2("TargetStatus1", 1, v74)
			v10:Register(mMovie, "TargetStatus1", { v10.ANCHOR_V_TOP, v10.ANCHOR_H_CENTRE })
			v10:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true, v30)
		end
	end
end

local function fn9()
	v31 = 100 / mMovie:__wf_atom_5e6e15c8("_root", 5)
	v32 = 100 / mMovie:__wf_atom_5e6e15c8("_root", 6)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 0)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 1)
	v33 = __wf_atom_5e6e15c8 * v31
	v34 = __wf_atom_5e6e15c8_2 * v32
end

local function fn10(object)
	if __wf_atom_7e8ad928(object) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			return
		end

		object = __wf_atom_18a5d83b:Settings()

		if __wf_atom_7e8ad928(object) then
			return
		end
	end

	v46.Text = object:__wf_atom_fd5d793e(21)
	v46.Health = object:__wf_atom_fd5d793e(23)
	v46.DecoHealth = object:__wf_atom_fd5d793e(38)
	v46.Energy = object:__wf_atom_fd5d793e(16)
	mMovie:__wf_atom_e57658c2("HintMessage", 44, v46.Text)
	mMovie:__wf_atom_e57658c2("BossStatus.EnergyBar.DetailLeft", 11, 16114605)
	mMovie:__wf_atom_e57658c2("BossStatus.EnergyBar.DetailRight", 11, 16114605)
	mMovie:__wf_atom_e57658c2("BossStatus.EnergyBar.FillLeft", 11, v46.Energy)
	mMovie:__wf_atom_e57658c2("BossStatus.EnergyBar.FillMid", 11, v46.Energy)
	mMovie:__wf_atom_e57658c2("BossStatus.EnergyBar.FillRight", 11, v46.Energy)

	for i = 1, #v47 do
		mMovie:__wf_atom_4c1c1986(v47[i].mClipName, "Name", 44, v46.Text)
		mMovie:__wf_atom_4c1c1986(v47[i].mClipName, "Level", 44, v46.Text)
		mMovie:__wf_atom_4c1c1986(v47[i].mClipName, "UnderLotus", 11, v46.Text)
	end

	if v40 ~= nil then
		for i = 1, 8 do
			if v40[i] == nil then
				continue
			end

			local clipName = v40[i].Player.clipName
			local clipName2 = v40[i].Kubrow.clipName
			mMovie:__wf_atom_4c1c1986(clipName, "Name", 44, v46.Text)
			mMovie:__wf_atom_4c1c1986(clipName, "Range", 44, v46.Text)
			mMovie:__wf_atom_4c1c1986(clipName, "Progress", 11, v46.Health)
			mMovie:__wf_atom_4c1c1986(clipName2, "Name", 44, v46.Text)
			mMovie:__wf_atom_4c1c1986(clipName2, "Range", 44, v46.Text)
			mMovie:__wf_atom_4c1c1986(clipName2, "Progress", 11, v46.Health)
		end
	end
end

local function fn11(p)
	if not __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local settings = __wf_atom_18a5d83b:Settings()

	if not __wf_atom_7e8ad928(settings) then
		fn10()
		v29 = settings:__wf_atom_db8b3656()
		v42 = settings:__wf_atom_94c0478f()
		local v73 = v44
		v44 = settings:__wf_atom_fd105887()

		if p or v73 ~= v44 then
			fn8()
		end

		v43 = settings:__wf_atom_1bcf302b()
	end

	v30 = module.HandleHudScale(mMovie, v29, v10)
	fn9()
end

local function fn12()
	v40 = {}

	for i = 1, 8 do
		v40[i] = {}
		v40[i].Player = {
			clipName = "Teammate" .. i,
			isPredeath = false
		}
		v40[i].Kubrow = {
			clipName = "Teammate" .. i .. "Kubrow",
			isPredeath = false
		}
	end
end

local function fn13()
	for i = 1, #v9 do
		v9[i].NameTag = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/" .. v9[i].Raw .. "_NoIcon", false)
		v9[i].Icon = mMovie:__wf_atom_8e9ac384("<" .. v9[i].Raw .. ">", true)
	end
end

function Shutdown()
	for i = 1, #v40 do
		if not __wf_atom_7e8ad928(v40[i].Player.HealthAndShield) then
			gRegion:__wf_atom_dd1e4d10(v40[i].Player.HealthAndShield)
		end

		if not __wf_atom_7e8ad928(v40[i].Kubrow.HealthAndShield) then
			gRegion:__wf_atom_dd1e4d10(v40[i].Kubrow.HealthAndShield)
		end
	end

	for i = 1, #v47 do
		if not __wf_atom_7e8ad928(v47[i].mHpShieldDisplay) then
			gRegion:__wf_atom_dd1e4d10(v47[i].mHpShieldDisplay)
		end
	end

	_T.ResetHudHintPos = nil
	_T.SetHudHintPosWorld = nil
	_T.SetHudHintMessage = nil
	_T.SetupBossAvatar = nil
end

function Initialize()
	if
		not __wf_atom_7e8ad928(commonResourcesMovie)
		and __wf_atom_7e8ad928(__wf_atom_8e4fda44:FindMovie(commonResourcesMovie))
	then
		__wf_atom_8e4fda44:__wf_atom_8b74c30b(commonResourcesMovie)
	end

	gGameRules2 = gGameRules
	v13 = gGameRules2:IsA(__wf_atom_abe10cec)
	print("LOTUS_UTIL:", module3)
	print("GetUIMode field:", module3 and module3.GetUIMode)
	v12 = module3.GetUIMode()
	v20 = mMovie:__wf_atom_2ad5cd23()
	v27 = mMovie:__wf_atom_97cd8326()
	v28 = mMovie:__wf_atom_54eeda24()
	v25 = mMovie:__wf_atom_d5a50cb5()
	v26 = mMovie:__wf_atom_c4f6543f()
	v64 = math.min(v25, v26) * 0.15
	v10 = module4.Create(mMovie)
	v10:Register(mMovie, "HintMessage", { v10.ANCHOR_V_CENTRE, v10.ANCHOR_H_CENTRE })
	v10:Register(mMovie, "BossStatus", { v10.ANCHOR_V_TOP, v10.ANCHOR_H_CENTRE })
	v10:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true, v30)
	v65 = module2.ConvertColorNumberToProceduralRGB(_G.UIColor_Shield)
	v66 = module2.ConvertColorNumberToProceduralRGB(_G.UIColor_Overshield)
	fn13()
	fn("TargetStatus1")
	fn11(true)

	if __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		__wf_atom_55142dd4(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01(), "OnProfileSaved")
	end

	mMovie:__wf_atom_e57658c2("TargetStatus1", 12, 0)
	mMovie:__wf_atom_e57658c2("Marker1", 12, 0)
	fn12()
	mMovie:__wf_atom_2dedec1a("Teammate1", 13, false)
	mMovie:__wf_atom_e57658c2("HintMessage", 12, 0)
	mMovie:__wf_atom_e57658c2("BossStatus", 12, 0)
	fn7()

	if module3.GetUIMode() == module3.UI_MODE_IN_SPACE_SHIP then
		hudMaterial:__wf_atom_a042ff6c(SF.__wf_atom_c087f126, 0)
		hudMaterial:__wf_atom_a042ff6c(SF.__wf_atom_4b3f4099, 0)
		hudFontMaterial:__wf_atom_a042ff6c(SF.__wf_atom_c087f126, 0)
		hudFontMaterial:__wf_atom_a042ff6c(SF.__wf_atom_4b3f4099, 0)
	end

	v69 = mMovie:__wf_atom_5e6e15c8("HintMessage", 0)
	v70 = mMovie:__wf_atom_5e6e15c8("HintMessage", 1)
	mMovie:__wf_atom_e57658c2("HintMessage", 5, "50")
	mMovie:__wf_atom_e57658c2("HintMessage", 6, "50")
	fn10()
	_T.ResetHudHintPos = fn3
	_T.SetHudHintPosWorld = fn2
	_T.SetHudHintMessage = fn4
end

local function fn14()
	v21 = v18:__wf_atom_a49f5825()
	v21[1].clipIndex = mMovie:__wf_atom_26fc837d("Marker1")

	for i = 1, #v21 do
		local clipName = "Marker" .. tostring(i)

		if i > 1 then
			__wf_atom_86cbd68d(mMovie, "Marker1.duplicateMovieClip", clipName, 50 + i)
		end

		v59[clipName] = {
			LastArrowScreenX = -1,
			LastArrowScreenY = -1,
			Shape = 1,
			LastDamageFactor = 0
		}
		local __wf_atom_26fc837d = mMovie:__wf_atom_26fc837d(clipName)
		v21[i].clipName = clipName
		v58[clipName] = {}
		v21[i].clipIndex = __wf_atom_26fc837d
		v21[i].arrowClipIndex = mMovie:__wf_atom_26fc837d(clipName .. ".Marker.arrow")
		v21[i].arrowImageClipIndex = mMovie:__wf_atom_26fc837d(clipName .. ".Marker.arrow.ArrowGraphic")
		v21[i].scanRangeClipIndex = mMovie:__wf_atom_26fc837d(clipName .. ".Marker.ScanRange")
		v21[i].labelVarName = clipName .. ".Marker.Label.text"
		mMovie:__wf_atom_4c1c1986(clipName, "Marker.StackCount", 12, 0)
		mMovie:__wf_atom_7f57ab2f(clipName, "Marker.StackCountBackground", 13, false)
		mMovie:__wf_atom_7f57ab2f(clipName, "Marker.arrowOutline", 13, false)
		mMovie:__wf_atom_7f57ab2f(clipName, "Marker.MarkerOutline", 13, false)

		if v60.StackCount == nil then
			v60.StackCount = mMovie:__wf_atom_5e6e15c8(clipName .. ".Marker.StackCount", 1)
			v60.StackCountBackground = mMovie:__wf_atom_5e6e15c8(clipName .. ".Marker.StackCountBackground", 1)
			v60.Label = mMovie:__wf_atom_5e6e15c8(clipName .. ".Marker.Label", 1)
			v60.ArrowGraphic = mMovie:__wf_atom_5e6e15c8(clipName .. ".Marker.arrow.ArrowGraphic", 1)
		end

		mMovie:OverrideMaterial(clipName .. ".Marker.CustomIcon", markerIconMask)
		mMovie:__wf_atom_87c1f39f(__wf_atom_26fc837d, 13, true)
		__wf_atom_83c14687(0)
	end

	function _T.GetFlashMarker(p, p2)
		if __wf_atom_7e8ad928(p) then
			return nil
		end

		for i = 1, #v21 do
			if __wf_atom_7e8ad928(v21[i]) then
				continue
			end

			local __wf_atom_cd79d6f3 = v21[i]:__wf_atom_cd79d6f3()

			if __wf_atom_cd79d6f3 == p and (p2 == nil or __wf_atom_cd79d6f3:__wf_atom_6a3d8b57() == p2) then
				return v21[i]
			end
		end

		return nil
	end
end

local function fn15()
	if __wf_atom_7e8ad928(v15) then
		v15 = mMovie:__wf_atom_7be51ede()

		if __wf_atom_7e8ad928(v15) then
			return false
		end

		v19 = v15:__wf_atom_cca6e0bc()

		if __wf_atom_7e8ad928(v19) then
			v15 = nil
			return false
		end
	end

	if __wf_atom_7e8ad928(v14) then
		v14 = v15:CameraControl()
	end

	local v73

	if __wf_atom_7e8ad928(v14) or not v14:__wf_atom_e62e24d5() or __wf_atom_7e8ad928(v14:__wf_atom_d891a752()) then
		if v11 or __wf_atom_7e8ad928(v16) then
			v73 = v15:__wf_atom_50a7d83e()

			if not __wf_atom_7e8ad928(v73) then
				v11 = false
			end
		else
			v73 = module3.GetPlayerAvatar(v15, v16)
		end
	else
		v73 = v14:__wf_atom_d891a752()
		v11 = true
	end

	if __wf_atom_7e8ad928(v73) then
		return false
	end

	if
		v11 and not __wf_atom_7e8ad928(v15:__wf_atom_50a7d83e())
		or not v11 and not __wf_atom_7e8ad928(v73) and (__wf_atom_7e8ad928(v16) or v16 ~= v73)
	then
		local __wf_atom_d2b2176d = v73:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) and __wf_atom_d2b2176d:IsA(__wf_atom_4d316097) then
			v17 = __wf_atom_d2b2176d
		end

		if __wf_atom_7e8ad928(v17) then
			return false
		end

		if __wf_atom_7e8ad928(v18) then
			v18 = v15:__wf_atom_301e8d97()

			if __wf_atom_7e8ad928(v18) then
				return false
			else
				fn14()
			end
		end

		v16 = v73
		v41 = 1 / v16:__wf_atom_c082fc3d()
	end

	v25 = mMovie:__wf_atom_97cd8326()
	v26 = mMovie:__wf_atom_54eeda24()

	if not Engine.__wf_atom_fc67ba71() then
		v25 = mMovie:__wf_atom_d5a50cb5()
		v26 = mMovie:__wf_atom_c4f6543f()
	end

	if #v35 ~= 0 then
		return true
	end

	v35 = gRegion:__wf_atom_3c8e1a7a()
	v36 = {}

	if #v35 ~= 0 then
		gRegion:__wf_atom_d5ede414("OnPlayersChanged")
	end

	return true
end

local function fn16()
	if __wf_atom_7e8ad928(v17) then
		return false
	end

	for i = 1, v17:__wf_atom_62abd325(0) do
		local __wf_atom_ba1c3957 = v17:__wf_atom_ba1c3957(i - 1, 0)

		if
			not __wf_atom_7e8ad928(__wf_atom_ba1c3957)
			and (__wf_atom_ba1c3957:IsA(v3) or __wf_atom_ba1c3957:IsA(v4))
			and v17:__wf_atom_b62f2024(i - 1, 0) > 0
		then
			return true
		end
	end

	return false
end

local function fn17(object)
	if object.arrowWasVisible == object.arrowVisible and not object.isNew then
		return
	end

	local __wf_atom_cd79d6f3 = object:__wf_atom_cd79d6f3()

	if
		__wf_atom_7e8ad928(__wf_atom_cd79d6f3)
		or object.arrowWasVisible == object.arrowVisible and not __wf_atom_cd79d6f3:__wf_atom_03cad03d()
	then
		return
	end

	local v73

	if object.arrowVisible then
		v73 = __wf_atom_cd79d6f3:__wf_atom_cba4f692()
	else
		v73 = __wf_atom_cd79d6f3:__wf_atom_a2d8c279()
	end

	local pos = object.pos
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			local __wf_atom_5d9ae734 = __wf_atom_d2b2176d:__wf_atom_5d9ae734()

			if not __wf_atom_7e8ad928(__wf_atom_5d9ae734) then
				pos = __wf_atom_5d9ae734:__wf_atom_6d529967(pos)
			end
		end
	end

	module2.PlaySound(v73, pos)
end

local function fn18(data, p, p2)
	if data.markerType >= 49 and data.markerType <= 56 then
		return false
	end

	local v73 = data.markerType == 37 or data.showBoundingArrows
	local _ = data.markerType == 105

	if p == nil then
		p = v59[data.clipName]
	end

	if p2 == nil then
		local __wf_atom_5d9ae734 = v17:__wf_atom_5d9ae734()
		p2 = not __wf_atom_7e8ad928(__wf_atom_5d9ae734) and __wf_atom_5d9ae734:__wf_atom_c16ea330(v16, true, false)
	end

	return (not v73 or not p.IsEmplacementMarker or __wf_atom_7e8ad928(v16) or not v16:__wf_atom_b2f8ef81()) and true
		or not p2
end

local function fn19(distanceToEye)
	return mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/UNIT_METER", true, {
		COUNT = distanceToEye
	})
end

local function fn20(p)
	local __wf_atom_97cd8326 = mMovie:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = mMovie:__wf_atom_54eeda24()

	if not Engine.__wf_atom_fc67ba71() then
		__wf_atom_97cd8326 = math.max(__wf_atom_97cd8326, mMovie:__wf_atom_d5a50cb5())
		__wf_atom_54eeda24 = math.max(__wf_atom_54eeda24, mMovie:__wf_atom_c4f6543f())
	end

	local v73 = __wf_atom_97cd8326 * 0.5
	local v74 = __wf_atom_54eeda24 * 0.5
	local v75 = not __wf_atom_7e8ad928(gGameRules2) and gGameRules2:__wf_atom_0fa72b69() == 1
	local v76 = 1
	local v77 = 1

	if v26 < v28 and v27 < v25 then
		v76 = v25 / v27
	elseif v25 < v27 and v28 < v26 then
		v77 = v26 / v28
	end

	local __wf_atom_5d9ae734 = v17:__wf_atom_5d9ae734()
	local v78 = not __wf_atom_7e8ad928(__wf_atom_5d9ae734) and __wf_atom_5d9ae734:__wf_atom_c16ea330(v16, true, false)

	for _, v79 in pairs(v21) do
		if v79.garbage or __wf_atom_7e8ad928(v79.clipName) or __wf_atom_7e8ad928(v59[v79.clipName]) then
			continue
		end

		local v80 = v79.markerType == 37 or v79.showBoundingArrows
		local _ = v79.markerType == 105
		local isProgressMarker = v79.isProgressMarker
		local clipName = v79.clipName
		local v81 = v59[clipName]
		local parentAvatar = nil
		local v82 = nil
		local parentDeco = nil
		local v83 = nil
		local markerWPtr, v84

		if v79.isNew then
			v22 = true
			markerWPtr = v79:__wf_atom_cd79d6f3()
			v84 = not __wf_atom_7e8ad928(markerWPtr)
			v81.markerWPtr = markerWPtr

			if v84 then
				local __wf_atom_3d96ddcd = markerWPtr:__wf_atom_3d96ddcd()

				if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_4ebf67cb) then
					if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_8d0b7f88) then
						v81.parentDeco = __wf_atom_3d96ddcd
						v81.parentAvatar = nil
						parentDeco = __wf_atom_3d96ddcd
						v82 = false
						v83 = true
					end
				else
					v81.parentAvatar = __wf_atom_3d96ddcd
					v81.parentDeco = nil
					parentAvatar = __wf_atom_3d96ddcd
					v82 = true
					v83 = false
				end
			end

			v81.IsEmplacementMarker = v84 and markerWPtr:__wf_atom_cfa23ff1()

			if v81.IsEmplacementMarker and v78 then
				v79.isNew = false
			end

			if v80 then
				if v82 and parentAvatar:__wf_atom_6165bb29() then
					parentAvatar:__wf_atom_fff90d1d(false)
				elseif v83 and not parentDeco:__wf_atom_b2f4c3d9() then
					parentDeco:__wf_atom_43893fc0(true)
				end
			end
		else
			markerWPtr = v81.markerWPtr
			v84 = not __wf_atom_7e8ad928(markerWPtr)
			parentAvatar = v81.parentAvatar
			v82 = not __wf_atom_7e8ad928(parentAvatar)
			parentDeco = v81.parentDeco
			v83 = not __wf_atom_7e8ad928(parentDeco)
		end

		local v85 = fn18(v79, v81, v78)
		fn17(v79)

		if v85 then
			local v86 = false
			local v87 = nil
			local v88 = v84 and markerWPtr:__wf_atom_5243c20b()
			local lastArrowScreenX = v79:__wf_atom_7b352aa8() / v76
			local lastArrowScreenY = v79:__wf_atom_7e5b2ca8() / v77

			if
				v79.arrowVisible
				and (math.abs(v81.LastArrowScreenX - lastArrowScreenX) > 0.75 or math.abs(v81.LastArrowScreenY - lastArrowScreenY) > 0.75)
			then
				local angleBetweenPoints = module2.GetAngleBetweenPoints(v73, lastArrowScreenY, lastArrowScreenX, v74)
				mMovie:__wf_atom_3783a721(v79.arrowClipIndex, 16, module2.ToDeg(angleBetweenPoints))
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrowOutline", 16, module2.ToDeg(angleBetweenPoints))
				v81.LastArrowScreenX = lastArrowScreenX
				v81.LastArrowScreenY = lastArrowScreenY
			end

			if v79.arrowWasVisible ~= v79.arrowVisible then
				v79.arrowWasVisible = v79.arrowVisible
				v86 = true
				local ternary = module2.Ternary(v79.arrowVisible, module2.Ternary(v88, fillMarkerAlpha, 100), 0)
				mMovie:__wf_atom_3783a721(v79.arrowClipIndex, 12, ternary)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrowOutline", 12, ternary)

				if v80 then
					if v79.arrowVisible then
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 0, 0)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 1, 0)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 0, 0)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 1, 0)

						if v81.IconScale ~= nil then
							mMovie:__wf_atom_1ca72041(
								clipName .. ".Marker.CustomIcon",
								"AlphaTestThreshold",
								0,
								0,
								0,
								0
							)
						end

						mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 0, 0)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 1, 0)
					end

					local ternary2 = module2.Ternary(
						v79.arrowVisible or v79.showIconWithBounds,
						module2.Ternary(v88, fillMarkerAlpha, 100),
						0
					)
					local ternary3 = module2.Ternary(v79.arrowVisible, 0, 100)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 12, ternary2)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 12, ternary2)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 12, ternary2)
					mMovie:__wf_atom_4c1c1986(clipName, "Bounds", 12, ternary3)
					mMovie:__wf_atom_4c1c1986(clipName, "NewBounds", 12, ternary3)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.ScanRange", 0, -40)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.ScanRange", 1, 18)
					mMovie:__wf_atom_7f57ab2f(clipName, "Marker.ScanRange", 13, not v79.arrowVisible)

					if not v61 and v79.arrowVisible then
						v61 = true
					end
				end
			end

			if v80 and v79.arrowVisible then
				local v91, v92

				if v88 then
					v91 = 200
					v92 = 1.5
				else
					v91 = __wf_atom_421b01aa(100 + (200 - v79.distanceToEye), 50, 200)
					v92 = 2
				end

				mMovie:__wf_atom_ff01ba24(v79.arrowImageClipIndex, v91, module2.Ternary(v88, v91 / v92, v91))
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrowOutline.ArrowGraphic", 5, v91)
				mMovie:__wf_atom_4c1c1986(
					clipName,
					"Marker.arrowOutline.ArrowGraphic",
					6,
					module2.Ternary(v88, v91 / v92, v91)
				)
			end

			local v91

			if v79.markerType == 11 then
				v91 = true
			elseif v79.markerType == 75 then
				v91 = v84 and markerWPtr:IsA(v5)
			else
				v91 = false
			end

			local v92 = 0

			if v84 and markerWPtr:__wf_atom_03cad03d() and v79.stackCount > 0 then
				local v93 = v58[clipName]

				if v93.Stacks == nil then
					v93.Stacks = 0
				end

				local v94 = v93.Stacks ~= v79.stackCount

				if v79.stackCount == 1 then
					if v94 then
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.StackCount", 12, 0)

						for i = 1, v93.Stacks do
							__wf_atom_86cbd68d(mMovie, clipName .. ".Marker.StackBacker" .. i .. ".removeMovieClip")
						end

						mMovie:__wf_atom_7f57ab2f(clipName, "Marker.marker", 13, true)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 1, 0)
						mMovie:__wf_atom_7f57ab2f(clipName, "Marker.StackCountBackground", 13, false)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.Label", 1, v60.Label)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrow", 1, 0)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrow.ArrowGraphic", 1, v60.ArrowGraphic)
					end
				else
					if v94 then
						mMovie:__wf_atom_48bd5a59(clipName, "Marker.StackCount", 36, "x" .. v79.stackCount)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.StackCount", 12, 100)

						for i = 1, v79.stackCount do
							local v95 = "StackBacker" .. i

							if v93.Stacks <= i then
								__wf_atom_86cbd68d(mMovie, clipName .. ".Marker.marker.duplicateMovieClip", v95, 1 + i)
								__wf_atom_86cbd68d(mMovie, clipName .. ".Marker.CustomIcon.swapDepths", 150)

								if i == v79.stackCount then
									v92 = -3 * (i - 1)
								end
							end

							mMovie:__wf_atom_e57658c2(clipName .. ".Marker." .. v95, 1, -3 * (i - 1))
						end

						mMovie:__wf_atom_4c1c1986(clipName, "Marker.StackCount", 1, v92 + v60.StackCount)
						mMovie:__wf_atom_4c1c1986(
							clipName,
							"Marker.StackCountBackground",
							1,
							v92 + v60.StackCountBackground
						)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.Label", 1, v92 + v60.Label)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrow", 1, v92 / 2)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrow.ArrowGraphic", 1, v92 / 2 + v60.ArrowGraphic)

						for i = v79.stackCount + 1, v93.Stacks do
							__wf_atom_86cbd68d(mMovie, clipName .. ".Marker.StackBacker" .. i .. ".removeMovieClip")
						end

						mMovie:__wf_atom_7f57ab2f(clipName, "Marker.marker", 13, false)
						mMovie:__wf_atom_7f57ab2f(clipName, "Marker.StackCountBackground", 13, true)
					else
						v92 = -3 * (v93.Stacks - 1)
					end

					mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 1, v92)
				end

				v93.Stacks = v79.stackCount
				local baseAlpha = 100

				if v84 then
					local __wf_atom_42406452 = markerWPtr:__wf_atom_42406452()

					if __wf_atom_42406452 > 0 and v79.distanceToEye < __wf_atom_42406452 then
						baseAlpha = math.max(50, v79.distanceToEye / __wf_atom_42406452 * baseAlpha)
					end

					baseAlpha *= markerWPtr:__wf_atom_a70e3244()
				end

				if v84 and markerWPtr:__wf_atom_09b5b947() then
					local v96

					if v79.constrainPosition then
						v96 = v79:__wf_atom_81812ea8() >= 0
					else
						v96 = v16:__wf_atom_2f0cc054(markerWPtr)
					end

					if v96 then
						mMovie:__wf_atom_3783a721(v79.clipIndex, 12, 0)
						v79.clientWasVisible = false
					else
						if v23 ~= v24 or v79.isNew or not v79.clientWasVisible or v81.BaseAlpha ~= baseAlpha then
							mMovie:__wf_atom_3783a721(
								v79.clipIndex,
								12,
								baseAlpha * module2.Ternary(v79.visibleWhileAiming, 1, v23)
							)
							v81.BaseAlpha = baseAlpha
							v79.clientWasVisible = true
						end

						mMovie:__wf_atom_4656454c(v79.clipIndex, lastArrowScreenX, lastArrowScreenY)
					end
				else
					mMovie:__wf_atom_4656454c(v79.clipIndex, lastArrowScreenX, lastArrowScreenY)

					if v23 ~= v24 or v79.isNew or not v79.clientWasVisible or v81.BaseAlpha ~= baseAlpha then
						mMovie:__wf_atom_3783a721(
							v79.clipIndex,
							12,
							baseAlpha * module2.Ternary(v79.visibleWhileAiming, 1, v23)
						)
						v81.BaseAlpha = baseAlpha
						v79.clientWasVisible = true
					end
				end
			else
				v79.clientWasVisible = false
				mMovie:__wf_atom_3783a721(v79.clipIndex, 12, 0)
			end

			local v93 = not v13
				or not (v79.markerType >= 49)
				or not (v79.markerType <= 52)
				or gRegion:__wf_atom_eab484a7():__wf_atom_8537d7d4() == v79.team
			local v94

			if v79.distanceToEye >= 0 then
				v94 = v84 and markerWPtr:__wf_atom_db4c0732()
			else
				v94 = false
			end

			if v94 then
				local v95 = lastArrowScreenX - v25 / 2
				local v96 = lastArrowScreenY - v26 / 2
				local v97 = math.sqrt(v95 * v95 + v96 * v96)

				if v64 < v97 then
					v94 = false
				end
			end

			if
				v79.distanceToEye >= 0
				and (not v84 or markerWPtr:__wf_atom_96e13805() or v81.ShowingStatus ~= nil or v94)
			then
				if v79.distanceToEye ~= v81.DistanceToEye then
					if v61 and not v80 then
						mMovie:__wf_atom_7f57ab2f(clipName, "Marker.ScanRange", 13, true)
					end

					if v81.ShowingStatus == nil then
						mMovie:__wf_atom_36225cb3(v79.scanRangeClipIndex, 36, fn19(v79.distanceToEye))
					else
						mMovie:__wf_atom_48bd5a59(clipName, "EnemyStatus.Distance", 36, fn19(v79.distanceToEye))
						mMovie:__wf_atom_36225cb3(v79.scanRangeClipIndex, 36, "")
					end

					v81.DistanceToEye = v79.distanceToEye
				end
			elseif v81.DistanceToEye ~= -1 then
				mMovie:__wf_atom_36225cb3(v79.scanRangeClipIndex, 36, "")
				mMovie:__wf_atom_48bd5a59(clipName, "EnemyStatus.Distance", 36, "")
				v81.DistanceToEye = -1
			end

			local v95

			if v84 and markerWPtr:__wf_atom_2a5505da() then
				local __wf_atom_53df8751 = markerWPtr:__wf_atom_53df8751()
				local __wf_atom_b5ebedc3 = markerWPtr:__wf_atom_b5ebedc3()
				v95 = __wf_atom_53df8751:__wf_atom_48a8e71b(1 - __wf_atom_b5ebedc3:__wf_atom_b636405b(__wf_atom_b5ebedc3:__wf_atom_421b01aa(v79.distanceToEye)))
				mMovie:__wf_atom_e57658c2(clipName, 5, v95 * 100)
				mMovie:__wf_atom_e57658c2(clipName, 6, v95 * 100)
			else
				v95 = 0
			end

			if v79.isNew then
				v81.Shape = 1

				if v84 and markerWPtr:__wf_atom_de5b69d8() and not fn16() then
					mMovie:__wf_atom_7d7314f1(v79.labelVarName, "/Lotus/Language/Game/ScannerRequired", true)
				else
					mMovie:__wf_atom_7d7314f1(v79.labelVarName, v79.labelLocTag, true)
				end

				local markerExtractionEnemiesIcon2 = v79:__wf_atom_4cb5b869()

				if __wf_atom_7e8ad928(markerExtractionEnemiesIcon2) then
					local markerType = v79.markerType

					if markerType == 6 then
						markerExtractionEnemiesIcon2 = forcedMarkerIcons[1]
					elseif markerType == 7 or markerType == 12 then
						markerExtractionEnemiesIcon2 = forcedMarkerIcons[2]
					elseif markerType == 11 then
						markerExtractionEnemiesIcon2 = forcedMarkerIcons[3]
					elseif markerType == 4 then
						markerExtractionEnemiesIcon2 = forcedMarkerIcons[4]
					end
				elseif v75 and v91 and v84 then
					if __wf_atom_7e8ad928(_T.ObjProgressBar) or _T.ObjProgressBar.Data.Progress == 1 then
						markerWPtr:__wf_atom_479a7ccf(17)
					else
						markerExtractionEnemiesIcon2 = markerExtractionEnemiesIcon
						markerWPtr:__wf_atom_479a7ccf(2)
						markerWPtr:__wf_atom_1bc81a67()
					end
				end

				local forcedMarkerBackerIcon2

				if v88 then
					forcedMarkerBackerIcon2 = markerWPtr:__wf_atom_1afd3f10()
					markerExtractionEnemiesIcon2 = forcedMarkerBackerIcon2
				else
					forcedMarkerBackerIcon2 = v79:__wf_atom_336f28fc()
				end

				if __wf_atom_7e8ad928(forcedMarkerBackerIcon2) then
					forcedMarkerBackerIcon2 = forcedMarkerBackerIcon
				end

				mMovie:__wf_atom_c90af43a(clipName .. ".Marker.CustomIcon", markerExtractionEnemiesIcon2)
				mMovie:__wf_atom_c90af43a(clipName .. ".Marker.marker.CustomBackerIcon", forcedMarkerBackerIcon2)
				v81.TintIcon = module.IsGreyscale(markerExtractionEnemiesIcon2)
				mMovie:__wf_atom_3783a721(v79.arrowImageClipIndex, 15, 32)
				mMovie:__wf_atom_3783a721(v79.arrowImageClipIndex, 14, 26)
				mMovie:__wf_atom_c90af43a(clipName .. ".Marker.arrow.ArrowGraphic", directionalArrow)
				mMovie:__wf_atom_7f57ab2f(clipName, "Marker.CustomIcon", 13, true)
				mMovie:OverrideMaterial(clipName .. ".Marker.arrow.ArrowGraphic", nil)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrowOutline.ArrowGraphic", 15, 16)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrowOutline.ArrowGraphic", 14, 11.5)
				mMovie:__wf_atom_7f57ab2f(clipName, "Marker.MarkerOutline", 13, v88)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrowOutline", 11, _G.UIColor_White)

				if v79.markerType == 85 then
					mMovie:OverrideMaterial(clipName .. ".Marker.CustomIcon", conservationAnimalVisibleRangeMaterial)
					mMovie:__wf_atom_1ca72041(clipName .. ".Marker.CustomIcon", "VisibilitySize", 0, 0, 0, 0)
					mMovie:__wf_atom_1ca72041(clipName .. ".Marker.CustomIcon", "VisibilityFadeSize", 0, 0, 0, 0)
				end

				if v84 then
					mMovie:__wf_atom_2dedec1a(clipName, 13, v93)
					mMovie:__wf_atom_7f57ab2f(clipName, "Marker.marker", 13, markerWPtr:__wf_atom_d955899c() or v88)
					local __wf_atom_a76ab55d = markerWPtr:__wf_atom_a76ab55d()
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 5, __wf_atom_a76ab55d.x * 100)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 6, __wf_atom_a76ab55d.y * 100)

					if v88 then
						mMovie:__wf_atom_c90af43a(clipName .. ".Marker.arrow.ArrowGraphic", offScreenMarkerArrow)
						mMovie:__wf_atom_c90af43a(
							clipName .. ".Marker.arrowOutline.ArrowGraphic",
							offScreenMarkerArrowOutline
						)
						mMovie:__wf_atom_c90af43a(clipName .. ".Marker.MarkerOutline", markerWPtr:__wf_atom_25124dc7())
						mMovie:__wf_atom_7f57ab2f(clipName, "Marker.arrowOutline", 13, true)
					else
						mMovie:__wf_atom_c90af43a(clipName .. ".Marker.arrow.ArrowGraphic", nil)
						mMovie:__wf_atom_7f57ab2f(clipName, "Marker.arrowOutline", 13, false)
					end
				else
					mMovie:__wf_atom_c90af43a(clipName .. ".Marker.arrow.ArrowGraphic", nil)
					mMovie:__wf_atom_7f57ab2f(clipName, "Marker.arrowOutline", 13, false)
				end

				mMovie:__wf_atom_7f57ab2f(clipName, "Bounds", 13, v80)
				mMovie:__wf_atom_7f57ab2f(clipName, "NewBounds", 13, v80 or isProgressMarker)
				mMovie:__wf_atom_290807ee(clipName .. ".EnemyStatus")
				mMovie:__wf_atom_4c1c1986(clipName, "EnemyStatus", 12, 0)

				if v80 or isProgressMarker then
					if v84 and markerWPtr:IsA(v6) then
						v81.Shape = 2
					elseif v84 and markerWPtr:IsA(v7) then
						v81.Shape = 3
					else
						v81.Shape = 1
					end

					if _G[v8[v81.Shape]] == nil then
						mMovie:__wf_atom_7f57ab2f(clipName, "NewBounds", 13, false)
					else
						mMovie:OverrideMaterial(clipName .. ".NewBounds.Backer", _G[v8[v81.Shape]][1])
						mMovie:OverrideMaterial(clipName .. ".NewBounds.Fill", _G[v8[v81.Shape]][2])
						mMovie:OverrideMaterial(clipName .. ".NewBounds.Focused", _G[v8[v81.Shape]][3])
						mMovie:OverrideMaterial(clipName .. ".NewBounds.HitPulse", _G[v8[v81.Shape]][2])
						mMovie:OverrideMaterial(clipName .. ".NewBounds.HitPulse2", _G[v8[v81.Shape]][2])
						mMovie:OverrideMaterial(clipName .. ".Bounds.FillContainer.Fill", _G[v8[v81.Shape]][4])
					end

					local ternary = module2.Ternary(
						v79.arrowVisible or v79.showIconWithBounds or isProgressMarker,
						module2.Ternary(v88, fillMarkerAlpha, 100),
						0
					)
					local ternary2 = module2.Ternary(v79.arrowVisible and not isProgressMarker, 0, 100)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 12, ternary)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 12, ternary)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 12, ternary)
					mMovie:__wf_atom_4c1c1986(clipName, "Bounds", 12, ternary2)
					mMovie:__wf_atom_4c1c1986(clipName, "NewBounds", 12, ternary2)
					mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.Fill", 12, enemyMarkerFillAlpha)
					mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.HitPulse", 12, 0)
					mMovie:__wf_atom_1ca72041(clipName .. ".NewBounds.HitPulse", "SectionPointsBase", 1, 1, 1, 0)
					mMovie:__wf_atom_1ca72041(clipName .. ".NewBounds.HitPulse", "SectionEndGlowLength", 0, 0, 0, 0)
					mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.HitPulse2", 12, 0)
					mMovie:__wf_atom_1ca72041(clipName .. ".NewBounds.HitPulse2", "SectionPointsBase", 1, 1, 1, 0)
					mMovie:__wf_atom_1ca72041(clipName .. ".NewBounds.HitPulse2", "SectionEndGlowLength", 0, 0, 0, 0)

					if isProgressMarker then
						mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.Focused", 12, 0)
						mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.Fill", 12, 100)
					end

					if v84 and v80 then
						local __wf_atom_659b1b6f = markerWPtr:__wf_atom_659b1b6f()
						mMovie:__wf_atom_4c1c1986(clipName, "Bounds.FillContainer.Fill", 11, __wf_atom_659b1b6f)
						mMovie:__wf_atom_4c1c1986(clipName, "Bounds.FillContainer.Fill", 12, 75)
						mMovie:__wf_atom_1ca72041(
							clipName .. ".Bounds.FillContainer.Fill",
							"AlphaTestThreshold",
							1,
							0,
							0,
							0
						)

						if v82 then
							if v43 then
								local __wf_atom_818ea3a7 = parentAvatar:__wf_atom_818ea3a7()
								mMovie:__wf_atom_50d60589(clipName .. ".EnemyStatus.Name", 46, "bottom")
								mMovie:__wf_atom_50d60589(clipName .. ".EnemyStatus.Name", 36, __wf_atom_818ea3a7)
							end

							if parentAvatar:__wf_atom_1c5f2430() then
								local __wf_atom_68de036a = parentAvatar:__wf_atom_68de036a()
								mMovie:__wf_atom_e57658c2(clipName .. ".EnemyStatus.Name", 1, -34)
								mMovie:__wf_atom_50d60589(
									clipName .. ".EnemyStatus.LevelStatus.Level",
									36,
									__wf_atom_68de036a
								)
								mMovie:__wf_atom_2dedec1a(clipName .. ".EnemyStatus.LevelStatus", 13, true)
							end
						elseif v83 and v43 then
							mMovie:__wf_atom_2dedec1a(clipName .. ".EnemyStatus.LevelStatus", 13, false)
							mMovie:__wf_atom_e57658c2(clipName .. ".EnemyStatus.Name", 1, -18)
							local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
								parentDeco:__wf_atom_4f3855f9():c_str(),
								false
							)
							mMovie:__wf_atom_50d60589(clipName .. ".EnemyStatus.Name", 46, "bottom")
							mMovie:__wf_atom_50d60589(clipName .. ".EnemyStatus.Name", 36, __wf_atom_8e9ac384)
						end
					else
						mMovie:__wf_atom_1ca72041(
							clipName .. ".Bounds.FillContainer.Fill",
							"RectEdgeColor",
							_G.UIColorObject_White.r,
							_G.UIColorObject_White.g,
							_G.UIColorObject_White.b,
							0.75
						)
						mMovie:__wf_atom_1ca72041(
							clipName .. ".Bounds.FillContainerInner.Fill",
							"RectEdgeColor",
							_G.UIColorObject_White.r,
							_G.UIColorObject_White.g,
							_G.UIColorObject_White.b,
							0.75
						)
					end

					v81.FillPct = nil
					v81.PrevProgress = nil
					v81.LastHealthPct = nil
					v81.LastLockOnFrame = nil
					v81.PrevAwareness = nil
					v81.ShowingStatus = nil
					v86 = true
				else
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 12, 100)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 12, 100)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 12, 100)
				end

				v81.LastDamageFactor = 0
				v81.Color = nil
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 0, 0)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 1, 0)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 0, 0)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 1, 0)
				mMovie:__wf_atom_1ca72041(clipName .. ".Marker.CustomIcon", "AlphaTestThreshold", 1, 0, 0, 0)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 0, 0)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 1, 0)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.ScanRange", 0, -40)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.ScanRange", 1, module2.Ternary(isProgressMarker, 30, 17))
				local ternary = module2.Ternary(v79.arrowVisible, module2.Ternary(v88, fillMarkerAlpha, 100), 0)
				mMovie:__wf_atom_3783a721(v79.arrowClipIndex, 12, ternary)
				mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrowOutline", 12, ternary)
				v79.isNew = false
			end

			if v84 then
				local color

				if v88 then
					local __wf_atom_845dcca5 = markerWPtr:__wf_atom_845dcca5()

					if __wf_atom_845dcca5 == 0 then
						color = markerWPtr:__wf_atom_10051386(0)
					elseif __wf_atom_845dcca5 >= 1 then
						color = markerWPtr:__wf_atom_10051386(2)
					else
						color = markerWPtr:__wf_atom_10051386(1)
					end
				else
					color = markerWPtr:__wf_atom_8bb9cbd2()
				end

				if color ~= v81.Color then
					if not v88 then
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 11, color)

						for i = 1, v79.stackCount do
							mMovie:__wf_atom_e57658c2(clipName .. ".Marker.StackBacker" .. i, 11, color)
						end
					end

					if v81.TintIcon then
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 11, color)
					else
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 11, _G.UIColor_White)
					end

					mMovie:__wf_atom_4c1c1986(clipName, "Marker.ScanRange", 11, color)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.StackCount", 11, color)
					v81.Color = color
					v86 = true
				end

				local __wf_atom_bcaaaa6a = markerWPtr:__wf_atom_bcaaaa6a()

				if __wf_atom_bcaaaa6a ~= v81.IconScale then
					v81.IconScale = __wf_atom_bcaaaa6a
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 5, v81.IconScale.x * 100)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.CustomIcon", 6, v81.IconScale.y * 100)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 5, v81.IconScale.x * 50)
					mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 6, v81.IconScale.y * 50)
				end

				if isProgressMarker then
					local __wf_atom_1c43a79b = markerWPtr:__wf_atom_1c43a79b()

					if __wf_atom_1c43a79b ~= v81.PrevProgress then
						v81.PrevProgress = __wf_atom_1c43a79b
						mMovie:__wf_atom_1ca72041(
							clipName .. ".NewBounds.Fill",
							"SectionPointsBase",
							__wf_atom_1c43a79b,
							1,
							1,
							0
						)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 11, color)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 11, color)
						mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.Fill", 11, color)
					end
				elseif v82 then
					local maxHealth = parentAvatar:GetMaxHealth()
					local __wf_atom_2bf72530 = parentAvatar:__wf_atom_7470861b():__wf_atom_2bf72530()
					local lastRatio = maxHealth / (__wf_atom_2bf72530 + maxHealth)
					local lastHealthPct = parentAvatar:__wf_atom_c6f1f83d() / maxHealth
					local __wf_atom_e6c740b2 = parentAvatar:__wf_atom_e6c740b2()
					local lastShieldPct = not (__wf_atom_2bf72530 > 0) and 0
						or parentAvatar:__wf_atom_7470861b():__wf_atom_7faf4619() / __wf_atom_2bf72530

					if
						lastHealthPct ~= v81.LastHealthPct
						or lastShieldPct ~= v81.LastShieldPct
						or lastRatio ~= v81.LastRatio
					then
						if
							v81.LastShieldPct == nil
							or lastShieldPct > 1 and v81.LastShieldPct <= 1
							or lastShieldPct <= 1 and v81.LastShieldPct > 1
						then
							v87 = module2.Ternary(lastShieldPct > 1, v66, v65)
						end

						local v100 = clipName .. ".NewBounds.HitPulse"

						if v81.AlternateHitPulse then
							v100 ..= "2"
						end

						if
							v81.LastHealthPct ~= nil
							and v81.LastShieldPct ~= nil
							and v81.LastDamageFactor <= __wf_atom_e6c740b2
							and __wf_atom_e6c740b2 > 0
						then
							v81.AlternateHitPulse = not v81.AlternateHitPulse
							local v101 = v81.LastHealthPct - lastHealthPct
							local v102 = v81.LastShieldPct - lastShieldPct

							if v101 == 0 then
								local v103 = math.max(v102, 0.015)
								mMovie:__wf_atom_1ca72041(
									v100,
									"SectionPointsBase",
									0,
									0,
									v103 * (1 - lastRatio),
									lastRatio + lastShieldPct * (1 - lastRatio)
								)
							else
								local v103 = math.max(v101, 0.015)
								local v104 = math.max(v102, 0.015)
								local v105 = lastRatio - lastHealthPct * lastRatio
								mMovie:__wf_atom_1ca72041(
									v100,
									"SectionPointsBase",
									v103 * lastRatio,
									v105,
									v105 + v104 * (1 - lastRatio),
									lastHealthPct * lastRatio
								)
							end

							mMovie:__wf_atom_290807ee(v100)
							mMovie:__wf_atom_e57658c2(v100, 12, 75)
							mMovie:__wf_atom_e57658c2(v100, 5, 753)
							mMovie:__wf_atom_e57658c2(v100, 6, 753)
							local v103 = 0.485
							local v104 = 0.275
							local v105 = 0

							if v81.Shape == 2 then
								v104 = 0.325
								v105 = -0.75
							elseif v81.Shape == 3 then
								v103 = 0.42
								v104 = 0.18
								v105 = 1
							end

							mMovie:__wf_atom_1ca72041(v100, "CircleSettings", v103, v104, 0, v105)
							local v106 = 0

							local function fn21(p2)
								mMovie:__wf_atom_1ca72041(
									v100,
									"CircleSettings",
									v103,
									v104 + (v106 + p2) * 2.5,
									0,
									v105
								)
							end

							__wf_atom_ec43d06e(
								mMovie,
								v100,
								0,
								{ fn21, 5, 6 },
								{ 0.5, 1053, 1053 },
								0.125,
								0,
								function()
									v106 = 0.5
									__wf_atom_ec43d06e(
										mMovie,
										v100,
										2,
										{ fn21, 5, 6, 12 },
										{ 0.5, 1253, 1253, 0 },
										0.125,
										0
									)
								end
							)
						end

						v81.LastHealthPct = lastHealthPct
						v81.LastShieldPct = lastShieldPct
						v81.LastRatio = lastRatio
						mMovie:__wf_atom_1ca72041(
							clipName .. ".NewBounds.Fill",
							"SectionPointsBase",
							lastHealthPct * lastRatio,
							lastRatio,
							lastRatio + math.min(1, lastShieldPct) * (1 - lastRatio),
							0
						)
						v86 = true
					end

					if __wf_atom_e6c740b2 ~= v81.LastDamageFactor then
						v81.LastDamageFactor = __wf_atom_e6c740b2
					end
				elseif v80 and v83 then
					local __wf_atom_95174740 = parentDeco:__wf_atom_95174740()
					local lastHealthPct = parentDeco:__wf_atom_c6f1f83d() / __wf_atom_95174740

					if lastHealthPct ~= v81.LastHealthPct then
						v81.LastHealthPct = lastHealthPct
						mMovie:__wf_atom_1ca72041(
							clipName .. ".NewBounds.Fill",
							"SectionPointsBase",
							lastHealthPct,
							1,
							1,
							0
						)
						v86 = true
					end
				end

				if v80 then
					if __wf_atom_7e8ad928(v48) then
						if v81.ShowingStatus then
							v81.ShowingStatus = false
							__wf_atom_ec43d06e(mMovie, clipName .. ".EnemyStatus", 0, { 12 }, { 0 }, 1, 0.3, function()
								v81.ShowingStatus = nil
							end)
						end
					else
						if
							v82
							and v47[v48].mAvatar == parentAvatar
							and not (v81.ShowingStatus or parentAvatar:__wf_atom_6165bb29())
						then
							v81.ShowingStatus = true
							mMovie:__wf_atom_290807ee(clipName .. ".EnemyStatus")
							mMovie:__wf_atom_4c1c1986(clipName, "EnemyStatus", 12, 100)
						elseif
							v83
							and (v47[v48].mDeco == parentDeco or parentDeco:__wf_atom_b2f8ef81())
							and not v81.ShowingStatus
							and parentDeco:__wf_atom_b2f4c3d9()
						then
							v81.ShowingStatus = true
							mMovie:__wf_atom_290807ee(clipName .. ".EnemyStatus")
							mMovie:__wf_atom_4c1c1986(clipName, "EnemyStatus", 12, 100)
						elseif
							v81.ShowingStatus
							and v47[v48].mAvatar ~= parentAvatar
							and v47[v48].mDeco ~= parentDeco
						then
							v81.ShowingStatus = false
							__wf_atom_ec43d06e(mMovie, clipName .. ".EnemyStatus", 0, { 12 }, { 0 }, 1, 0.3, function()
								v81.ShowingStatus = nil
							end)
						end

						if v82 and v43 then
							local __wf_atom_818ea3a7 = parentAvatar:__wf_atom_818ea3a7()
							local __wf_atom_7470861b = parentAvatar:__wf_atom_7470861b()

							for i = 1, #v9 do
								local __wf_atom_846af4f8 = __wf_atom_7470861b:__wf_atom_846af4f8(i - 1)

								if not (__wf_atom_846af4f8 > 0 and v9[i] ~= nil) then
									continue
								end

								local ternary = module2.Ternary(__wf_atom_846af4f8 > 1, __wf_atom_846af4f8, "")

								if v9[i].Icon ~= nil then
									__wf_atom_818ea3a7 ..= " " .. v9[i].Icon .. ternary
								end
							end

							mMovie:__wf_atom_50d60589(clipName .. ".EnemyStatus.Name", 36, __wf_atom_818ea3a7)
						end
					end
				end

				if v79.markerType == 85 then
					local v97 = markerWPtr:__wf_atom_845dcca5() * 0.8
					local v98 = mMovie:__wf_atom_5e6e15c8(clipName .. ".Marker.CustomIcon", 15) or 64
					local visibilitySize = module2.GetVisibilitySize(mMovie, v98 * v97 * v95)
					mMovie:__wf_atom_1ca72041(
						clipName .. ".Marker.CustomIcon",
						"VisibilitySize",
						visibilitySize,
						0,
						0,
						0
					)
					mMovie:__wf_atom_1ca72041(clipName .. ".Marker.CustomIcon", "VisibilityFadeSize", 0, 0, 0, 0)
					mMovie:__wf_atom_1ca72041(
						clipName .. ".Marker.CustomIcon",
						"VisibilityCenter",
						(lastArrowScreenY + 16 * v95) / v26,
						0,
						0,
						0
					)
				end
			end

			if v80 and (not v79.arrowVisible or v88) then
				local flag2

				if v81.FillPct == nil then
					v81.FillPct = __wf_atom_10cd16b2(0, 0.1)
					flag2 = true
				else
					flag2 = false
				end

				if v84 then
					local v96 = 0
					local prevAwareness = v81.PrevAwareness

					if v82 then
						prevAwareness = parentAvatar:__wf_atom_1793a706()
					end

					local prevAwareness2 = prevAwareness == nil and 1 or prevAwareness
					local v98, v99

					if prevAwareness2 == 2 then
						v98 = markerWPtr:__wf_atom_845dcca5() * 1.1
						v99 = v86 or v98 ~= v81.PrevFillPct
					else
						v98 = prevAwareness2 == 3 and 1.1 or v96
						v99 = v86 or prevAwareness2 ~= v81.PrevAwareness
						flag2 = true
					end

					if flag2 then
						v81.FillPct:__wf_atom_4453e49c(v98)
					else
						v81.FillPct:__wf_atom_09294a87(v98)
					end

					v81.FillPct:Update(p)

					if v99 then
						v81.PrevFillPct = v81.FillPct:__wf_atom_9e368823()
						v81.PrevAwareness = prevAwareness2

						if v88 and v81.IconScale ~= nil then
							mMovie:__wf_atom_1ca72041(
								clipName .. ".Marker.CustomIcon",
								"AlphaTestThreshold",
								v81.PrevFillPct,
								0,
								0,
								0
							)
						end

						local decoHealth, v100, v101, v102

						if v83 then
							decoHealth = v46.DecoHealth
							v100 = decoHealth
							v101 = v100
							v102 = v101
							v100 = v102
							v101 = v100
						elseif prevAwareness2 == 3 then
							decoHealth = markerWPtr:__wf_atom_46566e99()
							v102 = 2427145
							v101 = 2427145

							if v82 then
								local __wf_atom_2bf72530 = parentAvatar:__wf_atom_7470861b():__wf_atom_2bf72530()
								local v103 = not (__wf_atom_2bf72530 > 0) and 0
									or parentAvatar:__wf_atom_7470861b():__wf_atom_7faf4619() / __wf_atom_2bf72530
								v87 = module2.Ternary(v103 > 1, v66, v65)
							end

							v100 = decoHealth
						else
							if prevAwareness2 == 2 then
								decoHealth = markerWPtr:__wf_atom_659b1b6f()
								v100 = markerWPtr:__wf_atom_b1d3fb87()
								v87 = module2.ConvertColorNumberToProceduralRGB(module2.InterpolateColors(v100, _G.UIColor_White, 0.15))
								v102 = 7343875
							else
								decoHealth = markerWPtr:__wf_atom_0c035997()
								v87 = module2.ConvertColorNumberToProceduralRGB(module2.InterpolateColors(
									decoHealth,
									_G.UIColor_White,
									0.15
								))
								v100 = decoHealth
								v102 = 0
							end

							v101 = 16777215
						end

						mMovie:__wf_atom_4c1c1986(clipName, "Marker.MarkerOutline", 11, v102)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.arrowOutline", 11, v102)
						mMovie:__wf_atom_4c1c1986(clipName, "Marker.marker", 11, v101)
						mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.Focused", 11, decoHealth)
						mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.Fill", 11, v100)
						mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.HitPulse", 11, v100)
						mMovie:__wf_atom_4c1c1986(clipName, "NewBounds.HitPulse2", 11, v100)

						if v87 ~= nil then
							mMovie:__wf_atom_1ca72041(
								clipName .. ".NewBounds.Fill",
								"SectionTwoColor",
								v87.r,
								v87.g,
								v87.b,
								1
							)
							mMovie:__wf_atom_1ca72041(
								clipName .. ".NewBounds.HitPulse",
								"SectionTwoColor",
								v87.r,
								v87.g,
								v87.b,
								1
							)
							mMovie:__wf_atom_1ca72041(
								clipName .. ".NewBounds.HitPulse2",
								"SectionTwoColor",
								v87.r,
								v87.g,
								v87.b,
								1
							)
						end
					end
				end

				if not v79.arrowVisible then
					local __wf_atom_9e368823 = v81.FillPct:__wf_atom_9e368823()
					v18:__wf_atom_fc10db03(
						mMovie,
						clipName,
						v79,
						lastArrowScreenX,
						lastArrowScreenY,
						__wf_atom_421b01aa(__wf_atom_9e368823, 0, 1),
						__wf_atom_421b01aa(10.000000000000009 * (__wf_atom_9e368823 - 1), 0, 1),
						0,
						nil,
						v81.Shape == 2,
						1
					)
				end
			end

			if
				v84
				and v79.stackCount > 0
				and markerWPtr:__wf_atom_cd5897b0()
				and markerWPtr:__wf_atom_03cad03d()
				and (not v75 or not v91 or __wf_atom_7e8ad928(_T.ObjProgressBar) or _T.ObjProgressBar.Data.Progress == 1)
			then
				if __wf_atom_7e8ad928(v57[clipName]) then
					if v57[clipName] ~= nil then
						v57[clipName] = nil
					end
				else
					local screenSquare = v79.screenSquare
					local v96, v97

					if
						v79.screenSpacePos.z >= 0
						and (v80 or v79.showBoundingArrows)
						and not __wf_atom_7e8ad928(markerWPtr:__wf_atom_3d96ddcd())
					then
						local v98 = __wf_atom_421b01aa(
							(screenSquare:__wf_atom_c9d0fea6() - lastArrowScreenX) * 1.4,
							-64,
							-10
						)
						local v99 = __wf_atom_421b01aa(
							(screenSquare:__wf_atom_ccf700a6() - lastArrowScreenY) * 1.4,
							-64,
							-10
						)
						local v100 = __wf_atom_421b01aa(
							(screenSquare:__wf_atom_152cb4a3() - lastArrowScreenX) * 1.4,
							10,
							64
						)
						local v101 = __wf_atom_421b01aa(
							(screenSquare:__wf_atom_1852b6a3() - lastArrowScreenY) * 1.4,
							10,
							64
						)
						v96 = v100 - (v100 + math.abs(v98)) / 2
						v97 = v101 - (v101 + math.abs(v99)) / 2
					else
						v96 = 0
						v97 = 0
					end

					local gameCamera = gRegion:GetGameCamera()
					local screenParticlesCoord, v98 = module2.GetScreenParticlesCoord(
						mMovie,
						lastArrowScreenX + v96,
						lastArrowScreenY + v92 + v97,
						gameCamera
					)
					v57[clipName]:__wf_atom_e310f01f(
						Vector(screenParticlesCoord * v29, v98 * v29, 1),
						__wf_atom_80368bb1
					)
				end
			end
		else
			if v79.clientWasVisible then
				v79.clientWasVisible = false
				mMovie:__wf_atom_3783a721(v79.clipIndex, 12, 0)
			end

			if v79.isNew then
				v79.isNew = false
			end
		end
	end
end

local function fn21(p)
	if __wf_atom_7e8ad928(v16) then
		return
	end

	v24 = v23

	if v16:__wf_atom_7b82e9e1(0) and not v17:__wf_atom_84479917() then
		v23 -= p
	else
		v23 += p
	end

	v23 = __wf_atom_421b01aa(v23, 0, 1)
	v18:__wf_atom_0eb5be1a(mMovie)

	if not v18:__wf_atom_0019a982(v15, v19, p) then
		return
	end

	fn20(p)
end

function OnPlayersChanged()
	v38 = true
end

local function fn22()
	v38 = false

	if
		__wf_atom_7e8ad928(gGameRules2)
		or not gGameRules2:IsA(__wf_atom_589d05aa)
		or gGameRules2:__wf_atom_8cc6640f()
	then
		return
	end

	if __wf_atom_72884638("HUD.UseAlternateHud") or __wf_atom_72884638("HUD.HideStatusBars") then
		return
	end

	if #v40 == 0 then
		fn12()
	end

	v35 = gRegion:__wf_atom_3c8e1a7a()
	v36 = {}
	v37 = {}

	for _, v73 in ipairs(nonPlayerSquadTypes) do
		local all = gRegion:FindAll(v73)

		for _, v74 in ipairs(all) do
			table.insert(v37, v74)
		end
	end

	local v73 = 1

	for i = 1, 8 do
		local v74 = { nil, nil }

		if __wf_atom_7e8ad928(v35[i]) or v35[i]:__wf_atom_fabb6718() then
			if not __wf_atom_7e8ad928(v37[v73]) then
				v74[1] = v37[v73]:__wf_atom_818ea3a7()
				v73 += 1
			end

			v36[i] = nil
		else
			v36[i] = v35[i]:__wf_atom_50a7d83e()

			if not v35[i]:IsLocal() then
				local v75 = v35[i]
				v74[1] = __wf_atom_7e8ad928(v75) and "" or v75:__wf_atom_6be84646()
			end

			if not (__wf_atom_7e8ad928(v36[i]) or __wf_atom_7e8ad928(v36[i]:__wf_atom_d2b2176d())) then
				local __wf_atom_1915cc84 = v36[i]:__wf_atom_d2b2176d():__wf_atom_1915cc84()

				if not __wf_atom_7e8ad928(__wf_atom_1915cc84) then
					if v35[i]:__wf_atom_eee4f1f4() then
						v74[2] = v35[i]:__wf_atom_a4299765().mKubrowPetDetails.mName
					elseif v35[i]:__wf_atom_476a54b8() then
						v74[2] = __wf_atom_1915cc84:__wf_atom_818ea3a7()
					end
				end
			end
		end

		for j = 1, 2 do
			local ternary = module2.Ternary(j == 1, v40[i].Player, v40[i].Kubrow)
			local clipName = ternary.clipName

			if not (v74[j] == nil and clipName ~= "Teammate1" and mMovie:__wf_atom_253d7085(clipName)) then
				continue
			end

			__wf_atom_86cbd68d(mMovie, ternary.clipName .. ".removeMovieClip")
			ternary.IsVisible = nil
			ternary.IsLiteMode = nil
			ternary.LastDisplayName = nil
			ternary.HasClip = false
		end
	end
end

local v73 = Vector()

local function fn23(eyePosition, position, p) -- 1 equivalent call inferred from this helper
	local v74 = (position - eyePosition) * p
	return v74.x * v74.x + v74.y * v74.y + v74.z * v74.z
end

local function fn24(instance)
	if __wf_atom_7e8ad928(v16) then
		return
	end

	local count = #v35

	for i = 1, count do
		if v39[i] == nil then
			v39[i] = { name = "", avatar = nil, petName = "", petAvatar = nil }
		end

		if not (i <= 8) or __wf_atom_7e8ad928(v35[i]) then
			continue
		end

		local v74 = v35[i]
		local avatar = nil

		if v74:IsLocal() or v74:__wf_atom_fabb6718() then
			if v39[i].avatar ~= nil then
				v39[i].name = ""
				v39[i].avatar = nil
			end
		else
			avatar = module3.GetPlayerAvatar(v74, v36[i])

			if __wf_atom_7e8ad928(v16) or not __wf_atom_7e8ad928(avatar) and SF.__wf_atom_d6db8587(v16, avatar) then
				v36[i] = avatar

				if not __wf_atom_7e8ad928(avatar) then
					v39[i].name = __wf_atom_7e8ad928(v74) and "" or v74:__wf_atom_6be84646()
					v39[i].avatar = avatar
				end
			else
				v39[i].name = ""
				v39[i].avatar = nil
				avatar = nil
			end
		end

		if v74:__wf_atom_eee4f1f4() or v74:__wf_atom_476a54b8() then
			if __wf_atom_7e8ad928(avatar) then
				avatar = module3.GetPlayerAvatar(v74, v36[i])
				v36[i] = avatar
			end

			if __wf_atom_7e8ad928(avatar) then
				if v39[i].petAvatar ~= nil then
					v39[i].petName = nil
					v39[i].petAvatar = nil
				end
			else
				local __wf_atom_a4299765 = v74:__wf_atom_a4299765()

				if avatar:IsA(__wf_atom_c0fefb76) then
					avatar = v74:__wf_atom_eff0517e()
				end

				if not __wf_atom_7e8ad928(avatar) then
					local __wf_atom_d2b2176d = avatar:__wf_atom_d2b2176d()
					local __wf_atom_1915cc84 = __wf_atom_d2b2176d:__wf_atom_1915cc84()

					if not __wf_atom_7e8ad928(__wf_atom_1915cc84) then
						if __wf_atom_1915cc84:IsVisible() and not __wf_atom_d2b2176d:__wf_atom_2a5fa4a9() then
							if v74:__wf_atom_eee4f1f4() then
								if __wf_atom_a4299765.mKubrowPetDetails.mName == "" then
									local __wf_atom_d2b2176d2 = __wf_atom_1915cc84:__wf_atom_d2b2176d()

									if not __wf_atom_7e8ad928(__wf_atom_d2b2176d2) then
										local __wf_atom_e55d02aa = __wf_atom_d2b2176d2:__wf_atom_e55d02aa()

										if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
											v39[i].petName = mMovie:__wf_atom_8e9ac384(
												__wf_atom_e55d02aa:__wf_atom_014a76a2():c_str(),
												false
											)
										end
									end
								else
									v39[i].petName = __wf_atom_a4299765.mKubrowPetDetails.mName
								end
							elseif v74:__wf_atom_476a54b8() then
								v39[i].petName = __wf_atom_1915cc84:__wf_atom_818ea3a7()
							end

							v39[i].petAvatar = __wf_atom_1915cc84
						else
							v39[i].petName = nil
							v39[i].petAvatar = nil
						end
					end
				end
			end
		elseif v39[i].petAvatar ~= nil then
			v39[i].petName = nil
			v39[i].petAvatar = nil
		end
	end

	for i = 1, #v37 do
		local v74 = i + count

		if v39[v74] == nil then
			v39[v74] = { name = "", avatar = nil, petName = "", petAvatar = nil }
		end

		if not (v74 <= 8) or __wf_atom_7e8ad928(v37[i]) then
			continue
		end

		local avatar = v37[i]

		if __wf_atom_7e8ad928(v16) or SF.__wf_atom_d6db8587(v16, avatar) then
			if avatar:__wf_atom_bedb4e3f() then
				v39[v74].name = avatar:__wf_atom_818ea3a7()
			else
				v39[v74].name = ""
			end

			v39[v74].avatar = avatar
		else
			v39[v74].name = ""
			v39[v74].avatar = nil
		end

		v39[v74].petName = nil
		v39[v74].petAvatar = nil
	end

	for i = 1, count + #v37 do
		for j = 1, 2 do
			local v74 = v39[i]
			local ternary = module2.Ternary(j == 1, v74.avatar, v74.petAvatar)
			local ternary2 = module2.Ternary(j == 1, v74.name, v74.petName)
			local v75

			if v40[i] ~= nil then
				v75 = module2.Ternary(j == 1, v40[i].Player, v40[i].Kubrow)
			end

			if v75 == nil then
				continue
			end

			if __wf_atom_7e8ad928(ternary) then
				local clipName = v75.clipName

				if v75.IsVisible ~= false then
					mMovie:__wf_atom_2dedec1a(clipName, 13, false)
					v75.IsVisible = false
				end
			else
				local __wf_atom_7470861b = ternary:__wf_atom_7470861b()
				local __wf_atom_bedb4e3f = __wf_atom_7470861b:__wf_atom_bedb4e3f()
				local __wf_atom_c6f1f83d = ternary:__wf_atom_c6f1f83d()
				local v76 = v13 and ternary:__wf_atom_129d1aba(instance)
				local v77 = __wf_atom_bedb4e3f and ternary:__wf_atom_73c496b3()
				local __wf_atom_3812fa54 = ternary:__wf_atom_3812fa54()
				local v78 = v42 and v12 ~= module3.UI_MODE_IN_SPACE_HUB

				if v13 then
					v78 = v78 and v76
				end

				if v45 ~= nil and v78 then
					v78 = fn23(instance:EyePosition(), ternary:GetPosition(), v41) < v45 -- inferred equivalent call
				end

				local clipName = v75.clipName

				if not v75.HasClip then
					if not mMovie:__wf_atom_253d7085(clipName) then
						__wf_atom_86cbd68d(mMovie, "Teammate1.duplicateMovieClip", clipName, 3000 + (i * 2 - (2 - j)))
						mMovie:__wf_atom_4c1c1986(clipName, "Progress", 11, v46.Health)
						mMovie:__wf_atom_4c1c1986(clipName, "Name", 44, v46.Text)
						mMovie:__wf_atom_4c1c1986(clipName, "Range", 44, v46.Text)
						mMovie:__wf_atom_2dedec1a(clipName, 13, false)
						v75.IsVisible = false
					end

					v75.HasClip = true
				end

				if (v77 or v78) and not __wf_atom_3812fa54 then
					local v79 = nil
					local distanceToEye = 0

					if v77 and (not v13 or v76) then
						for _, v81 in pairs(v21) do
							if v81.garbage or v81.markerType ~= 4 then
								continue
							end

							local __wf_atom_cd79d6f3 = v81:__wf_atom_cd79d6f3()

							if __wf_atom_7e8ad928(__wf_atom_cd79d6f3) then
								continue
							end

							local __wf_atom_2e2a3cea = __wf_atom_cd79d6f3:__wf_atom_2e2a3cea()

							if __wf_atom_7e8ad928(__wf_atom_2e2a3cea) or __wf_atom_2e2a3cea ~= ternary then
								continue
							end

							v79 = mMovie:__wf_atom_74b9a49b(Vector(v81.pos.x, v81.pos.y + 0.2, v81.pos.z))
							distanceToEye = v81.distanceToEye
							break
						end
					end

					if v79 == nil then
						__wf_atom_7470861b:__wf_atom_5f3ad3f2(v73, 1)
						v73.y += 0.35

						if ternary:IsA(__wf_atom_68ce7caa) then
							v73.y += 0.25
						end

						v79 = mMovie:__wf_atom_74b9a49b(v73)
					end

					local isVisible

					if v79.z > 0 and v79.z < 1 then
						isVisible = __wf_atom_c6f1f83d > 0
					else
						isVisible = false
					end

					if v75.IsVisible ~= isVisible then
						mMovie:__wf_atom_2dedec1a(clipName, 13, isVisible)
						v75.IsVisible = isVisible
					end

					if v75.IsVisible then
						mMovie:__wf_atom_e57658c2(clipName, 0, module2.Round(v79.x))
						mMovie:__wf_atom_e57658c2(clipName, 1, module2.Round(v79.y) - 32)

						if v78 then
							local ternary3 = module2.Ternary(ternary2 == module3.HIDDEN_PLAYER_NAME, "", ternary2)

							if v75.LastDisplayName ~= ternary3 then
								mMovie:__wf_atom_50d60589(clipName .. ".Name", 36, ternary3)
								v75.LastDisplayName = ternary3
							end
						end

						if v77 and (not v13 or v76) then
							local __wf_atom_6c094e8e = ternary:__wf_atom_6c094e8e()
							v75.IsLiteMode = false

							if
								not __wf_atom_7e8ad928(instance)
								and instance:IsA(__wf_atom_7e6ed5fa)
								and instance:__wf_atom_bddd20a6() == ternary
							then
								v75.mTrackRevive = true
							end

							if v75.mTrackRevive and __wf_atom_6c094e8e > 0 then
								__wf_atom_86cbd68d(
									mMovie,
									clipName .. ".Progress.gotoAndStop",
									module2.Round(__wf_atom_6c094e8e * 100) + 1
								)
								mMovie:__wf_atom_7f57ab2f(clipName, "Progress", 13, true)
								mMovie:__wf_atom_7f57ab2f(clipName, "Range", 13, false)
							else
								mMovie:__wf_atom_7f57ab2f(clipName, "Progress", 13, false)
								mMovie:__wf_atom_48bd5a59(clipName, "Range", 36, fn19(distanceToEye))
								mMovie:__wf_atom_7f57ab2f(clipName, "Range", 13, true)
							end

							if v75.HealthAndShieldAvatar ~= ternary then
								v75.HealthAndShieldAvatar = ternary

								if __wf_atom_7e8ad928(v75.HealthAndShield) then
									local v81 = gRegion:IsMaster() and 3 or 4
									v75.HealthAndShield = gRegion:CreateObject(v, nil, v81)
								end

								v75.HealthAndShield:Setup(
									mMovie,
									ternary,
									100,
									clipName .. ".HealthBar",
									clipName .. ".HealthLabel"
								)
								v75.HealthAndShield:Initialize()
							end

							v75.HealthAndShield:Update(__wf_atom_084b3e93())
							mMovie:__wf_atom_7f57ab2f(clipName, "HealthLabel", 13, true)
						elseif not v75.IsLiteMode and (v76 or v78) then
							mMovie:__wf_atom_7f57ab2f(clipName, "Progress", 13, false)
							mMovie:__wf_atom_7f57ab2f(clipName, "Range", 13, false)
							mMovie:__wf_atom_7f57ab2f(clipName, "HealthLabel", 13, false)
							mMovie:__wf_atom_7f57ab2f(clipName, "HealthBar", 13, false)
							v75.IsLiteMode = true
						end
					end
				else
					mMovie:__wf_atom_2dedec1a(clipName, 13, false)
					v75.IsVisible = false
				end

				if not v13 and __wf_atom_bedb4e3f ~= v75.isPredeath and ternary2 ~= module3.HIDDEN_PLAYER_NAME then
					v75.isPredeath = __wf_atom_bedb4e3f
					v75.mTrackRevive = false
					local player

					if ternary2 == "" and not __wf_atom_7e8ad928(ternary) then
						player = ternary:__wf_atom_818ea3a7()
					else
						player = ternary2
					end

					local v80 = ""

					if __wf_atom_bedb4e3f then
						v80 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/HUD_IsDown", false, {
							PLAYER = player
						})
					elseif __wf_atom_c6f1f83d > 0 then
						v80 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/HUD_BeenRevived", false, {
							PLAYER = player
						})
					elseif __wf_atom_c6f1f83d <= 0 then
						v80 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/HUD_HasDied", false, {
							PLAYER = player
						})
					end

					if v80 ~= "" and not __wf_atom_7e8ad928(v20) then
						v20:Execute("ShowGameplayMessage", v80)
					end

					local isVisible = __wf_atom_bedb4e3f and not __wf_atom_3812fa54
					mMovie:__wf_atom_50d60589(clipName .. ".Name", 36, ternary2)

					if v75.IsVisible ~= isVisible then
						mMovie:__wf_atom_2dedec1a(clipName, 13, isVisible)
						v75.IsVisible = isVisible
					end
				end
			end
		end
	end
end

local function fn25(instance, state)
	local mName = state.mName
	local mLevel = state.mLevel
	state.mName = ""
	state.mLevel = ""
	state.mIsAIEnemyAvatar = false

	if __wf_atom_7e8ad928(state.mAvatar) then
		if not __wf_atom_7e8ad928(state.mDeco) then
			if state.mDeco:IsA(__wf_atom_3feeb44a) then
				local __wf_atom_37a29496 = state.mDeco:__wf_atom_37a29496()

				if not __wf_atom_7e8ad928(__wf_atom_37a29496) then
					state.mName = mMovie:__wf_atom_8e9ac384(__wf_atom_37a29496:__wf_atom_014a76a2():c_str(), false)
				end
			elseif state.mDeco:IsA(__wf_atom_8d0b7f88) and state.mDeco:__wf_atom_de5b69d8() and not fn16() then
				state.mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/ScannerRequired", true)
			else
				state.mCachedLocTag = state.mDeco:__wf_atom_4f3855f9()
				state.mName = mMovie:__wf_atom_8e9ac384(state.mCachedLocTag:c_str(), false)
			end
		end
	else
		local mAvatar = state.mAvatar
		local __wf_atom_a96eb2aa = mAvatar:__wf_atom_a96eb2aa()

		if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			if
				v42
				and mAvatar:__wf_atom_e93896ba() == instance:__wf_atom_e93896ba()
				and (not __wf_atom_7e8ad928(mAvatar:__wf_atom_a96eb2aa()) or mAvatar:IsA(__wf_atom_f1872364) or mAvatar:IsA(__wf_atom_afe1c44c))
			then
				state.mName = ""
			elseif mAvatar:IsA(nonPlayerSquadTypes[1]) then
				state.mName = mAvatar:__wf_atom_818ea3a7()
			else
				state.mIsAIEnemyAvatar = true

				if v43 then
					state.mName = mAvatar:__wf_atom_818ea3a7()
				end

				if mAvatar:__wf_atom_689edf30() and not _T.HideEnemyLevelsInHUD then
					state.mLevel = mAvatar:__wf_atom_68de036a()
				end
			end
		elseif instance:__wf_atom_129d1aba(mAvatar) and v42 then
			state.mName = ""
		elseif mAvatar:__wf_atom_e93896ba() == instance:__wf_atom_e93896ba() or v43 then
			state.mName = __wf_atom_7e8ad928(__wf_atom_a96eb2aa) and "" or __wf_atom_a96eb2aa:__wf_atom_6be84646()
		else
			state.mName = ""
		end
	end

	if state.mName == module3.HIDDEN_PLAYER_NAME then
		mMovie:__wf_atom_50d60589(
			state.mClipName .. ".Name",
			36,
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Stalker", false)
		)
		mMovie:__wf_atom_50d60589(state.mClipName .. ".Level", 36, "30")
		mMovie:__wf_atom_7f57ab2f(state.mClipName, "UnderLotus", 13, true)
	else
		if state.mName ~= mName then
			mMovie:__wf_atom_50d60589(state.mClipName .. ".Name", 36, state.mName)
		end

		if state.mLevel ~= mLevel then
			mMovie:__wf_atom_50d60589(state.mClipName .. ".Level", 36, state.mLevel)
			mMovie:__wf_atom_7f57ab2f(state.mClipName, "UnderLotus", 13, state.mLevel ~= "")
		end
	end
end

local function fn26(instance, p)
	if _T.SecretMiniGameActive or _T.PvpMode == 4 or __wf_atom_7e8ad928(v17) then
		return
	end

	local count = #v47
	local v74 = false
	local mPtr = nil

	if v12 == module3.UI_MODE_IN_SPACE_SHIP or v12 == module3.UI_MODE_IN_DOJO then
		local __wf_atom_be6b2a2f = v16:__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

		if not __wf_atom_7e8ad928(__wf_atom_be6b2a2f) and __wf_atom_be6b2a2f:IsA(__wf_atom_0097d4df) then
			mPtr = __wf_atom_be6b2a2f:__wf_atom_33466cc7()
		end

		if __wf_atom_7e8ad928(mPtr) then
			mPtr = v17:__wf_atom_f2e7f4a9()
		else
			v74 = true
		end
	else
		mPtr = v17:__wf_atom_f2e7f4a9()
	end

	local deco, otherAvatar, v76

	if not __wf_atom_7e8ad928(mPtr) then
		v76 = v18:FilterStatusEntity(mPtr)
		deco = v76.deco
		otherAvatar = v76.otherAvatar
		local v77 = not __wf_atom_7e8ad928(deco)
			and not v76.isFakeDeco
			and deco:IsA(__wf_atom_8d0b7f88)
			and (deco:__wf_atom_0104313a() or v74 and deco:IsA(__wf_atom_0ee166be))

		if
			(__wf_atom_7e8ad928(deco) or not v77 and (not deco:__wf_atom_572fc369() or deco:IsA(__wf_atom_0ee166be) or not v76.isFakeDeco and deco:__wf_atom_95174740() ~= 0 and not (deco:__wf_atom_c6f1f83d() > 0)) or not (v76.isFakeDeco or deco:__wf_atom_4da05a83()))
			and (__wf_atom_7e8ad928(otherAvatar) or otherAvatar:IsKilled() or not (otherAvatar:__wf_atom_572fc369() or mPtr:IsA(__wf_atom_7b01f9ce) and mPtr:IsEnabled()))
		then
			mPtr = nil
		end

		if not __wf_atom_7e8ad928(otherAvatar) then
			local __wf_atom_1915cc84 = v17:__wf_atom_1915cc84()

			if
				(v12 == module3.UI_MODE_IN_SPACE_HUB or v12 == module3.UI_MODE_IN_DOJO)
				and not otherAvatar:IsA(__wf_atom_ee1ed4db)
				or not __wf_atom_7e8ad928(__wf_atom_1915cc84)
				and not otherAvatar:IsA(__wf_atom_f1872364)
				and not otherAvatar:IsA(__wf_atom_afe1c44c)
				and __wf_atom_1915cc84 == otherAvatar
			then
				mPtr = nil
			end
		end

		if not __wf_atom_7e8ad928(otherAvatar) then
			local __wf_atom_7470861b = otherAvatar:__wf_atom_7470861b()

			if
				not otherAvatar:__wf_atom_572fc369()
				or not __wf_atom_7e8ad928(__wf_atom_7470861b) and __wf_atom_7470861b:__wf_atom_bedb4e3f()
			then
				local __wf_atom_f51f1faa = otherAvatar:__wf_atom_f51f1faa()

				if __wf_atom_7e8ad928(__wf_atom_f51f1faa) or not __wf_atom_f51f1faa:__wf_atom_572fc369() then
					mPtr = nil
				end
			end

			if
				not __wf_atom_7e8ad928(mPtr)
				and not __wf_atom_7e8ad928(instance)
				and instance:IsA(__wf_atom_47cae841)
				and instance:__wf_atom_4221009f() == otherAvatar
			then
				mPtr = nil
			end
		end

		if
			flag
			and not __wf_atom_7e8ad928(mPtr)
			and not __wf_atom_7e8ad928(otherAvatar)
			and v50:__wf_atom_50a7d83e() == otherAvatar
		then
			mPtr = nil
		end
	end

	if __wf_atom_7e8ad928(mPtr) then
		if v48 ~= nil and not __wf_atom_7e8ad928(v47[v48]) then
			v47[v48].mActive = false
			v48 = nil
		end
	else
		if v48 ~= nil and not __wf_atom_7e8ad928(v47[v48]) and v47[v48].mPtr ~= mPtr then
			v47[v48].mActive = false
			v48 = nil
		end

		for i = 1, count do
			if __wf_atom_7e8ad928(v47[i]) or v47[i].mPtr ~= mPtr then
				continue
			end

			if
				not __wf_atom_7e8ad928(v47[i].mAvatar) and v47[i].mAvatar:__wf_atom_b4e17474()
				or not __wf_atom_7e8ad928(v47[i].mDeco)
				and v47[i].mCachedLocTag ~= nil
				and v47[i].mCachedLocTag ~= v47[i].mDeco:__wf_atom_4f3855f9()
			then
				fn25(instance, v47[i])
			end

			v48 = i
			v47[i].mActive = true
			local v77 = not __wf_atom_7e8ad928(v47[i].mDeco)
				and v47[i].mDeco:IsA(__wf_atom_8d0b7f88)
				and v47[i].mDeco:__wf_atom_b2f4c3d9()
			v47[i].mVisible = not v77
				and (__wf_atom_7e8ad928(v47[i].mAvatar) or v47[i].mAvatar:__wf_atom_6165bb29())
				and true
				or false
			v47[i].mPersist = 1
			mMovie:__wf_atom_e57658c2(v47[i].mClipName, 12, module2.Ternary(v47[i].mVisible, 100, 0))
			break
		end

		if v48 == nil and #v47 > 0 then
			for i = 1, count do
				if __wf_atom_7e8ad928(v47[i]) or not (v47[i].mPersist < 2) then
					continue
				end

				v48 = i

				if v47[i].mPersist == 0 then
					break
				end
			end

			local v77 = v47[v48]
			v77.mPersist = 1
			v77.mPtr = mPtr
			v77.mDeco = deco
			v77.mAvatar = otherAvatar
			v77.mActive = true
			v77.mVisible = (__wf_atom_7e8ad928(v77.mDeco) or not (v77.mDeco:IsA(__wf_atom_8d0b7f88) and v77.mDeco:__wf_atom_b2f4c3d9()))
				and (__wf_atom_7e8ad928(v77.mAvatar) or v77.mAvatar:__wf_atom_6165bb29())
				and true
				or false
			v77.mHitProxy = v76.hitProxy
			v77.mDamageControl = nil
			v77.mName = nil
			v77.mCachedLocTag = nil
			v77.mLevel = nil

			for i = 1, #v9 do
				v77.mActiveProcs[i] = 0
				v77.mActiveImmunities[i] = false
			end

			if not __wf_atom_7e8ad928(v77.mAvatar) then
				v77.mDamageControl = v77.mAvatar:__wf_atom_7470861b()
			end

			fn25(instance, v77)
			local v78 = 100
			mMovie:__wf_atom_48bd5a59(v77.mClipName, "Immunities", 36, "")

			if v12 ~= module3.UI_MODE_IN_SPACE_HUB then
				if v77.mHpShieldDisplayAvatar ~= v77.mAvatar then
					v77.mHpShieldDisplayAvatar = v77.mAvatar
					v77.mHpShieldDisplay:__wf_atom_865e86de(v77.mAvatar)
				end

				if __wf_atom_7e8ad928(v77.mAvatar) then
					if not __wf_atom_7e8ad928(v77.mDeco) then
						if v77.mHpShieldDisplayDeco ~= v77.mDeco then
							v77.mHpShieldDisplayDeco = v77.mDeco
							v77.mHpShieldDisplay:SetDeco(v77.mDeco, v76.isFakeDeco == true)
						end

						v77.mHpShieldDisplay:__wf_atom_0a5b3af0(38)
						v77.mHpShieldDisplay:Initialize()
					end
				elseif v77.mAvatar:__wf_atom_1c5f2430() then
					v77.mHpShieldDisplayDeco = nil
					v77.mHpShieldDisplay:SetDeco(nil)
					v77.mHpShieldDisplay:__wf_atom_94a0e155(v77.mAvatar:__wf_atom_a97361bb() ~= instance:__wf_atom_a97361bb() or not v77.mAvatar:__wf_atom_535d5cbb())
					v77.mHpShieldDisplay:__wf_atom_0a5b3af0(23)
					v77.mHpShieldDisplay:Initialize()
				else
					v77.mHpShieldDisplayAvatar = nil
					v77.mHpShieldDisplay:__wf_atom_865e86de(nil)
					v77.mHpShieldDisplayDeco = nil
					v77.mHpShieldDisplay:SetDeco(nil)
					v78 = 0
				end
			end

			mMovie:__wf_atom_e57658c2(v77.mClipName, 12, module2.Ternary(v77.mVisible, v78, 0))
		end
	end

	local mDamageControl = nil

	for i = 1, count do
		if __wf_atom_7e8ad928(v47[i]) then
			continue
		end

		local v77 = v47[i]

		if v77.mActive and __wf_atom_7e8ad928(v77.mPtr) then
			v77.mActive = false
		end

		if not (v77.mActive or v77.mPersist > 0) then
			continue
		end

		v77.mHpShieldDisplay:Update(p)

		if v77.mActive then
			mDamageControl = v77.mDamageControl
		end

		if not (__wf_atom_7e8ad928(v77.mDamageControl) or v77.mHpShieldDisplay:__wf_atom_d033561d()) then
			local mName = v77.mName

			if mName == module3.HIDDEN_PLAYER_NAME then
				mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Stalker", false)
			end

			local flag2 = false

			for j = 1, #v77.mActiveProcs do
				local __wf_atom_846af4f8 = v77.mDamageControl:__wf_atom_846af4f8(j - 1)

				if v77.mActiveProcs[j] ~= __wf_atom_846af4f8 then
					v77.mActiveProcs[j] = __wf_atom_846af4f8
					flag2 = true
				end

				if not (__wf_atom_846af4f8 > 0 and v9[j] ~= nil and v9[j].Icon ~= nil) then
					continue
				end

				local ternary = module2.Ternary(__wf_atom_846af4f8 > 1, __wf_atom_846af4f8, "")
				mName ..= " " .. v9[j].Icon .. ternary
			end

			if flag2 then
				mMovie:__wf_atom_50d60589(v77.mClipName .. ".Name", 36, mName)
			end

			if v77.mDamageControl:IsA(__wf_atom_f7d00d58) then
				local v78 = ""
				local flag3 = false

				for j = 1, #v77.mActiveImmunities do
					local __wf_atom_cf6358c6 = v77.mDamageControl:__wf_atom_cf6358c6(j - 1)

					if v77.mActiveImmunities[j] ~= __wf_atom_cf6358c6 then
						v77.mActiveImmunities[j] = __wf_atom_cf6358c6
						flag3 = true
					end

					if __wf_atom_cf6358c6 and v9[j] ~= nil and v9[j].Icon ~= nil then
						v78 ..= v9[j].Icon .. " "
					end
				end

				if flag3 then
					mMovie:__wf_atom_50d60589(v77.mClipName .. ".Immunities", 36, v78)
				end
			end

			if
				gGameRules:IsA(__wf_atom_8fc2e025)
				and gGameRules:__wf_atom_c31e256f() == 1
				and not __wf_atom_7e8ad928(v77.mAvatar)
			then
				local name = nil

				if v77.mAvatar:IsA(__wf_atom_9e85eea2) then
					local __wf_atom_0b636f17 = v77.mAvatar:__wf_atom_0b636f17()

					if not __wf_atom_7e8ad928(__wf_atom_0b636f17) then
						name = __wf_atom_0b636f17:GetName()
					end
				else
					name = v77.mAvatar:__wf_atom_818ea3a7()
				end

				if name ~= nil then
					local __wf_atom_5802ff81 = gGameRules:__wf_atom_5802ff81(Symbol(name))

					if __wf_atom_5802ff81 > 0 then
						mMovie:__wf_atom_50d60589(v77.mClipName .. ".Immunities", 36, __wf_atom_5802ff81)
					end
				end
			end
		end

		if not v77.mActive then
			local v78 = not __wf_atom_7e8ad928(mPtr)
				or v77.mHpShieldDisplay:__wf_atom_071063d0() <= 0
				or not ((__wf_atom_7e8ad928(v77.mAvatar) or v77.mAvatar:__wf_atom_572fc369()) and (__wf_atom_7e8ad928(v77.mDeco) or v77.mDeco:__wf_atom_572fc369()))
				or __wf_atom_7e8ad928(v77.mAvatar) and __wf_atom_7e8ad928(v77.mDeco)
			local v79 = p * module2.Ternary(v78, 6, 1 - math.min(0.8, v77.mPersist))
			v77.mPersist = math.max(v77.mPersist - v79, 0)

			if v77.mVisible then
				mMovie:__wf_atom_e57658c2(v77.mClipName, 12, math.min(1, v77.mPersist) * 100)
			end

			if v77.mPersist <= 0 then
				v77.mPtr = nil
				v77.mDeco = nil
				v77.mAvatar = nil
				v77.mHitProxy = nil
				v77.mDamageControl = nil
			end
		end

		if not v44 then
			continue
		end

		local position = nil

		if __wf_atom_7e8ad928(v77.mAvatar) then
			if not __wf_atom_7e8ad928(v77.mDeco) then
				if v77.mDeco:IsA(__wf_atom_8d0b7f88) then
					position = v77.mDeco:__wf_atom_41e130cd()
				else
					position = v77.mDeco:GetPosition()
				end
			end
		else
			position = v77.mAvatar:__wf_atom_41e130cd()
		end

		if __wf_atom_7e8ad928(position) then
			continue
		end

		local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(position)

		if v26 < v28 or v25 < v27 then
			if v26 < v28 and v27 < v25 then
				local v78 = v28 / v26
				__wf_atom_74b9a49b.x = (__wf_atom_74b9a49b.x + v33) / (v25 * v31) * v27 - v33
				__wf_atom_74b9a49b.y = (__wf_atom_74b9a49b.y + v34) / v78 / (v26 * v32) * v28 - v34
			end

			__wf_atom_74b9a49b.x = v27 / 2 + (__wf_atom_74b9a49b.x + v33 - v27 / 2) / v29
			__wf_atom_74b9a49b.y = v28 / 2 + (__wf_atom_74b9a49b.y + v34 - v28 / 2) / v29
		end

		local mMovie2 = mMovie
		mMovie2:__wf_atom_2dedec1a(v77.mClipName, 13, __wf_atom_74b9a49b.z < 1 and __wf_atom_74b9a49b.z > 0)

		if not (__wf_atom_74b9a49b.z < 1) then
			continue
		end

		local x = 0
		local y = 0

		if __wf_atom_7e8ad928(v77.mAvatar) then
			local v80 = false

			if not __wf_atom_7e8ad928(v77.mDeco) then
				local __wf_atom_0c59b746 = v77.mDeco:__wf_atom_0c59b746()

				for _, v82 in pairs(__wf_atom_0c59b746) do
					if __wf_atom_7e8ad928(v82.mType) or not v82.mType:IsA(v2) then
						continue
					end

					if __wf_atom_7e8ad928(v82.mInstance) then
						break
					end

					local __wf_atom_74b9a49b2 = mMovie:__wf_atom_74b9a49b(v82.mInstance:GetPosition())

					if v26 < v28 or v25 < v27 then
						if v26 < v28 and v27 < v25 then
							local v83 = v28 / v26
							__wf_atom_74b9a49b2.x = (__wf_atom_74b9a49b2.x + v33) / (v25 * v31) * v27 - v33
							__wf_atom_74b9a49b2.y = (__wf_atom_74b9a49b2.y + v34) / v83 / (v26 * v32) * v28 - v34
						end

						__wf_atom_74b9a49b2.x = v27 / 2 + (__wf_atom_74b9a49b2.x + v33 - v27 / 2) / v29
						__wf_atom_74b9a49b2.y = v28 / 2 + (__wf_atom_74b9a49b2.y + v34 - v28 / 2) / v29
					end

					x = __wf_atom_74b9a49b2.x
					y = __wf_atom_74b9a49b2.y
					v80 = true
					break
				end
			end

			if not v80 then
				local __wf_atom_11d35342 = v18:__wf_atom_11d35342(v77.mDeco)
				x = __wf_atom_11d35342:__wf_atom_c9d0fea6() + (__wf_atom_11d35342:__wf_atom_152cb4a3() - __wf_atom_11d35342:__wf_atom_c9d0fea6()) / 2
				y = module2.Round(__wf_atom_11d35342:__wf_atom_ccf700a6()) - 20
			end
		else
			x = __wf_atom_74b9a49b.x
			y = __wf_atom_74b9a49b.y
		end

		if v77.mLevel == "" and not v77.mIsAIEnemyAvatar then
			y += 30
		end

		mMovie:__wf_atom_e57658c2(v77.mClipName, 0, module2.Round(x))
		mMovie:__wf_atom_e57658c2(v77.mClipName, 1, module2.Round(y))
	end

	if mDamageControl ~= v49 then
		v49 = mDamageControl

		if not __wf_atom_7e8ad928(v18) then
			v18:__wf_atom_8596577a(v49)
		end
	end
end

function Update()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	if __wf_atom_7e8ad928(gGameRules2) then
		gGameRules2 = gGameRules

		if __wf_atom_7e8ad928(gGameRules2) then
			return
		end

		v13 = gGameRules2:IsA(__wf_atom_abe10cec)
		v12 = module3.GetUIMode()
	end

	local v74 = __wf_atom_084b3e93()
	mMovie:__wf_atom_88d9cd84(v74)

	if not fn15() then
		return
	end

	fn21(v74)

	if v12 ~= module3.UI_MODE_IN_SPACE_SHIP then
		if v38 or _T.CrewHudUpdateRequired then
			_T.CrewHudUpdateRequired = nil
			fn22()
		end

		fn24(v16)
		fn26(v16, v74)

		if flag then
			fn6(v74)
		end
	end

	if not __wf_atom_7e8ad928(v20) then
		mMovie:SetVisible(v20:IsVisible())

		if _T.RailjackHudVisible == nil then
			if _T.ForcePostCameraAlpha ~= nil then
				mMovie:__wf_atom_e57658c2("_root", 12, _T.ForcePostCameraAlpha)
			end
		else
			mMovie:__wf_atom_e57658c2("_root", 12, _T.RailjackHudVisible and 100 or 0)
		end
	end

	local minimalHud = _T.MinimalHud

	if v63 ~= minimalHud then
		v63 = minimalHud
		local ternary = module2.Ternary(v63, 0, 100)

		for i = 1, #v40 do
			local v75 = v40[i]

			if v75 ~= nil and v75.Player ~= nil and v75.Player.clipName ~= nil then
				mMovie:__wf_atom_e57658c2(v75.Player.clipName, 12, ternary)
			end

			if v75 ~= nil and v75.Kubrow ~= nil and v75.Kubrow.clipName ~= nil then
				mMovie:__wf_atom_e57658c2(v75.Kubrow.clipName, 12, ternary)
			end
		end
	end

	local hideMarkers = _T.HideMarkers

	if v62 ~= hideMarkers or v22 then
		v62 = hideMarkers
		v22 = false
		local ternary = module2.Ternary(v62, 0, 100)

		for _, v75 in pairs(v21) do
			if v75.garbage then
				continue
			end

			local v76 = v75.clientWasVisible and fn18(v75) and 1 or 0
			mMovie:__wf_atom_3783a721(v75.clipIndex, 12, ternary * v76)
		end
	end

	v67 -= __wf_atom_fa1258d0()

	if v67 <= 0 then
		v67 = 0.3
		local v75 = __wf_atom_7e8ad928((__wf_atom_8e4fda44:__wf_atom_1dca1cfb()))

		if v68 ~= v75 then
			v68 = v75
			mMovie:__wf_atom_f0448d34(v68)
		end
	end

	if v71 then
		local __wf_atom_d5a50cb5 = mMovie:__wf_atom_d5a50cb5()
		local __wf_atom_c4f6543f = mMovie:__wf_atom_c4f6543f()
		local v75 = Vector()
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			local __wf_atom_dd7246c7 = __wf_atom_eab484a7:__wf_atom_dd7246c7()

			if not __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
				__wf_atom_dd7246c7:__wf_atom_592ddaac(v71, v75)
				mMovie:__wf_atom_e57658c2("HintMessage", 0, __wf_atom_d5a50cb5 * 0.5 + v75.x * __wf_atom_d5a50cb5 * 0.5)
				mMovie:__wf_atom_e57658c2("HintMessage", 1, __wf_atom_c4f6543f * 0.5 - v75.y * __wf_atom_c4f6543f * 0.5)
			end
		end
	end

	if v72 then
		mMovie:__wf_atom_50d60589("HintMessage", 36, mMovie:__wf_atom_8e9ac384(v72.text or "", true, v72.replace))

		if v72.text and v72.text ~= "" then
			mMovie:__wf_atom_e57658c2("HintMessage", 12, 100)
		else
			mMovie:__wf_atom_e57658c2("HintMessage", 12, 0)
		end

		v72 = nil
	end
end

function ToggleChatWindow()
	local movie = __wf_atom_8e4fda44:FindMovie(module2.GetChatMovie())

	if __wf_atom_7e8ad928(movie) then
		return
	end

	movie:Execute("ToggleFocus", "")
	return true
end

function IsChatWindowOpen()
	local movie = __wf_atom_8e4fda44:FindMovie(module2.GetChatMovie())
	return not (__wf_atom_7e8ad928(movie) or not movie:Execute("IsMaximized", ""))
end

function IsButtonBarTransitioning()
	if _T.IsButtonBarInputBlocked and _T.IsButtonBarInputBlocked() then
		return true
	end

	return false
end

function onViewportSizeChanged(p, p2, _, _)
	v30 = module.HandleHudScale(mMovie, v29, v10)
	v64 = math.min(p, p2) * 0.15
	fn9()
end

function OnProfileSaved()
	fn11()
end

function onHudMarginsChanged()
	if not (__wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(v10)) then
		v10:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true, v30)
	end
end

function SetMaxDrawDistanceForLabels(p)
	v45 = tonumber(p)
	v45 *= v45
end

function NotifyAbilityChange(_, _)
	if
		not Engine.IsPlayingWithController()
		or module3.GetUIMode() ~= module3.UI_MODE_IN_SPACE_SHIP
		or __wf_atom_7e8ad928(v17)
	then
		return true
	end

	local __wf_atom_e55d02aa = v17:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return true
	end

	local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()
	local flag2 = false

	for _, v75 in ipairs(__wf_atom_36b4a6e5) do
		if not v75:__wf_atom_f3a9b607() then
			continue
		end

		flag2 = true
		break
	end

	if flag2 then
		local __wf_atom_a043ba8b = __wf_atom_e55d02aa:__wf_atom_a043ba8b()

		if not (__wf_atom_7e8ad928(__wf_atom_a043ba8b) or __wf_atom_a043ba8b:__wf_atom_f3a9b607()) then
			__wf_atom_e55d02aa:__wf_atom_2e0e7918("NEXT")
		end
	end

	return true
end

function IconCacheFlushed()
	fn13()
end