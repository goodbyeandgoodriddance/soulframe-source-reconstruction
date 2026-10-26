module(..., package.seeall)

function CreateGearList(object, mClipName2, object2)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.LotusUtilities")
	local module3 = require("Lotus.Interface.UIStyleUtilities")
	local module4 = require("Lotus.Interface.StoreItemUtilities")
	local v = mClipName2 .. ".Items.Item"
	local v2 = {
		MAX_RING_ITEMS = 12,
		mClipName = mClipName2,
		mUseSpiral = false,
		mShowInsertButton = false,
		mElements = {},
		mDrawElements = {},
		mForceUpdate = false,
		mEditMode = false,
		mInHub = false,
		mRadius = 265,
		mRotationOffset = -120.1
	}
	v2.mAngle = 360 / v2.MAX_RING_ITEMS
	v2.mInitialX = 0
	v2.mInitialY = 0
	v2.mFocusedElement = 1
	v2.mCurrentOffset = 1
	v2.mInnerFade = 3
	v2.mOuterFade = 3
	v2.mVisibleElements = v2.MAX_RING_ITEMS
	v2.mElementOffset = 6
	v2.mSpiralWedgeScale = 137
	v2.mDisabledAlpha = 40
	v2.mAllowDuplicates = false
	v2.mTrackingPos = nil
	v2.mLeftStick = { X = 0, Y = 0 }
	v2.mTypeLoc = "/Lotus/Language/Menu/Store_New"
	v2.mInitIconWidth = object:__wf_atom_5e6e15c8(v .. ".Icon.Texture", 14)
	v2.mInitIconHeight = object:__wf_atom_5e6e15c8(v .. ".Icon.Texture", 15)
	v2.mUnfocusedScale = object:__wf_atom_5e6e15c8(v .. ".Icon", 5)
	v2.CollectorScannerType = WeakResource("/Lotus/Types/Restoratives/Consumable/LibraryScanner")
	v2.SyringeType = WeakResource("/Lotus/Types/Restoratives/Consumable/InfestedSyringe")
	v2.AntidoteType = WeakResource("/Lotus/Types/PickUps/RaidInfestedAntidoteItem")
	v2.CollectorScannerRechargeUpgradeType = WeakResource("/Lotus/Types/Items/MiscItems/LibraryScannerRechargeUpgrade")
	v2.GlyphConsumableType = WeakResource("/Lotus/Types/Restoratives/Consumable/GlyphConsumable")
	v2.GlyphNoConsumeType = WeakResource("/Lotus/Types/Restoratives/Consumable/GlyphConsumableNoCharges")
	v2.MiningLaserType = WeakResource("/Lotus/Types/Restoratives/Consumable/MiningLaser")
	v2.MultiToolType = WeakResource("/Lotus/Types/Restoratives/Consumable/RepairTool")
	v2.SpearFishingSpearType = WeakResource("/Lotus/Types/Restoratives/Consumable/BaseSpearFishingSpear")
	v2.ArchwingSummonType = WeakResource("/Lotus/Types/Restoratives/OpenArchwingSummon")
	v2.HoverboardSummonType = WeakResource("/Lotus/Types/Restoratives/HoverboardSummon")
	v2.MechSummonType = WeakResource("/Lotus/Types/Restoratives/LoadoutTechSummon")
	v2.HeavyWeaponSummonType = WeakResource("/Lotus/Types/Restoratives/HeavyWeaponSummon")
	v2.CrewmateBallType = WeakResource("/Lotus/Types/Restoratives/Consumable/CrewmateBall")
	v2.BaseHuntingGearItemType = WeakResource("/Lotus/Types/Restoratives/Conservation/BaseHuntingGearItem")
	v2.BaseHuntingAccessoryType = WeakResource("/Lotus/Types/Restoratives/Conservation/BaseHuntingAccessoryGearItem")
	v2.FairyFlightAcType = WeakResource("/Lotus/Powersuits/Fairy/FairyFlightAnimController")
	v2.ReaperType = WeakResource("/Lotus/Powersuits/Wraith/ReaperBaseSuit")
	v2.InstrumentType = WeakResource("/Lotus/Types/Items/Emotes/ShawzinEmote")
	v2.DefaultGlyphIcon = WeakResource("/Lotus/Interface/Icons/Player/LotusSymbol.png")

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
				mItem = object2:__wf_atom_ba1c3957(gearIndex)
			end

			count = object2:__wf_atom_b62f2024(gearIndex)
		end

		if __wf_atom_7e8ad928(mItem) then
			return count
		end

		if mItem:IsA(__wf_atom_72bebce2) and mItem:__wf_atom_2cbbab92() then
			count = math.max(0, count - 1)
		end

		if data.HasRechargeUpgrade == nil then
			local isA = mItem:IsA(v2.CollectorScannerType)

			if
				isA
				or mItem:IsA(v2.GlyphNoConsumeType)
				or mItem:IsA(v2.MiningLaserType)
				or mItem:IsA(v2.MultiToolType)
				or mItem:IsA(v2.SpearFishingSpearType)
				or mItem:IsA(v2.ArchwingSummonType)
				or mItem:IsA(v2.HoverboardSummonType)
				or mItem:IsA(v2.MechSummonType)
				or mItem:IsA(v2.HeavyWeaponSummonType)
				or mItem:IsA(v2.CrewmateBallType)
				or mItem:IsA(v2.BaseHuntingGearItemType) and not mItem:IsA(v2.BaseHuntingAccessoryType)
			then
				if isA then
					if not __wf_atom_7e8ad928((__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))) then
						local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()

						if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
							local __wf_atom_c84817dd = __wf_atom_9be88b01:GetInventory():__wf_atom_c84817dd()
							local hasRechargeUpgrade = false

							for _, v3 in ipairs(__wf_atom_c84817dd) do
								if not (v3.mItemCount > 0 and v3.mItemType == v2.CollectorScannerRechargeUpgradeType) then
									continue
								end

								hasRechargeUpgrade = true
								break
							end

							data.HasRechargeUpgrade = hasRechargeUpgrade
						end
					end
				else
					data.HasRechargeUpgrade = true
				end
			else
				data.HasRechargeUpgrade = false
			end
		end

		if data.HasRechargeUpgrade and count ~= 0 then
			return (object:__wf_atom_8e9ac384("<INFINITE>", true))
		end

		if mItem:IsA(v2.SyringeType) and not __wf_atom_7e8ad928(object2) then
			count = object2:__wf_atom_c9e583ca(v2.AntidoteType)
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
		return p.mFocusedElement
	end

	function v2.GetFocusedElement(p)
		return p.mDrawElements[p.mFocusedElement]
	end

	function v2:FocusElement(mFocusedElement)
		self.mFocusedElement = mFocusedElement

		if self.mDrawElements[mFocusedElement] then
			__wf_atom_ec43d06e(
				object,
				self.mDrawElements[mFocusedElement].mClipName .. ".Icon",
				2,
				{ 5, 6 },
				{ self.mUnfocusedScale * 1.35, self.mUnfocusedScale * 1.35 },
				0.25
			)
		end

		if not __wf_atom_7e8ad928(self.mOnFocusedCallback) then
			self.mOnFocusedCallback(self.mDrawElements[mFocusedElement])
		end
	end

	function v2:UnfocusElement(p)
		if self.mDrawElements[p] ~= nil and self.mDrawElements[p].mClipName ~= nil then
			__wf_atom_ec43d06e(
				object,
				self.mDrawElements[p].mClipName .. ".Icon",
				2,
				{ 5, 6 },
				{ self.mUnfocusedScale, self.mUnfocusedScale },
				0.15
			)
		end

		object:__wf_atom_50d60589("GearWheel.GearName", 36, "")
		object:__wf_atom_50d60589("GearWheel.GearDesc", 36, "")
		object:__wf_atom_2dedec1a("GearWheel.InfoBg", 13, false)
	end

	function v2:SelectElement(mSelectedElement)
		self.mSelectedElement = mSelectedElement
		module.PlaySound(_G.UISound_ButtonSelect)

		if not __wf_atom_7e8ad928(self.mOnSelectedCallback) then
			self.mOnSelectedCallback(self.mDrawElements[mSelectedElement])
		end
	end

	function v2:FocusElementInDirection(p)
		local v3 = (p + 270) % 360
		local v4 = 360
		local v5 = nil

		for _, mDrawElement in pairs(self.mDrawElements) do
			local id = mDrawElement.Id

			if not (not self.mUseSpiral or self.mFocusedElement - 2 <= id and id <= self.mFocusedElement + 2) then
				continue
			end

			local v6 = v2.mUseSpiral and 4 or 0
			local v7 = (object:__wf_atom_5e6e15c8(mDrawElement.mClipName, 16) + 180 - v6) % 360
			local v8 = math.min(math.abs(v3 - v7), (math.abs(v3 + 360 - v7)))

			if not (v8 < v4) then
				continue
			end

			v5 = id
			v4 = v8
		end

		if self.mFocusedElement ~= nil and v5 ~= self.mFocusedElement then
			self:UnfocusElement(self.mFocusedElement)
		end

		if v5 ~= nil and v5 ~= self.mFocusedElement then
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
				local __wf_atom_ba1c3957 = object2:__wf_atom_ba1c3957(i)

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
				self.mRadius = 360
				self.mRotationOffset = -124
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
			p = self.mDrawElements[self.mFocusedElement]
		end

		if p == nil or self.mFocusedElement ~= p.Id then
			return
		end

		local v3 = self.mFocusedElement ~= self.mPrevFocusedElement
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

		local mNameOverride = "/Lotus/Language/Menu/Arsenal_None"
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

		local mFocusedElement = self.mDragging and self.mFocusedElement or data.Id
		local slot

		if data.mInsertElementButton then
			slot = ""
		else
			slot = tonumber(mFocusedElement)

			if slot ~= nil and self.mGear and not __wf_atom_7e8ad928(object2) and object2:__wf_atom_68fc1021() == 0 then
				local v6 = "<GEAR_HOTKEY_" .. slot - 1 .. ">"
				local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(v6, true)

				if __wf_atom_8e9ac384 ~= v6 then
					slot ..= " " .. __wf_atom_8e9ac384
				end
			end
		end

		local v6 = self.mClipName .. ".GearInfo"
		local v7 = v6 .. ".Name"
		local v8 = v6 .. ".Count"
		local v9 = v6 .. ".Slot"
		local v10 = v6 .. ".Bg"
		local v11 = 0
		local v12 = 0

		if slot == nil or slot == "" then
			object:__wf_atom_50d60589(v9, 36, "")
		else
			object:__wf_atom_50d60589(v9, 36, Localize("/Lotus/Language/Menu/SlotId", {
				SLOT = slot
			}))
			v11 = object:__wf_atom_5e6e15c8(v9, 41) + 10
		end

		local v13 = Localize(self.mTypeLoc, {})

		if data.mInsertElementButton then
			object:__wf_atom_50d60589(v7, 36, TitleCase(Localize(mNameOverride, { TYPE = v13 })))
		else
			object:__wf_atom_50d60589(v7, 36, TitleCase(Localize(mNameOverride, {})))
		end

		local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(v7, 41)

		if self.mDescriptionOverrideCallback ~= nil then
			v4 = self.mDescriptionOverrideCallback(v4)
		end

		object:__wf_atom_50d60589(v8, 36, Localize(v4, {}))

		if v4 == nil or v4 == "" then
			object:__wf_atom_e57658c2(v7, 1, -16)
		else
			object:__wf_atom_e57658c2(v7, 1, -36)
			v12 = object:__wf_atom_5e6e15c8(v8, 41)
			__wf_atom_5e6e15c8 += 10
		end

		local v14 = math.max(object:__wf_atom_5e6e15c8(v7, 40), object:__wf_atom_5e6e15c8(v8, 40))
		local v15 = v11 + __wf_atom_5e6e15c8 + v12
		local v16 = math.floor(-v15 / 2)
		object:__wf_atom_e57658c2(v9, 1, v16)
		local v17 = v16 + v11
		object:__wf_atom_e57658c2(v7, 1, v17)
		object:__wf_atom_e57658c2(v8, 1, v17 + __wf_atom_5e6e15c8)
		object:__wf_atom_e57658c2(v10, 14, v14 + 200)
		object:__wf_atom_e57658c2(v10, 15, v15 + 150)
		object:__wf_atom_2dedec1a(v10, 13, true)

		if v3 and self.mUpdateDescriptionCallback ~= nil then
			if v5 then
				self.mUpdateDescriptionCallback(mItem:__wf_atom_3a3d2e39():c_str())
			else
				self.mUpdateDescriptionCallback()
			end
		end

		self.mPrevFocusedElement = self.mFocusedElement
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
		local v3 = false
		local v4 = self.mFocusedElement == state.Id
		self:RedrawFocusedElementText(state, count, cooldown)

		if not __wf_atom_7e8ad928(mItem) then
			if
				mItem:IsA(__wf_atom_72bebce2)
				and (mItem:IsA(self.GlyphConsumableType) or mItem:IsA(self.GlyphNoConsumeType))
			then
				v3 = true
				mIconOverride = self.DefaultGlyphIcon
				local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

				if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
					local __wf_atom_a6382ae5 = __wf_atom_eab484a7:__wf_atom_a4299765():__wf_atom_a6382ae5()

					if not (__wf_atom_7e8ad928(__wf_atom_a6382ae5) or __wf_atom_7e8ad928(__wf_atom_a6382ae5.mItemType)) then
						local v5 = Resource(__wf_atom_a6382ae5.mItemType)

						if not __wf_atom_7e8ad928(v5) then
							mIconOverride = v5:GetIconTexture()
						end
					end
				end
			end

			if __wf_atom_7e8ad928(mIconOverride) then
				mIconOverride, v3 = module4.GetIconTexture(mItem, true)
			end
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

		if v3 then
			mIconWidthOverride = mIconHeightOverride
		end

		object:__wf_atom_933bbce0(mClipName .. ".Icon.Texture", mIconOverride, mIconMaterialOverride)
		local v6 = mIconWidthOverride * p
		local v7 = mIconHeightOverride * p
		object:__wf_atom_4c1c1986(mClipName, "Icon.Texture", 14, v6)
		object:__wf_atom_4c1c1986(mClipName, "Icon.Texture", 15, v7)
		object:__wf_atom_7f57ab2f(mClipName, "Icon", 13, not __wf_atom_7e8ad928(mIconOverride))

		if self.mDragging and v4 then
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

		if data.mApplyIconColor then
			object:__wf_atom_4c1c1986(mClipName, "Icon", 11, (module3.GetColor(v4 and 10 or 9, true)))
			object:__wf_atom_4c1c1986(mClipName, "Icon", 12, state.Enabled and v5 or self.mDisabledAlpha)
		else
			object:__wf_atom_4c1c1986(
				mClipName,
				"Icon",
				11,
				state.Enabled and _G.UIColor_White or _G.UIColor_MediumGrey
			)
			object:__wf_atom_4c1c1986(mClipName, "Icon", 12, v5)
		end
	end

	function v2:Redraw()
		local v3 = (self.mVisibleElements - 1) / 2
		local v4 = v3 * 2 - self.mCurrentOffset
		local v5 = #self.mElements
		local v6 = self.mVisibleElements + self.mOuterFade - v5
		local v7 = self.mVisibleElements + self.mInnerFade + 1
		local v8 = false
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v9, v10, v11

		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			v9 = false
			v10 = false
			v11 = false
		else
			v9 = __wf_atom_c4f78a8f:__wf_atom_58dabbc7()
			v10 = not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_1cfa7bd2())
			local __wf_atom_6c2fc5cb = __wf_atom_c4f78a8f:__wf_atom_6c2fc5cb()

			if not __wf_atom_7e8ad928(__wf_atom_6c2fc5cb) then
				v8 = __wf_atom_6c2fc5cb:IsA(self.FairyFlightAcType)
			end

			local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
			v11 = not __wf_atom_7e8ad928(__wf_atom_e55d02aa) and __wf_atom_e55d02aa:IsA(self.ReaperType)
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
				mItem = object2:__wf_atom_ba1c3957(gearIndex)
				data.mItem = mItem
			end

			local v12 = not __wf_atom_7e8ad928(mItem)
			local v13 = not v12 or mItem:IsA(__wf_atom_72bebce2)
			local v14 = v12 and mItem:IsA(__wf_atom_9ae7d6a1)
			mDrawElement.Enabled = self.mEditMode

			if not mDrawElement.Enabled and not data.mLocked and (not v9 or v14 and v10) then
				if v14 then
					local v15 = not self.mIsOperator or v12 and not mItem:__wf_atom_c23aaa0d()
					local v16 = not v8 or v12 and not mItem:IsA(self.InstrumentType)
					mDrawElement.Enabled = v15 and v16 and not v11
				elseif v13 then
					local v15 = not self.mInHub or v12 and mItem:__wf_atom_bc111894()
					local v16 = not self.mIsOperator or v12 and mItem:__wf_atom_5701a88d()
					local v17 = not self.mIsVehicle or v12 and mItem:__wf_atom_5fe83802()
					local v18 = v12 and mItem:__wf_atom_bfb052a2()
					mDrawElement.Enabled = v15 and v16 and v17 and not v11 and v18
				else
					mDrawElement.Enabled = not v11
				end
			end

			local v15 = mDrawElement.Id + v4
			local v16 = 100

			if v2.mUseSpiral then
				if self.mLooping or not __wf_atom_7e8ad928(self.mElements[mDrawElement.Id]) then
					if v15 < v3 then
						local v17 = v16 / (self.mOuterFade + 1)
						v16 -= v17 * (v3 - v15)

						if not self.mLooping then
							v16 = math.max(v16, (mDrawElement.Id + v6) * v17)
						end
					elseif v3 * 3 < v15 then
						local v17 = v16 / (self.mInnerFade + 1)
						v16 -= v17 * (v15 - v3 * 3)

						if not self.mLooping then
							v16 = math.max(v16, (v7 - mDrawElement.Id) * v17)
						end
					end
				else
					v16 = 0
				end
			else
				v16 = (mDrawElement.Id < 1 or mDrawElement.Id > self.mVisibleElements) and 0 or v16
			end

			if v16 <= 0 then
				__wf_atom_86cbd68d(object, mClipName .. ".removeMovieClip")
				self.mDrawElements[k] = nil
			else
				local v17 = self.mFocusedElement == mDrawElement.Id
				object:__wf_atom_48bd5a59(mClipName, "Bg.Hotkey.Tf", 36, (tostring(mDrawElement.Id)))
				object:__wf_atom_4c1c1986(mClipName, "Bg.Hotkey.Tf", 12, 50)
				object:__wf_atom_7d7314f1(mClipName .. ".Bg.Callout.Tf.text", "<MENU_SELECT>")
				object:__wf_atom_7f57ab2f(mClipName, "Bg.Callout", 13, v17 and Engine.IsPlayingWithController())
				__wf_atom_86cbd68d(
					object,
					mClipName .. ".Bg.Highlight.gotoAndStop",
					module.Ternary(v17, "Focused", "Unfocused")
				)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Bg.Count.ItemCount",
					44,
					module.Ternary(v17, _G.UIColor_Black, _G.UIColor_White)
				)
				object:__wf_atom_4c1c1986(
					mClipName,
					"Bg.Count.ItemCount",
					90,
					module.Ternary(v17, _G.UIColor_White, _G.UIColor_Black)
				)
				object:__wf_atom_7f57ab2f(mClipName, "Bg.Highlight.Glow", 13, v12 and v17)
				object:__wf_atom_7f57ab2f(mClipName, "Bg.Count", 13, v12)
				object:__wf_atom_48bd5a59(mClipName, "LabelContainer.Label", 36, "")
				local v18 = v15 + self.mElementOffset
				local rotation = mDrawElement.Id * self.mAngle + self.mRotationOffset
				mDrawElement.Rotation = rotation
				local v19 = rotation + 90
				local rad = module.ToRad(rotation)
				local rounded = module.Round(self.mInitialX + math.cos(rad) * self.mRadius)
				local rounded2 = module.Round(self.mInitialY + math.sin(rad) * self.mRadius)
				object:__wf_atom_e57658c2(mClipName, 0, rounded)
				object:__wf_atom_e57658c2(mClipName, 1, rounded2)
				local mSpiralWedgeScale = self.mSpiralWedgeScale
				local v20 = 1

				if self.mUseSpiral then
					__wf_atom_86cbd68d(object, mClipName .. ".swapDepths", -mDrawElement.Id)
					object:__wf_atom_e57658c2(mClipName, 4, v18 * v18 * 80)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 5, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 6, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBlurer", 5, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBlurer", 6, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeHighlight", 5, mSpiralWedgeScale)
					object:__wf_atom_4c1c1986(mClipName, "WedgeHighlight", 6, mSpiralWedgeScale)
					v19 += math.min(v18 * 0.3, 4)
				else
					object:__wf_atom_e57658c2(mClipName, 4, 0)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 5, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 6, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBlurer", 5, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeBlurer", 6, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeHighlight", 5, 100)
					object:__wf_atom_4c1c1986(mClipName, "WedgeHighlight", 6, 100)
					v20 = 100 / mSpiralWedgeScale
				end

				object:__wf_atom_e57658c2(mClipName, 16, v19)
				object:__wf_atom_4c1c1986(mClipName, "Bg.Callout", 16, -v19)
				object:__wf_atom_4c1c1986(mClipName, "Bg.Count", 16, -v19)
				object:__wf_atom_4c1c1986(mClipName, "Bg.Hotkey", 16, -v19)

				if not data.mInsertElementButton then
					object:__wf_atom_4c1c1986(mClipName, "Icon", 16, -v19)
				end

				object:__wf_atom_4c1c1986(mClipName, "Cooldown", 16, -v19)
				object:__wf_atom_4c1c1986(mClipName, "LabelContainer", 16, -v19)
				object:__wf_atom_c90af43a(mClipName .. ".WedgeBacker", self.mBackerTextureOverride)
				object:__wf_atom_c90af43a(mClipName .. ".WedgeBlurer", self.mBackerTextureOverride)
				object:__wf_atom_4c1c1986(mClipName, "WedgeBacker", 11, module3.GetColor(2, true))
				object:__wf_atom_7f57ab2f(mClipName, "WedgeHighlight", 13, mDrawElement.Id == self.mFocusedElement)
				object:__wf_atom_c90af43a(mClipName .. ".WedgeHighlight", self.mHighlightTextureOverride)
				object:__wf_atom_4c1c1986(mClipName, "WedgeHighlight", 11, module3.GetColor(10, true))
				local v21 = self.mUseSpiral
					and (self.mEditMode and mDrawElement.Id == 1 and true or not self.mEditMode and data.Id == 1)
				local v22 = mClipName .. ".FirstItemMarker"
				object:__wf_atom_2dedec1a(v22, 13, v21)

				if v21 then
					object:__wf_atom_c90af43a(v22, self.mMarkerTextureOverride)
					object:__wf_atom_e57658c2(v22, 11, module3.GetColor(10, true))
					object:__wf_atom_e57658c2(v22, 0, -41.7)
					object:__wf_atom_e57658c2(v22, 1, -37)
					object:__wf_atom_e57658c2(v22, 5, 125)
					object:__wf_atom_e57658c2(v22, 6, 125)
					object:__wf_atom_e57658c2(v22, 16, -13.7)
				end

				self:RedrawElement(mDrawElement, v20)

				if not mDrawElement.Enabled then
					v16 = self.mDisabledAlpha / 100 * v16
				end

				object:__wf_atom_e57658c2(mClipName, 12, v16)
			end
		end
	end

	function v2:Update(_)
		local mClipName = self.mClipName
		local v3 = nil
		local isPlayingWithController = Engine.IsPlayingWithController()
		local mForceUpdate = self.mForceUpdate or object:__wf_atom_1b848254(mClipName)
		local mTrackingPos

		if self.mTrackingPos == nil then
			mForceUpdate = true
			mTrackingPos = { X = 0, Y = -200 }
			self.mTrackingPos = { X = 0, Y = 0 }

			if not isPlayingWithController then
				local v4 = object:__wf_atom_d5a50cb5() / 2
				local v5 = object:__wf_atom_c4f6543f() / 2
				local v6 = v4 + mTrackingPos.X
				local v7 = v5 + mTrackingPos.Y
				gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(v6, v7)
				__wf_atom_8e4fda44:__wf_atom_b005c93e(v6, v7)
			end
		else
			if isPlayingWithController then
				mTrackingPos = module.GetDistanceBetweenPoints({ X = 0, Y = 0 }, self.mLeftStick) > 0.2 and {
					X = self.mLeftStick.X,
					Y = -self.mLeftStick.Y
				} or v3
			else
				mTrackingPos = object:__wf_atom_5e6e15c8("_root", 30) ~= -1000
					and object:__wf_atom_5e6e15c8("_root", 31) ~= -1000
					and {
						X = object:__wf_atom_5e6e15c8(mClipName, 30),
						Y = object:__wf_atom_5e6e15c8(mClipName, 31)
					}
					or v3
			end

			if mTrackingPos ~= nil then
				local v4 = Vector(mTrackingPos.X, mTrackingPos.Y, 0)
				Normalize(v4)
				object:__wf_atom_4c1c1986(mClipName, "DragIcon", 0, v4.x * 300)
				object:__wf_atom_4c1c1986(mClipName, "DragIcon", 1, v4.y * 300)
			end
		end

		object:__wf_atom_7f57ab2f(mClipName, "DirArrow", 13, false)

		if
			mTrackingPos ~= nil
			and (isPlayingWithController or self.mTrackingPos.X ~= mTrackingPos.X or self.mTrackingPos.Y ~= mTrackingPos.Y)
		then
			local deg = module.ToDeg(module.GetAngleBetweenPoints(0, 0, mTrackingPos.Y, mTrackingPos.X))
			self:FocusElementInDirection(deg)
			object:__wf_atom_4c1c1986(mClipName, "DirArrow", 16, deg)
			self.mTrackingPos = mTrackingPos
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

		if not v4 and self.mCurrentOffset == self.mFocusedElement then
			self:RedrawFocusedElementText()
			return
		end

		self.mForceUpdate = false
		local count = #self.mElements
		local v6 = (self.mVisibleElements - 1) / 2
		local v7 = 1
		local v8 = 360 / self.mAngle
		local mFocusedElement = self.mFocusedElement

		if not self.mLooping then
			if mFocusedElement < 1 then
				mFocusedElement = 1
			elseif count <= mFocusedElement then
				if v5 and self.mElements[count].mInsertElementButton then
					mFocusedElement = count - 1
				else
					mFocusedElement = count
				end
			end

			self.mFocusedElement = mFocusedElement
		end

		if self.mUseSpiral then
			v7 = mFocusedElement - v6 - self.mInnerFade
			v8 = mFocusedElement + v6 + self.mOuterFade

			if not self.mLooping then
				local v9 = math.min(v7, self.mVisibleElements + self.mOuterFade - count + 1)
				local v10 = math.max(v8, self.mVisibleElements + self.mInnerFade)
				v7 = math.max(v9, 1)
				v8 = math.min(v10, count)
			end
		end

		for i = v7, v8 do
			local v9 = (count + i - 1) % count + 1

			if v5 then
				if v9 == mFocusedElement then
					v9 = mDragElement
				elseif v9 < mFocusedElement and mDragElement <= v9 then
					v9 += 1
				elseif mFocusedElement < v9 and v9 <= mDragElement then
					v9 -= 1
				end
			end

			local mElement = self.mElements[v9]
			local mDrawElement = self.mDrawElements[i]
			local v10 = mDrawElement == nil and {} or mDrawElement

			if v10.Data == mElement then
				continue
			end

			v10.Id = i
			v10.mClipName = v .. i
			v10.Data = mElement
			self.mDrawElements[i] = v10

			if not object:__wf_atom_253d7085(v10.mClipName) then
				__wf_atom_86cbd68d(object, v .. ".duplicateMovieClip", "Item" .. i, 10000 + i)
			end

			if i == mFocusedElement then
				self:FocusElement(i)
			end
		end

		if self.mCurrentOffset ~= mFocusedElement then
			self.mCurrentOffset = __wf_atom_104bfe98(self.mCurrentOffset, mFocusedElement, 0.1)

			if math.abs(self.mCurrentOffset - mFocusedElement) < 0.05 then
				self.mCurrentOffset = mFocusedElement
			end
		end

		self:Redraw()
	end

	function v2:Initialize()
		object:__wf_atom_2dedec1a(v, 13, false)
		object:__wf_atom_7f57ab2f(self.mClipName, "DragIcon", 13, false)
		object:__wf_atom_4c1c1986(self.mClipName, "DragIcon", 12, 75)
		self:SetCallbacks("SpiralItemPressed", "SpiralItemFocused", "SpiralItemUnfocused")

		for i = 13, #self.mElements do
			local mItem = self.mElements[i].mItem
			local gearIndex = self.mElements[i].GearIndex

			if not __wf_atom_7e8ad928(mItem) or not gearIndex or __wf_atom_7e8ad928(object2) then
				continue
			end

			local __wf_atom_ba1c3957 = object2:__wf_atom_ba1c3957(gearIndex)
			self.mElements[i].mItem = __wf_atom_ba1c3957
		end
	end

	return v2
end