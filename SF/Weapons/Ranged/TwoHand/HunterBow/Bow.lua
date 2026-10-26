local upgradeSymbol = Symbol("ARROW_SHATTER_DAMAGE")

function HideArrow(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if
		not __wf_atom_7e8ad928(__wf_atom_21ed1a39)
		and __wf_atom_21ed1a39:GetState() ~= 0
		and not object:__wf_atom_87e72caf()
	then
		object:__wf_atom_017e8c6b(true)
	end
end

local function fn(object) -- 2 equivalent calls inferred from this helper
	if object:__wf_atom_87e72caf() then
		object:__wf_atom_017e8c6b(false)
	end
end

function ShowArrow(object)
	fn(object) -- inferred equivalent call
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if not __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		__wf_atom_21ed1a39:__wf_atom_8232852b()
	end
end

local function fn2(object) -- 2 equivalent calls inferred from this helper
	if not object:__wf_atom_87e72caf() then
		object:__wf_atom_017e8c6b(true)
	end
end

function OnOwnerSetOffhandBow(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	while __wf_atom_7e8ad928(__wf_atom_6009c8ed) and not __wf_atom_7e8ad928(object) do
		__wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
		Sleep(0)
	end

	while not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(object)) do
		local __wf_atom_66088189 = object:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			if
				object:__wf_atom_3e33d5dd() == 0
				and (object:GetState() == 13 or object:GetState() == 14)
				and object:__wf_atom_f9b5aca2() > arrowShowChargeAmount
			then
				fn(__wf_atom_66088189) -- inferred equivalent call
			else
				fn2(__wf_atom_66088189) -- inferred equivalent call
			end
		end

		Sleep(0)
	end
end

function OnOwnerSet(object)
	Sleep(0)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	while __wf_atom_7e8ad928(__wf_atom_6009c8ed) and not __wf_atom_7e8ad928(object) do
		__wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
		Sleep(0)
	end

	local v = false

	while not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(object)) do
		local __wf_atom_66088189 = object:__wf_atom_66088189(1, 0)
		local v2 = object:GetState() == 16 or object:GetState() == 17
		local v3 = object:__wf_atom_3e33d5dd() == 0 or object:GetState() == 15

		if not v and v3 and not __wf_atom_7e8ad928(__wf_atom_66088189) and __wf_atom_66088189:__wf_atom_87e72caf() then
			__wf_atom_66088189:__wf_atom_017e8c6b(false)
		end

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			if v3 or __wf_atom_66088189:__wf_atom_87e72caf() then
				if v3 and __wf_atom_66088189:__wf_atom_87e72caf() and not v2 then
					local v4 = object:__wf_atom_5e005c29() == 1 or object:__wf_atom_5e005c29() == 3

					if
						(object:__wf_atom_9f71ab59() or __wf_atom_6009c8ed:__wf_atom_7b82e9e1(26) or not v4)
						and __wf_atom_66088189:__wf_atom_87e72caf()
					then
						__wf_atom_66088189:__wf_atom_017e8c6b(false)
					end
				end
			else
				fn2(__wf_atom_66088189) -- inferred equivalent call
			end
		end

		Sleep(0)
		v = v3
	end
end

local v = Symbol("CHARGED_ARROW_SHATTER")
local v2 = Symbol("ARROW_SHATTER_STABILITY_DAMAGE")
local v3 = Symbol("ARROW_SHATTER_DAMAGE")

local function fn3(object, object2)
	__wf_atom_7e8ad928(__wf_atom_8e4fda44)

	if object:__wf_atom_d2b2176d():__wf_atom_c1f9859f(461, object2:__wf_atom_1bb5b1ff(), object2, nil, v) then
		return true
	end

	return false
end

local function fn4(object, object2)
	local baseStabilityDamage = baseStabilityDamage

	if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object)) then
		baseStabilityDamage = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
			baseStabilityDamage,
			461,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			26,
			v2
		)
	end

	return baseStabilityDamage
end

function Shatter(object)
	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()
	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()
	local baseAmount = object:__wf_atom_ae4f866b(true, true) * 1

	if not (__wf_atom_7e8ad928(__wf_atom_9f2332e5) or __wf_atom_7e8ad928(__wf_atom_7be51ede)) then
		baseAmount = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_2a745663(
			baseAmount,
			461,
			__wf_atom_9f2332e5:__wf_atom_1bb5b1ff(),
			__wf_atom_9f2332e5,
			26,
			v3
		)
	end

	local damageData = Engine.DamageData()
	damageData.baseAmount = baseAmount
	damageData:__wf_atom_7498285f(0, 1)
	damageData.stabilityDamage = __wf_atom_e919fb8e.shatterStabilityDamage
	damageData:__wf_atom_6b472125(object:__wf_atom_7be51ede())
	damageData:__wf_atom_812165c6(object:__wf_atom_e3608dcd())
	damageData.blockableProjType = 4
	damageData.hitType = 2
	damageData.upgradeSymbol = upgradeSymbol
	Sleep(__wf_atom_e919fb8e.timeToShatter)
	gRegion:CreateEntity(shatterEffect, position, __wf_atom_dc309f8a)

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) or __wf_atom_f7e7be53 == object then
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData:__wf_atom_6b472125(__wf_atom_7be51ede)
		radialDamageData:__wf_atom_98d98d81(position)
		radialDamageData:__wf_atom_6d7ec072(Engine.UpgradedValue(baseAmount))
		radialDamageData.stabilityDamage = __wf_atom_e919fb8e.shatterStabilityDamage
		radialDamageData.radius = 2
		radialDamageData:__wf_atom_12cf5317(150)
		radialDamageData:__wf_atom_7498285f(0, 1)
		radialDamageData:__wf_atom_26deafb6(0.3)
		radialDamageData:__wf_atom_34a8a27a(__wf_atom_9f2332e5)
		radialDamageData.checkForCover = false
		radialDamageData.staticCoverOnly = false
		radialDamageData.fallOff = 0
		radialDamageData.hostAuthoritative = true
		radialDamageData.blockableProjType = 4
		radialDamageData.upgradeSymbol = upgradeSymbol
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	else
		__wf_atom_f7e7be53:__wf_atom_649bf33e(damageData)
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

local function fn5(list, list2)
	return list[2] < list2[2]
end

function OnChargedProjectileStop(object, _)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()
	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()

	if
		__wf_atom_7e8ad928(__wf_atom_7be51ede)
		or __wf_atom_7e8ad928(__wf_atom_9f2332e5)
		or not __wf_atom_9f2332e5:IsA(__wf_atom_2dc5c74e)
		or not fn3(__wf_atom_7be51ede, __wf_atom_9f2332e5)
	then
		return
	end

	gRegion:CreateEntity(shatterTriggerEffect, object:GetPosition(), object:__wf_atom_dc309f8a())

	if __wf_atom_7e8ad928(quickShotProjectileType) then
		return
	end

	local shatterStabilityDamage = fn4(__wf_atom_7be51ede, __wf_atom_9f2332e5)
	local position = object:GetPosition()
	local all = gRegion:FindAll(quickShotProjectileType, position, 0, 6)
	local v4 = {}

	for i = 1, #all do
		local v5 = all[i]

		if __wf_atom_7e8ad928(v5) or not v5:__wf_atom_8065a114() then
			continue
		end

		table.insert(v4, { i, __wf_atom_a93b9922(position, v5:GetPosition()) })
	end

	local total = 0.075

	for _, v5 in pairs(v4) do
		local v6 = all[v5[1]]
		total += Random(0.075, 0.15)
		local __wf_atom_e919fb8e = v6:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.timeToShatter = total
		__wf_atom_e919fb8e.shatterStabilityDamage = shatterStabilityDamage
		v6:__wf_atom_8a035cd5(Symbol("Shatter"), false)
	end

	local all2 = gRegion:FindAll(runeShotProjectileType, position, 0, 6)
	local v5 = {}

	if __wf_atom_7e8ad928(all2) then
		return
	end

	for i = 1, #all2 do
		local v6 = all2[i]

		if __wf_atom_7e8ad928(v6) or not v6:__wf_atom_8065a114() then
			continue
		end

		table.insert(v5, { i, __wf_atom_a93b9922(position, v6:GetPosition()) })
	end

	table.sort(v5, fn5)

	for _, v6 in pairs(v5) do
		local v7 = all2[v6[1]]
		total += Random(0.075, 0.15)
		local __wf_atom_e919fb8e = v7:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.timeToShatter = total
		__wf_atom_e919fb8e.shatterStabilityDamage = shatterStabilityDamage
		v7:__wf_atom_8a035cd5(Symbol("Shatter"), false)
	end
end