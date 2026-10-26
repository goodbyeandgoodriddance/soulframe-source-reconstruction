local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(_, object)
	local __wf_atom_bb81a9df = object:__wf_atom_bb81a9df()

	if __wf_atom_bb81a9df > 0.5 then
		return 0
	end

	return 1 - __wf_atom_bb81a9df
end

local function fn(object, startAnim, p, ...)
	return object:__wf_atom_c138b19b(startAnim) or object:__wf_atom_3c281634(startAnim) or p and fn(object, p, ...)
end

function ActivateAbility(object, object2, p, p2)
	module.PlayAnim(object, startAnim, true, 4, 3, false)

	if #powersToCancelBeforeCasting >= 1 then
		for k, _ in pairs(powersToCancelBeforeCasting) do
			local __wf_atom_e21e8409 = object:__wf_atom_e21e8409(powersToCancelBeforeCasting[k])

			if __wf_atom_7e8ad928(__wf_atom_e21e8409) or not __wf_atom_e21e8409:IsActive() then
				continue
			end

			object:DeactivateAbility(__wf_atom_e21e8409)
		end
	end

	if not object2:__wf_atom_c138b19b(startAnim, true) then
		return
	end

	local isMaster = gRegion:IsMaster()
	local v = object2:GetMaxHealth(true) * healthPercentagePerSec
	object2:__wf_atom_d2b2176d():AddUpgrade(169, 3, 0.75)
	local total = 0
	local v2 = false
	local v3 = 0

	while not object2:IsKilled() and total < healTime do
		if not (v2 or fn(object2, startAnim)) then
			module.PlayAnim(object, loopAnim, false, 4, 2, false)
			v2 = true
		end

		if object2:__wf_atom_7b82e9e1(13) or object2:__wf_atom_7b82e9e1(6) or object2:__wf_atom_7b82e9e1(12) then
			DeactivateAbility(object, object2, p, p2)
			return
		end

		if isMaster then
			v3 += v * __wf_atom_084b3e93()

			if v3 >= 1 then
				local v4 = math.floor(v3)
				v3 -= v4
				object2:Heal(object2, v4)
			end
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	module.PlayAnim(object, endAnim, true, 4, 1, false)
end

function DeactivateAbility(_, object, _, _)
	if fn(object, startAnim, loopAnim) then
		object:__wf_atom_9b5dcd3b(nil, false, 2, 1, false)
	end

	object:__wf_atom_d2b2176d():RemoveUpgrade(169, 3, 0.75)
end

function SelfHeal(_, _, object)
	local v = object:GetMaxHealth(true) * healthPercentagePerSec
	local isMaster = gRegion:IsMaster()
	local total = 0
	local v2 = 0

	while
		not object:IsKilled()
		and total < healTime
		and not (object:__wf_atom_7b82e9e1(13) or object:__wf_atom_7b82e9e1(6) or object:__wf_atom_7b82e9e1(12))
	do
		if isMaster then
			v2 += v * __wf_atom_084b3e93()

			if v2 >= 1 then
				local v3 = math.floor(v2)
				v2 -= v3
				object:Heal(object, v3)
			end
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end
end