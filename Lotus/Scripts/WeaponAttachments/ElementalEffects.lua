local v = WeakResource("/Lotus/Powersuits/Harlequin/IllusionMirrorAvatar")
local module = require("Lotus.Scripts.Effects.EffectsColorUtilities")

function ElementFxLights(object)
	Sleep(0)
	local creator = object:GetCreator()

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local __wf_atom_f7e7be53 = creator:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		return
	end

	if __wf_atom_f7e7be53:IsA(v) then
		object:TurnOff()
		return
	end

	if not creator:IsA(__wf_atom_56348098) then
		creator = creator:__wf_atom_3d96ddcd()
	end

	if __wf_atom_7e8ad928(creator) or not creator:IsA(__wf_atom_56348098) then
		return
	end

	local __wf_atom_21ed1a39 = creator:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	local __wf_atom_66088189 = __wf_atom_21ed1a39:__wf_atom_66088189(1, 1)

	if
		not __wf_atom_7e8ad928(__wf_atom_66088189)
		and creator == __wf_atom_66088189
		and (Engine.__wf_atom_84bb79c2() or module.ParticleQuality() < 1)
	then
		if
			__wf_atom_7e8ad928(gGameRules)
			or not (gGameRules:IsA(__wf_atom_e714d8ac) or gGameRules:IsA(__wf_atom_311a7128))
		then
			object:__wf_atom_a15342e3(3)
		else
			object:TurnOff()
			return
		end
	end

	local __wf_atom_483e7ddc = __wf_atom_21ed1a39:__wf_atom_483e7ddc(true, 49)
	local v2 = 0
	local v3 = 0

	for i = 3, 12 do
		local __wf_atom_bf612a92 = __wf_atom_483e7ddc:__wf_atom_bf612a92(i)

		if not (v2 < __wf_atom_bf612a92) then
			continue
		end

		v3 = i
		v2 = __wf_atom_bf612a92
	end

	local v4 = 0

	for i = 3, 12 do
		if i == v3 then
			continue
		end

		local __wf_atom_bf612a92 = __wf_atom_483e7ddc:__wf_atom_bf612a92(i)

		if v4 < __wf_atom_bf612a92 then
			v4 = __wf_atom_bf612a92
		end
	end

	if v3 == damageTypeOfThisLight then
		__wf_atom_21ed1a39:ApplyEnergyColor(object)
	else
		object:TurnOff()
	end
end

function ElementalFxToChild(object)
	Sleep(0)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(childType)
	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(__wf_atom_9578cbaa)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		__wf_atom_bb3e7833_2:__wf_atom_9f26f633(__wf_atom_bb3e7833, EMPTY_SYMBOL)
	end
end