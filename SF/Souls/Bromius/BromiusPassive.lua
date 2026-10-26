local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 0.1
local v2 = 1
local v3 = 5
local v4 = 0.1

local function fn(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
		0,
		0,
		nil,
		nil,
		26,
		Symbol("BromiusShatterPassive")
	)
	local magikForceCalc = module.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v = 0.15
		v2 = 1
		v3 = 5
	elseif __wf_atom_2a745663 == 2 then
		v = 0.2
		v2 = 2
		v3 = 10
	elseif __wf_atom_2a745663 == 3 then
		v = 0.25
		v2 = 3
		v3 = 12
	else
		v = 0.35
		v2 = 4
		v3 = 15
	end

	v2 *= magikForceCalc
	return true
end

local function fn2(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
		0,
		0,
		nil,
		nil,
		26,
		Symbol("BromiusReflectPassive")
	)
	local magikForceCalc = module.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		v4 = 0.1
	elseif __wf_atom_2a745663 == 2 then
		v4 = 0.15
	elseif __wf_atom_2a745663 == 3 then
		v4 = 0.2
	else
		v4 = 0.3
	end

	v4 *= magikForceCalc
	return true
end

function AddUpgrade(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local v5 = gRegion:IsMaster() and fn(__wf_atom_6009c8ed)
	local v6 = __wf_atom_6009c8ed:__wf_atom_4417a5d4() and fn2(__wf_atom_6009c8ed)

	if v5 then
		object:__wf_atom_520644d6(4, Symbol("OnHit"), Symbol("BromiusShatterPassive"))
	end

	if v6 then
		__wf_atom_6009c8ed:__wf_atom_51cd6126(Symbol("BromiusReflectPassive"), "OnDamaged")
	end
end

function RemoveUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	object:__wf_atom_2a5bca4a(nil, Symbol("BromiusShatterPassive"))
	__wf_atom_6009c8ed:__wf_atom_3ede53b4(Symbol("BromiusReflectPassive"))
end

function OnHit(object, _, _, object2, _, p)
	if p <= 0 or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_58367d88 = object2:__wf_atom_7470861b():__wf_atom_58367d88()

	if __wf_atom_58367d88 <= 0 then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	fn(__wf_atom_6009c8ed)
	local v5 = math.random()

	if v <= v5 then
		return
	end

	object2:PlaySound(armourShatterSound, false, 1, false)
	object2:Attach(armourShatterFxType, EMPTY_SYMBOL)
	__wf_atom_6009c8ed:Attach(armourBuffFxType, EMPTY_SYMBOL)
	local v6 = math.min(__wf_atom_58367d88, v2)
	object2:__wf_atom_d2b2176d():AddUpgrade(20, 0, -v6)
	__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_3c88d02d(v3, 20, 0, v6)
end

function OnDamaged(object)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292())
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292():__wf_atom_483e7ddc())
	then
		return
	end

	local __wf_atom_483e7ddc = object:__wf_atom_9d766292():__wf_atom_483e7ddc()

	if __wf_atom_483e7ddc.armourReduction <= 0 or __wf_atom_483e7ddc:__wf_atom_6e062502() then
		return
	end

	local __wf_atom_679ed446 = __wf_atom_483e7ddc:__wf_atom_679ed446()

	if
		__wf_atom_7e8ad928(__wf_atom_679ed446)
		or not __wf_atom_679ed446:IsA(__wf_atom_4ebf67cb)
		or __wf_atom_679ed446:IsKilled()
	then
		return
	end

	fn2(object)
	local damageData = Engine.DamageData()
	damageData.baseAmount = math.max(1, (math.floor(__wf_atom_483e7ddc.armourReduction * v4 + 0.5)))

	for i = 1, 15 do
		damageData:__wf_atom_7498285f(i, __wf_atom_483e7ddc:__wf_atom_bf612a92(i))
	end

	object:Attach(reflectedDamageFxType, EMPTY_SYMBOL)
	damageData:__wf_atom_6b472125(object)
	damageData:__wf_atom_34a8a27a(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
	__wf_atom_679ed446:__wf_atom_649bf33e(damageData)
end