local module = require("Lotus.Scripts.Libs.TransmissionSet")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Scripts.Libs.ConservationLib")
local module4 = require("Lotus.Scripts.Libs.GearLib")
local v = nil
local v2 = nil
local v3 = false
local v4 = 0
local frequencyMeter = 0
local v5 = __wf_atom_10cd16b2(0, 0.15)
local lureSequencer = nil
local v6 = false
local gHuntingTransmissionSet = nil
local v7 = Symbol("__ALL_ANIMALS__")
local v8 = false
local v9 = false
local total = 0
local v10 = 0

local function fn(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(animalStartMarkerTag)

	for i = 1, #__wf_atom_2226b35c do
		if __wf_atom_7e8ad928(__wf_atom_2226b35c[i]) then
			continue
		end

		if p == true and __wf_atom_2226b35c[i]:IsEnabled() == false then
			__wf_atom_2226b35c[i]:Enable()
		elseif p == false and __wf_atom_2226b35c[i]:IsEnabled() == true then
			__wf_atom_2226b35c[i]:Disable()
		end
	end
end

local function fn2(instance, object)
	if _T.lastGearWeaponSlot == nil then
		_T.lastGearWeaponSlot = {}
	end

	local __wf_atom_18aa6e58 = instance:__wf_atom_18aa6e58()
	local v11 = module4.TryEquipGear(instance, lureWeaponType)

	if v11 == module4.EquipResult.ALREADY_EQUIPPED then
		local _ = _T.gHunting[__wf_atom_18aa6e58].currentAnimalId == animalId

		if gRegion:IsMaster() and not instance:IsA(__wf_atom_c0fefb76) then
			object:Equip(2, 0, 0)
		end
	elseif v11 == module4.EquipResult.FAIL then
		return false
	end

	_T.gHunting[__wf_atom_18aa6e58].currentAnimalId = animalId
	return true
end

local function fn3(object)
	if
		not __wf_atom_7e8ad928(object)
		and object:__wf_atom_8efce136()
		and v9
		and not __wf_atom_7e8ad928(_T.gHunting.enterSensingHelper)
	then
		_T.gHunting.enterSensingHelper:Destroy()

		if __wf_atom_7e8ad928(object) then
			object = gRegion:__wf_atom_c4f78a8f()
		end

		_T.gHunting.exitSensingHelper = gRegion:CreateEntity(
			huntingSenseExitHelper,
			object:GetPosition(),
			__wf_atom_80368bb1,
			object
		)
		Sleep(1)

		if not __wf_atom_7e8ad928(_T.gHunting.exitSensingHelper) then
			_T.gHunting.exitSensingHelper:Destroy()
		end
	end
end

function AnimalLure(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_8efce136 = object:__wf_atom_8efce136()

	if not _T.gHunting then
		_T.gHunting = {}
	end

	local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

	if not _T.gHunting[__wf_atom_18aa6e58] then
		_T.gHunting[__wf_atom_18aa6e58] = {}
	end

	gHuntingTransmissionSet = _T.gHuntingTransmissionSet
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if fn2(object, __wf_atom_d2b2176d) then
		local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

		while __wf_atom_7e8ad928(__wf_atom_35a10d3c) or not __wf_atom_35a10d3c:IsA(lureWeaponType) do
			Sleep(0)

			if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				return
			else
				__wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)
			end
		end

		Sleep(0)

		if __wf_atom_8efce136 then
			fn(true)
		end

		v = object
		v2 = object:__wf_atom_a96eb2aa()
		local v11 = 0

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			__wf_atom_d2b2176d:__wf_atom_69213775(subGearSelector, object2:__wf_atom_1bb5b1ff())
		end

		Sleep(0)

		if __wf_atom_8efce136 then
			_T.gHunting.active = true
		end

		local getEquipStatus = module4.GetEquipStatus
		local unequipped = module4.EquipStatus.UNEQUIPPED
		local paused = module4.EquipStatus.PAUSED
		local v12 = false

		while true do
			local v13

			if __wf_atom_7e8ad928(object) or object:__wf_atom_bedb4e3f() or object:IsKilled() then
				v13 = true
			else
				local __wf_atom_18aa6e58_2 = object:__wf_atom_18aa6e58()
				v13 = animalId ~= v7 and _T.gHunting[__wf_atom_18aa6e58_2].currentAnimalId ~= animalId
			end

			if v13 then
				break
			end

			local equipStatus = getEquipStatus(__wf_atom_d2b2176d, lureWeaponType, v2)

			if equipStatus == unequipped then
				break
			end

			local v14 = equipStatus == paused

			if v12 ~= v14 and v14 then
				fn3(object)
				v3 = false
				frequencyMeter = 0
				v12 = v14
			end

			if not v14 then
				local v15 = object:__wf_atom_7b82e9e1(0) and 1 or -1
				v11 = __wf_atom_421b01aa(v11 + __wf_atom_084b3e93() * v15 * 3, 0, 1)
				local __wf_atom_35a10d3c2 = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)
				local pitch = object:__wf_atom_92aa9d91():__wf_atom_760b1c25().pitch
				local animalLureFiring = object:__wf_atom_ead6242d() and __wf_atom_35a10d3c2:IsA(lureWeaponType)
				local position = object:GetPosition()
				local v16 = pitch - v4

				if __wf_atom_8efce136 then
					_T.AnimalLureFiring = animalLureFiring
				end

				frequencyMeter = __wf_atom_421b01aa(frequencyMeter + v16 * 0.12, -1, 1)

				if __wf_atom_8efce136 then
					_T.FrequencyMeter = frequencyMeter
				end

				local isLocalAvatarInCallPoint = __wf_atom_8efce136
					and (_T.gHunting.isLocalAvatarInCallPoint or module3.GetCurrentConservationEncounterState() >= module3.states.SPAWNED)

				if isLocalAvatarInCallPoint ~= v9 then
					if isLocalAvatarInCallPoint then
						if not __wf_atom_7e8ad928(_T.gHunting.exitSensingHelper) then
							_T.gHunting.exitSensingHelper:Destroy()
						end

						if __wf_atom_7e8ad928(_T.gHunting.enterSensingHelper) then
							_T.gHunting.enterSensingHelper = gRegion:CreateEntity(
								huntingSenseEnterHelper,
								position,
								__wf_atom_80368bb1,
								object
							)
						end
					else
						if not __wf_atom_7e8ad928(_T.gHunting.enterSensingHelper) then
							_T.gHunting.enterSensingHelper:Destroy()
						end

						if __wf_atom_7e8ad928(_T.gHunting.exitSensingHelper) then
							_T.gHunting.exitSensingHelper = gRegion:CreateEntity(
								huntingSenseExitHelper,
								position,
								__wf_atom_80368bb1,
								object
							)
						end
					end

					v9 = isLocalAvatarInCallPoint
				end

				if animalLureFiring then
					if v3 == animalLureFiring then
						v5:__wf_atom_09294a87(frequencyMeter)
						v5:Update(__wf_atom_084b3e93())
					else
						v8 = false

						if not __wf_atom_7e8ad928(soundSequencerType) and __wf_atom_7e8ad928(lureSequencer) then
							lureSequencer = object:Attach(soundSequencerType, EMPTY_SYMBOL)
							_T.gHunting.lureSequencer = lureSequencer
						end

						if not (__wf_atom_7e8ad928(lureSequencer) or lureSequencer:IsEnabled()) then
							lureSequencer:Enable()
						end

						v5:__wf_atom_4453e49c(frequencyMeter)
						total = 0
						v6 = false
					end

					local v17 = nil

					if not __wf_atom_7e8ad928(lureSequencer) then
						local __wf_atom_fea764d9 = lureSequencer:__wf_atom_fea764d9()
						_T.AnimalLureSoundAmplitude = 0

						for i = 1, #__wf_atom_fea764d9 do
							local v18 = __wf_atom_fea764d9[i]

							if __wf_atom_7e8ad928(v18) then
								continue
							end

							if i == 1 then
								if not v6 then
									v18:__wf_atom_381473bc(false)
									v10 = v18:__wf_atom_53a51c90()
									v6 = true
								end

								v17 = v18:__wf_atom_946fdac0()
							end

							v18:__wf_atom_4ec021c2(0, __wf_atom_421b01aa(-v5:__wf_atom_9e368823(), 0, 1))
							v18:__wf_atom_4ec021c2(1, __wf_atom_421b01aa(v5:__wf_atom_9e368823(), 0, 1))
							v18:__wf_atom_4ec021c2(2, 0)
							v18:__wf_atom_4ec021c2(3, 0)
							_T.AnimalLureSoundAmplitude = _T.AnimalLureSoundAmplitude + v18:__wf_atom_31aab74c()
						end

						if v17 and v17 <= 0 and __wf_atom_35a10d3c2:GetState() == 1 then
							__wf_atom_d2b2176d:__wf_atom_28cf035c()
						end
					end

					if v17 and __wf_atom_8efce136 and _T.gHunting.isLocalAvatarInCallPoint then
						local nearestTagged = gRegion:FindNearestTagged(module3.callPointTag, position)

						if not __wf_atom_7e8ad928(nearestTagged) then
							local __wf_atom_3d96ddcd = nearestTagged:__wf_atom_3d96ddcd()
							local v18 = animalId == v7 or __wf_atom_3d96ddcd:HasTag(animalId)
							local currentConservationEncounterState = module3.GetCurrentConservationEncounterState()

							if
								currentConservationEncounterState == module3.states.INITIALIZED
								and v17 <= 0.1
								and not v8
							then
								if v18 then
									module3:InitiatePitchGame()
									v8 = true
								else
									module.PlayGlobalTransmission(gHuntingTransmissionSet, Symbol("WrongLure"))
								end
							elseif
								currentConservationEncounterState == module3.states.DOING_PITCH_MATCHING
								and _T.lureTargetGain
							then
								local lureTargetGain = _T.lureTargetGain

								if isDebug then
									__wf_atom_f2daf912("Current Gain: " .. frequencyMeter .. " Target Gain: " .. lureTargetGain)
								end

								if Abs(frequencyMeter - lureTargetGain) < targetAllowanceThreshold or isDemo then
									total += __wf_atom_084b3e93()
								end

								if v17 <= 0 then
									local v19 = total / v10 > requiredCallRating

									if v18 then
										if v19 then
											module3:PitchGameMatch()
										else
											module.PlayGlobalTransmission(
												gHuntingTransmissionSet,
												Symbol("HuntHoldLure")
											)
										end
									else
										module.PlayGlobalTransmission(gHuntingTransmissionSet, Symbol("WrongLure"))
									end
								end
							end
						end
					end
				elseif v3 ~= animalLureFiring then
					if not __wf_atom_7e8ad928(lureSequencer) then
						lureSequencer:Disable()
						lureSequencer:Destroy()
						frequencyMeter = 0
						_T.AnimalLureSoundAmplitude = 0
					end

					frequencyMeter = 0
				end

				v3 = animalLureFiring
				v4 = pitch
			end

			Sleep(0)
		end

		if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
			fn(false)
		end

		if __wf_atom_8efce136 then
			_T.gHunting.active = false
			fn3(object)
		end

		if gRegion:IsMaster() then
			object:__wf_atom_9373d0eb(20, false)
			module4.UnequipGear(object, lureWeaponType)
		end
	elseif __wf_atom_8efce136 then
		_T.gHunting.active = false
	end
end

function CanLure(instance)
	local __wf_atom_35a10d3c = instance:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		local state = __wf_atom_35a10d3c:GetState()

		if state == 15 or state == 16 or state == 17 then
			return false
		end
	end

	if
		instance:IsA(__wf_atom_c0fefb76)
		or (not instance:__wf_atom_d2b2176d():__wf_atom_3a8378da() or instance:__wf_atom_7b82e9e1(5))
	then
		return false
	end

	if
		module2.IsEquippingGearItem(instance)
		or (instance:__wf_atom_7b82e9e1(5) or instance:__wf_atom_d2b2176d():__wf_atom_9f71ab59())
	then
		return false
	end

	return gGameRules:__wf_atom_72fc675e().archwingRequired ~= true and gGameRules:__wf_atom_0fa72b69() ~= 32
end

function Deactivate(object, _)
	if gRegion:IsMaster() then
		object:__wf_atom_9373d0eb(20, false)
		module4.UnequipGear(object, lureWeaponType)
	end

	if __wf_atom_7e8ad928(object) or not object:__wf_atom_8efce136() then
		return
	end

	if _T.gHunting then
		_T.gHunting.active = false
	end

	if object:__wf_atom_4417a5d4() then
		fn(false)
	end
end