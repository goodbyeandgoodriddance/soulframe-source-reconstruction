local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function ActivateMote(object, p)
	if __wf_atom_7e8ad928(object) or not object:__wf_atom_631bafa1() then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local weaponMoteAbility = module.GetWeaponMoteAbility(p)

	if __wf_atom_7e8ad928(weaponMoteAbility) then
		return
	end

	local __wf_atom_b9421344 = __wf_atom_e55d02aa:__wf_atom_b9421344(weaponMoteAbility, p)

	if __wf_atom_b9421344 < __wf_atom_e55d02aa:__wf_atom_87a16e10() then
		__wf_atom_e55d02aa:TryToActivateAbility(__wf_atom_b9421344)
	end
end

local function fn(object, p, p2)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return p2
	end

	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return p2
	end

	return __wf_atom_d2b2176d:__wf_atom_2a745663(p2, p, __wf_atom_e55d02aa:__wf_atom_1bb5b1ff(), __wf_atom_e55d02aa)
end

function GetRuneDrainSpeed(p, p2)
	return fn(p, 139, p2)
end

function GetRuneDamageBuff(p, p2)
	return fn(p, 138, p2)
end

function GetRuneActivationCost()
	return SF.__wf_atom_1d2b8ddc()
end

function DebugFillRuneEnergy(_, object)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	__wf_atom_e55d02aa:__wf_atom_19516b62(100, 4)
	__wf_atom_e55d02aa:__wf_atom_19516b62(100, 5)
end