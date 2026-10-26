local module = require("EE.Interface.Utilities")
local module2 = require("SF.Scripts.Libs.StatsLib")
local module3 = require("Lotus.Interface.Libs.TimerMgr")
local module4 = require("SF.Scripts.FirstLoginUtils")
local v = Resource("/SF/Interface/Materials/RankUpBgRays")
local v2 = {
	Color(67, 83, 77, 255),
	Color(67, 83, 77, 255),
	Color(67, 83, 77, 255),
	Color(67, 83, 77, 255),
	Color(67, 83, 77, 255)
}
local v3 = {
	Color(207, 188, 129, 255),
	Color(149, 115, 59, 255),
	Color(151, 64, 8, 255),
	Color(66, 44, 33, 255),
	Color(21, 21, 21, 255)
}
local v4 = {
	Color(82, 147, 163, 255),
	Color(113, 186, 93, 255),
	Color(147, 147, 147, 255),
	Color(120, 72, 27, 255),
	Color(32, 32, 32, 255)
}
local v5 = {
	Resource("/SF/Upgrades/Skins/Mother/Hair4Helmet"),
	Resource("/SF/Upgrades/Skins/Mother/Hair5Helmet"),
	Resource("/SF/Upgrades/Skins/Mother/Hair1Helmet"),
	Resource("/SF/Upgrades/Skins/Mother/Hair2Helmet"),
	Resource("/SF/Upgrades/Skins/Mother/Hair3Helmet")
}
local fn
local fn2
local fn3
local fn4
local fn5
local v6 = false
local flag = false
local v7 = false
local v8 = false
local v9 = false
local v10 = false
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = {
	"MotherCustomizationTitle_Complexion",
	"MotherCustomizationTitle_HairStyle",
	"MotherCustomizationTitle_HairColour",
	"MotherCustomizationTitle_Eyes"
}
local v18 = {
	{
		"MotherComplextion_Lightest",
		"MotherComplextion_Light",
		"MotherComplextion_Medium",
		"MotherComplextion_Dark",
		"MotherComplextion_Darkest"
	},
	{ "MotherHair_1", "MotherHair_2", "MotherHair_3", "MotherHair_4", "MotherHair_5" },
	{
		"MotherHair_Blond",
		"MotherHair_LightBrown",
		"MotherHair_Red",
		"MotherHair_DarkBrown",
		"MotherHair_Black"
	},
	{ "MotherEye_Blue", "MotherEye_Green", "MotherEye_Grey", "MotherEye_Hazel", "MotherEye_Black" }
}
local motherCutsceneResourceAnchors = nil
local v19 = { module4.mMotherSkinColors, v2, v3, v4 }
local v20 = nil
local v21 = nil

local function fn6()
	__wf_atom_86cbd68d(mMovie, "CustomizationElement.gotoAndStop", 1)
	mMovie:__wf_atom_2dedec1a("_root", 13, true)
	mMovie:__wf_atom_e57658c2("CustomizationElement.SelectionFlower", 5, 100)
	mMovie:__wf_atom_e57658c2("CustomizationElement.SelectionFlower", 6, 100)
	mMovie:__wf_atom_a763aa1a(1)
	__wf_atom_ec43d06e(mMovie, "_root", 12, { function(p)
			mMovie:__wf_atom_a763aa1a(1 - p)
		end }, { 1 }, 2, 0, function()
		mMovie:__wf_atom_fbca497c(true)
		v6 = true
	end)
	module.PlaySound(uiFadeUpSound)
	flag = false
	v8 = _T.MotherSelectionState == 3
	v10 = _T.MotherSelectionState == 3

	if _T.MotherSelectionState == 3 then
		mMovie:__wf_atom_e57658c2("CustomizationElement", 0, 200)
	end

	fn4()
	v11 = _T.MotherSelectionState == 7
	fn()
	fn2()
end

local function fn7(object) -- 2 equivalent calls inferred from this helper
	local __wf_atom_cdcc10f5 = object:__wf_atom_cdcc10f5(1, 0)

	if #__wf_atom_cdcc10f5 > 0 then
		return __wf_atom_cdcc10f5[1]
	end

	return nil
end

local function fn8()
	local result = {}

	for _, v22 in ipairs(v5) do
		table.insert(result, fn7(v22)) -- inferred equivalent call
	end

	return result
end

local function fn9()
	if not (__wf_atom_7e8ad928(v20) or __wf_atom_7e8ad928(v21)) then
		return
	end

	local __wf_atom_c3b255b8 = gRegion:__wf_atom_c3b255b8()

	if not __wf_atom_7e8ad928(__wf_atom_c3b255b8) then
		local v22 = Symbol("Mother")
		local v23 = Symbol("Baby")
		local __wf_atom_59c6b81d = __wf_atom_c3b255b8:__wf_atom_59c6b81d()

		for _, v24 in ipairs(__wf_atom_59c6b81d) do
			if __wf_atom_7e8ad928(v24) or v24:IsA(__wf_atom_4ebf67cb) then
				continue
			end

			local __wf_atom_12695c30 = v24:__wf_atom_12695c30()

			if __wf_atom_12695c30 == v22 then
				v20 = v24

				if not __wf_atom_7e8ad928(v21) then
					break
				end
			elseif __wf_atom_12695c30 == v23 then
				v21 = v24

				if not __wf_atom_7e8ad928(v20) then
					break
				end
			end
		end
	end
end

function ApplyCustomization()
	local imGuiMotherCustomization = _T.ImGuiMotherCustomization and _T.ImGuiMotherCustomization
		or gGameData:GetInventory():__wf_atom_3a61ed37()
	fn9()

	if not __wf_atom_7e8ad928(v20) then
		local __wf_atom_035fdfa8 = imGuiMotherCustomization:__wf_atom_035fdfa8(0)

		if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
			local mType = fn7(Resource(__wf_atom_035fdfa8)).mType -- inferred equivalent call
			local v22 = fn8()

			for _, v23 in ipairs(v22) do
				local mType2 = v23.mType
				local __wf_atom_bb3e7833 = v20:__wf_atom_bb3e7833(mType2)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:__wf_atom_68f2c268(mType == mType2 and 0 or 0.9999)
				end
			end
		end

		imGuiMotherCustomization:ApplyCustomization(v20)
	end

	if not __wf_atom_7e8ad928(v21) and imGuiMotherCustomization:__wf_atom_f9098661(0, 0) then
		local color = imGuiMotherCustomization:GetColor(0, 0)
		local v22 = Symbol("SkinToneColor")
		v21:__wf_atom_fd3ec680(
			v22,
			1,
			color:__wf_atom_6f94332f(),
			color:__wf_atom_5cad32b9(),
			color:__wf_atom_0973634e(),
			1,
			false
		)
		v21:__wf_atom_fd3ec680(
			v22,
			4,
			color:__wf_atom_6f94332f(),
			color:__wf_atom_5cad32b9(),
			color:__wf_atom_0973634e(),
			1,
			false
		)
	end
end

function InitializeMotherBaby()
	fn9()

	if not __wf_atom_7e8ad928(v20) then
		local v22 = fn8()

		for _, v23 in ipairs(v22) do
			local mType = v23.mType

			if not __wf_atom_7e8ad928((v20:__wf_atom_bb3e7833(mType))) then
				continue
			end

			local autoChild = Engine.AutoChild(v23)
			v20:CreateAutoChild(autoChild)
			local __wf_atom_18aa6e58 = autoChild:__wf_atom_18aa6e58()

			if not __wf_atom_7e8ad928(__wf_atom_18aa6e58) then
				__wf_atom_18aa6e58:__wf_atom_68f2c268(0.99)
			end
		end
	end

	while __wf_atom_7e8ad928(gGameData) do
		Sleep(0)
	end

	fn5(1, 1, true)
	fn5(3, 1, true)
	fn5(5, 1, true)
	fn5(7, 1, true)
end

function Initialize()
	v6 = false
	mMovie:__wf_atom_fbca497c(false)
	mMovie:__wf_atom_2dedec1a("_root", 13, false)
	v16 = mMovie:__wf_atom_5e6e15c8("CustomizationElement.DetailsText", 1)
	v14 = module3.CreateTimerMgr()
	motherCutsceneResourceAnchors = { complexionSounds, hairMeshSounds, hairColorSounds, eyeSounds }

	if not _T.MotherCutsceneResourceAnchors then
		_T.MotherCutsceneResourceAnchors = motherCutsceneResourceAnchors
	end

	InitializeMotherBaby()

	if _T.MotherSelectionState ~= 1 then
		fn6()
		return
	end

	v13 = module.PlaySound(introLineSound)
	v7 = false
end

function Update()
	local v22 = __wf_atom_fa1258d0()

	if not __wf_atom_7e8ad928(v14) then
		v14:Update(v22)
	end

	mMovie:__wf_atom_88d9cd84(v22)

	if _T.MotherSelectionState == 1 and not v7 and __wf_atom_7e8ad928(v13) then
		v7 = true
		fn6()
	end

	if v8 and flag and v9 and __wf_atom_7e8ad928(v12) then
		fn6()
	end
end

local function fn10(p, p2, p3)
	local inventory = gGameData:GetInventory()
	local __wf_atom_23e1a032 = inventory:__wf_atom_23e1a032(0)

	for i = 1, #__wf_atom_23e1a032 do
		if __wf_atom_7e8ad928(__wf_atom_23e1a032[i]) or __wf_atom_23e1a032[i].mRemove then
			continue
		end

		local __wf_atom_b369d77f = __wf_atom_23e1a032[i]:__wf_atom_b369d77f(0)
		local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
		__wf_atom_eb82ab1f:SetColor(p, p2, p3)
		__wf_atom_eb82ab1f:__wf_atom_59cc106e(p, p2, true)
		inventory:__wf_atom_fe6304ae(__wf_atom_b369d77f.mItemId.mId, __wf_atom_b369d77f.mCustSlot, __wf_atom_eb82ab1f)
	end
end

local function fn11(p, p2)
	local inventory = gGameData:GetInventory()
	local __wf_atom_23e1a032 = inventory:__wf_atom_23e1a032(0)

	for i = 1, #__wf_atom_23e1a032 do
		if __wf_atom_7e8ad928(__wf_atom_23e1a032[i]) or __wf_atom_23e1a032[i].mRemove then
			continue
		end

		local __wf_atom_b369d77f = __wf_atom_23e1a032[i]:__wf_atom_b369d77f(0)
		local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
		__wf_atom_eb82ab1f:SetSkin(p2, p)
		inventory:__wf_atom_fe6304ae(__wf_atom_b369d77f.mItemId.mId, __wf_atom_b369d77f.mCustSlot, __wf_atom_eb82ab1f)
	end
end

local function fn12(motherCustomization)
	print("Colours: ")

	for i = 0, 9 - 1 do
		for j = 0, 8 - 1 do
			if motherCustomization:__wf_atom_f9098661(i, j) then
				print("[" .. i .. ", " .. j .. "] = " .. motherCustomization:GetColor(i, j):__wf_atom_dcecedb0())
			end
		end
	end

	print("Skins: ")

	for i = 0, 8 - 1 do
		local __wf_atom_035fdfa8 = motherCustomization:__wf_atom_035fdfa8(i)

		if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
			print(__wf_atom_035fdfa8:GetName())
		end
	end
end

local function fn13(motherCustomization)
	return motherCustomization:__wf_atom_f9098661(0, 0)
		and motherCustomization:__wf_atom_f9098661(0, 2)
		and motherCustomization:__wf_atom_f9098661(0, 3)
		and motherCustomization:__wf_atom_f9098661(1, 0)
		and motherCustomization:__wf_atom_f9098661(1, 1)
		and motherCustomization:__wf_atom_f9098661(1, 2)
		and motherCustomization:__wf_atom_f9098661(1, 3)
		and motherCustomization:__wf_atom_f9098661(1, 6)
		and not __wf_atom_7e8ad928(motherCustomization:__wf_atom_035fdfa8(0))
end

local function fn14(p) -- 6 equivalent calls inferred from this helper
	return (math.ceil(p / 2))
end

fn5 = function(p, p2, p3, p4)
	if flag then
		return
	end

	local v22 = fn14(p) -- inferred equivalent call
	local v23 = v19[fn14(p)][p2] -- inferred equivalent call
	local v24 = not p3
	local inventory = gGameData:GetInventory()

	if not _T.MotherCustomization then
		_T.MotherCustomization = inventory:__wf_atom_3a61ed37()
	end

	local motherCustomization = _T.MotherCustomization

	if _T.ImGuiMotherCustomization then
		motherCustomization = _T.ImGuiMotherCustomization
	end

	if p4 then
		print("Mom customization stage " .. v22 .. ", choice " .. p2)

		if not fn13(motherCustomization) then
			print("Invalid mom customization from profile")
			fn12(motherCustomization)
		end
	end

	if v22 == 1 then
		if v24 or not motherCustomization:__wf_atom_f9098661(0, 0) then
			motherCustomization:SetColor(0, 0, v23)
			motherCustomization:__wf_atom_59cc106e(0, 0, true)
		end

		if v24 then
			fn10(0, 0, v23)
			fn11(6, module4.mInitialHeadSkins[p2])
		end
	elseif v22 == 2 then
		if v24 or __wf_atom_7e8ad928(motherCustomization:__wf_atom_035fdfa8(0)) then
			motherCustomization:SetSkin(v5[p2], 0)
		end

		if v24 then
			fn11(4, module4.mInitialHairSkins[p2])
		end
	elseif v22 == 3 then
		if v24 or not motherCustomization:__wf_atom_f9098661(1, 0) then
			for i = 0, 3 do
				motherCustomization:SetColor(1, i, v23)
				motherCustomization:__wf_atom_59cc106e(1, i, true)
			end

			motherCustomization:SetColor(1, 6, v23)
			motherCustomization:__wf_atom_59cc106e(1, 6, true)
		end

		if v24 then
			fn10(1, 0, v23)
			fn10(1, 1, v23)
			fn10(1, 2, v23)
			fn10(1, 3, v23)
			fn10(1, 6, v23)
		end
	elseif v22 == 4 then
		local v25 = Color(v23.red * 0.75, v23.green * 0.75, v23.blue * 0.75, v23.alpha)
		local v26 = Color(v23.red * 1, v23.green * 1, v23.blue * 1, v23.alpha)

		if v24 or not motherCustomization:__wf_atom_f9098661(0, 2) then
			motherCustomization:SetColor(0, 2, v25)
			motherCustomization:__wf_atom_59cc106e(0, 2, true)
			motherCustomization:SetColor(0, 3, v26)
			motherCustomization:__wf_atom_59cc106e(0, 3, true)
		end

		if v24 then
			fn10(0, 2, v25)
			fn10(0, 3, v26)
		end
	end

	if _T.ImGuiMotherCustomization then
		_T.ImGuiMotherCustomization = motherCustomization
	end

	inventory:__wf_atom_1f384221(motherCustomization)

	if v24 or v22 == 4 then
		ApplyCustomization()
	end

	if p4 then
		print("Post apply customization: ")
		fn12(motherCustomization)

		if not fn13(motherCustomization) then
			LogBug("Invalid mom customization")
		end
	end
end

fn4 = function()
	local v22 = mMovie:__wf_atom_5e6e15c8("CustomizationElement", 0) + 135
	local v23 = mMovie:__wf_atom_5e6e15c8("CustomizationElement", 1) + 112
	local transformPixelToViewportCoordinates = module.TransformPixelToViewportCoordinates(mMovie, {
		x = v22,
		y = v23
	})
	local v24 = transformPixelToViewportCoordinates.x * mMovie:__wf_atom_d5a50cb5()
	local v25 = transformPixelToViewportCoordinates.y * mMovie:__wf_atom_c4f6543f()
	gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(v24, v25)
	__wf_atom_8e4fda44:__wf_atom_b005c93e(v24, v25)
end

local function fn15(p) -- 2 equivalent calls inferred from this helper
	return hairTextureIcons[p]
end

fn = function()
	for i = 1, 5 do
		local color = Color
		local v22 = color(v19[fn14(_T.MotherSelectionState)][i]) -- inferred equivalent call
		mMovie:__wf_atom_e57658c2("CustomizationElement.SelectionFlower.Petal" .. i .. ".Btn", 100, i)
		mMovie:SetCallbacks(
			"CustomizationElement.SelectionFlower.Petal" .. i .. ".Btn",
			"PetalRollOver",
			"PetalRollOut",
			nil,
			"PetalClick"
		)
		mMovie:__wf_atom_e57658c2("CustomizationElement.SelectionFlower.Petal" .. i .. ".Glow", 12, 0)

		if v10 then
			mMovie:__wf_atom_c90af43a("CustomizationElement.SelectionFlower.Petal" .. i .. ".ColorIndicator", fn15(i)) -- inferred equivalent call
		end

		mMovie:__wf_atom_e57658c2(
			"CustomizationElement.SelectionFlower.Petal" .. i .. ".ColorIndicator",
			11,
			v22:__wf_atom_dcecedb0()
		)
		mMovie:OverrideMaterial("CustomizationElement.SelectionFlower.Petal" .. i .. ".Glow.GlowInner", v)
	end
end

local function fn16(motherSelectionState) -- 1 equivalent call inferred from this helper
	local v22 = math.ceil(motherSelectionState / 2)
	return flowerIcons[v22]
end

fn2 = function()
	if _T.MotherSelectionState == nil then
		_T.MotherSelectionState = 1
	end

	local motherSelectionState = _T.MotherSelectionState
	local mMovie2 = mMovie
	local __wf_atom_8e9ac384 = mMovie2:__wf_atom_8e9ac384(
		"/SF/Language/Mother/" .. v17[fn14(motherSelectionState)], -- inferred equivalent call
		false
	)
	mMovie:__wf_atom_50d60589("CustomizationElement.TitleText", 36, __wf_atom_8e9ac384)
	mMovie:__wf_atom_50d60589("CustomizationElement.DetailsText", 36, "")
	mMovie:__wf_atom_e57658c2("CustomizationElement.DetailsText", 12, 0)
	local v22 = mMovie:__wf_atom_5e6e15c8("CustomizationElement.TitleText", 0) + mMovie:__wf_atom_5e6e15c8(
		"CustomizationElement.TitleText",
		14
	) / 2
	local v23 = v22 - mMovie:__wf_atom_5e6e15c8("CustomizationElement.TitleText", 40) / 2
	local v24 = v22 + mMovie:__wf_atom_5e6e15c8("CustomizationElement.TitleText", 40) / 2
	mMovie:__wf_atom_e57658c2("CustomizationElement.LeftDeco", 0, v23 - 37)
	mMovie:__wf_atom_e57658c2("CustomizationElement.RightDeco", 0, v24 + 30)
	local mMovie = mMovie
	mMovie:__wf_atom_c90af43a("CustomizationElement.Icon", fn16(motherSelectionState)) -- inferred equivalent call
end

local function fn17()
	__wf_atom_ec43d06e(mMovie, "_root", 13, { function(p)
			mMovie:__wf_atom_a763aa1a(p)
		end }, { 1 }, 2, 0, function()
		v9 = true

		if v10 then
			for i = 1, 5 do
				local mMovie = mMovie
				mMovie:__wf_atom_c90af43a(
					"CustomizationElement.SelectionFlower.Petal" .. i .. ".ColorIndicator",
					fn15(v15) -- inferred equivalent call
				)
			end
		end
	end)
end

local function fn18()
	v9 = false
	__wf_atom_86cbd68d(mMovie, "CustomizationElement.gotoAndPlay", 10)
	__wf_atom_ec43d06e(mMovie, "CustomizationElement.SelectionFlower", 13, { function(_) end }, { 1 }, 0.31, 0, fn17)
end

local function fn19(p)
	if flag then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		module2.ReplicateLogEvent("PROLOGUE_QUEST", "MotherCosmetic:" .. _T.MotherSelectionState, p)
	end

	v15 = p
	fn5(_T.MotherSelectionState, p, false, true)
	flag = true
	mMovie:__wf_atom_fbca497c(false)
	module.PlaySound(uiSelectSound)
	local v22 = fn14(_T.MotherSelectionState) -- inferred equivalent call
	local v23 = motherCutsceneResourceAnchors[v22][p]
	v12 = module.PlaySound(v23)

	if v8 then
		_T.MotherSelectionState = _T.MotherSelectionState + 2
	else
		fn3(v12)
	end

	v6 = false
	fn18()
end

local function fn20()
	if not __wf_atom_7e8ad928(v20) then
		local v22 = fn8()

		for _, v23 in ipairs(v22) do
			local mType = v23.mType
			local __wf_atom_bb3e7833 = v20:__wf_atom_bb3e7833(mType)

			if not (__wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_bb3e7833:IsVisible()) then
				gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
			end
		end
	end
end

fn3 = function(object)
	fn20()
	local __wf_atom_53a51c90 = object:__wf_atom_53a51c90()

	if v11 then
		local inventory = gGameData:GetInventory()
		local __wf_atom_c132f79b = inventory:__wf_atom_c132f79b(0, inventory:__wf_atom_d25917b6(0))
		local __wf_atom_b369d77f = __wf_atom_c132f79b:__wf_atom_b369d77f(0)
		local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				__wf_atom_e55d02aa:SetCustomization(__wf_atom_eb82ab1f, true)
			end
		end

		gGameData:__wf_atom_efd6bfce(0, __wf_atom_c132f79b)
		gGameData:__wf_atom_993aebc4("")
	else
		__wf_atom_53a51c90 -= 9
	end

	if not __wf_atom_7e8ad928(_T.MotherCutscene) then
		local __wf_atom_a5549761 = _T.MotherCutscene:__wf_atom_a5549761(true)

		if __wf_atom_53a51c90 <= __wf_atom_a5549761 then
			__wf_atom_53a51c90 -= __wf_atom_a5549761
			_T.MotherCutscene:__wf_atom_398939a1()
			_T.MotherCutscene = nil
		else
			local v22 = math.ceil((__wf_atom_53a51c90 - __wf_atom_a5549761) / 4)
			__wf_atom_53a51c90 += v22 * 4
			v14:AddTimer(__wf_atom_a5549761 + (v22 - 0.5) * 4, function()
				if not __wf_atom_7e8ad928(_T.MotherCutscene) then
					_T.MotherCutscene:__wf_atom_398939a1()
					_T.MotherCutscene = nil
				end
			end)
		end
	end

	local v22 = math.max(__wf_atom_53a51c90, 3)
	v14:AddTimer(v22, function()
		Close()
	end)
end

function Close()
	fn20()

	if _T.MotherSelectionState ~= nil then
		_T.MotherSelectionState = _T.MotherSelectionState + 1
	end

	if not __wf_atom_7e8ad928(_T.MotherCutscene) then
		_T.MotherCutscene:__wf_atom_398939a1()
		_T.MotherCutscene = nil
	end

	if v11 then
		_T.MotherCutsceneResourceAnchors = nil
	end

	mMovie:Close()
end

function PetalRollOver(p, p2)
	if not v6 then
		return
	end

	module.PlaySound(uiHoverSound)
	local v22 = v18[fn14(_T.MotherSelectionState)][p] -- inferred equivalent call
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Mother/" .. v22, false)
	mMovie:__wf_atom_50d60589("CustomizationElement.DetailsText", 36, __wf_atom_8e9ac384)
	__wf_atom_ec43d06e(mMovie, p2 .. "._parent", 2, { 5, 6 }, { 105, 105 }, 0.3)
	__wf_atom_ec43d06e(mMovie, p2 .. "._parent.Glow", 2, { 12 }, { 50 }, 0.3)
	mMovie:__wf_atom_e57658c2("CustomizationElement.DetailsText", 1, v16 + 5)
	__wf_atom_ec43d06e(mMovie, "CustomizationElement.DetailsText", 2, { 12, 1 }, { 100, v16 }, 0.3)
	fn5(_T.MotherSelectionState, p)
end

function PetalRollOut(_, p)
	if not v6 then
		return
	end

	__wf_atom_ec43d06e(mMovie, p .. "._parent", 2, { 5, 6 }, { 100, 100 }, 0.3)
	__wf_atom_ec43d06e(mMovie, p .. "._parent.Glow", 2, { 12 }, { 0 }, 0.3)
	__wf_atom_ec43d06e(mMovie, "CustomizationElement.DetailsText", 2, { 12 }, { 0 }, 0.3)
end

function PetalClick(p, _)
	if not v6 then
		return
	end

	fn19(p)
end