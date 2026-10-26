local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Scripts.Libs.EncounterLib")
local module4 = require("SF.Scripts.Libs.ObjectiveHudLib")
local v = Symbol("RandomTeam")
local v2 = nil
local v3 = nil
local v4 = {}
local v5 = {}

local function fn()
	Sleep(3)

	while not _T.CryptSetupDone do
		Sleep(0)
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(contextActionTag)

	for i = #__wf_atom_2226b35c, 1, -1 do
		if not __wf_atom_2226b35c[i]:IsEnabled() then
			table.remove(__wf_atom_2226b35c, i)
		end
	end

	local v6 = math.min(numCryptsToSearch, #__wf_atom_2226b35c)

	while #__wf_atom_2226b35c > 0 and #v4 < v6 do
		local v7 = __wf_atom_5784a397(1, #__wf_atom_2226b35c)
		local __wf_atom_e800787c = __wf_atom_2226b35c[v7]:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			continue
		end

		local layerIndex = __wf_atom_e800787c:GetLayerIndex()

		if __wf_atom_7e8ad928(v5[layerIndex]) then
			v5[layerIndex] = { actions = {}, marker = nil, navVolume = nil }
		end

		table.insert(v5[layerIndex].actions, __wf_atom_2226b35c[v7])
		table.insert(v4, __wf_atom_2226b35c[v7])
		table.remove(__wf_atom_2226b35c, v7)
	end

	local all = gRegion:FindAll(WeakResource("/EE/Types/Navigation/RecastNavVolume"))

	for i = 1, #all do
		local __wf_atom_e800787c = all[i]:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			continue
		end

		local layerIndex = __wf_atom_e800787c:GetLayerIndex()

		if not __wf_atom_7e8ad928(v5[layerIndex]) then
			v5[layerIndex].navVolume = all[i]
		end
	end

	for _, v7 in pairs(v5) do
		local position = v7.actions[1]:GetPosition()
		local v8 = 12
		local v9

		if __wf_atom_7e8ad928(v7.navVolume) then
			v9 = 0
		else
			position = v7.navVolume:GetPosition()
			local __wf_atom_80cf57aa = v7.navVolume:__wf_atom_80cf57aa()
			v9 = math.max(__wf_atom_80cf57aa.x, __wf_atom_80cf57aa.y, __wf_atom_80cf57aa.z) / 2
		end

		for _, action in ipairs(v7.actions) do
			local v10 = action:__wf_atom_a5304c35(position) + 5

			if v8 < v10 then
				v8 = v10
			end
		end

		if not (v9 >= 15 and v8 < v9) then
			v9 = math.max(v8, v9)
		end

		v7.marker = module3.CreateAreaMarker(areaMarkerType, position, v9, true)
		module2.AddSparrowDestination(v7.marker, v3, nil, module2.PRIORITY.HIGH)
		v3:__wf_atom_d494454b(v7.marker)
	end
end

local function fn2(object)
	local layerIndex = object:__wf_atom_e800787c():GetLayerIndex()

	for i = #v5[layerIndex].actions, 1, -1 do
		if not (__wf_atom_7e8ad928(v5[layerIndex].actions[i]) or not v5[layerIndex].actions[i]:IsEnabled() or v5[layerIndex].actions[i]:__wf_atom_272baebc()) then
			continue
		end

		table.remove(v5[layerIndex].actions, i)
	end

	if #v5[layerIndex].actions == 0 and not __wf_atom_7e8ad928(v5[layerIndex].marker) then
		v5[layerIndex].marker:Destroy()
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("ScrollPlacementDeco"), object:GetPosition(), 0, 5)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		gRegion:CreateEntity(scrollDecoType, __wf_atom_f738b4af:GetPosition(), __wf_atom_f738b4af:__wf_atom_dc309f8a())
	end

	Sleep(5)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v6 in ipairs(__wf_atom_ef7900cf) do
		module.GiveXpToPlayer(100, v6)
	end

	if not __wf_atom_7e8ad928(ghostAgentType) then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local v6 = __wf_atom_5784a397(0, 2)
		local v7 = { Range(8, 10), Range(15, 17) }
		local enemyLevel = module3.GetEnemyLevel(v3)

		for i = 1, v6 do
			local randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(
				object:GetPosition(),
				v7[i].minValue,
				v7[i].maxValue,
				true,
				__wf_atom_104bfe98(0.5, 0.8, math.random())
			)
			local __wf_atom_80368bb1 = __wf_atom_80368bb1
			local __wf_atom_ef7900cf2 = gRegion:__wf_atom_ef7900cf()
			local nearestObject = module.NearestObject(randomPointInRangeOnNav, __wf_atom_ef7900cf2)

			if not __wf_atom_7e8ad928(nearestObject) then
				__wf_atom_80368bb1 = __wf_atom_fa8d0177(randomPointInRangeOnNav, nearestObject:GetPosition())
			end

			local __wf_atom_402b3832 = __wf_atom_7d789620:__wf_atom_402b3832(
				ghostAgentType,
				randomPointInRangeOnNav,
				__wf_atom_80368bb1,
				v,
				enemyLevel.minValue
			)

			if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
				__wf_atom_402b3832:__wf_atom_30b587a4()
			end
		end
	end
end

function Main(object)
	print("Retrieve item encounter started")
	v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	object:__wf_atom_8e6fec76(1)
	v3 = object
	fn()
	object:__wf_atom_8e6fec76(2)
	local count = #v4
	local __wf_atom_c1f3dd00 = v3:__wf_atom_dd85e6db():__wf_atom_c1f3dd00()
	module4.UpdateOrAddHudCounterTask(v3, nil, __wf_atom_c1f3dd00, 0, count)
	local count2 = 0

	while not module3.PrimedMissionShouldShutDown(object, v3) do
		for i = #v4, 1, -1 do
			if __wf_atom_7e8ad928(v4[i]) or not (not v4[i]:IsEnabled() or v4[i]:__wf_atom_272baebc()) then
				continue
			end

			fn2(v4[i])
			table.remove(v4, i)
			count2 += 1
			local __wf_atom_c1f3dd00_2 = v3:__wf_atom_dd85e6db():__wf_atom_c1f3dd00()
			module4.UpdateOrAddHudCounterTask(v3, nil, __wf_atom_c1f3dd00_2, count2, count)
		end

		if count <= count2 then
			object:__wf_atom_8e6fec76(4)
			break
		else
			Sleep(0)
		end
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if object:__wf_atom_4026dfb5() == 4 then
		print("Retrieve item encounter succeeded")
		object:__wf_atom_8e6fec76(4)
		module4.CompleteHudTask(object)
		Sleep(4)

		if __wf_atom_7e8ad928(object) then
			return
		end

		module4.RemoveHudGroup(object)

		if object:__wf_atom_e464a32f() > 0 then
			if module.IsInOverworld() then
				while not __wf_atom_7e8ad928(object) and v2:__wf_atom_c6f505f2(object) > 0 do
					Sleep(0)
				end
			else
				while
					not __wf_atom_7e8ad928(object)
					and object:__wf_atom_4026dfb5() ~= 6
					and not Game.__wf_atom_2b221245(false)
				do
					Sleep(0)
				end
			end

			if __wf_atom_7e8ad928(object) then
				return
			end
		end
	else
		print("Retrieve item encounter shutdown")
		object:__wf_atom_8e6fec76(6)
		module4.RemoveHudGroup(object)
	end

	module3.RemoveObjects(object)
	print("Retrieve item encounter done")
end

function OnPrimed(_) end