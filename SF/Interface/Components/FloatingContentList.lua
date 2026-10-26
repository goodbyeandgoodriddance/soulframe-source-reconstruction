module(..., package.seeall)

function Create(p, p2, options)
	local mMovie = p.mMovie
	local _ = not mMovie:__wf_atom_253d7085(p2)
	local module = require("EE.Interface.Components.List")
	local newList = module.CreateNewList(p, p2 .. ".Offset.List.Element", options or {})
	mMovie:__wf_atom_2dedec1a(p2 .. ".Spinner", 13, false)
	newList.mForcedVerticalSeparation = newList.mForcedVerticalSeparation or 110
	newList.mInitialY = newList.mForcedVerticalSeparation / 2
	newList.mDefaultWidth = newList.mDefaultWidth or mMovie:__wf_atom_cfc41e35(p2, "Offset.List.Element.Btn", 14)

	if newList.mContentHeight == nil and newList.mVisibleElements ~= nil then
		newList.mContentHeight = newList.mVisibleElements * newList.mForcedVerticalSeparation
	end

	local mVisRangeMaterials = {
		Icon = _G.UIMaterial_FloatingListVerticalVisibilityRange,
		Backer = _G.UIMaterial_BackerRoughEdgeVisRangeMaterial,
		Text = _G.UIMaterial_FloatingListVerticalVisibilityRangeText
	}
	newList:AttachScrollBar(p2 .. ".Offset.Scroll", {
		mContentOffset = mMovie:__wf_atom_cfc41e35(p2, "Offset.List", 1) - mMovie:__wf_atom_cfc41e35(p2, "Offset.Scroll", 1),
		mVisRangeOffset = 10,
		mVisRangeMaterials = mVisRangeMaterials
	})

	function newList:UpdateContent(data, p3)
		if __wf_atom_7e8ad928(data) then
			return
		end

		local v = p3 or data.mClipName

		if __wf_atom_7e8ad928(v) then
			return
		end

		mMovie:__wf_atom_48bd5a59(v, "Name", 36, mMovie:__wf_atom_8e9ac384(data.Name or "", true))
		mMovie:__wf_atom_7f57ab2f(
			v,
			"Subheading",
			13,
			not __wf_atom_7e8ad928(data.Subheading) and data.Subheading ~= ""
		)
		mMovie:__wf_atom_48bd5a59(v, "Subheading", 36, mMovie:__wf_atom_8e9ac384(data.Subheading or "", true))
		self:UpdateVisualState(data, nil, v)
	end

	function newList:UpdateVisualState(p3, p4, p5)
		if p3 then
			local v = p5 or p3.mClipName

			if not v then
				return
			end

			if p4 == nil then
				p4 = p3 == newList:GetFocusedElement()
			end

			local _ = p3 == newList.mSelectedElement or p4
			local _ = p3 == newList.mSelectedElement
			local v2 = v .. ".Name"
			local v3

			if p3 == newList.mSelectedElement then
				v3 = _G.UIColor_Yellow
			else
				v3 = _G.UIColor_Gold
			end

			mMovie:__wf_atom_e57658c2(v2, 11, v3)
			mMovie:__wf_atom_2dedec1a(
				v .. ".FloatingListGlow",
				13,
				(p3 == newList.mSelectedElement or p4) and true or false
			)
			mMovie:__wf_atom_e57658c2(v .. ".Subheading", 12, p3.DisableSelection and 70 or 100)
			mMovie:__wf_atom_e57658c2(v .. ".BgFill", 12, p3.DisableSelection and 70 or 100)
			mMovie:__wf_atom_e57658c2(v .. ".Name", 12, p3.DisableSelection and 70 or 100)
		end
	end

	newList.FloatingContentList_OnDraw = newList.OnDraw

	function newList:OnDraw(p3, p4)
		self:FloatingContentList_OnDraw(p3, p4)
		self:UpdateVisualState(p3)
		self:UpdateContent(p3)
	end

	newList.FloatingContentList_OnClipCreated = newList.OnClipCreated

	function newList:OnClipCreated(p3, options2)
		self:FloatingContentList_OnClipCreated(p3, options2)
		mMovie:__wf_atom_e57658c2(p3 .. ".BgFill", 11, _G.UIColor_DarkerBrown)
		mMovie:__wf_atom_e57658c2(p3 .. ".FloatingListGlow", 12, 10)
		mMovie:__wf_atom_e57658c2(p3 .. ".Name", 11, _G.UIColor_Gold)
		mMovie:__wf_atom_e57658c2(p3 .. ".SubHeading", 11, _G.UIColor_Tan)
		mMovie:__wf_atom_2dedec1a(p3 .. ".SubHeading", 52, true)
		mMovie:OverrideMaterial(p3 .. ".BgFill", mVisRangeMaterials.Backer)
		mMovie:OverrideMaterial(p3 .. ".FloatingListGlow", mVisRangeMaterials.Icon)
		mMovie:OverrideMaterial(p3 .. ".Name", mVisRangeMaterials.Text)
		mMovie:OverrideMaterial(p3 .. ".SubHeading", mVisRangeMaterials.Text)
		self:UpdateContent(options2 or {}, p3)
		self:UpdateVisualState(options2, nil, p3)
	end

	newList.FloatingContentList_OnFocused = newList.OnFocused

	function newList:OnFocused(p3)
		self:FloatingContentList_OnFocused(p3)
		self:UpdateVisualState(p3, true)
	end

	newList.FloatingContentList_OnUnfocused = newList.OnUnfocused

	function newList:OnUnfocused(p3)
		self:FloatingContentList_OnUnfocused(p3)
		self:UpdateVisualState(p3, false)
	end

	newList.FloatingContentList_OnSelected = newList.OnSelected

	function newList:OnSelected(p3, p4)
		if p3 == self.mSelectedElement or p3.DisableSelection then
			return
		end

		local mSelectedElement = self.mSelectedElement
		self:FloatingContentList_OnSelected(p3, p4)
		self:UpdateVisualState(p3)

		if mSelectedElement and mSelectedElement.mClipName then
			self:UpdateVisualState(mSelectedElement)
		end
	end

	return newList
end