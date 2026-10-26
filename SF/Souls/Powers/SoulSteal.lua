local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("Lotus.Scripts.Libs.EasingLib")
local module4 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module5 = require("SF.Souls.Powers.EntitySoulModeScans")
local module6 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module7 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = WeakResource("/SF/Types/Player/Ghost/SfSparrowGhostAvatar")
local v2 = WeakResource("/SF/Types/Gameplay/EnergyWellGiveLore")
local v3 = WeakResource("/SF/Types/Game/SoulStealInfo/ScanBaseTypeSSE")
local v4 = Symbol("SOUL_STEAL_WEAPON")
local v5 = WeakResource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")
local v6 = false
local v7 = nil
local pullTime2 = 0.75
local fn
local fn2

local function fn3(object, instance, p)
	if __wf_atom_7e8ad928(instance) or instance:IsKilled() or object == instance then
		return false
	end

	if instance:__wf_atom_129d1aba(object) then
		if __wf_atom_7e8ad928(instance:__wf_atom_a96eb2aa()) or not instance:IsA(v) then
			return false
		end
	elseif instance:IsA(__wf_atom_6c243c5e) then
		if instance:__wf_atom_60a880d0() or not instance:__wf_atom_4573db05() then
			return false
		end
	else
		local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

		if
			__wf_atom_7e8ad928(__wf_atom_bb3e7833)
			or not __wf_atom_bb3e7833:__wf_atom_572fc369()
			or not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:IsA(v3) and not p
		then
			return false
		end
	end

	return true
end

local function fn4(object)
	local __wf_atom_d2b2176d = object:__wf_atom_6009c8ed():__wf_atom_d2b2176d()
	local __wf_atom_1bb5b1ff = object:__wf_atom_1bb5b1ff()

	for i = object:__wf_atom_dcd7aaf9() + 1, object:__wf_atom_87a16e10() do
		local __wf_atom_c497b0ae = object:__wf_atom_c497b0ae(i - 1)

		if
			not __wf_atom_7e8ad928(__wf_atom_c497b0ae)
			and __wf_atom_d2b2176d:__wf_atom_c1f9859f(
				1,
				__wf_atom_1bb5b1ff,
				object,
				__wf_atom_c497b0ae:__wf_atom_1bb5b1ff()
			)
		then
			return __wf_atom_c497b0ae
		end
	end

	return nil
end

local function fn5(object)
	local v8 = {}

	if not object then
		return v8
	end

	table.insert(v8, object)
	local creator = object:GetCreator()

	if not __wf_atom_7e8ad928(creator) and creator:IsA(__wf_atom_7e616794) then
		table.insert(v8, creator)

		if creator:IsA(__wf_atom_4ebf67cb) and creator:__wf_atom_f51f1faa() then
			table.insert(v8, creator:__wf_atom_f51f1faa())
		end
	end

	return v8
end

local function fn6(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Unequip(0, 2)

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
		__wf_atom_d2b2176d:Unequip(0, 2)
		Sleep(0)
	end
end

local function fn7(object)
	local ancestorUpgradeRankValueForTag = module4.GetAncestorUpgradeRankValueForTag(
		v5,
		Symbol("SoulStealDistance"),
		Symbol("TARGET_RANGE")
	)

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

		if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
			ancestorUpgradeRankValueForTag = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
				ancestorUpgradeRankValueForTag,
				165,
				__wf_atom_35a10d3c:__wf_atom_1bb5b1ff(),
				__wf_atom_35a10d3c
			)
		end
	end

	return ancestorUpgradeRankValueForTag
end

local function fn8(instance, instigatorAvatar)
	if __wf_atom_7e8ad928(instance) then
		return {}
	end

	local v8 = 3.4028234663852886e38
	local v9 = nil

	for _, v10 in gRegion:__wf_atom_ef7900cf() do
		local __wf_atom_d5fda8be = instance:__wf_atom_d5fda8be(v10:GetPosition())

		if
			__wf_atom_7e8ad928(v10)
			or v10 == instigatorAvatar
			or not (__wf_atom_d5fda8be < v8)
			or not (__wf_atom_d5fda8be <= fn7(v10))
		then
			continue
		end

		v9 = v10
		v8 = __wf_atom_d5fda8be
	end

	return v9
end

local function fn9()
	return module4.GetAncestorUpgradeRankValueForTag(v5, Symbol("SoulStealDistance"), Symbol("TARGET_RANGE_MOTE"))
end

function EvaluateAbility(object, object2, _)
	local position = object2:GetPosition()
	local v8, v9 = CheckQueuedSoulStealTarget(object2)

	if __wf_atom_7e8ad928(v8) then
		local soulScanTable = module5.GetSoulScanTable(object2)
		local v10 = not __wf_atom_7e8ad928(soulScanTable) and soulScanTable.timeScanningCompleted ~= nil
		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
		local aimPosition = object2:GetAimPosition()
		local v11 = __wf_atom_e97f3142(object2:__wf_atom_4e50d390())
		local v12 = {}
		local v13 = object2:__wf_atom_0251b5eb(
				2,
				fn7(object2),
				module4.GetAncestorUpgradeRankValueForTag(v5, Symbol("SoulStealDistance"), Symbol("TARGET_RADIUS")),
				true,
				true
			)
			or {}
		local __wf_atom_f2e7f4a9 = __wf_atom_d2b2176d:__wf_atom_f2e7f4a9()

		if not __wf_atom_7e8ad928(__wf_atom_f2e7f4a9) then
			if __wf_atom_f2e7f4a9:IsA(__wf_atom_d127f143) then
				__wf_atom_f2e7f4a9 = __wf_atom_f2e7f4a9:__wf_atom_6009c8ed()
			end

			if
				not __wf_atom_7e8ad928(__wf_atom_f2e7f4a9)
				and __wf_atom_f2e7f4a9:IsA(__wf_atom_4ebf67cb)
				and __wf_atom_f2e7f4a9:__wf_atom_d5fda8be(position) <= fn7(object2)
			then
				table.insert(v13, 1, __wf_atom_f2e7f4a9)
			end
		end

		for _, v14 in ipairs(v13) do
			if not (fn3(object2, v14, v10) and Dot(v14:__wf_atom_a2a18137() - aimPosition, v11) > 0) then
				continue
			end

			table.insert(v12, v14)
		end

		if #v12 > 0 then
			local v14 = nil

			for _, v15 in ipairs(v12) do
				if v15:IsA(__wf_atom_6c243c5e) then
					continue
				end

				v14 = v15
				break
			end

			if not __wf_atom_7e8ad928(v14) then
				object:__wf_atom_f7170fc9(v14)
				return true
			end
		end

		local all = gRegion:FindAll(__wf_atom_faccb0cf, position, 0, fn9())
		local __wf_atom_74d951b0 = __wf_atom_d2b2176d:__wf_atom_74d951b0()
		local v14 = {
			__wf_atom_4ebf67cb,
			__wf_atom_3feeb44a,
			__wf_atom_43e0c427,
			__wf_atom_7b01f9ce
		}
		local v15 = {}

		for _, v16 in ipairs(all) do
			if not ((not v16:IsA(v3) or v10) and v16:__wf_atom_572fc369()) then
				continue
			end

			local __wf_atom_d0069154 = v16:__wf_atom_d0069154()

			if not (Dot(__wf_atom_d0069154 - aimPosition, v11) > 0) then
				continue
			end

			local v17 = __wf_atom_8111d9dc(aimPosition, __wf_atom_74d951b0, __wf_atom_d0069154)
			local __wf_atom_f7e7be53 = v16:__wf_atom_f7e7be53()

			if not (v17 <= module4.GetAncestorUpgradeRankValueForTag(
				v5,
				Symbol("SoulStealDistance"),
				Symbol("TARGET_RADIUS")
			)) then
				continue
			end

			if not __wf_atom_7e8ad928(gRegion:__wf_atom_f54ffdb8(
				aimPosition,
				__wf_atom_d0069154,
				v14,
				fn5(__wf_atom_f7e7be53),
				false,
				nil,
				Vector()
			)) then
				continue
			end

			table.insert(v15, { __wf_atom_f7e7be53, __wf_atom_d0069154, v17 })
		end

		table.sort(v15, function(a, b)
			return a[3] < b[3]
		end)

		if #v15 > 0 then
			object:__wf_atom_f7170fc9(v15[1][1])
			object:__wf_atom_e638fc23(v15[1][2])
			return true
		else
			local __wf_atom_a96eb2aa = object2:__wf_atom_a96eb2aa()

			if
				not (#v12 > 0)
				or __wf_atom_7e8ad928(__wf_atom_a96eb2aa)
				or object2 ~= __wf_atom_a96eb2aa:GetPlayerAvatar(0)
			then
				return true
			end

			for _, v16 in ipairs(v12) do
				if __wf_atom_7e8ad928(v16) or not v16:IsA(__wf_atom_6c243c5e) or not v16:__wf_atom_4573db05() then
					continue
				end

				local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
				secondaryScriptArgs:__wf_atom_a17e41c6(v16)
				object:__wf_atom_e6831c5c(mOwner, Symbol("AnimoteMusicGame"), secondaryScriptArgs)
				return false
			end

			return true
		end
	else
		object:__wf_atom_f7170fc9(v8)

		if not __wf_atom_7e8ad928(v9) then
			object:__wf_atom_e638fc23(v9)
		end

		return true
	end
end

function NpcEvaluateAbility(_, _)
	return 0
end

local function fn10(p, ...)
	module.SetAbilityStats(p, mOwner, { ... })
end

function PullToMe(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local instigatorAvatar

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		instigatorAvatar = mOwner:__wf_atom_c78fa517():__wf_atom_6009c8ed()
	else
		instigatorAvatar = __wf_atom_e919fb8e.InstigatorAvatar
	end

	if __wf_atom_7e8ad928(instigatorAvatar) then
		return
	end

	local position = object:GetPosition()
	local __wf_atom_1c374cc9 = instigatorAvatar:__wf_atom_1c374cc9(Symbol("GAME_R1_FINGER1"))
	local __wf_atom_28d5d4aa = __wf_atom_28d5d4aa
	local v8 = __wf_atom_1c374cc9 - position
	Normalize(v8)
	local v9 = __wf_atom_edfe0d73(v8, Vector(1, 0, 0))
	local v10 = __wf_atom_edfe0d73(v8, Vector(0, 1, 0))
	local pullTime = __wf_atom_e919fb8e.PullTime or pullTime2

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		__wf_atom_e919fb8e.bPullStarted = true
	end

	local v11 = pullTime
	local v12 = position

	while
		not __wf_atom_7e8ad928(object)
		and not __wf_atom_7e8ad928(instigatorAvatar)
		and not __wf_atom_7e8ad928(mOwner)
		and mOwner:IsActive()
	do
		local v13 = instigatorAvatar:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM3")) + Vector(0, 0.1, 0)
		v11 = math.max(0, v11 - __wf_atom_084b3e93())
		local v14 = 1 - v11 / pullTime
		local v15 = math.pow(v14, 3)
		local v16 = __wf_atom_f55d6358(position, v13, v15)
		local v17 = 1 - math.abs(v14 * 2 - 1)
		local v18 = v16 + v9 * math.sin(v15 * 3.141592653589793 * 2) * 2 * v17 + v10 * math.sin(v15 * 3.141592653589793 * 0.5) * 3 * v17
		object:SetMeshScale(__wf_atom_421b01aa(__wf_atom_104bfe98(1, -0.2, v15), 0, 1))
		object:SetPosition(v18)
		object:__wf_atom_9b788a35(Rotation(v14 * 80, v14 * 60, v14 * 370))
		__wf_atom_28d5d4aa = (v18 - v12) / __wf_atom_084b3e93()
		Sleep(0)

		if v11 == 0 then
			v12 = v18
			break
		else
			v12 = v18
		end
	end

	if Length(__wf_atom_28d5d4aa) > 0.1 then
		local v13 = 0

		while v13 < 1 and not __wf_atom_7e8ad928(object) and (__wf_atom_7e8ad928(mOwner) or not mOwner:IsActive()) do
			v13 = __wf_atom_421b01aa(v13 + __wf_atom_084b3e93() * 1.75, 0, 1)
			v12 += __wf_atom_28d5d4aa * module3.inQuad(1 - v13, 0, 1, 1) * __wf_atom_084b3e93()
			object:SetPosition(v12)
			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		__wf_atom_e919fb8e.bPullComplete = true
	end

	v6 = true
end

function CheckQueuedSoulStealTarget(object)
	if __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget) then
		return nil
	end

	local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

	if __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58]) then
		return nil
	end

	local target = _T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58].target
	local pos = _T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58].pos
	_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58] = nil
	return target, pos
end

function QueueSoulStealTarget(object, target, pos)
	if __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget) then
		_T.SoulStealTargetQueuedTarget = {}
	end

	local __wf_atom_18aa6e58 = object:__wf_atom_18aa6e58()

	if __wf_atom_7e8ad928(_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58]) then
		_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58] = {}
	end

	_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58].target = target
	_T.SoulStealTargetQueuedTarget[__wf_atom_18aa6e58].pos = pos
end

local function fn11(object, object2, object3, p)
	if p <= 0 then
		return
	end

	local __wf_atom_b9421344 = object:__wf_atom_b9421344(object2, object3)

	if __wf_atom_b9421344 < object:__wf_atom_87a16e10() then
		object:__wf_atom_19516b62(p, (object:__wf_atom_2e4994f1(__wf_atom_b9421344)))
		return
	end

	print("No ability found to grant mote energy on SoulSteal")
	__wf_atom_f2daf912("No ability found to grant mote energy on SoulSteal")

	if not __wf_atom_7e8ad928(object2) then
		print("mote", object2:__wf_atom_5b41f63b())
	end

	if not __wf_atom_7e8ad928(object3) then
		print("weapon", object3:__wf_atom_5b41f63b())
	end
end

local function fn12(object) -- 5 equivalent calls inferred from this helper
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_a8e8c5c4 = __wf_atom_d2b2176d:__wf_atom_a8e8c5c4()

	if
		__wf_atom_7e8ad928(__wf_atom_a8e8c5c4)
		or __wf_atom_d2b2176d:__wf_atom_d93821d0((__wf_atom_a8e8c5c4:__wf_atom_55da7898()))
	then
		return nil
	end

	return __wf_atom_a8e8c5c4
end

local function fn13(instigatorAvatar, object, _)
	local v8

	if instigatorAvatar:__wf_atom_8efce136() and instigatorAvatar:__wf_atom_d2b2176d():__wf_atom_aba9c26e(0) ~= 14 then
		fn6(instigatorAvatar)
		v8 = true
	else
		v8 = false
	end

	if __wf_atom_7e8ad928(instigatorAvatar) or instigatorAvatar:IsKilled() then
		return
	end

	local v9 = module.PlayUpperBodyAnim(object, noTargetPullAnim, false, 2, 1, false)
	Sleep(v9)

	if instigatorAvatar:__wf_atom_8efce136() and v8 then
		local __wf_atom_a8e8c5c4 = fn12(instigatorAvatar) -- inferred equivalent call

		if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
			instigatorAvatar:__wf_atom_d2b2176d():Equip(__wf_atom_a8e8c5c4:__wf_atom_0395f752(), 0, 2)
		end
	end
end

function NotifySoulCollectChallenge(instance, object, object2)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_0d9c1a58 = object2:__wf_atom_0d9c1a58()

	if __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
		return
	end

	local v8 = instance:IsA(__wf_atom_4ebf67cb) or instance:IsA(__wf_atom_43e0c427)

	if not (v8 or __wf_atom_7e8ad928(object)) then
		v8 = not __wf_atom_7e8ad928(object:__wf_atom_87088114()) and object:__wf_atom_87088114():IsA(__wf_atom_4ebf67cb)
	end

	if not v8 then
		return
	end

	__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_0d9c1a58, Symbol("SOUL_COLLECT"))
end

function NotifySoulStealChallenge(instance, object, object2)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_0d9c1a58 = object2:__wf_atom_0d9c1a58()

	if __wf_atom_7e8ad928(__wf_atom_0d9c1a58) then
		return
	end

	local v8 = instance:IsA(__wf_atom_4ebf67cb) or instance:IsA(__wf_atom_43e0c427)

	if not (v8 or __wf_atom_7e8ad928(object)) then
		v8 = not __wf_atom_7e8ad928(object:__wf_atom_87088114()) and object:__wf_atom_87088114():IsA(__wf_atom_4ebf67cb)
	end

	if not v8 then
		return
	end

	local __wf_atom_a8e8c5c4 = fn12(object2) -- inferred equivalent call
	local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(soulType)
	local v9, v10, v11

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		v9 = false
		v10 = false
		v11 = false
	else
		v9 = string.find(__wf_atom_bb3e7833:GetName(), "Spirit")
		v10 = string.find(__wf_atom_bb3e7833:GetName(), "Grace")
		v11 = string.find(__wf_atom_bb3e7833:GetName(), "Power")
	end

	local lastSoulStealTargetAvatar = nil

	if instance:IsA(__wf_atom_4ebf67cb) then
		lastSoulStealTargetAvatar = instance
	elseif instance:IsA(__wf_atom_43e0c427) then
		lastSoulStealTargetAvatar = instance:__wf_atom_6009c8ed()
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.LastSoulStealTargetAvatar = lastSoulStealTargetAvatar
	__wf_atom_e919fb8e.LastSoulStealTime = Time()
	__wf_atom_e919fb8e.LastSoulStealEnergyType = nil

	if v9 then
		__wf_atom_e919fb8e.LastSoulStealEnergyType = 1
	elseif v10 then
		__wf_atom_e919fb8e.LastSoulStealEnergyType = 2
	elseif v11 then
		__wf_atom_e919fb8e.LastSoulStealEnergyType = 0
	end

	__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_0d9c1a58, challengeTag)

	if v9 then
		__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_0d9c1a58, Symbol("SOUL_STEAL_SPIRIT"))
	elseif v10 then
		__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_0d9c1a58, Symbol("SOUL_STEAL_GRACE"))
	elseif v11 then
		__wf_atom_539492fe:__wf_atom_c2038c7a(__wf_atom_0d9c1a58, Symbol("SOUL_STEAL_COURAGE"))
	end

	if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
		__wf_atom_539492fe:__wf_atom_c2038c7a(
			__wf_atom_0d9c1a58,
			v4,
			__wf_atom_a8e8c5c4,
			__wf_atom_a8e8c5c4:__wf_atom_1bb5b1ff()
		)
	end
end

local function fn14(loreMoteMinigameInstigator, loreMoteMinigameTarget) -- 1 equivalent call inferred from this helper
	_T.LoreMoteMinigameTarget = loreMoteMinigameTarget
	_T.LoreMoteMinigameInstigator = loreMoteMinigameInstigator
	__wf_atom_8e4fda44:__wf_atom_8b74c30b(moteFishingMovie)
end

function ActivateAbility(object, instigatorAvatar, instance, _, p)
	if instance == nil and instigatorAvatar:__wf_atom_8efce136() then
		instance = gRegion:__wf_atom_e2db08ce(v2, p, (fn7(instigatorAvatar)))
	end

	local flag = false

	if not __wf_atom_7e8ad928(instance) then
		instance:IsA(loreMoteType)
	end

	local soulScanTable = module5.GetSoulScanTable(instigatorAvatar)
	local v8

	if soulScanTable == nil then
		v8 = false
	else
		v8 = soulScanTable.timeScanningCompleted ~= nil

		if v8 and (__wf_atom_7e8ad928(instance) or instance:IsA(v3)) and soulScanTable.isPlayerSoulScanning then
			if __wf_atom_7e8ad928(instance) then
				instance = gRegion:__wf_atom_e2db08ce(v3, p, (fn7(instigatorAvatar)))
			end

			if not __wf_atom_7e8ad928(instance) then
				flag = true
				pullTime2 = 1
			end
		end

		if not __wf_atom_7e8ad928(instance) and instance:IsA(v3) and not (instance:__wf_atom_b2f8ef81() and v8) then
			instance = nil
		end
	end

	if __wf_atom_7e8ad928(instance) then
		fn13(instigatorAvatar, object)
		return
	end

	local __wf_atom_a96eb2aa = instigatorAvatar:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) or instigatorAvatar == __wf_atom_a96eb2aa:GetPlayerAvatar(0) then
		if flag then
			fn14(instigatorAvatar, instance) -- inferred equivalent call
		else
			if instigatorAvatar:__wf_atom_8efce136() then
				_T.ForceSoulMode = true
			end

			local v9 = nil
			local stealAbility = module.GetStealAbility(instance)
			local __wf_atom_bb3e7833 = instance:__wf_atom_bb3e7833(__wf_atom_faccb0cf)
			local isA = instance:IsA(__wf_atom_4ebf67cb)
			local isA2 = instance:IsA(__wf_atom_43e0c427)
			local v10

			if isA and instance then
				v10 = instance
			elseif isA2 then
				v10 = instance:__wf_atom_6009c8ed() or nil
			end

			local __wf_atom_e919fb8e = instigatorAvatar:__wf_atom_e919fb8e()
			local duplicateSoulSteal = not __wf_atom_7e8ad928(__wf_atom_e919fb8e.DuplicateSoulSteal)
				and __wf_atom_e919fb8e.DuplicateSoulSteal
			local v11

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				v11 = __wf_atom_bb3e7833:IsA(v3)
				local __wf_atom_e919fb8e2 = __wf_atom_bb3e7833:__wf_atom_e919fb8e()

				if
					not __wf_atom_7e8ad928(__wf_atom_e919fb8e2)
					and not __wf_atom_7e8ad928(__wf_atom_e919fb8e2.avatarHasStollen)
					and __wf_atom_e919fb8e2.avatarHasStollen == instigatorAvatar
				then
					fn13(instigatorAvatar, object)
					return
				end
			end

			instigatorAvatar:PlaySound(soulStealActivateSound, false, 1, false)
			local v12 = __wf_atom_fa8d0177(instigatorAvatar:GetPosition(), instance:GetPosition())
			instigatorAvatar:MotionControl():__wf_atom_3a1d0c16(v12)
			object:__wf_atom_2e2fda6e(25)
			fn10(mOwner:__wf_atom_c78fa517(), fn2, instance)
			local info = not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:GetInfo()
				or SF.SoulStealInfo()
			local v13

			if v11 then
				if v8 then
					v13 = __wf_atom_bb3e7833
				else
					__wf_atom_bb3e7833 = nil
				end
			else
				v13 = instance:__wf_atom_bb3e7833(soulType)
			end

			if not __wf_atom_7e8ad928(v13) then
				v9 = v13:__wf_atom_e919fb8e()
				v9.InstigatorAvatar = instigatorAvatar
			end

			local v14 = nil

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:__wf_atom_698b69c8(instigatorAvatar)
			end

			local v15 = not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:IsA(restoreType)
			local __wf_atom_35a10d3c = instigatorAvatar:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
			local __wf_atom_a8e8c5c4 = fn12(instigatorAvatar) -- inferred equivalent call
			local v16

			if __wf_atom_7e8ad928(__wf_atom_35a10d3c) or not __wf_atom_35a10d3c:IsA(__wf_atom_77e05d3b) then
				v16 = 0
			else
				__wf_atom_35a10d3c:__wf_atom_36d7c7d8()
				v16 = __wf_atom_35a10d3c:__wf_atom_6170b185()
			end

			local v17

			if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
				v17 = module.GetWeaponMoteAbility(__wf_atom_a8e8c5c4)

				if
					not __wf_atom_7e8ad928(v17)
					and __wf_atom_35a10d3c ~= __wf_atom_a8e8c5c4
					and v15
					and (isA or isA2)
				then
					if instigatorAvatar:__wf_atom_4417a5d4() then
						instigatorAvatar:__wf_atom_d2b2176d():Equip(__wf_atom_a8e8c5c4:__wf_atom_0395f752(), 0, 2)
					end

					if __wf_atom_a8e8c5c4:IsA(__wf_atom_77e05d3b) then
						__wf_atom_a8e8c5c4:__wf_atom_36d7c7d8()
						v16 = __wf_atom_a8e8c5c4:__wf_atom_6170b185()
					end
				end
			end

			local v18 = v16 + 1
			assert(25 == 25)

			if __wf_atom_7e8ad928(v18) then
				v7 = enemyPullAnim[1]
			else
				v7 = enemyPullAnim[v18]
			end

			local v19

			if (isA or isA2) and not v11 then
				pullTime2 = 0.25

				if not __wf_atom_7e8ad928(v13) then
					v9.PullTime = pullTime2
				end

				instigatorAvatar:PlaySound(avatarTargetCastSound, false, 1, false)

				if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
					local weaponMote = module.GetWeaponMote(__wf_atom_a8e8c5c4)

					if not __wf_atom_7e8ad928(weaponMote) then
						instigatorAvatar:PlaySound(weaponMote:__wf_atom_cea69207(), false, 1, false)
					end
				end

				v19 = module.PlayAnim(object, v7, false, 4, 1, false)
				module.EnableWeaponFiring(instigatorAvatar, mOwner, false)
				v14 = v10:Attach(preStealTargetFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
				v10:__wf_atom_58c8ffec(Symbol("SOUL_STEAL"), false, 4, 1, true)
			else
				if not __wf_atom_7e8ad928(v13) then
					v9.PullTime = pullTime2
				end

				v19 = module.PlayAnim(object, pullAnim, false, 4, 1, false)
				instigatorAvatar:PlaySound(otherTargetCastSound, false, 1, false)
			end

			local __wf_atom_ee2eb1db = info:__wf_atom_ee2eb1db()
			local v20 = Symbol("GAME_R1_ARM3")
			local _ = 0 <= 0
			local v21 = { instigatorAvatar }

			if duplicateSoulSteal then
				local v22 = fn8(instance, instigatorAvatar)

				if not __wf_atom_7e8ad928(v22) then
					table.insert(v21, v22)
				end

				__wf_atom_e919fb8e.DuplicateSoulSteal = false
			end

			if v11 then
				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:__wf_atom_8a035cd5(Symbol("PullToMe"), false)
				end
			elseif instance:IsA(loreMoteType) then
				instance:__wf_atom_8a035cd5(Symbol("PullToMe"), false)
			elseif not isA or v15 then
				local _ = pullAnim:__wf_atom_091354f5(Symbol("SoulStealComplete")) * v19

				if not instance:IsA(__wf_atom_8d0b7f88) then
					NotifySoulStealChallenge(instance, __wf_atom_bb3e7833, instigatorAvatar)

					if isA or isA2 then
						instigatorAvatar:__wf_atom_8914dfde("SoulStealComplete", 3)

						for _, v22 in ipairs(v21) do
							if not (__wf_atom_7e8ad928(instance) or not (instance:IsA(v3) or instance:IsA(loreMoteType))) then
								continue
							end

							if not (__wf_atom_7e8ad928(__wf_atom_bb3e7833) or not __wf_atom_bb3e7833:IsA(v3)) then
								continue
							end

							DoCrit(__wf_atom_bb3e7833, instance, v22, v21)
						end
					else
						instance:__wf_atom_8a035cd5(Symbol("PullToMe"), false)

						if
							__wf_atom_7e8ad928(v17)
							or __wf_atom_7e8ad928(__wf_atom_a8e8c5c4)
							or __wf_atom_7e8ad928(__wf_atom_bb3e7833)
						then
							if __wf_atom_7e8ad928(v17) then
								__wf_atom_f2daf912("null moteAbility")
							end

							if __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
								__wf_atom_f2daf912("null meleeWeapon")
							end

							if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
								__wf_atom_f2daf912("null SSE")
							end
						else
							local __wf_atom_e919fb8e2 = instance:__wf_atom_e919fb8e()
							local __wf_atom_438fe918 = __wf_atom_bb3e7833:__wf_atom_438fe918()

							if not __wf_atom_7e8ad928(__wf_atom_e919fb8e2) then
								fn11(object, v17, __wf_atom_a8e8c5c4, __wf_atom_438fe918)
							end
						end
					end
				end
			end

			local v22 = 1.5

			while not v6 and v22 > 0 do
				Sleep(0)
				v22 -= __wf_atom_084b3e93()
			end

			for _, v23 in ipairs(v21) do
				if __wf_atom_7e8ad928(v23) then
					continue
				end

				NotifySoulCollectChallenge(instance, __wf_atom_bb3e7833, v23)

				if isA2 then
					fn10(v23:__wf_atom_d2b2176d():__wf_atom_e55d02aa(), fn, v10, __wf_atom_bb3e7833, stealAbility)
				else
					fn10(v23:__wf_atom_d2b2176d():__wf_atom_e55d02aa(), fn, instance, __wf_atom_bb3e7833, stealAbility)
				end

				if not __wf_atom_7e8ad928(v14) then
					v14:Destroy()
				end

				if not (__wf_atom_7e8ad928(__wf_atom_ee2eb1db) or __wf_atom_7e8ad928(mOwner)) then
					mOwner:__wf_atom_7ccf4243(__wf_atom_ee2eb1db, v20, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				end
			end
		end
	else
		local playerAvatar = __wf_atom_a96eb2aa:GetPlayerAvatar(0)

		if not __wf_atom_7e8ad928(playerAvatar) then
			QueueSoulStealTarget(playerAvatar, instance, p)
		end
	end
end

function DoCrit(instance, instance2, instigatorAvatar, list)
	if __wf_atom_7e8ad928(instigatorAvatar) then
		return
	end

	if __wf_atom_7e8ad928(instance2) and not __wf_atom_7e8ad928(instance) then
		instance2 = instance:__wf_atom_f7e7be53()
	end

	local v8 = nil
	local v9 = nil
	local __wf_atom_e55d02aa = instigatorAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v10 = not __wf_atom_7e8ad928(instance2) and instance2:IsA(__wf_atom_4ebf67cb)
	local v11 = not __wf_atom_7e8ad928(instance2) and instance2:IsA(__wf_atom_43e0c427)
	local v12

	if v10 and instance2 then
		v12 = instance2
	elseif v11 then
		v12 = instance2:__wf_atom_6009c8ed() or nil
	end

	local __wf_atom_35a10d3c = instigatorAvatar:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	local __wf_atom_a8e8c5c4 = fn12(instigatorAvatar) -- inferred equivalent call
	local v13 = not __wf_atom_7e8ad928(instance) and instance:IsA(restoreType)
	local v14 = false
	local v15 = false
	local v16 = false

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) and __wf_atom_35a10d3c:IsA(__wf_atom_77e05d3b) then
		__wf_atom_35a10d3c:__wf_atom_36d7c7d8()
	end

	local v17

	if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
		v17 = module.GetWeaponMoteAbility(__wf_atom_a8e8c5c4)

		if not __wf_atom_7e8ad928(v17) and __wf_atom_35a10d3c ~= __wf_atom_a8e8c5c4 and v13 and v10 then
			if instigatorAvatar:__wf_atom_4417a5d4() then
				instigatorAvatar:__wf_atom_d2b2176d():Equip(__wf_atom_a8e8c5c4:__wf_atom_0395f752(), 0, 2)
			end

			if __wf_atom_a8e8c5c4:IsA(__wf_atom_77e05d3b) then
				__wf_atom_a8e8c5c4:__wf_atom_36d7c7d8()
			end
		end
	end

	if not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(instance2) or __wf_atom_7e8ad928(instigatorAvatar) or __wf_atom_7e8ad928(__wf_atom_e55d02aa)) then
		local __wf_atom_bb3e7833 = instance2:__wf_atom_bb3e7833(soulType)

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833 = instance:__wf_atom_3d96ddcd()

			if not (__wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_bb3e7833:IsA(soulType)) then
				__wf_atom_bb3e7833 = nil
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:__wf_atom_e6ed03c8()
			local __wf_atom_e919fb8e = __wf_atom_bb3e7833:__wf_atom_e919fb8e()

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
				v8 = instance:__wf_atom_876731d0()
				v9 = instance:__wf_atom_9fe17f23()
				__wf_atom_e919fb8e.InstigatorAvatar = instigatorAvatar
			end

			v14 = string.find(__wf_atom_bb3e7833:GetName(), "Spirit")
			v15 = string.find(__wf_atom_bb3e7833:GetName(), "Grace")
			v16 = string.find(__wf_atom_bb3e7833:GetName(), "Power")

			if __wf_atom_e55d02aa:__wf_atom_f5ca3244() then
				local __wf_atom_e919fb8e_2 = instigatorAvatar:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e_2.wyldVirtueBuff = true
			end

			if v14 then
				__wf_atom_bb3e7833:Attach(
					spiritBurstFxType,
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_e55d02aa
				)
			elseif v15 then
				__wf_atom_bb3e7833:Attach(
					graceBurstFxType,
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_e55d02aa
				)
			elseif v16 then
				__wf_atom_bb3e7833:Attach(
					courageBurstFxType,
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_e55d02aa
				)
			end

			local __wf_atom_be0bea4a = instance2:__wf_atom_be0bea4a()
			local v18 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoCourage")
			local v19 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoGrace")
			local v20 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoSpirit")
			local v21 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoCourageChild")
			local v22 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoGraceChild")
			local v23 = WeakResource("/SF/Fx/Abilities/Common/SoulSteal/SoulExtractBodyDecoSpiritChild")

			for _, v24 in ipairs(__wf_atom_be0bea4a) do
				if not (v24:IsA(v18) or v24:IsA(v19) or v24:IsA(v20) or v24:IsA(v21) or v24:IsA(v22) or v24:IsA(v23)) then
					continue
				end

				v24:PlayTriggeredFade()
			end

			__wf_atom_bb3e7833:__wf_atom_8a035cd5(Symbol("PullToMe"), false)

			for _, instigatorAvatar2 in pairs(list) do
				if __wf_atom_7e8ad928(instigatorAvatar2) or instigatorAvatar2 == instigatorAvatar then
					continue
				end

				local entity = gRegion:CreateEntity(
					Type(__wf_atom_bb3e7833),
					__wf_atom_bb3e7833:GetPosition(),
					__wf_atom_bb3e7833:__wf_atom_dc309f8a()
				)
				local __wf_atom_e919fb8e2 = entity:__wf_atom_e919fb8e()

				if __wf_atom_7e8ad928(__wf_atom_e919fb8e2) then
					continue
				end

				local __wf_atom_e919fb8e_2 = instigatorAvatar2:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e_2.DuplicateSoul = entity
				__wf_atom_e919fb8e2.InstigatorAvatar = instigatorAvatar2
				entity:__wf_atom_8a035cd5(Symbol("PullToMe"), false)
			end
		end
	end

	for _, v18 in ipairs(list) do
		if __wf_atom_7e8ad928(v18) then
			continue
		end

		local __wf_atom_e55d02aa2 = v18:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		module.Fear(v18, 8, true)

		if not (v10 or v11) or (__wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(v18)) then
			continue
		end

		local v19 = instance2:GetPosition() - v18:GetPosition() + Vector(0, 1, 0)
		Normalize(v19)
		local damageData = Engine.DamageData()
		local __wf_atom_c6f1f83d = v12:__wf_atom_c6f1f83d()
		local __wf_atom_a8e8c5c4_2 = fn12(v18) -- inferred equivalent call
		local damageData2 = Engine.DamageData()

		if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4_2) then
			local __wf_atom_18007d51 = __wf_atom_a8e8c5c4_2:__wf_atom_18007d51()
			__wf_atom_18007d51:__wf_atom_c39e64aa(damageData2)
			__wf_atom_18007d51:__wf_atom_56712eb7(damageData2)

			if not __wf_atom_7e8ad928(v17) and v12:IsA(__wf_atom_7e6ed5fa) then
				fn11(__wf_atom_e55d02aa2, v17, __wf_atom_a8e8c5c4_2, v12:__wf_atom_a6233307())
			end
		end

		if v12:__wf_atom_464a4772() then
			damageData.baseAmount = damageData2.baseAmount * vipCritDmgAmount
		else
			damageData.baseAmount = damageData2.baseAmount * enemyCritDmgAmount
		end

		damageData:__wf_atom_7498285f(15, 1)

		if __wf_atom_c6f1f83d < damageData.baseAmount then
			damageData:__wf_atom_d6f4d914(20, true)
			damageData:__wf_atom_1f3b492b(11)

			if v14 then
				v12:Attach(spiritKillFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_e55d02aa2)
			elseif v15 then
				v12:Attach(graceKillFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_e55d02aa2)
			elseif v16 then
				v12:Attach(courageKillFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_e55d02aa2)
			end
		end

		if __wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v9) then
			if __wf_atom_7e8ad928(__wf_atom_a8e8c5c4_2) then
				damageData:__wf_atom_6b472125(v18)
				damageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa2)
				print("soulSteal fallback from pact", __wf_atom_e55d02aa2:__wf_atom_5b41f63b())
			else
				damageData:__wf_atom_6b472125(v18)
				damageData:__wf_atom_34a8a27a(__wf_atom_a8e8c5c4_2)
				print("soulSteal fallback from last held weapon", __wf_atom_a8e8c5c4_2:__wf_atom_5b41f63b())
			end
		else
			damageData:__wf_atom_6b472125(v9)
			damageData:__wf_atom_34a8a27a(v8)
		end

		damageData:__wf_atom_12cf5317(v19 * -10)
		v12:__wf_atom_649bf33e(damageData)
	end
end

function DeactivateAbility(p, object)
	local __wf_atom_8efce136 = object:__wf_atom_8efce136()
	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if abilityStats then
		local abilityStat = abilityStats[1]
		local abilityStat2 = abilityStats[2]
		local v8

		if __wf_atom_7e8ad928(abilityStat2) or not (abilityStat2:IsA(__wf_atom_4ebf67cb) and abilityStat2) then
			if not (__wf_atom_7e8ad928(abilityStat2) or not abilityStat2:IsA(__wf_atom_43e0c427)) then
				v8 = abilityStat2:__wf_atom_6009c8ed() or nil
			end
		else
			v8 = abilityStat2
		end

		module.EnableWeaponFiring(object, mOwner, true)

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
			SF.__wf_atom_4659f336(__wf_atom_35a10d3c, true, false)
		end

		if not __wf_atom_7e8ad928(v8) then
			local __wf_atom_bb3e7833 = abilityStat2:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				local info = __wf_atom_bb3e7833:GetInfo()

				if not __wf_atom_7e8ad928(info) then
					local __wf_atom_7f40d458 = info:__wf_atom_7f40d458(true)

					if not __wf_atom_7e8ad928(__wf_atom_7f40d458) then
						gRegion:CreateEntity(__wf_atom_7f40d458, abilityStat2:GetPosition(), __wf_atom_80368bb1)
					end
				end
			end

			if v8:__wf_atom_fc8d8e90(Symbol("SOUL_STEAL")) then
				v8:__wf_atom_9b5dcd3b(nil, false, 2, 1, false)
			end
		end

		abilityStat(p, object, abilityStat2, unpack(abilityStats, 3))

		if __wf_atom_8efce136 then
			_T.ForceSoulMode = nil
		end

		while
			not __wf_atom_7e8ad928(object)
			and (object:__wf_atom_c138b19b(pullAnim, true) or object:__wf_atom_3c281634(pullAnim))
		do
			Sleep(0)
		end
	else
		while
			not __wf_atom_7e8ad928(object)
			and (object:__wf_atom_c138b19b(pullAnim, true) or object:__wf_atom_3c281634(pullAnim))
		do
			Sleep(0)
		end

		module.EnableWeaponFiring(object, mOwner, true)
	end
end

function LifeStealMoteApply(object, _)
	__wf_atom_f2daf912("Trying LifeSteal")

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	if __wf_atom_e55d02aa:__wf_atom_f3044fe0() >= __wf_atom_e55d02aa:__wf_atom_6a5c92a7() then
		local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()

		if __wf_atom_c6f1f83d < object:GetMaxHealth() then
			__wf_atom_e55d02aa:__wf_atom_9e7c0c61(0)
			object:Heal(object, 50, object)
			object:NotifyHeal(object:__wf_atom_a96eb2aa(), 50, 0, 1)
			module.NotifyHeal(object, object:__wf_atom_c6f1f83d() - __wf_atom_c6f1f83d)
		end

		__wf_atom_f2daf912("Apply LifeSteal")
	end
end

local function fn15(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928(_T.NumStolenEnergyRestores) then
		_T.NumStolenEnergyRestores = {}
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_6be84646 = object:__wf_atom_6be84646()
		local numStolenEnergyRestore = _T.NumStolenEnergyRestores[__wf_atom_6be84646]

		if __wf_atom_7e8ad928(numStolenEnergyRestore) then
			_T.NumStolenEnergyRestores[__wf_atom_6be84646] = 1
		else
			_T.NumStolenEnergyRestores[__wf_atom_6be84646] = numStolenEnergyRestore + 1
		end
	end
end

local function fn16(object, instance, info, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(info) then
		return
	end

	fn15(instance:__wf_atom_a96eb2aa())
	local __wf_atom_87a16e10 = object:__wf_atom_87a16e10()
	local v8 = math.max(info:__wf_atom_777fa6aa(), __wf_atom_084b3e93())
	local v9 = info:__wf_atom_fd53959a() + object:__wf_atom_6a5c92a7() * info:__wf_atom_fbd6c0a5()
	local __wf_atom_7d343c52 = info:__wf_atom_7d343c52()
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local v10 = v9
	local __wf_atom_2a745663s = {}
	local v11 = {}
	local flag = false

	for i = 0, 2 do
		if not info:__wf_atom_d74a80d6(i) then
			continue
		end

		local __wf_atom_2a745663 = __wf_atom_d2b2176d:__wf_atom_2a745663(
			info:__wf_atom_fd53959a() + instance:GetAttribute(i) * info:__wf_atom_fbd6c0a5(),
			66,
			nil,
			nil,
			26,
			Symbol(module2.GetAttributeTypeTag(i))
		)
		__wf_atom_2a745663s[i] = __wf_atom_2a745663
		v11[i] = __wf_atom_2a745663
		v10 = info:__wf_atom_7d343c52()
		flag = true

		for j = 0, __wf_atom_87a16e10 - 1 do
			if object:__wf_atom_2e4994f1(j) ~= i then
				continue
			end

			local __wf_atom_c497b0ae = object:__wf_atom_c497b0ae(j)

			if __wf_atom_7e8ad928(__wf_atom_c497b0ae) then
				continue
			end

			local __wf_atom_1fcd5380 = __wf_atom_c497b0ae:__wf_atom_1fcd5380()

			if __wf_atom_1fcd5380 > 0 then
				__wf_atom_c497b0ae:__wf_atom_80e49f0d((math.max(
					__wf_atom_1fcd5380 - instance:__wf_atom_d2b2176d():__wf_atom_2a745663(
						30,
						222,
						object:__wf_atom_1bb5b1ff(),
						object,
						26,
						Symbol("FLOW_POINT_REDUCTION")
					),
					0
				)))
			end
		end
	end

	while
		not __wf_atom_7e8ad928(instance)
		and not __wf_atom_7e8ad928(object)
		and (__wf_atom_7e8ad928(object2) or object2:__wf_atom_4b409d7b(instance))
	do
		local v12 = __wf_atom_084b3e93() / v8
		local v13 = false

		if flag then
			local v14 = false

			for k, v15 in pairs(__wf_atom_2a745663s) do
				local v16 = math.min(v15 * v12, v11[k])

				if object:__wf_atom_f3044fe0(k) < object:__wf_atom_6a5c92a7(k) then
					object:__wf_atom_19516b62(v16, k)
					v14 = true
					v10 = 0
				end

				if not object2 then
					v11[k] -= v16
				end

				v13 = v13 or v11[k] > 0
			end

			if v14 or not (__wf_atom_7d343c52 > 0) then
				v10 = 0
			else
				local v15 = math.min(__wf_atom_7d343c52 * v12, v10)
				object:__wf_atom_19516b62(v15)
				v10 -= v15
				v13 = v13 or v10 > 0
			end
		else
			local v14 = math.min(v9 * v12, v10)
			object:__wf_atom_19516b62(v14)

			if not object2 then
				v10 -= v14
			end

			v13 = v10 > 0
		end

		if not v13 then
			break
		end

		Sleep(0)
	end
end

fn = function(object, object2, instance, instance2, object3)
	local info = not __wf_atom_7e8ad928(instance2) and instance2:GetInfo() or SF.SoulStealInfo()
	local __wf_atom_7f40d458 = info:__wf_atom_7f40d458(false)
	local __wf_atom_7f40d458_2 = info:__wf_atom_7f40d458(true)

	if not __wf_atom_7e8ad928(__wf_atom_7f40d458) then
		object2:Attach(__wf_atom_7f40d458, EMPTY_SYMBOL)
	end

	if not __wf_atom_7e8ad928(instance2) then
		if not __wf_atom_7e8ad928(__wf_atom_7f40d458_2) then
			gRegion:CreateEntity(__wf_atom_7f40d458_2, instance2:__wf_atom_a2a18137(), instance2:__wf_atom_2f2bada0())
		end

		if instance2:OnSteal(object2) then
			if not __wf_atom_7e8ad928(object3) then
				object3:SetEnabled(false)
			end

			if not __wf_atom_7e8ad928(instance2) and instance2:__wf_atom_e919fb8e().noDestroySoul == nil then
				instance2:Destroy()
			end
		end
	end

	if gRegion:IsMaster() then
		for _, v8 in gRegion:__wf_atom_ef7900cf() do
			local __wf_atom_e919fb8e = v8:__wf_atom_e919fb8e()

			if __wf_atom_7e8ad928(__wf_atom_e919fb8e.DuplicateSoul) then
				continue
			end

			__wf_atom_e919fb8e.DuplicateSoul:Destroy()
			__wf_atom_e919fb8e.DuplicateSoul = nil

			if not __wf_atom_7e8ad928(__wf_atom_7f40d458) then
				v8:Attach(__wf_atom_7f40d458, EMPTY_SYMBOL)
			end
		end
	end

	if not __wf_atom_7e8ad928(object3) and gRegion:IsMaster() then
		object:__wf_atom_c83da9e6(object3:__wf_atom_1bb5b1ff())
	end

	if not __wf_atom_7e8ad928(instance) and gRegion:IsMaster() and instance:IsA(__wf_atom_3feeb44a) then
		object2:__wf_atom_d2b2176d():PickUpItem(instance, true, true)
	end

	if object2:__wf_atom_8efce136() then
		_T.ForceSoulMode = nil
	end

	fn16(object, object2, info)
end

fn2 = function(p, _, _)
	module.PlayUpperBodyAnim(p, failureAnim, false, 2, 1, false)
end

function RestoreEnergyTrigger(object, object2)
	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(__wf_atom_faccb0cf)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	fn16(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa(), object, __wf_atom_bb3e7833:GetInfo(), object2)
end

function SoulStealAbility(object, _, p)
	local __wf_atom_4ca4978e = object:__wf_atom_4ca4978e()
	local __wf_atom_248bb7ae = object:__wf_atom_248bb7ae(__wf_atom_4ca4978e)

	if __wf_atom_248bb7ae < object:__wf_atom_87a16e10() then
		local v8 = fn4(object)

		if not __wf_atom_7e8ad928(v8) then
			if object:__wf_atom_6009c8ed():__wf_atom_4417a5d4() then
				v8:__wf_atom_30a887ab(true)
				object:DeactivateAbility(v8:__wf_atom_1bb5b1ff())
			end

			object:__wf_atom_ac42b904(object:__wf_atom_e8008ec5(v8))
		end

		object:__wf_atom_ac42b904(__wf_atom_248bb7ae, 152)

		if p == 0 then
			local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(__wf_atom_248bb7ae)
			object:__wf_atom_9e7c0c61(object:__wf_atom_6a5c92a7(__wf_atom_2e4994f1), __wf_atom_2e4994f1)
		end

		local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
		secondaryScriptArgs:__wf_atom_079cbbd0(p)
		object:ActivateSecondaryScript(__wf_atom_4ca4978e, Symbol("OnSteal"), secondaryScriptArgs)
	end
end

function StolenAbilityFinished(object)
	local stealAbility = module.GetStealAbility(object:__wf_atom_6009c8ed())

	if not __wf_atom_7e8ad928(stealAbility) then
		object:__wf_atom_ac42b904(object:__wf_atom_248bb7ae(stealAbility))
		stealAbility:SetEnabled(false)
	end

	local v8 = fn4(object)

	if not __wf_atom_7e8ad928(v8) then
		if object:__wf_atom_6009c8ed():__wf_atom_4417a5d4() then
			v8:__wf_atom_30a887ab(false)
		end

		object:__wf_atom_ac42b904(object:__wf_atom_248bb7ae(v8), 152)
	end
end

function HideSpawnedSoulModeHiddenEntityScript(object)
	Sleep(0)
	local v8 = Symbol("SOUL_MODE_HIDDEN")
	local v9 = Symbol("SOUL_MODE_HIDDEN_UPGRADED")
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

	for _, v10 in ipairs(__wf_atom_f582136d) do
		if not (v10:__wf_atom_db682341() == v8 or v10:__wf_atom_db682341() == v9) then
			continue
		end

		v10:__wf_atom_a7ee9662(false, true)

		if v10:IsA(__wf_atom_d00f34c2) then
			v10:__wf_atom_edd3fec6(0)
		end

		v10:__wf_atom_a763aa1a(1)
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
	local runeActivationCost = module7.GetRuneActivationCost()
	object:__wf_atom_f3044fe0(p)
	return runeActivationCost <= object:__wf_atom_f3044fe0(p)
end

function RuneTutorial(object)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local v8 = GetSoulMeterSlot(__wf_atom_d2b2176d)
	__wf_atom_d2b2176d:Equip(5, 0, 0)
	_T.IsRuneTutorialActive = true
	_T.HideImpactMessage()
	local v9 = nil

	while _T.IsRuneTutorialActive do
		if __wf_atom_7e8ad928(object) or object:IsKilled() then
			_T.HideImpactMessage()
		elseif v8 then
			if __wf_atom_7e8ad928(v9) then
				v9 = tutorialTextStrings[1]
				_T.ShowImpactMessage(v9, -1)
			elseif __wf_atom_7e8ad928(v9) or not HasRuneEnergy(__wf_atom_d2b2176d:__wf_atom_e55d02aa(), v8) then
				if not HasRuneEnergy(__wf_atom_d2b2176d:__wf_atom_e55d02aa(), v8) and v9 == tutorialTextStrings[2] then
					break
				end
			else
				v9 = tutorialTextStrings[2]
				_T.ShowImpactMessage(v9, -1)
			end
		elseif __wf_atom_7e8ad928(v8) then
			v8 = GetSoulMeterSlot(object:__wf_atom_d2b2176d())
			_T.HideImpactMessage()
		end

		Sleep(0)
	end

	_T.HideImpactMessage()
end

function OnStealFenn(object, object2)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.noDestroySoul = true
	module6.WaitForLevel()
	module6.WaitForAiDir()
	Sleep(0)
	_T.PlayerGrantedFennJotarRune = nil
	local playerGrantedFennJotarRune = nil

	if gRegion:IsMaster() then
		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(5)
		local v8 = nil
		local v9 = nil

		while __wf_atom_7e8ad928(v8) do
			for _, v10 in ipairs(starterRunes) do
				if __wf_atom_28224c27 == nil then
					return
				end

				if not v10:__wf_atom_8e024c48("", __wf_atom_28224c27) then
					continue
				end

				v9 = __wf_atom_28224c27
				v8 = v10
				break
			end

			Sleep(0)
		end

		if not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v8)) then
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
			local object3 = gRegion:CreateObject(Type(v8), __wf_atom_28224c27, 1)
			object3:__wf_atom_eaa00d7a(v8:__wf_atom_f298d802(), __wf_atom_28224c27:__wf_atom_1bb5b1ff())
			v9:AddUpgrade(object3)
			object3:__wf_atom_bef9f191(0)
			__wf_atom_e55d02aa:FinalizeUpgrades(0)
			__wf_atom_d2b2176d:AddUpgrade(283, 4, 0.5)
			playerGrantedFennJotarRune = object2
		end

		Sleep(0)
		_T.PlayerGrantedFennJotarRune = playerGrantedFennJotarRune
	end

	local __wf_atom_575542c8 = object:__wf_atom_575542c8()
	__wf_atom_7e8ad928(__wf_atom_575542c8)

	if not __wf_atom_7e8ad928(birdType) then
		local v8 = __wf_atom_575542c8:GetPosition() + Vector(0, 1, 0)
		local v9 = object2:GetPosition() + Vector(0, 1, 0)
		local v10 = __wf_atom_fa8d0177(v8, v9)
		local entity = gRegion:CreateEntity(birdType, v8, v10, object2)
		entity:__wf_atom_045760db(object2, Symbol("GAME_C1_SPINE3"), 2.3)
		entity:__wf_atom_6cf07262(2.3)
	end

	object2:__wf_atom_8a035cd5(Symbol("RuneTutorial"), false)
	__wf_atom_575542c8:__wf_atom_a7ee9662(false)
end

function SoulStealRemove(object)
	Sleep(10)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_558ce619(Symbol("SoulSteal"))
	end
end