require("Lotus.Interface.LotusUtilities")
require("Lotus.Interface.UIStyleUtilities")
local module = require("SF.Interface.Libs.UIUtilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("EE.Interface.Utilities")
local module4 = require("EE.Interface.AnchorMgr")
local module5 = require("SF.Scripts.Libs.PlayerPetLib")
local UIColor_Yellow = _G.UIColor_Yellow
local UIColor_Beige = _G.UIColor_Beige
local UIColor_Orange = _G.UIColor_Orange
local UIColor_Black = _G.UIColor_Black
local v = 1
local v2 = nil
local flag = false
local v3 = nil
local v4 = {}
local v5 = {
	Resource("/SF/Types/Game/Pets/OmenWolfs/WolfAuraUpgrades/WolfStatAuraGuardUpgrade"),
	Resource("/SF/Types/Game/Pets/OmenWolfs/WolfAuraUpgrades/WolfStatAuraSpeedUpgrade"),
	Resource("/SF/Types/Game/Pets/OmenWolfs/WolfAuraUpgrades/WolfStatAuraStaminaUpgrade"),
	Resource("/SF/Types/Game/Pets/OmenWolfs/WolfAuraUpgrades/WolfStatAuraSearchUpgrade"),
	Resource("/SF/Types/Game/Pets/OmenWolfs/WolfAuraUpgrades/WolfStatAuraSupportUpgrade")
}
local v6 = {
	[1] = "<PETSTAT_GUARD>",
	[2] = "<PETSTAT_SPEED>",
	[3] = "<PETSTAT_STAMINA>",
	[4] = "<PETSTAT_SEARCH>",
	[5] = "<PETSTAT_SUPPORT>",
	[0] = "<PETSTAT_ENERGY>",
	Temperament = "<PETSTAT_TEMPERAMENT>",
	Maturity = "<PETSTAT_MATURITY>",
	[8] = "<PETSTAT_BOND>"
}
local v7 = {
	"/SF/Language/Pets/PetTemperment_Loyal",
	"/SF/Language/Pets/PetTemperment_Curious",
	"/SF/Language/Pets/PetTemperment_Playful"
}
local v8 = {
	[0] = "/SF/Language/Pets/PetRank1_Wild",
	[1] = "/SF/Language/Pets/PetRank2_Tame",
	[2] = "/SF/Language/Pets/PetRank3_Loyal",
	[3] = "/SF/Language/Pets/PetRank4_Loving",
	[4] = "/SF/Language/Pets/PetRank5",
	[5] = "/SF/Language/Pets/PetRank5_Soulbound"
}
local circleButtonsByUpgradeStat = {}
local v9 = {}
local v10 = {}
local flag2 = false
local total = 0
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = false

local function fn(p)
	return mMovie:__wf_atom_253d7085(p)
end

local function fn2()
	if _T.SetButtons == nil then
		return
	end

	local v15 = {}
	table.insert(v15, {
		Label = "/SF/Language/Menu/Menu_Back",
		CallBack = onKeyDown_MENU_CANCEL,
		CallOut = "MENU_CANCEL"
	})
	_T.SetButtons(mMovie, v15, getfenv(1))
end

local function fn3()
	mMovie:__wf_atom_c90af43a("Content.BgFill", backerTextureFill)
	mMovie:__wf_atom_c90af43a("Content.BgStart", backerTextureEnd)
	mMovie:__wf_atom_e57658c2("Content.BgFill", 11, 1774608)
	mMovie:__wf_atom_e57658c2("Content.BgStart", 11, 1774608)
	mMovie:__wf_atom_e57658c2("Content.BgFill", 12, 95)
	mMovie:__wf_atom_e57658c2("Content.BgStart", 12, 95)

	if fn("Content.Title.Text") then
		mMovie:__wf_atom_e57658c2("Content.Title.Text", 44, UIColor_Yellow)
	end

	if fn("Content.Title.Icon") then
		mMovie:__wf_atom_c90af43a("Content.Title.Icon", pupPawQuestIcon)
		mMovie:__wf_atom_e57658c2("Content.Title.Icon", 14, 80)
		mMovie:__wf_atom_e57658c2("Content.Title.Icon", 15, 80)
	end

	if fn("Content.Stats.Divider") then
		mMovie:__wf_atom_e57658c2("Content.Stats.Divider", 1, 165)
		mMovie:__wf_atom_e57658c2("Content.Stats.Divider", 14, 512)
		mMovie:__wf_atom_2dedec1a("Content.Stats.Divider", 13, true)
	end

	mMovie:__wf_atom_e57658c2(
		"Content.Stats.TrainingBarArea",
		1,
		mMovie:__wf_atom_5e6e15c8("Content.Stats.Divider", 1) + 15
	)

	if fn("Content.Sidebar.Backer") then
		mMovie:__wf_atom_e57658c2("Content.Sidebar.Backer", 15, 680)
	end

	if fn("Content.CornerLeft") then
		mMovie:__wf_atom_c90af43a("Content.CornerLeft", pupCornerFrame)
		mMovie:__wf_atom_e57658c2("Content.CornerLeft", 12, 70)
		mMovie:__wf_atom_e57658c2("Content.CornerLeft", 5, mMovie:__wf_atom_5e6e15c8("Content.CornerLeft", 5) * -1)
	end

	if fn("Content.CornerRight") then
		mMovie:__wf_atom_c90af43a("Content.CornerRight", pupCornerFrame)
		mMovie:__wf_atom_e57658c2("Content.CornerRight", 12, 70)
	end

	mMovie:__wf_atom_c90af43a("Content.CornerTopLeft", pupTopCornerFrame)
	mMovie:__wf_atom_e57658c2("Content.CornerTopLeft", 14, 325)
	mMovie:__wf_atom_e57658c2("Content.CornerTopLeft", 15, 325)
	mMovie:__wf_atom_c90af43a("Content.CornerTopRight", pupTopCornerFrame)
	mMovie:__wf_atom_e57658c2("Content.CornerTopRight", 5, mMovie:__wf_atom_5e6e15c8("Content.CornerTopRight", 5) * -1)
	mMovie:__wf_atom_e57658c2("Content.CornerTopRight", 14, 325)
	mMovie:__wf_atom_e57658c2("Content.CornerTopRight", 15, 325)

	if fn("Content.CenterFrame") then
		mMovie:__wf_atom_c90af43a("Content.CenterFrame", pupCenterFrame)
		mMovie:__wf_atom_e57658c2("Content.CenterFrame", 14, 190)
		mMovie:__wf_atom_e57658c2("Content.CenterFrame", 12, 70)
	end

	mMovie:__wf_atom_2dedec1a("BottomRightCorner", 13, false)
end

local function fn4(data, _, object)
	local disabled = data.Temperment == nil or data.Temperment == ""
	return {
		{
			Label = mMovie:__wf_atom_8e9ac384(v6.Temperament, true) .. " " .. mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Pets/PetStat_Temperament",
				true
			),
			Value = mMovie:__wf_atom_8e9ac384(v7[data.Temperment + 1], true),
			Disabled = disabled
		},
		{
			Label = mMovie:__wf_atom_8e9ac384(v6[8], true) .. " " .. mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Pets/PetStat_Bond",
				true
			),
			Value = mMovie:__wf_atom_8e9ac384(v8[object:__wf_atom_4fec12f3(8)], true)
		},
		{
			Label = mMovie:__wf_atom_8e9ac384(v6[0], true) .. " " .. mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Pets/PetStat_Energy",
				true
			),
			Value = math.floor(data.Energy * 100),
			UseBar = true
		},
		{
			Eligibility = module5.GetSkillEligibility(object, 1),
			UpgradeStat = 1,
			Label = mMovie:__wf_atom_8e9ac384(v6[1], true) .. " " .. mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Pets/PetStat_Guard",
				true
			),
			Value = object:__wf_atom_4fec12f3(1),
			Rating = object:__wf_atom_4fec12f3(1),
			MaxRating = module5.GetPetMaxSkillLevel(object, 1)
		},
		{
			Eligibility = module5.GetSkillEligibility(object, 2),
			UpgradeStat = 2,
			Label = mMovie:__wf_atom_8e9ac384(v6[2], true) .. " " .. mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Pets/PetStat_Speed",
				true
			),
			Value = object:__wf_atom_4fec12f3(2),
			Rating = object:__wf_atom_4fec12f3(2),
			MaxRating = module5.GetPetMaxSkillLevel(object, 2)
		},
		{
			Eligibility = module5.GetSkillEligibility(object, 3),
			UpgradeStat = 3,
			Label = mMovie:__wf_atom_8e9ac384(v6[3], true) .. " " .. mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Pets/PetStat_Stamina",
				true
			),
			Value = object:__wf_atom_4fec12f3(3),
			Rating = object:__wf_atom_4fec12f3(3),
			MaxRating = module5.GetPetMaxSkillLevel(object, 3)
		},
		{
			Eligibility = module5.GetSkillEligibility(object, 4),
			UpgradeStat = 4,
			Label = mMovie:__wf_atom_8e9ac384(v6[4], true) .. " " .. mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Pets/PetStat_Search",
				true
			),
			Value = object:__wf_atom_4fec12f3(4),
			Rating = object:__wf_atom_4fec12f3(4),
			MaxRating = module5.GetPetMaxSkillLevel(object, 4)
		},
		{
			Eligibility = module5.GetSkillEligibility(object, 5),
			UpgradeStat = 5,
			Label = mMovie:__wf_atom_8e9ac384(v6[5], true) .. " " .. mMovie:__wf_atom_8e9ac384(
				"/SF/Language/Pets/PetStat_Support",
				true
			),
			Value = object:__wf_atom_4fec12f3(5),
			Rating = object:__wf_atom_4fec12f3(5),
			MaxRating = module5.GetPetMaxSkillLevel(object, 5)
		}
	}
end

function Update()
	local v15 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v15)

	if flag2 then
		total += v15

		if total >= 1.2 then
			local v16 = v11
			flag2 = false
			total = 0
			v11 = nil

			if not __wf_atom_7e8ad928(v12) then
				v12:Destroy()
			end

			ConfirmStatUpgrade(v16)
		end
	end
end

function GetStatButtonClip(p)
	local v15 = v9[p]

	if v15 == nil then
		return nil
	end

	return "Content.Stats.Stat" .. v15 .. ".CircleBtnContainer.CircleBtn"
end

function GetStatPawClip(p, p2)
	local v15 = v9[p]

	if v15 == nil then
		return nil
	end

	return "Content.Stats.Stat" .. v15 .. ".Paws.Paw" .. p2
end

local function fn5(p, p2, p3, value)
	local v15 = p .. ".Paws"
	local v16 = v15 .. ".Paw1"

	if p2 == nil or p3 == nil or not fn(v16) then
		if fn(v15) then
			mMovie:__wf_atom_2dedec1a(v15, 13, false)
		end

		return false
	else
		mMovie:__wf_atom_e57658c2(v16, 5, 75)
		mMovie:__wf_atom_e57658c2(v16, 6, 75)
		local v17 = math.max(0, (math.floor(p3)))
		local v18 = math.max(0, (math.min(v17, (math.floor(p2)))))
		local v19 = math.min(v17, v18 + math.max(0, (math.floor(value or 0))))
		mMovie:__wf_atom_2dedec1a(v15, 13, true)
		local v20 = 170 - (v17 - 1) * 28
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v16, 1)

		for i = 1, v17 do
			local v21 = v15 .. ".Paw" .. i

			if i > 1 and not fn(v21) then
				__wf_atom_86cbd68d(mMovie, v16 .. ".duplicateMovieClip", "Paw" .. i, 2000 + i)
			end

			mMovie:__wf_atom_c90af43a(v21 .. ".PawIcon", pupPawPip)
			mMovie:__wf_atom_c90af43a(v21 .. ".PawFill", pupPawPip)
			mMovie:__wf_atom_e57658c2(v21 .. ".PawFill", 11, UIColor_Yellow)
			mMovie:__wf_atom_e57658c2(v21 .. ".PawFill", 12, 0)
			mMovie:__wf_atom_e57658c2(v21 .. ".PawMask", 6, 0)
			mMovie:__wf_atom_c90af43a(v21 .. ".PawStroke", pupPawPipStroke)
			mMovie:__wf_atom_e57658c2(v21 .. ".PawStroke", 11, UIColor_Yellow)
			mMovie:__wf_atom_2dedec1a(v21, 13, true)
			mMovie:__wf_atom_e57658c2(v21, 0, v20 + (i - 1) * 28)
			local v22 = i % 2 == 0 and -10 or 10
			local v23 = i % 2 == 0 and 3 or 0
			mMovie:__wf_atom_e57658c2(v21, 16, v22)
			mMovie:__wf_atom_e57658c2(v21, 1, __wf_atom_5e6e15c8 + v23)
			local v24 = i <= v18
			local v25

			if v18 < i then
				v25 = i <= v19
			else
				v25 = false
			end

			mMovie:__wf_atom_e57658c2(v21 .. ".PawIcon", 11, v24 and UIColor_Yellow or UIColor_Black)
			mMovie:__wf_atom_e57658c2(v21 .. ".PawIcon", 12, v24 and 100 or 40)
			mMovie:__wf_atom_2dedec1a(v21 .. ".PawStroke", 13, v25)
		end

		local v21 = v10[p] or 0

		for i = v17 + 1, v21 do
			local v22 = v15 .. ".Paw" .. i

			if fn(v22) then
				mMovie:__wf_atom_2dedec1a(v22, 13, false)
			end
		end

		v10[p] = v17
		return true
	end
end

function RefreshStatButton(p, p2, p3, p4)
	local v15 = circleButtonsByUpgradeStat[p]

	if v15 == nil then
		return
	end

	local v16 = v9[p]

	if v16 ~= nil then
		mMovie:__wf_atom_2dedec1a("Content.Stats.Stat" .. v16 .. ".CircleBtnContainer", 13, not v14)
	end

	if v14 then
		v15:SetDisabled(true)
		return
	end

	v15:SetDisabled(p3 == nil or not (p3 > 0) or not (p2 < p4))
end

function RefreshStatPips(p, value)
	local v15 = v9[p]

	if v15 == nil then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local v16 = value or 0
	local v17 = __wf_atom_eab484a7:__wf_atom_4fec12f3(p) + v16
	local petMaxSkillLevel = module5.GetPetMaxSkillLevel(__wf_atom_eab484a7, p)
	local v18 = module5.GetSkillEligibility(__wf_atom_eab484a7, p) - v16
	local v19 = v14 and 0 or v18
	fn5("Content.Stats.Stat" .. v15, v17, petMaxSkillLevel, v19)
	RefreshStatButton(p, v17, v19, petMaxSkillLevel)
end

function RefreshAllStatPips(p, p2)
	for k, _ in pairs(v9) do
		local v15 = p ~= k and 0 or p2
		RefreshStatPips(k, v15)
	end
end

function RefreshTrainingState(p, p2, p3, p4, value)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return false
	end

	local v15 = value or 0
	local v16 = p or module5.GetPetMaturity(__wf_atom_eab484a7) + v15
	local v17 = p2 or module5.GetPetMaxMaturity(__wf_atom_eab484a7)
	v14 = v17 > 0 and v17 <= v16

	if v14 then
		mMovie:__wf_atom_50d60589(
			"Content.Stats.TrainingBarArea.TrainingTxt",
			36,
			mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetStat_MaxMaturity", true)
		)
		mMovie:__wf_atom_2dedec1a("Content.Stats.TrainingBarArea.RankBar", 13, false)
		RefreshAllStatPips(p4, v15)
	else
		mMovie:__wf_atom_50d60589(
			"Content.Stats.TrainingBarArea.TrainingTxt",
			36,
			mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetStat_Maturity", true)
		)
		mMovie:__wf_atom_2dedec1a("Content.Stats.TrainingBarArea.RankBar", 13, true)
		local v18 = v16 / (v17 + 0.0001) + 0.0001
		local v19 = 256 * v18 - 4
		local v20 = 256 * v18

		if p3 then
			__wf_atom_ec43d06e(mMovie, "Content.Stats.TrainingBarArea.RankBar.Cap", 8, { 0 }, { v19 }, 0.25)
			__wf_atom_ec43d06e(mMovie, "Content.Stats.TrainingBarArea.RankBar.Mask", 8, { 14 }, { v20 }, 0.25)
		else
			mMovie:__wf_atom_e57658c2("Content.Stats.TrainingBarArea.RankBar.Cap", 0, v19)
			mMovie:__wf_atom_e57658c2("Content.Stats.TrainingBarArea.RankBar.Mask", 14, v20)
		end
	end

	return v14
end

function ConfirmStatUpgrade(p)
	if v14 then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_4fec12f3 = __wf_atom_eab484a7:__wf_atom_4fec12f3(p)
	local petMaxSkillLevel = module5.GetPetMaxSkillLevel(__wf_atom_eab484a7, p)

	if module5.GetSkillEligibility(__wf_atom_eab484a7, p) <= 0 or petMaxSkillLevel <= __wf_atom_4fec12f3 then
		return
	end

	local v15 = __wf_atom_4fec12f3 + 1
	local v16 = GetStatPawClip(p, v15)
	module3.CreateUIParticles(mMovie, v16 .. ".PawIcon", unlockedFx, 0, 0)
	module3.PlaySound(purchaseDoneSound)
	__wf_atom_eab484a7:__wf_atom_aa0d7314(p, 1)
	local v17 = gRegion:IsMaster() and 0 or 1

	if not RefreshTrainingState(nil, nil, true, v17) then
		RefreshStatPips(p, v17)
	end

	RefreshAuraProgress(__wf_atom_eab484a7, p)
end

function CancelPawHoldVisual(p)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local v15 = __wf_atom_eab484a7:__wf_atom_4fec12f3(p) + 1
	local v16 = GetStatPawClip(p, v15)

	if v16 == nil then
		return
	end

	__wf_atom_ec43d06e(mMovie, v16 .. ".PawFill", 8, { 12 }, { 0 }, 0.1)
	mMovie:__wf_atom_e57658c2(v16 .. ".PawMask", 6, 0)
	mMovie:__wf_atom_e57658c2(v16, 5, 75)
	mMovie:__wf_atom_e57658c2(v16, 6, 75)
end

function StartPawHoldVisual(p)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_4fec12f3 = __wf_atom_eab484a7:__wf_atom_4fec12f3(p)
	local petMaxSkillLevel = module5.GetPetMaxSkillLevel(__wf_atom_eab484a7, p)
	local skillEligibility = module5.GetSkillEligibility(__wf_atom_eab484a7, p)
	local v15 = __wf_atom_4fec12f3 + 1

	if skillEligibility <= 0 or petMaxSkillLevel < v15 then
		return
	end

	local v16 = GetStatPawClip(p, v15)

	if v16 == nil then
		return
	end

	mMovie:__wf_atom_e57658c2(v16, 5, 86.25)
	mMovie:__wf_atom_e57658c2(v16, 6, 86.25)
	mMovie:__wf_atom_2dedec1a(v16 .. ".PawFill", 13, true)
	mMovie:__wf_atom_e57658c2(v16 .. ".PawFill", 12, 100)
	mMovie:__wf_atom_e57658c2(v16 .. ".PawMask", 6, 0)
	__wf_atom_ec43d06e(mMovie, v16 .. ".PawMask", 0, { 6 }, { 200 }, 1.2)
end

function StartStatConfirm(p)
	if flag2 or v14 then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_4fec12f3 = __wf_atom_eab484a7:__wf_atom_4fec12f3(p)
	local petMaxSkillLevel = module5.GetPetMaxSkillLevel(__wf_atom_eab484a7, p)

	if module5.GetSkillEligibility(__wf_atom_eab484a7, p) <= 0 or petMaxSkillLevel <= __wf_atom_4fec12f3 then
		return
	end

	flag2 = true
	total = 0
	v11 = p
	local v15 = GetStatButtonClip(p)
	v12 = module3.CreateUIParticles(mMovie, v15 .. ".iconBacker", purchaseHoldFx, 0, 0)
	v13 = module3.PlaySound(purchaseHoldSound)
	StartPawHoldVisual(p)
end

function StopStatConfirm(p)
	if not flag2 then
		return
	end

	if not __wf_atom_7e8ad928(v13) then
		v13:Stop(false)
	end

	if not __wf_atom_7e8ad928(v12) then
		v12:Destroy()
	end

	CancelPawHoldVisual(p)
	flag2 = false
	total = 0
	v11 = nil
end

function OnStatButtonPressed(p)
	local v15 = circleButtonsByUpgradeStat[p]

	if v15.mDisabled then
		return
	end

	if v15 ~= nil and v15.OnPressed ~= nil then
		v15.OnPressed()
	end

	StartStatConfirm(p)
end

function OnStatButtonReleased(p)
	local _ = circleButtonsByUpgradeStat[p]
	StopStatConfirm(p)
end

function OnStatButtonUnfocused(p)
	local v15 = circleButtonsByUpgradeStat[p]

	if v15 ~= nil then
		v15:OnUnfocused()
	end

	if flag2 and v11 == p then
		StopStatConfirm(p)
	end
end

function OnStatButtonFocused(p)
	local v15 = circleButtonsByUpgradeStat[p]

	if v15 ~= nil then
		v15:OnFocused()
	end
end

local function fn6(i, state)
	local v15 = "Content.Stats.Stat" .. i
	state.UseBar = state.UseBar or false

	if state.UpgradeStat ~= nil then
		v9[state.UpgradeStat] = i
	end

	if i > 1 and not fn(v15) then
		__wf_atom_86cbd68d(mMovie, "Content.Stats.Stat1.duplicateMovieClip", "Stat" .. i, 1000 + i)
	end

	mMovie:__wf_atom_c90af43a(v15 .. ".Glow", glowTextIcon)
	mMovie:__wf_atom_e57658c2(v15 .. ".Glow", 12, 45)
	mMovie:__wf_atom_2dedec1a(v15 .. ".Glow", 13, false)
	local v16 = i >= 4 and 115 or 0
	mMovie:__wf_atom_2dedec1a(v15, 13, true)
	mMovie:__wf_atom_2dedec1a(v15 .. ".RankBar", 13, state.UseBar)
	mMovie:__wf_atom_e57658c2(v15, 1, (i - 1) * 50 + v16)
	mMovie:__wf_atom_e57658c2(v15, 12, state.Disabled and 40 or 100)
	local v17 = i >= 4 and 1 or 0

	if fn(v15 .. ".Backer") then
		local v18 = (i + v17) % 2 == 1
		mMovie:__wf_atom_2dedec1a(v15 .. ".Backer", 13, v18)
		mMovie:__wf_atom_e57658c2(v15 .. ".Backer", 11, UIColor_Orange)
		mMovie:__wf_atom_e57658c2(v15 .. ".Backer", 12, v18 and 25 or 0)
		mMovie:__wf_atom_e57658c2(v15 .. ".Backer", 15, 50)
		mMovie:OverrideMaterial(v15 .. ".Backer", roughBackerMaterial)
	end

	mMovie:__wf_atom_50d60589(v15 .. ".Label", 36, mMovie:__wf_atom_8e9ac384(state.Label, true))
	mMovie:__wf_atom_e57658c2(v15 .. ".Label", 44, UIColor_Beige)

	if fn(v15 .. ".Icon") then
		mMovie:__wf_atom_e57658c2(v15 .. ".Icon", 12, 50)
	end

	local v18 = fn5(v15, state.Rating, state.MaxRating or 5, state.Eligibility)

	if fn(v15 .. ".Value") then
		mMovie:__wf_atom_2dedec1a(v15 .. ".Value", 13, not (v18 or state.Disabled or state.UseBar))
		mMovie:__wf_atom_50d60589(v15 .. ".Value", 36, (tostring(state.Value or "")))
		mMovie:__wf_atom_e57658c2(v15 .. ".Value", 44, UIColor_Beige)
	end

	if state.UseBar then
		local v19 = state.Value / 100 + 0.0001
		mMovie:__wf_atom_e57658c2(v15 .. ".RankBar.Cap", 0, 256 * v19 - 4)
		mMovie:__wf_atom_e57658c2(v15 .. ".RankBar.Mask", 14, 256 * v19)
	end

	if fn(v15 .. ".LockIcon") then
		local disabled = state.Disabled == true
		mMovie:__wf_atom_2dedec1a(v15 .. ".LockIcon", 13, disabled)

		if disabled then
			mMovie:__wf_atom_c90af43a(v15 .. ".LockIcon", lockIcon)
		end
	end

	if state.UpgradeStat == nil then
		mMovie:__wf_atom_2dedec1a(v15 .. ".CircleBtnContainer", 13, false)
		return
	end

	local circleButton = module.CreateCircleButton(mMovie, v15 .. ".CircleBtnContainer.CircleBtn")
	local upgradeStat = state.UpgradeStat
	circleButton:SetTooltip(mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetStat_ConfirmStat", true), true)
	mMovie:__wf_atom_e57658c2(circleButton.mClipName .. ".IconBacker", 100, upgradeStat)
	mMovie:SetCallbacks(
		circleButton.mClipName .. ".IconBacker",
		"OnStatButtonFocused",
		"OnStatButtonUnfocused",
		"OnStatButtonReleased",
		"OnStatButtonPressed"
	)
	circleButtonsByUpgradeStat[upgradeStat] = circleButton
	circleButton:SetTextures(confirmButtonTextures, 65)
	mMovie:__wf_atom_e57658c2(v15 .. ".CircleBtnContainer", 5, 64)
	mMovie:__wf_atom_e57658c2(v15 .. ".CircleBtnContainer", 6, 64)
	mMovie:__wf_atom_e57658c2(v15 .. ".CircleBtnContainer", 16, 45)
	RefreshStatButton(upgradeStat, state.Rating, state.Eligibility, state.MaxRating or 5)
end

local function fn7(p)
	for i = math.max(p + 1, 2), v do
		local v15 = "Content.Stats.Stat" .. i

		if fn(v15) then
			__wf_atom_86cbd68d(mMovie, v15 .. ".removeMovieClip")
		end
	end

	v = math.max(1, p)
end

function Initialize()
	module2.DissolveIn(mMovie, nil, 1)
	module2.RegisterHideHudSelective(true)
	module3.PlaySound(menuOpenSound)
	fn2()
	fn3()
	_T.ItemInfoPopupMovies[""]:__wf_atom_62d09591(true)

	if v2 == nil then
		v2 = module4.Create(mMovie)
	end

	if v2.ANCHOR_V_RIGHT ~= nil then
		v2:Register(mMovie, "Content", { v2.ANCHOR_H_RIGHT })
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local v15

	if not (__wf_atom_7e8ad928(__wf_atom_eab484a7) or not __wf_atom_eab484a7:__wf_atom_5e8fa1ad()) then
		v15 = __wf_atom_eab484a7:__wf_atom_4febbf37()
	end

	local petMaturity = module5.GetPetMaturity(__wf_atom_eab484a7)
	local petMaxMaturity = module5.GetPetMaxMaturity(__wf_atom_eab484a7)
	local petEnergyPct = module5.GetPetEnergyPct(__wf_atom_eab484a7)

	if v15 then
		PopulatePupSummary({
			Name = v15.mName,
			Maturity = petMaturity,
			MaxMaturity = petMaxMaturity,
			Temperment = v15.mTemperment,
			Energy = petEnergyPct,
			Guard = v15.mGuard,
			Speed = v15.mSpeed,
			Stamina = v15.mStamina,
			Search = v15.mSearch,
			Support = v15.mSupport
		}, v15, __wf_atom_eab484a7)
	end
end

function Shutdown()
	_T.ItemInfoPopupMovies[""]:__wf_atom_62d09591(false)
	_T.InfoPopup_Data = nil

	if not __wf_atom_7e8ad928(v12) then
		v12:Destroy()
	end
end

local function fn8(p, p2, p3)
	local v15 = 0
	local v16 = v5[p3]
	local v17 = {}
	local v18 = 0

	if not __wf_atom_7e8ad928(v16) then
		for i = 0, v16:__wf_atom_5515f328() - 1 do
			local __wf_atom_f4a8fb82 = v16:__wf_atom_f4a8fb82(i)
			local __wf_atom_348dfac3 = v16:__wf_atom_348dfac3(i)
			v18, v15 = module5.GetPetAuraUpgradeValue(
				p,
				p2,
				__wf_atom_f4a8fb82,
				__wf_atom_348dfac3,
				v16:__wf_atom_70f93b03(i)
			)
			local __wf_atom_2a4e5592 = v16:__wf_atom_2a4e5592(i, (math.max(v18, __wf_atom_f4a8fb82)))
			local __wf_atom_539e4c87 = v16:__wf_atom_539e4c87(i)
			local __wf_atom_e953434e = v16:__wf_atom_e953434e(i)
			local PARAM = not (__wf_atom_e953434e and #__wf_atom_e953434e > 0) and "" or __wf_atom_e953434e[1]
			table.insert(
				v17,
				(mMovie:__wf_atom_8e9ac384(__wf_atom_539e4c87:c_str(), true, {
					VALUE = __wf_atom_2a4e5592,
					PARAM1 = PARAM
				}))
			)
		end
	end

	local v19 = ""

	for i, v20 in ipairs(v17) do
		if i ~= 1 then
			v19 ..= "\n\r"
		end

		v19 ..= v20
	end

	return v18, v15, v19
end

function RefreshAuraProgress(p, p2)
	local v15 = v4[p2]

	if v15 == nil or v15.mClipName == nil then
		return
	end

	local v16, progress, description = fn8(p, p2, v15.AuraIndex)
	local mClipName = v15.mClipName
	v15.Description = description
	v15.Progress = progress
	v15.DisabledAura = v16 <= 0
	__wf_atom_ec43d06e(mMovie, mClipName .. ".FillMask", 8, { 15 }, { 56 * (progress + 0.0001) }, 0.35)
	local v17 = v15.DisabledAura and 20 or 100
	__wf_atom_ec43d06e(mMovie, mClipName .. ".Icon", 8, { 12 }, { v17 }, 0.25)
	__wf_atom_ec43d06e(mMovie, mClipName .. ".Backer", 8, { 12 }, { v17 }, 0.25)
end

local function fn9(p, p2)
	mMovie:__wf_atom_2dedec1a(p .. ".Glow", 13, p2)
	local mMovie = mMovie
	local v15 = p .. ".Label"
	local v16

	if p2 then
		v16 = UIColor_Yellow
	else
		v16 = UIColor_Beige
	end

	mMovie:__wf_atom_e57658c2(v15, 44, v16)
end

function InitializeAuras(p)
	local module6 = require("EE.Interface.Components.List")
	v4 = {}
	v3 = module6.CreateNewList(getfenv(1), "Content.Auras.Aura1")
	v3.mForcedHorizontalSeparation = 90
	v3.mForcedVerticalSeparation = 0

	function v3.mElementDrawCallback(data)
		local mClipName = data.mClipName

		if data.Stat ~= nil then
			v4[data.Stat] = data
		end

		mMovie:__wf_atom_c90af43a(mClipName .. ".Icon", data.Icon)
		mMovie:__wf_atom_e57658c2(mClipName .. ".Icon", 11, _G.UIColor_Yellow)
		mMovie:__wf_atom_c90af43a(mClipName .. ".Backer", tintSlotBacker)
		mMovie:__wf_atom_e57658c2(mClipName .. ".Backer", 11, _G.UIColor_DarkGreen)
		mMovie:__wf_atom_e57658c2(mClipName .. ".Backer", 14, 72)
		mMovie:__wf_atom_e57658c2(mClipName .. ".Backer", 15, 72)
		mMovie:__wf_atom_c90af43a(mClipName .. ".BackerFill", tintSlotBacker)
		mMovie:__wf_atom_e57658c2(mClipName .. ".BackerFill", 11, _G.UIColor_BlueGreen)
		mMovie:__wf_atom_e57658c2(mClipName .. ".BackerFill", 14, 72)
		mMovie:__wf_atom_e57658c2(mClipName .. ".BackerFill", 15, 72)
		mMovie:__wf_atom_c90af43a(mClipName .. ".Btn", tintSlotBacker)
		mMovie:__wf_atom_e57658c2(mClipName .. ".Btn", 14, 72)
		mMovie:__wf_atom_e57658c2(mClipName .. ".Btn", 15, 72)
		mMovie:__wf_atom_e57658c2(mClipName .. ".FillMask", 14, 72)
		mMovie:__wf_atom_e57658c2(mClipName .. ".FillMask", 1, 36)
		mMovie:__wf_atom_e57658c2(mClipName .. ".FillMask", 15, 72 * (data.Progress + 0.0001))
		mMovie:__wf_atom_e57658c2(mClipName .. ".Icon", 14, 57.6)
		mMovie:__wf_atom_e57658c2(mClipName .. ".Icon", 15, 57.6)
		mMovie:__wf_atom_e57658c2(mClipName .. ".Icon", 12, data.DisabledAura and 20 or 100)
		mMovie:__wf_atom_e57658c2(mClipName .. ".Backer", 12, data.DisabledAura and 20 or 100)
	end

	function v3.mOnFocusedCallback(infoPopup_Data)
		if flag then
			return
		end

		module.SetItemInfoPopupRect(
			mMovie,
			infoPopup_Data,
			mMovie:__wf_atom_cfc41e35(infoPopup_Data.mClipName, "Btn", 2),
			mMovie:__wf_atom_cfc41e35(infoPopup_Data.mClipName, "Btn", 3),
			100,
			100
		)
		_T.InfoPopup_Data = infoPopup_Data
		local stat = infoPopup_Data.Stat
		local v15 = v9[stat]

		if v15 == nil then
			return
		end

		fn9("Content.Stats.Stat" .. v15, true)
		mMovie:__wf_atom_e57658c2(infoPopup_Data.mClipName, 5, 120)
		mMovie:__wf_atom_e57658c2(infoPopup_Data.mClipName, 6, 120)
	end

	function v3.mOnUnfocusedCallback(p2)
		_T.InfoPopup_Data = nil
		local stat = p2.Stat
		local v15 = v9[stat]

		if v15 == nil then
			return
		end

		fn9("Content.Stats.Stat" .. v15, false)
		mMovie:__wf_atom_e57658c2(p2.mClipName, 5, 100)
		mMovie:__wf_atom_e57658c2(p2.mClipName, 6, 100)
	end

	local v15 = { guardAuraIcon, speedAuraIcon, staminaAuraIcon, searchAuraIcon, supportAuraIcon }
	local v16 = {
		mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetAura_Title", true, {
			STAT = mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetStat_Guard", true)
		}),
		mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetAura_Title", true, {
			STAT = mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetStat_Speed", true)
		}),
		mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetAura_Title", true, {
			STAT = mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetStat_Stamina", true)
		}),
		mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetAura_Title", true, {
			STAT = mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetStat_Search", true)
		}),
		mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetAura_Title", true, {
			STAT = mMovie:__wf_atom_8e9ac384("/SF/Language/Pets/PetStat_Support", true)
		})
	}

	for i, stat in ipairs({ 1, 2, 3, 4, 5 }) do
		local v17, progress, description = fn8(p, stat, i)
		local v18 = {
			Stat = stat,
			Name = v16[i],
			Description = description,
			Icon = v15[i],
			Progress = progress,
			DisabledAura = v17 <= 0,
			AuraIndex = i,
			CustomEntry = true,
			HideLeaves = true
		}
		v3:AddElement(v18)
		v4[stat] = v18
	end
end

function PopulatePupSummary(data, p, p2)
	v9 = {}
	v14 = data.MaxMaturity > 0 and data.Maturity >= data.MaxMaturity
	local v15 = fn4(data, p, p2)
	local v16 = v

	for i = 1, #v15 do
		fn6(i, v15[i])
	end

	if fn("Content.Title.Text") then
		mMovie:__wf_atom_50d60589("Content.Title.Text", 36, mMovie:__wf_atom_8e9ac384(data.Name, true))
	end

	mMovie:__wf_atom_e57658c2("Content.Stats.TrainingBarArea.TrainingTxt", 44, UIColor_Beige)
	RefreshTrainingState(data.Maturity, data.MaxMaturity)
	v = math.max(v16, #v15)
	fn7(#v15)
	InitializeAuras(p2)
end

function TransitionOut()
	flag = true
	_T.InfoPopup_Data = nil
	module2.DissolveOutAndClose(mMovie)
	module2.RegisterHideHudSelective(false)
	module3.PlaySound(menuCloseSound)
end

function onKeyDown_MENU_CANCEL()
	TransitionOut()
	return true
end

function onViewportSizeChanged(p, p2)
	if v2 ~= nil then
		v2:Update(p, p2)
	end
end