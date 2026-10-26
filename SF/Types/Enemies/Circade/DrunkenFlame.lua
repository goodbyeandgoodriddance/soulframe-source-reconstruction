require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Libs.CommonFunctionsLib")
local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")

function NpcEvaluateAbility(object, object2)
	local total = 0
	local __wf_atom_d8853f2a = object2:__wf_atom_30e3d82b():__wf_atom_d8853f2a()
	local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(
		object2:__wf_atom_a2a18137(),
		spawnRange,
		numberOfColumns
	)

	if __wf_atom_7e8ad928(randomSpawnsOnNavInRange) or #randomSpawnsOnNavInRange == 0 then
		return 0
	end

	for i = 1, #__wf_atom_d8853f2a do
		local v = __wf_atom_d8853f2a[i]

		if not (v.visible and v:__wf_atom_a3309443()) then
			continue
		end

		local distanceToTarget = v.distanceToTarget

		if not (distanceToTarget >= 0 and distanceToTarget <= triggerDistance and v.avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5) then
			continue
		end

		total += (1 - distanceToTarget / triggerDistance) / #__wf_atom_d8853f2a
		object:__wf_atom_f7170fc9(v.avatar)
	end

	return total
end

function SpawnFireColumnClient(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_af89d322 = object:__wf_atom_af89d322(mOwner:__wf_atom_1bb5b1ff())

	for _, v in pairs(__wf_atom_af89d322) do
		local entity = gRegion:CreateEntity(columnTelegraphFX, v + columnFXOffset, __wf_atom_80368bb1)
		Sleep(columnTelegraphTime)
		gRegion:CreateEntity(fireColumn, v, __wf_atom_80368bb1, __wf_atom_6009c8ed)
		Sleep(timeBetweenEruptions)

		if not __wf_atom_7e8ad928(entity) then
			entity:Destroy()
		end
	end
end

function ActivateAbility(object, object2, p)
	local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(
		object2:__wf_atom_a2a18137(),
		spawnRange,
		numberOfColumns
	)

	if __wf_atom_7e8ad928(randomSpawnsOnNavInRange) or #randomSpawnsOnNavInRange == 0 then
		return
	end

	module2.PlayGlobalTransmission(transmissionSet, Symbol("FireAbility"))

	if
		__wf_atom_7e8ad928(p)
		and not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object2:__wf_atom_30e3d82b()))
	then
		local _entity = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
	end

	local __wf_atom_921c1a5f = object2:__wf_atom_921c1a5f(castAnim, false, 4, 1, true)
	local v = castAnim:__wf_atom_091354f5(Symbol("CastPower")) * __wf_atom_921c1a5f
	local v2 = castAnim:__wf_atom_091354f5(Symbol("CreateBottle")) * __wf_atom_921c1a5f
	local v3 = castAnim:__wf_atom_091354f5(Symbol("ThrowBottle")) * __wf_atom_921c1a5f
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local total = 0
	local v4 = nil

	while total < 5 do
		if v2 <= total and __wf_atom_7e8ad928(v4) then
			v4 = object2:Attach(bottleWeakRes, Symbol("GAME_L1_WEAPON1"), Vector(-0.03, -0.04, 0), __wf_atom_80368bb1)
		end

		if v3 <= total then
			__wf_atom_7e8ad928(v4)
		end

		if v <= total then
			v4:Destroy()
			break
		end

		if showDebug then
			for i = 1, #randomSpawnsOnNavInRange do
				gRegion:__wf_atom_b5c21154(randomSpawnsOnNavInRange[i], 1, debugColour, Rotation(0, 90, 0), 1)
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not gRegion:IsMaster() then
		return
	end

	for i = 1, #__wf_atom_ef7900cf do
		if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) or __wf_atom_ef7900cf[i]:IsKilled() then
			continue
		end

		table.insert(randomSpawnsOnNavInRange, #randomSpawnsOnNavInRange + 1, __wf_atom_ef7900cf[i]:GetPosition())
	end

	local secondaryScriptArgs = SF.SecondaryScriptArgs(true)

	for _, v5 in pairs(randomSpawnsOnNavInRange) do
		secondaryScriptArgs:__wf_atom_37d0a93a(v5)
	end

	object:ActivateSecondaryScript(mOwner:__wf_atom_e14d8a8c(), Symbol("SpawnFireColumnClient"), secondaryScriptArgs)

	for _, v5 in pairs(randomSpawnsOnNavInRange) do
		local entity = gRegion:CreateEntity(columnTelegraphFX, v5 + columnFXOffset, __wf_atom_80368bb1)
		Sleep(columnTelegraphTime)
		gRegion:CreateEntity(fireColumn, v5, __wf_atom_80368bb1, object2)
		Sleep(timeBetweenEruptions)

		if not __wf_atom_7e8ad928(entity) then
			entity:Destroy()
		end
	end
end

function ColumnDamage(instance)
	local v

	if not __wf_atom_7e8ad928(columnVFX) then
		v = gRegion:CreateEntity(columnVFX, instance:__wf_atom_a2a18137() + columnFXOffset, __wf_atom_80368bb1)
	end

	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = aoeRadius
	radialDamageData.baseAmount = aoeDamage
	radialDamageData.stabilityDamage = aoeStabilityDamage
	radialDamageData.hitAirborneTargets = true
	radialDamageData.checkForCover = false
	radialDamageData:__wf_atom_7498285f(12, 1)
	radialDamageData:__wf_atom_d6f4d914(16, true)
	radialDamageData:__wf_atom_98d98d81(instance:__wf_atom_a2a18137() + Vector(0, 1, 0))
	local creator = instance:GetCreator()

	if __wf_atom_7e8ad928(creator) then
		radialDamageData:__wf_atom_6b472125(instance)
		radialDamageData:__wf_atom_34a8a27a(instance)
	else
		instance:__wf_atom_7ebba814(creator)
		radialDamageData:__wf_atom_6b472125(creator)
		radialDamageData:__wf_atom_34a8a27a(creator:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
	end

	local v2 = math.random(columnlifeTime.minValue, columnlifeTime.maxValue)
	local total = 0

	while total <= v2 do
		total += __wf_atom_084b3e93()
		Sleep(0)

		if showDebug then
			gRegion:__wf_atom_b5c21154(instance:__wf_atom_a2a18137(), aoeRadius, debugColour, Rotation(0, 90, 0), 3)
		end
	end

	v:Destroy()
	Sleep(aoeSpawnDelay)
	gRegion:__wf_atom_f6ec80de(radialDamageData)

	if showDebug then
		gRegion:__wf_atom_b5c21154(instance:__wf_atom_a2a18137(), aoeRadius, debugColour, Rotation(0, 90, 0), 3)
	end

	gRegion:CreateEntity(aoeFX, instance:__wf_atom_a2a18137(), __wf_atom_80368bb1)
	instance:Destroy()
end