local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")

local function fn()
	Sleep(delay)

	if not __wf_atom_7e8ad928(targetObject) then
		targetObject:FirePort(nameOfPortToFire)

		if not __wf_atom_7e8ad928(firePortSound) then
			targetObject:PlaySound(firePortSound, false, 0, true)
		end
	end
end

local function fn2(object, p)
	Sleep(delay)

	if #portTargets == 0 then
		return
	end

	if maxTargets > #portTargets then
		maxTargets = #portTargets
	end

	local count = 0
	local v

	if p then
		v = object:__wf_atom_c08f5a0e(minTargets, maxTargets)
	else
		v = __wf_atom_5784a397(minTargets, maxTargets)
	end

	while count < v do
		local v2

		if p then
			v2 = object:__wf_atom_c08f5a0e(1, #portTargets)
		else
			v2 = __wf_atom_5784a397(1, #portTargets)
		end

		if not __wf_atom_7e8ad928(portTargets[v2]) and v2 <= #portsToFire then
			portTargets[v2]:FirePort(portsToFire[v2])
			table.remove(portTargets, v2)
			table.remove(portsToFire, v2)
			count += 1
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(alwaysTriggered) then
		alwaysTriggered:FirePort("Increment")
		alwaysTriggered:FirePort("Increment")
	end

	if disableOnEnded then
		object:Disable()
	end
end

function FirePort()
	fn()
end

function FireTaggedPort()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(tag)

	for _, v in ipairs(__wf_atom_2226b35c) do
		v:FirePort(nameOfPortToFire)
	end
end

function FireNearestTaggedPort(object)
	local position = object:GetPosition()
	local nearestTagged = gRegion:FindNearestTagged(tag, position)

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:FirePort(nameOfPortToFire)
	end
end

function FireMultiplePorts()
	if #portTargets == 0 or __wf_atom_7e8ad928(nameOfPortToFire) then
		return
	end

	Sleep(delay)

	for i = 1, #portTargets do
		if __wf_atom_7e8ad928(portTargets[i]) then
			continue
		end

		portTargets[i]:FirePort(nameOfPortToFire)
		Sleep(0)
	end
end

function FireMultiplePortsOnEntitiesByType()
	if #portTargetTypes == 0 or __wf_atom_7e8ad928(nameOfPortToFire) then
		return
	end

	Sleep(delay)

	for i = 1, #portTargetTypes do
		if __wf_atom_7e8ad928(portTargetTypes[i]) then
			continue
		end

		local all = gRegion:FindAll(portTargetTypes[i])

		for j, v in ipairs(all) do
			if not (__wf_atom_7e8ad928(all[j]) or __wf_atom_7e8ad928(nameOfPortToFire)) then
				v:FirePort(nameOfPortToFire)
			end
		end
	end
end

function FireMultipleDifferentPorts()
	if #portTargets == 0 or __wf_atom_7e8ad928(namesOfPortToFire) then
		return
	end

	Sleep(delay)

	for i = 1, #portTargets do
		if not __wf_atom_7e8ad928(portTargets[i]) then
			portTargets[i]:FirePort(namesOfPortToFire[i])
		end
	end
end

function FireMultipleDifferentPortsWithDelays()
	if #portTargets == 0 or __wf_atom_7e8ad928(namesOfPortToFire) then
		return
	end

	Sleep(delay)

	for i = 1, #portTargets do
		if __wf_atom_7e8ad928(portTargets[i]) or __wf_atom_7e8ad928(namesOfPortToFire[i]) then
			continue
		end

		portTargets[i]:FirePort(namesOfPortToFire[i])

		if #delayAfterLastPortFired == #portTargets then
			Sleep(delayAfterLastPortFired[i])
		end
	end
end

function FireMultipleDifferentPortsOnMultipleDifferentTaggedEntities(p)
	if #tags == 0 or __wf_atom_7e8ad928(namesOfPortToFire) then
		return
	end

	local v

	if onlyInThisTile then
		v = module.GetLayerIndex(p)
	end

	for i = 1, #tags do
		if __wf_atom_7e8ad928(tags[i]) then
			continue
		end

		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(tags[i])

		for j, v2 in ipairs(__wf_atom_2226b35c) do
			if __wf_atom_7e8ad928(__wf_atom_2226b35c[j]) or __wf_atom_7e8ad928(namesOfPortToFire[i]) then
				continue
			end

			if onlyInThisTile and module.GetLayerIndex(v2) == v then
				v2:FirePort(namesOfPortToFire[i])
			elseif not onlyInThisTile then
				v2:FirePort(namesOfPortToFire[i])
			end
		end
	end
end

function FireRandomWeightPort()
	local total = 0

	for _, v in ipairs(weightedRandomChance) do
		total += v
	end

	local v = __wf_atom_5784a397(1, total)

	for i, v2 in ipairs(weightedRandomChance) do
		v -= v2

		if not (v <= 0) then
			continue
		end

		weightedRandomTargets[i]:FirePort(weightedPortNames[i])
		break
	end
end

function FireRandomPorts(p, _)
	fn2(p, false)
end

function FireRandomReplicatedPorts(instance)
	print("Firing ports")

	if instance:IsA(__wf_atom_589cefdb) then
		fn2(instance, true)
	else
		print("Cannot run FireRandomReplicatedPorts on " .. instance:__wf_atom_5b41f63b() .. ". Context owner must be a script trigger!")
	end
end

function FirePortChance()
	Sleep(delay)

	if math.random() <= chanceToTrigger then
		if __wf_atom_7e8ad928(targetObject) then
			print("FirePort.lua::FirePortChance - No targetObject to fire port" .. nameOfPortToFire)
		else
			targetObject:FirePort(nameOfPortToFire)
		end
	elseif not __wf_atom_7e8ad928(altTarget) then
		altTarget:FirePort(altPort)
	end
end

function FirePortIfNoMigration()
	local v = Symbol("SecondObjective")
	local v2 = Symbol("SecondObjPortsStarted")

	if gGameRules:__wf_atom_d163c8e5(v) >= 1 then
		if gGameRules:__wf_atom_d163c8e5(v2) == 1 then
			return
		end
	elseif gPromotedToHost then
		return
	end

	for i = 1, #portTargets do
		if not __wf_atom_7e8ad928(portsToFire[i]) then
			portTargets[i]:FirePort(portsToFire[i])
		end
	end

	if gGameRules:__wf_atom_d163c8e5(v) >= 1 then
		gGameRules:SetNetPersistentVar(v2, 1)
	end
end

function FirePortBasedOnQuestState(_, _, _)
	module.WaitForLevel()
	module.WaitForLoginSequence()

	if module2.HasCompletedQuest(completedQuestWeakRes) then
		if dontFireOnActiveQuest then
			for _, v in pairs(questsToCheckIfActive) do
				if module2.QuestIsActive(v) then
					return
				end
			end
		end

		FireTaggedPort()
	end
end