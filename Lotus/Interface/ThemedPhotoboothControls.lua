local module = require("Lotus.Interface.PhotoboothUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.Components.ThemedCustomizationButton")
local module6 = require("Lotus.Scripts.Effects.EffectsColorUtilities")
local module7 = require("SF.Interface.SFUtilities")
mInitials = {
	DofHorizon = 0,
	DofDistance = 0,
	DofDepth = 0,
	Ease = 0,
	Fov = 0,
	Grain = 0,
	Exposure = 1,
	Saturation = 1,
	Fade = 0,
	LightRotation = 0,
	AmbientLight = 1
}
MIN_FOV = 20
MAX_FOV = 100
MIN_GRAIN = -0.025
MAX_GRAIN = 1
COLOR_CORRECTION_DEPTH_PARAM = Symbol("ColCorrectDepthFade")
MAX_FAR_PLANE = 20
MIN_EXPOSURE = 0.01
MAX_EXPOSURE = 0.3
EXPOSURE_STEP = 0.01
MIN_SATURATION = 0
MAX_SATURATION = 1
MAX_TIME_OF_DAY = 24
FadeSettings = { MIN_FADE = -1, MAX_FADE = 1, FADE_STEP = 0.05 }
MIN_CAMERA_DURATION = 0.5
MAX_CAMERA_DURATION = 30
DURATION_STEP = 0.1
MIN_SPEED_MULTIPLIER = 0
MAX_SPEED_MULTIPLIER = 10
SPEED_STEP = 0.5
local v = { MAX_CAMERA_EASE = 1, MIN_CAMERA_EASE = -1, EASE_STEP = 0.1 }
MIN_CAMERA_DATA = 2
MAX_CAMERA_DATA = 200
MIN_TEXT_SCALE = 0.2
MAX_TEXT_SCALE = 4
MAX_TEXT = 5
TEXT_CHAR_LIMIT = 30
MIN_BOX_WIDTH = 270
CALLOUT_WIDTH = 100
mColors = {}
DEFAULT_WHITE_ROOM_COLOR = Color(255, 255, 255, 255)
local v2 = nil
local v3 = nil
local v4 = nil
local freeCamActive = false
local v5 = false
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local flag = false
local gradient = nil
local mLabel = 0
local mLabel2 = 1
local mChecked = false
local mChecked2 = false
local mChecked3 = false
local mChecked4 = false
local multiplier = 0.1
local v11 = false
local mChecked5 = false
local v12 = nil
local v13 = Symbol("TintColor")
local v14 = Symbol("SandBoxInv")
local mChecked6 = true
local dofDistance = nil
local dofDepth = nil
local dofHorizon = nil
local v15 = false
local mActiveColors = nil
local v16 = nil
local v17 = {
	LightsOn = false,
	MainLight = {
		Instance = nil,
		TestInstance = nil,
		Color = Color(255, 255, 255, 255),
		InitBrightness = 0,
		Brightness = 0,
		Min = 0,
		Max = 1
	},
	FillLight = {
		Instance = nil,
		TestInstance = nil,
		Color = Color(255, 255, 255, 255),
		InitBrightness = 0,
		Brightness = 0,
		Min = 0,
		Max = 0.5
	},
	RimLight = {
		Instance = nil,
		TestInstance = nil,
		Color = Color(255, 255, 255, 255),
		InitBrightness = 0,
		Brightness = 0,
		Min = 0,
		Max = 2
	},
	LightRotation = 0
}
local v18 = {
	LightsOn = false,
	MainLight = {
		Instance = nil,
		TestInstance = nil,
		Color = Color(255, 255, 255, 255),
		InitBrightness = 0,
		Brightness = 0,
		Min = 0,
		Max = 1
	},
	FillLight = {
		Instance = nil,
		TestInstance = nil,
		Color = Color(255, 255, 255, 255),
		InitBrightness = 0,
		Brightness = 0,
		Min = 0,
		Max = 0.5
	},
	RimLight = {
		Instance = nil,
		TestInstance = nil,
		Color = Color(255, 255, 255, 255),
		InitBrightness = 0,
		Brightness = 0,
		Min = 0,
		Max = 2
	},
	LightRotation = 0
}
local lightsOn = v17.LightsOn
local mainLight2 = v17.MainLight
local fillLight2 = v17.FillLight
local rimLight2 = v17.RimLight
local lightRotation = v17.LightRotation
local v19 = { Current = 1, Min = 0, Max = 2, Lights = {} }
local v20 = nil
local v21 = false
local v22 = nil
local filename = nil
local mChecked7 = true
local v23 = nil
local v24 = nil
local v25 = {}
local v26 = 0
local v27 = 1
local v28 = { First = Color(239, 239, 239, 0), Second = Color(239, 239, 239, 0) }
local v29 = Color()
mInterpolateVisualFx = true
mLookAtAvatar = false
mVisualizeCamera = false
mLoopCamera = false
mEditingCameraIndex = nil
mCameraDatas = {}
mCamera = nil
mFocusedEntity = nil
mCameraAvatar = nil
mCameraTimer = 0
mCameraDuration = MAX_CAMERA_DURATION / 3
mCameraStartMarker = nil
mCameraEndMarker = nil
mCameraSplineDraw = nil
mAddCameraMode = false
mCinematicMode = false
mCameraSettings = false
mCameraUpdateIndex = 1
mCameraSpeed = 0
mCameraSpeedMult = 1
mNeedsCameraSpeedUpdate = false
mCameraEase = 0
mCameraSpeedControl = {
	SliderActive = false,
	Value = mCameraSpeedMult / MAX_SPEED_MULTIPLIER
}
local fn
local fn2
local fn3
local fn4

function OnUpdateSessionSettings() end

function SupportsThemes()
	return true
end

function OnLobbyReady(p)
	if not p then
		print("Photobooth session hosting failed")
	end
end

local function fn5(enabled)
	for i = 1, v6.CustomizationList:GetHowManyElements() do
		local elementInIndex = v6.CustomizationList:GetElementInIndex(i)

		if not elementInIndex.IsAddNextCameraPos then
			continue
		end

		elementInIndex.Enabled = enabled
		v6.CustomizationList.mElementDrawCallback(elementInIndex)
		break
	end
end

local function fn6(enabled)
	for i = 1, v6.CustomizationList:GetHowManyElements() do
		local elementInIndex = v6.CustomizationList:GetElementInIndex(i)

		if not elementInIndex.IsCancelEditMode then
			continue
		end

		elementInIndex.Enabled = enabled
		v6.CustomizationList.mElementDrawCallback(elementInIndex)
		break
	end
end

local function fn7(p)
	for i = 1, v6.CustomizationList:GetHowManyElements() do
		local elementInIndex = v6.CustomizationList:GetElementInIndex(i)

		if __wf_atom_7e8ad928(elementInIndex.IsAddCameraPos) then
			continue
		end

		elementInIndex.NameTag = p and "/Lotus/Language/Menu/Photobooth_ChangeCameraPos"
			or "/Lotus/Language/Menu/Photobooth_AddCameraPos"
		v6.CustomizationList.mElementDrawCallback(elementInIndex)
		break
	end
end

local function fn8(enabled)
	fn7(enabled)
	fn5(enabled)
	fn6(enabled)
end

local function fn9()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/PhotoboothToggleSloMo", false)
	local result = {}

	for i = 1, #slowMoMultipliers do
		table.insert(result, {
			Name = module2.FormatNumber(slowMoMultipliers[i], 1) .. "x " .. __wf_atom_8e9ac384,
			Multiplier = slowMoMultipliers[i]
		})
	end

	return result
end

local function fn10(multiplier2)
	local v30 = fn9()

	for i = 1, #v30 do
		if v30[i].Multiplier == multiplier2 then
			return i
		end
	end

	return 1
end

local function fn11()
	local result = {}

	for i = 1, #colorGradients do
		table.insert(result, {
			Name = __wf_atom_7e8ad928(colorGradLocTags[i]) and "" or mMovie:__wf_atom_8e9ac384(colorGradLocTags[i], false),
			Gradient = colorGradients[i]
		})
	end

	return result
end

local function fn12(gradient2)
	local v30 = fn11()

	for i = 1, #v30 do
		if v30[i].Gradient == gradient2 then
			return i
		end
	end

	return 1
end

local function fn13(p, value)
	local v30 = 10 ^ (value or 0)
	return math.floor(p * v30 + 0.5) / v30
end

local function fn14()
	if _T.playingCamera then
		return mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_CameraSpeed", false, {
			SPEED = fn13(mCameraSpeedMult, 1)
		})
	end

	return mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_CameraDuration", false, {
		TIME = fn13(mCameraDuration, 1)
	})
end

local function fn15()
	return mCameraDuration
end

local function fn16(p)
	local cinMaterial = cinMaterial

	if v11 then
		cinMaterial = cinMaterialWhiteRoom
	end

	mLabel = tonumber(p.mLabel)
	local v30 = not (mLabel < 1) and 5000 or MAX_FAR_PLANE

	if not __wf_atom_7e8ad928(cinMaterial) then
		local v31 = v30 * 1.2 * p.mLabel
		local v32 = v30 * p.mLabel

		if mChecked then
			cinMaterial:__wf_atom_a042ff6c(COLOR_CORRECTION_DEPTH_PARAM, v31, v32)
		else
			cinMaterial:__wf_atom_a042ff6c(COLOR_CORRECTION_DEPTH_PARAM, v32, v31)
		end
	end
end

local function fn17(p)
	local v30

	if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) then
		v30 = _T.PhotoBoothCameraSpot:__wf_atom_c277aed8() or nil
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	v6.SettingControlValues = true

	for i = 1, v6.CustomizationList:GetHowManyElements() do
		local elementInIndex = v6.CustomizationList:GetElementInIndex(i)

		local function fn18(elementInIndex2, p2)
			if elementInIndex2.mButton.mButtons ~= nil and #elementInIndex2.mButton.mButtons > 0 then
				elementInIndex.mButton.mButtons[1]:SetValue(p2)
			end
		end

		if elementInIndex.IsDofControl then
			if elementInIndex.IsDistance then
				fn18(elementInIndex, dofDistance)
			elseif elementInIndex.IsDepth then
				fn18(elementInIndex, dofDepth)
			elseif elementInIndex.IsHorizon then
				fn18(elementInIndex, dofHorizon)
			end

			function elementInIndex.IsEnabledCheck()
				return mChecked6
			end
		elseif elementInIndex.IsDofOn then
			fn18(elementInIndex, mChecked6)
		elseif elementInIndex.IsFilterOpacity then
			fn18(elementInIndex, mLabel2)
		elseif elementInIndex.IsFilterDepth then
			fn18(elementInIndex, mLabel)
		elseif elementInIndex.IsTextSelection then
			if #v25 > 0 then
				elementInIndex.NameTag = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_CurrentText", false) .. v25[v26].Text
			end
		elseif elementInIndex.IsFirstTextColor then
			if #v25 > 0 then
				mActiveColors:SetColor(4, v25[v26].FirstColor)
			end
		elseif elementInIndex.IsSecondTextColor then
			if #v25 > 0 then
				mActiveColors:SetColor(5, v25[v26].SecondColor)
			end
		elseif elementInIndex.IsColorGradient then
			elementInIndex.mButton.mDropDown:SelectElementById(fn12(gradient))
		elseif elementInIndex.IsSloMoMultiplier then
			elementInIndex.mButton.mDropDown:SelectElementById(fn10(multiplier))
		elseif elementInIndex.IsRoomColor then
			mActiveColors:SetColor(3, v29)
		elseif elementInIndex.IsLightControl then
			if elementInIndex.IsLightRotation then
				fn18(elementInIndex, lightRotation)
			elseif elementInIndex.IsMainBrightness then
				fn18(elementInIndex, fn13(mainLight2.Brightness, 2))
			elseif elementInIndex.IsFillBrightness then
				fn18(elementInIndex, fn13(fillLight2.Brightness, 2))
			elseif elementInIndex.IsRimBrightness then
				fn18(elementInIndex, fn13(rimLight2.Brightness, 2))
			elseif elementInIndex.IsMainColor then
				mActiveColors:SetColor(0, mainLight2.Instance:GetColor())
			elseif elementInIndex.IsFillColor then
				mActiveColors:SetColor(1, fillLight2.Instance:GetColor())
			elseif elementInIndex.IsRimColor then
				mActiveColors:SetColor(2, rimLight2.Instance:GetColor())
			end
		elseif elementInIndex.IsLightsOn then
			fn18(elementInIndex, lightsOn)
		elseif elementInIndex.IsAmbientLight then
			fn18(elementInIndex, fn13(v19.Current, 2))
		elseif elementInIndex.IsTimeOfDay then
			if not __wf_atom_7e8ad928(v12) then
				fn18(elementInIndex, v12:__wf_atom_cb3427c9())
			end
		elseif elementInIndex.IsWeather then
			if not __wf_atom_7e8ad928(v12) then
				fn18(elementInIndex, v12:__wf_atom_28fbc509())
			end
		elseif elementInIndex.IsExposure then
			if not __wf_atom_7e8ad928(postProcess) then
				fn18(elementInIndex, postProcess.targetExposure)
			end
		elseif elementInIndex.IsGrain then
			if not __wf_atom_7e8ad928(postProcess) then
				fn18(elementInIndex, postProcess.grainBias)
			end
		elseif elementInIndex.IsSaturation then
			if not __wf_atom_7e8ad928(postProcess) then
				fn18(elementInIndex, postProcess.saturation)
			end
		elseif elementInIndex.IsFade then
			if not __wf_atom_7e8ad928(postProcess) then
				fn18(elementInIndex, __wf_atom_8ad59546:__wf_atom_89894bd1())
			end
		elseif elementInIndex.IsFov then
			if not __wf_atom_7e8ad928(v30) then
				fn18(elementInIndex, v30)
			end
		elseif elementInIndex.IsCameraSpeed then
			if p then
				fn18(elementInIndex, mCameraSpeedMult)
				elementInIndex.mSteps = SPEED_STEP
			else
				fn18(elementInIndex, fn15())
				elementInIndex.mSteps = DURATION_STEP
			end

			elementInIndex.NameTag = fn14()
		elseif elementInIndex.IsCameraEase then
			fn18(elementInIndex, mCameraEase)
		end

		v6.CustomizationList.mElementDrawCallback(elementInIndex)
	end

	v6.SettingControlValues = false
end

local function fn18(p, p2)
	local mCameraData = mCameraDatas[p]
	mCameraDuration = mCameraData.duration
	mCameraSpeed = mCameraData.speed
	mCameraEase = mCameraData.ease

	if mCameraData.slowMultiplier ~= nil then
		gGameRules:__wf_atom_4827188a(mCameraData.slowMultiplier)
	end

	if not __wf_atom_7e8ad928(mCamera) then
		mCamera:__wf_atom_b4338d31(mCameraData.rotation)
		mCamera:Teleport(mCameraData.position, mCameraData.rotation)
	end

	if mInterpolateVisualFx or p2 then
		if not __wf_atom_7e8ad928(gradient) then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:CameraControl():__wf_atom_344d785e(gradient, mCameraData.filterOpacity)
			end

			fn16({ mLabel = mCameraData.filterDepth })
		end

		if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) then
			mChecked6 = mCameraData.dofOn == 1
			dofDistance = mCameraData.dofDistance
			dofDepth = mCameraData.dofDepth
			local ternary = module2.Ternary(mChecked6, dofDistance, 0)
			local ternary2 = module2.Ternary(mChecked6, dofDepth, 10000)
			_T.PhotoBoothCameraSpot:__wf_atom_8c3d9704(ternary)
			_T.PhotoBoothCameraSpot:__wf_atom_7e990320(ternary2)
			_T.PhotoBoothCameraSpot:__wf_atom_888efbe9(mCameraData.fov)
		end

		v19.Current = mCameraData.sceneLight

		for _, light in ipairs(v19.Lights) do
			light.Instance:__wf_atom_edd3fec6(light.InitialBrigtness * v19.Current)
		end

		local postProcess = gRegion:__wf_atom_8ad59546().postProcess
		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

		if not __wf_atom_7e8ad928(postProcess) then
			postProcess.targetExposure = mCameraData.exposure
			postProcess.saturation = mCameraData.saturation
			postProcess.lightMapBoost = v19.mInitialLightMapBoost * v19.Current
			__wf_atom_8ad59546:__wf_atom_47f0b80b(mCameraData.fade)
			postProcess.grainBias = mCameraData.grain
			dofHorizon = mCameraData.dofHorizon
			postProcess.horizonDOF = module2.Ternary(mChecked6, dofHorizon, 0)
		end

		if not __wf_atom_7e8ad928(v12) then
			v12:SetTimeOfDay(mCameraData.timeOfDay)
			v12:__wf_atom_0f30a0c5(mCameraData.weather)
		end
	end
end

local function fn19()
	local v30 = _T.playingCamera and "/Lotus/Language/Menu/Photobooth_StopCamera"
		or "/Lotus/Language/Menu/Photobooth_PlayCamera"
	return mMovie:__wf_atom_8e9ac384(v30, false)
end

local function fn20()
	local module8 = require("Lotus.Interface.Components.Button")
	local v30 = _T.playingCamera and "/Lotus/Language/SystemMessages/Photobooth_Stop"
		or "/Lotus/Language/SystemMessages/Photobooth_Play"
	v9 = module8.CreateButton(
		mMovie,
		"CameraControls.PlayBtn",
		v30,
		"PlayCamera",
		"<PHOTOBOOTH_TOGGLE_CONTROL>",
		nil,
		nil,
		true
	)
	v9.mShowCallout = true
	v9.mClickable = true
	v9.mFitToText = true
	v9.mFittedPadding = 14
	v9.mFittedPaddingWithController = 14
	v9:Redraw()
	local v31 = mLoopCamera and "/Lotus/Language/SystemMessages/Photobooth_Loop"
		or "/Lotus/Language/SystemMessages/Photobooth_NoLoop"
	v10 = module8.CreateButton(mMovie, "CameraControls.LoopBtn", v31, "ToggleLoop", "", nil, nil, true)
	v10.mFitToText = true
	v10.mFittedPadding = 14
	v10.mFittedPaddingWithController = 14
	v10:Redraw()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("CameraControls.LoopBtn", 0)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("CameraControls.PlayBtn.Btn", 14)
	mMovie:__wf_atom_e57658c2("CameraControls.PlayBtn", 0, __wf_atom_5e6e15c8 - __wf_atom_5e6e15c8_2 - 10)
end

local function fn21()
	for i = 1, v6.CustomizationList:GetHowManyElements() do
		local elementInIndex = v6.CustomizationList:GetElementInIndex(i)

		if __wf_atom_7e8ad928(elementInIndex.IsPlayCamera) then
			continue
		end

		elementInIndex.NameTag = fn19()
		v6.CustomizationList.mElementDrawCallback(elementInIndex)
		break
	end

	fn20()
end

local function fn22()
	local positions = {}

	for i = 1, #mCameraDatas do
		table.insert(positions, mCameraDatas[i].position)
	end

	local __wf_atom_da63a334 = gGameRules:__wf_atom_da63a334(positions)

	if #__wf_atom_da63a334 ~= #mCameraDatas then
		print("FAILED TO FIND ALL POINTS")
	end

	local count = #mCameraDatas
	local v30 = 0

	for i = 2, count do
		if i <= #__wf_atom_da63a334 then
			v30 = __wf_atom_da63a334[i] - __wf_atom_da63a334[i - 1]
		end

		mCameraDatas[i - 1].tValue = __wf_atom_da63a334[i - 1]
		mCameraDatas[i - 1].speed = v30 / mCameraDatas[i - 1].duration
	end

	mCameraDatas[count].tValue = __wf_atom_da63a334[#__wf_atom_da63a334]
	mCameraDatas[count].speed = mCameraDatas[count - 1].speed
end

local function fn23()
	gGameRules:__wf_atom_d595770f()

	if __wf_atom_7e8ad928(mCameraDatas) or #mCameraDatas < MIN_CAMERA_DATA then
		return
	end

	local positions = {}
	local v30 = {}
	local v31 = {}
	local v32 = {}
	local v35 = {}
	local v36 = {}
	local v37 = {}
	local v38 = {}

	for i = 1, #mCameraDatas do
		local mCameraData = mCameraDatas[i]

		if __wf_atom_7e8ad928(mCameraData) then
			continue
		end

		table.insert(positions, mCameraData.position)
		table.insert(
			v30,
			Vector(mCameraData.duration, mCameraData.slowMultiplier == nil and 1 or mCameraData.slowMultiplier, 0)
		)
		table.insert(v31, Vector(mCameraData.dofDistance, mCameraData.dofDepth, mCameraData.dofOn))
		table.insert(v32, Vector(mCameraData.dofHorizon, 0, 0))
		table.insert(v35, Vector(mCameraData.exposure, mCameraData.grain, mCameraData.saturation))
		table.insert(v36, Vector(mCameraData.fov, mCameraData.filterOpacity, mCameraData.filterDepth))
		table.insert(v37, Vector(mCameraData.timeOfDay, mCameraData.weather, mCameraData.sceneLight))
		table.insert(v38, Vector(mCameraData.fade, 0, 0))
	end

	gGameRules:__wf_atom_5db13ce6(0, positions)
	gGameRules:__wf_atom_5db13ce6(1, v30)
	gGameRules:__wf_atom_5db13ce6(2, v31)
	gGameRules:__wf_atom_5db13ce6(6, v32)
	gGameRules:__wf_atom_5db13ce6(3, v35)
	gGameRules:__wf_atom_5db13ce6(4, v36)
	gGameRules:__wf_atom_5db13ce6(5, v37)
	gGameRules:__wf_atom_5db13ce6(7, v38)
	local rotations = {}

	for i = 1, #mCameraDatas do
		table.insert(rotations, mCameraDatas[i].rotation)
	end

	gGameRules:__wf_atom_659dc096(rotations)
end

local function fn24()
	for i = 1, #mCameraDatas do
		if not __wf_atom_7e8ad928(mCameraDatas[i].camName) then
			mCameraDatas[i].camName.Movie:Close()
			mCameraDatas[i].camName.Anchor:Destroy()
			mCameraDatas[i].camName = nil
		end

		if not __wf_atom_7e8ad928(mCameraDatas[i].camDeco) then
			gRegion:__wf_atom_dd1e4d10(mCameraDatas[i].camDeco)
		end
	end

	gRegion:__wf_atom_dd1e4d10(mCameraStartMarker)
	gRegion:__wf_atom_dd1e4d10(mCameraEndMarker)
	gRegion:__wf_atom_dd1e4d10(mCameraSplineDraw)
end

local function fn25()
	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gGameRules) then
		return
	end

	local count = #mCameraDatas

	if count < 1 then
		return
	end

	local v30 = Vector(0, 1, 0)
	local v31 = Type("/Lotus/Interface/Objects/DojoBillboardTextParentDeco")

	for i = 1, count do
		local v32 = __wf_atom_e97f3142(mCameraDatas[i].rotation) * -0.25
		v32.y = -0.25
		mCameraDatas[i].camDeco = gRegion:CreateEntity(
			photoboothCameraDeco,
			mCameraDatas[i].position + v32,
			mCameraDatas[i].rotation
		)

		if __wf_atom_7e8ad928(textMovie) then
			continue
		end

		local entity = gRegion:CreateEntity(
			v31,
			mCameraDatas[i].camDeco:GetPosition(),
			mCameraDatas[i].camDeco:__wf_atom_dc309f8a()
		)
		local __wf_atom_5d67a2c5 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(textMovie)
		__wf_atom_5d67a2c5:__wf_atom_8a679cf7(entity, v30, __wf_atom_80368bb1, Vector(1, 1, 1))

		if not (__wf_atom_7e8ad928(__wf_atom_5d67a2c5) or __wf_atom_7e8ad928(entity)) then
			entity:SetVisibility(false)
			__wf_atom_5d67a2c5:__wf_atom_18f27a89(10)
			__wf_atom_5d67a2c5:__wf_atom_00010694(true)
			__wf_atom_5d67a2c5:Execute("HideBg", "true")
			__wf_atom_5d67a2c5:Execute("SetUserText", "")
			__wf_atom_5d67a2c5:Execute("SetMessage", (tostring(i)))
			__wf_atom_5d67a2c5:Execute(
				"SetTextColor",
				(tostring(module6.SRGBToLinear255(cameraNameTextColor):__wf_atom_dcecedb0()))
			)
		end

		mCameraDatas[i].camName = { Movie = __wf_atom_5d67a2c5, Anchor = entity }
	end

	mCameraStartMarker = gRegion:CreateEntity(photoboothStartDeco, mCameraDatas[1].position, __wf_atom_80368bb1)

	if MIN_CAMERA_DATA <= count then
		mCameraEndMarker = gRegion:CreateEntity(photoboothEndDeco, mCameraDatas[count].position, __wf_atom_80368bb1)
		local v32 = {}
		local v35 = 0
		table.insert(v32, (gGameRules:__wf_atom_c8454d7c(0, v35)))
		local v36

		while true do
			v36 = gGameRules:__wf_atom_c8454d7c(0, v35)
			table.insert(v32, v36)

			if v35 >= 1 then
				break
			end

			local v37 = v35 + 1 / 60
			v35 = v37 > 1 and 1 or v37
		end

		table.insert(v32, v36)
		mCameraSplineDraw = gRegion:CreateEntity(splineType, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		mCameraSplineDraw:__wf_atom_ff43aa5a(v32)
	end
end

local function fn26()
	_T.playingCamera = false
	fn21()
	fn17()

	if not mChecked4 then
		gGameRules:__wf_atom_9709a80e()
	end

	gGameRules:__wf_atom_e1f7152f(false)

	if __wf_atom_7e8ad928(mCameraAvatar) then
		local all = gRegion:FindAll(cameraAvatarType)

		if not (__wf_atom_7e8ad928(all) or __wf_atom_7e8ad928(all[1])) then
			mCameraAvatar = all[1]
		end
	end

	if not (__wf_atom_7e8ad928(mCameraAvatar) or __wf_atom_7e8ad928(mCamera)) then
		mCameraAvatar:SetPosition(mCamera:GetPosition())
	end

	fn23()

	if mVisualizeCamera then
		fn24()
		fn25()
	end
end

local function fn27(p)
	if _T.playingCamera and not p then
		fn26()
		return
	end

	if __wf_atom_7e8ad928(mCameraDatas) or #mCameraDatas < MIN_CAMERA_DATA then
		return
	end

	_T.playingCamera = true
	mCameraTimer = 0
	mCameraUpdateIndex = 1
	fn23()

	if mNeedsCameraSpeedUpdate then
		fn22()
		mNeedsCameraSpeedUpdate = false
	end

	fn18(1)
	fn21()
	fn17(true)
	gGameRules:__wf_atom_e1f7152f(true)
end

function PlayCamera()
	fn27()
end

local function fn28()
	if _T.playingCamera then
		fn26()
	end

	_T.editingCameraPos = 2
	fn8(true)
	fn18(mEditingCameraIndex, true)
	fn17()
end

local function fn29()
	if #mCameraDatas == 0 then
		return
	end

	if mEditingCameraIndex == nil then
		mEditingCameraIndex = 1
	else
		mEditingCameraIndex += 1

		if mEditingCameraIndex > #mCameraDatas then
			mEditingCameraIndex = 1
		end
	end

	fn28()
end

local function fn30()
	if #mCameraDatas == 0 then
		return
	end

	if mEditingCameraIndex == nil then
		mEditingCameraIndex = #mCameraDatas
	else
		mEditingCameraIndex -= 1

		if mEditingCameraIndex <= 0 then
			mEditingCameraIndex = #mCameraDatas
		end
	end

	fn28()
end

local function fn31(p)
	mEditingCameraIndex = tonumber(p)
	fn28()
	mEditingCameraIndex = nil
end

local function fn32(p)
	mEditingCameraIndex = tonumber(p)
	fn28()
end

function OnCameraPositionSelected(p)
	fn32(p)
end

local function fn33()
	module2.PlaySound(_G.UISound_Select)
	v24 = mMovie:PushChildMovie(genericMenuMovie)

	if not __wf_atom_7e8ad928(v24) then
		v24:Execute("SetTitle", "/Lotus/Language/Menu/Photobooth_EditCameraPositions")

		function _T.MenuSelectionDone(list)
			_T.GetMenuEntries = nil

			if list[1] ~= nil then
				mMovie:Execute("OnCameraPositionSelected", (tostring(list[1].Index)))
			end
		end

		v24:Execute("SetCallBack", "MenuSelectionDone")

		function _T.GetMenuEntries()
			local result = {}

			for i = 1, #mCameraDatas do
				table.insert(result, {
					Index = i,
					mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_CameraPos", false) .. " " .. i
				})
			end

			return result
		end

		v24:Execute("SetElementsFunction", "GetMenuEntries")
	end
end

local function fn34(p)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/UiElements/CAPTURA_ENABLED_SETTINGS_PROMPT",
		false,
		{
			REASON = mMovie:__wf_atom_8e9ac384(p, false)
		}
	)
	module2.ShowErrorMessage(__wf_atom_8e9ac384)
end

local function fn35(p)
	if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) then
		local dof = v16:DOF()

		if (__wf_atom_7e8ad928(dof) or not dof) and p.mChecked then
			mChecked6 = false
			fn34("/Lotus/Language/Menu/Options_Display_DOF")
		else
			mChecked6 = p.mChecked
			local ternary = module2.Ternary(mChecked6, dofDistance, 0)
			local ternary2 = module2.Ternary(mChecked6, dofDepth, 10000)
			local ternary3 = module2.Ternary(mChecked6, dofHorizon, 0)
			_T.PhotoBoothCameraSpot:__wf_atom_8c3d9704(ternary)
			_T.PhotoBoothCameraSpot:__wf_atom_7e990320(ternary2)
			local postProcess = gRegion:__wf_atom_8ad59546().postProcess

			if not __wf_atom_7e8ad928(postProcess) then
				postProcess.horizonDOF = ternary3
			end
		end

		v6.CustomizationList:RunForAllElements(function(p2)
			if p2.IsDofOn then
				p2.mButton.mCheckbox.mChecked = mChecked6
				v6.CustomizationList.mElementDrawCallback(p2)
			end
		end)
		v6.CustomizationList:RunEnabledChecks()
	end
end

local function fn36(p)
	if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) then
		dofDistance = p.mLabel
		_T.PhotoBoothCameraSpot:__wf_atom_8c3d9704(dofDistance)
	end
end

local function fn37(p)
	if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) then
		dofDepth = p.mLabel
		_T.PhotoBoothCameraSpot:__wf_atom_7e990320(dofDepth)
	end
end

local function fn38(p)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if not __wf_atom_7e8ad928(postProcess) then
		dofHorizon = p.mLabel
		postProcess.horizonDOF = p.mLabel
	end
end

local function fn39(p)
	if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) then
		_T.PhotoBoothCameraSpot:__wf_atom_888efbe9(p.mLabel)
	end
end

local function fn40(p)
	if not v16:Grain() and (__wf_atom_7e8ad928(v6) or not v6.SettingControlValues) then
		fn34("/Lotus/Language/Menu/Options_Display_Grain")
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if not __wf_atom_7e8ad928(postProcess) then
		postProcess.grainBias = p.mLabel
	end
end

local function fn41(p)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if not __wf_atom_7e8ad928(postProcess) then
		postProcess.targetExposure = p.mLabel
	end
end

local function fn42(p)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if not __wf_atom_7e8ad928(postProcess) then
		postProcess.saturation = p.mLabel
	end
end

local function fn43(p)
	gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(p.mLabel)
end

local function fn44(p)
	mChecked = p.mChecked
	fn16({ mLabel = mLabel })
end

local function fn45()
	v24 = module.OpenPhotoboothTileSelect(mMovie, v3)
end

local function fn46()
	module7.KillEnemies()
end

local function fn47()
	if not __wf_atom_7e8ad928(gGameRules) then
		local enemySelectorMovie = enemySelectorMovie
		_T.SelectingEnemies = true
		_T.SelectingEnemiesManifest = codexManifest
		v24 = mMovie:PushChildMovie(enemySelectorMovie)
	end
end

local function fn48()
	return mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_ClearCameraPos", false) .. " (" .. (__wf_atom_7e8ad928(mCameraDatas) and 0 or #mCameraDatas) .. ")"
end

local function fn49()
	for i = 1, v6.CustomizationList:GetHowManyElements() do
		local elementInIndex = v6.CustomizationList:GetElementInIndex(i)

		if __wf_atom_7e8ad928(elementInIndex.IsClearCamera) then
			continue
		end

		elementInIndex.NameTag = fn48()
		v6.CustomizationList.mElementDrawCallback(elementInIndex)
		break
	end
end

local function fn50(p)
	if __wf_atom_7e8ad928(mCameraDatas) then
		mCameraDatas = {}
	elseif #mCameraDatas >= MAX_CAMERA_DATA then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_CameraError", false, {
			CAMNUM = MAX_CAMERA_DATA
		})
		module2.ShowErrorMessage(__wf_atom_8e9ac384)
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_dd7246c7 = __wf_atom_eab484a7:__wf_atom_dd7246c7()

	if __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
		return
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local v30 = {
		position = __wf_atom_dd7246c7:__wf_atom_a2a18137(),
		rotation = __wf_atom_dd7246c7:__wf_atom_2f2bada0(),
		heading = __wf_atom_dd7246c7:__wf_atom_a06d543c(),
		duration = mCameraDuration,
		ease = mCameraEase,
		slowMultiplier = mChecked4 and multiplier or nil,
		filterOpacity = mLabel2,
		filterDepth = mLabel,
		dofOn = mChecked6 and 1 or 0,
		dofDistance = dofDistance,
		dofDepth = dofDepth,
		dofHorizon = dofHorizon,
		exposure = postProcess.targetExposure,
		grain = postProcess.grainBias,
		saturation = postProcess.saturation,
		fade = gRegion:__wf_atom_8ad59546():__wf_atom_89894bd1(),
		fov = _T.PhotoBoothCameraSpot:__wf_atom_c277aed8(),
		timeOfDay = __wf_atom_7e8ad928(v12) and 0 or v12:__wf_atom_cb3427c9() or 0,
		weather = __wf_atom_7e8ad928(v12) and 0 or v12:__wf_atom_28fbc509() or 0,
		sceneLight = v19.Current,
		mainLightBrightness = mainLight2.Brightness,
		fillLightBrightness = fillLight2.Brightness,
		rimLightBrightness = rimLight2.Brightness,
		lightRotation = lightRotation
	}

	if mEditingCameraIndex == nil then
		table.insert(mCameraDatas, v30)
	else
		fn24()

		if p then
			if mEditingCameraIndex + 1 > #mCameraDatas then
				table.insert(mCameraDatas, v30)
			else
				local mCameraData = mCameraDatas[#mCameraDatas]
				table.insert(mCameraDatas, mCameraData)

				for i = #mCameraDatas - 2, mEditingCameraIndex + 1, -1 do
					local mCameraData2 = mCameraDatas[i]
					mCameraDatas[i + 1] = mCameraData2
				end

				mCameraDatas[mEditingCameraIndex + 1] = v30
			end
		else
			mCameraDatas[mEditingCameraIndex] = v30
			fn8(false)
			mEditingCameraIndex = nil
			_T.editingCameraPos = nil
			fn3()
		end
	end

	if #mCameraDatas >= MIN_CAMERA_DATA then
		if not _T.playingCamera then
			fn23()
		end

		mNeedsCameraSpeedUpdate = true
	end

	if mVisualizeCamera then
		fn24()
		fn25()
	end

	fn49()
end

local function fn51()
	fn50(true)
end

local function fn52()
	local count = #mCameraDatas

	if count == 0 then
		return
	end

	fn24()

	if mEditingCameraIndex == nil then
		table.remove(mCameraDatas, count)
	else
		table.remove(mCameraDatas, mEditingCameraIndex)
		mEditingCameraIndex = nil
		fn8(false)
	end

	fn49()

	if _T.playingCamera and #mCameraDatas < MIN_CAMERA_DATA then
		fn26()
	elseif not _T.playingCamera then
		fn23()
	end

	mNeedsCameraSpeedUpdate = true

	if mVisualizeCamera then
		fn25()
	end
end

local function fn53(p)
	if p or not Engine.IsPlayingWithController() then
		if _T.playingCamera then
			fn26()
		end

		fn24()
		mCameraDatas = {}
		fn49()
		fn3()

		if mEditingCameraIndex ~= nil then
			fn8(false)
			mEditingCameraIndex = nil
			_T.editingCameraPos = nil
		end
	end
end

function ClearCameraPositions(p)
	if tonumber(p) == 4 then
		fn53(true)
	end
end

local function fn54(p)
	if _T.switchingPhotoControls then
		return
	end

	multiplier = p.Multiplier

	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_61a4925e() and mChecked4 then
		gGameRules:__wf_atom_4827188a(multiplier)
	end
end

local function fn55(p)
	mLabel2 = p.mLabel

	if not __wf_atom_7e8ad928(gradient) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:CameraControl():__wf_atom_344d785e(gradient, mLabel2)
		end
	end
end

local function fn56(p)
	local mIndex = nil
	local colorCorrection = v16:ColorCorrection()
	v6.CustomizationList:RunForAllElements(function(p2)
		if p2.IsColorGradient then
			mIndex = p2.mIndex
		end
	end)

	if _T.switchingPhotoControls then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local cameraControl = __wf_atom_c4f78a8f:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			if colorCorrection then
				if not __wf_atom_7e8ad928(gradient) then
					cameraControl:__wf_atom_928a45c5(gradient)
				end

				cameraControl:__wf_atom_abe9ab4a(false)
				cameraControl:__wf_atom_dc7b15db(p.Gradient, 0, -1, 0)
				cameraControl:__wf_atom_344d785e(p.Gradient, mLabel2)
				fn16({ mLabel = mLabel })

				if p.mIndex ~= 1 then
					cameraControl:__wf_atom_abe9ab4a(true)
				end

				gradient = p.Gradient
			else
				if not __wf_atom_7e8ad928(gradient) then
					cameraControl:__wf_atom_928a45c5(gradient)
				end

				local elementInIndex = v6.CustomizationList:GetElementInIndex(mIndex)

				if p.mIndex ~= 1 then
					fn34("/Lotus/Language/Menu/Options_Display_ColorCorrection")

					if elementInIndex.mInitialized then
						elementInIndex.mButton.mDropDown:SelectElementById(1)
					end
				end

				if elementInIndex.mInitialized then
					gradient = elementInIndex.mButton.mDropDown.mSelectedElement.Gradient
				end

				cameraControl:__wf_atom_abe9ab4a(false)
				cameraControl:__wf_atom_dc7b15db(gradient, 0, -1, 0)
			end
		end
	end

	v6.CustomizationList:RunEnabledChecks()
end

local function fn57()
	for i = 1, v6.CustomizationList:GetHowManyElements() do
		local elementInIndex = v6.CustomizationList:GetElementInIndex(i)

		if __wf_atom_7e8ad928(elementInIndex.IsCameraSpeed) then
			continue
		end

		elementInIndex.NameTag = fn14()
		v6.CustomizationList.mElementDrawCallback(elementInIndex)
		break
	end
end

local function fn58(p)
	mCameraDuration = p.mLabel
	fn57()
end

local function fn59(p)
	mCameraEase = p.mLabel
end

local function fn60()
	local tValue, tValue2

	if mCameraUpdateIndex < #mCameraDatas then
		tValue = mCameraDatas[mCameraUpdateIndex].tValue
		tValue2 = mCameraDatas[mCameraUpdateIndex + 1].tValue

		if not __wf_atom_7e8ad928(tValue2) and tValue2 <= mCameraTimer then
			mCameraUpdateIndex += 1
			mCameraDuration = mCameraDatas[mCameraUpdateIndex].duration
			mCameraSpeed = mCameraDatas[mCameraUpdateIndex].speed
			mCameraEase = mCameraDatas[mCameraUpdateIndex].ease
		end
	else
		tValue = 0
		tValue2 = 1
	end

	local v30 = tValue + (function(p, p2)
		if p2 <= 0 then
			return (math.pow(p, math.abs(p2) + 1))
		end

		return (math.pow(p, 1 - 0.5 * p2))
	end)((mCameraTimer - tValue) / (tValue2 - tValue), mCameraEase) * (tValue2 - tValue)
	gGameRules:__wf_atom_5dd59a41(v30, mLookAtAvatar)
	multiplier = math.max(0.1, gGameRules:__wf_atom_c8454d7c(1, v30).y)

	if multiplier < 0.9 then
		gGameRules:__wf_atom_4827188a(multiplier)
	else
		gGameRules:__wf_atom_9709a80e()
	end

	if mInterpolateVisualFx then
		if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) then
			local __wf_atom_c8454d7c = gGameRules:__wf_atom_c8454d7c(2, v30)
			dofDistance = math.max(0, __wf_atom_c8454d7c.x)
			dofDepth = math.max(0, __wf_atom_c8454d7c.y)

			if mChecked6 and __wf_atom_c8454d7c.z <= 0.05 or not mChecked6 and __wf_atom_c8454d7c.z >= 0.95 then
				mChecked6 = not mChecked6
			end

			local ternary = module2.Ternary(mChecked6, dofDistance, 0)
			local ternary2 = module2.Ternary(mChecked6, dofDepth, 10000)
			_T.PhotoBoothCameraSpot:__wf_atom_8c3d9704(ternary)
			_T.PhotoBoothCameraSpot:__wf_atom_7e990320(ternary2)
			local __wf_atom_c8454d7c2 = gGameRules:__wf_atom_c8454d7c(4, v30)
			_T.PhotoBoothCameraSpot:__wf_atom_888efbe9((math.max(MIN_FOV, __wf_atom_c8454d7c2.x)))

			if not __wf_atom_7e8ad928(gradient) then
				local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

				if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f:CameraControl())) then
					__wf_atom_c4f78a8f:CameraControl():__wf_atom_344d785e(gradient, __wf_atom_c8454d7c2.y)
				end

				fn16({ mLabel = __wf_atom_c8454d7c2.z })
			end
		end

		local postProcess = gRegion:__wf_atom_8ad59546().postProcess

		if not __wf_atom_7e8ad928(postProcess) then
			local __wf_atom_c8454d7c = gGameRules:__wf_atom_c8454d7c(3, v30)
			postProcess.targetExposure = math.max(MIN_EXPOSURE, __wf_atom_c8454d7c.x)
			postProcess.grainBias = math.max(MIN_GRAIN, __wf_atom_c8454d7c.y)
			postProcess.saturation = math.max(MIN_SATURATION, __wf_atom_c8454d7c.z)
			dofHorizon = math.max(0, gGameRules:__wf_atom_c8454d7c(6, v30).x)
			postProcess.horizonDOF = module2.Ternary(mChecked6, dofHorizon, 0)
			local __wf_atom_c8454d7c2 = gGameRules:__wf_atom_c8454d7c(7, v30)
			gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(__wf_atom_c8454d7c2.x)
		end

		if not __wf_atom_7e8ad928(v12) then
			local __wf_atom_c8454d7c = gGameRules:__wf_atom_c8454d7c(5, v30)
			v12:SetTimeOfDay((math.max(0, __wf_atom_c8454d7c.x)))
			v12:__wf_atom_0f30a0c5((math.max(0, __wf_atom_c8454d7c.y)))

			if not __wf_atom_7e8ad928(postProcess) then
				v19.Current = math.max(v19.Min, __wf_atom_c8454d7c.z)

				for _, light in ipairs(v19.Lights) do
					light.Instance:__wf_atom_edd3fec6(light.InitialBrigtness * v19.Current)
				end

				postProcess.lightMapBoost = v19.mInitialLightMapBoost * v19.Current
			end
		end
	end

	if mCameraTimer >= 1 then
		if mLoopCamera then
			fn27(true)
		else
			fn26()
		end
	end

	mCameraTimer += __wf_atom_fa1258d0() * mCameraSpeed * mCameraSpeedMult

	if mCameraTimer > 1 then
		mCameraTimer = 1
	end
end

local function fn61()
	if not __wf_atom_7e8ad928(gGameRules) and gRegion:IsMaster() then
		if gGameRules:Paused() then
			gGameRules:__wf_atom_9141808b()
		elseif mChecked5 then
			gGameRules:__wf_atom_fb52d63c()
		end
	end
end

local function fn62()
	if not __wf_atom_7e8ad928(gGameRules) and not mChecked5 and gRegion:IsMaster() then
		gGameRules:__wf_atom_fb52d63c()
	end
end

local function fn63(p)
	mChecked5 = p.mChecked
	gRegion:__wf_atom_eab484a7():__wf_atom_5e4f5566(mChecked5)
end

local function fn64(p)
	mChecked4 = p.mChecked

	if not __wf_atom_7e8ad928(gGameRules) then
		if mChecked4 then
			gGameRules:__wf_atom_4827188a(multiplier)
		else
			gGameRules:__wf_atom_9709a80e()
		end
	end
end

local function fn65(p)
	mLookAtAvatar = p.mChecked
end

local function fn66()
	if _T.detachCamera == nil then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local __wf_atom_eff0517e = __wf_atom_eab484a7:__wf_atom_eff0517e()

		if not __wf_atom_7e8ad928(__wf_atom_eff0517e) then
			__wf_atom_eff0517e:MotionControl():__wf_atom_9ef8d7ef(_T.detachCamera)
		end

		local __wf_atom_04b7536b = __wf_atom_eab484a7:__wf_atom_04b7536b()

		if not __wf_atom_7e8ad928(__wf_atom_04b7536b) then
			__wf_atom_04b7536b:MotionControl():__wf_atom_9ef8d7ef(_T.detachCamera)
		end
	end
end

local function fn67(p)
	if __wf_atom_7e8ad928(_T.detachCamera) then
		_T.detachCamera = false
	end

	_T.detachCamera = p.mChecked
	fn66()
end

local function fn68()
	mLoopCamera = not mLoopCamera
	fn20()
end

function ToggleLoop()
	fn68()
end

local function fn69()
	mVisualizeCamera = not mVisualizeCamera

	if mVisualizeCamera then
		fn25()
	else
		fn24()
	end

	fn4()
end

local function fn70()
	local v30 = (v26 > #v25 or v25[v26] == nil) and "" or v25[v26].Text

	for i = 1, v6.CustomizationList:GetHowManyElements() do
		local elementInIndex = v6.CustomizationList:GetElementInIndex(i)

		if __wf_atom_7e8ad928(elementInIndex.IsTextSelection) then
			continue
		end

		elementInIndex.NameTag = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_CurrentText", false) .. v30
		v6.CustomizationList.mElementDrawCallback(elementInIndex)
		break
	end
end

local function fn71()
	local enabled = not __wf_atom_7e8ad928(v25) and #v25 > 0
	local howManyElements = v6.CustomizationList:GetHowManyElements()

	if enabled then
		mActiveColors:SetColor(4, v25[v26].FirstColor)
		mActiveColors:SetColor(5, v25[v26].SecondColor)
	end

	for i = 1, howManyElements do
		local elementInIndex = v6.CustomizationList:GetElementInIndex(i)

		if elementInIndex.IsTextScale and enabled then
			for _, mButton in pairs(elementInIndex.mButton.mButtons) do
				mButton:SetValue(v25[v26].Scale)
			end
		end

		if not elementInIndex.IsText then
			continue
		end

		elementInIndex.Enabled = enabled
		v6.CustomizationList.mElementDrawCallback(elementInIndex)
	end
end

local function fn72(value)
	if #v25 == 0 then
		return
	end

	if value == nil or type(value) ~= "number" then
		v26 += 1

		if v26 > #v25 then
			v26 = 1
		end
	else
		v26 = value
	end

	fn70()
	fn71()
end

local function fn73(value)
	if __wf_atom_f8f86fc5(value, 1) ~= value then
		module2.ShowErrorMessage("/Lotus/Language/Menu/Photobooth_ProfanityError")
		return
	end

	_T.photoboothMsgText = value
	v25[v26].Movie:Execute("SetMessage", (tostring(value:gsub(",", "<COMMA>"))))
	v25[v26].Text = value
	fn72(v26)
end

function OnTextSet(p, _, p2)
	if tonumber(p2) == 4 then
		fn73(p)
	end
end

function OSKOnTextSet(p, p2)
	if not p then
		fn73(p2)
	end
end

local function fn74()
	if v25[v26] == nil then
		return
	end

	module3.ShowInputDialog(
		mMovie,
		"/Lotus/Language/Menu/Photobooth_SetText",
		v25[v26].Text,
		TEXT_CHAR_LIMIT,
		"OnTextSet",
		"OSKOnTextSet"
	)
end

local function fn75()
	if #v25 == 0 or __wf_atom_7e8ad928(mCamera) then
		return
	end

	local __wf_atom_a2a18137 = mCamera:__wf_atom_a2a18137()
	local __wf_atom_2f2bada0 = mCamera:__wf_atom_2f2bada0()
	local v30 = __wf_atom_a2a18137 + __wf_atom_e97f3142(__wf_atom_2f2bada0) * 2
	v25[v26].Parent:SetPosition(v30)
	v25[v26].Parent:__wf_atom_9b788a35(__wf_atom_2f2bada0)
end

local function fn76()
	if #v25 == 0 then
		return
	end

	fn72(v26)
	v25[v26].Movie:Close()
	v25[v26].Parent:Destroy()
	table.remove(v25, v26)

	if v26 > #v25 then
		v26 = 1
	end

	fn70()
	fn71()
end

local function fn77(p)
	if #v25 == 0 then
		return
	end

	local mLabel3 = p.mLabel
	v27 = mLabel3
	v25[v26].Scale = mLabel3
	v25[v26].Parent:SetMeshScale(mLabel3)
end

local function fn78()
	if #v25 >= MAX_TEXT then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_TextError", false, {
			TEXTNUM = MAX_TEXT
		})
		module2.ShowErrorMessage(__wf_atom_8e9ac384)
	else
		if __wf_atom_7e8ad928(mCamera) then
			return
		end

		local __wf_atom_a2a18137 = mCamera:__wf_atom_a2a18137()
		local __wf_atom_2f2bada0 = mCamera:__wf_atom_2f2bada0()
		local v30 = __wf_atom_a2a18137 + __wf_atom_e97f3142(__wf_atom_2f2bada0) * 2
		v26 = #v25 + 1
		local entity = gRegion:CreateEntity(textParentDeco, v30, __wf_atom_2f2bada0)
		local __wf_atom_5d67a2c5 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(textMovie)

		if not (__wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(__wf_atom_5d67a2c5)) then
			entity:SetVisibility(false)
			__wf_atom_5d67a2c5:__wf_atom_18f27a89(200)
			__wf_atom_5d67a2c5:__wf_atom_00010694(false)
			__wf_atom_5d67a2c5:Execute("HideBg", "true")
			__wf_atom_5d67a2c5:Execute("SetUserText", "")
			__wf_atom_5d67a2c5:__wf_atom_8a679cf7(entity, Vector(), Rotation(), Vector(1, 1, 1))
			__wf_atom_5d67a2c5:__wf_atom_f62a8704("SetVertexColors", {
				tostring(module6.SRGBToLinear255(v28.First):__wf_atom_dcecedb0()),
				(tostring(module6.SRGBToLinear255(v28.Second):__wf_atom_dcecedb0()))
			})
			table.insert(v25, {
				Movie = __wf_atom_5d67a2c5,
				Parent = entity,
				Text = "Text",
				FirstColor = v28.First,
				SecondColor = v28.Second,
				Scale = v27
			})
			fn74()
		end
	end
end

local function fn79(p)
	local v30 = v17

	if v2:IsA(__wf_atom_c0fefb76) then
		v30 = v18
	end

	lightsOn = p.mChecked
	v30.LightsOn = lightsOn
	local v31 = { mainLight2.Instance, fillLight2.Instance, rimLight2.Instance }

	for _, v32 in ipairs(v31) do
		if lightsOn then
			v32:TurnOn()
		else
			v32:TurnOff()
		end
	end

	v6.CustomizationList:RunForAllElements(function(p2)
		if p2.IsLightControl then
			v6.CustomizationList.mElementDrawCallback(p2)
		end
	end)
end

local function fn80(p)
	local v30 = v17

	if v2:IsA(__wf_atom_c0fefb76) then
		v30 = v18
	end

	lightsOn = v30.LightsOn
	mainLight2 = v30.MainLight
	fillLight2 = v30.FillLight
	rimLight2 = v30.RimLight
	lightRotation = v30.LightRotation

	if not p then
		fn17()
	end
end

local function fn81(instance, p)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	local v30 = v17

	if instance:IsA(__wf_atom_c0fefb76) then
		v30 = v18
	end

	local v31 = Symbol()
	v30.MainLight.Type = mainLight
	v30.FillLight.Type = fillLight
	v30.RimLight.Type = rimLight
	v30.MainLight.Offset = Vector(1.685398, 2.1435411, 0.181058)
	v30.FillLight.Offset = Vector(-1.0404561, 1.943356, 1.798421)
	v30.RimLight.Offset = Vector(-1.426972, 1.209541, -1.333951)
	v30.MainLight.Rotation = Rotation(-104.67, 32.75, 2.39)
	v30.FillLight.Rotation = Rotation(149.33, 32.75, 2.39)
	v30.RimLight.Rotation = Rotation(55.96, -2.23, 2.01)
	local v32 = { v30.MainLight, v30.FillLight, v30.RimLight }

	for _, v35 in ipairs(v32) do
		v35.Instance = instance:__wf_atom_bb3e7833(v35.Type)

		if __wf_atom_7e8ad928(v35.Instance) then
			v35.Instance = instance:Attach(v35.Type, v31, v35.Offset, v35.Rotation)
		end

		v35.Color = v35.Instance:GetColor()
		v35.Brightness = v35.Instance:__wf_atom_7b3a5764()
		v35.InitBrightness = v35.Brightness

		if not v30.LightsOn then
			v35.Instance:TurnOff()
		end

		v30.MainLight.TestInstance = nil
	end

	fn80(p)
end

local function fn82()
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	if not __wf_atom_7e8ad928(all) then
		for i = 1, #all do
			if not all[i]:__wf_atom_1d13ef4d() then
				continue
			end

			v12 = all[i]
			break
		end
	end

	fn81(gRegion:__wf_atom_c4f78a8f(), true)
	v19.Lights = {}
	local all2 = gRegion:FindAll(__wf_atom_d00f34c2)

	for i = 1, #all2 do
		if __wf_atom_7e8ad928(all2[i]) or all2[i]:IsA(mainLight) or all2[i]:IsA(fillLight) or all2[i]:IsA(rimLight) then
			continue
		end

		if not all2[i]:__wf_atom_18b12ed1() then
			continue
		end

		table.insert(v19.Lights, {
			Instance = all2[i],
			InitialBrigtness = all2[i]:__wf_atom_7b3a5764()
		})
	end
end

local function fn83(p)
	local v30 = v17

	if v2:IsA(__wf_atom_c0fefb76) then
		v30 = v18
	end

	lightRotation = p.mLabel
	v30.LightRotation = lightRotation
	local v31 = Rotation(lightRotation, 0, 0)
	local v32 = { mainLight2, fillLight2, rimLight2 }

	for _, v35 in ipairs(v32) do
		local v36 = __wf_atom_9341614d(v35.Offset, v31)
		local v37 = __wf_atom_d919c2d7(v31, v35.Rotation)
		v35.Instance:__wf_atom_e310f01f(v36, v37)
	end
end

local function fn84(p)
	if not __wf_atom_7e8ad928(v12) then
		v12:SetTimeOfDay(p.mLabel)
	end
end

local function fn85(p)
	if not __wf_atom_7e8ad928(v12) then
		v12:__wf_atom_0f30a0c5(p.mLabel)
	end
end

local function fn86(p)
	v19.Current = p.mLabel

	for _, light in ipairs(v19.Lights) do
		light.Instance:__wf_atom_edd3fec6(light.InitialBrigtness * v19.Current)
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if not __wf_atom_7e8ad928(postProcess) then
		postProcess.lightMapBoost = v19.mInitialLightMapBoost * v19.Current
	end
end

local function fn87(state, p)
	state.Brightness = p.mLabel
	state.Instance:__wf_atom_edd3fec6(state.Brightness)
end

local function fn88(p, color)
	p.Color = color
	p.Instance:SetColor(color)
end

local function fn89()
	return not gRegion:IsMaster()
end

local function fn90(p)
	mChecked3 = p.mChecked
	local all = gRegion:FindAll(__wf_atom_7e6ed5fa)
	local count = 0

	for i = 1, #all do
		if __wf_atom_7e8ad928(all[i]:__wf_atom_0d9c1a58()) then
			continue
		end

		if mChecked3 then
			all[i]:SetFaction(Symbol("Enemy" .. tostring(count)))
			count += 1
		else
			all[i]:SetFaction(Symbol("TENNO"))
		end
	end
end

local function fn91(p)
	mChecked2 = p.mChecked
	local all = gRegion:FindAll(__wf_atom_7e6ed5fa)

	if mChecked2 then
		for i = 1, #all do
			all[i]:__wf_atom_7470861b():__wf_atom_56b2394e(7, v14)
			all[i]:__wf_atom_7470861b():__wf_atom_9f17ac89(v14)
		end
	else
		for i = 1, #all do
			all[i]:__wf_atom_7470861b():__wf_atom_1fa97530(7, v14)
			all[i]:__wf_atom_7470861b():__wf_atom_77b5f32e(v14)
		end
	end
end

local function fn92(p)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local __wf_atom_04b7536b = __wf_atom_eab484a7:__wf_atom_04b7536b()

		if not __wf_atom_7e8ad928(__wf_atom_04b7536b) then
			__wf_atom_04b7536b:__wf_atom_d2b2176d():__wf_atom_c8700ab5(p.mChecked)
		end
	end
end

local function fn93()
	if __wf_atom_7e8ad928(mCameraAvatar) then
		local all = gRegion:FindAll(cameraAvatarType)

		if not (__wf_atom_7e8ad928(all) or __wf_atom_7e8ad928(all[1])) then
			mCameraAvatar = all[1]
		end
	end

	if not (__wf_atom_7e8ad928(mCameraAvatar) or __wf_atom_7e8ad928(mCamera)) then
		mCameraAvatar:Teleport(mCamera:__wf_atom_a2a18137())
	end
end

local function fn94(p)
	v21 = p
	v22 = nil

	if p and not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.diegeticsVisibilityOverride = true
		local v30 = v6.CustomizationList.mElementWidth + module2.Ternary(module4.UsingBrightBackground(), 230, 115)
		local v31 = {
			Center = 1,
			Size = module2.GetVisibilitySize(mMovie, v30 * 2, true),
			FadeSize = module2.GetVisibilityFadeSize(mMovie, 20)
		}
		_T.BackgroundMovie:Execute("SetBackgroundDepthTest", "false")
		_T.ShowBackground(0.25, nil, nil, v31)
	elseif not (p or __wf_atom_7e8ad928(_T.HideBackground)) then
		_T.HideBackground()
		_T.BackgroundMovie:Execute("SetBackgroundDepthTest", "true")
	end
end

local function fn95()
	v7:RemoveElements(true, true)
	local mBindings = "<SHOW_SECRET_1>" .. module2.Ternary(_T.freeCamActive, "/ <PHOTOBOOTH_CAMERA_EXIT>", "")

	if Engine.__wf_atom_dd1285f1() then
		mBindings = module2.Ternary(_T.freeCamActive, "<PHOTOBOOTH_CAMERA_EXIT>", "<SHOW_SECRET_1>")
	end

	if gRegion:IsMaster() then
		v7:AddElement({
			mBindings = mBindings,
			mDesc = "/Lotus/Language/Menu/Photobooth_FreeCamToggle_Desc"
		}, true)
	end

	if not v5 and _T.freeCamActive then
		if not mAddCameraMode then
			v7:AddElement(
				{
					mBindings = "<PHOTOBOOTH_TOGGLE_CONTROL>",
					mDesc = "/Lotus/Language/Menu/Photobooth_Controls_Switch"
				},
				true
			)
		end

		local ternary = module2.Ternary(Engine.__wf_atom_dd1285f1(), "<SHOW_SECRET_1>", "<AIM_POWER>")
		v7:AddElement({
			mBindings = ternary,
			mDesc = "/Lotus/Language/Menu/Photobooth_Controls_PanelVis"
		}, true)
		local mBindings2

		if Engine.__wf_atom_e43a530e() then
			mBindings2 = "<GAMEPAD_SELECT>"
		elseif Engine.__wf_atom_84bb79c2() then
			mBindings2 = "<GAMEPAD_HOME>"
		elseif Engine.__wf_atom_dd1285f1() then
			mBindings2 = "<SHOW_LEVEL_MAP>"
		elseif Engine.__wf_atom_b290ec01() then
			mBindings2 = "<GAMEPAD_CAPTURE>"
		else
			mBindings2 = "<KEY><F6>"
		end

		if Engine.__wf_atom_dd1285f1() then
			v7:AddElement(
				{
					mBindings = mBindings2,
					mDesc = "/Lotus/Language/Mobile/Photobooth_Controls_ButtonsVis"
				},
				true
			)
		elseif not Engine.__wf_atom_2a979d69() then
			v7:AddElement(
				{
					mBindings = mBindings2,
					mDesc = "/Lotus/Language/Menu/Photobooth_Controls_ScreenShot"
				},
				true
			)
		end

		if gRegion:IsMaster() then
			v7:AddElement(
				{
					mBindings = "<PHOTOBOOTH_ADVANCE_TIME>",
					mDesc = "/Lotus/Language/Menu/Photobooth_Controls_AdvanceTime"
				},
				true
			)
		end

		local ternary2 = module2.Ternary(Engine.IsPlayingWithController(), "<RUN>", "<PRE_RUN>")
		local ternary3 = module2.Ternary(Engine.__wf_atom_dd1285f1(), "<RELOAD>", ternary2)
		local ternary4 = module2.Ternary(Engine.__wf_atom_dd1285f1(), "<MELEE>", "<AIM_WEAPON>")
		v7:AddElement({
			mBindings = ternary3,
			mDesc = "/Lotus/Language/Menu/Photobooth_Controls_FastMovement"
		}, true)
		v7:AddElement({
			mBindings = ternary4,
			mDesc = "/Lotus/Language/Menu/Photobooth_Controls_SlowMovement"
		}, true)
		v7:AddElement(
			{
				mBindings = "<ACCEL_Y:INVERT=1>",
				mDesc = "/Lotus/Language/Menu/Photobooth_Controls_Descend"
			},
			true
		)
		v7:AddElement({
			mBindings = "<ACCEL_Y>",
			mDesc = "/Lotus/Language/Menu/Photobooth_Controls_Ascend"
		}, true)
		v7:AddElement(
			{
				mBindings = "<TILT_YAW> / <TILT_YAW:INVERT=1>",
				mDesc = "/Lotus/Language/Menu/Photobooth_Controls_Tilt"
			},
			true
		)

		if mAddCameraMode then
			v7:AddElement({ mBindings = "", mDesc = "" }, true)
			local mDesc = mEditingCameraIndex == nil and "/Lotus/Language/SystemMessages/Photobooth_ConfirmCamera"
				or "/Lotus/Language/SystemMessages/Photobooth_ConfirmEdit"
			v7:AddElement({ mBindings = "<PHOTOBOOTH_TOGGLE_CONTROL>", mDesc = mDesc }, true)
		end
	end

	v7:Redraw(nil, false, true)
	mMovie:__wf_atom_2dedec1a("Panel.GenericMessage", 13, not v5 and v7:GetHowManyElements() > 0)
	mMovie:__wf_atom_2dedec1a("Panel.AreaPicker", 13, v5)

	if v5 then
		local v30 = math.min(v6.CustomizationList:GetHeight(), v6.CustomizationList.mMaxVisibleHeight) + 30
		mMovie:__wf_atom_e57658c2("Panel.AreaPicker", 1, -v30)
		v6.CustomizationList:UpdateVisRanges()
		v6.CustomizationList:RunEnabledChecks()
	end

	fn94(v5 and not mMovie:__wf_atom_a91463a8("CameraControls", 13))
end

local function fn96()
	mCinematicMode = true
	v6.CustListScrollBar:SetScrollValue(0, false, true)
	v6.CustomizationList:RemoveElements(true, true)
	local v30 = {}

	if _T.SetButtons then
		_T.SetButtons(mMovie, v30, getfenv(1))
	end

	mMovie:__wf_atom_fbca497c(false)
	mMovie:__wf_atom_2dedec1a("CameraControls", 13, false)
end

local function fn97()
	local v30 = math.max(0.01, mCameraSpeedControl.Value * 200)
	mMovie:__wf_atom_e57658c2("CameraControls.SpeedSlider.Slider", 14, v30)
end

local function fn98()
	if not (__wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(v6.CustomizationList)) then
		v6.ResetDefaults()
	end

	if mCameraSettings then
		mCameraSpeedMult = 1
		mCameraSpeedControl.Value = mCameraSpeedMult / MAX_SPEED_MULTIPLIER
		fn97()

		if mLoopCamera then
			fn68()
		end
	end
end

fn4 = function()
	local v30 = {}

	if v5 then
		if mCameraSettings then
			if mEditingCameraIndex == nil then
				table.insert(v30, {
					Label = mVisualizeCamera and "/Lotus/Language/SystemMessages/Photobooth_VisCameraOn" or "/Lotus/Language/SystemMessages/Photobooth_VisCameraOff",
					CallBack = fn69,
					CallOut = "MENU_LTHUMB",
					OverrideTintIcons = not mVisualizeCamera
				})
			else
				table.insert(v30, {
					Label = "/Lotus/Language/Menu/Global_Confirm",
					CallBack = fn50,
					CallOut = "MENU_LTHUMB"
				})
			end

			if mEditingCameraIndex == nil then
				table.insert(v30, {
					Label = "/Lotus/Language/Menu/Photobooth_CinMode",
					CallBack = fn96,
					CallOut = "MENU_GENERIC2"
				})

				if #mCameraDatas > 0 then
					table.insert(v30, {
						Label = "/Lotus/Language/Menu/Photobooth_ClearCameraPos",
						CallBack = fn53,
						CallOut = "MENU_RTRIGGER1"
					})
				end
			end
		end

		if not mCameraSettings or mEditingCameraIndex ~= nil then
			table.insert(v30, {
				Label = "/Lotus/Language/Menu/Global_Defaults",
				CallBack = fn98,
				CallOut = "MENU_GENERIC1"
			})
		end

		table.insert(v30, {
			Label = "/Lotus/Language/Menu/Global_Back",
			CallBack = fn,
			CallOut = "MENU_CANCEL"
		})
	end

	if _T.SetButtons then
		_T.SetButtons(mMovie, v30, getfenv(1))

		if not __wf_atom_7e8ad928(buttonBarMovieWRes) then
			local movie = __wf_atom_8e4fda44:FindMovie(buttonBarMovieWRes)

			if not __wf_atom_7e8ad928(movie) then
				movie:__wf_atom_2e64957a(false)
			end
		end
	end
end

local function fn99()
	mAddCameraMode = true
	v5 = false
	mMovie:__wf_atom_2dedec1a("CameraControls", 13, false)
	mMovie:__wf_atom_c884ca43(true)
	fn4()
	fn95()
end

local function fn100()
	return fn12(gradient) ~= 1 and v16:ColorCorrection()
end

local function fn101()
	local mDefaultValue, mInitialValue

	if __wf_atom_7e8ad928(v12) then
		mDefaultValue = 0
		mInitialValue = 0
	else
		mDefaultValue = fn13(v12:__wf_atom_cb3427c9(), 0)
		mInitialValue = fn13(v12:__wf_atom_28fbc509(), 2)
	end

	return {
		{ Type = module5.Types.TITLE, NameTag = "/Lotus/Language/Menu/Photobooth_Camera" },
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = fn14(),
			mInitialValue = fn15(),
			mDefaultValue = 10,
			mMaxValue = MAX_CAMERA_DURATION,
			mMinValue = MIN_CAMERA_DURATION,
			mSteps = DURATION_STEP,
			mValueChangedCallback = fn58,
			IsCameraSpeed = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_CameraEase",
			mDefaultValue = mInitials.Ease,
			mMaxValue = v.MAX_CAMERA_EASE,
			mMinValue = v.MIN_CAMERA_EASE,
			mSteps = v.EASE_STEP,
			mValueChangedCallback = fn59,
			IsCameraEase = true
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/Photobooth_DoFEnable",
			mInitialValue = mChecked6,
			mDefaultValue = true,
			mValueChangedCallback = fn35,
			IsDofOn = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_DoFFocalDistance",
			mMaxValue = 20,
			mMinValue = 0,
			mDecimals = 1,
			mDefaultValue = mInitials.DofDistance,
			IsDofControl = true,
			IsDistance = true,
			mValueChangedCallback = fn36
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_DoFFocalDepth",
			mMaxValue = 7,
			mMinValue = 0,
			mDecimals = 2,
			mDefaultValue = mInitials.DofDepth,
			IsDofControl = true,
			IsDepth = true,
			mValueChangedCallback = fn37
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Settings/Photobooth_DofHorizon",
			mInitialValue = dofHorizon,
			mDefaultValue = 0,
			mMaxValue = 1,
			mMinValue = 0,
			mDecimals = 2,
			mValueChangedCallback = fn38,
			IsDofControl = true,
			IsHorizon = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Exposure",
			mDefaultValue = mInitials.Exposure,
			mMaxValue = MAX_EXPOSURE,
			mMinValue = MIN_EXPOSURE,
			mSteps = EXPOSURE_STEP,
			mDecimals = 2,
			mValueChangedCallback = fn41,
			ShouldRemove = function()
				return v11
			end,
			IsExposure = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Options_DisplayCustomize_Fov",
			mMaxValue = MAX_FOV,
			mMinValue = MIN_FOV,
			mDecimals = 0,
			mDefaultValue = mInitials.Fov,
			mValueChangedCallback = fn39,
			IsFov = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_FilterOpacity",
			mMaxValue = 1,
			mMinValue = 0,
			mDecimals = 2,
			mInitialValue = mLabel2,
			mDefaultValue = 1,
			mValueChangedCallback = fn55,
			IsFilterOpacity = true,
			IsEnabledCheck = fn100
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_FilterDepth",
			mMinValue = 0,
			mMaxValue = 1,
			mDecimals = 2,
			mInitialValue = mLabel,
			mDefaultValue = 0,
			mValueChangedCallback = fn16,
			IsFilterDepth = true,
			IsEnabledCheck = fn100
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Grain",
			mMinValue = MIN_GRAIN,
			mMaxValue = MAX_GRAIN,
			mDecimals = 2,
			mDefaultValue = mInitials.Grain,
			mValueChangedCallback = fn40,
			IsGrain = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Saturation",
			mMinValue = MIN_SATURATION,
			mMaxValue = MAX_SATURATION,
			mDecimals = 2,
			mDefaultValue = mInitials.Saturation,
			mValueChangedCallback = fn42,
			IsSaturation = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Fade",
			mMinValue = FadeSettings.MIN_FADE,
			mMaxValue = FadeSettings.MAX_FADE,
			mDecimals = 2,
			mSteps = FadeSettings.FADE_STEP,
			mDefaultValue = mInitials.Fade,
			mValueChangedCallback = fn43,
			IsFade = true
		},
		{ Type = module5.Types.TITLE, NameTag = "/Lotus/Language/Menu/Photobooth_Lights" },
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_TimeOfDay",
			mMaxValue = MAX_TIME_OF_DAY,
			mMinValue = 0,
			mDecimals = 0,
			mDefaultValue = mDefaultValue,
			mValueChangedCallback = fn84,
			ShouldRemove = function()
				return (__wf_atom_7e8ad928(v12))
			end,
			IsTimeOfDay = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_AmbientLight",
			mMaxValue = v19.Max,
			mMinValue = v19.Min,
			mDecimals = 2,
			mInitialValue = mInitials.AmbientLight,
			mDefaultValue = 1,
			mValueChangedCallback = fn86,
			IsAmbientLight = true
		},
		{ Type = module5.Types.TITLE, NameTag = "/Lotus/Language/Menu/Photobooth_Level" },
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Weather",
			mMinValue = 0,
			mMaxValue = 1,
			mDecimals = 2,
			mInitialValue = mInitialValue,
			mDefaultValue = 0,
			mValueChangedCallback = fn85,
			ShouldRemove = function()
				return (__wf_atom_7e8ad928(v12))
			end,
			IsWeather = true
		},
		{
			Type = module5.Types.TITLE,
			NameTag = "/Lotus/Language/Menu/Photobooth_Level",
			ShouldRemove = function()
				return not __wf_atom_7e8ad928(v12)
			end
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/PhotoboothToggleSloMo",
			mInitialValue = mChecked4,
			mDefaultValue = false,
			mValueChangedCallback = fn64,
			ShouldRemove = fn89
		},
		{
			Type = module5.Types.DROP_DOWN,
			ContentWidth = 392,
			mOptions = fn9(),
			mInitialValue = fn10(multiplier),
			mDefaultValue = 1,
			mValueChangedCallback = fn54,
			ShouldRemove = fn89,
			IsSloMoMultiplier = true
		},
		{
			Type = module5.Types.BUTTON,
			TopTitle = "/Lotus/Language/SystemMessages/Photobooth_Edit",
			NameTag = TitleCase(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_EditCameraPos", false)),
			mOnReleasedCallback = fn33
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = TitleCase(mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/SystemMessages/Photobooth_EditNextCamera",
				false
			)),
			mOnReleasedCallback = fn29
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = TitleCase(mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/SystemMessages/Photobooth_EditPrevCamera",
				false
			)),
			mOnReleasedCallback = fn30
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/SystemMessages/Photobooth_AddNextCameraPos",
			mOnReleasedCallback = fn51,
			IsEnabledCheck = function()
				return mEditingCameraIndex ~= nil
			end,
			IsAddNextCameraPos = true
		}
	}
end

local function fn102()
	_T.switchingPhotoControls = true
	mCameraSettings = true
	v6.CustListScrollBar:SetEnabled(true)
	v6.CustListScrollBar:SetScrollValue(0, false, true)
	mMovie:__wf_atom_2dedec1a("CameraControls", 13, false)
	v6.CustomizationList:RemoveElements(true, true)
	local v30 = fn101()

	for _, v31 in ipairs(v30) do
		if v31.ShouldRemove == nil or not v31.ShouldRemove() then
			v6.CustomizationList:AddElement(v31, true)
		end
	end

	v6.CustomizationList:Redraw()
	fn95()
	fn17()

	if mEditingCameraIndex ~= nil then
		fn8(true)
	end

	fn49()
	_T.switchingPhotoControls = nil
end

local function fn103()
	mCameraSettings = false
	dofDistance = 0
	dofDepth = 0
	dofHorizon = 0
	local v30 = 65
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local exposure = mInitials.Exposure
	local grain = mInitials.Grain
	local saturation = mInitials.Saturation

	if not __wf_atom_7e8ad928(postProcess) and v15 == true then
		exposure = postProcess.targetExposure
		grain = postProcess.grainBias
		saturation = postProcess.saturation
	end

	if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) then
		dofDistance = _T.PhotoBoothCameraSpot:__wf_atom_1125762e()
		dofDepth = _T.PhotoBoothCameraSpot:__wf_atom_bb4142b8()
		v30 = _T.PhotoBoothCameraSpot:__wf_atom_c277aed8()
	end

	if v15 == false then
		mInitials.DofDistance = dofDistance
		mInitials.DofDepth = dofDepth
		mInitials.DofHorizon = 0
		mInitials.Fov = v30
		v15 = true
	end

	if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) and v15 == false then
		_T.PhotoBoothCameraSpot:__wf_atom_888efbe9(__wf_atom_104bfe98(MIN_FOV, MAX_FOV, mInitials.Fov))
	end

	local function fn104()
		return not __wf_atom_7e8ad928(v25) and #v25 ~= 0
	end

	local v31 = {
		{ Type = module5.Types.TITLE, NameTag = "/Lotus/Language/Menu/Photobooth_Camera" },
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/Photobooth_DoFEnable",
			mInitialValue = mChecked6,
			mDefaultValue = true,
			mValueChangedCallback = fn35,
			IsDofOn = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_DoFFocalDistance",
			mMaxValue = 20,
			mMinValue = 0,
			mDecimals = 1,
			mInitialValue = dofDistance,
			mDefaultValue = mInitials.DofDistance,
			IsDofControl = true,
			IsDistance = true,
			mValueChangedCallback = fn36
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_DoFFocalDepth",
			mMaxValue = 7,
			mMinValue = 0,
			mDecimals = 1,
			mInitialValue = dofDepth,
			mDefaultValue = mInitials.DofDepth,
			IsDofControl = true,
			IsDepth = true,
			mValueChangedCallback = fn37
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Settings/Photobooth_DofHorizon",
			mMaxValue = 1,
			mMinValue = 0,
			mDecimals = 2,
			mInitialValue = dofHorizon,
			mDefaultValue = mInitials.DofHorizon,
			mValueChangedCallback = fn38,
			IsDofControl = true,
			IsHorizon = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Exposure",
			mMaxValue = MAX_EXPOSURE,
			mMinValue = MIN_EXPOSURE,
			mSteps = EXPOSURE_STEP,
			mInitialValue = exposure,
			mDefaultValue = mInitials.Exposure,
			mDecimals = 2,
			mValueChangedCallback = fn41,
			ShouldRemove = function()
				return v11
			end,
			IsExposure = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Options_DisplayCustomize_Fov",
			mMaxValue = MAX_FOV,
			mMinValue = MIN_FOV,
			mDecimals = 0,
			mInitialValue = v30,
			mDefaultValue = mInitials.Fov,
			mValueChangedCallback = fn39,
			IsFov = true
		},
		{
			Type = module5.Types.DROP_DOWN,
			ContentWidth = 392,
			mOptions = fn11(),
			mInitialValue = fn12(gradient),
			mDefaultValue = 1,
			mValueChangedCallback = fn56,
			IsColorGradient = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_FilterOpacity",
			IsEnabledCheck = fn100,
			mInitialValue = mLabel2,
			mDefaultValue = 1,
			mMinValue = 0,
			mMaxValue = 1,
			mDecimals = 2,
			mValueChangedCallback = fn55,
			IsFilterOpacity = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_FilterDepth",
			IsEnabledCheck = fn100,
			mMinValue = 0,
			mMaxValue = 1,
			mDecimals = 2,
			mInitialValue = mLabel,
			mDefaultValue = 0,
			mValueChangedCallback = fn16,
			IsFilterDepth = true
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/Photobooth_FilterFlipped",
			IsEnabledCheck = fn100,
			mInitialValue = mChecked,
			mDefaultValue = false,
			mValueChangedCallback = fn44
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Grain",
			mMinValue = MIN_GRAIN,
			mMaxValue = MAX_GRAIN,
			mDecimals = 2,
			mInitialValue = grain,
			mDefaultValue = mInitials.Grain,
			mValueChangedCallback = fn40,
			IsGrain = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Saturation",
			mMinValue = MIN_SATURATION,
			mMaxValue = MAX_SATURATION,
			mDecimals = 2,
			mInitialValue = saturation,
			mDefaultValue = mInitials.Saturation,
			mValueChangedCallback = fn42,
			IsSaturation = true
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/Photobooth_LookAtAvatar",
			mInitialValue = mLookAtAvatar,
			mDefaultValue = false,
			mValueChangedCallback = fn65
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/Photobooth_DetachCamera",
			mInitialValue = not __wf_atom_7e8ad928(_T.detachCamera) and _T.detachCamera,
			mDefaultValue = false,
			mValueChangedCallback = fn67
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/Menu/Photobooth_CameraSettings",
			mOnReleasedCallback = function()
				if mEditingCameraIndex == nil then
					fn3()
				else
					fn102()
				end
			end
		},
		{ Type = module5.Types.TITLE, NameTag = "/Lotus/Language/Menu/Photobooth_TextTitle" },
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/Menu/Photobooth_AddText",
			mOnReleasedCallback = fn78
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/Menu/Photobooth_CurrentText",
			mOnReleasedCallback = fn72,
			IsTextSelection = true,
			IsText = true,
			IsEnabledCheck = fn104
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/Menu/Photobooth_EditText",
			mOnReleasedCallback = fn74,
			IsText = true,
			IsEnabledCheck = fn104
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/Menu/Photobooth_ReposText",
			mOnReleasedCallback = fn75,
			IsText = true,
			IsEnabledCheck = fn104
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_TextScale",
			mInitialValue = v27,
			mDefaultValue = 1,
			mMinValue = MIN_TEXT_SCALE,
			mMaxValue = MAX_TEXT_SCALE,
			mDecimals = 2,
			mValueChangedCallback = fn77,
			IsTextScale = true,
			IsText = true,
			IsEnabledCheck = fn104
		},
		{
			Type = module5.Types.COLOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_PrimaryTextColor",
			mColorRegions = { 4 },
			mDefaultColor = Color(_G.UIColor_White):__wf_atom_dcecedb0(),
			IsFirstTextColor = true,
			IsText = true,
			IsEnabledCheck = fn104
		},
		{
			Type = module5.Types.COLOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_SecondaryTextColor",
			mColorRegions = { 5 },
			mDefaultColor = Color(_G.UIColor_White):__wf_atom_dcecedb0(),
			IsSecondTextColor = true,
			IsText = true,
			IsEnabledCheck = fn104
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/Menu/Photobooth_RemoveText",
			mOnReleasedCallback = fn76,
			IsText = true,
			IsEnabledCheck = fn104
		}
	}
	fn2(v31)

	for _, v32 in pairs(v31) do
		if v32.IsDofControl and v32.IsEnabledCheck == nil then
			function v32.IsEnabledCheck()
				return mChecked6
			end
		end
	end

	return v31
end

fn2 = function(list)
	local v30 = __wf_atom_7e8ad928(v12) and 0 or fn13(v12:__wf_atom_cb3427c9(), 0)
	local lightRotation2 = mInitials.LightRotation
	local mInitialValue = fn13(mainLight2.InitBrightness, 2)
	local mInitialValue2 = fn13(fillLight2.InitBrightness, 2)
	local mInitialValue3 = fn13(rimLight2.InitBrightness, 2)
	local mInitialValue4 = fn13(mInitials.AmbientLight, 2)

	local function fn104()
		return lightsOn
	end

	local v31 = {
		{ Type = module5.Types.TITLE, NameTag = "/Lotus/Language/Menu/Photobooth_Lights" },
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/Photobooth_EnableLights",
			mInitialValue = lightsOn,
			mDefaultValue = false,
			mValueChangedCallback = fn79,
			IsLightsOn = true
		},
		{
			Type = module5.Types.COLOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_MainLight",
			mColorRegions = { 0 },
			mDefaultColor = mainLight2.Color:__wf_atom_dcecedb0(),
			IsEnabledCheck = fn104,
			IsLightControl = true,
			IsMainColor = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_LightIntensity",
			mMinValue = mainLight2.Min,
			mMaxValue = mainLight2.Max,
			mInitialValue = mInitialValue,
			mDefaultValue = 0.2,
			mDecimals = 2,
			mValueChangedCallback = function(p)
				fn87(mainLight2, p)
			end,
			IsEnabledCheck = fn104,
			IsLightControl = true,
			IsMainBrightness = true
		},
		{
			Type = module5.Types.COLOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_FillLight",
			mColorRegions = { 1 },
			mDefaultColor = fillLight2.Color:__wf_atom_dcecedb0(),
			IsEnabledCheck = fn104,
			IsLightControl = true,
			IsFillColor = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_LightIntensity",
			mMinValue = fillLight2.Min,
			mMaxValue = fillLight2.Max,
			mInitialValue = mInitialValue2,
			mDefaultValue = 0.1,
			mDecimals = 2,
			mValueChangedCallback = function(p)
				fn87(fillLight2, p)
			end,
			IsEnabledCheck = fn104,
			IsLightControl = true,
			IsFillBrightness = true
		},
		{
			Type = module5.Types.COLOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_RimLight",
			mColorRegions = { 2 },
			mDefaultColor = rimLight2.Color:__wf_atom_dcecedb0(),
			IsEnabledCheck = fn104,
			IsLightControl = true,
			IsRimColor = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_LightIntensity",
			mMinValue = rimLight2.Min,
			mMaxValue = rimLight2.Max,
			mInitialValue = mInitialValue3,
			mDefaultValue = 0.4,
			mDecimals = 2,
			mValueChangedCallback = function(p)
				fn87(rimLight2, p)
			end,
			IsEnabledCheck = fn104,
			IsLightControl = true,
			IsRimBrightness = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Rotation",
			mMinValue = 0,
			mMaxValue = 360,
			mInitialValue = lightRotation2,
			mDefaultValue = 0,
			mValueChangedCallback = fn83,
			IsEnabledCheck = fn104,
			IsLightControl = true,
			IsLightRotation = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_TimeOfDay",
			mMinValue = 0,
			mMaxValue = MAX_TIME_OF_DAY,
			mDecimals = 0,
			mInitialValue = v30,
			mDefaultValue = v30,
			mValueChangedCallback = fn84,
			ShouldRemove = function()
				return (__wf_atom_7e8ad928(v12))
			end,
			IsTimeOfDay = true
		},
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_AmbientLight",
			mMinValue = v19.Min,
			mMaxValue = v19.Max,
			mInitialValue = mInitialValue4,
			mDefaultValue = 1,
			mDecimals = 2,
			mValueChangedCallback = fn86,
			IsAmbientLight = true
		}
	}

	for i = 1, #v31 do
		table.insert(list, v31[i])
	end
end

function PopulateRemainingSettings(list)
	local mInitialValue = __wf_atom_7e8ad928(v12) and 0 or fn13(v12:__wf_atom_28fbc509(), 2)
	local all = gRegion:FindAll(gNpcSpawnPointType)
	local flag2 = false

	for i = 1, #all do
		local c_str = all[i]:__wf_atom_db682341():c_str()

		if not (c_str ~= "TurretSpawn" and c_str ~= "CameraSpawn") then
			continue
		end

		flag2 = true
		break
	end

	if flag2 then
		local v30 = tostring(gRegion:__wf_atom_22941262():__wf_atom_5b41f63b())

		for i = 1, #noEnemiesPhotoboothLevels do
			if not string.find(v30, noEnemiesPhotoboothLevels[i]:__wf_atom_5b41f63b()) then
				continue
			end

			flag2 = false
			break
		end
	end

	local v30 = {
		{ Type = module5.Types.TITLE, NameTag = "/Lotus/Language/Menu/Photobooth_Level" },
		{
			Type = module5.Types.VALUE_SELECTOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_Weather",
			mMinValue = 0,
			mMaxValue = 1,
			mInitialValue = mInitialValue,
			mDefaultValue = 0,
			mDecimals = 2,
			mValueChangedCallback = fn85,
			ShouldRemove = function()
				return (__wf_atom_7e8ad928(v12))
			end,
			IsWeather = true
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/PhotoboothToggleSloMo",
			mInitialValue = mChecked4,
			mDefaultValue = false,
			mValueChangedCallback = fn64,
			ShouldRemove = fn89
		},
		{
			Type = module5.Types.DROP_DOWN,
			ContentWidth = 392,
			mOptions = fn9(),
			mInitialValue = fn10(multiplier),
			mDefaultValue = 1,
			mValueChangedCallback = fn54,
			ShouldRemove = fn89,
			IsSloMoMultiplier = true
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/Menu/PhotoboothAdvanceTime",
			mOnReleasedCallback = fn62,
			mOnPressedCallback = fn61,
			ShouldRemove = fn89
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/PhotoboothToggleAdvanceTime",
			mInitialValue = mChecked5,
			mDefaultValue = false,
			mValueChangedCallback = fn63,
			ShouldRemove = fn89
		},
		{
			Type = module5.Types.COLOR,
			NameTag = "/Lotus/Language/Menu/Photobooth_WhiteRoomColor",
			mColorRegions = { 3 },
			mDefaultColor = Color(_G.UIColor_White):__wf_atom_dcecedb0(),
			IsRoomColor = true,
			ShouldRemove = function()
				return not v11
			end
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/Menu/PhotoboothKillEnemies",
			mOnReleasedCallback = fn46,
			ShouldRemove = function()
				return not (flag2 and gRegion:IsMaster())
			end
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = "/Lotus/Language/Menu/PhotoboothEnemySelection",
			mOnReleasedCallback = fn47,
			ShouldRemove = function()
				return not (flag2 and gRegion:IsMaster())
			end
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/PhotoboothToggleFriendlyFire",
			mInitialValue = mChecked3,
			mDefaultValue = false,
			mValueChangedCallback = fn90,
			ShouldRemove = fn89
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/PhotoboothToggleStagger",
			mInitialValue = mChecked2,
			mDefaultValue = false,
			mValueChangedCallback = fn91,
			ShouldRemove = fn89
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/SystemMessages/Photobooth_OpWeaponEnabled",
			mInitialValue = true,
			mDefaultVale = true,
			mValueChangedCallback = fn92,
			IsEnabledCheck = function()
				return v2:IsA(__wf_atom_c0fefb76)
			end
		},
		{
			Type = module5.Types.BUTTON,
			NameTag = TitleCase(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/PhotoboothTileSelection", false)),
			mOnReleasedCallback = fn45,
			ShouldRemove = fn89
		},
		{
			Type = module5.Types.CHECKBOX,
			NameTag = "/Lotus/Language/Menu/Photobooth_SSDialog",
			mDefaultValue = mChecked7,
			mInitialValue = true,
			mValueChangedCallback = function(p)
				mChecked7 = p.mChecked
			end,
			ShouldRemove = function()
				return Engine.__wf_atom_e43a530e() or Engine.__wf_atom_84bb79c2()
			end
		}
	}

	for i = 1, #v30 do
		table.insert(list, v30[i])
	end

	for _, v31 in ipairs(list) do
		if not (v31.ShouldRemove == nil or not v31.ShouldRemove()) then
			continue
		end

		if v31.IsDofControl and v31.IsEnabledCheck == nil then
			function v31.IsEnabledCheck()
				return mChecked6
			end
		end

		v6.CustomizationList:AddElement(v31, true)
	end

	v6.CustomizationList:Redraw()
end

local function fn104(switchingPhotoControls)
	_T.switchingPhotoControls = switchingPhotoControls
	mMovie:__wf_atom_2dedec1a("CameraControls", 13, false)
	v6.CustomizationList:RemoveElements(true, true)
	local v30 = fn103()
	PopulateRemainingSettings(v30)
	fn95()

	if switchingPhotoControls then
		fn17()
	end

	_T.switchingPhotoControls = nil
end

local function fn105()
	mActiveColors = SF.CustomizationColorPalette()
	mActiveColors:SetColor(4, v28.First)
	mActiveColors:__wf_atom_59cc106e(4, true)
	mActiveColors:SetColor(5, v28.Second)
	mActiveColors:__wf_atom_59cc106e(5, true)
	mActiveColors:SetColor(0, mainLight2.Color)
	mActiveColors:__wf_atom_59cc106e(0, true)
	mActiveColors:SetColor(1, fillLight2.Color)
	mActiveColors:__wf_atom_59cc106e(1, true)
	mActiveColors:SetColor(2, rimLight2.Color)
	mActiveColors:__wf_atom_59cc106e(2, true)
	mActiveColors:SetColor(3, DEFAULT_WHITE_ROOM_COLOR)
	mActiveColors:__wf_atom_59cc106e(3, true)
end

local function fn106(p, p2, _, _)
	if not __wf_atom_7e8ad928(p2) then
		local v30 = Color(p2)

		if p == 4 then
			v28.First = v30

			if v25[v26] ~= nil and not __wf_atom_7e8ad928(v25[v26].Movie) then
				v25[v26].FirstColor = v30
				v25[v26].Movie:__wf_atom_f62a8704("SetVertexColors", {
					tostring(module6.SRGBToLinear255(v28.First):__wf_atom_dcecedb0()),
					(tostring(module6.SRGBToLinear255(v28.Second):__wf_atom_dcecedb0()))
				})
			end
		elseif p == 5 then
			v28.Second = v30

			if v25[v26] ~= nil and not __wf_atom_7e8ad928(v25[v26].Movie) then
				v25[v26].SecondColor = v30
				v25[v26].Movie:__wf_atom_f62a8704("SetVertexColors", {
					tostring(module6.SRGBToLinear255(v28.First):__wf_atom_dcecedb0()),
					(tostring(module6.SRGBToLinear255(v28.Second):__wf_atom_dcecedb0()))
				})
			end
		elseif p == 0 then
			fn88(mainLight2, v30)
		elseif p == 1 then
			fn88(fillLight2, v30)
		elseif p == 2 then
			fn88(rimLight2, v30)
		elseif p == 3 then
			whiteRoomMaterial:__wf_atom_a042ff6c(
				v13,
				module6.SRGBToLinear(v30.red),
				module6.SRGBToLinear(v30.green),
				module6.SRGBToLinear(v30.blue),
				1
			)
			v29 = v30
		end
	end
end

local function fn107()
	local _, v30 = module2.GetScreenDimensions(mMovie)
	local module8 = require("Lotus.Interface.Components.ThemedCustomizationList")
	v6 = module8.Create(mMovie, "Panel.AreaPicker")
	mMovie:__wf_atom_e57658c2("Panel.AreaPicker.CustomizationPanel.Scrollbar", 1, 2)
	v6.CustomizationList.mScrollBarExtension = 12
	v6.CustomizationList.mElementWidth = 400
	v6.CustomizationList.mElementHeight = 42
	v6.CustomizationList.mForcedVerticalSeparation = 45
	v6.CustomizationList.mDepthDirection = -1
	v6.CustomizationList.mApplyColorCallback = fn106
	v6.CustomizationList.mActiveColors = mActiveColors
	v6.CustomizationList.mMaxVisibleHeight = v30 * 0.85
	v6.CustomizationList.mColorPickerSkipSuitRot = true
	v6.ItemSelectionGrid:HookupCallbacks()
	v6.CustomizationList.VisibleRangeMaterial = panelVisRangeMaterial
	v6.CustomizationList.TextVisibleRangeMaterial = panelTextVisRangeMaterial
	v6.CustomizationList.RectangleVisibleRangeMaterial = panelBgVisRangeMaterial
	v6.CustomizationList:UpdateVisRanges()
end

local function fn108()
	local height = v7:GetHeight()
	local maxTextWidth = v7.MaxTextWidth
	mMovie:__wf_atom_e57658c2("Panel.GenericMessage.MessageContainer", 0, -(maxTextWidth + 10))
	mMovie:__wf_atom_e57658c2("Panel.GenericMessage.Bg", 15, height + 5)
	mMovie:__wf_atom_e57658c2("Panel.GenericMessage.Bg", 14, maxTextWidth + 30)
	mMovie:__wf_atom_e57658c2("Panel.GenericMessage.Blurer", 15, height + 5)
	mMovie:__wf_atom_e57658c2("Panel.GenericMessage.Blurer", 14, maxTextWidth + 30)
	v7:RunForAllVisibleElements(function(p)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Bg", 14, maxTextWidth + 30)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Setting", 0, maxTextWidth - 205)
	end)
end

local function fn109()
	local module8 = require("EE.Interface.Components.List")
	v7 = module8.CreateList(mMovie, "Panel.GenericMessage.MessageContainer.ListItem", 6)
	v7.MaxTextWidth = MIN_BOX_WIDTH
	v7.MaxCalloutWidth = CALLOUT_WIDTH

	function v7.mClipCreatedCallback(p, _)
		mMovie:OverrideMaterial(p .. ".Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(p .. ".Bg", "RectEdgeColor", 0, 0, 0, 0)
		mMovie:__wf_atom_4c1c1986(p, "Text", 44, mColors.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(p, "Callout", 44, mColors.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(p, "Setting", 44, mColors.FloatingContentHighlight)
	end

	function v7.mElementDrawCallback(data)
		if data.mClipName == nil then
			return
		end

		if data.mIndex % 2 == 0 then
			mMovie:__wf_atom_1ca72041(data.mClipName .. ".Bg", "RectInnerColor", 0, 0, 0, 0)
		else
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Bg",
				"RectInnerColor",
				mColors.ContentObject.r,
				mColors.ContentObject.g,
				mColors.ContentObject.b,
				0.05
			)
		end

		mMovie:__wf_atom_7d7314f1(data.mClipName .. ".Callout.text", data.mBindings)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Text", 0, CALLOUT_WIDTH)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Callout", 14, CALLOUT_WIDTH)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(data.mDesc, true)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Text", 12, 100)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Callout", 12, 100)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Setting", 13, false)
		mMovie:__wf_atom_48bd5a59(data.mClipName, "Text", 36, __wf_atom_8e9ac384)
		local v30 = mMovie:__wf_atom_cfc41e35(data.mClipName, "Text", 40) + CALLOUT_WIDTH
		v7.MaxTextWidth = math.max(v7.MaxTextWidth, v30)
	end

	function v7:CalculateY(p)
		local howManyElements = self:GetHowManyElements()
		return self.mInitialY - 30 * (howManyElements - p.mIndex)
	end

	function v7:GetHeight()
		return self:GetHowManyElements() * 30
	end

	v7._Redraw = v7.Redraw

	function v7:Redraw(p, p2, p3)
		self.MaxTextWidth = MIN_BOX_WIDTH
		self:_Redraw(p, p2, p3)
		fn108()
	end

	mMovie:OverrideMaterial("Panel.GenericMessage.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"Panel.GenericMessage.Bg",
		"RectInnerColor",
		mColors.BackgroundObject.r,
		mColors.BackgroundObject.g,
		mColors.BackgroundObject.b,
		0.7
	)
	mMovie:__wf_atom_1ca72041(
		"Panel.GenericMessage.Bg",
		"RectEdgeColor",
		mColors.FloatingContentObject.r,
		mColors.FloatingContentObject.g,
		mColors.FloatingContentObject.b,
		0.9
	)
	mMovie:__wf_atom_2dedec1a("Panel.GenericMessage.Header", 13, false)
	mMovie:__wf_atom_2dedec1a("Panel.GenericMessage.HeaderDeco", 13, false)
	mMovie:__wf_atom_2dedec1a("Panel.GenericMessage.Footer", 13, false)
end

local function fn110()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Warframe_Speed", false)
	mMovie:__wf_atom_50d60589("CameraControls.SpeedSlider.Label", 36, __wf_atom_8e9ac384)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("CameraControls.LoopBtn", 0)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("CameraControls.LoopBtn.Btn", 14)
	mMovie:__wf_atom_e57658c2("CameraControls.SpeedSlider", 0, __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 + 10)
	mMovie:__wf_atom_e57658c2("CameraControls.SpeedSlider.Slider", 15, 15)
	mMovie:__wf_atom_e57658c2("CameraControls.SpeedSlider.SliderBg", 15, 15)
	mMovie:__wf_atom_e57658c2("CameraControls.SpeedSlider.Slider", 1, 8)
	mMovie:__wf_atom_e57658c2("CameraControls.SpeedSlider.SliderBg", 1, 8)
	mMovie:SetCallbacks(
		"CameraControls.SpeedSlider.SliderBg",
		"SpeedSliderRollOver",
		"SpeedSliderRollOut",
		"SpeedSliderReleased",
		"SpeedSliderPressed"
	)
	mMovie:SetReleaseOutsideCallback("CameraControls.SpeedSlider.SliderBg", "SpeedSliderReleased")
	fn97()
end

local function fn111()
	local module8 = require("EE.Interface.Components.List")
	v8 = module8.CreateList(mMovie, "CameraControls.CameraList.CameraElement")
	v8:SetCallbacks("CameraElementPressed", "CameraElementFocused", "CameraElementUnfocused")
	v8.mForcedHorizontalSeparation = 141
	v8.mForcedVerticalSeparation = 0
	v8.mVisibleElements = 12

	function v8.CalculateScrollBarHeight(_, _)
		return 1700
	end

	v8:AttachScrollBar("CameraControls.Scrollbar", 0)
	v8:EnableSmoothScroll()
	v8.mScroll = 1

	function v8:GetElementIndex(p)
		local mIndex = p.mIndex

		if mIndex == nil then
			mIndex = self:GetElementIndexById(p.Id)
		end

		return mIndex
	end

	function v8:CalculateX(p)
		return self.mInitialX + (self:GetElementIndex(p) - self:GetScroll()) * self.mForcedHorizontalSeparation
	end

	function v8:ScrollValueChangedCallback(p, _)
		local v30 = self:GetHowManyElements() - self.mVisibleElements

		if self.mSmoothScroll then
			local v31 = __wf_atom_421b01aa(v30 * p, 0, v30) + 1

			if v31 ~= self.mScroll then
				local v32 = math.floor(v31) - math.floor(self.mScroll)
				self:SetScroll(v31, true)

				if v32 >= 1 or v32 <= -1 then
					self.mRedrawFromScrollBar = true
					self:Redraw(nil, false, true)
				end

				self:RunForAllVisibleElements(function(p2)
					self.mMovie:__wf_atom_e57658c2(p2.mClipName, 0, self:CalculateX(p2))
					self:RepositionButton(p2)
				end)
			end
		else
			local v31 = __wf_atom_421b01aa(self.UTIL.Round(v30 * p), 0, v30) + 1

			if v31 ~= self.mScroll then
				self:SetScroll(v31, true)
				self.mRedrawFromScrollBar = true
				self:Redraw(nil, false, true)
				self:RunForAllVisibleElements(function(p2)
					self.mMovie:__wf_atom_e57658c2(p2.mClipName, 1, self:CalculateY(p2))
					self:RepositionButton(p2)
				end)
			end
		end
	end

	function v8:CalculateY(_)
		return 0
	end

	function v8.mOnFocusedCallback(p)
		if p == nil or p.mClipName == nil then
			return
		end

		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Bg",
			"RectEdgeColor",
			_G.UIColorObject_Yellow.r,
			_G.UIColorObject_Yellow.g,
			_G.UIColorObject_Yellow.b,
			0.7
		)
	end

	function v8.mOnUnfocusedCallback(p)
		if p == nil or p.mClipName == nil then
			return
		end

		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Bg",
			"RectEdgeColor",
			_G.UIColorObject_White.r,
			_G.UIColorObject_White.g,
			_G.UIColorObject_White.b,
			0.5
		)
	end

	function v8.mOnSelectedCallback(data)
		if data == nil or data.mClipName == nil then
			return
		end

		mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".Bg",
			"RectInnerColor",
			_G.UIColorObject_White.r,
			_G.UIColorObject_White.g,
			_G.UIColorObject_White.b,
			0.5
		)
		data.CallBack(data.CameraIndex)
	end

	function v8.mElementDrawCallback(data)
		if data == nil or data.mClipName == nil then
			return
		end

		mMovie:OverrideMaterial(data.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:OverrideMaterial(data.mClipName .. ".Delete.Highlight", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(data.mClipName .. ".Delete.Highlight", "RectInnerColor", 0, 0, 0, 0)
		mMovie:__wf_atom_1ca72041(data.mClipName .. ".Delete.Highlight", "RectEdgeColor", 0, 0, 0, 0)
		mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".Bg",
			"RectInnerColor",
			_G.UIColorObject_White.r,
			_G.UIColorObject_White.g,
			_G.UIColorObject_White.b,
			0
		)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Settings", 13, not data.AddElement)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Edit", 13, not data.AddElement)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "IconLabel", 13, not data.AddElement)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Delete", 13, not data.AddElement)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "TimeLabel", 13, not data.AddElement)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "BottomLabel", 13, data.AddElement == true)

		if data.AddElement then
			mMovie:__wf_atom_7d7314f1(
				data.mClipName .. ".BottomLabel.text",
				"/Lotus/Language/SystemMessages/Photobooth_AddCamera"
			)

			if not __wf_atom_7e8ad928(addIcon) then
				mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", addIcon)
			end
		else
			if not __wf_atom_7e8ad928(cameraIcon) then
				mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", cameraIcon)
			end

			mMovie:__wf_atom_48bd5a59(
				data.mClipName,
				"IconLabel",
				36,
				"<p>" .. "<font color=\"#000000\">" .. data.Id .. "</font></p>"
			)
			mMovie:__wf_atom_48bd5a59(data.mClipName, "TimeLabel", 36, data.TimeLabel)
		end
	end

	function v8.mClipCreatedCallback(p, p2)
		mMovie:SetCallbacks(p .. ".Settings", "SettingsFocused", "SettingsUnfocused", "SettingsPressed", nil)
		mMovie:__wf_atom_4c1c1986(p, "Settings", 100, p2.Id)
		mMovie:SetCallbacks(p .. ".Edit", "EditFocused", "EditUnfocused", "EditPressed", nil)
		mMovie:__wf_atom_4c1c1986(p, "Edit", 100, p2.Id)
		mMovie:SetCallbacks(p .. ".Delete", "DeleteFocused", "DeleteUnfocused", "DeletePressed", nil)
		mMovie:__wf_atom_4c1c1986(p, "Delete", 100, p2.Id)
	end

	fn20()
	fn110()
end

function SpeedSliderPressed()
	mCameraSpeedControl.SliderActive = true
end

function SpeedSliderReleased()
	mCameraSpeedControl.SliderActive = false
end

local function fn112(p)
	if not __wf_atom_7e8ad928(v8) then
		v8:Redraw(nil, true)
		v8:FocusElementById(p, false)
		v8:SelectElementById((tonumber(p)))
	end
end

function CameraElementPressed(p)
	fn112(p)
end

local function fn113(p)
	if not __wf_atom_7e8ad928(v8) then
		v8:FocusElementById((tonumber(p)))
	end
end

function CameraElementFocused(p)
	fn113(p)
end

local function fn114(p)
	if not __wf_atom_7e8ad928(v8) then
		v8:UnfocusElementById((tonumber(p)))
	end
end

function CameraElementUnfocused(p)
	fn114(p)
end

local function fn115(p)
	local elementById = v8:GetElementById((tonumber(p)))

	if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
		mMovie:__wf_atom_1ca72041(
			elementById.mClipName .. ".Bg",
			"RectEdgeColor",
			_G.UIColorObject_Yellow.r,
			_G.UIColorObject_Yellow.g,
			_G.UIColorObject_Yellow.b,
			0.7
		)
		mMovie:__wf_atom_4c1c1986(elementById.mClipName, "Settings", 11, _G.UIColor_Yellow)
		_T.gToolTip = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_Level", false)
	end
end

function SettingsFocused(p)
	fn115(p)
end

local function fn116(p)
	local elementById = v8:GetElementById((tonumber(p)))

	if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
		mMovie:__wf_atom_1ca72041(
			elementById.mClipName .. ".Bg",
			"RectEdgeColor",
			_G.UIColorObject_White.r,
			_G.UIColorObject_White.g,
			_G.UIColorObject_White.b,
			0.5
		)
		mMovie:__wf_atom_4c1c1986(elementById.mClipName, "Settings", 11, _G.UIColor_White)
	end

	_T.gToolTip = nil
end

function SettingsUnfocused(p)
	fn116(p)
end

local function fn117(p)
	if _T.playingCamera then
		fn26()
	end

	mEditingCameraIndex = tonumber(p)
	fn18(mEditingCameraIndex)
	fn93()
	fn102()
	fn4()
end

function SettingsPressed(p)
	fn117(p)
end

local function fn118(p)
	local elementById = v8:GetElementById((tonumber(p)))

	if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
		mMovie:__wf_atom_1ca72041(
			elementById.mClipName .. ".Bg",
			"RectEdgeColor",
			_G.UIColorObject_Yellow.r,
			_G.UIColorObject_Yellow.g,
			_G.UIColorObject_Yellow.b,
			0.7
		)
		mMovie:__wf_atom_4c1c1986(elementById.mClipName, "Edit", 11, _G.UIColor_Yellow)
		_T.gToolTip = mMovie:__wf_atom_8e9ac384("/Lotus/Language/SystemMessages/Photobooth_Edit", false)
	end
end

function EditFocused(p)
	fn118(p)
end

local function fn119(p)
	local elementById = v8:GetElementById((tonumber(p)))

	if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
		mMovie:__wf_atom_1ca72041(
			elementById.mClipName .. ".Bg",
			"RectEdgeColor",
			_G.UIColorObject_White.r,
			_G.UIColorObject_White.g,
			_G.UIColorObject_White.b,
			0.5
		)
		mMovie:__wf_atom_4c1c1986(elementById.mClipName, "Edit", 11, _G.UIColor_White)
	end

	_T.gToolTip = nil
end

function EditUnfocused(p)
	fn119(p)
end

local function fn120(p)
	if _T.playingCamera then
		fn26()
	end

	mEditingCameraIndex = tonumber(p)
	fn18(mEditingCameraIndex)
	fn93()
	fn99()
end

function EditPressed(p)
	fn120(p)
end

local function fn121(p)
	local elementById = v8:GetElementById((tonumber(p)))

	if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
		mMovie:__wf_atom_1ca72041(
			elementById.mClipName .. ".Delete.Highlight",
			"RectEdgeColor",
			_G.UIColorObject_Yellow.r,
			_G.UIColorObject_Yellow.g,
			_G.UIColorObject_Yellow.b,
			0.7
		)
		_T.gToolTip = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Loadout_Remove", false)
	end
end

function DeleteFocused(p)
	fn121(p)
end

local function fn122(p)
	local elementById = v8:GetElementById((tonumber(p)))

	if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
		mMovie:__wf_atom_1ca72041(elementById.mClipName .. ".Delete.Highlight", "RectEdgeColor", 0, 0, 0, 0)
	end

	_T.gToolTip = nil
end

function DeleteUnfocused(p)
	fn122(p)
end

local function fn123(p)
	print("DeletePressed " .. p)
	mEditingCameraIndex = tonumber(p)
	fn52()
	fn3()
end

function DeletePressed(p)
	fn123(p)
end

local function fn124()
	mColors.Background = module4.GetColor(2, true)
	mColors.Content = module4.GetColor(6, true)
	mColors.FloatingContent = module4.GetColor(9, true)
	mColors.FloatingContentHighlight = module4.GetColor(10, true)
	mColors.BackgroundObject = module2.ConvertColorNumberToProceduralRGB(mColors.Background)
	mColors.ContentObject = module2.ConvertColorNumberToProceduralRGB(mColors.Content)
	mColors.FloatingContentObject = module2.ConvertColorNumberToProceduralRGB(mColors.FloatingContent)
	mColors.ContentHex = module2.ConvertColorNumberToHex(mColors.Content)
	mColors.FloatingContentHex = module2.ConvertColorNumberToHex(mColors.FloatingContent)
end

local function fn125()
	fn107()
	fn109()
	fn111()
	mMovie:__wf_atom_2dedec1a("CameraControls", 13, false)
	mMovie:__wf_atom_2e64957a(false)
	fn104()
end

fn3 = function()
	v6.CustListScrollBar:SetEnabled(false)
	v6.CustomizationList:RemoveElements(true, true)
	v6.CustomizationList:Redraw()
	v8:RemoveElements(true, true)
	mMovie:__wf_atom_2dedec1a("CameraControls", 13, true)
	fn94(false)
	mCameraSettings = true
	local v30 = {}

	for i = 1, #mCameraDatas do
		table.insert(v30, {
			CallBack = fn31,
			CameraIndex = i,
			TimeLabel = tostring(fn13(mCameraDatas[i].duration, 1)) .. "s"
		})
	end

	table.insert(v30, { AddElement = true, Enabled = true, CallBack = fn99 })

	for _, v31 in ipairs(v30) do
		v8:AddElement(v31, true)
	end

	v8:Redraw()
	fn4()
	fn21()
end

local function fn126()
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if not __wf_atom_7e8ad928(postProcess) then
		if not __wf_atom_7e8ad928(mCamera) then
			local __wf_atom_e800787c = mCamera:__wf_atom_e800787c()

			if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
				__wf_atom_e800787c:__wf_atom_c858e813(false)
				__wf_atom_e800787c:__wf_atom_b753c2fa(false)
				__wf_atom_e800787c:__wf_atom_653d5581(false)
				__wf_atom_e800787c:__wf_atom_5d8660b2(false)
			end
		end

		local cinMaterial = cinMaterial

		if v11 then
			cinMaterial = cinMaterialWhiteRoom
		end

		if not __wf_atom_7e8ad928(cinMaterial) then
			postProcess:__wf_atom_351eef0b(cinMaterial)
		end

		postProcess.useExposureEVCurve = false
		postProcess.exposureConvergeSpeed = 10

		if v11 then
			postProcess:__wf_atom_81e82b20(1, 1)
		else
			postProcess:__wf_atom_81e82b20(0.1, 128)
		end

		mInitials.Exposure = postProcess.targetExposure
		mInitials.Saturation = postProcess.saturation
		mInitials.Fade = gRegion:__wf_atom_8ad59546():__wf_atom_89894bd1()
		v19.mInitialLightMapBoost = postProcess.lightMapBoost
	end
end

function CancelCinematicMode()
	if _T.playingCamera then
		fn27()
	end

	fn4()
	fn102()
end

function PlayCinematicMode()
	fn27()
end

local function fn127() end

function Initialize()
	mMovie:__wf_atom_c884ca43(not v5)
	mMovie:__wf_atom_2dedec1a("WidthTester16", 13, false)
	mMovie:__wf_atom_2dedec1a("WidthTester24", 13, false)
	_T.ColorPicker_SkipSuitRotation = true
	local backgroundMovie = module4.GetBackgroundMovie()

	if not __wf_atom_7e8ad928(backgroundMovie) then
		v20 = __wf_atom_8e4fda44:FindMovie(backgroundMovie)
	end

	local __wf_atom_22941262 = gRegion:__wf_atom_22941262()

	if not __wf_atom_7e8ad928(__wf_atom_22941262) then
		v11 = __wf_atom_22941262:IsA(whiteRoomLevel)
	end

	if not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			__wf_atom_55142dd4(__wf_atom_18a5d83b:__wf_atom_9be88b01(), "OnProfileSaved")
			v16 = __wf_atom_18a5d83b:Settings()
			mChecked6 = v16:DOF()
		end
	end

	local module8 = require("Lotus.Interface.Libs.TimerMgr")
	v3 = module8.CreateTimerMgr()
	local module9 = require("EE.Interface.AnchorMgr")
	v4 = module9.Create(mMovie)
	v4:Register(mMovie, "Panel", { v4.ANCHOR_V_BOTTOM, v4.ANCHOR_H_RIGHT })
	v4:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	mMovie:OverrideMaterial("Panel.Delete.Highlight", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041("Panel.Delete.Highlight", "RectInnerColor", 0, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("Panel.Delete.Highlight", "RectEdgeColor", 0, 0, 0, 0)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local __wf_atom_dd7246c7 = __wf_atom_eab484a7:__wf_atom_dd7246c7()

		if not __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
			mCamera = __wf_atom_dd7246c7
		end

		local __wf_atom_50a7d83e = __wf_atom_eab484a7:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			v2 = __wf_atom_50a7d83e
		end

		local all = gRegion:FindAll(cameraAvatarType)

		if not (__wf_atom_7e8ad928(all) or __wf_atom_7e8ad928(all[1])) then
			mCameraAvatar = all[1]
		end

		fn127()
	end

	fn124()
	fn105()
	fn126()
	fn82()
	fn125()
end

local function fn128()
	if mEditingCameraIndex == nil then
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(mInitials.Fade)
	else
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(mCameraDatas[mEditingCameraIndex].fade)
	end
end

local function fn129(mFocusedEntity)
	if #mCameraDatas == 0 or __wf_atom_7e8ad928(mFocusedEntity) then
		return nil
	end

	for i = 1, #mCameraDatas do
		if mCameraDatas[i].camDeco == mFocusedEntity then
			return i
		end
	end

	__wf_atom_f2daf912("ERROR: Invalid Camera Decoration - no matching ID")
	return nil
end

local function fn130(photoboothCameraDeco, freeCamActive2)
	local ternary = module2.Ternary(freeCamActive2, mCameraAvatar, v2)

	if not (__wf_atom_7e8ad928(ternary) or __wf_atom_7e8ad928(mCamera)) then
		local ternary2 = module2.Ternary(
			freeCamActive2,
			ternary:GetPosition(),
			ternary:EyePosition() + Vector(0.25, 0, 0)
		)
		local __wf_atom_a06d543c = mCamera:__wf_atom_a06d543c()
		local __wf_atom_3ec9f18c = gRegion:__wf_atom_3ec9f18c(
			ternary2,
			ternary2 + __wf_atom_a06d543c * 4,
			0.15,
			ternary,
			Vector()
		)

		if not __wf_atom_7e8ad928(__wf_atom_3ec9f18c) and __wf_atom_3ec9f18c:IsA(photoboothCameraDeco) then
			return __wf_atom_3ec9f18c
		end
	end
end

local function fn131()
	if not __wf_atom_7e8ad928(mFocusedEntity) then
		if not __wf_atom_7e8ad928(highlightFx) then
			local __wf_atom_bb3e7833 = mFocusedEntity:__wf_atom_bb3e7833(highlightFx)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end

		mFocusedEntity = nil
	end
end

local function fn132(p)
	fn131()

	if not __wf_atom_7e8ad928(p) then
		mFocusedEntity = p

		if
			__wf_atom_7e8ad928((mFocusedEntity:__wf_atom_bb3e7833(highlightFx)))
			and not __wf_atom_7e8ad928(highlightFx)
		then
			mFocusedEntity:Attach(highlightFx, EMPTY_SYMBOL):__wf_atom_1b57cb83(false)
		end
	end
end

local function fn133()
	if not mFocusedEntity:IsA(photoboothCameraDeco) then
		return
	end

	local v30 = fn129(mFocusedEntity)

	if v30 ~= nil then
		fn3()
		fn112(v30)
	end
end

local function fn134()
	if not __wf_atom_7e8ad928(v2) then
		local __wf_atom_a96eb2aa = v2:__wf_atom_a96eb2aa()

		if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			if _T.detachCamera then
				if gGameRules:Paused() then
					if __wf_atom_a96eb2aa:__wf_atom_648b1408() then
						__wf_atom_a96eb2aa:__wf_atom_7232ad72(false)
					end
				elseif not __wf_atom_a96eb2aa:__wf_atom_648b1408() then
					__wf_atom_a96eb2aa:__wf_atom_7232ad72(true)
				end
			elseif __wf_atom_a96eb2aa:__wf_atom_648b1408() then
				__wf_atom_a96eb2aa:__wf_atom_7232ad72(false)
			end
		end
	end
end

local function fn135()
	if __wf_atom_7e8ad928(v6) then
		return false
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local rootBasedPosition, _ = module2.GetRootBasedPosition(mMovie, "Panel")
	return rootBasedPosition - (v6.CustomizationList.mElementWidth + 30) <= __wf_atom_5e6e15c8
end

function Update()
	if __wf_atom_7e8ad928(mCamera) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			mCamera = __wf_atom_eab484a7:__wf_atom_dd7246c7()
		end
	end

	if _T.freeCamActive ~= nil then
		if not (_T.freeCamActive or __wf_atom_7e8ad928(mCamera)) then
			mCamera:__wf_atom_b4338d31(mCamera:__wf_atom_2f2bada0())
		end

		if freeCamActive ~= _T.freeCamActive then
			mAddCameraMode = false
			mEditingCameraIndex = nil
			fn95()

			if _T.freeCamActive then
				local _ = not __wf_atom_7e8ad928(mFocusedEntity)
			end
		end

		freeCamActive = _T.freeCamActive
		gRegion:__wf_atom_c4f78a8f():__wf_atom_ab021aff(freeCamActive)
	end

	if _T.detachCamera ~= nil and _T.detachCamera then
		gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d():__wf_atom_9dfd2a6a()
	end

	local mMovie2 = mMovie
	local v30 = (_T.TopMenuOpen == nil or not _T.TopMenuOpen) and __wf_atom_7e8ad928(v24)

	if v30 then
		if _T.freeCamActive == nil then
			v30 = false
		else
			v30 = _T.freeCamControlsVis == nil or _T.freeCamControlsVis
		end
	end

	mMovie2:SetVisible(v30)
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v6) then
		v6.CustomizationList:Update(__wf_atom_fa1258d0())
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Update(__wf_atom_fa1258d0())
	end

	if _T.cancelCameraEdit then
		_T.cancelCameraEdit = nil
		mEditingCameraIndex = nil
		fn8(false)
		fn128()
	end

	if not __wf_atom_7e8ad928(mCamera) then
		if _T.playingCamera then
			fn60()
		elseif (_T.freeCamActive or _T.detachCamera) and mLookAtAvatar then
			local __wf_atom_a2a18137 = gRegion:__wf_atom_c4f78a8f():__wf_atom_a2a18137()
			__wf_atom_a2a18137.y += 1
			local lookAtRotation = mCamera:GetLookAtRotation(__wf_atom_a2a18137)
			mCamera:__wf_atom_9b788a35(lookAtRotation)
			mCamera:__wf_atom_b4338d31(lookAtRotation)
		end
	end

	if mCameraSpeedControl.SliderActive then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
		local rootBasedPosition, _ = module2.GetRootBasedPosition(mMovie, "CameraControls.SpeedSlider.SliderBg")
		local v31 = __wf_atom_5e6e15c8 - rootBasedPosition
		mCameraSpeedControl.Value = __wf_atom_421b01aa(v31, 0, 200) / 200
		mCameraSpeedMult = __wf_atom_104bfe98(MIN_SPEED_MULTIPLIER, MAX_SPEED_MULTIPLIER, mCameraSpeedControl.Value)
		fn97()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if v2 ~= __wf_atom_c4f78a8f then
		v2 = __wf_atom_c4f78a8f

		if not __wf_atom_7e8ad928(v2) then
			if v2:IsA(__wf_atom_c0fefb76) and __wf_atom_7e8ad928(v18.MainLight.Instance) then
				fn81(v2)
			end

			fn80()
			v2:ControlCamera(not _T.detachCamera)
			fn66()
		end
	end

	if mCinematicMode then
		mMovie:__wf_atom_fbca497c(false)
	end

	fn134()

	if v21 then
		local v31 = fn135()
		local v32 = _T.InventoryScreenOpen and 100 or module2.Ternary(v31, 80, 40)

		if (v22 == nil or v32 ~= v22) and not __wf_atom_7e8ad928(v20) then
			v22 = v32
			__wf_atom_ec43d06e(v20, "_root", 0, { 12 }, { v32 }, 0.2)
		end
	end

	if mAddCameraMode or not freeCamActive then
		fn131()
	else
		local v31 = fn130(photoboothCameraDeco, freeCamActive)

		if not __wf_atom_7e8ad928(v31) and v31 ~= mFocusedEntity then
			fn132(v31)
		elseif __wf_atom_7e8ad928(v31) and not __wf_atom_7e8ad928(mFocusedEntity) then
			fn131()
		end
	end
end

function onViewportSizeChanged(p, p2)
	if not __wf_atom_7e8ad928(v4) then
		v4:Update(p, p2)
	end

	if not __wf_atom_7e8ad928(v6) then
		local _, v30 = module2.GetScreenDimensions(mMovie)
		v6.CustomizationList.mMaxVisibleHeight = v30 * 0.8
		v6.CustomizationList:Redraw(nil, true, true)
		fn95()
	end
end

fn = function(p)
	if (mCinematicMode or v5 and mCameraSettings) and p then
		return
	end

	if v5 and mCameraSettings then
		if mEditingCameraIndex == nil then
			fn104()
			fn4()
			_T.gToolTip = nil
		else
			fn3()
			mEditingCameraIndex = nil
			fn4()
		end

		fn128()
	else
		v5 = not v5
		mMovie:__wf_atom_c884ca43(not v5)

		if v5 then
			if mAddCameraMode then
				mAddCameraMode = false
				fn50()
			end

			if mCameraSettings then
				fn3()
			else
				_T.gToolTip = nil

				if __wf_atom_7e8ad928(mFocusedEntity) then
					mMovie:__wf_atom_2dedec1a("CameraControls", 13, false)
				else
					fn133()
				end
			end

			if not (__wf_atom_7e8ad928(_T.freeCamControlsVis) or _T.freeCamControlsVis) then
				local v30 = gRegion:__wf_atom_e23b2855()[1]

				if not __wf_atom_7e8ad928(v30) then
					v30:__wf_atom_f39fa21e()
				end
			end
		else
			mMovie:__wf_atom_2dedec1a("CameraControls", 13, false)

			if _T.playingCamera and not _T.detachCamera then
				fn27()
			end
		end

		fn4()
		fn95()
	end
end

function ToggleControl()
	fn(true)
end

function onKeyDown_MENU_GENERIC1()
	if mCameraSettings and mEditingCameraIndex == nil then
		return
	end

	fn98()
end

function onKeyDown_MENU_GENERIC2()
	if mCameraSettings and mEditingCameraIndex == nil and not mCinematicMode then
		fn96()
		return true
	end

	if v5 and not __wf_atom_7e8ad928(v6) then
		v6.CustomizationList:RunForAllElements(function(p)
			if not __wf_atom_7e8ad928(p.mButton.mDropDown) and p.mButton.mDropDown.mMainButton:IsActive() then
				p.mButton.mDropDown.mMainButton:TryPressed(true, true)
			end
		end)
	end
end

function onKeyDown_PHOTOBOOTH_TOGGLE_CONTROL()
	if mCameraSettings and mEditingCameraIndex == nil then
		fn27()
	elseif mCameraSettings then
		fn98()
	end
end

function onKeyDown_MENU_CANCEL()
	if not mCinematicMode then
		fn(false)
		return
	end

	mCinematicMode = false
	fn4()
	fn3()
	mMovie:__wf_atom_fbca497c(true)
end

function onKeyDown_MENU_RTRIGGER1()
	if v5 and mCameraSettings and mEditingCameraIndex == nil and #mCameraDatas > 0 then
		module2.ShowYesOrNoMessage("/Lotus/Language/SystemMessages/Photobooth_ClearCamera", "ClearCameraPositions")
	end
end

function CommonResourcesReady()
	if flag then
		flag = false
		fn125()
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not v5 then
		return
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Scroll(p)
	end

	if mCameraSettings and not __wf_atom_7e8ad928(v8) then
		local mScrollBar = v8.mScrollBar

		if not __wf_atom_7e8ad928(mScrollBar) then
			mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
		end
	end
end

function ConfirmCaptureAction(p)
	if tonumber(p) == 5 and filename ~= nil and not Script.__wf_atom_eac9e095(filename) then
		module2.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_SSOpen", false, {
			FILENAME = filename
		}))
	end
end

function OnScreenCapture(filename2)
	filename = filename2

	if not mChecked7 then
		return
	end

	if not __wf_atom_7e8ad928(v23) then
		v23:Close()
	end

	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Photobooth_SSTitle", false, {
		FILENAME = filename2
	})
	dialogSettings.firstString = "/Lotus/Language/Menu/Badlands_Continue"
	dialogSettings.secondString = "/Lotus/Language/Menu/Photobooth_SSOpen"
	dialogSettings:SetCallback("ConfirmCaptureAction")
	v23 = module2.ShowCustomMessage(dialogSettings)
end

function OnProfileSaved()
	if not __wf_atom_7e8ad928(v16) then
		local dof = v16:DOF()

		if mChecked6 and not dof then
			mChecked6 = false
			v6.CustomizationList:RunForAllElements(function(state)
				if state.IsDofOn then
					state.ToggleVal = mChecked6
					v6.CustomizationList.mElementDrawCallback(state)
				elseif state.IsDofControl then
					state.Enabled = mChecked6
					v6.CustomizationList.mElementDrawCallback(state)
				end
			end)

			if not __wf_atom_7e8ad928(_T.PhotoBoothCameraSpot) then
				local ternary = module2.Ternary(mChecked6, dofDistance, 0)
				local ternary2 = module2.Ternary(mChecked6, dofDepth, 10000)
				_T.PhotoBoothCameraSpot:__wf_atom_8c3d9704(ternary)
				_T.PhotoBoothCameraSpot:__wf_atom_7e990320(ternary2)
			end

			local postProcess = gRegion:__wf_atom_8ad59546().postProcess

			if not __wf_atom_7e8ad928(postProcess) then
				postProcess.horizonDOF = module2.Ternary(mChecked6, dofHorizon, 0)
			end
		end

		local colorCorrection = v16:ColorCorrection()

		if __wf_atom_7e8ad928(colorCorrection) or not colorCorrection then
			local mIndex = nil
			v6.CustomizationList:RunForAllElements(function(p)
				if p.IsColorGradient then
					mIndex = p.mIndex
				end
			end)
			local elementInIndex = v6.CustomizationList:GetElementInIndex(mIndex)

			if not __wf_atom_7e8ad928(elementInIndex) then
				elementInIndex.mButton.mDropDown:SelectElement(1)
			end
		end
	end
end

function OnGamepadTransition(_)
	fn21()

	if not v5 then
		fn95()
	end
end