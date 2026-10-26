module(..., package.seeall)
local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("EE.Interface.Utilities")
require("SF.Scripts.Libs.QuestLib")
local movie = nil
local gGameRules2 = nil
local v = nil
local v2 = false
local savedHudTrackers2 = {
	CurrentIndex = 0,
	List = 0,
	TypeInfo = 0,
	ActiveHealthTrackers = 0,
	ActiveUpdaters = 0,
	ActiveBlinkTrackers = 0
}
savedHudTrackers2.CurrentIndex = 0
savedHudTrackers2.List = {}
savedHudTrackers2.TypeInfo = {}
savedHudTrackers2.ActiveHealthTrackers = {}
savedHudTrackers2.ActiveUpdaters = {}
savedHudTrackers2.ActiveBlinkTrackers = {}
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = {}
local function fn(location, location2)
	local typeName = type(location)
	local typeName2 = type(location2)

	if typeName ~= typeName2 then
		return false
	end

	if typeName ~= "table" and typeName2 ~= "table" then
		return location == location2
	end

	local metatable = getmetatable(location)

	if metatable and metatable.__eq then
		return location == location2
	end

	for k, item in pairs(location) do
		local item2 = location2[k]

		if item2 == nil or not fn(item, item2) then
			return false
		end
	end

	for k, item in pairs(location2) do
		local item2 = location[k]

		if item2 == nil or not fn(item2, item) then
			return false
		end
	end

	return true
end

local function fn2()
	if gRegion:IsMaster() then
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		for i = 1, #__wf_atom_3c8e1a7a do
			if not __wf_atom_7e8ad928(__wf_atom_3c8e1a7a[i]) then
				__wf_atom_3c8e1a7a[i]:__wf_atom_1fe991d0(false)
			end
		end
	end
end

function MissionTimerWaitBeforeEndMission()
	fn2()
end

local function fn3(p, ...)
	if v4 then
		v4(p, ...)
	end
end

local function fn4(fn5, ...)
	if v5 then
		v5(fn5, ...)
	else
		fn5(...)
	end
end

local function fn5() -- 4 equivalent calls inferred from this helper
	if v6 then
		v6(savedHudTrackers2)
	end
end

local function fn6(state, _)
	if not state.NeedsInit then
		return
	end

	local kind = state.Data.Type
	state.NeedsInit = nil

	if kind == module.HT_ICON_BAR then
		function state.List:AddElement(_, _)
			return nil
		end

		function state.List:RemoveElement(_, _, _, _, _, _) end

		function state.List:RemoveElements(_, _) end

		for _, v8 in pairs(state.InitFuncQueue) do
			v8[1](v8[2], v8[3], v8[4], v8[5], v8[6], v8[7])
		end
	end

	if state.InitCallBack then
		state.InitCallBack(state)
		state.InitCallBack = nil
	end

	if not __wf_atom_7e8ad928(state.Data.Location) then
		for _, locationTrackerAddedCallback in ipairs(_T.LocationTrackerAddedCallbacks) do
			locationTrackerAddedCallback(state)
		end
	end

	fn5() -- inferred equivalent call
end

local function fn7(list, data, p)
	if data.Icon then
		movie:__wf_atom_c90af43a(data.mClipName .. ".Bg", data.Icon)
	end

	if data.Rotation then
		movie:__wf_atom_4c1c1986(data.mClipName, "Bg", 16, data.Rotation)
	end

	if data.Width then
		movie:__wf_atom_4c1c1986(data.mClipName, "Bg", 14, data.Width)
	end

	if data.Height then
		movie:__wf_atom_4c1c1986(data.mClipName, "Bg", 15, data.Height)
	end

	if data.X then
		local v8

		if p and p.mClipName then
			local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(p.mClipName, 0)
			v8 = __wf_atom_5e6e15c8 == nil and 0 or __wf_atom_5e6e15c8
		else
			v8 = 0
		end

		if p or not list.mForcedHorizontalSeparation then
			movie:__wf_atom_e57658c2(data.mClipName, 0, data.X + v8)
		end
	end

	if data.Y then
		local v8

		if p and p.mClipName then
			local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(p.mClipName, 1)
			v8 = __wf_atom_5e6e15c8 == nil and 0 or __wf_atom_5e6e15c8
		else
			v8 = 0
		end

		if p or not list.mForcedVerticalSeparation then
			movie:__wf_atom_e57658c2(data.mClipName, 1, data.Y + v8)
		end
	end

	if data.Label then
		movie:__wf_atom_50d60589(data.mClipName .. ".Label", 36, data.Label)
	end

	if data.Alpha then
		movie:__wf_atom_e57658c2(data.mClipName, 12, data.Alpha)
	end

	if data.Visible then
		movie:__wf_atom_2dedec1a(data.mClipName, 13, data.Visible)
	end

	if data.Color then
		movie:__wf_atom_e57658c2(data.mClipName, 11, data.Color)
	end
end

local function fn8(state, p)
	if not state.NeedsInit then
		return
	end

	local kind = state.Data.Type
	local clipName = state.ClipName
	local v8 = state.Data.Height ~= nil
	__wf_atom_86cbd68d(
		movie,
		"HudTracker.Trackers." .. savedHudTrackers2.TypeInfo[kind].Name .. ".duplicateMovieClip",
		p,
		500 + state.Index
	)

	if not v8 then
		state.Data.Height = movie:__wf_atom_5e6e15c8(state.ClipName, 15)
	end

	state.BaseX = movie:__wf_atom_5e6e15c8(clipName, 0)
	state.Data.LocalizeLabels = state.Data.LocalizeLabels or {}

	if kind == module.HT_PROGRESS_BAR then
		if not v8 then
			state.Data.Height = state.Data.Height - 15
		end

		state.InitMessageXPos = movie:__wf_atom_5e6e15c8(clipName .. ".Message", 0)
		state.InitGoalXPos = movie:__wf_atom_5e6e15c8(clipName .. ".Goal", 0)
		movie:OverrideMaterial(clipName .. ".Progress", _G.UIMaterial_Plain)
		movie:OverrideMaterial(clipName .. ".Progress.Fill", v7.radialProgressMaterial)
		movie:__wf_atom_1ca72041(clipName .. ".Progress.Fill", "AlphaTestThreshold", 0, 0, 0, 0)

		if state.Data.Icon == nil then
			state.SetIcon(v7.defaultBroadcastIcon)
		end
	elseif kind == module.HT_TIMER then
		if state.Data.Label == nil then
			state.SetLabel("/Lotus/Language/Menu/AlertPopup_Time")
		end
	elseif kind == module.HT_HEALTH_TRACKER then
		movie:__wf_atom_e57658c2(clipName, 12, 0)
		movie:__wf_atom_4c1c1986(clipName, "LostHealth", 12, 0)
		movie:__wf_atom_7f57ab2f(clipName, "Name", 54, true)
	elseif kind == module.HT_OPPONENT_BAR then
		movie:__wf_atom_48bd5a59(clipName, "UpperProgressLabel", 36, "0%")
		movie:__wf_atom_4c1c1986(clipName, "UpperProgressBar.Progress", 5, __wf_atom_421b01aa(0, 0.001, 100))
		movie:__wf_atom_4c1c1986(clipName, "UpperProgressBar.Bg", 11, 13421772)
		movie:__wf_atom_48bd5a59(clipName, "LowerProgressLabel", 36, "0%")
		movie:__wf_atom_4c1c1986(clipName, "LowerProgressBar.Progress", 5, __wf_atom_421b01aa(0, 0.001, 100))
		movie:__wf_atom_4c1c1986(clipName, "LowerProgressBar.Bg", 11, 13421772)
		movie:OverrideMaterial(clipName .. ".UpperProgressBar.Bg", _G.UIMaterial_SmoothEdgeNoDepthTest)
		movie:OverrideMaterial(clipName .. ".LowerProgressBar.Bg", _G.UIMaterial_SmoothEdgeNoDepthTest)
		movie:OverrideMaterial(clipName .. ".UpperProgressBar.Progress", _G.UIMaterial_SmoothEdgeNoDepthTest)
		movie:OverrideMaterial(clipName .. ".LowerProgressBar.Progress", _G.UIMaterial_SmoothEdgeNoDepthTest)
	elseif kind == module.HT_LABEL then
		if not v8 then
			state.Data.Height = state.Data.Height + 15
		end

		movie:__wf_atom_7f57ab2f(clipName, "Label", 89, true)
		movie:__wf_atom_7f57ab2f(clipName, "Icon", 13, false)
		movie:__wf_atom_7f57ab2f(clipName, "Banner", 13, false)
		movie:__wf_atom_4c1c1986(clipName, "Glow", 12, 0)
		movie:__wf_atom_4c1c1986(clipName, "LongGlow", 12, 0)
	elseif kind == module.HT_ICON_BAR then
		if not v8 then
			state.Data.Height = state.Data.Height + 20
		end

		local v9 = clipName .. ".Element"
		movie:__wf_atom_2dedec1a(v9, 13, false)
		local module4 = require("EE.Interface.Components.List")
		local list = module4.CreateList(movie, clipName .. ".Element")
		list.mForcedVerticalSeparation = 0
		list.mForcedHorizontalSeparation = 22

		function list.mElementDrawCallback(p2)
			fn7(list, p2)

			for _, stackedElement in pairs(p2.StackedElements) do
				if __wf_atom_7e8ad928(stackedElement.mClipName) then
					__wf_atom_86cbd68d(
						movie,
						p2.mClipName .. ".duplicateMovieClip",
						stackedElement.Name,
						stackedElement.Depth
					)
					local v10 = 0

					while true do
						local v11 = p2.mClipName:find("%.", v10 + 1)

						if not v11 then
							break
						end

						v10 = v11
					end

					if v10 > 0 then
						stackedElement.mClipName = p2.mClipName:sub(1, v10) .. stackedElement.Name
					end
				end

				fn7(list, stackedElement, p2)
			end

			if state.CustomDrawFunction then
				state.CustomDrawFunction(movie, list, p2)
			end
		end

		list._IconList_Redraw = list.Redraw

		function list:Redraw(p2, p3, p4)
			if __wf_atom_7e8ad928(movie) then
				return
			end

			if #state.List.mElements > 0 then
				movie:__wf_atom_7f57ab2f(clipName, "Element", 13, state.List.mElements[1].Visible ~= false)
			else
				movie:__wf_atom_7f57ab2f(clipName, "Element", 13, true)
			end

			self:_IconList_Redraw(p2, p3, p4)
		end

		for k, v10 in pairs(state.List) do
			if type(k) == "string" and k ~= "Redraw" then
				list[k] = v10
			end
		end

		if state.List.mForcedVerticalSeparation == nil then
			list.mForcedVerticalSeparation = nil
		end

		if state.List.mForcedHorizontalSeparation == nil then
			list.mForcedHorizontalSeparation = nil
		end

		state.List = list
		state.NeedsInit = nil

		for _, v10 in pairs(state.InitFuncQueue) do
			v10[1](v10[2], v10[3], v10[4], v10[5], v10[6], v10[7])
		end

		if state.InitRedraw then
			state.List:Redraw(state.InitRedraw.Callback, state.InitRedraw.ForceRedraw, state.InitRedraw.InstantDraw)
			state.InitRedraw = nil
		end
	elseif kind == module.HT_TEMPERATURE_BAR then
		movie:OverrideMaterial(clipName .. ".RangeSegment", v7.temperatureSegmentMaterial)
		movie:__wf_atom_4c1c1986(clipName, "HighlightDeco", 12, 0)
		movie:__wf_atom_4c1c1986(clipName, "HighlightLeftEdge", 12, 0)
		movie:__wf_atom_4c1c1986(clipName, "HighlightRightEdge", 12, 0)
		movie:__wf_atom_4c1c1986(clipName, "HighlightSegment", 12, 0)
	elseif kind == module.HT_CORRUPTION_BAR then
		movie:__wf_atom_7f57ab2f(clipName, "CorruptionNode", 13, false)
		movie:OverrideMaterial(clipName .. ".Fill", v7.corruptionFillMaterial)
		movie:OverrideMaterial(clipName .. ".FillOutline", v7.corruptionFillMaterial)
		movie:OverrideMaterial(clipName .. ".BgDeco", _G.UIMaterial_Plain)
		movie:__wf_atom_4c1c1986(clipName, "FillBg", 12, 10)
		movie:__wf_atom_4c1c1986(clipName, "FillOutlineBg", 12, 30)
		movie:__wf_atom_4c1c1986(clipName, "Glow", 12, 55)
		movie:__wf_atom_4c1c1986(clipName, "BgDeco", 12, 50)
		movie:__wf_atom_7f57ab2f(clipName, "FillLine", 13, false)
	elseif kind == module.HT_NODE_CONFLICT_BAR then
		local v9 = clipName .. ".NodeContainer.Node"
		movie:__wf_atom_2dedec1a(v9, 13, false)
		movie:__wf_atom_2dedec1a(clipName .. ".FxAnchor", 13, false)
		movie:OverrideMaterial(clipName, _G.UIMaterial_Plain)
		movie:OverrideMaterial(clipName .. ".Flare.FlareCenter", _G.UIMaterial_Plain)
		movie:OverrideMaterial(clipName .. ".Flare.FlareLeft", _G.UIMaterial_Plain)
		movie:OverrideMaterial(clipName .. ".Flare.FlareRight", _G.UIMaterial_Plain)
		movie:OverrideMaterial(clipName .. ".Trough", _G.UIMaterial_Plain)
		movie:OverrideMaterial(clipName .. ".FillLeft", v7.nodeConflictMaterial)
		movie:OverrideMaterial(clipName .. ".FillRight", v7.nodeConflictMaterial)
		movie:OverrideMaterial(clipName .. ".BackerSwirls", v7.nodeConflictBgMaterial)
		movie:__wf_atom_1ca72041(clipName .. ".BackerSwirls", "RippleAnimationSettings", 0, 0, 0, 0)
		movie:__wf_atom_1ca72041(clipName .. ".FillRight", "WipeSpeed", 15, 0, 0, 0)
		local module4 = require("EE.Interface.Components.List")
		local list = module4.CreateList(movie, v9)
		list.mForcedVerticalSeparation = 0
		list.mForcedHorizontalSeparation = 22
		list.mLeftCount = 0
		list.mRightCount = 0

		function list.mClipCreatedCallback(p2)
			movie:OverrideMaterial(p2 .. ".Trough", v7.diamondMaterial)
			movie:OverrideMaterial(p2 .. ".Fill", v7.diamondProgressMaterial)
			movie:OverrideMaterial(p2 .. ".Pulse", v7.diamondProgressMaterial)
			movie:OverrideMaterial(p2 .. ".Icon", _G.UIMaterial_Plain)
			movie:OverrideMaterial(p2 .. ".IconBg", _G.UIMaterial_Plain)
			movie:OverrideMaterial(p2 .. ".DiamondBacker", _G.UIMaterial_Plain)
			movie:__wf_atom_4c1c1986(p2, "Trough", 11, _G.UIColor_White)
			movie:__wf_atom_4c1c1986(p2, "DiamondBacker", 11, 1315613)
			movie:__wf_atom_4c1c1986(p2, "Trough", 12, 40)
			movie:__wf_atom_1ca72041(p2 .. ".Trough", "CircleSettings", 0.485, 0.08, 0.65, 0)
			movie:__wf_atom_1ca72041(p2 .. ".Fill", "CircleSettings", 0.485, 0.08, 0.65, 0)
			movie:__wf_atom_1ca72041(p2 .. ".Pulse", "CircleSettings", 0.485, 0.12, 0.65, 0)
			movie:__wf_atom_1ca72041(p2 .. ".Pulse", "AlphaTestThreshold", 1, 0, 0, 0)
			movie:__wf_atom_4c1c1986(p2, "Pulse", 12, 0)
			movie:__wf_atom_2dedec1a(p2, 13, true)
		end

		function list:mElementDrawCallback()
			if self.IsLeftSide then
				local leftColorId = state.Data.LeftColorId

				if not state.Data.LeftColorHex then
					leftColorId = v:__wf_atom_fd5d793e(leftColorId)
				end

				movie:__wf_atom_4c1c1986(self.mClipName, "IconBg", 11, leftColorId)
				movie:__wf_atom_4c1c1986(self.mClipName, "Fill", 11, leftColorId)
				movie:__wf_atom_4c1c1986(self.mClipName, "Pulse", 11, leftColorId)
			else
				local rightColorId = state.Data.RightColorId

				if not state.Data.RightColorHex then
					rightColorId = v:__wf_atom_fd5d793e(rightColorId)
				end

				movie:__wf_atom_4c1c1986(self.mClipName, "IconBg", 11, rightColorId)
				movie:__wf_atom_4c1c1986(self.mClipName, "Fill", 11, rightColorId)
				movie:__wf_atom_4c1c1986(self.mClipName, "Pulse", 11, rightColorId)
			end

			movie:__wf_atom_1ca72041(self.mClipName .. ".Fill", "AlphaTestThreshold", self.Progress, 0, 0, 0)
			movie:__wf_atom_7f57ab2f(self.mClipName, "Icon", 13, not self.HideCenter)
			movie:__wf_atom_7f57ab2f(self.mClipName, "IconBg", 13, not self.HideCenter)

			if self.ShouldPulse then
				movie:__wf_atom_4c1c1986(self.mClipName, "Pulse", 12, 100)
				movie:__wf_atom_4c1c1986(self.mClipName, "Pulse", 5, 100)
				movie:__wf_atom_4c1c1986(self.mClipName, "Pulse", 6, 100)
				__wf_atom_ec43d06e(movie, self.mClipName .. ".Pulse", 2, { 5, 6, 12 }, { 200, 200, 0 }, 1)
				self.ShouldPulse = nil
			end
		end

		function list:CalculateX(p2)
			local v10 = __wf_atom_7e8ad928(self.mForcedHorizontalSeparation) and 0 or self.mForcedHorizontalSeparation

			if p2.IsLeftSide then
				self.mLeftCount += 1
				return (self.UTIL.Round(self.mInitialX + v10 * (self.mLeftCount - 1)))
			end

			self.mRightCount += 1
			return (self.UTIL.Round(self.mInitialX + 253 - v10 * (self.mRightCount - 1)))
		end

		list._Redraw = list.Redraw

		function list:Redraw(p2, p3, p4)
			if __wf_atom_7e8ad928(movie) then
				return
			end

			self.mLeftCount = 0
			self.mRightCount = 0
			self:_Redraw(p2, p3, p4)
		end

		state.List = list
		state.NeedsInit = nil

		for _, v10 in pairs(state.InitFuncQueue) do
			v10[1](v10[2], v10[3], v10[4], v10[5], v10[6], v10[7])
		end
	elseif kind == module.HT_DRAGON_TRACKER then
		movie:__wf_atom_7f57ab2f(clipName, "Circle", 13, false)
		movie:__wf_atom_7f57ab2f(clipName, "Direction", 13, false)
		movie:__wf_atom_7f57ab2f(clipName, "ProgressContainer", 13, false)
		movie:__wf_atom_7f57ab2f(clipName, "ProgressFlare", 13, false)
		movie:OverrideMaterial(clipName .. ".Bg", _G.UIMaterial_Plain)
		movie:OverrideMaterial(clipName .. ".Direction", _G.UIMaterial_Plain)
		movie:OverrideMaterial(clipName .. ".ProgressContainer.ProgressCircle", v7.radialProgressMaterial)
		movie:__wf_atom_933bbce0(clipName .. ".ProgressFlare", v7.dragonFlareTexture, v7.dragonFlareMaterial)
		movie:__wf_atom_4c1c1986(clipName, "ProgressContainer.ProgressCircle", 11, 15258973)
		movie:__wf_atom_1ca72041(clipName .. ".ProgressContainer.ProgressCircle", "AlphaTestThreshold", 0.3, 0, 0, 0)
		movie:__wf_atom_e57658c2(clipName .. ".Direction", 16, state.TargetRotation)
		local v9 = 5 * state.LineThickness

		for i = 1, 5 do
			state.SetRingColor(i, 12495206)

			if i == 1 then
				for j = 2, state.LineThickness do
					__wf_atom_86cbd68d(movie, clipName .. ".Circle.Line1.duplicateMovieClip", "Line" .. j, 300 + j)
				end
			else
				for j = 1, state.LineThickness do
					local v10 = (i - 1) * state.LineThickness + j
					__wf_atom_86cbd68d(movie, clipName .. ".Circle.Line1.duplicateMovieClip", "Line" .. v10, 300 + v10)
				end
			end

			if i > 1 then
				__wf_atom_86cbd68d(
					movie,
					clipName .. ".Circle.ArrowRotator1.duplicateMovieClip",
					"ArrowRotator" .. i,
					20 + i
				)
			end

			movie:__wf_atom_7f57ab2f(clipName, "Circle.ArrowRotator" .. i, 13, false)
		end

		for i = 1, v9 do
			movie:__wf_atom_7f57ab2f(clipName, "Circle.Line" .. i, 13, false)
		end
	else
		local _ = kind == module2.HT_PROGRESS_TRACKER
	end

	if v2 and kind ~= module.HT_TIMER then
		state.SetVisible(false)
		state.IgnoreVis = true
	end

	if state.Data.FadeTime and state.Data.FadeTime > 0 then
		movie:__wf_atom_e57658c2(clipName, 12, 0)
		__wf_atom_ec43d06e(movie, clipName, 0, { 12 }, { 100 }, state.Data.FadeTime)
	end

	if not __wf_atom_7e8ad928(state.UpdateHudColors) then
		state.UpdateHudColors()
	end

	state.NeedsInit = nil

	if state.InitCallBack then
		state.InitCallBack(state)
		state.InitCallBack = nil
	end

	if not __wf_atom_7e8ad928(state.Data.Location) then
		for _, locationTrackerAddedCallback in ipairs(_T.LocationTrackerAddedCallbacks) do
			locationTrackerAddedCallback(state)
		end
	end

	fn5() -- inferred equivalent call
end

local function fn9(p)
	for i, v8 in ipairs(savedHudTrackers2.List) do
		if v8.ClipName ~= p.ClipName then
			continue
		end

		if not __wf_atom_7e8ad928(movie) then
			__wf_atom_86cbd68d(movie, p.ClipName .. ".removeMovieClip")
		end

		if not __wf_atom_7e8ad928(p.Display) then
			gRegion:__wf_atom_dd1e4d10(p.Display)
		end

		table.remove(savedHudTrackers2.List, i)

		if not v6 then
			break
		end

		v6(savedHudTrackers2)
		break
	end
end

local function fn10(value, p)
	local v8 = nil

	if type(value) == "string" then
		for _, v9 in ipairs(savedHudTrackers2.List) do
			if v9.Name ~= value then
				continue
			end

			v8 = v9
			break
		end
	elseif not (__wf_atom_7e8ad928(value) or __wf_atom_7e8ad928(value.ClipName)) then
		for _, v9 in ipairs(savedHudTrackers2.List) do
			if value.Name ~= v9.Name then
				continue
			end

			v8 = v9
			break
		end
	end

	if v8 and not v8.Removing then
		savedHudTrackers2.ActiveHealthTrackers[v8.ClipName] = nil
		savedHudTrackers2.ActiveUpdaters[v8.ClipName] = nil
		savedHudTrackers2.ActiveBlinkTrackers[v8.ClipName] = nil
		v8.Removing = true
		v8.NeedsInit = nil
		local v9 = not (__wf_atom_7e8ad928(p) and v8.Data.FadeTime) and 0.15 or v8.Data.FadeTime

		if not v8.Local then
			if __wf_atom_7e8ad928(gGameRules2) then
				fn4(function()
					if not __wf_atom_7e8ad928(gGameRules2) then
						gGameRules2:RemoveHudTracker(v8.Name)
					end
				end)
			else
				gGameRules2:RemoveHudTracker(v8.Name)
			end
		end

		if __wf_atom_7e8ad928(movie) then
			v3:AddTimer(v9, function()
				fn9(v8)
			end)
		else
			__wf_atom_ec43d06e(movie, v8.ClipName, 0, { 12 }, { 0 }, v9, 0, function()
				fn9(v8)
			end)
		end

		if not __wf_atom_7e8ad928(v8.Data.TrackingId) then
			if _T.ObjectiveTrackers == nil then
				_T.ObjectiveTrackers = {}
			end

			if _T.ObjectiveTrackers[v8.Data.TrackingId] == nil then
				_T.ObjectiveTrackers[v8.Data.TrackingId] = {}
			end

			_T.ObjectiveTrackers[v8.Data.TrackingId][v8.Name] = nil
		end
	end
end

function RemoveHudTracker(p, p2)
	fn10(p, p2)
end

function GetHudTracker(p)
	for _, v8 in ipairs(savedHudTrackers2.List) do
		if v8.Name == p then
			return v8
		end
	end

	return nil
end

local function fn11(params)
	for k, item in pairs(params) do
		if type(item) == "number" then
			params[k] = module3.FormatNumber(item)
		end
	end
end

local function fn12(name, p, p2, p3, p4, initCallBack, p5)
	for _, v8 in ipairs(savedHudTrackers2.List) do
		if v8.Name == name and not v8.Removing then
			return v8
		end
	end

	local v8 = p4 == nil or p4
	local fadeTime = p2 == nil and 0.15 or p2
	local sortPriority2 = (__wf_atom_7e8ad928(p3) or p3 == false or p3 == true) and 5 or p3
	local v9 = p5 == nil or p5

	if savedHudTrackers2.TypeInfo[p] == nil then
		return nil
	end

	savedHudTrackers2.CurrentIndex += 1
	local v10 = savedHudTrackers2.TypeInfo[p].Name .. savedHudTrackers2.CurrentIndex
	local clipName = "HudTracker.Trackers." .. v10
	local flag = true
	local result = {
		ClipName = 0,
		NeedsInit = 0,
		InitCallBack = 0,
		Name = 0,
		Movie = 0,
		Local = 0,
		Index = 0,
		Data = 0
	}
	result.ClipName = clipName
	result.NeedsInit = true
	result.InitCallBack = initCallBack
	result.Name = name
	result.Movie = movie
	result.Local = not v8
	result.Index = savedHudTrackers2.CurrentIndex
	result.Data = {
		Type = p,
		OffsetX = 0,
		OffsetY = 0,
		FadeTime = fadeTime,
		SortPriority = sortPriority2
	}

	local function fn13()
		if v8 and not result.Removing then
			if __wf_atom_7e8ad928(gRegion) or not gRegion:IsMaster() then
				return
			end

			if __wf_atom_7e8ad928(gGameRules2) then
				fn4(function()
					if not __wf_atom_7e8ad928(gGameRules2) then
						gGameRules2:UpdateHudTracker(result.Name, cjson.encode(result.Data), result.EntityInfo)
					end
				end)
			else
				gGameRules2:UpdateHudTracker(result.Name, cjson.encode(result.Data), result.EntityInfo)
			end
		end
	end

	function result.Localize(tag, params, upper)
		fn11(params)

		for _, localizeLabel in ipairs(result.Data.LocalizeLabels) do
			if not (localizeLabel.Tag == tag and localizeLabel.Upper == upper) then
				continue
			end

			localizeLabel.Params = params
			return tag
		end

		table.insert(result.Data.LocalizeLabels, { Tag = tag, Params = params, Upper = upper })
		return tag
	end

	function result.SetOffset(offsetX, offsetY, p6)
		local flag2

		if offsetX == nil or not p6 and offsetX == result.Data.OffsetX then
			flag2 = false
		else
			result.Data.OffsetX = offsetX
			flag2 = true
		end

		if offsetY ~= nil and (p6 or offsetY ~= result.Data.OffsetY) then
			result.Data.OffsetY = offsetY
			flag2 = true
		end

		if flag2 then
			fn13()
			fn3(fn5)
		end
	end

	function result.SetHeight(height, p6, p7)
		if result.Data.AutoHeight and not p7 then
			result.Data.AutoHeight = nil
		end

		if not p6 and height == result.Data.Height then
			return
		end

		result.Data.Height = height
		fn13()
		fn3(fn5)
	end

	function result.SetVisible(visible, p6)
		if result.IgnoreVis or not p6 and visible == result.Visible then
			return
		end

		result.Visible = visible

		if result.Data.AutonomousVisibility then
			result.Data.Visible = nil
		else
			result.Data.Visible = visible
			fn13()
		end

		fn3(function()
			fn5() -- inferred equivalent call
			movie:__wf_atom_2dedec1a(clipName, 13, visible)
		end)
	end

	function result.IgnoreStacking(ignoreStacking, static, p6)
		if not p6 and ignoreStacking == result.Data.IgnoreStacking and static == result.Data.static then
			return
		end

		result.Data.IgnoreStacking = ignoreStacking
		result.Data.Static = static
		fn13()
		fn3(fn5)
	end

	function result.SetSortPriority(sortPriority, p6)
		if sortPriority == result.Data.SortPriority then
			return
		end

		result.Data.SortPriority = sortPriority
		fn13()

		if not p6 then
			fn3(fn5)
		end
	end

	function result.SetLocation(location)
		if fn(location, result.Data.Location) then
			return
		end

		result.Data.Location = location
		result.AutonomousVisibility = true
		fn13()
	end

	function result.AddToLocation(items)
		if result.Data.Location == nil then
			result.SetLocation(items)
			return
		end

		local copyTableRecursive = module3.CopyTableRecursive(result.Data.Location)

		for k, item in pairs(items) do
			copyTableRecursive[k] = item
		end

		result.SetLocation(copyTableRecursive)
	end

	function result.ApplyDataCommon(data, p6)
		result.SetOffset(data.OffsetX, data.OffsetY, p6)

		if not __wf_atom_7e8ad928(data.Height) then
			result.SetHeight(data.Height, p6, data.AutoHeight)
		end

		if not __wf_atom_7e8ad928(data.Location) then
			result.SetLocation(data.Location)
		end

		if not __wf_atom_7e8ad928(data.AutonomousVisibility) then
			result.AutonomousVisibility = data.AutonomousVisibility
		end

		if result.AutonomousVisibility then
			if result.Visible == nil then
				result.SetVisible(false)
			end
		elseif not __wf_atom_7e8ad928(data.Visible) then
			result.SetVisible(data.Visible, p6)
		end

		if not __wf_atom_7e8ad928(data.SortPriority) then
			result.SetSortPriority(data.SortPriority)
		end

		if not __wf_atom_7e8ad928(data.IgnoreStacking) then
			result.IgnoreStacking(data.IgnoreStacking, data.Static, p6)
		end

		if not __wf_atom_7e8ad928(data.TrackingId) then
			if _T.ObjectiveTrackers == nil then
				_T.ObjectiveTrackers = {}
			end

			if _T.ObjectiveTrackers[data.TrackingId] == nil then
				_T.ObjectiveTrackers[data.TrackingId] = {}
			end

			_T.ObjectiveTrackers[data.TrackingId][result.Name] = result
		end
	end

	if p == module.HT_PROGRESS_BAR then
		result.Data.Progress = 0
		result.Data.Padding = -7
		result.Data.LocalizeLabels = {}
		result.Data.LabelColorId = 41
		result.Data.GoalColorId = 41
		result.Data.ProgressColorId = 41
		result.Data.IconColorId = 41
		result.Data.FlareColorId = 40
		result.InitMessageXPos = 32
		result.InitGoalXPos = 32

		function result.Localize(tag, params, upper)
			fn11(params)

			for _, localizeLabel in ipairs(result.Data.LocalizeLabels) do
				if not (localizeLabel.Tag == tag and localizeLabel.Upper == upper) then
					continue
				end

				localizeLabel.Params = params
				return tag
			end

			table.insert(result.Data.LocalizeLabels, { Tag = tag, Params = params, Upper = upper })
			return tag
		end

		function result.SetLabel(p6, labelAnimRate, p7)
			local label = p6 == nil and "" or p6

			if not p7 and label == result.Data.Label then
				return
			end

			result.Data.Label = label
			result.Data.LabelAnimRate = labelAnimRate
			fn13()
			fn3(function()
				local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(label, true)

				if labelAnimRate then
					module3.AnimateTyping(movie, nil, clipName .. ".Message", __wf_atom_8e9ac384, nil, labelAnimRate)
				else
					movie:__wf_atom_48bd5a59(clipName, "Message", 36, __wf_atom_8e9ac384)
				end

				local ternary = module3.Ternary(label == "", -10, 0)
				local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(clipName .. ".Icon", 1)

				if __wf_atom_5e6e15c8 ~= nil then
					movie:__wf_atom_4c1c1986(clipName, "Goal", 1, __wf_atom_5e6e15c8 + ternary)
				end
			end)
		end

		function result.SetLabelColor(labelColorId, p6)
			if not p6 and labelColorId == result.Data.LabelColorId then
				return
			end

			result.Data.LabelColorId = labelColorId
			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(v) then
					movie:__wf_atom_4c1c1986(clipName, "Message", 11, v:__wf_atom_fd5d793e(result.Data.LabelColorId))
				end
			end)
		end

		function result.SetGoalLabel(p6, goalLabelAnimRate, p7)
			local v11 = p6 == nil and "" or p6
			result.newGoalLabel = v11

			if not __wf_atom_7e8ad928(movie) then
				for _, localizeLabel in ipairs(result.Data.LocalizeLabels) do
					local v12 = localizeLabel.Tag:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
					local v13 = movie:__wf_atom_8e9ac384(localizeLabel.Tag, true, localizeLabel.Params):gsub(
						"%%",
						"%%%0"
					)
					result.newGoalLabel = result.newGoalLabel:gsub(
						v12,
						module3.Ternary(localizeLabel.Upper, string.upper(v13), v13)
					)
				end
			end

			if not p7 and v11 == result.Data.GoalLabel and result.newGoalLabel == result.prevGoalLabel then
				return
			end

			result.Data.GoalLabel = v11
			result.Data.GoalLabelAnimRate = goalLabelAnimRate
			fn13()
			fn4(function()
				result.prevGoalLabel = result.newGoalLabel

				if not __wf_atom_7e8ad928(movie) then
					if goalLabelAnimRate then
						module3.AnimateTyping(
							movie,
							nil,
							clipName .. ".Goal",
							result.newGoalLabel,
							nil,
							goalLabelAnimRate
						)
					else
						movie:__wf_atom_48bd5a59(clipName, "Goal", 36, result.newGoalLabel)
					end
				end

				result.Data.LocalizeLabels = {}
			end)
		end

		function result.SetGoalColor(goalColorId, p6)
			if not p6 and goalColorId == result.Data.GoalColorId then
				return
			end

			result.Data.GoalColorId = goalColorId
			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(v) then
					movie:__wf_atom_4c1c1986(clipName, "Goal", 11, v:__wf_atom_fd5d793e(result.Data.GoalColorId))
				end
			end)
		end

		function result.SetIcon(defaultBroadcastIcon, p6)
			if __wf_atom_7e8ad928(defaultBroadcastIcon) then
				defaultBroadcastIcon = v7.defaultBroadcastIcon

				if __wf_atom_7e8ad928(defaultBroadcastIcon) then
					return
				end
			end

			if not p6 and defaultBroadcastIcon:__wf_atom_5b41f63b() == result.Data.Icon then
				return
			end

			result.Data.Icon = defaultBroadcastIcon:__wf_atom_5b41f63b()
			fn13()
			fn3(function()
				movie:__wf_atom_c90af43a(clipName .. ".Icon", defaultBroadcastIcon)
			end)
		end

		function result.SetIconSize(iconSize, p6)
			if not p6 and iconSize == result.Data.IconSize then
				return
			end

			result.Data.IconSize = iconSize
			fn13()
			fn3(function()
				movie:__wf_atom_4c1c1986(clipName, "Icon", 14, iconSize)
				movie:__wf_atom_4c1c1986(clipName, "Icon", 15, iconSize)
			end)
		end

		function result.SetIconColor(iconColorId, p6)
			if not p6 and iconColorId == result.Data.IconColorId then
				return
			end

			result.Data.IconColorId = iconColorId
			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(v) then
					movie:__wf_atom_4c1c1986(clipName, "Icon", 11, v:__wf_atom_fd5d793e(result.Data.IconColorId))
				end
			end)
		end

		function result.SetValue(progress, p6)
			if not p6 and progress == result.Data.Progress then
				return
			end

			result.Data.Progress = progress
			fn13()
			fn3(function()
				local v11 = progress >= 0
				movie:__wf_atom_7f57ab2f(clipName, "Progress", 13, v11)
				movie:__wf_atom_7f57ab2f(clipName, "Flare", 13, v11)
				movie:__wf_atom_7f57ab2f(clipName, "Icon", 13, v11)
				movie:__wf_atom_4c1c1986(clipName, "Message", 0, module3.Ternary(v11, result.InitMessageXPos, -5))
				movie:__wf_atom_4c1c1986(clipName, "Goal", 0, module3.Ternary(v11, result.InitGoalXPos, -5))

				if v11 then
					movie:__wf_atom_1ca72041(clipName .. ".Progress.Fill", "AlphaTestThreshold", progress, 0, 0, 0)
				end
			end)
		end

		function result.SetProgressColor(progressColorId, p6)
			if not p6 and progressColorId == result.Data.ProgressColorId then
				return
			end

			result.Data.ProgressColorId = progressColorId
			fn13()
			fn3(function()
				movie:__wf_atom_4c1c1986(clipName, "Progress", 11, v:__wf_atom_fd5d793e(result.Data.ProgressColorId))
			end)
		end

		function result.SetFlareColor(flareColorId, p6)
			if not p6 and flareColorId == result.Data.FlareColorId then
				return
			end

			result.Data.FlareColorId = flareColorId
			fn13()
			fn3(function()
				movie:__wf_atom_4c1c1986(clipName, "Flare", 11, v:__wf_atom_fd5d793e(result.Data.FlareColorId))
			end)
		end

		function result.SetBlinkColor(blinkColorId, p6, blinkMode, p7)
			if __wf_atom_7e8ad928(v) then
				return
			end

			local blinkLength = p6 == nil and 0.5 or p6

			if
				not p7
				and blinkColorId == result.Data.BlinkColorId
				and blinkLength == result.Data.BlinkLength
				and blinkMode == result.Data.BlinkMode
			then
				return
			end

			result.Data.BlinkColorId = blinkColorId
			result.Data.BlinkLength = blinkLength
			result.Data.BlinkMode = blinkMode
			fn13()

			if blinkColorId == nil then
				savedHudTrackers2.ActiveBlinkTrackers[clipName] = nil
				result.BlinkColorObj = nil
				result.BlinkFactor = nil
			else
				result.BlinkColorObj = Color(v:__wf_atom_fd5d793e(blinkColorId))

				if result.BlinkFactor == nil then
					result.BlinkFactor = 0
				end

				result.BlinkDir = 1
				savedHudTrackers2.ActiveBlinkTrackers[clipName] = result
			end
		end

		function result.ApplyBlinkColor(p6, p7)
			if __wf_atom_7e8ad928(v) then
				return
			end

			local v11 = Color(v:__wf_atom_fd5d793e(p7))
			v11.red = __wf_atom_104bfe98(v11.red, result.BlinkColorObj.red, result.BlinkFactor)
			v11.green = __wf_atom_104bfe98(v11.green, result.BlinkColorObj.green, result.BlinkFactor)
			v11.blue = __wf_atom_104bfe98(v11.blue, result.BlinkColorObj.blue, result.BlinkFactor)
			movie:__wf_atom_4c1c1986(clipName, p6, 11, v11:__wf_atom_dcecedb0())
		end

		function result.UpdateBlinkColors(p6)
			result.BlinkFactor += result.BlinkDir * p6 / result.Data.BlinkLength

			if result.BlinkFactor >= 1 then
				if result.Data.BlinkMode == 1 then
					result.BlinkFactor = 0
				else
					result.BlinkFactor = 1
					result.BlinkDir = -result.BlinkDir
				end
			elseif result.BlinkFactor <= 0 then
				result.BlinkFactor = 0
				result.BlinkDir = -result.BlinkDir
			end

			result.ApplyBlinkColor("Icon", result.Data.IconColorId)
			result.ApplyBlinkColor("Progress", result.Data.ProgressColorId)
			result.ApplyBlinkColor("Goal", result.Data.GoalColorId)
			result.ApplyBlinkColor("Message", result.Data.LabelColorId)
		end

		function result.UpdateHudColors()
			if __wf_atom_7e8ad928(v) then
				return
			end

			local __wf_atom_fd5d793e = v:__wf_atom_fd5d793e(result.Data.LabelColorId)
			local __wf_atom_fd5d793e2 = v:__wf_atom_fd5d793e(result.Data.GoalColorId)
			local __wf_atom_fd5d793e3 = v:__wf_atom_fd5d793e(result.Data.ProgressColorId)
			local __wf_atom_fd5d793e4 = v:__wf_atom_fd5d793e(result.Data.IconColorId)
			local __wf_atom_fd5d793e5 = v:__wf_atom_fd5d793e(result.Data.FlareColorId)

			if result.Data.BlinkColorId == nil then
				movie:__wf_atom_4c1c1986(clipName, "Message", 11, __wf_atom_fd5d793e)
				movie:__wf_atom_4c1c1986(clipName, "Goal", 11, __wf_atom_fd5d793e2)
				movie:__wf_atom_4c1c1986(clipName, "Progress", 11, __wf_atom_fd5d793e3)
				movie:__wf_atom_4c1c1986(clipName, "Icon", 11, __wf_atom_fd5d793e4)
			else
				result.BlinkColorObj = Color(v:__wf_atom_fd5d793e(result.Data.BlinkColorId))
				result.UpdateBlinkColors(0)
			end

			movie:__wf_atom_4c1c1986(clipName, "Flare", 11, __wf_atom_fd5d793e5)
		end

		function result.ApplyData(data, _, p6)
			result.Data.LocalizeLabels = data.LocalizeLabels

			if not __wf_atom_7e8ad928(data.Label) then
				result.SetLabel(data.Label, data.LabelAnimRate, p6)
			end

			if not __wf_atom_7e8ad928(data.LabelColorId) then
				result.SetLabelColor(data.LabelColorId, p6)
			end

			if not __wf_atom_7e8ad928(data.GoalLabel) then
				result.SetGoalLabel(data.GoalLabel, data.GoalLabelAnimRate, p6)
			end

			if not __wf_atom_7e8ad928(data.GoalColorId) then
				result.SetGoalColor(data.GoalColorId, p6)
			end

			if not __wf_atom_7e8ad928(data.Icon) then
				result.SetIcon(Resource(data.Icon), p6)
			end

			if not __wf_atom_7e8ad928(data.IconSize) then
				result.SetIconSize(data.IconSize, p6)
			end

			if not __wf_atom_7e8ad928(data.IconColorId) then
				result.SetIconColor(data.IconColorId, p6)
			end

			if not __wf_atom_7e8ad928(data.Progress) then
				result.SetValue(data.Progress, p6)
			end

			if not __wf_atom_7e8ad928(data.ProgressColorId) then
				result.SetProgressColor(data.ProgressColorId, p6)
			end

			if not __wf_atom_7e8ad928(data.FlareColorId) then
				result.SetFlareColor(data.FlareColorId, p6)
			end

			result.SetBlinkColor(data.BlinkColorId, data.BlinkLength, p6)
			result.ApplyDataCommon(data, p6)
		end
	elseif p == module.HT_TIMER then
		function result.ShowMessage(p6, messageDuration)
			if p6 == nil or p6 == result.Data.Message or _G.StalkerMode then
				return
			end

			result.Data.Message = p6
			result.Data.MessageDuration = messageDuration
			fn13()
			fn4(function()
				local v11 = not __wf_atom_7e8ad928(movie)
				local v12 = not v11 and "" or movie:__wf_atom_8e9ac384(p6, true)

				if result.CurrentMessage == nil then
					result.CurrentMessage = p6

					if v11 then
						__wf_atom_ec43d06e(movie, "BorderBox", 0, { 12 }, { 100 }, 0.25, 0, nil)
					end

					local function fn14()
						local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

						if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
							__wf_atom_b56d2aa8:__wf_atom_f62a8704("SetPartialFadeValues", { "BorderBox", "0" })
						end
					end

					module3.AnimateTyping(movie, nil, "BorderBox.Text", v12, function()
						if messageDuration ~= nil then
							result.popupTimerId = v3:AddTimer(messageDuration, function()
								result.Data.Message = nil
								result.Data.MessageDuration = nil
								result.CurrentMessage = nil
								fn13()
								v3:RemoveTimer(result.popupTimerId)

								if v11 then
									__wf_atom_ec43d06e(movie, "BorderBox", 8, { 12 }, { 0 }, 0.4, 0, fn14)
								end
							end)
						end
					end)

					if v11 then
						movie:__wf_atom_e57658c2(
							"BorderBox.Background",
							14,
							movie:__wf_atom_5e6e15c8("BorderBox.Text", 40) + 50
						)
					end
				else
					result.CurrentMessage = p6

					if v11 then
						movie:__wf_atom_50d60589("BorderBox.Text", 36, v12)
					end
				end
			end)
		end

		function result.SetLabel(p6, labelAnimRate, p7)
			local label = p6 == nil and "" or p6

			if not p7 and label == result.Data.Label then
				return
			end

			result.Data.Label = label
			result.Data.LabelAnimRate = labelAnimRate
			fn13()
			fn3(function()
				local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(label, true)

				if labelAnimRate then
					module3.AnimateTyping(movie, nil, clipName .. ".Title", __wf_atom_8e9ac384, nil, labelAnimRate)
				else
					movie:__wf_atom_48bd5a59(clipName, "Title", 36, __wf_atom_8e9ac384)
				end
			end)
		end

		function result.SetValue(p6, p7)
			local time = tonumber(p6)

			if not p7 and time == result.Data.Time then
				return
			end

			result.Data.Time = time
			fn13()
			fn4(function()
				local v11 = math.floor(result.Data.Time / 60)
				local v12 = math.floor(result.Data.Time - v11 * 60)
				local v13 = v11 < 1 and 0 or v11

				if result.Data.Time <= 0 then
					v13 = 0
					v12 = 0
				end

				if not __wf_atom_7e8ad928(movie) then
					movie:__wf_atom_48bd5a59(clipName, "Time", 36, string.format("%02.0f:%02.0f", v13, v12))
				end

				if
					result.Data.Duration
					and result.Data.TimerStarted
					and (result.Data.Inverted and result.Data.Time >= result.Data.Duration or not result.Data.Inverted and result.Data.Time <= 0)
				then
					if result.CompleteCallback ~= nil then
						result.CompleteCallback()
					end

					if result.Data.FailOnExpiry then
						result.ShowMessage("/Lotus/Language/Menu/HUD_MissionFailed")
						v3:AddTimer(1.5, fn2)
					end

					if result.Data.RemoveOnComplete then
						fn10(result)
					end
				end
			end)
		end

		function result.Update(p6)
			if not (result.Data.Paused or __wf_atom_7e8ad928(result.Data.Time) or result.Data.IsManualUpdate) then
				if result.Data.Inverted then
					result.SetValue(result.Data.Time + p6)

					if result.Data.Duration ~= nil and result.Data.Time >= result.Data.Duration then
						savedHudTrackers2.ActiveUpdaters[clipName] = nil
					end
				else
					result.SetValue(result.Data.Time - p6)

					if result.Data.Time <= 0 then
						savedHudTrackers2.ActiveUpdaters[clipName] = nil
					end
				end
			end
		end

		function result.StartTimer(duration, p6, removeOnComplete, failOnExpiry, completeCallback)
			local inverted = p6 == nil or p6
			result.Data.TimerStarted = nil
			result.Data.Duration = duration
			result.Data.Inverted = inverted
			result.Data.RemoveOnComplete = removeOnComplete
			result.Data.FailOnExpiry = failOnExpiry
			result.CompleteCallback = completeCallback

			if duration then
				result.SetValue(module3.Ternary(inverted, 0, duration))
			else
				result.SetValue(0)
			end

			savedHudTrackers2.ActiveUpdaters[clipName] = result
			result.Data.TimerStarted = true
		end

		function result.SetPaused(paused, p6)
			if not p6 and paused == result.Data.Paused then
				return
			end

			result.Data.Paused = paused
			fn13()
			fn3(function()
				local ternary = module3.Ternary(result.Data.Paused, 13, 41)

				if not __wf_atom_7e8ad928(v) then
					local __wf_atom_fd5d793e = v:__wf_atom_fd5d793e(ternary)
					movie:__wf_atom_4c1c1986(clipName, "Title", 44, __wf_atom_fd5d793e)
					movie:__wf_atom_4c1c1986(clipName, "Time", 44, __wf_atom_fd5d793e)
				end
			end)
		end

		function result.SetManualUpdate(isManualUpdate)
			result.Data.IsManualUpdate = isManualUpdate
		end

		function result.UpdateHudColors()
			if __wf_atom_7e8ad928(v) then
				return
			end

			local __wf_atom_fd5d793e = v:__wf_atom_fd5d793e(module3.Ternary(result.Data.Paused, 13, 41))
			movie:__wf_atom_4c1c1986(clipName, "Title", 44, __wf_atom_fd5d793e)
			movie:__wf_atom_4c1c1986(clipName, "Time", 44, __wf_atom_fd5d793e)
		end

		function result.ApplyData(data, _, p6)
			result.Data.TimerStarted = data.TimerStarted
			result.Data.Inverted = data.Inverted
			result.Data.Duration = data.Duration
			result.Data.RemoveOnComplete = data.RemoveOnComplete
			result.Data.FailOnExpiry = data.FailOnExpiry

			if not __wf_atom_7e8ad928(data.Label) then
				result.SetLabel(data.Label, data.LabelAnimRate, p6)
			end

			if not __wf_atom_7e8ad928(data.Time) then
				result.SetValue(data.Time, p6)
			end

			if not __wf_atom_7e8ad928(data.Paused) then
				result.SetPaused(data.Paused, p6)
			end

			if not __wf_atom_7e8ad928(data.Message) then
				result.ShowMessage(data.Message, data.MessageDuration)
			end

			result.ApplyDataCommon(data, p6)
		end
	elseif p == module.HT_HEALTH_TRACKER then
		result.Data.Padding = -7

		function result.SetTarget(entityInfo)
			if entityInfo == result.EntityInfo then
				return
			end

			result.EntityInfo = entityInfo

			for k, activeHealthTracker in pairs(savedHudTrackers2.ActiveHealthTrackers) do
				if not (k ~= clipName and activeHealthTracker.EntityInfo == result.EntityInfo) then
					continue
				end

				fn10(result)
				v8 = false
				result.Local = true
				return
			end

			fn13()
			fn4(function()
				if not __wf_atom_7e8ad928(result.EntityInfo) then
					if __wf_atom_7e8ad928(movie) then
						if not savedHudTrackers2.ActiveHealthTrackers[clipName] then
							savedHudTrackers2.ActiveHealthTrackers[clipName] = result
						end

						result.DisplayAvatar = result.EntityInfo
					else
						if result.EntityInfo:IsA(__wf_atom_7e6ed5fa) then
							local v11

							if result.Data.NameOverride == nil then
								v11 = result.EntityInfo:__wf_atom_818ea3a7()
							else
								v11 = movie:__wf_atom_8e9ac384(result.Data.NameOverride, true)
							end

							if result.Data.NameFormat then
								local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(
									string.gsub(result.Data.NameFormat, "|NAME|", v11),
									true
								)
								movie:__wf_atom_48bd5a59(clipName, "Name", 36, __wf_atom_8e9ac384)
							else
								movie:__wf_atom_48bd5a59(clipName, "Name", 36, v11)
							end
						end

						if savedHudTrackers2.ActiveHealthTrackers[clipName] then
							result.Display = savedHudTrackers2.ActiveHealthTrackers[clipName].Display
							result.Display:__wf_atom_865e86de(result.EntityInfo)
							result.DisplayAvatar = result.EntityInfo
							result.Display:Initialize()
						else
							local v11 = gRegion:IsMaster() and 3 or 4
							result.Display = gRegion:CreateObject(v7.healthShieldDisplayType, nil, v11)

							if __wf_atom_7e8ad928(result.Display) then
								print("Failed to created health display for tracker '" .. result.Name .. "'")
								fn10(result)
								return
							else
								result.Display:Setup(
									movie,
									result.EntityInfo,
									100,
									clipName .. ".Target",
									clipName .. ".Value"
								)
								result.DisplayAvatar = result.EntityInfo

								if result.Data.IgnorePredeath then
									result.Display:__wf_atom_2dcbceda(result.Data.IgnorePredeath)
								end

								savedHudTrackers2.ActiveHealthTrackers[clipName] = result
								__wf_atom_ec43d06e(movie, clipName, 8, { 12 }, { 100 }, 0.5, 0, nil)
							end
						end

						result.Display:Update(__wf_atom_084b3e93())
					end
				end
			end)
		end

		function result.SetNameFormat(nameFormat, p6)
			if not p6 and nameFormat == result.Data.NameFormat then
				return
			end

			result.Data.NameFormat = nameFormat
			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(result.EntityInfo) then
					local v11

					if result.Data.NameOverride == nil then
						v11 = result.EntityInfo:__wf_atom_818ea3a7()
					else
						v11 = movie:__wf_atom_8e9ac384(result.Data.NameOverride, true)
					end

					local v12 = string.gsub(nameFormat, "|NAME|", v11)
					movie:__wf_atom_7d7314f1(clipName .. ".Name.text", v12)
				end
			end)
		end

		function result.SetNameOverride(nameOverride, p6)
			if not p6 and nameOverride == result.Data.NameOverride then
				return
			end

			result.Data.NameOverride = nameOverride
			fn13()
		end

		function result.SetRemoveOnNullTarget(removeOnNullTarget, p6)
			if not p6 and removeOnNullTarget == result.Data.RemoveOnNullTarget then
				return
			end

			result.Data.RemoveOnNullTarget = removeOnNullTarget
			fn13()
		end

		function result.SetHealthWarningThreshold(healthWarningThreshold, p6)
			if not p6 and healthWarningThreshold == result.Data.HealthWarningThreshold then
				return
			end

			result.Data.HealthWarningThreshold = healthWarningThreshold
			fn13()
			fn3(function()
				if result.HealthPct == nil then
					result.HealthPct = module3.CreateObservable(-1, function(p7, p8)
						if p7 <= result.Data.HealthWarningThreshold and result.Data.HealthWarningThreshold < p8 then
							if not __wf_atom_7e8ad928(v7.defenseTargetNearDeath) then
								local function fn14() -- 1 equivalent call inferred from this helper
									local rootBasedPosition, v11 = module.GetRootBasedPosition(movie, clipName .. ".Value")
									module.CreateScreenParticles(
										movie,
										v7.defenseTargetNearDeath,
										rootBasedPosition + 10,
										v11 + 10
									)
								end

								if result.NearDeathTimerID == nil then
									result.NearDeathTimerID = v3:AddTimer(3, fn14, true)
									fn14() -- inferred equivalent call
								end
							end
						elseif result.NearDeathTimerID ~= nil and result.Data.HealthWarningThreshold < p7 then
							v3:RemoveTimer(result.NearDeathTimerID)
							result.NearDeathTimerID = nil
						end
					end)
				end
			end)
		end

		function result.ShowLostHealthMsg(p6)
			fn3(function()
				movie:__wf_atom_4c1c1986(clipName, "LostHealth", 12, 0)
				movie:__wf_atom_4c1c1986(clipName, "LostHealth", 5, 60)
				movie:__wf_atom_4c1c1986(clipName, "LostHealth", 6, 60)
				movie:__wf_atom_50d60589(clipName .. ".LostHealth.Label", 36, p6)
				local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(clipName .. ".LostHealth.Label", 40)
				movie:__wf_atom_4c1c1986(clipName, "LostHealth.Label", 0, -__wf_atom_5e6e15c8 / 2)
				movie:__wf_atom_4c1c1986(clipName, "LostHealth", 0, 100 - __wf_atom_5e6e15c8 / 2)
				__wf_atom_ec43d06e(
					movie,
					clipName .. ".LostHealth",
					2,
					{ 12, 5, 6 },
					{ 100, 100, 100 },
					0.25,
					0,
					function()
						__wf_atom_ec43d06e(
							movie,
							clipName .. ".LostHealth",
							0,
							{ 5, 6 },
							{ 120, 120 },
							1.5,
							0,
							function()
								__wf_atom_ec43d06e(movie, clipName .. ".LostHealth", 0, { 12 }, { 0 }, 0.25)
							end
						)
					end
				)

				if not __wf_atom_7e8ad928(v7.timeLostFx) then
					local rootBasedPosition, v11 = module.GetRootBasedPosition(movie, clipName .. ".LostHealth")
					module.CreateScreenParticles(movie, v7.timeLostFx, rootBasedPosition, v11 + 3)
				end
			end)
		end

		function result.SetIgnorePredeath(ignorePredeath, p6)
			if not p6 and ignorePredeath == result.Data.IgnorePredeath then
				return
			end

			result.Data.IgnorePredeath = ignorePredeath
			fn13()

			if not __wf_atom_7e8ad928(result.Display) then
				result.Display:__wf_atom_2dcbceda(ignorePredeath)
			end
		end

		function result.UpdateHudColors()
			if __wf_atom_7e8ad928(v) then
				return
			end

			local __wf_atom_fd5d793e = v:__wf_atom_fd5d793e(41)
			local __wf_atom_fd5d793e2 = v:__wf_atom_fd5d793e(23)
			movie:__wf_atom_4c1c1986(clipName, "Name", 44, __wf_atom_fd5d793e)
			movie:__wf_atom_4c1c1986(clipName, "LostHealth.Label", 44, __wf_atom_fd5d793e2)
		end

		function result.ApplyData(data, p6, p7)
			result.SetTarget(p6)

			if not __wf_atom_7e8ad928(data.RemoveOnNullTarget) then
				result.SetRemoveOnNullTarget(data.RemoveOnNullTarget, p7)
			end

			if not __wf_atom_7e8ad928(data.HealthWarningThreshold) then
				result.SetHealthWarningThreshold(data.HealthWarningThreshold, p7)
			end

			if not __wf_atom_7e8ad928(data.NameOverride) then
				result.SetNameOverride(data.NameOverride, p7)
			end

			if not __wf_atom_7e8ad928(data.NameFormat) then
				result.SetNameFormat(data.NameFormat, p7)
			end

			if not __wf_atom_7e8ad928(data.IgnorePredeath) then
				result.SetIgnorePredeath(data.IgnorePredeath, p7)
			end

			result.ApplyDataCommon(data, p7)
		end
	elseif p == module.HT_OPPONENT_BAR then
		result.Data.UpperColorId = 41
		result.Data.LowerColorId = 41

		function result.SetUpperFactionLabel(p6, p7)
			local upperFactionLabel = p6 == nil and "" or p6

			if not p7 and upperFactionLabel == result.Data.UpperFactionLabel then
				return
			end

			result.Data.UpperFactionLabel = upperFactionLabel
			fn13()
			fn3(function()
				local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(upperFactionLabel, true)
				movie:__wf_atom_48bd5a59(clipName, "UpperFactionLabel", 36, __wf_atom_8e9ac384)
				result.Data.UpperLabelWidth = math.max(
					movie:__wf_atom_5e6e15c8(clipName .. ".UpperFactionLabel", 40) + 30,
					181
				)
				local v11 = math.max(result.Data.LowerLabelWidth or 181, result.Data.UpperLabelWidth)
				movie:__wf_atom_4c1c1986(clipName, "UpperProgressLabel", 0, v11)
				movie:__wf_atom_4c1c1986(clipName, "LowerProgressLabel", 0, v11)
			end)
		end

		function result.SetLowerFactionLabel(p6, p7)
			local lowerFactionLabel = p6 == nil and "" or p6

			if not p7 and lowerFactionLabel == result.Data.LowerFactionLabel then
				return
			end

			result.Data.LowerFactionLabel = lowerFactionLabel
			fn13()
			fn3(function()
				local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(lowerFactionLabel, true)
				movie:__wf_atom_48bd5a59(clipName, "LowerFactionLabel", 36, __wf_atom_8e9ac384)
				result.Data.LowerLabelWidth = math.max(
					movie:__wf_atom_5e6e15c8(clipName .. ".LowerFactionLabel", 40) + 30,
					181
				)
				local v11 = math.max(result.Data.UpperLabelWidth or 181, result.Data.LowerLabelWidth)
				movie:__wf_atom_4c1c1986(clipName, "UpperProgressLabel", 0, v11)
				movie:__wf_atom_4c1c1986(clipName, "LowerProgressLabel", 0, v11)
			end)
		end

		function result.SetUpperFactionIcon(object, p6)
			if __wf_atom_7e8ad928(object) or not p6 and object:__wf_atom_5b41f63b() == result.Data.UpperFactionIcon then
				return
			end

			result.Data.UpperFactionIcon = object:__wf_atom_5b41f63b()
			fn13()
			fn3(function()
				movie:__wf_atom_c90af43a(clipName .. ".UpperFactionIcon", object)
			end)
		end

		function result.SetLowerFactionIcon(object, p6)
			if __wf_atom_7e8ad928(object) or not p6 and object:__wf_atom_5b41f63b() == result.Data.LowerFactionIcon then
				return
			end

			result.Data.LowerFactionIcon = object:__wf_atom_5b41f63b()
			fn13()
			fn3(function()
				movie:__wf_atom_c90af43a(clipName .. ".LowerFactionIcon", object)
			end)
		end

		function result.SetUpperColor(upperColorId, upperColorIcons, p6)
			if not p6 and upperColorId == result.Data.UpperColorId then
				return
			end

			result.Data.UpperColorId = upperColorId
			result.Data.UpperColorIcons = upperColorIcons
			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(v) then
					local __wf_atom_fd5d793e = v:__wf_atom_fd5d793e(result.Data.UpperColorId)
					movie:__wf_atom_4c1c1986(clipName, "UpperFactionLabel", 11, __wf_atom_fd5d793e)
					movie:__wf_atom_4c1c1986(clipName, "UpperProgressLabel", 11, __wf_atom_fd5d793e)
					movie:__wf_atom_4c1c1986(clipName, "UpperProgressBar.Progress", 11, __wf_atom_fd5d793e)

					if upperColorIcons then
						movie:__wf_atom_4c1c1986(clipName, "UpperFactionIcon", 11, __wf_atom_fd5d793e)
					end
				end
			end)
		end

		function result.SetLowerColor(lowerColorId, lowerColorIcons, p6)
			if not p6 and lowerColorId == result.Data.LowerColorId then
				return
			end

			result.Data.LowerColorId = lowerColorId
			result.Data.LowerColorIcons = lowerColorIcons
			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(v) then
					local __wf_atom_fd5d793e = v:__wf_atom_fd5d793e(result.Data.LowerColorId)
					movie:__wf_atom_4c1c1986(clipName, "LowerFactionLabel", 11, __wf_atom_fd5d793e)
					movie:__wf_atom_4c1c1986(clipName, "LowerProgressLabel", 11, __wf_atom_fd5d793e)
					movie:__wf_atom_4c1c1986(clipName, "LowerProgressBar.Progress", 11, __wf_atom_fd5d793e)

					if lowerColorIcons then
						movie:__wf_atom_4c1c1986(clipName, "LowerFactionIcon", 11, __wf_atom_fd5d793e)
					end
				end
			end)
		end

		function result.UpdateProgress(upperProgress, lowerProgress, p6)
			if not p6 and upperProgress == result.Data.UpperProgress and lowerProgress == result.Data.LowerProgress then
				return
			end

			result.Data.UpperProgress = upperProgress
			result.Data.LowerProgress = lowerProgress
			fn13()
			fn3(function()
				movie:__wf_atom_4c1c1986(
					clipName,
					"UpperProgressBar.Progress",
					5,
					__wf_atom_421b01aa(math.floor(upperProgress * 100), 0.001, 100)
				)
				movie:__wf_atom_48bd5a59(clipName, "UpperProgressLabel", 36, math.floor(upperProgress * 100) .. "%")

				if not __wf_atom_7e8ad928(lowerProgress) then
					movie:__wf_atom_4c1c1986(
						clipName,
						"LowerProgressBar.Progress",
						5,
						__wf_atom_421b01aa(math.floor(lowerProgress * 100), 0.001, 100)
					)
					movie:__wf_atom_48bd5a59(clipName, "LowerProgressLabel", 36, math.floor(lowerProgress * 100) .. "%")
				end
			end)
		end

		function result.ToggleLowerFaction(lowerVisible, p6)
			if not p6 and lowerVisible == result.Data.LowerVisible then
				return
			end

			result.Data.LowerVisible = lowerVisible
			fn13()
			fn3(function()
				local v11 = lowerVisible and 100 or 0
				movie:__wf_atom_4c1c1986(clipName, "LowerFactionLabel", 12, v11)
				movie:__wf_atom_4c1c1986(clipName, "LowerFactionIcon", 12, v11)
				movie:__wf_atom_4c1c1986(clipName, "LowerProgressLabel", 12, v11)
				movie:__wf_atom_4c1c1986(clipName, "LowerProgressBar.Progress", 12, v11)
				movie:__wf_atom_4c1c1986(clipName, "LowerProgressBar.Bg", 12, v11 / 5)
			end)
		end

		function result.UpdateHudColors()
			if __wf_atom_7e8ad928(v) then
				return
			end

			local __wf_atom_fd5d793e = v:__wf_atom_fd5d793e(result.Data.UpperColorId)
			local __wf_atom_fd5d793e2 = v:__wf_atom_fd5d793e(result.Data.LowerColorId)
			movie:__wf_atom_4c1c1986(clipName, "UpperFactionLabel", 11, __wf_atom_fd5d793e)
			movie:__wf_atom_4c1c1986(clipName, "UpperProgressLabel", 11, __wf_atom_fd5d793e)
			movie:__wf_atom_4c1c1986(clipName, "UpperProgressBar.Progress", 11, __wf_atom_fd5d793e)
			movie:__wf_atom_4c1c1986(clipName, "LowerFactionLabel", 11, __wf_atom_fd5d793e2)
			movie:__wf_atom_4c1c1986(clipName, "LowerProgressLabel", 11, __wf_atom_fd5d793e2)
			movie:__wf_atom_4c1c1986(clipName, "LowerProgressBar.Progress", 11, __wf_atom_fd5d793e2)

			if result.Data.UpperColorIcons then
				movie:__wf_atom_4c1c1986(clipName, "UpperFactionIcon", 11, __wf_atom_fd5d793e)
			end

			if result.Data.LowerColorIcons then
				movie:__wf_atom_4c1c1986(clipName, "LowerFactionIcon", 11, __wf_atom_fd5d793e2)
			end
		end

		function result.ApplyData(data, _, p6)
			if not __wf_atom_7e8ad928(data.UpperFactionLabel) then
				result.SetUpperFactionLabel(data.UpperFactionLabel, p6)
			end

			if not __wf_atom_7e8ad928(data.LowerFactionLabel) then
				result.SetLowerFactionLabel(data.LowerFactionLabel, p6)
			end

			if not __wf_atom_7e8ad928(data.UpperFactionIcon) then
				result.SetUpperFactionIcon(Resource(data.UpperFactionIcon), p6)
			end

			if not __wf_atom_7e8ad928(data.LowerFactionIcon) then
				result.SetLowerFactionIcon(Resource(data.LowerFactionIcon), p6)
			end

			if not __wf_atom_7e8ad928(data.UpperColorId) then
				result.SetUpperColor(data.UpperColorId, data.UpperColorIcons, p6)
			end

			if not __wf_atom_7e8ad928(data.LowerColorId) then
				result.SetLowerColor(data.LowerColorId, data.LowerColorIcons, p6)
			end

			if not __wf_atom_7e8ad928(data.UpperProgress) then
				result.UpdateProgress(data.UpperProgress, data.LowerProgress, p6)
			end

			if not __wf_atom_7e8ad928(data.LowerVisible) then
				result.ToggleLowerFaction(data.LowerVisible, p6)
			end

			result.ApplyDataCommon(data, p6)
		end
	elseif p == module.HT_LABEL then
		result.Data.AutoHeight = true
		result.Data.Padding = -7
		result.Data.LocalizeLabels = {}
		result.Data.Colors = {}

		function result.Localize(tag, params, upper)
			fn11(params)

			for _, localizeLabel in ipairs(result.Data.LocalizeLabels) do
				if not (localizeLabel.Tag == tag and localizeLabel.Upper == upper) then
					continue
				end

				localizeLabel.Params = params
				return tag
			end

			table.insert(result.Data.LocalizeLabels, { Tag = tag, Params = params, Upper = upper })
			return tag
		end

		function result.Colorize(p6)
			local v11 = "<Color" .. p6 .. ">"
			result.Data.Colors[v11] = p6
			return v11
		end

		function result.ColorizeBlink(p6, p7)
			if result.Data.BlinkStartColors == nil then
				result.Data.BlinkStartColors = {}
				result.Data.BlinkEndColors = {}
			end

			local v11 = "<BlinkColor" .. p6 .. "_" .. p7 .. ">"
			result.Data.BlinkStartColors[v11] = p6
			result.Data.BlinkEndColors[v11] = p7
			return v11
		end

		function result.SetLabel(p6, labelAnimRate, p7, p8)
			local v11 = p6 == nil and "" or p6

			if not p7 and v11 == result.newLabel then
				return
			end

			result.newLabel = v11

			for i = #result.Data.LocalizeLabels, 1, -1 do
				local localizeLabel = result.Data.LocalizeLabels[i]
				local v12 = localizeLabel.Tag:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")

				if string.find(v11, v12) == nil then
					table.remove(result.Data.LocalizeLabels, i)
				elseif not __wf_atom_7e8ad928(movie) then
					local v13 = {}

					for k, param in pairs(localizeLabel.Params) do
						if
							result.Data.ObjectiveData == nil
							or not result.Data.ObjectiveData.IsCounter
							or type(param) ~= "number"
						then
							v13[k] = movie:__wf_atom_8e9ac384(param, true)
						else
							v13[k] = module3.FormatNumber(param, 0)
						end
					end

					local v14 = movie:__wf_atom_8e9ac384(localizeLabel.Tag, true, v13):gsub("%%", "%%%0")
					result.newLabel = result.newLabel:gsub(
						v12,
						module3.Ternary(localizeLabel.Upper, string.upper(v14), v14)
					)
				end
			end

			if not __wf_atom_7e8ad928(v) then
				for k, color in pairs(result.Data.Colors) do
					if string.find(v11, k) == nil then
						continue
					end

					local convertColorNumberToHex = module3.ConvertColorNumberToHex(v:__wf_atom_fd5d793e(color))
					result.newLabel = result.newLabel:gsub(k, convertColorNumberToHex)
				end

				if result.Data.BlinkStartColors ~= nil then
					p8 = v11 == result.Data.Label and result.newLabel == result.prevBlinkLabel or p8
					result.prevBlinkLabel = result.newLabel

					for k, blinkStartColor in pairs(result.Data.BlinkStartColors) do
						local v12 = Color(v:__wf_atom_fd5d793e(blinkStartColor))
						local v13 = Color(v:__wf_atom_fd5d793e(result.Data.BlinkEndColors[k]))
						local v14 = math.abs((__wf_atom_4658d645(Time()) - 0.5) / 0.5)
						local v15 = v12.red * v14 + v13.red * (1 - v14)
						local v16 = v12.green * v14 + v13.green * (1 - v14)
						local v17 = v12.blue * v14 + v13.blue * (1 - v14)
						local v18 = "#" .. module3.ConvertRGB2HEX(v15, v16, v17)
						result.newLabel = result.newLabel:gsub(k, v18)
					end
				end
			end

			if not p7 and v11 == result.Data.Label and result.newLabel == result.prevLabel then
				return
			end

			result.Data.Label = v11
			result.Data.LabelAnimRate = labelAnimRate

			if not p8 then
				fn13()
			end

			fn3(function()
				if labelAnimRate then
					module3.AnimateTyping(movie, nil, clipName .. ".Label", result.newLabel, nil, labelAnimRate)
				elseif __wf_atom_7e8ad928(result.prevLabel) or result.prevLabel == "" then
					result.DissolveInText()

					if result.Visible then
						module3.PlaySound(_G.UISound_ObjectiveUpdateSound)
					end
				elseif result.prevLabel ~= result.newLabel then
					if result.Data.ObjectiveData ~= nil and result.Data.ObjectiveData.IsCounter then
						result.DissolveInText()
					else
						result.DissolveOutText()
					end
				end

				result.prevLabel = result.newLabel

				if result.Data.AutoHeight then
					local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(clipName .. ".Label", 41)

					if __wf_atom_5e6e15c8 ~= nil then
						result.SetHeight(math.max(__wf_atom_5e6e15c8 + 15, 40), nil, true)
					end
				end

				if not __wf_atom_7e8ad928(result.Data.Style) then
					result.SetupStyledText()
					return
				end

				movie:__wf_atom_7f57ab2f(clipName, "Icon", 13, false)
				movie:__wf_atom_7f57ab2f(clipName, "Banner", 13, false)
			end)
		end

		function result.SetupStyledText()
			if result.Data.Style == 1 then
				movie:__wf_atom_4c1c1986(clipName, "Banner", 1, -13)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 6, 12)
				movie:__wf_atom_7f57ab2f(clipName, "Icon", 13, false)
				movie:__wf_atom_7f57ab2f(clipName, "Banner", 13, true)
				movie:OverrideMaterial(clipName .. ".Banner", _G.UIMaterial_DarkPaperBacker)
				movie:__wf_atom_4c1c1986(clipName, "Label", 44, _G.UIColor_Yellow)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 14, movie:__wf_atom_cfc41e35(clipName, "Label", 40) + 50)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 11, 16777215)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 12, 100)
			elseif result.Data.Style == 2 then
				movie:__wf_atom_7f57ab2f(clipName, "Icon", 13, true)
				local completed = not __wf_atom_7e8ad928(result.Data.Completed) and result.Data.Completed
				movie:__wf_atom_7f57ab2f(clipName, "Icon.Completed", 13, completed)
				movie:__wf_atom_7f57ab2f(clipName, "Banner", 13, true)
				movie:__wf_atom_4c1c1986(clipName, "Label", 44, _G.UIColor_Tan)
				movie:OverrideMaterial(clipName .. ".Banner", _G.UIMaterial_DarkPaperBacker)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 14, movie:__wf_atom_cfc41e35(clipName, "Label", 40) + 50)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 11, 0)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 12, 60)
			elseif result.Data.Style == 3 then
				movie:__wf_atom_7f57ab2f(clipName, "Icon", 13, false)
				movie:__wf_atom_7f57ab2f(clipName, "Banner", 13, true)
				movie:__wf_atom_4c1c1986(clipName, "Label", 44, _G.UIColor_Tan)
				movie:OverrideMaterial(clipName .. ".Banner", _G.UIMaterial_DarkPaperBacker)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 14, movie:__wf_atom_cfc41e35(clipName, "Label", 40) + 50)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 11, 0)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 12, 60)
			end
		end

		function result.PulseGlow()
			if not result.Visible then
				return
			end

			local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(clipName .. ".Label", 40)
			local __wf_atom_5e6e15c8_2 = movie:__wf_atom_5e6e15c8(clipName .. ".Label", 0)
			movie:__wf_atom_4c1c1986(clipName, "LongGlow", 0, __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8 / 2)
			movie:__wf_atom_4c1c1986(clipName, "LongGlow", 14, __wf_atom_5e6e15c8 + 100)
			local v11 = Type("/SF/Fx/Interface/Progression/MissionObjective/ParentFlare")
			module3.CreateUIParticles(movie, clipName .. ".Icon", v11, 0, 0)
		end

		function result.DissolveInText()
			movie:__wf_atom_50d60589(clipName .. ".Label", 36, result.newLabel)
			movie:__wf_atom_50d60589(clipName .. ".Label", 0, -15)
			movie:__wf_atom_50d60589(clipName .. ".Banner", 0, -35)
			local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(clipName .. ".Label", 41)
			movie:__wf_atom_e57658c2(clipName .. ".Banner", 15, __wf_atom_5e6e15c8 + 10)
			result.SetupStyledText()
			local v11 = result.Data.ObjectiveData ~= nil and result.Data.ObjectiveData.IsCounter and true or false

			if
				result.Data.Style == 2
				and result.prevLabel ~= result.newLabel
				and result.newLabel ~= nil
				and not v11
			then
				fn3(result.PulseGlow)
			end

			__wf_atom_ec43d06e(movie, clipName .. ".Banner", 1, { 0 }, { -28 }, 1, 0)
			__wf_atom_ec43d06e(movie, clipName .. ".Icon", 4, { 5, 6 }, { 120, 120 }, 0.3, 0, function()
				__wf_atom_ec43d06e(movie, clipName .. ".Icon", 1, { 5, 6 }, { 100, 100 }, 0.3, 0)
			end)
			__wf_atom_ec43d06e(movie, clipName .. ".Label", 1, {
				function(p6)
					movie:__wf_atom_1ca72041(clipName .. ".Label", "Dissolve", 1 - p6, 0, 0, 0)
				end,
				0
			}, { 1, -2 }, 0.3, 0, function() end)
		end

		function result.DissolveOutText()
			__wf_atom_ec43d06e(movie, clipName .. ".Banner", 0, { 0 }, { -8 }, 1, 0)
			__wf_atom_ec43d06e(movie, clipName .. ".Label", 2, {
				function(p6)
					movie:__wf_atom_1ca72041(clipName .. ".Label", "Dissolve", p6, 0, 0, 0)
				end,
				0
			}, { 1, 10 }, 0.8, 0, result.DissolveInText)
		end

		function result.UpdateHudColors()
			if __wf_atom_7e8ad928(v) then
				return
			end

			local __wf_atom_fd5d793e = v:__wf_atom_fd5d793e(41)
			movie:__wf_atom_4c1c1986(clipName, "Label", 44, __wf_atom_fd5d793e)
			result.SetLabel(result.Data.Label, result.Data.LabelAnimRate, nil, true)
		end

		function result.SetStyle(style)
			result.Data.Style = style
			result.ApplyData(result.Data)
			fn13()
		end

		function result.SetCompleted(completed)
			if not (completed ~= nil and result.Data.Completed ~= completed) then
				return
			end

			result.Data.Completed = completed
			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(result.Data.Style) then
					if result.Data.Style == 1 then
						movie:__wf_atom_7f57ab2f(clipName, "Icon", 13, false)
					elseif result.Data.Style == 2 then
						if result.Data.Completed then
							__wf_atom_ec43d06e(movie, clipName .. ".Glow", 0, { 12 }, { 100 }, 0.2, 0, function()
								__wf_atom_ec43d06e(movie, clipName .. ".Glow", 0, { 12 }, { 0 }, 1.2)
							end)
						else
							__wf_atom_ec43d06e(movie, clipName .. ".Glow", 0, { 12 }, { 0 }, 0.2)
						end

						movie:__wf_atom_7f57ab2f(clipName, "Icon.Completed", 13, completed)
					end
				end
			end)
		end

		function result.ApplyData(data, _, p6)
			if not __wf_atom_7e8ad928(data.Label) then
				result.Data.LocalizeLabels = data.LocalizeLabels
				result.Data.Colors = data.Colors
				result.Data.BlinkStartColors = data.BlinkStartColors
				result.Data.BlinkEndColors = data.BlinkEndColors
				result.Data.Style = data.Style
				result.SetLabel(data.Label, data.LabelAnimRate, p6)
				result.SetCompleted(data.Completed)
				result.ApplyDataCommon(data, p6)
			end
		end
	elseif p == module.HT_ICON_BAR then
		result.List = {
			mForcedVerticalSeparation = 0,
			mForcedHorizontalSeparation = 22,
			Redraw = function(self, callback, forceRedraw, instantDraw)
				if result.InitRedraw then
					result.InitRedraw.ForceRedraw = forceRedraw or result.InitRedraw.ForceRedraw
					result.InitRedraw.InstantDraw = instantDraw or result.InitRedraw.InstantDraw
				else
					result.InitRedraw = { ForceRedraw = forceRedraw, InstantDraw = instantDraw }
				end

				if not result.InitRedraw.Callback then
					result.InitRedraw.Callback = callback
				end
			end
		}
		result.Data.ListData = {}
		result.InitFuncQueue = {}
		local v11 = { Icon = true }
		local v12 = {
			mPrefix = true,
			UTIL = true,
			mClips = true,
			mClipName = true,
			mTopClipIndexUsed = true,
			UP = true,
			DOWN = true,
			LEFT = true,
			RIGHT = true
		}

		function result.StripUnserializables(items)
			local result2 = {}

			for k, item in pairs(items) do
				if v12[k] then
					continue
				end

				if type(item) == "table" then
					if item ~= items then
						result2[k] = result.StripUnserializables(item)
					end
				elseif type(item) == "userdata" and v11[k] then
					result2[k] = item:__wf_atom_5b41f63b()
				elseif type(item) ~= "function" and type(item) ~= "userdata" then
					result2[k] = item
				end
			end

			return result2
		end

		function result.ApplyListData(list, listData)
			if list == nil then
				list = result.List
			end

			if listData == nil then
				listData = result.Data.ListData
			end

			for k, v13 in pairs(listData) do
				if v11[k] then
					list[k] = Resource(v13)
				elseif __wf_atom_7e8ad928(list[k]) or type(v13) ~= "table" then
					list[k] = v13
				end
			end

			for k, v13 in pairs(list) do
				if v12[k] then
					continue
				end

				if type(v13) == "table" then
					if v13 ~= list then
						result.ApplyListData(v13, listData[k])
					end
				elseif
					listData[k] == nil
					and (type(v13) == "userdata" and v11[k] or type(v13) ~= "function" and type(v13) ~= "userdata")
				then
					list[k] = nil
				end
			end
		end

		function result.UpdateData()
			result.Data.ListData = result.StripUnserializables(result.List)
			fn13()
		end

		function result.AddIcon(icon, p6, p7)
			local v13 = __wf_atom_7e8ad928(p6) and {} or p6
			v13.Icon = icon

			if result.NeedsInit then
				table.insert(result.InitFuncQueue, { result.AddIcon, icon, v13, p7 })
				return
			end

			result.List:AddElement(v13, module3.Ternary(__wf_atom_7e8ad928(p7), true, p7))
			result.UpdateData()
		end

		function result.RemoveIcon(p6, p7, p8)
			if result.NeedsInit then
				table.insert(result.InitFuncQueue, { result.RemoveIcon, p6, p7, p8 })
				return
			end

			result.List:RemoveElement(p6, p7, p8)
			result.UpdateData()
		end

		function result.RemoveIcons(p6, p7)
			if result.NeedsInit then
				table.insert(result.InitFuncQueue, { result.RemoveIcons, p6, p7 })
				return
			end

			result.List:RemoveElements(p6, p7)
			result.UpdateData()
		end

		function result.AddStackingIcon(p6, p7, icon, p8)
			if p7 == nil then
				print("HudTracker: No key for stacking icon!")
				return
			end

			if result.NeedsInit then
				table.insert(result.InitFuncQueue, { result.AddStackingIcon, p6, p7, icon, p8 })
				return
			end

			local v13 = result.List.mElements and result.List.mElements[p6]

			if v13 then
				if __wf_atom_7e8ad928(v13.StackedElements) then
					v13.StackedElements = {}
				end

				local count = 0

				for _, _ in pairs(v13.StackedElements) do
					count += 1
				end

				local v14 = __wf_atom_7e8ad928(p8) and {} or p8

				if __wf_atom_7e8ad928(v14.Alpha) then
					v14.Alpha = 100
				end

				if __wf_atom_7e8ad928(v14.Visible) then
					v14.Visible = true
				end

				if __wf_atom_7e8ad928(v14.Y) then
					v14.Y = 0
				end

				v14.Icon = icon
				v14.Name = p7 .. "_" .. p6
				v14.Depth = 1500 + p6 * 20 + count
				v13.StackedElements[p7] = v14
			end
		end

		function result.SetCustomDrawFunction(customDrawFunction)
			if type(customDrawFunction) == "function" then
				result.CustomDrawFunction = customDrawFunction
			else
				result.CustomDrawFunction = nil
			end
		end

		function result.UpdateHudColors()
			if __wf_atom_7e8ad928(v) or __wf_atom_7e8ad928(result.List) then
				return
			end

			result.UpdatingHudColors = true
			result.List:Redraw(nil, true)
			result.UpdatingHudColors = nil
		end

		function result.ApplyData(p6, _, p7)
			if not __wf_atom_7e8ad928(p6.ListData) then
				result.Data.ListData = p6.ListData
				result.ApplyListData()
			end

			result.ApplyDataCommon(p6, p7)
			result.List:Redraw(nil, true)
		end

		result.Data.ListData = result.StripUnserializables(result.List)
	elseif p == module.HT_TEMPERATURE_BAR then
		result.Data.AutoHeight = true
		result.TempWidth = 195
		result.Data.Padding = -20

		function result.SetRange(rangeMin, rangeMax, p6)
			if not p6 and rangeMin == result.Data.RangeMin and rangeMax == result.Data.RangeMax then
				return
			end

			if rangeMin ~= nil then
				result.Data.RangeMin = rangeMin
			end

			if rangeMax ~= nil then
				result.Data.RangeMax = rangeMax
			end

			fn13()
			fn3(function()
				if result.Data.RangeMin ~= nil and result.Data.RangeMax ~= nil then
					local v11 = 31 + __wf_atom_421b01aa(result.Data.RangeMin * result.TempWidth, 0.01, result.TempWidth)
					local v12 = 31 + __wf_atom_421b01aa(result.Data.RangeMax * result.TempWidth, 0.01, result.TempWidth)
					local v13 = math.max(v12 - 6 - (v11 + 7), 0.01) / 8
					movie:__wf_atom_4c1c1986(clipName, "RangeLeft", 0, v11)
					movie:__wf_atom_4c1c1986(clipName, "RangeRight", 0, v12)
					movie:__wf_atom_4c1c1986(clipName, "RangeSegment", 0, v11 + 7)
					movie:__wf_atom_4c1c1986(clipName, "RangeSegment", 14, (math.max(v12 - 6 - (v11 + 7), 0.01)))
					movie:__wf_atom_4c1c1986(clipName, "HighlightLeftEdge", 0, v11)
					movie:__wf_atom_4c1c1986(clipName, "HighlightRightEdge", 0, v12)
					movie:__wf_atom_4c1c1986(clipName, "HighlightSegment", 0, v11 + 13)
					movie:__wf_atom_4c1c1986(clipName, "HighlightDeco", 0, v11 + (v12 - v11) / 2)
					movie:__wf_atom_4c1c1986(clipName, "HighlightSegment", 14, (math.max(v12 - 12 - (v11 + 13), 0.01)))
					movie:__wf_atom_1ca72041(clipName .. ".RangeSegment", "TileRepeats", v13, 1, 0, 0)

					if result.Data.TemperaturePct ~= nil then
						local v14 = result.Data.TemperaturePct >= result.Data.RangeMin
							and result.Data.TemperaturePct <= result.Data.RangeMax
							and 100
							or 0
						movie:__wf_atom_4c1c1986(clipName, "HighlightDeco", 12, v14)
						movie:__wf_atom_4c1c1986(clipName, "HighlightLeftEdge", 12, v14)
						movie:__wf_atom_4c1c1986(clipName, "HighlightRightEdge", 12, v14)
						movie:__wf_atom_4c1c1986(clipName, "HighlightSegment", 12, v14)
					end
				end
			end)
		end

		function result.SetTemperature(temperaturePct, p6)
			if not p6 and temperaturePct == result.Data.TemperaturePct then
				return
			end

			result.Data.TemperaturePct = temperaturePct
			fn13()
			fn3(function()
				local v11 = __wf_atom_421b01aa(temperaturePct * result.TempWidth, 0.01, result.TempWidth)
				local v12 = 31 + v11
				movie:__wf_atom_4c1c1986(clipName, "FillMask", 14, v11)
				movie:__wf_atom_4c1c1986(clipName, "Indicator", 0, v12)

				if result.Data.RangeMin ~= nil and result.Data.RangeMax ~= nil then
					local v13 = result.Data.TemperaturePct >= result.Data.RangeMin
						and result.Data.TemperaturePct <= result.Data.RangeMax
						and 100
						or 0
					movie:__wf_atom_4c1c1986(clipName, "HighlightDeco", 12, v13)
					movie:__wf_atom_4c1c1986(clipName, "HighlightLeftEdge", 12, v13)
					movie:__wf_atom_4c1c1986(clipName, "HighlightRightEdge", 12, v13)
					movie:__wf_atom_4c1c1986(clipName, "HighlightSegment", 12, v13)
				end
			end)
		end

		function result.SetRangeVisible(rangeVisible, p6)
			if not p6 and rangeVisible == result.Data.RangeVisible then
				return
			end

			result.Data.RangeVisible = rangeVisible
			fn13()
			fn3(function()
				movie:__wf_atom_7f57ab2f(clipName, "RangeLeft", 13, result.Data.RangeVisible)
				movie:__wf_atom_7f57ab2f(clipName, "RangeRight", 13, result.Data.RangeVisible)
				movie:__wf_atom_7f57ab2f(clipName, "RangeSegment", 13, result.Data.RangeVisible)
				movie:__wf_atom_7f57ab2f(clipName, "HighlightLeftEdge", 13, result.Data.RangeVisible)
				movie:__wf_atom_7f57ab2f(clipName, "HighlightRightEdge", 13, result.Data.RangeVisible)
				movie:__wf_atom_7f57ab2f(clipName, "HighlightSegment", 13, result.Data.RangeVisible)
				movie:__wf_atom_7f57ab2f(clipName, "HighlightDeco", 13, result.Data.RangeVisible)
			end)
		end

		function result.ApplyData(data, _, p6)
			if not (__wf_atom_7e8ad928(data.RangeMin) and __wf_atom_7e8ad928(data.RangeMax)) then
				result.SetRange(data.RangeMin, data.RangeMax, p6)
			end

			if not __wf_atom_7e8ad928(data.TemperaturePct) then
				result.SetTemperature(data.TemperaturePct, p6)
			end

			if not __wf_atom_7e8ad928(data.RangeVisible) then
				result.SetRangeVisible(data.RangeVisible, p6)
			end

			result.ApplyDataCommon(data, p6)
		end
	elseif p == module.HT_CORRUPTION_BAR then
		result.Data.AutoHeight = true
		result.Data.Padding = -190
		result.Data.Nodes = {}
		result.Data.Value = 0
		result.NumNodes = 0
		result.InitFuncQueue = {}

		function result.SetValue(p6, p7)
			if not p7 and p6 == result.Data.Value then
				return
			end

			result.Data.Value = p6
			fn13()
			fn3(function()
				movie:__wf_atom_1ca72041(clipName .. ".Fill", "VisibilitySize", p6, 0, 0, 0)
				movie:__wf_atom_1ca72041(clipName .. ".FillOutline", "VisibilitySize", p6, 0, 0, 0)
				movie:__wf_atom_48bd5a59(clipName, "FillLabel", 36, math.floor(p6 * 100) .. "%")
				movie:__wf_atom_4c1c1986(clipName, "Glow", 12, module3.Ternary(p6 >= 1, 100, 55))
				movie:__wf_atom_4c1c1986(clipName, "BgDeco", 12, module3.Ternary(p6 >= 1, 100, 50))
				movie:__wf_atom_4c1c1986(clipName, "FillLine", 1, 284 - p6 * 266)
				movie:__wf_atom_7f57ab2f(clipName, "FillLine", 13, p6 > 0 and p6 < 1)

				for _, node in pairs(result.Data.Nodes) do
					local v11 = clipName .. ".CorruptionNode" .. node.Index
					local v12 = node.Value <= p6
					movie:__wf_atom_4c1c1986(v11, "Cap", 12, module3.Ternary(node.HasCap and v12, 100, 0))
					movie:__wf_atom_4c1c1986(v11, "Sparkles", 12, module3.Ternary(v12, 100, 0))
					movie:__wf_atom_4c1c1986(v11, "Glow", 12, module3.Ternary(v12, 100, 0))
					movie:__wf_atom_4c1c1986(v11, "Icon", 12, module3.Ternary(v12, 100, 50))
					movie:__wf_atom_4c1c1986(v11, "Label", 12, module3.Ternary(v12, 100, 50))
				end
			end)
		end

		function result.AddNode(p6, p7, label, hasCap)
			if result.Data.Nodes[p6] == nil then
				result.NumNodes += 1
				result.Data.Nodes[p6] = {
					Value = p7,
					Label = label,
					HasCap = hasCap,
					Index = result.NumNodes
				}
			else
				result.Data.Nodes[p6].Value = p7
				result.Data.Nodes[p6].Label = label
				result.Data.Nodes[p6].HasCap = hasCap
			end

			fn13()
			fn3(function()
				local v11 = "CorruptionNode" .. result.Data.Nodes[p6].Index
				local v12 = clipName .. "." .. v11

				if not movie:__wf_atom_253d7085(clipName .. "." .. v11) then
					__wf_atom_86cbd68d(
						movie,
						clipName .. ".CorruptionNode.duplicateMovieClip",
						v11,
						440 + result.Data.Nodes[p6].Index
					)
				end

				local v13 = p7 <= result.Data.Value
				movie:__wf_atom_e57658c2(v12, 1, 282 - p7 * 257)
				movie:__wf_atom_7d7314f1(v12 .. ".Label.text", label)
				movie:__wf_atom_4c1c1986(v12, "Cap", 12, module3.Ternary(hasCap and v13, 100, 0))
				movie:__wf_atom_4c1c1986(v12, "Sparkles", 12, module3.Ternary(v13, 100, 0))
				movie:__wf_atom_4c1c1986(v12, "Glow", 12, module3.Ternary(v13, 100, 0))
				movie:__wf_atom_4c1c1986(v12, "Icon", 12, module3.Ternary(v13, 100, 50))
				movie:__wf_atom_4c1c1986(v12, "Label", 12, module3.Ternary(v13, 100, 50))
				movie:__wf_atom_2dedec1a(v12, 13, true)
			end)
		end

		function result.SetNodeLabel(p6, label, _)
			if result.Data.Nodes[p6] == nil then
				return
			end

			result.Data.Nodes[p6].Label = label
			fn13()
			fn3(function()
				local v11 = clipName .. ".CorruptionNode" .. result.Data.Nodes[p6].Index
				movie:__wf_atom_7d7314f1(v11 .. ".Label.text", label)
			end)
		end

		function result.ApplyData(p6, _, p7)
			if not __wf_atom_7e8ad928(p6.Value) then
				result.SetValue(p6.Value, p7)
			end

			for k, node in pairs(p6.Nodes) do
				result.AddNode(k, node.Value, node.Label, node.HasCap)
			end

			result.ApplyDataCommon(p6, p7)
		end
	elseif p == module.HT_NODE_CONFLICT_BAR then
		result.Data.AutoHeight = true
		result.Data.Padding = 0
		result.Data.LeftColorId = 19
		result.Data.RightColorId = 15
		result.Data.Nodes = {}
		result.InitFuncQueue = {}

		function result.SetValue(p6, p7)
			local progress = __wf_atom_421b01aa(p6, 0, 1)

			if not p7 and progress == result.Data.Progress then
				return
			end

			result.Data.Progress = progress
			fn13()
			fn3(function()
				movie:__wf_atom_4c1c1986(clipName, "MaskLeft", 14, (math.max(0.01, progress * 273)))
				movie:__wf_atom_4c1c1986(clipName, "MaskRight", 14, 273 - math.max(0.01, progress * 273))
				movie:__wf_atom_4c1c1986(clipName, "Flare", 0, math.max(0.01, progress * 273) + 20)
			end)
		end

		function result.SetBgDistortion(bgDistortionStrength, p6)
			if not p6 and bgDistortionStrength == result.Data.BgDistortionStrength then
				return
			end

			result.Data.BgDistortionStrength = bgDistortionStrength
			fn13()
			fn3(function()
				movie:__wf_atom_1ca72041(
					clipName .. ".BackerSwirls",
					"RippleAnimationSettings",
					bgDistortionStrength * 1.5,
					bgDistortionStrength * 1.5,
					bgDistortionStrength * 1.5,
					bgDistortionStrength * 0.1
				)
			end)
		end

		function result.SetCenterLabel(centerLabel, showCenterFx, p6)
			if
				centerLabel == nil
				or centerLabel == result.Data.CenterLabel and showCenterFx == result.Data.ShowCenterFx and not p6
			then
				return
			end

			result.Data.CenterLabel = centerLabel
			result.Data.ShowCenterFx = showCenterFx
			fn13()
			fn3(function()
				movie:__wf_atom_7d7314f1(clipName .. ".LabelCenter.text", result.Data.CenterLabel)

				if result.Data.ShowCenterFx and not __wf_atom_7e8ad928(v7.nodeConflictFx) then
					local rootBasedPosition, v11 = module.GetRootBasedPosition(movie, clipName .. ".FxAnchor", true)
					module.CreateScreenParticles(movie, v7.nodeConflictFx, rootBasedPosition, v11)
				end
			end)
		end

		function result.SetLabels(leftLabel, rightLabel, p6)
			local v11

			if leftLabel == nil then
				v11 = false
			else
				v11 = leftLabel ~= result.Data.LeftLabel or p6
			end

			local v12

			if rightLabel == nil then
				v12 = false
			else
				v12 = rightLabel ~= result.Data.RightLabel or p6
			end

			if not (v11 or v12) then
				return
			end

			if v11 then
				result.Data.LeftLabel = leftLabel
			end

			if v12 then
				result.Data.RightLabel = rightLabel
			end

			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(result.Data.LeftLabel) then
					movie:__wf_atom_7d7314f1(clipName .. ".LabelLeft.text", result.Data.LeftLabel)
				end

				if not __wf_atom_7e8ad928(result.Data.RightLabel) then
					movie:__wf_atom_7d7314f1(clipName .. ".LabelRight.text", result.Data.RightLabel)
				end
			end)
		end

		function result.SetLeftColor(leftColorId, leftColorHex, p6)
			if not p6 and leftColorId == result.Data.LeftColorId and leftColorHex == result.Data.LeftColorHex then
				return
			end

			result.Data.LeftColorId = leftColorId
			result.Data.LeftColorHex = leftColorHex
			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(v) then
					local leftColorId2 = result.Data.LeftColorId

					if not result.Data.LeftColorHex then
						leftColorId2 = v:__wf_atom_fd5d793e(leftColorId2)
					end

					movie:__wf_atom_4c1c1986(clipName, "FillLeft", 11, leftColorId2)
					movie:__wf_atom_4c1c1986(clipName, "Flare.FlareLeft", 11, leftColorId2)

					if not __wf_atom_7e8ad928(result.List) then
						result.List:Redraw(nil, true, true)
					end
				end
			end)
		end

		function result.SetRightColor(rightColorId, rightColorHex, p6)
			if not p6 and rightColorId == result.Data.RightColorId and rightColorHex == result.Data.RightColorHex then
				return
			end

			result.Data.RightColorId = rightColorId
			result.Data.RightColorHex = rightColorHex
			fn13()
			fn3(function()
				if not __wf_atom_7e8ad928(v) then
					local rightColorId2 = result.Data.RightColorId

					if not result.Data.RightColorHex then
						rightColorId2 = v:__wf_atom_fd5d793e(rightColorId2)
					end

					movie:__wf_atom_4c1c1986(clipName, "FillRight", 11, rightColorId2)
					movie:__wf_atom_4c1c1986(clipName, "Flare.FlareRight", 11, rightColorId2)

					if not __wf_atom_7e8ad928(result.List) then
						result.List:Redraw(nil, true, true)
					end
				end
			end)
		end

		function result.UpdateNode(p6, isLeftSide, progress, hideCenter, _)
			for _, node in ipairs(result.Data.Nodes) do
				if node.NodeId ~= p6 then
					continue
				end

				local flag2

				if isLeftSide == nil or node.IsLeftSide == isLeftSide then
					flag2 = false
				else
					node.IsLeftSide = isLeftSide
					flag2 = true
				end

				if progress ~= nil and node.Progress ~= progress then
					node.Progress = progress
					flag2 = true
				end

				if hideCenter ~= nil and node.HideCenter ~= hideCenter then
					node.HideCenter = hideCenter
					flag2 = true
				end

				if flag2 then
					fn13()
				end

				return true
			end

			return false
		end

		function result.AddNode(nodeId, p6, p7, p8, p9)
			if result.UpdateNode(nodeId, p6, p7, p8, p9) then
				return
			end

			local isLeftSide = p6 == true
			local hideCenter = p8 == true
			local progress = p7 == nil and 1 or __wf_atom_421b01aa(p7, 0, 1)

			if result.NeedsInit then
				table.insert(result.InitFuncQueue, {
					result.AddNode,
					nodeId,
					isLeftSide,
					progress,
					hideCenter,
					p9
				})
				return
			end

			result.List:AddElement({
				NodeId = nodeId,
				IsLeftSide = isLeftSide,
				Progress = progress,
				HideCenter = hideCenter,
				ShouldPulse = true
			}, p9)
			table.insert(result.Data.Nodes, {
				NodeId = nodeId,
				IsLeftSide = isLeftSide,
				Progress = progress,
				HideCenter = hideCenter
			})
			fn13()
		end

		function result.RemoveNode(p6, p7)
			if result.NeedsInit then
				table.insert(result.InitFuncQueue, { result.RemoveNode, p6, p7 })
				return
			end

			local v11 = nil

			for _, mElement in ipairs(result.List.mElements) do
				if mElement.NodeId ~= p6 then
					continue
				end

				v11 = mElement
				break
			end

			if not __wf_atom_7e8ad928(v11) then
				result.List:RemoveElement(v11.mIndex, p7)

				for i, node in ipairs(result.Data.Nodes) do
					if node.NodeId ~= p6 then
						continue
					end

					table.remove(result.Data.Nodes, i)
					fn13()
					return
				end
			end
		end

		function result.ApplyNodeUpdate(nodes)
			if result.NeedsInit then
				table.insert(result.InitFuncQueue, { result.ApplyNodeUpdate, nodes })
				return
			end

			local v11 = 1
			local v12 = 1
			local v13 = false

			while true do
				local node = nodes[v11]
				local elementInIndex = result.List:GetElementInIndex(v12)

				if __wf_atom_7e8ad928(node) then
					if __wf_atom_7e8ad928(elementInIndex) then
						break
					end

					result.List:RemoveElement(v12, true)
					v13 = true
				elseif __wf_atom_7e8ad928(elementInIndex) then
					result.List:AddElement({
						NodeId = node.NodeId,
						IsLeftSide = node.IsLeftSide,
						Progress = node.Progress,
						HideCenter = node.HideCenter,
						ShouldPulse = true
					}, true)
					v11 += 1
					v12 += 1
					v13 = true
				elseif elementInIndex.NodeId == node.NodeId then
					if elementInIndex.NodeId ~= node.NodeId then
						break
					end

					if
						elementInIndex.IsLeftSide ~= node.IsLeftSide
						or elementInIndex.Progress ~= node.Progress
						or elementInIndex.HideCenter ~= node.HideCenter
					then
						elementInIndex.ShouldPulse = elementInIndex.IsLeftSide ~= node.IsLeftSide
						elementInIndex.IsLeftSide = node.IsLeftSide
						elementInIndex.Progress = node.Progress
						elementInIndex.HideCenter = node.HideCenter
						v13 = true
					end

					v11 += 1
					v12 += 1
				else
					result.List:RemoveElement(v12, true)
					v13 = true
				end
			end

			if v13 and not gRegion:IsMaster() and v8 then
				result.Data.Nodes = nodes
				fn13()
			end

			result.List:Redraw(nil, true, true)
		end

		function result.UpdateHudColors()
			if __wf_atom_7e8ad928(v) then
				return
			end

			local leftColorId = result.Data.LeftColorId
			local rightColorId = result.Data.RightColorId

			if not result.Data.LeftColorHex then
				leftColorId = v:__wf_atom_fd5d793e(leftColorId)
			end

			if not result.Data.RightColorHex then
				rightColorId = v:__wf_atom_fd5d793e(rightColorId)
			end

			movie:__wf_atom_4c1c1986(clipName, "FillLeft", 11, leftColorId)
			movie:__wf_atom_4c1c1986(clipName, "FillRight", 11, rightColorId)
			movie:__wf_atom_4c1c1986(clipName, "Flare.FlareLeft", 11, leftColorId)
			movie:__wf_atom_4c1c1986(clipName, "Flare.FlareRight", 11, rightColorId)

			if not __wf_atom_7e8ad928(result.List) then
				result.List:Redraw(nil, true, true)
			end
		end

		function result.ApplyData(data, _, p6)
			if not __wf_atom_7e8ad928(data.Progress) then
				result.SetValue(data.Progress, p6)
			end

			if not __wf_atom_7e8ad928(data.BgDistortionStrength) then
				result.SetBgDistortion(data.BgDistortionStrength, p6)
			end

			if not __wf_atom_7e8ad928(data.CenterLabel) then
				result.SetCenterLabel(data.CenterLabel, data.ShowCenterFx, p6)
			end

			if not (__wf_atom_7e8ad928(data.LeftLabel) and __wf_atom_7e8ad928(data.RightLabel)) then
				result.SetLabels(data.LeftLabel, data.RightLabel, p6)
			end

			if not __wf_atom_7e8ad928(data.LeftColorId) then
				result.SetLeftColor(data.LeftColorId, data.LeftColorHex, p6)
			end

			if not __wf_atom_7e8ad928(data.RightColorId) then
				result.SetRightColor(data.RightColorId, data.RightColorHex, p6)
			end

			result.ApplyNodeUpdate(data.Nodes)
			result.ApplyDataCommon(data, p6)
		end
	elseif p == module.HT_DRAGON_TRACKER then
		result.Data.AutoHeight = true
		result.Data.Padding = 10
		result.TargetRotation = 1
		result.LineThickness = 3
		result.ActiveLineThickness = 1
		result.Data.RingPositions = { 0, 0, 0, 0, 0 }

		function result.SetRingColor(p6, p7)
			movie:__wf_atom_4c1c1986(clipName, "Circle.ArrowRotator" .. p6, 11, p7)

			for i = 1, result.LineThickness do
				local v11 = "Circle.Line" .. (p6 - 1) * result.LineThickness + i
				movie:__wf_atom_4c1c1986(clipName, v11, 11, p7)
				movie:__wf_atom_4c1c1986(clipName, v11, 11, p7)
			end
		end

		function result.SetProgressMode(progressMode, p6)
			if not p6 and progressMode == result.Data.ProgressMode then
				return
			end

			result.Data.ProgressMode = progressMode
			fn13()
			fn3(function()
				movie:__wf_atom_7f57ab2f(clipName, "Circle", 13, not progressMode)
				movie:__wf_atom_7f57ab2f(clipName, "Direction", 13, not progressMode)
				movie:__wf_atom_7f57ab2f(clipName, "ProgressContainer", 13, progressMode)
				movie:__wf_atom_7f57ab2f(clipName, "ProgressFlare", 13, progressMode)
			end)
		end

		function result.SetTargetPosition(targetPosition, p6)
			if not p6 and targetPosition == result.Data.TargetPosition then
				return
			end

			result.Data.TargetPosition = targetPosition
			fn13()
			fn3(function()
				result.TargetRotation = 90 + result.Data.TargetPosition * 90
				movie:__wf_atom_4c1c1986(clipName, "Direction", 16, result.TargetRotation)

				for i = 1, result.Data.ActiveRings do
					local v11 = result.Data.RingPositions[i] == result.Data.TargetPosition
					local ternary = module3.Ternary(v11, 16774830, 12495206)
					result.SetRingColor(i, ternary)

					for j = 1, result.ActiveLineThickness do
						movie:__wf_atom_7f57ab2f(clipName, "Circle.Line" .. i * result.LineThickness - (j - 1), 13, v11)
					end
				end
			end)
		end

		function result.SetRingCount(p6, p7)
			local activeRings = __wf_atom_421b01aa(p6, 0, 5)

			if not p7 and activeRings == result.Data.ActiveRings then
				return
			end

			result.Data.ActiveRings = activeRings
			fn13()
			fn3(function()
				for i = 1, 5 do
					local v11 = i <= result.Data.ActiveRings
					local v12 = 30 + i * (107 / (result.Data.ActiveRings + 1))

					for j = 1, result.LineThickness do
						local v13 = "Circle.Line" .. (i - 1) * result.LineThickness + j
						movie:__wf_atom_7f57ab2f(clipName, v13, 13, v11)

						if not v11 then
							continue
						end

						movie:__wf_atom_4c1c1986(clipName, v13, 14, v12 - (j - 1))
						movie:__wf_atom_4c1c1986(clipName, v13, 15, v12 - (j - 1))
					end

					movie:__wf_atom_4c1c1986(clipName, "Circle.ArrowRotator" .. i .. ".Arrow", 1, v12 / 2 - 1)
					movie:__wf_atom_4c1c1986(clipName, "Circle.ArrowRotator" .. i .. ".Arrow", 14, 28 + i)
					movie:__wf_atom_4c1c1986(clipName, "Circle.ArrowRotator" .. i .. ".Arrow", 15, 8 + i / 2)
					movie:__wf_atom_7f57ab2f(clipName, "Circle.ArrowRotator" .. i, 13, v11)
				end
			end)
		end

		function result.SetActiveRing(activeRing)
			fn3(function()
				if activeRing ~= result.ActiveRing and result.ActiveRing ~= nil then
					local v11 = result.Data.RingPositions[result.ActiveRing] == result.Data.TargetPosition
					local ternary = module3.Ternary(v11, 16114605, 12495206)
					result.SetRingColor(result.ActiveRing, ternary)
				end

				result.ActiveRing = activeRing

				if activeRing ~= nil then
					result.SetRingColor(activeRing, _G.UIColor_White)
				end
			end)
		end

		function result.SetRingPosition(p6, p7, p8)
			if result.Data.ActiveRings < p6 or p7 == nil or result.Data.RingPositions[p6] == p7 and not p8 then
				return
			end

			local v11 = result.Data.RingPositions[p6] == 0
			result.Data.RingPositions[p6] = p7
			fn13()
			fn3(function()
				local v12 = clipName .. ".Circle.ArrowRotator" .. p6
				local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(v12, 16)
				local v13 = 90 + p7 * 90

				if __wf_atom_5e6e15c8 + 180 < v13 then
					v13 -= 360
				end

				if v11 then
					movie:__wf_atom_e57658c2(v12, 16, v13)
					local v14 = result.Data.RingPositions[p6] == result.Data.TargetPosition
					local ternary = module3.Ternary(v14, 16114605, 12495206)
					result.SetRingColor(p6, ternary)

					for i = 1, result.ActiveLineThickness do
						movie:__wf_atom_7f57ab2f(
							clipName,
							"Circle.Line" .. p6 * result.LineThickness - (i - 1),
							13,
							v14
						)
					end
				else
					for i = 1, result.ActiveLineThickness do
						movie:__wf_atom_7f57ab2f(
							clipName,
							"Circle.Line" .. p6 * result.LineThickness - (i - 1),
							13,
							false
						)
					end

					result.SetRingColor(p6, _G.UIColor_White)
					__wf_atom_ec43d06e(movie, v12, 2, { 16 }, { v13 }, 1.7, 0, function()
						local v14 = result.Data.RingPositions[p6] == result.Data.TargetPosition
						local ternary = module3.Ternary(v14, 16114605, 12495206)
						result.SetRingColor(p6, ternary)

						for i = 1, result.ActiveLineThickness do
							movie:__wf_atom_7f57ab2f(
								clipName,
								"Circle.Line" .. p6 * result.LineThickness - (i - 1),
								13,
								v14
							)
						end

						if v14 and not __wf_atom_7e8ad928(v7.dragonAlignFx) then
							local rootBasedPosition, v15 = module.GetRootBasedPosition(movie, clipName .. ".Bg")
							module.CreateScreenParticles(movie, v7.dragonAlignFx, rootBasedPosition + 10, v15)
						end
					end)
				end
			end)
		end

		function result.SetProgress(progress, p6)
			if not p6 and progress == result.Data.Progress then
				return
			end

			result.Data.Progress = progress
			fn13()
			fn3(function()
				local v11 = math.floor(result.Data.Progress * 100) .. "%"
				movie:__wf_atom_48bd5a59(clipName, "ProgressContainer.Label", 36, v11)
				movie:__wf_atom_1ca72041(
					clipName .. ".ProgressContainer.ProgressCircle",
					"AlphaTestThreshold",
					result.Data.Progress,
					0,
					0,
					0
				)
			end)
		end

		function result.ApplyData(data, _, p6)
			if not __wf_atom_7e8ad928(data.TargetPosition) then
				result.SetTargetPosition(data.TargetPosition, p6)
			end

			if not __wf_atom_7e8ad928(data.ActiveRings) then
				result.SetRingCount(data.ActiveRings, p6)

				for i = 1, data.ActiveRings do
					if not __wf_atom_7e8ad928(data.RingPositions[i]) then
						result.SetRingPosition(i, data.RingPositions[i], p6)
					end
				end
			end

			if not __wf_atom_7e8ad928(data.Progress) then
				result.SetProgress(data.Progress, p6)
			end

			if not __wf_atom_7e8ad928(data.ProgressMode) then
				result.SetProgressMode(data.ProgressMode, p6)
			end

			result.ApplyDataCommon(data, p6)
		end
	elseif p == module2.HT_PROGRESS_TRACKER then
		function result.SetLabel(p6, _, _)
			fn3(function()
				p6 = movie:__wf_atom_8e9ac384(p6, true)
				movie:__wf_atom_48bd5a59(clipName, "Title", 36, p6)
				movie:__wf_atom_4c1c1986(clipName, "Banner", 14, movie:__wf_atom_cfc41e35(clipName, "Title", 40) + 20)
			end)
		end

		function result.SetGoal(p6)
			movie:__wf_atom_48bd5a59(clipName, "Element.Label", 36, p6)
		end

		function result.ApplyData(p6, _, p7)
			result.ApplyDataCommon(p6, p7)
		end
	else
		flag = false
		result = nil
		print("Unknown HUD Tracker " .. p)
	end

	function result.SetTrackingId(trackingId)
		if not __wf_atom_7e8ad928(trackingId) and trackingId ~= "" then
			result.Data.TrackingId = trackingId
			fn13()

			if _T.ObjectiveTrackers == nil then
				_T.ObjectiveTrackers = {}
			end

			if _T.ObjectiveTrackers[trackingId] == nil then
				_T.ObjectiveTrackers[trackingId] = {}
			end

			_T.ObjectiveTrackers[trackingId][result.Name] = result
		end
	end

	function result.SetAutonomousVisibility(autonomousVisibility)
		result.Data.AutonomousVisibility = autonomousVisibility
		result.AutonomousVisibility = autonomousVisibility
		fn13()
	end

	if flag then
		if v8 and v9 then
			if result.UpdateData == nil then
				fn13()
			else
				result.UpdateData()
			end
		end

		table.insert(savedHudTrackers2.List, result)
	end

	if movie then
		fn4(fn8, result, v10)
	else
		fn4(fn6, result, v10)
	end

	return result
end

function AddHudTracker(name, p, p2, p3, p4, initCallBack, p5)
	return (fn12(name, p, p2, p3, p4, initCallBack, p5))
end

function Sort()
	fn5() -- inferred equivalent call
end

local function fn13(p)
	for _, activeHealthTracker in pairs(savedHudTrackers2.ActiveHealthTrackers) do
		if activeHealthTracker.Data.RemoveOnNullTarget and __wf_atom_7e8ad928(activeHealthTracker.DisplayAvatar) then
			fn10(activeHealthTracker)
		elseif not __wf_atom_7e8ad928(activeHealthTracker.Display) then
			activeHealthTracker.Display:Update(p)

			if not (__wf_atom_7e8ad928(activeHealthTracker.HealthPct) or __wf_atom_7e8ad928(activeHealthTracker.DisplayAvatar)) then
				local v8 = math.ceil(activeHealthTracker.DisplayAvatar:__wf_atom_bb81a9df() * 100)
				local v9 = v8 > 100 and 100 or v8
				activeHealthTracker.HealthPct:Set(v9)
			end
		end
	end
end

function UpdateHudTrackers(p)
	fn13(p)

	for _, activeUpdater in pairs(savedHudTrackers2.ActiveUpdaters) do
		activeUpdater.Update(p)
	end

	for _, activeBlinkTracker in pairs(savedHudTrackers2.ActiveBlinkTrackers) do
		activeBlinkTracker.UpdateBlinkColors(p)
	end

	if not __wf_atom_7e8ad928(gGameRules2) and gGameRules2:__wf_atom_2cc9377d() then
		local hudTrackers = gGameRules2:GetHudTrackers()

		for _, v8 in ipairs(savedHudTrackers2.List) do
			if not v8.Local then
				v8.NoDataReceived = true
			end
		end

		for _, hudTracker in ipairs(hudTrackers) do
			local v8 = false

			if hudTracker.mDirty then
				local success, result = pcall(cjson.decode, hudTracker.mData)

				if not success then
					if result ~= nil then
						print(result)
					end

					print(hudTracker.mName)
					print(hudTracker.mData)
					LogBug("cjson.decode failed for a hud tracker, check the log for the json dump")
					result = nil
				end

				local mEntity = hudTracker.mEntity

				if not __wf_atom_7e8ad928(result) then
					v8 = true
					local v9 = fn12(
						hudTracker.mName,
						result.Type,
						result.FadeTime,
						result.SortPriority,
						true,
						nil,
						false
					)
					v9.NoDataReceived = nil
					v9.ApplyData(result, mEntity)

					if result.Type == module.HT_HEALTH_TRACKER and __wf_atom_7e8ad928(mEntity) then
						gGameRules2:SetHudTrackerDirty(hudTracker.mName, true)
					end
				end
			end

			if v8 then
				continue
			end

			for _, v9 in ipairs(savedHudTrackers2.List) do
				if v9.Name ~= hudTracker.mName then
					continue
				end

				v9.NoDataReceived = nil
				break
			end
		end

		local names = {}

		for _, v8 in ipairs(savedHudTrackers2.List) do
			if v8.NoDataReceived then
				table.insert(names, v8.Name)
			end
		end

		for i = 1, #names do
			fn10(names[i])
		end
	end
end

local function fn14()
	if __wf_atom_7e8ad928(movie) then
		return
	end

	for _, v8 in ipairs(savedHudTrackers2.List) do
		if not __wf_atom_7e8ad928(v8.UpdateHudColors) then
			v8.UpdateHudColors()
		end
	end
end

function UpdateHudColors()
	fn14()
end

function Initialize(p, p2, p3, p4, p5, p6, p7)
	movie = p
	v = p2
	v3 = p3
	v7 = p4
	v4 = p5
	v5 = p6
	v6 = p7
	gGameRules2 = gGameRules
	savedHudTrackers2 = {
		CurrentIndex = 0,
		List = {},
		TypeInfo = {},
		ActiveHealthTrackers = {},
		ActiveUpdaters = {},
		ActiveBlinkTrackers = {}
	}
	savedHudTrackers2.TypeInfo[module.HT_PROGRESS_BAR] = { Name = "ProgressBar" }
	savedHudTrackers2.TypeInfo[module.HT_TIMER] = { Name = "Timer" }
	savedHudTrackers2.TypeInfo[module.HT_HEALTH_TRACKER] = { Name = "HealthTracker" }
	savedHudTrackers2.TypeInfo[module.HT_OPPONENT_BAR] = { Name = "OpponentBar" }
	savedHudTrackers2.TypeInfo[module.HT_LABEL] = { Name = "Label" }
	savedHudTrackers2.TypeInfo[module.HT_ICON_BAR] = { Name = "IconBar" }
	savedHudTrackers2.TypeInfo[module.HT_TEMPERATURE_BAR] = { Name = "TemperatureBar" }
	savedHudTrackers2.TypeInfo[module.HT_CORRUPTION_BAR] = { Name = "CorruptionMeter" }
	savedHudTrackers2.TypeInfo[module2.HT_PROGRESS_TRACKER] = { Name = "ProgressTracker" }
	v2 = __wf_atom_72884638("HUD.UseAlternateHud")

	if not (__wf_atom_7e8ad928(v) or __wf_atom_7e8ad928(movie)) then
		fn14()
	end
end

function SaveTrackers()
	_T.SavedHudTrackers = savedHudTrackers2
end

function LoadTrackers()
	if __wf_atom_7e8ad928(_T.SavedHudTrackers) then
		return
	end

	local savedHudTrackers = _T.SavedHudTrackers

	for i = 1, #savedHudTrackers.List do
		local v8 = savedHudTrackers.List[i]
		local kind = v8.Data.Type
		fn12(v8.Name, kind, v8.Data.FadeTime, v8.Data.SortPriority, not v8.Local).ApplyData(v8.Data, v8.EntityInfo)
		savedHudTrackers2.ActiveUpdaters = savedHudTrackers.ActiveUpdaters
	end

	_T.SavedHudTrackers = nil
end

function SetGameRules(object)
	print("SetGameRules: " .. (__wf_atom_7e8ad928(object) and "N/A" or object:__wf_atom_5b41f63b()))
	gGameRules2 = object
end