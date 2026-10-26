local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = false
local entryPoints = {}
local v2 = {}
local v3 = nil
local v4 = nil
local selectedEntryPoint = nil
local v5 = true
local total = 0
local v6 = {
	{ tag = Symbol("PunctInvulnerable"), dmgType = 1 },
	{ tag = Symbol("ImpactInvulnerable"), dmgType = 0 },
	{ tag = Symbol("SlashInvulnerable"), dmgType = 2 }
}
local _ = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}

function DissolveIn(object, p)
	local rockFallDissolveInTime = rockFallDissolveInTime

	if p ~= nil then
		rockFallDissolveInTime = p
	end

	local v7 = rockFallDissolveInTime

	while rockFallDissolveInTime > 0 do
		rockFallDissolveInTime -= __wf_atom_084b3e93()
		object:__wf_atom_68f2c268((__wf_atom_421b01aa(rockFallDissolveInTime / v7, 0, 1)))
		Sleep(0)
	end
end

local function fn(position, p) -- 2 equivalent calls inferred from this helper
	local v7 = __wf_atom_fa8d0177(position, p)
	v7.pitch = 0
	v7.bank = 0
	return v7
end

local function fn2(object, position, p, p2)
	local v7 = p == nil and 10 or p
	local v8 = fn(object:GetPosition(), position) -- inferred equivalent call
	object:__wf_atom_84d66e8e(v8)
	object:__wf_atom_51075230(v8)
	Sleep(0)
	local v9 = position - object:GetPosition()
	v9.y = 0
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	__wf_atom_a06d543c.y = 0
	Normalize(v9)
	Normalize(__wf_atom_a06d543c)
	local v10 = math.abs((__wf_atom_d08b2f29(v9, __wf_atom_a06d543c)))
	local total2 = 0

	while v10 > 5 and total2 < v7 do
		local __wf_atom_a06d543c2 = object:__wf_atom_a06d543c()
		__wf_atom_a06d543c2.y = 0
		Normalize(__wf_atom_a06d543c2)
		v10 = math.abs((__wf_atom_d08b2f29(v9, __wf_atom_a06d543c2)))
		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if p2 ~= nil then
		object:Teleport(object:GetPosition(), v8)
	end
end

local function fn3(object, position, __wf_atom_921c1a5f, callback, p)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local total2 = 0

	if p == nil then
		p = 0.5
	end

	while total2 < __wf_atom_921c1a5f and p < Distance(object:__wf_atom_a2a18137(), position) and not v5 do
		local v7

		if callback == nil then
			v7 = total2 / __wf_atom_921c1a5f
		else
			v7 = callback(total2 / __wf_atom_921c1a5f)
		end

		if IsFrozenSolid(object) then
			object:__wf_atom_d70bf41b(4, object)
		end

		local v8 = (1 - v7) * __wf_atom_a2a18137 + v7 * position
		local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v8)

		if __wf_atom_0e0a6fee.y > object:GetPosition().y + 1 then
			__wf_atom_0e0a6fee = Vector(__wf_atom_0e0a6fee.x, object:GetPosition().y, __wf_atom_0e0a6fee.z)
		end

		object:SetPosition(__wf_atom_0e0a6fee)
		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end
end

local function fn4(object, position, p, p2, callback)
	local position2 = object:GetPosition()
	local midpoint = (position2 + position) / 2
	midpoint.y += 2 * p
	local total2 = 0

	while total2 < p2 do
		local v7

		if callback == nil then
			v7 = total2 / p2
		else
			v7 = callback(total2 / p2)
		end

		if IsFrozenSolid(object) then
			object:__wf_atom_d70bf41b(4)
		end

		object:SetPosition(math.pow(1 - v7, 2) * position2 + (1 - v7) * 2 * v7 * midpoint + math.pow(v7, 2) * position)
		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	object:SetPosition(position)
end

local function fn5(object, p, p2, callback, p3)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local total2 = 0
	local v7 = Distance(__wf_atom_a2a18137, p) / p2

	if p3 == nil then
		p3 = 0.5
	end

	while total2 < v7 and p3 < Distance(object:__wf_atom_a2a18137(), p) and not v5 do
		local v8

		if callback == nil then
			v8 = total2 / v7
		else
			v8 = callback(total2 / v7)
		end

		if IsFrozenSolid(object) then
			object:__wf_atom_d70bf41b(4)
		end

		local v9 = (1 - v8) * __wf_atom_a2a18137 + v8 * p
		local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v9)

		if __wf_atom_0e0a6fee.y < object:GetPosition().y + 0.5 then
			v9.y = __wf_atom_0e0a6fee.y
		end

		object:SetPosition(v9)
		total2 += __wf_atom_084b3e93()

		if showDebug then
			gRegion:__wf_atom_5b35a0c8(
				object:__wf_atom_a2a18137(),
				Color(0, 255, 0),
				Distance(object:__wf_atom_a2a18137(), p),
				1,
				0
			)
		end

		Sleep(0)
	end
end

function RockFallArea(object)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	if __wf_atom_7e8ad928(__wf_atom_ef7900cf) or #__wf_atom_ef7900cf == 0 then
		return
	end

	local buttSlamRockFallRadius2 = buttSlamRockFallRadius
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local position = object:GetPosition()
	local v7 = Vector(0, 0, 0)
	local _ = buttSlamRockFallRadius2 * math.sqrt((__wf_atom_7abf2d2f()))
	local _ = math.random() * 2 * 3.141592653589793
	local count = 0

	if showDebug then
		gRegion:__wf_atom_5b35a0c8(position + Vector(0, 1, 0), Color(0, 255, 0), "Rock Fall Area", 1, 10)
		gRegion:__wf_atom_b5c21154(
			position + Vector(0, 1, 0),
			buttSlamRockFallRadius,
			Color(0, 255, 0),
			Rotation(0, 90, 0),
			10
		)
	end

	while count < rockFallTotalNumber do
		v7.x = position.x
		v7.z = position.z
		v7.y = position.y
		local v8 = buttSlamRockFallRadius2 * math.sqrt((math.random()))
		local v9 = math.random() * 2 * 3.141592653589793
		v7.x += math.cos(v9) * v8
		v7.z += math.sin(v9) * v8

		if showDebug then
			gRegion:__wf_atom_b5c21154(v7 + Vector(0, 1, 0), 1, Color(0, 255, 0), Rotation(0, 90, 0), 10)
		end

		gRegion:CreateEntity(RockFallTelegraphFX, v7, __wf_atom_80368bb1)
		v7.y += rockFallStartHeight
		local v10 = __wf_atom_fa8d0177(Vector(0, 1, 0), Vector(0, 0, 0))
		local entity = gRegion:CreateEntity(rockFallProjectileType, v7, v10, object, object, 1)
		Sleep(0)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_8a035cd5(Symbol("DissolveIn"), false)
			entity:__wf_atom_8fcdea81(object)
			entity:__wf_atom_c6dbdab6(__wf_atom_e55d02aa)
		end

		count += 1
		Sleep(projectileInterval:__wf_atom_ff1686f2())
	end
end

function CheckIfStuck(p, p2, p3)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	if math.pow(__wf_atom_a93b9922(p2, p3) / __wf_atom_084b3e93(), 2) < 1 then
		total += __wf_atom_084b3e93()

		if total >= 1 then
			return true
		end
	else
		total = 0
	end

	return false
end

local function fn6(object)
	if __wf_atom_7e8ad928(v2) or #v2 == 0 then
		v2 = gRegion:__wf_atom_2226b35c(Symbol("BromiusRootBarrier"))
	end

	local position = object:GetPosition()
	local v7 = nil

	for _, v8 in pairs(v2) do
		local __wf_atom_a5304c35 = v8:__wf_atom_a5304c35(position)

		if __wf_atom_7e8ad928(v7) or __wf_atom_a5304c35 < v7:__wf_atom_a5304c35(position) then
			v7 = v8
		end
	end

	return v7
end

local function fn7(object)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	for _, v7 in pairs(v6) do
		__wf_atom_7470861b:__wf_atom_9fba31e6(v7.tag, v7.dmgType, 6, 0)
	end
end

function NpcEvaluateAbility(p, object)
	entryPoints = gRegion:__wf_atom_2226b35c(Symbol("BromiusChargePoint"))

	if __wf_atom_7e8ad928(entryPoints) then
		return 0
	end

	local selectedEntryPoint2 = nil
	local v7 = 0

	for _, v8 in pairs(entryPoints) do
		if __wf_atom_7e8ad928(v8) then
			return
		end

		local v9 = fn6(v8):__wf_atom_a2a18137() + v8:__wf_atom_a06d543c() * jumpMidPointPos
		local v10 = v8:GetPosition() - v9
		local v11 = object:GetPosition() - v9
		local v12 = v9 - object:GetPosition()
		Normalize(v11)
		Normalize(v10)
		Normalize(v12)
		local v13 = math.abs((__wf_atom_d08b2f29(v11, v10)))
		local v14 = math.abs((__wf_atom_d08b2f29(object:__wf_atom_a06d543c(), v12)))

		if showDebug then
			gRegion:__wf_atom_628723a6(object:GetPosition(), v9, Color(0, 255, 0), 10)
			gRegion:__wf_atom_628723a6(v9, v8:GetPosition(), Color(0, 255, 0), 10)
			gRegion:__wf_atom_5b35a0c8(v9, Color(0, 255, 0), v13, 1, 10)
		end

		if not (jumpMidPointValidAngle < v13 and (__wf_atom_7e8ad928(selectedEntryPoint2) or v14 < v7)) then
			continue
		end

		v7 = v14
		selectedEntryPoint2 = v8
	end

	if __wf_atom_7e8ad928(selectedEntryPoint2) then
		for _, v8 in pairs(entryPoints) do
			if __wf_atom_7e8ad928(v8) then
				return
			end

			local __wf_atom_a5304c35 = object:__wf_atom_a5304c35(v8:GetPosition())

			if not (__wf_atom_7e8ad928(selectedEntryPoint2) or object:__wf_atom_a5304c35(selectedEntryPoint2:GetPosition()) < __wf_atom_a5304c35) then
				continue
			end

			selectedEntryPoint2 = v8
		end
	end

	local v8 = { entryPoints = entryPoints, selectedEntryPoint = selectedEntryPoint2 }
	module.SetAbilityStats(p, mOwner, v8)
	object:__wf_atom_78ad8b9f(128, 1)
	return 1
end

local function fn8(entryPoints2, p, p2)
	if __wf_atom_7e8ad928(p) and __wf_atom_7e8ad928(p2) then
		return entryPoints2[math.random(1, #entryPoints2)]
	end

	local v7 = 1

	while v7 <= #entryPoints2 do
		if entryPoints2[v7] == p or entryPoints2[v7] == p2 then
			table.remove(entryPoints2, v7)
		else
			v7 += 1
		end
	end

	return entryPoints2[math.random(1, #entryPoints2)]
end

function HideAvatar(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	__wf_atom_6009c8ed:__wf_atom_68f2c268(1)
end

function DissolveInTime(object, _, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	DissolveIn(__wf_atom_6009c8ed, p)
end

function ActivateAbility(object, object2, _)
	if teleportDebug then
		object2:Teleport(gRegion:GetPlayerAvatar():GetPosition(), gRegion:GetPlayerAvatar():__wf_atom_dc309f8a())
		Sleep(0.5)
	end

	v5 = false

	if gRegion:IsMaster() then
		local v7 = __wf_atom_5784a397(chargeLoops.minValue, chargeLoops.maxValue)
		object2:__wf_atom_78ad8b9f(128, 1)
		local abilityStats = module.GetAbilityStats(object, mOwner, true)
		entryPoints = gRegion:__wf_atom_2226b35c(Symbol("BromiusChargePoint"))
		v2 = gRegion:__wf_atom_2226b35c(Symbol("BromiusRootBarrier"))

		if __wf_atom_7e8ad928(abilityStats) then
			local selectedEntryPoint2 = nil
			local v8 = 0

			for _, v9 in pairs(entryPoints) do
				if __wf_atom_7e8ad928(v9) then
					return
				end

				local v10 = fn6(v9):__wf_atom_a2a18137() + v9:__wf_atom_a06d543c() * jumpMidPointPos
				local v11 = v9:GetPosition() - v10
				local v12 = object2:GetPosition() - v10
				local v13 = v10 - object2:GetPosition()
				Normalize(v12)
				Normalize(v11)
				Normalize(v13)
				local v14 = math.abs((__wf_atom_d08b2f29(v12, v11)))
				local v15 = math.abs((__wf_atom_d08b2f29(object2:__wf_atom_a06d543c(), v13)))

				if showDebug then
					gRegion:__wf_atom_628723a6(object2:GetPosition(), v10, Color(0, 255, 0), 10)
					gRegion:__wf_atom_628723a6(v10, v9:GetPosition(), Color(0, 255, 0), 10)
					gRegion:__wf_atom_5b35a0c8(v10, Color(0, 255, 0), v14, 1, 10)
				end

				if not (jumpMidPointValidAngle < v14 and (__wf_atom_7e8ad928(selectedEntryPoint2) or v15 < v8)) then
					continue
				end

				v8 = v15
				selectedEntryPoint2 = v9
			end

			if __wf_atom_7e8ad928(selectedEntryPoint2) then
				for _, v9 in pairs(entryPoints) do
					if __wf_atom_7e8ad928(v9) then
						return
					end

					local __wf_atom_a5304c35 = object2:__wf_atom_a5304c35(v9:GetPosition())

					if not (__wf_atom_7e8ad928(selectedEntryPoint2) or object2:__wf_atom_a5304c35(selectedEntryPoint2:GetPosition()) < __wf_atom_a5304c35) then
						continue
					end

					selectedEntryPoint2 = v9
				end
			end

			abilityStats = { entryPoints = entryPoints, selectedEntryPoint = selectedEntryPoint2 }
			module.SetAbilityStats(object, mOwner, abilityStats)
		end

		if __wf_atom_7e8ad928(abilityStats) then
			return
		end

		entryPoints = abilityStats.entryPoints
		selectedEntryPoint = abilityStats.selectedEntryPoint

		if gRegion:IsMaster() then
			object2:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")
			fn7(object2)
			v = true
		end

		local taggedChild = module2.FindTaggedChild(object2:__wf_atom_be0bea4a(), Symbol("BromiusDamageTrigger"))

		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:Enable()
		end

		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

		if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			return
		end

		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		local position = selectedEntryPoint:GetPosition()
		v3 = selectedEntryPoint

		if showDebug then
			gRegion:__wf_atom_5b35a0c8(position, Color(0, 255, 0), "Bromius Destination", 1, 10)
		end

		local v8 = fn6(selectedEntryPoint)
		object2:SetDisableGravity(true)
		object2:__wf_atom_d1b42aad(false)
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local v9 = v8:__wf_atom_a2a18137() + selectedEntryPoint:__wf_atom_a06d543c() * jumpMidPointPos

		if not __wf_atom_7e8ad928(__wf_atom_7d789620) then
			v9 = __wf_atom_7d789620:__wf_atom_0e0a6fee(v9)
		end

		if showDebug then
			gRegion:__wf_atom_5b35a0c8(v9, Color(0, 255, 0), "BarrierMidWaypoint", 1, 10)
		end

		__wf_atom_30e3d82b:StartMoving(v9, 2)
		object2:SetPosture(2)
		local runToStartPointTimeOut = runToStartPointTimeOut

		while
			not __wf_atom_7e8ad928(object2)
			and object2:__wf_atom_d5fda8be(v9) > agentRunStopDistance
			and runToStartPointTimeOut > 0
			and not (object2:IsKilled() or object2:__wf_atom_bedb4e3f() or v5)
		do
			local __wf_atom_d5fda8be = object2:__wf_atom_d5fda8be(v9)

			if showDebug then
				gRegion:__wf_atom_5b35a0c8(v9 + Vector(0, 1, 0), Color(0, 255, 0), __wf_atom_d5fda8be, 1, 0)
			end

			if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or not IsFrozenSolid(object2) then
				runToStartPointTimeOut -= __wf_atom_084b3e93()
				Sleep(0)
			else
				__wf_atom_30e3d82b:__wf_atom_b414eabf()
				return
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
		end

		if __wf_atom_7e8ad928(object2) or object2:IsKilled() or object2:__wf_atom_bedb4e3f() or v5 then
			return
		end

		if object2:__wf_atom_d5fda8be(v9) > agentRunStopDistance then
			object2:__wf_atom_921c1a5f(chargeThrough, false, 2, 2, true)
			fn5(object2, v9, 6.5, nil, agentRunStopDistance)

			if __wf_atom_7e8ad928(object2) then
				return
			else
				object2:__wf_atom_921c1a5f(nil, false)
			end
		end

		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b)
			or __wf_atom_7e8ad928(object2)
			or object2:IsKilled()
			or object2:__wf_atom_bedb4e3f()
			or v5
		then
			return
		end

		local v10 = v8:__wf_atom_a2a18137() + selectedEntryPoint:__wf_atom_a06d543c() * jumpIntoBarrierPos
		__wf_atom_30e3d82b:StartMoving(v10, 2)

		if showDebug then
			gRegion:__wf_atom_5b35a0c8(v10, Color(0, 255, 0), "BarrierStartJumpPos", 1, 10)
		end

		module2.SetImmunity(object2, true)
		local v11 = 5

		while
			not __wf_atom_7e8ad928(object2)
			and object2:__wf_atom_d5fda8be(v10) > agentRunStopDistance
			and v11 > 0
			and not (object2:IsKilled() or object2:__wf_atom_bedb4e3f())
		do
			local __wf_atom_d5fda8be = object2:__wf_atom_d5fda8be(v9)

			if showDebug then
				gRegion:__wf_atom_5b35a0c8(v10 + Vector(0, 1, 0), Color(0, 255, 0), __wf_atom_d5fda8be, 1, 0)
			end

			if IsFrozenSolid(object2) then
				object2:__wf_atom_d70bf41b(4)
			end

			v11 -= __wf_atom_084b3e93()
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
		end

		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b)
			or __wf_atom_7e8ad928(object2)
			or object2:IsKilled()
			or object2:__wf_atom_bedb4e3f()
			or v5
		then
			return
		end

		if gRegion:IsMaster() then
			v = false
		end

		local __wf_atom_921c1a5f = object2:__wf_atom_921c1a5f(jumpAway, false, 2, 1, true)
		local _ = jumpAway:__wf_atom_091354f5(Symbol(jumpAwayOpenBarrierEvent)) * __wf_atom_921c1a5f
		fn6(selectedEntryPoint):FirePort("Unlock")
		fn3(object2, position, __wf_atom_921c1a5f)
		local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
		object:ActivateSecondaryScript(mOwner:__wf_atom_e14d8a8c(), Symbol("HideAvatar"), secondaryScriptArgs)

		for i = 1, v7 do
			if __wf_atom_7e8ad928(object2) or object2:IsKilled() or object2:__wf_atom_bedb4e3f() then
				break
			end

			if IsFrozenSolid(object2) then
				object2:__wf_atom_d70bf41b(4)
			end

			object2:__wf_atom_921c1a5f(nil, false)
			local v12 = fn8(entryPoints, v3, v4)

			if not __wf_atom_7e8ad928(v3) then
				fn6(v3):FirePort("Lock")
			end

			if not __wf_atom_7e8ad928(v4) then
				fn6(v4):FirePort("Lock")
			end

			local v13

			if i == v7 then
				v13 = gRegion:__wf_atom_0a6a5887(Symbol("ButtSlam"))
			else
				v13 = v12:__wf_atom_31c6f706()[1]
			end

			if showDebug then
				gRegion:__wf_atom_628723a6(v12:GetPosition(), v13:GetPosition(), Color(0, 255, 0), 10)
			end

			local v14 = __wf_atom_fa8d0177(v12:GetPosition(), v13:GetPosition())
			object2:Teleport(v12:GetPosition(), v14)
			object2:__wf_atom_84d66e8e(v14)
			local secondaryScriptArgs2 = SF.SecondaryScriptArgs(true)
			secondaryScriptArgs2:__wf_atom_079cbbd0(runtime)
			object:ActivateSecondaryScript(mOwner:__wf_atom_e14d8a8c(), Symbol("DissolveInTime"), secondaryScriptArgs2)
			Sleep(runtime)
			fn6(v12):FirePort("Unlock")
			Sleep(goingOutWaitTime)

			if __wf_atom_7e8ad928(object2) or object2:IsKilled() or object2:__wf_atom_bedb4e3f() then
				break
			end

			local v15 = fn(object2:GetPosition(), v13:GetPosition()) -- inferred equivalent call
			object2:Teleport(object2:GetPosition(), v15)

			if not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(v13)) then
				__wf_atom_30e3d82b:__wf_atom_b783ff91(v13:GetPosition())
			end

			fn2(object2, v13:GetPosition(), 5)

			if __wf_atom_7e8ad928(object2) or object2:IsKilled() or object2:__wf_atom_bedb4e3f() then
				break
			end

			if i == v7 then
				local __wf_atom_921c1a5f2 = object2:__wf_atom_921c1a5f(jumpEnd, false, 2, 1, true)
				local v16 = jumpEnd:__wf_atom_091354f5(Symbol("ButtSlam")) * __wf_atom_921c1a5f2
				fn4(object2, v13:GetPosition(), 0, v16)
				module2.SetImmunity(object2, false)
				object2:__wf_atom_8a035cd5(Symbol("RockFallArea"), false)

				if not __wf_atom_7e8ad928(slamFX) then
					gRegion:CreateEntity(slamFX, v13:GetPosition(), __wf_atom_80368bb1, object2, object2, 1)
				end
			else
				fn6(v13):FirePort("Unlock")
				object2:__wf_atom_921c1a5f(chargeThrough, false, 2, 2, true)
				object2:SetDisableGravity(true)
				object2:__wf_atom_d1b42aad(false)
				module2.SetImmunity(object2, false)
				fn5(object2, v13:GetPosition(), chargeVelocityMult * object2:__wf_atom_c082fc3d())
			end

			v3 = v12
			v4 = v13

			if not (v5 and i ~= v7) then
				continue
			end

			object2:__wf_atom_921c1a5f(chargeInterupt, false, 2, 1, true)
			break
		end

		if __wf_atom_7e8ad928(object2) then
			return
		end

		object2:SetDisableGravity(false)
		object2:__wf_atom_d1b42aad(true)

		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:Disable()
		end

		if not __wf_atom_7e8ad928(v3) then
			fn6(v3):FirePort("Lock")
		end

		if not __wf_atom_7e8ad928(v4) then
			fn6(v4):FirePort("Lock")
		end

		while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_c138b19b(jumpEnd) do
			if object2:__wf_atom_c138b19b(chargeInterupt) then
				return
			else
				Sleep(0)
			end
		end

		if not __wf_atom_7e8ad928(object2) then
			object2:__wf_atom_921c1a5f(nil, false)
		end
	else
		object2:__wf_atom_78ad8b9f(128, 1)

		while not (__wf_atom_7e8ad928(object2) or object2:__wf_atom_c138b19b(jumpAway)) do
			Sleep(0)
		end

		if __wf_atom_7e8ad928(object2) then
			return
		end

		object2:SetDisableGravity(true)
		object2:__wf_atom_d1b42aad(false)

		while not (__wf_atom_7e8ad928(object2) or object2:__wf_atom_c138b19b(jumpEnd)) do
			if object2:__wf_atom_c138b19b(chargeInterupt) then
				return
			else
				Sleep(0)
			end
		end

		if __wf_atom_7e8ad928(object2) then
			return
		end

		object2:__wf_atom_8914dfde("ButtSlam", 10)
	end
end

function IsFrozenSolid(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	return object:IsFrozenSolid()
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(mOwner) or __wf_atom_7e8ad928((mOwner:__wf_atom_c78fa517())) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if object:__wf_atom_bedb4e3f() or object:IsKilled() then
		v5 = true
	elseif
		__wf_atom_9d766292:__wf_atom_78650070(19)
		or __wf_atom_9d766292:__wf_atom_78650070(17)
		or __wf_atom_9d766292:__wf_atom_78650070(18)
	then
		v5 = true
	end
end

function DeactivateAbility(_, object, _, _)
	if gRegion:IsMaster() and not __wf_atom_7e8ad928(object) then
		object:__wf_atom_3ede53b4(Symbol("InteruptDamage"))
		local __wf_atom_7470861b = object:__wf_atom_7470861b()

		for _, v7 in pairs(v6) do
			__wf_atom_7470861b:__wf_atom_63396172(v7.tag)
		end

		module2.SetImmunity(object, false)
	end

	if not __wf_atom_7e8ad928(object) then
		object:SetDisableGravity(false)
		object:__wf_atom_d1b42aad(true)
		local taggedChild = module2.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("BromiusDamageTrigger"))

		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:Disable()
		end

		object:MotionControl():__wf_atom_3959d938(false)
	end
end