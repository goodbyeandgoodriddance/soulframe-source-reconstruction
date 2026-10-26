local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Souls.Powers.EntitySoulModeScans")
local v = nil
local v2 = nil

function StartPreDeathSequence(object)
	Sleep(0)

	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	if __wf_atom_7e8ad928(spiritAgentType) then
		print("MOCKERY AVATAR: ERROR! Spririt agent type is missing")
		return
	end

	for i = 1, #preDeathStartAnims do
		if not object:__wf_atom_c138b19b(preDeathStartAnims[i], false) then
			continue
		end

		object:__wf_atom_8914dfde(String("EjectSpirit"), 1)
		break
	end

	local taggedChildren = module.FindTaggedChildren(object:__wf_atom_be0bea4a(), Symbol("SpiritDeco"))
	local v3 = nil
	local v4 = gRegion:IsMaster() and module.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("DecoTrigger"))

	if v4 then
		v4:Destroy()
	end

	if #taggedChildren > 0 then
		for _, v5 in ipairs(taggedChildren) do
			v5:SetVisibility(false)
		end
	end

	if not gRegion:IsMaster() then
		return
	end

	if __wf_atom_7e8ad928(v) then
		local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
		Type()
		v = __wf_atom_2202ffb6:__wf_atom_0a5fdbf0(
			spiritAgentType,
			object:__wf_atom_a2a18137(),
			object:__wf_atom_2f2bada0(),
			__wf_atom_30e3d82b
		)
		Sleep(0.1)

		if not __wf_atom_7e8ad928(v) then
			v2 = v:__wf_atom_50a7d83e()

			if not __wf_atom_7e8ad928(v2) then
				v2:__wf_atom_6a95c7b8(object)
				local taggedChild = module.FindTaggedChild(v2:__wf_atom_be0bea4a(), Symbol("SoulStealIdle"))

				if not __wf_atom_7e8ad928(taggedChild) then
					taggedChild:Destroy()
				end

				local v5 = __wf_atom_5784a397(1, 3)

				if #soulStealEntitys ~= 3 then
					print("MOCKERY AVATAR: ERROR! Soul Steal Entities not initialized properly")
					return
				end

				local soulStealEntity = soulStealEntitys[v5]
				v3 = v2:Attach(soulStealEntity, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v2, 1)
				v3:__wf_atom_83cc9d29(v2)
				v2:SetBlackboardBool(Symbol("HasHuskTarget"), true)
				v2:SetBlackboardBool(Symbol("ReturnToHusk"), false)
				v:__wf_atom_f54283ea()
				object:__wf_atom_15b36b95(false)
				object:__wf_atom_d1b42aad(false)
				object:__wf_atom_30964595(false)
				object:SetDisableGravity(true)
				object:__wf_atom_0ed81088(false)
				v3:__wf_atom_83cc9d29(v2)
				v3:__wf_atom_e919fb8e()
				local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
				v3:__wf_atom_ab698c41(__wf_atom_e919fb8e.lastDamageSource, __wf_atom_e919fb8e.lastDamageSourceObject)
			end
		end
	elseif not __wf_atom_7e8ad928(v2) then
		print("ERROR - MOCKERY AVATAR: Spirit avatar already existed")
	end

	local maxHealth = object:GetMaxHealth()
	local v5 = reviveHealthPerc * maxHealth
	local v6 = preDeathLength * returnTimePerc
	local total = 0

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_bedb4e3f() and not object:IsKilled() do
		if
			v6 <= total
			and not __wf_atom_7e8ad928(v2)
			and not __wf_atom_7e8ad928(v)
			and v2:__wf_atom_52077f7a(Symbol("ReturnToHusk")) == false
		then
			v:__wf_atom_b783ff91(object:__wf_atom_a2a18137(), object:__wf_atom_dc309f8a().heading)
			v2:SetBlackboardBool(Symbol("ReturnToHusk"), true)
		elseif preDeathLength <= total then
			object:SetHealth(v5, false)
			break
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(preDeathEndAnim, false) then
		object:__wf_atom_8914dfde(String("SpiritEntered"), 1)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:SetVisibility(false)
		v2:Destroy()
	end

	object:Attach(handleDecoTriggerType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, 1)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_15b36b95(true)
		object:__wf_atom_d1b42aad(true)
		object:__wf_atom_30964595(true)
		object:SetDisableGravity(false)
		object:__wf_atom_0ed81088(true)
	end
end

function OnDamaged(object)
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if
		__wf_atom_7e8ad928(__wf_atom_9d766292)
		or __wf_atom_7e8ad928(__wf_atom_9d766292:__wf_atom_679ed446())
		or __wf_atom_7e8ad928(__wf_atom_9d766292:__wf_atom_3371f607())
	then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.lastDamageSource = __wf_atom_9d766292:__wf_atom_679ed446()
	__wf_atom_e919fb8e.lastDamageSourceObject = __wf_atom_9d766292:__wf_atom_3371f607()
end

function HandleClientDecoState(object)
	local v3 = nil
	local total = 0

	while __wf_atom_7e8ad928(v3) do
		v3 = object:__wf_atom_3d96ddcd()
		Sleep(0.1)
		total += 0.1

		if total >= 1 then
			break
		end
	end

	if v3 then
		local taggedChildren = module.FindTaggedChildren(v3:__wf_atom_be0bea4a(), Symbol("SpiritDeco"))

		if #taggedChildren > 0 then
			for _, v4 in ipairs(taggedChildren) do
				if not __wf_atom_7e8ad928(v4) then
					v4:SetVisibility(true)
				end
			end
		end
	end
end