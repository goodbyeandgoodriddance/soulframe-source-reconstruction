module(..., package.seeall)
dojoCustomObstacleCourseGameRules = WeakResource("/Lotus/Types/GameRules/LotusObstacleCourseGameRules")
local module = require("Lotus.Scripts.Effects.EffectsColorUtilities")
local module2 = require("EE.Interface.Utilities")
playerAvatarType = WeakResource("/SF/Types/Player/TennoAvatar")
local v = WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/ShipPlaceableLight")
local v2 = WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/ShipPlaceableTextLight")
local v3 = {}
local v4 = WeakResource("/Lotus/Objects/Tenno/Props/TennoPlaceables/TnoSpawnPad")
dojoRecipeManifest = WeakResource("/Lotus/Types/Game/Store/DojoRecipeManifest")
dojoZoneAttribsType = WeakResource("/Lotus/Levels/ClanDojo/ClanDojoZoneAttribs")

local function fn(p, instance)
	if not __wf_atom_7e8ad928(p.pictureFrameInfo.mImage) then
		if instance:IsA(WeakResource("/Lotus/Interface/FragmentArtwork/GlyphFrameDeco")) then
			p.pictureFrameInfo.mScale = 1
		end

		instance:__wf_atom_56f370a5(p.pictureFrameInfo, true)
	end

	if instance:IsA(v) then
		if _T.PlacingCustomizableDeco then
			p.pictureFrameInfo.mColorCorrection = Color(239, 239, 239):__wf_atom_dcecedb0()
		end

		instance:__wf_atom_18212c52(p.pictureFrameInfo, true)

		if instance:IsA(v2) then
			local __wf_atom_4f911ec1 = instance:__wf_atom_4f911ec1()

			if not __wf_atom_7e8ad928(__wf_atom_4f911ec1) then
				__wf_atom_4f911ec1:__wf_atom_18f27a89(200)
				__wf_atom_4f911ec1:__wf_atom_00010694(false)
				__wf_atom_4f911ec1:Execute("HideBg", "true")
				__wf_atom_4f911ec1:Execute("SetUserText", "")
				__wf_atom_4f911ec1:Execute("SetMessage", (tostring(p.pictureFrameInfo.mText:gsub(",", "<COMMA>"))))
				__wf_atom_4f911ec1:Execute("SetHiddenInBackgroundRegion", "true")
				local mTextColorA = p.pictureFrameInfo.mTextColorA
				local v5 = Color(mTextColorA)
				local v6 = tostring((module.SRGBToLinear255(v5):__wf_atom_dcecedb0()))
				local mTextColorB = p.pictureFrameInfo.mTextColorB
				local v7 = Color(mTextColorB)
				__wf_atom_4f911ec1:__wf_atom_f62a8704("SetVertexColors", {
					v6,
					(tostring((module.SRGBToLinear255(v7):__wf_atom_dcecedb0())))
				})
				local __wf_atom_d511015b = instance:__wf_atom_d511015b()

				if not __wf_atom_7e8ad928(__wf_atom_d511015b) then
					__wf_atom_d511015b:SetMeshScale(p.pictureFrameInfo.mTextScale)
					local __wf_atom_be0bea4a = instance:__wf_atom_be0bea4a()

					for i = 1, #__wf_atom_be0bea4a do
						if not __wf_atom_be0bea4a[i]:IsA(__wf_atom_d00f34c2) then
							continue
						end

						local __wf_atom_48a8e71b = __wf_atom_be0bea4a[i]:__wf_atom_9a4bac79():__wf_atom_48a8e71b(p.pictureFrameInfo.mYOffset)
						local __wf_atom_3d96ddcd = __wf_atom_d511015b:__wf_atom_3d96ddcd()

						if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
							__wf_atom_d511015b:__wf_atom_e310f01f(
								Vector(0, __wf_atom_48a8e71b, 0),
								Rotation(0, p.pictureFrameInfo.mTextOrientation, 0)
							)
							break
						end

						local __wf_atom_5b41f63b = __wf_atom_3d96ddcd:__wf_atom_5b41f63b()

						if
							__wf_atom_7e8ad928(_T.UserDecoText)
							or __wf_atom_7e8ad928(_T.UserDecoText[__wf_atom_5b41f63b])
						then
							__wf_atom_d511015b:__wf_atom_e310f01f(
								Vector(0, __wf_atom_48a8e71b, 0),
								Rotation(0, p.pictureFrameInfo.mTextOrientation, 0)
							)
							break
						end

						local v8 = _T.UserDecoText[__wf_atom_5b41f63b]
						__wf_atom_d511015b:__wf_atom_e310f01f(
							Vector(
								v8.pos.x + v8.dir.x * __wf_atom_48a8e71b,
								v8.pos.y + v8.dir.y * __wf_atom_48a8e71b,
								v8.pos.z + v8.dir.z * __wf_atom_48a8e71b
							),
							Rotation(v8.rot.heading, v8.rot.pitch + p.pictureFrameInfo.mTextOrientation, v8.rot.bank)
						)
						break
					end
				end

				if not __wf_atom_7e8ad928(gClient) and gClient:__wf_atom_449cc668() then
					__wf_atom_4f911ec1:SetVisible(false)

					if __wf_atom_7e8ad928(_T.UserTextMovies) then
						_T.UserTextMovies = {}
					end

					table.insert(_T.UserTextMovies, __wf_atom_4f911ec1)
				end
			end
		end
	end
end

function ApplyPlacedDecoPictureFrameInfo(p, p2)
	fn(p, p2)
end

local function fn2(p, p2, p3)
	if __wf_atom_7e8ad928(p[p2]) then
		p[p2] = {}
	end

	local v5 = false

	for i = 1, #p[p2] do
		if p[p2][i] ~= p3 then
			continue
		end

		v5 = true
		break
	end

	if not v5 then
		table.insert(p[p2], p3)
	end
end

local function fn3(p, p2, p3)
	if not __wf_atom_7e8ad928(p[p2]) then
		for i = #p[p2], 1, -1 do
			if p[p2][i] ~= p3 then
				continue
			end

			table.remove(p[p2], i)
			return
		end
	end
end

local function fn4(data, p, callback, p2)
	if p == "" then
		callback((Framework.JsonLayoutComponent()))
		return
	end

	local v5 = p2 and 1800 or nil

	if not __wf_atom_7e8ad928(v5) then
		if #data.mDojoRequests > 0 then
			return
		end

		if
			v5 <= __wf_atom_c4e218a2() - data.mLastDojoRefreshTime
			and (__wf_atom_7e8ad928(data.mLastRefreshTimes) or __wf_atom_7e8ad928(data.mLastRefreshTimes[p]) or v5 <= __wf_atom_c4e218a2() - data.mLastRefreshTimes[p])
		then
			data.mJsonProcLevelHelper:RefreshComponent(p, data.mDojo:__wf_atom_a2bfd8e9(), "")
			return
		end
	end

	local component = data.mDojo:GetComponent(p)
	fn3(data.mComponentRequests, p, callback)
	callback(component)
end

local function fn5(p, object)
	if object:__wf_atom_47cac5d4() then
		p.mJsonProcLevelHelper:__wf_atom_a9fd312a(object:__wf_atom_4a99b8d3())
	elseif object:__wf_atom_1ed604a8() and gRegion:IsMaster() then
		p.mJsonProcLevelHelper:__wf_atom_a9fd312a(object:__wf_atom_621049bb())
	end

	local placedDecos = object.placedDecos

	for i = 1, #placedDecos do
		local placedDeco = placedDecos[i]

		if placedDeco:__wf_atom_47cac5d4() then
			p.mJsonProcLevelHelper:__wf_atom_afea0d81(object:__wf_atom_854e0028(), placedDeco:__wf_atom_4a99b8d3())
		end

		__wf_atom_83c14687(0)
	end
end

local function fn6(object)
	local v5 = WeakResource("/Lotus/Types/LevelObjects/DojoRoomCameraSpot")
	local all = gRegion:FindAll(v5)

	for i = 1, #all do
		local componentParams = object:BuildComponentParams(all[i])

		if componentParams.id ~= "" then
			object.mIdToRoomCameraSpots[componentParams.id] = all[i]
		end
	end
end

local function fn7(p, p2)
	local all = gRegion:FindAll(__wf_atom_e1d1671b)
	local v5

	if not (__wf_atom_7e8ad928(_T.DojoMgr) or __wf_atom_7e8ad928(_T.DojoMgr.mIdToZoneAttribs) or __wf_atom_7e8ad928(_T.DojoMgr.mIdToZoneAttribs[p2])) then
		v5 = _T.DojoMgr.mIdToZoneAttribs[p2]
	end

	if p == nil then
		return
	end

	local v6 = Symbol(p)

	for i = 1, #all do
		local v7 = all[i]

		if not (v7:__wf_atom_6c640264() and v7:__wf_atom_b1dbf338() == v6 or v6 == EMPTY_SYMBOL and v7:__wf_atom_b1dbf338() == Symbol("BackDropSpace")) then
			continue
		end

		if __wf_atom_7e8ad928(v5) then
			continue
		end

		v5:__wf_atom_4e830354(v6)
		v5:__wf_atom_e800787c():__wf_atom_b01831b3(v7:__wf_atom_e800787c())
	end
end

function CreateDojoMgr()
	return {
		mDojo = nil,
		mDojoRequests = {},
		mIdToZoneMap = {},
		mIdToPlacedDecos = {},
		mDecoStatusChangedCallback = {},
		mDecoFocusChangedCallback = {},
		mDecoSelectedCallback = {},
		mIdToZoneAttribs = {},
		mIdToShutterOpenActionsMap = {},
		mIdToShutterCloseActionsMap = {},
		mIdToShutterState = {},
		mDecoTypeToDecos = {},
		mDecoTypesLoaded = {},
		mDecosToCreate = {},
		mDecoCreateQueue = 0,
		mImmedDecosToCreate = {},
		mImmedDecoCreateQueue = 0,
		mPrioDecosToCreate = {},
		mPrioDecoCreateQueue = 0,
		mIdToDojoGates = {},
		mIdToRoomCameraSpots = {},
		mComponentRequests = {},
		mComponentSubscribers = {},
		mVaultChangeSubscribers = {},
		mAllianceVaultChangeSubscribers = {},
		mUnderConstructionComponents = {},
		mConstructionQueuedComponents = {},
		mDestructionPendingComponents = {},
		mGameRules = nil,
		mJsonProcLevelHelper = nil,
		mLastDojoRefreshTime = 0,
		mLastRefreshTimes = {},
		mLastVaultRefreshTime = 0,
		mLastAllianceVaultRefreshTime = 0,
		mComponentOperationCallback = nil,
		mComponentAbortedCallback = nil,
		mPlaceInLayoutCallback = nil,
		mSetComponentMessageCallback = nil,
		mSetComponentSettingsCallback = nil,
		mLevelReloadPending = false,
		mPendingDecoToPlace = nil,
		mPendingDecoComponentId = nil,
		mPendingDestroyDeco = nil,
		mPendingDestroyDecoComponentId = nil,
		mDecoConstructionQueuedMaterialOverride = nil,
		mDecoUnderConstructionMaterialOverride = nil,
		mCountdownSeqType = nil,
		mBuildCompleteSeqType = nil,
		mDojoGateDialogTriggerType = nil,
		mDisableSpawnPoints = true,
		mCurrentlyFocusedDeco = { Deco = nil, Id = nil },
		mDefaultLightColors = {},
		mReadyToCreateDecos = nil,
		mDecosOverlappingLocalAvatar = {},
		mSpawnRoomId = "",
		TINT_NAMES = {
			Symbol("TintColor0"),
			Symbol("TintColor1"),
			Symbol("TintColor2"),
			Symbol("TintColor3"),
			Symbol("EmissiveTintColor")
		},
		SetGameRulesAndDojo = function(p, mGameRules, mJsonProcLevelHelper, mCountdownSeqType, mBuildCompleteSeqType, mDojoGateDialogTriggerType, mDisableSpawnPoints)
			p.mGameRules = mGameRules
			p.mJsonProcLevelHelper = mJsonProcLevelHelper
			p.mDojo = mJsonProcLevelHelper:__wf_atom_5175aea4()
			p.mCountdownSeqType = mCountdownSeqType
			p.mBuildCompleteSeqType = mBuildCompleteSeqType
			p.mDojoGateDialogTriggerType = mDojoGateDialogTriggerType
			p.mDisableSpawnPoints = mDisableSpawnPoints

			if gRegion:IsMaster() and not gPromotedToHost then
				p.mLastDojoRefreshTime = __wf_atom_c4e218a2()
				local components = p.mDojo:GetComponents()

				for i = 1, #components do
					local component = components[i]

					if i == 1 then
						p.mSpawnRoomId = component:__wf_atom_854e0028()
					end

					fn5(p, components[i])
				end
			end

			local levelArgs = Engine.OpenLevelArgs()
			levelArgs.streamingLayer = 300
			levelArgs.isAutonomous = true
			levelArgs.streamingMode = 1
			levelArgs.streamingPriority = 2
			levelArgs:__wf_atom_c4be912d("OnStreamSkyboxes")
			levelArgs:__wf_atom_60471db9(Vector(-1000, -1000, -1000), __wf_atom_80368bb1)
			Engine.StreamRegion(levelArgs)
			fn6(p)
		end,
		Update = function(self)
			if not (self.mReadyToCreateDecos or __wf_atom_7e8ad928((gRegion:__wf_atom_c4f78a8f()))) then
				if self.mReadyToCreateDecos == nil then
					self.mReadyToCreateDecos = false
				else
					self.mReadyToCreateDecos = true
				end
			end

			local count = 0
			local v5 = self.mGameRules:InDojo()
			local __wf_atom_92221480 = self.mJsonProcLevelHelper:__wf_atom_92221480()

			local function fn8(items, p)
				for k, list in pairs(items) do
					if self.mDecoTypesLoaded[k] and #list > 0 then
						for i = #list, 1, -1 do
							local decoId = list[i].DecoId
							local roomId = list[i].RoomId
							local __wf_atom_0d0c9d51 = self.mDojo:__wf_atom_0d0c9d51(decoId)

							if
								__wf_atom_0d0c9d51:__wf_atom_854e0028() == decoId
								and (v5 or not (__wf_atom_0d0c9d51:__wf_atom_644d0f1d() or __wf_atom_0d0c9d51:__wf_atom_47cac5d4()))
								and not __wf_atom_7e8ad928(__wf_atom_0d0c9d51.decoType)
								and __wf_atom_0d0c9d51.decoType:__wf_atom_5b41f63b() == k
							then
								self:CreateDeco(
									__wf_atom_92221480,
									roomId,
									__wf_atom_0d0c9d51,
									self.mSpawnRoomId == roomId
								)

								if p == 2 then
									self.mImmedDecoCreateQueue -= 1
								else
									if p == 1 then
										self.mPrioDecoCreateQueue -= 1
									else
										self.mDecoCreateQueue -= 1
									end

									count += 1
								end
							end

							table.remove(list, i)

							if count >= 50 then
								break
							end
						end
					end

					if count >= 50 then
						break
					end
				end
			end

			if self.mImmedDecoCreateQueue > 0 then
				fn8(self.mImmedDecosToCreate, 2)
			end

			if not self.mReadyToCreateDecos then
				return
			end

			if self.mPrioDecoCreateQueue > 0 then
				fn8(self.mPrioDecosToCreate, 1)
			end

			if count < 50 and self.mDecoCreateQueue > 0 then
				fn8(self.mDecosToCreate, 0)
			end

			self.ApplyDecoGrouping(self)
			local v6 = Vector()
			local v7 = Vector()
			local v8 = Rotation()

			for i = #self.mDecosOverlappingLocalAvatar, 1, -1 do
				self.mDecosOverlappingLocalAvatar[i]:__wf_atom_210b921a(v6, v7, v8)
				v6.x += 0.1
				v6.y += 0.1
				v6.z += 0.1
				local __wf_atom_c072bb51 = gRegion:__wf_atom_c072bb51(v7, v6, v8, playerAvatarType)
				local v9 = false

				for j = 1, #__wf_atom_c072bb51 do
					if not __wf_atom_c072bb51[j]:__wf_atom_8efce136() then
						continue
					end

					v9 = true
					break
				end

				if v9 then
					continue
				end

				self.mDecosOverlappingLocalAvatar[i]:__wf_atom_c529459a(4, 1, true, nil)
				table.remove(self.mDecosOverlappingLocalAvatar, i)
			end

			if not (__wf_atom_7e8ad928(_T.UserTextMovies) or __wf_atom_7e8ad928(gClient) or gClient:__wf_atom_449cc668()) then
				for i = 1, #_T.UserTextMovies do
					local userTextMovy = _T.UserTextMovies[i]

					if not __wf_atom_7e8ad928(userTextMovy) then
						userTextMovy:SetVisible(true)
					end
				end

				_T.UserTextMovies = nil
			end
		end,
		GetComponentAndSubscribeToChanges = function(self, p, p2, p3)
			fn2(self.mComponentSubscribers, p, p2)
			fn4(self, p, p2, p3)
		end,
		GetComponent = function(self, p, p2, p3)
			fn2(self.mComponentRequests, p, p2)
			fn4(self, p, p2, p3)
		end,
		GetDojo = function(data, callback, p)
			if not (__wf_atom_7e8ad928(data.mDojoRequests) or p <= __wf_atom_c4e218a2() - data.mLastDojoRefreshTime) then
				callback()
				return
			end

			if not __wf_atom_7e8ad928(callback) then
				table.insert(data.mDojoRequests, callback)
			end

			local __wf_atom_6020c572 = gMatchingService:__wf_atom_6020c572()
			data.mJsonProcLevelHelper:RefreshData(__wf_atom_6020c572)
		end,
		NotifySubscribersOfComponentRefresh = function(data, object)
			local __wf_atom_854e0028 = object:__wf_atom_854e0028()

			if
				object:__wf_atom_8598f3a9()
				and not __wf_atom_7e8ad928(data.mComponentSubscribers[__wf_atom_854e0028])
			then
				local v5 = {}

				for i = 1, #data.mComponentSubscribers[__wf_atom_854e0028] do
					table.insert(v5, data.mComponentSubscribers[__wf_atom_854e0028][i])
				end

				for i = 1, #v5 do
					v5[i](object)
				end

				data.mLastRefreshTimes[__wf_atom_854e0028] = __wf_atom_c4e218a2()
			end

			if object:__wf_atom_8598f3a9() and not __wf_atom_7e8ad928(data.mComponentRequests[__wf_atom_854e0028]) then
				for i = 1, #data.mComponentRequests[__wf_atom_854e0028] do
					data.mComponentRequests[__wf_atom_854e0028][i](object)
				end

				data.mComponentRequests[__wf_atom_854e0028] = {}
				data.mLastRefreshTimes[__wf_atom_854e0028] = __wf_atom_c4e218a2()
			end

			fn5(data, object)
		end,
		SubscribeToVaultChanges = function(p, p2, p3)
			if p3 then
				p.mAllianceVaultChangeSubscribers[#p.mAllianceVaultChangeSubscribers + 1] = p2
			else
				p.mVaultChangeSubscribers[#p.mVaultChangeSubscribers + 1] = p2
			end
		end,
		UnsubscribeToVaultChanges = function(p, p2, p3)
			if p3 then
				for i = #p.mAllianceVaultChangeSubscribers, 1, -1 do
					if p.mAllianceVaultChangeSubscribers[i] ~= p2 then
						continue
					end

					table.remove(p.mAllianceVaultChangeSubscribers, i)
					return
				end
			else
				for i = #p.mVaultChangeSubscribers, 1, -1 do
					if p.mVaultChangeSubscribers[i] ~= p2 then
						continue
					end

					table.remove(p.mVaultChangeSubscribers, i)
					return
				end
			end
		end,
		RefreshVault = function(state, p)
			if p then
				state.mLastAllianceVaultRefreshTime = __wf_atom_c4e218a2()

				for i = 1, #state.mAllianceVaultChangeSubscribers do
					state.mAllianceVaultChangeSubscribers[i]()
				end
			else
				state.mLastVaultRefreshTime = __wf_atom_c4e218a2()

				for i = 1, #state.mVaultChangeSubscribers do
					state.mVaultChangeSubscribers[i]()
				end
			end
		end,
		AdjustVaultRecipeTime = function(p, p2, p3)
			if p2 > 0 then
				if p3 then
					if p.mLastAllianceVaultRefreshTime ~= 0 then
						return p2 - (__wf_atom_c4e218a2() - p.mLastAllianceVaultRefreshTime)
					end
				elseif p.mLastVaultRefreshTime ~= 0 then
					return p2 - (__wf_atom_c4e218a2() - p.mLastVaultRefreshTime)
				end
			end

			return p2
		end,
		UpdateComponentDecoStates = function(data, p)
			local component = data.mDojo:GetComponent(p)
			local placedDecos = component.placedDecos
			local __wf_atom_92221480 = data.mJsonProcLevelHelper:__wf_atom_92221480()

			for i = 1, #placedDecos do
				local placedDeco = placedDecos[i]
				data.CreateDeco(data, __wf_atom_92221480, p, placedDeco, false)

				if placedDeco:__wf_atom_47cac5d4() then
					data.mJsonProcLevelHelper:__wf_atom_afea0d81(
						component:__wf_atom_854e0028(),
						placedDeco:__wf_atom_4a99b8d3()
					)
				end

				__wf_atom_83c14687(0)
			end
		end,
		RefreshComponent = function(self, p, p2, p3)
			local isA = gGameRules:IsA(__wf_atom_1316e0c2)

			if p == 0 then
				local v5 = self.mDojo:RefreshComponent(p2)
				self.NotifySubscribersOfComponentRefresh(self, v5)
			elseif p > 0 then
				self.RefreshDojo(self, true, p2, p3)
			else
				isA = false
			end

			if isA then
				local __wf_atom_001889b4 = self.mDojo:__wf_atom_001889b4()
				gMatchingService:__wf_atom_080915b6(__wf_atom_001889b4)

				if p3 then
					gMatchingService:__wf_atom_9c7c90fb():__wf_atom_0c0d9655(__wf_atom_001889b4)
				end
			end
		end,
		RefreshComponents = function(self, p, p2)
			local v5 = self.mDojo:RefreshComponents(p)
			local __wf_atom_001889b4 = self.mDojo:__wf_atom_001889b4()
			gMatchingService:__wf_atom_080915b6(__wf_atom_001889b4)

			if p2 and gGameRules:IsA(__wf_atom_1316e0c2) then
				gMatchingService:__wf_atom_9c7c90fb():__wf_atom_0c0d9655(__wf_atom_001889b4)
			end

			for i = 1, #v5 do
				self.NotifySubscribersOfComponentRefresh(self, v5[i])
			end
		end,
		RefreshDojo = function(state, p, p2, p3)
			if p then
				local v5 = state.mDojo:Refresh(p2)
				local v6 = state.mJsonProcLevelHelper:__wf_atom_739e0c82() and 1 or v5
				state.mLastDojoRefreshTime = __wf_atom_c4e218a2()
				local __wf_atom_001889b4 = state.mDojo:__wf_atom_001889b4()
				gMatchingService:__wf_atom_080915b6(__wf_atom_001889b4)

				if p3 and gGameRules:IsA(__wf_atom_1316e0c2) then
					gMatchingService:__wf_atom_9c7c90fb():__wf_atom_0c0d9655(__wf_atom_001889b4)
				end

				if gGameRules:IsA(__wf_atom_1316e0c2) then
					gGameRules:OnDojoRefreshed(p2)
				end

				local v7 = false

				for _, _ in pairs(state.mIdToRoomCameraSpots) do
					v7 = true
					break
				end

				if not v7 then
					fn6(state)
				end

				local components = state.mDojo:GetComponents()

				if v6 == 0 then
					local all = gRegion:FindAll(dojoZoneAttribsType)
					local v8 = {}

					for i = 1, #all do
						v8[all[i]:__wf_atom_e800787c():GetLayerIndex()] = true
					end

					local count = 0

					for _, _ in pairs(v8) do
						count += 1
					end

					if
						count ~= #components
						and state.mJsonProcLevelHelper:__wf_atom_c752491a(
							0,
							state.mDojo:__wf_atom_96ea76e4(p2),
							__wf_atom_001889b4
						)
					then
						state.mLevelReloadPending = true
						return
					end
				elseif state.mJsonProcLevelHelper:__wf_atom_c752491a(
					v6,
					state.mDojo:__wf_atom_96ea76e4(p2),
					__wf_atom_001889b4
				) then
					state.mLevelReloadPending = true
					return
				end

				for i = 1, #state.mDojoRequests do
					state.mDojoRequests[i]()
				end

				state.mDojoRequests = {}

				for i = 1, #components do
					state.NotifySubscribersOfComponentRefresh(state, components[i])
				end
			end
		end,
		UnSubscribe = function(p, p2, p3)
			fn3(p.mComponentSubscribers, p2, p3)
		end,
		PlaceInLayout = function(self, p, mPlaceInLayoutCallback)
			if not __wf_atom_7e8ad928(self.mPlaceInLayoutCallback) then
				mPlaceInLayoutCallback(-3, "Already have a place operation pending!")
				return
			end

			local placeInJsonLayout = self.mDojo:PlaceInJsonLayout(p)

			if placeInJsonLayout == "" then
				mPlaceInLayoutCallback(-3, "Cannot place in layout!")
				return
			end

			self.mPlaceInLayoutCallback = mPlaceInLayoutCallback
			self.mJsonProcLevelHelper:PlaceInLayout(placeInJsonLayout)
		end,
		OnComponentPlaced = function(state, p, p2, p3)
			if not __wf_atom_7e8ad928(state.mPlaceInLayoutCallback) then
				local mPlaceInLayoutCallback = state.mPlaceInLayoutCallback
				state.mPlaceInLayoutCallback = nil
				mPlaceInLayoutCallback(p, p2)
			end

			if p >= 0 then
				state.RefreshDojo(state, true, p2, p3)
			end
		end,
		ConvertSpawnRoom = function(state, mPlaceInLayoutCallback)
			if not __wf_atom_7e8ad928(state.mPlaceInLayoutCallback) then
				mPlaceInLayoutCallback(-3, "Already have a place operation pending!")
				return
			end

			local spawnRoom = state.mDojo:GetSpawnRoom()

			if spawnRoom == "" then
				mPlaceInLayoutCallback(-3, "No spawn room somehow?!")
				return
			end

			state.mPlaceInLayoutCallback = mPlaceInLayoutCallback
			state.mJsonProcLevelHelper:__wf_atom_068e660f(spawnRoom, state.mDojo:__wf_atom_a2bfd8e9())
		end,
		ChangeSpawnRoom = function(self, object, mPlaceInLayoutCallback, mConfirmationReviewedCallback)
			self.mConfirmationReviewedCallback = mConfirmationReviewedCallback

			if not __wf_atom_7e8ad928(self.mPlaceInLayoutCallback) then
				mPlaceInLayoutCallback(-3, "Already have a place operation pending!")
				return
			end

			if not self.mDojo:__wf_atom_51e36e75(object) then
				mPlaceInLayoutCallback(-3, "This room can't be used as the spawn room, why are you calling this?")
				return
			end

			self.mPlaceInLayoutCallback = mPlaceInLayoutCallback
			local encoded

			if self:ShouldAttachDecosToZone() then
				encoded = ""
			else
				local v5 = {}

				for k, mIdToZoneAttrib in pairs(self.mIdToZoneAttribs) do
					if __wf_atom_7e8ad928(mIdToZoneAttrib) then
						continue
					end

					local position = mIdToZoneAttrib:GetPosition()
					local __wf_atom_dc309f8a = mIdToZoneAttrib:__wf_atom_dc309f8a()
					v5[k] = {
						P = { position.x, position.y, position.z },
						R = { __wf_atom_dc309f8a.heading, __wf_atom_dc309f8a.pitch, __wf_atom_dc309f8a.bank }
					}
				end

				encoded = cjson.encode(v5)
			end

			self.mJsonProcLevelHelper:__wf_atom_12cf0778(
				object:__wf_atom_854e0028(),
				self.mDojo:__wf_atom_a2bfd8e9(),
				not self:ShouldAttachDecosToZone(),
				encoded
			)
		end,
		ConfirmationReviewed = function(p)
			if not __wf_atom_7e8ad928(p.mConfirmationReviewedCallback) then
				local mConfirmationReviewedCallback = p.mConfirmationReviewedCallback
				p.mConfirmationReviewedCallback = nil
				mConfirmationReviewedCallback()
			end
		end,
		OnSpawnRoomChanged = function(state, p, p2, p3)
			if not __wf_atom_7e8ad928(state.mPlaceInLayoutCallback) then
				local mPlaceInLayoutCallback = state.mPlaceInLayoutCallback
				state.mPlaceInLayoutCallback = nil
				mPlaceInLayoutCallback(p, p2)
			end

			if p >= 0 then
				state.RefreshDojo(state, true, p2, p3)

				if p == 0 then
					state.mJsonProcLevelHelper:__wf_atom_c752491a(
						0,
						state.mDojo:__wf_atom_96ea76e4(p2),
						state.mDojo:__wf_atom_001889b4(),
						true
					)
				end
			end
		end,
		StartGuildRecipe = function(self, p, p2, p3, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:StartGuildRecipe(p, p2, p3)
		end,
		RushComponent = function(self, p, p2, p3, p4, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:RushComponent(p, p2, p3, p4)
		end,
		RushDeco = function(self, p, p2, p3, p4, p5, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:RushDeco(p, p2, p3, p4, p5)
		end,
		RushGuildRecipe = function(self, p, p2, p3, p4, mComponentOperationCallback, p5)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:RushGuildRecipe(p, p2, p3, p4, p5)
		end,
		CommitComponentContribution = function(self, p, p2, p3, p4, p5, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:CommitComponentContribution(p, p2, p3, p4, p5)
		end,
		CommitDojoDecorationContribution = function(state, p, p2, p3, p4, p5, p6, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(state.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			state.mComponentOperationCallback = mComponentOperationCallback
			state.mJsonProcLevelHelper:__wf_atom_3acd3fcc(p, p2, p3, p4, p5, p6)
		end,
		CommitGuildRecipeContribution = function(state, p, p2, p3, p4, p5, p6, p7, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(state.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			state.mComponentOperationCallback = mComponentOperationCallback
			state.mJsonProcLevelHelper:__wf_atom_0183438c(p, p2, p3, p4, p5, p6, p7)
		end,
		PlacePendingDecoration = function(self, mComponentOperationCallback, p)
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				__wf_atom_c4f78a8f:__wf_atom_a1b79f95():__wf_atom_be6b2a2f():__wf_atom_2c3ed725()
			end

			if
				not __wf_atom_7e8ad928(self.mComponentOperationCallback)
				or __wf_atom_7e8ad928(self.mPendingDecoToPlace)
				or __wf_atom_7e8ad928(self.mPendingDecoComponentId)
			then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			local placedDecoSocketInfo

			if _T.PlacedDecoSocketInfo == nil then
				placedDecoSocketInfo = 255
			else
				placedDecoSocketInfo = _T.PlacedDecoSocketInfo
				_T.PlacedDecoSocketInfo = nil
			end

			local v5 = __wf_atom_7e8ad928((Resource(dojoRecipeManifest):__wf_atom_9d65cc25(self.mPendingDecoToPlace:__wf_atom_1bb5b1ff())))
				and true
				or false
			self.mJsonProcLevelHelper:__wf_atom_9b39615a(
				self.mPendingDecoToPlace,
				self.mPendingDecoComponentId,
				p,
				placedDecoSocketInfo,
				self.mDojo:__wf_atom_a2bfd8e9(),
				v5,
				v5,
				self:ShouldAttachDecosToZone()
			)
			self.mPendingDecoToPlace = nil
			self.mPendingDecoComponentId = nil
		end,
		AbortDecoration = function(self, p, p2, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:AbortDecoration(p, p2, self:ShouldAttachDecosToZone())
			self.mPendingDecoToPlace = nil
			self.mPendingDecoComponentId = nil
		end,
		AbortDecorationByID = function(self, p, p2, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:AbortDecorationByID(p, p2)
			self.mPendingDecoToPlace = nil
			self.mPendingDecoComponentId = nil
		end,
		AbortGuildRecipe = function(self, p, p2, mComponentOperationCallback, p3)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:AbortGuildRecipe(p, p2, p3)
		end,
		DestroyDecoration = function(self, mComponentOperationCallback)
			if
				not __wf_atom_7e8ad928(self.mComponentOperationCallback)
				or __wf_atom_7e8ad928(self.mPendingDestroyDeco)
				or __wf_atom_7e8ad928(self.mPendingDestroyDecoComponentId)
			then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:DestroyDecoration(
				self.mPendingDestroyDeco,
				self.mPendingDestroyDecoComponentId,
				self:ShouldAttachDecosToZone()
			)
			self.mPendingDecoToPlace = nil
			self.mPendingDecoComponentId = nil
		end,
		ClearObstacleCourseDecorations = function(state, mComponentOperationCallback)
			if
				not __wf_atom_7e8ad928(state.mComponentOperationCallback)
				or __wf_atom_7e8ad928(state.mPendingDestroyDecoComponentId)
			then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			state.mComponentOperationCallback = mComponentOperationCallback
			state.mJsonProcLevelHelper:__wf_atom_48a2b291(state.mPendingDestroyDecoComponentId)
			state.mPendingDecoToPlace = nil
			state.mPendingDecoComponentId = nil
		end,
		OnComponentOperationFinished = function(state, p, p2, p3)
			if not __wf_atom_7e8ad928(state.mComponentOperationCallback) then
				local mComponentOperationCallback = state.mComponentOperationCallback
				state.mComponentOperationCallback = nil
				mComponentOperationCallback(p, p2)
			end

			if p > 0 then
				state.RefreshDojo(state, true, p2, p3)
			end
		end,
		AbortComponent = function(self, p, mComponentAbortedCallback)
			if not __wf_atom_7e8ad928(self.mComponentAbortedCallback) then
				mComponentAbortedCallback(-3, "Already have an abort operation pending!")
				return
			end

			self.mComponentAbortedCallback = mComponentAbortedCallback
			self.mJsonProcLevelHelper:AbortComponent(p)
		end,
		OnComponentAborted = function(state, p, p2, p3)
			if p >= 0 then
				state.RefreshDojo(state, true, p2, p3)
			end

			if not __wf_atom_7e8ad928(state.mComponentAbortedCallback) then
				state.mComponentAbortedCallback(p, p2)
				state.mComponentAbortedCallback = nil
			end
		end,
		SetComponentMessage = function(self, p, p2, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			local v5 = __wf_atom_932a80f8(p2, nil)

			if v5 > 0 then
				module2.ShowErrorMessage(Localize("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", true) .. __wf_atom_f50c9d2d(p2, v5, v5))
				mComponentOperationCallback(true, "Bad character")
			else
				self.mComponentOperationCallback = mComponentOperationCallback
				self.mJsonProcLevelHelper:SetComponentMessage(p, p2)
			end
		end,
		OnComponentMessageSet = function(p, p2, p3)
			if not __wf_atom_7e8ad928(p.mSetComponentMessageCallback) then
				local mSetComponentMessageCallback = p.mSetComponentMessageCallback
				p.mSetComponentMessageCallback = nil
				mSetComponentMessageCallback(p2, p3)
			end
		end,
		SetComponentName = function(self, p, p2, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			local v5 = __wf_atom_932a80f8(p2, nil)

			if v5 > 0 then
				module2.ShowErrorMessage(Localize("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", true) .. __wf_atom_f50c9d2d(p2, v5, v5))
				mComponentOperationCallback(true, "Bad character")
			else
				self.mComponentOperationCallback = mComponentOperationCallback
				self.mJsonProcLevelHelper:SetComponentName(p, p2)
			end
		end,
		OnComponentNameSet = function(p, p2, p3)
			if not __wf_atom_7e8ad928(p.mSetComponentNameCallback) then
				local mSetComponentNameCallback = p.mSetComponentNameCallback
				p.mSetComponentNameCallback = nil
				mSetComponentNameCallback(p2, p3)
			end
		end,
		SetComponentSettings = function(self, p, p2, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:SetComponentSettings(p, p2)
		end,
		OnComponentSettingsSet = function(p, p2, p3)
			if not __wf_atom_7e8ad928(p.mSetComponentSettingsCallback) then
				local mSetComponentSettingsCallback = p.mSetComponentSettingsCallback
				p.mSetComponentSettingsCallback = nil
				mSetComponentSettingsCallback(p2, p3)
			end
		end,
		QueueComponentDestruction = function(self, p, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:QueueComponentDestruction(p, self.mDojo:__wf_atom_a2bfd8e9())
		end,
		CancelComponentDestruction = function(self, p, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:CancelComponentDestruction(p)
		end,
		BuildComponentParams = function(self, p)
			if self.mLevelReloadPending or __wf_atom_7e8ad928(self.mDojo) then
				print("Returning empty component params because a level reload is pending")
				return (Framework.ComponentParams())
			else
				return (self.mDojo:BuildComponentParams(p))
			end
		end,
		SetEmblemForDeco = function(self, p)
			if not self.mJsonProcLevelHelper:__wf_atom_5f39734c() then
				SF.__wf_atom_6ca4e25e(p, self.mJsonProcLevelHelper:__wf_atom_d7d87a7e())
			end
		end,
		OnEmblemRetrieved = function(data)
			for k, _ in pairs(data.mIdToZoneMap) do
				for _, v5 in pairs(data.mIdToPlacedDecos[k]) do
					if __wf_atom_7e8ad928(v5) or not v5:__wf_atom_8bc62c77() then
						continue
					end

					SF.__wf_atom_6ca4e25e(v5, data.mJsonProcLevelHelper:__wf_atom_d7d87a7e())
				end
			end

			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("EmblemDeco"))

			for i = 1, #__wf_atom_2226b35c do
				SF.__wf_atom_6ca4e25e(__wf_atom_2226b35c[i], data.mJsonProcLevelHelper:__wf_atom_d7d87a7e())
			end
		end,
		SubscribeToComponentChanges = function(self)
			local all = gRegion:FindAll(dojoZoneAttribsType)

			for i = 1, #all do
				local componentParams = self:BuildComponentParams(all[i])

				if __wf_atom_7e8ad928(self.mIdToZoneMap[componentParams.id]) then
					self.mIdToZoneMap[componentParams.id] = {}
				end

				table.insert(self.mIdToZoneMap[componentParams.id], all[i]:__wf_atom_e800787c())

				if not (__wf_atom_7e8ad928(self.mIdToZoneAttribs[componentParams.id]) or all[i]:__wf_atom_18aa6e58() < self.mIdToZoneAttribs[componentParams.id]:__wf_atom_18aa6e58()) then
					continue
				end

				self.mIdToZoneAttribs[componentParams.id] = all[i]
			end

			local __wf_atom_10031082 = _T.DojoMgr.mDojo:__wf_atom_10031082()

			if __wf_atom_10031082 ~= "" then
				self.mSpawnRoomId = __wf_atom_10031082
			end

			if self.mSpawnRoomId == "" then
				for k, _ in pairs(self.mIdToZoneMap) do
					self:GetComponentAndSubscribeToChanges(k, self.OnComponentChanged, true)
				end
			else
				self:GetComponentAndSubscribeToChanges(self.mSpawnRoomId, self.OnComponentChanged, true)

				for k, _ in pairs(self.mIdToZoneMap) do
					if k ~= self.mSpawnRoomId then
						self:GetComponentAndSubscribeToChanges(k, self.OnComponentChanged, true)
					end
				end
			end

			if not __wf_atom_7e8ad928(self.mDojoGateDialogTriggerType) then
				local all2 = gRegion:FindAll(self.mDojoGateDialogTriggerType)

				for i = 1, #all2 do
					local componentParams = self:BuildComponentParams(all2[i])

					if componentParams.id == "" then
						continue
					end

					if __wf_atom_7e8ad928(self.mIdToDojoGates[componentParams.id]) then
						self.mIdToDojoGates[componentParams.id] = {}
					end

					table.insert(self.mIdToDojoGates[componentParams.id], all2[i])
				end
			end
		end,
		CreateDeco = function(self, p, p2, object, p3)
			local v5 = nil

			if __wf_atom_7e8ad928(self.mIdToPlacedDecos[p2][object:__wf_atom_854e0028()]) then
				if self:ShouldAttachDecosToZone() then
					if gGameRules:IsA(dojoCustomObstacleCourseGameRules) then
						if gRegion:IsMaster() and not gGameRules:__wf_atom_c2edaf8b() then
							v5 = self.mIdToZoneAttribs[p2]:Attach(
								Type(object.decoType),
								EMPTY_SYMBOL,
								object.pos,
								object.rot,
								nil,
								1
							)
						end
					else
						v5 = self.mIdToZoneAttribs[p2]:Attach(
							Type(object.decoType),
							EMPTY_SYMBOL,
							object.pos,
							object.rot
						)
					end

					if __wf_atom_7e8ad928(v5) and not gGameRules:IsA(dojoCustomObstacleCourseGameRules) then
						print("Entity is null!")
						print("deco type is " .. object.decoType:__wf_atom_5b41f63b())
						print("room id is " .. p2)
						print("deco id is " .. object:__wf_atom_854e0028())
					end
				elseif object:__wf_atom_7d9f7223() == "" then
					v5 = gRegion:CreateEntity(Type(object.decoType), object.pos + p, object.rot, nil)
				else
					v5 = gRegion:CreateEntity(Type(object.decoType), object.pos, object.rot, nil)
				end

				if not __wf_atom_7e8ad928(v5) then
					v5:SetMeshScale(object.scale)
					v5:__wf_atom_b76c96ce(object.socketInfo)

					if object:__wf_atom_7d9f7223():__wf_atom_b70c3343() then
						if self:ShouldAttachDecosToZone() then
							v5:SetId(object:__wf_atom_854e0028())
							v5:__wf_atom_09a93858()
						else
							v5:__wf_atom_d8a07d4f(object:__wf_atom_854e0028(), self.mIdToZoneAttribs[p2])
							v5:__wf_atom_e6ed03c8()
						end
					else
						v5:__wf_atom_fc2dff8b(object:__wf_atom_7d9f7223())
						v5:__wf_atom_e310f01f(object.pos, object.rot)

						if __wf_atom_7e8ad928(self.mDecosToGroup) then
							self.mDecosToGroup = {}
						end

						if __wf_atom_7e8ad928(self.mDecosToGroup[p2]) then
							self.mDecosToGroup[p2] = {}
						end

						self.mDecosToGroup[p2][object:__wf_atom_854e0028()] = v5
					end

					if object.name ~= "" then
						v5:SetName(object.name)
					end

					if _T.PlacingCustomizableDeco then
						if v5:IsA(WeakResource("/Lotus/Types/Game/DojoPlaceableDecorations/ShipPlaceablePictureFrame")) then
							_T.FragmentViewerDeco = v5
							_T.BackgroundMovie:Execute("ShowFragmentScreen", "")
						elseif v5:IsA(v) then
							_T.LightDeco = v5

							if v5:IsA(v2) then
								_T.TextLightMovie = v5:__wf_atom_4f911ec1()
							else
								_T.TextLightMovie = nil
							end

							_T.BackgroundMovie:Execute("ShowLightCustScreen", "")
						end

						_T.PlacingCustomizableDeco = false
					else
						fn(object, v5)
					end

					self.mIdToPlacedDecos[p2][object:__wf_atom_854e0028()] = v5
				end
			else
				v5 = self.mIdToPlacedDecos[p2][object:__wf_atom_854e0028()]
			end

			local __wf_atom_bea1f978 = v5:__wf_atom_bea1f978()
			local mDecoConstructionQueuedMaterialOverride = nil
			local v6, v7

			if object:__wf_atom_644d0f1d() then
				mDecoConstructionQueuedMaterialOverride = self.mDecoConstructionQueuedMaterialOverride
				v6 = 2
				v7 = 2
			elseif object:__wf_atom_47cac5d4() then
				mDecoConstructionQueuedMaterialOverride = self.mDecoUnderConstructionMaterialOverride
				v6 = 3
				v7 = 2
			else
				v6 = 4
				v7 = 1

				if p3 and (not v5:IsA(__wf_atom_0ee166be) or v5:__wf_atom_4126cc96()) then
					local v8 = Vector()
					local v9 = Vector()
					local v10 = Rotation()
					v5:__wf_atom_210b921a(v8, v9, v10)
					v8.x += 0.1
					v8.y += 0.1
					v8.z += 0.1
					local __wf_atom_c072bb51 = gRegion:__wf_atom_c072bb51(v9, v8, v10, playerAvatarType)

					for i = 1, #__wf_atom_c072bb51 do
						if not __wf_atom_c072bb51[i]:__wf_atom_8efce136() then
							continue
						end

						table.insert(self.mDecosOverlappingLocalAvatar, v5)
						mDecoConstructionQueuedMaterialOverride = self.mDojo:__wf_atom_2a059165(2)
						v6 = 1
						v7 = 2
					end
				end
			end

			if v6 ~= __wf_atom_bea1f978 or not gRegion:IsMaster() then
				v5:__wf_atom_c529459a(v6, v7, true, mDecoConstructionQueuedMaterialOverride)

				if v5:__wf_atom_8bc62c77() then
					self:SetEmblemForDeco(v5)
				end
			end
		end,
		OnDecoResourceReady = function(p, p2, p3)
			if not p2 then
				print("Failed to load " .. p3 .. "; cannot make decos!")
				return
			end

			p.mDecoTypesLoaded[p3] = true

			if p.mImmedDecosToCreate[p3] and gGameRules:IsA(__wf_atom_1316e0c2) then
				gGameRules:__wf_atom_ef3cd09e(true)
			end
		end,
		ApplyDecoGrouping = function(state)
			if not __wf_atom_7e8ad928(state.mDecosToGroup) and state.mGameRules:InDojo() then
				local components = state.mDojo:GetComponents()

				for i = 1, #components do
					local component = components[i]
					local __wf_atom_854e0028 = component:__wf_atom_854e0028()

					if
						__wf_atom_7e8ad928(state.mDecosToGroup)
						or __wf_atom_7e8ad928(state.mDecosToGroup[__wf_atom_854e0028])
						or not component:__wf_atom_8598f3a9()
					then
						continue
					end

					if component:__wf_atom_644d0f1d() or component:__wf_atom_47cac5d4() then
						continue
					end

					for _, v5 in pairs(state.mDecosToGroup[__wf_atom_854e0028]) do
						if
							__wf_atom_7e8ad928(v5)
							or __wf_atom_7e8ad928(state.mIdToPlacedDecos[__wf_atom_854e0028][tostring(v5:__wf_atom_7d9f7223())])
						then
							continue
						end

						v5:__wf_atom_6172d87a(
							state.mIdToPlacedDecos[__wf_atom_854e0028][tostring(v5:__wf_atom_7d9f7223())],
							true
						)
						state.mDecosToGroup[__wf_atom_854e0028][v5:__wf_atom_854e0028()] = nil
					end

					if next(state.mDecosToGroup[__wf_atom_854e0028]) == nil then
						state.mDecosToGroup[__wf_atom_854e0028] = nil
					end

					if next(state.mDecosToGroup) == nil then
						state.mDecosToGroup = nil
					end
				end
			end
		end,
		OnComponentChanged = function(object)
			__wf_atom_83c14687(0)
			local dojoMgr = _T.DojoMgr

			if __wf_atom_7e8ad928(dojoMgr.mDecoConstructionQueuedMaterialOverride) then
				dojoMgr.mDecoConstructionQueuedMaterialOverride = dojoMgr.mDojo:__wf_atom_2a059165(0)
			end

			if __wf_atom_7e8ad928(dojoMgr.mDecoUnderConstructionMaterialOverride) then
				dojoMgr.mDecoUnderConstructionMaterialOverride = dojoMgr.mDojo:__wf_atom_2a059165(1)
			end

			if __wf_atom_7e8ad928(dojoMgr.mDecoTypeToDecos) then
				dojoMgr.mDecoTypeToDecos = {}
			end

			local v5 = dojoMgr.mGameRules:InDojo()
			local __wf_atom_854e0028 = object:__wf_atom_854e0028()

			if object:__wf_atom_8598f3a9() then
				local __wf_atom_92221480 = dojoMgr.mJsonProcLevelHelper:__wf_atom_92221480()

				if __wf_atom_7e8ad928(dojoMgr.mIdToPlacedDecos[__wf_atom_854e0028]) then
					dojoMgr.mIdToPlacedDecos[__wf_atom_854e0028] = {}
				end

				local v6 = {}
				local placedDecos = object.placedDecos

				if __wf_atom_854e0028 == dojoMgr.mSpawnRoomId then
					for i = 1, #placedDecos do
						local placedDeco = placedDecos[i]

						if not (v5 or not (placedDeco:__wf_atom_644d0f1d() or placedDeco:__wf_atom_47cac5d4())) then
							continue
						end

						if
							not __wf_atom_7e8ad928(dojoMgr.mIdToPlacedDecos[__wf_atom_854e0028][placedDeco:__wf_atom_854e0028()])
							or __wf_atom_7e8ad928(placedDeco.decoType)
						then
							continue
						end

						local decoType = placedDeco.decoType

						if not (v4 and decoType == v4) then
							continue
						end

						local __wf_atom_5b41f63b = placedDeco.decoType:__wf_atom_5b41f63b()
						local flag

						if __wf_atom_7e8ad928(dojoMgr.mDecoTypeToDecos[__wf_atom_5b41f63b]) then
							dojoMgr.mDecoTypeToDecos[__wf_atom_5b41f63b] = {}
							dojoMgr.mImmedDecosToCreate[__wf_atom_5b41f63b] = {}
							flag = true
						else
							flag = false
						end

						dojoMgr.mDecoTypeToDecos[__wf_atom_5b41f63b][placedDeco:__wf_atom_854e0028()] = __wf_atom_854e0028
						table.insert(dojoMgr.mImmedDecosToCreate[__wf_atom_5b41f63b], {
							RoomId = __wf_atom_854e0028,
							DecoId = placedDeco:__wf_atom_854e0028()
						})
						dojoMgr.mImmedDecoCreateQueue += 1

						if flag then
							dojoMgr.mJsonProcLevelHelper:__wf_atom_e3c390d0(placedDeco)
						end
					end

					if dojoMgr.mImmedDecoCreateQueue > 0 and gGameRules:IsA(__wf_atom_1316e0c2) then
						gGameRules:__wf_atom_ef3cd09e(false)
					end
				end

				for i = 1, #placedDecos do
					local placedDeco = placedDecos[i]

					if v5 or not (placedDeco:__wf_atom_644d0f1d() or placedDeco:__wf_atom_47cac5d4()) then
						local v7 = nil
						local flag = true

						if __wf_atom_7e8ad928(dojoMgr.mIdToPlacedDecos[__wf_atom_854e0028][placedDeco:__wf_atom_854e0028()]) then
							if __wf_atom_7e8ad928(placedDeco.decoType) then
								print("Found Placed Decoration with bad type! Id is: " .. placedDeco:__wf_atom_854e0028())
							else
								local __wf_atom_5b41f63b = placedDeco.decoType:__wf_atom_5b41f63b()
								local flag2

								if __wf_atom_7e8ad928(dojoMgr.mDecoTypeToDecos[__wf_atom_5b41f63b]) then
									flag2 = true
									dojoMgr.mDecoTypeToDecos[__wf_atom_5b41f63b] = {}
									local decoType = placedDeco.decoType

									if v4 and decoType == v4 then
										dojoMgr.mImmedDecosToCreate[__wf_atom_5b41f63b] = {}
									else
										dojoMgr.mDecosToCreate[__wf_atom_5b41f63b] = {}
										dojoMgr.mPrioDecosToCreate[__wf_atom_5b41f63b] = {}
									end
								else
									flag2 = false
								end

								local decoType = placedDeco.decoType

								if v4 and decoType == v4 then
									if dojoMgr.mDecoTypeToDecos[__wf_atom_5b41f63b][placedDeco:__wf_atom_854e0028()] == nil then
										table.insert(dojoMgr.mImmedDecosToCreate[__wf_atom_5b41f63b], {
											RoomId = __wf_atom_854e0028,
											DecoId = placedDeco:__wf_atom_854e0028()
										})
										dojoMgr.mImmedDecoCreateQueue += 1
									end
								elseif __wf_atom_854e0028 == dojoMgr.mSpawnRoomId then
									table.insert(dojoMgr.mPrioDecosToCreate[__wf_atom_5b41f63b], {
										RoomId = __wf_atom_854e0028,
										DecoId = placedDeco:__wf_atom_854e0028()
									})
									dojoMgr.mPrioDecoCreateQueue += 1
								else
									table.insert(dojoMgr.mDecosToCreate[__wf_atom_5b41f63b], {
										RoomId = __wf_atom_854e0028,
										DecoId = placedDeco:__wf_atom_854e0028()
									})
									dojoMgr.mDecoCreateQueue += 1
								end

								dojoMgr.mDecoTypeToDecos[__wf_atom_5b41f63b][placedDeco:__wf_atom_854e0028()] = __wf_atom_854e0028

								if flag2 then
									dojoMgr.mJsonProcLevelHelper:__wf_atom_e3c390d0(placedDeco)
								end
							end
						else
							v7 = dojoMgr.mIdToPlacedDecos[__wf_atom_854e0028][placedDeco:__wf_atom_854e0028()]
							local position = v7:GetPosition()
							local __wf_atom_dc309f8a = v7:__wf_atom_dc309f8a()

							if dojoMgr:ShouldAttachDecosToZone() then
								v7:__wf_atom_d8a07d4f(
									placedDeco:__wf_atom_854e0028(),
									dojoMgr.mIdToZoneAttribs[__wf_atom_854e0028]
								)
								v7:__wf_atom_e310f01f(placedDeco.pos, placedDeco.rot)
								v7:__wf_atom_09a93858()

								if v7:__wf_atom_81803e4e() and placedDeco:__wf_atom_7d9f7223():__wf_atom_b70c3343() then
									v7:__wf_atom_528c8027(false)
								end
							elseif placedDeco:__wf_atom_7d9f7223() == "" then
								if v7:__wf_atom_82e0dd7f() then
									v7:__wf_atom_528c8027(false)
								end

								v7:SetPosition(placedDeco.pos + __wf_atom_92221480)
								v7:__wf_atom_9b788a35(placedDeco.rot)
							else
								v7:__wf_atom_e310f01f(placedDeco.pos, placedDeco.rot)
								local v8 = dojoMgr.mIdToPlacedDecos[__wf_atom_854e0028][tostring(placedDeco:__wf_atom_7d9f7223())]

								if __wf_atom_7e8ad928(v8) then
									if __wf_atom_7e8ad928(dojoMgr.mDecosToGroup) then
										dojoMgr.mDecosToGroup = {}
									end

									if __wf_atom_7e8ad928(dojoMgr.mDecosToGroup[__wf_atom_854e0028]) then
										dojoMgr.mDecosToGroup[__wf_atom_854e0028] = {}
									end

									dojoMgr.mDecosToGroup[__wf_atom_854e0028][placedDeco:__wf_atom_854e0028()] = v7
									v7:__wf_atom_e310f01f(placedDeco.pos, placedDeco.rot)
								else
									v7:__wf_atom_6172d87a(v8, false)
								end
							end

							v7:SetMeshScale(placedDeco.scale)

							if _T.DecoMoveInfo ~= nil and _T.DecoMoveInfo.Deco == v7 then
								_T.DecoMoveInfo.OrigPos = v7:GetPosition()
								_T.DecoMoveInfo.OrigRot = v7:__wf_atom_dc309f8a()
								_T.DecoMoveInfo.OrigScale = v7:__wf_atom_c082fc3d()
								v7:SetPosition(position)
								v7:__wf_atom_9b788a35(__wf_atom_dc309f8a)
								flag = false
							end
						end

						if not __wf_atom_7e8ad928(v7) then
							local __wf_atom_bea1f978 = v7:__wf_atom_bea1f978()
							local __wf_atom_854e0028_2 = placedDeco:__wf_atom_854e0028()
							v6[__wf_atom_854e0028_2] = v7
							local v8 = 1
							local v9 = nil
							local v10 = 2

							if placedDeco:__wf_atom_644d0f1d() or placedDeco:__wf_atom_47cac5d4() then
								v8 = 2
								v9 = module2.Ternary(
									placedDeco:__wf_atom_644d0f1d(),
									dojoMgr.mDecoConstructionQueuedMaterialOverride,
									dojoMgr.mDecoUnderConstructionMaterialOverride
								)

								if placedDeco:__wf_atom_47cac5d4() then
									v10 = 3
								end
							else
								v10 = 4

								if v7:__wf_atom_8bc62c77() then
									dojoMgr:SetEmblemForDeco(v7)
								end
							end

							fn(placedDeco, v7)

							if __wf_atom_bea1f978 ~= v10 then
								if flag then
									v7:__wf_atom_c529459a(v10, v8, true, v9)

									if v7:__wf_atom_81803e4e() then
										v7:__wf_atom_86388d9f(
											dojoMgr.mDecoConstructionQueuedMaterialOverride,
											dojoMgr.mDecoUnderConstructionMaterialOverride
										)
									end
								end

								if dojoMgr.mDecoStatusChangedCallback[__wf_atom_854e0028_2] ~= nil then
									dojoMgr.mDecoStatusChangedCallback[__wf_atom_854e0028_2](
										v7,
										__wf_atom_bea1f978,
										v10
									)
								end
							end
						end
					end

					__wf_atom_83c14687(0)
				end

				local v7 = {}

				for k, v8 in pairs(dojoMgr.mIdToPlacedDecos[__wf_atom_854e0028]) do
					if not __wf_atom_7e8ad928(v6[k]) then
						continue
					end

					if _T.DecoMoveInfo ~= nil and _T.DecoMoveInfo.Deco == v8 then
						local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

						if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
							__wf_atom_c4f78a8f:__wf_atom_a1b79f95():__wf_atom_be6b2a2f():__wf_atom_156e6c2a()
							print("DecoMoveInfo cleared OnComponentChanged")
							_T.DecoMoveInfo = nil
							module2.ShowMessage("/Lotus/Language/Dojo/DecoDestroyedByOther")
						end
					end

					v8:Destroy()
					dojoMgr.mDecoTypeToDecos[v8:__wf_atom_1bb5b1ff():__wf_atom_5b41f63b()][v8:__wf_atom_854e0028()] = nil
					table.insert(v7, k)
				end

				for i = 1, #v7 do
					dojoMgr.mIdToPlacedDecos[__wf_atom_854e0028][v7[i]] = nil
				end

				local v8 = dojoMgr.mIdToZoneMap[__wf_atom_854e0028]

				if not __wf_atom_7e8ad928(v8) then
					if dojoMgr.mDisableSpawnPoints and gRegion:IsMaster() then
						dojoMgr.mDojo:__wf_atom_17be0f71(v8, object:__wf_atom_2dfce0a4())
					end

					if object:__wf_atom_1ed604a8() then
						if __wf_atom_7e8ad928(dojoMgr.mDestructionPendingComponents[__wf_atom_854e0028]) then
							dojoMgr.mDojo:__wf_atom_be49d620(2, v8)
							dojoMgr.mDestructionPendingComponents[__wf_atom_854e0028] = v8
						end
					elseif object:__wf_atom_644d0f1d() then
						if __wf_atom_7e8ad928(dojoMgr.mConstructionQueuedComponents[__wf_atom_854e0028]) then
							dojoMgr.mDojo:__wf_atom_be49d620(0, v8)
							dojoMgr.mConstructionQueuedComponents[__wf_atom_854e0028] = v8
						end
					elseif object:__wf_atom_47cac5d4() then
						if __wf_atom_7e8ad928(dojoMgr.mUnderConstructionComponents[__wf_atom_854e0028]) then
							dojoMgr.mDojo:__wf_atom_be49d620(1, v8)
							dojoMgr.mUnderConstructionComponents[__wf_atom_854e0028] = v8
							dojoMgr.mConstructionQueuedComponents[__wf_atom_854e0028] = nil

							if not __wf_atom_7e8ad928(dojoMgr.mCountdownSeqType) then
								local allInZones = dojoMgr.FindAllInZones(v8, dojoMgr.mCountdownSeqType)

								for i = 1, #allInZones do
									allInZones[i]:FirePort("Enable")
								end
							end
						end
					else
						if __wf_atom_7e8ad928(dojoMgr.mUnderConstructionComponents[__wf_atom_854e0028]) then
							if not __wf_atom_7e8ad928(dojoMgr.mConstructionQueuedComponents[__wf_atom_854e0028]) then
								dojoMgr.mDojo:__wf_atom_7fb257ae(
									dojoMgr.mConstructionQueuedComponents[__wf_atom_854e0028],
									object.prefab
								)
								dojoMgr.mConstructionQueuedComponents[__wf_atom_854e0028] = nil
							end
						else
							dojoMgr.mDojo:__wf_atom_7fb257ae(
								dojoMgr.mUnderConstructionComponents[__wf_atom_854e0028],
								object.prefab
							)
							dojoMgr.mUnderConstructionComponents[__wf_atom_854e0028] = nil

							if not (__wf_atom_7e8ad928(dojoMgr.mCountdownSeqType) or __wf_atom_7e8ad928(dojoMgr.mBuildCompleteSeqType)) then
								local allInZones = dojoMgr.FindAllInZones(v8, dojoMgr.mCountdownSeqType)
								local allInZones2 = dojoMgr.FindAllInZones(v8, dojoMgr.mBuildCompleteSeqType)

								for i = 1, #allInZones do
									allInZones[i]:FirePort("Disable")
								end

								for i = 1, #allInZones2 do
									allInZones2[i]:FirePort("Enable")
								end
							end

							if not dojoMgr.mJsonProcLevelHelper:__wf_atom_5f39734c() then
								local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("EmblemDeco"))

								for i = 1, #__wf_atom_2226b35c do
									SF.__wf_atom_6ca4e25e(
										__wf_atom_2226b35c[i],
										dojoMgr.mJsonProcLevelHelper:__wf_atom_d7d87a7e()
									)
								end
							end
						end

						if not __wf_atom_7e8ad928(dojoMgr.mDestructionPendingComponents[__wf_atom_854e0028]) then
							dojoMgr.mDojo:__wf_atom_7fb257ae(
								dojoMgr.mDestructionPendingComponents[__wf_atom_854e0028],
								object.prefab
							)
							dojoMgr.mDestructionPendingComponents[__wf_atom_854e0028] = nil
						end

						if not __wf_atom_7e8ad928(dojoMgr.mIdToDojoGates[__wf_atom_854e0028]) then
							for i = 1, #dojoMgr.mIdToDojoGates[__wf_atom_854e0028] do
								dojoMgr.mIdToDojoGates[__wf_atom_854e0028][i]:FirePort("Close")
								dojoMgr.mIdToDojoGates[__wf_atom_854e0028][i]:FirePort("Disable")
							end
						end

						if not _T.PaintBotColorsActive then
							if not __wf_atom_7e8ad928(object.colors) then
								dojoMgr:ApplyAllTintsToZoneEntities(v8, object.colors)
							end

							if not __wf_atom_7e8ad928(object.lights) then
								dojoMgr:ApplyAllLightsToZone(v8, object.lights)
							end
						end

						for _, v9 in ipairs(v8) do
							v9:__wf_atom_4219faa8(Symbol(object.name))
						end
					end
				end

				dojoMgr:ApplyRoomSettings(object)
			elseif __wf_atom_854e0028 ~= "" then
				local v6 = dojoMgr.mIdToZoneMap[__wf_atom_854e0028]

				if gRegion:IsMaster() then
					local allInZones = dojoMgr.FindAllInZones(v6, __wf_atom_f51baf83)

					for i = 1, #allInZones do
						allInZones[i]:FirePort("Lock")
					end
				end
			end
		end,
		FindAllInZones = function(list, p)
			if #list == 0 then
				return nil
			end

			local all = list[1]:FindAll(p)

			for i = 2, #list do
				local all2 = list[i]:FindAll(p)

				if all == nil then
					all = all2
				else
					local v5 = #all

					for j = 1, #all2 do
						local v6 = all2[j]
						local flag = true

						for k = 1, v5 do
							if all[k] ~= v6 then
								continue
							end

							flag = false
							break
						end

						if flag then
							table.insert(all, v6)
						end
					end
				end
			end

			return all
		end,
		IsEntityInZones = function(object, list)
			if __wf_atom_7e8ad928(list) or __wf_atom_7e8ad928(object) then
				return false
			end

			local __wf_atom_e800787c = object:__wf_atom_e800787c()

			for i = 1, #list do
				if __wf_atom_e800787c == list[i] then
					return true
				end
			end

			return false
		end,
		ShouldAttachDecosToZone = function(self)
			return not self.mGameRules:IsA(__wf_atom_1316e0c2) or not self.mDojo:__wf_atom_94aa11de()
		end,
		SetComponentColors = function(self, p, p2, p3, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:SetComponentColors(p, p2, p3)
		end,
		SetComponentLights = function(self, p, p2, p3, mComponentOperationCallback)
			if not __wf_atom_7e8ad928(self.mComponentOperationCallback) then
				mComponentOperationCallback(-3, "Already have a component operation pending!")
				return
			end

			self.mComponentOperationCallback = mComponentOperationCallback
			self.mJsonProcLevelHelper:SetComponentLights(p, p2, p3)
		end,
		ApplyAllTintsToZoneEntities = function(self, p, list)
			local v5 = {}

			for i = 1, #list do
				local v6 = list[i]

				if v6:__wf_atom_dcecedb0() == SF.__wf_atom_020e617a:__wf_atom_dcecedb0() then
					v5[#v5 + 1] = -1
					v5[#v5 + 1] = -1
					v5[#v5 + 1] = -1
					v5[#v5 + 1] = -1
				else
					v5[#v5 + 1] = module.SRGBToLinear(v6.red)
					v5[#v5 + 1] = module.SRGBToLinear(v6.green)
					v5[#v5 + 1] = module.SRGBToLinear(v6.blue)
					v5[#v5 + 1] = 1
				end
			end

			if not __wf_atom_7e8ad928(self.mDojo) and self.mDojo:IsA(__wf_atom_d0857c10) then
				self.mDojo:ApplyAllTintsToZoneEntities(p, self.TINT_NAMES, v5)
			end
		end,
		ApplyTintToZoneEntities = function(self, p, p2, object)
			local v5 = object:__wf_atom_dcecedb0() == SF.__wf_atom_020e617a:__wf_atom_dcecedb0()
				and { -1, -1, -1, -1 }
				or {
					module.SRGBToLinear(object.red),
					module.SRGBToLinear(object.green),
					module.SRGBToLinear(object.blue),
					1
				}
			self.mDojo:ApplyTintToZoneEntities(p, p2, v5)
		end,
		ApplyAllLightsToZone = function(self, p, list)
			local v5 = next(self.mDefaultLightColors) == nil
			self.ApplyLightToZone(self, p, self.TINT_NAMES[1], list[1], v5)
			self.ApplyLightToZone(self, p, self.TINT_NAMES[2], list[2], v5)
			self.ApplyLightToZone(self, p, self.TINT_NAMES[3], list[3], v5)
		end,
		ApplyLightToZone = function(data, list, p, object, p2)
			local v5 = object:__wf_atom_dcecedb0() == SF.__wf_atom_020e617a:__wf_atom_dcecedb0()

			if p == data.TINT_NAMES[1] then
				local allInZones = data.FindAllInZones(list, __wf_atom_d00f34c2)

				if not __wf_atom_7e8ad928(allInZones) then
					for i = 1, #allInZones do
						if not (allInZones[i]:__wf_atom_18b12ed1() and allInZones[i]:__wf_atom_bc193479():__wf_atom_8598f3a9()) then
							continue
						end

						if p2 then
							data.mDefaultLightColors[allInZones[i]:__wf_atom_18aa6e58()] = allInZones[i]:GetColor()
						end

						if v5 then
							local __wf_atom_18aa6e58 = allInZones[i]:__wf_atom_18aa6e58()

							if not __wf_atom_7e8ad928(data.mDefaultLightColors[__wf_atom_18aa6e58]) then
								object = data.mDefaultLightColors[__wf_atom_18aa6e58]
							end
						end

						allInZones[i]:SetColor(object)
					end
				end

				local v6 = v5 and { 1, 1, 1, 0 }
					or {
						module.SRGBToLinear(object.red),
						module.SRGBToLinear(object.green),
						module.SRGBToLinear(object.blue),
						1
					}
				local __wf_atom_72a05e4d = object:__wf_atom_72a05e4d()

				if __wf_atom_72a05e4d > 0.01 then
					local v7 = 0.7 / __wf_atom_72a05e4d
					v6[1] *= v7
					v6[2] *= v7
					v6[3] *= v7
				end

				local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("GodRay"))

				if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
					for i = 1, #__wf_atom_2226b35c do
						if data.IsEntityInZones(__wf_atom_2226b35c[i], list) then
							__wf_atom_2226b35c[i]:SetMaterialParam(SF.__wf_atom_3b7bc4af, v6[1], v6[2], v6[3], v6[4])
						end
					end
				end
			elseif p == data.TINT_NAMES[2] then
				for i = 1, #list do
					list[i]:__wf_atom_b753c2fa(not v5)
					list[i]:__wf_atom_c633e405(object)
					list[i]:__wf_atom_3592b868(not v5)
					list[i]:__wf_atom_f232be3d(object)
				end

				local v6 = {}

				for _ = 1, 2 do
					if object:__wf_atom_dcecedb0() == SF.__wf_atom_020e617a:__wf_atom_dcecedb0() then
						v6[#v6 + 1] = -1
						v6[#v6 + 1] = -1
						v6[#v6 + 1] = -1
						v6[#v6 + 1] = -1
					else
						v6[#v6 + 1] = module.SRGBToLinear(object.red)
						v6[#v6 + 1] = module.SRGBToLinear(object.green)
						v6[#v6 + 1] = module.SRGBToLinear(object.blue)
						v6[#v6 + 1] = 1
					end
				end

				local v7 = { SF.__wf_atom_61632308, SF.__wf_atom_405f1ef3 }
				data.mDojo:ApplyAllTintsToZoneEntities(list, v7, v6)
				local allInZones = data.FindAllInZones(list, __wf_atom_d00f34c2)

				if not __wf_atom_7e8ad928(allInZones) then
					for i = 1, #allInZones do
						if
							allInZones[i]:__wf_atom_18b12ed1()
							or not allInZones[i]:__wf_atom_bc193479():__wf_atom_8598f3a9()
						then
							continue
						end

						if p2 then
							data.mDefaultLightColors[allInZones[i]:__wf_atom_18aa6e58()] = allInZones[i]:GetColor()
						end

						if v5 then
							local __wf_atom_18aa6e58 = allInZones[i]:__wf_atom_18aa6e58()

							if not __wf_atom_7e8ad928(data.mDefaultLightColors[__wf_atom_18aa6e58]) then
								object = data.mDefaultLightColors[__wf_atom_18aa6e58]
							end
						end

						allInZones[i]:SetColor(object)
					end
				end
			elseif p == data.TINT_NAMES[3] then
				object.alpha = 255

				for i = 1, #list do
					list[i]:__wf_atom_c858e813(not v5)
					list[i]:__wf_atom_248af10a(object)
					list[i]:__wf_atom_e1bbff52(0.25)
				end
			end
		end,
		HasRoomsCollectingMaterials = function(p)
			local components = p.mDojo:GetComponents()

			for i = 1, #components do
				if components[i]:__wf_atom_644d0f1d() then
					return true
				end
			end

			return false
		end,
		GetMaxBarracksTier = function(p)
			local components = p.mDojo:GetComponents()
			local v5 = {
				["/Lotus/Levels/ClanDojo/ClanDojoBarracksShadow.level"] = 2,
				["/Lotus/Levels/ClanDojo/ClanDojoBarracksStorm.level"] = 3,
				["/Lotus/Levels/ClanDojo/ClanDojoBarracksMountain.level"] = 4,
				["/Lotus/Levels/ClanDojo/ClanDojoBarracksMoon.level"] = 5
			}
			local v6 = 0

			for i = 1, #components do
				if v5[components[i].prefab:__wf_atom_5b41f63b()] ~= nil then
					v6 = math.max(v6, v5[components[i].prefab:__wf_atom_5b41f63b()])
				end
			end

			return v6
		end,
		GetStandaloneComponent = function(p, p2)
			local component = p.mDojo:GetComponent(p2)

			if not component:__wf_atom_8598f3a9() then
				return ""
			end

			local placedDecos = component.placedDecos

			for i = 1, #placedDecos do
				local v5 = p.mIdToPlacedDecos[p2][placedDecos[i]:__wf_atom_854e0028()]

				if not __wf_atom_7e8ad928(v5) then
					component:__wf_atom_1c895a9d(i, v5:__wf_atom_fa6a8faf(), v5:__wf_atom_45c0553e(true))
				end
			end

			return component
		end,
		EnterPlacementMode = function(p, dojoPlacingRecipe, p2, p3)
			if __wf_atom_7e8ad928(dojoPlacingRecipe) then
				return false
			end

			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			local __wf_atom_be6b2a2f = __wf_atom_c4f78a8f:__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

			if
				__wf_atom_7e8ad928(__wf_atom_be6b2a2f)
				or not __wf_atom_be6b2a2f:IsA(__wf_atom_0097d4df)
				or __wf_atom_be6b2a2f:__wf_atom_4d37592a()
			then
				return false
			end

			_T.VaultDeco = false
			__wf_atom_c4f78a8f:__wf_atom_a96eb2aa():__wf_atom_301e8d97():__wf_atom_78443212(Localize("/Lotus/Language/Dojo/PlacementMode", true))
			__wf_atom_be6b2a2f:__wf_atom_8c7019a4(
				dojoPlacingRecipe:__wf_atom_dcaa99d5(),
				p.mIdToZoneMap[p2],
				p2,
				dojoPlacingRecipe:__wf_atom_1f01e1ad(),
				p3
			)
			_T.DojoPlacingRecipe = dojoPlacingRecipe
			return true
		end,
		EnterGroupedPlacementMode = function(p, dojoPlacingGroup, p2, p3)
			if __wf_atom_7e8ad928(dojoPlacingGroup) then
				return false
			end

			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				return false
			end

			local v5 = Resource(dojoRecipeManifest)
			local __wf_atom_58b2e21e = __wf_atom_c4f78a8f:__wf_atom_e800787c():__wf_atom_58b2e21e()
			local componentParams = _T.DojoMgr:BuildComponentParams(__wf_atom_58b2e21e)

			if not dojoPlacingGroup:__wf_atom_c9d0d817(v5, (_T.DojoMgr.mDojo:GetJsonComponent(componentParams))) then
				return false
			end

			local __wf_atom_be6b2a2f = __wf_atom_c4f78a8f:__wf_atom_a1b79f95():__wf_atom_be6b2a2f()

			if
				__wf_atom_7e8ad928(__wf_atom_be6b2a2f)
				or not __wf_atom_be6b2a2f:IsA(__wf_atom_0097d4df)
				or __wf_atom_be6b2a2f:__wf_atom_4d37592a()
			then
				return false
			end

			_T.VaultDeco = false
			__wf_atom_c4f78a8f:__wf_atom_a96eb2aa():__wf_atom_301e8d97():__wf_atom_78443212(Localize("/Lotus/Language/Dojo/PlacementMode", true))
			__wf_atom_be6b2a2f:__wf_atom_8741e469(dojoPlacingGroup, p.mIdToZoneMap[p2], p2, Range(1, 1), p3)
			_T.DojoPlacingGroup = dojoPlacingGroup
			return true
		end,
		AddDecoStatusChangedCallback = function(p, p2, p3)
			p.mDecoStatusChangedCallback[p2] = p3
		end,
		AddDecoFocusChangedCallback = function(p, p2, p3)
			p.mDecoFocusChangedCallback[p2] = p3
		end,
		AddDecoSelectedCallback = function(p, p2, p3)
			p.mDecoSelectedCallback[p2] = p3
		end,
		ApplyRoomSettings = function(self, _) end,
		HasSwappableBackdrop = function(self, p)
			for _, v5 in ipairs(v3) do
				if p.prefab == v5 then
					return true
				end
			end

			return false
		end,
		RefreshOpenSpaceBackdrop = function(_, p, p2)
			fn7(p, p2)
		end,
		RefreshAllDojoBackdrops = function(self)
			local components = self.mDojo:GetComponents()

			for i = 1, #components do
				local component = components[i]

				if not self:HasSwappableBackdrop(component) then
					continue
				end

				local __wf_atom_19ba9236 = component:__wf_atom_19ba9236()
				local decoded = cjson.decode(__wf_atom_19ba9236)

				if decoded ~= nil and decoded.backdropId ~= nil then
					fn7(decoded.backdropId, component.id.mId)
				end
			end
		end
	}
end