local v = 2
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")

local function fn(p, p2, object)
	local v2 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v3 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v2 == 0 then
		if p == 1 then
			v = 2
		elseif p == 2 then
			v = 3
		elseif p == 3 then
			v = 4
		else
			v = 5
		end
	elseif v2 == 1 then
		if p == 1 then
			v = 2
		elseif p == 2 then
			v = 4
		elseif p == 3 then
			v = 6
		else
			v = 8
		end
	elseif p == 1 then
		v = 2
	elseif p == 2 then
		v = 5
	elseif p == 3 then
		v = 8
	else
		v = 10
	end

	v *= v3
end

function CloneWait(instance)
	if not __wf_atom_7e8ad928(instance) then
		local v2 = 0

		while v2 < 1 do
			v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() * 2, 0, 1)
			instance:__wf_atom_68f2c268(1 - v2 * 0.6)
			Sleep(0)
		end
	end

	local v2 = v
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local creator = instance:GetCreator()
	local __wf_atom_e0730826 = __wf_atom_7d789620:__wf_atom_e0730826(instance, 10)

	for _, v3 in ipairs(__wf_atom_e0730826) do
		local __wf_atom_50a7d83e = v3:__wf_atom_50a7d83e()

		if
			__wf_atom_7e8ad928(__wf_atom_50a7d83e)
			or __wf_atom_50a7d83e:IsKilled()
			or __wf_atom_50a7d83e:__wf_atom_129d1aba(instance)
			or v3:__wf_atom_216d6edd() ~= creator
		then
			continue
		end

		v3:__wf_atom_e4153bc7()
		v3:__wf_atom_920a5a62()
		__wf_atom_50a7d83e:__wf_atom_5b3d56b0(creator)
	end

	while v2 > 0 do
		Sleep(0.25)
		v2 -= __wf_atom_084b3e93() + 0.25
	end

	__wf_atom_7e8ad928(creator)

	for _, v3 in ipairs(__wf_atom_e0730826) do
		if __wf_atom_7e8ad928(v3) then
			continue
		end

		local __wf_atom_50a7d83e = v3:__wf_atom_50a7d83e()

		if
			__wf_atom_7e8ad928(__wf_atom_50a7d83e)
			or __wf_atom_50a7d83e:IsKilled()
			or __wf_atom_50a7d83e:__wf_atom_129d1aba(instance)
			or v3:__wf_atom_216d6edd() ~= instance
		then
			continue
		end

		v3:__wf_atom_e4153bc7()
		v3:__wf_atom_920a5a62()
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:__wf_atom_2f3f52aa(-5)
		local v3 = 0

		while v3 < 1 do
			v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() * 3, 0, 1)
			instance:__wf_atom_68f2c268(v3 * 0.4 + 0.6)
			Sleep(0)
		end

		instance:Destroy()
	end
end

function OnUpgradeApplied(object, _, p, _, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	fn(p, object, p2)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	local position = object:GetPosition()
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	object:Attach(cloneAttachFxType, EMPTY_SYMBOL)
	local entity = gRegion:CreateEntity(cloneCollectAvatarType, position, __wf_atom_2f2bada0, object)
	entity:__wf_atom_d2b2176d():__wf_atom_13a9a02f(__wf_atom_a96eb2aa, true)
	entity:__wf_atom_72cd7949(object:__wf_atom_f115b657())
	entity:SetFaction(__wf_atom_e93896ba)
	entity:__wf_atom_2f3f52aa(5)
	entity:__wf_atom_c274907d(object:__wf_atom_0d9c1a58())
	entity:__wf_atom_68f2c268(1)
	entity:SetVisibility(true)
	entity:SetHealth(200)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8a035cd5(Symbol("CloneWait"), false)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v2 = { BONUS = module2.FormatNumber(v, 0) }
	return cjson.encode(v2)
end