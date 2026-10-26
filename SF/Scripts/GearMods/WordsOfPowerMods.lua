local v = nil
local v2 = nil
local v3 = nil

local function fn(p) -- 2 equivalent calls inferred from this helper
	return cooldownReduction + cooldownReductionPerLevel * (p - 1)
end

function GetAbilityStats(p, _, _, _, _, _)
	local v4 = { BONUS = fn(p) } -- inferred equivalent call
	return cjson.encode(v4)
end

function IsAnyAbilityOnCoolDown(object)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return false
	end

	local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

	for i = 2, #__wf_atom_36b4a6e5 do
		local v4 = __wf_atom_36b4a6e5[i]

		if not __wf_atom_7e8ad928(v4) and v4:__wf_atom_ca98158b() then
			return false
		end
	end

	return true
end

function CreateFlowPoint(object)
	if not gRegion:IsMaster() then
		return
	end

	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if #flowSources > 1 then
		v3 = flowSources[1]
	else
		v3 = flowSources[math.random(1, #flowSources)]
	end

	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local v4 = object:__wf_atom_a2a18137() + __wf_atom_9341614d(Vector(2, 0, 2), object:__wf_atom_4e50d390())
	local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(v4, distance, 1)
	gRegion:CreateEntity(v3, __wf_atom_0e0a6fee, __wf_atom_dc309f8a)
end

local function fn2(p) -- 2 equivalent calls inferred from this helper
	for _, v4 in validAttribs do
		if p == v4 then
			return true
		end
	end

	return false
end

function ReduceActivePowerCooldowns(object, _, p, _, _)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

	for i = 2, #__wf_atom_36b4a6e5 do
		local v4 = __wf_atom_36b4a6e5[i]

		if
			__wf_atom_7e8ad928(v4)
			or not v4:__wf_atom_ca98158b()
			or not fn2(__wf_atom_e55d02aa:__wf_atom_2e4994f1(i - 1)) -- inferred equivalent call
		then
			continue
		end

		v4:__wf_atom_80e49f0d(v4:__wf_atom_1fcd5380() - fn(p)) -- inferred equivalent call
	end
end

function RefundFlowCost(_, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_36b4a6e5 = object:__wf_atom_36b4a6e5()

	for i = 2, #__wf_atom_36b4a6e5 do
		local v4 = __wf_atom_36b4a6e5[i]

		if __wf_atom_7e8ad928(v4) or not v4:__wf_atom_fb998937() or not fn2(object:__wf_atom_2e4994f1(i - 1)) then -- inferred equivalent call
			continue
		end

		v4:__wf_atom_dcd5fcd6()
	end
end

function IsMoving(object)
	local __wf_atom_08998754 = object:__wf_atom_08998754()
	local v4 = Time()

	if object:__wf_atom_7b82e9e1(15) or object:__wf_atom_7b82e9e1(4) or object:__wf_atom_7b82e9e1(5) then
		return false
	end

	local v5 = Length(object:MotionControl():__wf_atom_0cf4ee4b()) > 0.1
	local __wf_atom_cc1fa73e = object:__wf_atom_cc1fa73e(0.01)

	if
		v5
		and __wf_atom_cc1fa73e
		and (__wf_atom_08998754 == 0 or __wf_atom_08998754 == 1 or __wf_atom_08998754 == 2)
	then
		return false
	end

	if v == nil then
		v = v4
	end

	if v4 - v > timeHeldStill then
		v = nil
		return true
	end
end

function IsThrownItemEmbedded(object)
	local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(5)

	if __wf_atom_7e8ad928(__wf_atom_28224c27) then
		return false
	end

	for i = 0, __wf_atom_28224c27:__wf_atom_ca3e110b() - 1 do
		local __wf_atom_414f70dd = __wf_atom_28224c27:__wf_atom_414f70dd(i)

		if __wf_atom_7e8ad928(__wf_atom_414f70dd) then
			continue
		end

		local __wf_atom_91859ed8 = __wf_atom_414f70dd:__wf_atom_91859ed8()

		for _, v4 in ipairs(__wf_atom_91859ed8) do
			if v4:__wf_atom_8107dcc6() == 2 then
				return true
			end
		end
	end

	return false
end