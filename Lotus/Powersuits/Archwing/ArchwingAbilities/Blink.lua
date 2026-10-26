local v = 4
local v2 = 20
local v3 = 7
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(object, p)
	local v4 = v * p
	local v5 = v2 * p
	local v6 = v3

	if __wf_atom_7e8ad928(object) then
		return v4, v5, v6
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_f7583f71 = __wf_atom_d2b2176d:__wf_atom_f7583f71()

	if not __wf_atom_7e8ad928(__wf_atom_f7583f71) then
		v4 = __wf_atom_d2b2176d:__wf_atom_2a745663(v4, 9, __wf_atom_f7583f71:__wf_atom_1bb5b1ff(), __wf_atom_f7583f71)
		v5 = __wf_atom_d2b2176d:__wf_atom_2a745663(v5, 9, __wf_atom_f7583f71:__wf_atom_1bb5b1ff(), __wf_atom_f7583f71)
		v6 = __wf_atom_d2b2176d:__wf_atom_2a745663(v3, 3, __wf_atom_f7583f71:__wf_atom_1bb5b1ff(), __wf_atom_f7583f71)
	end

	return v4, v5, v6
end

function GetAbilityUpgradeLevelInfo()
	local __wf_atom_d0620dc0 = module.__wf_atom_d0620dc0(_T.AbilityLevelQueryParms.Avatar)
	local level = _T.AbilityLevelQueryParms.Level

	if level == 1 then
		v = 40
		v2 = 20
		v3 = 7
	elseif level == 2 then
		v = 60
		v2 = 30
		v3 = 10
	elseif level == 3 then
		v = 80
		v2 = 40
		v3 = 12
	else
		v = 100
		v2 = 50
		v3 = 15
	end

	if _T.AbilityLevelQueryParms.Modded == true then
		v, v2, v3 = fn(_T.AbilityLevelQueryParms.Avatar, __wf_atom_d0620dc0)
	else
		v *= __wf_atom_d0620dc0
		v2 *= __wf_atom_d0620dc0
	end

	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, { Label = "/Lotus/Language/Menu/RANGE", Value = v })
	table.insert(abilityUpgradeLevelInfo, { Label = "/Lotus/Language/Game/STUN_RANGE", Value = v2 })
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Labels/AVATAR_STUN_TIME",
		Value = v3
	})
	abilityUpgradeLevelInfo.Modded = _T.AbilityLevelQueryParms.Modded
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function EvaluateAbility(object, object2, p)
	local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
	local v4 = __wf_atom_72fc675e.archwingRequired and __wf_atom_72fc675e.faction == 1
	local __wf_atom_0b8838a5 = object2:__wf_atom_0b8838a5()
	local flag = false

	if object2:__wf_atom_535d5cbb() and not (v4 or __wf_atom_0b8838a5) then
		local all = gRegion:FindAll(WeakResource("/EE/Types/Engine/SafeVolume"))

		if #all > 0 then
			for _, v5 in ipairs(all) do
				if v5:IsTouching(object2) then
					flag = true
				end
			end
		else
			flag = true
		end
	else
		flag = true
	end

	if flag then
		local __wf_atom_325f2969 = module.__wf_atom_325f2969(object2)
		module.__wf_atom_4a79bad2(object2)

		if p == 1 then
			v = 40
			v2 = 20
			v3 = 7
		elseif p == 2 then
			v = 60
			v2 = 30
			v3 = 10
		elseif p == 3 then
			v = 80
			v2 = 40
			v3 = 12
		else
			v = 100
			v2 = 50
			v3 = 15
		end

		local v5 = fn(object2, __wf_atom_325f2969)
		local _ = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
		Vector()
		local __wf_atom_d0069154 = object2:__wf_atom_d0069154()
		object2:__wf_atom_cb05c7fd(__wf_atom_d0069154)
		local v6 = __wf_atom_d0069154 + __wf_atom_e97f3142(object2:__wf_atom_4e50d390()) * v5
		local v7 = Vector()

		if object2:MotionControl():__wf_atom_902a5663(v6, v7) then
			object:__wf_atom_e638fc23(v7)
			return true
		end
	end

	object2:__wf_atom_623b3028(Symbol("/Lotus/Language/Game/AbilityActivationBlocked"))
	return false
end

local function fn2(_, __wf_atom_f7583f71, p, p2)
	local v4 = __wf_atom_fa8d0177(p2, p)
	v4.bank = Random(-180, 180)
	local entity = gRegion:CreateEntity(lineDeco, p2, v4, __wf_atom_f7583f71)

	if not __wf_atom_7e8ad928(entity) then
		local v5 = Length(p - p2) / 190
		entity:SetMaterialParam(SF.__wf_atom_db19d2a9, 1, 1, v5)
		entity:__wf_atom_82dcfcd4((Rotation(0, 0, Random(-8, 8))))
		entity:__wf_atom_8a035cd5(Symbol("DecoFade"), false)
	end
end

function BlinkEffect(instance, p, p2)
	local __wf_atom_e55d02aa = instance:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_f7583f71 = instance:__wf_atom_d2b2176d():__wf_atom_f7583f71()

	if instance:HasTag(Symbol("ArchwingFlight")) then
		__wf_atom_f7583f71 = __wf_atom_e55d02aa
	end

	if not __wf_atom_7e8ad928(castSound) then
		instance:PlaySound(castSound, false, 1)
	end

	gRegion:CreateEntity(blinkStartBurst, p, instance:__wf_atom_0e1e5bc9(), __wf_atom_f7583f71)

	if instance:__wf_atom_8efce136() then
		local v4 = instance:Attach(
			blinkAttach,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_f7583f71
		)
		local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(swimDeco)
		local cameraControl = instance:CameraControl()
		local gameCamera = gRegion:GetGameCamera()
		local entity = gRegion:CreateEntity(cameraSpotType, gameCamera:GetPosition(), gameCamera:__wf_atom_dc309f8a())

		if not __wf_atom_7e8ad928(entity) then
			cameraControl:SetCameraSpot(entity, 0)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:__wf_atom_dc5956fc(gameCamera, Symbol())
			end
		end

		fn2(instance, __wf_atom_f7583f71, p2, p)
		gRegion:CreateEntity(blinkBurst, p2 + Vector(0, 0.2, 0), instance:__wf_atom_4e50d390(), __wf_atom_f7583f71)

		if instance:__wf_atom_0b8838a5() then
			gRegion:CreateEntity(waterAdd, p2 + Vector(0, 0.8, 0), __wf_atom_80368bb1, __wf_atom_f7583f71)
		end

		cameraControl:SetCameraSpot(nil, 0.1)

		if not __wf_atom_7e8ad928(entity) then
			entity:Destroy()
		end

		if not __wf_atom_7e8ad928(v4) then
			v4:Destroy()
		end

		Sleep(1)

		if not (__wf_atom_7e8ad928(gameCamera) or __wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_7e8ad928(instance)) then
			__wf_atom_bb3e7833:__wf_atom_dc5956fc(instance, Symbol())
		end
	end
end

function ActivateAbility(object, object2, _, _, p)
	if object2:__wf_atom_8efce136() then
		object2:Blink(p)
		local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
		secondaryScriptArgs:__wf_atom_37d0a93a(p)
		object:ActivateSecondaryScript(mOwner:__wf_atom_e14d8a8c(), Symbol("Teleported"), secondaryScriptArgs)
	end

	if gRegion:IsMaster() then
		local all = gRegion:FindAll(__wf_atom_9e85eea2)

		for _, v4 in ipairs(all) do
			if __wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v4:__wf_atom_30e3d82b()) then
				continue
			end

			local __wf_atom_30e3d82b = v4:__wf_atom_30e3d82b()

			if __wf_atom_30e3d82b:__wf_atom_9a1e4ed3().entity ~= object2 then
				continue
			end

			__wf_atom_30e3d82b:__wf_atom_e4153bc7()
			__wf_atom_30e3d82b:__wf_atom_4a5d71f8()
			__wf_atom_30e3d82b:__wf_atom_920a5a62()
		end
	end

	local all = gRegion:FindAll(__wf_atom_05b12f3a)

	for _, v4 in ipairs(all) do
		if __wf_atom_7e8ad928(v4) or v4:__wf_atom_216d6edd() ~= object2 then
			continue
		end

		v4:__wf_atom_e4153bc7()
	end

	Sleep(0)
	Sleep(0)
end

function Teleported(object, p, p2)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_325f2969 = module.__wf_atom_325f2969(__wf_atom_6009c8ed)

	if p == 1 then
		v = 40
		v2 = 20
		v3 = 7
	elseif p == 2 then
		v = 60
		v2 = 30
		v3 = 10
	elseif p == 3 then
		v = 80
		v2 = 40
		v3 = 12
	else
		v = 100
		v2 = 50
		v3 = 15
	end

	local _, v4, v5 = fn(__wf_atom_6009c8ed, __wf_atom_325f2969)
	local __wf_atom_e93896ba = __wf_atom_6009c8ed:__wf_atom_e93896ba()
	local all = gRegion:FindAll(__wf_atom_9e85eea2, p2, 0, v4)

	for _, v6 in ipairs(all) do
		if
			__wf_atom_7e8ad928(v6)
			or v6:__wf_atom_8c3af1a5(__wf_atom_e93896ba)
			or v6:__wf_atom_39ae2374(9)
			or v6:__wf_atom_464a4772()
		then
			continue
		end

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(v6:__wf_atom_30e3d82b()) then
			v6:__wf_atom_30e3d82b():__wf_atom_707fb30f(true, v5)
			v6:__wf_atom_58c8ffec(Symbol("EXCALIBUR_BLIND"), false, 3, 1, true, __wf_atom_5784a397(0, 2))
		end

		v6:__wf_atom_d50c5af7(blindProjector, Symbol(), Vector(), Rotation(), v5)
	end
end

function DecoFade(instance)
	Sleep(0)
	local v4 = Random(0.7, 0.9)
	local v5 = Random(0.7, 1)
	local __wf_atom_06adb5a9 = instance:__wf_atom_06adb5a9(SF.__wf_atom_db19d2a9, 3)
	local total = 0

	while total < 1 and not __wf_atom_7e8ad928(instance) do
		local v6 = total * total
		instance:SetMaterialParam(SF.__wf_atom_f35beb09, 1 - v6)
		instance:SetMaterialParam(SF.__wf_atom_db19d2a9, 1 + v6 * v4, 1 + v6 * v4, __wf_atom_06adb5a9)
		total += __wf_atom_084b3e93() * v5
		Sleep(0)
	end

	instance:Destroy()
end