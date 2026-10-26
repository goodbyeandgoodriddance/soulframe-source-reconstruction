require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Scripts.Libs.EncounterLib")
local module = require("SF.Scripts.Libs.TransmissionSet")

function ActivatePassive(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) or not gRegion:IsMaster() then
		return
	end

	local v = false

	while not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled()) do
		if __wf_atom_6009c8ed:__wf_atom_7b82e9e1(4) and v then
			if Random(0, 100) < droppingElementChance then
				module.PlayGlobalTransmission(transmissionSet, Symbol("SmokeAbility"))
				Sleep(dropingElementSpawnDelay)
				gRegion:CreateEntity(
					droppingElement,
					__wf_atom_6009c8ed:__wf_atom_a2a18137(),
					__wf_atom_80368bb1,
					__wf_atom_6009c8ed,
					__wf_atom_6009c8ed,
					1
				):__wf_atom_7ebba814(__wf_atom_6009c8ed)
			end

			v = false
		else
			v = not __wf_atom_6009c8ed:__wf_atom_7b82e9e1(4) or v
		end

		Sleep(0)
	end
end

local function fn(list, instance)
	for _, v in ipairs(list) do
		if not __wf_atom_7e8ad928(v) and v:__wf_atom_8a6b8fc3(instance) < playerDetectingRange then
			return true
		end
	end

	return false
end

function droppingExplodeDamage(instance)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local creator = instance:GetCreator()
	local v

	if not __wf_atom_7e8ad928(beforeExplodingFX) then
		v = gRegion:CreateEntity(
			beforeExplodingFX,
			instance:__wf_atom_a2a18137() + beforeExplodeFXOffset,
			__wf_atom_80368bb1,
			nil,
			nil,
			1
		)
	end

	local droppingElementMaxLifeTime = droppingElementMaxLifeTime

	while
		droppingElementMaxLifeTime > 0
		and not (fn(__wf_atom_ef7900cf, instance) or creator:IsKilled() or creator:__wf_atom_bedb4e3f())
	do
		droppingElementMaxLifeTime -= __wf_atom_084b3e93()

		if showDebug then
			gRegion:__wf_atom_b5c21154(
				instance:__wf_atom_a2a18137(),
				playerDetectingRange,
				debugColour,
				Rotation(0, 90, 0),
				1
			)
		end

		Sleep(0)
	end

	if creator:IsKilled() or creator:__wf_atom_bedb4e3f() then
		if not __wf_atom_7e8ad928(v) then
			v:Destroy()
		end
	else
		local creator2 = instance:GetCreator()
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.radius = aoeRadius
		radialDamageData.baseAmount = aoeDamage
		radialDamageData.stabilityDamage = stabilityDamage
		radialDamageData.hitAirborneTargets = hitAirborne
		radialDamageData.checkForCover = checkCover
		radialDamageData.baseProcChance = damageProcChance
		radialDamageData:__wf_atom_7498285f(damageType, 1)
		radialDamageData:__wf_atom_d6f4d914(damageProc, true)
		radialDamageData:__wf_atom_98d98d81(instance:__wf_atom_a2a18137())
		radialDamageData.fallOff = damageFallOff
		radialDamageData.hostAuthoritative = true

		if __wf_atom_7e8ad928(creator2) then
			radialDamageData:__wf_atom_6b472125(instance)
			radialDamageData:__wf_atom_34a8a27a(instance)
		else
			instance:__wf_atom_7ebba814(creator2)
			radialDamageData:__wf_atom_6b472125(creator2)
			radialDamageData:__wf_atom_34a8a27a(creator2:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
		end

		if showDebug then
			gRegion:__wf_atom_b5c21154(
				instance:__wf_atom_a2a18137(),
				aoeRadius,
				debugColour,
				Rotation(0, 90, 0),
				explodeDelayAfterPlayerInRange
			)
		end

		Sleep(explodeDelayAfterPlayerInRange)

		if not __wf_atom_7e8ad928(v) then
			v:Destroy()
		end

		gRegion:CreateEntity(explodingFX, instance:__wf_atom_a2a18137(), __wf_atom_80368bb1, nil, nil, 1)
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		instance:Destroy()
	end
end

function RemovePassive(object)
	if __wf_atom_7e8ad928((object:__wf_atom_6009c8ed())) then
	end
end