module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")

function Create(p, p2, options)
	local v = options or {}
	local mMovie = p.mMovie
	local _ = not mMovie:__wf_atom_253d7085(p2)
	local mScrollAlwaysVisible = v.mScrollAlwaysVisible
	v.mGrid = true
	v.mDecrementSelectedCallback = nil
	v.mIncrementSelectedCallback = nil
	v.mPadding = v.mPadding or 8
	v.mColumnSeparation = (v.mColumnSeparation or 134) + v.mPadding
	v.mRowSeparation = (v.mRowSeparation or 134) + v.mPadding
	v.mOriginalButtonHeight = v.mOriginalButtonHeight or v.mRowSeparation
	v.mInitialX = v.mColumnSeparation / 2
	v.mInitialY = v.mRowSeparation / 2
	v.mAlignment = v.mAlignment or module.RIGHT_ALIGNED
	v.mAddFillerElements = v.mAddFillerElements == nil or v.mAddFillerElements
	local module3 = require("EE.Interface.Components.Grid")
	local newGrid = module3.CreateNewGrid(p, p2 .. ".Offset.Grid.Element", v)

	if newGrid.mColumns == nil then
		newGrid.mColumns = math.floor((986 + newGrid.mPadding) / newGrid.mColumnSeparation)
	end

	newGrid.mDefaultWidth = newGrid.mDefaultWidth or newGrid.mColumns * newGrid.mColumnSeparation - newGrid.mPadding
	newGrid.mScrollAlwaysVisible = mScrollAlwaysVisible

	if newGrid.mContentHeight == nil and newGrid.mRows ~= nil then
		newGrid.mContentHeight = newGrid.mRows * newGrid.mRowSeparation
	end

	local module4 = require("EE.Interface.Components.ItemList")
	local v2 = module4.Create(p, p2, newGrid)
	v2.ITEM_UTIL = require("SF.Interface.Libs.ItemUtil")
	v2.ItemGrid_Redraw = v2.Redraw

	function v2.Redraw(object, p3, p4, p5)
		if object.mAddFillerElements then
			local mRows = math.floor(object.mRows)
			local mColumns = math.floor(object.mColumns)

			for _ = 1, math.max(math.ceil(#object.mElements / mColumns), mRows) * mColumns - #object.mElements do
				object:ItemList_AddElement({ IsDummy = true }, true)
			end
		end

		object:ItemGrid_Redraw(p3, p4, p5)
		local v3 = mMovie:__wf_atom_5e6e15c8(p2 .. ".Offset.Grid", 14) - 64

		if v3 < mMovie:__wf_atom_5e6e15c8(p2 .. ".TitleBar", 14) then
			mMovie:__wf_atom_4c1c1986(p2, "TitleBar.Backer", 14, v3)
			mMovie:__wf_atom_4c1c1986(p2, "TitleBar.DetailLeft", 0, -v3 / 2 - 12)
			mMovie:__wf_atom_4c1c1986(p2, "TitleBar.DetailRight", 0, v3 / 2 + 12)
		end
	end

	v2.ItemGrid_UpdateWidth = v2.UpdateWidth

	function v2:UpdateWidth(p3, p4)
		local v3 = p3 or self.mWidth
		self.mColumns = math.floor((v3 + self.mPadding) / self.mColumnSeparation)
		local v4 = self.mColumns * self.mColumnSeparation - self.mPadding

		if v3 ~= v4 then
			v3 = v4
			p4 = true
		end

		self:ItemGrid_UpdateWidth(v3, p4)
	end

	function v2:PressedElementById(p3)
		if self.mMultiSelect then
			local elementById = self:GetElementById(p3)

			if elementById ~= nil then
				if not self:Selectable(elementById) then
					return
				end

				module.PlaySound(_G.UISound_Select)

				if self.mShiftKeyDown then
					self.ITEM_UTIL.MaxSelectedCount(mMovie, elementById.mClipName, elementById, self)
				else
					self.ITEM_UTIL.IncSelectedCount(mMovie, elementById.mClipName, elementById, self)
				end
			end
		end
	end

	function v2:RightPressedElementById(p3)
		if self.mMultiSelect then
			local elementById = self:GetElementById(p3)

			if elementById ~= nil then
				if not self:Selectable(elementById) then
					return
				end

				module.PlaySound(_G.UISound_Select)

				if self.mShiftKeyDown then
					self.ITEM_UTIL.MinSelectedCount(mMovie, elementById.mClipName, elementById, self)
				else
					self.ITEM_UTIL.DecSelectedCount(mMovie, elementById.mClipName, elementById, self)
				end
			end
		end
	end

	function v2.UpdateSelectedCount(object, p3, p4)
		if object.mMaxCount ~= nil then
			local v3 = object.mCount + p4 - object.mMaxCount

			if v3 > 0 then
				p4 -= v3
				p3.SelectedCount -= v3
				local convertHEX2RGB255 = module.ConvertHEX2RGB255(_G.UIColor_Tan)
				local convertHEX2RGB255_2 = module.ConvertHEX2RGB255(_G.UIColor_Negative)
				module2.PulseColor(mMovie, p2 .. ".Count", 2, nil, convertHEX2RGB255, convertHEX2RGB255_2)
			end
		end

		object:SetCount(object.mCount + p4)
	end

	v2._Selectable = v2.Selectable

	function v2:Selectable(p3)
		return self:_Selectable(p3) and (not self.mMultiSelect or p3.IsSelectable)
	end

	v2:UpdateWidth()
	v2:SetCallbacks({ Press = "PressedElementById", RightPress = "RightPressedElementById" })
	module.HookUpEnvironmentCallback(p2, p, "onKeyDown_SHIFT", function() end)
	module.HookUpEnvironmentCallback(p2, p, "onKeyUp_SHIFT", function() end)
	return v2
end