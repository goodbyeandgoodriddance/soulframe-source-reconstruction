module(..., package.seeall)

function Create(p, p2, options, value)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIStyleUtilities")
	local module3 = require("Lotus.Interface.Components.ThemedButton")
	local v = module3.Create(p, p2)
	v.mOptions = options or {}
	v.mIndex = value or 1
	v.mArrowIcon = nil
	v.mArrowIconWidth = 16
	v.mArrowIconHeight = 32
	v.mLabelYOffset = -0.5
	v.mArrowFocused = 0
	v.Button_SetActive = v.SetActive

	function v.SetActive(object, p3)
		object:Button_SetActive(p3)
		object.mMovie:__wf_atom_2dedec1a(object.mClipName .. ".BtnLeft", 67, p3)
		object.mMovie:__wf_atom_2dedec1a(object.mClipName .. ".BtnRight", 67, p3)
	end

	v.Button_HookUpCallbacks = v.HookUpCallbacks

	function v:HookUpCallbacks()
		self:Button_HookUpCallbacks()
		local parentEnv = self:GetParentEnv()
		local mMovie = self.mMovie
		local mClipName = self.mClipName
		local v2 = string.gsub(mClipName, "%.", "")

		parentEnv[v2 .. "OverAlt"] = function(p3)
			self:TrySetAltFocus(true, (tonumber(p3)))
		end

		parentEnv[v2 .. "OutAlt"] = function(p3)
			self:TrySetAltFocus(false, (tonumber(p3)))
		end

		parentEnv[v2 .. "PressAlt"] = function(p3)
			self:TryAltPressed(true, (tonumber(p3)))
		end

		parentEnv[v2 .. "ReleaseAlt"] = function(p3)
			self:TryAltPressed(false, (tonumber(p3)))
		end

		mMovie:SetCallbacks(
			mClipName .. ".BtnLeft",
			v2 .. "OverAlt",
			v2 .. "OutAlt",
			v2 .. "ReleaseAlt",
			v2 .. "PressAlt"
		)
		mMovie:SetCallbacks(
			mClipName .. ".BtnRight",
			v2 .. "OverAlt",
			v2 .. "OutAlt",
			v2 .. "ReleaseAlt",
			v2 .. "PressAlt"
		)
		mMovie:__wf_atom_e57658c2(mClipName .. ".BtnLeft", 100, -1)
		mMovie:__wf_atom_e57658c2(mClipName .. ".BtnRight", 100, 1)
	end

	v.ButtonSetFocus = v.SetFocus

	function v:SetFocus(p3, _)
		self:SetAltFocus(p3, 1)
	end

	function v:TrySetAltFocus(p3, p4)
		self:SetAltFocus(p3, p4)
	end

	function v:SetAltFocus(p3, p4)
		if p3 then
			self.mArrowFocused = tonumber(p4)
		else
			self.mArrowFocused = 0
		end

		self:ButtonSetFocus(p3)
		self:UpdateColors()
	end

	function v:Pressed(p3, _)
		self:AltPressed(p3, 1)
	end

	function v:TryAltPressed(p3, p4)
		self:AltPressed(p3, p4)
	end

	function v:AltPressed(p3, p4)
		if p3 then
			self:SetValue((self.mIndex + p4 - 1) % #self.mOptions + 1)
		end
	end

	function v:SetIndexByValue(p3, p4)
		local v2 = 1

		for i = 1, #self.mOptions do
			if self.mOptions[i].Value ~= p3 then
				continue
			end

			v2 = i
			break
		end

		self:SetValue(v2, p4)
	end

	function v:SetValue(p3, p4)
		self.mIndex = __wf_atom_421b01aa(p3, 1, #self.mOptions)

		if self.mOptions[self.mIndex] == nil then
			print("no options! requested: " .. p3)
			self.mLabel = "INVALID"
		else
			self.mLabel = self.mOptions[self.mIndex].Label
		end

		if not p4 then
			self:SetText(self.mLabel)
		end

		self:ValueChanged()
	end

	v.ButtonResize = v.Resize

	function v.Resize(object)
		object:ButtonResize()
		local v2 = math.max(object.mArrowIconWidth, object.mArrowIconHeight)
		local v3 = object.mWidth - v2 - v2
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "Label", 0, v2 + 10)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "Label", 14, v3)

		if object.mPostText ~= nil then
			module.SetFitText(object.mMovie, object.mClipName .. ".Label", object.mPostText)
		end

		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "Btn", 0, v2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "Btn", 1, object.mHeight / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "Btn", 14, v3)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "Btn", 15, object.mHeight)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "BtnLeft", 0, v2 / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "BtnLeft", 1, object.mHeight / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "BtnLeft", 14, v2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "BtnLeft", 15, object.mArrowIconHeight)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconLeft", 0, v2 / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconLeft", 1, object.mHeight / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconLeft", 14, object.mArrowIconWidth)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconLeft", 15, object.mArrowIconHeight)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "BtnRight", 0, v2 + v3 + v2 / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "BtnRight", 1, object.mHeight / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "BtnRight", 14, v2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "BtnRight", 15, object.mArrowIconHeight)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconRight", 0, v2 + v3 + v2 / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconRight", 1, object.mHeight / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconRight", 14, object.mArrowIconWidth)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconRight", 15, object.mArrowIconHeight)
	end

	v.ButtonUpdateColors = v.UpdateColors

	function v:UpdateColors()
		self:ButtonUpdateColors()
		local mApplyThemes = self.mApplyThemes
		local color = module2.GetColor(9, true, mApplyThemes)
		local color2 = module2.GetColor(10, true, mApplyThemes)
		self.mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"IconLeft",
			11,
			module.Ternary(self.mArrowFocused == -1, color2, color)
		)
		self.mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"IconRight",
			11,
			module.Ternary(self.mArrowFocused == 1, color2, color)
		)
	end

	v.ButtonRedraw = v.Redraw

	function v:Redraw()
		self:ButtonRedraw()
		self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "Backer", 13, false)

		if not __wf_atom_7e8ad928(self.mVisRangeMaterials) then
			self.mMovie:OverrideMaterial(self.mClipName .. ".IconLeft", self.mVisRangeMaterials.BaseMaterial)
			self.mMovie:OverrideMaterial(self.mClipName .. ".IconRight", self.mVisRangeMaterials.BaseMaterial)
		end

		self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".IconLeft", self.mArrowIcon)
		self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".IconRight", self.mArrowIcon)
	end

	v.mHookedUpCallbacks = false
	v:HookUpCallbacks()
	local label

	if #v.mOptions > 0 and not __wf_atom_7e8ad928(v.mIndex) then
		if __wf_atom_7e8ad928(v.mOptions[v.mIndex]) then
			label = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Generic_Error", false)
		else
			label = v.mOptions[v.mIndex].Label
		end
	else
		label = ""
	end

	v:SetText(label)
	v:Redraw()
	return v
end