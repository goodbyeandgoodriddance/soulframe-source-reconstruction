local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module6 = require("SF.Scripts.Libs.TaleLib")
local v = nil
local v2 = nil
local v3 = nil

local function fn()
	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	local patrolEncounterTypes2 = {}

	for _, v4 in ipairs(patrolEncounterTypes) do
		local __wf_atom_8b1357e3 = Resource(v4):__wf_atom_8b1357e3()

		if __wf_atom_7e8ad928(__wf_atom_8b1357e3) or #__wf_atom_8b1357e3 == 0 then
			table.insert(patrolEncounterTypes2, v4)
		else
			for i = 1, #__wf_atom_8b1357e3 do
				if not __wf_atom_8b1357e3[i].ValidTime:Contains(__wf_atom_cb3427c9) then
					continue
				end

				table.insert(patrolEncounterTypes2, v4)
				break
			end
		end
	end

	if #patrolEncounterTypes2 == 0 then
		patrolEncounterTypes2 = patrolEncounterTypes
	end

	return patrolEncounterTypes2[__wf_atom_5784a397(1, #patrolEncounterTypes2)]
end

local function fn2(object)
	local __wf_atom_103377cc = object:__wf_atom_103377cc()
	local __wf_atom_fe00d825 = object:__wf_atom_fe00d825()

	for _, v4 in ipairs(__wf_atom_fe00d825) do
		if not v4:IsA(__wf_atom_0f520c3c) then
			continue
		end

		v4:__wf_atom_400189c4(__wf_atom_103377cc + 5)
		break
	end
end

function Main(object)
	print("Clear patrol encounter started")
	v = module.WaitForAiDir()

	while not v:__wf_atom_5e711c72() do
		Sleep(0)
	end

	v3 = object:__wf_atom_dd85e6db()
	local v4 = object:__wf_atom_26b04ea9() or object
	local position = v4:GetPosition()
	local __wf_atom_103377cc = v4:__wf_atom_103377cc()
	local __wf_atom_d0c8d09f = v3:__wf_atom_d0c8d09f()
	object:__wf_atom_8e6fec76(1)
	module2.RemoveMissionMarker(v4)
	local __wf_atom_e529dedd = v4:__wf_atom_e529dedd()

	for _, v5 in ipairs(__wf_atom_e529dedd) do
		local v6 = Type(v5:__wf_atom_dd85e6db())

		for _, className in ipairs(patrolEncounterTypes) do
			if __wf_atom_7e8ad928(v6) or not v6:IsA(className) then
				continue
			end

			v2 = v5
			break
		end

		if not __wf_atom_7e8ad928(v2) then
			break
		end
	end

	if __wf_atom_7e8ad928(v2) then
		if _T.PlayEncounterTransmissions then
			if __wf_atom_7e8ad928(questToCheck) then
				module4.PlayGlobalTransmission(__wf_atom_d0c8d09f, introTransmissionTag)
			else
				module4.PlayQuestDependentTransmission(
					__wf_atom_d0c8d09f,
					questToCheck,
					introTransmissionTag,
					introTransmissionPostQuestTag
				)
			end
		end

		local v5 = fn()
		v:AddEncounter(v5)
		v2 = v:ActivateSpecificEncounterNearPos(position, 0, __wf_atom_103377cc * 0.75, v5, 0, 0, v4)

		if __wf_atom_7e8ad928(v2) then
			v2 = v:__wf_atom_c4c644af(position, v5, v4)
		end
	end

	if __wf_atom_7e8ad928(v2) then
		print("Error, no patrol encounter")
		object:__wf_atom_8e6fec76(6)
	else
		while not __wf_atom_7e8ad928(v2) and v2:__wf_atom_4026dfb5() < 2 do
			Sleep(0.5)
		end

		if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(v2) then
			return
		end

		local __wf_atom_6199ef01 = v2:__wf_atom_6199ef01()

		for _, v5 in ipairs(__wf_atom_6199ef01) do
			local __wf_atom_50a7d83e = v5:__wf_atom_50a7d83e()

			if
				__wf_atom_7e8ad928(__wf_atom_50a7d83e)
				or __wf_atom_50a7d83e:IsKilled()
				or __wf_atom_7e8ad928(soulModeAttachType)
				or __wf_atom_50a7d83e:__wf_atom_a586ea4c(soulModeAttachType)
			then
				continue
			end

			object:__wf_atom_d494454b((__wf_atom_50a7d83e:Attach(soulModeAttachType, EMPTY_SYMBOL)))
			module3.AddSparrowDestination(
				__wf_atom_50a7d83e,
				v4,
				nil,
				module3.PRIORITY.HIGH,
				Range(6, __wf_atom_103377cc * 2)
			)
		end

		fn2(v4)
		module5.UpdateOrAddHudTask(object)
		object:__wf_atom_8e6fec76(2)
		local total = 0

		while not module2.PrimedMissionShouldShutDown(object, v4) do
			local __wf_atom_4026dfb5 = v2:__wf_atom_4026dfb5()

			if __wf_atom_4026dfb5 == 4 or object:__wf_atom_4026dfb5() == 4 then
				object:__wf_atom_8e6fec76(4)
				break
			end

			if __wf_atom_4026dfb5 == 6 then
				print("Shutdown due to mPatrolHint shutdown")
				object:__wf_atom_8e6fec76(6)
				break
			else
				if total >= 3 then
					local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
					local __wf_atom_6199ef01_2 = v2:__wf_atom_6199ef01()

					for _, v5 in ipairs(__wf_atom_ef7900cf) do
						for _, v6 in ipairs(__wf_atom_6199ef01_2) do
							local __wf_atom_50a7d83e = v6:__wf_atom_50a7d83e()

							if
								__wf_atom_7e8ad928(__wf_atom_50a7d83e)
								or __wf_atom_50a7d83e:IsKilled()
								or not (v5:__wf_atom_1c8f7b2d(__wf_atom_50a7d83e) <= 60)
							then
								continue
							end

							module5.UpdateVisibility(true)
						end
					end

					total = 0
				else
					total += __wf_atom_084b3e93()
				end

				local _debugDrawDailyLocations = _T.DebugDrawDailyLocations
				Sleep(0)
			end
		end

		if __wf_atom_7e8ad928(object) then
			return
		end

		if object:__wf_atom_4026dfb5() == 4 then
			module5.CompleteHudTask(object)
			Sleep(3)

			if __wf_atom_7e8ad928(object) then
				return
			end
		else
			if not __wf_atom_7e8ad928(v2) then
				v2:__wf_atom_8e6fec76(6)
			end

			object:__wf_atom_8e6fec76(6)
		end

		module2.RemoveMessengerIntel(object, true)
		module5.RemoveHudGroup(object)
		module2.RemoveObjects(object)
		print("Clear patrol encounter ended")
	end
end

function OnPrimed(p)
	if #randomMessengerText == 0 or module6.HintIsReserved(p) then
		return
	end

	local v4 = randomMessengerText[__wf_atom_5784a397(1, #randomMessengerText)]
	module2.AddMessengerIntel(p, messengerContainerHintType, v4)
end