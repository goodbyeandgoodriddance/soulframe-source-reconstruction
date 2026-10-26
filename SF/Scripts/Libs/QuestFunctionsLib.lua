local module = require("SF.Scripts.Libs.ObjectiveHudLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local completetime = module.COMPLETETIME
local flag = false

function HandleSparrowAndCreateMarker(p, object, p2, p3)
	if p == 0 then
		return
	end

	local v = Range(5, 3.4028234663852886e38)
	local v2

	if p == 2 then
		v = Range(15, 3.4028234663852886e38)
		v2 = 40
	else
		v2 = 20
	end

	module3.AddQuestDestination(object, p3, p2, v)
	return (module2.CreateAreaMarkerAtPos(object:GetPosition(), v2, __wf_atom_28d5d4aa, p3, p2))
end

function HandleSparrowAndRemoveMarker(p, p2, p3, p4)
	if p ~= 0 then
		if not __wf_atom_7e8ad928(p2) then
			module2.DestroyAreaMarker(p2)
		end

		if not __wf_atom_7e8ad928(p3) then
			module3.RemoveSparrowDestination(p3, p4)
		end
	end
end

local function fn(instance, object)
	local v, v2

	if instance:IsA(__wf_atom_f806fd7a) then
		v = instance:__wf_atom_103377cc() + 5
		v2 = instance:__wf_atom_be637430()
	end

	for _, v3 in ipairs(v2) do
		v = math.max(v3:__wf_atom_50a7d83e():__wf_atom_1c8f7b2d(instance), v)
	end

	object:__wf_atom_400189c4((math.min(v + 5, 80)))
end

local function fn2(object)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) and __wf_atom_7be51ede:__wf_atom_4417a5d4() then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.triggerCompleted = true
		object:Disable()
	end
end

local function fn3(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.triggerCompleted = true
	object:Disable()
end

local function fn4(object)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) and __wf_atom_7be51ede:__wf_atom_4417a5d4() then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.interactionCompleted = true
	end
end

local function fn5(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 3 or __wf_atom_4026dfb5 == 4 then
		flag = true
	end
end

function WaitForGoToLocation(p, p2, p3, p4, p5, p6)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Enable()
		__wf_atom_55142dd4(__wf_atom_0a6a5887, "OnTouched", fn2)

		if p4 then
			module.UpdateOrAddHudTask(p5, p2, p6)
		end

		local v = HandleSparrowAndCreateMarker(p3, __wf_atom_0a6a5887, p2, p5)
		local __wf_atom_e919fb8e = __wf_atom_0a6a5887:__wf_atom_e919fb8e()

		while true do
			if __wf_atom_e919fb8e == nil then
				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					__wf_atom_e919fb8e = __wf_atom_0a6a5887:__wf_atom_e919fb8e()
				end
			elseif __wf_atom_e919fb8e.triggerCompleted ~= nil and __wf_atom_e919fb8e.triggerCompleted then
				break
			end

			Sleep(0)
		end

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			return
		end

		if p4 then
			module.CompleteHudTask(p5, nil, p2, completetime)
		end

		HandleSparrowAndRemoveMarker(p3, v, __wf_atom_0a6a5887, p2)
	end
end

function WaitForLookAt(p, p2, p3, p4, p5, p6)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Enable()
		__wf_atom_55142dd4(__wf_atom_0a6a5887, "Activated", fn3)

		if p4 then
			module.UpdateOrAddHudTask(mOwner, p2, p6)
		end

		local v = HandleSparrowAndCreateMarker(p3, __wf_atom_0a6a5887, p2, p5)
		local __wf_atom_e919fb8e = __wf_atom_0a6a5887:__wf_atom_e919fb8e()

		while true do
			if __wf_atom_e919fb8e == nil then
				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					__wf_atom_e919fb8e = __wf_atom_0a6a5887:__wf_atom_e919fb8e()
				end
			elseif __wf_atom_e919fb8e.triggerCompleted ~= nil and __wf_atom_e919fb8e.triggerCompleted then
				break
			end

			Sleep(0)
		end

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			return
		end

		if p4 then
			module.CompleteHudTask(mOwner, nil, p2, completetime)
		end

		HandleSparrowAndRemoveMarker(p3, v, __wf_atom_0a6a5887, p2)
	end
end

function WaitForMultipleInteractions(list, p, p2, p3, p4, p5)
	if #list == 0 then
		return
	end

	local v = list[1]

	for _, v2 in ipairs(list) do
		v2:Enable()
		__wf_atom_55142dd4(v2, "OnActivated", fn4)
	end

	local count = #list
	local v2 = HandleSparrowAndCreateMarker(p4, v, p, p3)
	local count2 = 0
	local v3 = -1

	while #list > 0 do
		for i, v4 in ipairs(list) do
			local __wf_atom_e919fb8e = v4:__wf_atom_e919fb8e()

			if not (__wf_atom_e919fb8e ~= nil and __wf_atom_e919fb8e.interactionCompleted ~= nil and __wf_atom_e919fb8e.interactionCompleted) then
				continue
			end

			table.remove(list, i)
			count2 += 1
		end

		if p2 and count2 ~= v3 then
			if count <= 1 then
				module.UpdateOrAddHudTask(p3, p, p5)
			else
				module.UpdateOrAddHudCounterTask(p3, p, p5, count2, count)
			end

			v3 = count2
		end

		Sleep(0)
	end

	if count2 == count and p2 then
		if count <= 1 then
			module.UpdateOrAddHudTask(p3, p, p5)
		else
			module.UpdateOrAddHudCounterTask(p3, p, p5, count2, count)
		end

		Sleep(0.5)
		module.CompleteHudTask(p3, nil, p, completetime)
	end

	HandleSparrowAndRemoveMarker(p4, v2, v, p)
end

function WaitForInteraction(p, p2, p3, p4, p5, p6)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Enable()
		__wf_atom_55142dd4(__wf_atom_0a6a5887, "OnActivated", fn4)

		if p4 then
			module.UpdateOrAddHudTask(p5, p2, p6)
		end

		local v = HandleSparrowAndCreateMarker(p3, __wf_atom_0a6a5887, p2, p5)
		local __wf_atom_e919fb8e = __wf_atom_0a6a5887:__wf_atom_e919fb8e()

		while true do
			if __wf_atom_e919fb8e == nil then
				if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
					__wf_atom_e919fb8e = __wf_atom_0a6a5887:__wf_atom_e919fb8e()
				end
			elseif __wf_atom_e919fb8e.interactionCompleted ~= nil and __wf_atom_e919fb8e.interactionCompleted then
				break
			end

			Sleep(0)
		end

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			return
		end

		if p4 then
			module.CompleteHudTask(p5, nil, p2, completetime)
		end

		HandleSparrowAndRemoveMarker(p3, v, __wf_atom_0a6a5887, p2)
	end
end

function WaitForWeaponEquip(className, p, p2, p3, p4)
	if p2 then
		module.UpdateOrAddHudTask(p3, p, p4)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while true do
		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		else
			local __wf_atom_35a10d3c = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

			if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and __wf_atom_35a10d3c:IsA(className) then
				break
			end
		end

		Sleep(4)
	end

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	if p2 then
		module.CompleteHudTask(p3, nil, p, completetime)
	end
end

local function fn6(instance) -- 1 equivalent call inferred from this helper
	if
		__wf_atom_7e8ad928(instance)
		or instance:IsA(__wf_atom_6a50bd07) and instance:IsA(__wf_atom_8d0b7f88) and instance:__wf_atom_c6f1f83d() <= 0
	then
		return true
	end

	return false
end

function WaitForEntitiesToBeDestroyed(list, p, p2, p3, p4)
	if #list == 0 then
		return
	end

	for _, v in ipairs(list) do
		v:SetVisibility(true)
	end

	local count = #list
	local count2 = 0
	local v = -1

	while #list > 0 do
		for i, v2 in ipairs(list) do
			if not fn6(v2) then -- inferred equivalent call
				continue
			end

			table.remove(list, i)
			count2 += 1
		end

		if p2 and count2 ~= v then
			module.UpdateOrAddHudCounterTask(p3, p, p4, count2, count)
			v = count2
		end

		Sleep(0)
	end

	if count2 == count and p2 then
		module.UpdateOrAddHudCounterTask(p3, p, p4, count2, count)
		Sleep(0.5)
		module.CompleteHudTask(p3, nil, p, completetime)
	end
end

function CreateEncounter(p, p2, _, _, _, _, _)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p2)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	__wf_atom_7d789620:AddEncounter(p)

	if __wf_atom_0a6a5887:IsA(__wf_atom_f806fd7a) then
		return (__wf_atom_7d789620:ActivateSpecificEncounterAtSpecificHint(__wf_atom_0a6a5887, p))
	end

	return (__wf_atom_7d789620:__wf_atom_c4c644af(__wf_atom_0a6a5887:GetPosition(), p))
end

function WaitforEncounterFinished(object, p, p2, p3, p4, p5)
	if p3 then
		module.UpdateOrAddHudTask(p4, p, p5)
	end

	local v

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_7dd025d4(fn5, (Symbol("QUESTFUNCLIB-" .. tostring(p))))
		v = HandleSparrowAndCreateMarker(p2, object, p, p4)
	end

	while not __wf_atom_7e8ad928(object) do
		if flag then
			if p3 then
				module.CompleteHudTask(p4, nil, p, completetime)
			end

			HandleSparrowAndRemoveMarker(p2, v, object, p)
			break
		else
			if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(v)) then
				fn(object, v)
			end

			Sleep(0)
		end
	end
end

function WaitForCreatedEncToBeDefeated(p, p2, p3, p4, p5, p6, p7)
	if p5 then
		module.UpdateOrAddHudTask(p6, p3, p7)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p2)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v = nil
	__wf_atom_7d789620:AddEncounter(p)
	local v2

	if __wf_atom_0a6a5887:IsA(__wf_atom_f806fd7a) then
		v2 = __wf_atom_7d789620:ActivateSpecificEncounterAtSpecificHint(__wf_atom_0a6a5887, p)
	else
		v2 = __wf_atom_7d789620:__wf_atom_c4c644af(__wf_atom_0a6a5887:GetPosition(), p)
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:__wf_atom_7dd025d4(fn5, (Symbol("QUESTFUNCLIB-" .. tostring(p3))))
		v = HandleSparrowAndCreateMarker(p4, v2, p3, p6)
	end

	while not __wf_atom_7e8ad928(v2) do
		if flag then
			if p5 then
				module.CompleteHudTask(p6, nil, p3, completetime)
			end

			HandleSparrowAndRemoveMarker(p4, v, v2, p3)
			break
		else
			if not (__wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v)) then
				fn(v2, v)
			end

			Sleep(0)
		end
	end
end

function WaitForTaggedQuestCinematicToEnd(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("StartPlaying")

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end
end