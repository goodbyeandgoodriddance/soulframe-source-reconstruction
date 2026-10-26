module(..., package.seeall)

function Create(p, p2, p3)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIStyleUtilities")
	local module3 = require("Lotus.Interface.Components.ThemedButton")
	local mChecked2 = p3 == nil or p3
	local v = module3.Create(p, p2)
	v.mIconOnClipName = "IconOff"
	v.mIconOffClipName = "IconOn"
	v.mIconOn = nil
	v.mIconOff = nil
	v.mIconDefault = nil
	v.mIconOnSize = 25
	v.mIconOffSize = 17
	v.mIconDefaultSize = 16
	v.mChecked = mChecked2

	function v:UpdateIcons()
		local mMovie = self.mMovie
		local mClipName = self.mClipName
		mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOnClipName, 12, module.Ternary(self.mChecked, 100, 60))
		mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOffClipName, 12, module.Ternary(self.mChecked, 60, 100))

		if v.mChecked then
			mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOnClipName, 14, self.mIconOnSize)
			mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOnClipName, 15, self.mIconOnSize)
			mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOffClipName, 14, self.mIconDefaultSize)
			mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOffClipName, 15, self.mIconDefaultSize)
			mMovie:__wf_atom_4c1c1986(mClipName, "Inner", 0, self.mWidth / 2 - 2)
			mMovie:__wf_atom_c90af43a(mClipName .. "." .. self.mIconOnClipName, self.mIconOn)
			mMovie:__wf_atom_c90af43a(mClipName .. "." .. self.mIconOffClipName, self.mIconDefault)
		else
			mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOnClipName, 14, self.mIconDefaultSize)
			mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOnClipName, 15, self.mIconDefaultSize)
			mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOffClipName, 14, self.mIconOffSize)
			mMovie:__wf_atom_4c1c1986(mClipName, self.mIconOffClipName, 15, self.mIconOffSize)
			mMovie:__wf_atom_4c1c1986(mClipName, "Inner", 0, -1)
			mMovie:__wf_atom_c90af43a(mClipName .. "." .. self.mIconOnClipName, self.mIconDefault)
			mMovie:__wf_atom_c90af43a(mClipName .. "." .. self.mIconOffClipName, self.mIconOff)
		end
	end

	function v:SetValue(mChecked, p4)
		local v2 = p4 == nil or p4
		self.mChecked = mChecked
		self:ValueChanged()

		if v2 then
			self:UpdateIcons()
			self:UpdateColors()
		end
	end

	v.ButtonPressed = v.Pressed

	function v:Pressed(p4, p5)
		self:ButtonPressed(p4, p5)

		if p4 and self:IsActive() then
			self:SetValue(not self.mChecked)
		end
	end

	v.ButtonResize = v.Resize

	function v.Resize(object)
		object:ButtonResize()
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "Inner", 14, object.mWidth / 2 + 3)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "Inner", 15, object.mHeight)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconOn", 0, object.mWidth / 4)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconOn", 1, object.mHeight / 2)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconOff", 0, object.mWidth * 0.75)
		object.mMovie:__wf_atom_4c1c1986(object.mClipName, "IconOff", 1, object.mHeight / 2)
	end

	v.ButtonUpdateColors = v.UpdateColors

	function v:UpdateColors()
		self:ButtonUpdateColors()
		local mApplyThemes = self.mApplyThemes
		local color = module2.GetColor(9, true, mApplyThemes)
		local color2 = module2.GetColor(10, true, mApplyThemes)
		self.mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			self.mIconOnClipName,
			11,
			module.Ternary(self.mFocused and self.mChecked, color2, color)
		)
		self.mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			self.mIconOffClipName,
			11,
			module.Ternary(self.mFocused and not self.mChecked, color2, color)
		)
		self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Inner", 11, color)
	end

	v.ButtonRedraw = v.Redraw

	function v:Redraw()
		self:ButtonRedraw()
		self:UpdateIcons()
		local uiMaterial_Button = _G.UIMaterial_Button

		if not __wf_atom_7e8ad928(self.mVisRangeMaterials) then
			self.mMovie:OverrideMaterial(
				self.mClipName .. "." .. self.mIconOnClipName,
				self.mVisRangeMaterials.BaseMaterial
			)
			self.mMovie:OverrideMaterial(
				self.mClipName .. "." .. self.mIconOffClipName,
				self.mVisRangeMaterials.BaseMaterial
			)
			uiMaterial_Button = self.mVisRangeMaterials.BackerMaterial
		end

		self.mMovie:OverrideMaterial(self.mClipName .. ".Inner", uiMaterial_Button)
		self.mMovie:__wf_atom_1ca72041(self.mClipName .. ".Inner", "RectEdgeColor", 0, 0, 0, 0)
		self.mMovie:__wf_atom_1ca72041(self.mClipName .. ".Inner", "RectInnerColor", 1, 1, 1, 1)
	end

	v:Redraw()
	return v
end