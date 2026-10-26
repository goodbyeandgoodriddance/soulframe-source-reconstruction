local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Scripts.Libs.AudioLib")
local module4 = require("SF.Scripts.HudTrackers")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module6 = require("Lotus.Interface.UIStyleUtilities")
local module7 = require("SF.Interface.SFUtilities")
local module8 = require("SF.Scripts.Libs.SparrowLib")
local module9 = require("SF.Scripts.Libs.QuestLib")
local module10 = require("Lotus.Scripts.Libs.AbilitiesLib")
local module11 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module12 = require("EE.Interface.AnchorMgr")
local module13 = require("SF.Interface.Libs.UIUtilities")
local module14 = require("SF.Scripts.Libs.EncounterLib")
local module15 = require("SF.Souls.Powers.EntitySoulModeScans")
local module16 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module17 = require("Lotus.Interface.BindingsUtil")
local module18 = require("Lotus.Interface.LotusNetworkUtilities")
local v = { DISABLED = 1, ENABLED = 3, MUTED = 2, TALKING = 4 }
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local mSettings = nil
local v7 = nil
local playerAvatar = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = 0
local v15 = __wf_atom_10cd16b2(1, 0.2)
local v16 = 0
local v17 = false
local v18 = nil
local v19 = nil
local v20 = {}
local v21 = 0.5
local v22 = 0.5
local v23 = 1
local v24 = 0
local v25 = {
	SOUL_MODE_DISSOLVE_IN_TIME = 0.2,
	SOUL_MODE_DISSOLVE_OUT_TIME = 3,
	FULL_ALPHA = 75,
	SOUL_METER_HEIGHT = 130,
	SOUL_ENERGY_COLOR = Color(16044441),
	ARROW_Y_DELTA = 6
}
local v26 = 0
local flag = false
local v27 = nil
local v28 = -1
local v29 = {}
local v30 = false
local v31 = {
	mScreenDuck = 0,
	mTransOnRightSide = false,
	mPlayingWithController = false,
	mDispatchingQueuedFuncs = false,
	mWasSpectating = false,
	mSpaceMode = false,
	mImpactMessageFrame = 0,
	mImpactMessageScale = 100,
	mImpactMessageTransitionScale = 100,
	mImpactMessageText = "",
	mImpactMessageFilter = nil,
	mImpactMessageParameters = nil,
	mImpactMessageDuration = 0,
	mImpactMessageWithCountdown = false,
	IsSpectating = false,
	IsOperator = false,
	Initialized = false,
	UIMode = false,
	IsInConclave = false,
	mProfileMovie = nil,
	mHudMarkersMovie = nil,
	mHudTrackersMovie = nil,
	mDistanceFieldMiniMap = true,
	PlayerListHasChanged = false,
	MissionType = -1,
	StalkerMode = false,
	IsAlternateHud = false,
	mEnergyVisible = true,
	mMiniMapHidden = false,
	mAbilityFxPlayed = false,
	mHasSoulStealAbility = false
}
local v32 = { 1, 1, 1 }
local __wf_atom_d91abe08s = { false, false, false }
local __wf_atom_d91abe08s2 = { false, false, false }
local v34 = { true, true, true }
local v35 = false
local v36 = { nil, nil, nil }
local v37 = nil
local v38 = nil
local v39 = false
local v40 = -1
local v41 = true
local v42 = false
local v43 = nil
local mAvatar = nil
local v44 = { 100, 100, 100 }
local v45 = __wf_atom_10cd16b2(1, 0.25)
local v46 = 0
local v47 = false
local progressionScreenCooldownDuration2 = 0
local v48 = nil
local mAvatar2 = nil
local v49 = true
local v50 = -1
local v51 = {}
local v52 = 1
local v53 = 1
local v54 = {
	Scale = 50,
	HealthFillScale = 66,
	StabilityFillScale = 79.983,
	Alpha = 75,
	StabilityAlpha = 80,
	BackerAlpha = 75,
	PulseScale = 1.25
}
local gGameRules2 = nil
local v55 = nil
local v56 = nil
local v57 = {
	InventoryController = nil,
	DamageController = nil,
	CameraController = nil,
	InputController = nil
}
local class = nil
local v58 = nil
local flag2 = false
local v59 = false
local v60 = false
local v61 = false
local v62 = nil
local v63 = false
local v64 = false
local v65 = false
local module19 = require("SF.Interface.Components.BoosterInfo")
local count = 0
local v66 = {}
local v67 = __wf_atom_10cd16b2(0, 0.15)
local flag3 = false
local v68 = Vector()
local v69 = Vector()
local v70 = false
local v71 = nil
local v72 = Symbol("SOUL_MODE_HIDDEN")
local v73 = Symbol("SOUL_MODE_HIDDEN_UPGRADED")
local v74 = Symbol("SOUL_MODE_SHOWN")
local v75 = WeakResource("/SF/Fx/Gameplay/Interactables/SoulModeSphereDeco")
local v76 = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")
local v77 = nil
local v78 = Symbol("FirstTemperLearned")
local v79 = WeakResource("/SF/Sounds/Dialog/Quests/AncestorRelationshipTuvalkane/DTMPRS00375Tuvalkane")
local v80 = WeakResource("/SF/Sounds/Dialog/Quests/AncestorRelationshipTuvalkane/TemperTransmission")
local v81 = {
	HudScalePadding = { 0, 0 },
	HudScale = 1
}
local v82 = {}
local v83 = {}
local v84 = false
local v85 = nil
local v86 = { __wf_atom_10cd16b2(0, 0.1), __wf_atom_10cd16b2(0, 0.1), __wf_atom_10cd16b2(0, 0.1) }
local v87 = { Symbol("ABILITY_READY_0"), Symbol("ABILITY_READY_1"), Symbol("ABILITY_READY_2") }
local v88 = WeakResource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")
local v89 = nil
local v90 = nil
local v91 = nil
local v92 = nil
local v93 = nil
local v94 = __wf_atom_10cd16b2(0, 0.15)
local v95 = WeakResource("/SF/Interface/HUD/PetStatus.swf")

local function fn(callback, ...)
	if not v31.Initialized then
		return
	end

	if v31.mDispatchingQueuedFuncs then
		callback(...)
		return
	end

	table.insert(v29, { callback, ... })

	if #v29 > 400 and _G.functionQueueOverflow == nil then
		LogBug("Hud queue overflow")
		_G.functionQueueOverflow = true
	end
end

local function fn2(object)
	local __wf_atom_1bb5b1ff = object:__wf_atom_1bb5b1ff()
	local __wf_atom_9765cbd5 = object:__wf_atom_9765cbd5()
	local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(__wf_atom_9765cbd5, __wf_atom_1bb5b1ff)
	local __wf_atom_a1680b24 = __wf_atom_c67f9605:__wf_atom_a1680b24(__wf_atom_1bb5b1ff)
	local v96 = math.min(__wf_atom_b4a75eaa + 1, __wf_atom_a1680b24)
	local __wf_atom_89d4ac2a = __wf_atom_c67f9605:__wf_atom_89d4ac2a(v96, __wf_atom_1bb5b1ff)
	local __wf_atom_89d4ac2a2 = __wf_atom_c67f9605:__wf_atom_89d4ac2a(__wf_atom_b4a75eaa, __wf_atom_1bb5b1ff)
	return __wf_atom_421b01aa(
		(__wf_atom_9765cbd5 - __wf_atom_89d4ac2a2) / (__wf_atom_89d4ac2a - __wf_atom_89d4ac2a2),
		0,
		1
	)
end

local function fn3(p, p2)
	module4.RemoveHudTracker(p, p2)
end

local function fn4(p, p2, p3)
	local v96 = math.pow(
		module16.GetAncestorUpgradeRankValueForTag(
			v88,
			Symbol("SpectralLightHighlightRange"),
			Symbol("SPECTRAL_LIGHT_RANGE")
		),
		2
	)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)
	local position

	if not __wf_atom_7e8ad928(v7) then
		position = v7:GetPosition()
	end

	for _, v97 in ipairs(__wf_atom_2226b35c) do
		if v97:IsA(__wf_atom_67c46eba) and v97:__wf_atom_535d5cbb() and v97:__wf_atom_4417a5d4() then
			continue
		end

		local v98

		if position and not (v96 < __wf_atom_a93b9922(position, v97:GetPosition())) then
			v98 = p2
		else
			v98 = p3
		end

		if v98 < 1 then
			v97:__wf_atom_a7ee9662(true, true)
		elseif v98 >= 1 then
			v97:__wf_atom_a7ee9662(false, true)
		end

		if v97:IsA(__wf_atom_9578cbaa) then
			if v98 >= 1 and v97:IsActive() then
				v97:Disable()
			elseif v98 < 1 and not v97:IsActive() then
				v97:Enable()
			end
		end

		if v97:IsA(__wf_atom_d00f34c2) then
			v97:__wf_atom_edd3fec6(1 - v98)
		end

		v97:__wf_atom_a763aa1a(v98)
		v97:__wf_atom_68f2c268(v98)
	end
end

local function fn5()
	fn4(v72, v23, 1)
	fn4(v74, v24, 0)

	if module16.GetAncestorUpgradeRankValueForTag(v88, Symbol("HighlightSpawnedResources"), Symbol("ENABLE")) > 0 then
		fn4(v73, v23, 1)
	end

	if v23 <= 0 then
		module3.EnableTaggedSequencers(Symbol("SoulModeSFX"), true)
	elseif v23 >= 1 then
		module3.EnableTaggedSequencers(Symbol("SoulModeSFX"), false)
	end

	_T.NeedSoulModeVisUpdate = nil
end

local function fn6(p)
	if __wf_atom_7e8ad928(p) or p == "" then
		HideImpactMessage()
	else
		ShowImpactMessage(p, -1)
	end
end

local function fn7()
	local __wf_atom_97cd8326 = mMovie:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = mMovie:__wf_atom_54eeda24()
	local screenDimensions, v96 = module.GetScreenDimensions(mMovie)
	v68.x = -(screenDimensions - __wf_atom_97cd8326) / 2
	v68.y = -(v96 - __wf_atom_54eeda24) / 2
	v69.x = __wf_atom_97cd8326 + (screenDimensions - __wf_atom_97cd8326) / 2
	v69.y = __wf_atom_54eeda24 + (v96 - __wf_atom_54eeda24) / 2

	if v81.HudScale == 0 or v81.HudScale == nil then
		v81.HudScale = 1
	end

	local v97 = 1 / v81.HudScale
	mMovie:__wf_atom_e57658c2("PainTop", 14, screenDimensions * v97)
	mMovie:__wf_atom_e57658c2("PainBottom", 14, screenDimensions * v97)
	mMovie:__wf_atom_e57658c2("PainLeft", 15, v96 * v97)
	mMovie:__wf_atom_e57658c2("PainRight", 15, v96 * v97)
end

local function fn8()
	v81.HudScalePadding = module13.HandleHudScale(mMovie, v81.HudScale, nil, v83)

	if not __wf_atom_7e8ad928(v12) then
		v12:HandleHudScale()
	end

	if not __wf_atom_7e8ad928(v3) then
		for _, v96 in pairs(v82) do
			local coords = v3:GetCoords(v96.Clip)
			v12:__wf_atom_dc63139a(v96.Movie, v96.Clip, coords.x, coords.y)

			if not v96.HandleHudScale or __wf_atom_7e8ad928(v96.Movie) then
				continue
			end

			module13.HandleHudScale(v96.Movie, v81.HudScale, v3, v83)
		end
	end

	if v3 ~= nil then
		v3:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true, v81.HudScalePadding)
	end

	fn7()
end

function AddMotionClip(movie, clip, handleHudScale, applyTrackerOffset)
	if __wf_atom_7e8ad928(v12) then
		return
	end

	local coords = v3:GetCoords(clip)

	if __wf_atom_7e8ad928(coords) then
		print("HUD::addMotionClip - Could not add " .. clip .. " to motion clips, clip not found in AnchorMgr")
	else
		table.insert(v82, {
			Clip = clip,
			Movie = movie,
			HandleHudScale = handleHudScale,
			ApplyTrackerOffset = applyTrackerOffset
		})
		v12:__wf_atom_dc63139a(movie, clip, coords.x, coords.y)

		if handleHudScale and not __wf_atom_7e8ad928(movie) then
			module13.HandleHudScale(movie, v81.HudScale, v3, v83)
		end

		if applyTrackerOffset then
			module4.Sort()
		end
	end
end

function onHudMarginsChanged()
	if not (__wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(v3)) then
		v3:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true, v81.HudScalePadding)

		for _, v96 in pairs(v82) do
			local coords = v3:GetCoords(v96.Clip)
			v12:__wf_atom_dc63139a(v96.Movie, v96.Clip, coords.x, coords.y)
		end

		v12:__wf_atom_c06cd6e6(v3:GetCoords("Notification").y)
	end

	fn7()
end

function onViewportSizeChanged(_, _, _, _)
	if not __wf_atom_7e8ad928(v4) then
		v4:OnViewportSizeChanged()
	end

	module.ScaleSlicedMaterials(mMovie, { impactBackerMaterial })
	module7.ScaleBackerToViewport(mMovie, "ImpactMessage.Backer")
	FormatImpactMessageBacker()

	if not __wf_atom_7e8ad928(v3) then
		v3:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true, v81.HudScalePadding, v81.HudScale)

		for _, v96 in pairs(v82) do
			local coords = v3:GetCoords(v96.Clip)
			v12:__wf_atom_dc63139a(v96.Movie, v96.Clip, coords.x, coords.y)
		end

		v12:__wf_atom_c06cd6e6(v3:GetCoords("Notification").y)
	end

	if __wf_atom_7e8ad928(v2) then
		fn8()
	else
		v2:AddTimer(0.01, function()
			fn8()
		end)
	end

	fn7()
end

local function fn9()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local settings = __wf_atom_18a5d83b:Settings()

	if settings then
		v81.HudScale = settings:__wf_atom_db8b3656()
		v81.mCrosshairAlpha = settings:__wf_atom_350909f6()
		v81.mCrosshairScale = settings:__wf_atom_18fcaa61()
		mMovie:__wf_atom_e57658c2("LockOn.Crosshair", 12, v81.mCrosshairAlpha * 100)
	end

	v85 = settings:__wf_atom_d6069beb()
	fn8()
end

function OnProfileSaved()
	fn9()
end

local function fn10(instance)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_6c243c5e) then
		return
	end

	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()

	if instance:__wf_atom_4573db05() then
		if v77 ~= true and not instance:__wf_atom_a586ea4c(avatarAnimalSoulMode) then
			local v96 = true

			if not __wf_atom_7e8ad928(gRegion:__wf_atom_2202ffb6()) then
				local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
				local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

				if not (__wf_atom_7e8ad928(__wf_atom_7d789620) or __wf_atom_7e8ad928(__wf_atom_eab484a7) or __wf_atom_7d789620:__wf_atom_37241977(__wf_atom_eab484a7)) then
					v96 = false
				end
			end

			if not (_T.HideAnimalTutorial or v96) then
				_T.ShowImpactMessage("/SF/Language/Motes/MoteCaptureHelpText", 5)
			end
		end

		__wf_atom_e919fb8e.prevHasMote = true

		if not __wf_atom_e919fb8e.MusicResponse then
			return
		end
	elseif __wf_atom_e919fb8e.prevHasMote ~= false then
		local __wf_atom_0c59b746 = instance:__wf_atom_0c59b746()

		for _, v96 in ipairs(__wf_atom_0c59b746) do
			local __wf_atom_18aa6e58 = v96:__wf_atom_18aa6e58()

			if __wf_atom_7e8ad928(__wf_atom_18aa6e58) or not __wf_atom_18aa6e58:IsA(v75) then
				continue
			end

			instance:__wf_atom_8f12baaa(v96)
		end

		__wf_atom_e919fb8e.prevHasMote = false
	end
end

local function fn11(list)
	for _, v96 in ipairs(list) do
		if not __wf_atom_7e8ad928(v96.mItemType) and v96.mItemType:IsA(v76) then
			return true
		end
	end

	return false
end

local function fn12()
	local ancestorUpgradeRankValueForTag = module16.GetAncestorUpgradeRankValueForTag(
		v88,
		Symbol("SpectralLightHighlightRange"),
		Symbol("SPECTRAL_LIGHT_RANGE")
	)
	local all = gRegion:FindAll(__wf_atom_9e85eea2)
	local result = {}

	for i = 1, #all do
		if all[i]:IsKilled() or all[i]:__wf_atom_e93896ba() == Symbol("Neutral") or all[i]:__wf_atom_129d1aba(v7) then
			continue
		end

		if not (all[i]:__wf_atom_464a4772() and all[i]:__wf_atom_8a6b8fc3(v7) < ancestorUpgradeRankValueForTag or all[i]:__wf_atom_8a6b8fc3(v7) < ancestorUpgradeRankValueForTag) then
			continue
		end

		table.insert(result, all[i])
	end

	return result
end

local function fn13(_, p)
	if p then
		local v96 = module16.GetAncestorUpgradeRankValueForTag(v88, Symbol("CombatUnawareHighlight"), Symbol("ENABLE")) > 0
		local v97 = module16.GetAncestorUpgradeRankValueForTag(v88, Symbol("CombatAwareHighlight"), Symbol("ENABLE")) > 0

		if v96 or v97 then
			local v98 = fn12()

			for i, v99 in ipairs(v98) do
				local v100 = v96 and not v98[i]:__wf_atom_3a6b0cbb() and true or false

				if not (v97 and v98[i]:__wf_atom_3a6b0cbb() or v100) or v99:__wf_atom_a586ea4c(soulAllyProjector) then
					continue
				end

				v99:Attach(soulAllyProjector, EMPTY_SYMBOL)
				table.insert(v20, v99)
			end
		end
	else
		for i = 1, #v20 do
			if not __wf_atom_7e8ad928(v20[i]) then
				v20[i]:__wf_atom_0650fed7(soulAllyProjector)
			end
		end

		v20 = {}
	end
end

local function fn14(p, p2, p3)
	if p2 then
		fn13(p3, true)

		if not v42 then
			local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

			for _, v96 in ipairs(__wf_atom_3c8e1a7a) do
				if not (v96 ~= v8 and v96:__wf_atom_d25abf5f()) then
					continue
				end

				local __wf_atom_50a7d83e = v96:__wf_atom_50a7d83e()

				if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:__wf_atom_a586ea4c(soulAllyProjector)) then
					__wf_atom_50a7d83e:Attach(soulAllyProjector, EMPTY_SYMBOL)
				end
			end
		end
	elseif p2 ~= v19 then
		fn13(p3, false)
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v96 in ipairs(__wf_atom_ef7900cf) do
			v96:__wf_atom_0650fed7(soulAllyProjector)
		end
	end

	if p2 ~= v19 then
		if p2 then
			v21 = 1
			local all = gRegion:FindAll(__wf_atom_9e85eea2, v7:__wf_atom_a2a18137(), 0, 30)

			if v77 ~= true then
				local v96

				if __wf_atom_7e8ad928(gGameData) then
					v96 = false
				else
					local inventory = gGameData:GetInventory()

					if __wf_atom_7e8ad928(inventory) then
						v96 = false
					else
						v96 = fn11(inventory:GetUpgrades()) or fn11(inventory:__wf_atom_063f1444())
					end
				end

				v77 = v96
			end

			for i = 1, #all do
				if not all[i]:IsKilled() then
					fn10(all[i])
				end
			end

			if not __wf_atom_7e8ad928(soulAimStartSound) then
				module.PlaySound(soulAimStartSound)
			end

			if not __wf_atom_7e8ad928(v7) then
				v7:Attach(soulAimSequencer, EMPTY_SYMBOL)

				if not __wf_atom_7e8ad928(v6) then
					v7:Attach(v6, EMPTY_SYMBOL)
				end

				local soulPulseFxType2

				if __wf_atom_7e8ad928(v9) or not v9:__wf_atom_a07f65c2() then
					soulPulseFxType2 = soulPulseFxType
				else
					soulPulseFxType2 = corruptPulseFxType
				end

				if
					not __wf_atom_7e8ad928(soulPulseFxType2)
					and __wf_atom_7e8ad928((v7:__wf_atom_bb3e7833(soulPulseFxType2)))
				then
					v7:Attach(soulPulseFxType2, EMPTY_SYMBOL)
				end
			end

			__wf_atom_ec43d06e(mMovie, "ArcanaNew", 8, { 12 }, { v25.FULL_ALPHA }, 0.334)
		else
			v21 = 0.5

			if v19 and not __wf_atom_7e8ad928(soulAimExitSound) then
				module.PlaySound(soulAimExitSound)
			end

			if not __wf_atom_7e8ad928(v7) then
				v7:__wf_atom_0650fed7(soulAimSequencer)

				if not __wf_atom_7e8ad928(v6) then
					local __wf_atom_bb3e7833 = v7:__wf_atom_bb3e7833(v6)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end
				end
			end

			module15.EndSoulmodeScan(playerAvatar, p3, v57.InputController)
			__wf_atom_ec43d06e(mMovie, "ArcanaNew", 8, { 12 }, { 0 }, 0.334)
		end

		v19 = p2
	end

	local v96 = p2 and 0 or 1
	local needSoulModeVisUpdate = _T.NeedSoulModeVisUpdate

	if v23 ~= v96 then
		local v97 = v96 - v23
		local v98 = v97 / math.abs(v97)
		local ternary = module.Ternary(v98 < 0, v25.SOUL_MODE_DISSOLVE_IN_TIME, v25.SOUL_MODE_DISSOLVE_OUT_TIME)
		v23 = __wf_atom_421b01aa(v23 + v98 * (p / ternary), 0, 1)
		needSoulModeVisUpdate = true
	end

	if v24 ~= 1 - v96 then
		local v97 = 1 - v96 - v24
		local v98 = v97 / math.abs(v97)
		local ternary = module.Ternary(v98 < 0, v25.SOUL_MODE_DISSOLVE_IN_TIME, v25.SOUL_MODE_DISSOLVE_OUT_TIME)
		v24 = __wf_atom_421b01aa(v24 + v98 * (p / ternary), 0, 1)
		needSoulModeVisUpdate = true
	end

	if needSoulModeVisUpdate then
		fn5()
	end

	if p2 and module16.GetAncestorUpgradeRankValueForTag(v88, Symbol("ScanModeUpgrade"), Symbol("ENABLE")) > 0 then
		module15.SoulScanMode(playerAvatar, p3, v57.InventoryController, v57.CameraController, v57.InputController)
	end
end

local function fn15()
	v8 = mMovie:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(v8) then
		return
	end

	local __wf_atom_50a7d83e = v8:__wf_atom_50a7d83e()

	if
		not __wf_atom_7e8ad928(__wf_atom_50a7d83e)
		and __wf_atom_50a7d83e:IsA(__wf_atom_47cae841)
		and not __wf_atom_7e8ad928(__wf_atom_50a7d83e:__wf_atom_4221009f())
	then
		__wf_atom_50a7d83e = __wf_atom_50a7d83e:__wf_atom_4221009f()
	end

	if v7 ~= __wf_atom_50a7d83e then
		fn14(0, false)
	end

	v7 = __wf_atom_50a7d83e
	playerAvatar = v8:GetPlayerAvatar(0)
end

local function fn16(p, object)
	local v96 = 1
	mMovie:__wf_atom_e57658c2(p, 12, 0)
	local __wf_atom_0f53c1b9 = object:__wf_atom_0f53c1b9()
	local __wf_atom_919e7078 = object:__wf_atom_919e7078()

	if __wf_atom_7e8ad928(__wf_atom_0f53c1b9) then
		mMovie:__wf_atom_e57658c2(p, 12, 0)
	else
		if not mMovie:__wf_atom_253d7085(p .. 2) then
			__wf_atom_86cbd68d(mMovie, p .. ".duplicateMovieClip", "Icon" .. 2, 3)
		end

		mMovie:__wf_atom_e57658c2(p .. 2, 12, 100)
		mMovie:__wf_atom_c90af43a(p .. 2, __wf_atom_0f53c1b9[2])

		if __wf_atom_7e8ad928(__wf_atom_919e7078) or #__wf_atom_919e7078 < 2 then
			mMovie:OverrideMaterial(p .. 2, nil)
		else
			mMovie:OverrideMaterial(p .. 2, __wf_atom_919e7078[2])
		end

		if #__wf_atom_0f53c1b9 == 4 then
			mMovie:__wf_atom_f321ac85(p .. 2, Symbol("NormalMap"), __wf_atom_0f53c1b9[4])
			mMovie:OverrideMaterial(p .. 2, runeMaterial)
		end

		v96 = #__wf_atom_0f53c1b9 + 1
	end

	while mMovie:__wf_atom_253d7085(p .. v96) do
		__wf_atom_86cbd68d(mMovie, p .. v96 .. ".removeMovieClip")
		v96 += 1

		if v96 > 1000 then
			LogBug("Rune icon layers overflow")
		end
	end
end

local function fn17()
	if flag2 then
		return
	end

	flag2 = true
	__wf_atom_ec43d06e(mMovie, "MotePreview.Icon", 4, { function(p)
			mMovie:__wf_atom_e57658c2("MotePreview", 5, (math.max(1, __wf_atom_104bfe98(135, 100, p))))
			mMovie:__wf_atom_e57658c2("MotePreview", 6, (math.max(1, __wf_atom_104bfe98(135, 100, p))))
		end }, { 1 }, 0.75, 0, function()
		mMovie:__wf_atom_e57658c2("MotePreview", 5, 100)
		mMovie:__wf_atom_e57658c2("MotePreview", 6, 100)
	end)
end

local function fn18()
	local v96 = { "StatsNew.CourageIcon", "StatsNew.SpiritIcon", "StatsNew.GraceIcon" }

	if not __wf_atom_7e8ad928(v9) and v9:__wf_atom_a07f65c2() then
		mMovie:__wf_atom_c90af43a("StatsNew.Frame2.Border2", corruptedBorder2)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Border1", corruptedBorder1)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Notch0", corruptedDivider)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Notch1", corruptedDivider)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Notch2", corruptedDivider)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Notch3", corruptedDivider)
		mMovie:__wf_atom_c90af43a("StatsNew.SoulEnergyFill", corruptedSoulEnergy)
		mMovie:__wf_atom_c90af43a("StatsNew.SoulEnergyLockedFill", corruptedSoulEnergy)
		mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyLockedFill", 11, 16777215)
		mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyLockedFill", 12, 50)
		mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyFill", 11, 16777215)
		mMovie:__wf_atom_c90af43a("HealthComponent.HealthBarFill", corruptedHealthFill)
		mMovie:__wf_atom_c90af43a("HealthComponent.DpadFlower", corruptedDpadFlower)
		mMovie:__wf_atom_e57658c2("HealthComponent.DpadFlower", 12, 90)
		mMovie:__wf_atom_c90af43a("StatsNew.WeaponXP.Fill", corruptedXPBarFill)
		mMovie:__wf_atom_c90af43a("StatsNew.PactXP.Fill", corruptedXPBarFill)
		mMovie:__wf_atom_c90af43a("CourageLock", corruptedLockIcon)
		mMovie:__wf_atom_c90af43a("SpiritLock", corruptedLockIcon)
		mMovie:__wf_atom_c90af43a("GraceLock", corruptedLockIcon)
		mMovie:__wf_atom_e57658c2("StatsNew.WeaponXP.xpBarFrame", 11, 8621452)
		mMovie:__wf_atom_e57658c2("StatsNew.PactXP.xpBarFrame", 11, 8621452)
		mMovie:__wf_atom_e57658c2("StatsNew.Courage.Bg", 11, 2235943)
		mMovie:__wf_atom_e57658c2("StatsNew.Spirit.Bg", 11, 2235943)
		mMovie:__wf_atom_e57658c2("StatsNew.Grace.Bg", 11, 2235943)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Right.Icon", 11, 10724008)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Bottom.Icon", 11, 10724008)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Left.Icon", 11, 10724008)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Right.Icon", 12, 85)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Bottom.Icon", 12, 85)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Left.Icon", 12, 85)

		for _, v97 in v96 do
			mMovie:__wf_atom_e57658c2(v97, 11, 10724008)
			mMovie:__wf_atom_e57658c2(v97, 12, 70)
		end
	else
		mMovie:__wf_atom_c90af43a("StatsNew.Frame2.Border2", normalBorder2)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Border1", normalBorder1)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Notch0", normalDivider)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Notch1", normalDivider)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Notch2", normalDivider)
		mMovie:__wf_atom_c90af43a("StatsNew.Frame1.Notch3", normalDivider)
		mMovie:__wf_atom_c90af43a("StatsNew.SoulEnergyFill", normalSoulEnergy)
		mMovie:__wf_atom_c90af43a("StatsNew.SoulEnergyLockedFill", normalSoulEnergy)
		mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyLockedFill", 11, 6246192)
		mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyLockedFill", 12, 100)
		mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyFill", 11, v25.SOUL_ENERGY_COLOR:__wf_atom_dcecedb0())
		mMovie:__wf_atom_c90af43a("HealthComponent.HealthBarFill", normalHealthFill)
		mMovie:__wf_atom_c90af43a("HealthComponent.DpadFlower", normalDpadFlower)
		mMovie:__wf_atom_e57658c2("HealthComponent.DpadFlower", 12, 100)
		mMovie:__wf_atom_c90af43a("CourageLock", normalLockIcon)
		mMovie:__wf_atom_c90af43a("SpiritLock", normalLockIcon)
		mMovie:__wf_atom_c90af43a("GraceLock", normalLockIcon)
		mMovie:__wf_atom_e57658c2("StatsNew.WeaponXP.xpBarFrame", 11, 16777215)
		mMovie:__wf_atom_e57658c2("StatsNew.PactXP.xpBarFrame", 11, 16777215)
		local normalXPBarFill2 = normalXPBarFill
		local envoyInventoryControl = module7.GetEnvoyInventoryControl()
		local v97

		if __wf_atom_7e8ad928(envoyInventoryControl) then
			v97 = v62
		else
			v97 = envoyInventoryControl:__wf_atom_a8e8c5c4()
			v62 = v97
		end

		if not __wf_atom_7e8ad928(v97) and fn2(v97) == 1 then
			normalXPBarFill2 = pactWeaponXpBarMaxTexture
		end

		mMovie:__wf_atom_c90af43a("StatsNew.WeaponXP.Fill", normalXPBarFill2)
		local normalXPBarFill = normalXPBarFill
		local __wf_atom_e55d02aa = v7:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) and fn2(__wf_atom_e55d02aa) == 1 then
			normalXPBarFill = pactWeaponXpBarMaxTexture
		end

		mMovie:__wf_atom_c90af43a("StatsNew.PactXP.Fill", normalXPBarFill)
		mMovie:__wf_atom_e57658c2("StatsNew.Courage.Bg", 11, 5256242)
		mMovie:__wf_atom_e57658c2("StatsNew.Spirit.Bg", 11, 6124631)
		mMovie:__wf_atom_e57658c2("StatsNew.Grace.Bg", 11, 4482163)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Right.Icon", 11, _G.UIColor_Tan)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Bottom.Icon", 11, _G.UIColor_Tan)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Left.Icon", 11, _G.UIColor_Tan)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Right.Icon", 12, 100)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Bottom.Icon", 12, 100)
		mMovie:__wf_atom_e57658c2("healthComponent.Controls.Left.Icon", 12, 100)

		for _, v98 in v96 do
			mMovie:__wf_atom_e57658c2(v98, 11, _G.UIColor_Tan)
			mMovie:__wf_atom_e57658c2(v98, 12, 100)
		end
	end
end

local function fn19()
	if __wf_atom_7e8ad928(v9) then
		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.Frame2"), 13, true)
		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.Frame1"), 13, false)
		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.SoulEnergyFill"), 13, false)
		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.SoulEnergyLockedFill"), 13, false)
		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.SoulEnergyBacker"), 13, false)
		mMovie:__wf_atom_e57658c2("MotePreview", 12, 0)
	else
		local envoyInventoryControl = module7.GetEnvoyInventoryControl()
		local v96

		if __wf_atom_7e8ad928(envoyInventoryControl) then
			v96 = v62
		else
			v96 = envoyInventoryControl:__wf_atom_a8e8c5c4()
			v62 = v96
		end

		local weaponMote = module10.GetWeaponMote(v96)
		v61 = v60
		v60 = not __wf_atom_7e8ad928(weaponMote)
		module7.GetEnvoyInventoryControl()

		if v60 then
			local v97 = Resource(weaponMote)
			flag2 = false
			fn16("MotePreview.Icon", v97)
			fn17()
			mMovie:__wf_atom_e57658c2("MotePreview", 12, 100)
		else
			mMovie:__wf_atom_e57658c2("MotePreview", 12, 0)
		end

		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.Frame2"), 13, not v60)
		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.Frame1"), 13, v60)
		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.SoulEnergyFill"), 13, v60)
		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.SoulEnergyLockedFill"), 13, v60)
		mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("StatsNew.SoulEnergyBacker"), 13, v60)
		local v97 = 150
		local v98 = 120
		local v99 = not __wf_atom_7e8ad928(v9) and v9:__wf_atom_a07f65c2() and 50 or 100

		if v60 then
			if not v61 then
				v97 = 150
			end
		else
			v98 = 150

			if v61 then
				v97 = 100
			end
		end

		local v100 = v59 and 100 or 0
		mMovie:__wf_atom_e57658c2("StatsNew.SpiritIcon", 5, v97)
		mMovie:__wf_atom_e57658c2("StatsNew.SpiritIcon", 6, v97)
		mMovie:__wf_atom_e57658c2("StatsNew.Spirit", 5, v97)
		mMovie:__wf_atom_e57658c2("StatsNew.Spirit", 6, v97)
		mMovie:__wf_atom_e57658c2("StatsNew.SpiritBacker", 5, v97)
		mMovie:__wf_atom_e57658c2("StatsNew.SpiritBacker", 6, v97)
		__wf_atom_ec43d06e(mMovie, "StatsNew.SpiritIcon", 7, { 5, 6 }, { v98, v98 }, 0.3)
		__wf_atom_ec43d06e(mMovie, "StatsNew.Spirit", 7, { 5, 6 }, { v98, v98 }, 0.3)
		__wf_atom_ec43d06e(mMovie, "StatsNew.SpiritBacker", 7, { 5, 6 }, { v98, v98 }, 0.3)
		__wf_atom_ec43d06e(mMovie, "StatsNew.SoulEnergyFill", 8, { 12 }, { 100 }, 0.3)
		__wf_atom_ec43d06e(mMovie, "StatsNew.SoulEnergyLockedFill", 8, { 12 }, { v99 }, 0.3)
		__wf_atom_ec43d06e(mMovie, "StatsNew.SpiritGlow", 8, { 12 }, { v100 }, 0.3)
	end
end

function GetSoulMeterSlot()
	local envoyInventoryControl = module7.GetEnvoyInventoryControl()

	if __wf_atom_7e8ad928(envoyInventoryControl) then
		return nil
	end

	local __wf_atom_e55d02aa = envoyInventoryControl:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return nil
	end

	local envoyInventoryControl2 = module7.GetEnvoyInventoryControl()
	local v96

	if __wf_atom_7e8ad928(envoyInventoryControl2) then
		v96 = v62
	else
		v96 = envoyInventoryControl2:__wf_atom_a8e8c5c4()
		v62 = v96
	end

	local weaponMoteAbility = module10.GetWeaponMoteAbility(v96)

	if not __wf_atom_7e8ad928(weaponMoteAbility) then
		local __wf_atom_b9421344 = __wf_atom_e55d02aa:__wf_atom_b9421344(weaponMoteAbility, v96)

		if __wf_atom_b9421344 < __wf_atom_e55d02aa:__wf_atom_87a16e10() then
			return __wf_atom_e55d02aa:__wf_atom_2e4994f1(__wf_atom_b9421344)
		end
	end

	return nil
end

function IsMoteAbilityActive()
	local envoyInventoryControl = module7.GetEnvoyInventoryControl()

	if __wf_atom_7e8ad928(envoyInventoryControl) then
		return false
	end

	local __wf_atom_e55d02aa = envoyInventoryControl:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return false
	end

	local __wf_atom_35a10d3c = envoyInventoryControl:__wf_atom_35a10d3c(0)
	local weaponMoteAbility = module10.GetWeaponMoteAbility(__wf_atom_35a10d3c)

	if not __wf_atom_7e8ad928(weaponMoteAbility) then
		local __wf_atom_b9421344 = __wf_atom_e55d02aa:__wf_atom_b9421344(weaponMoteAbility, __wf_atom_35a10d3c)

		if __wf_atom_b9421344 < __wf_atom_e55d02aa:__wf_atom_87a16e10() then
			return __wf_atom_e55d02aa:__wf_atom_c497b0ae(__wf_atom_b9421344):IsActive()
		end
	end

	return false
end

local function fn20()
	_T.SpectatorHudOpen = false
	class = {}

	function class.Update()
		if
			class.isEnabled.mValue == v31.IsSpectating
			or __wf_atom_7e8ad928(gGameRules2)
			or not gGameRules2:__wf_atom_46038484()
			or gGameRules2:__wf_atom_5fcf77eb() < 4
			or __wf_atom_7e8ad928(v8)
			or __wf_atom_7e8ad928(v8:__wf_atom_50a7d83e())
		then
			return
		end

		class.isEnabled:Set(v31.IsSpectating)
	end

	class.isEnabled = module.CreateObservable(false, function(p, _)
		if p then
			if _T.SecretMiniGameActive then
				return
			end

			local __wf_atom_edfbbe1f = gGameRules2:__wf_atom_edfbbe1f()

			if not __wf_atom_7e8ad928(__wf_atom_edfbbe1f) then
				local movie = __wf_atom_8e4fda44:FindMovie(__wf_atom_edfbbe1f)

				if not __wf_atom_7e8ad928(movie) then
					movie:Close()
				end
			end

			local movie = __wf_atom_8e4fda44:FindMovie(buyReviveMovie)

			if
				not __wf_atom_7e8ad928(v8)
				and not __wf_atom_7e8ad928(v8:__wf_atom_50a7d83e())
				and not module2.IsHarvestedOrBranded(v8:__wf_atom_50a7d83e())
				and (v8:__wf_atom_50a7d83e():IsKilled() or v8:__wf_atom_50a7d83e():__wf_atom_7470861b():__wf_atom_bedb4e3f())
				and not movie
			then
				__wf_atom_8e4fda44:__wf_atom_8b74c30b(buyReviveMovie)
			end
		end
	end)
end

local function fn21(p, p2, p3, p4)
	local v96 = "HealthComponent.BuffContainer." .. p
	mMovie:__wf_atom_290807ee(v96)

	if not mMovie:__wf_atom_253d7085(v96) then
		count += 1
		__wf_atom_86cbd68d(mMovie, "HealthComponent.BuffContainer.Element.duplicateMovieClip", p, count)
	end

	mMovie:__wf_atom_2dedec1a(v96, 13, true)
	mMovie:__wf_atom_c90af43a(v96 .. ".Inner.Icon", p2)
	mMovie:__wf_atom_2dedec1a(v96 .. ".Inner.DebuffIcon", 13, p4)
	mMovie:__wf_atom_e57658c2(v96 .. ".Inner.DebuffIcon", 11, 12733773)
	mMovie:__wf_atom_c90af43a(v96 .. ".Inner.Backer", buffBackerIcon)
	mMovie:__wf_atom_c90af43a(v96 .. ".Inner.Fill", buffFillIcon)
	mMovie:__wf_atom_c90af43a(v96 .. ".Inner.Glow", buffGlowIcon)
	mMovie:__wf_atom_e57658c2(v96 .. ".Inner.Backer", 11, _G.UIColor_Beige)
	mMovie:__wf_atom_e57658c2(v96 .. ".Inner.Glow", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_2dedec1a(v96 .. ".Inner.Line", 13, false)
	mMovie:__wf_atom_e57658c2(v96, 12, 0)
	__wf_atom_ec43d06e(mMovie, v96, 8, { 12 }, { 100 }, 0.5, 0)
	mMovie:__wf_atom_e57658c2(v96 .. ".Inner.Fill", 11, p3)
	table.insert(v66, v96)
end

local function fn22(p)
	if p == nil then
		return
	end

	local v96 = "HealthComponent.BuffContainer." .. p
	__wf_atom_ec43d06e(mMovie, v96, 8, { 12 }, { 0 }, 0.5, 0, function()
		__wf_atom_86cbd68d(mMovie, v96 .. ".removeMovieClip")

		for i = 1, #v66 do
			if v66[i] == v96 then
				table.remove(v66, i)
			end
		end
	end)
end

local function fn23()
	mMovie:__wf_atom_e57658c2("HealthComponent.BuffContainer", 12, 100)
	mMovie:__wf_atom_2dedec1a("HealthComponent.BuffContainer.Element", 13, false)
	module19:AddOnAddedCallback("Hud", mMovie, function(p)
		local mActiveBooster = module19.mActiveBoosters[p]
		local mClipName = "Element" .. mActiveBooster.mItemType:GetName()
		mActiveBooster.mClipName = mClipName
		fn21(mClipName, mActiveBooster.mIconTexture, mActiveBooster.mUiColor:__wf_atom_dcecedb0(), false)
	end)
	module19:AddOnRemovedCallback("Hud", mMovie, function(p)
		fn22(module19.mActiveBoosters[p].mClipName)
	end)
	module19:Initialize(mMovie)
end

local function fn24()
	local v96 = Color(75, 5, 5)

	for i = 1, #rednightDebuffIcons do
		fn21("Debuff" .. i, rednightDebuffIcons[i], v96:__wf_atom_dcecedb0(), true)
	end
end

local function fn25()
	v3 = module12.Create(mMovie, true)
	v3.mHudScalePadding = v81.HudScalePadding
	v3:Register(mMovie, "Spinner", { v3.ANCHOR_V_TOP, v3.ANCHOR_H_LEFT })
	v3:Register(mMovie, "Notification", { v3.ANCHOR_V_TOP, v3.ANCHOR_H_CENTRE })
	v3:Register(mMovie, "Compass1", { v3.ANCHOR_V_TOP, v3.ANCHOR_H_CENTRE })
	v3:Register(mMovie, "Notify", { v3.ANCHOR_V_TOP, v3.ANCHOR_H_CENTRE })
	v3:Register(mMovie, "SpecialLogMessageContainer", { v3.ANCHOR_V_TOP, v3.ANCHOR_H_CENTRE })
	v3:Register(mMovie, "ImpactMessage", { v3.ANCHOR_V_TOP, v3.ANCHOR_H_CENTRE })
	v3:Register(mMovie, "Nightfold", { v3.ANCHOR_V_TOP, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "HealthComponent", { v3.ANCHOR_V_BOTTOM, v3.ANCHOR_H_LEFT })
	v3:Register(mMovie, "SquadInfo", { v3.ANCHOR_V_BOTTOM, v3.ANCHOR_H_LEFT })
	v3:Register(mMovie, "LogMessageContainer", { v3.ANCHOR_V_BOTTOM, v3.ANCHOR_H_LEFT })
	v3:Register(mMovie, "StatsNew", { v3.ANCHOR_V_BOTTOM, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "ArcanaNew", { v3.ANCHOR_V_BOTTOM, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "MotePreview", { v3.ANCHOR_V_BOTTOM, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "GraceLock", { v3.ANCHOR_V_BOTTOM, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "SpiritLock", { v3.ANCHOR_V_BOTTOM, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "CourageLock", { v3.ANCHOR_V_BOTTOM, v3.ANCHOR_H_RIGHT })
	v3:Register(mMovie, "PainLeft", {
		v3.ANCHOR_V_CENTRE,
		v3.ANCHOR_H_LEFT,
		IgnoreHudMargins = true
	})
	v3:Register(mMovie, "PainRight", {
		v3.ANCHOR_V_CENTRE,
		v3.ANCHOR_H_RIGHT,
		IgnoreHudMargins = true
	})
	v3:Register(mMovie, "PainTop", {
		v3.ANCHOR_V_TOP,
		v3.ANCHOR_H_CENTRE,
		IgnoreHudMargins = true
	})
	v3:Register(mMovie, "PainBottom", {
		v3.ANCHOR_V_BOTTOM,
		v3.ANCHOR_H_CENTRE,
		IgnoreHudMargins = true
	})
	v3:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	AddMotionClip(mMovie, "Notification")
	AddMotionClip(mMovie, "Compass1")
	AddMotionClip(mMovie, "Notify")
	AddMotionClip(mMovie, "SpecialLogMessageContainer")
	AddMotionClip(mMovie, "ImpactMessage")
	AddMotionClip(mMovie, "Nightfold")
	AddMotionClip(mMovie, "HealthComponent")
	AddMotionClip(mMovie, "SquadInfo")
	AddMotionClip(mMovie, "LogMessageContainer")
	AddMotionClip(mMovie, "StatsNew")
	AddMotionClip(mMovie, "ArcanaNew")
	AddMotionClip(mMovie, "MotePreview")
	AddMotionClip(mMovie, "GraceLock")
	AddMotionClip(mMovie, "SpiritLock")
	AddMotionClip(mMovie, "CourageLock")
	fn9()
end

local function fn26(p, p2, value, p3)
	if not __wf_atom_7e8ad928(v12) then
		if type(value) == "string" then
			v12:__wf_atom_5988a5fd(p, p2, value)
			return
		end

		if p3 == nil then
			p3 = false
		end

		v12:SetAbilityTimer(p, p2, value, p3 == true)
	end
end

local function fn27(p, p2, p3, p4, p5)
	if not __wf_atom_7e8ad928(v12) then
		if p5 == nil then
			p5 = false
		end

		v12:AddAbilityTimer(p, p2, p3, p4, p5 == true)
	end
end

function Initialize()
	fn20()
	InitializeNightfold()
	_T.SetAbilityTimer = fn26
	_T.AddAbilityTimer = fn27
	mMovie:SetVisible(false)

	if not __wf_atom_7e8ad928(commonResourcesMovie) then
		__wf_atom_8e4fda44:__wf_atom_8b74c30b(commonResourcesMovie)
	end

	mMovie:__wf_atom_2dedec1a("StatsNew.CourageGlow", 13, false)
	mMovie:__wf_atom_2dedec1a("StatsNew.GraceGlow", 13, false)
	mMovie:__wf_atom_e57658c2("healthComponent.Controls.Top.Prompt", 12, v25.FULL_ALPHA)
	mMovie:__wf_atom_e57658c2("healthComponent.Controls.Right.Prompt", 12, v25.FULL_ALPHA)
	mMovie:__wf_atom_e57658c2("healthComponent.Controls.Bottom.Prompt", 12, v25.FULL_ALPHA)
	mMovie:__wf_atom_e57658c2("healthComponent.Controls.Left.Prompt", 12, v25.FULL_ALPHA)
	mMovie:__wf_atom_e57658c2("healthComponent.Controls.GamepadCentralPrompt", 12, v25.FULL_ALPHA)
	mMovie:__wf_atom_e57658c2("StatsNew", 12, 75)
	mMovie:__wf_atom_e57658c2("HealCharges", 12, 75)
	mMovie:__wf_atom_e57658c2("StatsNew.SpiritGlow", 12, 0)
	mMovie:__wf_atom_e57658c2("StatsNew.Soul", 12, 0)
	mMovie:OverrideMaterial("EnemyHealth.Health.Center", attributeFillMaterial)

	for _, v96 in { "StatsNew.CourageIcon", "StatsNew.SpiritIcon", "StatsNew.GraceIcon" } do
		mMovie:__wf_atom_e57658c2(v96, 11, _G.UIColor_Tan)
	end

	v43 = module.CreateObservable("", fn6)

	if
		not __wf_atom_7e8ad928(contextActionMovie)
		and __wf_atom_72884638("HUD.ShowInWorldContextActions", true)
		and __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(contextActionMovie)))
	then
		mMovie:PushChildMovie(contextActionMovie)
	end

	if not __wf_atom_7e8ad928(hudTrackersMovie) then
		v31.mHudTrackersMovie = __wf_atom_8e4fda44:FindMovie(hudTrackersMovie)

		if __wf_atom_7e8ad928(v31.mHudTrackersMovie) then
			v31.mHudTrackersMovie = mMovie:PushChildMovie(hudTrackersMovie)
		end
	end

	if not __wf_atom_7e8ad928(hudMarkersMovie) then
		v31.mHudMarkersMovie = __wf_atom_8e4fda44:FindMovie(hudMarkersMovie)

		if __wf_atom_7e8ad928(v31.mHudMarkersMovie) then
			v31.mHudMarkersMovie = mMovie:PushChildMovie(hudMarkersMovie)

			if not __wf_atom_7e8ad928(v31.mHudMarkersMovie) then
				v31.mHudMarkersMovie:__wf_atom_8fcdea81(mMovie:__wf_atom_7be51ede())
			end
		end
	end

	mMovie:__wf_atom_c90af43a("SuccessfulHitNotification.Normal", hitNotificationIcon)
	mMovie:__wf_atom_c90af43a("SuccessfulHitNotification.Headshot", hitNotificationHeadshotIcon)
	mMovie:__wf_atom_c90af43a("SuccessfulHitNotification.Invulnerable", hitNotificationInvulnerableIcon)
	mMovie:__wf_atom_e57658c2("SuccessfulHitNotification", 12, 0)
	mMovie:__wf_atom_2dedec1a("SuccessfulHitNotification.Headshot", 13, false)
	mMovie:__wf_atom_2dedec1a("SuccessfulHitNotification.Invulnerable", 13, false)
	mMovie:__wf_atom_e57658c2("LockOn", 12, 0)
	mMovie:__wf_atom_e57658c2("KillNumber1", 12, 0)
	mMovie:__wf_atom_87c1f39f(mMovie:__wf_atom_26fc837d("TargetHit1"), 13, false)
	mMovie:OverrideMaterial("PainTop", painMaterial)
	mMovie:OverrideMaterial("PainBottom", painMaterial)
	mMovie:OverrideMaterial("PainLeft", painMaterial)
	mMovie:OverrideMaterial("PainRight", painMaterial)
	mMovie:OverrideMaterial("Notification.VineDetails", wavyMaterial)
	mMovie:OverrideMaterial("Notification.Bg", wavyMaterial)
	mMovie:__wf_atom_c90af43a("Notification.IconBacker", iconSkillBacker)
	mMovie:__wf_atom_e57658c2("PainTop", 12, 0)
	mMovie:__wf_atom_e57658c2("PainBottom", 12, 0)
	mMovie:__wf_atom_e57658c2("PainLeft", 12, 0)
	mMovie:__wf_atom_e57658c2("PainRight", 12, 0)
	mMovie:__wf_atom_e57658c2("EnemyHealth", 12, 0)
	mMovie:__wf_atom_e57658c2("ArcanaNew", 12, 0)
	mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyFill", 12, 0)
	mMovie:OverrideMaterial("StatsNew.SoulEnergyFill", lifeOuterMaterial)
	mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyFill", 11, v25.SOUL_ENERGY_COLOR:__wf_atom_dcecedb0())
	mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyLockedFill", 12, 0)
	mMovie:OverrideMaterial("StatsNew.SoulEnergyLockedFill", lifeLockedOuterMaterial)
	mMovie:__wf_atom_e57658c2("StatsNew.SoulEnergyLockedFill", 11, 6246192)
	mMovie:__wf_atom_1ca72041("StatsNew.SoulEnergyLockedFill", "MaskScale", -1, 1, 0, 0)
	mMovie:OverrideMaterial("StatsNew.PactXP.Fill", pactWeaponXpBarMaterial)
	mMovie:__wf_atom_e57658c2("StatsNew.PactXP", 12, 0)
	mMovie:OverrideMaterial("StatsNew.WeaponXP.Fill", pactWeaponXpBarMaterial)
	mMovie:__wf_atom_e57658c2("StatsNew.WeaponXP", 12, 0)
	mMovie:__wf_atom_e57658c2("StatsNew.StarMiniDecoration", 12, 0)
	mMovie:__wf_atom_c90af43a("SquadInfo.Player1.VoiceStatus.TalkingIndicator", playerTalkingIcon)
	mMovie:__wf_atom_c90af43a("SquadInfo.Player1.VoiceStatus.Muted", playerMutedIcon)
	mMovie:__wf_atom_e57658c2("Notify", 12, 0)
	mMovie:__wf_atom_e57658c2("Throw", 12, 0)
	mMovie:__wf_atom_e57658c2("AmmoTracker.Label", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_e57658c2("HealCharges.Label", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_50d60589("HealCharges.Label", 36, 0)
	mMovie:__wf_atom_e57658c2("HealCharges.Callout.tf", 44, module6.PromptTextColor)
	mMovie:__wf_atom_e57658c2("ArcanaNew.CourageCallout.Tf", 44, module6.PromptTextColor)
	mMovie:__wf_atom_e57658c2("ArcanaNew.SpiritCallout.Tf", 44, module6.PromptTextColor)
	mMovie:__wf_atom_e57658c2("ArcanaNew.GraceCallout.Tf", 44, module6.PromptTextColor)
	mMovie:__wf_atom_e57658c2("ArcanaNew.CannonStatus.PipBacker1", 11, 0)
	mMovie:__wf_atom_e57658c2("ArcanaNew.CannonStatus.PipBacker2", 11, 0)
	mMovie:__wf_atom_e57658c2("ArcanaNew.CannonStatus.PipBacker3", 11, 0)
	mMovie:__wf_atom_c90af43a("LogMessageContainer.IconContainer.Backer", logMessageIconTextures[1])
	mMovie:__wf_atom_c90af43a("LogMessageContainer.IconContainer.Border", logMessageIconTextures[2])
	mMovie:__wf_atom_e57658c2("LogMessageContainer.IconContainer.Border", 11, 8152122)
	mMovie:__wf_atom_e57658c2("LogMessageContainer", 12, 0)
	mMovie:__wf_atom_e57658c2("SpecialLogMessageContainer", 12, 0)
	v93 = {
		x = mMovie:__wf_atom_5e6e15c8("LogMessageContainer", 0),
		y = mMovie:__wf_atom_5e6e15c8("LogMessageContainer", 1)
	}
	mMovie:__wf_atom_c90af43a("SpecialLogMessageContainer.IconContainer.ItemBoxFrame", logMessageIconTextures[2])
	mMovie:__wf_atom_e57658c2("SpecialLogMessageContainer.IconContainer.ItemBoxFrame", 11, 8152122)
	mMovie:__wf_atom_e57658c2("SpecialLogMessageContainer.SoftBrownShadow", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("Notification", 12, 0)
	mMovie:__wf_atom_2dedec1a("Notification.Bar", 13, false)
	mMovie:__wf_atom_2dedec1a("NotificationSmall.Rays", 13, false)
	mMovie:__wf_atom_2dedec1a("NotificationSmall.Bar", 13, false)
	mMovie:OverrideMaterial("Notification.Bg.Shadow", mRankUpBgMaterial)
	mMovie:OverrideMaterial("Notification.Bg.Mist", mRankUpBgMaterial)
	mMovie:OverrideMaterial("StatsNew.SpiritGlow", mIdolGlowMaterial)
	mMovie:__wf_atom_e57658c2("EnemyHealth.Health.Mask", 6, v54.HealthFillScale)
	mMovie:__wf_atom_e57658c2("EnemyHealth.Stability.Mask", 6, v54.StabilityFillScale)
	mMovie:__wf_atom_e57658c2("EnemyHealth.Health.Backer", 11, _G.UIColor_Black)
	mMovie:__wf_atom_e57658c2("EnemyHealth.Health.Backer", 12, v54.BackerAlpha)
	mMovie:__wf_atom_e57658c2("EnemyHealth.Strokes.Trough", 11, 16777215)
	mMovie:__wf_atom_e57658c2("EnemyHealth.Strokes.Trough", 12, 50)
	v58 = GetSoulMeterSlot()
	fn19()
	fn7()
	fn15()
	v23 = 1
	v24 = 0
	fn14(0, false)
	mMovie:__wf_atom_50d60589("ImpactMessage.Label", 36, "")
	mMovie:__wf_atom_e57658c2("ImpactMessage.Label", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_e57658c2("ImpactMessage", 12, 0)
	mMovie:__wf_atom_50d60589("ImpactMessage.Countdown.Text", 36, "")
	mMovie:__wf_atom_e57658c2("ImpactMessage.Countdown.Text", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_e57658c2("ImpactMessage.Topper", 11, _G.UIColor_DarkerBrown)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local v96 = __wf_atom_7e8ad928(mSettings)
		mSettings = __wf_atom_18a5d83b:Settings()

		if v96 then
			v81.mCrosshairAlpha = math.clamp(mSettings:__wf_atom_350909f6(), 0, 1) * 100
			v81.mCrosshairScale = math.clamp(mSettings:__wf_atom_18fcaa61(), 0.25, 1)
			mMovie:__wf_atom_e57658c2("LockOn.Crosshair", 12, v81.mCrosshairAlpha * 100)
		end
	end

	local module20 = require("Lotus.Interface.Libs.TimerMgr")
	v2 = module20.CreateTimerMgr()
	RegisterCallbacks()
	local module21 = require("Lotus.Interface.Components.ThemedSpinner")
	v4 = module21.Create(mMovie, "Spinner")
	v31.Initialized = true
	local module22 = require("SF.Interface.Components.Hud.HUDHealthComponent")
	local v96 = {
		radialProgressMaterial = radialProgressMaterialHealth,
		controlFlowerIcons = controlFlowerIcons
	}
	v55 = module22.Create(mMovie, "HealthComponent", v96)
	v55:SetPotionIconActive(false)
	v55:SetPotionCount(0)
	local module23 = require("SF.Interface.Components.Hud.CompassComponent")
	local v97 = {
		compassGlowIcon = compassGlowIcon,
		questStarIcon = questStarIcon,
		squadMemberCompassIcon = squadMemberCompassIcon,
		paintedMarkerType = paintedMarkerType,
		sparrowRespawnIcon = sparrowRespawnIcon,
		mSettings = mSettings,
		notificationMovie = notificationMovie
	}
	v56 = module23.Create(mMovie, "Compass1", v97)
	mMovie:OverrideMaterial("StatsNew.Courage.Bg", attributeFillMaterialVisRange)
	mMovie:OverrideMaterial("StatsNew.Spirit.Bg", attributeFillMaterialVisRange)
	mMovie:OverrideMaterial("StatsNew.Grace.Bg", attributeFillMaterialVisRange)
	v44[1] = mMovie:__wf_atom_5e6e15c8("StatsNew.CourageIcon", 5)
	v44[2] = mMovie:__wf_atom_5e6e15c8("StatsNew.SpiritIcon", 5)
	v44[3] = mMovie:__wf_atom_5e6e15c8("StatsNew.GraceIcon", 5)
	mMovie:__wf_atom_2dedec1a("StatsNew.Frame1.Notch1", 13, false)
	mMovie:__wf_atom_2dedec1a("StatsNew.Frame1.Notch2", 13, false)
	mMovie:__wf_atom_2dedec1a("StatsNew.Frame1.Notch3", 13, false)
	mMovie:__wf_atom_1ca72041("StatsNew.Courage.Bg", "VisibilityFadeSize", 0.065, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("StatsNew.Spirit.Bg", "VisibilityFadeSize", 0.032, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("StatsNew.Grace.Bg", "VisibilityFadeSize", 0.065, 0, 0, 0)
	mMovie:__wf_atom_e57658c2("MotePreview", 12, 0)

	for i = 1, module7.MAX_SQUAD_SIZE do
		mMovie:__wf_atom_2dedec1a("SquadInfo.Player" .. i, 13, false)
	end

	fn23()
end

function RegisterCallbacks()
	_T.ActivateFullHUD = ActivateFullHUD
	_T.SetForceShowHUD = SetForceShowHUD
	_T.SetupBossAvatar = ShowBossStatus
	_T.SetupBossAvatarList = ShowBossListStatus

	function _T.ShowImpactMessage(...)
		fn(ShowImpactMessage, ...)
	end

	function _T.HideImpactMessage(...)
		fn(HideImpactMessage, ...)
	end

	function _T.RemoveHudTracker(...)
		fn(fn3, ...)
	end

	_T.SetForceShowAbilities = SetForceShowAbilities
	_T.IsNightfoldAlertActive = IsNightfoldAlertActive

	function _T.HUDResetLogContainerPosition()
		mMovie:__wf_atom_e57658c2("LogMessageContainer", 0, v93.x)
		mMovie:__wf_atom_e57658c2("LogMessageContainer", 1, v93.y)
	end

	function _T.HUDSetLogContainerPosition(x, y)
		if x == nil then
			x = v93.x
		end

		if y == nil then
			y = v93.y
		end

		mMovie:__wf_atom_e57658c2("LogMessageContainer", 0, x)
		mMovie:__wf_atom_e57658c2("LogMessageContainer", 1, y)
	end
end

function Shutdown()
	if v19 then
		v23 = 1
		v24 = 0
		fn14(0, false)
	end
end

function IconCacheFlushed()
	print(Engine.IsPlayingWithController())

	if not __wf_atom_7e8ad928(v55) then
		v55:OnGamepadTransition()
	end
end

function OnGamepadTransition()
	v30 = true
	SetImpactMessageText(v31.mImpactMessageText, v31.mImpactMessageFilter, v31.mImpactMessageParameters)
end

local function fn28(p, p2, p3)
	local v96 = "<ACTIVATE_ABILITY_" .. tostring(p2) .. ">"
	local __wf_atom_c7fa5e0c = mMovie:__wf_atom_c7fa5e0c(v96, p3)
	local v97 = __wf_atom_c7fa5e0c == v96 and "" or __wf_atom_c7fa5e0c

	if v97 == "" then
		mMovie:__wf_atom_2dedec1a(p, 13, false)
		return
	end

	mMovie:__wf_atom_48bd5a59(p, "Tf", 36, v97)
	mMovie:__wf_atom_2dedec1a(p, 13, true)
end

function UpdateFade(p)
	local v96

	if _T.HideHudSelective == nil then
		v96 = false
	else
		v96 = _T.HideHudSelective > 0
	end

	if _T.TopMenuOpen or v96 then
		v15:__wf_atom_09294a87(0)
	else
		v15:__wf_atom_09294a87(1)
	end

	v15:Update(p)
end

local function fn29()
	local v96 = not __wf_atom_7e8ad928(v9) and v9:__wf_atom_a07f65c2() and 100 or v25.FULL_ALPHA
	local v97 = {
		StatsNew = {
			Fun = function()
				if
					_T.InTutorialBeforePactChoice
					or v7 and v7:__wf_atom_799d95f5() and not _T.NightfoldFactionChoice
				then
					return 0
				end

				return v96
			end,
			Condition = function()
				return not v35
			end
		},
		NotificationSmall = {
			Fun = function()
				return 100
			end
		},
		HealthComponent = {
			Fun = function()
				if
					_T.InTutorialBeforePactChoice
					or v7 and v7:__wf_atom_799d95f5() and not _T.NightfoldFactionChoice
				then
					return 0
				end

				return v96
			end
		},
		HealCharges = {
			Fun = function()
				return v25.FULL_ALPHA
			end
		},
		AmmoTracker = {
			Fun = function()
				return v25.FULL_ALPHA
			end
		},
		ArcanaNew = {
			Fun = function()
				local FULL_ALPHA = v25.FULL_ALPHA

				if
					_T.InTutorialBeforePactChoice
					or v7 and v7:__wf_atom_799d95f5() and not _T.NightfoldFactionChoice
				then
					return 0
				end

				return FULL_ALPHA
			end
		},
		LockOn = {
			Fun = function()
				return v25.FULL_ALPHA
			end
		},
		SpiritLock = {
			Fun = function()
				if
					_T.InTutorialBeforePactChoice
					or v7 and v7:__wf_atom_799d95f5() and not _T.NightfoldFactionChoice
				then
					return 0
				end

				return 100
			end
		},
		CourageLock = {
			Fun = function()
				if
					_T.InTutorialBeforePactChoice
					or v7 and v7:__wf_atom_799d95f5() and not _T.NightfoldFactionChoice
				then
					return 0
				end

				return 100
			end
		},
		GraceLock = {
			Fun = function()
				if
					_T.InTutorialBeforePactChoice
					or v7 and v7:__wf_atom_799d95f5() and not _T.NightfoldFactionChoice
				then
					return 0
				end

				return 100
			end
		},
		MotePreview = {
			Fun = function()
				if not v58 then
					return 0
				end

				local FULL_ALPHA = v25.FULL_ALPHA

				if
					_T.InTutorialBeforePactChoice
					or v7 and v7:__wf_atom_799d95f5() and not _T.NightfoldFactionChoice
				then
					return 0
				end

				return FULL_ALPHA
			end
		},
		Compass1 = {
			Condition = function()
				return module7.IsPlayingCinematic()
			end,
			Fun = function()
				return 0
			end
		}
	}
	local v98 = v14 * v15:__wf_atom_9e368823()

	for k, v99 in pairs(v97) do
		if not (v99.Condition == nil or v99.Condition() == true) then
			continue
		end

		local fun = v99.Fun()
		mMovie:__wf_atom_e57658c2(k, 12, v98 * fun)
	end

	for i = 1, module7.MAX_SQUAD_SIZE do
		mMovie:__wf_atom_e57658c2("SquadInfo.Player" .. i .. ".Name", 0, 42 - v16 * 500)
		mMovie:__wf_atom_e57658c2("SquadInfo.Player" .. i .. ".Name", 12, 100 - v16 * 500)
		local v99 = math.max(
			42,
			mMovie:__wf_atom_5e6e15c8("SquadInfo.Player" .. i .. ".Name", 0) + mMovie:__wf_atom_5e6e15c8(
				"SquadInfo.Player" .. i .. ".Name",
				40
			) + 7
		)
		mMovie:__wf_atom_e57658c2("SquadInfo.Player" .. i .. ".VoiceStatus", 0, v99)
	end
end

local function fn30(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local ternary = module.Ternary(false, 6124631, 7409695)
	local v96 = __wf_atom_421b01aa(object:__wf_atom_bb81a9df(), 0.05, 1)
	local __wf_atom_68de036a = object:__wf_atom_68de036a()
	local __wf_atom_4598c071 = object:__wf_atom_7470861b():__wf_atom_4598c071()
	mMovie:__wf_atom_c90af43a("EnemyHealth.StatusIcon", charmedStatusIcon)
	mMovie:__wf_atom_2dedec1a("EnemyHealth.StatusIcon", 13, false)
	mMovie:__wf_atom_e57658c2("EnemyHealth.Health", 11, ternary)
	mMovie:__wf_atom_e57658c2("EnemyHealth.Health.Center", 12, __wf_atom_104bfe98(100, 200, 1 - v96))
	mMovie:__wf_atom_50d60589("EnemyHealth.LevelText", 36, __wf_atom_68de036a)

	if not __wf_atom_7e8ad928(_T.CombatTutorialEnded) then
		local _combatTutorialEnded = _T.CombatTutorialEnded
	end

	v64 = module7.IsUndamagableEnemy(mMovie, object)
	mMovie:__wf_atom_c90af43a("EnemyHealth.NoDamageIcon", noDamageXTexture)
	local v97

	if v64 then
		mMovie:OverrideMaterial("EnemyHealth.Health.Center", greyhealthMaterial)
		mMovie:OverrideMaterial("EnemyHealth.Health.Mask", greyhealthMaterial)
		mMovie:__wf_atom_e57658c2("EnemyHealth.NoDamageIcon", 11, 7039851)
		mMovie:__wf_atom_e57658c2("EnemyHealth.NoDamageIcon", 12, 100)
		mMovie:__wf_atom_e57658c2("EnemyHealth.Stability", 11, 12698049)
		v97 = false
	else
		mMovie:__wf_atom_e57658c2("EnemyHealth.NoDamageIcon", 12, 0)
		mMovie:__wf_atom_e57658c2("EnemyHealth.Stability", 11, 14271380)
		mMovie:OverrideMaterial("EnemyHealth.Health.Center", attributeFillMaterial)
		v97 = true
	end

	mMovie:__wf_atom_2dedec1a("EnemyHealth.LevelText", 13, v97)

	if __wf_atom_4598c071 ~= v52 or v53 ~= v96 then
		mMovie:__wf_atom_e57658c2("EnemyHealth.Health.Mask", 6, v96 * v54.HealthFillScale)
		mMovie:__wf_atom_e57658c2("EnemyHealth.Stability.Mask", 6, __wf_atom_4598c071 * v54.StabilityFillScale)

		if v96 > 0 and v96 < 1 and (v52 < __wf_atom_4598c071 or v96 < v53) then
			mMovie:__wf_atom_e57658c2("EnemyHealth", 5, v54.Scale * v54.PulseScale)
			mMovie:__wf_atom_e57658c2("EnemyHealth", 6, v54.Scale * v54.PulseScale)
			__wf_atom_ec43d06e(mMovie, "EnemyHealth", 2, { 5, 6 }, { v54.Scale, v54.Scale }, 0.35, 0)
		end

		if __wf_atom_4598c071 >= 1 then
			mMovie:__wf_atom_e57658c2("EnemyHealth.Stability", 12, 100)

			if v52 < __wf_atom_4598c071 then
				v5 = module.CreateUIParticles(mMovie, "EnemyHealth.Stability", stabilityBurstFx, 0, 0)
			end
		else
			mMovie:__wf_atom_e57658c2("EnemyHealth.Stability", 12, v54.StabilityAlpha)
		end

		v52 = __wf_atom_4598c071
		v53 = v96
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:Update(0)
	end
end

local function fn31(p) -- 1 equivalent call inferred from this helper
	if p == 1 then
		return "ArcanaNew.CourageCallout"
	elseif p == 2 then
		return "ArcanaNew.SpiritCallout"
	elseif p == 3 then
		return "ArcanaNew.GraceCallout"
	end

	return ""
end

local function fn32(p, p2)
	if __wf_atom_7e8ad928(v12) or (__wf_atom_7e8ad928(v7) or not v7:__wf_atom_02b0f32f()) then
		return
	end

	local v96 = v9

	if
		not __wf_atom_7e8ad928(v7)
		and playerAvatar ~= v7
		and not (__wf_atom_7e8ad928(v7:__wf_atom_d2b2176d()) or __wf_atom_7e8ad928(v7:__wf_atom_d2b2176d():__wf_atom_e55d02aa()))
	then
		v96 = v7:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	end

	local __wf_atom_d91abe08 = v96:__wf_atom_d91abe08(p)
	local v97 = ({ "Courage", "Spirit", "Grace" })[p]
	local v98 = 0
	local v99 = 0
	local __wf_atom_c497b0ae = v96:__wf_atom_c497b0ae(p)
	local v100 = "StatsNew." .. v97 .. "Icon"
	local v101 = fn31(p) -- inferred equivalent call
	local __wf_atom_d91abe08_2 = v96:__wf_atom_d91abe08(p)
	mMovie:__wf_atom_e57658c2(v101, 12, __wf_atom_d91abe08 and 100 or 70)
	local v102

	if __wf_atom_7e8ad928(__wf_atom_c497b0ae) then
		v102 = false
	else
		__wf_atom_d91abe08_2 = __wf_atom_c497b0ae:__wf_atom_31446586() and v96:__wf_atom_d91abe08(p)
		v102 = __wf_atom_c497b0ae:IsEnabled()

		if __wf_atom_c497b0ae:__wf_atom_de7e7709() > 0 then
			if __wf_atom_c497b0ae:__wf_atom_ca98158b() then
				v99 = 1 - __wf_atom_c497b0ae:__wf_atom_1fcd5380(true) / __wf_atom_c497b0ae:__wf_atom_de7e7709(true)
				v98 = __wf_atom_c497b0ae:__wf_atom_5ddc32c4() / __wf_atom_c497b0ae:__wf_atom_245092c9()

				if v98 < 1 then
					v39 = true
				end

				if __wf_atom_c497b0ae:__wf_atom_5ddc32c4() == 0 or not __wf_atom_d91abe08 then
					mMovie:__wf_atom_e57658c2(v101, 12, 70)
				else
					mMovie:__wf_atom_e57658c2(v101, 12, 100)
				end
			elseif not __wf_atom_7e8ad928(v12) then
				if __wf_atom_c497b0ae:IsReady() then
					v98 = 1
					v99 = 1
				else
					v98 = 0
					v99 = 0
				end

				local __wf_atom_4cd209dc = v12:__wf_atom_4cd209dc(p)

				if not __wf_atom_7e8ad928(__wf_atom_4cd209dc) and __wf_atom_4cd209dc ~= "" then
					v98 = tonumber(__wf_atom_4cd209dc)
					v99 = v98
				end
			end
		else
			local __wf_atom_2e4994f1 = v96:__wf_atom_2e4994f1(p)
			v99 = v96:__wf_atom_f3044fe0(__wf_atom_2e4994f1) / v96:__wf_atom_6a5c92a7(__wf_atom_2e4994f1)

			if __wf_atom_c497b0ae:IsReady() and __wf_atom_d91abe08 then
				mMovie:__wf_atom_e57658c2(v101, 12, 100)
			else
				mMovie:__wf_atom_e57658c2(v101, 12, 70)
			end

			v98 = v99 >= 1 and 1 or 0
		end
	end

	local v103 = __wf_atom_d91abe08s[p]
	local v104 = __wf_atom_d91abe08s2[p]
	local v105 = v34[p]
	mMovie:__wf_atom_2dedec1a("StatsNew." .. v97 .. "Symbol", 13, false)

	if v105 and v98 ~= v32[p] and v98 >= 1 then
		local v106 = v44[p]
		local v107 = v106 * 1.5
		mMovie:__wf_atom_e57658c2(v100, 5, v107)
		mMovie:__wf_atom_e57658c2(v100, 6, v107)
		__wf_atom_ec43d06e(mMovie, v100, 4, { 5, 6 }, { v106, v106 }, 0.75, 0, function()
			mMovie:__wf_atom_e57658c2(v100, 5, v106)
			mMovie:__wf_atom_e57658c2(v100, 6, v106)
		end)
		module.CreateUIParticles(mMovie, "StatsNew." .. v97, abilityRechargedFx, 0, 0, nil, nil, nil, nil, true)
		local __wf_atom_43cc9de1 = v96:__wf_atom_43cc9de1(Symbol("ABILITY_READY_FX"))

		if __wf_atom_7e8ad928(__wf_atom_43cc9de1) then
			__wf_atom_43cc9de1 = v96:__wf_atom_43cc9de1(Symbol("EQUIP_FX"))
		end

		local __wf_atom_43cc9de1_2 = v96:__wf_atom_43cc9de1(v87[p])
		v7:Attach(__wf_atom_43cc9de1, EMPTY_SYMBOL)
		module.PlaySound(__wf_atom_43cc9de1_2)
	end

	v32[p] = v98

	if (__wf_atom_d91abe08_2 ~= v103 or __wf_atom_d91abe08 ~= v104) and v97 ~= nil then
		local v106 = v97 == "Spirit" and not v59 and 150 or 110

		if not (__wf_atom_d91abe08_2 or __wf_atom_7e8ad928(v36[p]) or __wf_atom_7e8ad928(v36[p].mInstance)) then
			v36[p]:Destroy()
			v36[p] = nil
		end

		if __wf_atom_d91abe08_2 and not __wf_atom_7e8ad928(abilityBlockedPersistentFx) then
			v36[p] = module.CreateUIParticles(
				mMovie,
				"StatsNew." .. v97,
				abilityBlockedPersistentFx,
				0,
				0,
				nil,
				nil,
				nil,
				nil,
				true
			)

			if
				not __wf_atom_7e8ad928(v36[p])
				and not __wf_atom_7e8ad928(v36[p].mInstance)
				and (v97 ~= "Spirit" or v59)
			then
				v36[p].mInstance:SetSize(0.0001, 0.02, true)
			end
		end

		__wf_atom_ec43d06e(mMovie, "StatsNew." .. v97, 7, { 5, 6 }, { v106, v106 }, 0.3)

		if mMovie:__wf_atom_5e6e15c8("StatsNew", 12) > 50 then
			module.CreateUIParticles(
				mMovie,
				"StatsNew." .. v97,
				module.Ternary(__wf_atom_d91abe08_2, abilityBlockedFx, abilityUnblockedFx),
				0,
				0,
				nil,
				nil,
				nil,
				nil,
				true
			)
			module.PlaySound(abilityUnblockSound)
		end

		mMovie:OverrideMaterial(
			"StatsNew." .. v97 .. ".Bg",
			module.Ternary(__wf_atom_d91abe08_2, abilityBlockedMaterial, attributeFillMaterialVisRange)
		)
		mMovie:OverrideMaterial(
			"StatsNew." .. v97 .. ".Icon",
			module.Ternary(__wf_atom_d91abe08_2, abilityBlockedMaterial, nil)
		)
	end

	if not __wf_atom_7e8ad928(v36[p]) and __wf_atom_d91abe08_2 then
		if __wf_atom_7e8ad928(v36[p].mInstance) or not (mMovie:__wf_atom_5e6e15c8("StatsNew", 12) < 25) then
			if __wf_atom_7e8ad928(v36[p].mInstance) and mMovie:__wf_atom_5e6e15c8("StatsNew", 12) > 50 then
				v36[p]:SetVisibility(true)
				v36[p]:Update(0)

				if not __wf_atom_7e8ad928(v36[p].mInstance) and (v97 ~= "Spirit" or v59) then
					v36[p].mInstance:SetSize(0.0001, 0.02, true)
				end
			end
		else
			v36[p].mInstance:FadeOut()
			v36[p]:Update(0)
		end
	end

	__wf_atom_d91abe08s[p] = __wf_atom_d91abe08_2
	__wf_atom_d91abe08s2[p] = __wf_atom_d91abe08
	v34[p] = v102
	mMovie:__wf_atom_2dedec1a(v100, 13, __wf_atom_d91abe08)
	mMovie:__wf_atom_2dedec1a(v97 .. "Lock", 13, not __wf_atom_d91abe08)
	mMovie:__wf_atom_2dedec1a("StatsNew." .. v97, 13, __wf_atom_d91abe08)
	local __wf_atom_2490589b = v86[p]:__wf_atom_2490589b(v99, p2)
	local v106

	if p == 1 then
		v106 = __wf_atom_104bfe98(0.03, 0.72, 1 - __wf_atom_2490589b)
	elseif p == 2 then
		v106 = __wf_atom_104bfe98(0.05, 0.82, 1 - __wf_atom_2490589b)
	else
		v106 = __wf_atom_104bfe98(0.02, 0.74, 1 - __wf_atom_2490589b)
	end

	mMovie:__wf_atom_1ca72041("StatsNew." .. v97 .. ".Bg", "VisibilitySize", v106, 0, 0, 0)
end

function ChildScriptProgressionScreen(object, p)
	local decoded = cjson.decode(p)
	local v96 = decoded[1]
	local v97 = decoded[2]

	if not (decoded.SkipWaitingForNotifications or __wf_atom_7e8ad928(object)) then
		local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

		if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			local __wf_atom_330f77f5 = __wf_atom_a96eb2aa:__wf_atom_330f77f5(false)

			while not __wf_atom_7e8ad928(__wf_atom_330f77f5) and __wf_atom_330f77f5:__wf_atom_aaf836a8() do
				Sleep(0)
			end
		end
	end

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	module9.TriggerPlayerProgressionCelebration(object, v96, v97)
end

function ShowProgressionScreenCustom(label, value, p, p2, p3)
	local v96 = {
		Label = label,
		CacheIndex = value or 1,
		Encounter = true
	}

	if p3 == "true" then
		v96.SkipWaitingForNotifications = true
	end

	local decoded = cjson.decode(p2)

	for k, v97 in pairs(decoded) do
		v96[k] = v97
	end

	local v97 = p or nil
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		__wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		or __wf_atom_c4f78a8f ~= gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
	then
		module7.ShowProgressionScreen(false, v96)
	else
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("ChildScriptProgressionScreen"), false, cjson.encode({ v96, v97 }))
	end
end

function QueueProgressionScreen()
	if _T.ProgressionScreenDisabled then
		return
	end

	if v48 == nil then
		v48 = module7.IsDaytime()
	end

	if progressionScreenCooldownDuration2 > 0 then
		return
	end

	v46 = 6
	v47 = true
end

local function fn33()
	if
		__wf_atom_7e8ad928(v7)
		or __wf_atom_7e8ad928(playerAvatar)
		or playerAvatar:IsKilled()
		or v7:__wf_atom_799d95f5()
	then
		return false
	end

	if
		gGameRules:IsA(__wf_atom_e714d8ac)
		or __wf_atom_7e8ad928(gRegion)
		or not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8())
	then
		return false
	end

	if not ((__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8())) and __wf_atom_7e8ad928(_T.curTransmission)) then
		return false
	end

	if module9.IsAnyQuestTracked() or not module11.IsInOverworld() then
		return false
	end

	local isDaytime = module7.IsDaytime()

	if v48 == isDaytime then
		return false
	end

	local all = gRegion:FindAll(__wf_atom_9e85eea2)

	for i = 1, #all do
		if
			not all[i]:IsKilled()
			and not all[i]:__wf_atom_129d1aba(v7)
			and (all[i]:__wf_atom_464a4772() or all[i]:__wf_atom_3a6b0cbb() and all[i]:__wf_atom_8a6b8fc3(v7) < progressionScreenEnemyRange)
		then
			return false
		end
	end

	return true
end

local function fn34(data)
	local v96 = -21
	local v97 = 20
	local partyLeaderIcon2

	if data.mHost and #gRegion:__wf_atom_3c8e1a7a() > 1 then
		partyLeaderIcon2 = partyLeaderIcon
	end

	if data.mSlot ~= 0 then
		local v98

		if not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(data.mPlayer)) then
			v98 = data.mPlayer:__wf_atom_50a7d83e()
		end

		if __wf_atom_7e8ad928(v98) or not v98:IsA(__wf_atom_9d7477c0) then
			if data.mDamageTimer > 0 and data.mHealth > 0 then
				partyLeaderIcon2 = activeCombatIcon
				v97 += 1
			end
		else
			partyLeaderIcon2 = sparrowRespawnIcon
			v96 -= 1
		end
	end

	local v98 = data.mClipName .. ".SecondaryIcon"
	local v99 = data.mClipName .. ".SecondaryFrame"
	mMovie:__wf_atom_2dedec1a(v98, 13, partyLeaderIcon2 ~= nil)
	mMovie:__wf_atom_2dedec1a(v99, 13, partyLeaderIcon2 ~= nil)
	mMovie:__wf_atom_c90af43a(v98, partyLeaderIcon2)
	mMovie:__wf_atom_e57658c2(v98, 0, v96)
	mMovie:__wf_atom_e57658c2(v98, 1, v97)
	local profileImage = data.mLoadout.ProfileImage
	local iconTexture = nil

	if #profileImage > 0 then
		local v100 = Resource(profileImage)

		if not __wf_atom_7e8ad928(v100) then
			iconTexture = v100:GetIconTexture()
		end
	end

	if __wf_atom_7e8ad928(iconTexture) then
		iconTexture = _G.UITexture_ProfilePlaceHolder
	end

	local v100 = data.mClipName .. ".PrimaryIcon"
	mMovie:__wf_atom_2dedec1a(v100, 13, v100 ~= nil)
	mMovie:OverrideMaterial(v100, hudSquadIconMaterial)
	mMovie:__wf_atom_c90af43a(v100, iconTexture)
end

local function fn35(__wf_atom_ef151cfd)
	local v96 = v51[__wf_atom_ef151cfd]

	if v96 == nil or v96.mClipName == nil then
		return
	end

	if __wf_atom_7e8ad928(__wf_atom_597fcbc7) or not __wf_atom_597fcbc7:__wf_atom_5e6e39e2(v96.mMatchmakingString) then
		if not __wf_atom_7e8ad928(v96.playerTalking) and v96.playerTalking > 0 then
			v96.playerTalking -= __wf_atom_fa1258d0()
		end
	else
		v96.playerTalking = 0.25
	end

	local disabled = v.DISABLED

	if not __wf_atom_7e8ad928(v96.mPlayer) and not v96.mPlayer:IsLocal() and v96.mPlayer:__wf_atom_b615e133() then
		disabled = v.ENABLED

		if __wf_atom_7e8ad928(v96.playerTalking) or not (v96.playerTalking > 0) then
			if __wf_atom_597fcbc7:__wf_atom_29cd1ff1(v96.mMatchmakingString) then
				disabled = v.MUTED
			end
		else
			disabled = v.TALKING
		end
	end

	if not v85 then
		disabled = v.DISABLED
	end

	if
		(__wf_atom_7e8ad928(v96.mVoipState) or v96.mVoipState ~= disabled)
		and v96.mClipName
		and v96.mClipName ~= ""
		and mMovie:__wf_atom_253d7085(v96.mClipName)
	then
		v96.mVoipState = disabled
		mMovie:__wf_atom_7f57ab2f(v96.mClipName, "VoiceStatus", 13, disabled ~= v.DISABLED)
		mMovie:__wf_atom_7f57ab2f(v96.mClipName, "VoiceStatus.Muted", 13, disabled == v.MUTED)
		mMovie:__wf_atom_e57658c2(v96.mClipName .. ".VoiceStatus.Muted", 11, 12075338)
		local ternary = module.Ternary(disabled == v.TALKING, 90, 30)
		mMovie:__wf_atom_4c1c1986(v96.mClipName, "VoiceStatus.TalkingIndicator", 12, ternary)
		mMovie:__wf_atom_4c1c1986(v96.mClipName, "VoiceStatus.TalkingIndicator", 11, _G.UIColor_Yellow)
	end
end

local function fn36(p, p2, i)
	local v96 = math.rad(-p * 360 - 135)
	local v97 = math.cos(v96)
	local v98 = math.sin(v96)
	local v99 = v97 * 76
	local v100 = v98 * 76
	local v101 = math.deg((math.atan2(-v100, v99)))
	mMovie:__wf_atom_e57658c2(p2 .. i, 0, v99 + 4)
	mMovie:__wf_atom_e57658c2(p2 .. i, 1, -v100 + -3)
	mMovie:__wf_atom_e57658c2(p2 .. i, 16, v101 - 90)
	mMovie:__wf_atom_2dedec1a(p2 .. i, 13, true)
end

local function fn37(p, mClipName)
	local v96 = __wf_atom_104bfe98(0.5, 1, p)
	mMovie:__wf_atom_1ca72041(mClipName .. ".HealthBar", "AlphaTestThreshold", v96, 0, 0, 0)
	local v97

	if p > 0.5 then
		v97 = (p - 0.5) * 2
	else
		v97 = 1 - p * 2
	end

	local v98 = math.pow(v97, 2)
	local v99 = __wf_atom_104bfe98(26, 26, v98)
	local v100 = Rotation(0, 0, __wf_atom_104bfe98(-85, 85, p))
	local v101 = __wf_atom_9341614d(Vector(0, 1, 0), v100) * v99
	mMovie:__wf_atom_e57658c2(mClipName .. ".HealthBarCap", 0, -v101.x)
	mMovie:__wf_atom_e57658c2(mClipName .. ".HealthBarCap", 1, -v101.y)
	local v102 = v100.bank * (270 / 255)
	mMovie:__wf_atom_e57658c2(mClipName .. ".HealthBarCap", 16, v102)
end

local function fn38(p)
	__wf_atom_ec43d06e(mMovie, p, 8, { 12 }, { 100 }, 0.25, nil, function()
		__wf_atom_ec43d06e(mMovie, p, 8, { 12 }, { 0 }, 2, 8)
	end)
end

local function fn39(p, p2, p3, p4)
	local v96 = p .. ".Fill"
	local v97 = p .. ".Icon"

	local function fn40(p5)
		local v98 = __wf_atom_104bfe98(p2, p3, p5)

		if __wf_atom_7e8ad928(v9) or not v9:__wf_atom_a07f65c2() then
			local mMovie = mMovie
			local v100

			if v98 == 1 then
				v100 = pactWeaponXpBarMaxTexture
			end

			mMovie:__wf_atom_c90af43a(v96, v100)
		end

		mMovie:__wf_atom_1ca72041(v96, "AlphaTestThreshold", v98, 0, 0, 0)
	end

	if p4 or p2 == nil then
		mMovie:__wf_atom_290807ee(v96)
		p2 = 0
		fn40(1)
	else
		fn38("StatsNew.PactXP")
		fn38("StatsNew.WeaponXP")
		fn38("StatsNew.StarMiniDecoration")
		__wf_atom_ec43d06e(mMovie, v96, 0, {}, {}, 0.25, nil, function()
			mMovie:__wf_atom_e57658c2(v97, 5, 150)
			mMovie:__wf_atom_e57658c2(v97, 6, 150)
			__wf_atom_ec43d06e(mMovie, v97, 7, { 5, 6 }, { 100, 100 }, 0.3)
			__wf_atom_ec43d06e(mMovie, v96, 8, { fn40 }, { 1 }, 1)
		end)
	end
end

local function fn40(p) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	local v96

	if not __wf_atom_7e8ad928(gGameRules) then
		v96 = gGameRules:__wf_atom_964056fd()
	end

	if __wf_atom_7e8ad928(v96) then
		return nil
	end

	return v96:__wf_atom_232fd31d(p)
end

local function fn41(__wf_atom_ef151cfd)
	local v96 = v51[__wf_atom_ef151cfd]

	if v96 == nil or v96.mClipName == nil then
		return
	end

	local v97 = v96.mClipName .. ".HealthBar"
	local v98 = v96.mSlot == 0
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local mAvatar3 = v96.mAvatar
	local v99, mHealth, mRegainableHealthPct, mHealthPct

	if __wf_atom_7e8ad928(mAvatar3) then
		v99 = 1
		mHealth = 100
		mRegainableHealthPct = 1
		mHealthPct = 1
	else
		mHealth = math.max(0, mAvatar3:__wf_atom_c6f1f83d())
		mHealthPct = __wf_atom_421b01aa(mAvatar3:__wf_atom_bb81a9df(), 0, 1)
		v99 = mAvatar3:__wf_atom_7470861b():__wf_atom_4598c071()
		mRegainableHealthPct = __wf_atom_421b01aa(mAvatar3:__wf_atom_7470861b():__wf_atom_1e709ace(), 0, 1)
	end

	if not v98 then
		local v103 = v97 .. "._parent"

		if not mMovie:__wf_atom_253d7085(v103) then
			__wf_atom_86cbd68d(mMovie, "SquadInfo.Player1.duplicateMovieClip", "Player" .. v96.mSlot, v96.mSlot)
		end

		local v104 = (__wf_atom_7e8ad928(v66) or not (#v66 > 0)) and 90 or 55

		for i = 1, module7.MAX_SQUAD_SIZE do
			local v105 = math.max(0, i - 1) * 10
			local v106 = v104 - 56 * i - v105
			mMovie:__wf_atom_e57658c2("SquadInfo.Player" .. i, 1, v106)
		end

		mMovie:__wf_atom_48bd5a59(v103, "Name", 36, v96.mName)
	end

	if v98 then
		__wf_atom_86cbd68d(mMovie, "NotificationSmall.StabilityBar.gotoAndStop", __wf_atom_421b01aa(v99 * 100, 1, 100))
		mMovie:__wf_atom_e57658c2("NotificationSmall.StabilityBar", 11, Color(255, 255, 255):__wf_atom_dcecedb0())

		if v99 >= 1 then
			mMovie:__wf_atom_e57658c2("NotificationSmall.StabilityBar", 12, 100)
		else
			mMovie:__wf_atom_e57658c2("NotificationSmall.StabilityBar", 12, 50)
		end

		v55:SetStabilityPercent(v99)
		local envoyInventoryControl = module7.GetEnvoyInventoryControl()
		local v103

		if __wf_atom_7e8ad928(envoyInventoryControl) then
			v103 = v62
		else
			v103 = envoyInventoryControl:__wf_atom_a8e8c5c4()
			v62 = v103
		end

		if __wf_atom_7e8ad928(v103) then
			mMovie:__wf_atom_c90af43a("StatsNew.WeaponXP.Icon", nil)
			fn39("StatsNew.WeaponXP", 0, 0, true)
			v90 = nil
		else
			local v104 = v103 ~= v91
			local v105 = fn2(v103)
			local v106 = fn40(Resource(v103:__wf_atom_c45b4ac3())) -- inferred equivalent call

			if not __wf_atom_7e8ad928(v106) then
				mMovie:__wf_atom_c90af43a("StatsNew.WeaponXP.Icon", v106:__wf_atom_79f592cb())
			end

			if v105 ~= v90 then
				fn39("StatsNew.WeaponXP", v90, v105, v104)
				v90 = v105
				v91 = v103
			end
		end

		local __wf_atom_e55d02aa = v7:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			local v104 = fn2(__wf_atom_e55d02aa)
			mMovie:__wf_atom_c90af43a("StatsNew.PactXP.Icon", pactEyeIcon)

			if v104 ~= v89 then
				fn39("StatsNew.PactXP", v89, v104)
				v89 = v104
			end
		end
	end

	if v96.mHealth ~= mHealth or v96.mRegainableHealthPct ~= mRegainableHealthPct then
		fn37(mHealthPct, v96.mClipName)

		if mHealthPct < v96.mHealthPct then
			if mHealth > 0 then
				v96.mDamageTimer = 5
			else
				v96.mDamageTimer = 0
			end
		end

		v96.mHealth = mHealth
		v96.mHealthPct = mHealthPct
		v96.mRegainableHealthPct = mRegainableHealthPct

		if v98 then
			mMovie:__wf_atom_e57658c2(v97, 5, 73)
			mMovie:__wf_atom_e57658c2(v97, 6, 73)
			__wf_atom_ec43d06e(mMovie, v97, 4, { 5, 6 }, { 61, 61 }, 0.5)
			v55:SetHealthPercent(mHealthPct, mRegainableHealthPct)
		end

		if mHealthPct <= 0.25 then
			local _ = math.sin(Time() * 3 * 3.141592653589793) * 20 + 100
			local v103 = math.abs((math.sin(Time() * 3 * 3.141592653589793)))
			mMovie:__wf_atom_e57658c2(v97, 11, Color(v103 * 255, v103 * 255, v103 * 255):__wf_atom_dcecedb0())

			if v98 then
				postProcess.saturationBias = -0.5
			end
		else
			mMovie:__wf_atom_e57658c2(v97, 11, Color(255, 255, 255):__wf_atom_dcecedb0())

			if v98 then
				postProcess.saturationBias = 0
			end
		end
	end

	if v98 and gRegion:__wf_atom_c3b255b8() then
		postProcess.saturationBias = 0
	end

	fn34(v96)
end

function UpdateBuffs(p)
	module19:Update()

	if module19.mDirty then
		module19.mDirty = false
		module19.mDirtyIndices = {}
	end

	for i = 1, #module19.mActiveBoosters do
		local mActiveBooster = module19.mActiveBoosters[i]
		local v96

		if mActiveBooster.mExpiry ~= nil then
			v96 = Engine.__wf_atom_db2b0cee(mActiveBooster.mExpiry)
		end

		local v97 = "HealthComponent.BuffContainer." .. mActiveBooster.mClipName

		if not (v96 ~= nil and mActiveBooster.mDuration > 0) then
			continue
		end

		local v98 = v96 / mActiveBooster.mDuration
		local v99 = __wf_atom_421b01aa(v98, 0, 1)
		mMovie:__wf_atom_4c1c1986(v97, "Inner.FillMask", 6, 200)
		mMovie:__wf_atom_4c1c1986(v97, "Inner.FillMask", 5, v99 * 175)
	end

	for i = 1, #v66 do
		local v96 = v66[i]
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v96, 16)

		if #v66 == 1 then
			local v97 = __wf_atom_5e6e15c8 + (0 - __wf_atom_5e6e15c8) * p * 4
			mMovie:__wf_atom_e57658c2(v96, 16, v97)
			mMovie:__wf_atom_4c1c1986(v96, "Inner", 16, v97)
		else
			local v97 = __wf_atom_5e6e15c8 + (25 * i - (#v66 * 25 / 2 + 12.5) - __wf_atom_5e6e15c8) * p * 4
			mMovie:__wf_atom_e57658c2(v96, 16, v97)
			mMovie:__wf_atom_4c1c1986(v96, "Inner", 16, -v97)
		end
	end
end

local function fn42(p)
	if __wf_atom_7e8ad928(postProcessMaterial) then
		return
	end

	local v96 = not _T.SpellFX and 0 or _T.SpellFX
	local __wf_atom_846af4f8 = v7:__wf_atom_7470861b():__wf_atom_846af4f8(6)
	local v97 = not (__wf_atom_846af4f8 > 0) and 0 or math.pow(__wf_atom_421b01aa(__wf_atom_846af4f8 / 3, 0, 1), 0.5)

	if _T.DrunkBias then
		v97 += _T.DrunkBias
	end

	local __wf_atom_2490589b = v67:__wf_atom_2490589b(v97, p)
	postProcessMaterial:__wf_atom_a042ff6c(
		Symbol("ChromaticShift"),
		__wf_atom_104bfe98(5, 10, __wf_atom_2490589b),
		0,
		0,
		0
	)
	postProcessMaterial:__wf_atom_a042ff6c(
		Symbol("UnderwaterParams"),
		__wf_atom_104bfe98(0, 20, __wf_atom_2490589b),
		__wf_atom_104bfe98(0, 20, __wf_atom_2490589b),
		0.2,
		0.1
	)
	postProcessMaterial:__wf_atom_a042ff6c(Symbol("UnderwaterParamsB"), 1, 0.0099999998, 0.050000001, 10)
	local postProcessBias = gRegion:__wf_atom_8ad59546().postProcessBias
	local v98 = math.abs((math.sin(__wf_atom_4658d645(Time() * 0.15) * 3.141592653589793 * 2)))
	postProcessBias.radialBlurStrength = v98 * __wf_atom_2490589b
	local cameraControl = v7:CameraControl()

	if __wf_atom_2490589b > 0.001 then
		if not flag3 then
			flag3 = true
			cameraControl:__wf_atom_dc7b15db(drunkColorGrading, 0.0001, -1, 0.0001)
		end

		cameraControl:__wf_atom_344d785e(drunkColorGrading, __wf_atom_2490589b)
	elseif flag3 then
		flag3 = false
		cameraControl:__wf_atom_928a45c5(drunkColorGrading)
	end

	if not gRegion:__wf_atom_c3b255b8() then
		v22 = __wf_atom_104bfe98(v22, v21, p * 4)
		local v99 = (v22 - 0.5) * 2
		postProcessMaterial:__wf_atom_a042ff6c(
			Symbol("VignetteStrength"),
			__wf_atom_104bfe98(0.5, 0.75, __wf_atom_421b01aa(v99 + v96 + __wf_atom_2490589b * v98, 0, 1)),
			0,
			0,
			0
		)
		postProcessMaterial:__wf_atom_a042ff6c(
			Symbol("LensDistort"),
			__wf_atom_421b01aa(v99 * 0.02 + v96 * 0.2, 0, 1),
			0,
			0,
			0
		)
	end
end

local function fn43(mAvatar3) -- 1 equivalent call inferred from this helper
	return not __wf_atom_7e8ad928(mAvatar3) and (not mAvatar3:IsA(__wf_atom_7e6ed5fa) or mAvatar3:__wf_atom_d2385fe3())
end

local function fn44()
	if not __wf_atom_7e8ad928(v12) then
		local __wf_atom_9eeb9a68 = v12:__wf_atom_9eeb9a68()

		if not __wf_atom_7e8ad928(__wf_atom_9eeb9a68) then
			mAvatar2 = __wf_atom_9eeb9a68.mAvatar

			if
				fn43(mAvatar2) -- inferred equivalent call
				and mAvatar2 ~= gRegion:__wf_atom_c4f78a8f()
				and not (gGameRules:__wf_atom_af3bd666() and gGameRules:__wf_atom_5a12aa12(mAvatar2))
			then
				local v96 = mAvatar2
				local v97

				if not __wf_atom_7e8ad928(v96) then
					v97 = gGameRules:__wf_atom_70f5d0a5(v96)

					if #v97 == 0 then
						local __wf_atom_9c7c90fb = gMatchingService:__wf_atom_9c7c90fb()

						if not __wf_atom_7e8ad928(__wf_atom_9c7c90fb) then
							v97 = __wf_atom_9c7c90fb:__wf_atom_70f5d0a5(v96)
						end
					end
				end

				if #v97 > 0 then
					return
				end
			end
		end
	end

	mAvatar2 = nil
end

function Update()
	if __wf_atom_7e8ad928(gGameRules2) or gGameRules2 ~= gGameRules then
		gGameRules2 = gGameRules
	end

	if v30 and not __wf_atom_7e8ad928(v55) then
		v30 = false
		v55:OnGamepadTransition()
	end

	if __wf_atom_7e8ad928(v57.CameraController) and not __wf_atom_7e8ad928(v8) then
		v57.CameraController = v8:CameraControl()
	end

	if __wf_atom_7e8ad928(v57.InputController) and not __wf_atom_7e8ad928(v8:__wf_atom_50a7d83e()) then
		v57.InputController = v8:__wf_atom_50a7d83e():__wf_atom_92aa9d91()
	end

	if __wf_atom_7e8ad928(v57.InventoryController) then
		v57.InventoryController = module7.GetEnvoyInventoryControl()
	end

	if
		__wf_atom_7e8ad928(v57.CameraController)
		or not v57.CameraController:__wf_atom_e62e24d5()
		or __wf_atom_7e8ad928(v57.CameraController:__wf_atom_d891a752())
	then
		if v31.IsSpectating or __wf_atom_7e8ad928(v7) then
			v31.IsSpectating = false
		end
	else
		v31.IsSpectating = true
	end

	if class ~= nil then
		class:Update()
	end

	if _T.EtherealHubActive or gGameRules:__wf_atom_95862cc1() then
		fn44()
	end

	if v65 ~= module14.IsHardModeActive() then
		v65 = module14.IsHardModeActive()

		if v65 then
			fn24()
		else
			for i = 1, #rednightDebuffIcons do
				fn22("Debuff" .. i)
			end
		end
	end

	local v96 = __wf_atom_084b3e93()
	local v97 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v97)

	if not __wf_atom_7e8ad928(v2) then
		v2:Update(v96)
	end

	if not __wf_atom_7e8ad928(v13) then
		local __wf_atom_854c2301 = v13:__wf_atom_854c2301()

		if #__wf_atom_854c2301 == 0 and not __wf_atom_7e8ad928(mAvatar2) then
			__wf_atom_854c2301 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/InspectPlayer", true, {
				INSPECT = module17.GetLocForAction("INSPECT")
			})
		end

		if v43.mValue ~= __wf_atom_854c2301 then
			if v13:__wf_atom_c2febbdc() then
				_T.GenericMessageNoAnimateTyping = true
			end

			v43:Set(__wf_atom_854c2301)
		end
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:SetActive(module11.IsStreamingLevel() and not gClient:__wf_atom_449cc668())
		v4:Update()
	end

	fn15()
	UpdateNightfold()

	if __wf_atom_7e8ad928(v7) then
		v14 = __wf_atom_421b01aa(v14 - v97, 0, 1)
		fn29()
		mMovie:__wf_atom_e57658c2("PainTop", 12, 0)
		mMovie:__wf_atom_e57658c2("PainBottom", 12, 0)
		mMovie:__wf_atom_e57658c2("PainLeft", 12, 0)
		mMovie:__wf_atom_e57658c2("PainRight", 12, 0)
	else
		progressionScreenCooldownDuration2 -= v96

		if v47 and not __wf_atom_7e8ad928(v7) then
			v46 -= v96

			if v46 < 0 then
				if fn33() then
					v47 = false
					module7.ShowProgressionScreen()
					progressionScreenCooldownDuration2 = progressionScreenCooldownDuration
					v48 = module7.IsDaytime()
				else
					v46 = 6
				end
			end
		end

		local flag4 = false
		local envoyInventoryControl = module7.GetEnvoyInventoryControl()
		local v98

		if not (__wf_atom_7e8ad928(v57.InventoryController) or __wf_atom_7e8ad928(envoyInventoryControl)) then
			v98 = envoyInventoryControl:__wf_atom_e55d02aa()
		end

		if v9 ~= v98 then
			v9 = v98
			fn18()
			flag4 = true
			v10 = nil
			v11 = nil

			if __wf_atom_7e8ad928(v9) then
				v6 = nil
			else
				v6 = v9:__wf_atom_8e96c598(4)
			end

			if not __wf_atom_7e8ad928(v9) then
				local __wf_atom_48e95afas = {}
				local v99 = { "StatsNew.CourageIcon", "StatsNew.SpiritIcon", "StatsNew.GraceIcon" }

				for i = 1, 3 do
					local __wf_atom_e68785c4 = v9:__wf_atom_e68785c4(i)

					if __wf_atom_7e8ad928(__wf_atom_e68785c4) then
						continue
					end

					local __wf_atom_48e95afa = __wf_atom_e68785c4:__wf_atom_48e95afa()

					if not __wf_atom_7e8ad928(__wf_atom_48e95afa) then
						table.insert(__wf_atom_48e95afas, __wf_atom_48e95afa)
					end
				end

				if #__wf_atom_48e95afas > 0 then
					if not v92 then
						v92 = module13.CreateAsyncLoader()
					end

					v92:LoadMultipleResources("AbilityIcons", __wf_atom_48e95afas, function()
						if __wf_atom_7e8ad928(v9) then
							return
						end

						for i = 1, 3 do
							local __wf_atom_e68785c4 = v9:__wf_atom_e68785c4(i)

							if __wf_atom_7e8ad928(__wf_atom_e68785c4) then
								continue
							end

							local __wf_atom_48e95afa = __wf_atom_e68785c4:__wf_atom_48e95afa()

							if __wf_atom_7e8ad928(__wf_atom_48e95afa) then
								continue
							end

							mMovie:__wf_atom_c90af43a(v99[i] .. ".Main", __wf_atom_48e95afa)
							mMovie:__wf_atom_c90af43a(v99[i] .. ".Shadow", __wf_atom_48e95afa)
							mMovie:__wf_atom_e57658c2(v99[i] .. ".Shadow", 12, 70)
						end
					end)
				end
			end
		end

		if not (__wf_atom_7e8ad928(v55) or __wf_atom_7e8ad928(envoyInventoryControl)) then
			v55:Update(v7, envoyInventoryControl)
		end

		local v99 = false

		if not __wf_atom_7e8ad928(envoyInventoryControl) then
			local __wf_atom_4c047e9d = envoyInventoryControl:__wf_atom_4c047e9d()

			if not (__wf_atom_7e8ad928(__wf_atom_4c047e9d) or __wf_atom_7e8ad928(__wf_atom_4c047e9d:__wf_atom_180bd4bb())) then
				v99 = true
				local v100 = __wf_atom_4c047e9d:__wf_atom_89832c32() + __wf_atom_4c047e9d:__wf_atom_04eb25d8()

				if v100 ~= v50 then
					mMovie:__wf_atom_50d60589("AmmoTracker.Label", 36, v100)
					v50 = v100
				end
			end
		end

		if v99 ~= v49 then
			mMovie:__wf_atom_2dedec1a("AmmoTracker", 13, v99)
			v49 = v99
		end

		if v42 == __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) then
			v42 = not v42
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for _, v100 in ipairs(__wf_atom_ef7900cf) do
				v100:__wf_atom_0650fed7(soulAllyProjector)
			end
		end

		UpdateFade(v97)

		if v42 and not _T.ForceShowHud then
			fn42(v97)

			if not __wf_atom_7e8ad928(v12) then
				v12:Update(v8, v97)
				v12:__wf_atom_c2d054ba(v7, false, v97)
				v12:__wf_atom_3486cae2(v7, v97, false)
			end
		else
			if __wf_atom_8e4fda44:__wf_atom_6b69b901(backgroundMovie) then
				if __wf_atom_7e8ad928(_T.BackgroundInitialized) then
					print("Closing background and reinitializing due to the fact that the BackgroundInitialized is nil")
					__wf_atom_8e4fda44:FindMovie(backgroundMovie):Close()
					__wf_atom_8e4fda44:__wf_atom_8b74c30b(backgroundMovie)
				end
			else
				print("Pushing background movie from Update")
				__wf_atom_8e4fda44:__wf_atom_8b74c30b(backgroundMovie)
			end

			v31.mDispatchingQueuedFuncs = true

			if #v29 > 0 then
				for i = 1, #v29 do
					v29[i][1](
						v29[i][2],
						v29[i][3],
						v29[i][4],
						v29[i][5],
						v29[i][6],
						v29[i][7],
						v29[i][8],
						v29[i][9],
						v29[i][10],
						v29[i][11],
						v29[i][12]
					)
				end

				v29 = {}
			end

			v31.mDispatchingQueuedFuncs = false
			local v100

			if not __wf_atom_7e8ad928(v7) then
				v100 = v7:__wf_atom_4dc54686()
			end

			fn28("ArcanaNew.CourageCallout", 1, v100)
			fn28("ArcanaNew.SpiritCallout", 2, v100)
			fn28("ArcanaNew.GraceCallout", 3, v100)
			local __wf_atom_c7fa5e0c = mMovie:__wf_atom_c7fa5e0c("<GEAR_HOTKEY_0>", v100)
			mMovie:__wf_atom_50d60589(
				"HealCharges.Callout.Tf",
				36,
				module.Ternary(__wf_atom_c7fa5e0c == "<GEAR_HOTKEY_0>", "", __wf_atom_c7fa5e0c)
			)
			local __wf_atom_92aa9d91 = v7:__wf_atom_92aa9d91()
			local v101 = __wf_atom_92aa9d91:__wf_atom_3911136e(false) or _T.ForceSoulMode
			fn14(v96, v101, v9)
			local v102 = GetSoulMeterSlot()

			if v102 ~= v58 then
				v58 = v102
				fn19()
			end

			local v103 = IsMoteAbilityActive()

			if v103 ~= v59 then
				v59 = v103
				fn19()
			end

			fn42(v97)
			local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()
			local v104 = __wf_atom_7e8ad928(__wf_atom_15811761) and "" or __wf_atom_15811761:__wf_atom_6c164199()
			local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
			local v105 = false
			local count2 = 0
			local v106 = 0

			for _, mPlayer in ipairs(__wf_atom_3c8e1a7a) do
				local __wf_atom_ef151cfd = mPlayer:__wf_atom_ef151cfd()
				local v108 = v51[__wf_atom_ef151cfd]
				local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()
				local __wf_atom_79d5d81f = mPlayer:__wf_atom_79d5d81f()
				local v109 = nil

				for _, v111 in __wf_atom_bb46d8b6 do
					if v111.matchMakingString ~= __wf_atom_79d5d81f then
						continue
					end

					v109 = v111
					break
				end

				if v108 == nil then
					v108 = {
						mHealth = 0,
						mHealthPct = 0,
						mRegainableHealthPct = 0,
						mDamageTimer = 0,
						mMatchmakingString = __wf_atom_79d5d81f,
						mPlayer = mPlayer,
						mLoadout = __wf_atom_7e8ad928(v109) and {} or cjson.decode(v109.loadout)
					}
					v51[__wf_atom_ef151cfd] = v108
				elseif v108.mName ~= mPlayer:__wf_atom_6be84646() then
					v108.mVoipState = nil
				end

				v108.mName = mPlayer:__wf_atom_6be84646()
				v108.mHost = v108.mName == v104
				local playerAvatar2 = mPlayer:GetPlayerAvatar(0)

				if not __wf_atom_7e8ad928(playerAvatar2) then
					v108.mAvatar = playerAvatar2
				end

				if mPlayer:IsLocal() and not v105 then
					v108.mClipName = "NotificationSmall"
					v108.mSlot = 0
					v105 = true
				else
					count2 += 1
					v108.mClipName = "SquadInfo.Player" .. count2
					v108.mSlot = count2
					mMovie:OverrideMaterial(v108.mClipName .. ".HealthBar", radialProgressMaterialHealth)
					mMovie:__wf_atom_2dedec1a("SquadInfo.Player" .. count2, 13, true)
				end

				if v108.mDamageTimer > 0 then
					v108.mDamageTimer -= v97
				end

				fn41(__wf_atom_ef151cfd)
				fn35(__wf_atom_ef151cfd)
				v106 = math.max(v106, v108.mDamageTimer)
			end

			for i = count2 + 1, module7.MAX_SQUAD_SIZE do
				mMovie:__wf_atom_2dedec1a("SquadInfo.Player" .. i, 13, false)
			end

			if __wf_atom_7e8ad928(playerAvatar) or not playerAvatar:IsKilled() then
				local v107

				if not __wf_atom_7e8ad928(envoyInventoryControl) then
					v107 = envoyInventoryControl:__wf_atom_35a10d3c(0)
				end

				if (__wf_atom_7e8ad928(v107) and not (v7:__wf_atom_bb81a9df() < 1 or v101 or _T.ForceShowHud or v39 or v106 > 0) and 0 or 1) > 0.1 then
					v14 = __wf_atom_421b01aa(v14 + v97, 0, 1)
					v16 = __wf_atom_421b01aa(v16 + v97, 0, 1)
				else
					v14 = __wf_atom_421b01aa(v14 - v97 * 0.34, 0, 1)

					if v14 < 0.5 then
						v16 = __wf_atom_421b01aa(v16 - v97, 0, 1)
					end
				end
			else
				v14 = __wf_atom_421b01aa(v14 - v97, 0, 1)
				mMovie:__wf_atom_e57658c2("PainTop", 12, 0)
				mMovie:__wf_atom_e57658c2("PainBottom", 12, 0)
				mMovie:__wf_atom_e57658c2("PainLeft", 12, 0)
				mMovie:__wf_atom_e57658c2("PainRight", 12, 0)
				mMovie:__wf_atom_e57658c2("EnemyHealth", 12, 0)
			end

			fn29()
			local v107 = _T.HideHud ~= nil and _T.HideHud > 0 or gClient:__wf_atom_449cc668()
			mMovie:SetVisible(not v107)

			if not __wf_atom_7e8ad928(v56) then
				v56:Update(v97, v7, v8, v12, v17, v63)
			end

			if __wf_atom_7e8ad928(playerAvatar) or not playerAvatar:IsKilled() then
				if not __wf_atom_7e8ad928(v9) then
					v39 = false
					fn32(1, v97)
					fn32(2, v97)
					fn32(3, v97)
					local __wf_atom_4ca4978e = v9:__wf_atom_4ca4978e()
					local v108

					if not __wf_atom_7e8ad928(__wf_atom_4ca4978e) then
						v108 = v9:__wf_atom_e21e8409(__wf_atom_4ca4978e) or nil
					end

					local mHasSoulStealAbility = not __wf_atom_7e8ad928(v108) and v108:IsEnabled()

					if mHasSoulStealAbility then
						local v110 = v9:__wf_atom_f3044fe0() / v9:__wf_atom_6a5c92a7()
						local v111 = v110 == nil and 1 or v110

						if v31.mHasSoulStealAbility == mHasSoulStealAbility then
							mMovie:__wf_atom_e57658c2("StatsNew.Soul.Meter.Mask", 15, v25.SOUL_METER_HEIGHT * v111)
						else
							v31.mHasSoulStealAbility = mHasSoulStealAbility
							__wf_atom_ec43d06e(mMovie, "StatsNew.Soul", 8, { 12 }, { 150 }, 0.3)
						end
					elseif v31.mHasSoulStealAbility ~= mHasSoulStealAbility then
						v31.mHasSoulStealAbility = mHasSoulStealAbility
						__wf_atom_ec43d06e(mMovie, "StatsNew.Soul", 8, { 12 }, { 0 }, 0.3)
					end

					local __wf_atom_22941262 = v9:__wf_atom_22941262()

					if not __wf_atom_7e8ad928(v12) and v10 ~= __wf_atom_22941262 then
						v10 = __wf_atom_22941262
					end

					local v110 = __wf_atom_22941262 == v9:__wf_atom_e0ccd217() and 100
						or math.floor(v9:__wf_atom_dd642f5c() * 100) + 1

					if v11 ~= v110 then
						if v11 then
							v11 = __wf_atom_104bfe98(v11, v110, v96 * 3)
						else
							v11 = v110
						end

						__wf_atom_86cbd68d(mMovie, "NotificationSmall.Bar.gotoAndStop", v11)
					end

					local v111, v112

					if v58 == nil then
						v111 = -1
						v112 = false
					else
						local __wf_atom_6a5c92a7 = v9:__wf_atom_6a5c92a7(v58)
						local __wf_atom_f3044fe0 = v9:__wf_atom_f3044fe0(v58)
						v111 = __wf_atom_f3044fe0 / 200
						v112 = __wf_atom_6a5c92a7 <= __wf_atom_f3044fe0
						local v113 = (200 - __wf_atom_6a5c92a7) / 200

						for i = 0, 3 do
							fn36(0.25 * i, "StatsNew.Frame1.Notch", i)
							mMovie:__wf_atom_2dedec1a("StatsNew.Frame1.Notch" .. i, 13, true)
						end

						mMovie:__wf_atom_1ca72041("StatsNew.SoulEnergyLockedFill", "AlphaTestThreshold", v113, 0, 0, 0)
					end

					if flag4 then
						v40 = v111
						mMovie:__wf_atom_1ca72041("StatsNew.SoulEnergyFill", "AlphaTestThreshold", v111, 0, 0, 0)
					elseif v40 ~= v111 then
						if v111 >= 1 then
							module.PlaySound(energyFullSound)
						elseif v41 and not v112 and (__wf_atom_7e8ad928(v9) or not v9:__wf_atom_a07f65c2()) then
							mMovie:__wf_atom_e57658c2(
								"StatsNew.SoulEnergyFill",
								11,
								v25.SOUL_ENERGY_COLOR:__wf_atom_dcecedb0()
							)
						end

						if v111 < v40 then
							if v111 <= 0 and v111 > -1 then
								module.PlaySound(energyEmptySound)
							end

							fn17()
						else
							flag2 = false
						end

						v40 = v111
						v41 = v112
						mMovie:__wf_atom_1ca72041("StatsNew.SoulEnergyFill", "AlphaTestThreshold", v111, 0, 0, 0)
					end

					if v112 and (__wf_atom_7e8ad928(v9) or not v9:__wf_atom_a07f65c2()) then
						local v113 = __wf_atom_104bfe98(0.5, 1, (math.abs((math.sin(Time() * 1 * 3.141592653589793)))))
						mMovie:__wf_atom_e57658c2(
							"StatsNew.SoulEnergyFill",
							11,
							Color(0, 0, 0):__wf_atom_104bfe98(v25.SOUL_ENERGY_COLOR, v113):__wf_atom_dcecedb0()
						)
						mMovie:__wf_atom_e57658c2(
							"StatsNew.SpiritGlow",
							11,
							Color(255 * v113, 255 * v113, 255 * v113):__wf_atom_dcecedb0()
						)
					end
				end

				local flag5 = false
				local v108 = false
				local v109 = false
				local v110

				if not __wf_atom_7e8ad928(envoyInventoryControl) then
					v110 = envoyInventoryControl:__wf_atom_4c047e9d()
				end

				if not __wf_atom_7e8ad928(v110) then
					if v110:__wf_atom_3e33d5dd() == 0 then
						local __wf_atom_414f70dd = v110:__wf_atom_414f70dd(0)

						if
							not __wf_atom_7e8ad928(__wf_atom_414f70dd)
							and __wf_atom_414f70dd:IsA(__wf_atom_7486ea74)
						then
							v109 = true
							flag5 = true
						end
					elseif v110:__wf_atom_0e0343b4(true, true) then
						flag5 = true
					end

					local __wf_atom_75a0566d = v110:__wf_atom_75a0566d()

					if not __wf_atom_7e8ad928(__wf_atom_75a0566d) and __wf_atom_75a0566d:__wf_atom_f824cfe6() == 8 then
						v108 = true
					end
				end

				local v111

				if v109 and flag5 then
					if not v110:__wf_atom_dedeec57() then
						v110:__wf_atom_ead6242d()
					end

					v111 = -7
				else
					v111 = 0
				end

				local __wf_atom_2490589b = v94:__wf_atom_2490589b(v111, v97)
				v7:__wf_atom_2f0092a2(Symbol("GAME_C1_SPINE2"), Rotation(__wf_atom_2490589b, 0, 0))

				if not v84 and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
					v84 = true
					fn9()
					__wf_atom_55142dd4(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01(), "OnProfileSaved")
				end

				if __wf_atom_7e8ad928(v12) then
					v12 = v8:__wf_atom_330f77f5(true)
					v12:__wf_atom_ba3e8a92(v8)
					v12:__wf_atom_c84d1d8e()
					v12:__wf_atom_e8aae4c8(true)
					fn25()
					v12:__wf_atom_775dd181(mMovie)
					v12:__wf_atom_c06cd6e6(v3:GetCoords("Notification").y)
				else
					v12:Update(v8, v97)
					v12:__wf_atom_9527dd63(v7, v97)
					v12:__wf_atom_c2d054ba(v7, false, v97)
					v12:__wf_atom_3486cae2(v7, v97, false)
					v12:__wf_atom_ee4c93da(
						v7,
						_T.DisableMiniMap == true,
						_T.DisableMiniMap ~= true,
						_T.OverlayMapVisible == true
					)
					local v112 = { mAvatar = nil }
					local __wf_atom_f036f03b = __wf_atom_92aa9d91:__wf_atom_f036f03b()
					local v113 = v101 or flag5

					if
						not v113
						and __wf_atom_92aa9d91:__wf_atom_f597f078()
						and (v108 or __wf_atom_7e8ad928(__wf_atom_f036f03b))
						or v113
					then
						local v114

						if not __wf_atom_7e8ad928(envoyInventoryControl) then
							v114 = envoyInventoryControl:__wf_atom_f2e7f4a9()
						end

						if
							not __wf_atom_7e8ad928(v114)
							and v114:IsA(__wf_atom_67c46eba)
							and not __wf_atom_7e8ad928(v13)
						then
							local filterStatusEntity = v13:FilterStatusEntity(v114)

							if
								not __wf_atom_7e8ad928(filterStatusEntity)
								and Distance(filterStatusEntity.otherAvatar:GetPosition(), v7:GetPosition()) <= 40
							then
								v112.mAvatar = filterStatusEntity.otherAvatar

								if
									not __wf_atom_7e8ad928(filterStatusEntity.otherAvatar)
									and not __wf_atom_7e8ad928(v12:__wf_atom_3c4f0eb1())
									and filterStatusEntity.otherAvatar ~= v12:__wf_atom_3c4f0eb1()
								then
									v12:__wf_atom_b4277be3(nil)
								end

								__wf_atom_f036f03b = v114
							end
						end
					end

					local flag6

					if
						__wf_atom_7e8ad928(__wf_atom_f036f03b)
						or not __wf_atom_f036f03b:IsA(__wf_atom_67c46eba)
						or __wf_atom_f036f03b:IsKilled()
						or not __wf_atom_f036f03b:__wf_atom_1c5f2430()
						or __wf_atom_f036f03b:__wf_atom_e93896ba() == Symbol("Neutral")
						or __wf_atom_f036f03b:__wf_atom_464a4772()
						or not __wf_atom_f036f03b:__wf_atom_49ad2492(0.2)
						or __wf_atom_f036f03b:__wf_atom_129d1aba(v7)
					then
						flag6 = false
					else
						v112.mAvatar = __wf_atom_f036f03b
						flag6 = true
					end

					if flag6 and not __wf_atom_7e8ad928(__wf_atom_f036f03b) and v18 ~= __wf_atom_f036f03b then
						v18 = __wf_atom_f036f03b
						local v114 = v18:EyePosition() + Vector(0, v18:__wf_atom_d547c32d(), 0)
						local __wf_atom_a2a18137 = v18:__wf_atom_a2a18137()
						v45:__wf_atom_4453e49c(v114.y - __wf_atom_a2a18137.y)
						mMovie:__wf_atom_e57658c2("EnemyHealth", 5, v54.Scale)
						mMovie:__wf_atom_e57658c2("EnemyHealth", 6, v54.Scale)
					end

					local v114 = 0.3

					if not __wf_atom_7e8ad928(v18) then
						local v115 = v18:EyePosition() + Vector(0, v18:__wf_atom_d547c32d(), 0)
						local __wf_atom_a2a18137 = v18:__wf_atom_a2a18137()
						__wf_atom_a2a18137.y += v45:__wf_atom_2490589b(v115.y - __wf_atom_a2a18137.y, v97)
						local __wf_atom_74b9a49b = mMovie:__wf_atom_74b9a49b(__wf_atom_a2a18137)
						local __wf_atom_d5fda8be = v7:__wf_atom_d5fda8be(__wf_atom_a2a18137)
						local v116 = __wf_atom_104bfe98(0, 25, __wf_atom_d5fda8be / 35)
						__wf_atom_74b9a49b.x = __wf_atom_421b01aa(__wf_atom_74b9a49b.x, v68.x + 30, v69.x - 30)
						__wf_atom_74b9a49b.y = __wf_atom_421b01aa(__wf_atom_74b9a49b.y - v116, v68.y + 44, v69.y - 44)
						mMovie:__wf_atom_e57658c2("EnemyHealth", 0, __wf_atom_74b9a49b.x)
						mMovie:__wf_atom_e57658c2("EnemyHealth", 1, __wf_atom_74b9a49b.y)
						fn30(v18)

						if v18:IsKilled() or v18:__wf_atom_e93896ba() == Symbol("Neutral") then
							v18 = nil
							flag6 = false
							v17 = true
							v114 = 0.15
						end
					end

					if v17 ~= flag6 then
						v17 = flag6

						if flag6 then
							__wf_atom_ec43d06e(mMovie, "EnemyHealth", 8, { 12 }, { v54.Alpha }, 0.15)
						else
							__wf_atom_ec43d06e(mMovie, "EnemyHealth", 8, { 12 }, { 0 }, v114)
						end
					end

					if v12:__wf_atom_d0ecd4ab() then
						module4.Sort()
					end

					if __wf_atom_c67f9605:__wf_atom_767c33c3() then
						v12:__wf_atom_41f28674(not module11.IsInOverworld())
						v12:__wf_atom_1d2159af(v7, nil, nil)
					end
				end

				if __wf_atom_7e8ad928(v13) then
					v13 = v8:__wf_atom_301e8d97()
					v13:__wf_atom_ba3e8a92(v8)
				end

				local v112

				if not __wf_atom_7e8ad928(envoyInventoryControl) then
					v112 = envoyInventoryControl:__wf_atom_28224c27(0)
				end

				if not __wf_atom_7e8ad928(v112) then
					local v113 = v112:__wf_atom_89832c32() / v112:__wf_atom_3d08948b(0):__wf_atom_693aebd2()

					if v113 <= 0 then
						mMovie:__wf_atom_e57658c2("ArcanaNew.CannonStatus.CannonIcon", 12, 50)
					elseif v113 < 1 then
						mMovie:__wf_atom_e57658c2("ArcanaNew.CannonStatus.CannonIcon", 12, 50)
					else
						mMovie:__wf_atom_e57658c2("ArcanaNew.CannonStatus.CannonIcon", 12, 100)
					end

					for i = 1, 3 do
						local v114 = "ArcanaNew.CannonStatus.Pip" .. i

						if v113 >= 1 then
							mMovie:__wf_atom_2dedec1a(v114, 13, true)
							mMovie:__wf_atom_e57658c2(v114, 12, 100)
							mMovie:__wf_atom_e57658c2(v114, 6, 100)
							v113 -= 1
						elseif v113 > 0 then
							mMovie:__wf_atom_2dedec1a(v114, 13, true)
							mMovie:__wf_atom_e57658c2(v114, 12, 50)
							mMovie:__wf_atom_e57658c2(v114, 6, v113 * 100)
							v113 = 0
						else
							mMovie:__wf_atom_2dedec1a(v114, 13, false)
						end
					end
				end

				local v113 = v26

				if not __wf_atom_7e8ad928(envoyInventoryControl) then
					v113 = envoyInventoryControl:__wf_atom_d5bed0b3()
				end

				if v113 ~= v26 or _T.TestNotif then
					if _T.TestNotif then
						_T.TestNotif = nil
						v113 = v26 + 4000
					end

					if v113 - v26 > 2000 then
						v26 = v113
						v7:PlaySound(notifySound, false)
						__wf_atom_86cbd68d(mMovie, "Notify.gotoAndPlay", 1)
						mMovie:__wf_atom_50d60589("Notify.Label", 36, "Skill point awarded!")
						local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Notify.Label", 40)
						mMovie:__wf_atom_e57658c2("Notify.Label", 0, -__wf_atom_5e6e15c8 / 2)
						__wf_atom_ec43d06e(mMovie, "Notify", 8, { 12 }, { v25.FULL_ALPHA }, 2, 0, function()
							__wf_atom_ec43d06e(mMovie, "Notify", 8, { 12 }, { 0 }, 2, 3)
						end)
					end
				end

				if not __wf_atom_7e8ad928(v110) and v108 then
					local __wf_atom_083a9e64 = v110:__wf_atom_083a9e64()
					local v114, v115

					if __wf_atom_083a9e64:IsA(__wf_atom_609eeefa) then
						v114 = __wf_atom_083a9e64:__wf_atom_f9b5aca2()
						v115 = __wf_atom_083a9e64:__wf_atom_ea97c292()
						v108 = true
					else
						v114 = 0
					end

					local v116 = __wf_atom_421b01aa(v114, 0, 1)

					if v116 > 0 and v115.maxValue > 0 then
						if not flag then
							__wf_atom_ec43d06e(mMovie, "Throw", 8, { 12 }, { 75 }, 0.15)
						end

						local v117 = (v115.minValue + v115.maxValue) * 0.5
						local v118 = v115.maxValue - v115.minValue
						mMovie:__wf_atom_e57658c2("Throw.Perfect", 0, v117 * 106 - 53)
						mMovie:__wf_atom_e57658c2("Throw.Perfect", 14, v118 * 106)
						flag = true
						mMovie:__wf_atom_e57658c2("Throw.Charge", 0, v116 * 106 - 53)

						if v115:Contains(v116) then
							mMovie:__wf_atom_e57658c2("Throw.Perfect", 11, 15385216)
						else
							mMovie:__wf_atom_e57658c2("Throw.Perfect", 11, 8355711)
						end
					else
						if flag then
							__wf_atom_ec43d06e(mMovie, "Throw", 8, { 12 }, { 0 }, 0.15)
						end

						flag = false
					end
				end

				if v27 == nil and not __wf_atom_7e8ad928(envoyInventoryControl) then
					for i = 1, envoyInventoryControl:__wf_atom_62abd325(0) do
						local __wf_atom_ba1c3957 = envoyInventoryControl:__wf_atom_ba1c3957(i - 1, 0)

						if __wf_atom_7e8ad928(__wf_atom_ba1c3957) or not __wf_atom_ba1c3957:IsA(healthPotionType) then
							continue
						end

						v27 = i - 1
						mMovie:__wf_atom_c90af43a("HealCharges.Icon", __wf_atom_ba1c3957:GetIconTexture())
						envoyInventoryControl:__wf_atom_218da54d(v27)
						v55:SetPotionIcon(__wf_atom_ba1c3957:GetIconTexture())
						v55:SetPotionIconActive(true)
					end
				end

				if v27 ~= nil and not __wf_atom_7e8ad928(envoyInventoryControl) then
					local __wf_atom_5574f912 = envoyInventoryControl:__wf_atom_5574f912()

					if v27 ~= __wf_atom_5574f912 then
						v27 = __wf_atom_5574f912
						local __wf_atom_ba1c3957 = envoyInventoryControl:__wf_atom_ba1c3957(v27, 0)

						if not __wf_atom_7e8ad928(__wf_atom_ba1c3957) then
							mMovie:__wf_atom_c90af43a("HealCharges.Icon", __wf_atom_ba1c3957:GetIconTexture())
							v55:SetPotionIcon(__wf_atom_ba1c3957:GetIconTexture())
							v55:SetPotionIconActive(true)
						end
					end

					local __wf_atom_b62f2024 = envoyInventoryControl:__wf_atom_b62f2024(v27, 0)

					if __wf_atom_b62f2024 ~= v28 then
						v28 = __wf_atom_b62f2024
						mMovie:__wf_atom_50d60589("HealCharges.Label", 36, __wf_atom_b62f2024)
						v55:SetPotionCount(__wf_atom_b62f2024)
						mMovie:__wf_atom_e57658c2(
							"HealCharges.Callout.tf",
							12,
							module.Ternary(__wf_atom_b62f2024 > 0, 100, 70)
						)

						if __wf_atom_b62f2024 <= 0 then
							v27 = nil
						end
					end
				end

				if not (__wf_atom_7e8ad928(v110) or v108) then
					local __wf_atom_75a0566d = v110:__wf_atom_75a0566d()
					local v114 = false

					if not __wf_atom_7e8ad928(__wf_atom_75a0566d) and __wf_atom_75a0566d:__wf_atom_dedeec57() then
						local __wf_atom_083a9e64 = v110:__wf_atom_083a9e64()
						local v115, v116

						if __wf_atom_083a9e64:IsA(__wf_atom_27b2ed0b) then
							v115 = __wf_atom_083a9e64:__wf_atom_f9b5aca2()
							v116 = __wf_atom_083a9e64:__wf_atom_2520c9c7()
						else
							v115 = 0
						end

						local v117 = __wf_atom_421b01aa(v115, 0, 1)

						if v117 > 0 and v116.minValue < 1 then
							if not flag then
								__wf_atom_ec43d06e(mMovie, "Throw", 8, { 12 }, { 75 }, 0.15)
							end

							local v118 = (v116.minValue + v116.maxValue) * 0.5
							local v119 = v116.maxValue - v116.minValue
							flag = true
							mMovie:__wf_atom_e57658c2("Throw.Perfect", 0, v118 * 106 - 53)
							mMovie:__wf_atom_e57658c2("Throw.Perfect", 14, v119 * 106)
							mMovie:__wf_atom_e57658c2("Throw.Charge", 0, v117 * 106 - 53)

							if v116:Contains(v117) then
								mMovie:__wf_atom_e57658c2("Throw.Perfect", 11, 15385216)
							else
								mMovie:__wf_atom_e57658c2("Throw.Perfect", 11, 8355711)
							end

							v114 = true
						end
					end

					if not v114 and flag then
						__wf_atom_ec43d06e(mMovie, "Throw", 8, { 12 }, { 0 }, 0.15)
						flag = false
					end
				end

				local v114 = 0
				local v115 = v81.mCrosshairScale == nil and 0.75 or v81.mCrosshairScale
				mMovie:__wf_atom_e57658c2("LockOn", 5, v115 * 50)
				mMovie:__wf_atom_e57658c2("LockOn", 6, v115 * 50)

				if flag5 then
					v114 = 90
				elseif not (__wf_atom_7e8ad928(__wf_atom_92aa9d91) or __wf_atom_7e8ad928(envoyInventoryControl)) then
					if __wf_atom_7e8ad928((__wf_atom_92aa9d91:__wf_atom_f036f03b())) then
						envoyInventoryControl:__wf_atom_42d19f6e()
					end

					if v101 or _T.ForceReticle then
						if not v7:IsA(__wf_atom_47cae841) then
							mMovie:__wf_atom_e57658c2("LockOn", 0, mMovie:__wf_atom_97cd8326() * 0.5)
							mMovie:__wf_atom_e57658c2("LockOn", 1, mMovie:__wf_atom_54eeda24() * 0.5)
							v114 = 100
						end
					elseif flag and v108 then
						mMovie:__wf_atom_e57658c2("LockOn", 0, mMovie:__wf_atom_97cd8326() * 0.5)
						mMovie:__wf_atom_e57658c2("LockOn", 1, mMovie:__wf_atom_54eeda24() * 0.5)
						v114 = 100
					elseif __wf_atom_92aa9d91:__wf_atom_f597f078() then
						v114 = 90
					else
						local __wf_atom_35a10d3c = envoyInventoryControl:__wf_atom_35a10d3c(0)
						v114 = not __wf_atom_7e8ad928(__wf_atom_35a10d3c)
							and __wf_atom_35a10d3c:__wf_atom_0395f752() == 1
							and not __wf_atom_35a10d3c:__wf_atom_f018ec88(__wf_atom_35a10d3c:__wf_atom_5e005c29())
							and 90
							or v114
					end
				end

				if flag and v14 < 0.5 then
					v14 = 0.5
				end

				if __wf_atom_7e8ad928(mSettings) then
					local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

					if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
						mSettings = __wf_atom_18a5d83b:Settings()
					end
				else
					v114 = mSettings:__wf_atom_f8127d00() and not (v107 or _T.TopMenuOpen) and 100 or v114
				end

				mMovie:__wf_atom_e57658c2("LockOn", 12, v114)
				mMovie:__wf_atom_e57658c2("LockOn", 11, 14540253)

				if __wf_atom_7e8ad928(envoyInventoryControl) then
					mMovie:__wf_atom_2dedec1a("LockOn.SpellCursor", 13, false)
				else
					local aimPosition = v7:GetAimPosition()
					local __wf_atom_74d951b0 = envoyInventoryControl:__wf_atom_74d951b0()
					local v116 = Length(__wf_atom_74d951b0 - aimPosition)
					local v117 = v101 ~= nil and v101 and true or false
					mMovie:__wf_atom_2dedec1a("LockOn.SpellCursor", 13, v117 and v116 < 15)
				end

				module5.Update()
				UpdateBuffs(v96)

				if v31.mImpactMessageWithCountdown and not (v31.mImpactMessageDuration <= 0) then
					v31.mImpactMessageDuration -= v96
					mMovie:__wf_atom_50d60589(
						"ImpactMessage.Countdown.Text",
						36,
						module.FormatNumber(v31.mImpactMessageDuration, 0)
					)
				end

				if v92 then
					v92:Update()
				end
			else
				mMovie:__wf_atom_290807ee("Throw")
				mMovie:__wf_atom_e57658c2("Throw", 12, 0)

				if not __wf_atom_7e8ad928(v12) then
					v12:Update(v8, v97)
					v12:__wf_atom_c2d054ba(v7, false, v97)
					v12:__wf_atom_3486cae2(v7, v97, false)
				end
			end
		end
	end
end

function AnimateTyping(p, value, p2)
	module.AnimateTyping(mMovie, nil, p, value or "", p2)
end

function UpdatePickupText(p, p2, p3, p4, p5, p6)
	local v96 = tonumber(p4)
	local v97 = tonumber(p5)
	local v98 = p .. ".Title"
	local v99 = p .. ".TotalCount"
	local formatNumber = module.FormatNumber(v96)
	local v100 = (v96 == 1 or v96 == 0) and "" or formatNumber .. " "
	local v101 = p2 ~= "/SF/Language/Items/AmountItemMax" and p2 ~= "/SF/Language/Items/AmountItemMaxMessage" and ""
		or " " .. mMovie:__wf_atom_8e9ac384("/SF/Language/Items/AmountItemMax", false)
	local v102 = "<p><font color='#bca783'>(" .. module.FormatNumber(v97) .. v101 .. ")</font></p>"
	local v103 = (v102 == 0 or v96 == 0) and "" or v102
	local v104 = "'#D1BD99'"

	if p6 == "false" then
		mMovie:__wf_atom_e57658c2(v98, 12, 75)
		mMovie:__wf_atom_e57658c2(v99, 12, 50)
		v104 = "'#736A57'"
	else
		mMovie:__wf_atom_e57658c2(v98, 12, 100)
		mMovie:__wf_atom_e57658c2(v99, 12, 75)
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v98, 0)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v98, 40)
	mMovie:__wf_atom_e57658c2(v99, 0, __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 + 5)
	mMovie:__wf_atom_50d60589(v99, 36, v103)
	local v105 = v100 .. p3

	if p3 == "" then
		v105 = mMovie:__wf_atom_8e9ac384(p2, false)
	end

	local v106 = "<p><font color=" .. v104 .. ">" .. v105 .. "</font></p>"
	mMovie:__wf_atom_50d60589(v98, 36, v106)
end

function AnimatePickupText(p, p2, p3, p4, p5)
	local v96 = tonumber(p4)
	local v97 = tonumber(p5)

	if v97 == 0 then
		UpdatePickupText(p, p2, p3, v96)
		return
	end

	UpdatePickupText(p, p2, p3, v97)
	__wf_atom_ec43d06e(mMovie, p, 8, { function(_)
			local v99 = math.ceil(v96 - v97)
			UpdatePickupText(p, p2, p3, v99, v96)
		end }, { 1 }, 1.5, 0.2)
end

function PulseText(_) end

local function fn45(curTransmission, p)
	local movie = __wf_atom_8e4fda44:FindMovie(_G.UIMovie_TransmissionMovie)

	if curTransmission == nil then
		curTransmission = _T.curTransmission
	end

	if not (__wf_atom_7e8ad928(curTransmission) or __wf_atom_7e8ad928(movie)) then
		if _T.curTransmission == curTransmission or p and _T.curTransmission:IsA(curTransmission) then
			movie:Execute("QueueClose", "")
		elseif not __wf_atom_7e8ad928(_T.QueuedTransmissions) then
			local v96 = 1

			while v96 <= #_T.QueuedTransmissions do
				if
					_T.QueuedTransmissions[v96].Transmission == curTransmission
					or p and _T.QueuedTransmissions[v96].Transmission:IsA(curTransmission)
				then
					table.remove(_T.QueuedTransmissions, v96)
					return
				end

				v96 += 1

				if v96 > 1000 then
					LogBug("Transmission queue overflow")
				end
			end
		end
	end
end

local function fn46(transmission, __wf_atom_f8cac16f)
	if _T.QueuedTransmissions == nil then
		_T.QueuedTransmissions = {}
	end

	print("Queuing new transmission: " .. transmission:GetName())

	if SF.__wf_atom_ab12373e(transmission).mQueueDump then
		print("Dumping queued transmissions and interrupting current one")
		fn45()
		_T.QueuedTransmissions = {}
	end

	table.insert(_T.QueuedTransmissions, {
		Transmission = transmission,
		SpeakerData = __wf_atom_f8cac16f
	})
end

function ShowTransmission(p)
	if _T.DisableAllTransmissions then
		return
	end

	local v96 = WeakResource(p)

	if not __wf_atom_7e8ad928(gGameData) and not gGameData:__wf_atom_7f86fc42(v78) and v96:IsA(v80) then
		p = v79:__wf_atom_5b41f63b()
		gGameData:__wf_atom_c9bb8504(v78)
	end

	local transmission = Resource(p)
	local v98 = not __wf_atom_7e8ad928(_T.curTransmission) and _T.curTransmission:__wf_atom_5b41f63b() == p

	if not v98 then
		for i = 1, #_T.QueuedTransmissions do
			if
				__wf_atom_7e8ad928(_T.QueuedTransmissions[i].Transmission)
				or _T.QueuedTransmissions[i].Transmission:__wf_atom_5b41f63b() ~= p
			then
				continue
			end

			v98 = true
			break
		end
	end

	if not v98 then
		local __wf_atom_f8cac16f = v12:__wf_atom_f8cac16f()

		if not __wf_atom_7e8ad928(transmission) then
			fn46(transmission, __wf_atom_f8cac16f)

			if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(_G.UIMovie_TransmissionMovie))) then
				__wf_atom_8e4fda44:__wf_atom_8b74c30b(_G.UIMovie_TransmissionMovie)
			end
		end

		v31.mTransOnRightSide = transmission:__wf_atom_f7082041()
		print("Queued a transmission from Hud: " .. p)
		local movie = __wf_atom_8e4fda44:FindMovie(_G.UIMovie_TransmissionMovie)
		assert(not __wf_atom_7e8ad928(movie))

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("TransmissionQueuedFromHud", p)
		end
	end
end

function SetForceShowHUD(forceShowHud)
	_T.ForceShowHud = forceShowHud
	mMovie:__wf_atom_62d09591(forceShowHud)
end

function SetForceShowAbilities(p)
	v35 = p

	if p then
		__wf_atom_ec43d06e(mMovie, "StatsNew", 8, { 12 }, { v25.FULL_ALPHA }, 0.25)
	end
end

function ActivateFullHUD()
	v14 = 1
end

function ShowBossListStatus(pendingBossStatusAvatars, p)
	local movie = __wf_atom_8e4fda44:FindMovie(bossStatusMovie)

	if pendingBossStatusAvatars == nil or #pendingBossStatusAvatars == 0 then
		v63 = false

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("TransitionOut", "")
		end
	else
		v63 = true

		if __wf_atom_7e8ad928(v12) then
			return
		end

		_T.PendingBossStatusAvatars = pendingBossStatusAvatars
		local forceShowHud

		if __wf_atom_7e8ad928(_T.ForceShowHud) then
			forceShowHud = false
		else
			forceShowHud = _T.ForceShowHud
		end

		if p == nil then
			p = false
		end

		v12:__wf_atom_b4984563(
			bossStatusMovie,
			"AcquireBossAvatar",
			{ tostring(forceShowHud), (tostring(p)) },
			-1,
			"BossStatus",
			true
		)
	end
end

function ShowBossStatus(p)
	if p == nil then
		ShowBossListStatus(nil, false)
	else
		ShowBossListStatus({ p }, false)
	end
end

function ModifyControllerTag(value)
	if not string.find(value, "_KBM") then
		return value
	end

	local isPlayingWithController = Engine.IsPlayingWithController()
	local v96 = Engine.__wf_atom_84bb79c2() or Engine.__wf_atom_e43a530e() or Engine.__wf_atom_b290ec01()
	local __wf_atom_dd1285f1 = Engine.__wf_atom_dd1285f1()

	if v96 then
		if isPlayingWithController then
			return (string.gsub(value, "_KBM", "_Controller"))
		end
	else
		if isPlayingWithController then
			return (string.gsub(value, "_KBM", "_Controller"))
		end

		if __wf_atom_dd1285f1 then
			value = string.gsub(value, "_KBM", "_Touch")
		end
	end

	return value
end

function HideImpactMessage()
	if not __wf_atom_7e8ad928(v12) then
		v12:__wf_atom_819f9afc("ImpactMessage")
	end

	v31.ActiveImpactMessage = nil
	v37 = nil
	v31.mImpactMessageText = nil
	v31.mImpactMessageFilter = nil
	v31.mImpactMessageParameters = nil
	v31.mImpactMessageWithCountdown = false
	__wf_atom_ec43d06e(
		mMovie,
		"ImpactMessage",
		0,
		{ 12, 5, 6 },
		{ 0, v31.mImpactMessageTransitionScale, v31.mImpactMessageTransitionScale },
		0.25
	)

	if not __wf_atom_7e8ad928(v38) then
		mMovie:__wf_atom_62d09591(v38)
		v38 = nil
	end
end

local function fn47(p)
	__wf_atom_ec43d06e(mMovie, p, 2, { 5, 6 }, { 110, 110 }, 0.4, 0, function()
		__wf_atom_ec43d06e(mMovie, p, 1, { 5, 6 }, { 100, 100 }, 0.6, 0, function()
			fn47(p)
		end)
	end)
end

local function fn48(p)
	mMovie:__wf_atom_1ca72041("ImpactMessage.Label", "Dissolve", 1 - p, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("ImpactMessage.Line", "Dissolve", 1 - p, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("ImpactMessage.Backer", "Dissolve", 1 - p, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("ImpactMessage.Icon", "Dissolve", 1 - p, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("ImpactMessage.Countdown.Backer", "Dissolve", 1 - p, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("ImpactMessage.Countdown.Text", "Dissolve", 1 - p, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("ImpactMessage.Topper", "Dissolve", 1 - p, 0, 0, 0)
end

function SetImpactMessageText(p, p2, p3)
	local v96

	if __wf_atom_7e8ad928(p2) then
		v96 = mMovie:__wf_atom_8e9ac384(p, true, p3)
	else
		v96 = mMovie:__wf_atom_c7fa5e0c(p, p2, p3)

		if string.find(v96, "<[%u%d_]+>") then
			v96 = mMovie:__wf_atom_8e9ac384(p, true, p3)
		end
	end

	mMovie:__wf_atom_50d60589("ImpactMessage.Label", 36, v96)
end

function FormatImpactMessageBacker()
	if __wf_atom_7e8ad928(_G.UIColor_DarkerBrown) then
		return
	end

	local v96 = math.max(
		mMovie:__wf_atom_5e6e15c8("ImpactMessage.Line", 14) - 80,
		mMovie:__wf_atom_5e6e15c8("ImpactMessage.Label", 40)
	)
	mMovie:__wf_atom_e57658c2("ImpactMessage.Backer", 14, v96 + 200)
	local v97 = mMovie:__wf_atom_5e6e15c8("ImpactMessage.Label", 41) + 32
	mMovie:__wf_atom_e57658c2("ImpactMessage.Backer", 15, v97)
	mMovie:__wf_atom_e57658c2("ImpactMessage.Backer", 11, _G.UIColor_DarkerBrown)
	mMovie:__wf_atom_e57658c2("ImpactMessage.Backer", 12, 70)
	local visibilitySize = module.GetVisibilitySize(mMovie, v96, true)
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 40, true)
	mMovie:OverrideMaterial("ImpactMessage.Backer", impactBackerMaterial)
	mMovie:__wf_atom_1ca72041("ImpactMessage.Backer", "VisibilitySize", visibilitySize, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("ImpactMessage.Backer", "VisibilityFadeSize", visibilityFadeSize, 0, 0, 0)
end

function OnImpactMessageShown(p)
	v31.ActiveImpactMessage = nil
	local decoded = cjson.decode(p)
	local message = decoded.Message
	local duration = decoded.Duration or 0
	local sound = decoded.Sound

	if sound ~= nil then
		sound = Resource(sound)
	end

	local particles = decoded.Particles
	local decoded2

	if decoded.LocalizationParameters ~= nil then
		decoded2 = cjson.decode(decoded.LocalizationParameters)
	end

	v31.mImpactMessageParameters = decoded2
	local frame = decoded.Frame
	local scale = decoded.Scale
	local transitionScale = decoded.TransitionScale
	local drawOverCinematics = decoded.DrawOverCinematics
	local localizeInputFilter = decoded.LocalizeInputFilter

	if localizeInputFilter ~= nil then
		localizeInputFilter = WeakResource(localizeInputFilter)
	end

	v31.mImpactMessageFilter = localizeInputFilter
	local withCountdown = decoded.WithCountdown or false
	mMovie:__wf_atom_2dedec1a("ImpactMessage.Countdown", 13, withCountdown)
	mMovie:__wf_atom_2dedec1a("ImpactMessage.Icon", 13, not withCountdown)
	mMovie:__wf_atom_50d60589("ImpactMessage.Countdown.Text", 36, (tostring(duration)))
	v31.mImpactMessageDuration = duration
	v31.mImpactMessageWithCountdown = withCountdown

	if v31.mImpactMessageFrame ~= frame then
		v31.mImpactMessageFrame = frame
		__wf_atom_86cbd68d(mMovie, "ImpactMessage.gotoAndStop", frame)
	end

	if scale then
		v31.mImpactMessageScale = scale
	else
		scale = 100
	end

	if transitionScale then
		v31.mImpactMessageTransitionScale = transitionScale
	else
		transitionScale = 100
	end

	local v96

	if v31.mImpactMessageText == message then
		v96 = 0
	else
		v96 = 0.75
		v31.mImpactMessageText = message
		module.PlaySound(sound)
		fn48(0)

		if particles and not __wf_atom_7e8ad928(impactMessageParticleFX) then
			local rootBasedPosition, v97 = module2.GetRootBasedPosition(mMovie, "ImpactMessage")
			module2.CreateScreenParticles(mMovie, impactMessageParticleFX, rootBasedPosition, v97)
		end

		mMovie:__wf_atom_e57658c2("ImpactMessage", 12, 100)
		mMovie:__wf_atom_e57658c2("ImpactMessage", 5, transitionScale)
		mMovie:__wf_atom_e57658c2("ImpactMessage", 6, transitionScale)
	end

	local v97 = mMovie:DrawOverCinematics()

	if not __wf_atom_7e8ad928(drawOverCinematics) and v97 ~= drawOverCinematics then
		v38 = v97
		mMovie:__wf_atom_62d09591(drawOverCinematics)
	end

	SetImpactMessageText(message, localizeInputFilter, decoded2)
	FormatImpactMessageBacker()

	if not __wf_atom_7e8ad928(v37) then
		v2:RemoveTimer(v37)
		v37 = nil
	end

	fn47("ImpactMessage.Icon")
	__wf_atom_ec43d06e(mMovie, "ImpactMessage", 0, { fn48, 5, 6 }, { 1, scale, scale }, v96, 0, function()
		if duration >= 0 then
			v37 = v2:AddTimer(duration - 0.4, HideImpactMessage)
		end
	end)
end

function ShowImpactMessage(callback, duration, impactMessageSound2, p, p2, _, scale, transitionScale, drawOverCinematics, localizeInputFilter, withCountdown)
	if __wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(v12) then
		return
	end

	if type(callback) == "function" then
		callback = callback()
	end

	local message = ModifyControllerTag(callback)

	if duration >= 0 then
		duration = math.max(duration, 0.5)
	end

	if __wf_atom_7e8ad928(impactMessageSound2) then
		impactMessageSound2 = impactMessageSound
	end

	local particles = __wf_atom_7e8ad928(p) and true or p
	local v99 = WeakResource("/SF/Interface/HUD/Hud.swf")

	if not __wf_atom_7e8ad928(impactMessageSound2) then
		impactMessageSound2 = impactMessageSound2:__wf_atom_5b41f63b()
	end

	if not __wf_atom_7e8ad928(localizeInputFilter) then
		localizeInputFilter = localizeInputFilter:__wf_atom_5b41f63b()
	end

	local v100 = {
		Message = message,
		Duration = duration,
		Sound = impactMessageSound2,
		Particles = particles,
		LocalizationParameters = cjson.encode(p2),
		Frame = 1,
		Scale = scale,
		TransitionScale = transitionScale,
		DrawOverCinematics = drawOverCinematics,
		LocalizeInputFilter = localizeInputFilter,
		WithCountdown = withCountdown
	}
	v12:__wf_atom_b4984563(v99, "OnImpactMessageShown", { cjson.encode(v100) }, duration, "ImpactMessage")
end

function ShowImpactMessageHelper(p, p2, p3)
	ShowImpactMessage(p, tonumber(p2), nil, nil, nil, nil, nil, nil, nil, nil, p3 == "true")
end

function CreateNotificationParticles(p, p2)
	if not (_T.MinimalHud or v31.IsAlternateHud) then
		local v96 = Resource(p)
		local rootBasedPosition, v97 = module2.GetRootBasedPosition(mMovie, "Notification")
		module2.CreateScreenParticles(mMovie, v96, rootBasedPosition, v97 + p2)
	end
end

local function fn49(p)
	mMovie:__wf_atom_e57658c2("Notification.Title.Text", 77, p / 4)
	mMovie:__wf_atom_e57658c2("Notification.Title", 5, p / 2 + 100)
	mMovie:__wf_atom_e57658c2("Notification.Title", 6, p / 2 + 100)
end

local function fn50(p)
	mMovie:__wf_atom_1ca72041("Notification.Level.Text", "Dissolve", 1 - p, 0, 0, 0)
end

local function fn51(p, p2) -- 2 equivalent calls inferred from this helper
	mMovie:__wf_atom_1ca72041(p2, "Dissolve", p, 0, 0, 0)
end

local function fn52(p, p2)
	fn51(1 - p, p2) -- inferred equivalent call
end

local function fn53(p, p2, p3)
	local v96 = p2 and fn52 or fn51
	mMovie:__wf_atom_1ca72041(p, "Dissolve", p2 and 1 or 0, 0, 0, 0)
	__wf_atom_ec43d06e(mMovie, p, 2, { function(p4)
			v96(p4, p)
		end }, { 1 }, p3 * 2, 0)
end

function ShowNotification(p)
	local v96 = tonumber(p)
	mMovie:__wf_atom_e57658c2("Notification", 12, 100)
	mMovie:__wf_atom_e57658c2("Notification", 5, 100)
	mMovie:__wf_atom_e57658c2("Notification", 6, 100)
	mMovie:__wf_atom_e57658c2("Notification.Title.Text", 77, 0)
	mMovie:__wf_atom_e57658c2("Notification.Details2.Text", 12, 0)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Notification.Level.Text", 40)
	mMovie:__wf_atom_e57658c2("Notification.Level", 0, __wf_atom_5e6e15c8 / 20)
	fn51(1, "Notification.Level.Text") -- inferred equivalent call
	__wf_atom_ec43d06e(mMovie, "Notification.Level", 2, { fn50 }, { 2 }, 1.5, 0.1)
	__wf_atom_ec43d06e(mMovie, "Notification.Title", 2, { fn49 }, { 10 }, v96 + 0.5)
	fn53("Notification.Title.Text", true, 0.2)
	fn53("Notification.PactIcon", true, 0.42)
	fn53("Notification.CenterIcon", true, 0.42)
	fn53("Notification.IconBacker", true, 0.42)
	fn53("Notification.Subtitle.Text", true, 0.33)
	fn53("Notification.RankBacker", true, 0.42)
	fn53("Notification.PactTextBacker", true, 0.33)
	fn53("Notification.Bg.Mist", true, 0.42)
	fn53("Notification.VineDetails", true, 0.42)
	fn53("Notification.DarkeningBacker", true, 0.66)

	local function fn54()
		v12:__wf_atom_99407548(false)
		fn53("Notification.Level.Text", false, 0.5)
		fn53("Notification.Title.Text", false, 0.5)
		fn53("Notification.PactIcon", false, 0.5)
		fn53("Notification.CenterIcon", false, 0.5)
		fn53("Notification.IconBacker", false, 0.5)

		if mMovie:__wf_atom_387f260e("Notification.Details2.Text", 36) == "" then
			fn53("Notification.Subtitle.Text", false, 0.5)
		end

		fn53("Notification.Details2.Text", false, 0.5)
		fn53("Notification.RankBacker", false, 0.5)
		fn53("Notification.PactTextBacker", false, 0.5)
		fn53("Notification.Bg.Mist", false, 0.5)
		fn53("Notification.VineDetails", false, 0.5)
		fn53("Notification.DarkeningBacker", false, 0.5)
	end

	__wf_atom_86cbd68d(mMovie, "Notification.gotoAndPlay", 1)
	__wf_atom_ec43d06e(mMovie, "Notification", 0, {}, {}, 0, v96 / 2, function()
		if mMovie:__wf_atom_387f260e("Notification.Details2.Text", 36) ~= "" then
			mMovie:__wf_atom_e57658c2("Notification.Details2.Text", 12, 100)
			fn53("Notification.Subtitle.Text", false, 0.5)
			fn53("Notification.Details2.Text", true, 0.5)
		end

		__wf_atom_ec43d06e(mMovie, "Notification", 0, {}, {}, 0, v96 / 2, fn54)
	end)
end

function UpdateSparrowsTrackedQuest()
	if gRegion:IsMaster() then
		module8.UpdateSparrowDestination()
	end
end

function OnQuestStarted(p)
	module9.OnQuestStarted(p)
end

function OnTrackedJournalEntry()
	UpdateSparrowsTrackedQuest()
	module16.RefreshAncestorHudTrackers()
end

function ToggleChatWindow()
	local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("ToggleFocus", "")
	end
end

function ToggleQuestsJournal()
	local movie = __wf_atom_8e4fda44:FindMovie(questsJournalMovie)

	if __wf_atom_7e8ad928(movie) then
		__wf_atom_8e4fda44:__wf_atom_8b74c30b(questsJournalMovie)
	else
		movie:Execute("AdvanceAndShutdown", nil)
	end
end

function ToggleInventory()
	if _T.InventoryOpen then
		module7.CloseInventory()
	else
		module7.OpenInventory(mMovie)
	end
end

function NotifyAbilityActivate(p, p2, p3)
	v55:PulseControl(tostring(p), p2 == "true", p3 == "true")
end

function NotifyAbilityActivateError() end

function IsNightfoldAlertActive()
	return v70
end

function InitializeNightfold()
	mMovie:OverrideMaterial("Nightfold.Bg", nightfoldBgMaterial)
	mMovie:OverrideMaterial("Nightfold.Bg.Mist", nightfoldMistMaterial)
	mMovie:__wf_atom_e57658c2("Nightfold.Glow", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Nightfold.Glow", 12, 60)
	mMovie:__wf_atom_e57658c2("Nightfold.CircleBg", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Nightfold.CircleBg", 12, 45)
	mMovie:OverrideMaterial("Nightfold.ProgressFill", nightfoldProgressMaterial)
	mMovie:__wf_atom_e57658c2("Nightfold.ProgressBg", 12, 10)
	mMovie:__wf_atom_e57658c2("Nightfold", 12, 0)
end

function UpdateNightfold()
	local v96, v97

	if __wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled() then
		v96 = false
		v97 = 0
	else
		local __wf_atom_737fd2c9 = playerAvatar:__wf_atom_737fd2c9(9)
		v97 = playerAvatar:__wf_atom_92aa9d91():__wf_atom_86618c58()

		if __wf_atom_737fd2c9 or v97 < 1 then
			v96 = playerAvatar:__wf_atom_92aa9d91():__wf_atom_722edb11()
		else
			v96 = false
		end

		if v96 or __wf_atom_737fd2c9 then
			mMovie:__wf_atom_1ca72041("Nightfold.ProgressFill", "AlphaTestThreshold", v97, 0, 0, 0)
		end

		if __wf_atom_737fd2c9 then
			return
		end
	end

	if v96 ~= v70 then
		if v96 then
			v71 = module.PlaySound(nightfoldHoldStartSound)
			mMovie:__wf_atom_e57658c2("Nightfold", 12, 60)
			__wf_atom_ec43d06e(mMovie, "Nightfold", 8, { 12 }, { 100 }, 0.25)
		elseif v97 == 1 then
			mMovie:__wf_atom_e57658c2("Nightfold", 12, 0)
		else
			__wf_atom_ec43d06e(mMovie, "Nightfold", 8, { 12 }, { 0 }, 0.25)

			if not __wf_atom_7e8ad928(v71) then
				v71:Stop(false)
			end
		end

		v70 = v96
	end
end

function OnHealthRegainFromAttacks()
	module.PlaySound(healthRegainedSound)
end

function OnSettingsSaved()
	if not __wf_atom_7e8ad928(v55) then
		v55:OnControlsChanged()
	end
end

function CommonResourcesReady()
	FormatImpactMessageBacker()
end

function OnInvitePlayer(p)
	if _T.ShowNotification ~= nil then
		_T.ShowNotification(p, "SquadMemberInvited")
	end
end

function InvitePlayer()
	if not __wf_atom_7e8ad928(mAvatar) then
		local v96 = mAvatar
		local v97

		if not __wf_atom_7e8ad928(v96) then
			v97 = gGameRules:__wf_atom_70f5d0a5(v96)

			if #v97 == 0 then
				local __wf_atom_9c7c90fb = gMatchingService:__wf_atom_9c7c90fb()

				if not __wf_atom_7e8ad928(__wf_atom_9c7c90fb) then
					v97 = __wf_atom_9c7c90fb:__wf_atom_70f5d0a5(v96)
				end
			end
		end

		gMatchingService:__wf_atom_b83bc045(
			v97,
			mAvatar:__wf_atom_818ea3a7(),
			module18.GetSquadMissionForInvite(),
			"OnInvitePlayer"
		)
	end

	mAvatar = nil
end

function OnInvitePlayerPressed(p)
	if tonumber(p) ~= 4 then
		mAvatar = nil
	elseif not __wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761())) then
		InvitePlayer()
	elseif
		__wf_atom_7e8ad928(gGameRules)
		or not (gGameRules:IsA(__wf_atom_589d05aa) and gGameRules:__wf_atom_72fc675e().soloMode)
	then
		module18.HostSquadSession("InvitePlayer")
	else
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GameInvitesDisabled", false))
	end
end

function OnInspect()
	if not (_T.EtherealHubActive or gGameRules:__wf_atom_95862cc1()) then
		return
	end

	local __wf_atom_9eeb9a68 = v12:__wf_atom_9eeb9a68()

	if
		not __wf_atom_7e8ad928(__wf_atom_9eeb9a68)
		and __wf_atom_9eeb9a68.mActive
		and __wf_atom_9eeb9a68.mName ~= module2.HIDDEN_PLAYER_NAME
	then
		mAvatar = __wf_atom_9eeb9a68.mAvatar

		if not __wf_atom_7e8ad928(mAvatar) and mAvatar == mAvatar2 then
			local v96 = mAvatar
			local v97

			if not __wf_atom_7e8ad928(v96) then
				v97 = gGameRules:__wf_atom_70f5d0a5(v96)

				if #v97 == 0 then
					local __wf_atom_9c7c90fb = gMatchingService:__wf_atom_9c7c90fb()

					if not __wf_atom_7e8ad928(__wf_atom_9c7c90fb) then
						v97 = __wf_atom_9c7c90fb:__wf_atom_70f5d0a5(v96)
					end
				end
			end

			if #v97 > 0 then
				local __wf_atom_9c7c90fb = gMatchingService:__wf_atom_9c7c90fb()
				local __wf_atom_818ea3a7 = mAvatar:__wf_atom_818ea3a7()

				if
					not __wf_atom_7e8ad928(__wf_atom_9c7c90fb)
					and __wf_atom_9c7c90fb:__wf_atom_3179c2db(__wf_atom_818ea3a7)
				then
					local __wf_atom_6551a62d = __wf_atom_9c7c90fb:__wf_atom_6551a62d(__wf_atom_818ea3a7)
					local dialogGridItems = {}

					for _, v99 in {
						{
							loadout = 0,
							skins = { 4, 0, 2, 3 }
						},
						{ loadout = 3 },
						{ loadout = 2 },
						{ loadout = 0 },
						{
							loadout = 0,
							skins = { 5 }
						}
					} do
						local customization = v99.customization

						if customization == nil then
							local mItem = __wf_atom_6551a62d:__wf_atom_d21f18f2(0, v99.loadout).mItem

							if mItem and v99.skins == nil then
								table.insert(dialogGridItems, mItem)
							end

							customization = mItem:__wf_atom_eb82ab1f()
							v99.customization = customization
						end

						for _, skin in v99.skins do
							local __wf_atom_d78fd481 = customization:__wf_atom_d78fd481(skin)

							if
								__wf_atom_7e8ad928(__wf_atom_d78fd481.mItemType)
								or __wf_atom_7e8ad928((WeakResource(__wf_atom_d78fd481.mItemType)))
							then
								continue
							end

							table.insert(dialogGridItems, __wf_atom_d78fd481)
						end
					end

					_T.DialogGridItems = dialogGridItems
					_T.DialogGridItemOwner = __wf_atom_9eeb9a68.mAvatar
					module.ShowTwoOptionMessage(
						"",
						"OnInvitePlayerPressed",
						nil,
						__wf_atom_818ea3a7 .. " <LEAF_YELLOW>" .. __wf_atom_6551a62d.mPlayerLevel,
						"/SF/Language/Social/Invite",
						"/Menu/Confirm_Item_Cancel"
					)
				end
			end
		end
	end
end

function PetStatsChanged(value)
	if __wf_atom_7e8ad928(v7) or __wf_atom_7e8ad928(v8) then
		return
	end

	local __wf_atom_e919fb8e = v7:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.PlayerWolfAvatar) then
		return
	end

	local __wf_atom_e55d02aa = __wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local v96 = string.split(value)
	local flag4 = false
	local v97 = 0
	local v98 = false

	for i = 1, #v96, 3 do
		v97 = tonumber(v96[i])
		local v99 = tonumber(v96[i + 1])
		local v100 = tonumber(v96[i + 2])

		if v97 == 8 then
			local __wf_atom_046929a0 = __wf_atom_e55d02aa:__wf_atom_046929a0(v99)

			if __wf_atom_e55d02aa:__wf_atom_046929a0(v100) < __wf_atom_046929a0 then
				local __wf_atom_4febbf37 = v8:__wf_atom_4febbf37()
				local mDescription = Localize(__wf_atom_4febbf37.mName, false)
				local __wf_atom_301e8d97 = v8:__wf_atom_301e8d97()

				if not __wf_atom_7e8ad928(__wf_atom_301e8d97) then
					local levelUpInfo = SF.LevelUpInfo()
					levelUpInfo.mTitle = Localize("/SF/Language/Pacts/BondNum", {
						NUMBER = __wf_atom_046929a0
					})
					levelUpInfo.mDescription = mDescription
					levelUpInfo.mItem = __wf_atom_e55d02aa
					__wf_atom_301e8d97:__wf_atom_258c05b2(levelUpInfo)
				end
			end
		else
			v98 = __wf_atom_e55d02aa:__wf_atom_82b1de4f(v99) > __wf_atom_e55d02aa:__wf_atom_82b1de4f(v100)
		end

		flag4 = true
	end

	if flag4 then
		local v99 = __wf_atom_e919fb8e.PlayerWolfAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(
			100,
			237,
			__wf_atom_e55d02aa:__wf_atom_1bb5b1ff(),
			__wf_atom_e55d02aa
		) > 100

		if not __wf_atom_7e8ad928(v95) then
			local movie = __wf_atom_8e4fda44:FindMovie(v95)

			if not __wf_atom_7e8ad928(movie) then
				movie:Execute("OnPetStatIncreased", v97 .. "," .. tostring(v98) .. "," .. tostring(v99))
			end
		end
	end
end