local v = nil
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("SF.Interface.SFUtilities")
local module5 = require("SF.Interface.Libs.OdeCipher")
local module6 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module7 = require("SF.Scripts.Libs.TaleLib")
local module8 = require("SF.Scripts.Libs.EncounterLib")
require("SF.Scripts.Libs.QuestLib")
local module9 = require("SF.Scripts.Prototypes.FastTravel")
local module10 = require("EE.Interface.AnchorMgr")
local v2 = nil
local v3 = nil
local flag = true
local flag2 = false
local v4 = false
local playerAvatar = nil
local v5 = nil
local v6 = 1
local v7 = 0
local v8 = true
local v9 = nil
local v10 = false
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = { x = 0, y = 0 }
local v15 = nil
local v16 = __wf_atom_10cd16b2(2, 0.175)
local v17 = 0.5
local v18 = true
local v19 = { x = 0, y = 0 }
local v20 = 0
local v21 = nil
local v22 = nil
local v23 = nil
local flag3 = false
local total = 0
local v24 = nil
local v25 = nil
local v26 = nil
local v27 = Vector()
local v28 = Vector()
local v29 = {
	IsVisible = Engine.IsPlayingWithController(),
	X = 0,
	Y = 0
}
local v30 = false
local v31 = Symbol("SquareCenter")
local v32 = Symbol("SquareSize")
local v33 = Symbol("SquareFadeSize")
Symbol("TileOffset")
local v34 = Symbol("TileRepeats")
local focusCodexTab = Symbol("Locations")
local v36 = 0.0025
local v37 = 1
local v38 = false
local v39 = __wf_atom_10cd16b2(0, 0.25)
local v40 = __wf_atom_10cd16b2(0, 0.25)
local v41 = nil
local v42 = 0
local v43 = 0
local v44 = 0
local v45 = 0
local v46 = nil
local v47 = nil
local focusMapMarker = nil
local x = 1
local total2 = 0
local v48 = {}
local v49 = -1

local function fn(p)
	if not __wf_atom_7e8ad928(focusMapMarker) then
		total2 += p
		local v50 = math.abs(__wf_atom_4658d645(total2 * 1) * 2 - 1)
		local v51 = __wf_atom_24a82b69(v50)
		local v52 = __wf_atom_104bfe98(x, x * 1.2, v51)
		focusMapMarker:__wf_atom_f6b21aac(v52)
	end
end

local function fn2()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()
	return not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) and __wf_atom_2ad5cd23:__wf_atom_6d61d595() == topMenuMovie
end

local function fn3()
	mMovie:__wf_atom_e57658c2("MiniMapContainer", 0, v11 / 2)
	mMovie:__wf_atom_e57658c2("MiniMapOverlayMsg", 0, v11 / 2)
end

local function fn4(p, p2)
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(p, p2)
	end

	v11 = mMovie:__wf_atom_97cd8326()
	v12 = mMovie:__wf_atom_54eeda24()
	local screenDimensions, v50 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("Blurer", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("Blurer", 15, v50)
	mMovie:__wf_atom_e57658c2("Border", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("Border", 15, v50)
	mMovie:__wf_atom_e57658c2("Backer", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("Backer", 15, v50)
	mMovie:__wf_atom_e57658c2("Vignette", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("Vignette", 15, v50)
	fn3()
	module.ScaleSlicedMaterials(mMovie, { mapBorderMaterial })
end

function onViewportSizeChanged(p, p2)
	fn4(p, p2)
end

local function fn5(isVisible)
	v29.IsVisible = isVisible
	mMovie:__wf_atom_2dedec1a("Reticle", 13, isVisible)
	mMovie:__wf_atom_fbca497c(not isVisible)

	if not __wf_atom_7e8ad928(_T.ShowButtonBarCursor) then
		_T.ShowButtonBarCursor(not isVisible)
	end

	if isVisible and not (__wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7())) then
		gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(
			mMovie:__wf_atom_d5a50cb5() / 2,
			mMovie:__wf_atom_c4f6543f() / 2
		)
	end
end

local function fn6(playerAvatar2)
	if playerAvatar2:__wf_atom_7b82e9e1(0) then
		v7 -= __wf_atom_084b3e93()
	else
		v7 += __wf_atom_084b3e93()
	end

	v7 = __wf_atom_421b01aa(v7, 0, 1)
end

local function fn7(p)
	v21 = module.CreateUIParticles(
		mMovie,
		"MiniMapContainer.MiniMapMarkers.PlayerArrow",
		playerPulseFx,
		0,
		0,
		__wf_atom_392793db
	)

	if not (__wf_atom_7e8ad928(v21) or __wf_atom_7e8ad928(v21.mInstance)) then
		local v50 = mMovie:__wf_atom_5e6e15c8("MiniMapContainer.MiniMapMarkers.PlayerArrow", 16) / 180
		v21.mInstance:__wf_atom_de8fbee6(v50, v50)
	end

	if p and tonumber(p) > 0 then
		v3:AddTimer(0.8, fn7, false, p - 1)
	end
end

local function fn8()
	flag = false
	fn7(1)
end

local function fn9()
	if v15 and not __wf_atom_7e8ad928(v5) then
		local __wf_atom_afb5740a = v5:__wf_atom_afb5740a()
		local v50 = v18
		local v51 = v27 ~= v28 or v50
		local v52 = (v27.x - v24.x) / (v25.x - v24.x)
		local v53 = (v27.z - v24.z) / (v25.z - v24.z)
		local v54 = v26.x * __wf_atom_afb5740a
		local v55 = v26.z * __wf_atom_afb5740a
		v15.mMin.x = -v54 * (1 - v52)
		v15.mMax.x = v54 * v52
		v15.mMin.y = -v55 * v53
		v15.mMax.y = v55 * (1 - v53)

		if v15.mMin.x > v15.mMax.x then
			local x2 = v15.mMin.x
			v15.mMin.x = v15.mMax.x
			v15.mMax.x = x2
		end

		if v15.mMin.y > v15.mMax.y then
			local y = v15.mMin.y
			v15.mMin.y = v15.mMax.y
			v15.mMax.y = y
		end

		v15.mScrollRange.x = v15.mMin.x - v15.mMax.x
		v15.mScrollRange.y = v15.mMin.y - v15.mMax.y
		local v56 = v15.mMax.y - v15.mMin.y
		local v57 = v15.mMax.x - v15.mMin.x
		local v58 = __wf_atom_421b01aa(
			module.Ternary(v56 ~= 0, 1 - (v15.mCurrentCoords.y - v15.mMin.y) / v56, 1),
			0 - v15.mLeeway.y,
			1 + v15.mLeeway.y
		)
		local v59 = __wf_atom_421b01aa(
			module.Ternary(v57 ~= 0, 1 - (v15.mCurrentCoords.x - v15.mMin.x) / v57, 1),
			0 - v15.mLeeway.x,
			1 + v15.mLeeway.x
		)
		v15:SetScroll("x", v59, nil, v51)
		v15:SetScroll("y", v58, nil, v51)
		v18 = false
	end
end

local function fn10()
	local envoyInventoryControl = module4.GetEnvoyInventoryControl()

	if __wf_atom_7e8ad928(envoyInventoryControl) then
		return false
	end

	return (envoyInventoryControl:__wf_atom_ff0dc264(bromiusCompletedFragment))
end

local function fn11()
	if __wf_atom_7e8ad928(v5) then
		return
	end

	local v50 = nil

	if __wf_atom_7e8ad928(v22) then
		if __wf_atom_7e8ad928(_T.FocusCodexEntry) then
			if not __wf_atom_7e8ad928(_T.FocusMapMarker) then
				local __wf_atom_c0ec6f07 = v5:__wf_atom_c0ec6f07(_T.FocusMapMarker)
				v15.mCurrentCoords.x = -__wf_atom_c0ec6f07.x
				v15.mCurrentCoords.y = __wf_atom_c0ec6f07.y

				if not __wf_atom_7e8ad928(focusMapMarker) then
					focusMapMarker:__wf_atom_f6b21aac(x)
				end

				focusMapMarker = _T.FocusMapMarker
				x = focusMapMarker:__wf_atom_bcaaaa6a().x
				_T.FocusMapMarker = nil
			end
		else
			v50 = v5:__wf_atom_88eea4f9(_T.FocusCodexEntry)
			focusMapMarker = v50.mEntity

			if focusMapMarker ~= nil then
				x = focusMapMarker:__wf_atom_bcaaaa6a().x
			end
		end
	else
		v50 = v5:__wf_atom_625af973(v22:GetClipName())
	end

	if v50 and v50.mVisible then
		v15.mCurrentCoords.x = -v50.mRelativePositionInPixels.x
		v15.mCurrentCoords.y = v50.mRelativePositionInPixels.y
	end

	if _T.FocusMapOffset ~= nil then
		v15.mCurrentCoords.x += _T.FocusMapOffset.x
		v15.mCurrentCoords.y += _T.FocusMapOffset.y
		_T.FocusMapOffset = nil
	end
end

local function fn12(p)
	v15.mCurrentCoords.x = __wf_atom_104bfe98(v15.mInitialCoords.x, v15.mTargetCoords.x, p)
	v15.mCurrentCoords.y = __wf_atom_104bfe98(v15.mInitialCoords.y, v15.mTargetCoords.y, p)
end

local function fn13()
	v15.mInitialCoords = { x = v15.mCurrentCoords.x, y = v15.mCurrentCoords.y }
	fn11()
	v15.mTargetCoords = v15.mCurrentCoords
	v15.mCurrentCoords = { x = v15.mInitialCoords.x, y = v15.mInitialCoords.y }
	__wf_atom_ec43d06e(mMovie, "fake_clip", 8, { fn12 }, { 1 }, 0.65, 0, function()
		v15.mCurrentCoords = v15.mTargetCoords
	end)
end

function FocusMapLocation(p, p2)
	if __wf_atom_7e8ad928(v5) then
		return
	end

	if module.Ternary(p2 == "true", true, false) then
		local focusMapMarker2 = _T.FocusMapMarker

		if focusMapMarker2 ~= nil then
			local __wf_atom_cf1a5059 = focusMapMarker2:__wf_atom_cf1a5059()
			playerAvatar:__wf_atom_4ec993ab(__wf_atom_cf1a5059.x, __wf_atom_cf1a5059.z)
		end
	end

	if p then
		fn13()
	else
		fn11()
	end

	if not __wf_atom_7e8ad928(_T.FocusCodexEntry) then
		v5:__wf_atom_1893acae(v15.mCurrentCoords.x, v15.mCurrentCoords.y, v16.mCurVal, v17, 4)
	end
end

local function fn14(p)
	for _, v50 in gRegion:FindAll(allMapMarkers) do
		if p then
			v50:Enable()
		else
			v50:Disable()
		end
	end
end

local function fn15(_)
	for _, v50 in gRegion:FindAll(minibossMarkers) do
		local __wf_atom_e919fb8e = v50:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(v50) then
			continue
		end

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e) or __wf_atom_e919fb8e.UpdateStatus == nil then
			v50:Disable()
		else
			__wf_atom_e919fb8e.UpdateStatus()
		end
	end
end

local function fn16()
	for _, v50 in gRegion:FindAll(locationAreaMarkers) do
		local __wf_atom_366ba480 = v50:__wf_atom_366ba480()

		if
			v50:IsA(siegeAreaMarkers)
			or __wf_atom_7e8ad928(__wf_atom_366ba480)
			or __wf_atom_366ba480:__wf_atom_7188fa33()
		then
			continue
		end

		local envoyInventoryControl = module4.GetEnvoyInventoryControl()

		if __wf_atom_7e8ad928(envoyInventoryControl) then
			continue
		end

		local __wf_atom_3563f9c2 = __wf_atom_366ba480:__wf_atom_3563f9c2()

		if __wf_atom_3563f9c2 <= math.min(
			envoyInventoryControl:__wf_atom_96a19f31(__wf_atom_366ba480),
			__wf_atom_3563f9c2
		) then
			v50:SetIcon(completeLocationMarkerIcon)
		end
	end
end

local function fn17()
	for _, v50 in gRegion:FindAll(siegeAreaMarkers) do
		if v50 == nil then
			continue
		end

		local __wf_atom_e919fb8e = v50:__wf_atom_e919fb8e()

		if __wf_atom_e919fb8e.UpdateStatus ~= nil then
			__wf_atom_e919fb8e.UpdateStatus()
		end
	end
end

local function fn18()
	for _, v50 in gRegion:FindAll(treeMarkers) do
		if CanTeleport() then
			v50:SetIcon(treeTeleportAcornIcon)
		else
			v50:SetIcon(treeIcon)
		end
	end
end

local function fn19()
	local envoyInventoryControl = module4.GetEnvoyInventoryControl()

	if __wf_atom_7e8ad928(envoyInventoryControl) then
		return false
	end

	for _, v50 in gRegion:FindAll(dungeonMarkers) do
		if envoyInventoryControl:__wf_atom_ff0dc264((v50:__wf_atom_366ba480())) then
			v50:Enable()
		else
			v50:Disable()
		end
	end
end

local function fn20()
	local playerFaction = module7.GetPlayerFaction()

	for _, v50 in gRegion:FindAll(factionAreaMarkers) do
		local __wf_atom_e919fb8e = v50:__wf_atom_e919fb8e()
		local faction = __wf_atom_e919fb8e.faction
		local originalIcon = __wf_atom_e919fb8e.originalIcon

		if faction == playerFaction then
			v50:__wf_atom_f6b21aac(3)

			if CanTeleport() then
				if faction == Symbol("SilentRoseSyndicate") then
					originalIcon = silentRoseAcornIcon
				elseif faction == Symbol("FeySyndicate") then
					originalIcon = alcaChildrenAcornIcon
				elseif faction == Symbol("ChampionSyndicate") then
					originalIcon = kithOfKingsAcornIcon
				end
			end

			v50:SetIcon(originalIcon)
		else
			v50:__wf_atom_f6b21aac(2)
			v50:SetIcon(completeLocationMarkerIcon)
		end
	end
end

local function fn21(position)
	if __wf_atom_7e8ad928(worldTreeDensityVolume) then
		return 0
	end

	return worldTreeDensityVolume:GetColor(position, false).red
end

local function fn22(_)
	for _, v50 in gRegion:FindAll(allMapMarkers) do
		if not v50:IsEnabled() or v50:__wf_atom_cb46d52c() then
			continue
		end

		local v51 = bit32.lshift(1, fn21(v50:GetPosition()) - 1)

		if bit32.band(v42, v51) ~= 0 then
			continue
		end

		print("hiding ", v50:__wf_atom_5b41f63b())
		v50:Disable()
	end
end

local function fn23()
	return not __wf_atom_7e8ad928(v5) and v5:__wf_atom_bf66310e()
end

local function fn24()
	if fn23() and module6.IsInOverworld() then
		fn14(false)
		fn15(false)
	elseif module8.IsHardModeActive() then
		fn14(false)
		fn15(true)
	else
		fn14(true)
		fn15(false)
		fn16()
		fn20()
		fn18()
		fn19()
		fn17()
		fn22()
	end
end

local function fn25()
	v10 = false
	flag2 = false

	if not __wf_atom_7e8ad928(v5) then
		fn24()
		v5:__wf_atom_e6bd35b0(true)
		v5:__wf_atom_e29da7c3(true)
		v5:__wf_atom_9cd68098(true)

		if v15 then
			fn11()
			v5:__wf_atom_1893acae(v15.mCurrentCoords.x, v15.mCurrentCoords.y, v16.mCurVal, v17, 4)
		end
	end

	module.PlaySound(mapOpenSound)
	AddMixEffect()
	_T.OverlayMapVisible = true
	v8 = true
	mMovie:__wf_atom_290807ee("_root")
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12, 4 }, { 100, 0 }, 0.2, 0, fn8)
end

local function fn26()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v6 = __wf_atom_18a5d83b:Settings():__wf_atom_2e625b82()
	end
end

function OnProfileSaved()
	fn26()
end

local function fn27()
	v29.X = module.Round(v11 / 2)
	v29.Y = module.Round(v12 / 2)
	mMovie:__wf_atom_e57658c2("Reticle", 0, v29.X)
	mMovie:__wf_atom_e57658c2("Reticle", 1, v29.Y)
	mMovie:__wf_atom_2dedec1a("Reticle", 13, v29.IsVisible)
end

local function fn28()
	local v50 = mMovie:__wf_atom_d5a50cb5() / mMovie:__wf_atom_c4f6543f() / (v11 / v12)

	if fn23() then
		v17 = 1 / (v5:__wf_atom_afb5740a() * (v25.z - v24.z) / v12) / math.min(1, v50) * (1 / v6)
	else
		v17 = 1 / (v5:__wf_atom_afb5740a() * (v25.z - v24.z - 200) / v12) / math.min(1, v50) * (1 / v6)
	end

	v16:__wf_atom_4453e49c(v17)
	v18 = true
	_T.NeedMapZoomUpdate = nil
end

local function fn29()
	v41 = v5:__wf_atom_6b868c2f()

	if fn23() then
		v24 = {
			x = v41:__wf_atom_c9d0fea6() - 100,
			y = v41:__wf_atom_ccf700a6(),
			z = v41:__wf_atom_c384faa6() - 100
		}
		v25 = {
			x = v41:__wf_atom_152cb4a3() + 100,
			y = v41:__wf_atom_1852b6a3(),
			z = v41:__wf_atom_1b78b8a3() + 100
		}
	else
		v24 = {
			x = v41:__wf_atom_c9d0fea6() - 250,
			y = v41:__wf_atom_ccf700a6(),
			z = v41:__wf_atom_c384faa6() - 200
		}
		v25 = {
			x = v41:__wf_atom_152cb4a3() + 350,
			y = v41:__wf_atom_1852b6a3(),
			z = v41:__wf_atom_1b78b8a3() + 200
		}
	end

	v24 = {
		x = v41:__wf_atom_c9d0fea6(),
		y = v41:__wf_atom_ccf700a6(),
		z = v41:__wf_atom_c384faa6()
	}
	v25 = {
		x = v41:__wf_atom_152cb4a3(),
		y = v41:__wf_atom_1852b6a3(),
		z = v41:__wf_atom_1b78b8a3()
	}
	v26 = {
		x = v25.x - v24.x,
		y = v25.y - v24.y,
		z = v25.z - v24.z
	}
	local v50 = mMovie:__wf_atom_d5a50cb5() / mMovie:__wf_atom_c4f6543f() / (v11 / v12)
	v17 = 1 / (v5:__wf_atom_afb5740a() * (v25.z - v24.z - 0) / v12) / math.min(1, v50) * (1 / v6)
	v16:__wf_atom_4453e49c((math.max(v17, 1)))
	fn27()
	v3:AddTimer(playerPulseInterval, fn7, true, 1)
	v5:__wf_atom_d2c76857()

	if #tacticalRequiredTags > 0 then
		v5:__wf_atom_4f416771(tacticalRequiredTags)
	end

	if #tacticalExcludeTags > 0 then
		v5:__wf_atom_9ba6987e(tacticalExcludeTags)
	end

	v5:__wf_atom_2889d69a(true)

	if module6.IsInOverworld() and not fn23() then
		v36 = 0.0025
		v37 = 1
	else
		v36 = 0.02
		v37 = 0.5
	end
end

function GetTranslatedWorldCoordinates(p, p2)
	local mCurVal = v16.mCurVal
	local v50 = v5:__wf_atom_afb5740a() * mCurVal
	local mWorldPosition = _T.mWorldPosition

	if not __wf_atom_7e8ad928(playerAvatar) then
		if playerAvatar:__wf_atom_799d95f5() then
			mWorldPosition = playerAvatar:__wf_atom_4c2e0189()
		else
			mWorldPosition = playerAvatar:GetPosition()
		end
	end

	return
		mWorldPosition.x + (p - v11 / 2 - v15.mCurrentCoords.x * mCurVal) / v50,
		mWorldPosition.z - (p2 - v12 / 2 - v15.mCurrentCoords.y * mCurVal) / v50
end

local function fn30()
	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()

		if not (__wf_atom_7e8ad928(__wf_atom_e23b2855) or __wf_atom_7e8ad928(__wf_atom_e23b2855[1])) then
			playerAvatar = __wf_atom_e23b2855[1]:__wf_atom_50a7d83e()
		end
	end

	if __wf_atom_7e8ad928(playerAvatar) then
		print("ERROR: No avatar found!")
		assert(false)
	end

	fn26()

	if __wf_atom_7e8ad928(__wf_atom_a0f6588f) or __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		print("InitOnValidAvatarPlayer: no playerProfile")
	else
		__wf_atom_55142dd4(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01(), "OnProfileSaved")
	end

	fn3()
	v5 = playerAvatar:__wf_atom_a96eb2aa():__wf_atom_cca6e0bc()
	fn29()
	fn9()
	fn25()
	v5:__wf_atom_2889d69a(true)
	v4 = true
end

local function fn31()
	if not __wf_atom_7e8ad928(_T.MapContextAction) then
		_T.MapContextAction:Enable()
		_T.MapContextAction = nil
	end

	if _T.OnCloseMap then
		_T.OnCloseMap()
		_T.OnCloseMap = nil
	end

	if not fn2() then
		mMovie:Close()
	end

	if not __wf_atom_7e8ad928(focusMapMarker) then
		focusMapMarker:__wf_atom_f6b21aac(x)
	end
end

local function fn32()
	mMovie:__wf_atom_c884ca43(false)
	fn3()
	print("Map opened in advanced mode")

	if not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			v9 = __wf_atom_eab484a7:__wf_atom_330f77f5()
		end
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:__wf_atom_8175b5c4(false)
	end

	fn5(Engine.IsPlayingWithController())

	if not __wf_atom_7e8ad928(v5) then
		fn29()
	end

	local module11 = require("EE.Interface.Components.DragScroll")
	v15 = module11.Create(mMovie, "Board", -500, -500, 500, 500)
	v15.mLeeway = { x = 0, y = 0 }
	fn9()
	mMovie:__wf_atom_290807ee("MapHint")
	__wf_atom_ec43d06e(mMovie, "MapHint", 8, { 12 }, { 0 }, 0.3)
	UpdateButtons()
	mMovie:__wf_atom_2dedec1a("Reticle", 13, v29.IsVisible)
	__wf_atom_ec43d06e(mMovie, "TimeOfDay", 8, { 12 }, { 100 }, 0.3)
	__wf_atom_ec43d06e(mMovie, "Blurer", 8, { 12 }, { 100 }, 0.3)
end

function CanTeleport(instance)
	if (_T.BlockFastTravel or 0) > 0 then
		return false
	end

	local v50

	if instance == nil or not instance:IsA(factionAreaMarkers) then
		v50 = true
	else
		local playerFaction = module7.GetPlayerFaction()
		v50 = instance:__wf_atom_e919fb8e().faction == playerFaction
	end

	local v51

	if __wf_atom_7e8ad928(playerAvatar) then
		v51 = false
	else
		v51 = playerAvatar == gRegion:__wf_atom_c4f78a8f()
	end

	local v52 = not __wf_atom_7e8ad928(playerAvatar) and playerAvatar:__wf_atom_799d95f5()
	return v45 > 0
		and v51
		and v50
		and fn10()
		and not v52
		and not (module6.PlayerIsInBattle(playerAvatar) or module9.IsFastTravelInProgress())
end

function InitializeMapHold()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			for i = 0, __wf_atom_d2b2176d:__wf_atom_62abd325() - 1 do
				local __wf_atom_ba1c3957 = __wf_atom_d2b2176d:__wf_atom_ba1c3957(i)

				if __wf_atom_7e8ad928(__wf_atom_ba1c3957) or not __wf_atom_ba1c3957:IsA(teleportItemType) then
					continue
				end

				v46 = i
				v45 = __wf_atom_d2b2176d:__wf_atom_b62f2024(v46)
				break
			end
		end
	end

	local v50 = fn10()
	mMovie:__wf_atom_2dedec1a("Currency", 13, v50)
	mMovie:__wf_atom_2dedec1a("MapHold", 13, v50)

	if v50 then
		local uiColor_Red = _G.UIColor_Red
		mMovie:__wf_atom_50d60589("Currency.Icon", 36, mMovie:__wf_atom_8e9ac384("<CURRENCY_TELEPORT>", true))
		mMovie:__wf_atom_50d60589("Currency.Value", 36, v45)
		mMovie:__wf_atom_e57658c2("Currency.Value", 11, _G.UIColor_Beige)
		mMovie:__wf_atom_e57658c2("MapHold.Glow", 11, 2825751)
		mMovie:__wf_atom_e57658c2("MapHold.Glow", 12, 60)
		mMovie:__wf_atom_e57658c2("MapHold.CircleBg", 11, 2825751)
		mMovie:__wf_atom_e57658c2("MapHold.CircleBg", 12, 45)
		mMovie:OverrideMaterial("MapHold.ProgressFill", mapHoldProgressMaterial)
		mMovie:__wf_atom_e57658c2("MapHold.ProgressBg", 11, uiColor_Red)
		mMovie:__wf_atom_e57658c2("MapHold.ProgressBg", 12, 10)
		mMovie:__wf_atom_e57658c2("MapHold", 12, 0)
	end
end

function Initialize()
	v11 = mMovie:__wf_atom_97cd8326()
	v12 = mMovie:__wf_atom_54eeda24()
	local module11 = require("Lotus.Interface.Libs.TimerMgr")
	v3 = module11.CreateTimerMgr()
	v2 = module10.Create(mMovie)
	v2:Register(mMovie, "Currency", { v2.ANCHOR_V_BOTTOM, v2.ANCHOR_H_LEFT })
	v2:Register(mMovie, "TimeOfDay", { v2.ANCHOR_V_BOTTOM, v2.ANCHOR_H_LEFT })
	v2:Register(mMovie, "MapHint", { v2.ANCHOR_V_BOTTOM, v2.ANCHOR_H_CENTRE })
	v2:Register(mMovie, "Compass", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_RIGHT })
	v2:Register(mMovie, "Border", { v2.ANCHOR_V_CENTRE, v2.ANCHOR_H_CENTRE })
	v2:Register(mMovie, "Banner", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_LEFT })
	v2:Register(mMovie, "Backer", { v2.ANCHOR_V_CENTRE, v2.ANCHOR_H_CENTRE })
	v2:Register(mMovie, "Vignette", { v2.ANCHOR_V_CENTRE, v2.ANCHOR_H_CENTRE })
	v2:Register(mMovie, "Warning", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_RIGHT })
	mMovie:__wf_atom_c884ca43(true)
	mMovie:__wf_atom_50d60589("Banner.TitleText", 36, Localize("/SF/Language/Locations/Midrath", nil))
	mMovie:OverrideMaterial("Border", mapBorderMaterial)
	mMovie:OverrideMaterial("Backer", mapBackerMaterial)
	mMovie:OverrideMaterial("Vignette", mapVignetteMaterial)
	mMovie:__wf_atom_e57658c2("Vignette", 11, _G.UIColor_DarkerBrown)
	mapVignetteMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, 0.5)
	mapVignetteMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, 0.6)
	mapVignetteMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, 0.2)
	mapVignetteMaterial:__wf_atom_a042ff6c(Symbol("Dissolve"), -1)
	mapVignetteMaterial:__wf_atom_a042ff6c(SF.__wf_atom_05c75cda, 1, 1)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("_root", 4, -15000)
	mMovie:__wf_atom_e57658c2("Compass", 11, _G.UIColor_Tan)
	mMovie:__wf_atom_2dedec1a("Reticle", 13, false)
	mMovie:__wf_atom_e57658c2("TimeOfDay", 12, 0)
	mMovie:__wf_atom_e57658c2("Blurer", 12, 0)
	fn5(v29.IsVisible)
	mMovie:__wf_atom_e57658c2("MiniMapContainer.MiniMapMarkers.Marker1", 12, 0)
	mMovie:__wf_atom_e57658c2("MiniMapOverlayMsg", 12, 0)
	mMovie:OverrideMaterial("MiniMapOverlayMsg.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"MiniMapOverlayMsg.Bg",
		"RectInnerColor",
		_G.UIColorObject_Black.r,
		_G.UIColorObject_Black.g,
		_G.UIColorObject_Black.b,
		0.4
	)
	mMovie:__wf_atom_1ca72041(
		"MiniMapOverlayMsg.Bg",
		"RectEdgeColor",
		_G.UIColorObject_Black.r,
		_G.UIColorObject_Black.g,
		_G.UIColorObject_Black.b,
		0.4
	)
	mMovie:__wf_atom_7d7314f1("MiniMapOverlayMsg.Label.text", "/Lotus/Language/SystemMessages/MapJammed")
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("MiniMapOverlayMsg.Label", 40)
	mMovie:__wf_atom_e57658c2("MiniMapOverlayMsg.Bg", 14, __wf_atom_5e6e15c8 + 20)
	mMovie:__wf_atom_e57658c2("MapHint", 12, 0)
	mMovie:__wf_atom_7d7314f1("MapHint.text", "/Lotus/Language/Menu/AdvancedMapHint")
	__wf_atom_86cbd68d(mMovie, "MiniMapContainer.MiniMapMarkers.PlayerArrow.swapDepths", 5000)
	InitializeMapHold()

	if module3.IsInNewWarAltCharacterMission() then
		mMovie:__wf_atom_2dedec1a("MapHint", 13, false)
	end

	fn32()

	if not __wf_atom_7e8ad928(v5) then
		v5:__wf_atom_e29da7c3(true)
		v5:__wf_atom_9cd68098(true)
	end

	if Engine.__wf_atom_2a979d69() then
		mMovie:__wf_atom_1b5ae3f7(false)
		gRegion:__wf_atom_eab484a7():__wf_atom_f3ae1167(true)
		mMovie:__wf_atom_e57658c2("MiniMapContainer", 5, 100)
		mMovie:__wf_atom_e57658c2("MiniMapContainer", 6, 100)
		mMovie:__wf_atom_e57658c2("MiniMapOverlayMsg", 5, 100)
		mMovie:__wf_atom_e57658c2("MiniMapOverlayMsg", 6, 100)
		mMovie:__wf_atom_e57658c2("MiniMapContainer.MiniMapMarkers.Marker1", 5, 125)
		mMovie:__wf_atom_e57658c2("MiniMapContainer.MiniMapMarkers.Marker1", 6, 125)
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:__wf_atom_8175b5c4(false)
	end

	mMovie:OverrideMaterial("MiniMapContainer.GlobalMask", globalMaskMaterial)
	mMovie:__wf_atom_e57658c2("MiniMapContainer.GlobalMask", 12, 90)
	fn4(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) then
		return
	end

	local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()
	v42 = 0
	v43 = 0
	v44 = 0
	local revealMapMask = _T.RevealMapMask
	_T.RevealMapMask = nil

	for i = 1, #mapMaskLore do
		local __wf_atom_afc2f523 = __wf_atom_d2b2176d:__wf_atom_afc2f523(mapMaskLore[i])

		if revealMapMask and revealMapMask[1] == mapMaskLore[i] then
			local index = table.find(mapMaskLore[i]:__wf_atom_22020464(), revealMapMask[2])

			if index then
				__wf_atom_afc2f523 = bit32.replace(__wf_atom_afc2f523, 0, index - 1)
				local v50 = i
				v3:AddTimer(1, function()
					v43 = 16 * (v50 - 1) + index
					module.PlaySound(mapZoneRevealSound)
				end)
				v3:AddTimer(0.1, function()
					v16:__wf_atom_09294a87(v17 * 2.75)
				end)
			end
		end

		local v50 = bit32.lshift(__wf_atom_afc2f523, 16 * (i - 1))
		v42 = bit32.bor(v42, v50)
	end

	mMovie:__wf_atom_1ca72041("MiniMapContainer.GlobalMask", "IdMaskParams", v42, 0, 0, 0)
	mMovie:__wf_atom_2dedec1a("Warning", 13, false)
end

local function fn33()
	if _T.MapRequestLocationCB then
		_T.MapRequestLocationCB(false)
	end

	v10 = true
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	_T.OverlayMapVisible = false
	UpdateButtons()
	module.PlaySound(mapCloseSound)
	RemoveMixEffect()
	mMovie:__wf_atom_0c1c47f2(nil)
	mMovie:__wf_atom_c884ca43(true)
	mMovie:__wf_atom_b4ffb30f(false)

	if not __wf_atom_7e8ad928(v5) then
		v5:__wf_atom_d2c76857()
		v5:__wf_atom_2889d69a(false)
		v5:__wf_atom_e6bd35b0(false)
		v5:__wf_atom_e29da7c3(false)
		v5:__wf_atom_9cd68098(false)
	end

	flag = true
	v8 = false

	if not __wf_atom_7e8ad928(v9) then
		v9:__wf_atom_8175b5c4(true)
	end

	if not fn2() then
		__wf_atom_ec43d06e(mMovie, "_root", 2, { 12, 4 }, { 0, -15000 }, 0.35, 0, function()
			flag2 = true
		end)
	end
end

function ToggleVisibility()
	if v8 or _T.HubShowRoomActive then
		fn33()
	else
		fn25()
	end
end

function Hide()
	fn33()
end

function Close()
	if Engine.__wf_atom_2a979d69() then
		gRegion:__wf_atom_eab484a7():__wf_atom_f3ae1167(false)
	end

	fn33()
end

local function fn34()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if fn2() then
		__wf_atom_2ad5cd23:Execute("SelectTabByMovie", (tostring(codexMovie:__wf_atom_5b41f63b())))
		return
	end

	if __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		mMovie:PushChildMovie(codexMovie)
		return
	end

	__wf_atom_2ad5cd23:Execute("FocusMapLocation", "")
	Close()
end

local function fn35()
	_G.mWaypointTeleports = not _G.mWaypointTeleports
	UpdateButtons()
end

function UpdateButtons()
	local topMenuChildButtons = {}

	if not v10 then
		if module4.ShowDevOptions() then
			local v51 = _G.mWaypointTeleports and "<FULL_CHECK>" or "<EMPTY_CHECK>"
			table.insert(topMenuChildButtons, {
				Label = mMovie:__wf_atom_8e9ac384("[DEV] RMB Teleport " .. v51, true),
				CallBack = fn35
			})
		end

		if _T.FocusCodexEntry ~= nil then
			table.insert(topMenuChildButtons, {
				Label = "/SF/Language/Codex/ViewCodex",
				CallBack = fn34,
				CallOut = "MENU_GENERIC2",
				Icon = codexIcon,
				IconShiftY = -5
			})
		end

		if Engine.IsPlayingWithController() then
			table.insert(topMenuChildButtons, {
				Label = "/Lotus/Language/Menu/Pan",
				CallOut = "MENU_X",
				SkipCallback = true
			})
			table.insert(topMenuChildButtons, {
				Label = "/Lotus/Language/Menu/Zoom",
				CallOut = "MENU_RIGHT_X",
				SkipCallback = true
			})
			table.insert(topMenuChildButtons, {
				Label = "/Lotus/Language/Menu/MapMarkerWaypoint",
				CallOut = "MENU_SELECT"
			})
		end

		table.insert(topMenuChildButtons, {
			Label = "/Lotus/Language/Menu/Exit",
			CallBack = Close,
			CallOut = "MENU_CANCEL"
		})
	end

	_T.TopMenuChildButtons = topMenuChildButtons
	_T.TopMenuChildButtonOptions = nil

	if fn2() then
		if not __wf_atom_7e8ad928(_T.SetButtons) then
			_T.SetButtons(mMovie)
		end

		mMovie:__wf_atom_2ad5cd23():Execute("UpdateButtons", "")
	elseif not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, topMenuChildButtons, getfenv(1))
	end
end

function Shutdown()
	if Engine.__wf_atom_2a979d69() then
		gRegion:__wf_atom_eab484a7():__wf_atom_f3ae1167(false)
	end

	if not __wf_atom_7e8ad928(_T.ShowButtonBarCursor) then
		_T.ShowButtonBarCursor(true)
	end

	if not __wf_atom_7e8ad928(v13) then
		v13:Close()
	end

	_T.InfoPopup_Data = nil

	if not __wf_atom_7e8ad928(v5) then
		v5:__wf_atom_d2c76857()
		v5:__wf_atom_2889d69a(false)
	end
end

local function fn36(__wf_atom_cb3427c9, _)
	if module4.IsDaytime() then
		return
			module3.TimeOfDayConstants.TIME_OF_DAY_LABEL_DAY,
			module3.TimeOfDayConstants.TIME_OF_DAY_LABEL_NIGHT,
			(22 - __wf_atom_cb3427c9) / 0.0083333333
	end

	local TIME_OF_DAY_LABEL_NIGHT = module3.TimeOfDayConstants.TIME_OF_DAY_LABEL_NIGHT
	local TIME_OF_DAY_LABEL_DAY = module3.TimeOfDayConstants.TIME_OF_DAY_LABEL_DAY

	if __wf_atom_cb3427c9 >= 22 then
		return TIME_OF_DAY_LABEL_NIGHT, TIME_OF_DAY_LABEL_DAY, (30 - __wf_atom_cb3427c9) / 0.0083333333
	end

	return TIME_OF_DAY_LABEL_NIGHT, TIME_OF_DAY_LABEL_DAY, (6 - __wf_atom_cb3427c9) / 0.0083333333
end

local function fn37()
	if
		__wf_atom_7e8ad928(gGameRules)
		or __wf_atom_7e8ad928(gRegion)
		or __wf_atom_7e8ad928(gRegion:__wf_atom_8ad59546())
	then
		return
	end

	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	local _, v50, v51 = fn36(__wf_atom_cb3427c9, nil)
	local v52 = (__wf_atom_cb3427c9 - 12) / 24 * -360
	mMovie:__wf_atom_e57658c2("TimeOfDay.DayNight", 16, v52 + __wf_atom_fa1258d0() * 30)
	local secondsToFormattedTime = module3.SecondsToFormattedTime(mMovie, v51, "CompactOne")
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/SystemMessages/TimeUntil", false, {
		LABEL = mMovie:__wf_atom_8e9ac384(v50, false),
		TIME = secondsToFormattedTime
	})

	if not _T.timeToNext or _T.timeToNext ~= secondsToFormattedTime then
		_T.timeToNext = secondsToFormattedTime
	end

	local v53 = MongoDateTime()
	v53.sec = string.format("%u", gGameRules:__wf_atom_93691ff2())
	local __wf_atom_e0c3cbeb = v53:__wf_atom_e0c3cbeb(Engine.__wf_atom_578fc9dd())
	local v54 = string.gsub(__wf_atom_e0c3cbeb, " ", "/")
	local v55 = StringSplit("/", v54)
	local _, day, month, year = module5.ConvertDateToGame(v55[4], v55[2], v55[1], v55[3])
	local v59 = Localize("/SF/Language/Codex/TimeStamp", { DAY = day, MONTH = month, YEAR = year })
	mMovie:__wf_atom_50d60589(
		"TimeOfDay.Label",
		36,
		"<p><font color=\"#DD9F38\">" .. __wf_atom_8e9ac384 .. "<br><font face=\"SpectralRegular\" color=\"#BCA783\">" .. v59 .. "</font></font></p>"
	)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("TimeOfDay.Label", 40)
	mMovie:__wf_atom_e57658c2("TimeOfDay.Backer", 14, __wf_atom_5e6e15c8 + 90)
end

local function fn38()
	if __wf_atom_7e8ad928(v22) then
		return
	end

	local mEntity = v22.mEntity

	if __wf_atom_7e8ad928(mEntity) or not mEntity:IsA(__wf_atom_17f001c3) then
		return
	end

	_T.FocusCodexEntry = mEntity:__wf_atom_366ba480()
	_T.FocusCodexTab = focusCodexTab
	UpdateButtons()

	if not CanTeleport(mEntity) then
		return
	end

	if (mEntity:IsA(treeMarkers) or mEntity:IsA(factionAreaMarkers)) and v47 == nil then
		v47 = {}
		v47.X = v15.mCurrentCoords.x
		v47.Y = v15.mCurrentCoords.y
		print("SETTING TELEPORT COORDS")
		local screenCursor = module.GetScreenCursor(mMovie)
		local _ = screenCursor.x
		local _ = screenCursor.y
		local clipName = v22:GetClipName()
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(clipName, 2)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(clipName, 3)
		local __wf_atom_e32e2012 = mEntity:__wf_atom_e32e2012()
		local x2 = mEntity:__wf_atom_bcaaaa6a().x
		local y = mEntity:__wf_atom_bcaaaa6a().y
		mMovie:__wf_atom_c90af43a("MapHold.TeleportIcon", __wf_atom_e32e2012)
		mMovie:__wf_atom_e57658c2("MapHold", 5, x2 * 50)
		mMovie:__wf_atom_e57658c2("MapHold", 6, y * 50)
		mMovie:__wf_atom_e57658c2("MapHold", 12, 100)
		mMovie:__wf_atom_e57658c2("MapHold", 0, __wf_atom_5e6e15c8)
		mMovie:__wf_atom_e57658c2("MapHold", 1, __wf_atom_5e6e15c8_2)
		flag3 = true
		v23 = v22
		module.PlaySound(acornTeleportHoldStartSound)

		if not __wf_atom_7e8ad928(acornTeleportHoldSound) and __wf_atom_7e8ad928(v) then
			v = module.PlaySound(acornTeleportHoldSound)
		end
	end
end

local function fn39()
	flag3 = false
	total = 0
	v47 = nil
	mMovie:__wf_atom_e57658c2("MapHold", 12, 0)

	if not __wf_atom_7e8ad928(v) then
		v:Stop(false)
	end
end

function Update()
	if flag2 then
		fn31()
		return
	end

	if __wf_atom_7e8ad928(gRegion) or gRegion:__wf_atom_c3b255b8() then
		return
	end

	if __wf_atom_7e8ad928(playerAvatar) and v4 then
		v4 = false
	end

	if not v4 then
		local __wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()

		if not (__wf_atom_7e8ad928(__wf_atom_e23b2855) or __wf_atom_7e8ad928(__wf_atom_e23b2855[1])) then
			playerAvatar = __wf_atom_e23b2855[1]:__wf_atom_50a7d83e()

			if not (__wf_atom_7e8ad928(playerAvatar) or __wf_atom_7e8ad928(playerAvatar:__wf_atom_a96eb2aa())) then
				fn30()
			end
		end
	end

	local v50 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v50)

	if not __wf_atom_7e8ad928(v3) then
		v3:Update(v50)
	end

	if flag3 then
		total += v50
		mMovie:__wf_atom_1ca72041("MapHold.ProgressFill", "AlphaTestThreshold", total / 1, 0, 0, 0)

		if total > 1 then
			Teleport()
			flag3 = false
			total = 0
		end
	end

	fn37()

	if not (__wf_atom_7e8ad928(v21) or __wf_atom_7e8ad928(v21.mInstance)) then
		v21:Update(0)
	end

	if v8 and not __wf_atom_7e8ad928(v5) then
		local v51 = v16.mCurVal * v37
		v15.mDragMultiplier = 1 / v51

		if math.abs(v19.x) <= 0 then
			v39.mSmoothTime = 0.05
		else
			v39.mSmoothTime = 0.25
		end

		if math.abs(v19.y) <= 0 then
			v40.mSmoothTime = 0.05
		else
			v40.mSmoothTime = 0.25
		end

		local __wf_atom_2490589b = v39:__wf_atom_2490589b(v19.x, v50)
		local v52 = v40:__wf_atom_2490589b(v19.y, v50) * 1
		v15.mDragSpeed.x = __wf_atom_2490589b * v36 / v51
		v15.mDragSpeed.y = v52 * v36 / v51
		v15:Update(v50)

		if v20 ~= 0 then
			v16:__wf_atom_09294a87(__wf_atom_421b01aa(v16.mTargetVal - v20 * 0.1, v17, 4))

			if not v29.IsVisible then
				v20 = 0
			end
		end

		v16:Update(v50)

		if v16.mCurVal ~= v51 then
			v18 = true
		end

		if not __wf_atom_7e8ad928(playerAvatar) then
			playerAvatar:__wf_atom_c5f1c61a(v27)
			fn9()
			v28.x = v27.x
			v28.y = v27.y
			v28.z = v27.z

			if
				v47 ~= nil
				and module.GetDistanceBetweenPoints(v47, {
					X = v15.mCurrentCoords.x,
					Y = v15.mCurrentCoords.y
				}) > 8
			then
				fn39()
			end

			v5:__wf_atom_1893acae(v15.mCurrentCoords.x, v15.mCurrentCoords.y, v16.mCurVal, v17, 4)
		end

		v5:__wf_atom_1969b572(true)
		v5:__wf_atom_7da714d0(miniMapMaterial, colorMiniMapMaterial)
		local v53 = Vector(v41:__wf_atom_c9d0fea6(), v41:__wf_atom_ccf700a6(), v41:__wf_atom_c384faa6())
		local v54 = Vector(v41:__wf_atom_152cb4a3(), v41:__wf_atom_1852b6a3(), v41:__wf_atom_1b78b8a3())
		local __wf_atom_aee81ad7 = v5:__wf_atom_aee81ad7()
		local __wf_atom_afb5740a = v5:__wf_atom_afb5740a()
		local v55 = -(v54.z - v53.z) * v16.mCurVal - __wf_atom_aee81ad7.x * __wf_atom_afb5740a * v16.mCurVal + v15.mCurrentCoords.x * v16.mCurVal
		local v56 = -(v54.x - v53.x) * v16.mCurVal + __wf_atom_aee81ad7.z * __wf_atom_afb5740a * v16.mCurVal + v15.mCurrentCoords.y * v16.mCurVal
		mMovie:__wf_atom_2dedec1a("MiniMapContainer.GlobalMask", 13, not fn23())
		mMovie:__wf_atom_e57658c2("MiniMapContainer.GlobalMask", 0, v55)
		mMovie:__wf_atom_e57658c2("MiniMapContainer.GlobalMask", 1, v56)
		mMovie:__wf_atom_e57658c2("MiniMapContainer.RegionOutline", 0, v55)
		mMovie:__wf_atom_e57658c2("MiniMapContainer.RegionOutline", 1, v56)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("MiniMapContainer.GlobalMask", 2)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("MiniMapContainer.GlobalMask", 3)
		local v57 = __wf_atom_afb5740a * (v54.x - v53.x) * v16.mCurVal
		local v58 = __wf_atom_afb5740a * (v54.z - v53.z) * v16.mCurVal
		mMovie:__wf_atom_e57658c2("MiniMapContainer.GlobalMask", 14, v57)
		mMovie:__wf_atom_e57658c2("MiniMapContainer.GlobalMask", 15, v58)
		mMovie:__wf_atom_e57658c2("MiniMapContainer.RegionOutline", 14, v57)
		mMovie:__wf_atom_e57658c2("MiniMapContainer.RegionOutline", 15, v58)
		local v59 = v57 * edgeFadePercent
		local v60 = v58 * edgeFadePercent
		local screenDimensions, v61 = module.GetScreenDimensions(mMovie)
		local v62 = (mMovie:__wf_atom_97cd8326() - screenDimensions) / 2
		local v63 = (mMovie:__wf_atom_54eeda24() - v61) / 2
		local v64 = __wf_atom_5e6e15c8 + v57 / 2
		local v65 = __wf_atom_5e6e15c8_2 + v58 / 2
		local v66 = v57 - v59 * 2
		local v67 = v58 - v60 * 2
		module.GetVisibilityCenter(mMovie, v64, true)
		module.GetVisibilityCenter(mMovie, v65)

		if v64 < v62 then
			v66 += (v64 - v62) * 2

			if v66 < 0 then
				v64 = v62 + v66 / 2
			else
				v64 = v62
			end
		else
			local v68 = v62 + screenDimensions

			if v68 < v64 then
				v66 -= (v64 - v68) * 2

				if v66 < 0 then
					v64 = v68 - v66 / 2
				else
					v64 = v68
				end
			end
		end

		if v65 < v63 then
			v67 += (v65 - v63) * 2

			if v67 < 0 then
				v65 = v63 + v67 / 2
			else
				v65 = v63
			end
		else
			local v68 = v63 + v61

			if v68 < v65 then
				v67 -= (v65 - v68) * 2

				if v67 < 0 then
					v65 = v68 - v67 / 2
				else
					v65 = v68
				end
			end
		end

		local visibilityCenter = module.GetVisibilityCenter(mMovie, v64, true)
		local visibilityCenter2 = module.GetVisibilityCenter(mMovie, v65)
		mapBackerMaterial:__wf_atom_a042ff6c(v34, (16 + 1) / 2, (9 + 1) / 2)
		colorMiniMapMaterial:__wf_atom_a042ff6c(v31, visibilityCenter, visibilityCenter2)
		colorMiniMapMaterial:__wf_atom_a042ff6c(
			v32,
			module.GetVisibilitySize(mMovie, v66, true),
			module.GetVisibilitySize(mMovie, v67)
		)
		colorMiniMapMaterial:__wf_atom_a042ff6c(
			v33,
			module.GetVisibilitySize(mMovie, v59, true),
			module.GetVisibilitySize(mMovie, v60)
		)

		if _T.NeedMapZoomUpdate then
			fn28()
		end

		if not __wf_atom_7e8ad928(playerAvatar) then
			fn6(playerAvatar)
		end

		UpdateRegionRollOver()

		if v43 > 0 then
			v44 = __wf_atom_421b01aa(v44 + v50 * 0.5, 0, 1)
			mMovie:__wf_atom_1ca72041("MiniMapContainer.GlobalMask", "IdMaskParams", v42, v43, v44, 0)

			if v44 >= 1 then
				v42 = bit32.replace(v42, 1, v43 - 1)
				v43 = 0
			end
		end
	end

	if Engine.__wf_atom_2a979d69() and v38 and v15.mDragging == false then
		v15:StartDrag()
	end

	local v51 = math.abs((math.sin(__wf_atom_4658d645(Time() * 0.6) * 3.1415927410125732 * 2)))
	mMovie:__wf_atom_e57658c2("MiniMapContainer.MiniMapMarkers.PlayerArrow", 5, __wf_atom_104bfe98(80, 100, v51))
	mMovie:__wf_atom_e57658c2("MiniMapContainer.MiniMapMarkers.PlayerArrow", 6, __wf_atom_104bfe98(80, 100, v51))
	fn(v50)
end

function UpdateQuestNodeState(p, p2)
	local v50 = tonumber(p2)
	local questNodeIcon = questNodeIcon
	local questNodeHoverIcon = questNodeHoverIcon
	local v51 = 100
	local v52 = 16777215
	local v54 = 150
	local v55 = 1.75
	local v56 = 0
	local questNodeXIcon2 = nil

	if v50 == 1 then
		v51 = 50
	elseif v50 == 7 then
		v51 = 75
		v52 = 0
	elseif v50 == 2 then
		v51 = 100
	elseif v50 == 3 then
		questNodeXIcon2 = questNodeXIcon
		v51 = 75
		v52 = 0
	elseif v50 == 4 then
		questNodeHoverIcon = questNodeFinalHoverIcon
		v51 = 100
		v54 = 220
		v55 = 1.3
		v56 = 0
	elseif v50 == 5 then
		questNodeHoverIcon = questNodeFinalHoverIcon
		v51 = 100
		v54 = 220
		v55 = 1.3
		v56 = 0
	elseif v50 == 6 then
		questNodeHoverIcon = questNodeFinalHoverIcon
		v51 = 100
		v54 = 220
		v55 = 1.3
		v56 = 0
	end

	local v57 = 2 - math.min(2 / (v5:__wf_atom_afb5740a() * v16.mCurVal + 0.5), 2)
	local v58 = 90 * __wf_atom_421b01aa(v57, 0, 1)

	if not mMovie:__wf_atom_bd8fa442(p, "QuestInfo", 13) or v48[p] == nil then
		v48[p] = 0
	end

	local v59 = __wf_atom_fa1258d0()
	v48[p] = math.min(1, v48[p] + v59 * 3)
	local __wf_atom_625af973 = v5:__wf_atom_625af973(p)

	if not (__wf_atom_7e8ad928(__wf_atom_625af973) or __wf_atom_7e8ad928(__wf_atom_625af973.mEntity)) then
		__wf_atom_625af973.mEntity:__wf_atom_00c79e8f(__wf_atom_24a82b69(v48[p]))
	end

	mMovie:__wf_atom_7f57ab2f(p, "StatusIcons", 13, questNodeXIcon2 and true or false)
	mMovie:__wf_atom_7f57ab2f(p, "StatusIcons.Icon1", 13, questNodeXIcon2 and true or false)
	mMovie:__wf_atom_7f57ab2f(p, "QuestInfo", 13, true)
	mMovie:__wf_atom_c90af43a(p .. ".StatusIcons.Icon1", questNodeXIcon2)
	mMovie:__wf_atom_c90af43a(p .. ".QuestInfo.Backer", questNodeIcon)
	mMovie:__wf_atom_c90af43a(p .. ".QuestInfo.Hover", questNodeHoverIcon)
	mMovie:__wf_atom_c90af43a(p .. ".QuestInfo.Glow", questNodeGlowIcon)
	mMovie:__wf_atom_4c1c1986(p, "Icon", 12, v51)
	mMovie:__wf_atom_4c1c1986(p, "Icon", 11, v52)

	if __wf_atom_7e8ad928(v22) or v22:GetClipName() ~= p then
		mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Backer", 12, v58)
	end

	local v60 = v54 * v5:__wf_atom_afb5740a() * v16.mCurVal
	mMovie:__wf_atom_4c1c1986(p, "StatusIcons.Icon1", 5, v60)
	mMovie:__wf_atom_4c1c1986(p, "StatusIcons.Icon1", 6, v60)
	mMovie:__wf_atom_4c1c1986(p, "StatusIcons.Icon1", 0, 0)
	mMovie:__wf_atom_4c1c1986(p, "StatusIcons.Icon1", 1, 0)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Backer", 5, v60)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Backer", 6, v60)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Backer", 1, 0)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Hover", 5, v55 * v60)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Hover", 6, v55 * v60)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Glow", 5, 2 * v60)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Glow", 6, 2 * v60)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Glow", 12, v56)
	local ternary = module.Ternary(__wf_atom_7e8ad928(questNodeXIcon2), 1, 2)

	while mMovie:__wf_atom_253d7085(p .. ".StatusIcons.Icon" .. ternary) do
		mMovie:__wf_atom_7f57ab2f(p, ".StatusIcons.Icon" .. ternary, 13, false)
		ternary += 1
	end
end

function UpdateQuestMarker(p, p2, p3)
	local v50 = tonumber(p2)
	local v51 = tonumber(p3)

	if v50 ~= 1 then
		return
	end

	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Backer", 12, 0)
	mMovie:__wf_atom_7f57ab2f(p, "QuestInfo", 13, true)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Backer", 1, 20)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Hover", 12, 0)
	mMovie:__wf_atom_4c1c1986(p, "QuestInfo.Glow", 12, 0)

	if v51 > 0 then
		mMovie:__wf_atom_7f57ab2f(p, "StatusIcons", 13, true)
	end

	for i = 1, v51 do
		local v52 = p .. ".StatusIcons.Icon" .. i

		if not mMovie:__wf_atom_253d7085(v52) then
			__wf_atom_86cbd68d(mMovie, p .. ".StatusIcons.Icon1.duplicateMovieClip", "Icon" .. i, i)
		end

		mMovie:__wf_atom_c90af43a(v52, questStarIcon)
		mMovie:__wf_atom_2dedec1a(v52, 13, true)
		mMovie:__wf_atom_e57658c2(v52, 5, 75)
		mMovie:__wf_atom_e57658c2(v52, 6, 75)
		local total3 = -40
		local v53

		if i <= v51 / 2 then
			v53 = i * -1
		else
			v53 = i - math.ceil(v51 / 2)
		end

		local v54

		if v51 % 2 == 1 then
			local v55

			if i == math.ceil(v51 / 2) then
				v55 = 0
			elseif i < v51 / 2 then
				v55 = v53 - 1
			else
				v55 = v53 + 1
			end

			total3 += math.abs(v55 * 3)
			v54 = v55 * 8
		else
			v54 = v53 * 10
		end

		mMovie:__wf_atom_e57658c2(v52, 0, v54)
		mMovie:__wf_atom_e57658c2(v52, 1, total3)
	end

	local v52 = v51 + 1

	while mMovie:__wf_atom_253d7085(p .. ".StatusIcons.Icon" .. v52) do
		mMovie:__wf_atom_7f57ab2f(p, "StatusIcons.Icon" .. v52, 13, false)
		v52 += 1
	end
end

local function fn40(p, p2)
	if fn23() then
		return true
	end

	local v50 = v5:__wf_atom_afb5740a() * v16.mCurVal
	local mCurVal = v16.mCurVal
	local mWorldPosition = _T.mWorldPosition

	if not __wf_atom_7e8ad928(playerAvatar) then
		if playerAvatar:__wf_atom_799d95f5() then
			mWorldPosition = playerAvatar:__wf_atom_4c2e0189()
		else
			mWorldPosition = playerAvatar:GetPosition()
		end
	end

	local v51 = v50 * (v24.x - mWorldPosition.x) + v11 / 2 + v15.mCurrentCoords.x * mCurVal
	local v52 = -v50 * (v25.z - mWorldPosition.z) + v12 / 2 + v15.mCurrentCoords.y * mCurVal
	local v53 = v50 * (v25.x - mWorldPosition.x) + v11 / 2 + v15.mCurrentCoords.x * mCurVal
	local v54 = -v50 * (v24.z - mWorldPosition.z) + v12 / 2 + v15.mCurrentCoords.y * mCurVal
	return p < v51 or v53 < p or p2 < v52 or v54 < p2
end

local function fn41(p)
	if not (__wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v22)) then
		v5:__wf_atom_5481b401(p, false)
		SetRegionMarkerFocus(v49, true)
		local mEntity = v22.mEntity

		if not __wf_atom_7e8ad928(mEntity) and mEntity:IsA(__wf_atom_17f001c3) then
			mEntity:__wf_atom_2e2a3cea()

			if #mEntity:__wf_atom_d462835b():c_str() > 0 then
				local clipName = v22:GetClipName()
				__wf_atom_ec43d06e(mMovie, clipName .. ".QuestInfo.Hover", 8, { 12 }, { 0 }, 0.2, 0)
				local __wf_atom_68dff988 = mEntity:__wf_atom_68dff988()

				if __wf_atom_68dff988 == 4 or __wf_atom_68dff988 == 5 or __wf_atom_68dff988 == 6 then
					__wf_atom_ec43d06e(mMovie, clipName .. ".QuestInfo.Backer", 8, { 12 }, { 100 }, 0.2, 0)
				end

				_T.InfoPopup_Data = nil
			end
		end
	end

	_T.gToolTip = nil
	v22 = nil
end

local function fn42(mEntity, object)
	if mEntity:IsA(__wf_atom_7e6ed5fa) then
		_T.gToolTip = mEntity:__wf_atom_a96eb2aa():__wf_atom_6be84646()
		_T.gToolTipDelay = 0
	else
		local c_str = mEntity:__wf_atom_d462835b():c_str()

		if #c_str > 0 then
			_T.gToolTip = nil
			local c_str2 = mEntity:__wf_atom_faa8b972():c_str()
			local infoPopup_Data = {
				CustomEntry = true,
				Name = mMovie:__wf_atom_8e9ac384(c_str2, true),
				Description = mMovie:__wf_atom_8e9ac384(c_str, true)
			}
			local v51 = object:GetClipName() .. ".Btn"
			module2.SetItemInfoPopupRect(
				mMovie,
				infoPopup_Data,
				mMovie:__wf_atom_5e6e15c8(v51, 2),
				mMovie:__wf_atom_5e6e15c8(v51, 3),
				mMovie:__wf_atom_5e6e15c8(v51, 14),
				mMovie:__wf_atom_5e6e15c8(v51, 15)
			)
			_T.InfoPopup_Data = infoPopup_Data
			local clipName = object:GetClipName()
			local v52 = { (mMovie:__wf_atom_5e6e15c8(clipName .. ".QuestInfo.Backer", 12)) }
			__wf_atom_ec43d06e(mMovie, clipName .. ".QuestInfo.Hover", 8, { 12 }, v52, 0.2, 0)
			local __wf_atom_68dff988 = mEntity:__wf_atom_68dff988()

			if __wf_atom_68dff988 == 4 or __wf_atom_68dff988 == 5 or __wf_atom_68dff988 == 6 then
				__wf_atom_ec43d06e(mMovie, clipName .. ".QuestInfo.Backer", 8, { 12 }, { 0 }, 0.2, 0)
			end
		else
			local __wf_atom_6a3d8b57 = mEntity:__wf_atom_6a3d8b57()

			if __wf_atom_7e8ad928(__wf_atom_6a3d8b57) then
				local __wf_atom_7d1f83d4 = mEntity:__wf_atom_7d1f83d4()

				if __wf_atom_7d1f83d4 == EMPTY_SYMBOL then
					local __wf_atom_366ba480 = mEntity:__wf_atom_366ba480()
					local fragmentCipher = module5.FragmentCipher(__wf_atom_366ba480)
					_T.gToolTip = Localize(fragmentCipher, {})
					_T.gToolTipDelay = 0
				else
					_T.gToolTip = Localize(tostring(__wf_atom_7d1f83d4), {})
					_T.gToolTipDelay = 0
				end
			else
				_T.gToolTip = __wf_atom_6a3d8b57:__wf_atom_6be84646()
				_T.gToolTipDelay = 0
			end
		end
	end
end

local function fn43(p)
	if Engine.__wf_atom_2a979d69() and not __wf_atom_7e8ad928(v22) then
		fn41(p)
	end

	if not __wf_atom_7e8ad928(v5) then
		local __wf_atom_8af4322b = v5:__wf_atom_8af4322b(p)

		if __wf_atom_8af4322b.mVisible then
			v22 = __wf_atom_8af4322b
			v5:__wf_atom_5481b401(p, true)
			module.PlaySound(markerHoverSound)
			local mEntity = __wf_atom_8af4322b.mEntity

			if not __wf_atom_7e8ad928(mEntity) then
				fn42(mEntity, __wf_atom_8af4322b)
			end
		end
	end
end

function MarkerRollOverCallback(p)
	fn43(p)
end

function MarkerRollOutCallback(p)
	fn41(p)
end

function SetRegionMarkerFocus(p, p2)
	if p ~= nil and p ~= 0 then
		local v50 = regionMarkersById[p]

		if not __wf_atom_7e8ad928(v50) then
			local __wf_atom_21be8192 = v5:__wf_atom_21be8192(v50)

			if not __wf_atom_7e8ad928(__wf_atom_21be8192) then
				local __wf_atom_bdcd039e = __wf_atom_21be8192:__wf_atom_bdcd039e()
				v5:__wf_atom_5481b401(__wf_atom_bdcd039e, p2)
			end
		end
	end
end

function UpdateRegionRollOver()
	local v50 = nil

	if not __wf_atom_7e8ad928(v5) and math.abs(v16.mCurVal - v17) < 0.01 and module6.IsInOverworld() and not fn23() then
		local v51, v52

		if Engine.IsPlayingWithController() then
			v51 = mMovie:__wf_atom_5e6e15c8("Reticle", 0)
			v52 = mMovie:__wf_atom_5e6e15c8("Reticle", 1)
		else
			v51 = mMovie:__wf_atom_5e6e15c8("_root", 30)
			v52 = mMovie:__wf_atom_5e6e15c8("_root", 31)
		end

		if (v51 ~= -1000 or v52 ~= -1000) and not fn40(v51, v52) then
			local v53, v54 = GetTranslatedWorldCoordinates(v51, v52)
			local v55 = Vector(v53, 0, v54)
			v50 = module6.GetRegionIdFromDensityVolume(v55)
		end
	end

	if v50 ~= nil and v50 ~= 0 then
		local v51 = regionMarkersById[v50]

		for _, v53 in gRegion:FindAll(v51) do
			if v53:IsEnabled() then
				continue
			end

			v50 = nil
			break
		end
	end

	if v50 ~= v49 then
		if v50 == nil or v50 == 0 then
			mMovie:__wf_atom_290807ee("MiniMapContainer.RegionOutline")
			mMovie:__wf_atom_2dedec1a("MiniMapContainer.RegionOutline", 13, false)
			mMovie:__wf_atom_e57658c2("MiniMapContainer.RegionOutline", 12, 0)
			SetRegionMarkerFocus(v49, false)
		else
			mMovie:__wf_atom_2dedec1a("MiniMapContainer.RegionOutline", 13, true)
			__wf_atom_ec43d06e(mMovie, "MiniMapContainer.RegionOutline", 0, {}, {}, 0.1, 0, function()
				mMovie:__wf_atom_933bbce0(
					"MiniMapContainer.RegionOutline",
					miniMapRegionOutlineTextures[v50],
					miniMapRegionOutlineMaterial
				)
				mMovie:__wf_atom_e57658c2("MiniMapContainer.RegionOutline", 12, 0)
				__wf_atom_ec43d06e(mMovie, "MiniMapContainer.RegionOutline", 2, { 12 }, { 100 }, 0.15, 0)
				SetRegionMarkerFocus(v50, true)
			end)
		end

		v49 = v50
	end
end

function Teleport()
	if __wf_atom_7e8ad928(v23) or __wf_atom_7e8ad928(v23.mEntity) then
		return
	end

	local mEntity = v23.mEntity

	if
		not CanTeleport(mEntity)
		or (__wf_atom_7e8ad928(playerAvatar) or __wf_atom_7e8ad928(playerAvatar:__wf_atom_d2b2176d()))
	then
		return
	end

	module.PlaySound(acornTeleportConfirmSound)

	if not __wf_atom_7e8ad928(playerAvatar) then
		local position = v23.mEntity:GetPosition()
		local x2 = position.x
		local z = position.z
		local y = position.y
		local v50 = nil

		if mEntity:IsA(treeMarkers) then
			v50 = Symbol("MapTreeJobBoard")
		elseif mEntity:IsA(factionAreaMarkers) then
			local faction = mEntity:__wf_atom_e919fb8e().faction

			if faction == Symbol("SilentRoseSyndicate") then
				v50 = Symbol("SilentRoseEntrance")
			elseif faction == Symbol("FeySyndicate") then
				v50 = Symbol("AlcasChildrenEntrance")
			elseif faction == Symbol("ChampionSyndicate") then
				v50 = Symbol("KithOfKingsOutsideEntrance")
			end
		end

		local nearestTagged = gRegion:FindNearestTagged(v50, Vector(x2, y, z))

		if not __wf_atom_7e8ad928(nearestTagged) then
			onKeyDown_SHOW_LEVEL_MAP()
			module9.FastTravel(nearestTagged)
		end
	end
end

local function fn44()
	if not (__wf_atom_7e8ad928(v22) or v15.mChanged) then
		module.PlaySound(markerSelectSound)
		v23 = v22
		local mEntity = v22.mEntity

		if mEntity:IsA(treeMarkers) or not mEntity:IsA(__wf_atom_0f520c3c) then
			return
		end

		if mEntity then
			_T.FocusCodexEntry = mEntity:__wf_atom_366ba480()
			_T.FocusCodexTab = focusCodexTab
			UpdateButtons()
			fn13()
		end
	end
end

function MarkerSelectCallback(_)
	if Engine.__wf_atom_2a979d69() then
		v15:StopDrag()
	else
		fn44()
	end
end

function MarkerReleaseCallback(p)
	if Engine.__wf_atom_2a979d69() then
		local v50 = v22
		fn43(p)

		if not __wf_atom_7e8ad928(v22) and not __wf_atom_7e8ad928(v50) and v22.mEntity == v50.mEntity then
			fn44()
		end
	end
end

function DialogConfirm()
	if not __wf_atom_7e8ad928(v13) then
		v13:Close()
	end
end

function TrySetWaypoint()
	if v30 and not __wf_atom_7e8ad928(v5) then
		v30 = false
		local v50, v51

		if Engine.IsPlayingWithController() then
			v50 = mMovie:__wf_atom_5e6e15c8("Reticle", 0)
			v51 = mMovie:__wf_atom_5e6e15c8("Reticle", 1)
		else
			v50 = mMovie:__wf_atom_5e6e15c8("_root", 30)
			v51 = mMovie:__wf_atom_5e6e15c8("_root", 31)
		end

		if v50 == -1000 and v51 == -1000 then
			return
		end

		if __wf_atom_7e8ad928(playerAvatar) or fn40(v50, v51) then
			mMovie:__wf_atom_7d7314f1("MapHint.text", "/Lotus/Language/Menu/MapMarkerDisabledZone")
			module.PlaySound(_G.UISound_Error)
			__wf_atom_ec43d06e(mMovie, "MapHint", 8, { 12 }, { 70 }, 0.15, 0, function()
				__wf_atom_ec43d06e(mMovie, "MapHint", 8, { 12 }, { 0 }, 0.15, 2)
			end)
		else
			v14.x = v50
			v14.y = v51
			local x2, z = GetTranslatedWorldCoordinates(v14.x, v14.y)

			if not (__wf_atom_7e8ad928(v22) or __wf_atom_7e8ad928(v22.mEntity)) then
				local position = v22.mEntity:GetPosition()
				x2 = position.x
				z = position.z
				local _ = position.y
			end

			playerAvatar:__wf_atom_4ec993ab(x2, z)

			if not gGameData:__wf_atom_7f86fc42(Symbol("MapMarkerTutorial")) then
				local dialogSettings = Engine.DialogSettings()
				dialogSettings.locString = "/Lotus/Language/Menu/MapMarkerFirstPlacementDescription"
				dialogSettings.titleString = "/Lotus/Language/Menu/MapMarkerFirstPlacementHeader"
				dialogSettings.dialogType = 0
				dialogSettings.firstString = "/Lotus/Language/Menu/ItemSelection_OK"
				dialogSettings:SetCallback("DialogConfirm")
				v13 = module.ShowCustomMessage(dialogSettings)
				gGameData:__wf_atom_c9bb8504(Symbol("MapMarkerTutorial"))
			end
		end

		if _T.MapRequestLocationCB then
			_T.MapRequestLocationCB(true)
			ToggleVisibility()
		end
	end
end

function onKeyDown_MENU_SELECT()
	fn38()

	if __wf_atom_7e8ad928(v22) then
		v30 = true
	end

	return true
end

function onKeyUp_MENU_SELECT()
	fn39()

	if __wf_atom_7e8ad928(v22) then
		TrySetWaypoint()
	else
		fn44()
	end

	return true
end

function onKeyDown_MENU_CANCEL()
	if not flag then
		fn33()
	end
end

function onKeyDown_MENU_CLICK()
	fn38()

	if Engine.__wf_atom_2a979d69() then
		v38 = true
		return false
	end

	v15:StartDrag()
	return (__wf_atom_7e8ad928(v22))
end

function onKeyUp_MENU_CLICK()
	fn39()
	v15:StopDrag()

	if not Engine.__wf_atom_2a979d69() then
		return (__wf_atom_7e8ad928(v22))
	end

	v38 = false
	return false
end

function onKeyDown_MENU_RIGHT_CLICK()
	v30 = true
	return true
end

function onKeyUp_MENU_RIGHT_CLICK()
	TrySetWaypoint()
	return true
end

function onKeyDown_MENU_MOUSE_Z(_, increment)
	if tonumber(increment) > 0 then
		increment = module.INCREMENT
	elseif tonumber(increment) < 0 then
		increment = module.DECREMENT
	end

	if _T.MapRightStickPan and Engine.IsPlayingWithController() then
		return true
	end

	v20 = increment
	return true
end

local function fn45(p)
	local v50 = math.abs(p) <= controllerDeadZone
	v19.y = module.Ternary(v50, 0, -p)
end

local function fn46(p)
	local v50 = math.abs(p) <= controllerDeadZone
	v19.x = module.Ternary(v50, 0, p)
end

function onKeyDown_MENU_UP()
	if _T.MapRightStickPan then
		return true
	end

	fn45(1)
	return true
end

function onKeyUp_MENU_UP()
	if _T.MapRightStickPan then
		return true
	end

	if v19.y < 0 then
		fn45(0)
	end

	return true
end

function onKeyDown_MENU_DOWN()
	if _T.MapRightStickPan then
		return true
	end

	fn45(-1)
	return true
end

function onKeyUp_MENU_DOWN()
	if _T.MapRightStickPan then
		return true
	end

	if v19.y > 0 then
		fn45(0)
	end

	return true
end

function onKeyDown_MENU_LEFT()
	if _T.MapRightStickPan then
		return true
	end

	fn46(-1)
	return true
end

function onKeyUp_MENU_LEFT()
	if _T.MapRightStickPan then
		return true
	end

	if v19.x < 0 then
		fn46(0)
	end

	return true
end

function onKeyDown_MENU_RIGHT()
	if _T.MapRightStickPan then
		return true
	end

	fn46(1)
	return true
end

function onKeyUp_MENU_RIGHT()
	if _T.MapRightStickPan then
		return true
	end

	if v19.x > 0 then
		fn46(0)
	end

	return true
end

function onKeyDown_MENU_X(_, p)
	if flag or _T.MapRightStickPan then
		return
	end

	fn46(tonumber(p))
	return true
end

function onKeyUp_MENU_X(_, _)
	if flag or _T.MapRightStickPan then
		return
	end

	fn46(0)
	return true
end

function onKeyDown_MENU_Y(_, p)
	if flag or _T.MapRightStickPan then
		return
	end

	fn45(tonumber(p))
	return true
end

function onKeyUp_MENU_Y(_, _)
	if flag or _T.MapRightStickPan then
		return
	end

	fn45(0)
	return true
end

function onKeyDown_MENU_RIGHT_Y(_, p)
	if flag then
		return
	end

	if _T.MapRightStickPan then
		fn45(tonumber(p))
		return true
	end

	v20 = -tonumber(p) * 0.4
	return true
end

function onKeyUp_MENU_RIGHT_Y(_, _)
	if flag then
		return
	end

	if _T.MapRightStickPan then
		fn45(0)
		return true
	end

	v20 = 0
	return true
end

function onKeyDown_MENU_RIGHT_X(_, p)
	if flag then
		return
	end

	if not _T.MapRightStickPan then
		return true
	end

	fn46(tonumber(p))
	return true
end

function onKeyUp_MENU_RIGHT_X(_, _)
	if flag then
		return
	end

	if not _T.MapRightStickPan then
		return true
	end

	fn46(0)
	return true
end

function onKeyDown_TOGGLE_CHAT_WINDOW()
	fn46(0)
	fn45(0)
end

function onKeyDown_TOGGLE_CHAT_WINDOW_ALT()
	fn46(0)
	fn45(0)
end

function onKeyDown_SHOW_LEVEL_MAP()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		fn33()
	else
		__wf_atom_2ad5cd23:Execute("Close", "")
	end

	return true
end

function onKeyDown_MENU_GENERIC1()
	v30 = true
	return true
end

function onKeyUp_MENU_GENERIC1()
	TrySetWaypoint()
	return true
end

function OnGamepadTransition(p)
	fn5(p ~= "true")
	UpdateButtons()
end

function onKeyDown_MENU_PINCH_DELTA(_, p)
	v20 = (p - 1) * -50
	return true
end

function OpenedFromPauseMenu()
	v2:ChangeOriginalCoords("Banner", 0, 110)
	v2:ChangeOriginalCoords("Compass", 1865, 110)
	v2:ChangeOriginalCoords("Warning", 1315, 100)
	fn4(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function PrepareToClose()
	fn33()
end

function ClosedFromPauseMenu()
	fn31()
end

function AddMixEffect(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_66669661(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end
end

function RemoveMixEffect(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_b3845a20 = gClient:__wf_atom_b3845a20()

	if not __wf_atom_7e8ad928(__wf_atom_b3845a20) then
		__wf_atom_b3845a20:__wf_atom_64d1f332(__wf_atom_c4f78a8f, mixEffect, mixingGroup)
	end
end