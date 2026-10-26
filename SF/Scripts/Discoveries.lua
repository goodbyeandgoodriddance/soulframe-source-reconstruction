local module = require("SF.Scripts.Libs.RaycastLib")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local v = WeakResource("/SF/Types/Game/Ancestors/Orlick/OrlickAncestor")

local function fn(position, p, p2, object)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v2 = 7
	local v3 = {}

	for i = 1, v2 do
		table.insert(v3, i)
	end

	local v4 = p / 3
	local v5 = Vector(0, 0, v4 * 2)
	local v6 = math.min(math.min(math.max(math.floor(v4 * 4 / 25), 1), 3), p2)
	local v7 = math.random(1, v6)
	local spawnAllMotes, v8

	if __wf_atom_7e8ad928(object) then
		spawnAllMotes = false
	else
		v8 = object:__wf_atom_e919fb8e()
		spawnAllMotes = v8.spawnAllMotes or false

		if spawnAllMotes then
			v7 = p2 - (v8.numberMotesSpawned or 0)

			if v7 <= 0 then
				return
			end
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

			if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				v7 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_2a745663(
					v7,
					211,
					__wf_atom_e55d02aa:__wf_atom_1bb5b1ff(),
					__wf_atom_e55d02aa
				)
			end
		end
	end

	local count = 0

	for _ = 1, v7 do
		local v9 = false
		local count2 = 0

		while not v9 do
			if spawnAllMotes then
				v2 = count2 == 3 and 7 or v2

				if count2 > 6 then
					break
				end
			elseif count2 > 3 then
				break
			end

			local v10 = math.random(1, v2)
			local v11 = v3[v10]
			v3[v10] = v3[v2]
			local v12

			if v11 == 7 then
				v12 = position
			else
				v12 = position + __wf_atom_9341614d(v5, Rotation(60 * (v11 - 1), 0, 999))
			end

			local __wf_atom_a70d9d07 = __wf_atom_7d789620:__wf_atom_a70d9d07(v12, v4, false, 2)
			local groundPos = module.GetGroundPos(__wf_atom_a70d9d07, __wf_atom_28d5d4aa, nil, nil, __wf_atom_28d5d4aa)

			if __wf_atom_28d5d4aa == groundPos then
				count2 += 1
			else
				count += 1
				v2 -= 1
				local v13 = groundPos + Vector(0, math.random(1, 2), 0)
				gRegion:CreateEntity(loreMoteType, v13, __wf_atom_80368bb1):__wf_atom_bb3e7833(__wf_atom_faccb0cf):__wf_atom_281c0d58(loreFragmentRes:__wf_atom_1bb5b1ff())
				v9 = true
			end
		end
	end

	if not __wf_atom_7e8ad928(v8) then
		v8.numberMotesSpawned = count
	end

	return count
end

function LocationDiscovery(object, object2)
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(loreFragmentRes) then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if
		__wf_atom_7e8ad928(__wf_atom_a96eb2aa)
		or not __wf_atom_a96eb2aa:IsLocal()
		or __wf_atom_a96eb2aa:GetPlayerAvatar(0) ~= object
	then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return
	end

	if _T.Discoveries == nil then
		_T.Discoveries = {}
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
	local c_str = loreFragmentRes:__wf_atom_014a76a2():c_str()

	if
		_T.Discoveries[c_str] ~= nil
		and (__wf_atom_e919fb8e.spawnAllMotes == nil or not __wf_atom_e919fb8e.spawnAllMotes)
	then
		return
	end

	if spawnChance < 1 then
		if __wf_atom_e919fb8e.rolledSpawnChance then
			return
		end

		local v2 = math.random()
		__wf_atom_e919fb8e.rolledSpawnChance = true

		if spawnChance < v2 then
			return
		end
	end

	local __wf_atom_3563f9c2 = loreFragmentRes:__wf_atom_3563f9c2()
	local __wf_atom_ff0dc264 = __wf_atom_d2b2176d:__wf_atom_ff0dc264(loreFragmentRes)

	if __wf_atom_3563f9c2 == 0 and not loreFragmentRes:__wf_atom_7188fa33() then
		if not __wf_atom_ff0dc264 then
			gGameData:DiscoverLoreFragment(loreFragmentRes, "SyncInventoryCallback")
		end
	else
		if not __wf_atom_ff0dc264 then
			gGameData:DiscoverLoreFragment(loreFragmentRes, "DiscoverLoreFragmentCallback")
		end

		if module3.GetAncestorUpgradeRankValueForTag(v, Symbol("SpawnLoreMotes"), Symbol("ENABLE")) > 0 then
			_T.Discoveries[c_str] = true

			if module2.IsInHub() then
				return
			end

			local specificDimTrigger2

			if __wf_atom_7e8ad928(specificDimTrigger) then
				specificDimTrigger2 = object2
			else
				specificDimTrigger2 = specificDimTrigger
			end

			local v2 = not __wf_atom_ff0dc264 and 0
				or math.min(__wf_atom_d2b2176d:__wf_atom_96a19f31(loreFragmentRes), __wf_atom_3563f9c2)
				or 0
			local v3

			if v2 < __wf_atom_3563f9c2 then
				local position = specificDimTrigger2:GetPosition()
				local __wf_atom_80cf57aa = specificDimTrigger2:__wf_atom_80cf57aa()
				v3 = fn(
					position,
					math.max(20, (math.max(__wf_atom_80cf57aa.x / 2, __wf_atom_80cf57aa.z / 2))),
					__wf_atom_3563f9c2 - v2,
					object2
				)
				__wf_atom_e919fb8e.spawnAllMotes = false
			else
				v3 = 0
			end

			if not __wf_atom_7e8ad928(notificationMovie) then
				local __wf_atom_330f77f5 = __wf_atom_a96eb2aa:__wf_atom_330f77f5(false)

				if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
					__wf_atom_330f77f5:__wf_atom_b4984563(
						notificationMovie,
						"LocationDiscovered",
						{
							c_str,
							tostring(v2),
							tostring(__wf_atom_3563f9c2),
							"false",
							tostring(v3),
							(tostring(11))
						},
						11,
						"LocationDiscovered",
						true
					)
					__wf_atom_e919fb8e.locationDiscovered = true
				end
			end
		elseif
			(__wf_atom_e919fb8e.locationDisovered == nil or not __wf_atom_e919fb8e.locationDiscovered)
			and not __wf_atom_7e8ad928(notificationMovie)
		then
			local __wf_atom_330f77f5 = __wf_atom_a96eb2aa:__wf_atom_330f77f5(false)

			if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
				__wf_atom_330f77f5:__wf_atom_b4984563(
					notificationMovie,
					"LocationDiscovered",
					{
						c_str,
						tostring(0),
						tostring(__wf_atom_3563f9c2),
						"false",
						tostring(0),
						(tostring(11))
					},
					11,
					"LocationDiscovered",
					true
				)
				__wf_atom_e919fb8e.locationDiscovered = true
			end
		end
	end
end

function InventorySyncCompleted() end

function SyncInventoryCallback(p, _)
	if p then
		gGameData:SyncInventoryFromDB("InventorySyncCompleted")
	end
end

function DiscoverLoreFragmentCallback(p, p2)
	if p then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

			if not __wf_atom_7e8ad928(playerAvatar) then
				local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

				if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
					local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

					if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
						__wf_atom_d2b2176d:__wf_atom_1c510625(2000, __wf_atom_e55d02aa)
					end
				end
			end
		end

		SyncInventoryCallback(p, p2)
	end
end