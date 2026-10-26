local module = require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Interface.SFUtilities")
require("Lotus.Scripts.Libs.EasingLib")
require("SF.Scripts.Libs.AncestorsFunctionLib")
require("SF.Souls.Powers.EntitySoulModeScans")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil

function PullToMe(object)
	local position = object:GetPosition()
	local v2 = v

	if __wf_atom_7e8ad928(v2) then
		return
	end

	local v3 = v2:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM3")) + Vector(0, 0.1, 0)
	local ___wf_atom_28d5d4aa = __wf_atom_28d5d4aa
	local v4 = v3 - position
	Normalize(v4)
	local v5 = __wf_atom_edfe0d73(v4, Vector(1, 0, 0))
	local v6 = __wf_atom_edfe0d73(v4, Vector(0, 1, 0))
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_032e921b)
	local entity = gRegion:CreateEntity(__wf_atom_bb3e7833, position, __wf_atom_80368bb1)
	local v7 = 0

	while not __wf_atom_7e8ad928(v2) and v7 < 1 do
		local v8 = v2:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM3")) + Vector(0, 0.1, 0)
		v7 = __wf_atom_421b01aa(v7 + __wf_atom_084b3e93() / 1, 0, 1)
		local v9 = math.pow(v7, 3)
		local v10 = __wf_atom_f55d6358(position, v8, v9)
		local v11 = 1 - math.abs(v7 * 2 - 1)
		local v12 = v10 + v5 * math.sin(v9 * 3.141592653589793 * 2) * 2 * v11 + v6 * math.sin(v9 * 3.141592653589793 * 0.5) * 3 * v11
		entity:SetMeshScale(__wf_atom_421b01aa(__wf_atom_104bfe98(1, -0.2, v9), 0, 1))
		entity:SetPosition(v12)
		entity:__wf_atom_9b788a35(Rotation(v7 * 80, v7 * 60, v7 * 370))
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:Destroy()
	end
end

function GetSoulMeterSlot(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_e55d02aa = object:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return nil
	end

	local __wf_atom_35a10d3c = object:__wf_atom_35a10d3c(0)
	local weaponMoteAbility = module.GetWeaponMoteAbility(__wf_atom_35a10d3c)

	if not __wf_atom_7e8ad928(weaponMoteAbility) then
		local __wf_atom_b9421344 = __wf_atom_e55d02aa:__wf_atom_b9421344(weaponMoteAbility, __wf_atom_35a10d3c)

		if __wf_atom_b9421344 < __wf_atom_e55d02aa:__wf_atom_87a16e10() then
			return __wf_atom_e55d02aa:__wf_atom_2e4994f1(__wf_atom_b9421344)
		end
	end

	return nil
end

function HasRuneEnergy(object, p)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	object:__wf_atom_f3044fe0(p)
	return object:__wf_atom_f3044fe0(p) >= 50
end

function _MakeFennLocalInvis()
	if not _T.FennSoulStolen then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local nearestTagged = gRegion:FindNearestTagged(Symbol("FennJotarHelmetDeco"), __wf_atom_c4f78a8f:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			local __wf_atom_3d96ddcd = nearestTagged:__wf_atom_3d96ddcd()
			local nearestTagged2 = gRegion:FindNearestTagged(Symbol("WispDeco"), __wf_atom_3d96ddcd:GetPosition())

			if not __wf_atom_7e8ad928(nearestTagged2) then
				nearestTagged2:Destroy()
			end

			while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
				__wf_atom_3d96ddcd:__wf_atom_a7ee9662(false, true)
				Sleep(0)
			end
		end
	end
end

function RuneTutorial(object)
	if object:__wf_atom_4417a5d4() then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
		local v2 = GetSoulMeterSlot(__wf_atom_d2b2176d)
		local v3 = nil
		__wf_atom_d2b2176d:Equip(5, 0, 0)
		local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_9e7c0c61(50, 4, true)
		end

		_T.IsRuneTutorialActive = true
		_T.HideImpactMessage()
		gRegion:__wf_atom_c4f78a8f()
		Sleep(5)
		local flag = false

		while _T.IsRuneTutorialActive do
			if __wf_atom_7e8ad928(object) or object:IsKilled() then
				if v3 then
					_T.HideImpactMessage()
					v3 = nil
				end
			elseif v2 then
				if __wf_atom_7e8ad928(v3) then
					v3 = tutorialTextStrings[1]
					_T.ShowImpactMessage(v3, -1)
				else
					local v4 = HasRuneEnergy(__wf_atom_d2b2176d:__wf_atom_e55d02aa(), v2)

					if v4 and v3 ~= tutorialTextStrings[2] then
						v3 = tutorialTextStrings[2]
						_T.ShowImpactMessage(v3, -1)
					elseif not v4 and v3 == tutorialTextStrings[2] then
						if flag then
							break
						end

						v3 = tutorialTextStrings[1]
						_T.ShowImpactMessage(v3, -1)
						flag = true
					end
				end
			elseif __wf_atom_7e8ad928(v2) then
				v2 = GetSoulMeterSlot(object:__wf_atom_d2b2176d())

				if v3 then
					_T.HideImpactMessage()
					v3 = nil
				end
			end

			Sleep(0)
		end

		_T.HideImpactMessage()
	end
end

function OnStealFenn(object, avatarHasStollen)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.noDestroySoul = true

	if
		not __wf_atom_7e8ad928(__wf_atom_e919fb8e.avatarHasStollen)
		and __wf_atom_e919fb8e.avatarHasStollen == avatarHasStollen
	then
		return
	end

	__wf_atom_e919fb8e.avatarHasStollen = avatarHasStollen
	module2.WaitForLevel()
	module2.WaitForAiDir()
	Sleep(0)
	local __wf_atom_28224c27 = avatarHasStollen:__wf_atom_d2b2176d():__wf_atom_28224c27(5)
	local __wf_atom_06f3cb74 = __wf_atom_28224c27:__wf_atom_06f3cb74()
	local flag = false
	_T.FennSoulStolen = true
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local nearestTagged = gRegion:FindNearestTagged(Symbol("FennJotarHelmetDeco"), __wf_atom_c4f78a8f:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			local __wf_atom_3d96ddcd = nearestTagged:__wf_atom_3d96ddcd()

			if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				__wf_atom_3d96ddcd:__wf_atom_8a035cd5(Symbol("_MakeFennLocalInvis"), false)
			end
		end
	end

	_T.HideImpactMessage()

	for i = 0, __wf_atom_06f3cb74 - 1 do
		local __wf_atom_b9a1f18c = __wf_atom_28224c27:__wf_atom_b9a1f18c(i)

		if __wf_atom_7e8ad928(__wf_atom_b9a1f18c) then
			continue
		end

		for _, className in ipairs(starterRunes) do
			if not __wf_atom_b9a1f18c:IsA(className) then
				continue
			end

			flag = true
			break
		end
	end

	if flag then
		return
	end

	if not _T.PlayerGrantedFennJotarRune then
		_T.PlayerGrantedFennJotarRune = {}
	end

	local v2 = nil

	if gRegion:IsMaster() then
		local __wf_atom_d2b2176d = avatarHasStollen:__wf_atom_d2b2176d()
		local __wf_atom_28224c27_2 = __wf_atom_d2b2176d:__wf_atom_28224c27(5)
		local v3 = nil
		local v4 = nil

		while __wf_atom_7e8ad928(v3) do
			for _, v5 in ipairs(starterRunes) do
				if __wf_atom_28224c27_2 == nil then
					return
				end

				if not v5:__wf_atom_8e024c48("", __wf_atom_28224c27_2) then
					continue
				end

				v4 = __wf_atom_28224c27_2
				v3 = v5
				break
			end

			Sleep(0)
		end

		v = avatarHasStollen
		object:__wf_atom_8a035cd5(Symbol("PullToMe"), false)

		if not (__wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v3)) then
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
			local object2 = gRegion:CreateObject(Type(v3), __wf_atom_28224c27_2, 1)
			object2:__wf_atom_eaa00d7a(v3:__wf_atom_f298d802(), __wf_atom_28224c27_2:__wf_atom_1bb5b1ff())
			v4:AddUpgrade(object2)
			object2:__wf_atom_bef9f191(0)
			__wf_atom_e55d02aa:FinalizeUpgrades(0)
			__wf_atom_d2b2176d:AddUpgrade(283, 4, 0.5)
			v2 = avatarHasStollen
		end

		Sleep(0)
		table.insert(_T.PlayerGrantedFennJotarRune, v2:__wf_atom_a96eb2aa())
	end

	__wf_atom_7e8ad928((object:__wf_atom_575542c8()))
	avatarHasStollen:__wf_atom_8a035cd5(Symbol("RuneTutorial"), false)
end