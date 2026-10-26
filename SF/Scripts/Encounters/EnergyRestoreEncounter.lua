WeakResource("/SF/Types/Gameplay/EnergyWellRestorePower")
local v = Symbol("FireSource")
Symbol("ForestSpawnVolume")
local v2 = { WeakResource("/SF/Fx/Environment/Fire/TorchFireSourceDeco") }
local _ = { red = Color(255, 0, 0), green = Color(0, 255, 0), blue = Color(0, 128, 255) }
local v3 = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Interface.SFUtilities")
local module2 = require("SF.Scripts.Libs.EncounterLib")
require("Lotus.Scripts.Libs.SpawnObjectsOnTerrain")
require("EE.Interface.Utilities")

local function fn(position, list, p)
	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(__wf_atom_8e4fda44) then
		return nil
	end

	if not __wf_atom_7e8ad928(list) and #list > 0 then
		for i = #list, 1, -1 do
			if __wf_atom_7e8ad928(list[i]) then
				table.remove(list, i)
			end
		end

		local nearestObject = module.NearestObject(position, list, 20, false, true)

		if
			nearestObject ~= nil
			and (p or __wf_atom_7e8ad928(gRegion:__wf_atom_439c0d29(
				Symbol("EnergyRestore"),
				list[nearestObject]:GetPosition(),
				0,
				2
			)))
		then
			local v4 = false

			for _, className in ipairs(v2) do
				if not list[nearestObject]:IsA(className) then
					continue
				end

				v4 = true
				break
			end

			local position2

			if v4 or not (math.random() <= 0.5) then
				local v5 = Vector(math.random() * 2, 0, 0)
				local _ = position + __wf_atom_9341614d(
					v5,
					Rotation(math.random() * 360, math.random() * 360, math.random() * 360)
				)
				position2 = v3:__wf_atom_0e0a6fee(position)
				local v6 = math.random() * (position.y + 1.5 - position2.y)
				position2.y += v6
			elseif list[nearestObject]:IsA(__wf_atom_3a0953be) then
				position2 = list[nearestObject]:GetPosition()
			else
				position2 = list[nearestObject]:GetPosition() + Vector(0, 1.5, 0)
			end

			table.remove(list, nearestObject)
			return position2
		end
	end
end

function EnergyRestoreEncounter(object)
	v3 = module.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return
	end

	local position = object:GetPosition()
	local __wf_atom_103377cc = object:__wf_atom_103377cc()
	gRegion:__wf_atom_439c0d29(v, position, 0, __wf_atom_103377cc + 5)
	local __wf_atom_db682341 = object:__wf_atom_db682341()

	if __wf_atom_db682341 == Symbol("WaterHotspot") then
		local _restoreTypeWater = restoreTypeWater
	elseif __wf_atom_db682341 == Symbol("EarthHotspot") then
		local _restoreTypeEarth = restoreTypeEarth
	elseif __wf_atom_db682341 == Symbol("FireHotspot") then
		local _restoreTypeFire = restoreTypeFire
	end

	local v4 = false

	while not (__wf_atom_7e8ad928(object) or object:ShouldShutDown()) do
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v5 in ipairs(__wf_atom_ef7900cf) do
			if not (v5:__wf_atom_1c8f7b2d(object) <= 100) then
				continue
			end

			v4 = true
			break
		end

		if not v4 then
			break
		end

		Sleep(2)
	end

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
	else
		module2.RemoveObjects(object)
	end
end

function EnergyRestoreManager()
	print("EnergyRestoreManager started")
	module.WaitForLevel()
	v3 = module.WaitForAiDir()
	local v4 = spawnRange.maxValue + 10
	local v5 = {}
	local v6 = false

	while true do
		local v7 = __wf_atom_5784a397(spawnIntervalTime.minValue, spawnIntervalTime.maxValue)

		while v7 > 0 or #v5 >= maxRestoresActive or not v6 do
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for i = #v5, 1, -1 do
				if __wf_atom_7e8ad928(v5[i]) then
					table.remove(v5, i)
				else
					local v8 = false

					for _, v9 in ipairs(__wf_atom_ef7900cf) do
						if not (v9:__wf_atom_1c8f7b2d(v5[i]) <= v4) then
							continue
						end

						v8 = true
						break
					end

					if not v8 then
						v5[i]:Destroy()
						table.remove(v5, i)
					end
				end
			end

			v6 = false

			for _, v8 in ipairs(__wf_atom_ef7900cf) do
				if __wf_atom_7e8ad928(nil) or v8:__wf_atom_a5304c35(nil) > minPlayerDistFromLastRestoresSpawnPos then
					v6 = true
				end
			end

			v7 -= 1
			Sleep(1)
		end

		Sleep(0)
	end
end

local function fn2(object)
	local v4 = nil

	if object:__wf_atom_bbcb227c() then
		v4 = (2 * object:__wf_atom_4e28532a()) ^ 2
	elseif object:__wf_atom_642b7ae0() then
		v4 = (2 * object:__wf_atom_0d6bb7d4()) ^ 2
	elseif object:__wf_atom_fdefab34() then
		local __wf_atom_80cf57aa = object:__wf_atom_80cf57aa()
		v4 = __wf_atom_80cf57aa.x * __wf_atom_80cf57aa.z
	end

	return (math.min(math.max(v4 * 0.25, 10), 180))
end

local function fn3(object, randomPointInVolume)
	local y = nil

	if object:__wf_atom_bbcb227c() then
		y = object:__wf_atom_4e28532a() * 2
	elseif object:__wf_atom_642b7ae0() then
		y = object:__wf_atom_7bb1d979()
	elseif object:__wf_atom_fdefab34() then
		y = object:__wf_atom_80cf57aa().y
	end

	local v4 = false
	local v5 = Vector(randomPointInVolume.x, object:GetPosition().y - y, randomPointInVolume.z)
	local __wf_atom_0e0a6fee = v3:__wf_atom_0e0a6fee(v5, 2, 50)

	if __wf_atom_0e0a6fee == v5 then
		local __wf_atom_4d26da3a = v3:__wf_atom_4d26da3a(v5, y + 1)

		if module.Distance2d(__wf_atom_4d26da3a, v5) <= 2 then
			__wf_atom_0e0a6fee = __wf_atom_4d26da3a
			v4 = true
		end
	else
		v4 = true
	end

	if not v4 then
		local __wf_atom_0e0a6fee2 = v3:__wf_atom_0e0a6fee(randomPointInVolume, y + 1, y + 1)
		__wf_atom_0e0a6fee = v3:__wf_atom_4d26da3a(randomPointInVolume, y + 1)

		if not (module.Distance2d(__wf_atom_0e0a6fee, randomPointInVolume) < module.Distance2d(__wf_atom_0e0a6fee2, randomPointInVolume)) then
			__wf_atom_0e0a6fee = __wf_atom_0e0a6fee2
		end
	end

	return (Vector(
		__wf_atom_0e0a6fee.x,
		math.max(__wf_atom_0e0a6fee.y + 1, randomPointInVolume.y),
		__wf_atom_0e0a6fee.z
	))
end

function EnergyRestoresInDungeon()
	module.WaitForLevel()
	v3 = module.WaitForAiDir()

	while not v3:__wf_atom_d0c59e69() do
		Sleep(0)
	end

	local v4 = {
		WeakResource("/SF/Types/Gameplay/EnergySourceVolumeEarth"),
		WeakResource("/SF/Types/Gameplay/EnergySourceVolumeWater"),
		(WeakResource("/SF/Types/Gameplay/EnergySourceVolumeFire"))
	}
	local v5 = { restoreTypeEarth, restoreTypeWater, restoreTypeFire }
	local v6 = { Color(0, 255, 64), Color(0, 64, 255), Color(255, 64, 0) }
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("EnergyRestoreVolume"))
	local total = 0
	local v7 = { 0, 0, 0 }
	local v8 = {}

	for _, object in ipairs(__wf_atom_2226b35c) do
		local color = Color(255, 255, 255)
		local score = fn2(object)
		total += score

		for i, className in ipairs(v4) do
			if not object:IsA(className) then
				continue
			end

			color = v6[i]
			v7[i] += score
			break
		end

		table.insert(v8, { object = object, score = score, color = color })
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ArenaScriptTrigger"))
	local layerIndex

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		layerIndex = __wf_atom_0a6a5887:__wf_atom_e800787c():GetLayerIndex()
	end

	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(v)
	local randomizeTableOrder = module.RandomizeTableOrder(__wf_atom_2226b35c2)
	local total2 = 0

	for _, object in ipairs(randomizeTableOrder) do
		local __wf_atom_e800787c = object:__wf_atom_e800787c()

		if
			__wf_atom_7e8ad928(__wf_atom_e800787c)
			or not (__wf_atom_7e8ad928(layerIndex) or not __wf_atom_7e8ad928(layerIndex) and __wf_atom_e800787c:GetLayerIndex() ~= layerIndex)
		then
			continue
		end

		table.insert(v8, { object = object, score = 8, color = v6[3] })
		total2 += 8
		v7[3] = total2

		if total * 0.5 <= total2 then
			break
		end
	end

	local v9 = total + total2

	for _ = 1, math.min(math.floor(v3:__wf_atom_5be58e19() / 100), 200) do
		local v10 = math.random() * v9
		v8 = module.RandomizeTableOrder(v8)
		local total3 = 0

		for _, v11 in ipairs(v8) do
			total3 += v11.score

			if not (v10 <= total3) then
				continue
			end

			local _color = v11.color
			local v12 = nil
			local score

			if v11.object:IsA(__wf_atom_6e7519b4) then
				for i, className in ipairs(v4) do
					if not v11.object:IsA(className) then
						continue
					end

					v12 = v5[i]
					break
				end

				if __wf_atom_7e8ad928(v12) then
					v12 = v5[__wf_atom_5784a397(1, #v5)]
				end

				local randomPointInVolume = module.GetRandomPointInVolume(v11.object)
				local v13 = fn3(v11.object, randomPointInVolume)
				gRegion:CreateEntity(v12, v13, __wf_atom_80368bb1)
				score = v11.score * 0.8
			else
				local position = v11.object:GetPosition()
				local v13 = fn(position, { v11.object }, true) or position
				local restoreTypeFire = restoreTypeFire
				gRegion:CreateEntity(restoreTypeFire, v13, __wf_atom_80368bb1)
				score = v11.score
			end

			v11.score -= score
			v9 -= score
			break
		end
	end
end

function RunScriptTrigger(object)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	module.WaitForAiDir()
	object:FirePort("Execute")
end