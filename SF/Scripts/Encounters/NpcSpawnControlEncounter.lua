local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local v = nil
local position = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local count = 0

function OnKilled(object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_3193e389():Disable()
	end
end

function OnSpawn(object)
	local __wf_atom_08228110 = object:__wf_atom_08228110()

	if not __wf_atom_7e8ad928(__wf_atom_08228110) then
		local __wf_atom_30e3d82b = __wf_atom_08228110:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			v2:__wf_atom_97f955c1(__wf_atom_30e3d82b)
			__wf_atom_55142dd4(__wf_atom_08228110, "OnKilled")

			if not __wf_atom_7e8ad928(spawnFx) then
				local position2 = object:GetPosition()
				local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
				local v6

				if __wf_atom_7e8ad928((Resource(spawnFx):__wf_atom_b6b760b5())) then
					v6 = module3.GetGroundPos(position2)
				else
					v6, __wf_atom_dc309f8a = module3.GetGroundAlignedSpawnPosRot(spawnFx, position2, __wf_atom_dc309f8a)
				end

				local entity = gRegion:CreateEntity(spawnFx, v6, __wf_atom_dc309f8a)
				v2:__wf_atom_d494454b(entity)
			end

			count += 1
		end
	end
end

local function fn(object)
	v = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	local _spawnFx = spawnFx
	position = object:GetPosition()
	v2 = object
	v2:__wf_atom_8e6fec76(1)
	local pointInstances = module.FindPointInstances(v2, __wf_atom_96b9d246)

	if __wf_atom_7e8ad928(pointInstances) or #pointInstances == 0 then
		return false
	end

	v4 = pointInstances[1]
	local enemyLevel = module.GetEnemyLevel(object)
	local __wf_atom_dcc0a6f8 = v4:__wf_atom_dcc0a6f8()

	for i, v6 in ipairs(__wf_atom_dcc0a6f8) do
		__wf_atom_55142dd4(v6, "OnSpawn")
		v6:__wf_atom_3a8cdb40((math.floor((__wf_atom_104bfe98(
			enemyLevel.minValue,
			enemyLevel.maxValue,
			i / #__wf_atom_dcc0a6f8
		)))))
	end

	v5 = v4:__wf_atom_1d28ac91()
	count = 0

	if autoStartSpawnControl then
		v4:Reset()
	end

	v3 = v2:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(v2, v3)
	v2:__wf_atom_2cc8420c(v2:__wf_atom_dd85e6db())
	return true
end

local function fn2()
	if __wf_atom_7e8ad928(v2) then
		print("Shutdown due to level streaming")
		return
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Stop()
	end

	if v2:__wf_atom_3634e6d2() == 0 and v5 <= count then
		v2:__wf_atom_050639fe()
		v2:__wf_atom_8776856a(0)
		v2:__wf_atom_8e6fec76(4)

		if module2.IsInOverworld() then
			while not __wf_atom_7e8ad928(v2) and v2:__wf_atom_e464a32f() > 0 and v:__wf_atom_c6f505f2(v2) > 0 do
				Sleep(0)
			end
		end

		if diableHintWhenComplete then
			v2:Disable()
		end
	else
		v2:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(v2) then
		print("Shutdown due to level streaming")
		return
	end

	while not __wf_atom_7e8ad928(v2) and v2:__wf_atom_e464a32f() > 0 and v:__wf_atom_c6f505f2(v2) > 0 do
		Sleep(1)
	end

	module.RemoveAgents(v2)
	module.RemoveObjects(v2)
	Sleep(0)
end

function NpcSpawnControlEncounter(object)
	if not fn(object) then
		object:__wf_atom_8e6fec76(6)
		return
	end

	object:__wf_atom_8e6fec76(2)

	while not module.ShouldShutDown(v2) and (count < v5 or v2:__wf_atom_3634e6d2() > 0) do
		v3 = v2:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(v2, v3)
		Sleep(1)
	end

	fn2()
end