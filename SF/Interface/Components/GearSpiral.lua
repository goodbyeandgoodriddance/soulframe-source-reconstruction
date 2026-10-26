module(..., package.seeall)

function CreateGearList(object, mClipName2, object2)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.LotusUtilities")
	local module3 = require("Lotus.Interface.UIStyleUtilities")
	local module4 = require("Lotus.Interface.StoreItemUtilities")
	local v = mClipName2 .. ".Items.Item"
	Resource("/SF/Interface/Graphics/ColourCustomization/TintSlotNode.png")
	local v2 = {
		MAX_RING_ITEMS = 8,
		mClipName = mClipName2,
		mUseSpiral = false,
		mShowDirection = true,
		mShowInsertButton = false,
		mElements = {},
		mDrawElements = {},
		mForceUpdate = false,
		mEditMode = false,
		mInHub = false,
		mRadius = 146
	}
	v2.mAngle = 360 / v2.MAX_RING_ITEMS
	v2.mRotationOffset = -3 * v2.mAngle
	v2.mInitialX = 0
	v2.mInitialY = 0
	v2.mFocusedIndex = 1
	v2.mFocused = true
	v2.mCurrentOffset = 1
	v2.mInnerFade = 3
	v2.mOuterFade = 3
	v2.mVisibleElements = v2.MAX_RING_ITEMS
	v2.mElementOffset = 6
	v2.mSpiralWedgeScale = 124
	v2.mDisabledAlpha = 70
	v2.mAllowDuplicates = false
	v2.mTrackingPos = nil
	v2.mRightStick = { X = 0, Y = 0 }
	v2.mDeadzoneCoyoteTimer = 0
	v2.mTypeLoc = "/Lotus/Language/Menu/Store_New"
	v2.mInitIconWidth = object:__wf_atom_5e6e15c8(v .. ".Icon.Texture", 14)
	v2.mInitIconHeight = object:__wf_atom_5e6e15c8(v .. ".Icon.Texture", 15)
	v2.mUnfocusedScale = object:__wf_atom_5e6e15c8(v .. ".Icon", 5)
	v2.mConsumablesPage = 0
	v2.mStatsClips = {}

	function v2:SetCallbacks(mSelectElementCallback, mRollOverElementCallback, mRollOutElementCallback, mPressElementCallback)
		self.mSelectElementCallback = mSelectElementCallback
		self.mRollOverElementCallback = mRollOverElementCallback
		self.mRollOutElementCallback = mRollOutElementCallback
		self.mPressElementCallback = mPressElementCallback

		for i = 1, #self.pElements do
			local mClipName = self.pElements[i].mClipName

			if mClipName == nil then
				continue
			end

			if not __wf_atom_7e8ad928(self.mPressElementCallback) then
				self.mMovie:__wf_atom_976dcedd(mClipName, "PressedCallback", self.mPressElementCallback)
			end

			if not __wf_atom_7e8ad928(self.mSelectElementCallback) then
				self.mMovie:__wf_atom_976dcedd(mClipName, "SelectCallback", self.mSelectElementCallback)
			end

			if not __wf_atom_7e8ad928(self.mRollOverElementCallback) then
				self.mMovie:__wf_atom_976dcedd(mClipName, "RollOverCallback", self.mRollOverElementCallback)
			end

			if not __wf_atom_7e8ad928(self.mRollOutElementCallback) then
				self.mMovie:__wf_atom_976dcedd(mClipName, "RollOutCallback", self.mRollOutElementCallback)
			end
		end
	end

	function v2:GetCount(p)
		local data = p.Data

		if data.mInsertElementButton then
			return nil
		end

		local count = data.Count
		local gearIndex = data.GearIndex
		local mItem = data.mItem

		if gearIndex and not __wf_atom_7e8ad928(object2) then
			if __wf_atom_7e8ad928(mItem) then
				mItem = object2:__wf_atom_ba1c3957(gearIndex, self.mConsumablesPage)
			end

			count = object2:__wf_atom_b62f2024(gearIndex, self.mConsumablesPage)
		end

		if __wf_atom_7e8ad928(mItem) then
			return count
		end

		if mItem:IsA(__wf_atom_72bebce2) and mItem:__wf_atom_2cbbab92() then
			count = math.max(0, count - 1)
		end

		if data.HasRechargeUpgrade == nil then
			data.HasRechargeUpgrade = false
		end

		if data.HasRechargeUpgrade and count ~= 0 then
			count = object:__wf_atom_8e9ac384("<INFINITE>", true)
		end

		return count
	end

	function v2:GetCooldown(instance)
		if
			__wf_atom_7e8ad928(instance)
			or not (instance:IsA(__wf_atom_72bebce2) and (instance:__wf_atom_3e167923(module2.IsPlayingHardGameModeMission()) or _T.IsLiteSortie))
		then
			return 0
		end

		return instance:GetCooldown()
	end

	function v2.GetHowManyElements(p)
		return #p.mElements
	end

	function v2.GetHowManyVisibleElements(p)
		return p.mVisibleElements
	end

	function v2.GetElementInIndex(p, p2)
		return p.mDrawElements[p2]
	end

	function v2.GetFocusedElementIndex(p)
		return p.mFocusedIndex
	end

	function v2.GetFocusedElement(p)
		return p.mDrawElements[p.mFocusedIndex]
	end

	function v2:FocusElement(mFocusedIndex)
		if self.mFocused then
			return
		end

		self.mFocusedIndex = mFocusedIndex
		self.mFocused = true

		if self.mDrawElements[mFocusedIndex] and not self.mDrawElements[mFocusedIndex].DisableFocusVisual then
			__wf_atom_ec43d06e(
				object,
				self.mDrawElements[mFocusedIndex].mClipName .. ".Icon",
				2,
				{ 5, 6 },
				{ self.mUnfocusedScale * 1.35, self.mUnfocusedScale * 1.35 },
				0.25
			)
		end

		if not __wf_atom_7e8ad928(self.mOnFocusedCallback) then
			self.mOnFocusedCallback(self.mDrawElements[mFocusedIndex])
		end
	end

	function v2:UnfocusElement(p)
		if self.mDrawElements[p] ~= nil and self.mDrawElements[p].mClipName ~= nil then
			local mClipName = self.mDrawElements[p].mClipName
			__wf_atom_ec43d06e(
				object,
				mClipName .. ".Icon",
				2,
				{ 5, 6 },
				{ self.mUnfocusedScale, self.mUnfocusedScale },
				0.15
			)
			object:__wf_atom_2dedec1a(mClipName .. ".WedgeHighlight", 13, false)
		end

		self.mFocused = false
		object:__wf_atom_50d60589("GearWheel.GearName", 36, "")
		object:__wf_atom_50d60589("GearWheel.GearDesc", 36, "")
		object:__wf_atom_50d60589(self.mClipName .. ".GearInfo.Slot", 36, "")
		object:__wf_atom_2dedec1a("GearWheel.InfoBg", 13, false)
	end

	function v2:SelectElement(mSelectedElement)
		if not self.mFocused then
			return
		end

		self.mSelectedElement = mSelectedElement
		module.PlaySound(_G.UISound_ButtonSelect)

		if not __wf_atom_7e8ad928(self.mOnSelectedCallback) then
			self.mOnSelectedCallback(self.mDrawElements[mSelectedElement])
		end
	end

	function v2:FocusElementInDirection(p)
		local v3 = (p + 270) % 360
		object:__wf_atom_e57658c2(self.mClipName .. ".DirectionIndicator", 16, v3)
		local v4 = 360
		local v5 = nil

		for _, mDrawElement in pairs(self.mDrawElements) do
			local id = mDrawElement.Id

			if not (not self.mUseSpiral or self.mFocusedIndex - 2 <= id and id <= self.mFocusedIndex + 2) then
				continue
			end

			local v6 = v2.mUseSpiral and 4 or 0
			local v7 = (object:__wf_atom_5e6e15c8(mDrawElement.mClipName, 16) + 180 - v6) % 360
			local v8 = math.min(math.abs(v3 - v7), (math.abs(v3 + 360 - v7)))

			if v8 < v4 then
				v5 = id
				v4 = v8
			elseif 360 - v8 < v4 then
				v4 = 360 - v8
				v5 = id
			end
		end

		if self.mFocused and v5 ~= self.mFocusedIndex then
			self:UnfocusElement(self.mFocusedIndex)
		end

		local v6

		if self.mTrackingPos.X == 0 then
			v6 = false
		else
			v6 = self.mTrackingPos.Y ~= 0
		end

		if v6 and v5 ~= nil and v5 ~= self.mFocusedIndex then
			local mDragging = self.mDragElement ~= nil

			if self.mDragging ~= mDragging then
				self.mDragging = mDragging

				if mDragging then
					module.PlaySound(_G.UISound_StartDrag)
				end

				object:__wf_atom_7f57ab2f(self.mClipName, "DragIcon", 13, mDragging)
			end

			self:FocusElement(v5)
		end
	end

	function v2:SetFilterType(mFilterType)
		self.mFilterType = mFilterType
		local count = #self.mElements

		if __wf_atom_7e8ad928(mFilterType) then
			for i = 1, count do
				local mElement = self.mElements[i]
				mElement.GearIndex = mElement.Id - 1
			end
		elseif not __wf_atom_7e8ad928(object2) then
			local v3 = 1

			for i = 0, count - 1 do
				local __wf_atom_ba1c3957 = object2:__wf_atom_ba1c3957(i, self.mConsumablesPage)

				if __wf_atom_7e8ad928(__wf_atom_ba1c3957) or not __wf_atom_ba1c3957:IsA(mFilterType) then
					continue
				end

				self.mElements[v3].GearIndex = i
				v3 += 1
			end

			for _ = v3, count do
				self.mElements[v3].GearIndex = nil
			end
		end
	end

	function v2:CheckSpiralEnabled()
		local mElements = self.mElements
		local count = 0
		local count2 = 0

		for i = 1, #mElements do
			local mElement = mElements[i]

			if mElement.mInsertElementButton then
				continue
			end

			count += 1

			if not (i <= self.MAX_RING_ITEMS and __wf_atom_7e8ad928(mElement.mItem) and __wf_atom_7e8ad928(mElement.GearIndex)) then
				continue
			end

			count2 += 1
		end

		local mUseSpiral = self.MAX_RING_ITEMS <= count
		local mEditMode = self.mEditMode

		if mEditMode then
			if mUseSpiral then
				if count2 == 0 then
					mEditMode = count < SF.__wf_atom_37a7b2c4
				else
					mEditMode = false
				end
			else
				mEditMode = mUseSpiral
			end
		end

		if not mEditMode and count == self.MAX_RING_ITEMS then
			mUseSpiral = false
		end

		if self.mShowInsertButton ~= mEditMode then
			self.mShowInsertButton = mEditMode

			if mEditMode then
				if not mElements[#mElements].mInsertElementButton then
					self:AddElement({
						mInsertElementButton = true,
						mIconOverride = self.mAddItemTexture,
						mIconWidthOverride = 50,
						mIconHeightOverride = 50,
						mApplyIconColor = true
					})
				end
			else
				for i = #mElements, 1, -1 do
					if mElements[i].mInsertElementButton then
						self:RemoveElement(i)
					end
				end
			end
		end

		if self.mUseSpiral ~= mUseSpiral then
			self.mUseSpiral = mUseSpiral

			if mUseSpiral then
				self.mRadius = 180
				self.mRotationOffset = -137
				self.mVisibleElements = self.MAX_RING_ITEMS - self.mInnerFade
			else
				self.mRadius = 265
				self.mRotationOffset = -120.6
				self.mVisibleElements = self.MAX_RING_ITEMS
			end
		end

		self.mForceUpdate = true
	end

	function v2:UpdateIds(value)
		for i = value or 1, #self.mElements do
			self.mElements[i].Id = i
		end
	end

	function v2:AddElement(p, p2)
		if p2 == nil then
			table.insert(self.mElements, p)
			p.Id = #self.mElements
		else
			table.insert(self.mElements, p2, p)
			self:UpdateIds(p2)
		end

		self:CheckSpiralEnabled()
	end

	function v2:RemoveElement(id2)
		local mElement = self.mElements[id2]
		mElement.mItem = nil
		mElement.GearIndex = nil
		self:CheckSpiralEnabled()

		if id2 <= self.MAX_RING_ITEMS then
			self.mElements[id2] = { Id = id2 }
		elseif #self.mElements <= self.MAX_RING_ITEMS then
			local id = mElement.Id

			for k, _ in pairs(mElement) do
				mElement[k] = nil
			end

			mElement.Id = id
		else
			table.remove(self.mElements, id2)
			self:UpdateIds(id2)
		end
	end

	function v2:EditElement(items, p)
		local mElement = self.mElements[p]

		if mElement ~= nil then
			for k, item in pairs(items) do
				mElement[k] = item
			end
		end

		mElement.GearIndex = nil
		mElement.HasRechargeUpgrade = nil
		self:CheckSpiralEnabled()
	end

	function v2:SetElement(p, p2, p3)
		local mElement = self.mElements[p2]

		if __wf_atom_7e8ad928(mElement) then
			return
		end

		if p.EmptySlot then
			if not mElement.mInsertElementButton then
				self:RemoveElement(p2)
			end
		elseif self:ValidateElement(p, p2, p3) then
			if mElement.mInsertElementButton then
				self:AddElement(p, #self.mElements)
			else
				self:EditElement(p, p2)
			end

			self:RemoveDuplicates(p, p2)
		end
	end

	function v2:MoveElement(p, p2)
		if self.mDragging then
			self.mDragging = false
			module.PlaySound(_G.UISound_EndDrag)
			object:__wf_atom_7f57ab2f(self.mClipName, "DragIcon", 13, false)
		end

		if p == p2 then
			return
		end

		local mElement = self.mElements[p]
		local mElement2 = self.mElements[p2]

		if
			mElement ~= nil
			and mElement2 ~= nil
			and not (mElement.mInsertElementButton or mElement2.mInsertElementButton)
		then
			table.remove(self.mElements, p)

			if p < p2 then
				for i = 0, p2 - p do
					if not __wf_atom_7e8ad928(self.mElements[p + i]) then
						self.mElements[p + i].Id = p + i
					end
				end
			end

			self:AddElement(mElement, p2)
		end
	end

	function v2:RemoveDuplicates(p, p2)
		local mItem = p.mItem

		if self.mAllowDuplicates or __wf_atom_7e8ad928(mItem) then
			return
		end

		for i = #self.mElements, 1, -1 do
			local mElement = self.mElements[i]

			if mElement.Id == p2 then
				continue
			end

			local mItem2 = mElement.mItem

			if __wf_atom_7e8ad928(mItem2) or not mItem2:IsA(mItem) then
				continue
			end

			self:RemoveElement(i)
		end
	end

	function v2:ValidateElement(p, p2, className)
		local mItem = p.mItem

		if self.mAllowDuplicates or __wf_atom_7e8ad928(className) or __wf_atom_7e8ad928(mItem) then
			return true
		end

		for i = 1, #self.mElements do
			local mElement = self.mElements[i]

			if mElement.Id == p2 then
				continue
			end

			local mItem2 = mElement.mItem
			local v3

			if not __wf_atom_7e8ad928(mElement.mStoreItem) then
				v3 = mElement.mStoreItem:__wf_atom_6a6ada7b() or nil
			end

			if not (mItem:IsA(v3) or not __wf_atom_7e8ad928(mItem2) and mItem2:IsA(className)) then
				continue
			end

			local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("/Lotus/Language/Items/GearMutuallyExclusive", false, {
				ITEMA = object:__wf_atom_8e9ac384(mItem2:__wf_atom_014a76a2():c_str(), false),
				ITEMB = object:__wf_atom_8e9ac384(mItem:__wf_atom_014a76a2():c_str(), false)
			})
			module.ShowMessage(__wf_atom_8e9ac384)
			return false
		end

		return true
	end

	function v2:RedrawFocusedElementText(p, count, cooldown)
		if p == nil then
			p = self.mDrawElements[self.mFocusedIndex]
		end

		if p == nil or self.mFocusedIndex ~= p.Id then
			return
		end

		local v3 = self.mFocusedIndex ~= self.mPrevFocusedElement
		local data = p.Data
		local mItem = data.mItem

		if count == nil then
			count = self:GetCount(p)
		end

		if cooldown == nil then
			cooldown = self:GetCooldown(mItem)

			if cooldown == 0 then
				return
			end
		end

		local mNameOverride = ""
		local v4 = ""
		local v5 = not __wf_atom_7e8ad928(mItem)

		if v5 then
			mNameOverride = mItem:__wf_atom_014a76a2():c_str()

			if cooldown > 0 then
				v4 = module2.SecondsToFormattedTime(object, math.ceil(cooldown), "Compact")
			else
				v4 = count
			end
		elseif data.mNameOverride then
			mNameOverride = data.mNameOverride
		elseif data.mInsertElementButton then
			mNameOverride = "/Lotus/Language/Menu/AddItemOfType"
		end

		local mFocusedIndex = self.mDragging and self.mFocusedIndex or data.Id

		if not data.mInsertElementButton then
			local v6 = tonumber(mFocusedIndex)

			if v6 ~= nil and self.mGear and not __wf_atom_7e8ad928(object2) and object2:__wf_atom_68fc1021() == 0 then
				local v7 = "<GEAR_HOTKEY_" .. v6 - 1 .. ">"
				local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(v7, true)

				if __wf_atom_8e9ac384 ~= v7 then
					local _ = v6 .. " " .. __wf_atom_8e9ac384
				end
			end
		end

		local v6 = self.mClipName .. ".GearInfo"
		local v7 = v6 .. ".Name"
		local v8 = v6 .. ".Count"
		local v9 = v6 .. ".Slot"
		local v10 = v6 .. ".Bg"
		local v11 = v6 .. ".StatEntry"
		local v12 = 0
		object:__wf_atom_e57658c2(v7, 44, _G.UIColor_Beige)
		object:__wf_atom_e57658c2(v8, 44, _G.UIColor_Beige)
		object:__wf_atom_e57658c2(v9, 44, _G.UIColor_Beige)

		local function fn()
			object:__wf_atom_e57658c2(v9, 50, 23)
			object:__wf_atom_e57658c2(v9, 1, -90)
			object:__wf_atom_2dedec1a(v11, 13, false)
			object:__wf_atom_2dedec1a(v11 .. 1, 13, false)
			object:__wf_atom_2dedec1a(v11 .. 2, 13, false)
		end

		if
			_T.FishingMode
			and p.Data ~= nil
			and p.Data.mItem ~= nil
			and p.Data.mItem:IsA(WeakResource("/SF/Types/Items/Consumables/Tackle/BaseFishingLure"))
		then
			object:__wf_atom_e57658c2(v9, 50, 18)
			local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(v9, 41)
			object:__wf_atom_e57658c2(v9, 1, -120 - __wf_atom_5e6e15c8 / 2)
			local mItem2 = p.Data.mItem
			local __wf_atom_e5aab704 = mItem2:__wf_atom_e5aab704()
			local __wf_atom_df7ce91d = mItem2:__wf_atom_df7ce91d()
			local v13 = __wf_atom_df7ce91d == 0 and ""
				or Localize("/SF/Language/Fish/FishingFamily" .. __wf_atom_df7ce91d, nil)
			local v14

			if __wf_atom_e5aab704 == nil or not (#__wf_atom_e5aab704 > 0) then
				v14 = __wf_atom_e5aab704 == nil and "" or __wf_atom_e5aab704
			else
				v14 = __wf_atom_e5aab704[1]:c_str()
			end

			local v15 = Localize(v14, nil)
			local v16 = {
				{
					LOC = Localize("/SF/Language/Fish/FishBiomeLabel", nil),
					VALUE = v15
				},
				{
					LOC = Localize("/SF/Language/Fish/FishFamilyLabel", nil),
					VALUE = v13
				}
			}

			if v15 == "" and v13 == "" then
				fn()
			else
				for i = 1, #v16 do
					local mStatsClip = self.mStatsClips[i]

					if self.mStatsClips[i] == nil then
						mStatsClip = v11 .. i

						if i == 1 then
							mStatsClip = v11
						else
							__wf_atom_86cbd68d(object, v11 .. ".duplicateMovieClip", "StatEntry" .. i, i)
						end

						self.mStatsClips[i] = mStatsClip
					end

					local v17 = v16[i].VALUE == nil and ""
						or "<p><font color=0xBCA783>" .. v16[i].VALUE .. "</font></p>"
					object:__wf_atom_2dedec1a(mStatsClip, 13, true)
					object:__wf_atom_50d60589(mStatsClip .. ".Label", 36, v17)
					local v18 = i <= 1 and 0 or object:__wf_atom_5e6e15c8(self.mStatsClips[i - 1], 15)
					object:__wf_atom_e57658c2(mStatsClip, 1, -120 + __wf_atom_5e6e15c8 + 40 + v18 / 2 * i)
				end
			end
		else
			fn()
		end

		local v13 = Localize(self.mTypeLoc, {})

		if self.mFocused then
			if data.mInsertElementButton then
				object:__wf_atom_50d60589(v9, 36, TitleCase(Localize(mNameOverride, { TYPE = v13 })))
			else
				object:__wf_atom_50d60589(v9, 36, TitleCase(Localize(mNameOverride, {})))
			end
		end

		local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(v7, 41)

		if self.mDescriptionOverrideCallback ~= nil then
			v4 = self.mDescriptionOverrideCallback(v4)
		end

		if v4 ~= nil and v4 ~= "" then
			v12 = object:__wf_atom_5e6e15c8(v8, 41)
			__wf_atom_5e6e15c8 += 10
		end

		math.max(object:__wf_atom_5e6e15c8(v7, 40), object:__wf_atom_5e6e15c8(v8, 40))
		local _ = math.floor(-(__wf_atom_5e6e15c8 + 0 + v12) / 2) + 0 + __wf_atom_5e6e15c8
		object:__wf_atom_e57658c2(v10, 14, 400)
		object:__wf_atom_e57658c2(v10, 15, 400)
		object:__wf_atom_2dedec1a(v10, 13, true)

		if v3 and self.mUpdateDescriptionCallback ~= nil then
			if v5 then
				self.mUpdateDescriptionCallback(mItem:__wf_atom_3a3d2e39():c_str())
			else
				self.mUpdateDescriptionCallback()
			end
		end

		self.mPrevFocusedElement = self.mFocusedIndex
	end

	function v2:RedrawElement(state, p)
		local mClipName = state.mClipName
		local data = state.Data
		local mItem = data.mItem
		local mIconOverride = data.mIconOverride
		local mIconWidthOverride = data.mIconWidthOverride or self.mInitIconWidth
		local mIconHeightOverride = data.mIconHeightOverride or self.mInitIconHeight
		local count = self:GetCount(state)
		local cooldown = self:GetCooldown(mItem)
		local v3 = self.mFocusedIndex == state.Id
		self:RedrawFocusedElementText(state, count, cooldown)
		local v4

		if __wf_atom_7e8ad928(mItem) or not __wf_atom_7e8ad928(mIconOverride) then
			v4 = false
		else
			mIconOverride, v4 = module4.GetIconTexture(mItem, true)
		end

		local v5 = 100
		local mIconMaterialOverride = nil

		if data.mInsertElementButton then
			object:__wf_atom_4c1c1986(mClipName, "Icon", 0, 4)
			v5 = 50
		else
			mIconMaterialOverride = data.mIconMaterialOverride or self.mIconMaterialOverride
			mIconWidthOverride = data.mIconWidthOverride or self.mIconWidthOverride or mIconWidthOverride
			mIconHeightOverride = data.mIconHeightOverride or self.mIconHeightOverride or mIconHeightOverride
		end

		if v4 then
			mIconWidthOverride = mIconHeightOverride
		end

		object:__wf_atom_933bbce0(mClipName .. ".Icon.Texture", mIconOverride, mIconMaterialOverride)
		local v6 = mIconWidthOverride * p
		local v7 = mIconHeightOverride * p
		object:__wf_atom_4c1c1986(mClipName, "Icon.Texture", 14, v6)
		object:__wf_atom_4c1c1986(mClipName, "Icon.Texture", 15, v7)
		object:__wf_atom_7f57ab2f(mClipName, "Icon", 13, not __wf_atom_7e8ad928(mIconOverride))

		if self.mDragging and v3 then
			object:__wf_atom_933bbce0(self.mClipName .. ".DragIcon.Texture", mIconOverride, mIconMaterialOverride)
			object:__wf_atom_4c1c1986(self.mClipName, "DragIcon.Texture", 14, v6 * 2.5)
			object:__wf_atom_4c1c1986(self.mClipName, "DragIcon.Texture", 15, v7 * 2.5)
		end

		local enabled = state.Enabled

		if enabled then
			if cooldown <= 0 then
				enabled = count ~= 0
			else
				enabled = false
			end
		end

		state.Enabled = enabled

		if not data.mApplyIconColor then
			object:__wf_atom_4c1c1986(mClipName, "Icon", 12, v5)
			return
		end

		object:__wf_atom_4c1c1986(mClipName, "Icon", 11, (module3.GetColor(v3 and 10 or 9, true)))
		object:__wf_atom_4c1c1986(mClipName, "Icon", 12, state.Enabled and v5 or self.mDisabledAlpha)
	end

	function v2:Redraw()
		local v3 = (self.mVisibleElements - 1) / 2
		local v4 = v3 * 2 - self.mCurrentOffset
		local v5 = #self.mElements
		local v6 = self.mVisibleElements + self.mOuterFade - v5
		local v7 = self.mVisibleElements + self.mInnerFade + 1
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v8, v9

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			v8 = false
			v9 = false
		else
			v8 = __wf_atom_c4f78a8f:__wf_atom_58dabbc7()
			v9 = not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_1cfa7bd2())
		end

		if Engine.IsPlayingWithController() then
			object:__wf_atom_7f57ab2f(self.mClipName, "DirectionIndicator.Arrow", 13, true)
		else
			object:__wf_atom_7f57ab2f(self.mClipName, "DirectionIndicator.Arrow", 13, false)
			object:__wf_atom_4c1c1986(self.mClipName, "DirectionIndicator.Arrow", 1, self.mRadius - 32)
		end

		for k, mDrawElement in pairs(self.mDrawElements) do
			local mClipName = mDrawElement.mClipName

			if mClipName == nil then
				continue
			end

			local data = mDrawElement.Data
			local gearIndex = data.GearIndex
			local mItem = data.mItem

			if __wf_atom_7e8ad928(mItem) and gearIndex and not __wf_atom_7e8ad928(object2) then
				mItem = object2:__wf_atom_ba1c3957(gearIndex, self.mConsumablesPage)
				data.mItem = mItem
			end

			local v10 = not __wf_atom_7e8ad928(mItem)
			local v11 = not v10 or mItem:IsA(__wf_atom_72bebce2)
			local v12 = v10 and mItem:IsA(__wf_atom_9ae7d6a1)
			local v13 = not __wf_atom_7e8ad928(mItem)
				and mItem:IsA(__wf_atom_72bebce2)
				and mItem:__wf_atom_de8272d7() == 1
			mDrawElement.Enabled = self.mEditMode

			if not mDrawElement.Enabled and not data.mLocked and (not v8 or v12 and v9) then
				if v12 then
					mDrawElement.Enabled = not self.mIsOperator or v10 and not mItem:__wf_atom_c23aaa0d()
				elseif v11 then
					local v14 = not self.mInHub or v10 and mItem:__wf_atom_bc111894()
					local v15 = not self.mIsOperator or v10 and mItem:__wf_atom_5701a88d()
					local v16 = not self.mIsVehicle or v10 and mItem:__wf_atom_5fe83802()
					local v17 = v10 and mItem:__wf_atom_bfb052a2()
					mDrawElement.Enabled = v14 and v15 and v16 and v17
				else
					mDrawElement.Enabled = true
				end
			end

			local v14 = mDrawElement.Id + v4
			local v15 = 90

			if v2.mUseSpiral then
				if self.mLooping or not __wf_atom_7e8ad928(self.mElements[mDrawElement.Id]) then
					if v14 < v3 then
						local v16 = v15 / (self.mOuterFade + 1)
						v15 -= v16 * (v3 - v14)

						if not self.mLooping then
							v15 = math.max(v15, (mDrawElement.Id + v6) * v16)
						end
					elseif v3 * 3 < v14 then
						local v16 = v15 / (self.mInnerFade + 1)
						v15 -= v16 * (v14 - v3 * 3)

						if not self.mLooping then
							v15 = math.max(v15, (v7 - mDrawElement.Id) * v16)
						end
					end
				else
					v15 = 0
				end
			else
				v15 = (mDrawElement.Id < 1 or mDrawElement.Id > self.mVisibleElements) and 0 or v15
			end

			if v15 <= 0 then
				__wf_atom_86cbd68d(object, mClipName .. ".removeMovieClip")
				self.mDrawElements[k] = nil
			else
				local v16 = self.mFocusedIndex == mDrawElement.Id
				local count = self:GetCount(mDrawElement)

				if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
					mDrawElement.IsPetItemNoPetSummon = v10
						and mItem:IsA(WeakResource("/SF/Types/Items/Consumables/PetConsumeables/BasePetFood"))
						and __wf_atom_c4f78a8f:__wf_atom_e919fb8e().PlayerWolfAvatar == nil
				end

				mDrawElement.DisableFocusVisual = v11 and count == 0 and true
					or not v10
					or mDrawElement.IsPetItemNoPetSummon

				if mDrawElement.DisableFocusVisual then
					v15 = math.min(v15, 40)
					v16 = false
				end

				object:__wf_atom_48bd5a59(mClipName, "Bg.Hotkey.Tf", 36, (tostring(mDrawElement.Id)))
				object:__wf_atom_4c1c1986(mClipName, "Bg.Hotkey.Tf", 12, 50)
				object:__wf_atom_7d7314f1(mClipName .. ".Bg.Callout.Tf.text", "<MENU_SELECT>")
				object:__wf_atom_7f57ab2f(mClipName, "Bg.Callout", 13, v16 and Engine.IsPlayingWithController())
				__wf_atom_86cbd68d(
					object,
					mClipName .. ".Bg.Highlight.gotoAndStop",
					module.Ternary(v16, "Focused", "Unfocused")
				)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Bg.Count.ItemCount",
					44,
					module.Ternary(v16, _G.UIColor_Black, _G.UIColor_White)
				)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Bg.Count.ItemCount",
					90,
					module.Ternary(v16, _G.UIColor_White, _G.UIColor_Black)
				)
				object:__wf_atom_7f57ab2f(mClipName, "Bg.Highlight.Glow", 13, v10 and v16)
				object:__wf_atom_7f57ab2f(mClipName, "Bg.Count", 13, v10)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Icon.LabelContainer.Label",
					44,
					module.Ternary(v16, _G.UIColor_Yellow, _G.UIColor_Tan)
				)
				object:__wf_atom_48bd5a59(mClipName, "Icon.LabelContainer.Label", 36, count)
				object:__wf_atom_7f57ab2f(
					mClipName,
					"Icon.LabelContainer",
					13,
					mDrawElement.Enabled and not v12 and not v13
				)
				local v17 = v14 + self.mElementOffset
				local rotation = mDrawElement.Id * self.mAngle + self.mRotationOffset
				mDrawElement.Rotation = rotation
				local v18 = rotation + 90
				local rad = module.ToRad(rotation)
				local rounded = module.Round(self.mInitialX + math.cos(rad) * self.mRadius)
				local rounded2 = module.Round(self.mInitialY + math.sin(rad) * self.mRadius)
				object:__wf_atom_e57658c2(mClipName, 0, rounded)
				object:__wf_atom_e57658c2(mClipName, 1, rounded2)
				local mSpiralWedgeScale = self.mSpiralWedgeScale
				local v19 = 1

				if self.mUseSpiral then
					__wf_atom_86cbd68d(object, mClipName .. ".swapDepths", -mDrawElement.Id)
					object:__wf_atom_e57658c2(mClipName, 4, v17 * v17 * 80)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 5, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 6, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBlurer", 5, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBlurer", 6, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeHighlight", 5, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeHighlight", 6, mSpiralWedgeScale)
					v18 += math.min(v17 * 0.3, 4)
				else
					object:__wf_atom_e57658c2(mClipName, 4, 0)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 5, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 6, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBlurer", 5, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBlurer", 6, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeHighlight", 5, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeHighlight", 6, 100)
					v19 = 100 / mSpiralWedgeScale
				end

				object:__wf_atom_e57658c2(mClipName, 16, v18)
				object:__wf_atom_4c1c1986(mClipName, "Bg.Callout", 16, -v18)
				object:__wf_atom_4c1c1986(mClipName, "Bg.Count", 16, -v18)
				object:__wf_atom_4c1c1986(mClipName, "Bg.Hotkey", 16, -v18)

				if not data.mInsertElementButton then
					object:__wf_atom_4c1c1986(mClipName, "Icon", 16, -v18)
				end

				object:__wf_atom_4c1c1986(mClipName, "Cooldown", 16, -v18)
				object:__wf_atom_c90af43a(mClipName .. ".WedgeBacker", self.mBackerTextureOverride)
				object:__wf_atom_c90af43a(mClipName .. ".WedgeBlurer", self.mBackerTextureOverride)
				object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 11, _G.UIColor_Beige)
				object:__wf_atom_7f57ab2f(mClipName, "WedgeHighlight", 13, v16 and self.mFocused)
				object:__wf_atom_c90af43a(mClipName .. ".WedgeHighlight", self.mHighlightTextureOverride)
				object:__wf_atom_2dedec1a(mClipName .. ".FirstItemMarker", 13, false)
				self:RedrawElement(mDrawElement, v19)

				if not mDrawElement.Enabled then
					v15 = self.mDisabledAlpha / 100 * v15
				end

				object:__wf_atom_e57658c2(mClipName, 12, v15)
			end
		end
	end

	function v2:Update(p)
		local mClipName = self.mClipName
		local mTrackingPos = nil
		local isPlayingWithController = Engine.IsPlayingWithController()
		local mForceUpdate = self.mForceUpdate or object:__wf_atom_1b848254(mClipName)

		if self.mTrackingPos == nil then
			mForceUpdate = true
			mTrackingPos = { X = 0, Y = 0 }
			self.mTrackingPos = { X = nil, Y = nil }

			if not isPlayingWithController then
				local v3 = object:__wf_atom_d5a50cb5() / 2
				local v4 = object:__wf_atom_c4f6543f() / 2
				local v5 = v3 + mTrackingPos.X
				local v6 = v4 + mTrackingPos.Y
				gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(v5, v6)
				__wf_atom_8e4fda44:__wf_atom_b005c93e(v5, v6)
			end
		else
			if isPlayingWithController then
				if module.GetDistanceBetweenPoints({ X = 0, Y = 0 }, self.mRightStick) > 0.2 then
					mTrackingPos = {
						X = self.mRightStick.X,
						Y = -self.mRightStick.Y
					}
					self.mDeadzoneCoyoteTimer = 0.3
				else
					self.mDeadzoneCoyoteTimer -= p
					mTrackingPos = { X = 0, Y = 0 }
				end
			elseif
				object:__wf_atom_5e6e15c8("_root", 30) ~= -1000
				and object:__wf_atom_5e6e15c8("_root", 31) ~= -1000
			then
				self.mDeadzoneCoyoteTimer = 0
				mTrackingPos = module.GetDistanceBetweenPoints({ X = 0, Y = 0 }, {
						X = object:__wf_atom_5e6e15c8(mClipName, 30),
						Y = object:__wf_atom_5e6e15c8(mClipName, 31)
					}) > self.mRadius - 75
					and {
						X = object:__wf_atom_5e6e15c8(mClipName, 30),
						Y = object:__wf_atom_5e6e15c8(mClipName, 31)
					}
					or { X = 0, Y = 0 }
			end

			if mTrackingPos ~= nil then
				local v3 = Vector(mTrackingPos.X, mTrackingPos.Y, 0)
				Normalize(v3)
				object:__wf_atom_4c1c1986(mClipName, "DragIcon", 0, v3.x * 300)
				object:__wf_atom_4c1c1986(mClipName, "DragIcon", 1, v3.y * 300)
			end
		end

		object:__wf_atom_7f57ab2f(mClipName, "DirArrow", 13, false)
		self.mForceUpdate = false
		local v3

		if mTrackingPos == nil then
			v3 = true
		else
			v3 = mTrackingPos.X ~= 0 or mTrackingPos.Y ~= 0

			if
				isPlayingWithController
				or self.mTrackingPos.X ~= mTrackingPos.X
				or self.mTrackingPos.Y ~= mTrackingPos.Y
			then
				if mTrackingPos.X == 0 and mTrackingPos.Y == 0 then
					if self.mDeadzoneCoyoteTimer <= 0 then
						self:UnfocusElement(self.mFocusedIndex)
					end
				else
					if not self.mFocused then
						self.mForceUpdate = true
					end

					local deg = module.ToDeg(module.GetAngleBetweenPoints(0, 0, mTrackingPos.Y, mTrackingPos.X))
					self:FocusElementInDirection(deg)
					object:__wf_atom_4c1c1986(mClipName, "DirArrow", 16, deg)
				end

				self.mTrackingPos = mTrackingPos
			end
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local mBlocked = __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
			or __wf_atom_c4f78a8f:__wf_atom_58dabbc7()
			or not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_1cfa7bd2())
			or __wf_atom_c4f78a8f:IsA(__wf_atom_72d5e8c0)
		local v4 = mForceUpdate or self.mBlocked ~= mBlocked
		self.mBlocked = mBlocked

		if not v4 then
			for _, mDrawElement in pairs(self.mDrawElements) do
				local data = mDrawElement.Data
				local mCooldownActive = self:GetCooldown(data.mItem) > 0

				if data.mCooldownActive == mCooldownActive then
					continue
				end

				data.mCooldownActive = mCooldownActive
				v4 = true
				break
			end
		end

		local mDragElement = self.mDragElement
		local v5 = mDragElement ~= nil

		if v5 then
			local mElement = self.mElements[mDragElement]

			if mElement == nil then
				v5 = false
			else
				v5 = not mElement.mInsertElementButton
			end

			if not v5 then
				self.mDragElement = nil
			end
		end

		if not v4 and self.mCurrentOffset == self.mFocusedIndex then
			self:RedrawFocusedElementText()
			return
		end

		local count = #self.mElements
		local v6 = (self.mVisibleElements - 1) / 2
		local v7 = 1
		local v8 = 360 / self.mAngle
		local mFocusedIndex = self.mFocusedIndex

		if not self.mLooping then
			if mFocusedIndex < 1 then
				mFocusedIndex = 1
			elseif count <= mFocusedIndex then
				if v5 and self.mElements[count].mInsertElementButton then
					mFocusedIndex = count - 1
				else
					mFocusedIndex = count
				end
			end

			self.mFocusedIndex = mFocusedIndex
		end

		if self.mUseSpiral then
			v7 = mFocusedIndex - v6 - self.mInnerFade
			v8 = mFocusedIndex + v6 + self.mOuterFade

			if not self.mLooping then
				local v9 = math.min(v7, self.mVisibleElements + self.mOuterFade - count + 1)
				local v10 = math.max(v8, self.mVisibleElements + self.mInnerFade)
				v7 = math.max(v9, 1)
				v8 = math.min(v10, count)
			end
		end

		if self.mShowDirection ~= self.mFocused then
			self.mShowDirection = not self.mFocused
			local v9 = { (module.Ternary(self.mShowDirection, 70, 0)) }
			__wf_atom_ec43d06e(object, mClipName .. ".DirectionIndicator", 2, { 12 }, v9, 0.15)
		end

		for i = v7, v8 do
			local v9 = (count + i - 1) % count + 1

			if v5 then
				if v9 == mFocusedIndex then
					v9 = mDragElement
				elseif v9 < mFocusedIndex and mDragElement <= v9 then
					v9 += 1
				elseif mFocusedIndex < v9 and v9 <= mDragElement then
					v9 -= 1
				end
			end

			local mElement = self.mElements[v9]
			local mDrawElement = self.mDrawElements[i]
			local v10 = mDrawElement == nil and {} or mDrawElement

			if v10.Data ~= mElement then
				v10.Id = i
				v10.mClipName = v .. i
				v10.Data = mElement
				self.mDrawElements[i] = v10

				if not object:__wf_atom_253d7085(v10.mClipName) then
					__wf_atom_86cbd68d(object, v .. ".duplicateMovieClip", "Item" .. i, 10000 + i)
				end
			end

			if i ~= mFocusedIndex then
				continue
			end

			if v3 then
				self:FocusElement(i)
			else
				self:UnfocusElement(i)
			end
		end

		if self.mCurrentOffset ~= mFocusedIndex and mFocusedIndex ~= nil then
			self.mCurrentOffset = __wf_atom_104bfe98(self.mCurrentOffset, mFocusedIndex, 0.1)

			if math.abs(self.mCurrentOffset - mFocusedIndex) < 0.05 then
				self.mCurrentOffset = mFocusedIndex
			end
		end

		self:Redraw()
	end

	function v2:Initialize()
		object:__wf_atom_2dedec1a(v, 13, false)
		object:__wf_atom_7f57ab2f(self.mClipName, "DragIcon", 13, false)
		object:__wf_atom_4c1c1986(self.mClipName, "DragIcon", 12, 75)
		object:__wf_atom_4c1c1986(self.mClipName, "DirectionIndicator", 12, 75)
		self:SetCallbacks("SpiralItemPressed", "SpiralItemFocused", "SpiralItemUnfocused")

		for i = 13, #self.mElements do
			local mItem = self.mElements[i].mItem
			local gearIndex = self.mElements[i].GearIndex

			if not __wf_atom_7e8ad928(mItem) or not gearIndex or __wf_atom_7e8ad928(object2) then
				continue
			end

			local __wf_atom_ba1c3957 = object2:__wf_atom_ba1c3957(gearIndex, self.mConsumablesPage)
			self.mElements[i].mItem = __wf_atom_ba1c3957
		end

		local v3 = self.mClipName .. ".GearInfo.Bg"
		object:__wf_atom_e57658c2(v3, 14, 400)
		object:__wf_atom_e57658c2(v3, 15, 400)
		object:__wf_atom_2dedec1a(v3, 13, true)
	end

	return v2
end