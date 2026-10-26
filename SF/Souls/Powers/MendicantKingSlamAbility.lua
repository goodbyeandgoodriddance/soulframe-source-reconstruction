local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(object, object2, _)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not npcUseRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
	then
		return 0
	end

	local all = gRegion:FindAll(corruptionSpawnDeco, object2:GetPosition(), 0, rangeToCheckForMounds)
	local count = 0

	if not __wf_atom_7e8ad928(all) then
		for _, v in pairs(all) do
			if v:__wf_atom_c6f1f83d() ~= -1 then
				count += 1
			end
		end
	end

	if __wf_atom_7e8ad928(all) or count <= amountOfMoundsNeededToActivate then
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	end

	return 0
end

local function fn(object, p)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v

	if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
		v = __wf_atom_2202ffb6:__wf_atom_7d789620()
	end

	local v2 = 360 / numberOfSpikesToSpawn
	local total = 0
	local warningFXs = {}
	local __wf_atom_0e0a6fees = {}

	while total < 360 do
		local v3 = math.rad(total)
		local position = object:GetPosition()
		local v4 = position.x + spikesRadius * math.cos(v3)
		local v5 = position.z + spikesRadius * math.sin(v3)
		local __wf_atom_0e0a6fee = v:__wf_atom_0e0a6fee((Vector(v4, position.y, v5)))

		if gRegion:IsMaster() then
			table.insert(warningFXs, (gRegion:CreateEntity(warningSlamFX, __wf_atom_0e0a6fee, __wf_atom_80368bb1)))
		end

		if debugDraw then
			local v6 = Color(255, 0, 93)
			gRegion:__wf_atom_8d991675(__wf_atom_0e0a6fee, 1, v6, 3)
		end

		__wf_atom_0e0a6fees[#__wf_atom_0e0a6fees + 1] = __wf_atom_0e0a6fee
		total += v2
	end

	_T.WarningFXs = warningFXs
	object:__wf_atom_8914dfde(animSpikesEvent, 2)

	for _, v3 in pairs(__wf_atom_0e0a6fees) do
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = AOEDamageAmount
		radialDamageData.stabilityDamage = AoeStabilityDamageAmount
		radialDamageData.radius = AoeDamageRadius
		radialDamageData.fallOff = 0
		radialDamageData.checkForCover = false
		radialDamageData:__wf_atom_7498285f(7, 1)
		radialDamageData:__wf_atom_12cf5317(15000)
		radialDamageData:__wf_atom_98d98d81(v3 + Vector(0, 1, 0))
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(p)
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end

	Sleep(0.2)

	for _, v3 in ipairs(warningFXs) do
		if not __wf_atom_7e8ad928(v3) then
			v3:Destroy()
		end
	end

	for _, v3 in pairs(__wf_atom_0e0a6fees) do
		if not gRegion:IsMaster() then
			continue
		end

		gRegion:CreateEntity(createSpikesFX, v3, __wf_atom_80368bb1)
		local v4 = __wf_atom_fa8d0177(v3, object:GetPosition()) + Rotation(35, 0, 0)
		local entity = gRegion:CreateEntity(corruptionSpawnDeco, v3, v4)

		if __wf_atom_7e8ad928(_T.MendicantKingCurrentMounds) then
			_T.MendicantKingCurrentMounds = {}
		end

		_T.MendicantKingCurrentMounds[#_T.MendicantKingCurrentMounds + 1] = entity
	end
end

function ActivateAbility(p, object)
	if not module.PlayAnimAndSuspendUntilEvent(p, activateAnim, warningFxEvent, false, 2, 1, true) then
		return
	end

	if not __wf_atom_7e8ad928(_T.MendicantKingCurrentMounds) and gRegion:IsMaster() then
		for _, mendicantKingCurrentMound in pairs(_T.MendicantKingCurrentMounds) do
			if not __wf_atom_7e8ad928(mendicantKingCurrentMound) then
				mendicantKingCurrentMound:Destroy()
			end
		end
	end

	fn(object, p)

	if not __wf_atom_7e8ad928(activateAnim) then
		while object:__wf_atom_c138b19b(activateAnim) do
			Sleep(0.1)
		end
	end
end