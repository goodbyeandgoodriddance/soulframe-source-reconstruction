local flag = false
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local statOwner = nil
local arsenalAvatar = nil
local inventory = nil
local v7 = nil
local v8 = {}
local v9 = nil
local v10 = __wf_atom_10cd16b2(0, 0.25)
local v11 = __wf_atom_10cd16b2(0, 0.25)
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = { Edge = nil, Inner = nil }
local v16 = { SwapMotes = nil, MotesDescription = nil }
local v17 = {}
local v18 = {}
local mAttributeItem = nil
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = nil
local v26 = nil
local v27 = false
local v28 = { LS_NONE = 0, LS_LOADING = 1, LS_DONE = 2, LS_RELEASED = 3 }
local v29 = { mSlotLoader = nil, mSelectionLoader = nil, mPreviewLoader = nil }
local v30 = false
local v31 = false
local v32 = {}
local v35 = false
local v36 = nil
local v37 = nil
local flag2 = false
local v38 = nil
local v39 = nil
local v40 = 0
local v41 = Vector(-0.1, -0.1, -0.15)
local flag3 = false
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.StoreItemUtilities")
local module4 = require("SF.Scripts.SFCinematics")
local module5 = require("SF.Interface.SFUtilities")
local module6 = require("SF.Interface.Libs.UIUtilities")
local module7 = require("SF.Interface.Libs.StatsUtil")
local module8 = require("EE.Interface.AnchorMgr")
local module9 = require("SF.Scripts.Libs.SparrowLib")
local module10 = require("Lotus.Interface.Components.RadialText")
local module11 = require("SF.Interface.Components.Button")
local asyncLoader = module6.CreateAsyncLoader()
local v42 = nil
local v43 = nil
local v44 = nil
local v45 = nil
local v46 = nil
local v47 = nil
local v48 = nil
local flag4 = false
local v49 = false
local v50 = false
local v51 = nil
local v52 = { x = 0, y = 0 }
v52.x = 0
v52.y = 0
local v53 = { x = 0, y = 0 }
v53.x = 0
v53.y = 0
local v54 = 0
local v55 = WeakResource("/SF/Souls/Common/SFIdolMod")
local fn
local fn2
local fn3
local fn4
local fn5
local fn6
local v56 = nil
local v57 = nil
local v58 = nil
local v59 = nil
local v60 = nil

local function fn7(value)
	local v61 = {}
	local v62 = 1

	for k in string.gmatch(value, "%S+") do
		assert(not v61[k])
		v61[k] = v62
		v62 += 1
	end

	v61.MAX_Value = v62
	return (setmetatable(v61, {
		__newindex = function()
			error("Attempting to add to enum")
		end,
		__index = function()
			error("Attempting to access invalid enum")
		end
	}))
end

local v61 = fn7("    PACT\n    MELEE\n    CHEST\n    LEGS\n    SECONDARY\n    HELM\n    IDOL\n    TOTEM\n    SKILLS\n    GUIDE\n    VIRTUEGEM\n")
local v62 = fn7("    VIRTUES\n    PACT\n    SOULS\n")
local v63 = {
	SUIT = { LoadOutType = 0, LoadOutId = 0, StoreItemId = 3 },
	MELEE = { LoadOutType = 0, LoadOutId = 3, StoreItemId = 5 },
	SECONDARY = { LoadOutType = 0, LoadOutId = 2, StoreItemId = 1 }
}
local v64 = {
	{ Clip = "Virtues", Bone = Symbol("GAME_C1_ROOT"), Pos = Vector(-0.3, 1.65, 0) },
	{ Clip = "Pact", Bone = Symbol("GAME_C1_ROOT"), Pos = Vector(0.3, 1.15, 0) },
	{ Clip = "Souls", Bone = Symbol("GAME_C1_SPINE5"), Pos = Vector(-0.15, 0.05, 0) },
	{ Clip = "MeleePicker", Bone = Symbol("GAME_C1_SPINE1"), Pos = Vector(-0.34, -0.2, 0) },
	{ Clip = "ChestPicker", Bone = Symbol("GAME_C1_SPINE5"), Pos = Vector(-0.35, 0.14, 0) },
	{ Clip = "LeggingsPicker", Bone = Symbol("GAME_C1_SPINE1"), Pos = Vector(0.15, -0.18, 0) },
	{ Clip = "RangedPicker", Bone = Symbol("GAME_C1_SPINE1"), Pos = Vector(-0.3, 0.03, 0) },
	{ Clip = "HelmPicker", Bone = Symbol("GAME_C1_HEAD1"), Pos = Vector(0.1, 0.07, 0) },
	{ Clip = "IdolPicker", Bone = Symbol("GAME_C1_HEAD1"), Pos = Vector(0.1, -0.3, 0) },
	{ Clip = "GuidePicker", Bone = Symbol("GAME_C1_HEAD1"), Pos = Vector(0.25, -0.125, 0) }
}
local v65 = { "Courage", "Spirit", "Grace" }
local v66 = {}
local manifest = Resource("/Lotus/Types/Game/Store/ProductsManifest")
local v68 = nil
local v69 = nil
local v70 = { nil, nil }
v70[1], v70[2] = 0, 0
local v71 = nil
local v72 = nil
local flag5 = false
local mFadeUnownedItems = false
local itemCategory = nil
local v74 = nil
local v75 = nil
local topMenuOpen = false
local sparrowCourageVirtueAnim2 = nil
local v76 = { [0] = 9450805, [2] = 4482163, [1] = 6124631 }
local v77 = { [0] = 8083003, [2] = 4014418, [1] = 6253660 }
local v78 = __wf_atom_10cd16b2(0, 0.15)
local heading = 0
local v79 = 0
local v80 = 0
local v81 = 0
local flag6 = false
local v82 = true
local v83 = {
	{ "ExtremeCourageDistribution", "VesperExtremeWrathDistribution", Vector(15, 1, 1) },
	{ "ExtremeSpiritDistribution", "VesperExtremeDeathDistribution", Vector(1, 15, 1) },
	{ "ExtremeGraceDistribution", "VesperExtremeDoomDistribution", Vector(1, 1, 15) },
	{ "StarterCourageDistribution", "VesperStarterWrathDistribution", Vector(4, 3, 3) },
	{ "StarterSpiritDistribution", "VesperStarterDeathDistribution", Vector(3, 4, 4) },
	{ "StarterGraceDistribution", "VesperStarterDoomDistribution", Vector(3, 3, 4) },
	{ "MildCourageGraceDistribution", "VesperMildWrathDoomDistribution", Vector(4, 1, 4) },
	{ "MildCourageSpiritDistribution", "VesperMildWrathDeathDistribution", Vector(4, 4, 1) },
	{ "MildSpiritGraceDistribution", "VesperMildDeathDoomDistribution", Vector(1, 4, 4) },
	{ "CentralDistribution", "VesperCentralDistribution", Vector(1, 1, 1) }
}

local function fn8(p)
	if p == nil or p.Type == nil then
		return false
	end

	return p.Type:IsA(__wf_atom_9df43583) and not p.Type:IsA(__wf_atom_d98e64fe)
end

local function fn9()
	return v51 == "Corrupted"
end

local function fn10(p, p2)
	mMovie:__wf_atom_48bd5a59(p, "Label", 36, Localize(p2, false))
	mMovie:OverrideMaterial(p .. ".Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(p .. ".Bg", "RectInnerColor", v15.Inner.r, v15.Inner.g, v15.Inner.b, 1)
	mMovie:__wf_atom_1ca72041(p .. ".Bg", "RectEdgeColor", v15.Edge.r, v15.Edge.g, v15.Edge.b, 1)
	local v84 = mMovie:__wf_atom_cfc41e35(p, "Label", 40) + 16
	mMovie:__wf_atom_4c1c1986(p, "Bg", 14, v84)
	mMovie:__wf_atom_4c1c1986(p, "LeftCap", 0, -(v84 / 2) - 12)
	mMovie:__wf_atom_4c1c1986(p, "RightCap", 0, v84 / 2 + 12)
	mMovie:__wf_atom_e57658c2(p, 12, 0)
end

local function fn11()
	local v84 = fn9()

	for k, v85 in v64 do
		local clip = v85.Clip

		if v85.Special then
			if v84 then
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Backer", equipGridBackerTextures[4])
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Icon", corruptNodeIconTextures[k])
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Leaves", equipGridFrameTextures[2])
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Dots", equipGridDotsTextures[2])
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Glow", equipGridGlowTextures[3])
			else
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Backer", equipGridBackerTextures[1])
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Icon", nodeIconTextures[k])
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Leaves", equipGridFrameTextures[1])
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Dots", equipGridDotsTextures[1])
				mMovie:__wf_atom_c90af43a(clip .. ".Hover.Glow", equipGridGlowTextures[1])
			end

			mMovie:__wf_atom_7f57ab2f(clip, "Hover.OuterRing", 13, not v84)
		end

		mMovie:__wf_atom_7f57ab2f(clip, "Hover.Rays", 13, false)
		mMovie:__wf_atom_7f57ab2f(clip, "Hover.FxSlotFront", 13, false)
		mMovie:__wf_atom_7f57ab2f(clip, "Hover.FxSlotBack", 13, false)
		mMovie:__wf_atom_4c1c1986(clip, "Details.Item1", 5, 85)
		mMovie:__wf_atom_4c1c1986(clip, "Details.Item1", 6, 85)
		mMovie:__wf_atom_4c1c1986(clip, "Details.Item1", 12, 85)
		mMovie:__wf_atom_4c1c1986(clip, "Hover", 5, 26.25)
		mMovie:__wf_atom_4c1c1986(clip, "Hover", 6, 26.25)
		mMovie:__wf_atom_4c1c1986(clip, "Hover", 12, 85)
		local mMovie = mMovie
		local v88

		if v84 then
			v88 = _G.UIColor_LightGrey
		else
			v88 = _G.UIColor_Yellow
		end

		mMovie:__wf_atom_4c1c1986(clip, "Label.Label", 11, v88)
	end

	local v85 = "/SF/Language/Pacts/Virtues"

	if v84 then
		v85 ..= "Corrupted"
	end

	fn10("Virtues.Label", v85)

	if v84 and v12 ~= nil then
		mMovie:__wf_atom_2dedec1a("Pact.Hover.FxSlotFront", 13, v84)
		mMovie:__wf_atom_2dedec1a("Pact.Hover.FxSlotBack", 13, v84)
		v60 = module.CreateUIParticles(mMovie, "Pact.Hover.FxSlotFront", frontIconFx)
	end
end

local function fn12(p)
	flag6 = false
	mMovie:PushChildMovie(p)
end

local function fn13()
	local screenDimensions, v84 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, v84)
	mMovie:__wf_atom_e57658c2("CorruptedVignette", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("CorruptedVignette", 15, v84)
end

local function fn14(p, p2)
	local v84 = Resource("/SF/Interface/Materials/ItemQualityBorderMaterial")
	local v85 = { pactBannerMaterial, v84 }
	module.ScaleSlicedMaterials(mMovie, v85)
	module5.ScaleBackerToViewport(mMovie, "InventoryContainer.Bg")

	if v43 ~= nil then
		v43:Update(p, p2)
	end

	if v72 ~= nil then
		v72:UpdateHeight(nil, true)
		v72:RefreshCategory()
	end

	fn13()
end

function onViewportSizeChanged(p, p2)
	fn14(p, p2)
end

local function fn15(p, p2)
	statOwner:CameraControl():__wf_atom_fd14c463(1)
	statOwner:CameraControl():SetCameraSpot(p, p2)
end

local function fn16(fn17, mClearedCallback)
	return {
		mResLoader = nil,
		mState = v28.LS_NONE,
		mCallback = fn17,
		mClearedCallback = mClearedCallback,
		mItems = nil,
		Load = function(self, mItems, p)
			self.mItems = mItems
			self.mResLoader = UISys.__wf_atom_c0dbe47c(mItems, p)
			self.mState = v28.LS_LOADING
		end,
		Update = function(state)
			if state.mState == v28.LS_LOADING then
				if __wf_atom_7e8ad928(state.mResLoader) then
					state.mState = v28.LS_NONE
				elseif state.mResLoader:__wf_atom_86399a47() then
					local mItems = {}

					for _, mItem in ipairs(state.mItems) do
						table.insert(mItems, Type(mItem))
					end

					state.mItems = mItems
					state.mState = v28.LS_DONE

					if state.mCallback ~= nil then
						state.mCallback(state)
					end
				end
			end
		end,
		Release = function(self)
			if not __wf_atom_7e8ad928(self.mResLoader) then
				self.mState = v28.LS_RELEASED
				self.mItems = nil
				self.mResLoader:Abort()

				if self.mClearedCallback ~= nil then
					self.mClearedCallback(self)
				end
			end
		end,
		Pin = function(self, mItems)
			if self.mState == v28.LS_DONE then
				self.mItems = mItems
			end
		end
	}
end

local function fn17()
	return gRegion:IsMaster() and 3 or 4
end

local function fn18(p, p2, p3, p4)
	local v84 = math.floor(0.5 + __wf_atom_104bfe98(p3, p4, p2))
	v66[p] = v84
	__wf_atom_86cbd68d(mMovie, p .. ".gotoAndStop", v84)
end

local function fn19(weaponToUpgrade)
	if __wf_atom_7e8ad928(weaponToUpgrade) or flag then
		return
	end

	flag = true
	module.PlaySound(_G.UISound_Select)
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil

	function _T.OnReturnToArsenal(p)
		if __wf_atom_7e8ad928(mMovie) then
			return
		end

		if flag5 then
			fn15(v3, 0.25)
		else
			fn15(v, 0.25)
		end

		module5.DissolveIn(mMovie)
		v50 = false

		if p then
			if not __wf_atom_7e8ad928(_T.WeaponToUpgrade) then
				if flag5 then
					local v84 = v7[0]
					local v85 = nil

					if itemCategory == v61.MELEE then
						v85 = v84:__wf_atom_b369d77f(3)
					elseif itemCategory == v61.SECONDARY then
						v85 = v84:__wf_atom_b369d77f(2)
					end

					if v85 ~= nil and _T.WeaponToUpgrade.Selected then
						fn(itemCategory, _T.WeaponToUpgrade, arsenalAvatar)
					end
				else
					fn(_T.WeaponToUpgrade.ItemCategory, _T.WeaponToUpgrade, arsenalAvatar)
				end
			end

			ApplyVirtueGem(mAttributeItem)
			fn2()
			fn3(arsenalAvatar)
			fn4()
			v30 = true
			fn5()
		end

		_T.WeaponToUpgrade = nil
		_T.ArsenalAvatar = nil
		flag = false

		if not __wf_atom_7e8ad928(v72) then
			v72.mScrollBar:ResizeVisRangeMaterials()
		end
	end

	module5.DissolveOut(mMovie)

	if __wf_atom_72884638("SF.UseOldModSlots", false) then
		_T.WeaponToUpgrade = weaponToUpgrade.StoreItem
		fn12(weaponUpgradesMovie)
	else
		_T.WeaponToUpgrade = weaponToUpgrade
		_T.ArsenalAvatar = arsenalAvatar
		fn12(moteUpgradesMovie)
	end

	v50 = true
end

local function fn20(p)
	if p == v61.MELEE then
		return "MeleePicker"
	end

	if p == v61.CHEST then
		return "ChestPicker"
	end

	if p == v61.LEGS then
		return "LeggingsPicker"
	end

	if p == v61.SECONDARY then
		return "RangedPicker"
	end

	if p == v61.HELM then
		return "HelmPicker"
	end

	if p == v61.TOTEM then
		return "IdolPicker"
	end

	if p == v61.GUIDE then
		return "GuidePicker"
	end

	return ""
end

local function fn21(p)
	if p == v62.VIRTUES then
		return "Virtues"
	end

	if p == v62.PACT then
		return "Pact"
	end

	if p == v62.SOULS then
		return "Souls"
	end

	return ""
end

local function fn22(p)
	if p == nil then
		return nil
	end

	if p < v62.MAX_Value then
		return fn21(p)
	end

	return fn20(p - v62.MAX_Value)
end

local function fn23(value, p)
	if p then
		mMovie:__wf_atom_7f57ab2f(value, "Details", 67, false)
		__wf_atom_ec43d06e(mMovie, value .. ".Details", 0, { 12 }, { 0 }, 0.5, 0)
	end

	__wf_atom_ec43d06e(mMovie, value .. ".Label", 0, { 12 }, { 0 }, 0.5, 0)
	mMovie:__wf_atom_7f57ab2f(value, "Hover.OuterRing", 13, false)
	mMovie:__wf_atom_7f57ab2f(value, "Hover.Rays", 13, false)
	mMovie:__wf_atom_7f57ab2f(value, "Hover.FxSlotFront", 13, false)
	mMovie:__wf_atom_7f57ab2f(value, "Hover.FxSlotBack", 13, false)
	mMovie:__wf_atom_7f57ab2f(value, "Details.Item1.Rays", 13, false)
	mMovie:__wf_atom_7f57ab2f(value, "Details.Item1.Box", 13, false)
	__wf_atom_ec43d06e(mMovie, value .. ".Details.Item1", 0, { 5, 6, 12 }, { 85, 85, 85 }, 0.34)
	__wf_atom_ec43d06e(mMovie, value .. ".Hover", 0, {
		5,
		6,
		12,
		function(p2)
			fn18(value .. ".Hover", p2, 20, 9)
		end
	}, { 26.25, 26.25, 85, 1 }, 0.34)
	EquipmentGridItemUnfocused()
	module.PlaySound(_G.UISound_Unfocus)

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("NIGHTFOLD_MENU_TIME"), "CHARACTER_" .. string.upper(value))
	end
end

local function fn24()
	local v84 = fn9()
	local v85 = "/SF/Language/Pacts/Virtues"

	if v84 then
		v85 ..= "Corrupted"
	end

	local v86 = Localize(v85, false)
	local name

	if v84 then
		name = mMovie:__wf_atom_8e9ac384(v86 .. "<WRATH_ICON><DEATH_ICON><DOOM_ICON>", true)
	else
		name = mMovie:__wf_atom_8e9ac384(v86 .. "<COURAGE_ICON><SPIRIT_ICON><GRACE_ICON>", true)
	end

	local infoPopup_Data = {
		CustomEntry = true,
		TopLeftAligned = false,
		Name = name,
		LocalizedDesc = mMovie:__wf_atom_8e9ac384(v85 .. "Desc", true),
		Rect = { X = -0.02, Y = 0.2, W = 0.07135, H = 0.1269 },
		BottomAnchor = false
	}
	_T.InfoPopup_Data = infoPopup_Data
end

local function fn25(p, p2)
	local v84 = p .. ".Details.MagicksButton"
	local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8(v84, 67)

	if p2 == nil then
		p2 = __wf_atom_a91463a8
	end

	local v85 = mMovie:__wf_atom_bd8fa442(v84, "Button.Alert", 13) and true or p2

	if v85 ~= __wf_atom_a91463a8 then
		if v85 then
			mMovie:__wf_atom_2dedec1a(v84, 67, false)
			__wf_atom_ec43d06e(mMovie, v84, 8, { 12 }, { 75 }, 0.25)
			__wf_atom_ec43d06e(mMovie, v84 .. ".Button", 8, { 0 }, { 48 }, 0.25, 0, function()
				mMovie:__wf_atom_2dedec1a(v84, 67, true)
			end)
		else
			__wf_atom_ec43d06e(mMovie, v84, 8, { 12 }, { 0 }, 0.25)
			__wf_atom_ec43d06e(mMovie, v84 .. ".Button", 8, { 0 }, { 70 }, 0.25)
			mMovie:__wf_atom_2dedec1a(v84, 67, false)
		end
	end
end

local function fn26(value, p, p2)
	if flag or flag4 then
		return false
	end

	if v12 ~= nil and v12 ~= p then
		local v84 = v12 < 4
		local v85 = fn22(v12)
		fn23(v85, v84)
		fn25(v85, false)
	end

	mMovie:__wf_atom_7f57ab2f(value, "Details", 67, true)
	__wf_atom_ec43d06e(mMovie, value .. ".Details", 0, { 12 }, { 100 }, 0.3)
	__wf_atom_ec43d06e(mMovie, value .. ".Label", 0, { 12 }, { 100 }, 0.3)
	local corruptEdgeTexture2

	if fn9() then
		corruptEdgeTexture2 = corruptEdgeTexture
	else
		corruptEdgeTexture2 = catLabelEdgeTexture
	end

	mMovie:__wf_atom_c90af43a(value .. ".Label.LeftCap", corruptEdgeTexture2)
	mMovie:__wf_atom_c90af43a(value .. ".Label.RightCap", corruptEdgeTexture2)
	local v84 = fn9()
	__wf_atom_86cbd68d(mMovie, value .. ".Hover.gotoAndStop", "Active")
	mMovie:__wf_atom_7f57ab2f(value, "Hover.OuterRing", 13, not v84)
	mMovie:__wf_atom_7f57ab2f(value, "Hover.Rays", 13, not v84)
	mMovie:__wf_atom_7f57ab2f(value, "Hover.FxSlotFront", 13, v84)
	mMovie:__wf_atom_7f57ab2f(value, "Hover.FxSlotBack", 13, v84)
	mMovie:__wf_atom_7f57ab2f(value, "Details.Item1.Rays", 13, true)
	mMovie:__wf_atom_7f57ab2f(value, "Details.Item1.Box", 13, not v84)
	local mMovie2 = mMovie
	local v85 = value .. ".Hover.Glow"
	local v86

	if v84 then
		v86 = equipGridGlowTextures[3]
	else
		v86 = equipGridGlowTextures[1]
	end

	mMovie2:__wf_atom_c90af43a(v85, v86)
	mMovie:__wf_atom_933bbce0(value .. ".Hover.FxSlotFront", fxSlotFrontTexture, fxSlotFrontMaterial)
	mMovie:__wf_atom_933bbce0(value .. ".Hover.FxSlotBack", fxSlotBackTexture, fxSlotBackMaterial)

	if not __wf_atom_7e8ad928(v60) then
		v60:Destroy()
		v60 = nil
	end

	if v84 then
		v60 = module.CreateUIParticles(mMovie, value .. ".Hover.FxSlotFront", frontIconFx)
	end

	__wf_atom_ec43d06e(mMovie, value .. ".Details.Item1", 0, { 5, 6, 12 }, { 110, 110, 100 }, 0.34)
	__wf_atom_ec43d06e(mMovie, value .. ".Hover", 0, {
		5,
		6,
		12,
		function(p3)
			fn18(value .. ".Hover", p3, 10, 20)
		end
	}, { 35, 35, 100, 1 }, 0.34)
	v12 = p
	EquipmentGridItemFocused()

	if not p2 then
		module.PlaySound(_G.UISound_GridOpen)
	end

	if not __wf_atom_7e8ad928(v6) then
		local v87 = value .. ".Hover"
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v87, 2)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v87, 3)
		local convertToScreenPosition = module.ConvertToScreenPosition(
			mMovie,
			Vector(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2, 0)
		)
		local __wf_atom_92d75093 = v6:__wf_atom_92d75093()
		v53 = {
			x = __wf_atom_92d75093.x - convertToScreenPosition.x,
			y = __wf_atom_92d75093.y - convertToScreenPosition.y
		}
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("NIGHTFOLD_MENU_OPEN"), "CHARACTER_" .. string.upper(value))
		__wf_atom_21342f4a:StartTimer(Symbol("NIGHTFOLD_MENU_TIME"), "CHARACTER_" .. string.upper(value))
		v38 = string.upper(value)
	end

	return true
end

function VirtuesRollOver()
	if not fn26("Virtues", v62.VIRTUES) then
		return
	end

	v70 = { 7, -3, "Virtues" }
	fn24()

	if v12 ~= nil and v12 == v62.VIRTUES then
		return
	end

	module6.StopClipPulse(mMovie, "Virtues.Hover", 26)
	v49 = false
end

function VirtuesRollOut()
	_T.InfoPopup_Data = nil

	if flag4 and v70[3] ~= "Virtues" and not v49 then
		v49 = true
		module6.StartClipPulse(mMovie, "Virtues.Hover", 26, 29, 0.5)
	end

	fn23("Virtues")
end

function VirtuesClick() end

function PactRollOver()
	if __wf_atom_7e8ad928(arsenalAvatar) or not fn26("Pact", v62.PACT) then
		return
	end

	UpdateUnspentPactPoints()
	module.PlaySound(v69)
	arsenalAvatar:Attach(v68, EMPTY_SYMBOL)
	v70 = { -7, 1.5, "Pact" }
end

function PactRollOut()
	fn23("Pact")
end

function PactClick() end

function SoulsRollOver()
	if not fn26("Souls", v62.SOULS) then
		return
	end

	module.PlaySound(soulsFocusSound)
	v70 = { 4, -1, "Souls" }
end

function SoulsRollOut()
	fn23("Souls")
end

function SoulsClick() end

function VirtueClick(_) end

function FadeToNeutral(object)
	local color = object:GetColor()
	local v84 = 0

	while v84 < 1 do
		v84 = __wf_atom_421b01aa(v84 + __wf_atom_084b3e93(), 0, 1)
		object:SetColor((color:__wf_atom_104bfe98(Color(255, 255, 255), v84 * 0.5)))
		Sleep(0)
	end
end

function VirtueGemClick() end

function VirtueGemRollOver()
	mMovie:__wf_atom_e57658c2("Virtues.Details.GemMist", 14, 710)
	mMovie:__wf_atom_e57658c2("Virtues.Details.GemMist", 15, 710)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.BackerLayer", 8, { 12 }, { 80 }, 0.3)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.GemMist", 8, { 12 }, { 100 }, 0.3)
	module.PlaySound(virtueGemRollOverSound)
end

function VirtueGemRollOut()
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.BackerLayer", 8, { 12 }, { 40 }, 0.3)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.GemMist", 8, { 12 }, { 0 }, 0.3)
end

function VirtueTipRollOver(p, _)
	local v84 = "Virtues.Details." .. v65[p] .. "Tip"
	__wf_atom_ec43d06e(mMovie, v84, 0, { 12 }, { 100 }, 0.5, 0)
end

function VirtueTipRollOut(p)
	local v84 = "Virtues.Details." .. v65[p] .. "Tip"
	__wf_atom_ec43d06e(mMovie, v84, 0, { 12 }, { 0 }, 0.5, 0)
end

function MotesRollOver(p)
	local v84 = fn20(p) .. ".Details.MagicksButton.Button"

	if not mMovie:__wf_atom_a91463a8(fn20(p) .. ".Details.MagicksButton", 67) then
		return
	end

	__wf_atom_ec43d06e(mMovie, v84, 8, { 5, 6 }, { 110, 110 }, 0.25)
	__wf_atom_ec43d06e(mMovie, v84 .. ".Glow", 8, { 12 }, { 100 }, 0.25)
	__wf_atom_ec43d06e(mMovie, fn20(p) .. ".Details.MagicksButton", 8, { 12 }, { 100 }, 0.25)
	module.PlaySound(motesRolloverSound)
	local infoPopup_Data = v18[p]

	if __wf_atom_7e8ad928(infoPopup_Data) then
		_T.gToolTip = "<p><font color=\"" .. v16.SwapMotes .. "\">" .. mMovie:__wf_atom_8e9ac384(
			"/SF/Language/Menu/Weapon_Swap_Motes",
			false
		) .. "</font></p>"
		return
	end

	module6.SetItemInfoPopupRect(
		mMovie,
		infoPopup_Data,
		mMovie:__wf_atom_5e6e15c8(v84, 2),
		mMovie:__wf_atom_5e6e15c8(v84, 3),
		mMovie:__wf_atom_5e6e15c8(v84, 14),
		mMovie:__wf_atom_5e6e15c8(v84, 15)
	)
	_T.InfoPopup_Data = infoPopup_Data
end

function MotesRollOut(p)
	local v84 = fn20(p) .. ".Details.MagicksButton.Button"
	__wf_atom_ec43d06e(mMovie, v84, 8, { 5, 6 }, { 100, 100 }, 0.25)
	__wf_atom_ec43d06e(mMovie, v84 .. ".Glow", 8, { 12 }, { 0 }, 0.25)
	__wf_atom_ec43d06e(mMovie, fn20(p) .. ".Details.MagicksButton", 8, { 12 }, { 75 }, 0.25)
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
end

function MotesPressed(p)
	local mElement = v17[p].mElements[1]

	if __wf_atom_7e8ad928(mElement) or __wf_atom_7e8ad928(mElement.RawItem) then
		return
	end

	fn19(mElement)
	MotesRollOut(p)
end

function FadeToFire(object)
	local color = object:GetColor()
	local v84 = 0

	while v84 < 1 do
		v84 = __wf_atom_421b01aa(v84 + __wf_atom_084b3e93(), 0, 1)
		object:SetColor((color:__wf_atom_104bfe98(Color(255, 155, 57), v84)))
		Sleep(0)
	end
end

local function fn27(p, p2, p3, p4)
	__wf_atom_86cbd68d(mMovie, "Virtues.Details." .. p .. "Fill.gotoAndStop", p3)
	local v84 = math.floor(p2 + 0.5)
	math.floor(p3 + 0.5)

	if p4 and p4 ~= 0 then
		p4 = "+" .. math.floor(p4 + 0.5)
	end

	local uiColor_LightGrey

	if fn9() then
		uiColor_LightGrey = _G.UIColor_LightGrey
	else
		uiColor_LightGrey = _G.UIColor_Grey
	end

	if p == "Life" then
		mMovie:__wf_atom_e57658c2("Virtues.Details." .. "Life", 36, v84)
		mMovie:__wf_atom_e57658c2("Virtues.Details." .. "Life", 11, uiColor_LightGrey)
		mMovie:__wf_atom_2dedec1a("Virtues.Details." .. "Life" .. "Bonus", 13, false)
	else
		mMovie:__wf_atom_e57658c2("Virtues.Details." .. p .. ".Value", 36, v84)
		mMovie:__wf_atom_e57658c2("Virtues.Details." .. p .. ".Value", 44, uiColor_LightGrey)
		mMovie:__wf_atom_2dedec1a("Virtues.Details." .. p .. ".Bonus", 13, false)
	end
end

function ApplyVirtueGem(mAttributeItem2)
	if mAttributeItem2 ~= nil then
		local v84 = v7[0]
		v84.mAttributeItem = mAttributeItem2
		inventory:__wf_atom_337fac69(0, v84)
		gGameData:__wf_atom_efd6bfce(0, v84)
		fn3(arsenalAvatar)
		fn4()
	end
end

function UpdateUnspentPactPoints()
	if __wf_atom_7e8ad928(arsenalAvatar) then
		return
	end

	local __wf_atom_d2b2176d = arsenalAvatar:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	_T.ArsenalPact = __wf_atom_e55d02aa
	asyncLoader:LoadResource("SkillTreePactPoints", __wf_atom_e55d02aa:__wf_atom_c45b4ac3(), function(p)
		local v84 = Resource(p)

		if
			__wf_atom_7e8ad928(__wf_atom_d2b2176d)
			or __wf_atom_7e8ad928(arsenalAvatar)
			or __wf_atom_7e8ad928(mMovie)
		then
			return
		end

		local __wf_atom_dfb755f8 = __wf_atom_d2b2176d:__wf_atom_dfb755f8(v84)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/SystemMessages/UpgradePact", false)
		local v85 = module5.AreUpgradesAvailableForSkillTree(
				__wf_atom_d2b2176d,
				v84,
				__wf_atom_d2b2176d:__wf_atom_dfb755f8(v84)
			)
			and true
			or false
		mMovie:__wf_atom_2dedec1a("Pact.Hover.Alert", 13, v85)

		if not __wf_atom_7e8ad928(v44) then
			if v85 then
				v44:SetIcon(pointsPipIcon, 42, 0, 0)
				v44:SetIconText(tostring(__wf_atom_dfb755f8), 19, 2825751)
			else
				v44:SetIcon(nil)
			end

			v44:SetText(__wf_atom_8e9ac384)
		end
	end)
end

function VirtueControlFocused(_, p)
	if not flag4 then
		return
	end

	__wf_atom_ec43d06e(mMovie, p, 2, { 5, 6 }, { 110, 110 }, 0.3)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.BackerLayer", 8, { 12 }, { 80 }, 0.3)
	module6.StopClipPulse(mMovie, "Virtues.Details.VirtueControl", 100)
end

function VirtueControlUnfocused(p, p2)
	if not flag4 then
		return
	end

	__wf_atom_ec43d06e(mMovie, p2, 2, { 5, 6 }, { 100, 100 }, 0.3)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.BackerLayer", 8, { 12 }, { 40 }, 0.3)

	if flag3 then
		VirtueControlReleased(p, p2)
	end

	module6.StartClipPulse(mMovie, "Virtues.Details.VirtueControl", 100, 120, 0.5)
end

local v84 = nil

function ApplyVirtueChanges()
	local v85 = v7[0]
	inventory:__wf_atom_337fac69(0, v85)
	OnEquipVirtueGem(v85.mAttributeItem)
	gGameData:__wf_atom_efd6bfce(0, v85)
	fn3(arsenalAvatar)
	mAttributeItem = v85.mAttributeItem
	fn4()
	fn6(true)
	v35 = v32.mAttributeConfigU ~= v85.mAttributeConfigU or v32.mAttributeConfigV ~= v85.mAttributeConfigV
	v46:SetActive(v35)
end

function VirtueControlReleased(_, _)
	if not flag4 then
		return
	end

	flag3 = false
	ApplyVirtueChanges()

	if not __wf_atom_7e8ad928(v84) then
		v84:Stop(false)
	end
end

function VirtueControlPressed(_, _)
	if not flag4 then
		return
	end

	flag3 = true
	module.PlaySound(virtueGemDynamicPressedSound)

	if not __wf_atom_7e8ad928(virtueGemDynamicPressedHoldSound) and __wf_atom_7e8ad928(v84) then
		v84 = module.PlaySound(virtueGemDynamicPressedHoldSound)
	end
end

local v85 = nil
local v86 = nil
local v87 = 0
local v88 = 0
local v89 = 0

local function fn28(data)
	local v90 = Vector(data.mAttributeConfigU, data.mAttributeConfigV, 0)
	local v91 = 1 - v90.x - v90.y
	local v92 = {
		Vector(
			mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueSpirtMarker", 0),
			mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueSpirtMarker", 1),
			0
		),
		Vector(
			mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueCourageMarker", 0),
			mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueCourageMarker", 1),
			0
		),
		(Vector(
			mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueGraceMarker", 0),
			mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueGraceMarker", 1),
			0
		))
	}

	if fn9() then
		local v93 = v92[3]
		local v94 = v92[2]
		v92[2] = v93
		v92[3] = v94
	end

	local v93 = v92[1].x * v90.x + v92[3].x * v90.y + v92[2].x * v91
	local v94 = v92[1].y * v90.x + v92[3].y * v90.y + v92[2].y * v91
	mMovie:__wf_atom_e57658c2("Virtues.Details.VirtueControl", 0, v93)
	mMovie:__wf_atom_e57658c2("Virtues.Details.VirtueControl", 1, v94)
	local v95 = 1 - math.max(math.max(v90.x, v90.y), v91)
	local v96 = Vector(v90.x, v90.y, v91)
	local v97 = v96 * v96
	Normalize(v97)
	local v98, v99, v100

	if fn9() then
		v98 = 10773740
		v99 = 11450828
		v100 = 16766759
	else
		v98 = 16716825
		v99 = 7602022
		v100 = 3381759
	end

	local HEX2RGB = module.HEX2RGB(v98)
	local v101 = Vector(HEX2RGB.r, HEX2RGB.g, HEX2RGB.b) / 255
	local HEX2RGB2 = module.HEX2RGB(v99)
	local v102 = Vector(HEX2RGB2.r, HEX2RGB2.g, HEX2RGB2.b) / 255
	local HEX2RGB3 = module.HEX2RGB(v100)
	local v103 = Vector(HEX2RGB3.r, HEX2RGB3.g, HEX2RGB3.b) / 255 * v97.y + v102 * v97.x + v101 * v97.z
	mMovie:__wf_atom_1ca72041("Virtues.Details.VirtueControl.CombinedFlare", "TintColor", v103.x, v103.y, v103.z, 1)
	mMovie:__wf_atom_e57658c2("Virtues.Details.VirtueControl.CombinedFlare", 12, 100)
	mMovie:__wf_atom_e57658c2("Virtues.Details.DynamicPrism.CombinedLines", 12, v95 * 100)
	mMovie:__wf_atom_e57658c2("Virtues.Details.DynamicPrism.CourageLines", 12, 100 * v97.z)
	mMovie:__wf_atom_e57658c2("Virtues.Details.DynamicPrism.SpiritLines", 12, 100 * v97.x)
	mMovie:__wf_atom_e57658c2("Virtues.Details.DynamicPrism.GraceLines", 12, 100 * v97.y)
	local v104 = Resource(data.mAttributeItem)
	local __wf_atom_f7423942 = __wf_atom_c67f9605:__wf_atom_f7423942(gGameData:__wf_atom_d5bed0b3())
	local __wf_atom_e3a1a628, v105, v106 = v104:__wf_atom_e3a1a628(
		SF.__wf_atom_edd3fb68 + __wf_atom_f7423942 + statOwner:__wf_atom_4ad84724(),
		data.mAttributeConfigU,
		data.mAttributeConfigV
	)

	if __wf_atom_e3a1a628 ~= v87 or v105 ~= v88 or v106 ~= v89 then
		local v107 = __wf_atom_e3a1a628 + 1
		local v108 = v105 + 1
		local v109 = v106 + 1
		v87 = v107
		v88 = v108
		v89 = v109
		local v110 = v107 + v108 + v109
		local attribute = arsenalAvatar:GetAttribute(0, false)
		local attribute2 = arsenalAvatar:GetAttribute(1, false)
		local attribute3 = arsenalAvatar:GetAttribute(2, false)
		fn27("Courage", v107, v107 / v110 * 100, v107 - attribute)
		fn27("Spirit", v108, v108 / v110 * 100, v108 - attribute2)
		fn27("Grace", v109, v109 / v110 * 100, v109 - attribute3)
		mMovie:__wf_atom_e57658c2("Virtues.Details.Courage", 5, 120)
		mMovie:__wf_atom_e57658c2("Virtues.Details.Courage", 6, 120)
		__wf_atom_ec43d06e(mMovie, "Virtues.Details.Courage", 2, { 5, 6 }, { 100, 100 }, 0.3)
		mMovie:__wf_atom_e57658c2("Virtues.Details.Spirit", 5, 120)
		mMovie:__wf_atom_e57658c2("Virtues.Details.Spirit", 6, 120)
		__wf_atom_ec43d06e(mMovie, "Virtues.Details.Spirit", 2, { 5, 6 }, { 100, 100 }, 0.3)
		mMovie:__wf_atom_e57658c2("Virtues.Details.Grace", 5, 120)
		mMovie:__wf_atom_e57658c2("Virtues.Details.Grace", 6, 120)
		__wf_atom_ec43d06e(mMovie, "Virtues.Details.Grace", 2, { 5, 6 }, { 100, 100 }, 0.3)
	end
end

function UpdateVirtueControl(_)
	if not flag3 then
		return
	end

	v85 = {}
	v86 = {}
	v85[1] = Vector(
		mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueSpirtMarker", 2),
		mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueSpirtMarker", 3),
		0
	)
	v85[2] = Vector(
		mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueCourageMarker", 2),
		mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueCourageMarker", 3),
		0
	)
	v85[3] = Vector(
		mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueGraceMarker", 2),
		mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtueGraceMarker", 3),
		0
	)

	if fn9() then
		local v90 = v85
		local v91 = v85
		local v92 = v85[3]
		local v93 = v85[2]
		v90[2] = v92
		v91[3] = v93
	end

	v86[1] = {
		n = __wf_atom_edfe0d73(v85[1] - v85[2], Vector(0, 0, 1))
	}
	Normalize(v86[1].n)
	v86[1].w = Dot(v86[1].n, v85[1]) - 2
	v86[2] = {
		n = __wf_atom_edfe0d73(v85[2] - v85[3], Vector(0, 0, 1))
	}
	Normalize(v86[2].n)
	v86[2].w = Dot(v86[2].n, v85[2]) - 2
	v86[3] = {
		n = __wf_atom_edfe0d73(v85[3] - v85[1], Vector(0, 0, 1))
	}
	Normalize(v86[3].n)
	v86[3].w = Dot(v86[3].n, v85[3]) - 2
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)
	local v90 = Vector(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2, 0)

	for i = 1, 3 do
		if not (__wf_atom_7cff1779(v90, v86[i].n, v86[i].w) > 0) then
			continue
		end

		local v91 = i + 1
		local v92 = v91 > 3 and 1 or v91
		v90 = __wf_atom_bdb9797f(v85[i], v85[v92], v90)
	end

	local v91 = Vector()
	__wf_atom_5f7ca964(v90, v85[1], v85[3], v85[2], v91, true)
	local v92 = v7[0]
	v92.mAttributeConfigU = math.round(v91.x * 255) / 255
	v92.mAttributeConfigV = math.round(v91.y * 255) / 255
	fn28(v92)
end

fn4 = function()
	local attribute = arsenalAvatar:GetAttribute(0, false)
	local attribute2 = arsenalAvatar:GetAttribute(1, false)
	local attribute3 = arsenalAvatar:GetAttribute(2, false)
	local attribute4 = arsenalAvatar:GetAttribute(0, true)
	local attribute5 = arsenalAvatar:GetAttribute(1, true)
	local attribute6 = arsenalAvatar:GetAttribute(2, true)
	local v90 = v7[0]
	local storeItem = manifest:GetStoreItem(v90.mAttributeItem)

	if Resource(v90.mAttributeItem):__wf_atom_0a0a3205() then
		mMovie:__wf_atom_2dedec1a("Virtues.Details.VirtueControl", 13, true)
	else
		mMovie:__wf_atom_2dedec1a("Virtues.Details.VirtueControl", 13, false)
	end

	mMovie:__wf_atom_2dedec1a("Virtues.Details.DynamicPrism", 13, true)
	local v91 = attribute4 + attribute5 + attribute6
	local maxHealth = arsenalAvatar:GetMaxHealth(false)
	local maxHealth2 = arsenalAvatar:GetMaxHealth(true)
	local __wf_atom_bb81a9df = arsenalAvatar:__wf_atom_bb81a9df()
	fn27("Courage", attribute4, attribute4 / v91 * 100, attribute4 - attribute)
	fn27("Spirit", attribute5, attribute5 / v91 * 100, attribute5 - attribute2)
	fn27("Grace", attribute6, attribute6 / v91 * 100, attribute6 - attribute3)
	fn27("Life", maxHealth2, __wf_atom_bb81a9df * 100, maxHealth2 - maxHealth)
	local v92

	if __wf_atom_7e8ad928(storeItem) then
		v92 = false
	else
		v92 = storeItem:GetIconTexture() ~= nil
		local v93

		if fn9() then
			v93 = Vector(attribute3, attribute2, attribute)
		else
			v93 = Vector(attribute, attribute2, attribute3)
		end

		Normalize(v93)
		local v94 = 999999
		local v95 = 1

		for i = 1, #v83 do
			Normalize(v83[i][3])
			local v96 = Distance(v83[i][3], v93)

			if not (v96 < v94) then
				continue
			end

			v95 = i
			v94 = v96
		end

		local v96

		if fn9() then
			v96 = v83[v95][2]
		else
			v96 = v83[v95][1]
		end

		mMovie:__wf_atom_7d7314f1("Virtues.Details.VirtuesHint.Text", "/SF/Language/Virtues/" .. v96 .. "Name")
		local v97 = Localize("/SF/Language/Virtues/" .. v96 .. "Desc", false)
		local v98 = string.sub(v97, 1, (string.find(v97, "\n")))
		mMovie:__wf_atom_50d60589("Virtues.Details.VirtuesHintDesc", 36, v98)
		mMovie:__wf_atom_e57658c2("Virtues.Details.VirtuesHintDesc", 11, _G.UIColor_Beige)

		if not __wf_atom_7e8ad928(v46) then
			local v99 = mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtuesHintDesc", 1) + mMovie:__wf_atom_5e6e15c8(
				"Virtues.Details.VirtuesHintDesc",
				41
			) + 10
			v46:SetPosition(nil, v99)
			v47:SetPosition(nil, v99)
			v48:SetPosition(nil, v99)
		end
	end

	mMovie:__wf_atom_e57658c2("Virtues.Details.GemMat", 14, 350)
	mMovie:__wf_atom_e57658c2("Virtues.Details.GemMat", 15, 350)
	mMovie:__wf_atom_2dedec1a("Virtues.Details.GemMat", 13, v92)

	if v91 <= 0 then
		mMovie:__wf_atom_50d60589("Virtues.Details.VirtuesHint", 36, "")
		return
	end

	for i = v61.PACT, v61.MAX_Value do
		if v17[i] ~= nil then
			v17[i]:Redraw(nil, true, true)
		end
	end
end

local function fn29(p)
	if not __wf_atom_7e8ad928(v25) then
		v25:SetActive(p ~= 0)
	end
end

local function fn30(p, p2, object)
	if object == nil then
		return
	end

	object.mAnchor = nil
	object:SetPosition(mMovie:__wf_atom_5e6e15c8(p, 0) + p2, nil, module.CENTER_ALIGNED)
end

local function fn31()
	if v44 == nil or v45 == nil then
		return
	end

	if __wf_atom_7e8ad928(v37) or not (#v37:__wf_atom_8276662e() > 0) then
		fn30("Pact.Details.SpiritIcon", 0, v45)
		return
	end

	local v90 = v45.mWidth + v44.mWidth + 150
	fn30("Pact.Details.SpiritIcon", 0 - v90 / 3, v45)
	fn30("Pact.Details.SpiritIcon", 0 + v90 / 3, v44)
end

function AbilityPressed(_) end

local function fn32(p)
	if fn9() then
		if p == 1 then
			return "<WRATH_ICON>"
		elseif p == 2 then
			return "<DEATH_ICON>"
		elseif p == 3 then
			return "<DOOM_ICON>"
		end
	elseif p == 1 then
		return "<COURAGE_ICON>"
	elseif p == 2 then
		return "<SPIRIT_ICON>"
	elseif p == 3 then
		return "<GRACE_ICON>"
	end

	return ""
end

function AbilityFocused(p)
	if __wf_atom_7e8ad928(v37) then
		return
	end

	local __wf_atom_e68785c4 = v37:__wf_atom_e68785c4(p)

	if __wf_atom_7e8ad928(__wf_atom_e68785c4) or mMovie:__wf_atom_5e6e15c8("Pact.Details", 12) <= 1 then
		return
	end

	if v29.mPreviewLoader ~= nil then
		v29.mPreviewLoader:Release()
	end

	local v90 = "Pact.Details.Ability" .. tostring(p) .. "Hover"
	local v91 = Localize(__wf_atom_e68785c4:__wf_atom_014a76a2():c_str(), false)
	local v92 = fn32(p)
	local infoPopup_Data = {
		CustomEntry = true,
		Name = mMovie:__wf_atom_8e9ac384(v92 .. " " .. v91, true),
		LocalizedDesc = Localize(__wf_atom_e68785c4:__wf_atom_3a3d2e39():c_str(), false),
		StoreItem = nil
	}
	module6.SetItemInfoPopupRect(
		mMovie,
		infoPopup_Data,
		mMovie:__wf_atom_5e6e15c8(v90, 2),
		mMovie:__wf_atom_5e6e15c8(v90, 3),
		mMovie:__wf_atom_5e6e15c8(v90, 14),
		mMovie:__wf_atom_5e6e15c8(v90, 15)
	)
	_T.InfoPopup_Data = infoPopup_Data
end

function AbilityUnfocused(_)
	_T.InfoPopup_Data = nil
end

local function fn33()
	if __wf_atom_7e8ad928(arsenalAvatar) then
		return
	end

	local __wf_atom_e55d02aa = arsenalAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_a769ebe3 = __wf_atom_e55d02aa:__wf_atom_a769ebe3(0)
	local __wf_atom_a769ebe3_2 = __wf_atom_e55d02aa:__wf_atom_a769ebe3(1)
	local __wf_atom_a769ebe3_3 = __wf_atom_e55d02aa:__wf_atom_a769ebe3(2)
	local __wf_atom_2a745663 = arsenalAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(
		__wf_atom_a769ebe3,
		20,
		nil,
		nil,
		21
	)
	local __wf_atom_2a745663_2 = arsenalAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(
		__wf_atom_a769ebe3_2,
		20,
		nil,
		nil,
		25
	)
	local __wf_atom_2a745663_3 = arsenalAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(__wf_atom_a769ebe3_3, 168)
	local v90 = __wf_atom_2a745663 + __wf_atom_2a745663_2 + __wf_atom_2a745663_3
	mMovie:__wf_atom_7f57ab2f("ArmorStats", "TotalDefense", 54, true)
	mMovie:__wf_atom_50d60589("ArmorStats.TotalDefense", 36, module.FormatNumber(v90, 0))
	mMovie:__wf_atom_4c1c1986("ArmorStats", "TotalDefense", 0, module.Ternary(v90 > 99, -26, -26))
	mMovie:__wf_atom_4c1c1986("ArmorStats", "TotalDefense", 1, module.Ternary(v90 > 99, -25, -31))
	mMovie:__wf_atom_50d60589("ArmorStats.Resist1.DamageAmount", 36, module.FormatNumber(__wf_atom_2a745663, 0))
	mMovie:__wf_atom_50d60589("ArmorStats.Resist2.DamageAmount", 36, module.FormatNumber(__wf_atom_2a745663_2, 0))
	mMovie:__wf_atom_50d60589("ArmorStats.Resist3.DamageAmount", 36, module.FormatNumber(__wf_atom_2a745663_3, 0))
end

local function fn34(p)
	mMovie:__wf_atom_2dedec1a("Pact.Details.Backer", 13, true)
	mMovie:__wf_atom_2dedec1a("Pact.Details.Name", 13, true)
	mMovie:__wf_atom_2dedec1a("Pact.Details.BondTitle", 13, true)
	mMovie:__wf_atom_2dedec1a("Pact.Details.Bond", 13, true)
	local pactBannerTexture = pactBannerTexture
	local pactBannerMaterial = pactBannerMaterial
	local virtueIcons = virtueIcons

	if fn9() then
		pactBannerTexture = corruptBannerTexture
		pactBannerMaterial = corruptBannerMaterial
		virtueIcons = corruptVirtueIcons
		mMovie:__wf_atom_933bbce0("Pact.Details.FireFG", corruptDressTextures[1], virtueDressMaterial)
		mMovie:__wf_atom_1ca72041("Pact.Details.FireFG", "PlasmaSpeed_PlasmaTile", 0.155, 2, 0, 0)
		mMovie:__wf_atom_1ca72041(
			"Pact.Details.FireFG",
			"PlasmaStrength_PlasmaTopAtten_PlasmaBottomAtten_PlasmaTopOffset",
			0.23,
			0.5,
			0,
			0
		)
		mMovie:__wf_atom_933bbce0("Pact.Details.FireBG", corruptDressTextures[2], virtueDressMaterial)
		mMovie:__wf_atom_1ca72041("Pact.Details.FireBG", "PlasmaSpeed_PlasmaTile", 0.188, 2, 0, 0)
		mMovie:__wf_atom_1ca72041(
			"Pact.Details.FireBG",
			"PlasmaStrength_PlasmaTopAtten_PlasmaBottomAtten_PlasmaTopOffset",
			0.23,
			0.5,
			0,
			0
		)
		mMovie:__wf_atom_933bbce0("Pact.Details.Smoke", corruptDressTextures[3], virtueDressMaterial)
		mMovie:__wf_atom_1ca72041("Pact.Details.Smoke", "PlasmaSpeed_PlasmaTile", 0.077, 2, 0, 0)
		mMovie:__wf_atom_1ca72041(
			"Pact.Details.Smoke",
			"PlasmaStrength_PlasmaTopAtten_PlasmaBottomAtten_PlasmaTopOffset",
			0.23,
			0.2,
			0,
			0
		)
		mMovie:__wf_atom_c90af43a("Pact.Details.KnightLeft", corruptTextures[1])
		mMovie:__wf_atom_c90af43a("Pact.Details.KnightRight", corruptTextures[1])
		mMovie:__wf_atom_c90af43a("Pact.Details.Wood", corruptTextures[2])
		mMovie:__wf_atom_c90af43a("Pact.Details.Backer", corruptTextures[3])
	else
		mMovie:__wf_atom_933bbce0("Pact.Details.DressLeft", pactDressTextures[1], virtueDressMaterial)
		mMovie:__wf_atom_933bbce0("Pact.Details.DressCenter", pactDressTextures[2], virtueDressMaterial)
		mMovie:__wf_atom_933bbce0("Pact.Details.DressRight", pactDressTextures[3], virtueDressMaterial)
		mMovie:__wf_atom_c90af43a("Pact.Details.GirlsFront", pactTextures[1])
		mMovie:__wf_atom_c90af43a("Pact.Details.GirlsBack", pactTextures[2])
		mMovie:__wf_atom_c90af43a("Pact.Details.Backer", pactTextures[3])
	end

	mMovie:__wf_atom_c90af43a("Pact.Details.CourageIcon", virtueIcons[1])
	mMovie:__wf_atom_c90af43a("Pact.Details.SpiritIcon", virtueIcons[2])
	mMovie:__wf_atom_c90af43a("Pact.Details.GraceIcon", virtueIcons[3])
	mMovie:__wf_atom_933bbce0("Pact.Details.Banner", pactBannerTexture, pactBannerMaterial)

	for i = 1, 3 do
		local v90 = "Pact.Details.Ability" .. tostring(i)
		mMovie:__wf_atom_2dedec1a(v90, 13, true)
		mMovie:__wf_atom_e57658c2(v90 .. "Hover", 100, i)
		mMovie:__wf_atom_e57658c2(v90 .. "Hover", 12, 0)
		mMovie:SetCallbacks(v90 .. "Hover", "AbilityFocused", "AbilityUnfocused", nil, nil)
	end

	v37 = nil
	local v90 = 0

	if p and not __wf_atom_7e8ad928(gGameData) then
		gGameData:__wf_atom_efd6bfce(0, v7[0])
	end

	if inventory then
		local __wf_atom_e55d02aa = statOwner:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		local __wf_atom_b369d77f = v7[0]:__wf_atom_b369d77f(0)
		local __wf_atom_0ff4b555 = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId)
		v90 = __wf_atom_c67f9605:__wf_atom_b4a75eaa(__wf_atom_0ff4b555.mXP, __wf_atom_0ff4b555.mItemType)

		if
			v30
			or __wf_atom_7e8ad928(__wf_atom_e55d02aa)
			or __wf_atom_e55d02aa:__wf_atom_1bb5b1ff() == __wf_atom_0ff4b555.mItemType
		then
			v37 = Resource(__wf_atom_0ff4b555.mItemType)
		else
			v37 = __wf_atom_e55d02aa
			v90 = v37:__wf_atom_22941262()
		end
	end

	local v91 = not __wf_atom_7e8ad928(v37) and #v37:__wf_atom_8276662e() > 0
	mMovie:__wf_atom_2dedec1a("Pact.Details.UpgradeBtn", 13, v91)
	fn31()

	if __wf_atom_7e8ad928(v37) and not __wf_atom_7e8ad928(arsenalAvatar) then
		v37 = arsenalAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if __wf_atom_7e8ad928(v37) then
			return
		else
			v90 = v37:__wf_atom_22941262()
		end
	end

	local iconTexture = v37:GetIconTexture()
	asyncLoader:LoadResource(
		"AltIcon",
		WeakResource("/SF/Interface/Graphics/Equipment/Pact/CenterIcons/" .. iconTexture:GetName()),
		function(p2)
			local v93 = fn9()
			mMovie:__wf_atom_c90af43a("Pact.Details.PactIcon", p2)
			mMovie:__wf_atom_50d60589("Pact.Details.Name", 36, Localize(v37:__wf_atom_014a76a2():c_str(), {}))
			mMovie:__wf_atom_50d60589("Pact.Details.Bond", 36, module.FormatNumber(v90))
			local mMovie2 = mMovie
			local v96

			if v93 then
				v96 = _G.UIColor_LightGrey
			else
				v96 = _G.UIColor_DarkerBrown
			end

			mMovie2:__wf_atom_e57658c2("Pact.Details.Name", 44, v96)
			local mMovie3 = mMovie
			local v99

			if v93 then
				v99 = _G.UIColor_LightGrey
			else
				v99 = _G.UIColor_Beige
			end

			mMovie3:__wf_atom_50d60589("Pact.Details.BondTitle", 44, v99)
			local mMovie4 = mMovie
			local v102

			if v93 then
				v102 = _G.UIColor_LightGrey
			else
				v102 = _G.UIColor_Beige
			end

			mMovie4:__wf_atom_50d60589("Pact.Details.Bond", 44, v102)
			local v103 = mMovie:__wf_atom_5e6e15c8("Pact.Details.Name", 40) + 240
			mMovie:__wf_atom_e57658c2("Pact.Details.Banner", 14, v103)

			for i = 1, 3 do
				local __wf_atom_e68785c4 = v37:__wf_atom_e68785c4(i)

				if not __wf_atom_7e8ad928(__wf_atom_e68785c4) then
					mMovie:__wf_atom_c90af43a(
						"Pact.Details.Ability" .. tostring(i),
						__wf_atom_e68785c4:GetIconTexture()
					)
				end
			end
		end
	)
	fn4()
end

local function fn35()
	local shoulderOffset = module9.GetShoulderOffset(arsenalAvatar)

	if
		not __wf_atom_7e8ad928(statOwner:__wf_atom_a96eb2aa())
		and not __wf_atom_7e8ad928(module9.GetSparrowSkinForPlayer(statOwner:__wf_atom_a96eb2aa()))
		and module9.GetSparrowSkinForPlayer(statOwner:__wf_atom_a96eb2aa()):__wf_atom_5b41f63b() == "/SF/Upgrades/Skins/Sparrow/FloppetBody"
	then
		shoulderOffset = v41
	end

	local v90 = arsenalAvatar:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM1")) + __wf_atom_9341614d(
		shoulderOffset,
		arsenalAvatar:__wf_atom_8e4cf043(Symbol("GAME_R1_ARM1"))
	)
	local v91 = (function(p, p2)
		local v92 = p + p2

		if v92 >= 180 then
			return v92 - 360
		end

		if v92 < -180 then
			return v92 + 360
		end

		return v92
	end)(arsenalAvatar:__wf_atom_3d840c93(173), 15)
	return v90, (Rotation(v91, 0, 0))
end

local function fn36()
	if __wf_atom_7e8ad928(v39) then
		return
	end

	if
		__wf_atom_7e8ad928(statOwner:__wf_atom_a96eb2aa())
		or __wf_atom_7e8ad928(module9.GetSparrowSkinForPlayer(statOwner:__wf_atom_a96eb2aa()))
		or module9.GetSparrowSkinForPlayer(statOwner:__wf_atom_a96eb2aa()):__wf_atom_5b41f63b() ~= "/SF/Upgrades/Skins/Sparrow/FloppetBody"
	then
		v39:__wf_atom_921c1a5f(sparrowShoulderPerchLoopAnim, false, 3, 2, true)
	else
		v39:__wf_atom_921c1a5f(floppetHoverAnim, false, 3, 2, true)
	end
end

local function fn37()
	if __wf_atom_7e8ad928(arsenalAvatar) or __wf_atom_7e8ad928(statOwner) then
		return
	end

	if not __wf_atom_7e8ad928(v39) then
		v39:Destroy()
	end

	local v90, v91 = fn35()
	v39 = gRegion:CreateEntity(dummySparrowAvatarType, v90, v91, arsenalAvatar, arsenalAvatar, fn17())

	if __wf_atom_7e8ad928(v39) then
		return
	end

	if
		not gRegion:IsMaster()
		and not __wf_atom_7e8ad928(v39:__wf_atom_d2b2176d())
		and __wf_atom_7e8ad928(v39:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
	then
		v39:GiveItem(sparrowSuitType, true)
	end

	module9.ApplySparrowCustomization(statOwner, v39)
	v40 = 0.1
	v39:SetVisibility(false, true)
	v39:SetMeshScale(1.25)

	if not __wf_atom_7e8ad928(v39) then
		local v92 = Symbol("SPARROW_APPEAR_FX")
		local v93 = Symbol("SPARROW_GUIDE_VFX")
		local v94 = Symbol("SPARROW_LIGHT")
		local __wf_atom_f582136d = v39:__wf_atom_f582136d(__wf_atom_7e616794)

		for _, v95 in ipairs(__wf_atom_f582136d) do
			if not (v95:__wf_atom_db682341() == v92 or v95:__wf_atom_db682341() == v93 or v95:__wf_atom_db682341() == v94) then
				continue
			end

			v95:Destroy()
		end
	end

	fn36()
end

local function fn38()
	if __wf_atom_7e8ad928(v39) or __wf_atom_7e8ad928(arsenalAvatar) or __wf_atom_7e8ad928(statOwner) then
		return
	end

	local v90, v91 = fn35()
	v39:Teleport(v90, v91)
	v39:SetMeshScale(1.25)
	v39:__wf_atom_e424c72a(not v50)

	if v40 <= 0 then
		v39:SetVisibility(true, true)
		v40 = 0
	else
		v40 -= __wf_atom_084b3e93()
	end
end

fn3 = function(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(arsenalAvatar) then
		LogBug("mDummyAvatar is nil")
		return
	end

	module5.BuildLoadout(p)
	arsenalAvatar:SetVisibility(true, true)
	statOwner:__wf_atom_a7ee9662(false)
	fn33()
	UpdateUnspentPactPoints()
end

local function fn39(p)
	local __wf_atom_05b32923 = inventory:__wf_atom_05b32923(1, 3, Resource(p), true)
	local result = {}

	for _, v90 in ipairs(__wf_atom_05b32923) do
		if v90.mInstance ~= nil and v90.mInstance:IsA(v55) then
			table.insert(result, v90)
		end
	end

	return result
end

local function fn40()
	local result = {}

	if not gGameData then
		return result
	end

	for _, v90 in pairs(v63) do
		local __wf_atom_b369d77f = v7[v90.LoadOutType]:__wf_atom_b369d77f(v90.LoadOutId)
		local __wf_atom_a82c3c45 = gGameData:__wf_atom_a82c3c45(
			__wf_atom_b369d77f.mItemId.mId,
			v90.LoadOutType,
			v90.LoadOutId,
			v90.StoreItemId,
			__wf_atom_b369d77f.mModSlot,
			__wf_atom_b369d77f.mCustSlot
		)

		for _, v91 in ipairs(__wf_atom_a82c3c45) do
			table.insert(result, v91)
		end
	end

	return result
end

local function fn41(p)
	if not inventory then
		return nil
	end

	local v90 = nil
	local result = {}
	local fn42
	local __wf_atom_b369d77f = v7[0]:__wf_atom_b369d77f(0)
	local mItemType = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId).mItemType

	if p == v61.PACT then
		v90 = inventory:__wf_atom_ebdc4e6e()
	elseif p == v61.MELEE then
		v90 = inventory:__wf_atom_4259c789()
	elseif p == v61.SECONDARY then
		v90 = inventory:__wf_atom_4f67b86c()
	elseif p == v61.VIRTUEGEM then
		v90 = inventory:__wf_atom_da43e3f3()

		for i = #v90, 1, -1 do
			if not (__wf_atom_7e8ad928(v90[i].mItemType) or not v90[i].mItemType:IsA(baseVirtueGemTypes)) then
				continue
			end

			table.remove(v90, i)
		end
	elseif p == v61.HELM or p == v61.CHEST or p == v61.LEGS or p == v61.TOTEM or p == v61.GUIDE then
		v90 = inventory:__wf_atom_71d5cc00()
		local v91

		if p == v61.HELM then
			v91 = 0
		elseif p == v61.CHEST then
			v91 = 2
		elseif p == v61.LEGS then
			v91 = 3
		elseif p == v61.GUIDE then
			v91 = 2
		else
			v91 = 5
		end

		fn42 = function(object)
			if not object:__wf_atom_e84d016c(v91) then
				return false
			end

			if p ~= v61.GUIDE then
				local __wf_atom_7c09e378 = object:__wf_atom_7c09e378()

				if
					not __wf_atom_7e8ad928(__wf_atom_7c09e378)
					and (__wf_atom_7e8ad928(mItemType) or not mItemType:IsA(__wf_atom_7c09e378))
				then
					return false
				end
			end

			return true
		end

		local __wf_atom_92ba339b = manifest:__wf_atom_92ba339b(baseWeaponSkinType)
		local v92 = {}

		for _, v93 in v90 do
			if not __wf_atom_7e8ad928(v93.mItemType) then
				v92[v93.mItemType:__wf_atom_5b41f63b()] = true
			end
		end

		for _, v93 in ipairs(__wf_atom_92ba339b) do
			if __wf_atom_7e8ad928(v93) or not (not fn42 or fn42(v93)) then
				continue
			end

			local item = v93:GetItem()

			if not (__wf_atom_7e8ad928(item) or not v92[item:__wf_atom_5b41f63b()]) then
				continue
			end

			local weaponSkinInfo = SF.WeaponSkinInfo()
			weaponSkinInfo.mItemType = v93:GetItem()
			table.insert(result, weaponSkinInfo)
		end
	elseif p == v61.IDOL then
		v90 = fn39(mItemType)
	end

	for _, v91 in ipairs(v90) do
		if __wf_atom_7e8ad928(v91.mItemType) then
			continue
		end

		local storeItem = manifest:GetStoreItem(v91.mItemType)

		if __wf_atom_7e8ad928(storeItem) or not (not fn42 or fn42(storeItem)) then
			continue
		end

		table.insert(result, v91)
	end

	return result
end

local function fn42()
	local v90 = nil
	local __wf_atom_b369d77f = v7[0]:__wf_atom_b369d77f(0)
	local __wf_atom_43563387 = inventory:__wf_atom_43563387(__wf_atom_b369d77f.mItemId.mId, 0, false)
	local v91 = fn39(statOwner:__wf_atom_d2b2176d():__wf_atom_e55d02aa())

	if __wf_atom_43563387 ~= nil and #__wf_atom_43563387 > 0 then
		for _, v93 in ipairs(v91) do
			if v93.mItemType ~= __wf_atom_43563387[1].mItemType then
				continue
			end

			v90 = __wf_atom_43563387[1]
			break
		end
	end

	if v90 == nil and #v91 > 0 then
		return v91[1]
	end

	return v90
end

function OnEquipVirtueGem(p)
	local __wf_atom_f7423942 = __wf_atom_c67f9605:__wf_atom_f7423942(gGameData:__wf_atom_d5bed0b3())
	local v90 = SF.__wf_atom_edd3fb68 + __wf_atom_f7423942 + statOwner:__wf_atom_4ad84724()
	local v91 = { 0, 0, 0 }

	if p ~= nil then
		local v92 = v7[0]
		local v93 = Resource(p)
		local __wf_atom_e3a1a628, v94, v95 = v93:__wf_atom_e3a1a628(v90, v92.mAttributeConfigU, v92.mAttributeConfigV)
		v91[1] = __wf_atom_e3a1a628
		v91[2] = v94
		v91[3] = v95
		local __wf_atom_b377c1ff = v93:__wf_atom_b377c1ff()

		if __wf_atom_b377c1ff ~= nil then
			module.PlaySound(Resource(__wf_atom_b377c1ff))
		end
	end

	local v92 = math.max(v91[1], v91[2], v91[3])

	if v91[1] == v92 then
		arsenalAvatar:__wf_atom_921c1a5f(virtueCourageEquipAnim, false, 3, 1, true)
		arsenalAvatar:Attach(virtueCourageEquipFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	elseif v91[2] == v92 then
		arsenalAvatar:__wf_atom_921c1a5f(virtueSpiritEquipAnim, false, 3, 1, true)
		arsenalAvatar:Attach(virtueSpiritEquipFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	else
		arsenalAvatar:__wf_atom_921c1a5f(virtueGraceEquipAnim, false, 3, 1, true)
		arsenalAvatar:Attach(virtueGraceEquipFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	fn33()

	if __wf_atom_7e8ad928(statOwner:__wf_atom_a96eb2aa()) then
		return
	end

	local sparrowSkinForPlayer = module9.GetSparrowSkinForPlayer(statOwner:__wf_atom_a96eb2aa())

	if
		__wf_atom_7e8ad928(sparrowSkinForPlayer)
		or sparrowSkinForPlayer:__wf_atom_5b41f63b() == "/SF/Upgrades/Skins/Sparrow/FloppetBody"
		or __wf_atom_7e8ad928(v39)
	then
		return
	end

	if v91[1] == v92 then
		sparrowCourageVirtueAnim2 = sparrowCourageVirtueAnim
	elseif v91[2] == v92 then
		sparrowCourageVirtueAnim2 = sparrowSpiritVirtueAnim
	else
		sparrowCourageVirtueAnim2 = sparrowGraceVirtueAnim
	end

	v39:StopAnimation()
	v26:AddTimer(0.1, function()
		v39:__wf_atom_921c1a5f(sparrowCourageVirtueAnim2, false, 3, 1, false)
		v26:AddTimer(0.05, function()
			WaitForSparrowAnimComplete()
		end)
	end)
end

function WaitForSparrowAnimComplete()
	if __wf_atom_7e8ad928(v39) then
		return
	end

	if v39:__wf_atom_c138b19b(sparrowCourageVirtueAnim2) then
		v26:AddTimer(0.05, function()
			WaitForSparrowAnimComplete()
		end)
	else
		fn36()
	end
end

local function fn43()
	local circularText = module10.CreateCircularText(mMovie, "Virtues.Details.SpiritBannerText.Name.Letter")
	circularText.mFlip = true
	circularText.mRadius = 155
	circularText.mTargetAngle = 70
	circularText.mLetterSpacing = 10
	circularText.mMaterial = virtueMaterials[3]
	circularText:SetText(string.upper(Localize("/SF/Language/Menu/AT_DEATH", nil)))
	mMovie:__wf_atom_e57658c2("Virtues.Details.SpiritBannerText", 11, _G.UIColor_LightGrey)
	local circularText2 = module10.CreateCircularText(mMovie, "Virtues.Details.CourageBannerText.Name.Letter")
	circularText2.mFlip = true
	circularText2.mRadius = 110
	circularText2.mTargetAngle = 84
	circularText2.mLetterSpacing = 10
	circularText2.mMaterial = virtueMaterials[3]
	circularText2:SetText(string.upper(Localize("/SF/Language/Menu/AT_DOOM", nil)))
	mMovie:__wf_atom_e57658c2("Virtues.Details.CourageBannerText", 11, _G.UIColor_LightGrey)
	local circularText3 = module10.CreateCircularText(mMovie, "Virtues.Details.GraceBannerText.Name.Letter")
	circularText3.mFlip = true
	circularText3.mRadius = 120
	circularText3.mTargetAngle = 80
	circularText3.mLetterSpacing = 10
	circularText3.mMaterial = virtueMaterials[3]
	circularText3:SetText(string.upper(Localize("/SF/Language/Menu/AT_WRATH", nil)))
	mMovie:__wf_atom_e57658c2("Virtues.Details.GraceBannerText", 11, _G.UIColor_LightGrey)
	local circularText4 = module10.CreateCircularText(mMovie, "Virtues.Details.Illustration.LifeBannerText.Name.Letter")
	circularText4.mFlip = true
	circularText4.mRadius = 160
	circularText4.mTargetAngle = 28
	circularText4.mLetterSpacing = 10
	circularText4.mMaterial = virtueMaterials[3]
	circularText4:SetText(string.upper(Localize("/SF/Language/Menu/AT_UNLIFE", nil)))
	mMovie:__wf_atom_e57658c2("Virtues.Details.Illustration.LifeBannerText", 11, _G.UIColor_LightGrey)
end

local function fn44()
	local circularText = module10.CreateCircularText(mMovie, "Virtues.Details.SpiritBannerText.Name.Letter")
	circularText.mRadius = 130
	circularText.mTargetAngle = 70
	circularText.mLetterSpacing = 10
	circularText.mMaterial = virtueMaterials[3]
	circularText:SetText(string.upper(Localize("/SF/Language/Menu/AT_SPIRIT", nil)))
	mMovie:__wf_atom_e57658c2("Virtues.Details.SpiritBannerText", 11, _G.UIColor_DarkerBrown)
	local circularText2 = module10.CreateCircularText(mMovie, "Virtues.Details.CourageBannerText.Name.Letter")
	circularText2.mRadius = 92
	circularText2.mTargetAngle = 90
	circularText2.mLetterSpacing = 10
	circularText2.mMaterial = virtueMaterials[3]
	circularText2:SetText(string.upper(Localize("/SF/Language/Menu/AT_COURAGE", nil)))
	mMovie:__wf_atom_e57658c2("Virtues.Details.CourageBannerText", 11, _G.UIColor_DarkerBrown)
	local circularText3 = module10.CreateCircularText(mMovie, "Virtues.Details.GraceBannerText.Name.Letter")
	circularText3.mRadius = 92
	circularText3.mTargetAngle = 80
	circularText3.mLetterSpacing = 10
	circularText3.mMaterial = virtueMaterials[3]
	circularText3:SetText(string.upper(Localize("/SF/Language/Menu/AT_GRACE", nil)))
	mMovie:__wf_atom_e57658c2("Virtues.Details.GraceBannerText", 11, _G.UIColor_DarkerBrown)
	local circularText4 = module10.CreateCircularText(mMovie, "Virtues.Details.Illustration.LifeBannerText.Name.Letter")
	circularText4.mRadius = 160
	circularText4.mTargetAngle = 28
	circularText4.mLetterSpacing = 10
	circularText4.mMaterial = virtueMaterials[3]
	circularText4:SetText(string.upper(Localize("/SF/Language/Menu/AT_LIFE", nil)))
	mMovie:__wf_atom_e57658c2("Virtues.Details.Illustration.LifeBannerText", 11, _G.UIColor_DarkerBrown)
end

local function fn45()
	mMovie:__wf_atom_2dedec1a("Virtues.Details.DynamicPrism", 13, false)
	mMovie:__wf_atom_2dedec1a("Virtues.Details.VirtueControl", 13, false)
	mMovie:OverrideMaterial("Virtues.Details.VirtueControl.CombinedFlare", virtueControlFlareMaterial)
	mMovie:__wf_atom_e57658c2("Virtues.Details.CourageHover", 12, 0)
	mMovie:__wf_atom_e57658c2("Virtues.Details.SpiritHover", 12, 0)
	mMovie:__wf_atom_e57658c2("Virtues.Details.GraceHover", 12, 0)
	mMovie:__wf_atom_e57658c2("Virtues.Details.CourageHover", 100, 1)
	mMovie:__wf_atom_e57658c2("Virtues.Details.SpiritHover", 100, 2)
	mMovie:__wf_atom_e57658c2("Virtues.Details.GraceHover", 100, 3)
	mMovie:__wf_atom_2dedec1a("Virtues.Details.VirtueControl", 13, false)
	mMovie:__wf_atom_2dedec1a("Virtues.Details.VirtueSpirtMarker", 13, false)
	mMovie:__wf_atom_2dedec1a("Virtues.Details.VirtueCourageMarker", 13, false)
	mMovie:__wf_atom_2dedec1a("Virtues.Details.VirtueGraceMarker", 13, false)
	mMovie:SetCallbacks(
		"Virtues.Details.VirtueControl",
		"VirtueControlFocused",
		"VirtueControlUnfocused",
		"VirtueControlReleased",
		"VirtueControlPressed"
	)
	local v90 = fn9()

	if __wf_atom_b953295d():c_str() == "_en" then
		if v90 then
			mMovie:__wf_atom_c90af43a("Virtues.Details.CourageBanner", courageCorruptBannerText)
			mMovie:__wf_atom_c90af43a("Virtues.Details.GraceBanner", graceCorruptBannerText)
			mMovie:__wf_atom_c90af43a("Virtues.Details.SpiritBanner", spiritCorruptBannerText)
		else
			mMovie:__wf_atom_c90af43a("Virtues.Details.CourageBanner", courageBannerText)
			mMovie:__wf_atom_c90af43a("Virtues.Details.GraceBanner", graceBannerText)
			mMovie:__wf_atom_c90af43a("Virtues.Details.SpiritBanner", spiritBannerText)
		end

		mMovie:__wf_atom_2dedec1a("Virtues.Details.CourageBannerText", 13, false)
		mMovie:__wf_atom_2dedec1a("Virtues.Details.GraceBannerText", 13, false)
		mMovie:__wf_atom_2dedec1a("Virtues.Details.SpiritBannerText", 13, false)
	end

	mMovie:__wf_atom_2dedec1a("Virtues.Details.Backer", 13, v90)

	if not v90 then
		mMovie:OverrideMaterial("Virtues.Details.BackerLayer", virtueMaterials[2])
	end

	mMovie:OverrideMaterial("Virtues.Details.GemMist.Shadow", radialRaysMaterial)
	mMovie:OverrideMaterial("Virtues.Details.GemMist.Mist", radialRaysMaterial)
	mMovie:__wf_atom_e57658c2("Virtues.Details.GemMist", 12, 0)
	mMovie:__wf_atom_e57658c2("Virtues.Details.BackerLayer", 12, 40)
	mMovie:__wf_atom_933bbce0("Virtues.Details.DressLeft", virtueDressTextures[1], virtueDressMaterial)
	mMovie:__wf_atom_933bbce0("Virtues.Details.DressRight", virtueDressTextures[2], virtueDressMaterial)
	local mMovie2 = mMovie
	local v92

	if v90 then
		v92 = corruptGemTexture
	else
		v92 = virtueGemTexture
	end

	mMovie2:__wf_atom_933bbce0("Virtues.Details.GemMat", v92, virtueGemMaterial)
	local corruptEdgeTexture2

	if v90 then
		corruptEdgeTexture2 = corruptEdgeTexture
	else
		corruptEdgeTexture2 = catLabelEdgeTexture
	end

	mMovie:__wf_atom_c90af43a("Pact.Label.LeftCap", corruptEdgeTexture2)
	mMovie:__wf_atom_c90af43a("Pact.Label.RightCap", corruptEdgeTexture2)
	mMovie:SetCallbacks("Virtues.Details.CourageHover", "VirtueTipRollOver", "VirtueTipRollOut", nil, "VirtueClick")
	mMovie:SetCallbacks("Virtues.Details.SpiritHover", "VirtueTipRollOver", "VirtueTipRollOut", nil, "VirtueClick")
	mMovie:SetCallbacks("Virtues.Details.GraceHover", "VirtueTipRollOver", "VirtueTipRollOut", nil, "VirtueClick")
	mMovie:__wf_atom_e57658c2("Virtues.Details.Value", 11, _G.UIColor_Beige)
	local mMovie3 = mMovie
	local v95

	if v90 then
		v95 = _G.UIColor_LightGrey
	else
		v95 = _G.UIColor_LightYellow
	end

	mMovie3:__wf_atom_e57658c2("Virtues.Details.VirtuesHint", 11, v95)
	mMovie:__wf_atom_e57658c2("CorruptedVignette", 12, v90 and 40 or 0)
	mMovie:__wf_atom_e57658c2("CorruptedVignette", 11, 327697)
	v46 = module11.Create(
		mMovie,
		"Virtues.Details.ConfirmBtn",
		"/SF/Language/Menu/VirtueConfirm",
		"ConfirmVirtueChanges"
	)
	v46:SetAnchor(module.CENTER_ALIGNED)
	v46:Resize()
	v46:SetVisible(false)
	v47 = module11.Create(
		mMovie,
		"Virtues.Details.RebalanceBtn",
		"/SF/Language/Menu/VirtueRebalance",
		"UnlockVirtueControl"
	)
	v47:SetAnchor(module.CENTER_ALIGNED)
	v47:Resize()
	v47:SetVisible(true)
	v48 = module11.Create(mMovie, "Virtues.Details.RevertBtn", "/SF/Language/Menu/VirtueRevert", "OnClickRevertVirtue")
	v48:SetAnchor(module.CENTER_ALIGNED)
	v48:Resize()
	v48:SetVisible(false)

	if v90 then
		fn43()
	else
		fn44()
	end
end

local function fn46(object)
	local v90 = not __wf_atom_7e8ad928(object) and object:__wf_atom_a07f65c2()
	local v91 = v90 and "Corrupted" or "Standard"

	if v51 ~= v91 then
		v51 = v91
		local v92 = v15
		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB
		local v93

		if v90 then
			v93 = _G.UIColor_DarkerPurple
		else
			v93 = _G.UIColor_DarkBrown
		end

		v92.Inner = convertColorNumberToProceduralRGB(v93)
		local v94 = v15
		local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB
		local v95

		if v90 then
			v95 = _G.UIColor_Black
		else
			v95 = _G.UIColor_DarkerBrown
		end

		v94.Edge = convertColorNumberToProceduralRGB2(v95)
		__wf_atom_86cbd68d(mMovie, "Virtues.Details.gotoAndStop", v91)
		__wf_atom_86cbd68d(mMovie, "Pact.Details.gotoAndStop", v91)
		mMovie:__wf_atom_c90af43a("Souls.Details.Heart", soulTextures[v90 and 13 or 2])

		for k, _ in skillTrees do
			local v96 = "Souls.Details.Attribute" .. k
			mMovie:__wf_atom_c90af43a(v96 .. ".EyeBacker", soulTextures[v90 and 14 or 9])
		end

		fn45()
	end

	fn11()
end

fn = function(p, p2, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local v90 = nil

	if p2.RawItem then
		local v91 = v7[0]

		if p == v61.PACT then
			local __wf_atom_b369d77f = v91:__wf_atom_b369d77f(0)
			local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
			__wf_atom_b369d77f.mItemId.mId = p2.RawItem.mItemId.mId
			__wf_atom_b369d77f.mModSlot = 0

			if __wf_atom_7e8ad928(__wf_atom_b369d77f.mCustSlot) then
				__wf_atom_b369d77f.mCustSlot = 0
			end

			v91:__wf_atom_0aa16242(0, __wf_atom_b369d77f)
			inventory:__wf_atom_337fac69(0, v91)
			inventory:__wf_atom_fe6304ae(
				__wf_atom_b369d77f.mItemId.mId,
				__wf_atom_b369d77f.mCustSlot,
				__wf_atom_eb82ab1f
			)
			fn46(Resource(p2.Type))
		elseif p == v61.MELEE then
			local __wf_atom_b369d77f = v91:__wf_atom_b369d77f(3)
			__wf_atom_b369d77f.mItemId.mId = p2.RawItem.mItemId.mId
			__wf_atom_b369d77f.mModSlot = 0
			__wf_atom_b369d77f.mCustSlot = 0
			v91:__wf_atom_0aa16242(3, __wf_atom_b369d77f)
			inventory:__wf_atom_337fac69(0, v91)
		elseif p == v61.SECONDARY then
			local __wf_atom_b369d77f = v91:__wf_atom_b369d77f(2)
			__wf_atom_b369d77f.mItemId.mId = p2.RawItem.mItemId.mId
			__wf_atom_b369d77f.mModSlot = 0
			__wf_atom_b369d77f.mCustSlot = 0
			v91:__wf_atom_0aa16242(2, __wf_atom_b369d77f)
			inventory:__wf_atom_337fac69(0, v91)
		elseif p == v61.HELM or p == v61.CHEST or p == v61.LEGS or p == v61.TOTEM then
			local __wf_atom_b369d77f = v91:__wf_atom_b369d77f(0)
			local __wf_atom_0ff4b555 = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId)
			local __wf_atom_eb82ab1f = __wf_atom_0ff4b555:__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)

			if p == v61.HELM then
				__wf_atom_eb82ab1f:__wf_atom_b6072b05(p2.RawItem, 0)
			elseif p == v61.CHEST then
				__wf_atom_eb82ab1f:__wf_atom_b6072b05(p2.RawItem, 2)
			elseif p == v61.LEGS then
				__wf_atom_eb82ab1f:__wf_atom_b6072b05(p2.RawItem, 3)
			elseif p == v61.TOTEM then
				__wf_atom_eb82ab1f:__wf_atom_b6072b05(p2.RawItem, 5)

				if _T.TutorialStepTalisman then
					if __wf_atom_7e8ad928(p2.RawItem.mItemType) then
						_T.TutorialTalismanEquipped = false
					else
						_T.TutorialTalismanEquipped = true
					end

					fn6()
				end
			end

			__wf_atom_0ff4b555:SetCustomization(__wf_atom_eb82ab1f, __wf_atom_b369d77f.mCustSlot)
			inventory:__wf_atom_fe6304ae(
				__wf_atom_b369d77f.mItemId.mId,
				__wf_atom_b369d77f.mCustSlot,
				__wf_atom_eb82ab1f
			)
		elseif p == v61.IDOL then
			local __wf_atom_b369d77f = v91:__wf_atom_b369d77f(0)
			local __wf_atom_43563387 = inventory:__wf_atom_43563387(__wf_atom_b369d77f.mItemId.mId, 0, false)
			local upgradeId = SF.UpgradeId()
			upgradeId.mId = p2.RawItem.mItemId
			upgradeId.mType = p2.RawItem.mItemType
			local upgradeIds = { upgradeId }

			for i = 2, #__wf_atom_43563387 do
				local upgradeId2 = SF.UpgradeId()
				upgradeId2.mId = __wf_atom_43563387[i].mItemId
				upgradeId2.mType = __wf_atom_43563387[i].mItemType
				table.insert(upgradeIds, upgradeId2)
			end

			inventory:__wf_atom_494e9b0e(__wf_atom_b369d77f.mItemId.mId, 0, false, upgradeIds)
			inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_494e9b0e(upgradeIds)
		elseif p == v61.GUIDE then
			local weaponCustomization = SF.WeaponCustomization()
			local mItemType = p2.RawItem.mItemType

			if not __wf_atom_7e8ad928(mItemType) then
				weaponCustomization:SetSkin(mItemType, 2)
			end

			inventory:__wf_atom_e1f7c9fe(weaponCustomization)
			gGameRules:__wf_atom_51274c29(weaponCustomization)
			local __wf_atom_b377c1ff = p2.RawItem:__wf_atom_18aa6e58():__wf_atom_b377c1ff()
			module.PlaySound(Resource(__wf_atom_b377c1ff))
		elseif p == v61.VIRTUEGEM then
			v91.mAttributeItem = p2.RawItem.mItemType
			inventory:__wf_atom_337fac69(0, v91)
			OnEquipVirtueGem(v91.mAttributeItem)
			mAttributeItem = v91.mAttributeItem
		end

		gGameData:__wf_atom_efd6bfce(0, v91)
		fn3(object)

		if p == v61.GUIDE then
			fn37()
		end

		if p == v61.PACT then
			v90 = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
		elseif p == v61.MELEE then
			v90 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()
		end

		v29.mSlotLoader:Pin(fn40())
		v30 = true
	end

	if p == v61.PACT then
		if __wf_atom_7e8ad928(v90) then
			v68 = nil
			v69 = nil
		else
			v68 = v90:__wf_atom_43cc9de1(Symbol("EQUIP_FX"))
			v69 = v90:__wf_atom_43cc9de1(Symbol("EQUIP_SFX"))
			object:Attach(v68, EMPTY_SYMBOL)
			module.PlaySound(v69)
		end

		fn34()
	end

	fn4()
	fn6(true)
	return v90
end

local function fn47(p)
	local result = { [0] = 0, [1] = 0, [2] = 0 }
	local v90 = false

	if __wf_atom_7e8ad928(p.StoreItem) then
		return false, result
	end

	for i = 0, 2 do
		local __wf_atom_4dbc3979 = p.StoreItem:__wf_atom_4dbc3979(i)
		result[i] = __wf_atom_4dbc3979

		if __wf_atom_4dbc3979 > 0 then
			v90 = true
		end
	end

	return v90, result
end

local function fn48(p)
	local result = { [0] = 0, [1] = 0, [2] = 0 }

	if __wf_atom_7e8ad928(p.StoreItem) then
		return result
	end

	if p.Type:IsA(__wf_atom_abf506db) then
		for i = 0, 2 do
			for j = 0, 2 do
				local __wf_atom_4900a295 = p.StoreItem:__wf_atom_4900a295(i, j)
				result[j] += __wf_atom_4900a295
			end
		end
	else
		for i = 0, 2 do
			local __wf_atom_4900a295 = p.StoreItem:__wf_atom_4900a295(i)
			result[i] += __wf_atom_4900a295
		end
	end

	return result
end

local function fn49(list, p, p2, p3)
	local result = {}

	if p == v61.SKILLS then
		return result
	end

	local v90 = fn41(p)
	local v91 = {}

	for _, v92 in ipairs(list) do
		local v93 = manifest:__wf_atom_caa82b8d(v92) or {}
		table.move(v93, 1, #v93, #v91 + 1, v91)
	end

	for _, v92 in ipairs(v91) do
		if p == v61.SECONDARY then
			if v92:__wf_atom_efa6f447() ~= v63.SECONDARY.StoreItemId then
				continue
			end
		elseif p == v61.MELEE and v92:__wf_atom_efa6f447() == v63.SECONDARY.StoreItemId then
			continue
		end

		if __wf_atom_7e8ad928(v92) or __wf_atom_7e8ad928(v92:GetItem()) then
			continue
		end

		local storeItem = manifest:GetStoreItem(v92:GetItem())
		local v93 = nil

		for _, v94 in ipairs(v90) do
			if __wf_atom_7e8ad928(v94) or manifest:GetStoreItem(v94.mItemType) ~= storeItem then
				continue
			end

			if __wf_atom_7e8ad928(v94) then
				v93 = v94
			else
				local storeItemInfo = module3.GetStoreItemInfo(mMovie, storeItem, { ItemInfo = v94 }, nil, nil, true)
				storeItemInfo.Manifest = manifest
				storeItemInfo.OwnsItem = true
				storeItemInfo.mItem = v94
				local v95 = not __wf_atom_7e8ad928(storeItemInfo.Type) and storeItemInfo.Type:IsA(__wf_atom_abf506db)

				if __wf_atom_7e8ad928(arsenalAvatar) then
					LogBug("mDummyAvatar is nil")
					v93 = v94
				elseif
					(p == v61.SECONDARY or p == v61.MELEE or v95)
					and not __wf_atom_7e8ad928(storeItemInfo.StoreItem)
				then
					local v96, v97 = fn47(storeItemInfo)
					storeItemInfo.SecondaryStatusIcon = {}
					storeItemInfo.SecondaryStatusScales = {}
					storeItemInfo.SecondaryStatusColors = {}

					if _T.TutorialStepTalisman and not _T.TutorialTalismanEquipped and p == v61.TOTEM then
						table.insert(storeItemInfo.SecondaryStatusIcon, newAlertIcon)
						table.insert(storeItemInfo.SecondaryStatusScales, 100)
					end

					local flag7 = true

					if v96 then
						v93 = v94

						for k, v99 in pairs(v97) do
							if not (arsenalAvatar:GetAttribute(k, true) < v99) then
								continue
							end

							flag7 = false
							break
						end
					else
						v93 = v94
					end

					local v98 = not __wf_atom_7e8ad928(storeItemInfo.Type)
						and storeItemInfo.Type == WeakResource("/SF/Weapons/Melee/TwoHand/MotherCorruptedGreatSword/MotherCorruptedGreatSwordMeleeWeapon")

					if flag7 then
						local v99 = fn48(storeItemInfo)

						for i = 0, 2 do
							if not (v99[i] > 0) then
								continue
							end

							local secondaryStatusIcon = storeItemInfo.SecondaryStatusIcon
							local v100

							if v98 then
								v100 = virtueIconsSmallCorrupt[i + 1]
							else
								v100 = virtueIconsSmall[i + 1]
							end

							table.insert(secondaryStatusIcon, v100)
							table.insert(storeItemInfo.SecondaryStatusScales, 100)
							local secondaryStatusColors = storeItemInfo.SecondaryStatusColors
							local v101

							if v98 then
								v101 = v77[i]
							else
								v101 = v76[i]
							end

							table.insert(secondaryStatusColors, v101)
						end
					end
				else
					v93 = v94
				end

				if p2 then
					table.insert(result, 1, storeItemInfo)
				else
					table.insert(result, storeItemInfo)
				end
			end
		end

		if not (__wf_atom_7e8ad928(v93) and p3) then
			continue
		end

		local storeItemInfo = module3.GetStoreItemInfo(mMovie, v92, nil, nil, true)
		local v94 = {
			Name = storeItemInfo.Name,
			Icon = storeItemInfo.Icon,
			OwnsItem = false,
			StoreItemInfo = storeItemInfo,
			DisableSelection = true
		}

		if p2 then
			table.insert(result, 1, v94)
		else
			table.insert(result, v94)
		end
	end

	return result
end

local function fn50()
	local storeItemInfos = {}

	for _, itemInfo in ipairs(skillTrees) do
		local __wf_atom_232fd31d = manifest:__wf_atom_232fd31d(itemInfo)

		if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
			continue
		end

		local storeItemInfo = module3.GetStoreItemInfo(
			mMovie,
			__wf_atom_232fd31d,
			{ ItemInfo = itemInfo },
			nil,
			nil,
			true
		)
		storeItemInfo.Manifest = manifest
		table.insert(storeItemInfos, storeItemInfo)
	end

	return storeItemInfos
end

local function fn51(p, p2)
	local rawItem = nil
	local v91 = nil
	local emptyTalismanIcon2 = nil
	local result

	if p == v61.PACT then
		result = fn49({ baseSoulType }, p, false, p2)
	elseif p == v61.MELEE then
		result = fn49(baseWeaponTypes, p, true, p2)
	elseif p == v61.CHEST then
		result = fn49({ baseBodyType }, p, false, p2)
		v91 = WeakResource("/SF/Upgrades/Skins/Body/UnderwearBody")
	elseif p == v61.LEGS then
		result = fn49({ baseLegsType }, p, false, p2)
		v91 = WeakResource("/SF/Upgrades/Skins/Legs/UnderwearLegs")
	elseif p == v61.HELM then
		result = fn49({ baseHelmType }, p, false, p2)
		v91 = WeakResource("/SF/Upgrades/Skins/Helmets/NoHelmet")
	elseif p == v61.TOTEM then
		result = fn49({ baseTotemType }, p, false, p2)
		rawItem = SF.WeaponSkinInfo()
		emptyTalismanIcon2 = emptyTalismanIcon
	elseif p == v61.SECONDARY then
		result = fn49(baseRangedWeaponTypes, p, false, p2)
		rawItem = SF.PresetEntry()
		emptyTalismanIcon2 = emptySidearmIcon
	elseif p == v61.IDOL then
		result = fn49({ baseIdolType }, p, false, p2)
	elseif p == v61.SKILLS then
		result = fn50()
	elseif p == v61.GUIDE then
		result = fn49({ baseGuideTypes }, p, false, p2)
	elseif p == v61.VIRTUEGEM then
		result = fn49({ baseVirtueGemTypes }, p, false, p2)
	else
		local v92 = p ~= v61.IDOL and {} or idolTextures
		local rawItem2 = { ItemId = MongoId(), ItemType = WeakResource() }
		result = {}

		for i = 1, #v92 do
			table.insert(result, { Icon = v92[i], RawItem = rawItem2 })
		end
	end

	if v91 ~= nil then
		for i, v93 in ipairs(result) do
			local v94

			if v93.RawItem ~= nil then
				v94 = v93.RawItem.mItemType
			end

			if v94 ~= v91 then
				continue
			end

			v93.IsUnequipItem = true
			table.remove(result, i)
			table.insert(result, 1, v93)
			break
		end
	end

	if rawItem == nil and emptyTalismanIcon2 == nil then
		return result
	end

	local emptyEquipmentIcon = emptyEquipmentIcon

	if emptyTalismanIcon2 ~= nil then
		emptyEquipmentIcon = emptyTalismanIcon2
	end

	table.insert(result, 1, {
		RawItem = rawItem,
		Name = mMovie:__wf_atom_8e9ac384("/SF/Language/Armour/UnequipItem", false),
		Description = "",
		Icon = emptyEquipmentIcon,
		CustomEntry = true,
		OwnsItem = true,
		IsUnequipItem = true
	})
	return result
end

local function fn52()
	fn29(0)

	if not __wf_atom_7e8ad928(gGameData) then
		for k, v90 in pairs(v7) do
			gGameData:__wf_atom_efd6bfce(k, v90)

			if v90:__wf_atom_48e5303e() then
				inventory:__wf_atom_337fac69(k, v90)
			end
		end
	end

	fn3(arsenalAvatar)
	fn34()
	flag = false
end

local function fn53()
	for k, v90 in pairs(v29.mSelectionLoader.mPendingSelection) do
		fn(k, v90, arsenalAvatar)
	end

	v29.mSelectionLoader.mPendingSelection = nil
	UpdateUnspentPactPoints()
end

local function fn54()
	local mPendingPreview = v29.mPreviewLoader.mPendingPreview

	if __wf_atom_7e8ad928(mPendingPreview) then
		return
	end

	local v90 = itemCategory
	local compareItemInfo = nil
	local v92 = v7[0]
	local v93 = nil

	if v90 == v61.MELEE then
		v93 = v92:__wf_atom_b369d77f(3)
	elseif v90 == v61.SECONDARY then
		v93 = v92:__wf_atom_b369d77f(2)
	elseif v90 == v61.HELM or v90 == v61.CHEST or v90 == v61.LEGS or v90 == v61.TOTEM then
		local __wf_atom_b369d77f = v92:__wf_atom_b369d77f(0)
		local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)

		if v90 == v61.HELM then
			v93 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(0)
		elseif v90 == v61.CHEST then
			v93 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(2)
		elseif v90 == v61.LEGS then
			v93 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(3)
		elseif v90 == v61.TOTEM then
			v93 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(5)
		end
	end

	if v93 then
		local v94 = fn51(v90) or {}

		for _, v95 in ipairs(v94) do
			if not (v90 ~= v61.SKILLS and v93 and (not __wf_atom_7e8ad928(v95.RawItem) and v93.mItemId == v95.RawItem.mItemId or v93.mItemType == v95.Type)) then
				continue
			end

			compareItemInfo = v95
		end
	end

	local weaponElementUpgradesAndFingerprints, v94 = module7.GetWeaponElementUpgradesAndFingerprints(mPendingPreview)
	local kind = mPendingPreview.Type
	local v95 = true

	if __wf_atom_7e8ad928(mPendingPreview.RawItem) then
		v20, v21 = module7.CreateProxyWeapon(
			statOwner,
			mPendingPreview.Type,
			mPendingPreview.Xp,
			weaponElementUpgradesAndFingerprints
		)

		if __wf_atom_7e8ad928(v20) then
			return
		end
	else
		v20, v21 = module7.CreateProxyWeapon(
			statOwner,
			mPendingPreview.RawItem.mItemType,
			mPendingPreview.Xp,
			weaponElementUpgradesAndFingerprints,
			v94,
			mPendingPreview.RawItem.mQuality,
			mPendingPreview.RawItem.mItemId,
			mPendingPreview.RawItem.mShiny,
			mPendingPreview.RawItem.mCreator
		)

		if not __wf_atom_7e8ad928(mPendingPreview.RawItem.mItemType) and __wf_atom_7e8ad928(v20) then
			return
		end
	end

	if
		compareItemInfo
		and compareItemInfo.RawItem
		and mPendingPreview.RawItem
		and compareItemInfo.RawItem.mItemId ~= mPendingPreview.RawItem.mItemId
	then
		local weaponElementUpgradesAndFingerprints2, v96 = module7.GetWeaponElementUpgradesAndFingerprints(compareItemInfo)
		kind = compareItemInfo.Type

		if __wf_atom_7e8ad928(compareItemInfo.RawItem) then
			v22, v23 = module7.CreateProxyWeapon(
				statOwner,
				compareItemInfo.Type,
				compareItemInfo.Xp,
				weaponElementUpgradesAndFingerprints2
			)
		else
			v22, v23 = module7.CreateProxyWeapon(
				statOwner,
				compareItemInfo.RawItem.mItemType,
				compareItemInfo.Xp,
				weaponElementUpgradesAndFingerprints2,
				v96,
				compareItemInfo.RawItem.mQuality,
				compareItemInfo.RawItem.mItemId,
				compareItemInfo.RawItem.mShiny,
				compareItemInfo.RawItem.mCreator
			)
		end
	end

	mPendingPreview.StatWeapon = v20
	mPendingPreview.StatOwner = statOwner
	mPendingPreview.StatCompareWeapon = v22

	if compareItemInfo then
		compareItemInfo.StatWeapon = v22
		compareItemInfo.StatOwner = statOwner
		compareItemInfo.StatCompareWeapon = v20
		compareItemInfo.InventoryFixedPosition = true
		compareItemInfo.MetaData = not compareItemInfo.MetaData and {} or compareItemInfo.MetaData
		compareItemInfo.MetaData.HidePrice = true
		mPendingPreview.CompareItemInfo = compareItemInfo
	end

	if __wf_atom_7e8ad928(v20) or not v20:IsA(__wf_atom_9df43583) then
		if flag5 or __wf_atom_7e8ad928(kind) or not (kind:IsA(baseHelmType) and Type(kind):__wf_atom_ee0f346d()) then
			mPendingPreview.SubtitleOverride = nil
		else
			local __wf_atom_b369d77f = v7[0]:__wf_atom_b369d77f(0)
			local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
			local __wf_atom_f9098661 = __wf_atom_eb82ab1f:__wf_atom_f9098661(4, 0)
			local color = __wf_atom_eb82ab1f:GetColor(4, 0)
			local v96 = __wf_atom_f9098661 and bit32.extract(color.red, 0) == 1
			local ternary = module.Ternary(
				v96,
				"/SF/Language/Armour/Arsenal_CloseHelmet",
				"/SF/Language/Armour/Arsenal_OpenHelmet"
			)
			mPendingPreview.SubtitleOverride = mMovie:__wf_atom_8e9ac384(
				module.Ternary(Engine.IsPlayingWithController(), "<MENU_GENERIC2>", "<MENU_RIGHT_CLICK>"),
				true
			) .. " " .. mMovie:__wf_atom_8e9ac384(ternary, true)
			mPendingPreview.SubtitleOverride = "<p><font color=\"" .. v16.SwapMotes .. "\">" .. mPendingPreview.SubtitleOverride .. "</font></p>"
		end
	else
		mMovie:__wf_atom_8e9ac384(
			module.Ternary(Engine.IsPlayingWithController(), "<MENU_GENERIC2>", "<MENU_RIGHT_CLICK>"),
			true
		)
		mPendingPreview.Refresh = false
	end

	module6.SetItemInfoPopupRect(
		mMovie,
		mPendingPreview,
		mMovie:__wf_atom_5e6e15c8(mPendingPreview.mClipName, 2),
		mMovie:__wf_atom_5e6e15c8(mPendingPreview.mClipName, 3),
		mMovie:__wf_atom_5e6e15c8(mPendingPreview.mClipName, 14),
		mMovie:__wf_atom_5e6e15c8(mPendingPreview.mClipName, 15)
	)
	v27 = true

	if
		flag5
		or mPendingPreview.ItemCategory ~= v61.HELM
		and mPendingPreview.ItemCategory ~= v61.GUIDE
		and mPendingPreview.ItemCategory ~= v61.LEGS
		and mPendingPreview.ItemCategory ~= v61.TOTEM
	then
		if __wf_atom_7e8ad928(mPendingPreview.Type) or not mPendingPreview.Type:IsA(baseVirtueGemTypes) then
			if flag5 then
				mPendingPreview.InventoryFixedPosition = true
				module6.SetItemInfoPopupRect(
					mMovie,
					mPendingPreview,
					mMovie:__wf_atom_5e6e15c8("InventoryContainer.InventoryGrid.Offset", 2) - 433,
					mMovie:__wf_atom_5e6e15c8("InventoryContainer.InventoryGrid.Offset", 3) - 21,
					math.max(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_97cd8326()),
					mMovie:__wf_atom_5e6e15c8(mPendingPreview.mClipName, 15),
					true
				)
			end
		else
			local storeItem = manifest:GetStoreItem(mPendingPreview.Type)

			if storeItem ~= nil then
				local infoPopup_Data = {
					CustomEntry = true,
					Name = Localize(storeItem:__wf_atom_014a76a2():c_str(), false),
					LocalizedDesc = Localize(storeItem:__wf_atom_3a3d2e39():c_str(), false)
				}
				module6.SetItemInfoPopupRect(
					mMovie,
					infoPopup_Data,
					mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtuesHint", 0) + 600,
					mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtuesHint", 1) + 525,
					mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtuesHint", 14),
					mMovie:__wf_atom_5e6e15c8("Virtues.Details.VirtuesHint", 15)
				)
				_T.InfoPopup_Data = infoPopup_Data
			end

			v27 = false
			v95 = false
		end
	else
		mPendingPreview.RightAligned = true
	end

	if not __wf_atom_7e8ad928(mPendingPreview.Type) and v95 then
		if mPendingPreview.MetaData == nil then
			mPendingPreview.MetaData = {}
		end

		mPendingPreview.MetaData.HidePrice = true
		_T.InfoPopup_Data = mPendingPreview
	end
end

local function fn55()
	if not __wf_atom_7e8ad928(v20) and v21 ~= nil then
		v21()
	end

	if not __wf_atom_7e8ad928(v22) and v23 ~= nil then
		v23()
	end

	v20 = nil
	v21 = nil
	v22 = nil
	v23 = nil
	_T.InfoPopup_Data = nil
end

local function fn56()
	flag = true
	v7 = {}

	if inventory then
		for i = 0, 3 - 1 do
			v7[i] = inventory:__wf_atom_c132f79b(i, inventory:__wf_atom_d25917b6(i))
		end
	else
		for i = 0, 3 - 1 do
			v7[i] = SF.LoadOutPreset()
		end
	end

	local v90 = fn40()
	v29.mSlotLoader:Release()

	if #v90 > 0 then
		fn29(2)
		v29.mSlotLoader:Load(v90, true)
	else
		fn52()
	end

	fn34(true)
	v32.mAttributeConfigU = v7[0].mAttributeConfigU
	v32.mAttributeConfigV = v7[0].mAttributeConfigV
	fn28(v7[0])
end

function OnNewPreset(p, p2)
	OnSaveLoadOutComplete(p, p2)

	if p and not __wf_atom_7e8ad928(p2) and p2 ~= "" then
		inventory:__wf_atom_89608f94(0, MongoId(p2))
		v7[0] = inventory:__wf_atom_c132f79b(0, inventory:__wf_atom_d25917b6(0))
	end

	UpdateLoadoutDropDown()
end

local function fn57(p)
	fn29(2)
	gGameData:__wf_atom_993aebc4(p)
end

local function fn58()
	local __wf_atom_23e1a032 = inventory:__wf_atom_23e1a032(0)
	local v90 = 0

	for i = 1, #__wf_atom_23e1a032 do
		if __wf_atom_7e8ad928(__wf_atom_23e1a032[i]) or __wf_atom_23e1a032[i].mRemove then
			continue
		end

		local __wf_atom_b369d77f = __wf_atom_23e1a032[i]:__wf_atom_b369d77f(0)

		if v90 <= __wf_atom_b369d77f.mCustSlot then
			v90 = __wf_atom_b369d77f.mCustSlot + 1
		end
	end

	return v90
end

local function fn59(mName)
	local copy = v7[0]:Copy()
	copy.mItemId.mId = SF.__wf_atom_b8679e91
	copy.mName = mName
	copy.mFavorite = false
	local __wf_atom_b369d77f = copy:__wf_atom_b369d77f(0)
	local mCustSlot = __wf_atom_b369d77f.mCustSlot
	__wf_atom_b369d77f.mCustSlot = fn58()
	local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(mCustSlot)
	inventory:__wf_atom_fe6304ae(__wf_atom_b369d77f.mItemId.mId, __wf_atom_b369d77f.mCustSlot, __wf_atom_eb82ab1f)
	copy:__wf_atom_0aa16242(0, __wf_atom_b369d77f)
	inventory:__wf_atom_337fac69(0, copy)
	fn57("OnNewPreset")
end

function ChangeLoadout(object)
	local mItemTypes = {}

	for i = 0, 6 - 1 do
		local __wf_atom_b369d77f = object:__wf_atom_b369d77f(i)

		if __wf_atom_7e8ad928(__wf_atom_b369d77f.mItemType) then
			local mItemId = __wf_atom_b369d77f.mItemId
			local __wf_atom_0ff4b555 = inventory:__wf_atom_0ff4b555(mItemId)

			if __wf_atom_7e8ad928(__wf_atom_0ff4b555) or __wf_atom_7e8ad928(__wf_atom_0ff4b555.mItemType) then
				local __wf_atom_4177a1ad = inventory:__wf_atom_4177a1ad(mItemId)

				if not (__wf_atom_7e8ad928(__wf_atom_4177a1ad) or __wf_atom_7e8ad928(__wf_atom_4177a1ad.mItemType)) then
					table.insert(mItemTypes, __wf_atom_4177a1ad.mItemType)
				end
			else
				table.insert(mItemTypes, __wf_atom_0ff4b555.mItemType)
			end
		else
			table.insert(mItemTypes, __wf_atom_b369d77f.mItemType)
		end
	end

	local __wf_atom_b369d77f = object:__wf_atom_b369d77f(0)
	local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)

	for i = 0, 8 - 1 do
		local __wf_atom_d78fd481 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(i)

		if __wf_atom_7e8ad928(__wf_atom_d78fd481) then
			continue
		end

		local __wf_atom_4177a1ad = inventory:__wf_atom_4177a1ad(__wf_atom_d78fd481.mItemId)

		if not (__wf_atom_7e8ad928(__wf_atom_4177a1ad) or __wf_atom_7e8ad928(__wf_atom_4177a1ad.mItemType)) then
			table.insert(mItemTypes, __wf_atom_4177a1ad.mItemType)
		end
	end

	local function fn60(object2, object3)
		local __wf_atom_b369d77f2 = object2:__wf_atom_b369d77f(0)
		local mCustSlot = __wf_atom_b369d77f2.mCustSlot
		local __wf_atom_eb82ab1f2 = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f2.mItemId):__wf_atom_eb82ab1f(mCustSlot)
		local __wf_atom_b369d77f3 = object3:__wf_atom_b369d77f(0)
		local mCustSlot2 = __wf_atom_b369d77f3.mCustSlot
		local __wf_atom_eb82ab1f3 = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f3.mItemId):__wf_atom_eb82ab1f(mCustSlot2)

		for _, v90 in ipairs({ 0, 1 }) do
			__wf_atom_eb82ab1f3:__wf_atom_2754430f(v90, __wf_atom_eb82ab1f2:GetColors(v90))
		end

		for _, v90 in ipairs({ 4, 6, 7 }) do
			__wf_atom_eb82ab1f3:__wf_atom_b6072b05(__wf_atom_eb82ab1f2:__wf_atom_d78fd481(v90), v90)
		end

		inventory:__wf_atom_fe6304ae(__wf_atom_b369d77f3.mItemId, __wf_atom_b369d77f3.mCustSlot, __wf_atom_eb82ab1f3)
	end

	v12 = nil
	flag = true
	asyncLoader:LoadMultipleResources("LoadoutSwap", mItemTypes, function()
		flag = false
		fn60(v7[0], object)
		inventory:__wf_atom_89608f94(0, object.mItemId)
		v7[0] = object
		gGameData:__wf_atom_efd6bfce(0, object)
		v30 = true
		InitializeItemPickers()
		gGameData:__wf_atom_a45f5d5f()
		fn3(arsenalAvatar)

		for i = 0, 2 do
			statOwner:__wf_atom_9189c3be(i, arsenalAvatar:GetAttribute(i, false))
		end

		local v90 = Resource(object.mAttributeItem)

		if not __wf_atom_7e8ad928(v90) and v90:__wf_atom_0a0a3205() then
			v32.mAttributeConfigU = v7[0].mAttributeConfigU
			v32.mAttributeConfigV = v7[0].mAttributeConfigV
			fn28(object)
		end

		fn34()
		fn29(0)
		fn5()
	end)
end

function OnSaveAndSwitchLoadout(p, p2)
	OnSaveLoadOutComplete(p, p2)
	ChangeLoadout(v36)
end

local function fn60(loadout)
	RevertVirtueChanges(true)
	v36 = loadout
	fn29(2)

	if v30 then
		fn57("OnSaveAndSwitchLoadout")
	else
		ChangeLoadout(v36)
	end
end

local function fn61()
	return gGameData:GetInventory():__wf_atom_59af3769(3)
end

local function fn62(mStoreItem, callback)
	local purchaseParams = SF.PurchaseParams()
	purchaseParams.mSource = 0
	purchaseParams.mSourceId = manifest:__wf_atom_5b41f63b()
	purchaseParams.mStoreItem = mStoreItem
	purchaseParams.mQuantity = 1
	purchaseParams.mSkipConfirm = true
	_T.DoPurchase(purchaseParams, function(p)
		if p ~= nil then
			if __wf_atom_7e8ad928(mMovie) then
				return
			end

			if p and callback ~= nil then
				callback()
			end
		end
	end)
end

local function fn63(fn64)
	local __wf_atom_232fd31d = manifest:__wf_atom_232fd31d((WeakResource("/SF/Types/StoreItems/SlotItems/PveBonusLoadoutBin")))
	local storeItemPriceObject = module2.GetStoreItemPriceObject(__wf_atom_232fd31d)
	local storeItemInfo = module3.GetStoreItemInfo(mMovie, __wf_atom_232fd31d, nil, nil, nil, true)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<PREMIUM_CURRENCY>" .. storeItemPriceObject.UsePrice, true)
	local name = storeItemInfo.Name
	local colorHTMLMessage = module5.ColorHTMLMessage("/SF/Language/Vendor/PurchaseLoadoutSlot", {
		COST = __wf_atom_8e9ac384,
		ITEM = name
	})
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = colorHTMLMessage
	dialogSettings.titleString = "/SF/Language/Vendor/LoadoutsMaxed"
	dialogSettings.firstString = "/Menu/Confirm_Item_Yes"
	dialogSettings.secondString = "/Menu/Confirm_Item_No"
	dialogSettings:SetCallback(function(p)
		if p ~= 4 then
			return
		end

		fn62(__wf_atom_232fd31d, fn64)
	end)
	dialogSettings.icon = __wf_atom_232fd31d:__wf_atom_5b41f63b() .. ",100,100,nil,nil,/Lotus/Fx/Interface/IdentifyResourceFanfare"
	module.ShowCustomMessage(dialogSettings)
end

function ReselectEquippedLoadout()
	inventory:__wf_atom_d25917b6(0)

	for i = 1, #v19.mElements do
		if __wf_atom_7e8ad928(v19.mElements[i]) or __wf_atom_7e8ad928(v19.mElements[i].Preset) then
			continue
		end

		local _preset = v19.mElements[i].Preset
	end
end

function UpdateLoadoutDropDown()
	v19:RemoveElements(true, true)
	local __wf_atom_23e1a032 = inventory:__wf_atom_23e1a032(0)
	local __wf_atom_d25917b6 = inventory:__wf_atom_d25917b6(0)
	local id = 1
	local v91 = nil

	for i = 1, #__wf_atom_23e1a032 do
		if __wf_atom_7e8ad928(__wf_atom_23e1a032[i]) or __wf_atom_23e1a032[i].mRemove then
			continue
		end

		if v19:GetElementById(id) == nil then
			if __wf_atom_7e8ad928(__wf_atom_23e1a032[i].mName) or __wf_atom_23e1a032[i].mName == "" then
				__wf_atom_23e1a032[i].mName = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/DefaultLoadoutName", false)
			end

			v19:InsertElement(i, {
				Name = __wf_atom_23e1a032[i].mName,
				Loadout = __wf_atom_23e1a032[i],
				Id = id
			})
		end

		if __wf_atom_23e1a032[i].mItemId == __wf_atom_d25917b6 then
			v91 = id
		end

		id += 1
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/CreateNewLoadout", false)
	v19:AddElement({ Name = __wf_atom_8e9ac384, Id = 0 })

	if not __wf_atom_7e8ad928(v91) then
		v19:SelectElementById(v91)
	end

	v19:Redraw(nil, true, true)
	return id, v91
end

function InitializeLoadoutDropdown()
	local module12 = require("SF.Interface.Components.DropDownMenu")
	v19 = module12.Create(getfenv(1), "LoadoutDropdown", {
		mShowHighlight = true,
		mMainButtonHeight = 44
	})
	UpdateLoadoutDropDown()

	function v19.mOnSelectedCallback(p)
		if flag then
			return false
		end

		if not __wf_atom_7e8ad928(p.Loadout) then
			fn60(p.Loadout)
		elseif #inventory:__wf_atom_23e1a032(0) < fn61() then
			module5.ShowInputDialog(
				mMovie,
				"/SF/Language/Menu/CreateNewLoadout",
				"",
				14,
				"InputNewLoadoutName",
				"InputNewLoadoutNameOSK"
			)
		else
			fn63(function()
				module5.ShowInputDialog(
					mMovie,
					"/SF/Language/Menu/CreateNewLoadout",
					"",
					14,
					"InputNewLoadoutName",
					"InputNewLoadoutNameOSK"
				)
			end)
		end
	end

	mMovie:OverrideMaterial("RenameButton.Background", _G.UIMaterial_UnfocusedTabBorder)
	mMovie:SetCallbacks("RenameButton", "RenameLoadoutFocused", "RenameLoadoutUnfocused", "RenameLoadoutPressed", nil)
end

function RenameLoadoutFocused()
	if flag4 then
		return
	end

	mMovie:OverrideMaterial("RenameButton.Background", _G.UIMaterial_FocusedTabBorder)
end

function RenameLoadoutUnfocused()
	if flag4 then
		return
	end

	mMovie:OverrideMaterial("RenameButton.Background", _G.UIMaterial_UnfocusedTabBorder)
end

local function fn64()
	return false
end

function RenameLoadoutPressed()
	if flag4 then
		return
	end

	local v90 = fn64() and { extraTag = "/SF/Language/Menu/DeleteLoadout" } or nil
	module5.ShowInputDialog(
		mMovie,
		"/SF/Language/Menu/RenameLoadout",
		"",
		14,
		"InputRenameLoadoutName",
		"InputRenameLoadoutNameOSK",
		v90
	)
end

local function fn65(mName)
	v7[0].mName = mName
	inventory:__wf_atom_337fac69(0, v7[0])
	fn57("OnNewPreset")
end

local function fn66()
	v7[0].mRemove = true
	inventory:__wf_atom_337fac69(0, v7[0])
	fn57("OnNewPreset")
end

function InputRenameLoadoutName(p, mName)
	if tonumber(p) == 5 then
		return
	end

	if tonumber(p) == 6 then
		fn66()
		return
	end

	if mName == nil or mName == "" then
		return
	end

	local invalidNameCharacters = module.GetInvalidNameCharacters(mName, " ")

	if invalidNameCharacters > 0 then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
			mName,
			invalidNameCharacters,
			invalidNameCharacters
		))
	else
		fn65(mName)
	end
end

function InputRenameLoadoutNameOSK(p, mName)
	if p or (mName == nil or mName == "") then
		return
	end

	local invalidNameCharacters = module.GetInvalidNameCharacters(mName, " ")

	if invalidNameCharacters > 0 then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
			mName,
			invalidNameCharacters,
			invalidNameCharacters
		))
	else
		fn65(mName)
	end
end

function InputNewLoadoutName(p, mName)
	if tonumber(p) == 5 then
		ReselectEquippedLoadout()
		return
	end

	if mName == nil or mName == "" then
		ReselectEquippedLoadout()
		return
	end

	local invalidNameCharacters = module.GetInvalidNameCharacters(mName, " ")

	if invalidNameCharacters > 0 then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
			mName,
			invalidNameCharacters,
			invalidNameCharacters
		))
	else
		fn59(mName)
	end
end

function InputNewLoadoutNameOSK(p, mName)
	if p then
		ReselectEquippedLoadout()
		return
	end

	if mName == nil or mName == "" then
		ReselectEquippedLoadout()
		return
	end

	local invalidNameCharacters = module.GetInvalidNameCharacters(mName, " ")

	if invalidNameCharacters > 0 then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
			mName,
			invalidNameCharacters,
			invalidNameCharacters
		))
	else
		fn59(mName)
	end
end

local function fn67()
	if not flag5 then
		return
	end

	flag5 = false
	v72:UnfocusElement(v72.mCurrentElementIndex)
	v75 = nil
	InitializeItemPickers()
	local mLevel, v91

	if __wf_atom_7e8ad928(gGameData) then
		mLevel = 0
		v91 = 0
	else
		local __wf_atom_d5bed0b3 = gGameData:__wf_atom_d5bed0b3()
		mLevel = __wf_atom_c67f9605:__wf_atom_f7423942(__wf_atom_d5bed0b3)
		local __wf_atom_e372699a = __wf_atom_c67f9605:__wf_atom_e372699a(__wf_atom_d5bed0b3)
		local __wf_atom_c927661a = __wf_atom_c67f9605:__wf_atom_c927661a(__wf_atom_d5bed0b3)
		v91 = (__wf_atom_d5bed0b3 - __wf_atom_e372699a) / (__wf_atom_c927661a - __wf_atom_e372699a)
	end

	local v92 = {
		mMovie = mMovie,
		mLabel = v6:__wf_atom_6be84646(),
		mLevel = mLevel,
		mRankProgress = v91 * 100,
		mOverwriteCurrencies = false
	}

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v92)
	end

	itemCategory = nil
	v74 = nil
	mFadeUnownedItems = false

	if v12 ~= nil then
		local v93 = v12
		local v94 = fn22(v12)
		fn23(v94)
		fn26(v94, v93)
	end

	__wf_atom_ec43d06e(mMovie, "InventoryContainer", 8, { 12 }, { 0 }, 0.25, 0, function()
		mMovie:__wf_atom_2dedec1a("InventoryContainer", 13, false)
	end)
	__wf_atom_ec43d06e(mMovie, "LoadoutDropdown", 8, { 12 }, { 100 }, 0.25, 0, function()
		mMovie:__wf_atom_2dedec1a("LoadoutDropdown", 67, true)
	end)
	__wf_atom_ec43d06e(mMovie, "RenameButton", 8, { 12 }, { 100 }, 0.25, 0, function()
		mMovie:__wf_atom_2dedec1a("RenameButton", 67, true)
	end)
	module5.HideBackground({ mFadeTime = 0.35 })

	for _, v93 in ipairs(v64) do
		local clip = v93.Clip
		__wf_atom_ec43d06e(mMovie, clip, 8, { 12 }, { 100 }, 0.25)
		__wf_atom_ec43d06e(mMovie, clip .. ".Hover", 8, { 12 }, { 100 }, 0.25)
		mMovie:__wf_atom_2dedec1a(clip, 67, true)
	end

	fn15(v, 0.25)
	UpdateButtons()
	fn5()
end

fn6 = function(p)
	if v74 == nil then
		return
	end

	local mElements

	if p then
		mElements = v72.mElements
	else
		mElements = fn51(v74.ItemCategory, true)
		v72:RemoveElements(true, true)
	end

	local v90 = mElements or {}

	for i, v91 in ipairs(v90) do
		v91.OriginalSort = i
	end

	table.sort(v90, function(a, b)
		if a.IsUnequipItem ~= b.IsUnequipItem then
			return a.IsUnequipItem == true
		end

		local v91 = not __wf_atom_7e8ad928(a.mItem) and a.mItem.mFavorite == true

		if v91 ~= (not __wf_atom_7e8ad928(b.mItem) and b.mItem.mFavorite == true) then
			return v91
		end

		local v92 = not __wf_atom_7e8ad928(a.mItem) and a.mItem.mIsNew == true

		if v92 == (not __wf_atom_7e8ad928(b.mItem) and b.mItem.mIsNew == true) then
			return a.OriginalSort < b.OriginalSort
		end

		return v92
	end)
	local v91 = v7[0]
	local v92 = #v90 > 0 and v90[1].CustomEntry and 1 or -1
	local count = 0
	local v93 = -1

	for _, v94 in ipairs(v90) do
		local storeItem

		if not (__wf_atom_7e8ad928(v94.StoreItemInfo) or __wf_atom_7e8ad928(v94.StoreItemInfo.StoreItem)) then
			storeItem = v94.StoreItemInfo.StoreItem
		end

		if not __wf_atom_7e8ad928(v94.StoreItem) then
			storeItem = v94.StoreItem
		end

		if not v94.CustomEntry then
			if __wf_atom_7e8ad928(storeItem) then
				continue
			end

			local item = storeItem:GetItem()

			if
				not item:IsA(WeakResource("/SF/Upgrades/Skins/Helmets/NoHelmet"))
				and not item:IsA(WeakResource("/SF/Upgrades/Skins/Legs/UnderwearLegs"))
				and not item:IsA(WeakResource("/SF/Upgrades/Skins/Body/UnderwearBody"))
				and not v94.OwnsItem
				and (not storeItem:__wf_atom_1f093091() or storeItem:__wf_atom_e063e3c3())
			then
				continue
			end
		end

		if v94.OwnsItem or mFadeUnownedItems and not v94.OwnsItem then
			count += 1
		end

		if not v94.CustomEntry then
			if v74.ItemCategory == v61.VIRTUEGEM then
				local mAttributeItem2 = v91.mAttributeItem

				if v94.Type == mAttributeItem2 then
					v75 = v94
					v93 = count
				end
			elseif v75 == nil then
				for i = 0, 6 - 1 do
					local __wf_atom_b369d77f = v91:__wf_atom_b369d77f(i)

					if v94.RawItem == nil or v94.RawItem.mItemId == nil then
						break
					end

					if v94.RawItem.mItemId == __wf_atom_b369d77f.mItemId then
						v75 = v94
						v93 = count
					end

					if __wf_atom_7e8ad928(v74.Type) or not v74.Type:IsA(__wf_atom_abf506db) then
						continue
					end

					local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)

					for j = 0, 8 - 1 do
						local __wf_atom_d78fd481 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(j)

						if __wf_atom_7e8ad928(__wf_atom_d78fd481) then
							continue
						end

						local mItemId = __wf_atom_d78fd481.mItemId
						local v95 = not mItemId:__wf_atom_b70c3343() and mItemId:__wf_atom_8598f3a9()

						if v95 and mItemId == v94.RawItem.mItemId then
							v75 = v94
							v93 = count
							break
						elseif not v95 and v94.Type == v74.Type then
							v92 = count
						end
					end
				end
			elseif
				v94.RawItem ~= nil
				and v94.RawItem.mItemId ~= nil
				and v75.RawItem ~= nil
				and v75.RawItem.mItemId ~= nil
				and v94.RawItem.mItemId == v75.RawItem.mItemId
				and v94.RawItem.mItemType == v75.RawItem.mItemType
			then
				v75 = v94
				v93 = count
			end
		end

		if not (v94.OwnsItem or mFadeUnownedItems and not v94.OwnsItem) then
			continue
		end

		if v94.MetaData == nil then
			v94.MetaData = {}
		end

		v94.MetaData.HidePrice = true

		if not p then
			v72:AddElement(v94, true)
		end
	end

	local v94

	if v93 == -1 then
		v94 = v92 ~= -1
	else
		v94 = false
	end

	if v94 then
		v93 = v92
	end

	if v75 ~= nil then
		v75.Equipped = true
	end

	if p then
		v72:RunForAllElements(function(p2)
			v72.ITEM_UTIL.Update(mMovie, p2.mClipName, p2, v72)
			v72.mElementDrawCallback(p2)
		end)
		return
	end

	v72:Redraw(nil, true, true)
	v72:UpdateWidth()

	if v93 ~= -1 then
		v72:SelectElementById(v93)
		_T.InfoPopup_Data = nil
	end
end

function UpdateButtons(p)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	local v90 = {}
	local v91 = p == nil and {} or p
	local label

	if flag5 then
		label = "/SF/Language/Menu/Menu_Back"
		local ternary = module.Ternary(mFadeUnownedItems, "<FULL_CHECK>", "<EMPTY_CHECK>")

		if v91.HideUnownedToggle == nil or not v91.HideUnownedToggle then
			table.insert(v90, {
				Label = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/Arsenal_ToggleUnowned", false) .. " " .. ternary,
				CallBack = function()
					mFadeUnownedItems = not mFadeUnownedItems
					v72.mFadeUnownedItems = mFadeUnownedItems
					fn6()
					UpdateButtons()
				end
			})
		end
	else
		label = "/Lotus/Language/Menu/Exit"
	end

	table.insert(v90, {
		Label = label,
		CallBack = function()
			mMovie:Execute("onKeyUp_MENU_CANCEL", nil)
		end,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v90, getfenv(1))
	end
end

local function fn68(p, mId, value)
	local module12 = require("EE.Interface.Components.Grid")
	local ternary = module.Ternary(mId == v61.SKILLS, 6, value or 1)
	local v90 = math.ceil(value / ternary)
	local grid = module12.CreateGrid(mMovie, p, nil, ternary, v90)
	grid:SetCallbacks("EquipmentGridItemPressed", "EquipmentGridItemFocused", "EquipmentGridItemUnfocused")
	grid.mColumnSeparation = 12
	grid.mRowSeparation = 6
	grid.mId = mId
	grid._Equip_CalculateY = grid.CalculateY

	function grid.CalculateY(object, p2)
		return (object:_Equip_CalculateY(p2))
	end

	function grid.mOnFocusedCallback(mPendingPreview)
		__wf_atom_86cbd68d(mMovie, mPendingPreview.mClipName .. ".swapDepths", 1500)
		module.PlaySound(_G.UISound_Focus)

		if
			mPendingPreview.Name
			and mPendingPreview.Name == mMovie:__wf_atom_8e9ac384("/SF/Language/Armour/UnequipItem", false)
			or mPendingPreview.Name == mMovie:__wf_atom_8e9ac384("/SF/Language/Weapons/None", false)
		then
			_T.gToolTip = mMovie:__wf_atom_8e9ac384("/SF/Language/Weapons/None", false)
		end

		if v29.mPreviewLoader ~= nil then
			local v91 = nil

			if __wf_atom_7e8ad928(mPendingPreview.RawItem) or __wf_atom_7e8ad928(mPendingPreview.RawItem.mItemType) then
				if mPendingPreview.FullName then
					v91 = { mPendingPreview.FullName }
				end
			else
				v91 = { mPendingPreview.RawItem.mItemType:__wf_atom_5b41f63b() }

				if mPendingPreview.RawItem.mItemType:IsA(__wf_atom_2fc5c2e8) then
					local __wf_atom_43563387 = mPendingPreview.RawItem:__wf_atom_43563387()

					for _, v92 in ipairs(__wf_atom_43563387) do
						if not __wf_atom_7e8ad928(v92.mType) then
							table.insert(v91, v92.mType:__wf_atom_5b41f63b())
						end
					end
				end

				if not __wf_atom_7e8ad928(mPendingPreview.RawItem.mUpgradeType) then
					table.insert(v91, mPendingPreview.RawItem.mUpgradeType:__wf_atom_5b41f63b())
				end
			end

			v29.mPreviewLoader:Load(v91, true)
			v29.mPreviewLoader.mPendingPreview = mPendingPreview
			v24 = mPendingPreview
		end
	end

	function grid.mOnUnfocusedCallback(_)
		if v29.mPreviewLoader ~= nil then
			v29.mPreviewLoader:Release()
		end

		_T.gToolTip = nil
		v24 = nil
	end

	function grid.mElementDrawCallback(data)
		local mClipName = data.mClipName
		mMovie:__wf_atom_e57658c2(mClipName, 16, __wf_atom_104bfe98(-0.75, 0.75, math.random()))
		mMovie:__wf_atom_7f57ab2f(mClipName, "StatusIcon", 13, false)
		local v91 = fn9()

		if v91 then
			mMovie:__wf_atom_c90af43a(mClipName .. ".Rays", equipGridGlowTextures[3])
			mMovie:__wf_atom_c90af43a(mClipName .. ".Box", equipGridGlowTextures[2])
			mMovie:__wf_atom_c90af43a(mClipName .. ".Glow", equipGridBackerTextures[5])
		else
			mMovie:__wf_atom_c90af43a(mClipName .. ".Rays", equipGridGlowTextures[1])
			mMovie:__wf_atom_c90af43a(mClipName .. ".Box", equipGridGlowTextures[2])
			mMovie:__wf_atom_c90af43a(mClipName .. ".Glow", equipGridBackerTextures[1])
		end

		mMovie:__wf_atom_c90af43a(mClipName .. ".Border", equipGridBorderTextures[3])
		mMovie:__wf_atom_7f57ab2f(mClipName, "Border", 13, false)
		mMovie:__wf_atom_4c1c1986(mClipName, "Border", 12, 0)
		mMovie:__wf_atom_4c1c1986(mClipName, "Border", 15, 150)
		mMovie:__wf_atom_4c1c1986(mClipName, "Border", 14, 150)
		mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 15, 160)
		mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 14, 160)
		mMovie:__wf_atom_4c1c1986(mClipName, "Glow", 12, 95)
		mMovie:__wf_atom_4c1c1986(mClipName, "Rays", 15, 220)
		mMovie:__wf_atom_4c1c1986(mClipName, "Rays", 14, 220)
		mMovie:__wf_atom_4c1c1986(mClipName, "Box", 15, 220)
		mMovie:__wf_atom_4c1c1986(mClipName, "Box", 14, 220)

		if data.ItemCategory == v61.MELEE or data.ItemCategory == v61.SECONDARY then
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 15, 80)
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 14, 80)
			mMovie:OverrideMaterial(mClipName .. ".Icon", nil)
		else
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 15, 105)
			mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 14, 105)
			mMovie:OverrideMaterial(mClipName .. ".Icon", equipmentIconMask)
		end

		mMovie:__wf_atom_4c1c1986(mClipName, "Rays", 12, 40)
		mMovie:__wf_atom_4c1c1986(mClipName, "Box", 12, 70)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Glow", 13, true)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Icon", 13, not __wf_atom_7e8ad928(data.Icon))
		mMovie:__wf_atom_7f57ab2f(mClipName, "Rays", 13, false)
		mMovie:__wf_atom_7f57ab2f(mClipName, "Box", 13, false)

		if not __wf_atom_7e8ad928(data.Icon) then
			mMovie:__wf_atom_c90af43a(mClipName .. ".Icon", data.Icon)

			if module6.IsGreyscale(data.Icon) then
				local mMovie = mMovie
				local v94

				if v91 then
					v94 = _G.UIColor_LightGrey
				else
					v94 = _G.UIColor_DarkBrown
				end

				mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 11, v94)
			else
				mMovie:__wf_atom_4c1c1986(mClipName, "Icon", 11, 16777215)
			end
		end

		local v92 = not __wf_atom_7e8ad928(data.Type) and data.Type:IsA(__wf_atom_abf506db)
		local v93 = {}

		if _T.TutorialStepTalisman and not _T.TutorialTalismanEquipped and data.ItemCategory == v61.TOTEM then
			table.insert(v93, { texture = newAlertIcon, scale = 100 })
		end

		if data.ItemCategory == v61.MELEE or data.ItemCategory == v61.SECONDARY or v92 then
			local v94, v95 = fn47(data)
			local flag7 = true

			if v94 then
				for k, v97 in pairs(v95) do
					if not (arsenalAvatar:GetAttribute(k, true) < v97) then
						continue
					end

					flag7 = false
					break
				end
			end

			local v96 = not __wf_atom_7e8ad928(data.Type)
				and data.Type == WeakResource("/SF/Weapons/Melee/TwoHand/MotherCorruptedGreatSword/MotherCorruptedGreatSwordMeleeWeapon")

			if flag7 then
				local v97 = fn48(data)

				for i = 0, 2 do
					if v97[i] <= 0 then
						continue
					end

					local texture

					if v96 then
						texture = virtueIconsSmallCorrupt[i + 1]
					else
						texture = virtueIconsSmall[i + 1]
					end

					local color

					if v96 then
						color = v77[i]
					else
						color = v76[i]
					end

					table.insert(v93, { texture = texture, color = color })
				end
			end
		end

		for i, v94 in ipairs(v93) do
			local ternary2 = module.Ternary(i == 1, "", i)
			local v95 = data.mClipName .. ".StatusIcon"
			local v96 = v95 .. ternary2

			if not mMovie:__wf_atom_253d7085(v96) then
				__wf_atom_86cbd68d(mMovie, v95 .. ".duplicateMovieClip", "StatusIcon" .. ternary2, ternary2)
			end

			local v97 = (i - 1) * module.ToRad(30) + module.ToRad(210)
			local v98 = math.cos(v97) * 54
			local v99 = math.sin(v97) * 54
			mMovie:__wf_atom_e57658c2(v96, 0, v98)
			mMovie:__wf_atom_e57658c2(v96, 1, v99)
			mMovie:__wf_atom_c90af43a(v96, v94.texture)
			mMovie:__wf_atom_e57658c2(v96, 11, v94.color or 16777215)
			mMovie:__wf_atom_e57658c2(v96, 5, v94.scale or 75)
			mMovie:__wf_atom_e57658c2(v96, 6, v94.scale or 75)
			mMovie:__wf_atom_2dedec1a(v96, 13, true)
		end

		for i = #v93 + 1, 6 do
			local ternary2 = module.Ternary(i == 1, "", i)
			local v94 = (data.mClipName .. ".StatusIcon") .. ternary2

			if not mMovie:__wf_atom_253d7085(v94) then
				break
			end

			mMovie:__wf_atom_2dedec1a(v94, 13, false)
		end

		mMovie:__wf_atom_7f57ab2f(data.mClipName, "SkillDiamond", 13, false)
	end

	function grid.mOnSelectedCallback(p2)
		itemCategory = nil

		if
			grid.mId ~= v61.MELEE
			and grid.mId ~= v61.SECONDARY
			and grid.mId ~= v61.HELM
			and grid.mId ~= v61.CHEST
			and grid.mId ~= v61.LEGS
			and grid.mId ~= v61.TOTEM
			and grid.mId ~= v61.GUIDE
			and grid.mId ~= v61.VIRTUEGEM
		then
			return
		end

		if v29.mSelectionLoader.mState == v28.LS_LOADING then
			return
		end

		flag5 = true
		_T.InfoPopup_Data = nil
		itemCategory = p2.ItemCategory
		v74 = p2

		if v60 then
			v60:SetVisibility(false)
		end

		module.PlaySound(_G.UISound_Select)
		local module13 = require("EE.Interface.Components.ItemGrid")
		local v91 = { mColumns = 4, mCanSelectItem = true, mScrollAlwaysVisible = false }

		if v72 == nil then
			v72 = module13.Create(getfenv(1), "InventoryContainer.InventoryGrid", v91)

			function v72:mElementDrawCallback()
				local v92 = not __wf_atom_7e8ad928(self.Type) and self.Type:IsA(__wf_atom_abf506db)

				if
					(itemCategory == v61.SECONDARY or itemCategory == v61.MELEE or v92)
					and self.OwnsItem
					and not __wf_atom_7e8ad928(self.StoreItem)
				then
					self.SecondaryStatusPositions = {}

					for i = 1, #self.SecondaryStatusIcon do
						table.insert(self.SecondaryStatusPositions, -47 + 24 * (i - 1))
					end

					v72.ITEM_UTIL.SetSecondaryStatus(mMovie, self.mClipName, self, v72)
				end
			end
		else
			v72:RemoveElements(true, true)
		end

		function v72:mOnFocusedCallback()
			if v29.mPreviewLoader == nil then
				return
			end

			local v92 = nil

			if module6.CanDismantleItem(self) and v57 == nil then
				self.BottomLeftCalloutOverride = mMovie:__wf_atom_8e9ac384(
					module.Ternary(Engine.IsPlayingWithController(), "<MENU_GENERIC2>", "<MENU_RIGHT_CLICK>"),
					true
				) .. " " .. mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/Dismantle", true)
				v56 = self
			else
				self.BottomLeftCalloutOverride = nil
				v56 = nil
			end

			if __wf_atom_7e8ad928(self.RawItem) or __wf_atom_7e8ad928(self.RawItem.mItemType) then
				if self.FullName then
					v92 = { self.FullName }
				end
			else
				v92 = { self.RawItem.mItemType:__wf_atom_5b41f63b() }

				if self.RawItem.mItemType:IsA(__wf_atom_2fc5c2e8) then
					local __wf_atom_43563387 = self.RawItem:__wf_atom_43563387()

					for _, v93 in ipairs(__wf_atom_43563387) do
						if not __wf_atom_7e8ad928(v93.mType) then
							table.insert(v92, v93.mType:__wf_atom_5b41f63b())
						end
					end
				end

				if not __wf_atom_7e8ad928(self.RawItem.mUpgradeType) then
					table.insert(v92, self.RawItem.mUpgradeType:__wf_atom_5b41f63b())
				end

				if
					self ~= nil
					and not __wf_atom_7e8ad928(self.RawItem)
					and not __wf_atom_7e8ad928(self.RawItem.mItemType)
					and self.RawItem.mItemType:IsA(baseVirtueGemTypes)
				then
					ApplyVirtueGem(self.RawItem.mItemType)
				end
			end

			v29.mPreviewLoader:Load(v92, true)
			v29.mPreviewLoader.mPendingPreview = self
			v24 = self

			if self.Name and self.Name == mMovie:__wf_atom_8e9ac384("/SF/Language/Armour/UnequipItem", false) then
				self.StatusIconTooltip = self.Name
			end
		end

		function v72.mOnUnfocusedCallback(p3)
			if v29.mPreviewLoader ~= nil then
				v29.mPreviewLoader:Release()
			end

			_T.gToolTip = nil
			v24 = nil

			if
				p3 ~= nil
				and not __wf_atom_7e8ad928(p3.RawItem)
				and not __wf_atom_7e8ad928(p3.RawItem.mItemType)
				and p3.RawItem.mItemType:IsA(baseVirtueGemTypes)
				and mAttributeItem ~= nil
			then
				ApplyVirtueGem(mAttributeItem)
			end
		end

		function v72:mOnSelectedCallback()
			local v92 = {}

			if v75 ~= nil and self.UID ~= nil and self.UID == v75.UID then
				return
			end

			local v93 = false

			if v75 == nil then
				v75 = self
				v75.Equipped = true
				v93 = true
			else
				v75.Equipped = false
			end

			local v94 = self.Type ~= v75.Type or v93
			local v95 = not __wf_atom_7e8ad928(self.RawItem)
				and not __wf_atom_7e8ad928(v75.RawItem)
				and self.RawItem.mItemId ~= v75.RawItem.mItemId
				or v94
			v75 = self

			if self.Type then
				if self.Type:IsA(__wf_atom_9df43583) then
					local __wf_atom_3dbd0893 = gGameData:__wf_atom_3dbd0893(self.Type)
					table.move(__wf_atom_3dbd0893, 1, #__wf_atom_3dbd0893, #v92 + 1, v92)
				else
					table.insert(v92, self.Type:__wf_atom_5b41f63b())
				end
			end

			if module6.MarkItemIsNew(self, false) then
				v72.ITEM_UTIL.Update(mMovie, self.mClipName, self, v72)
				self.Refresh = true
				v30 = true
			end

			if v95 then
				v29.mSelectionLoader:Release()
				v29.mSelectionLoader:Load(v92, true)
				local mSelectionLoader = v29.mSelectionLoader
				local statesByItemCategory = { [p2.ItemCategory] = self }
				mSelectionLoader.mPendingSelection = statesByItemCategory

				if
					v29.mPreviewLoader ~= nil
					and v29.mPreviewLoader.mResLoader ~= nil
					and v29.mPreviewLoader.mResLoader:__wf_atom_86399a47()
				then
					self.Refresh = true
					fn55()
					fn54()
				end
			end
		end

		local v92 = {}

		if grid.mId == v61.VIRTUEGEM then
			v72:SetTitle("/SF/Language/Armour/VirtuePrism")
			v92.HideUnownedToggle = true
		else
			v72:SetTitle("/SF/Language/Armour/EquipItem")
		end

		fn6(false)
		UpdateButtons(v92)

		if _T.HideCurrencyBar ~= nil then
			_T.HideCurrencyBar(mMovie)
		end

		mMovie:__wf_atom_2dedec1a("InventoryContainer", 13, true)
		mMovie:__wf_atom_e57658c2("InventoryContainer", 12, 0)
		__wf_atom_ec43d06e(mMovie, "InventoryContainer", 8, { 12 }, { 100 }, 0.25)
		mMovie:__wf_atom_2dedec1a("LoadoutDropdown", 67, false)
		mMovie:__wf_atom_2dedec1a("RenameButton", 67, false)
		__wf_atom_ec43d06e(mMovie, "LoadoutDropdown", 8, { 12 }, { 0 }, 0.25)
		__wf_atom_ec43d06e(mMovie, "RenameButton", 8, { 12 }, { 0 }, 0.25)
		local v93 = v3

		for _, v94 in ipairs(v64) do
			if grid.mId == v61.VIRTUEGEM and v94.Clip == "Virtues" then
				__wf_atom_ec43d06e(mMovie, "Virtues.Hover", 8, { 12 }, { 0 }, 0.25)
				__wf_atom_ec43d06e(mMovie, "Virtues.Label", 8, { 12 }, { 0 }, 0.25)
			else
				__wf_atom_ec43d06e(mMovie, v94.Clip, 8, { 12 }, { 0 }, 0.25)
				mMovie:__wf_atom_2dedec1a(v94.Clip, 67, false)
			end
		end

		if p2.ItemCategory == v61.GUIDE then
			v93 = v4
		elseif p2.ItemCategory == v61.VIRTUEGEM then
			v93 = v5
			mMovie:__wf_atom_2dedec1a("Virtues", 67, true)
		end

		fn15(v93, 0.25)
		module5.ShowBackground({ mFade = module.RIGHT_ALIGNED })
		local elementById = grid:GetElementById(grid.mCurrSelectedId)

		if not (__wf_atom_7e8ad928(elementById) or __wf_atom_7e8ad928(elementById.mClipName)) then
			mMovie:__wf_atom_c90af43a(elementById.mClipName .. ".Border", equipGridBorderTextures[1])
			mMovie:__wf_atom_7f57ab2f(elementById.mClipName, "Glow", 13, false)
			mMovie:__wf_atom_7f57ab2f(elementById.mClipName, "Rays", 13, false)
			mMovie:__wf_atom_4c1c1986(elementById.mClipName, "Box", 11, 10261102)
		end

		grid.mCurrSelectedId = p2.Id
	end

	return grid
end

function UpdateRotatingUI(p)
	if v82 == p or flag5 then
		return
	end

	local v90, v91

	if p then
		v90 = 100
		v91 = 0.6
	else
		v90 = 0
		v91 = 0.3
	end

	v82 = p

	if v60 then
		v60:SetVisibility(p)
	end

	for _, v92 in ipairs(v64) do
		if not (not flag4 or v92.Clip == "Virtues") then
			continue
		end

		__wf_atom_ec43d06e(mMovie, v92.Clip, 8, { 12 }, { v90 }, v91)
		mMovie:__wf_atom_2dedec1a(v92.Clip, 67, p)
	end
end

function DetailsHover(p)
	local v90 = fn20(p)
	local v91 = fn22(v12)

	if not fn26(v90, v62.MAX_Value + p) then
		return
	end

	v70 = { 0, 0 }

	if p == v61.MELEE then
		v70 = { 6, 1 }
	elseif p == v61.SECONDARY then
		v70 = { 5, -1 }
	elseif p == v61.HELM then
		v70 = { -2, -4 }
	elseif p == v61.CHEST then
		v70 = { 5, -2 }
	elseif p == v61.LEGS then
		v70 = { -1, 1 }
	elseif p == v61.GUIDE then
		v70 = { -3, -2 }
	elseif p == v61.TOTEM then
		v70 = { -3, -2 }
	end

	table.insert(v70, v90)

	if v90 ~= v91 and (p == v61.MELEE or p == v61.SECONDARY) then
		fn25(v90, true)
	end
end

function DetailsUnhover(p)
	fn23((fn20(p)))
end

fn5 = function()
	local v90 = { v61.MELEE, v61.SECONDARY }

	for _, v91 in ipairs(v90) do
		local mElement = v17[v91].mElements[1]

		if __wf_atom_7e8ad928(mElement) then
			mMovie:__wf_atom_7f57ab2f(fn20(v91), "Details.MagicksButton", 13, false)
		elseif __wf_atom_7e8ad928(mElement.RawItem) then
			mMovie:__wf_atom_7f57ab2f(fn20(v91), "Details.MagicksButton", 13, false)
		elseif __wf_atom_7e8ad928(mElement.Type) then
			mMovie:__wf_atom_7f57ab2f(fn20(v91), "Details.MagicksButton", 13, false)
		else
			local v92 = v91
			asyncLoader:LoadResource("MoteRefresh" .. v91, mElement.Type, function(p)
				local v93 = fn20(v92)
				mMovie:__wf_atom_7f57ab2f(v93, "Details.MagicksButton", 13, true)
				local v94 = Resource(p)
				local __wf_atom_6ec6b781 = v94:__wf_atom_6ec6b781()
				local v95 = inventory:__wf_atom_43563387(mElement.RawItem.mItemId.mId, 0, false) or {}
				local v96 = nil

				for i, v97 in ipairs(__wf_atom_6ec6b781) do
					if v97 ~= 8 then
						continue
					end

					local itemInfo = v95[i]

					if __wf_atom_7e8ad928(itemInfo) then
						continue
					end

					local storeItem = manifest:GetStoreItem(itemInfo.mItemType)
					v96 = module3.GetStoreItemInfo(mMovie, storeItem, { ItemInfo = itemInfo }, nil, nil, true)

					if __wf_atom_7e8ad928(v96) then
						continue
					end

					v96.Polarity = 8
					v96.StatsColor = _G.UIColor_Yellow
				end

				v18[v92] = v96
				local v97 = v93 .. ".Details.MagicksButton.Button"

				if __wf_atom_7e8ad928(v96) then
					mMovie:__wf_atom_c90af43a(v97 .. ".Rune", motesButtonRuneTexture)
					mMovie:__wf_atom_4c1c1986(v97, "Rune", 12, 0)
				else
					asyncLoader:LoadResource("MoteRefreshIcon" .. v92, v96.Icon, function(p2)
						local v98 = Resource(p2)
						mMovie:__wf_atom_c90af43a(v97 .. ".Rune", v98)
						mMovie:__wf_atom_4c1c1986(v97, "Rune", 12, 100)
					end)
				end

				local doesWeaponHaveFillableRuneSlot = module5.DoesWeaponHaveFillableRuneSlot(
					v94,
					mElement.RawItem.mItemId
				)
				mMovie:__wf_atom_7f57ab2f(v93, "Details.MagicksButton.Button.Alert", 13, doesWeaponHaveFillableRuneSlot)
				fn25(v93, v12 == v92 + v62.MAX_Value)
			end)
		end
	end
end

local function fn69(gridId, ids, label, anchor)
	local v90 = fn20(gridId)
	mMovie:__wf_atom_7f57ab2f(v90, "Details.MagicksButton", 67, false)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton", 12, 0)
	mMovie:__wf_atom_c90af43a(v90 .. ".Details.MagicksButton.Frame", motesButtonFrameTexture)
	mMovie:__wf_atom_c90af43a(v90 .. ".Details.MagicksButton.Button.Alert", newAlertIcon)
	mMovie:__wf_atom_c90af43a(v90 .. ".Details.MagicksButton.Button.Backer", motesButtonBackerTexture)
	mMovie:__wf_atom_c90af43a(v90 .. ".Details.MagicksButton.Button.Rune", motesButtonRuneTexture)
	mMovie:__wf_atom_c90af43a(v90 .. ".Details.MagicksButton.Button.RuneBorder", motesButtonBorderTexture)
	mMovie:__wf_atom_c90af43a(v90 .. ".Details.MagicksButton.Button.Glow", motesButtonGlowTexture)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button.Backer", 11, _G.UIColor_DarkerBrown)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button.Glow", 12, 0)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button", 0, 70)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button.RuneBorder", 14, 80)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button.RuneBorder", 15, 80)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button.Rune", 14, 48)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button.Rune", 15, 48)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button.Alert", 0, -28)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button.Alert", 1, -8)
	__wf_atom_86cbd68d(mMovie, v90 .. ".Details.MagicksButton.swapDepths", 1501)
	mMovie:__wf_atom_2dedec1a(v90 .. ".Details.MagicksButton.Button.Alert", 13, false)
	mMovie:__wf_atom_4c1c1986(v90, "Details.MagicksButton.Button.Rune", 100, gridId)
	mMovie:SetCallbacks(
		v90 .. ".Details.MagicksButton.Button.Rune",
		"MotesRollOver",
		"MotesRollOut",
		nil,
		"MotesPressed"
	)

	if gridId ~= v61.MELEE and gridId ~= v61.SECONDARY then
		mMovie:__wf_atom_7f57ab2f(v90, "Details.MagicksButton", 13, false)
	end

	v17[gridId] = fn68(v90 .. ".Details.Item1", gridId, #ids)
	mMovie:SetCallbacks(v90 .. ".Details.Item1", "DetailsHover", "DetailsUnhover", nil, "EquipmentGridItemPressed")
	mMovie:__wf_atom_4c1c1986(v90, "Details.Item1", 100, gridId)
	mMovie:__wf_atom_c90af43a(v90 .. ".Details.Item1.Alert", newAlertIcon)
	mMovie:__wf_atom_7f57ab2f(v90, "Details.Item1.Alert", 13, false)
	mMovie:__wf_atom_7f57ab2f(v90, "Hover.StatusIcon", 13, false)

	for i, itemCategory2 in ipairs(ids) do
		local v92 = false
		local mItemId = nil
		local mItemType = nil
		local v93 = nil
		local v94 = v7[0]
		local mAttributeItem2 = nil

		if itemCategory2 == v61.MELEE then
			mAttributeItem2 = v94:__wf_atom_b369d77f(3)
			local __wf_atom_28224c27 = statOwner:__wf_atom_d2b2176d():__wf_atom_28224c27(5)
			local mItemType2 = mAttributeItem2.mItemType
			local v95

			if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
				v95 = __wf_atom_28224c27:__wf_atom_1bb5b1ff()
				local mItemId2 = mAttributeItem2.mItemId

				if
					not mItemId2:__wf_atom_b70c3343()
					and mItemId2:__wf_atom_8598f3a9()
					and __wf_atom_7e8ad928(mItemType2)
				then
					local __wf_atom_0ff4b555 = inventory:__wf_atom_0ff4b555(0, 3, mItemId2.mId)

					if __wf_atom_0ff4b555 then
						mItemType2 = __wf_atom_0ff4b555.mItemType
					end
				end
			end

			if v95 ~= nil and v95 ~= mItemType2 and not v30 then
				v93 = v95
			end
		elseif itemCategory2 == v61.SECONDARY then
			mAttributeItem2 = v94:__wf_atom_b369d77f(2)
			local __wf_atom_28224c27 = statOwner:__wf_atom_d2b2176d():__wf_atom_28224c27(1)
			local mItemType2 = mAttributeItem2.mItemType
			local v95

			if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
				v95 = __wf_atom_28224c27:__wf_atom_1bb5b1ff()
				local mItemId2 = mAttributeItem2.mItemId

				if
					not mItemId2:__wf_atom_b70c3343()
					and mItemId2:__wf_atom_8598f3a9()
					and __wf_atom_7e8ad928(mItemType2)
				then
					local __wf_atom_0ff4b555 = inventory:__wf_atom_0ff4b555(0, 2, mItemId2.mId)

					if __wf_atom_0ff4b555 then
						mItemType2 = __wf_atom_0ff4b555.mItemType
					end
				end
			end

			if v95 ~= nil and v95 ~= mItemType2 and not v30 then
				v93 = v95
			end
		elseif itemCategory2 == v61.IDOL then
			mAttributeItem2 = fn42()
		elseif itemCategory2 == v61.GUIDE then
			local __wf_atom_1eafa462 = gGameRules:__wf_atom_1eafa462(v6)
			mAttributeItem2 = __wf_atom_1eafa462:__wf_atom_d78fd481(2)
			mItemType = mAttributeItem2.mItemType

			if mItemType == nil then
				mItemType = __wf_atom_1eafa462:__wf_atom_035fdfa8(2)
			end

			if mItemType == nil then
				local v95 = fn49({ baseGuideTypes }, itemCategory2, false, false)
				local weaponCustomization = SF.WeaponCustomization()
				local v96 = Resource("/SF/Upgrades/Skins/Sparrow/SparrowBody")

				for k in v95 do
					if not (v95[k].Type ~= nil and v95[k].Type:GetName() == v96:GetName()) then
						continue
					end

					if not __wf_atom_7e8ad928(v96) then
						weaponCustomization:SetSkin(v96, 2)
					end

					inventory:__wf_atom_e1f7c9fe(weaponCustomization)
					gGameRules:__wf_atom_51274c29(weaponCustomization)
					mItemType = v96
					break
				end
			end

			local mItemId2 = mAttributeItem2.mItemId

			if mItemId2:__wf_atom_b70c3343() or not mItemId2:__wf_atom_8598f3a9() then
				v93 = mItemType
			end
		elseif itemCategory2 == v61.VIRTUEGEM then
			mAttributeItem2 = v94.mAttributeItem

			if mAttributeItem2 == nil then
				mAttributeItem2 = gGameData:__wf_atom_a4299765():__wf_atom_275f9121(0)
				v94.mAttributeItem = mAttributeItem2
			end

			if mAttributeItem2 ~= nil and mAttributeItem2.mItemType == nil then
				mItemType = mAttributeItem2
			end

			mAttributeItem = v94.mAttributeItem
			local v95 = fn51(itemCategory2) or {}
			local flag7 = false
			local kind = nil

			for _, v96 in ipairs(v95) do
				if v96.OwnsItem then
					kind = v96.Type
				end

				if v96.Type ~= v94.mAttributeItem or v96.OwnsItem then
					continue
				end

				flag7 = true
			end

			if flag7 then
				v94.mAttributeItem = kind
				mAttributeItem = v94.mAttributeItem6
				inventory:__wf_atom_337fac69(0, v94)
			end
		else
			local __wf_atom_b369d77f = v94:__wf_atom_b369d77f(0)
			local __wf_atom_eb82ab1f = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId):__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
			local v95 = nil

			if itemCategory2 == v61.HELM then
				mAttributeItem2 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(0)
				v95 = __wf_atom_eb82ab1f:__wf_atom_730958a3(0)
			elseif itemCategory2 == v61.CHEST then
				mAttributeItem2 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(2)
				v95 = __wf_atom_eb82ab1f:__wf_atom_730958a3(2)
			elseif itemCategory2 == v61.LEGS then
				mAttributeItem2 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(3)
				v95 = __wf_atom_eb82ab1f:__wf_atom_730958a3(3)
			elseif itemCategory2 == v61.TOTEM then
				mAttributeItem2 = __wf_atom_eb82ab1f:__wf_atom_d78fd481(5)
				v95 = __wf_atom_eb82ab1f:__wf_atom_730958a3(5)

				if _T.TutorialStepTalisman then
					if __wf_atom_7e8ad928(mAttributeItem2) or __wf_atom_7e8ad928(mAttributeItem2.mItemType) then
						_T.TutorialTalismanEquipped = false
					else
						_T.TutorialTalismanEquipped = true
					end
				end
			end

			if not (__wf_atom_7e8ad928(v95) or __wf_atom_7e8ad928(v95.mItemType)) then
				mMovie:__wf_atom_7f57ab2f(v90, "Hover.StatusIcon", 13, true)
				mMovie:__wf_atom_c90af43a(v90 .. ".Hover.StatusIcon", moonsteelIconTexture)
			end
		end

		if mAttributeItem2 then
			mItemId = mAttributeItem2.mItemId

			if mItemType == nil then
				mItemType = mAttributeItem2.mItemType
			end

			if mItemId then
				v92 = not mItemId:__wf_atom_b70c3343() and mItemId:__wf_atom_8598f3a9()
			else
				v92 = false
			end
		end

		local v95 = fn51(itemCategory2, true) or {}

		for _, v96 in ipairs(v95) do
			if itemCategory2 == v61.SKILLS then
				continue
			end

			if not (v93 ~= nil and (v96.StoreItemInfo ~= nil and v93 == v96.StoreItemInfo.Type or v93 == v96.Type) or v93 == nil and (v92 and not __wf_atom_7e8ad928(v96.RawItem) and mItemId == v96.RawItem.mItemId or not v92 and mItemType == v96.Type)) then
				continue
			end

			v96.ItemCategory = itemCategory2
			v17[gridId]:AddElement(v96, true)
			break
		end

		v17[gridId]:Redraw(nil, true, true)
		mMovie:__wf_atom_4c1c1986(v90, "Details", 12, 0)
		mMovie:__wf_atom_7f57ab2f(v90, "Details", 67, false)
		__wf_atom_86cbd68d(mMovie, v90 .. ".Hover.gotoAndStop", 1)
		mMovie:__wf_atom_4c1c1986(v90, "Hover", 5, 26.25)
		mMovie:__wf_atom_4c1c1986(v90, "Hover", 6, 26.25)
		mMovie:__wf_atom_4c1c1986(v90, "Hover", 12, 85)
		mMovie:__wf_atom_4c1c1986(v90, "PanelHover", 12, 0)
		fn10(v90 .. ".Label", label)
		local v96 = mMovie:__wf_atom_cfc41e35(v90, "Label.Bg", 14) / 2 + 96
		mMovie:__wf_atom_4c1c1986(v90, "Label", 0, -73 + v96 * module.Ternary(anchor == 1 or anchor == 3, 1, -1))
		local v97 = math.min(#v95, v17[gridId].mColumns)
		local ternary = module.Ternary(anchor == 1 or anchor == 3, 255, -16 - (v97 - 1) * 125)
		mMovie:__wf_atom_4c1c1986(v90, "Details", 0, ternary)
		mMovie:__wf_atom_4c1c1986(v90, "Details", 1, module.Ternary(anchor == 1 or anchor == 2, -205, 91))

		if itemCategory2 == v61.SECONDARY then
			local mElement = v17[gridId].mElements[i]

			if not (__wf_atom_7e8ad928(mElement) or v92) then
				mElement.Name = mMovie:__wf_atom_8e9ac384("/SF/Language/Weapons/None", false)
			end
		end

		if not (anchor == 1 or anchor == 2) then
			continue
		end

		local v98 = math.ceil(v17[gridId]:GetHowManyElements() / v17[gridId].mColumns)
		mMovie:__wf_atom_4c1c1986(v90, "Details", 1, v98 * -125 + 40)
	end
end

fn2 = function()
	local v90 = fn50()
	local v91 = false

	for i, v92 in ipairs(v90) do
		local v93 = "Souls.Details.Attribute" .. tostring(i)
		mMovie:__wf_atom_2dedec1a(v93 .. ".Label", 13, false)
		mMovie:__wf_atom_2dedec1a(v93 .. ".Icon", 13, true)
		mMovie:__wf_atom_2dedec1a(v93 .. ".Label.Label", 13, true)
		mMovie:__wf_atom_2dedec1a(v93 .. ".Points", 13, true)
		mMovie:__wf_atom_c90af43a(v93 .. ".Points.Alert", newAlertIcon)
		mMovie:__wf_atom_c90af43a(v93 .. ".Label.Backer", soulTextures[12])
		mMovie:__wf_atom_4c1c1986(v93, "Label.Label", 44, _G.UIColor_DarkBrown)
		mMovie:__wf_atom_4c1c1986(v93, "Label.Level", 44, 2428165)
		mMovie:__wf_atom_4c1c1986(v93, "Label", 12, 80)
		mMovie:__wf_atom_48bd5a59(v93, "Label.Label", 36, v92.Name)
		mMovie:__wf_atom_c90af43a(v93 .. ".Icon", v92.Icon)

		if not __wf_atom_7e8ad928(statOwner) then
			local __wf_atom_d2b2176d = statOwner:__wf_atom_d2b2176d()
			local v94 = Resource(v92.RawItem)
			local v95

			if module5.AreUpgradesAvailableForSkillTree(__wf_atom_d2b2176d, v94) then
				v95 = true
				v91 = true
			else
				v95 = false
			end

			local __wf_atom_9114aa52 = __wf_atom_d2b2176d:__wf_atom_9114aa52(v92.RawItem)
			mMovie:__wf_atom_7f57ab2f(v93, "Points.Rays", 13, v95)
			mMovie:__wf_atom_7f57ab2f(v93, "Points.Diamond", 13, v95)
			mMovie:__wf_atom_7f57ab2f(v93, "GlowSparks", 13, false)
			mMovie:__wf_atom_48bd5a59(v93, "Points.Points", 36, __wf_atom_9114aa52)
			mMovie:__wf_atom_4c1c1986(v93, "Points", 5, v95 and 85 or 65)
			mMovie:__wf_atom_4c1c1986(v93, "Points", 6, v95 and 85 or 65)
			mMovie:__wf_atom_7f57ab2f(v93, "Points.Alert", 13, v95)
		end

		mMovie:__wf_atom_4c1c1986(v93, "GlowSparks", 12, 70)
		mMovie:OverrideMaterial(v93 .. ".GlowSparks", radialRaysMaterial)
		mMovie:__wf_atom_4c1c1986(v93, "Btn", 100, i)
		mMovie:SetCallbacks(
			v93 .. ".Btn",
			"SoulAttributeFocused",
			"SoulAttributeUnfocused",
			nil,
			"SoulAttributePressed"
		)
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v93, "Label.Label", 40)
		mMovie:__wf_atom_4c1c1986(v93, "Label.InnerFill", 14, __wf_atom_cfc41e35)
		mMovie:__wf_atom_4c1c1986(v93, "Label.EdgeFill", 14, __wf_atom_cfc41e35)
		local v94 = __wf_atom_cfc41e35 / 2 + 25
		mMovie:__wf_atom_4c1c1986(v93, "Label.InnerLeftCap", 0, -v94)
		mMovie:__wf_atom_4c1c1986(v93, "Label.EdgeLeftCap", 0, -v94)
		mMovie:__wf_atom_4c1c1986(v93, "Label.InnerRightCap", 0, v94)
		mMovie:__wf_atom_4c1c1986(v93, "Label.EdgeRightCap", 0, v94)
		mMovie:__wf_atom_4c1c1986(v93, "Label.Icon", 0, -v94 + 4)
		mMovie:__wf_atom_4c1c1986(v93, "Label.Level", 0, v94 - 33)
	end

	for i = #v90 + 1, 7 do
		local v92 = "Souls.Details.Attribute" .. tostring(i)
		mMovie:__wf_atom_2dedec1a(v92, 13, false)
		mMovie:__wf_atom_2dedec1a(v92 .. ".Label", 13, false)
		mMovie:__wf_atom_2dedec1a(v92 .. ".Icon", 13, false)
		mMovie:__wf_atom_2dedec1a(v92 .. ".Label.Label", 13, false)
		mMovie:__wf_atom_2dedec1a(v92 .. ".Points", 13, false)
		mMovie:__wf_atom_c90af43a(v92 .. ".Label.Backer", soulTextures[11])
	end

	mMovie:__wf_atom_2dedec1a("Souls.Hover.Alert", 13, v91)
end

function SoulAttributeFocused(p)
	local v90 = "Souls.Details.Attribute" .. tostring(p)
	local v91 = fn9()
	__wf_atom_ec43d06e(mMovie, v90 .. ".Icon", 2, { 5, 6 }, { 300, 300 }, 0.5)
	mMovie:__wf_atom_c90af43a(v90 .. ".EyeBacker", soulTextures[v91 and 15 or 10])
	module.PlaySound(_G.UISound_Focus)
	local skillTree = skillTrees[p]

	if not __wf_atom_7e8ad928(skillTree) then
		local gToolTip = Localize(skillTree:__wf_atom_014a76a2():c_str(), nil)
		_T.gToolTip = gToolTip
		_T.gToolTipDelay = 0
	end
end

function SoulAttributeUnfocused(p)
	local v90 = "Souls.Details.Attribute" .. tostring(p)
	local v91 = fn9()
	__wf_atom_ec43d06e(mMovie, v90 .. ".Icon", 2, { 5, 6 }, { 250, 250 }, 0.5)
	mMovie:__wf_atom_c90af43a(v90 .. ".EyeBacker", soulTextures[v91 and 14 or 9])
	_T.gToolTip = nil
end

function SoulAttributePressed(p)
	if flag then
		return
	end

	flag = true
	module.PlaySound(_G.UISound_Select)
	_T.SkillTreeSelected = skillTrees[p]
	_T.gToolTip = nil

	function _T.OnReturnToArsenal()
		if __wf_atom_7e8ad928(mMovie) then
			return
		end

		fn2()
		fn15(v, 0.25)
		module5.DissolveIn(mMovie)
		fn3(arsenalAvatar)
		fn4()
		flag = false
		v30 = true
	end

	module5.DissolveOut(mMovie)
	fn15(v2, 0.25)
	fn12(skillTreeMovie)
end

function OnNewPactSelected(p)
	flag = false
	mMovie:__wf_atom_f0448d34(true)

	if __wf_atom_7e8ad928(p) then
		return
	end

	local v90 = fn51(v61.PACT)
	local v91 = nil

	for _, v93 in ipairs(v90) do
		if p ~= v93.RawItem.mItemId.mId then
			continue
		end

		v91 = v93
		break
	end

	if __wf_atom_7e8ad928(v91) then
		return
	end

	local __wf_atom_3dbd0893 = gGameData:__wf_atom_3dbd0893(v91.Type)
	v29.mSelectionLoader:Release()
	v29.mSelectionLoader:Load(__wf_atom_3dbd0893, true)
	local mSelectionLoader = v29.mSelectionLoader
	mSelectionLoader.mPendingSelection = { [v61.PACT] = v91 }
end

function SwapPact()
	if v29.mSelectionLoader.mState == v28.LS_LOADING or flag then
		return
	end

	flag = true
	mMovie:__wf_atom_f0448d34(false)
	local v90 = fn51(v61.PACT)
	local __wf_atom_b369d77f = v7[0]:__wf_atom_b369d77f(0)
	local v91 = nil

	for _, v93 in ipairs(v90) do
		if not (v93.RawItem and v93.RawItem.mItemId.mId == __wf_atom_b369d77f.mItemId.mId) then
			continue
		end

		v91 = v93
		break
	end

	if not __wf_atom_7e8ad928(v60) then
		v60:Destroy()
		v60 = nil
	end

	_T.GridSelectionTitle = "/SF/Language/Menu/ChoosePact"
	_T.GridSelectionCallback = OnNewPactSelected

	if __wf_atom_7e8ad928(v91) then
		print("Current Pact not found")
	else
		local mId = v91.RawItem.mItemId.mId
		_T.CurrentSelectedPactId = mId
	end

	v25:SetActive(true)
	v25:SetScale(120)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 12, 50)

	local function fn70()
		v25:SetActive(false)
		mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 12, 0)
		flag = false
	end

	function _T.GridLoadedCallback()
		fn70()
	end

	v26:AddTimer(5, function()
		fn70()
	end)
	fn12(gridSelectionMovie)
end

function OpenUpgradePact()
	if flag then
		return
	end

	flag = true
	local __wf_atom_e55d02aa = arsenalAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	asyncLoader:LoadResource("SkillTree", __wf_atom_e55d02aa:__wf_atom_c45b4ac3(), function(p)
		_T.SkillTreeSelected = Resource(p)

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			_T.SkillTreeLocOverride = __wf_atom_e55d02aa:__wf_atom_014a76a2():c_str()
		end

		function _T.OnReturnToArsenal()
			fn2()
			fn15(v, 0.25)
			module5.DissolveIn(mMovie)
			fn3(arsenalAvatar)
			fn4()
			UpdateUnspentPactPoints()
			flag = false
			v30 = true
		end

		module5.DissolveOut(mMovie)
		fn15(v2, 0.25)
		fn12(skillTreeMovie)
	end)
end

function ClosePactUpgrade(p)
	module5.DissolveIn(mMovie)

	if not __wf_atom_7e8ad928(v14) then
		module5.DissolveOutAndClose(v14)
		v14 = nil
	end

	flag = false

	if p == "true" then
		fn3(arsenalAvatar)
		fn4()
		v30 = true
	end
end

function ChildScriptFadeToNormal()
	module4.FadeToBlack(false, 2)
end

local function fn70()
	mMovie:OverrideMaterial("ArmorStats.Shadow", _G.UIMaterial_DarkPaperBacker)
	mMovie:__wf_atom_e57658c2("ArmorStats.Shadow", 12, 50)
	mMovie:__wf_atom_e57658c2("ArmorStats.Shadow", 11, 2236962)
	mMovie:__wf_atom_e57658c2("ArmorStats.TotalDefense", 44, _G.UIColor_Yellow)

	for i = 1, 3 do
		mMovie:__wf_atom_e57658c2("ArmorStats" .. ".Resist" .. i .. ".DamageType", 44, _G.UIColor_Yellow)
		mMovie:__wf_atom_e57658c2("ArmorStats" .. ".Resist" .. i .. ".DamageAmount", 44, _G.UIColor_Yellow)
	end

	mMovie:__wf_atom_50d60589("ArmorStats.Resist1.DamageType", 36, mMovie:__wf_atom_8e9ac384("<DAMAGE_PHYSICAL>", true))
	mMovie:__wf_atom_50d60589("ArmorStats.Resist2.DamageType", 36, mMovie:__wf_atom_8e9ac384("<DAMAGE_MAGIC>", true))
	mMovie:__wf_atom_50d60589(
		"ArmorStats.Resist3.DamageType",
		36,
		mMovie:__wf_atom_8e9ac384("<DAMAGE_STABILITY>", true)
	)
end

function InitializeItemPickers()
	mMovie:__wf_atom_2dedec1a("InventoryContainer", 13, false)
	mMovie:__wf_atom_e57658c2("InventoryContainer.Bg", 12, 0)
	mMovie:__wf_atom_e57658c2("InventoryContainer.Bg", 11, _G.UIColor_Black)
	local v90 = {}
	table.insert(v90, {
		GridId = v61.MELEE,
		Ids = { v61.MELEE },
		Label = "/SF/Language/SystemMessages/WeaponSlot",
		Anchor = 1
	})
	table.insert(v90, {
		GridId = v61.SECONDARY,
		Ids = { v61.SECONDARY },
		Label = "/SF/Language/SystemMessages/SecondarySlot",
		Anchor = 1
	})
	table.insert(v90, {
		GridId = v61.HELM,
		Ids = { v61.HELM },
		Label = "/SF/Language/SystemMessages/HeadAmorSlot",
		Anchor = 4
	})
	table.insert(v90, {
		GridId = v61.CHEST,
		Ids = { v61.CHEST },
		Label = "/SF/Language/SystemMessages/UpperArmorSlot",
		Anchor = 3
	})
	table.insert(v90, {
		GridId = v61.LEGS,
		Ids = { v61.LEGS },
		Label = "/SF/Language/SystemMessages/LowerArmorSlot",
		Anchor = 2
	})
	table.insert(v90, {
		GridId = v61.TOTEM,
		Ids = { v61.TOTEM },
		Label = "/SF/Language/SystemMessages/IdolSlot",
		Anchor = 4
	})
	table.insert(v90, {
		GridId = v61.SKILLS,
		Ids = { v61.SKILLS },
		Label = "/SF/Language/SystemMessages/Skills",
		Anchor = 3
	})
	table.insert(v90, {
		GridId = v61.GUIDE,
		Ids = { v61.GUIDE },
		Label = "/SF/Language/SystemMessages/GuideSlot",
		Anchor = 2
	})
	table.insert(v90, {
		GridId = v61.VIRTUEGEM,
		Ids = { v61.VIRTUEGEM },
		Label = "/SF/Language/SystemMessages/VirtueGem",
		Anchor = 1
	})

	for _, v91 in v90 do
		fn69(v91.GridId, v91.Ids, v91.Label, v91.Anchor)
		ShowNode(v91.GridId)
	end

	fn5()
end

function ShowNode(p)
	local v90 = fn20(p)
	mMovie:__wf_atom_7f57ab2f(v90, "Details", 67, true)
	mMovie:__wf_atom_e57658c2(v90 .. ".Details", 0, 115)
	mMovie:__wf_atom_e57658c2(v90 .. ".Details", 1, 0)
	mMovie:__wf_atom_4c1c1986(v90, "Details", 12, 0)
	mMovie:__wf_atom_4c1c1986(v90, "Details.Item1", 12, 100)
	__wf_atom_ec43d06e(mMovie, v90 .. ".Details", 0, { 12 }, { 100 }, 0.3, v54)
end

local function fn71()
	if not _T.TutorialStepTalisman or __wf_atom_7e8ad928(inventory) then
		return
	end

	local v90 = inventory:__wf_atom_71d5cc00() or {}

	for _, v91 in ipairs(v90) do
		local storeItem = manifest:GetStoreItem(v91.mItemType)

		if __wf_atom_7e8ad928(storeItem) or not storeItem:__wf_atom_e84d016c(5) then
			continue
		end

		_T.TutorialHasTalisman = true
		break
	end
end

function ConfirmVirtueChanges()
	v30 = v30 or v35
	v35 = false
	v32.mAttributeConfigU = v7[0].mAttributeConfigU
	v32.mAttributeConfigV = v7[0].mAttributeConfigV

	for i = 0, 2 do
		statOwner:__wf_atom_9189c3be(i, arsenalAvatar:GetAttribute(i, false))
	end

	LockVirtueControl()
end

function UnlockVirtueControl()
	flag4 = true
	v19.mMainButton:SetActive(false)
	v46:SetVisible(true)
	v48:SetVisible(true)
	v47:SetVisible(false)
	v46:SetActive(false)
	mMovie:__wf_atom_e57658c2("Virtues.Details.GemMist", 14, 1000)
	mMovie:__wf_atom_e57658c2("Virtues.Details.GemMist", 15, 1000)
	mMovie:__wf_atom_e57658c2("Virtues.Details.GemMist", 12, 0)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.GemMist", 8, { 12, 14, 15 }, { 100, 600, 600 }, 0.3, 0)
	module6.StartClipPulse(mMovie, "Virtues.Details.VirtueControl", 120, 100, 0.5)
	module.PlaySound(virtueRebalanceSound)

	for _, v90 in ipairs(v64) do
		if v90.Clip == "Virtues" then
			continue
		end

		__wf_atom_ec43d06e(mMovie, v90.Clip, 8, { 12 }, { 0 }, 0.25)
		mMovie:__wf_atom_2dedec1a(v90.Clip, 67, false)
	end
end

function LockVirtueControl()
	flag4 = false
	v19.mMainButton:SetActive(true)
	v46:SetVisible(false)
	v48:SetVisible(false)
	v47:SetVisible(true)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.GemMat", 8, { 14, 15 }, { 350, 350 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.DynamicPrism", 8, { 14, 15 }, { 350, 350 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.BackerLayer", 8, { 12 }, { 40 }, 0.2)
	mMovie:__wf_atom_e57658c2("Virtues.Details.GemMist", 12, 100)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.GemMist", 8, { 12, 14, 15 }, { 0, 1045, 1045 }, 0.6, 0)
	__wf_atom_ec43d06e(mMovie, "Virtues.Details.VirtueControl", 8, { 12, 14, 15 }, { 100, 100, 100 }, 0.3, 0)
	module6.StopClipPulse(mMovie, "Virtues.Details.VirtueControl", 100)
	module.PlaySound(virtueConfirmChangeSound)

	for _, v90 in ipairs(v64) do
		if v90.Clip == "Virtues" then
			continue
		end

		__wf_atom_ec43d06e(mMovie, v90.Clip, 8, { 12 }, { 100 }, 0.25)
		mMovie:__wf_atom_2dedec1a(v90.Clip, 67, true)
	end
end

function OnClickRevertVirtue(_)
	RevertVirtueChanges(false)
end

function RevertVirtueChanges(p)
	v7[0].mAttributeConfigU = v32.mAttributeConfigU
	v7[0].mAttributeConfigV = v32.mAttributeConfigV

	if not p then
		fn28(v7[0])
	end

	ApplyVirtueChanges()
	LockVirtueControl()
end

function OpenFlashMovieFile() end

function GetSkillTreeDepsToLoad()
	local result = {}

	for _, v90 in ipairs(skillTrees) do
		local __wf_atom_67eae01c = Resource(v90):__wf_atom_67eae01c()

		for _, v91 in ipairs(__wf_atom_67eae01c) do
			table.insert(result, v91)
		end
	end

	return result
end

function Initialize()
	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(true)
	end

	module5.CloseProgressionScreen()
	module6.SetChatVisible(false)
	module6.SetConsumablesEnabled(false)
	module5.RegisterHideHud(true)
	mMovie:__wf_atom_433c28ce(false)
	statOwner = gRegion:__wf_atom_c4f78a8f()
	v6 = gRegion:__wf_atom_eab484a7()
	v43 = module8.Create(mMovie)
	v43:Register(mMovie, "ArmorStats", { v43.ANCHOR_V_TOP, v43.ANCHOR_H_RIGHT })
	v43:Register(mMovie, "LoadoutDropdown", { v43.ANCHOR_V_TOP, v43.ANCHOR_H_RIGHT })
	v43:Register(mMovie, "RenameButton", { v43.ANCHOR_V_TOP, v43.ANCHOR_H_RIGHT })
	v43:Register(mMovie, "InventoryContainer", { v43.ANCHOR_V_TOP, v43.ANCHOR_H_RIGHT })
	v43:Register(mMovie, "CorruptedVignette", { v43.ANCHOR_V_CENTRE, v43.ANCHOR_H_CENTRE })

	for _, v90 in v64 do
		local clip = v90.Clip
		v90.Special = not mMovie:__wf_atom_253d7085(clip .. ".PanelHover")
	end

	local v90

	if not __wf_atom_7e8ad928(statOwner) then
		v90 = statOwner:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	end

	fn46(v90)
	local module12 = require("Lotus.Interface.Components.ThemedSpinner")
	v25 = module12.Create(mMovie, "Spinner")
	v25:SetActive(false)
	fn13()
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 12, 0)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 11, 0)
	local module13 = require("Lotus.Interface.Libs.TimerMgr")
	v26 = module13.CreateTimerMgr()
	v71 = statOwner:CameraControl():__wf_atom_1b3db7e0()

	if not __wf_atom_7e8ad928(gGameData) then
		inventory = gGameData:GetInventory()
	end

	module.PlaySound(enterSound)
	v16.SwapMotes = module.ConvertColorNumberToHex(_G.UIColor_Yellow)
	v16.MotesDescription = module.ConvertColorNumberToHex(_G.UIColor_Beige)
	mMovie:__wf_atom_8fcdea81(statOwner)
	local v91 = Vector(0, 1.3, 0)
	local v92 = Vector(0, 0, 2)
	local v93 = statOwner:GetPosition() + v91
	local __wf_atom_d9cb4b97 = statOwner:MotionControl():__wf_atom_d9cb4b97()
	local v94 = v93 + __wf_atom_9341614d(v92, __wf_atom_d9cb4b97)
	local v95 = __wf_atom_fa8d0177(v94, v93)
	v = gRegion:CreateEntity(cameraSpotType, v94, v95)
	v:__wf_atom_7e990320(2)
	v:__wf_atom_8c3d9704(2)
	v:__wf_atom_b811702e(Symbol("ArsenalCameraPrimary"))
	v9 = v95
	local v96 = v92 + Vector(-0.3, 0, 0)
	local v97 = v93 + __wf_atom_9341614d(v96, __wf_atom_d9cb4b97)
	v2 = gRegion:CreateEntity(cameraSpotType, v97, v95)
	v2:__wf_atom_7e990320(2)
	v2:__wf_atom_8c3d9704(2)
	local v98 = v92 + Vector(-0.5, 0.5, 2)
	local v99 = v93 + __wf_atom_9341614d(v98, __wf_atom_d9cb4b97)
	local v100 = __wf_atom_fa8d0177(v93 + __wf_atom_9341614d(v92 + Vector(0.1, 0.6, 1), __wf_atom_d9cb4b97), v93)
	v3 = gRegion:CreateEntity(cameraSpotType, v99, v100)
	v3:__wf_atom_7e990320(2)
	v3:__wf_atom_8c3d9704(4)
	local v101 = Vector(0.1, 0.275, 0.5)
	local v102 = v93 + __wf_atom_9341614d(v101, __wf_atom_d9cb4b97)
	v4 = gRegion:CreateEntity(cameraSpotType, v102, v95)
	local v103 = Vector(-0.8, 0.05, 2.5)
	local v104 = v93 + __wf_atom_9341614d(v103, __wf_atom_d9cb4b97)
	v5 = gRegion:CreateEntity(cameraSpotType, v104, v95)
	arsenalAvatar = gRegion:CreateEntity(dummyAvatarType, statOwner:GetPosition(), __wf_atom_d9cb4b97, v6, v6, fn17())
	arsenalAvatar:__wf_atom_c274907d(v6)
	arsenalAvatar:SetVisibility(false, true)
	arsenalAvatar:SetFaction(statOwner:__wf_atom_e93896ba())
	arsenalAvatar:__wf_atom_4339a64c(false)
	arsenalAvatar:__wf_atom_3b7f7d6b(false)
	arsenalAvatar:__wf_atom_e424c72a(true)
	arsenalAvatar:__wf_atom_45cf0e1a(statOwner:__wf_atom_b6b760b5(), true, false)
	arsenalAvatar:__wf_atom_70f78a63(statOwner)
	arsenalAvatar:__wf_atom_51075230(__wf_atom_d9cb4b97)
	arsenalAvatar:Teleport(statOwner:GetPosition(), __wf_atom_d9cb4b97)
	heading = __wf_atom_d9cb4b97.heading
	v79 = heading

	for i = 0, 2 do
		arsenalAvatar:__wf_atom_9189c3be(i, statOwner:GetAttribute(i, false))
	end

	fn15(v, 0.5)
	arsenalAvatar:__wf_atom_2f0092a2(Symbol("GAME_C1_HEAD1"), Rotation(0, 0, 0))
	arsenalAvatar:__wf_atom_921c1a5f(idleAnimation, false, 2, 2)
	fn37()
	v29.mSlotLoader = fn16(fn52)
	v29.mSelectionLoader = fn16(fn53)
	v29.mPreviewLoader = fn16(fn54, fn55)
	mMovie:__wf_atom_e57658c2("Virtues", 12, 100)
	mMovie:__wf_atom_e57658c2("Virtues.Details", 12, 0)
	mMovie:__wf_atom_2dedec1a("Virtues.Details", 67, false)
	__wf_atom_86cbd68d(mMovie, "Virtues.Hover.gotoAndStop", 1)
	mMovie:__wf_atom_e57658c2("Pact", 12, 100)
	mMovie:__wf_atom_e57658c2("Pact.Details", 12, 0)
	mMovie:__wf_atom_2dedec1a("Pact.Details", 67, false)
	__wf_atom_86cbd68d(mMovie, "Pact.Hover.gotoAndStop", 1)
	mMovie:__wf_atom_e57658c2("Souls", 12, 100)
	mMovie:__wf_atom_e57658c2("Souls.Details", 12, 0)
	mMovie:__wf_atom_2dedec1a("Souls.Details", 67, false)
	__wf_atom_86cbd68d(mMovie, "Souls.Hover.gotoAndStop", 1)
	mMovie:__wf_atom_c90af43a("Virtues.Hover.Alert", newAlertIcon)
	mMovie:__wf_atom_c90af43a("Pact.Hover.Alert", newAlertIcon)
	mMovie:__wf_atom_c90af43a("Souls.Hover.Alert", newAlertIcon)
	mMovie:__wf_atom_c90af43a("Souls.Details.Bg", soulTextures[1])
	mMovie:__wf_atom_933bbce0("Souls.Details.VineLeft", soulTextures[7], virtueMaterials[1])
	mMovie:__wf_atom_933bbce0("Souls.Details.VineRight", soulTextures[7], virtueMaterials[1])
	mMovie:__wf_atom_933bbce0("Souls.Details.FlagLeft", soulTextures[8], virtueMaterials[1])
	mMovie:__wf_atom_933bbce0("Souls.Details.FlagRight", soulTextures[8], virtueMaterials[1])
	mMovie:__wf_atom_2dedec1a("Virtues.Hover.Alert", 13, false)
	mMovie:__wf_atom_2dedec1a("Pact.Hover.Alert", 13, false)
	mMovie:__wf_atom_2dedec1a("Souls.Hover.Alert", 13, false)
	local mLevel, v106

	if __wf_atom_7e8ad928(gGameData) then
		mLevel = 0
		v106 = 0
	else
		local __wf_atom_d5bed0b3 = gGameData:__wf_atom_d5bed0b3()
		mLevel = __wf_atom_c67f9605:__wf_atom_f7423942(__wf_atom_d5bed0b3)
		local __wf_atom_e372699a = __wf_atom_c67f9605:__wf_atom_e372699a(__wf_atom_d5bed0b3)
		local __wf_atom_c927661a = __wf_atom_c67f9605:__wf_atom_c927661a(__wf_atom_d5bed0b3)
		v106 = (__wf_atom_d5bed0b3 - __wf_atom_e372699a) / (__wf_atom_c927661a - __wf_atom_e372699a)
	end

	mMovie:SetCallbacks("Virtues.Hover", "VirtuesRollOver", "VirtuesRollOut", nil, "VirtuesClick")
	mMovie:SetCallbacks("Pact.Hover", "PactRollOver", "PactRollOut", nil, "PactClick")
	mMovie:SetCallbacks("Souls.Hover", "SoulsRollOver", "SoulsRollOut", nil, "SoulsClick")
	fn10("Pact.Label", "/SF/Language/Categories/Pact")
	fn10("Souls.Label", "/SF/Language/SystemMessages/Skills")
	InitializeLoadoutDropdown()
	fn70()
	mMovie:__wf_atom_50d60589("Pact.Details.BondTitle", 36, Localize("/SF/Language/Pacts/Bond", nil))
	v45 = module11.Create(mMovie, "Pact.Details.SwapBtn", "/SF/Language/SystemMessages/SwapPact", "SwapPact")
	v45:SetVariant(module11.VARIANTS.SPECIAL_BUTTON)
	v44 = module11.Create(
		mMovie,
		"Pact.Details.UpgradeBtn",
		"/SF/Language/SystemMessages/UpgradePact",
		"OpenUpgradePact"
	)
	v44:SetVariant(module11.VARIANTS.SPECIAL_BUTTON)
	mMovie:__wf_atom_2dedec1a("Pact.Details.DetailsBtn", 13, false)
	mMovie:__wf_atom_2dedec1a("ConfirmStartingGearBtn", 13, false)
	asyncLoader:LoadMultipleResources("SkillTrees", skillTrees, function()
		asyncLoader:LoadMultipleResources("SkillTreeDeps", GetSkillTreeDepsToLoad(), function()
			fn2()
		end)
	end)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FireLight"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_8a035cd5(Symbol("FadeToNeutral"), false)
	end

	fn56()
	InitializeItemPickers()
	mMovie:__wf_atom_2dedec1a("Souls.Details.Bg", 13, false)
	local v107 = {
		mMovie = mMovie,
		mLabel = v6:__wf_atom_6be84646(),
		mLevel = mLevel,
		mRankProgress = v106 * 100,
		mOverwriteCurrencies = false
	}

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v107)
	end

	v6:__wf_atom_a16f9b3c(mMovie:__wf_atom_d5a50cb5() / 2, mMovie:__wf_atom_c4f6543f() / 2 - 200)
	v52 = v6:__wf_atom_92d75093()
	v54 = 0
	module5.DissolveIn(mMovie)

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("NIGHTFOLD_MENU_OPEN"), "CHARACTER")
		__wf_atom_21342f4a:StartTimer(Symbol("NIGHTFOLD_MENU_TIME"), "CHARACTER_TOTAL")
	end

	v43:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	local movie = __wf_atom_8e4fda44:FindMovie(currencyBarMovie)

	if movie then
		movie:__wf_atom_f0448d34(true)
	end

	fn71()
	UpdateButtons()
end

local function fn72()
	if not __wf_atom_7e8ad928(arsenalAvatar) and arsenalAvatar ~= statOwner then
		print("Destroying local avatar")
		gRegion:__wf_atom_dd1e4d10(arsenalAvatar)
	end

	if not __wf_atom_7e8ad928(statOwner) then
		statOwner:__wf_atom_2f0092a2(Symbol("GAME_C1_HEAD1"), Rotation(0, 0, 0))
		statOwner:__wf_atom_a7ee9662(true)
		local __wf_atom_d2b2176d = statOwner:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

				for _, v90 in ipairs(__wf_atom_36b4a6e5) do
					if not __wf_atom_7e8ad928(v90) then
						v90:SetEnabled(false)
					end
				end
			end
		end
	end

	if not __wf_atom_7e8ad928(v13) then
		v13:Stop(false)
		v13 = nil
	end

	if not __wf_atom_7e8ad928(v14) then
		v14:Close()
		v14 = nil
	end

	if v29.mPreviewLoader ~= nil then
		v29.mPreviewLoader:Release()
		v29.mPreviewLoader = nil
	end

	if not __wf_atom_7e8ad928(nil) then
		(nil):TurnOff()
	end

	if not __wf_atom_7e8ad928(v60) then
		v60:Destroy()
		v60 = nil
	end

	_T.InfoPopup_Data = nil
	_T.SkillTreeSelected = nil
	_T.gToolTip = nil
	_T.OnReturnToArsenal = nil
	_T.ArsenalPact = nil
end

function Shutdown()
	print("Shutting down character screen")
	fn72()
	module6.SetChatVisible(true)
	module6.SetConsumablesEnabled(true)
	module5.RegisterHideHud(false)

	if v71 ~= nil and not __wf_atom_7e8ad928(statOwner) then
		local cameraControl = statOwner:CameraControl()

		if not cameraControl:__wf_atom_c8c5ba0a() then
			cameraControl:__wf_atom_fd14c463(v71)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("NIGHTFOLD_MENU_TIME"), "CHARACTER_TOTAL")

		if not __wf_atom_7e8ad928(v38) then
			__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("NIGHTFOLD_MENU_TIME"), "CHARACTER_" .. v38)
		end

		v38 = nil
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(false)
	end
end

local function fn73()
	print("ResumeAdvanceAndShutdown")

	if not __wf_atom_7e8ad928(v2) then
		gRegion:__wf_atom_dd1e4d10(v2)
	end

	if not __wf_atom_7e8ad928(v3) then
		gRegion:__wf_atom_dd1e4d10(v3)
	end

	if not __wf_atom_7e8ad928(v4) then
		gRegion:__wf_atom_dd1e4d10(v4)
	end

	if not __wf_atom_7e8ad928(v5) then
		gRegion:__wf_atom_dd1e4d10(v5)
	end

	if not __wf_atom_7e8ad928(statOwner) then
		local cameraControl = statOwner:CameraControl()

		if not cameraControl:__wf_atom_c8c5ba0a() then
			cameraControl:__wf_atom_fd14c463(0.1)
		end

		fn15(nil, 0.1)
	end

	gRegion:__wf_atom_dd1e4d10(v)
	mMovie:__wf_atom_0c1c47f2(nil)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FireLight"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_8a035cd5(Symbol("FadeToFire"), false)
	end

	module.PlaySound(exitSound)
	fn72()
	module5.DissolveOutAndClose(mMovie)
	local movie = __wf_atom_8e4fda44:FindMovie(currencyBarMovie)

	if movie then
		movie:__wf_atom_f0448d34(false)
	end

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(mMovie)
	end
end

local function fn74()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.locString = Localize("/SF/Language/Menu/VirtueConfirmChangeWarning", true)
	dialogSettings.titleString = "/SF/Language/Menu/VirtueConfirmChange"
	dialogSettings.dialogType = 1
	dialogSettings.firstString = "/SF/Language/Menu/VirtueConfirm"
	dialogSettings.secondString = "/SF/Language/Menu/VirtueRevert"
	dialogSettings:SetCallback("OnVirtueDialogConfirm")
	module.ShowCustomMessage(dialogSettings)
end

local function fn75()
	print("AdvanceAndShutdown")

	if v35 then
		fn74()
		return
	end

	if flag then
		return
	end

	if flag5 then
		fn67()
		return
	end

	if v30 then
		fn57("OnSaveLoadOutComplete")
	end

	flag = true
	v24 = nil

	if not v30 then
		fn73()
		return
	end

	fn29(1)
	flag2 = true
end

function OnVirtueDialogConfirm(p)
	if p == 4 then
		ConfirmVirtueChanges()
	elseif p == 5 then
		RevertVirtueChanges()
	end

	v35 = false
	fn75()
end

function ConfirmStartingGear()
	fn75()
end

local function fn76()
	if v30 then
		return
	end

	if v31 then
		v31 = false
		module2.RequestLoadOutBuild(v6)
	end

	if not __wf_atom_7e8ad928(statOwner) then
		local __wf_atom_d2b2176d = statOwner:__wf_atom_d2b2176d()

		if __wf_atom_d2b2176d:__wf_atom_e65461b9() or __wf_atom_7e8ad928(__wf_atom_d2b2176d:__wf_atom_e55d02aa()) then
			return
		end
	end

	flag2 = false
	fn29(0)
	fn73()
end

function onKeyDown_MENU_RIGHT_X(_, p)
	local v90 = tonumber(p)
	v78:__wf_atom_09294a87(math.abs(v90) < 0.2 and 0 or v90)
	return true
end

function onKeyUp_MENU_RIGHT_X()
	v78:__wf_atom_09294a87(0)
	return true
end

function onKeyDown_MENU_CLICK()
	local focus = mMovie:GetFocus()

	if not mMovie:__wf_atom_94bf489f() and focus == "" then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)

		if __wf_atom_5e6e15c8 ~= -1000 and __wf_atom_5e6e15c8_2 ~= -1000 then
			v80 = __wf_atom_5e6e15c8
			v81 = __wf_atom_5e6e15c8_2
			flag6 = true
		end
	end
end

function onKeyUp_MENU_CLICK()
	flag6 = false
end

local function fn77(p)
	local v90 = flag5
		and mMovie:__wf_atom_5e6e15c8("_root", 30) > mMovie:__wf_atom_5e6e15c8("InventoryContainer.InventoryGrid", 2)

	if v42 ~= v90 then
		v42 = v90
		mMovie:__wf_atom_40912f8e(not v42)
	end

	if v90 then
		return
	end

	if not Engine.IsPlayingWithController() then
		if flag6 then
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)

			if __wf_atom_5e6e15c8 ~= -1000 and __wf_atom_5e6e15c8_2 ~= -1000 then
				v78:__wf_atom_09294a87((__wf_atom_5e6e15c8 - v80) * 0.2)
				v80 = __wf_atom_5e6e15c8
				v81 = __wf_atom_5e6e15c8_2
			end
		else
			v78:__wf_atom_09294a87(0)
		end
	end

	v78:Update(p)
	local __wf_atom_9e368823 = v78:__wf_atom_9e368823()

	if math.abs(__wf_atom_9e368823) > 0.0001 then
		heading -= __wf_atom_9e368823 * 1
		local v91 = Rotation(heading, 0, 0)
		heading = v91.heading

		if not __wf_atom_7e8ad928(arsenalAvatar) then
			arsenalAvatar:__wf_atom_51075230(v91)
		end
	end

	UpdateRotatingUI(not flag6)
end

function Update()
	local v90 = __wf_atom_fa1258d0()
	local v91 = __wf_atom_084b3e93()
	mMovie:__wf_atom_88d9cd84(v90)
	asyncLoader:Update()

	if not __wf_atom_7e8ad928(v26) then
		v26:Update(v91)
	end

	if __wf_atom_7e8ad928(arsenalAvatar) or __wf_atom_7e8ad928(statOwner) then
		mMovie:Close()
		return
	end

	if topMenuOpen ~= _T.TopMenuOpen then
		if _T.TopMenuOpen then
			mMovie:__wf_atom_f0448d34(false)
		else
			mMovie:__wf_atom_f0448d34(true)
		end
	end

	topMenuOpen = _T.TopMenuOpen

	if not __wf_atom_7e8ad928(v60) then
		v60:Update(v90)
	end

	local __wf_atom_d9cb4b97 = arsenalAvatar:MotionControl():__wf_atom_d9cb4b97()
	local __wf_atom_92d75093 = v6:__wf_atom_92d75093()
	local v92 = __wf_atom_92d75093.x - v52.x
	local v93 = __wf_atom_92d75093.y - v52.y
	v52 = __wf_atom_92d75093

	if not (__wf_atom_7e8ad928(v) or flag) then
		local v94 = v70[1]
		local v95 = v70[2]
		local __wf_atom_2490589b = v10:__wf_atom_2490589b(v94, v90)
		local __wf_atom_2490589b2 = v11:__wf_atom_2490589b(v95, v90)
		v:__wf_atom_9b788a35(v9 + Rotation(__wf_atom_2490589b, __wf_atom_2490589b2, 0))
	end

	if #v8 == 0 then
		for k, v94 in v64 do
			v8[k] = arsenalAvatar:__wf_atom_1c374cc9(v94.Bone)
		end
	end

	__wf_atom_d9cb4b97.heading += v79 - heading

	for k, v94 in v64 do
		v8[k] = __wf_atom_f55d6358(v8[k], arsenalAvatar:__wf_atom_1c374cc9(v94.Bone), v90 * 0.3)
		local v95 = v8[k] + __wf_atom_9341614d(v94.Pos, __wf_atom_d9cb4b97)
		local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(v95)
		mMovie:__wf_atom_e57658c2(v94.Clip, 0, __wf_atom_74b9a49b.x)
		mMovie:__wf_atom_e57658c2(v94.Clip, 1, __wf_atom_74b9a49b.y)
	end

	v27 = true
	local mVelocity = math.abs(v10.mVelocity)
	local mVelocity2 = math.abs(v11.mVelocity)

	if v70[3] and (mVelocity > 0.35 or mVelocity2 > 0.35) then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v70[3] .. ".Hover", 2)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v70[3] .. ".Hover", 3)
		v53.x += v92
		v53.y += v93
		local convertToScreenPosition = module.ConvertToScreenPosition(
			mMovie,
			Vector(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2, 0)
		)
		local v94 = math.floor(convertToScreenPosition.x + 0.5) + v53.x
		local v95 = math.floor(convertToScreenPosition.y + 0.5) + v53.y
		v52.x = v94
		v52.y = v95

		if not flag then
			v6:__wf_atom_a16f9b3c(v94, v95)
			__wf_atom_8e4fda44:__wf_atom_b005c93e(v94, v95)

			if not __wf_atom_7e8ad928(__wf_atom_8e4fda44:__wf_atom_04e714d5()) then
				__wf_atom_8e4fda44:__wf_atom_04e714d5():__wf_atom_34940d8a(v94, v95)
			end
		end

		v27 = true
	end

	if not flag5 and not __wf_atom_7e8ad928(v24) and not __wf_atom_7e8ad928(v24.Rect) and v70[3] then
		local transformPixelToViewportCoordinates = module.TransformPixelToViewportCoordinates(mMovie, {
			x = mMovie:__wf_atom_5e6e15c8(v70[3] .. ".Label", 2),
			y = mMovie:__wf_atom_5e6e15c8(v70[3] .. ".Label", 3) + 25
		})
		v24.Rect.X = __wf_atom_104bfe98(v24.Rect.X, transformPixelToViewportCoordinates.x, 0.5)
		v24.Rect.Y = __wf_atom_104bfe98(v24.Rect.Y, transformPixelToViewportCoordinates.y, 0.5)
	end

	for _, v94 in pairs(v29) do
		v94:Update()
	end

	fn38()

	if flag2 then
		fn76()
	end

	fn77(v90)
	UpdateVirtueControl(v90)
end

function OnSaveLoadOutComplete(p, _)
	fn29(0)
	module2.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
	v30 = false
	v31 = p
	__wf_atom_539492fe:__wf_atom_c2038c7a(v6, Symbol("ARSENAL_SAVED"))
end

function OnUpdateSessionSettings() end

local function fn78()
	if v12 == nil then
		return nil
	end

	local v90 = v12 - v62.MAX_Value
	local v91

	if v90 > 0 then
		return v17[v90]
	end

	return v91
end

function EquipmentGridItemPressed()
	local v90 = fn78()

	if not __wf_atom_7e8ad928(v90) then
		v90:SelectElementById(1)
	end

	module.PlaySound(equipmentGridOpenSound)
end

function EquipmentGridItemFocused()
	local v90 = fn78()

	if not __wf_atom_7e8ad928(v90) then
		v90:FocusElementById(1)
	end
end

function EquipmentGridItemUnfocused()
	local v90 = fn78()

	if not __wf_atom_7e8ad928(v90) then
		v90:UnfocusElementById(1)
	end
end

function onKeyDown_MENU_SELECT() end

function onKeyUp_MENU_CANCEL()
	if flag5 then
		fn67()
		UpdateButtons()
	else
		fn75()
	end

	return true
end

function onKeyDown_MENU_GENERIC1()
	return true
end

function onKeyDown_MENU_RIGHT_CLICK()
	if flag then
		return true
	end

	if flag5 then
		AskToDismantle(v56)
	else
		if __wf_atom_7e8ad928(v24) or __wf_atom_7e8ad928(v24.Type) then
			return true
		end

		if not v24.Type:IsA(__wf_atom_9df43583) and itemCategory == nil and v24.Type:IsA(baseHelmType) then
			local v90 = v7[0]
			local __wf_atom_b369d77f = v90:__wf_atom_b369d77f(0)
			local __wf_atom_0ff4b555 = inventory:__wf_atom_0ff4b555(0, 0, __wf_atom_b369d77f.mItemId.mId)
			local __wf_atom_eb82ab1f = __wf_atom_0ff4b555:__wf_atom_eb82ab1f(__wf_atom_b369d77f.mCustSlot)
			local __wf_atom_f9098661 = __wf_atom_eb82ab1f:__wf_atom_f9098661(4, 0)
			local color = __wf_atom_eb82ab1f:GetColor(4, 0)
			local v91 = __wf_atom_f9098661 and bit32.extract(color.red, 0) == 1
			color.red = bit32.replace(color.red, v91 and 0 or 1, 0)
			__wf_atom_eb82ab1f:SetColor(4, 0, color)
			__wf_atom_eb82ab1f:__wf_atom_59cc106e(4, 0, true)
			__wf_atom_eb82ab1f:ApplyCustomization(arsenalAvatar, false)
			__wf_atom_0ff4b555:SetCustomization(__wf_atom_eb82ab1f, __wf_atom_b369d77f.mCustSlot)
			inventory:__wf_atom_fe6304ae(
				__wf_atom_b369d77f.mItemId.mId,
				__wf_atom_b369d77f.mCustSlot,
				__wf_atom_eb82ab1f
			)
			gGameData:__wf_atom_efd6bfce(0, v90)
			fn3(arsenalAvatar)
			v30 = true

			if v29.mPreviewLoader ~= nil and v29.mPreviewLoader.mResLoader:__wf_atom_86399a47() then
				v24.Refresh = true
				fn55()
				fn54()
			end
		end
	end

	return true
end

function ShowItemTicker(p)
	if p == v59 then
		return
	end

	v59 = p
	module5.RegisterHideHud(not p)
	local movie = __wf_atom_8e4fda44:FindMovie(WeakResource("/SF/Interface/HUD/Hud.swf"))

	if movie then
		movie:__wf_atom_f0448d34(p)
	end
end

function OnItemDismantled(p, p2)
	local v90 = fn8(v57)

	if p then
		ShowItemTicker(true)
		v26:ClearTimers()
		v26:AddTimer(5, function()
			ShowItemTicker(false)
		end)
		module.PlaySound(sellConfirmSound)
		local v91 = {}
		local v92 = ""

		if v90 then
			local inventoryChanges = (__wf_atom_0a63ecce(p2) == "" and {} or cjson.decode(p2)).inventoryChanges

			if inventoryChanges ~= nil then
				for k, miscItem in inventoryChanges.MiscItems do
					local v93 = miscItem
					asyncLoader:LoadResource("Resource" .. k, WeakResource(miscItem.ItemType), function(p3)
						local v94 = Resource(p3)

						if v94 ~= nil then
							v91.Icon = v94:GetIconTexture()
							local c_str = v94:__wf_atom_014a76a2():c_str()
							v92 = v93.ItemCount .. " " .. mMovie:__wf_atom_8e9ac384(c_str, false)
							module5.AddPickupLogMessage(v92, v91)
						end
					end)
				end
			end
		else
			v91.Icon = dracsIcon
			v91.Life = 2
			local v93 = v57.SellingPrice .. " " .. mMovie:__wf_atom_8e9ac384("/SF/Language/Progression/Dracs", false)
			module5.AddPickupLogMessage(v93, v91)
		end
	elseif v90 then
		module.ShowMessage("/SF/Language/Vendor/DismantleItemFailed")
	else
		module.ShowMessage("/SF/Language/Vendor/SellFailed")
	end

	local mCurrentScroll = v72.mScrollBar.mCurrentScroll
	local unfilteredIndexForElement = v72:GetUnfilteredIndexForElement(v57)

	if unfilteredIndexForElement ~= nil then
		v72:RemoveElementUnfiltered(unfilteredIndexForElement, true, true)
		v72:Redraw(nil, true, true)
		v72.mScrollBar:SetScrollValue(mCurrentScroll, true, true)
	end

	if _T.BackgroundMovie ~= nil then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	v57 = nil
	v56 = nil
	flag = false
	v58 = nil
end

function DismantleItem(p)
	flag = false

	if v57 ~= nil then
		return
	end

	if tonumber(p) == 4 and v56 ~= nil then
		if _T.BackgroundMovie ~= nil then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
		end

		v57 = v56
		local sellOperation = SF.SellOperation()
		sellOperation:__wf_atom_afdfc7fe()
		local category = v57.Category
		local sellingPrice = v57.SellingPrice
		sellOperation:SellItem(category, tostring(v57.mItem.mItemId), 1)

		if fn8(v57) then
			sellOperation.mSellCurrency = 6
		else
			sellOperation.mSellCurrency = 0
			sellOperation.mSellPrice = sellingPrice
		end

		v58 = SF.SellCommand(sellOperation, "OnItemDismantled")
		v58:Execute()
	else
		v57 = nil
		v56 = nil
	end
end

function AskToDismantle(p)
	if p == nil or flag then
		return
	end

	flag = true
	local name = p.Name
	local sellingPrice = p.SellingPrice
	local v90 = "<font face=\"Spectral SC\" color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">"
	local v91 = v90 .. Localize(name, nil) .. "</font>"
	local price = v90 .. mMovie:__wf_atom_8e9ac384("/SF/Language/Currency/CurrencyAmount", true, {
		AMOUNT = sellingPrice
	}) .. "</font>"
	local _ = "<p><font >" .. mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/ConfirmSale", true, {
		PRICE = price,
		ITEM = v91
	}) .. "</font></p>"
	mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/SellItemHeading", true)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/DismantleItem", true, {
		ITEM = v91
	})
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/Dismantle", true)

	if module6.CanDismantleItem(p) and v57 == nil then
		module.ShowYesOrNoMessage(__wf_atom_8e9ac384, "DismantleItem", nil, __wf_atom_8e9ac384_2)
		return
	end

	local __wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/DismantleNotAllowed", true, {
		ITEM = v91
	})
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:__wf_atom_799d95f5()) then
		__wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384("/SF/Language/Vendor/DismantleDisabled", true)
	end

	module.ShowMessage(__wf_atom_8e9ac384_3, "OnErrorHandler")
	flag = false
	return false
end

function onKeyDown_MENU_GENERIC2()
	onKeyDown_MENU_RIGHT_CLICK()
	return true
end

function onKeyDown_MENU_GENERIC3()
	if __wf_atom_7e8ad928(v72) then
		return
	end

	local focusedElement = v72:GetFocusedElement()

	if not __wf_atom_7e8ad928(focusedElement) and module6.ToggleFavoriteItem(focusedElement) then
		v72.ITEM_UTIL.Update(mMovie, focusedElement.mClipName, focusedElement, v72)
		focusedElement.Refresh = true
		v30 = true
		module.PlaySound(_G.UISound_Select)
	end

	return true
end

function OnGamepadTransition(_)
	fn31()
end