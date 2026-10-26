module(..., package.seeall)
local module = require("Lotus.Interface.Libs.DioramaLoader")
local v = WeakResource("/Lotus/Types/Player/TennoActionFigureLoadoutAvatar")
local v2 = WeakResource("/Lotus/Types/Enemies/Orokin/Entrati/EntratiTech/EntratiTechAvatar")
local v3 = {
	{
		EnemyType = WeakResource("/Lotus/Types/Enemies/Grineer/Forest/Avatars/EliteRifleLancerAvatar"),
		AttachmentsToDestroy = {
			WeakResource("/Lotus/Characters/Grineer/Marine/GrineerMaskDeco"),
			WeakResource("/Lotus/Characters/Grineer/Marine/DesertGrineerShoulderClothDeco"),
			WeakResource("/Lotus/Characters/Grineer/Marine/Ponytail/GrineerLoinClothAttachment")
		}
	},
	{
		EnemyType = WeakResource("/Lotus/Types/Enemies/SpaceBattles/Corpus/CrewMan/JetpackMarineAvatar"),
		AttachmentsToDestroy = {
			WeakResource("/Lotus/Fx/Enemies/Corpus/SpaceJetpack/ThrusterJetsSpawner"),
			WeakResource("/Lotus/Fx/Enemies/JetPackMarine/ThrusterLight"),
			WeakResource("/Lotus/Sounds/Enemies/GrineerJetPackMarine/GrineerJetPackLiftOffSeq"),
			WeakResource("/Lotus/Sounds/Enemies/CorpusJetpack/CorpusJetpackFlightLoopSeq"),
			WeakResource("/Lotus/Types/Game/MarkerInfos/SpaceEnemyMarkerInfo")
		},
		ScaleOverride = 0.625
	},
	{
		EnemyType = WeakResource("/Lotus/Types/Enemies/Corpus/Spaceman/ModularSpacemanAvatarWalkingShield"),
		AttachmentsToDestroy = {
			WeakResource("/Lotus/Characters/Guild/CorpusModular/FemaleFaceADeco"),
			WeakResource("/Lotus/Characters/Guild/CorpusModular/CorpusModularHoodDeco")
		}
	}
}

local function fn(state, data)
	for i = 1, #state.mPendingActionFigures do
		local mId = data.Preset.mItemId.mId
		local mId2 = data.VehiclePreset.mItemId.mId
		local loadOutType = data.LoadOutType
		local __wf_atom_4942f5a9 = state.mPendingActionFigures[i]:__wf_atom_4942f5a9()
		local mId3 = __wf_atom_4942f5a9.mLoadOutPreset.mItemId.mId
		local mId4 = __wf_atom_4942f5a9.mVehiclePreset.mItemId.mId
		local v4

		if mId3 == mId and __wf_atom_4942f5a9.mLoadOutType == loadOutType then
			if mId4 == mId2 or mId4 == "" and mId2 == SF.__wf_atom_b8679e91 then
				v4 = true
			elseif mId4 == SF.__wf_atom_b8679e91 then
				v4 = mId2 == ""
			else
				v4 = false
			end
		else
			v4 = false
		end

		if v4 then
			return true
		end
	end

	return false
end

local function fn2(_, list)
	for i = #list, 1, -1 do
		list[i]:__wf_atom_8893fd5b()
		table.remove(list)
	end
end

local function fn3(state, mEquippedWeapon)
	local mPreviewAvatar = state.mPreviewAvatar

	if mEquippedWeapon == state.mLastEquipSlot then
		return false
	end

	local v4 = 0

	if mEquippedWeapon == 0 then
		local v5

		if state.mLastEquipSlot == 2 then
			v5 = 1
		elseif state.mLastEquipSlot == 3 then
			v5 = 5
		elseif state.mLastEquipSlot == 4 then
			v5 = 7
		else
			v5 = v4
		end

		if not __wf_atom_7e8ad928(mPreviewAvatar) then
			mPreviewAvatar:__wf_atom_d2b2176d():__wf_atom_67861ccf(v5, 3)
			mPreviewAvatar:__wf_atom_d2b2176d():__wf_atom_c8700ab5(false)
		end
	else
		local v5

		if mEquippedWeapon == 2 then
			v5 = 1
		elseif mEquippedWeapon == 3 then
			v5 = 5
		elseif mEquippedWeapon == 4 then
			v5 = 7
		else
			v5 = v4
		end

		local v6

		if state.mLastEquipSlot == 1 then
			v6 = 0
		elseif state.mLastEquipSlot == 2 then
			v6 = 1
		elseif state.mLastEquipSlot == 3 then
			v6 = 5
		elseif mEquippedWeapon == 4 then
			v6 = 7
		else
			v6 = nil
		end

		if not __wf_atom_7e8ad928(mPreviewAvatar) then
			mPreviewAvatar:__wf_atom_d2b2176d():__wf_atom_c8700ab5(true)

			if v6 ~= nil then
				mPreviewAvatar:__wf_atom_d2b2176d():__wf_atom_67861ccf(v6, 3)
			end

			mPreviewAvatar:__wf_atom_d2b2176d():Equip(v5, 0, 2)
		end
	end

	state.mLastEquipSlot = mEquippedWeapon
	return true
end

local function fn4(state)
	for i = #state.mPendingActionFigures, 1, -1 do
		local mPendingActionFigure = state.mPendingActionFigures[i]

		if __wf_atom_7e8ad928(mPendingActionFigure) then
			print("ActionFigureLoadOutLoader - PendingFigure nil at index: " .. tostring(i) .. ", total figures: " .. tostring(#state.mPendingActionFigures))
			table.remove(state.mPendingActionFigures, i)
		else
			local __wf_atom_4942f5a9 = mPendingActionFigure:__wf_atom_4942f5a9()
			local mCurrentLoadOutId = state.mCurrentLoadOutId
			local mCurrentVehicleId = state.mCurrentVehicleId
			local mCurrentLoadOutType = state.mCurrentLoadOutType
			local mId = __wf_atom_4942f5a9.mLoadOutPreset.mItemId.mId
			local mId2 = __wf_atom_4942f5a9.mVehiclePreset.mItemId.mId
			local v4

			if mId == mCurrentLoadOutId and __wf_atom_4942f5a9.mLoadOutType == mCurrentLoadOutType then
				if mId2 == mCurrentVehicleId or mId2 == "" and mCurrentVehicleId == SF.__wf_atom_b8679e91 then
					v4 = true
				elseif mId2 == SF.__wf_atom_b8679e91 then
					v4 = mCurrentVehicleId == ""
				else
					v4 = false
				end
			else
				v4 = false
			end

			if v4 then
				if fn3(state, __wf_atom_4942f5a9.mEquippedWeapon) then
					state.mEquipCopyPending = 3
					return false
				end

				local __wf_atom_be0bea4a = mPendingActionFigure:__wf_atom_be0bea4a()

				for j = #__wf_atom_be0bea4a, 1, -1 do
					gRegion:__wf_atom_dd1e4d10(__wf_atom_be0bea4a[j])
				end

				local __wf_atom_0c59b746 = mPendingActionFigure:__wf_atom_0c59b746()

				for j = #__wf_atom_0c59b746, 1, -1 do
					mPendingActionFigure:__wf_atom_8f12baaa(__wf_atom_0c59b746[j])
				end

				if state.mEquipCopyPending > 0 then
					state.mEquipCopyPending -= 1
					return false
				end

				local v5 = { __wf_atom_465d956f }
				module.SetupDecoAsAvatarWithWeapons(mPendingActionFigure, state.mPreviewAvatar, false, v5)
				table.remove(state.mPendingActionFigures, i)
			end
		end
	end

	if not __wf_atom_7e8ad928(state.mPreviewAvatar) then
		state.mPreviewAvatar:__wf_atom_d2b2176d():__wf_atom_c8700ab5(false)
	end

	if not fn(state, state.mPendingLoadOutPresetInfos[#state.mPendingLoadOutPresetInfos]) then
		table.remove(state.mPendingLoadOutPresetInfos)
	end

	return true
end

local function fn5(data)
	for i = #data.mPendingEnemyFigures, 1, -1 do
		local mPendingEnemyFigure = data.mPendingEnemyFigures[i]

		if __wf_atom_7e8ad928(mPendingEnemyFigure) then
			table.remove(data.mPendingEnemyFigures, i)
		elseif mPendingEnemyFigure:__wf_atom_4942f5a9().mAvatarType == data.mPendingEnemyTypes[1] then
			local __wf_atom_be0bea4a = mPendingEnemyFigure:__wf_atom_be0bea4a()

			for j = #__wf_atom_be0bea4a, 1, -1 do
				gRegion:__wf_atom_dd1e4d10(__wf_atom_be0bea4a[j])
			end

			local __wf_atom_0c59b746 = mPendingEnemyFigure:__wf_atom_0c59b746()

			for j = #__wf_atom_0c59b746, 1, -1 do
				mPendingEnemyFigure:__wf_atom_8f12baaa(__wf_atom_0c59b746[j])
			end

			local attachmentsToDestroy = {}
			local scaleOverride = nil

			for j = 1, #v3 do
				if not data.mEnemyLoader.Avatar:IsA(v3[j].EnemyType) then
					continue
				end

				attachmentsToDestroy = v3[j].AttachmentsToDestroy

				if not v3[j].ScaleOverride then
					break
				end

				scaleOverride = v3[j].ScaleOverride
				break
			end

			module.SetupDecoAsAvatarWithWeapons(
				mPendingEnemyFigure,
				data.mEnemyLoader.Avatar,
				false,
				attachmentsToDestroy
			)

			if scaleOverride then
				mPendingEnemyFigure:SetMeshScale(scaleOverride, true)
			else
				mPendingEnemyFigure:SetMeshScale(
					Resource(mPendingEnemyFigure:__wf_atom_1bb5b1ff()):__wf_atom_c082fc3d() * data.mEnemyLoader.Avatar:__wf_atom_c082fc3d(),
					true
				)
			end

			table.remove(data.mPendingEnemyFigures, i)
		end
	end

	table.remove(data.mPendingEnemyTypes, 1)
end

local function fn6(object, _)
	local v4 = gRegion:IsMaster() and 3 or 4
	local position = object:GetPosition() + Vector(0, -2, 0)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ActionFigureAvatarSpawn"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		position = __wf_atom_0a6a5887:GetPosition()
	end

	local entity = gRegion:CreateEntity(Type(v2), position, __wf_atom_80368bb1, object, object, v4)

	if __wf_atom_7e8ad928(entity) then
		return entity
	end

	local __wf_atom_d2b2176d = entity:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:__wf_atom_91ecc559()
	__wf_atom_d2b2176d:Clear()
	entity:__wf_atom_4aa8ac56(true, false)
	entity:__wf_atom_e5d015a7(Symbol())
	entity:SetVisibility(false)
	entity:__wf_atom_9373d0eb(7, true)
	entity:__wf_atom_986f733d(Symbol(), 5)
	return entity
end

local function fn7(p, object, p2)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local v4 = gRegion:IsMaster() and 3 or 4
	local position = object:GetPosition() + Vector(0, -2, 0)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ActionFigureAvatarSpawn"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		position = __wf_atom_0a6a5887:GetPosition()
	end

	local entity = gRegion:CreateEntity(p, position, __wf_atom_80368bb1, object, object, v4)

	if __wf_atom_7e8ad928(entity) then
		return entity
	end

	entity:__wf_atom_4aa8ac56(true, false)
	entity:__wf_atom_e5d015a7(Symbol())
	entity:SetVisibility(false)
	entity:__wf_atom_9373d0eb(7, true)
	entity:__wf_atom_986f733d(Symbol(), 5)

	if p2 then
		entity:__wf_atom_d2b2176d():__wf_atom_c8700ab5(false)
	end

	return entity
end

function CreateActionFigureLoader(mSpinner)
	if not __wf_atom_7e8ad928(_T.ActionFigureLoadOutLoader) then
		print("ActionFigureLoadOutLoader - Tried to create, already exists")
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		print("Couldn't get player avatar, not creating a loader")
		return
	end

	if __wf_atom_7e8ad928(v) then
		print("previewAvatarType was not created, not creating a loader")
		return
	end

	local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(Type(v), __wf_atom_c4f78a8f:GetPosition())

	if __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
		__wf_atom_e2db08ce = fn7(Type(v), __wf_atom_c4f78a8f, true)
	end

	if __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
		print("Couldn't create a previewAvatar, not creating a loader")
		return
	end

	if __wf_atom_7e8ad928(gGameData) then
		print("Couldn't get game data, not creating a loader")
		return
	end

	if __wf_atom_7e8ad928(v2) then
		print("mechAvatarType was not created, not creating a loader")
		return
	end

	local __wf_atom_e2db08ce2 = gRegion:__wf_atom_e2db08ce(Type(v2), __wf_atom_c4f78a8f:GetPosition())

	if __wf_atom_7e8ad928(__wf_atom_e2db08ce2) then
		__wf_atom_e2db08ce2 = fn6(__wf_atom_c4f78a8f, false)
	end

	if __wf_atom_7e8ad928(__wf_atom_e2db08ce2) then
		print("Couldn't create a mechAvatar, not creating a loader")
	else
		_T.ActionFigureLoadOutLoader = {
			mPreviewAvatar = __wf_atom_e2db08ce,
			mMechAvatar = __wf_atom_e2db08ce2,
			mSpinner = mSpinner,
			mLoadOut = SF.LoadOut(),
			mNeedToShutdown = false,
			mPendingActionFigures = {},
			mPendingLoadOutPresetInfos = {},
			mLoadOutLoader = { Loader = nil, IsLoading = false, LoadOutCopyPending = 0 },
			mPendingEnemyFigures = {},
			mPendingEnemyTypes = {},
			mEnemyLoader = { Loader = nil, IsLoading = false, AvatarCopyPending = 0, Avatar = nil },
			mLastEquipSlot = 0,
			mReadyForWeaponSwitch = true,
			mKeepAlive = false,
			mCurrentLoadOutType = 0,
			mCurrentLoadOutId = "",
			mCurrentVehicleId = "",
			mCodexManifestType = WeakResource("/Lotus/Types/Lore/PrimaryCodexManifest"),
			mCodexManifest = nil,
			mEquipCopyPending = 0,
			StartCustomizeMode = function(p)
				p.mKeepAlive = true
			end,
			Update = function(state)
				if not state.mReadyForWeaponSwitch then
					state.mReadyForWeaponSwitch = state.mLoadOutLoader.LoadOutCopyPending == 0
						and not __wf_atom_7e8ad928(state.mPreviewAvatar)
						and state.mPreviewAvatar:__wf_atom_d2b2176d():__wf_atom_aba9c26e(0) == 14
				end

				if state.mLoadOutLoader.LoadOutCopyPending > 0 then
					state.mLoadOutLoader.LoadOutCopyPending = state.mLoadOutLoader.LoadOutCopyPending - 1

					if state.mLoadOutLoader.LoadOutCopyPending == 0 then
						local v4 = fn4(state)

						if not v4 then
							state.mLoadOutLoader.LoadOutCopyPending = 4
						end

						if v4 and not __wf_atom_7e8ad928(state.mSpinner) then
							state.mSpinner:SetActive(false)
						end
					end
				elseif
					state.mLoadOutLoader.IsLoading
					and not __wf_atom_7e8ad928(state.mLoadOutLoader.Loader)
					and state.mLoadOutLoader.Loader:__wf_atom_86399a47()
				then
					state.mLoadOutLoader.IsLoading = false

					if not __wf_atom_7e8ad928(state.mPreviewAvatar) then
						state.mPreviewAvatar:__wf_atom_d2b2176d():BuildLoadOut(state.mLoadOut)
						state.mPreviewAvatar:__wf_atom_d2b2176d():__wf_atom_cac3dd53(false, false, true)
					end

					state.mLoadOutLoader.LoadOutCopyPending = 4
				elseif
					state.mNeedToShutdown
					and not state.mKeepAlive
					and #state.mPendingLoadOutPresetInfos == 0
					and #state.mPendingActionFigures == 0
					and #state.mPendingEnemyFigures == 0
					and #state.mPendingEnemyTypes == 0
				then
					state.mSpinner = nil

					if not __wf_atom_7e8ad928(state.mEnemyLoader.Avatar) then
						state.mEnemyLoader.Avatar:Destroy()
						_T.AvatarRandomizerOverrideIndex = nil
					end

					_T.ActionFigureLoadOutLoader = nil
				elseif
					state.mLoadOutLoader.IsLoading
					or #state.mPendingLoadOutPresetInfos ~= 0
					or #state.mPendingActionFigures == 0
				then
					if
						not state.mLoadOutLoader.IsLoading
						and #state.mPendingLoadOutPresetInfos ~= 0
						and not __wf_atom_7e8ad928(gGameData)
					then
						if #state.mPendingActionFigures == 0 then
							table.remove(state.mPendingLoadOutPresetInfos)
						else
							local mPendingLoadOutPresetInfo = state.mPendingLoadOutPresetInfos[#state.mPendingLoadOutPresetInfos]

							if not fn(state, mPendingLoadOutPresetInfo) then
								table.remove(state.mPendingLoadOutPresetInfos)
								return
							end

							if state.mCurrentLoadOutId ~= "" and not __wf_atom_7e8ad928(state.mPreviewAvatar) then
								local __wf_atom_d2b2176d = state.mPreviewAvatar:__wf_atom_d2b2176d()
								__wf_atom_d2b2176d:StoreInventoryItem(0, true)
								__wf_atom_d2b2176d:StoreInventoryItem(1, true)
								__wf_atom_d2b2176d:StoreInventoryItem(5, true)
								__wf_atom_d2b2176d:StoreInventoryItem(7, true)
								__wf_atom_d2b2176d:StoreInventoryItem(10, true)
							end

							state.mLastEquipSlot = 0
							local v4 = not gRegion:IsMaster()
							state.mLoadOut.mOperatorCustomization = gGameData:__wf_atom_a4299765().mOperatorCustomization
							local v5 = {}
							local presets = {}
							state.mCurrentLoadOutId = mPendingLoadOutPresetInfo.Preset.mItemId.mId
							state.mCurrentVehicleId = mPendingLoadOutPresetInfo.VehiclePreset.mItemId.mId
							state.mCurrentLoadOutType = mPendingLoadOutPresetInfo.LoadOutType
							table.insert(v5, 0)
							table.insert(presets, mPendingLoadOutPresetInfo.Preset)
							gGameData:__wf_atom_75ebd344(state.mLoadOut, v5, presets, v4)
							state.mLoadOutLoader.Loader = gGameData:__wf_atom_6522a4b1()
							state.mLoadOutLoader.IsLoading = true

							if not __wf_atom_7e8ad928(state.mSpinner) then
								state.mSpinner:SetActive(true)
							end
						end
					end
				else
					fn2(state, state.mPendingActionFigures)
				end

				if state.mEnemyLoader.AvatarCopyPending > 0 then
					state.mEnemyLoader.AvatarCopyPending = state.mEnemyLoader.AvatarCopyPending - 1

					if state.mEnemyLoader.AvatarCopyPending == 0 then
						fn5(state)
						state.mEnemyLoader.Loader:Abort()
						state.mEnemyLoader.Loader = nil
						state.mEnemyLoader.IsLoading = false

						if not __wf_atom_7e8ad928(state.mSpinner) then
							state.mSpinner:SetActive(false)
						end
					end
				elseif
					__wf_atom_7e8ad928(state.mEnemyLoader.Loader)
					and #state.mPendingEnemyTypes == 0
					and #state.mPendingEnemyFigures ~= 0
				then
					fn2(state, state.mPendingEnemyFigures)
				elseif #state.mPendingEnemyTypes == 0 or not __wf_atom_7e8ad928(state.mEnemyLoader.Loader) then
					if
						state.mEnemyLoader.IsLoading
						and not __wf_atom_7e8ad928(state.mEnemyLoader.Loader)
						and state.mEnemyLoader.Loader:__wf_atom_86399a47()
					then
						if not __wf_atom_7e8ad928(state.mEnemyLoader.Avatar) then
							state.mEnemyLoader.Avatar:Destroy()
						end

						local __wf_atom_c4f78a8f2 = gRegion:__wf_atom_c4f78a8f()
						_T.AvatarRandomizerOverrideIndex = 1
						state.mEnemyLoader.Avatar = fn7(Type(state.mPendingEnemyTypes[1]), __wf_atom_c4f78a8f2, false)

						if not __wf_atom_7e8ad928(state.mEnemyLoader.Avatar) then
							if not __wf_atom_7e8ad928(state.mEnemyLoader.Weapon) then
								local v4 = state.mEnemyLoader.Avatar:GiveItem(Type(state.mEnemyLoader.Weapon), false)

								if not (__wf_atom_7e8ad928(v4) or state.mEnemyLoader.Avatar:__wf_atom_d2b2176d():Equip(
									v4:__wf_atom_0395f752(),
									0,
									2
								)) then
									print("Error equipping Enemy ActionFigure Weapon")
								end
							end

							state.mEnemyLoader.AvatarCopyPending = 3
						end
					end
				else
					local v4 = { state.mPendingEnemyTypes[1]:__wf_atom_5b41f63b() }

					if __wf_atom_7e8ad928(state.mCodexManifest) then
						state.mCodexManifest = Resource(state.mCodexManifestType)
					end

					local __wf_atom_c711142e = state.mCodexManifest:__wf_atom_c711142e(state.mPendingEnemyTypes[1])

					if not __wf_atom_7e8ad928(__wf_atom_c711142e) then
						if not __wf_atom_7e8ad928(__wf_atom_c711142e.equipType) then
							table.insert(v4, __wf_atom_c711142e.equipType:__wf_atom_5b41f63b())
						end

						state.mEnemyLoader.Weapon = __wf_atom_c711142e.equipType
					end

					state.mEnemyLoader.Loader = UISys.__wf_atom_c0dbe47c(v4)
					state.mEnemyLoader.IsLoading = true

					if not __wf_atom_7e8ad928(state.mSpinner) then
						state.mSpinner:SetActive(true)
					end
				end
			end,
			ReloadDecoWithLoadOut = function(p, p2, object)
				table.insert(p.mPendingLoadOutPresetInfos, {
					Preset = object:Copy(),
					VehiclePreset = SF.LoadOutPreset(),
					LoadOutType = 0
				})
				table.insert(p.mPendingActionFigures, p2)
			end,
			ReloadDecoWithLoadOutAndVehicle = function(p, p2, object, object2, loadOutType)
				table.insert(p.mPendingLoadOutPresetInfos, {
					Preset = object:Copy(),
					VehiclePreset = object2:Copy(),
					LoadOutType = loadOutType
				})
				table.insert(p.mPendingActionFigures, p2)
			end,
			ReloadDeco = function(self, object)
				if not self:IsReadyForWeaponSwitch() then
					return
				end

				table.insert(self.mPendingActionFigures, object)

				if not __wf_atom_7e8ad928(self.mSpinner) then
					self.mSpinner:SetActive(true)
				end

				local __wf_atom_4942f5a9 = object:__wf_atom_4942f5a9()
				table.insert(self.mPendingLoadOutPresetInfos, {
					Preset = __wf_atom_4942f5a9.mLoadOutPreset:Copy(),
					VehiclePreset = __wf_atom_4942f5a9.mVehiclePreset:Copy(),
					LoadOutType = __wf_atom_4942f5a9.mLoadOutType
				})
				self.mReadyForWeaponSwitch = false
				self.mLoadOutLoader.LoadOutCopyPending = 1
			end,
			ReloadEnemyDeco = function(self, p, p2)
				if not self:IsReadyForEnemySwitch() then
					return
				end

				table.insert(self.mPendingEnemyFigures, p)

				if not __wf_atom_7e8ad928(p2) then
					table.insert(self.mPendingEnemyTypes, p2)
				end
			end,
			IsReadyForEnemySwitch = function(self)
				return #self.mPendingEnemyFigures == 0
			end,
			IsReadyForWeaponSwitch = function(self)
				return self.mReadyForWeaponSwitch and self.mLoadOutLoader.LoadOutCopyPending == 0
			end,
			LoadDecosWithLoadOutsThenFinish = function(state, list, list2, list3, list4)
				local count = #state.mPendingActionFigures
				print("ActionFigureLoadOutLoader - oldLen Figures: " .. tostring(count))

				for i = 1, #list do
					state.mPendingActionFigures[i + count] = list[i]
				end

				local v4 = #state.mPendingLoadOutPresetInfos

				for i = 1, #list2 do
					state.mPendingLoadOutPresetInfos[i + v4] = list2[i]
				end

				if #list3 > 0 then
					local v5 = #state.mPendingEnemyFigures

					for i = 1, #list3 do
						state.mPendingEnemyFigures[i + v5] = list3[i]
					end

					local v6 = #state.mPendingEnemyTypes

					for i = 1, #list4 do
						state.mPendingEnemyTypes[i + v6] = list4[i]
					end
				end

				state.mNeedToShutdown = true
			end,
			EndCustomizeMode = function(p)
				p.mNeedToShutdown = true
				p.mKeepAlive = false
			end
		}
	end
end