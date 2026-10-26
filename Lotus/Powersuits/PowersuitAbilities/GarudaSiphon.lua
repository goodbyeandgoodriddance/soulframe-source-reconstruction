local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("Lotus.Powersuits.PowersuitAbilities.PVPLib")
local v = Symbol("GAME_L1_WEAPON1")
local v2 = Symbol("vScales")
local v3 = Symbol("GAME_C1_SPINE2")
local v4 = 30
local radius = 2
local v5 = 10
local v6 = 0.05
local v7 = 0.05

local function fn(p)
	if module2.IsPvpEnabled() then
		if p == 1 then
			v4 = 10
			radius = 2
			v5 = 10
			v6 = 0.05
		elseif p == 2 then
			v4 = 15
			radius = 3
			v5 = 15
			v6 = 0.06
		elseif p == 3 then
			v4 = 20
			radius = 4
			v5 = 15
			v6 = 0.07
		else
			v4 = 25
			radius = 5
			v5 = 20
			v6 = 0.15
		end

		v7 = 0.05
	else
		v4 = 30

		if p == 1 then
			radius = 4
			v5 = 10
			v6 = 0.15
		elseif p == 2 then
			radius = 4.5
			v5 = 15
			v6 = 0.17
		elseif p == 3 then
			radius = 6
			v5 = 15
			v6 = 0.2
		else
			radius = 8
			v5 = 20
			v6 = 0.25
		end

		v7 = 0.01
	end
end

local function fn2(object)
	local v8 = v4
	local v9 = radius
	local v10 = v5
	local v11 = v6

	if __wf_atom_7e8ad928(object) then
		return v8, v9, v10, v11
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return v8, v9, v10, v11
	end

	local __wf_atom_1bb5b1ff = __wf_atom_e55d02aa:__wf_atom_1bb5b1ff()
	v8 = __wf_atom_d2b2176d:__wf_atom_2a745663(v4, 9, __wf_atom_1bb5b1ff, __wf_atom_e55d02aa)
	v9 = __wf_atom_d2b2176d:__wf_atom_2a745663(radius, 9, __wf_atom_1bb5b1ff, __wf_atom_e55d02aa)
	v10 = __wf_atom_d2b2176d:__wf_atom_2a745663(v5, 3, __wf_atom_1bb5b1ff, __wf_atom_e55d02aa)
	v11 = __wf_atom_d2b2176d:__wf_atom_2a745663(v6, 10, __wf_atom_1bb5b1ff, __wf_atom_e55d02aa)
	return v8, v9, v10, v11
end

function GetAbilityUpgradeLevelInfo()
	fn(_T.AbilityLevelQueryParms.Level)

	if _T.AbilityLevelQueryParms.Modded == true then
		v4, radius, v5, v6 = fn2(_T.AbilityLevelQueryParms.Avatar)
	end

	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Labels/AVATAR_ABILITY_RANGE",
		Value = v4,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/HEAL_RADIUS",
		Value = radius,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/ABILITY_DURATION",
		Value = v5,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/HEALTH_PER_SEC",
		Value = math.floor(v6 * 100),
		ValueUnit = "/Lotus/Language/Game/UNIT_PERCENT"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/DPS",
		Value = math.floor(v7 * 100),
		ValueUnit = "/Lotus/Language/Game/UNIT_PERCENT"
	})
	abilityUpgradeLevelInfo.EnergyCost = Resource(_T.AbilityLevelQueryParms.Ability:__wf_atom_1bb5b1ff()):__wf_atom_cb2fe64e(false)
	abilityUpgradeLevelInfo.Modded = _T.AbilityLevelQueryParms.Modded
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

local function fn3(p, object)
	if
		__wf_atom_7e8ad928(object)
		or object:IsKilled()
		or object:__wf_atom_39ae2374(9)
		or object:__wf_atom_4402f880(p)
	then
		return false
	end

	local __wf_atom_7470861b = object:__wf_atom_7470861b()
	return not (__wf_atom_7470861b:__wf_atom_f5007eb3(20) or __wf_atom_7470861b:__wf_atom_fbb7443d())
end

local function fn4(object, object2, p, list, p2)
	local v8 = __wf_atom_e97f3142(object2:__wf_atom_4e50d390())
	local v9 = {}

	for _, v10 in ipairs(list) do
		if not (fn3(object2, v10) and (p or Dot(v10:__wf_atom_a2a18137() - p2, v8) > 0)) then
			continue
		end

		if v10:IsA(__wf_atom_863f6fee) or v10:IsA(__wf_atom_c7671663) or v10:IsA(__wf_atom_6c243c5e) then
			continue
		end

		local __wf_atom_f51f1faa = v10:__wf_atom_f51f1faa()

		if not (__wf_atom_7e8ad928(__wf_atom_f51f1faa) or not __wf_atom_f51f1faa:__wf_atom_d4dc8568()) then
			continue
		end

		local flag = true

		for _, list2 in pairs(_T.garudaSiphon) do
			for _, v11 in ipairs(list2) do
				if v10 ~= v11 then
					continue
				end

				flag = false
				break
			end

			if not flag then
				break
			end
		end

		if flag then
			table.insert(v9, v10)
		end
	end

	if #v9 == 0 then
		if p or not mOwner:IsActive() then
			return false, Symbol("/Lotus/Language/Game/AbilityErrorInvalidTarget")
		end

		object:DeactivateAbility(mOwner:__wf_atom_1bb5b1ff())
		return false
	else
		local v10 = nil

		for _, v11 in ipairs(v9) do
			if not (v11:__wf_atom_d5fda8be(p2) <= v4) then
				continue
			end

			v10 = v11
			break
		end

		if v10 == nil then
			return false, Symbol("/Lotus/Language/Game/AbilityErrorOutOfRange")
		end

		return true, v10
	end
end

function EvaluateAbility(object, object2, p)
	fn(p)
	v4 = fn2(object2)
	local __wf_atom_0251b5eb = object2:__wf_atom_0251b5eb(0.75, v4, 2, true, true)
	local v8 = __wf_atom_0251b5eb == nil and {} or __wf_atom_0251b5eb
	local __wf_atom_f2e7f4a9 = object2:__wf_atom_d2b2176d():__wf_atom_f2e7f4a9()

	if not __wf_atom_7e8ad928(__wf_atom_f2e7f4a9) then
		if __wf_atom_f2e7f4a9:IsA(__wf_atom_d127f143) then
			__wf_atom_f2e7f4a9 = __wf_atom_f2e7f4a9:__wf_atom_6009c8ed()
		end

		if not __wf_atom_7e8ad928(__wf_atom_f2e7f4a9) and __wf_atom_f2e7f4a9:IsA(__wf_atom_4ebf67cb) then
			if _T.garudaSiphon ~= nil then
				local __wf_atom_18aa6e58 = object2:__wf_atom_18aa6e58()

				for _, v9 in ipairs(_T.garudaSiphon[__wf_atom_18aa6e58]) do
					if v9 ~= __wf_atom_f2e7f4a9 then
						continue
					end

					local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
					secondaryScriptArgs:__wf_atom_a17e41c6(__wf_atom_f2e7f4a9)
					object:__wf_atom_e6831c5c(mOwner, Symbol("LetGo"), secondaryScriptArgs)
					return false
				end
			end

			table.insert(v8, 1, __wf_atom_f2e7f4a9)
		end
	end

	if mOwner:__wf_atom_cb2fe64e(false) == 0 and mOwner:__wf_atom_de7e7709() == 0 then
		local __wf_atom_6557214c = object:__wf_atom_6557214c(Resource(mOwner:__wf_atom_1bb5b1ff()):__wf_atom_cb2fe64e(false))
		local __wf_atom_f3044fe0 = object:__wf_atom_f3044fe0()
		local __wf_atom_a615e414 = object:__wf_atom_a615e414()

		if __wf_atom_a615e414 > 0 then
			__wf_atom_f3044fe0 = object2:__wf_atom_7470861b():__wf_atom_7faf4619()
			__wf_atom_6557214c *= __wf_atom_a615e414
		end

		if __wf_atom_f3044fe0 < __wf_atom_6557214c and not module.__wf_atom_0043ea07(object2, false) then
			if __wf_atom_a615e414 > 0 then
				object2:__wf_atom_623b3028(Symbol("/Lotus/Language/Game/AbilityNeedMoreShield"))
			else
				object2:__wf_atom_623b3028(Symbol("/Lotus/Language/Game/AbilityNeedMoreEnergy"))
			end

			return false
		end
	end

	local v9, v10 = fn4(object, object2, true, v8, object2:GetPosition())

	if not v9 then
		object2:__wf_atom_623b3028(v10)
		return false
	end

	local v11 = Vector()
	local __wf_atom_3ec9f18c = gRegion:__wf_atom_3ec9f18c(
		object2:__wf_atom_d0069154(),
		v10:__wf_atom_d0069154(),
		0.1,
		object2,
		v11,
		true
	)

	if __wf_atom_7e8ad928(__wf_atom_3ec9f18c) or __wf_atom_3ec9f18c == v10 then
		object:__wf_atom_f7170fc9(v10)
		return true
	end

	object2:__wf_atom_623b3028(Symbol("/Lotus/Language/Game/AbilityErrorTargetObstructed"))
	return false
end

function NpcEvaluateAbility(_, _)
	return 0
end

function InitializeAbility(_, _)
	if module2.IsFightingGame() then
		mOwner:__wf_atom_b5374ea1(gGameRules:__wf_atom_db9127e8() + 100)
	end
end

local v8 = {
	instigatorAvatar = nil,
	suit = nil,
	realAvatar = nil,
	realSuit = nil,
	position = nil,
	targetAvatar = nil
}

local function fn5(suit, instigatorAvatar, realSuit, realAvatar, p, targetAvatar, p2)
	gRegion:CreateEntity(realSuit:__wf_atom_43cc9de1(Symbol("SiphonCastBurst")), p, __wf_atom_80368bb1, realSuit)

	if
		__wf_atom_7e8ad928(targetAvatar)
		or targetAvatar:IsKilled()
		or not __wf_atom_7e8ad928(targetAvatar:__wf_atom_f51f1faa())
		and targetAvatar:__wf_atom_f51f1faa():__wf_atom_d4dc8568()
	then
		if instigatorAvatar == realAvatar then
			if gRegion:IsMaster() and not module2.IsPvpEnabled() then
				suit:__wf_atom_19516b62(p2)
			end

			if not __wf_atom_7e8ad928(targetAvatar) then
				targetAvatar:__wf_atom_9373d0eb(6, false)
			end
		end
	else
		v8.instigatorAvatar = instigatorAvatar
		v8.suit = suit
		v8.realAvatar = realAvatar
		v8.realSuit = realSuit
		v8.position = targetAvatar:GetPosition()
		v8.targetAvatar = targetAvatar
		local entity = gRegion:CreateEntity(
			realSuit:__wf_atom_43cc9de1(Symbol("SiphonRangeDeco")),
			v8.position,
			__wf_atom_80368bb1,
			realSuit
		)

		if not __wf_atom_7e8ad928(entity) then
			entity:SetMeshScale(radius / 1.25)
			entity:__wf_atom_8a035cd5(Symbol("DoSiphon"), false)
		end
	end
end

local function fn6(object, p)
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if p then
		__wf_atom_7470861b:__wf_atom_6cbcca8d(__wf_atom_37768748, 26, 6, 0, 0)
		__wf_atom_7470861b:__wf_atom_77b5f32e(__wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(0, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(4, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(5, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(7, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(11, __wf_atom_37768748)
	else
		__wf_atom_7470861b:__wf_atom_a8cf605f(__wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_9f17ac89(__wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_56b2394e(0, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_56b2394e(3, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_56b2394e(4, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_56b2394e(5, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_56b2394e(7, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_56b2394e(11, __wf_atom_37768748)
	end
end

function ActivateAbility(object, object2, object3, p)
	fn(p)
	v4, radius, v5, v6 = fn2(object2)
	local motionControl = object2:MotionControl()

	if not __wf_atom_7e8ad928(object3) then
		motionControl:__wf_atom_3a1d0c16(__wf_atom_fa8d0177(object2:GetPosition(), object3:GetPosition()))
	end

	if not module.__wf_atom_0043ea07(object2, false) then
		mOwner:__wf_atom_b5374ea1(Resource(mOwner:__wf_atom_1bb5b1ff()):__wf_atom_cb2fe64e(false))
	end

	local __wf_atom_cb2fe64e = mOwner:__wf_atom_cb2fe64e()

	if __wf_atom_7e8ad928(object3) or object3:IsKilled() then
		if gRegion:IsMaster() and not module2.IsPvpEnabled() then
			object:__wf_atom_19516b62(__wf_atom_cb2fe64e)
		end
	else
		if not (object3:__wf_atom_464a4772() or object3:__wf_atom_39ae2374(9)) then
			object3:__wf_atom_9373d0eb(6, true)
		end

		fn6(object2, true)
		object2:Attach(
			object:__wf_atom_43cc9de1(Symbol("SiphonCast")),
			v,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			object
		)
		object:__wf_atom_2f54a1b2(true)
		local v9 = module.PlayAnim(object, activateAnim, false, 2, 1, true)
		local v10 = v9 * activateAnim:__wf_atom_091354f5(Symbol("SiphonDash"))
		local v11 = v9 * activateAnim:__wf_atom_091354f5(Symbol("SiphonArrive")) - v10
		local v12 = v9 * activateAnim:__wf_atom_091354f5(Symbol("SiphonTear")) - (v10 + v11)
		Sleep(v10)

		if __wf_atom_7e8ad928(object3) or object3:IsKilled() then
			if gRegion:IsMaster() and not module2.IsPvpEnabled() then
				object:__wf_atom_19516b62(__wf_atom_cb2fe64e)
			end
		else
			if object2:__wf_atom_4417a5d4() then
				local position = object3:GetPosition()

				while v11 > 0 do
					if not __wf_atom_7e8ad928(object3) then
						position = object3:GetPosition()
					end

					local v13 = position - object2:GetPosition()
					local v14 = Length(v13)

					if v14 < 1 or v4 * 2 < v14 then
						break
					end

					local v15 = math.min(1000, v14 * 2 / v11)
					local v16 = math.min(150, v15)
					motionControl:__wf_atom_4bb21efc(v13 * v16 / v14)
					motionControl:__wf_atom_3a1d0c16(__wf_atom_fa8d0177(object2:GetPosition(), position))
					Sleep(0)
					v11 -= __wf_atom_084b3e93() * v16 / v15
				end

				motionControl:__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
				gRegion:__wf_atom_f6ec80de(
					object2,
					object2:GetPosition(),
					0,
					8,
					100,
					0,
					object3,
					object,
					16,
					true,
					false,
					true,
					0
				)
			end

			Sleep((math.max(0, v12 + v11)))
			local cameraControl = object2:CameraControl()

			if not __wf_atom_7e8ad928(cameraControl) then
				cameraControl:__wf_atom_4dab66dd(object2:EyePosition(), -1, 65, 2)
			end

			object:__wf_atom_2f54a1b2(false)
			fn5(object, object2, object, object2, object2:__wf_atom_1c374cc9(v), object3, __wf_atom_cb2fe64e)
		end
	end
end

function DeactivateAbility(_, object, _, _)
	if _T.garudaSiphon ~= nil and _T.garudaSiphon[object:__wf_atom_18aa6e58()] ~= nil then
		mOwner:__wf_atom_b5374ea1(0)
	end

	fn6(object, false)
end

function CrewShipInfo()
	local mAbility = _T.CrewShipAbilityInfo.mAbility
	local __wf_atom_c78fa517 = mAbility:__wf_atom_c78fa517()
	fn(__wf_atom_c78fa517:__wf_atom_cc3c265a(__wf_atom_c78fa517:__wf_atom_248bb7ae(mAbility:__wf_atom_1bb5b1ff())))
	v4, radius = fn2(__wf_atom_c78fa517:__wf_atom_6009c8ed())
	_T.CrewShipAbilityInfo.mAbilityInfo = {
		Radius = radius,
		EnergyCost = mAbility:__wf_atom_cb2fe64e(true)
	}
end

function CrewShipEval(p)
	local pos = _T.CrewShipAbilityEval.pos
	local v9 = gRegion:FindAll(__wf_atom_9e85eea2, pos, 0, _T.CrewShipAbilityEval.radius) or {}
	table.sort(v9, function(a, b)
		return a:__wf_atom_d5fda8be(pos) < b:__wf_atom_d5fda8be(pos)
	end)
	local success, v10 = fn4(nil, p, true, v9, pos)
	_T.CrewShipAbilityEval = {
		success = success,
		target = success and v10 or nil
	}
end

function CrewShipActivate(p, p2, p3, p4, p5, _, p6, p7)
	local name = mOwner:__wf_atom_1bb5b1ff():GetName()

	if module.__wf_atom_215c632b(name) then
		return true
	end

	fn(p5)
	v4, radius, v5, v6 = fn2(p4)

	if not __wf_atom_7e8ad928(p7) then
		fn5(p2, p, p3, p4, p6, p7)
	end

	module.__wf_atom_c97a0164(name)
end

function DoSiphon(object)
	local instigatorAvatar = v8.instigatorAvatar
	local suit = v8.suit
	local realAvatar = v8.realAvatar
	local realSuit = v8.realSuit
	local position = v8.position
	local targetAvatar = v8.targetAvatar
	local __wf_atom_1bb5b1ff = mOwner:__wf_atom_1bb5b1ff()
	local isMaster = gRegion:IsMaster()
	local v9 = instigatorAvatar ~= realAvatar

	if not v9 then
		mOwner:__wf_atom_b5374ea1(0)
	end

	if _T.garudaSiphon == nil then
		_T.garudaSiphon = {}
	end

	local __wf_atom_18aa6e58 = instigatorAvatar:__wf_atom_18aa6e58()

	if _T.garudaSiphon[__wf_atom_18aa6e58] == nil then
		_T.garudaSiphon[__wf_atom_18aa6e58] = {}
	end

	for i = #_T.garudaSiphon[__wf_atom_18aa6e58], 1, -1 do
		local v10 = _T.garudaSiphon[__wf_atom_18aa6e58][i]

		if __wf_atom_7e8ad928(v10) or v10:IsKilled() then
			table.remove(_T.garudaSiphon[__wf_atom_18aa6e58], i)
		end
	end

	if #_T.garudaSiphon[__wf_atom_18aa6e58] >= 3 then
		table.remove(_T.garudaSiphon[__wf_atom_18aa6e58], 1)
	end

	table.insert(_T.garudaSiphon[__wf_atom_18aa6e58], targetAvatar)
	local v10 = math.max(1, targetAvatar:GetMaxHealth() * v7)
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	local __wf_atom_7470861b = targetAvatar:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_6cbcca8d(__wf_atom_37768748, 26, 6, 0, 0)
	local __wf_atom_bf9d0dc4 = __wf_atom_7470861b:__wf_atom_bf9d0dc4(0)
	local __wf_atom_1c374cc9 = targetAvatar:__wf_atom_1c374cc9(__wf_atom_bf9d0dc4, false)
	local v11 = Rotation(math.random(-180, 180), math.random(-180, 180), 0)
	local entity = gRegion:CreateEntity(siphonDecoType, __wf_atom_1c374cc9, v11, realSuit)
	local __wf_atom_43cc9de1 = suit:__wf_atom_43cc9de1(Symbol("SpearMesh"))

	if not (__wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(__wf_atom_43cc9de1)) then
		entity:__wf_atom_45cf0e1a(__wf_atom_43cc9de1, false, false)
	end

	local v12 = Rotation(math.random(-180, 180), -90, 0)
	local v13

	if isMaster then
		v13 = Engine.DamageData()
		v13:__wf_atom_7498285f(17, 1)
		__wf_atom_7470861b:__wf_atom_249d0297(true)
	end

	local buffNotification = SF.BuffNotification()
	buffNotification.instigator = instigatorAvatar
	buffNotification.buffType = 2
	buffNotification.abilityType = __wf_atom_1bb5b1ff
	buffNotification.buffData = math.floor(v6 * 100)
	local v14, v15

	if __wf_atom_7470861b:__wf_atom_5ab5c7c4() == 5 then
		v14 = targetAvatar:Attach(
			realSuit:__wf_atom_43cc9de1(Symbol("SiphonEnemyAttachRobot")),
			__wf_atom_bf9d0dc4,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			realSuit
		)
		v15 = gRegion:CreateEntity(siphonDecoTwoTypeRobot, targetAvatar:__wf_atom_a2a18137(), v12, realSuit)
	else
		v14 = targetAvatar:Attach(
			realSuit:__wf_atom_43cc9de1(Symbol("SiphonEnemyAttach")),
			__wf_atom_bf9d0dc4,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			realSuit
		)
		v15 = gRegion:CreateEntity(siphonDecoTwoType, targetAvatar:__wf_atom_a2a18137(), v12, realSuit)
	end

	if not (__wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(__wf_atom_43cc9de1)) then
		v15:__wf_atom_45cf0e1a(__wf_atom_43cc9de1, false, false)
	end

	if isMaster then
		local damageData = Engine.DamageData()
		damageData:__wf_atom_d6f4d914(20, true)
		targetAvatar:__wf_atom_649bf33e(damageData)
	end

	targetAvatar:__wf_atom_dd875cd8(true)
	local flag = false
	local v16 = {}
	local v17 = 0
	local v18 = 0
	local uniqueAbilityId = module.GetUniqueAbilityId()

	if not v9 then
		_T.AddAbilityTimer(__wf_atom_1bb5b1ff, instigatorAvatar, v5, uniqueAbilityId)
	end

	local v19 = targetAvatar

	while
		v5 > 0
		and not __wf_atom_7e8ad928(mOwner)
		and not __wf_atom_7e8ad928(instigatorAvatar)
		and not instigatorAvatar:IsKilled()
		and not __wf_atom_7e8ad928(v19)
		and fn3(instigatorAvatar, targetAvatar)
	do
		local v20 = false

		if _T.garudaSiphon ~= nil then
			for _, v21 in ipairs(_T.garudaSiphon[__wf_atom_18aa6e58]) do
				if v21 ~= targetAvatar then
					continue
				end

				v20 = true
				break
			end
		end

		if not v20 then
			break
		end

		if not flag then
			local __wf_atom_f51f1faa = targetAvatar:__wf_atom_f51f1faa()

			if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
				__wf_atom_f51f1faa:__wf_atom_41296388(true)

				if not __wf_atom_7e8ad928(entity) then
					local __wf_atom_fec6bb4d = __wf_atom_f51f1faa:__wf_atom_fec6bb4d(1)

					if not __wf_atom_7e8ad928(__wf_atom_fec6bb4d) then
						targetAvatar:AttachRagdoll(__wf_atom_fec6bb4d, entity, Symbol("GAME_C1_ROOT"), true)
					end
				end

				v19 = __wf_atom_f51f1faa
				flag = true
			end
		end

		if v18 < 1 and not __wf_atom_7e8ad928(entity) then
			v18 = math.min(1, v18 + __wf_atom_084b3e93() * 16)
			entity:Teleport(
				__wf_atom_1c374cc9 + __wf_atom_f55d6358(__wf_atom_28d5d4aa, Vector(0, 0.5, 0), v18),
				(__wf_atom_d919c2d7(v12, Rotation(0, __wf_atom_104bfe98(0, -180, v18), 0)))
			)
		end

		if v17 <= 0 then
			local affected = {}

			for k, v21 in pairs(v16) do
				local avatar = v21.avatar

				if
					not __wf_atom_7e8ad928(avatar)
					and instigatorAvatar:__wf_atom_f2309174(avatar)
					and not (avatar:__wf_atom_39ae2374(14) or mOwner:__wf_atom_bb0b791e(avatar))
				then
					local __wf_atom_d5fda8be = avatar:__wf_atom_d5fda8be(position)

					if not (radius < __wf_atom_d5fda8be or avatar:__wf_atom_c6f1f83d() >= avatar:GetMaxHealth()) then
						continue
					end
				end

				if not __wf_atom_7e8ad928(v21.linkFx) then
					v21.linkFx:Destroy()
				end

				if not __wf_atom_7e8ad928(v21.wind) then
					v21.wind:Destroy()
				end

				module.__wf_atom_69b355fe(__wf_atom_37768748, instigatorAvatar, avatar)
				table.insert(affected, avatar)
				v16[k] = nil
			end

			if #affected > 0 then
				buffNotification.affected = affected
				instigatorAvatar:__wf_atom_abdab2f9(buffNotification, false, true)
				affected = {}
			end

			local all = gRegion:FindAll(__wf_atom_4ebf67cb, position, 0, radius)

			for _, avatar in ipairs(all) do
				local __wf_atom_18aa6e58_2 = avatar:__wf_atom_18aa6e58()

				if
					not avatar:__wf_atom_129d1aba(instigatorAvatar)
					or mOwner:__wf_atom_bb0b791e(avatar)
					or not instigatorAvatar:__wf_atom_f2309174(avatar)
					or avatar:__wf_atom_39ae2374(14)
				then
					continue
				end

				if not (avatar:__wf_atom_c6f1f83d() < avatar:GetMaxHealth() and v16[__wf_atom_18aa6e58_2] == nil) then
					continue
				end

				table.insert(affected, avatar)
				local linkFx = v19:Attach(linkFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, realAvatar)

				if not __wf_atom_7e8ad928(linkFx) then
					linkFx:__wf_atom_341daa34(avatar, 0)
				end

				module.__wf_atom_35d06ab6(__wf_atom_37768748, instigatorAvatar, avatar)
				v16[__wf_atom_18aa6e58_2] = {
					avatar = avatar,
					totalHeal = 0,
					linkFx = linkFx,
					wind = avatar:Attach(windAttach, v3)
				}
			end

			if #affected > 0 then
				buffNotification.affected = affected
				instigatorAvatar:__wf_atom_abdab2f9(buffNotification, true, true)
			end

			if isMaster then
				local count = 0

				for _, v21 in pairs(v16) do
					count += 1
					local avatar = v21.avatar
					local maxHealth = avatar:GetMaxHealth()
					local __wf_atom_c6f1f83d = avatar:__wf_atom_c6f1f83d()

					if not (__wf_atom_c6f1f83d < maxHealth) then
						continue
					end

					v21.totalHeal += (maxHealth - __wf_atom_c6f1f83d) * (v6 * 0.25)
					local totalHeal = math.floor(v21.totalHeal)

					if not (totalHeal > 0) then
						continue
					end

					avatar:Heal(avatar, totalHeal, instigatorAvatar)
					module.NotifyHeal(instigatorAvatar, avatar:__wf_atom_c6f1f83d() - __wf_atom_c6f1f83d)
					v21.totalHeal -= totalHeal
				end

				if count > 0 then
					v13:__wf_atom_6d7ec072(Engine.UpgradedValue(v10 * 0.25 * count))
					targetAvatar:__wf_atom_649bf33e(v13)
				end
			end

			if next(v16) == nil then
				if not __wf_atom_7e8ad928(object) then
					object:SetMaterialParam(v2, 1, 0.5, 1, 0)
				end
			elseif not __wf_atom_7e8ad928(object) then
				object:SetMaterialParam(v2, 1, 1.2, 1, 0)
			end

			v17 += 0.25
		end

		Sleep(0)
		v17 -= __wf_atom_084b3e93()
		v5 -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(targetAvatar) then
		if flag then
			local __wf_atom_f51f1faa = targetAvatar:__wf_atom_f51f1faa()

			if not __wf_atom_7e8ad928(__wf_atom_f51f1faa) then
				__wf_atom_f51f1faa:__wf_atom_41296388(false)
				targetAvatar:__wf_atom_8391ca00(__wf_atom_f51f1faa:__wf_atom_fec6bb4d(1))
			end
		end

		targetAvatar:__wf_atom_9373d0eb(6, false)
		targetAvatar:__wf_atom_dd875cd8(false)
		__wf_atom_7470861b:__wf_atom_a8cf605f(__wf_atom_37768748)

		if gRegion:IsMaster() then
			local __wf_atom_07dba710 = __wf_atom_7470861b:__wf_atom_07dba710()
			__wf_atom_7470861b:__wf_atom_249d0297(false)

			if __wf_atom_07dba710:__wf_atom_6386920d():__wf_atom_37799654() > 0 then
				__wf_atom_07dba710:__wf_atom_6b472125(instigatorAvatar)
				__wf_atom_07dba710:__wf_atom_34a8a27a(suit)
				targetAvatar:__wf_atom_649bf33e(__wf_atom_07dba710)
			end
		end
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:PlayTriggeredFade()
	end

	if not __wf_atom_7e8ad928(v15) then
		v15:PlayTriggeredFade()
	end

	if not __wf_atom_7e8ad928(v14) then
		v14:Destroy()
	end

	local avatars = {}

	for _, v20 in pairs(v16) do
		if not __wf_atom_7e8ad928(v20.linkFx) then
			v20.linkFx:Destroy()
		end

		if not __wf_atom_7e8ad928(v20.wind) then
			v20.wind:Destroy()
		end

		if __wf_atom_7e8ad928(v20.avatar) then
			continue
		end

		table.insert(avatars, v20.avatar)
		module.__wf_atom_69b355fe(__wf_atom_37768748, instigatorAvatar, v20.avatar)
	end

	if #avatars > 0 then
		buffNotification.affected = avatars
		instigatorAvatar:__wf_atom_abdab2f9(buffNotification, false, true)
	end

	if _T.garudaSiphon ~= nil then
		for i, v20 in ipairs(_T.garudaSiphon[__wf_atom_18aa6e58]) do
			if v20 ~= targetAvatar then
				continue
			end

			table.remove(_T.garudaSiphon[__wf_atom_18aa6e58], i)
			break
		end

		if #_T.garudaSiphon[__wf_atom_18aa6e58] == 0 then
			_T.garudaSiphon[__wf_atom_18aa6e58] = nil

			if not v9 then
				_T.AddAbilityTimer(__wf_atom_1bb5b1ff, instigatorAvatar, 0, uniqueAbilityId)
			end

			if not (__wf_atom_7e8ad928(mOwner) or v9) then
				mOwner:__wf_atom_b5374ea1(Resource(mOwner:__wf_atom_1bb5b1ff()):__wf_atom_cb2fe64e(false))
			end
		end

		if next(_T.garudaSiphon) == nil then
			_T.garudaSiphon = nil
		end
	end

	object:PlayTriggeredFade()
end

function LetGo(object, _, object2)
	if _T.garudaSiphon == nil then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local __wf_atom_18aa6e58 = __wf_atom_6009c8ed:__wf_atom_18aa6e58()

	for i = #_T.garudaSiphon[__wf_atom_18aa6e58], 1, -1 do
		if _T.garudaSiphon[__wf_atom_18aa6e58][i] ~= object2 then
			continue
		end

		table.remove(_T.garudaSiphon[__wf_atom_18aa6e58], i)
		gRegion:PlaySound(letGoSound, object2:GetPosition(), false, 0, __wf_atom_6009c8ed)
		break
	end
end

function CensorProjector(object)
	local v9 = __wf_atom_9a7a37ad()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not (v9 or __wf_atom_7e8ad928(__wf_atom_18a5d83b)) then
		v9 = __wf_atom_18a5d83b:Settings():__wf_atom_8d143e5c()
	end

	if v9 then
		local v10 = Vector(0.04, 0.04, 0.04)
		object:SetMaterialParam(Symbol("BloodColor"), v10.x, v10.y, v10.z, 0.5)
	end
end