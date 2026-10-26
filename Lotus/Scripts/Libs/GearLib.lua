local equipStatus = { UNEQUIPPED = 0, EQUIPPED = 1, PAUSED = 2 }
local equipResult = { SUCCESS = 0, FAIL = 1, ALREADY_EQUIPPED = 2 }
local GearLib = {}

function GearLib.TryEquipGear(instance, className, p, callback)
	if _T.prevGearSlots == nil then
		_T.prevGearSlots = {}
	end

	local v = __wf_atom_7e8ad928(p) and 2 or p

	if __wf_atom_7e8ad928(instance) then
		return equipResult.FAIL
	end

	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		print("no weapon in main hand")
	elseif __wf_atom_35a10d3c:IsA(className) then
		print("gearlib: requested gear already equipped")
		return equipResult.ALREADY_EQUIPPED
	end

	if not gRegion:IsMaster() then
		return equipResult.SUCCESS
	end

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		local __wf_atom_55da7898 = __wf_atom_35a10d3c:__wf_atom_55da7898()

		if __wf_atom_55da7898 ~= v then
			_T.prevGearSlots[instance:__wf_atom_18aa6e58()] = __wf_atom_55da7898
		end
	end

	local v2 = instance:IsA(__wf_atom_c0fefb76) and 2 or 0
	instance:GiveItem(className, false)

	if not __wf_atom_7e8ad928(callback) then
		callback(true, instance)
	end

	local __wf_atom_3a8378da = __wf_atom_d2b2176d:__wf_atom_3a8378da()

	if not __wf_atom_3a8378da then
		local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

		if
			not __wf_atom_7e8ad928(__wf_atom_3d96ddcd)
			and __wf_atom_3d96ddcd:IsA(__wf_atom_47cae841)
			and __wf_atom_3d96ddcd:__wf_atom_4221009f() == instance
		then
			__wf_atom_d2b2176d:__wf_atom_b9375444(true)
		end
	end

	__wf_atom_d2b2176d:Equip(v, 0, v2)
	__wf_atom_d2b2176d:__wf_atom_b9375444(__wf_atom_3a8378da)
	return equipResult.SUCCESS
end

function GearLib.UnequipGear(instance, className, p)
	if __wf_atom_7e8ad928(instance) or not (gRegion:IsMaster() or instance:__wf_atom_4417a5d4()) then
		return
	end

	if _T.prevGearSlots == nil then
		_T.prevGearSlots = {}
	end

	local v = __wf_atom_7e8ad928(p) and 2 or p
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local __wf_atom_18aa6e58 = instance:__wf_atom_18aa6e58()

	if not instance:__wf_atom_bedb4e3f() then
		local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

		if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
			if __wf_atom_35a10d3c:IsA(className) then
				local v2 = instance:IsA(__wf_atom_c0fefb76) and 2 or 0

				if _T.prevGearSlots[__wf_atom_18aa6e58] then
					__wf_atom_d2b2176d:Equip(_T.prevGearSlots[__wf_atom_18aa6e58], 0, v2)
				else
					__wf_atom_d2b2176d:Unequip(0, v2)
				end

				_T.prevGearSlots[__wf_atom_18aa6e58] = nil
			elseif __wf_atom_35a10d3c:__wf_atom_55da7898() ~= v then
				_T.prevGearSlots[__wf_atom_18aa6e58] = nil
			end
		end
	end

	instance:RemoveItem(className)
end

function GearLib.GetEquipStatus(object, className, object2, p)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(className) then
		return equipStatus.UNEQUIPPED
	end

	local __wf_atom_28224c27 = object:__wf_atom_28224c27(__wf_atom_7e8ad928(p) and 2 or p)

	if not (__wf_atom_7e8ad928(__wf_atom_28224c27) or __wf_atom_28224c27:IsA(className)) then
		return equipStatus.UNEQUIPPED
	end

	local __wf_atom_35a10d3c = object:__wf_atom_35a10d3c(0)

	if __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		if not __wf_atom_7e8ad928(object2) then
			local __wf_atom_50a7d83e = object2:__wf_atom_50a7d83e()

			if
				__wf_atom_7e8ad928(__wf_atom_50a7d83e)
				or __wf_atom_50a7d83e:__wf_atom_a96eb2aa() ~= object2
				or __wf_atom_50a7d83e:IsA(__wf_atom_47cae841)
			then
				return equipStatus.PAUSED
			end

			return equipStatus.UNEQUIPPED
		end
	elseif __wf_atom_35a10d3c ~= __wf_atom_28224c27 then
		if __wf_atom_35a10d3c:IsA(__wf_atom_77e05d3b) or __wf_atom_35a10d3c:__wf_atom_0395f752() == 11 then
			return equipStatus.PAUSED
		end

		return equipStatus.UNEQUIPPED
	end

	return equipStatus.EQUIPPED
end

GearLib.EquipStatus = equipStatus
GearLib.EquipResult = equipResult
return GearLib