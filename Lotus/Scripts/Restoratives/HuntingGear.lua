local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("Lotus.Scripts.Libs.ConservationLib")
local module3 = require("Lotus.Scripts.Libs.GearLib")
local v = nil
local v2 = nil
local v3 = nil
local v4 = 0
local v5 = false

local function fn(instance)
	if __wf_atom_7e8ad928(instance) then
		return false
	end

	local v6 = -1

	for i = 1, #animalStartMarkerTypes do
		if instance:IsA(animalStartMarkerTypes[i]) then
			v6 = i
		end
	end

	if v6 > 0 then
		local animalLureGearItemType = animalLureGearItemTypes[v6]
		local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()

		if not (__wf_atom_7e8ad928(__wf_atom_9be88b01) or __wf_atom_7e8ad928(__wf_atom_9be88b01:GetInventory())) then
			return __wf_atom_9be88b01:GetInventory():__wf_atom_6e1a4664(animalLureGearItemType)
		end
	end

	return false
end

local function fn2(p)
	local all = gRegion:FindAll(baseAnimalStartMarkerType)

	for i = 1, #all do
		if __wf_atom_7e8ad928(all[i]) or not fn(all[i]) then
			continue
		end

		if p == true and all[i]:IsEnabled() == false then
			all[i]:Enable()
		elseif p == false and all[i]:IsEnabled() == true then
			all[i]:Disable()
		end
	end
end

local function fn3(instance, _)
	local v6 = module3.TryEquipGear(instance, weaponType)

	if v6 ~= module3.EquipResult.ALREADY_EQUIPPED then
		return v6 ~= module3.EquipResult.FAIL
	end

	if gRegion:IsMaster() then
		instance:__wf_atom_9373d0eb(20, false)
		module3.UnequipGear(instance, weaponType)
	end

	if instance:__wf_atom_4417a5d4() then
		fn2(false)
	end

	return false
end

local function fn4(instance)
	v4 -= __wf_atom_084b3e93()

	if v4 > 0 then
		return
	end

	v4 = 1.5
	local all = gRegion:FindAll(baseAnimalType, instance:GetPosition(), 0, pulseRangeThreshold)
	local v6 = false

	for i = 1, #all do
		local v7 = all[i]

		if not __wf_atom_7e8ad928((v7:__wf_atom_bb3e7833(pulseFX))) then
			continue
		end

		v7:Attach(pulseFX, EMPTY_SYMBOL)
		v6 = true
	end

	if v6 == true then
		instance:PlaySound(pulseSound, false, 0, false)
	end
end

function Hunt(instance, object)
	if not _T.gHunting then
		_T.gHunting = {}
	end

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_8efce136 = instance:__wf_atom_8efce136()
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()

	if fn3(instance, __wf_atom_d2b2176d) then
		local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

		while __wf_atom_7e8ad928(__wf_atom_35a10d3c) or not __wf_atom_35a10d3c:IsA(weaponType) do
			Sleep(0)

			if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				return
			else
				__wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)
			end
		end

		local getEquipStatus = module3.GetEquipStatus
		local unequipped = module3.EquipStatus.UNEQUIPPED
		v = instance:__wf_atom_a96eb2aa()

		if __wf_atom_8efce136 then
			v2 = instance
			v3 = object
			instance:CameraControl()
			local __wf_atom_d2b2176d2 = instance:__wf_atom_d2b2176d()

			if not __wf_atom_7e8ad928(__wf_atom_d2b2176d2) then
				__wf_atom_d2b2176d2:__wf_atom_69213775(subGearSelector, object:__wf_atom_1bb5b1ff())
			end

			Sleep(0)

			if instance:__wf_atom_4417a5d4() then
				fn2(true)
			end

			if __wf_atom_8efce136 then
				_T.gHunting.active = true
			end

			local v6 = 0

			while not __wf_atom_7e8ad928(instance) do
				if instance:__wf_atom_bedb4e3f() or instance:IsKilled() then
					if not instance:__wf_atom_4417a5d4() then
						break
					end

					fn2(false)
					break
				else
					local v7 = instance:__wf_atom_7b82e9e1(0) and 1 or -1
					v6 = __wf_atom_421b01aa(v6 + __wf_atom_084b3e93() * v7 * 3, 0, 1)
					instance:CameraControl()

					if v6 >= 1 then
						fn4(instance)
					end

					if getEquipStatus(__wf_atom_d2b2176d2, weaponType, v) == unequipped then
						if not instance:__wf_atom_4417a5d4() then
							break
						end

						fn2(false)
						break
					else
						local v8 = __wf_atom_8efce136
							and module2.GetCurrentConservationEncounterState() >= module2.states.SPAWNED

						if v8 ~= v5 then
							if v8 then
								if not __wf_atom_7e8ad928(_T.gHunting.exitSensingHelper) then
									_T.gHunting.exitSensingHelper:Destroy()
								end

								if __wf_atom_7e8ad928(_T.gHunting.enterSensingHelper) then
									_T.gHunting.enterSensingHelper = gRegion:CreateEntity(
										huntingSenseEnterHelper,
										instance:GetPosition(),
										__wf_atom_80368bb1,
										instance
									)
								end
							else
								if not __wf_atom_7e8ad928(_T.gHunting.enterSensingHelper) then
									_T.gHunting.enterSensingHelper:Destroy()
								end

								if __wf_atom_7e8ad928(_T.gHunting.exitSensingHelper) then
									_T.gHunting.exitSensingHelper = gRegion:CreateEntity(
										huntingSenseExitHelper,
										instance:GetPosition(),
										__wf_atom_80368bb1,
										instance
									)
								end
							end

							v5 = v8
						end

						Sleep(0)
					end
				end
			end

			if __wf_atom_8efce136 then
				_T.gHunting.active = false

				if v5 and not __wf_atom_7e8ad928(_T.gHunting.enterSensingHelper) then
					_T.gHunting.enterSensingHelper:Destroy()

					if __wf_atom_7e8ad928(instance) then
						instance = gRegion:__wf_atom_c4f78a8f()
					end

					_T.gHunting.exitSensingHelper = gRegion:CreateEntity(
						huntingSenseExitHelper,
						instance:GetPosition(),
						__wf_atom_80368bb1,
						instance
					)
					Sleep(1)

					if not __wf_atom_7e8ad928(_T.gHunting.exitSensingHelper) then
						_T.gHunting.exitSensingHelper:Destroy()
					end
				end
			end

			if gRegion:IsMaster() then
				instance:__wf_atom_9373d0eb(20, false)
				module3.UnequipGear(instance, weaponType)
			end
		elseif gRegion:IsMaster() then
			local isA = instance:IsA(__wf_atom_c0fefb76)
			local __wf_atom_7470861b = instance:__wf_atom_7470861b()
			local __wf_atom_d2b2176d2 = instance:__wf_atom_d2b2176d()
			local v6 = false

			while
				not __wf_atom_7e8ad928(instance)
				and not instance:IsKilled()
				and not __wf_atom_7470861b:__wf_atom_bedb4e3f()
				and getEquipStatus(__wf_atom_d2b2176d2, weaponType, v) ~= unequipped
			do
				if isA then
					local __wf_atom_7b82e9e1 = instance:__wf_atom_7b82e9e1(0)

					if __wf_atom_7b82e9e1 ~= v6 then
						instance:__wf_atom_9373d0eb(20, __wf_atom_7b82e9e1)
						v6 = __wf_atom_7b82e9e1
					end
				end

				Sleep(0)
			end

			instance:__wf_atom_9373d0eb(20, false)
			module3.UnequipGear(instance, weaponType)
		end
	elseif __wf_atom_8efce136 then
		_T.gHunting.active = false
	end
end

function CanTranq(instance)
	local __wf_atom_35a10d3c = instance:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and __wf_atom_35a10d3c:IsA(weaponType) then
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

	if module.IsEquippingGearItem(instance) then
		return false
	end

	return not (instance:__wf_atom_7b82e9e1(5) or instance:__wf_atom_d2b2176d():__wf_atom_9f71ab59())
end

function Deactivate(object, _)
	if gRegion:IsMaster() then
		object:__wf_atom_9373d0eb(20, false)
		module3.UnequipGear(object, weaponType)
	end

	if __wf_atom_7e8ad928(object) or not object:__wf_atom_8efce136() then
		return
	end

	if _T.gHunting then
		_T.gHunting.active = false
	end

	if object:__wf_atom_4417a5d4() then
		fn2(false)
	end
end