local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("SF.Scripts.Libs.SparrowLib")
local module5 = require("SF.Interface.SFUtilities")
local module6 = require("SF.Scripts.Libs.EncounterLib")
local v = Symbol("ActiveFactionTaskEncounter")
local v2 = nil
local v3 = nil

local function fn(instance)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("blockingEnc"), instance:GetPosition(), 0, 20)
	local __wf_atom_4026dfb5 = instance:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 1 then
		return
	end

	if __wf_atom_4026dfb5 == 2 then
		print("Encounter Is active")
	elseif __wf_atom_4026dfb5 == 4 then
		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			__wf_atom_f738b4af:Destroy()
		end
	elseif __wf_atom_4026dfb5 == 6 then
		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			__wf_atom_f738b4af:Destroy()
		end

		instance:Destroy()
	end
end

function SetUpChampionGhostFight(p)
	if not module.InitializeTask(mOwner, p) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GhostKnightFightWP"))
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v4 = false
	module6.SpawnCombatBlockingContainer(randomCombatBlockingContainerType, __wf_atom_0a6a5887:GetPosition()):__wf_atom_b811702e(Symbol("blockingEnc"))
	local __wf_atom_a5304c35 = __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887:GetPosition())

	if module5.IsDaytime() then
		module2.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/ReturnAtNight")

		while module5.IsDaytime() do
			Sleep(0)
		end
	end

	if module3.IsInOverworld() then
		if __wf_atom_a5304c35 > 20 then
			module2.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/ReturnToTheGate")
			v3 = module.CreateAreaMarker(__wf_atom_0a6a5887, 50, __wf_atom_28d5d4aa, mOwner, p)
			module4.AddSparrowDestination(
				__wf_atom_0a6a5887,
				nil,
				"initiateFaction",
				module4.PRIORITY.CRITICAL,
				nil,
				mOwner
			)
		end

		while __wf_atom_a5304c35 > 20 do
			__wf_atom_a5304c35 = __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887:GetPosition())

			if __wf_atom_a5304c35 <= 100 and v4 == false then
				v4 = true
				local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
					Symbol("ChampionHubStepsHint"),
					__wf_atom_0a6a5887:GetPosition(),
					0,
					30
				)

				if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
					__wf_atom_7d789620:__wf_atom_ccbb5582(__wf_atom_f738b4af)
					__wf_atom_f738b4af:__wf_atom_7dd025d4(fn, v)
				end
			end

			if __wf_atom_a5304c35 <= 20 then
				break
			else
				Sleep(0)
			end
		end

		v2 = p
	end
end

function ChamptionTaskDay(p)
	if not module.InitializeTask(mOwner, p) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GhostKnightFightWP"))
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
		Symbol("ChampionDoorNote"),
		__wf_atom_0a6a5887:GetPosition(),
		0,
		20
	)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v4 = false
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("GhostKnightFightWP"))
	local __wf_atom_f738b4af2 = gRegion:__wf_atom_f738b4af(
		Symbol("SparrowPerchPoint"),
		__wf_atom_0a6a5887_2:GetPosition(),
		0,
		20
	)
	local __wf_atom_a5304c35 = __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887_2:GetPosition())

	if __wf_atom_a5304c35 > 20 then
		module2.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/InitiateFactionGoToChampion")
		v3 = module.CreateAreaMarker(__wf_atom_0a6a5887_2, 50, __wf_atom_28d5d4aa, mOwner, p)
		module4.AddSparrowDestination(
			__wf_atom_0a6a5887_2,
			nil,
			"initiateFaction",
			module4.PRIORITY.CRITICAL,
			nil,
			mOwner
		)

		while __wf_atom_a5304c35 > 20 do
			__wf_atom_a5304c35 = __wf_atom_c4f78a8f:__wf_atom_a5304c35(__wf_atom_0a6a5887_2:GetPosition())

			if __wf_atom_a5304c35 <= 20 and v4 == false then
				module4.AddSparrowDestination(
					__wf_atom_f738b4af2,
					nil,
					"initiateFaction",
					module4.PRIORITY.CRITICAL,
					nil,
					mOwner
				)
				module2.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/SearchTheEntrance")
				break
			else
				Sleep(0)
			end
		end
	else
		module4.AddSparrowDestination(
			__wf_atom_f738b4af2,
			nil,
			"initiateFaction",
			module4.PRIORITY.CRITICAL,
			nil,
			mOwner
		)
		module2.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/SearchTheEntrance")
	end

	if not (__wf_atom_7e8ad928(__wf_atom_f738b4af) or __wf_atom_7e8ad928(__wf_atom_f738b4af)) then
		while not __wf_atom_f738b4af:__wf_atom_272baebc() do
			Sleep(1)
		end
	end

	module.CompleteTaskWithID(mOwner, p)
end

function WaitForNight(p)
	if not module.InitializeTask(mOwner, p) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GhostKnightFightWP"))
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
		Symbol("SparrowPerchPoint"),
		__wf_atom_0a6a5887:GetPosition(),
		0,
		20
	)
	module2.UpdateOrAddHudTask(mOwner, p, "/SF/Language/Quests/ReturnAtNight")
	module4.RemoveSparrowDestination(__wf_atom_f738b4af, "initiateFaction")

	while module5.IsDaytime() do
		Sleep(0)
	end

	module.CompleteTaskWithID(mOwner, p)
end

function ChamptionEntranceTaskCheck(p)
	if not module3.IsInOverworld() or module5.IsDaytime() then
		return
	end

	module.CompleteTaskWithID(mOwner, p)
end

function OnGhostKnightDeath(object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_8914dfde("deathVFX", 2)
		local v4 = object:GetPosition() + Vector(0, 2, 0)
		local entity = gRegion:CreateEntity(deathFX, v4, __wf_atom_80368bb1)
		local v5 = 0

		while not __wf_atom_7e8ad928(object) and v5 < 1 do
			v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93(), 0, 1)
			object:__wf_atom_68f2c268(v5)
			Sleep(0)
		end

		Sleep(0.1)
		local v6 = 0
		local nearestTagged = gRegion:FindNearestTagged(Symbol("ChampionStatue"), object:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			local v7 = nearestTagged:GetPosition() + Vector(0, 2.8, 0)
			__wf_atom_f55d6358(v4, v7, v6)

			while not __wf_atom_7e8ad928(object) and v6 < 4 do
				v6 = __wf_atom_421b01aa(v6 + __wf_atom_084b3e93(), 0, 4)
				local v8 = -(math.cos(3.141592653589793 * v6 / 4) - 1) / 2
				entity:SetPosition((__wf_atom_f55d6358(v4, v7, v8)))
				Sleep(0)
			end

			object:SetVisibility(false, true)
			nearestTagged:Attach(deathStatueFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa)
			Sleep(0.06)
			entity:Destroy()
			local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
				Symbol("OpenChampDoorPortForwarder"),
				object:GetPosition(),
				0,
				100
			)

			if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
				Sleep(2)
				__wf_atom_f738b4af:FirePort("TriggerPort")

				for _, v8 in gRegion:FindAll(markerInfo) do
					v8:__wf_atom_ff716ec1(true)
				end
			end
		end
	end
end