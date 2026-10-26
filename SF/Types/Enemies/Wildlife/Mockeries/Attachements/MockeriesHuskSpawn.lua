local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")

function SetUpMockeryHusk(object)
	if gRegion:IsMaster() then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.bbHandleDecoTriggerType = handleDecoTriggerType
		__wf_atom_e919fb8e.bbMockerySpiritAgentTypes = {}
		table.insert(__wf_atom_e919fb8e.bbMockerySpiritAgentTypes, mockeryManSpiritAgentType)
		table.insert(__wf_atom_e919fb8e.bbMockerySpiritAgentTypes, mockeryWomanSpiritAgentType)
		__wf_atom_e919fb8e.bbMockeryAgentTypes = validMockeryAgents
		__wf_atom_e919fb8e.bbValidManAgentIndexes = validManAgentIndexes
		__wf_atom_e919fb8e.bbValidWomanAgentIndexes = validWomanAgentIndexes
	end
end

function HandleClientDecoState(object)
	local v = nil
	local total = 0

	while __wf_atom_7e8ad928(v) do
		v = object:__wf_atom_3d96ddcd()
		Sleep(0.1)
		total += 0.1

		if total >= 1 then
			break
		end
	end

	if not __wf_atom_7e8ad928(v) then
		local __wf_atom_be0bea4a = v:__wf_atom_be0bea4a()

		for i = 1, #__wf_atom_be0bea4a do
			if __wf_atom_7e8ad928(__wf_atom_be0bea4a[i]) or not __wf_atom_be0bea4a[i]:IsA(__wf_atom_3ae8d73b) then
				continue
			end

			__wf_atom_be0bea4a[i]:Destroy()
		end
	end
end

function EnterTrigger(object, object2)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
	local __wf_atom_e919fb8e = object:__wf_atom_3d96ddcd():__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.bbWispTypeIndex = 0

	for i = 1, #__wf_atom_e919fb8e.bbMockerySpiritAgentTypes do
		if
			__wf_atom_7e8ad928(__wf_atom_e919fb8e.bbMockerySpiritAgentTypes[i])
			or not __wf_atom_30e3d82b:IsA(__wf_atom_e919fb8e.bbMockerySpiritAgentTypes[i])
		then
			continue
		end

		__wf_atom_e919fb8e.bbWispTypeIndex = i
		break
	end

	if __wf_atom_e919fb8e.bbWispTypeIndex == 0 then
		return
	end

	local __wf_atom_e919fb8e2 = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e2 then
		if __wf_atom_7e8ad928(__wf_atom_e919fb8e2.bbStoredAvatars) then
			__wf_atom_e919fb8e2.bbStoredAvatars = { object2 }
		else
			table.insert(__wf_atom_e919fb8e2.bbStoredAvatars, object2)
		end

		__wf_atom_e919fb8e2.bbTriggerActive = true

		if #__wf_atom_e919fb8e2.bbStoredAvatars == 1 then
			object:__wf_atom_8a035cd5(Symbol("_LocalEvaluateActivateHusk"), false)
		end
	end
end

function ExitTrigger(object, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbStoredAvatars) then
			for i, bbStoredAvatar in ipairs(__wf_atom_e919fb8e.bbStoredAvatars) do
				if bbStoredAvatar ~= __wf_atom_e919fb8e.bbStoredAvatars[i] then
					continue
				end

				table.remove(__wf_atom_e919fb8e.bbStoredAvatars, i)
				break
			end
		end

		if #__wf_atom_e919fb8e.bbStoredAvatars <= 0 then
			__wf_atom_e919fb8e.bbTriggerActive = false
		end
	end
end

local function fn(object)
	local bbWispAgent = object:__wf_atom_e919fb8e().bbWispAgent
	local __wf_atom_50a7d83e = bbWispAgent:__wf_atom_50a7d83e()
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_e919fb8e = __wf_atom_3d96ddcd:__wf_atom_e919fb8e()
	local v

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.bbForcedAgentIndex)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbMockeryAgentTypes[__wf_atom_e919fb8e.bbForcedAgentIndex])
	then
		local v2 = {}
		local bbValidManAgentIndexes = {}

		if __wf_atom_e919fb8e.bbWispTypeIndex == 1 then
			bbValidManAgentIndexes = __wf_atom_e919fb8e.bbValidManAgentIndexes
		elseif __wf_atom_e919fb8e.bbWispTypeIndex == 2 then
			bbValidManAgentIndexes = __wf_atom_e919fb8e.bbValidWomanAgentIndexes
		end

		if #bbValidManAgentIndexes <= 0 then
			print("ERROR - MOCKERY HUSK: This Husk Decoration was marked to be compatible with this wisp type but did not provide any valid agent indexes for this wisp type.")
			return
		end

		for i = 1, #bbValidManAgentIndexes do
			if bbValidManAgentIndexes[i] > 0 then
				table.insert(v2, __wf_atom_e919fb8e.bbMockeryAgentTypes[bbValidManAgentIndexes[i]])
			end
		end

		if #v2 <= 0 then
			print("ERROR - MOCKERY HUSK: This Husk Decoration was marked to be compatible with this wisp type but did not provide any valid agents for this wisp type.")
			return
		else
			v = v2[__wf_atom_5784a397(1, #v2)]
		end
	else
		v = __wf_atom_e919fb8e.bbMockeryAgentTypes[__wf_atom_e919fb8e.bbForcedAgentIndex]
	end

	if not v then
		print("ERROR - MOCKERY HUSK: This Husk Decoration failed to properly provide a mockery agent to spawn.")
		return
	end

	object:Disable()
	__wf_atom_3d96ddcd:SetVisibility(false)
	__wf_atom_3d96ddcd:__wf_atom_b811702e(Symbol("CLAIMED"))
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local __wf_atom_68de036a = bbWispAgent:__wf_atom_68de036a()
	local __wf_atom_402b3832 = __wf_atom_2202ffb6:__wf_atom_402b3832(
		v,
		__wf_atom_3d96ddcd:__wf_atom_a2a18137(),
		__wf_atom_3d96ddcd:__wf_atom_2f2bada0(),
		Symbol("RandomTeam"),
		__wf_atom_68de036a
	)

	if __wf_atom_7e8ad928(__wf_atom_402b3832) then
		print("ERROR - MOCKERY HUSK: This Husk Decoration failed to spawn a Mockery Agent.")
		return
	end

	local __wf_atom_76724198 = bbWispAgent:__wf_atom_76724198()

	if not __wf_atom_7e8ad928(__wf_atom_76724198) then
		__wf_atom_76724198:__wf_atom_97f955c1(__wf_atom_402b3832)
	end

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:SetBlackboardBool(Symbol("FoundHusk"), true)
		__wf_atom_50a7d83e:SetBlackboardBool(Symbol("IsEarlySoulSteal"), false)
		__wf_atom_50a7d83e:Destroy()
	end

	__wf_atom_402b3832:__wf_atom_f54283ea()
	Sleep(0.5)
	__wf_atom_3d96ddcd:Attach(
		__wf_atom_e919fb8e.bbHandleDecoTriggerType,
		EMPTY_SYMBOL,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		__wf_atom_3d96ddcd,
		1
	)
	Sleep(0.5)
	gRegion:__wf_atom_dd1e4d10(__wf_atom_3d96ddcd)
end

function _LocalEvaluateActivateHusk(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	while __wf_atom_e919fb8e.bbTriggerActive and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.bbStoredAvatars) do
		for _, bbStoredAvatar in ipairs(__wf_atom_e919fb8e.bbStoredAvatars) do
			if
				__wf_atom_7e8ad928(bbStoredAvatar)
				or __wf_atom_7e8ad928(bbStoredAvatar:__wf_atom_30e3d82b())
				or not bbStoredAvatar:__wf_atom_30e3d82b():__wf_atom_04ea4887()
			then
				continue
			end

			if bbStoredAvatar:__wf_atom_52077f7a(Symbol("HasHuskTarget")) ~= false then
				continue
			end

			__wf_atom_e919fb8e.bbWispAgent = bbStoredAvatar:__wf_atom_30e3d82b()
			fn(object)
			return
		end

		Sleep(0.1)
	end
end

local function fn2(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_5e696f4d = object:__wf_atom_75a0566d():__wf_atom_5e696f4d(meleeContext)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

	for _ = 1, __wf_atom_5e696f4d do
		object:__wf_atom_01e1d257(meleeContext)
	end

	while
		not __wf_atom_7e8ad928(object) and object:__wf_atom_85821ed3()
		or not __wf_atom_7e8ad928(__wf_atom_d2b2176d) and __wf_atom_d2b2176d:__wf_atom_9f71ab59()
	do
		Sleep(0)
	end
end

local function fn3(object)
	local bbMockeryAgentTypes = object:__wf_atom_e919fb8e().bbMockeryAgentTypes
	local v

	if #bbMockeryAgentTypes > 0 then
		v = bbMockeryAgentTypes[Random(1, #bbMockeryAgentTypes)]
	end

	if not v then
		print("ERROR - MOCKERY HUSK: This Husk Decoration failed to properly provide a Mockery Agent to spawn.")
		return nil
	end

	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local enemyLevel = module2.GetEnemyLevel(object)
	local v2 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
	return (__wf_atom_2202ffb6:__wf_atom_402b3832(
		v,
		object:__wf_atom_a2a18137(),
		object:__wf_atom_2f2bada0(),
		Symbol("RandomTeam"),
		v2
	))
end

function HuskTrap(object, p)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local __wf_atom_be0bea4a = __wf_atom_3d96ddcd:__wf_atom_be0bea4a()

	for i = 1, #__wf_atom_be0bea4a do
		if __wf_atom_7e8ad928(__wf_atom_be0bea4a[i]) or not __wf_atom_be0bea4a[i]:IsA(__wf_atom_7b01f9ce) then
			continue
		end

		__wf_atom_be0bea4a[i]:Destroy()
	end

	local v = fn3(__wf_atom_3d96ddcd)

	if __wf_atom_7e8ad928(v) then
		print("ERROR - MOCKERY HUSK: This Husk Decoration failed to spawn a Mockery Agent.")
		return
	end

	local __wf_atom_50a7d83e = v:__wf_atom_50a7d83e()
	local __wf_atom_9fb9a1d6 = __wf_atom_50a7d83e:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
	__wf_atom_50a7d83e:SetVisibility(false)
	local taggedChildren = module.FindTaggedChildren(__wf_atom_50a7d83e:__wf_atom_be0bea4a(), Symbol("SpiritDeco"))

	if #taggedChildren > 0 then
		for _, v2 in ipairs(taggedChildren) do
			v2:SetVisibility(true)
		end
	end

	__wf_atom_3d96ddcd:Attach(
		__wf_atom_3d96ddcd:__wf_atom_e919fb8e().bbHandleDecoTriggerType,
		EMPTY_SYMBOL,
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1,
		__wf_atom_3d96ddcd,
		1
	)
	__wf_atom_50a7d83e:__wf_atom_30e3d82b():__wf_atom_f23858e5(p)
	__wf_atom_3d96ddcd:__wf_atom_921c1a5f(attackAnim, false, false)
	__wf_atom_3d96ddcd:SetVisibility(false)
	__wf_atom_50a7d83e:SetVisibility(true)
	fn2(__wf_atom_9fb9a1d6, __wf_atom_50a7d83e)

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:__wf_atom_78ad8b9f(128, 0)
	end

	__wf_atom_3d96ddcd:Destroy()
end

function OnDamaged(object)
	if object:__wf_atom_c6f1f83d() <= 0 then
		local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

		for i = 1, #__wf_atom_be0bea4a do
			if __wf_atom_7e8ad928(__wf_atom_be0bea4a[i]) or not __wf_atom_be0bea4a[i]:IsA(__wf_atom_3ae8d73b) then
				continue
			end

			__wf_atom_be0bea4a[i]:Destroy()
		end

		local taggedChild = module.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("HuskTrapTrigger"))

		if taggedChild then
			taggedChild:Disable()
		end

		fn3(object)
	end
end