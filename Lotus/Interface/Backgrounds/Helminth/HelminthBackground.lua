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
	local __wf_atom_dcecedb0 = color3:__wf_atom_dcecedb0()
	local __wf_atom_dcecedb0_2 = color4:__wf_atom_dcecedb0()
	mMovie:__wf_atom_e57658c2("Flowers", 11, __wf_atom_dcecedb0)
	mMovie:__wf_atom_e57658c2("Stars", 11, __wf_atom_dcecedb0_2)
	mMovie:__wf_atom_e57658c2("Triangles", 11, __wf_atom_dcecedb0)
	local color5 = module2.GetColor(1, true)
	local color6 = module2.GetColor(9, true)
	local color7 = module2.GetColor(6)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.EggLine", 11, color5)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.Leaves", 11, color5)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.Circle", 11, color6)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.DetailsTop", 11, color6)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.DetailsBottom", 11, color6)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.DetailsLeft", 11, color6)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.DetailsRight", 11, color6)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.Spokes", 11, color6)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.EdgeDecorationRight", 11, __wf_atom_dcecedb0_2)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.EdgeDecorationLeft", 11, __wf_atom_dcecedb0_2)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.ArmSectionRight.Top", 11, __wf_atom_dcecedb0_2)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.ArmSectionRight.Middle", 11, __wf_atom_dcecedb0)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.ArmSectionRight.Bottom", 11, __wf_atom_dcecedb0_2)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.ArmSectionLeft.Top", 11, __wf_atom_dcecedb0_2)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.ArmSectionLeft.Middle", 11, __wf_atom_dcecedb0)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.ArmSectionLeft.Bottom", 11, __wf_atom_dcecedb0_2)
	mMovie:__wf_atom_e57658c2("ForegroundContainer.Foreground.TennoDecoration", 11, color5)
	mMovie:__wf_atom_933bbce0("ForegroundContainer.Foreground.Egg", eggTexture, colorRemapMaterial)
	mMovie:__wf_atom_1ca72041(
		"ForegroundContainer.Foreground.Egg",
		"StartColor",
		color.red / 255,
		color.green / 255,
		color.blue / 255,
		1
	)
	mMovie:__wf_atom_1ca72041(
		"ForegroundContainer.Foreground.Egg",
		"EndColor",
		color4.red / 255,
		color4.green / 255,
		color4.blue / 255,
		1
	)
	mMovie:__wf_atom_1ca72041("Bg", "StartColor", color.red / 255, color.green / 255, color.blue / 255, 1)
	mMovie:__wf_atom_1ca72041("Bg", "EndColor", color2.red / 255, color2.green / 255, color2.blue / 255, 1)
	local count = 0

	repeat
		count += 1
		local v = "Flowers.Flower" .. count
		mMovie:__wf_atom_1ca72041(v, "RipplesColor", color7.red / 255, color7.green / 255, color7.blue / 255, 0.4)
	until not mMovie:__wf_atom_253d7085(v)

	fn()
end

function OnStyleChangedCallback()
	fn2()
end

local function fn3(p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	local v = { clips[1].Material, flowersMaterial, mMovie:__wf_atom_27bb5c88() }
	module2.SetBackgroundVisible(mMovie, p, p2, p3, p4, v, p5, clips)
end

local function fn4(p, p2, p3, p4, p5)
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

	fn3(true, p, p5, p4, highlightOn)
end

local function fn5(p, p2) -- 1 equivalent call inferred from this helper
	fn3(false, p, p2, nil, highlightOn)
end

local function fn6()
	return highlightOn, highlightOffset
end

local function fn7(material, _, _)
	if __wf_atom_7e8ad928(material) then
		clips[1].Material = colorRemapMaterial
		mMovie:OverrideMaterial("Bg", colorRemapMaterial)
		mMovie:__wf_atom_e57658c2("Stars", 12, 100)
	else
		clips[1].Material = material
		mMovie:OverrideMaterial("Bg", material)
		mMovie:__wf_atom_e57658c2("Stars", 12, 0)
	end
end

function Initialize()
	_T.ShowBackground = fn4
	_T.HideBackground = fn5
	_T.GetBackgroundInfo = fn6
	_T.SetMaskedBackgroundVis = fn7
	clips = {}
	table.insert(clips, {
		ClipName = "Bg",
		Texture = bgTexture,
		Scale = 1.1,
		Alpha = 100,
		Material = colorRemapMaterial
	})
	table.insert(clips, {
		ClipName = "Flowers",
		Texture = flowersTexture,
		Scale = 1.075,
		Alpha = 40,
		KeepProportions = true
	})
	table.insert(clips, { ClipName = "Stars", Scale = 1.05, Alpha = 100 })
	table.insert(clips, { ClipName = "Triangles", Scale = 1.045, Alpha = 7 })
	table.insert(clips, {
		ClipName = "ForegroundContainer",
		Scale = 1,
		Alpha = 100,
		Highlight = true,
		KeepProportions = true
	})
	local count = 0

	repeat
		count += 1
		local v = "Flowers.Flower" .. count
		mMovie:OverrideMaterial(v, flowersMaterial)
	until not mMovie:__wf_atom_253d7085(v)

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