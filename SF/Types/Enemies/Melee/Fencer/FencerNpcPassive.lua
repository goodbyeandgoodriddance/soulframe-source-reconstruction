local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local v = Symbol("DisableDodgePassive")

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

function DecoyWait(instance)
	local v2 = 1
	local creator = instance:GetCreator()

	if not __wf_atom_7e8ad928(creator) then
		creator:__wf_atom_9373d0eb(7, true)
		creator:__wf_atom_8d98f2fc(false, false, false)
	end

	while v2 > 0 do
		Sleep(0.25)
		v2 -= __wf_atom_084b3e93() + 0.25
	end

	instance:__wf_atom_2f3f52aa(-5)

	if not __wf_atom_7e8ad928(creator) then
		creator:__wf_atom_9373d0eb(7, false)
		creator:__wf_atom_8d98f2fc(true, true, true)
	end

	local v3 = 0

	while v3 < 1 and not __wf_atom_7e8ad928(instance) do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() * 3, 0, 1)
		instance:__wf_atom_68f2c268(v3 * 0.4 + 0.6)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function OnDodge(object)
	if __wf_atom_7e8ad928(object) or object:__wf_atom_348d7b5c(v) then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	local position = object:GetPosition()
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	object:Attach(dodgeAttachFxType, EMPTY_SYMBOL)

	if not __wf_atom_7e8ad928(dodgeSound) then
		object:PlaySound(dodgeSound, false)
	end

	local entity = gRegion:CreateEntity(dodgeDecoyAvatarType, position, __wf_atom_2f2bada0, object, __wf_atom_e55d02aa)
	entity:__wf_atom_45cf0e1a(object:__wf_atom_b6b760b5(), true, true)
	entity:__wf_atom_70f78a63(object)
	entity:__wf_atom_72cd7949(object:__wf_atom_f115b657())
	entity:SetFaction(__wf_atom_e93896ba)
	entity:__wf_atom_2f3f52aa(5)
	entity:__wf_atom_68f2c268(1)
	entity:SetVisibility(true)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_e919fb8e.shuffledDodgeAnims or #__wf_atom_e919fb8e.shuffledDodgeAnims == 0 then
		__wf_atom_e919fb8e.shuffledDodgeAnims = module2.CopyTable(dodgeAnims)
		module2.ShuffleTable(__wf_atom_e919fb8e.shuffledDodgeAnims)
	end

	local shuffledDodgeAnim = __wf_atom_e919fb8e.shuffledDodgeAnims[1]
	table.remove(__wf_atom_e919fb8e.shuffledDodgeAnims, 1)

	if not __wf_atom_e919fb8e.dodgeSounds or #__wf_atom_e919fb8e.dodgeSounds == 0 then
		__wf_atom_e919fb8e.dodgeSounds = module2.CopyTable(dodgePluckSounds)
	end

	local dodgeSound = __wf_atom_e919fb8e.dodgeSounds[1]
	table.remove(__wf_atom_e919fb8e.dodgeSounds, 1)
	entity:__wf_atom_9b5dcd3b(shuffledDodgeAnim, false, 2, 3, true)
	entity:PlaySound(dodgeSound, false)

	if not __wf_atom_7e8ad928(entity) then
		local v2 = 0

		while v2 < 1 and not __wf_atom_7e8ad928(entity) do
			v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() * 2, 0, 1)
			entity:__wf_atom_68f2c268(1 - v2 * 0.6)
			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8a035cd5(Symbol("DecoyWait"), false)
	end
end