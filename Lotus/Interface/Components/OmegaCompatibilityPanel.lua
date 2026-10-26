module(..., package.seeall)
local v = WeakResource("/Lotus/Upgrades/Mods/Randomized/LotusRifleRandomModRare")
local v2 = WeakResource("/Lotus/Upgrades/Mods/Randomized/LotusShotgunRandomModRare")
local v3 = WeakResource("/Lotus/Upgrades/Mods/Randomized/LotusPistolRandomModRare")
local v4 = WeakResource("/Lotus/Upgrades/Mods/Randomized/PlayerMeleeWeaponRandomModRare")
local v5 = WeakResource("/Lotus/Upgrades/Mods/Randomized/LotusArchgunRandomModRare")
local v6 = WeakResource("/Lotus/Upgrades/Mods/Randomized/LotusModularMeleeRandomModRare")
local v7 = WeakResource("/Lotus/Upgrades/Mods/Randomized/LotusModularPistolRandomModRare")

function Create(mMovie, mClipName, mUpdateOmegaCallback2)
	local module = require("EE.Interface.Utilities")
	local module2 = require("Lotus.Interface.UIStyleUtilities")
	local module3 = require("Lotus.Interface.UIUtilities")
	local module4 = require("Lotus.Interface.StoreItemUtilities")
	local v8 = {
		mMovie = mMovie,
		mClipName = mClipName,
		mParentEnv = nil,
		mUpdateOmegaCallback = mUpdateOmegaCallback2,
		mCompatibleItems = {},
		mCurrentCompatibleIndex = 1,
		GetParentEnv = function(self)
			if self.mParentEnv ~= nil then
				return self.mParentEnv
			end

			local v8 = 1
			local mParentEnv

			repeat
				mParentEnv = getfenv(v8)
				v8 += 1
			until mParentEnv.mMovie

			self.mParentEnv = mParentEnv
			return mParentEnv
		end,
		HookUpCallbacks = function(self, _)
			assert(not self.mHookedUpCallbacks)
			self.mHookedUpCallbacks = true
			local parentEnv = self:GetParentEnv()

			function parentEnv.OmegaItemFocused(p)
				if not (self.mMovie:Execute("IsInputBlocked", "") or __wf_atom_7e8ad928(self.mGrid)) then
					self.mGrid:FocusElementById((tonumber(p)))
				end
			end

			function parentEnv.OmegaItemUnfocused(p)
				if not (self.mMovie:Execute("IsInputBlocked", "") or __wf_atom_7e8ad928(self.mGrid)) then
					self.mGrid:UnfocusElementById((tonumber(p)))
				end
			end

			function parentEnv.NextFitRollOver()
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "NextBtn", 11, self.mFloatingContentHighlight)
			end

			function parentEnv.NextFitRollOut()
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "NextBtn", 11, self.mFloatingContent)
			end

			function parentEnv.NextFitSelect()
				module.PlaySound(_G.UISound_Select)
				self.mCurrentCompatibleIndex = math.min(self.mCurrentCompatibleIndex + 1, #self.mCompatibleItems)
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "PrevBtn", 13, self.mCurrentCompatibleIndex > 1)
				self.mMovie:__wf_atom_7f57ab2f(
					self.mClipName,
					"NextBtn",
					13,
					self.mCurrentCompatibleIndex < #self.mCompatibleItems
				)
				self.mGrid:RemoveElements(true, true)
				self.mGrid:AddElement(self.mCompatibleItems[self.mCurrentCompatibleIndex])
				self.mGrid:Redraw(nil, true, true)
			end

			self.mMovie:SetCallbacks(
				self.mClipName .. ".NextBtn.Btn",
				"NextFitRollOver",
				"NextFitRollOut",
				"NextFitSelect",
				"NextFitPressed"
			)

			function parentEnv.PrevFitRollOver()
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "PrevBtn", 11, self.mFloatingContentHighlight)
			end

			function parentEnv.PrevFitRollOut()
				self.mMovie:__wf_atom_4c1c1986(self.mClipName, "PrevBtn", 11, self.mFloatingContent)
			end

			function parentEnv.PrevFitSelect()
				module.PlaySound(_G.UISound_Select)
				self.mCurrentCompatibleIndex = math.max(self.mCurrentCompatibleIndex - 1, 1)
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "PrevBtn", 13, self.mCurrentCompatibleIndex > 1)
				self.mMovie:__wf_atom_7f57ab2f(
					self.mClipName,
					"NextBtn",
					13,
					self.mCurrentCompatibleIndex < #self.mCompatibleItems
				)
				self.mGrid:RemoveElements(true, true)
				self.mGrid:AddElement(self.mCompatibleItems[self.mCurrentCompatibleIndex])
				self.mGrid:Redraw(nil, true, true)
			end

			self.mMovie:SetCallbacks(
				self.mClipName .. ".PrevBtn.Btn",
				"PrevFitRollOver",
				"PrevFitRollOut",
				"PrevFitSelect",
				"PrevFitPressed"
			)
		end,
		SetUpdateOmegaCallback = function(p, mUpdateOmegaCallback)
			p.mUpdateOmegaCallback = mUpdateOmegaCallback
		end,
		UpdateColors = function(self)
			self.mFloatingContent = module2.GetColor(9, true)
			self.mFloatingContentHighlight = module2.GetColor(10, true)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "Label", 44, self.mFloatingContent)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "NextBtn", 11, self.mFloatingContent)
			self.mMovie:__wf_atom_4c1c1986(self.mClipName, "PrevBtn", 11, self.mFloatingContent)
		end,
		BuildCompatibleList = function(self, instance, p, object)
			if
				__wf_atom_7e8ad928(instance)
				or __wf_atom_7e8ad928(p)
				or __wf_atom_7e8ad928(gGameData)
				or not instance:__wf_atom_ffb2b866(p)
			then
				return false
			end

			if __wf_atom_7e8ad928(object) then
				if not __wf_atom_7e8ad928(gGameRules) then
					object = gGameRules:__wf_atom_964056fd()
				end

				if __wf_atom_7e8ad928(object) then
					return false
				end
			end

			self.mCompatibleItems = {}
			local __wf_atom_1cdf1bf4 = instance:__wf_atom_1cdf1bf4(p)
			local inventory = gGameData:GetInventory()
			local v8 = nil

			if instance:IsA(v7) then
				v8 = inventory:__wf_atom_20b04548()
				local __wf_atom_4f67b86c = inventory:__wf_atom_4f67b86c()

				for _, v9 in ipairs(__wf_atom_4f67b86c) do
					table.insert(v8, v9)
				end
			elseif instance:IsA(v6) then
				v8 = inventory:__wf_atom_4259c789()
			end

			if #v8 > 0 then
				for _, itemInfo in ipairs(v8) do
					if __wf_atom_7e8ad928(itemInfo.mModularParts) then
						continue
					end

					local mModularParts = itemInfo.mModularParts

					for _, mModularPart in ipairs(mModularParts) do
						if not mModularPart:IsA(__wf_atom_1cdf1bf4) then
							continue
						end

						local __wf_atom_232fd31d = object:__wf_atom_232fd31d(itemInfo.mItemType)

						if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
							continue
						end

						local storeItemInfo = module4.GetStoreItemInfo(
							self.mMovie,
							__wf_atom_232fd31d,
							{ ItemInfo = itemInfo, GameData = gGameData },
							object,
							inventory,
							true
						)
						storeItemInfo.DefaultItemInfoTab = 2
						storeItemInfo.ShowDisposition = true
						storeItemInfo.ModularTip = __wf_atom_1cdf1bf4
						table.insert(self.mCompatibleItems, storeItemInfo)
						break
					end
				end
			else
				if instance:IsA(v) or instance:IsA(v2) then
					v8 = inventory:__wf_atom_4f67b86c()
					local __wf_atom_1273f04d = inventory:__wf_atom_1273f04d()

					for _, v9 in ipairs(__wf_atom_1273f04d) do
						v8[#v8 + 1] = v9
					end
				elseif instance:IsA(v3) then
					v8 = inventory:__wf_atom_20b04548()
				elseif instance:IsA(v4) then
					v8 = inventory:__wf_atom_4259c789()
					local __wf_atom_1273f04d = inventory:__wf_atom_1273f04d()

					for _, v9 in ipairs(__wf_atom_1273f04d) do
						v8[#v8 + 1] = v9
					end
				elseif instance:IsA(v5) then
					v8 = inventory:__wf_atom_546ac461()
				end

				if #v8 > 0 then
					for _, v9 in ipairs(v8) do
						local mItemType = v9.mItemType

						if not mItemType:IsA(__wf_atom_1cdf1bf4) then
							continue
						end

						local __wf_atom_232fd31d = object:__wf_atom_232fd31d(mItemType)

						if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
							continue
						end

						local storeItemInfo = module4.GetStoreItemInfo(
							self.mMovie,
							__wf_atom_232fd31d,
							{ GameData = gGameData },
							object,
							inventory,
							true
						)
						storeItemInfo.DefaultItemInfoTab = 2
						storeItemInfo.ShowDisposition = true
						table.insert(self.mCompatibleItems, storeItemInfo)
					end
				end
			end

			if #self.mCompatibleItems ~= 0 then
				return true
			end

			local __wf_atom_232fd31d = object:__wf_atom_232fd31d(__wf_atom_1cdf1bf4)

			if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
				return true
			end

			local storeItemInfo = module4.GetStoreItemInfo(
				self.mMovie,
				__wf_atom_232fd31d,
				{ GameData = gGameData },
				object,
				inventory,
				true
			)
			storeItemInfo.DefaultItemInfoTab = 2
			storeItemInfo.ShowDisposition = true
			table.insert(self.mCompatibleItems, storeItemInfo)
			return true
		end,
		SetupOmega = function(self, p, p2, p3)
			if not self:BuildCompatibleList(p, p2, p3) then
				return
			end

			if #self.mCompatibleItems > 0 then
				self.mGrid:AddElement(self.mCompatibleItems[1])
				self.mGrid:Redraw(nil, true)
				self.mMovie:__wf_atom_7f57ab2f(mClipName, "PrevBtn", 13, false)
				self.mMovie:__wf_atom_7f57ab2f(
					mClipName,
					"NextBtn",
					13,
					self.mCurrentCompatibleIndex < #self.mCompatibleItems
				)
				self.mMovie:__wf_atom_2dedec1a(mClipName, 13, true)
			end
		end
	}
	local module5 = require("Lotus.Interface.Components.CategorizedGrid")
	v8.mGrid = module5.CreateCategorizedGrid(v8.mMovie, mClipName .. ".Item", 1, 1)
	v8.mGrid:SetCallbacks(nil, "OmegaItemFocused", "OmegaItemUnfocused")
	v8.mGrid.mSelectedScale = 100
	v8.mGrid.ElementWidth = 160
	v8.mGrid.ElementHeight = 160

	function v8.mGrid.mOnFocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		module3.OnGridItemFocusChanged(v8.mMovie, v8.mGrid, p, {
			IsFocused = true,
			ShowInfoPopup = true,
			IgnoreCount = true
		})
	end

	function v8.mGrid.mOnUnfocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		module3.OnGridItemFocusChanged(v8.mMovie, v8.mGrid, p, {
			IsFocused = false,
			IgnoreCount = true
		})
	end

	function v8.mGrid.mClipCreatedCallback(p, _)
		module3.OnGridItemCreated(v8.mMovie, v8.mGrid, p)
	end

	function v8.mGrid.mElementDrawCallback(data)
		if data.mClipName == nil or __wf_atom_7e8ad928(gGameData) then
			return
		end

		local isFocused = data == v8.mGrid:GetFocusedElement()
		local v9 = {
			HideOwned = true,
			IsFiller = data.Filler or data.EmptySlot,
			IsFocused = isFocused,
			IgnoreCount = true
		}
		module3.DrawGridItem(v8.mMovie, v8.mGrid, data, v9)

		if not __wf_atom_7e8ad928(v8.mUpdateOmegaCallback) then
			v8.mUpdateOmegaCallback(data.Type, data.ModularTip)
		end
	end

	v8:UpdateColors()
	v8:HookUpCallbacks()
	v8.mMovie:__wf_atom_7d7314f1(mClipName .. ".Label.text", "/Lotus/Language/SystemMessages/ItemCompatibilityLabel")
	v8.mMovie:__wf_atom_2dedec1a(mClipName, 13, false)
	return v8
end