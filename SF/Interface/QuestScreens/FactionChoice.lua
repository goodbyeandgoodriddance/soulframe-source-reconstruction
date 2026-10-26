local module = require("SF.Scripts.FirstLoginUtils")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module5 = require("SF.Interface.SFUtilities")
local module6 = require("EE.Interface.Utilities")
local module7 = require("SF.Scripts.Libs.StatsLib")
local module8 = require("SF.Scripts.NightFoldLib")
local module9 = require("SF.Scripts.Libs.TransmissionSet")
local v = { "GlowCenter", "GlowInner", "GlowOuter" }
local v2 = { "Courage", "Grace", "Spirit" }
local v3 = { _G.UIColor_LightRed, _G.UIColor_Blue, _G.UIColor_BlueGreen }
local v4 = { Symbol("ChampionSyndicate"), Symbol("SilentRoseSyndicate"), Symbol("FeySyndicate") }
local v5 = { Symbol("UrgeToHowl"), Symbol("StolenWealth"), Symbol("SpeakToFlowers") }
local v6 = {
	{ "Ability1", "Weapon" },
	{ "Ability2", "FactionTotem" },
	{ "Ability3", "Instrument" }
}
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local firstSelectedLoadout = nil
local firstSupportedSyndicate = nil
local v18 = nil
local v19 = "SelectionTriangle"
local v20 = 0
local v21 = 0
local timeOfDay = nil
local v22 = nil
local sunDir = nil
local v23 = nil
local v24 = nil
local v25 = Vector(-1, 1, 1)
local color = Color(255, 255, 255)
local lightColor = Color(255, 255, 255)
local v26 = false
local v27 = false
local flag = false
local v28 = nil
local v29 = nil
local flag2 = false
local v30 = { FC_FACTIONS = 0, FC_DETAILS = 1, FC_CONFIRMING = 2 }
local FC_FACTIONS = v30.FC_FACTIONS
local v31 = false
local v32 = nil
local v35 = false

function UpdateIdleAfterTurn()
	if not v32 or v31 then
		return
	end

	if v32 then
		v9:__wf_atom_9b5dcd3b(v32, false, 2, 2)
		v32 = nil
	end
end

function WaitAndStopConvergence()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	Sleep(2)
	v31 = false

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:MotionControl():__wf_atom_3959d938(false)
	end
end

function TurnPlayer(p)
	local v36 = Vector(0, 0, 1)
	local __wf_atom_d9cb4b97 = v9:MotionControl():__wf_atom_d9cb4b97()
	__wf_atom_d9cb4b97.heading += p
	__wf_atom_d9cb4b97.pitch += 10
	v9:__wf_atom_51075230(__wf_atom_d9cb4b97)
	v31 = true
	local v37 = v9:GetPosition() + __wf_atom_9341614d(v36, __wf_atom_d9cb4b97)
	v9:MotionControl():__wf_atom_fb8cb580(true, v37, 1)
	v9:__wf_atom_8a035cd5(Symbol("WaitAndStopConvergence"), false)
end

function ChildScriptFadeToNormal()
	module5.DissolveIn(mMovie, nil, 2)
	module4.Fade(false, 2)
end

local function fn()
	local v36 = Vector(0, 1, 0)
	local v37 = Vector(0.7, 0, -3.2)
	local cameraControl = gRegion:__wf_atom_c4f78a8f():CameraControl()
	v14 = 160
	local v38 = v9:GetPosition() + v36
	local __wf_atom_d9cb4b97 = v9:MotionControl():__wf_atom_d9cb4b97()
	local v39 = v38 + __wf_atom_9341614d(v37, __wf_atom_d9cb4b97)
	__wf_atom_d9cb4b97.pitch -= 3
	v10 = gRegion:CreateEntity(cameraSpotType, v39, __wf_atom_d9cb4b97)

	if not __wf_atom_7e8ad928(cameraControl) then
		cameraControl:SetCameraSpot(v10, 0)
	end

	v9:__wf_atom_8a035cd5(Symbol("ChildScriptFadeToNormal"), false)
	TurnPlayer(v14)
	v11 = gRegion:__wf_atom_0a6a5887(Symbol("FirstLoginArsenalLight"))
	v11:TurnOn()
	v11:__wf_atom_f5c11ad2(250)
	v11:__wf_atom_3926210f(80)
	v11:SetColor(color)
	v11:SetPosition(v38 + __wf_atom_9341614d(v9:__wf_atom_a06d543c(), Rotation(90, 0, 0)))
	v11:__wf_atom_9b788a35(__wf_atom_fa8d0177(v11:GetPosition(), v38))
end

local function fn2(p)
	local v36 = "SelectionTriangle"

	for k, v37 in v2 do
		local v38 = v36 .. "." .. v37
		mMovie:SetCallbacks(v38 .. ".Button", "RollOverButton", "RollOutButton", "ButtonClicked", nil)
		mMovie:__wf_atom_4c1c1986(v38, "Button", 100, k)
		mMovie:__wf_atom_4c1c1986(v38, "Leaf", 11, v3[k])
		mMovie:__wf_atom_4c1c1986(v38, "LeafHighlight", 12, 0)

		if p then
			UnfocusButton(k, 0)
		else
			UnfocusButton(k)
		end
	end

	mMovie:OverrideMaterial(v36 .. ".GoldLayer", goldRipple)
	local v37 = v36 .. ".ChooseYourPath"
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/FactionChoicePrompt", false)
	mMovie:__wf_atom_48bd5a59(v37, "Label", 36, __wf_atom_8e9ac384)
	mMovie:__wf_atom_4c1c1986(v37, "Label", 11, _G.UIColor_Beige)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v37 .. ".Label", 40)
	mMovie:OverrideMaterial(v37 .. ".Banner", _G.UIMaterial_DarkPaperBacker)
	mMovie:__wf_atom_4c1c1986(v37, "Banner", 14, __wf_atom_5e6e15c8 + 60)
	mMovie:OverrideMaterial("SelectionTriangle.SpiritHighlight.Banner", virtueBannerMaterial)
	mMovie:OverrideMaterial("SelectionTriangle.CourageHighlight.Banner", virtueBannerMaterial)
	mMovie:OverrideMaterial("SelectionTriangle.GraceHighlight.Banner", virtueBannerMaterial)
end

local function fn3()
	mMovie:OverrideMaterial("DetailsPanel.Virtue.DividerLine", dividerMaterial)
	mMovie:__wf_atom_1ca72041("DetailsPanel.Virtue.DividerLine", "VisibilitySize", 0, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("DetailsPanel.Virtue.DividerLine", "VisibilityFadeSize", 0, 0, 0, 0)
	mMovie:OverrideMaterial("DetailsPanel.Abilities.DividerLineLeft", dividerMaterial)
	mMovie:OverrideMaterial("DetailsPanel.Abilities.DividerLineRight", dividerMaterial)
	mMovie:__wf_atom_2dedec1a("DetailsPanel.Abilities.VerticalDivider", 13, false)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Backer", 11, 1118481)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Backer", 12, 85)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Abilities.AbilitiesLabel", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("DetailsPanel.Abilities.GearLabel", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_50d60589(
		"DetailsPanel.Abilities.AbilitiesLabel",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/AbilitiesLabel", false)
	)
	mMovie:__wf_atom_50d60589(
		"DetailsPanel.Abilities.GearLabel",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/GearLabel", false)
	)
	local v36 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.Abilities.AbilitiesLabel", 40) + 15
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.Abilities.DividerLineLeft", 14)
	mMovie:__wf_atom_1ca72041(
		"DetailsPanel.Abilities.DividerLineLeft",
		"VisibilitySize",
		v36 / __wf_atom_5e6e15c8 / 2,
		0,
		0,
		0
	)
	local v37 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.Abilities.GearLabel", 40) + 10
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("DetailsPanel.Abilities.DividerLineRight", 14)
	mMovie:__wf_atom_1ca72041(
		"DetailsPanel.Abilities.DividerLineRight",
		"VisibilitySize",
		v37 / __wf_atom_5e6e15c8_2 / 2,
		0,
		0,
		0
	)

	for _, v38 in v do
		mMovie:__wf_atom_4c1c1986("SelectionTriangle", v38, 12, 0)
	end

	local module10 = require("SF.Interface.Components.Button")
	v8 = module10.Create(mMovie, "DetailsPanel.Buttons.BackButton", "/SF/Language/Menu/Menu_Back", "BackToChoice")
	v8:SetVariant(module10.VARIANTS.SPECIAL_BUTTON)
	v7 = module10.Create(mMovie, "DetailsPanel.Buttons.ConfirmButton", "/SF/Language/Menu/Menu_Try", "ConfirmSelection")
	v7:SetVariant(module10.VARIANTS.SPECIAL_BUTTON)
	local v38 = math.max(
		mMovie:__wf_atom_5e6e15c8("DetailsPanel.Buttons.BackButton.Btn", 14),
		(mMovie:__wf_atom_5e6e15c8("DetailsPanel.Buttons.ConfirmButton.Btn", 14))
	)
	v8:SetWidth(v38)
	v7:SetWidth(v38)
	v8:SetPosition(-290, nil, module6.CENTER_ALIGNED)
	v7:SetPosition(290, nil, module6.CENTER_ALIGNED)
	local v39 = mMovie:__wf_atom_cfc41e35("DetailsPanel", "Buttons.BackButton", 14) - mMovie:__wf_atom_cfc41e35(
		"DetailsPanel",
		"Buttons.ConfirmButton",
		14
	)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Buttons", 0, v39 / 2)
end

local function fn4()
	local all = gRegion:FindAll(__wf_atom_4d4372ee)
	local v36 = Symbol("DefaultMainSky")

	for i = 1, #all do
		local v37 = all[i]

		if v37:__wf_atom_db682341() ~= v36 then
			continue
		end

		v12 = v37
		break
	end

	if not __wf_atom_7e8ad928(v12) then
		v13 = v12:__wf_atom_267e8b99()
		v23 = v13
	end

	v24 = 1
end

local function fn5()
	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gGameData) then
		return
	end

	timeOfDay = nil
	v24 = nil

	if not __wf_atom_7e8ad928(v12) then
		v12:__wf_atom_e2779837(true)
		v12:Enable(true)
		local v36 = math.max(v12:__wf_atom_3e305fe5(), 0.00001)
		local v37 = 24 / v36
		local timeOfDay2 = gGameRules:CalculateTimeOfDay(v36, v37 / 2)
		v12:SetTimeOfDay(timeOfDay2)
		v12:__wf_atom_d0e0a161(false)
		v12:__wf_atom_4c1730a2(v13)
	end
end

function UpdateTimeOfDay(p, p2)
	if __wf_atom_7e8ad928(timeOfDay) or __wf_atom_7e8ad928(v12) then
		return
	end

	if not p2 then
		v12:SetTimeOfDay(timeOfDay)
		return
	end

	v20 = __wf_atom_421b01aa(v20 + p, 0, 1)
	local v36 = __wf_atom_24a82b69(v20)
	local v37 = __wf_atom_104bfe98(v22, timeOfDay, v36)

	if sunDir then
		local v38 = __wf_atom_f55d6358(v25, sunDir, v36)
		Normalize(v38)
		v12:__wf_atom_2ee34f0b(v38)
		local __wf_atom_104bfe98 = Color(color):__wf_atom_104bfe98(lightColor, v36)
		v11:SetColor(__wf_atom_104bfe98)
	end

	v12:SetTimeOfDay((math.max(0, v37)))
end

local function fn6(p, p2)
	if __wf_atom_7e8ad928(v24) or __wf_atom_7e8ad928(v12) then
		return
	end

	if not p2 then
		v12:__wf_atom_4c1730a2(v24)
		return
	end

	v21 = __wf_atom_421b01aa(v21 + p, 0, 1)
	local v36 = __wf_atom_24a82b69(v21)
	local v37 = __wf_atom_104bfe98(v23, v24, v36)
	v12:__wf_atom_4c1730a2(v37)
end

local function fn7()
	for _, v36 in v2 do
		local v37 = "SelectionTriangle" .. "." .. v36 .. ".Button"
		mMovie:SetCallbacks(v37, nil, nil, nil, nil)
	end
end

local function fn8(p)
	local v36 = mMovie:__wf_atom_cfc41e35(p, "Name", 1) + mMovie:__wf_atom_cfc41e35(p, "Name", 41) + 4

	if mMovie:__wf_atom_cfc41e35(p, "Desc", 40) == 0 then
		v36 -= mMovie:__wf_atom_cfc41e35(p, "Desc", 41)
	end

	mMovie:__wf_atom_4c1c1986(p, "Desc", 1, v36)
end

local function fn9(p)
	mMovie:__wf_atom_4c1c1986(p, "Name", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986(p, "Desc", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_4c1c1986(p, "Backer", 11, _G.UIColor_Beige)
	mMovie:__wf_atom_4c1c1986(p, "Border", 11, _G.UIColor_Yellow)
	fn8(p)
end

local function fn10(object, p)
	local v36 = Localize(object:__wf_atom_014a76a2():c_str(), false)
	local v37 = Localize(object:__wf_atom_3a3d2e39():c_str(), false)
	local v38 = string.gsub(v37, "\r.*", "")
	local iconTexture = object:GetIconTexture()
	mMovie:__wf_atom_50d60589(p .. ".Name", 36, v36)
	mMovie:__wf_atom_50d60589(p .. ".Desc", 36, v38)
	fn9(p)
	mMovie:__wf_atom_c90af43a(p .. ".Icon", iconTexture)
end

local function fn11()
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35("DetailsPanel", "Abilities.List.Ability1.Backer", 15)
	local v36 = 0

	for _, v37 in v6 do
		local v38 = v36 + 20
		local v39 = __wf_atom_cfc41e35

		for _, v40 in v37 do
			local v41 = "DetailsPanel" .. ".Abilities.List." .. v40
			mMovie:__wf_atom_e57658c2(v41, 1, v38)
			local v42 = mMovie:__wf_atom_cfc41e35(v41, "Desc", 1) + mMovie:__wf_atom_cfc41e35(v41, "Desc", 41)

			if v39 < v42 then
				v39 = v42
			end
		end

		v36 = v38 + v39 + 20
	end

	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Abilities.VerticalDivider", 15, v36)
	local v37 = math.min(
		v36 + (mMovie:__wf_atom_cfc41e35("DetailsPanel", "Abilities", 1) + mMovie:__wf_atom_cfc41e35(
			"DetailsPanel",
			"Abilities.List",
			1
		) + 20),
		mMovie:__wf_atom_54eeda24() * 0.95 - mMovie:__wf_atom_cfc41e35("DetailsPanel", "Buttons", 15)
	)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Buttons", 1, v37)
end

local function fn12()
	local v36 = Resource(firstSelectedLoadout.gear[1])
	local v37 = Resource(firstSelectedLoadout.gear[5])
	local v38 = Resource(firstSelectedLoadout.totem)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(firstSelectedLoadout.virtueName, false)
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(v36:__wf_atom_014a76a2():c_str(), false)
	local __wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384(v36:__wf_atom_3a3d2e39():c_str(), false)
	local v39 = "DetailsPanel.Abilities.List"

	for i = 1, 3 do
		fn10(v36:__wf_atom_e68785c4(i), v39 .. ".Ability" .. i)
	end

	fn10(v37, v39 .. ".Weapon")
	fn10(v38, v39 .. ".FactionTotem")
	mMovie:__wf_atom_c90af43a(v39 .. ".Instrument.Icon", instrumentIcon)
	mMovie:__wf_atom_50d60589(
		v39 .. ".Instrument.Name",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/FactionChoiceInstrumentName", false)
	)
	mMovie:__wf_atom_50d60589(
		v39 .. ".Instrument.Desc",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/FactionChoiceInstrumentDescription", false)
	)
	fn9(v39 .. ".Instrument")
	mMovie:__wf_atom_48bd5a59("DetailsPanel", "Pact.Name", 36, __wf_atom_8e9ac384)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Pact.Name", 11, _G.UIColor_Gold)
	mMovie:__wf_atom_48bd5a59("DetailsPanel", "Pact.Desc", 36, __wf_atom_8e9ac384_3)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Pact.Desc", 11, _G.UIColor_Beige)
	local v40 = math.max(
		mMovie:__wf_atom_cfc41e35("DetailsPanel", "Pact", 1) + mMovie:__wf_atom_cfc41e35("DetailsPanel", "Pact.Desc", 1) + mMovie:__wf_atom_cfc41e35("DetailsPanel", "Pact.Desc", 41) + 16,
		340
	)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Abilities", 1, v40)
	mMovie:__wf_atom_c90af43a("DetailsPanel.Virtue.Icon", firstSelectedLoadout.characterIcon)
	mMovie:__wf_atom_48bd5a59("DetailsPanel", "Virtue.Name", 36, __wf_atom_8e9ac384_2)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Virtue.Name", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Virtue.Glow", 11, v17)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Virtue.SoftGlow", 11, v17)
	mMovie:__wf_atom_c90af43a("DetailsPanel.IdolContainer.Icon", firstSelectedLoadout.idolIcon)
	local v41 = mMovie:__wf_atom_cfc41e35("DetailsPanel", "Virtue.Name", 40) / 2 + 20
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Virtue.LeftLeaf", 0, -v41)
	mMovie:__wf_atom_4c1c1986("DetailsPanel", "Virtue.RightLeaf", 0, v41)
	mMovie:OverrideMaterial("DetailsPanel.Virtue.Icon", virtueBannerMaterial)
	mMovie:OverrideMaterial("DetailsPanel.Virtue.SoftGlow", virtueGlowMaterial)
	fn11()
end

local function fn13()
	mMovie:__wf_atom_2dedec1a(v18, 13, false)
	mMovie:__wf_atom_2dedec1a(v19, 13, true)
	module5.DissolveIn(mMovie)
end

local function fn14()
	if not __wf_atom_7e8ad928(factionMenuMusic) then
		v28:Stop(false)
	end

	TurnPlayer(-v14)
	v11:TurnOff()
	v9:CameraControl():SetCameraSpot(nil, 0)

	if not __wf_atom_7e8ad928(v11) then
		v11:TurnOff()
	end

	fn5()

	if not __wf_atom_7e8ad928(gRegion) then
		gRegion:__wf_atom_dd1e4d10(v10)
	end

	module5.DissolveOut(mMovie, OnDissolveOutComplete)
end

local function fn15()
	print("Called GiveGear")
	local v36 = {}
	local v37 = nil
	local v38 = nil

	for _, v39 in ipairs(firstSelectedLoadout.gear) do
		local v40 = Resource(v39)

		if v40:IsA(__wf_atom_abf506db) then
			table.insert(v36, v40)
		end

		if v40:IsA(__wf_atom_d98e64fe) then
			v37 = v40
		else
			v38 = v40
		end
	end

	v26 = true
	gGameData:__wf_atom_814c9017(v37, v38, v36, "OnGiveStartingGearComplete", firstSupportedSyndicate)
	fn14()
end

local function fn16()
	print("CloseAfterValidation: mWaitingForStartingGear or not mDissolveOutComplete" .. tostring(v26) .. " " .. tostring(v27))

	if v26 or not v27 then
		return
	end

	module3.StartQuest(factionQuestWRes)
	ShowBlockingMessage(0)

	if not __wf_atom_7e8ad928(mMovie) then
		mMovie:Close()
	end

	_T.FactionSelectionClosed = true
end

function Shutdown()
	module5.RegisterHideHud(false)
	module8.RegisterPreventNighfoldUsage(false)

	if not __wf_atom_7e8ad928(v11) then
		v11:TurnOff()
	end

	fn5()

	if not __wf_atom_7e8ad928(gRegion) then
		gRegion:__wf_atom_dd1e4d10(v10)
	end

	if v15 ~= nil and not __wf_atom_7e8ad928(v9) then
		local cameraControl = v9:CameraControl()

		if not cameraControl:__wf_atom_c8c5ba0a() then
			cameraControl:__wf_atom_fd14c463(v15)
		end
	end
end

local function fn17()
	local module10 = require("Lotus.Interface.Components.RadialText")
	local circularText = module10.CreateCircularText(
		mMovie,
		"SelectionTriangle.SpiritHighlight.SpiritBannerText.Name.Letter"
	)
	circularText.mRadius = 130
	circularText.mTargetAngle = 70
	circularText.mLetterSpacing = 10
	circularText.mMaterial = virtueMaterials[3]
	circularText:SetText(string.upper(Localize("/SF/Language/Menu/AT_SPIRIT", nil)))
	mMovie:__wf_atom_e57658c2("SelectionTriangle.SpiritHighlight.SpiritBannerText", 11, _G.UIColor_DarkerBrown)
	local circularText2 = module10.CreateCircularText(
		mMovie,
		"SelectionTriangle.CourageHighlight.CourageBannerText.Name.Letter"
	)
	circularText2.mRadius = 92
	circularText2.mTargetAngle = 90
	circularText2.mLetterSpacing = 10
	circularText2.mMaterial = virtueMaterials[3]
	circularText2:SetText(string.upper(Localize("/SF/Language/Menu/AT_COURAGE", nil)))
	mMovie:__wf_atom_e57658c2("SelectionTriangle.CourageHighlight.CourageBannerText", 11, _G.UIColor_DarkerBrown)
	local circularText3 = module10.CreateCircularText(
		mMovie,
		"SelectionTriangle.GraceHighlight.GraceBannerText.Name.Letter"
	)
	circularText3.mRadius = 92
	circularText3.mTargetAngle = 80
	circularText3.mLetterSpacing = 10
	circularText3.mMaterial = virtueMaterials[3]
	circularText3:SetText(string.upper(Localize("/SF/Language/Menu/AT_GRACE", nil)))
	mMovie:__wf_atom_e57658c2("SelectionTriangle.GraceHighlight.GraceBannerText", 11, _G.UIColor_DarkerBrown)
	local circularText4 = module10.CreateCircularText(mMovie, "SelectionTriangle.LifeBannerText.Name.Letter")
	circularText4.mRadius = 160
	circularText4.mTargetAngle = 28
	circularText4.mLetterSpacing = 10
	circularText4.mMaterial = virtueMaterials[3]
	circularText4:SetText(string.upper(Localize("/SF/Language/Menu/AT_LIFE", nil)))
	mMovie:__wf_atom_e57658c2("SelectionTriangle.Illustration.LifeBannerText", 11, _G.UIColor_DarkerBrown)
	return circularText4
end

function Initialize()
	module5.RegisterHideHud(true)
	module8.RegisterPreventNighfoldUsage(true)
	_T.FactionSelectionClosed = false
	module6.PlaySound(menuOpenSound)

	if not __wf_atom_7e8ad928(factionMenuMusic) and __wf_atom_7e8ad928(v28) then
		v28 = module6.PlaySound(factionMenuMusic)
	end

	v9 = gRegion:__wf_atom_c4f78a8f()
	v9:__wf_atom_9b5dcd3b(nil, false)
	v15 = v9:CameraControl():__wf_atom_1b3db7e0()

	if _T.NightfoldFactionChoice then
		gGameData:GetInventory():__wf_atom_3a61ed37():ApplyCustomization(v9, true)
	end

	fn()
	fn4()
	fn2(true)
	fn3()
	fn17()
	v16 = module.LoadInitialGear()
	mMovie:__wf_atom_2dedec1a("DetailsPanel", 13, false)
	mMovie:__wf_atom_c884ca43(true)
	v9:__wf_atom_aeb02c14(emptyInputFilter)
	v35 = true
end

function Update()
	local v36 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v36)

	if flag then
		UpdateTimeOfDay(v36, true)
	end

	fn6(v36, true)

	if v35 and not __wf_atom_7e8ad928(v16) and v16:__wf_atom_86399a47() then
		v35 = false
		mMovie:__wf_atom_c884ca43(false)
		v9:__wf_atom_cf966a74(emptyInputFilter)
	end

	if flag2 then
		fn12()
		v18 = "SelectionTriangle"
		v19 = "DetailsPanel"
		module5.DissolveOut(mMovie, fn13)
		flag2 = false
	end

	UpdateIdleAfterTurn()
end

function OnGiveStartingGearComplete(_, _)
	print("FactionChoice : OnGiveStartingGearComplete")
	gGameData:SyncInventoryFromDB("OnInventorySynced")
end

function OnInventorySynced(_, _)
	local inventory = gGameData:GetInventory()

	while __wf_atom_7e8ad928(inventory) or __wf_atom_7e8ad928(gGameData) do
		Sleep(0)

		if not __wf_atom_7e8ad928(gGameData) then
			inventory = gGameData:GetInventory()
		end
	end

	local __wf_atom_71d5cc00 = inventory:__wf_atom_71d5cc00()
	local __wf_atom_ebdc4e6e = inventory:__wf_atom_ebdc4e6e()
	local __wf_atom_4259c789 = inventory:__wf_atom_4259c789()
	local __wf_atom_a4299765 = gGameData:__wf_atom_a4299765()
	local __wf_atom_c132f79b = inventory:__wf_atom_c132f79b(0, inventory:__wf_atom_d25917b6(0))
	local __wf_atom_b369d77f = __wf_atom_c132f79b:__wf_atom_b369d77f(0)
	local v36 = false

	for _, v37 in ipairs(__wf_atom_ebdc4e6e) do
		if v37.mItemType ~= firstSelectedLoadout.gear[1] then
			continue
		end

		__wf_atom_b369d77f.mItemId.mId = v37.mItemId.mId
		__wf_atom_b369d77f.mModSlot = 0
		__wf_atom_b369d77f.mCustSlot = 0
		__wf_atom_c132f79b:__wf_atom_0aa16242(0, __wf_atom_b369d77f)
		v36 = true
	end

	assert(v36)
	local v37 = false

	for _, v38 in ipairs(__wf_atom_4259c789) do
		if v38.mItemType ~= firstSelectedLoadout.gear[5] then
			continue
		end

		local __wf_atom_b369d77f2 = __wf_atom_c132f79b:__wf_atom_b369d77f(3)
		__wf_atom_b369d77f2.mItemId.mId = v38.mItemId.mId
		__wf_atom_b369d77f2.mModSlot = 0
		__wf_atom_b369d77f2.mCustSlot = 0
		__wf_atom_c132f79b:__wf_atom_0aa16242(3, __wf_atom_b369d77f2)
		v37 = true
	end

	assert(v37)
	local mItem = __wf_atom_a4299765:__wf_atom_d21f18f2(0, 0).mItem
	local __wf_atom_eb82ab1f = mItem:__wf_atom_eb82ab1f()
	local count = 0

	for _, v38 in ipairs(__wf_atom_71d5cc00) do
		if v38.mItemType == firstSelectedLoadout.gear[2] then
			__wf_atom_eb82ab1f:__wf_atom_b6072b05(v38, 2)
			count += 1
		end

		if v38.mItemType == firstSelectedLoadout.gear[3] then
			__wf_atom_eb82ab1f:__wf_atom_b6072b05(v38, 0)
			count += 1
		end

		if v38.mItemType ~= firstSelectedLoadout.gear[4] then
			continue
		end

		__wf_atom_eb82ab1f:__wf_atom_b6072b05(v38, 3)
		count += 1
	end

	assert(count == 3)
	mItem:SetCustomization(__wf_atom_eb82ab1f)
	inventory:__wf_atom_337fac69(0, __wf_atom_c132f79b)
	inventory:__wf_atom_fe6304ae(__wf_atom_b369d77f.mItemId.mId, 0, __wf_atom_eb82ab1f)
	gGameData:__wf_atom_efd6bfce(0, __wf_atom_c132f79b)
	gGameData:__wf_atom_993aebc4("OnSaveNewLoadOutComplete")
	v26 = false
	fn16()
end

function OnSaveNewLoadOutComplete(_, _)
	print("FactionChoice : OnSaveNewLoadOutComplete")
	module2.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
end

function OnUpdateSessionSettings()
	fn16()
end

function OnDissolveOutComplete()
	v27 = true
	local v36 = Symbol("Halloween2025")

	if not gGameData:__wf_atom_7f86fc42(v36) then
		__wf_atom_8e4fda44:__wf_atom_3e5e23c0(welcomeMovieWRes, "OnWelcomeMovieLoaded")
		gGameData:__wf_atom_c9bb8504(v36)
	end

	fn16()
end

function FocusButton(p, value, value2)
	if FC_FACTIONS ~= v30.FC_FACTIONS or __wf_atom_7e8ad928(v10) then
		return
	end

	module6.PlaySound(factionRolloverSound)
	local v36 = v2[p]

	if v36 == nil then
		return
	end

	local v37 = "SelectionTriangle" .. "." .. v36
	local v38 = v37 .. ".LeafHighlight"
	local v39 = v37 .. "Highlight"
	local v40

	if value == nil then
		v40 = value2 == nil
	else
		v40 = false
	end

	if v40 then
		firstSelectedLoadout = module.GetInitialFactionLoadouts()[p]

		if not flag then
			v12:__wf_atom_e2779837(true)
			v12:Enable(true)
			v12:__wf_atom_4c1730a2(v24)
			v12:__wf_atom_d0e0a161(true)
			flag = true
		end

		sunDir = firstSelectedLoadout.sunDir

		if not _T.NightfoldFactionChoice then
			Normalize(sunDir)
			local v41 = 109.4 - v10:__wf_atom_dc309f8a().heading
			sunDir = __wf_atom_9341614d(sunDir, Rotation(v41, 0, 0))
		end

		timeOfDay = firstSelectedLoadout.timeOfDay
		v22 = v12:__wf_atom_cb3427c9()
		v25 = v12:__wf_atom_032a6a06()
		color = v11:GetColor()
		lightColor = firstSelectedLoadout.lightColor
		v20 = 0
	end

	local v41 = value or 0.2
	local v42 = value2 or 0
	__wf_atom_ec43d06e(mMovie, v38, 2, { 12 }, { 20 }, v41, v42)
	__wf_atom_ec43d06e(mMovie, v39, 2, { 5, 6 }, { 105, 105 }, v41, v42)
	__wf_atom_ec43d06e(mMovie, v37 .. ".Glow", 2, { 12 }, { 100 }, v41, v42)
	local v43 = v17
	v17 = v3[p]

	if v43 == nil or not mMovie:__wf_atom_1b848254("SelectionTriangle.GlowCenter") then
		for _, v44 in v do
			mMovie:__wf_atom_4c1c1986("SelectionTriangle", v44, 11, v17)
			__wf_atom_ec43d06e(mMovie, "SelectionTriangle" .. "." .. v44, 2, { 12 }, { 100 }, v41, v42)
		end
	else
		for _, v44 in v do
			local v45 = v44
			__wf_atom_ec43d06e(mMovie, "SelectionTriangle" .. "." .. v44, 2, {
				12,
				function(p2)
					local interpolateColors = module6.InterpolateColors(v43, v17, p2)
					mMovie:__wf_atom_4c1c1986("SelectionTriangle", v45, 11, interpolateColors)
				end
			}, { 100, 1 }, v41, v42)
		end
	end

	if v40 then
		if not _T.NightfoldFactionChoice then
			local loadOut = SF.LoadOut()
			local __wf_atom_d2b2176d = v9:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:__wf_atom_91ecc559()
			__wf_atom_d2b2176d:Clear()
			__wf_atom_d2b2176d:BuildLoadOut(loadOut, 0)
		end

		local __wf_atom_e0f044e1 = firstSelectedLoadout.faction:__wf_atom_e0f044e1()
		module.GiveInitialGear(v9, __wf_atom_e0f044e1, nil, true)
		v32 = module.GetFactionIdleAnim(__wf_atom_e0f044e1)
		v9:Attach(swapFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		module6.PlaySound(factionRolloverFoley)
	end
end

function RollOverButton(p)
	FocusButton(p)
end

function UnfocusButton(p, value, value2)
	if FC_FACTIONS ~= v30.FC_FACTIONS or __wf_atom_7e8ad928(v10) then
		return
	end

	local v36 = v2[p]

	if v36 == nil then
		return
	end

	local v37 = value or 0.2
	local v38 = value2 or 0
	local v39 = "SelectionTriangle" .. "." .. v36
	local v40 = v39 .. ".LeafHighlight"
	local v41 = v39 .. "Highlight"
	__wf_atom_ec43d06e(mMovie, v40, 2, { 12 }, { 0 }, v37, v38)
	__wf_atom_ec43d06e(mMovie, v41, 1, { 5, 6 }, { 100, 100 }, v37, v38)
	__wf_atom_ec43d06e(mMovie, v39 .. ".Glow", 2, { 12 }, { 0 }, v37, v38)

	for _, v42 in v do
		__wf_atom_ec43d06e(mMovie, "SelectionTriangle" .. "." .. v42, 1, { 12 }, { 0 }, v37, v38, function()
			v17 = nil
		end)
	end
end

function RollOutButton(p)
	UnfocusButton(p)
end

function ButtonClicked(firstLoginQuestCurrentFactionChoice)
	if FC_FACTIONS ~= v30.FC_FACTIONS then
		return
	end

	module6.PlaySound(factionSelectSound)
	module6.PlaySound(factionSelectEquips[firstLoginQuestCurrentFactionChoice])
	v29 = module6.PlaySound(factionSelectStingers[firstLoginQuestCurrentFactionChoice])
	fn7()
	v17 = v3[firstLoginQuestCurrentFactionChoice]
	firstSelectedLoadout = module.GetInitialFactionLoadouts()[firstLoginQuestCurrentFactionChoice]
	firstSupportedSyndicate = v4[firstLoginQuestCurrentFactionChoice]
	firstSelectedLoadout.characterIcon = virtueIcons[firstLoginQuestCurrentFactionChoice]
	firstSelectedLoadout.idolIcon = pactIdolIcons[firstLoginQuestCurrentFactionChoice]
	v9:__wf_atom_9b5dcd3b(nil, false)

	if _T.NightfoldFactionChoice then
		module9.PlayGlobalTransmission(transmissionSet, v5[firstLoginQuestCurrentFactionChoice], false)
		_T.FirstLoginQuestCurrentFactionChoice = firstLoginQuestCurrentFactionChoice
	end

	flag2 = true
	FC_FACTIONS = v30.FC_DETAILS
end

function BackToChoice()
	if not (FC_FACTIONS == v30.FC_DETAILS and v19 ~= "SelectionTriangle") then
		return
	end

	FC_FACTIONS = v30.FC_FACTIONS
	fn2()
	v18 = "DetailsPanel"
	v19 = "SelectionTriangle"
	module5.DissolveOut(mMovie, fn13)

	if not __wf_atom_7e8ad928(v29) then
		v29:Stop(false)
	end
end

function OnWelcomeMovieLoaded(_) end

function ConfirmSelection()
	if FC_FACTIONS ~= v30.FC_DETAILS then
		return
	end

	v9:__wf_atom_9b5dcd3b(nil, false)
	FC_FACTIONS = v30.FC_CONFIRMING
	module6.PlaySound(choiceConfirmSelectionSound)

	if not __wf_atom_7e8ad928(v29) then
		v29:Stop(false)
	end

	if _T.NightfoldFactionChoice then
		_T.FirstSelectedLoadout = firstSelectedLoadout
		_T.FirstSupportedSyndicate = firstSupportedSyndicate
		_T.FactionSelectionClosed = true

		if not __wf_atom_7e8ad928(mMovie) then
			mMovie:Close()
		end
	else
		module7.ReplicateLogEvent("PROLOGUE_QUEST", "ChoosePact", firstSelectedLoadout.virtueName)
		fn15()
	end
end

function onKeyDown_MENU_CANCEL()
	BackToChoice()
end

function ShowBlockingMessage(p)
	print("ShowBlockingMessage " .. p)

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", (tostring(p)))
	end
end