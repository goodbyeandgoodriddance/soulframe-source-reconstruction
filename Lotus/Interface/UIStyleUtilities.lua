module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local v = WeakResource("")
local v2 = Resource("/Lotus/Fx/ColorGradingData/NeutralColorGrading")
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = false
MovieBackgroundColor = 2825751
MovieBackgroundAlpha = 0.7
PromptTextColor = 5587490

local function fn()
	if not (__wf_atom_7e8ad928(_G.CurrStyle) or __wf_atom_7e8ad928(_G.CurrStyle.Colors) or __wf_atom_7e8ad928(_G.CurrStyle.Background) or __wf_atom_7e8ad928(_G.CurrStyle.Sounds)) then
		return true
	end

	print("UISTYLE: _G.CurrStyle invalid, updating theme")

	if __wf_atom_7e8ad928(gClient) then
		print("UISTYLE: gClient invalid")
	else
		local __wf_atom_3cb140dc = gClient:__wf_atom_3cb140dc()

		if not __wf_atom_7e8ad928(__wf_atom_3cb140dc) then
			print("UISTYLE: overlayMgr valid")
			local __wf_atom_a4bdf2b8 = __wf_atom_3cb140dc:__wf_atom_a4bdf2b8()
			local __wf_atom_cb0fd61c = __wf_atom_3cb140dc:__wf_atom_cb0fd61c()
			local __wf_atom_f57f9624 = __wf_atom_3cb140dc:__wf_atom_f57f9624()

			if not __wf_atom_7e8ad928(__wf_atom_a4bdf2b8) then
				print("UISTYLE: style valid, _G.CurrStyle assigned")
				_G.CurrStyle = {
					Style = __wf_atom_a4bdf2b8,
					Colors = __wf_atom_a4bdf2b8:__wf_atom_3663169e(),
					ColorCorrection = module.Ternary(
						not __wf_atom_7e8ad928(__wf_atom_a4bdf2b8:__wf_atom_ebbf8cf8()),
						__wf_atom_a4bdf2b8:__wf_atom_ebbf8cf8(),
						__wf_atom_a4bdf2b8:__wf_atom_93697128()
					),
					Background = __wf_atom_cb0fd61c,
					Sounds = __wf_atom_f57f9624
				}
			end
		end
	end

	return not (__wf_atom_7e8ad928(_G.CurrStyle) or __wf_atom_7e8ad928(_G.CurrStyle.Colors) or __wf_atom_7e8ad928(_G.CurrStyle.Background) or __wf_atom_7e8ad928(_G.CurrStyle.Sounds))
end

function GetDefaultStyle()
	local __wf_atom_3cb140dc = gClient:__wf_atom_3cb140dc()

	if __wf_atom_7e8ad928(__wf_atom_3cb140dc) then
		return nil, nil, nil
	end

	return
		__wf_atom_3cb140dc:GetDefaultStyle(),
		__wf_atom_3cb140dc:__wf_atom_20628ea2(),
		__wf_atom_3cb140dc:__wf_atom_d09a064f()
end

function ForceDefaultStyle(p, p2, p3)
	if __wf_atom_7e8ad928(gClient) then
		return false
	end

	local __wf_atom_3cb140dc = gClient:__wf_atom_3cb140dc()

	if __wf_atom_7e8ad928(__wf_atom_3cb140dc) then
		return false
	end

	__wf_atom_3cb140dc:__wf_atom_e4811fd6(p, p2, p3)
	return true
end

function GetColor(p, p2, p3)
	local v7 = Color()

	if p3 == false then
		if __wf_atom_7e8ad928(v5) then
			print("UISTYLE: using legacy colors")
			local __wf_atom_3cb140dc = gClient:__wf_atom_3cb140dc()

			if not __wf_atom_7e8ad928(__wf_atom_3cb140dc) then
				v4 = __wf_atom_3cb140dc:__wf_atom_eea8846f()

				if not __wf_atom_7e8ad928(v4) then
					v5 = v4:__wf_atom_3663169e()
				end
			end
		end

		if not __wf_atom_7e8ad928(v5) then
			v7 = v5[p + 1]
		end
	elseif fn() then
		v7 = _G.CurrStyle.Colors[p + 1]
	end

	if p2 then
		return v7:__wf_atom_dcecedb0()
	end

	v7.alpha = 255
	return v7
end

function GetIconOverride(iconOverride)
	if fn() and not __wf_atom_7e8ad928(_G.CurrStyle.Style) then
		iconOverride = _G.CurrStyle.Style:GetIconOverride(iconOverride)
	end

	return iconOverride
end

function GetBackgroundMovie()
	local v7

	if fn() and not __wf_atom_7e8ad928(_G.CurrStyle.Background) then
		return (_G.CurrStyle.Background:GetBackgroundMovie())
	end

	return v7
end

function GetBackgroundLogo()
	local v7

	if fn() and not __wf_atom_7e8ad928(_G.CurrStyle.Background) then
		return (_G.CurrStyle.Background:__wf_atom_0daa3225())
	end

	return v7
end

function GetAnimalLogo(p)
	local v7 = nil
	local v8

	if
		fn()
		and (p or not __wf_atom_7e8ad928(_G.CurrStyle.Background) and _G.CurrStyle.Background:__wf_atom_5b41f63b() == "/Lotus/Interface/Graphics/CustomUI/Backgrounds/SpringFestivalBackground")
	then
		v8 = true
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local settings = __wf_atom_18a5d83b:Settings()

			if not __wf_atom_7e8ad928(settings) then
				v7 = settings:__wf_atom_dad78c1a()
			end
		end

		if v7 == nil then
			v7 = v
		end
	else
		v8 = false
	end

	return v8, v7
end

function HasLoginButtonBorder()
	if fn() and not __wf_atom_7e8ad928(_G.CurrStyle.Background) then
		return _G.CurrStyle.Background:__wf_atom_5b41f63b() == "/Lotus/Interface/Graphics/CustomUI/Backgrounds/SpringFestivalBackground"
	else
		return false
	end
end

function GetSounds()
	local v7

	if fn() and not __wf_atom_7e8ad928(_G.CurrStyle.Sounds) then
		return (_G.CurrStyle.Sounds:GetSounds())
	end

	return v7
end

local function fn2(p, value, p2)
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v7

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		v7 = __wf_atom_c4f78a8f:CameraControl()
	end

	if __wf_atom_7e8ad928(v7) then
		print("No camera control, unable to apply theme color correction!")
	elseif p == nil or p then
		local colorCorrection = fn() and _G.CurrStyle.ColorCorrection

		if colorCorrection == v3 then
			return
		end

		if not __wf_atom_7e8ad928(v3) then
			fn2(false)
		end

		if not __wf_atom_7e8ad928(colorCorrection) then
			local v8 = math.max(0.1, value or 0.35)
			v7:__wf_atom_dc7b15db(colorCorrection, v8, -1, v8, p2 == nil and 1 or p2)
			v3 = colorCorrection
		end
	elseif not __wf_atom_7e8ad928(v3) then
		v7:__wf_atom_928a45c5(v3, true)
		v3 = nil
	end
end

function ApplyColorCorrection(p, p2, p3)
	fn2(p, p2, p3)
end

function RefreshStyle()
	_G.CurrStyle = nil
	fn()

	if v6 then
		fn2(true, 0)
	end
end

function ToggleForcedColorCorrection()
	v6 = not v6
	fn2(v6, 0)
end

local function fn3(p, p2)
	if not __wf_atom_7e8ad928(gRegion) then
		if p2 == true then
			local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

			if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
				local postProcess = __wf_atom_8ad59546.postProcess

				if not __wf_atom_7e8ad928(postProcess) then
					if p then
						if _T.StoredDynamicExposure == nil then
							_T.StoredDynamicExposure = postProcess:__wf_atom_bd002f92()
						end

						postProcess:__wf_atom_81e82b20(4, 4)

						if _T.StoredExposureConvergeSpeed == nil then
							_T.StoredExposureConvergeSpeed = postProcess.exposureConvergeSpeed
						end

						postProcess.exposureConvergeSpeed = 10
						__wf_atom_8ad59546:__wf_atom_dbd87fdd(true)
					else
						__wf_atom_8ad59546:__wf_atom_dbd87fdd(false)

						if _T.StoredDynamicExposure ~= nil then
							postProcess:__wf_atom_81e82b20(
								_T.StoredDynamicExposure.minValue,
								_T.StoredDynamicExposure.maxValue
							)
							_T.StoredDynamicExposure = nil
						end

						if _T.StoredExposureConvergeSpeed ~= nil then
							postProcess.exposureConvergeSpeed = _T.StoredExposureConvergeSpeed
							_T.StoredExposureConvergeSpeed = nil
						end
					end
				end
			end
		end

		if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_469b1d97) then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				local cameraControl = __wf_atom_c4f78a8f:CameraControl()

				if not __wf_atom_7e8ad928(cameraControl) then
					if p then
						cameraControl:__wf_atom_dc7b15db(v2, 0.35, -1, 0.35)
						local __wf_atom_4cd347da = cameraControl:__wf_atom_4cd347da()

						if not __wf_atom_7e8ad928(__wf_atom_4cd347da) then
							_T.BackgroundMovieDepthOverride = __wf_atom_4cd347da:__wf_atom_bb4142b8()
							__wf_atom_4cd347da:__wf_atom_7e990320(100)
							cameraControl:SetCameraSpot(__wf_atom_4cd347da)
						end
					else
						cameraControl:__wf_atom_928a45c5(v2)

						if not __wf_atom_7e8ad928(_T.BackgroundMovieDepthOverride) then
							local __wf_atom_4cd347da = cameraControl:__wf_atom_4cd347da()

							if not __wf_atom_7e8ad928(__wf_atom_4cd347da) then
								__wf_atom_4cd347da:__wf_atom_7e990320(_T.BackgroundMovieDepthOverride)
								cameraControl:SetCameraSpot(__wf_atom_4cd347da)
							end
						end
					end
				end
			end
		end

		if p then
			_T.HiddenFlares = {}
			local v7 = Symbol("BackgroundPersistent")
			local all = gRegion:FindAll(__wf_atom_fac7b40a)

			for i = 1, #all do
				if __wf_atom_7e8ad928(all[i]) or not all[i]:IsActive() or all[i]:HasTag(v7) then
					continue
				end

				all[i]:Disable()
				table.insert(_T.HiddenFlares, all[i])
			end
		else
			local hiddenFlares = _T.HiddenFlares
			_T.HiddenFlares = nil

			for i = 1, #hiddenFlares do
				if not __wf_atom_7e8ad928(hiddenFlares[i]) then
					hiddenFlares[i]:Enable()
				end
			end
		end

		if _T.diegeticsVisibilityOverride == nil then
			__wf_atom_8e4fda44:__wf_atom_864a9745(not p)
		else
			__wf_atom_8e4fda44:__wf_atom_864a9745(_T.diegeticsVisibilityOverride)
			_T.diegeticsVisibilityOverride = nil
		end
	end
end

function UsingBrightBackground()
	if fn() and _G.CurrStyle.Colors[2 + 1]:__wf_atom_72a05e4d() > 0.5 then
		return true
	end

	return false
end

local function fn4(p, state, list)
	if list ~= nil then
		local flag = false

		if state == nil then
			state = {
				Size = 2,
				Center = 0.5,
				FadeSize = 0,
				InvertX = 0,
				InvertY = -1,
				SetTime = 0
			}
		elseif fn() and _G.CurrStyle.Colors[2 + 1]:__wf_atom_72a05e4d() > 0.5 then
			flag = true
		end

		if state.InvertX == nil then
			state.InvertX = 0
		end

		if state.InvertY == nil then
			state.InvertY = -1
		end

		_T.Style_CurrVisRangeInfo = {
			Size = state.Size,
			Center = state.Center,
			FadeSize = state.FadeSize,
			InvertX = state.InvertX,
			InvertY = state.InvertY
		}
		local v7 = { Size = 2, Center = 0.5, FadeSize = 0 }
		local size = state.Size
		local fadeSize = state.FadeSize

		if flag then
			size = state.Size - 0.1
			fadeSize = state.FadeSize * 0.66
		end

		if not __wf_atom_7e8ad928(list[1]) then
			v7.Size = list[1]:__wf_atom_b90af225(SF.__wf_atom_cf0d1cc6, 1)
			v7.Center = list[1]:__wf_atom_b90af225(SF.__wf_atom_5ddc828f, 1)
			v7.FadeSize = list[1]:__wf_atom_b90af225(SF.__wf_atom_7a5b8f59, 1)
		end

		local function fn5(p2)
			local v8 = {
				Size = __wf_atom_104bfe98(v7.Size, size, p2),
				Center = __wf_atom_104bfe98(v7.Center, state.Center, p2),
				FadeSize = __wf_atom_104bfe98(v7.Size, fadeSize, p2)
			}

			for i = 1, #list do
				if __wf_atom_7e8ad928(list[i]) then
					continue
				end

				list[i]:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, v8.Size)
				list[i]:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, v8.Center)
				list[i]:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, v8.FadeSize)
				list[i]:__wf_atom_a042ff6c(SF.__wf_atom_05c75cda, state.InvertX, state.InvertY)
			end
		end

		__wf_atom_ec43d06e(
			p,
			"VisRangeSetter",
			0,
			{ fn5 },
			{ 1 },
			module.Ternary(state.SetTime == nil, 0, state.SetTime)
		)
	end
end

function SetBackgroundVisibleRangeInfo(p, p2, p3)
	fn4(p, p2, p3)
end

function SetBackgroundVisible(object, p, p2, p3, p4, p5, p6, list)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local backgroundVisible = __wf_atom_7e8ad928(p) and true or p

	if _T.BackgroundVisible ~= backgroundVisible then
		_T.BackgroundVisible = backgroundVisible
		local v7 = __wf_atom_7e8ad928(p2) and 0.5 or p2
		local v8 = __wf_atom_7e8ad928(p3) and 0 or p3
		object:__wf_atom_b4ffb30f(backgroundVisible)
		__wf_atom_ec43d06e(object, "_root", 0, { 12 }, { module.Ternary(backgroundVisible, 100, 0) }, v7, v8)
		fn3(backgroundVisible, p6)
	end

	if backgroundVisible then
		fn4(object, p4, p5)

		if not __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
			local __wf_atom_5bb4e2aa = gClient:__wf_atom_5bb4e2aa()
			local v7 = WeakResource("/Lotus/Levels/Proc/PlayerShip")
			local __wf_atom_a744f814 = GraphicsRes.__wf_atom_a744f814(gRegion:__wf_atom_22941262())
			local v8 = __wf_atom_5bb4e2aa ~= v7
			local v9 = __wf_atom_a744f814 == v7

			if v8 and not v9 then
				local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0, false)

				if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
					local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

					if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
						local v10 = __wf_atom_9be88b01:GetInventory():GetActiveQuest() == WeakResource("/Lotus/Types/Keys/NewWarQuest/NewWarQuestKeyChain")

						if not v10 then
							local mBootLocation = __wf_atom_9be88b01:__wf_atom_247a5d2e(true).mBootLocation

							if mBootLocation == 1 then
								v10 = false
							else
								v10 = mBootLocation ~= 2
							end
						end

						if v10 then
							fn3(false, p6)

							for _, v11 in ipairs(list) do
								object:__wf_atom_2dedec1a(v11.ClipName, 13, false)
							end
						end
					end
				end
			end
		end
	end
end

function CalculateForegroundScale(p, p2, p3, p4)
	local v7 = p / p2
	return p3 / p4 / v7
end

function UpdateForegroundAvatarTracking(object, p, p2)
	if p.TrackAvatar and not __wf_atom_7e8ad928(gRegion) then
		local __wf_atom_97cd8326 = object:__wf_atom_97cd8326()
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local __wf_atom_7be51ede = object:__wf_atom_7be51ede()
		local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8("_root", 0)

		if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

			if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				object:__wf_atom_8fcdea81(__wf_atom_eab484a7)
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			object:__wf_atom_e57658c2(
				"ForegroundContainer.Foreground",
				0,
				object:__wf_atom_74b9a49b(__wf_atom_c4f78a8f:GetPosition()).x - __wf_atom_97cd8326 / 2 + __wf_atom_5e6e15c8 + p.x * __wf_atom_97cd8326 * p2
			)
		end
	end
end

function UpdateBackgroundMovement(object, data)
	local screenDimensions, v7 = module.GetScreenDimensions(object)
	local __wf_atom_97cd8326 = object:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = object:__wf_atom_54eeda24()
	local v8 = __wf_atom_421b01aa(object:__wf_atom_79258be8(), 0, screenDimensions) - screenDimensions / 2
	local v9 = __wf_atom_421b01aa(object:__wf_atom_7c4b8de8(), 0, v7) - v7 / 2
	local v10 = -__wf_atom_421b01aa(v8 / screenDimensions, -1, 1)
	local v11 = -__wf_atom_421b01aa(v9 / v7, -1, 1)
	data.SmoothCursorX:__wf_atom_09294a87(v10)
	data.SmoothCursorY:__wf_atom_09294a87(v11)
	data.SmoothCursorX:Update(data.RDT)
	data.SmoothCursorY:Update(data.RDT)
	local __wf_atom_9e368823 = data.SmoothCursorX:__wf_atom_9e368823()
	local __wf_atom_9e368823_2 = data.SmoothCursorY:__wf_atom_9e368823()

	for _, clip in ipairs(data.Clips) do
		if (data.HighlightOn or not clip.Highlight) and clip.Scale ~= nil then
			object:__wf_atom_e57658c2(
				clip.ClipName,
				0,
				module.Ternary(clip.Highlight, data.HighlightOffset.x * __wf_atom_97cd8326 * data.ForegroundXScale, 0) + __wf_atom_9e368823 * (__wf_atom_97cd8326 * 0.5 * (1 - clip.Scale))
			)
			object:__wf_atom_e57658c2(
				clip.ClipName,
				1,
				module.Ternary(clip.Highlight, data.HighlightOffset.y * __wf_atom_54eeda24, 0) + __wf_atom_9e368823_2 * (__wf_atom_54eeda24 * 0.5 * (1 - clip.Scale))
			)
		end

		if not clip.NoMovement then
			continue
		end

		object:__wf_atom_e57658c2(clip.ClipName, 17, -__wf_atom_9e368823 * 5)
		object:__wf_atom_e57658c2(clip.ClipName, 18, -__wf_atom_9e368823_2 * -2)
	end

	object:__wf_atom_e57658c2("_root", 17, __wf_atom_9e368823 * 5)
	object:__wf_atom_e57658c2("_root", 18, __wf_atom_9e368823_2 * -2)
	object:__wf_atom_e57658c2("ForegroundContainer", 17, -__wf_atom_9e368823 * 5)
	object:__wf_atom_e57658c2("ForegroundContainer", 18, -__wf_atom_9e368823_2 * -2)
end

function GetCurrentBackgroundInfo()
	local v7 = { Visible = _T.BackgroundVisible }

	if not v7.Visible then
		return v7
	end

	if _T.Style_CurrVisRangeInfo ~= nil then
		v7.VisRangeInfo = {
			Size = _T.Style_CurrVisRangeInfo.Size,
			Center = _T.Style_CurrVisRangeInfo.Center,
			FadeSize = _T.Style_CurrVisRangeInfo.FadeSize,
			InvertX = _T.Style_CurrVisRangeInfo.InvertX,
			InvertY = _T.Style_CurrVisRangeInfo.InvertY
		}
	end

	if _T.GetBackgroundInfo ~= nil then
		local backgroundInfo, highlightOffset = _T.GetBackgroundInfo()
		v7.HighlightOn = backgroundInfo
		v7.HighlightOffset = highlightOffset
	end

	return v7
end

function SetKneelingAvatar(object, p)
	local v7 = {}

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) then
		return v7
	end

	if not __wf_atom_7e8ad928(_T.TopMenuMovie) then
		object:__wf_atom_9b5dcd3b(nil, false)
	end

	object:__wf_atom_e06358f3(Symbol("InstantKneel"))
	v7.CameraControl = object:CameraControl()

	if not __wf_atom_7e8ad928(v7.CameraControl) then
		v7.OldCameraSpot = v7.CameraControl:__wf_atom_4cd347da()
		v7.CameraSpot = object:Attach(p, EMPTY_SYMBOL, Vector(0, 0.65, 2.1), Rotation(160, 0, 0))
		v7.CameraControl:SetCameraSpot(v7.CameraSpot, 0.1)
	end

	return v7
end

function StandKneelingAvatar(object, p, p2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p.CameraSpot) or __wf_atom_7e8ad928(gRegion) then
		return
	end

	if
		p2
		or not _T.TopMenuOpen
		or __wf_atom_7e8ad928(_T.TopMenuMovie)
		or not _T.TopMenuMovie:Execute("IsAttachedToAvatar", "")
	then
		object:__wf_atom_e06358f3(Symbol("NULL"))
	else
		_T.TopMenuMovie:Execute("TransitionAnims", "")
	end

	p.CameraSpot:Destroy()

	if not __wf_atom_7e8ad928(object) then
		local cameraControl = object:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			if not __wf_atom_7e8ad928(p.OldCameraSpot) then
				cameraControl:SetCameraSpot(nil, 0)
			end

			cameraControl:SetCameraSpot(p.OldCameraSpot, module.Ternary(__wf_atom_7e8ad928(p.OldCameraSpot), 0, 0.25))
		end
	end
end