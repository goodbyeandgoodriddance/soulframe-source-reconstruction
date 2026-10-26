local v = Vector(0, 60, 0)
local v2 = {
	{ distanceMax = 20, distanceMin = 10, rotateTime = 40 },
	{ distanceMax = 30, distanceMin = 20, rotateTime = 50 }
}
local v3 = {
	{ distanceMax = 3, distanceMin = 3, rotateTime = 10 }
}
local v4 = Symbol("CollectorCinTale")
local v5 = Symbol("CollectorCinTaleLeaving")
local v6 = Symbol("CollectorCinTaleDestruction")
local v7 = Symbol("FloatingBalloon")
local v8 = Symbol("AnimalCageSpawn")
local v9 = Symbol("ObjectiveSpawnCollectorCrate")
local v10 = Symbol("Guard")
local v11 = WeakResource("/EE/Types/Engine/SoundSysVolume")
local v12 = Vector(0, -14, 0)
local v13 = WeakResource("/SF/Types/Game/Encounters/Ode/Components/ExplosivesAttachment")
local v14 = Symbol("Grineer")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module6 = require("Lotus.Scripts.Libs.Query")
local module7 = require("Lotus.Scripts.Libs.AudioLib")
local module8 = require("SF.Scripts.Libs.ChallengeLib")
local module9 = require("SF.Scripts.Libs.QuestLib")
local v15 = nil
local v16 = nil
local v17 = nil
local total = 0
local v18 = nil
local position = nil
local position2 = nil
local v19 = {}
local total2 = 999
local v20 = nil
local v21 = nil
local v22 = nil
local count = 0
local v23 = false
local v24 = {}
local v25 = {}
local v26 = nil
local entities = nil
local v27 = nil
local v28 = nil
local v29 = -1
local v30 = -1
local v31 = {}
local v32 = nil
local count2 = 0
local v33 = nil
local v34 = nil
local combatEncounterWavesHard2 = nil
local v35 = {}
local flag = nil
local v36 = false
local v37 = false
local total3 = 0
local v38 = nil
local flag2 = false
local total4 = 0
local total5 = 0
local v39 = nil

function DitherIn(object)
	object:__wf_atom_68f2c268(1)
	local v40 = 1

	while not __wf_atom_7e8ad928(object) and v40 > 0 do
		v40 = __wf_atom_421b01aa(v40 - __wf_atom_084b3e93() / 2, 0, 1)
		object:__wf_atom_68f2c268(__wf_atom_24a82b69(v40))
		Sleep(0)
	end
end

local function fn(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_55142dd4(__wf_atom_50a7d83e, "OnKilled")

		if count == 1 then
			object:__wf_atom_03cc4f3c(v10, position, v28 * 0.5)
		else
			__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("DitherIn"), false)
		end

		if
			not __wf_atom_7e8ad928(soulModeAttachType)
			and __wf_atom_7e8ad928(__wf_atom_50a7d83e:__wf_atom_bb3e7833(soulModeAttachType))
		then
			__wf_atom_50a7d83e:Attach(soulModeAttachType, EMPTY_SYMBOL)
		end
	end
end

local function fn2(p)
	v39 = v39 or module5.GetObjectId(v16)

	if p == -1 then
		gGameRules:__wf_atom_4ca02fbf(v39)
		module9.UntrackEntry(v39, 4)
	else
		local v40 = { tostring(killEnemiesLocText), (tostring(defeatNimrodLocText)) }
		local mNodes = { Localize(v40[p], false) }

		for _ = p + 1, #v40 do
			table.insert(mNodes, "???")
		end

		local journalEntry = SF.JournalEntry(4, v39)
		journalEntry.mEntity = v16
		journalEntry.mNodes = mNodes
		journalEntry.mName = "/SF/Language/Objectives/CollectorTaleTitle"
		journalEntry.mDesc = "/SF/Language/Objectives/CollectorTaleLongDesc"
		module9.TrackEntry(v39, 4, true)
		gGameRules:__wf_atom_d032ba30(journalEntry)
	end
end

local function fn3(object)
	local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()

	for _, v40 in ipairs(__wf_atom_6199ef01) do
		local __wf_atom_50a7d83e = v40:__wf_atom_50a7d83e()

		if
			not __wf_atom_7e8ad928(__wf_atom_50a7d83e)
			and not __wf_atom_50a7d83e:IsKilled()
			and module2.IsHeavyAgent(v40)
		then
			return true
		end
	end
end

local function fn4()
	v22 = v22 or {}

	for i = #v22, 1, -1 do
		if not (__wf_atom_7e8ad928(v22[i]) or v22[i]:IsKilled() or v22[i]:__wf_atom_a5304c35(position) <= v28 * 1.5) then
			continue
		end

		table.remove(v22, i)
	end

	local __wf_atom_57e5ac18 = gRegion:__wf_atom_57e5ac18()

	for _, v40 in ipairs(__wf_atom_57e5ac18) do
		if
			v40:IsKilled()
			or not v40:IsA(__wf_atom_9e85eea2)
			or v40:__wf_atom_e93896ba() ~= v14
			or v40:__wf_atom_464a4772()
		then
			continue
		end

		if not (v40:__wf_atom_a5304c35(position) <= v28) then
			continue
		end

		local v41 = false

		for _, v43 in ipairs(v22) do
			if v43 ~= v40 then
				continue
			end

			v41 = true
			break
		end

		if v41 then
			continue
		end

		if not __wf_atom_7e8ad928(soulModeAttachType) then
			v40:Attach(soulModeAttachType, EMPTY_SYMBOL)
		end

		__wf_atom_55142dd4(v40, "OnKilled")
		table.insert(v22, v40)
	end
end

local function fn5(p)
	if flag2 then
		for i = #v31, 1, -1 do
			if not __wf_atom_7e8ad928(v31[i]) then
				continue
			end

			table.remove(v31, i)
			v34:PlaySound(crateCollectedSound, false)
		end

		if #v31 > 0 and count > 1 then
			if v29 <= 0 then
				local v40 = v31[__wf_atom_5784a397(1, #v31)]
				table.insert(_T.CollectorIncomingObjects, v40)
				v29 = 40
				print("Added critical object to collection list")
			elseif v29 > 0 then
				v29 -= p
			end
		end

		if not __wf_atom_7e8ad928(v32) and count == #combatEncounterWavesHard2 and not v36 then
			if total3 >= 2 then
				table.insert(_T.CollectorIncomingObjects, v32)
				v36 = true
			else
				total3 += p
			end
		end
	end

	if v30 == 0 then
		for i = #v35, 1, -1 do
			if __wf_atom_7e8ad928(v35[i]) then
				table.remove(v35, i)
			end
		end

		if #v35 < 10 then
			local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v7, position, 0, v28)
			v35 = module.MergeTables(v35, __wf_atom_439c0d29, true)
		end

		if #v35 == 0 then
			return
		end

		local v40 = Vector()

		for i = #v35, 1, -1 do
			if
				not gRegion:__wf_atom_c20d246a(v18, v35[i]:GetPosition(), nil, nil, v40)
				or __wf_atom_7e8ad928(nil)
				or v35[i] == nil
			then
				continue
			end

			if v35[i]:__wf_atom_bb3e7833(v13) then
				continue
			end

			table.remove(v35, i)
		end

		for _ = 1, __wf_atom_5784a397(1, 2) do
			local v41 = __wf_atom_5784a397(1, #v35)
			local v42 = v35[v41]
			table.insert(_T.CollectorIncomingObjects, v42)
			table.remove(v35, v41)

			if #v35 == 0 then
				break
			end
		end

		v30 = __wf_atom_5784a397(20, 22)
	elseif v30 > 0 then
		v30 -= p
		v30 = math.max(v30, 0)
	end
end

local function fn6(p)
	local firstRegisteredObjectOfType = module2.GetFirstRegisteredObjectOfType(v16, overcastPostProcessVolumeType)

	if p then
		if not __wf_atom_7e8ad928(firstRegisteredObjectOfType) then
			firstRegisteredObjectOfType:Enable()
			return
		end

		local v40 = math.max(100, v16:__wf_atom_8f18e876())
		local entity = gRegion:CreateEntity(overcastPostProcessVolumeType, position, __wf_atom_80368bb1)
		entity:__wf_atom_400189c4(v40)
		v16:__wf_atom_d494454b(entity)
	elseif not __wf_atom_7e8ad928(firstRegisteredObjectOfType) then
		firstRegisteredObjectOfType:Disable()
	end
end

local function fn7(p, p2)
	total += p
	total5 += p

	if total5 < 0.1 then
		return
	end

	total5 = 0

	if __wf_atom_7e8ad928(entities) or #entities == 0 then
		entities = module2.GetRegisteredObjectsOfType(v16, beamType)

		if __wf_atom_7e8ad928(entities) or #entities == 0 then
			entities = {}

			for _ = 1, 2 do
				local entity = gRegion:CreateEntity(beamType, v18, __wf_atom_80368bb1)
				entity:__wf_atom_a64eca67(v18)
				v16:__wf_atom_d494454b(entity)
				table.insert(entities, entity)
			end
		end
	end

	if __wf_atom_7e8ad928(v25) or #v25 == 0 then
		v25 = module2.GetRegisteredObjectsOfType(v16, beamTriggerType)
	end

	local v40 = 0

	for _, v42 in ipairs({
		{ 0, 1, 2, 3 },
		{ 0, 1, 2, 3, 4 },
		{ 0, 1, 2, 3, 4, 4 }
	}) do
		if #v42 ~= #combatEncounterWavesHard2 then
			continue
		end

		v40 = v42[count] or 0
		break
	end

	local v42 = v2

	if v40 == 0 then
		v42 = v3
	end

	for i, v43 in ipairs(v42) do
		if __wf_atom_7e8ad928(entities[i]) then
			continue
		end

		local v44

		if v40 <= 1 then
			local v45 = total % v43.rotateTime * (1 / v43.rotateTime)

			if i % 2 == 0 then
				v45 = -v45
			end

			v44 = position + __wf_atom_9341614d(Vector(v43.distanceMax, 0, 0), Rotation(360 * v45, 0, 0))
		elseif v40 == 2 then
			local v45 = math.sin((total + 30) * (1 / 60) * 3.141592653589793)

			if i % 2 == 0 then
				v45 = -v45
			end

			local v46 = total % 60 * (1 / 60)
			v44 = position + __wf_atom_9341614d(Vector(v45 * 25, 0, v45 * 25), Rotation(v46 * 360, 0, 0))
		elseif v40 == 3 then
			local v45 = math.sin((total + 10) * 0.05 * 3.141592653589793)
			local v46 = __wf_atom_104bfe98(1, 0.3, (math.min(total / 20, 1)))

			if i % 2 == 0 then
				v45 = -v45
				v46 = -v46
			end

			v44 = position + Vector(v45 * 25, 0, 25 * v46)
		else
			local v45 = total % 90 * (1 / 90)
			local v46 = Rotation(v45 * 360, 0, 0)

			if i % 2 == 0 then
				local v47 = math.sin((total + 10) * 0.05 * 3.141592653589793)
				v44 = position + __wf_atom_9341614d(Vector(v47 * 25, 0, 3), v46)
			else
				local v47 = math.sin(total * 0.05 * 3.141592653589793)
				v44 = position + __wf_atom_9341614d(Vector(3, 0, v47 * 25), v46)
			end
		end

		local v45 = Vector()
		gRegion:Raycast(v44 + Vector(0, 20, 0), v44 + Vector(0, -30, 0), nil, nil, v45, true, true)
		v24[i] = v45

		if not p2 then
			if __wf_atom_7e8ad928(v25[i]) then
				v25[i] = gRegion:CreateEntity(beamTriggerType, v18, __wf_atom_80368bb1)
				v16:__wf_atom_d494454b(v25[i])
				entities[i]:__wf_atom_b2394158(v25[i], EMPTY_SYMBOL)
			end

			v25[i]:SetPosition(v45)
		end

		local v46 = __wf_atom_fa8d0177(v18 * Vector(1, 0.5, 1), v45 * Vector(1, 0.5, 1))
		entities[i]:__wf_atom_9b788a35(v46)
	end
end

local function fn8()
	for i = #v19, 1, -1 do
		if __wf_atom_7e8ad928(v19[i].obj) or not v19[i].obj:IsA(criticalItemType) then
			continue
		end

		if not __wf_atom_7e8ad928(v19[i].beam) then
			v19[i].beam:Destroy()
		end

		table.remove(v19, i)
	end
end

local function fn9(p)
	for i = #v19, 1, -1 do
		if not __wf_atom_7e8ad928(v19[i].obj) then
			continue
		end

		if not __wf_atom_7e8ad928(v19[i].beam) then
			v19[i].beam:Destroy()
		end

		if v19[i].isCritical then
			if #v31 % 2 == 0 and count < #combatEncounterWavesHard2 then
				module4.PlayRadialTransmission(v33, Symbol("CrateCollected"), position, 100)
			end

			print("Crate collected")
		end

		table.remove(v19, i)
	end

	for i = #_T.CollectorIncomingObjects, 1, -1 do
		local collectorIncomingObject = _T.CollectorIncomingObjects[i]

		if not __wf_atom_7e8ad928(collectorIncomingObject) then
			local v40 = {
				obj = collectorIncomingObject,
				startPos = collectorIncomingObject:GetPosition(),
				startRot = collectorIncomingObject:__wf_atom_dc309f8a(),
				movePct = 0,
				endOffset = __wf_atom_28d5d4aa
			}

			if collectorIncomingObject:IsA(criticalItemType) or collectorIncomingObject:IsA(bombPlantableItemType) then
				if collectorIncomingObject == v38 then
					v40.moveTime = 3
					v40.beam = gRegion:CreateEntity(pullBeamType, v18, __wf_atom_80368bb1)
					v40.endRot = __wf_atom_d919c2d7(v40.startRot, Rotation(90, 10, 10))
				else
					v40.moveTime = 12
					v40.isCritical = true
					v40.beam = gRegion:CreateEntity(pullCriticalBeamType, v18, __wf_atom_80368bb1)
					v40.endRot = __wf_atom_d919c2d7(
						v40.startRot,
						Rotation(__wf_atom_5784a397(-90, 90), __wf_atom_5784a397(-20, 20), __wf_atom_5784a397(-90, 90))
					)
				end
			elseif collectorIncomingObject:__wf_atom_db682341() == v7 then
				v40.moveTime = __wf_atom_5784a397(8, 12)
				v40.endRot = __wf_atom_d919c2d7(v40.startRot, Rotation(__wf_atom_5784a397(-90, 90), 0, 0))
				v40.endOffset = Vector(0, -3, 0)
			else
				v40.moveTime = __wf_atom_5784a397(10, 15)
				v40.endRot = __wf_atom_d919c2d7(
					v40.startRot,
					Rotation(__wf_atom_5784a397(-90, 90), __wf_atom_5784a397(-20, 20), __wf_atom_5784a397(-90, 90))
				)
				v40.beam = gRegion:CreateEntity(pullBeamType, v18, __wf_atom_80368bb1)
			end

			if not __wf_atom_7e8ad928(v40.beam) then
				v40.beam:__wf_atom_b2394158(v40.obj, EMPTY_SYMBOL)
			end

			table.insert(v19, v40)
		end

		table.remove(_T.CollectorIncomingObjects, i)
	end

	for i = #_T.CollectorRemoveObjects, 1, -1 do
		for j = #v19, -1, -1 do
			if __wf_atom_7e8ad928(v19[j]) or v19[j].obj ~= _T.CollectorRemoveObjects[i] then
				continue
			end

			if not __wf_atom_7e8ad928(v19[j].beam) then
				gRegion:__wf_atom_dd1e4d10(v19[j].beam)
			end

			if v19[j].obj:IsA(criticalItemType) or v19[j].obj:IsA(bombPlantableItemType) then
				module7.EnableSequencerAttachments(v19[j].obj, true, Symbol("ObjectiveCrateDetach"))
				local __wf_atom_9c85bbdb = v16:__wf_atom_9c85bbdb(150)

				for _, v40 in ipairs(__wf_atom_9c85bbdb) do
					module.GiveXpToPlayer(200, v40)
				end
			end

			if v19[j].movePct >= 0.1 and count < #combatEncounterWavesHard2 and v19[j].obj ~= v38 then
				module4.PlayRadialTransmission(v33, Symbol("PlayerHitFloatingCrate"), position, 100)
			end

			if v19[j].obj == v38 then
				v38 = nil
			end

			table.remove(v19, j)
		end

		table.remove(_T.CollectorRemoveObjects, i)
	end

	for _, v40 in ipairs(v19) do
		v40.movePct += p / v40.moveTime

		if not v37 and v40.movePct * v40.moveTime >= 2 and v40.isCritical and v40.obj:__wf_atom_bb3e7833(v13) then
			local v41 = WeakResource("/SF/Types/Game/Transmissions/MadaTransmission")

			if not __wf_atom_7e8ad928(v16) then
				local __wf_atom_9c85bbdb = v16:__wf_atom_9c85bbdb(150)
				module4.EmptyTransmissionQueue(__wf_atom_9c85bbdb, v41)
				module4.CloseTransmissions()
			end

			v37 = true
		end

		local v41 = v18

		if v40.obj == v38 then
			v41 = position + Vector(0, 9, 0)
		end

		local v42

		if v40.obj == v38 and v40.doneMovement then
			v42 = __wf_atom_f55d6358(v41, v41 + Vector(0, 1, 0), (math.sin(v40.movePct * 5)))
		elseif __wf_atom_7e8ad928(v40.beamId) then
			v42 = __wf_atom_f55d6358(v40.startPos, v41 + v40.endOffset, (math.min(v40.movePct ^ 2.5, 1)))
		else
			local v43 = v24[v40.beamId]
			local v44 = Vector(v43.x, v40.startPos.y, v43.z)
			v42 = __wf_atom_f55d6358(v44, v41 + v40.endOffset, (math.min(v40.movePct ^ 2.5, 1)))
		end

		local __wf_atom_80368bb1_2

		if v40.obj == v38 then
			__wf_atom_80368bb1_2 = __wf_atom_9d2f097a(v40.startRot, v40.endRot, v40.movePct)
		elseif __wf_atom_7e8ad928(v40.endRot) then
			__wf_atom_80368bb1_2 = __wf_atom_80368bb1
		else
			__wf_atom_80368bb1_2 = __wf_atom_9d2f097a(v40.startRot, v40.endRot, (math.min(v40.movePct ^ 1.8, 1)))
		end

		if not v40.doneMovement then
			local __wf_atom_d5fda8be = v40.obj:__wf_atom_d5fda8be(v41 + v40.endOffset)

			if v40.obj == v38 then
				if __wf_atom_d5fda8be <= 0.1 then
					v40.doneMovement = true
				end
			elseif __wf_atom_d5fda8be <= 2 or v40.obj:IsA(balloonType) and __wf_atom_d5fda8be <= 4 then
				v40.obj:__wf_atom_8a035cd5(Symbol("CollectObjectChildScript"), false)
				v40.doneMovement = true

				if v40.obj:__wf_atom_bb3e7833(v13) then
					flag = true
				end
			end
		end

		v40.obj:Teleport(v42, __wf_atom_80368bb1_2)
	end
end

local function fn10()
	if count == 1 then
		return position + Vector(1, 0, 1)
	end

	local v40 = Range(math.max(v28 - 10, 5), v28)
	local __wf_atom_28ce676a = v15:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, v40, 4)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(60)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("CollectorSpawnQuery"), Color("0x00FFFF"))
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v41 in ipairs(__wf_atom_ef7900cf) do
		__wf_atom_28ce676a:__wf_atom_60113517(v41:GetPosition(), 2, 0.05, 1)
	end

	local positions = module6.GetPositions(2, __wf_atom_28ce676a)

	if __wf_atom_7e8ad928(positions) or not (#positions > 0) then
		return (v15:GetRandomPointInRangeOnNav(position, 25, 35, true, 0.5))
	end

	return positions[__wf_atom_5784a397(1, #positions)]
end

local function fn11()
	print("Spawning boss")
	total = 0
	count += 1
	local enemyLevel = module2.GetEnemyLevel(v16, true)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("CollectorBossSpawn"), position, 0, v28)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for i = #__wf_atom_439c0d29, 1, -1 do
		for _, v41 in ipairs(__wf_atom_ef7900cf) do
			if not (v41:__wf_atom_8a6b8fc3(__wf_atom_439c0d29[i]) <= 5 and #__wf_atom_439c0d29 > 1) then
				continue
			end

			table.remove(__wf_atom_439c0d29, i)
			break
		end
	end

	local randomPointInRangeOnNav, v40

	if __wf_atom_7e8ad928(__wf_atom_439c0d29) or not (#__wf_atom_439c0d29 > 0) then
		randomPointInRangeOnNav = v15:GetRandomPointInRangeOnNav(position, 10, v28, true, 0.5)
		v40 = __wf_atom_fa8d0177(randomPointInRangeOnNav, position)
	else
		local v41 = __wf_atom_5784a397(1, #__wf_atom_439c0d29)
		randomPointInRangeOnNav = __wf_atom_439c0d29[v41]:GetPosition()
		v40 = __wf_atom_439c0d29[v41]:__wf_atom_dc309f8a()
	end

	v27 = v15:__wf_atom_402b3832(
		bossAgentType,
		randomPointInRangeOnNav,
		v40,
		Symbol("RandomTeam"),
		enemyLevel.maxValue,
		bossSpawnAnim
	)

	if not __wf_atom_7e8ad928(v27) then
		total2 = 25
		v27:__wf_atom_30b587a4()
		v27:__wf_atom_03cc4f3c(v10, position, v28)
		v16:__wf_atom_97f955c1(v27)
		v26 = v27:__wf_atom_50a7d83e()
		module2.RemoveMissionMarker(v16)
		module5.UpdateOrAddHudTask(v16, "Nimrod", defeatNimrodLocText)
		fn2(2)
		v30 = __wf_atom_5784a397(8, 10)
		module7.EnableAttachments(v34, true, v11, Symbol("NimrodBossMusic"))
		local __wf_atom_12d9eb4f = v17:__wf_atom_12d9eb4f()

		if not __wf_atom_7e8ad928(__wf_atom_12d9eb4f) then
			local v41 = v26:Attach(__wf_atom_12d9eb4f, EMPTY_SYMBOL)
			v16:__wf_atom_d494454b(v41)
		end

		local v41 = Symbol("BossAwarenessTrigger")
		local __wf_atom_f582136d = v26:__wf_atom_f582136d(__wf_atom_589cefdb)

		for _, v42 in ipairs(__wf_atom_f582136d) do
			if __wf_atom_7e8ad928(v42) or v42:__wf_atom_db682341() ~= v41 then
				continue
			end

			v42:Enable()
		end

		print("Boss spawned")
	end
end

local function fn12()
	if __wf_atom_7e8ad928(v16) then
		print("Early out, streaming during boss dialog")
		return true
	end

	local v40 = __wf_atom_03df4e1d()
	fn7(v40)
	fn9(v40)
end

local function fn13(p)
	if #combatEncounterWavesHard2 == 0 then
		return
	end

	total2 += p
	total4 += p

	if total4 < 1 then
		return
	end

	total4 = 0

	if __wf_atom_7e8ad928(v26) then
		if count < #combatEncounterWavesHard2 then
			if count <= 1 then
				fn4()
			end

			if
				(__wf_atom_7e8ad928(v20) or v20:__wf_atom_3634e6d2() <= 1 and not fn3(v20))
				and (count ~= 1 or count == 1 and #v22 == 0)
				and total2 >= 5
			then
				count += 1
				total = 0
				print("New enemy wave: " .. count)
				local enemyLevel = module2.GetEnemyLevel(v16, true)
				local v40 = (count - 1) / (#combatEncounterWavesHard2 - 1)
				local v41 = math.ceil((__wf_atom_104bfe98(enemyLevel.minValue, enemyLevel.maxValue, v40)))
				v16:__wf_atom_252fae6e(v41)

				if not __wf_atom_7e8ad928(combatEncounterWavesHard2[count]) then
					local v42 = fn10()
					v15:AddEncounter(combatEncounterWavesHard2[count])
					v20 = v15:__wf_atom_c4c644af(v42, combatEncounterWavesHard2[count], v16)

					if not __wf_atom_7e8ad928(v20) then
						v20:__wf_atom_c361f7f8(fn, Symbol("WaveEnemyRegister"))
						v30 = math.max(v30, 10)
						v29 = math.max(v29, __wf_atom_5784a397(5, 7))
						total2 = 0

						if count == math.ceil(#combatEncounterWavesHard2 / 2) then
							module4.PlayRadialTransmission(v33, Symbol("EnemyWave" .. count), position, 100)
						end
					end
				end

				if count == #combatEncounterWavesHard2 - 1 then
					module7.EnableSequencerAttachments(v34, true, Symbol("CollectorStageTwoStinger"))
				elseif count == #combatEncounterWavesHard2 then
					module7.EnableSequencerAttachments(v34, true, Symbol("CollectorStageThreeStinger"))
				end
			end
		elseif not __wf_atom_7e8ad928(bossAgentType) and not flag and __wf_atom_7e8ad928(v20) then
			if not (total2 >= 5) then
				total2 += p
				return
			end

			print("Spawn boss transmission started")
			module5.CompleteHudTask(v16, nil, "Enemies")
			module5.RemoveHudTask(v16, nil, "Enemies", 4)
			local v40 = WeakResource("/SF/Types/Game/Transmissions/MadaTransmission")

			if not __wf_atom_7e8ad928(v16) then
				local __wf_atom_9c85bbdb = v16:__wf_atom_9c85bbdb(150)
				module4.EmptyTransmissionQueue(__wf_atom_9c85bbdb, v40)
				module4.CloseTransmissions()
			end

			module4.PlayRadialTransmission(v33, Symbol("NimrodBoss"), position, 100)
			fn8()
			module4.WaitForTransmissions(false, fn12)

			if __wf_atom_7e8ad928(v16) then
				print("Shutdown due to streaming (waited for boss dialog)")
				return
			end

			fn11()
			v29 = math.max(v29, 15)
		end
	elseif
		(not __wf_atom_7e8ad928(v26) or __wf_atom_7e8ad928(bossAgentType) and count >= #combatEncounterWavesHard2)
		and __wf_atom_7e8ad928(v21)
		and count2 < 10
	then
		if total2 >= 30 then
			print("Spawning boss adds wave")
			local v40 = fn10()
			v15:AddEncounter(bossAddsEncounter)
			v21 = v15:__wf_atom_c4c644af(v40, bossAddsEncounter, v16)
			v21:__wf_atom_c361f7f8(fn, Symbol("WaveEnemyRegister"))
			total2 = 0
			count2 += 1
		else
			total2 += p
		end
	end
end

local function fn14(p, p2, p3)
	local __wf_atom_28ce676a = v15:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, p2, 2.5)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(p3)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
	__wf_atom_28ce676a:__wf_atom_2b700733(v18, 1, 2, 0.1)
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("CollectorObjects"), Color("0x00FFFF"))
	return (module6.GetPositions(p, __wf_atom_28ce676a))
end

local function fn15()
	print("Spawning collection")
	local v40 = false
	local count3 = 0
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("OdeCartSpawn"), position, 0, v28)

	if #__wf_atom_439c0d29 > 0 then
		for _ = 1, math.min(#__wf_atom_439c0d29, __wf_atom_5784a397(2, 3)) do
			local v41 = __wf_atom_5784a397(1, #__wf_atom_439c0d29)
			local entity = gRegion:CreateEntity(
				collectorCartType,
				__wf_atom_439c0d29[v41]:GetPosition(),
				__wf_atom_439c0d29[v41]:__wf_atom_dc309f8a()
			)
			v16:__wf_atom_d494454b(entity)
			__wf_atom_439c0d29[v41]:FirePort("Disable")
			table.remove(__wf_atom_439c0d29, v41)
		end

		Sleep(0)
	end

	if not (__wf_atom_7e8ad928(bombPlantableItemType) or module2.IsHardModeActive()) then
		local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(v8, position, 0, v28)

		if #__wf_atom_439c0d29_2 > 0 then
			local v41 = __wf_atom_5784a397(1, #__wf_atom_439c0d29_2)
			local position3 = __wf_atom_439c0d29_2[v41]:GetPosition()
			local __wf_atom_dc309f8a = __wf_atom_439c0d29_2[v41]:__wf_atom_dc309f8a()
			local entity = gRegion:CreateEntity(bombPlantableItemType, position3, __wf_atom_dc309f8a)
			v16:__wf_atom_d494454b(entity)
			__wf_atom_439c0d29_2[v41]:FirePort("Disable")
			v40 = true
		end
	end

	local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(v9, position, 0, v28)

	if #__wf_atom_439c0d29_2 > 0 then
		for _ = 1, math.min(5, #__wf_atom_439c0d29_2 + 1) - 1 do
			if not (#__wf_atom_439c0d29_2 > 0) then
				continue
			end

			local v41 = __wf_atom_5784a397(1, #__wf_atom_439c0d29_2)
			local position3 = __wf_atom_439c0d29_2[v41]:GetPosition()
			local __wf_atom_dc309f8a = __wf_atom_439c0d29_2[v41]:__wf_atom_dc309f8a()
			__wf_atom_439c0d29_2[v41]:FirePort("Disable")
			table.remove(__wf_atom_439c0d29_2, v41)
			local entity = gRegion:CreateEntity(criticalItemType, position3, __wf_atom_dc309f8a)
			v16:__wf_atom_d494454b(entity)
			count3 += 1
		end
	end

	local v41 = Range(3, 18)
	local v42 = fn14(17, Range(3, v28 - 5), 20)

	if not (v40 or __wf_atom_7e8ad928(bombPlantableItemType) or module2.IsHardModeActive()) then
		if #v42 > 0 then
			local v43 = __wf_atom_5784a397(1, #v42)
			local v44 = v42[v43]
			table.remove(v42, v43)
			local groundAlignedSpawnPosRot, v45 = module3.GetGroundAlignedSpawnPosRot(
				criticalItemType,
				v44,
				Rotation(__wf_atom_5784a397(0, 360), 0, 0),
				true,
				30
			)
			local v46 = groundAlignedSpawnPosRot or v44
			local v47 = v45 or __wf_atom_80368bb1
			local v48 = __wf_atom_d919c2d7(v47, __wf_atom_fa8d0177(v46, position))
			local entity = gRegion:CreateEntity(bombPlantableItemType, v46, v48)
			v16:__wf_atom_d494454b(entity)
		else
			print("Nowhere for the bomb cage to spawn here")
		end
	end

	if count3 < 5 then
		for _ = 1, 5 - count3 - 1 do
			local v43

			if #v42 > 0 then
				local v44 = __wf_atom_5784a397(1, #v42)
				v43 = v42[v44]
				table.remove(v42, v44)
			else
				local randomPointInRange = module.GetRandomPointInRange(position, v41.minValue, v41.maxValue)
				v43 = v15:__wf_atom_0e0a6fee(randomPointInRange)
			end

			local groundAlignedSpawnPosRot, v44 = module3.GetGroundAlignedSpawnPosRot(
				criticalItemType,
				v43,
				Rotation(__wf_atom_5784a397(0, 360), 0, 0),
				true,
				30
			)
			local v45 = v44 or __wf_atom_80368bb1
			local v46 = __wf_atom_d919c2d7(v45, Rotation(__wf_atom_5784a397(0, 360), 0, 0))
			local entity = gRegion:CreateEntity(criticalItemType, groundAlignedSpawnPosRot or v43, v46)
			v16:__wf_atom_d494454b(entity)
		end

		local groundAlignedSpawnPosRot, _ = module3.GetGroundAlignedSpawnPosRot(
			criticalItemType,
			position,
			Rotation(__wf_atom_5784a397(0, 360), 0, 0),
			false,
			30
		)

		if __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
			groundAlignedSpawnPosRot = position + Vector(0, 2, 0)
		end

		local entity = gRegion:CreateEntity(criticalItemType, groundAlignedSpawnPosRot, __wf_atom_80368bb1)
		local __wf_atom_e919fb8e = entity:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.introCrate = true
		v16:__wf_atom_d494454b(entity)
	end

	if not __wf_atom_7e8ad928(balloonType) then
		for _ = 1, __wf_atom_5784a397(3, 5) do
			local randomPointInRange = module.GetRandomPointInRange(position, 5, 20)
			local groundPos = module3.GetGroundPos(randomPointInRange)
			local v43 = Vector(groundPos.x, v18.y - 15, groundPos.z)
			local v44 = __wf_atom_f55d6358(groundPos + Vector(0, 2.5, 0), v43, math.random())
			local entity = gRegion:CreateEntity(balloonType, v44, Rotation(__wf_atom_5784a397(0, 360), 0, 0))
			v16:__wf_atom_d494454b(entity)
			entity:__wf_atom_8a035cd5(Symbol("BalloonChildScript"), false)
		end
	end

	if #randomGroundItemTypes > 0 then
		for _ = 1, 12 do
			local randomGroundItemType = randomGroundItemTypes[__wf_atom_5784a397(1, #randomGroundItemTypes)]

			if __wf_atom_7e8ad928(randomGroundItemType) then
				continue
			end

			local v43

			if #v42 > 0 then
				local v44 = __wf_atom_5784a397(1, #v42)
				v43 = v42[v44]
				table.remove(v42, v44)
			else
				local randomPointInRange = module.GetRandomPointInRange(position, 5, 15)
				v43 = v15:__wf_atom_0e0a6fee(randomPointInRange)
			end

			local groundAlignedSpawnPosRot, v44 = module3.GetGroundAlignedSpawnPosRot(
				randomGroundItemType,
				v43,
				Rotation(__wf_atom_5784a397(0, 360), 0, 0),
				true,
				v28
			)

			if __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
				continue
			end

			local v45 = __wf_atom_d919c2d7(v44, Rotation(__wf_atom_5784a397(0, 360), 0, 0))
			local entity = gRegion:CreateEntity(randomGroundItemType, groundAlignedSpawnPosRot, v45)
			v16:__wf_atom_d494454b(entity)
		end
	end

	if not __wf_atom_7e8ad928(dynamicCombatBlockingContainerHintType) then
		local entity = gRegion:CreateEntity(dynamicCombatBlockingContainerHintType, position, __wf_atom_80368bb1)
		v15:__wf_atom_ccbb5582(entity)
		v16:__wf_atom_d494454b(entity)
	end

	print("Collection spawned")
end

local function fn16()
	v35 = {}

	for _, v40 in ipairs(randomGroundItemTypes) do
		local registeredObjectsOfType = module2.GetRegisteredObjectsOfType(v16, v40)
		v35 = module.MergeTables(v35, registeredObjectsOfType)
	end

	local __wf_atom_a56d7910 = gRegion:__wf_atom_a56d7910(position, v28, additionalTypesToDetect)

	for i = #__wf_atom_a56d7910, 1, -1 do
		if not __wf_atom_7e8ad928(__wf_atom_a56d7910[i]:__wf_atom_3d96ddcd()) then
			table.remove(__wf_atom_a56d7910, i)
		end
	end

	v35 = module.MergeTables(v35, __wf_atom_a56d7910, true)
end

local function fn17(p)
	print("Shutdown collector")

	if __wf_atom_7e8ad928(v16) then
		print("Shutdown due to streaming (ShutdownCollector)")
		return
	end

	_T.DevModeCollectorInfo = nil
	local v40

	if flag then
		v40 = gRegion:__wf_atom_0a6a5887(v6)
		module7.EnableSequencerAttachments(v34, false, Symbol("CollectorMachineLoop"))
		local __wf_atom_bb3e7833 = v34:__wf_atom_bb3e7833(collectorAttachFx)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	else
		v40 = gRegion:__wf_atom_0a6a5887(v5)
	end

	local __wf_atom_4a0ffa6e = v16:__wf_atom_4a0ffa6e()
	local v41 = false

	while not __wf_atom_7e8ad928(v16) and v16:__wf_atom_b3bb0c43(__wf_atom_4a0ffa6e) > 0 do
		if not (v41 or __wf_atom_7e8ad928(v40) or v40:__wf_atom_7d4910e4()) then
			fn6(false)
			v41 = true
		end

		Sleep(0)
	end

	if __wf_atom_7e8ad928(v16) then
		print("Shutdown due to streaming (Waited for players during shutdown)")
		return
	end

	if not (p or __wf_atom_7e8ad928(v20)) then
		v20:__wf_atom_8e6fec76(6)
	end

	while not __wf_atom_7e8ad928(v40) and v40:__wf_atom_7d4910e4() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v16) then
		print("Shutdown due to streaming (Waited for cinematic during shutdown)")
		return
	end

	if not v41 then
		fn6(false)
	end

	if not (__wf_atom_7e8ad928(v34) or flag) then
		v34:SetVisibility(false)
	end

	module2.RemoveAgents(v16)
	module2.RemoveObjects(v16, v9, true)
	module2.RemoveObjects(v16, v8, true)
	print("Shutdown collector done")
end

function OnPrimed(object)
	print("OnPrimed: Collector primed")
	module.WaitForLevel()
	module.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Streaming at start of OnPrimed")
		return
	end

	local v40 = object:__wf_atom_4026dfb5() > 0
	position = object:GetPosition()
	v16 = object
	v15 = module.WaitForAiDir()
	position2 = object:GetPosition() + v
	v34 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorShip"))

	if __wf_atom_7e8ad928(v34) then
		print("Ship not in area")
		return
	end

	local all = gRegion:FindAll(
		WeakResource("/SF/Types/Game/Encounters/CombatEncounterHint"),
		object:GetPosition(),
		0,
		80
	)

	for _, v41 in ipairs(all) do
		v41:Disable()
	end

	v28 = v16:__wf_atom_103377cc()
	v18 = position2 + v12 + Vector(0, -5, 0)
	_T.CollectorIncomingObjects = {}

	if __wf_atom_7e8ad928((v34:__wf_atom_bb3e7833(collectorAttachFx))) then
		v34:Attach(collectorAttachFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("ShipWp"), position, 0, 100)
	local v41

	if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		v41 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
	else
		position2 = __wf_atom_f738b4af:GetPosition()
		v41 = __wf_atom_f738b4af:__wf_atom_dc309f8a()
	end

	v34:SetVisibility(false)
	v34:Teleport(position2, v41)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v4)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v5)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(v6)

	if not v40 then
		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			__wf_atom_0a6a5887:Teleport(position2, v41)
			__wf_atom_0a6a5887_2:Teleport(position2, v41)
			__wf_atom_0a6a5887_3:Teleport(position2, v41)
			Sleep(0.1)

			if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_7e8ad928(v34) then
				print("Streaming in OnPrimed collector cin startup")
				return
			else
				__wf_atom_0a6a5887:FirePort("StartPlaying")
				v34:SetVisibility(true)
			end
		end

		local v42 = v34:Attach(collectorLightType, EMPTY_SYMBOL, Vector(0, -0.5, 0), Rotation(0, 90, 0))
		v16:__wf_atom_d494454b(v42)
		fn15()
	end

	print("OnPrimed: Initial setup done")
	Sleep(1)
	local total6 = 0

	while
		not __wf_atom_7e8ad928(v16) and v16:__wf_atom_5b6b447d() ~= EMPTY_SYMBOL and v16:__wf_atom_4026dfb5() < 2
		or not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4()
	do
		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_7d4910e4()) then
			fn7(__wf_atom_03df4e1d(), true)
		end

		total6 += __wf_atom_03df4e1d()

		if total6 >= 900 then
			v16:__wf_atom_75628d88(EMPTY_SYMBOL)
			break
		else
			Sleep(0)
		end
	end

	print("OnPrimed Loop ended")

	if not __wf_atom_7e8ad928(v16) and v16:__wf_atom_4026dfb5() < 1 and v16:__wf_atom_5b6b447d() == EMPTY_SYMBOL then
		print("OnPrimed: hint was unprimed and never activated")
		module.DestroyObjectList(v25)
		module.DestroyObjectList(entities)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:FirePort("StartPlaying")
		end

		_T.SetCollectorAccountTimer = true
		fn17(true)
		print("OnPrimed: Players left the area, cleaned up all objects")
	end
end

function Main(object)
	print("Collector encounter started")

	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	v15 = module.WaitForAiDir()
	v16 = object:__wf_atom_26b04ea9()
	v17 = object:__wf_atom_dd85e6db()
	v33 = v17:__wf_atom_d0c8d09f()
	position = object:GetPosition()
	position2 = position + v
	v18 = position2 + v12 + Vector(0, -5, 0)
	v28 = v16:__wf_atom_103377cc()
	combatEncounterWavesHard2 = combatEncounterWavesHard
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v4)
	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v5)
	local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(v6)
	local v40 = false
	local total6 = 0
	local v41 = false
	local v42 = false
	local v43 = false
	_T.CollectorIncomingObjects = {}
	_T.CollectorRemoveObjects = {}

	if __wf_atom_7e8ad928(v16) then
		v16 = object
	end

	if object:__wf_atom_4026dfb5() <= 1 then
		object:__wf_atom_8e6fec76(1)
		v16:__wf_atom_8e6fec76(1)
		_T.NimrodSkyCleared = nil
		fn13(999)
		module.StartPluginScripts({ rewardScreenScriptTrigger }, object)
	end

	while #v31 == 0 do
		Sleep(1)
		v31 = gRegion:__wf_atom_439c0d29(Symbol("CollectorCrate"), position, 0, v28 + 10)
	end

	for i, v44 in ipairs(v31) do
		if not (v44:__wf_atom_e919fb8e().introCrate or i == #v31) then
			continue
		end

		v38 = v44
		table.insert(_T.CollectorIncomingObjects, v38)
		break
	end

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to streaming (Waited for mCriticalItems)")
		return
	end

	_T.PlantBombHint = v16
	v32 = gRegion:__wf_atom_f738b4af(Symbol("BombPlantableItem"), position, 0, v28 + 10)
	v34 = gRegion:__wf_atom_0a6a5887(Symbol("CollectorShip"))
	fn16()
	local __wf_atom_e529dedd = v16:__wf_atom_e529dedd()

	for _, v44 in ipairs(__wf_atom_e529dedd) do
		if v44 ~= object then
			v20 = v44
		end
	end

	print("Setup completed")

	if object:__wf_atom_4026dfb5() <= 2 then
		object:__wf_atom_8e6fec76(2)
		v16:__wf_atom_8e6fec76(2)
	end

	local __wf_atom_4a0ffa6e = v16:__wf_atom_4a0ffa6e()
	local c_str = v17:__wf_atom_4f3855f9():c_str()
	local v44 = nil

	while not module2.PrimedMissionShouldShutDown(object, v16, nil, nil, true) and __wf_atom_7e8ad928(v44) do
		local v45 = __wf_atom_03df4e1d()

		if flag2 then
			if not v23 and v40 and count == 1 and v16:__wf_atom_b3bb0c43(v28) > 0 then
				print("Enemies alerted")

				if not __wf_atom_7e8ad928(v20) and v20:__wf_atom_4026dfb5() == 2 then
					module2.AlertEnemies(v20)
				end

				v23 = true
				module7.EnableAttachments(v34, true, v11, Symbol("HeavyCombatMusic"))
			end

			if not v43 then
				if total6 >= 10 then
					module5.AddHudTitle(v16, nil, c_str)
					module5.UpdateOrAddHudTask(v16, "Enemies", killEnemiesLocText)
					fn2(1)
					v43 = true
				else
					total6 += v45
				end
			end
		elseif v38 == nil then
			if total6 >= 2 then
				if not (v40 or __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_7d4910e4()) then
					module7.EnableSequencerAttachments(v34, true, Symbol("CollectorEncounterStartStinger"))
					module4.PlayRadialTransmission(v33, Symbol("CollectorDocking"), position, 100)
					v30 = 5
					local v46 = v34:Attach(tetherAttachType, EMPTY_SYMBOL, v12)
					v16:__wf_atom_d494454b(v46)
					local __wf_atom_9c85bbdb = v16:__wf_atom_9c85bbdb(150)
					v40 = true

					for _, v47 in ipairs(__wf_atom_9c85bbdb) do
						if __wf_atom_7e8ad928(v47) then
							continue
						end

						local __wf_atom_a96eb2aa = v47:__wf_atom_a96eb2aa()

						if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
							gGameRules:__wf_atom_6680e8ba(
								__wf_atom_a96eb2aa,
								introNotificationMovie,
								"PolluterStart",
								{ c_str, (tostring(8)) },
								8,
								"PolluterStart",
								true
							)
						end
					end

					flag2 = true
				end
			else
				total6 += v45
			end
		end

		local __wf_atom_b3bb0c43 = v16:__wf_atom_b3bb0c43(__wf_atom_4a0ffa6e)

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_7d4910e4()) then
			fn9(v45)
			fn7(v45)

			if flag2 then
				fn5(v45)
				fn13(v45)

				if not (v41 or _T.NimrodSkyCleared) then
					fn6(true)
					v41 = true
				end
			end
		end

		if v42 or not (__wf_atom_b3bb0c43 > 0) then
			if v42 and __wf_atom_b3bb0c43 == 0 then
				module5.UpdateVisibility(false)
				v42 = false
			end
		else
			module5.UpdateVisibility(true)
			v42 = true
		end

		if not __wf_atom_7e8ad928(v26) and v26:IsKilled() then
			print("Nimrod was killed")
			module5.CompleteHudTask(v16, nil, "Nimrod")
			v44 = 4
		end

		v44 = flag and 4 or v44
		Sleep(0)
	end

	print("Collector encounter ending...")
	_T.SetCollectorAccountTimer = true
	Sleep(2)
	fn2(-1)

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to streaming (Ended)")
		return
	end

	fn8()

	for _, v45 in ipairs(v31) do
		if not __wf_atom_7e8ad928(v45) then
			v45:__wf_atom_8a035cd5(Symbol("FinaleChildScript"), false)
		end
	end

	module.DestroyObjectList(v25)
	module.DestroyObjectList(entities)

	if flag then
		__wf_atom_0a6a5887_2 = __wf_atom_0a6a5887_3
	elseif v44 == 4 then
		module5.CompleteHudTask(v16)
		module4.PlayRadialTransmission(v33, Symbol("MissionSuccess"), position, 100)
		module7.EnableAttachments(v34, false, v11, Symbol("HeavyCombatMusic"))
		module7.EnableAttachments(v34, false, v11, Symbol("NimrodBossMusic"))
	end

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		__wf_atom_0a6a5887_2:FirePort("StartPlaying")
		print("playing collectorCinLeaving")

		if flag and not __wf_atom_7e8ad928(v34) then
			v34:Attach(collectorShipExplosionFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end

		Sleep(8)
	end

	local v45 = WeakResource("/SF/Types/Game/Transmissions/MadaTransmission")

	if not __wf_atom_7e8ad928(v16) then
		local __wf_atom_9c85bbdb = v16:__wf_atom_9c85bbdb(150)
		module4.EmptyTransmissionQueue(__wf_atom_9c85bbdb, v45)
		module4.CloseTransmissions()
	end

	if v44 == 4 or v44 == 5 then
		if v44 == 4 then
			print("Succeeded")
			module8.NotifyTagAllPlayers(Symbol("COLLECTOR_SUCCESS"))
		else
			print("Failed")
			module8.NotifyTagAllPlayers(Symbol("COLLECTOR_FAILURE"))
			module4.PlayRadialTransmission(v33, Symbol("MissionFailed"), position, 100)

			if __wf_atom_7e8ad928(object) then
				print("Shutdown due to streaming (MissionFailed)")
				return
			end

			if not __wf_atom_7e8ad928(v26) then
				v26:__wf_atom_921c1a5f(bossRetreatAnim, true, 3, 1, true)

				if not __wf_atom_7e8ad928(v26) then
					v26:Destroy()
				end
			end

			module4.WaitForTransmissions()
			_T.ShowImpactMessage("/SF/Language/Objectives/CollectorTaleFailed", 5)
		end

		if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(v16) then
			print("Shutdown due to streaming (Completed or Failed)")
			return
		end

		object:__wf_atom_8e6fec76(v44)
		v16:__wf_atom_8e6fec76(v44)
		module5.RemoveHudGroup(v16)
	else
		print("Shutdown")
		module5.RemoveHudGroup(v16)

		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_8e6fec76(6)
		end

		if not __wf_atom_7e8ad928(v16) then
			v16:__wf_atom_8e6fec76(6)
		end
	end

	print("Collector encounter ended")
	fn17()
	print("Collector shutdown complete")
end

function OnKilled(object)
	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(soulModeAttachType)) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(soulModeAttachType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function EnergyDrainBeamTrigger(object)
	local __wf_atom_6f4fd712 = object:__wf_atom_6f4fd712()
	local v40 = WeakResource("/SF/Types/Player/EnvoyAvatar")
	local damageData = Engine.DamageData()
	damageData.baseAmount = 30
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_d6f4d914(5, true)
	damageData:__wf_atom_d6f4d914(17, true)
	damageData:__wf_atom_8e0ba0ec(-3)

	for _, v41 in ipairs(__wf_atom_6f4fd712) do
		if __wf_atom_7e8ad928(v41) or v41:IsKilled() or not v41:IsA(v40) or module.IsInNightFold(v41) then
			continue
		end

		v41:__wf_atom_649bf33e(damageData)
	end
end

function CollectorItemSoulStealEntity(_) end

function CollectorItemOnDamaged(object)
	if object:__wf_atom_bb3e7833(v13) then
		return
	end

	if __wf_atom_7e8ad928(_T.CollectorRemoveObjects) then
		_T.CollectorRemoveObjects = {}
	end

	local v40 = false

	for _, collectorRemoveObject in ipairs(_T.CollectorRemoveObjects) do
		if collectorRemoveObject == object then
			v40 = true
		end
	end

	if not v40 then
		table.insert(_T.CollectorRemoveObjects, object)
	end
end

function BalloonChildScript(object)
	local position3 = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local groundPos = module3.GetGroundPos(position3, __wf_atom_28d5d4aa, Vector(0, -30, 0))
	local v40 = Distance(groundPos, position3)
	local v41 = v40 * 1 - math.random() * (v40 / 3)

	if v41 <= 0 then
		return
	end

	object:Teleport(groundPos, __wf_atom_dc309f8a)
	local total6 = 0

	while not __wf_atom_7e8ad928(object) and total6 <= v41 do
		object:Teleport(__wf_atom_f55d6358(groundPos, position3, (total6 / v41) ^ 0.25), __wf_atom_dc309f8a)
		total6 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:Teleport(position3, __wf_atom_dc309f8a)
	end
end

function FinaleChildScript(instance)
	local v40 = __wf_atom_104bfe98(9, 10, math.random())
	local position3 = instance:GetPosition()
	local __wf_atom_dc309f8a = instance:__wf_atom_dc309f8a()
	local v41 = position3 + Vector(0, v40, 0)
	local v42 = Rotation(__wf_atom_5784a397(0, 360), __wf_atom_5784a397(0, 360), __wf_atom_5784a397(0, 360))
	local _ = Distance(position3, v41) * (1 / __wf_atom_104bfe98(0.9, 1.1, math.random()))
	local v43 = __wf_atom_104bfe98(4, 5, math.random())
	local total6 = 0

	while not __wf_atom_7e8ad928(instance) and total6 <= v43 do
		local v44 = (total6 / v43) ^ 0.5
		instance:Teleport(__wf_atom_f55d6358(position3, v41, v44), __wf_atom_9d2f097a(__wf_atom_dc309f8a, v42, v44))
		total6 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function CollectObjectChildScript(object)
	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()
	object:__wf_atom_0ed81088(false)
	local total6 = 0

	while not __wf_atom_7e8ad928(object) and total6 <= 0.6 do
		object:SetMeshScale(__wf_atom_104bfe98(__wf_atom_c082fc3d, 0.01, total6 / 0.6))
		total6 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		gRegion:__wf_atom_dd1e4d10(object)
	end
end

function TempPotionAction(object, object2)
	if
		__wf_atom_7e8ad928(potionDeco)
		or object2 ~= gRegion:__wf_atom_c4f78a8f()
		or (__wf_atom_7e8ad928(object2) or object2:IsKilled())
	then
		return
	end

	object2:__wf_atom_d2b2176d():Unequip(0, 0)
	object2:__wf_atom_aeb02c14(inputFilter)
	local position3 = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local total6 = 0

	while total6 <= 0.6 do
		object2:Teleport(
			__wf_atom_f55d6358(object2:GetPosition(), position3, (math.min(total6 / 0.6, 1))),
			(__wf_atom_9d2f097a(object2:__wf_atom_2f2bada0(), __wf_atom_dc309f8a, (math.min(total6 / 0.6, 1))))
		)
		total6 += __wf_atom_084b3e93()
		Sleep(0)
	end

	Sleep(0.5)
	object2:Teleport(object:GetPosition(), object:__wf_atom_dc309f8a())
	object2:__wf_atom_921c1a5f(anim, false, 2, 1, true)
	Sleep(1.2)
	object2:GiveItem(elixirType, false)

	if gGameData:__wf_atom_a4299765() then
		local __wf_atom_6b29f1ed = gGameData:__wf_atom_a4299765():__wf_atom_6b29f1ed()
		local v40 = false

		for _, v41 in ipairs(__wf_atom_6b29f1ed) do
			if v41.mItemType == elixirType then
				v40 = true
			end
		end

		if not v40 then
			gGameData:__wf_atom_a6b3ae2b(elixirType)
		end
	end

	potionDeco:AttachToInPlace(object2, Symbol("GAME_R1_WEAPON1"))
	Sleep(2.495)
	gRegion:__wf_atom_dd1e4d10(potionDeco)
	object2:__wf_atom_cf966a74(inputFilter)
	object:Disable()
end

function AttachBombAction(object, _)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local v40 = Vector(0, 1.5, 0)
	__wf_atom_3d96ddcd:Attach(explosivesDeco, EMPTY_SYMBOL, v40)
	object:Disable()

	if not __wf_atom_7e8ad928(_T.PlantBombHint) then
		module5.CompleteHudTask(_T.PlantBombHint, nil, "PlantBomb")
		_T.PlantBombHint = nil
	end
end