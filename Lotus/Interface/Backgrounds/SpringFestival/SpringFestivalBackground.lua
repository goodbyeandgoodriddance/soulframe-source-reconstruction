local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local highlightOn = true
local highlightOffset = { x = 0, y = 0 }
highlightOffset.x = 0
highlightOffset.y = 0
local clips = {}
local smoothCursorX = __wf_atom_10cd16b2(0, 0.15)
local smoothCursorY = __wf_atom_10cd16b2(0, 0.15)
local foregroundXScale = 1

local function fn()
	local _, _ = module.GetScreenDimensions(mMovie)
	local __wf_atom_97cd8326 = mMovie:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = mMovie:__wf_atom_54eeda24()
	local v = __wf_atom_97cd8326 * 0.5
	local v2 = __wf_atom_54eeda24 * 0.5

	for _, v3 in ipairs(clips) do
		if not __wf_atom_7e8ad928(v3.Texture) then
			mMovie:__wf_atom_c90af43a(v3.ClipName, v3.Texture)
		end

		if v3.Scale == nil then
			mMovie:__wf_atom_e57658c2(v3.ClipName, 0, 0)
			mMovie:__wf_atom_e57658c2(v3.ClipName, 1, 0)
		else
			if v3.KeepProportions then
				mMovie:__wf_atom_e57658c2(v3.ClipName, 5, v3.Scale * 100)
				mMovie:__wf_atom_e57658c2(v3.ClipName, 6, v3.Scale * 100)
			else
				mMovie:__wf_atom_e57658c2(v3.ClipName, 14, v3.Scale * __wf_atom_97cd8326)
				mMovie:__wf_atom_e57658c2(v3.ClipName, 15, v3.Scale * __wf_atom_54eeda24)
			end

			mMovie:__wf_atom_e57658c2(v3.ClipName, 4, -1000 + module.Round(1000 * v3.Scale))
		end

		mMovie:__wf_atom_e57658c2(v3.ClipName, 12, v3.Alpha)

		if not __wf_atom_7e8ad928(v3.Material) then
			mMovie:OverrideMaterial(v3.ClipName, v3.Material)
		end
	end

	local __wf_atom_d5a50cb5 = mMovie:__wf_atom_d5a50cb5()
	local __wf_atom_c4f6543f = mMovie:__wf_atom_c4f6543f()
	foregroundXScale = module2.CalculateForegroundScale(
		__wf_atom_d5a50cb5,
		__wf_atom_c4f6543f,
		__wf_atom_97cd8326,
		__wf_atom_54eeda24
	)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground", 5, foregroundXScale * 100)
	mMovie:__wf_atom_e57658c2("_root", 0, v)
	mMovie:__wf_atom_e57658c2("_root", 1, v2)
end

local function fn2()
	local color = module2.GetColor(2)
	local color2 = module2.GetColor(3)
	local color3 = module2.GetColor(4)
	local color4 = module2.GetColor(5)
	module2.GetColor(10)
	local color5 = module2.GetColor(0)
	color4:__wf_atom_dcecedb0()
	local color6 = module2.GetColor(1, true)
	local color7 = module2.GetColor(9, true)
	module2.GetColor(8, true)
	mMovie:__wf_atom_e57658c2("Stars", 11, color6)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.BackgroundDesign", 11, color7)
	mMovie:__wf_atom_1ca72041("Clouds", "StartColor", color3.red / 255, color3.green / 255, color3.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("Clouds", "EndColor", color3.red / 255, color3.green / 255, color3.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("CloudsGreen", "StartColor", color5.red / 255, color5.green / 255, color5.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("CloudsGreen", "EndColor", color5.red / 255, color5.green / 255, color5.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("Bg", "StartColor", color.red / 255, color.green / 255, color.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("Bg", "EndColor", color2.red / 255, color2.green / 255, color2.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("Bg2", "StartColor", color.red / 255, color.green / 255, color.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("Bg2", "EndColor", color2.red / 255, color2.green / 255, color2.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("Bg2", "PlasmaStrength_PlasmaTopAtten_PlasmaBottomAtten", 0.01, 1, 1, 0)
	mMovie:__wf_atom_1ca72041("Bg2", "PlasmaSpeed_PlasmaTile", 0.15, 0.5, 0, 0)
	module2.GetColor(6)
	fn()
end

function OnStyleChangedCallback()
	fn2()
end

local function fn3(p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	local v = {
		colorRemapMaterial,
		bgMaterial,
		bg2Material,
		mMovie:__wf_atom_27bb5c88(),
		smokeMaterial
	}
	module2.SetBackgroundVisible(mMovie, p, p2, p3, p4, v, p5, clips)
end

local function fn4(p, p2, p3, p4)
	local v = __wf_atom_7e8ad928(p2) and { x = 0, y = 0 } or p2

	if __wf_atom_7e8ad928(p3) then
		p3 = false
	end

	highlightOffset = v
	highlightOn = p3

	for _, v2 in ipairs(clips) do
		if not v2.Highlight or __wf_atom_7e8ad928(mMovie) then
			continue
		end

		mMovie:__wf_atom_2dedec1a(v2.ClipName, 13, highlightOn)
	end

	fn3(true, p, nil, p4, highlightOn)
end

local function fn5(p, p2) -- 1 equivalent call inferred from this helper
	fn3(false, p, p2, nil, highlightOn)
end

local function fn6()
	return highlightOn, highlightOffset
end

function Initialize()
	_T.ShowBackground = fn4
	_T.HideBackground = fn5
	_T.GetBackgroundInfo = fn6
	mMovie:__wf_atom_2dedec1a("ForegroundContainer.Foreground.Egg", 13, false)
	mMovie:__wf_atom_2dedec1a("ForegroundContainer.Foreground.EggFill", 13, false)
	clips = {}
	table.insert(clips, {
		ClipName = "Bg",
		Texture = bgTexture,
		Scale = 1.1,
		Alpha = 100,
		Material = bgMaterial
	})
	table.insert(clips, {
		ClipName = "Bg2",
		Texture = bgTexture,
		Scale = 1.1,
		Alpha = 30,
		Material = bg2Material
	})
	table.insert(clips, {
		ClipName = "Clouds",
		Scale = 1,
		Alpha = 100,
		KeepProportions = true,
		Material = smokeMaterial
	})
	table.insert(clips, {
		ClipName = "CloudsGreen",
		Scale = 1,
		Alpha = 100,
		KeepProportions = true,
		Material = smokeMaterial
	})
	table.insert(clips, { ClipName = "Stars", Scale = 1.05, Alpha = 100 })
	table.insert(clips, {
		ClipName = "ForegroundContainer",
		Scale = 1,
		Alpha = 100,
		Highlight = true,
		KeepProportions = true
	})
	fn2()

	if _T.BackgroundVisible then
		fn4(0.5, { TrackAvatar = true, x = 0, y = 0 }, true)
	else
		fn5(0, nil) -- inferred equivalent call
	end
end

function Update()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if _T.BackgroundVisible then
		module2.UpdateBackgroundMovement(mMovie, {
			SmoothCursorX = smoothCursorX,
			SmoothCursorY = smoothCursorY,
			RDT = __wf_atom_fa1258d0(),
			HighlightOn = highlightOn,
			HighlightOffset = highlightOffset,
			ForegroundXScale = foregroundXScale,
			Clips = clips
		})
		module2.UpdateForegroundAvatarTracking(mMovie, highlightOffset, foregroundXScale)
	end
end

function onKeyDown_MENU_SELECT() end

function onKeyDown_MENU_CANCEL()
	mMovie:Close()
end

function onViewportSizeChanged(_, _, _, _)
	fn()
end