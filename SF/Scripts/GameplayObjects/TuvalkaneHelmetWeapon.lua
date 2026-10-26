local module = require("SF.Scripts.Libs.SparrowLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.NightFoldLib")
local flag = false
local total = 0
local v = 0
local v2 = nil
local v3 = nil
local v4 = WeakResource("/SF/Types/Quests/AncestorProgression/TuvalkaneProgression/ProgressionQuests/AncestorTuvalkaneDiscoveryQuest")

function TuvalkaneHelmGameplayModEnabled(object)
	if __wf_atom_7e8ad928(inputFilter) or __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_aeb02c14(inputFilter)
	object:MotionControl():__wf_atom_99fc7a82(forceWalk)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
		module4.RegisterPreventNighfoldUsage(true)
		object:__wf_atom_51cd6126(Symbol("HelmitHit"), "OnDamaged")
	end

	if gRegion:IsMaster() then
		flag = true
		UpdateNavagation(object)
	end
end

function TuvalkaneHelmGameplayModDisabled(object)
	if __wf_atom_7e8ad928(inputFilter) or __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_cf966a74(inputFilter)
	object:MotionControl():__wf_atom_99fc7a82(forceWalk)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
		module4.RegisterPreventNighfoldUsage(false)
		SoulVisionDisable(object)
		object:__wf_atom_3ede53b4(Symbol("HelmitHit"))
	end

	flag = false

	if gRegion:IsMaster() then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("HelmitPickup"))
		module.RemoveSparrowDestination(nil, "ForgeWP")
		module.SetSparrowMode(nil)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			while __wf_atom_7e8ad928(_T.TuvHelmQuestTask) do
				Sleep(0)
			end

			module.AddQuestDestination(__wf_atom_0a6a5887, _T.TuvHelmQuestTask.owner, _T.TuvHelmQuestTask.taskId)
		end
	end
end

function UpdateNavagation(object)
	if module2.IsInOverworld() then
		v2 = gRegion:__wf_atom_0a6a5887(Symbol("ForgeWP"))

		if __wf_atom_7e8ad928(v2) then
			return
		end

		Sleep(3)

		if __wf_atom_7e8ad928(object) then
			return
		end

		v = object:__wf_atom_a5304c35(v2:GetPosition())
		object:__wf_atom_cecb2d55(sRtpcDistance, v)

		if not __wf_atom_7e8ad928(bellRingSound) then
			object:PlaySound(bellRingSound, false)
		end

		while __wf_atom_7e8ad928(_T.TuvHelmQuestTask) do
			Sleep(0)
		end

		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ForgePathStartWP"))
		local v5 = module.AddQuestDestination(v2, _T.TuvHelmQuestTask.owner, _T.TuvHelmQuestTask.taskId)
		module.SetupWaypointPath(v5, __wf_atom_0a6a5887)
		module.SetSparrowMode("WaitAndHover")
		v3 = module.GetSparrowForPlayer(object)

		if __wf_atom_7e8ad928(v3) then
			object:__wf_atom_4bf6f27a(true)
			v3 = module.GetSparrowForPlayer(object)
		end
	end

	while flag do
		if not (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(object)) then
			if __wf_atom_7e8ad928(v2) then
				break
			end

			if not __wf_atom_7e8ad928(v4) then
				module3.TrackQuest(v4, false, true)
			end

			local __wf_atom_8a6b8fc3 = object:__wf_atom_8a6b8fc3(v3)
			local __wf_atom_a5304c35 = object:__wf_atom_a5304c35(v2:GetPosition())
			local __wf_atom_a5304c35_2 = v3:__wf_atom_a5304c35(v2:GetPosition())
			local v5 = __wf_atom_8a6b8fc3 <= playerProximityDistanceToSparrow
				or __wf_atom_a5304c35 < __wf_atom_a5304c35_2

			if total >= bellRingTime and v5 then
				if not __wf_atom_7e8ad928(v2) then
					v = object:__wf_atom_a5304c35(v2:GetPosition())
					object:__wf_atom_cecb2d55(sRtpcDistance, v)
				end

				if not __wf_atom_7e8ad928(bellRingSound) then
					object:PlaySound(bellRingSound, false)
				end

				total = 0
			else
				total += __wf_atom_084b3e93()
			end
		end

		if object:__wf_atom_7b82e9e1(4) or not __wf_atom_7e8ad928(object:__wf_atom_f51f1faa()) then
			object:__wf_atom_d2b2176d():__wf_atom_67861ccf(4, 2)

			if not __wf_atom_7e8ad928(bellDropSound) then
				object:PlaySound(bellDropSound, false)
			end
		end

		Sleep(0)
	end
end

function SoulVisionDisable(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(soulVisionEnableFx)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function HelmitStun(p, p2)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = damageRadius
	radialDamageData.baseAmount = 10
	radialDamageData:__wf_atom_6b472125(p)
	radialDamageData:__wf_atom_98d98d81(p2)
	radialDamageData:__wf_atom_d6f4d914(0, true)
	radialDamageData:__wf_atom_d6f4d914(18, true)
	gRegion:__wf_atom_f6ec80de(radialDamageData)

	if not __wf_atom_7e8ad928(castFX) then
		gRegion:CreateEntity(castFX, p2, __wf_atom_80368bb1)
	end

	gRegion:__wf_atom_8d991675(radialDamageData:__wf_atom_e5d0bedf(), radialDamageData.radius, damageDebugAreaColour, 2)
end

function OnDamaged(object)
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if
		__wf_atom_9d766292:__wf_atom_78650070(16)
		or __wf_atom_9d766292:__wf_atom_78650070(17)
		or __wf_atom_9d766292:__wf_atom_78650070(19)
	then
		HelmitStun(object, object:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1")))
		object:__wf_atom_d2b2176d():__wf_atom_08ff49d5(0)
	end
end

function OnPrePickup(object, _, _)
	if gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():Unequip(0, 2)
	end
end

function OnWeaponDropped(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_f2f1a00f(object)
		__wf_atom_6009c8ed:__wf_atom_3ede53b4(Symbol("HelmitHit"))
		SoulVisionDisable(__wf_atom_6009c8ed)
	end
end

function DropWeaponFromStagger(object)
	local __wf_atom_6009c8ed = object:__wf_atom_21ed1a39():__wf_atom_6009c8ed()
	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
	HelmitStun(__wf_atom_6009c8ed, __wf_atom_6009c8ed:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1")))
	__wf_atom_d2b2176d:__wf_atom_08ff49d5(0)
end

function PickupEvaluate(p, _)
	return not __wf_atom_7e8ad928(p)
end