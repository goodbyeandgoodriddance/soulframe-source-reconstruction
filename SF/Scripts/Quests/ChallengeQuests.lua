local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.ObjectiveHudLib")
local v = {}
local count = 0

function _OnQuestProgressChanged(progress, p)
	print("_OnQuestProgressChanged", p, progress)

	if v[p] ~= nil and v[p].progress ~= progress then
		v[p].dirty = true
		v[p].progress = progress
		v[p].completed = v[p].required <= progress
	end
end

local function fn(object, p, p2, p3, p4)
	local v2 = Symbol(p)
	local v3 = Symbol(p2)
	__wf_atom_539492fe:__wf_atom_b78d6285(object, v2, v3)
	__wf_atom_539492fe:__wf_atom_4a6aa38d(v2, v3, "_OnQuestProgressChanged")
	local __wf_atom_0481eb9e = object:__wf_atom_0481eb9e()

	if p3 ~= nil and p3 ~= "" then
		__wf_atom_0481eb9e = p3
	end

	local locName = string.format("%s_Name", __wf_atom_0481eb9e)
	local locDesc = string.format("%s_Description", __wf_atom_0481eb9e)

	if p4 ~= nil and p4 ~= "" then
		locName = p4
	end

	local __wf_atom_457dda04 = __wf_atom_539492fe:__wf_atom_457dda04(v2, v3)
	local __wf_atom_18516282 = object:__wf_atom_18516282()
	v[p2] = {
		completed = __wf_atom_18516282 <= __wf_atom_457dda04,
		progress = __wf_atom_457dda04,
		required = __wf_atom_18516282,
		locPath = __wf_atom_0481eb9e,
		locName = locName,
		locDesc = locDesc,
		dirty = true
	}

	if object:IsA(__wf_atom_4c0b2204) and object:__wf_atom_19008c91() then
		local __wf_atom_ac556b6c = object:__wf_atom_ac556b6c()

		if __wf_atom_ac556b6c:__wf_atom_8598f3a9() then
			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
			__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_eab484a7, __wf_atom_ac556b6c)
		end
	end

	count += 1
	print("Registered challenge", object:__wf_atom_5b41f63b(), p2)
end

function UpdateHud(p)
	if useChallengeLocOnHud then
		for k, _ in pairs(v) do
			if not v[k].dirty then
				continue
			end

			module3.UpdateOrAddHudCounterTask(mOwner, k, v[k].locName, v[k].progress, v[k].required)

			if v[k].completed then
				module3.CompleteHudTask(mOwner, nil, k)
			end

			v[k].dirty = false
		end
	else
		local progress = 0
		local required = 0
		local v2 = false

		if count > 1 then
			required = count

			for _, v3 in pairs(v) do
				if v3.completed then
					progress += 1
				end

				v2 = v2 or v3.dirty
				v3.dirty = false
			end
		else
			for _, v3 in pairs(v) do
				required = v3.required
				progress = v3.progress
				v2 = v2 or v3.dirty
				v3.dirty = false
			end
		end

		if v2 then
			if showProgressOnHud then
				module3.UpdateOrAddHudCounterTask(mOwner, p, nil, progress, required)
			else
				module3.UpdateOrAddHudTask(mOwner, p, nil, nil, progress == required)
			end
		end
	end
end

function KillChallengeTask(p)
	print("START KillChallengeTask", p)

	if not (gRegion:IsMaster() or mOwner:__wf_atom_6d0c070b()) then
		print("KillChallengeTask - Client quitting early, not local quest")
		return
	end

	module.WaitForLevel()
	module.WaitForLoginSequence()
	module2.TrackQuest(mOwner)
	local object = gRegion:CreateObject(Type(killChallenge))
	object:__wf_atom_c238fa07(requiredCount)

	if killChallenge:IsA(__wf_atom_4c0b2204) then
		object:__wf_atom_2b73844f(victimType)
		object:__wf_atom_d0c1afd2(damageSourceObjects)
	end

	fn(object, p, "KillChallenge", nil, challengeHudLocalizationPath)
	local completed = false

	while not completed do
		completed = v.KillChallenge.completed
		UpdateHud(p)
		Sleep(1)
	end

	Sleep(3)
	module2.CompleteTaskWithID(mOwner, p)
	print("END KillChallengeTask", p)
end

function GenericChallengeTask(p)
	print("START GenericChallengeTask", p)

	if not (gRegion:IsMaster() or mOwner:__wf_atom_6d0c070b()) then
		print("GenericChallengeTask - Client quitting early, not local quest")
		return
	end

	module.WaitForLevel()
	module.WaitForLoginSequence()
	module2.TrackQuest(mOwner)

	for _, v2 in ipairs(challenges) do
		local object = gRegion:CreateObject(Type(v2))
		fn(object, p, object:GetName())
	end

	local completed = false

	while not completed do
		completed = true

		for _, v2 in pairs(v) do
			completed = completed and v2.completed
		end

		UpdateHud(p)
		Sleep(1)
	end

	Sleep(3)
	module2.CompleteTaskWithID(mOwner, p)
	print("END GenericChallengeTask", p)
end