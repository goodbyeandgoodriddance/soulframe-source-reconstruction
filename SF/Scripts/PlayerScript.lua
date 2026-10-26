local v = Symbol("EmissiveMapAtten")
local v2 = Resource("/SF/PostFX/Materials/DefaultSFPost")
local v3 = WeakResource("/SF/Types/NeutralCreatures/SparrowAgent")
local v4 = math.random(5, 30)
local v5 = Symbol("BattleBegins")
local v6 = Symbol("BattleConcluded")
local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("Lotus.Interface.TransmissionUtilities")
local module3 = require("SF.Scripts.NightFoldLib")
local module4 = require("SF.Scripts.Libs.StatsLib")
local module5 = require("SF.Scripts.Libs.SparrowLib")
local module6 = require("SF.Scripts.Libs.CommonFunctionsLib")

local function fn(object)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local __wf_atom_6480316c = __wf_atom_c67f9605:__wf_atom_6480316c(
			__wf_atom_e55d02aa:__wf_atom_e0ccd217(),
			__wf_atom_e55d02aa:__wf_atom_1bb5b1ff()
		)
		local __wf_atom_9765cbd5 = __wf_atom_e55d02aa:__wf_atom_9765cbd5()

		if __wf_atom_9765cbd5 < __wf_atom_6480316c then
			__wf_atom_e55d02aa:__wf_atom_263a11c2(__wf_atom_6480316c - __wf_atom_9765cbd5)
		else
			__wf_atom_e55d02aa:__wf_atom_67dd6811(__wf_atom_6480316c)
		end
	end
end

function DynMusicStateChanged(value, value2)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	local v7

	if string.find(value, "Combat") == nil then
		v7 = false
	else
		v7 = string.find(value2, "Fallback") == nil
	end

	local v8

	if string.find(value2, "Combat") == nil then
		v8 = false
	else
		v8 = string.find(value2, "Fallback") == nil
	end

	local v9 = not v7
	local transmissionResponse = nil

	if v7 and not v8 then
		print("Combat -> idle")
		transmissionResponse = module2:GetTransmissionResponse(v6, __wf_atom_9be88b01, __wf_atom_c4f78a8f)
	elseif v8 and v9 then
		print("Idle -> combat")
		transmissionResponse = module2:GetTransmissionResponse(v5, __wf_atom_9be88b01, __wf_atom_c4f78a8f)
	end

	if not __wf_atom_7e8ad928(transmissionResponse) then
		__wf_atom_c4f78a8f:__wf_atom_1a73b1c2(transmissionResponse)
	end
end

function HideHudWeaponPanel()
	_T.HideWeaponPanel()
end

function ShowHudWeaponPanel()
	_T.ShowWeaponPanel()
end

function HideHudAbilityPanel()
	_T.HideAbilityPanel()
end

function ShowHudAbilityPanel()
	_T.ShowAbilityPanel()
end

function ReportSoundPerceptionOnMove(object)
	while not __wf_atom_7e8ad928(object) do
		if object:__wf_atom_08998754() == 2 then
			gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(
				2,
				6,
				object:GetPosition(),
				object,
				innerRadius,
				outerRadius,
				true
			)
		end

		local v7 = Random(intervalMin, intervalMax)
		Sleep(v7)
	end
end

local function fn2(object, p)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local __wf_atom_6e6983c7 = __wf_atom_e55d02aa:__wf_atom_6e6983c7(1)
	__wf_atom_6e6983c7:SetMaterialParam(v, p and 15 or 0.25)
	local __wf_atom_be0bea4a = __wf_atom_6e6983c7:__wf_atom_be0bea4a()

	for _, v7 in ipairs(__wf_atom_be0bea4a) do
		if v7:GetName() ~= "BuffFX" then
			continue
		end

		if p then
			v7:Enable()
		else
			v7:Disable()
		end
	end
end

function WyldBuff(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local suitAttribute = nil

	while not __wf_atom_7e8ad928(object) do
		if
			__wf_atom_e919fb8e.wyldVirtueBuff and __wf_atom_e55d02aa == __wf_atom_d2b2176d:__wf_atom_e55d02aa()
			or not suitAttribute
		then
			if
				__wf_atom_e919fb8e.wyldVirtueBuff
				and not suitAttribute
				and __wf_atom_e919fb8e.suitAttribute == __wf_atom_e919fb8e.LastSoulStealEnergyType
			then
				fn2(object, true)
				__wf_atom_d2b2176d:AddUpgrade(21 + __wf_atom_e919fb8e.suitAttribute, 3, wyldBuffMult)
				suitAttribute = __wf_atom_e919fb8e.suitAttribute
				__wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
			end
		else
			fn2(object, false)
			__wf_atom_d2b2176d:RemoveUpgrade(suitAttribute, 3, wyldBuffMult)
			__wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
			suitAttribute = nil
		end

		local v7 = Random(intervalMin, intervalMax)
		Sleep(v7)
	end
end

function Fishing(object)
	local v7 = false

	while not __wf_atom_7e8ad928(object) do
		if object:__wf_atom_0b8838a5() and not v7 then
			v7 = true
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WSP11.5_FishingAction"))

			if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
				__wf_atom_0a6a5887:SetPosition(object:__wf_atom_a2a18137())
				__wf_atom_0a6a5887:__wf_atom_9b788a35(object:__wf_atom_2f2bada0())
				Sleep(0)
				object:__wf_atom_3e5bf6ab(__wf_atom_0a6a5887, true)
			end
		end

		if not object:__wf_atom_0b8838a5() and v7 then
			v7 = false
		end

		local v8 = Random(intervalMin, intervalMax)
		Sleep(v8)
	end
end

function GraceStealthBuff(instance)
	local attribute = instance:GetAttribute(2)
	local v7 = not (attribute > 10) and 1 or __wf_atom_421b01aa(1 - (attribute - 0) / 80, 0.25, 1)
	local v8 = v7
	local v9 = false

	while not __wf_atom_7e8ad928(instance) do
		if instance:__wf_atom_08998754() == 4 and v9 == false then
			instance:__wf_atom_d2b2176d():AddUpgrade(106, 2, v7)
			v9 = true
		elseif instance:__wf_atom_08998754() ~= 4 and v9 == true then
			instance:__wf_atom_d2b2176d():RemoveUpgrade(106, 2, v8)
			v9 = false
		end

		local attribute2 = instance:GetAttribute(2)

		if attribute ~= attribute2 then
			v7 = not (attribute2 > 10) and 1 or __wf_atom_421b01aa(1 - (attribute2 - 0) / 80, 0.25, 1)
			instance:__wf_atom_d2b2176d():RemoveUpgrade(106, 2, v8)
			instance:__wf_atom_d2b2176d():AddUpgrade(106, 2, v7)
			attribute = attribute2
			v8 = v7
		end

		Sleep(0)
	end
end

function Infamy(object)
	local v7 = module6.WaitForAiDir()
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		__wf_atom_e55d02aa:__wf_atom_520644d6(0, Symbol("OnKill"), Symbol("OnKill"))
	end

	__wf_atom_e919fb8e.InfTotal = 0
	local v8 = 0
	local total = 0
	local infTotal = 0

	while not __wf_atom_7e8ad928(object) do
		if v8 > 30 and __wf_atom_e919fb8e.InfTotal > 0 then
			total += __wf_atom_084b3e93() + 0.25

			if total > 2 then
				__wf_atom_e919fb8e.InfTotal = math.max(0, __wf_atom_e919fb8e.InfTotal - 1)
				total = 0
			end
		end

		Sleep(0.25)
		local v9 = v8 + (__wf_atom_084b3e93() + 0.25)

		if __wf_atom_e919fb8e.InfTotal > 100 then
			__wf_atom_e919fb8e.InfTotal = 100
		end

		v8 = (v7:__wf_atom_37241977(__wf_atom_a96eb2aa) or infTotal < __wf_atom_e919fb8e.InfTotal) and 0 or v9
		infTotal = __wf_atom_e919fb8e.InfTotal
	end
end

function RuneEnergyDrain(object)
	local v7 = module6.WaitForAiDir()
	local v8 = Symbol("RUNE_ENERGY_DRAIN_DELAY")
	local v9 = 8
	local v10 = 8
	local v11 = 0
	local v12 = 0
	local v13 = 8
	local v14 = 8

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(5)

			if not __wf_atom_7e8ad928(__wf_atom_28224c27) and __wf_atom_28224c27 ~= nil then
				local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
					8,
					461,
					__wf_atom_28224c27:__wf_atom_1bb5b1ff(),
					__wf_atom_28224c27,
					26,
					v8
				)

				if __wf_atom_2a745663 ~= v9 then
					v13 = __wf_atom_2a745663
					v9 = v13
					v13 = v9
				end
			end

			local __wf_atom_28224c27_2 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(1)

			if not __wf_atom_7e8ad928(__wf_atom_28224c27_2) then
				local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
					8,
					461,
					__wf_atom_28224c27_2:__wf_atom_1bb5b1ff(),
					__wf_atom_28224c27_2,
					26,
					v8
				)

				if __wf_atom_2a745663 ~= v10 then
					v14 = __wf_atom_2a745663
					v10 = v14
					v14 = v10
				end
			end

			if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) or not v7:__wf_atom_37241977(__wf_atom_a96eb2aa) then
				local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

				for i, v15 in ipairs(__wf_atom_36b4a6e5) do
					if not v15:IsActive() then
						continue
					end

					local __wf_atom_2e4994f1 = __wf_atom_e55d02aa:__wf_atom_2e4994f1(i - 1)

					if __wf_atom_2e4994f1 == 4 then
						v13 = v9
					elseif __wf_atom_2e4994f1 == 5 then
						v14 = v10
					end
				end
			else
				v14 = v10
				v13 = v9
			end

			local __wf_atom_f3044fe0 = __wf_atom_e55d02aa:__wf_atom_f3044fe0(4)
			local __wf_atom_f3044fe0_2 = __wf_atom_e55d02aa:__wf_atom_f3044fe0(5)

			if v11 < __wf_atom_f3044fe0 or v12 < __wf_atom_f3044fe0_2 then
				v14 = v10
				v13 = v9
			end

			if v13 < 0 then
				if __wf_atom_f3044fe0 > 0 then
					v11 = __wf_atom_f3044fe0 - 10 * __wf_atom_084b3e93()
					__wf_atom_e55d02aa:__wf_atom_9e7c0c61(v11, 4, true)
				else
					v11 = __wf_atom_f3044fe0
				end
			else
				v13 -= __wf_atom_084b3e93()
				v11 = __wf_atom_f3044fe0
			end

			if v14 < 0 then
				if __wf_atom_f3044fe0_2 > 0 then
					v12 = __wf_atom_f3044fe0_2 - 10 * __wf_atom_084b3e93()
					__wf_atom_e55d02aa:__wf_atom_9e7c0c61(v12, 5, true)
				else
					v12 = __wf_atom_f3044fe0_2
				end
			else
				v14 -= __wf_atom_084b3e93()
				v12 = __wf_atom_f3044fe0_2
			end
		end

		Sleep(0)
	end
end

function OnMeleeHit(instance)
	local v7 = WeakResource("/SF/Types/Enemies/Sinecure/Knight/GruntHeavyAvatarBase")

	if
		__wf_atom_7e8ad928(instance)
		or __wf_atom_7e8ad928(instance:__wf_atom_9d766292())
		or __wf_atom_7e8ad928(instance:__wf_atom_9d766292():__wf_atom_483e7ddc())
	then
		return
	end

	local __wf_atom_483e7ddc = instance:__wf_atom_9d766292():__wf_atom_483e7ddc()
	local victim = __wf_atom_483e7ddc.victim

	if __wf_atom_483e7ddc.criticalChance <= 0 or __wf_atom_483e7ddc:__wf_atom_6e062502() then
		return
	end

	local __wf_atom_e55d02aa = instance:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_9232afe2 = __wf_atom_483e7ddc:__wf_atom_9232afe2()

	if __wf_atom_9232afe2 <= 0 then
		return
	end

	local __wf_atom_35a10d3c = instance:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	local __wf_atom_28224c27 = instance:__wf_atom_d2b2176d():__wf_atom_28224c27(5)
	local __wf_atom_28224c27_2 = instance:__wf_atom_d2b2176d():__wf_atom_28224c27(1)

	if __wf_atom_35a10d3c == __wf_atom_28224c27_2 or __wf_atom_35a10d3c == __wf_atom_28224c27 then
		local v8 = math.round(__wf_atom_9232afe2 * (0.02 + instance:GetAttribute(1) * 0.001))
		local v9 = __wf_atom_35a10d3c == __wf_atom_28224c27_2 and 5 or 4
		local v10 = __wf_atom_421b01aa(v8, 1, 15)
		__wf_atom_e55d02aa:__wf_atom_9e7c0c61(__wf_atom_e55d02aa:__wf_atom_f3044fe0(v9) + v10, v9, true)
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(victim) and victim:IsKilled() then
		local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()

		if victim:__wf_atom_464a4772() then
			__wf_atom_e919fb8e.InfTotal += 50
		elseif victim:IsA(v7) then
			__wf_atom_e919fb8e.InfTotal += 10
		else
			__wf_atom_e919fb8e.InfTotal += 1
		end
	end
end

function StreamNightFold(object)
	if not object:__wf_atom_631bafa1() then
		return
	end

	if not module3.IsNightFoldStreamed() then
		module3.StreamNightFold()
	end
end

function OnEnvoyDeath(instance, object)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.wyldVirtueBuff = nil

	if instance:IsA(__wf_atom_43e0c427) then
		instance = instance:__wf_atom_6009c8ed()
	end

	local __wf_atom_a96eb2aa = instance:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) or not instance:IsKilled() then
		return
	end

	if _T.PlayerShrinePosition == nil then
		_T.PlayerShrinePosition = {}
	end

	_T.PlayerShrinePosition[__wf_atom_a96eb2aa:__wf_atom_ef151cfd()] = instance:GetPosition()
	local v7 = __wf_atom_7e8ad928(object:__wf_atom_679ed446()) and {}
		or {
			e = object:__wf_atom_679ed446():__wf_atom_1bb5b1ff():__wf_atom_5b41f63b()
		}

	if instance:__wf_atom_8efce136() then
		module4.LogEventWithContext("DIE", instance, nil, v7)
	end
end

function OnEnvoyAvatarCreated(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	Sleep(0)

	if gRegion:IsMaster() then
		object:__wf_atom_8a035cd5(Symbol("SparrowSpawnerUpdate"), false)
		object:__wf_atom_8a035cd5(Symbol("WyldBuff"), false)
		object:__wf_atom_8a035cd5(Symbol("Infamy"), false)
		object:__wf_atom_8a035cd5(Symbol("RuneEnergyDrain"), false)
		object:__wf_atom_b4529799(Symbol("RuneEnergyGain"), "OnMeleeHit")
		object:__wf_atom_8a035cd5(Symbol("GraceStealthBuff"), false)
	end

	if
		__wf_atom_7e8ad928(object:__wf_atom_a96eb2aa())
		or not object:__wf_atom_a96eb2aa():IsLocal()
		or not _G.LoginSequencePlayed
	then
		return
	end

	object:__wf_atom_d2b2176d():Unequip(0, 2)

	if object:__wf_atom_8efce136() and resetFade then
		gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, 2)
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	postProcess:__wf_atom_351eef0b(v2)
	postProcess.bnwBufferInvert = false
	postProcess.bnwBufferBias = 0
	postProcess.radialBlurStrength = 0

	if not __wf_atom_7e8ad928(_T.ReviveMarker) then
		_T.ReviveMarker:Destroy()
		_T.ReviveMarker = nil
	end

	if not __wf_atom_7e8ad928(_T.ReviveSplineEntity) then
		_T.ReviveSplineEntity:Destroy()
		_T.ReviveSplineEntity = nil
	end

	if not __wf_atom_7e8ad928(_T.ReviveSplineDeco) then
		_T.ReviveSplineDeco:Destroy()
		_T.ReviveSplineDeco = nil
	end

	if _T.ReviveLaunchHint then
		_T.ReviveLaunchHint = nil
		_T.HideImpactMessage()
	end

	if not __wf_atom_7e8ad928(deathNotificationMovie) then
		local movie = __wf_atom_8e4fda44:FindMovie(deathNotificationMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Close()
		end
	end

	if not _T.TeleportedToOldOverworldLocation then
		local __wf_atom_ade7f08f = gRegion:__wf_atom_ade7f08f()

		if __wf_atom_ade7f08f.contextTags ~= nil then
			for _, contextTag in ipairs(__wf_atom_ade7f08f.contextTags) do
				local __wf_atom_df75ecc6 = Game.__wf_atom_df75ecc6(object, contextTag)

				if not (__wf_atom_df75ecc6.x ~= 0 and __wf_atom_df75ecc6.y ~= 0 and __wf_atom_df75ecc6.z ~= 0) then
					continue
				end

				local nearestTagged = gRegion:FindNearestTagged(Symbol("ResShrine"), __wf_atom_df75ecc6)

				if __wf_atom_7e8ad928(nearestTagged) then
					continue
				end

				local __wf_atom_bb3e7833 = nearestTagged:__wf_atom_bb3e7833(__wf_atom_0f45538d)

				if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					continue
				end

				local __wf_atom_a2a18137 = __wf_atom_bb3e7833:__wf_atom_a2a18137()
				local __wf_atom_2f2bada0 = __wf_atom_bb3e7833:__wf_atom_2f2bada0()
				local v7 = Vector(0, 0, 2.5)
				local v8 = __wf_atom_a2a18137 + __wf_atom_9341614d(v7, __wf_atom_2f2bada0)
				local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v8)

				if not __wf_atom_7e8ad928(_G.StatsActiveLevelName) then
					module4.TrackExitLevel(_G.StatsActiveLevelName, gRegion:__wf_atom_22941262(), "teleport")
				end

				object:Teleport(__wf_atom_0e0a6fee, __wf_atom_2f2bada0)
				_T.TeleportedToOldOverworldLocation = true

				if not __wf_atom_7e8ad928(_G.StatsLoadingLevelName) then
					module4.TrackEnterLevel(_G.StatsLoadingLevelName, "teleport")
				end

				break
			end
		end
	end

	if
		gRegion:IsMaster()
		and not (__wf_atom_7e8ad928(__wf_atom_21342f4a) or __wf_atom_7e8ad928(_T.StatsReviveSparrow))
	then
		if _T.StatsReviveSparrow then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("REVIVE_SPARROW"), "", "")
			module4.LogEventWithContext("REVIVE_SPARROW", object)
		else
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("REVIVE_SHRINE"), "", "")
			module4.LogEventWithContext("REVIVE_SHRINE", object)
		end

		_T.StatsReviveSparrow = nil
	end

	while _T.mNightFoldRequested == nil do
		StreamNightFold(object)
		Sleep(0)
	end
end

function Update(object)
	Sleep(1)
	local uiMode = module.GetUIMode()

	if
		uiMode ~= module.UI_MODE_IN_GAME and uiMode ~= module.UI_MODE_IN_DOJO
		or __wf_atom_7e8ad928(object)
		or not (object:__wf_atom_8efce136() or object:IsMaster())
	then
		return
	end

	if maxLevel and gRegion:IsMaster() then
		fn(object)
	end

	if not (_T.MusicStateChangeRegistered or __wf_atom_7e8ad928(gGameRules)) then
		local __wf_atom_a374c1f8 = gGameRules:__wf_atom_a374c1f8()

		if not __wf_atom_7e8ad928(__wf_atom_a374c1f8) then
			__wf_atom_a374c1f8:__wf_atom_3b0f0168("DynMusicStateChanged")
			_T.MusicStateChangeRegistered = true
		end
	end

	if not __wf_atom_7e8ad928(hudOverride) then
		local v7 = true

		if checkPreferDefaultHud then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local settings = __wf_atom_18a5d83b:Settings()

				if not __wf_atom_7e8ad928(settings) then
					v7 = not settings:__wf_atom_4d3fd30a()
				end
			end
		end

		if
			v7
			and not __wf_atom_7e8ad928(gGameData)
			and not __wf_atom_7e8ad928(object)
			and object:__wf_atom_4417a5d4()
		then
			_T.ShouldSaveHudTrackers = true
			gGameData:__wf_atom_f0cbae7f(hudOverride, true)
			_T.ShouldSaveHudTrackers = nil
		end
	end

	if doReportSoundPerceptionOnMov and gRegion:IsMaster() then
		object:__wf_atom_8a035cd5(Symbol("ReportSoundPerceptionOnMove"), false)
	end

	while not __wf_atom_7e8ad928(object) do
		module.UpdateHeadTracking(object, true)
		Sleep(0)
	end
end

function OnDamageScript(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if gRegion:IsMaster() then
		__wf_atom_e919fb8e.sparrowPlayerLastDamagedTime = Time()
	end

	if not object:__wf_atom_4417a5d4() then
		return
	end

	if _T.Conversations ~= nil and type(_T.Conversations) == "table" and next(_T.Conversations) ~= nil then
		print("damage taken, force closing conversations")
		_T.ForceDialogClose = true
	end
end

function DodgeRollTriggerUpdate(object)
	while true do
		local v7 = false
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_3d96ddcd:IsKilled()) then
			local __wf_atom_e919fb8e = __wf_atom_3d96ddcd:__wf_atom_e919fb8e()

			if
				not __wf_atom_7e8ad928(__wf_atom_e919fb8e.dodgeRollDamageTriggerTimer)
				and __wf_atom_e919fb8e.dodgeRollDamageTriggerTimer > 0
			then
				__wf_atom_e919fb8e.dodgeRollDamageTriggerTimer -= __wf_atom_084b3e93()
				v7 = true
			end
		end

		if object:IsEnabled() and not v7 then
			object:Disable()
		elseif not object:IsEnabled() and v7 then
			object:Enable()
		end

		Sleep(0)
	end
end

function OnDodgeRollStarted(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() or __wf_atom_7e8ad928(dodgeDamageTriggerType) then
		return
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(dodgeDamageTriggerType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = gRegion:CreateEntity(
			dodgeDamageTriggerType,
			object:GetPosition(),
			object:__wf_atom_dc309f8a(),
			object
		)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:__wf_atom_dc5956fc(object, EMPTY_SYMBOL)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.dodgeRollDamageTriggerTimer = 0.5
	end
end

function SparrowSpawnerUpdate(object)
	if not gRegion:IsMaster() then
		return
	end

	while not _G.LoginSequencePlayed do
		Sleep(0.5)
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local v7 = 0

	while not __wf_atom_7e8ad928(object) do
		v7 = (module5.SparrowAliveForPlayer(object) or not module5.CanShoulderPerch(object)) and 0 or v7 + 0.2

		if v4 <= v7 then
			__wf_atom_e919fb8e.sparrowImmediateShoulderPerch = true
			local v8 = object:GetPosition() + __wf_atom_9341614d(Vector(0, 0, 10), object:__wf_atom_2f2bada0()) + Vector(0, 5, 0)

			if math.random(0, 1) < 0.5 then
				v8 = object:GetPosition() + __wf_atom_9341614d(Vector(0, 0, -10), object:__wf_atom_2f2bada0()) + Vector(0, 2, 0)
			end

			local v9 = __wf_atom_fa8d0177(v8, object:GetPosition())
			module5.SimpleSpawnSparrow(object, Type(v3), v8, v9, true)
			object:__wf_atom_be7f08c9(true)
			v7 = 0
			v4 = math.random(5, 30)
		end

		Sleep(0.2)
	end
end