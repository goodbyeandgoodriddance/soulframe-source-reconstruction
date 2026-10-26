local v = Symbol("SparrowPerchPoint")
local v2 = Symbol("Dead-End")
local v3 = WeakResource("/SF/Types/Quests/PreAlpha/Q1WakeUp")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.QuestLib")
local module3 = require("SF.Scripts.Libs.RespawnLib")

local function fn(p, p2)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)
	local v4 = nil

	for i = #__wf_atom_2226b35c, 1, -1 do
		if __wf_atom_2226b35c[i]:__wf_atom_e800787c():__wf_atom_db682341() == v2 then
			table.remove(__wf_atom_2226b35c, i)
		end
	end

	local v5 = nil
	local v6 = nil
	local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(p2)
	local __wf_atom_ec87469e = gRegion:__wf_atom_ec87469e(__wf_atom_0e0a6fee)
	local v7, layerIndex

	if __wf_atom_7e8ad928(__wf_atom_ec87469e) then
		v7 = Symbol("Connector")
		layerIndex = 1
	else
		layerIndex = __wf_atom_ec87469e:GetLayerIndex()
		v7 = __wf_atom_ec87469e:__wf_atom_db682341()
	end

	if v7 == v2 then
		local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(p)
		local filterObjectsInLayerIndex = module.FilterObjectsInLayerIndex(layerIndex, __wf_atom_2226b35c2)

		if #filterObjectsInLayerIndex > 0 then
			for _, v8 in pairs(filterObjectsInLayerIndex) do
				if not __wf_atom_7e8ad928(v8) then
					v6 = v8
				end
			end
		end
	else
		local filterObjectsInLayerIndex = module.FilterObjectsInLayerIndex(
			layerIndex,
			module.CopyTable(__wf_atom_2226b35c)
		)

		if #filterObjectsInLayerIndex > 0 then
			local entranceWaypoint = module.GetEntranceWaypoint()

			if not __wf_atom_7e8ad928(entranceWaypoint) then
				local position = entranceWaypoint:GetPosition()
				local __wf_atom_57856d42 = __wf_atom_7d789620:__wf_atom_57856d42(
					__wf_atom_7d789620:__wf_atom_0e0a6fee(p2),
					position
				)
				local v8 = nil
				local v9 = 3.4028234663852886e38

				for _, v10 in pairs(filterObjectsInLayerIndex) do
					local __wf_atom_57856d42_2 = __wf_atom_7d789620:__wf_atom_57856d42(
						__wf_atom_7d789620:__wf_atom_0e0a6fee(v10:GetPosition()),
						position
					)

					if __wf_atom_7e8ad928(v8) then
						v9 = __wf_atom_57856d42_2
						v8 = v10
					elseif __wf_atom_57856d42_2 < v9 then
						v9 = __wf_atom_57856d42_2
						v8 = v10
					end
				end

				if v9 < __wf_atom_57856d42 then
					v6 = v8
				end
			end
		end

		if __wf_atom_7e8ad928(v6) then
			for _, v8 in pairs(__wf_atom_2226b35c) do
				local layerIndex2 = module.GetLayerIndex(v8)
				local v9 = layerIndex2 == nil and -1 or layerIndex2

				if not (v9 < layerIndex) then
					continue
				end

				if __wf_atom_7e8ad928(v5) then
					v6 = v8
					v5 = v9
				elseif v5 < v9 then
					v6 = v8
					v5 = v9
				end
			end
		end
	end

	if __wf_atom_7e8ad928(v6) then
		for _, v8 in pairs(__wf_atom_2226b35c) do
			local layerIndex2 = module.GetLayerIndex(v8)
			local v9 = layerIndex2 == nil and -1 or layerIndex2

			if __wf_atom_7e8ad928(v5) then
				v6 = v8
				v5 = v9
			elseif v9 < v5 then
				v6 = v8
				v5 = v9
			end
		end
	end

	local blightZoneShrine = module3.GetBlightZoneShrine()
	local v8

	if __wf_atom_7e8ad928(blightZoneShrine) then
		blightZoneShrine = module.GetReviveShrinePreference()
		v8 = module.IsReviveShrineImperative()
	else
		v8 = true
	end

	if __wf_atom_7e8ad928(blightZoneShrine) then
		print("We didn't get an unlocked shrine, picking the nearest one behind player")
		return v6
	else
		if v8 then
			print("The game has assigned a preferred shrine, picking it")
			return blightZoneShrine
		end

		if
			blightZoneShrine:__wf_atom_e800787c():__wf_atom_db682341() == v2
			or v6:__wf_atom_e800787c():__wf_atom_db682341() == v2
		then
			local __wf_atom_0e0a6fee2 = __wf_atom_7d789620:__wf_atom_0e0a6fee(blightZoneShrine:GetPosition())
			local __wf_atom_0e0a6fee3 = __wf_atom_7d789620:__wf_atom_0e0a6fee(v6:GetPosition())

			if __wf_atom_7e8ad928(__wf_atom_0e0a6fee2) or __wf_atom_7e8ad928(__wf_atom_0e0a6fee3) then
				return v4
			end

			local __wf_atom_57856d42 = __wf_atom_7d789620:__wf_atom_57856d42(__wf_atom_0e0a6fee2, p2)
			local __wf_atom_57856d42_2 = __wf_atom_7d789620:__wf_atom_57856d42(__wf_atom_0e0a6fee3, p2)

			if __wf_atom_7e8ad928(__wf_atom_57856d42) or __wf_atom_7e8ad928(__wf_atom_57856d42_2) then
				print("There is a shrine player checked at in the dead end, but we can not path to it and pick the closest behind him")
				return v6
			end

			if __wf_atom_57856d42 < __wf_atom_57856d42_2 then
				print("There is a good shrine player checked at the dead end, picking it")
				return blightZoneShrine
			end

			print("There is a shrine player checked at in the dead end, but we are picking one closer behind him")
			return v6
		else
			local layerIndex2 = module.GetLayerIndex(blightZoneShrine)
			local v9 = layerIndex2 == nil and -1 or layerIndex2
			local layerIndex3 = module.GetLayerIndex(v6)

			if (layerIndex3 == nil and -1 or layerIndex3) <= v9 then
				print("There is a good shrine player checked at, picking it")
				return blightZoneShrine
			end

			print("There is a shrine player checked at,  but we are picking one closer behind him")
			return v6
		end
	end
end

function RespawnPlayer(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local playerAvatar = object:GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) then
		print("Ghost revive: Player did not have an original avatar, we're going to have to SpawnPlayer them as an EnvoyAvatar")
		local playerAvatar2 = object:GetPlayerAvatar(10)
		gGameRules:SpawnPlayer(object, envoyAvatarType)

		if not __wf_atom_7e8ad928(playerAvatar2) then
			playerAvatar2:Destroy()
			object:__wf_atom_6c552f4c(10, nil)
		end
	elseif playerAvatar:__wf_atom_bedb4e3f() or not playerAvatar:IsKilled() then
		print("avatar still alive, we can't respawn them")
	else
		gGameRules:RespawnPlayer(object, false)
	end
end

function FadeOutBird(object)
	local v4 = 0

	while v4 < 1 and not __wf_atom_7e8ad928(object) do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() * 2, 0, 1)
		local v5 = __wf_atom_24a82b69(v4)
		object:__wf_atom_68f2c268(v5)
		object:CameraControl():__wf_atom_25382a0d(1 + v5 * 1)
		object:__wf_atom_986f733d(Symbol("DoneFlight"), __wf_atom_104bfe98(1, 0.2, v5))
		object:PlaySound(birdFadeSound, false)
		Sleep(0)
	end
end

function Revive(instance, instance2)
	if __wf_atom_7e8ad928(instance2) then
		return
	end

	local __wf_atom_a96eb2aa = instance2:__wf_atom_a96eb2aa()
	print("Reviving player")

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	local __wf_atom_ef151cfd = __wf_atom_a96eb2aa:__wf_atom_ef151cfd()

	if
		__wf_atom_7e8ad928(_T.EnabledShrine)
		or __wf_atom_7e8ad928(_T.EnabledShrine[__wf_atom_ef151cfd])
		or _T.EnabledShrine[__wf_atom_a96eb2aa:__wf_atom_ef151cfd()] ~= instance
	then
		return
	end

	if not (instance2:IsA(ghostAvatarType) or instance2:IsA(sparrowGhostAvatarType)) then
		return
	end

	_T.EnabledShrine[__wf_atom_a96eb2aa:__wf_atom_ef151cfd()] = nil

	if instance2:__wf_atom_8efce136() then
		gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(1, 2)
		instance2:__wf_atom_8a035cd5(Symbol("FadeOutBird"), false)
		Sleep(0.5 + __wf_atom_084b3e93())
	end

	if __wf_atom_7e8ad928(instance2) then
		return
	end

	_T.StatsReviveSparrow = true
	RespawnPlayer(__wf_atom_a96eb2aa)
	local position = instance:GetPosition()
	local __wf_atom_d9cb4b97 = instance2:MotionControl():__wf_atom_d9cb4b97()
	local __wf_atom_50a7d83e = __wf_atom_a96eb2aa:__wf_atom_50a7d83e()
	__wf_atom_50a7d83e:Teleport(__wf_atom_50a7d83e:__wf_atom_0d7d47e6(position), __wf_atom_d9cb4b97)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("GhostNavDeco"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Destroy()
	end

	if not __wf_atom_7e8ad928(reviveAttachFxType) then
		__wf_atom_50a7d83e:Attach(reviveAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	instance:Destroy()
end

function PlayReviveAnim(object)
	if __wf_atom_72884638("Ghost.Sparrow") and not __wf_atom_7e8ad928(object) then
		local v4 = object:Attach(revivePerceptionHint, Symbol("GAME_C1_SPINE3"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		object:__wf_atom_dd875cd8(true)
		object:__wf_atom_8914dfde("ReviveEnd", object:__wf_atom_921c1a5f(activateAnim, true, 3, 1))

		if __wf_atom_7e8ad928(object) then
			return
		end

		object:__wf_atom_dd875cd8(false)

		if not __wf_atom_7e8ad928(v4) then
			v4:Destroy()
		end
	end
end

function ShrineRevive(p, instance)
	if __wf_atom_7e8ad928(instance) or not (instance:IsA(ghostAvatarType) or instance:IsA(sparrowGhostAvatarType)) then
		return
	end

	_T.DyingFade = nil

	if not __wf_atom_72884638("Ghost.Sparrow") then
		instance:__wf_atom_921c1a5f(activateAnim, true, 3, 1)
	end

	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_a96eb2aa = instance:__wf_atom_a96eb2aa()
	Revive(p, instance)
	local __wf_atom_50a7d83e = __wf_atom_a96eb2aa:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(healingPotType) then
		__wf_atom_50a7d83e:GiveItem(healingPotType, true)
	end

	__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("PlayReviveAnim"), false)
end

function ShrineReviveConditionScript(p, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return false
	end

	if object:IsMaster() then
		local __wf_atom_ef151cfd = __wf_atom_a96eb2aa:__wf_atom_ef151cfd()

		if __wf_atom_7e8ad928(_T.EnabledShrine) or __wf_atom_7e8ad928(_T.EnabledShrine[__wf_atom_ef151cfd]) then
			return false
		end

		return _T.EnabledShrine[__wf_atom_ef151cfd] == p
	elseif
		__wf_atom_7e8ad928(_T.PlayerShrinePosition)
		or __wf_atom_7e8ad928(_T.PlayerShrinePosition[__wf_atom_a96eb2aa:__wf_atom_ef151cfd()])
	then
		return false
	else
		return __wf_atom_a93b9922(
			_T.PlayerShrinePosition[__wf_atom_a96eb2aa:__wf_atom_ef151cfd()],
			object:__wf_atom_a2a18137()
		) < 100
	end
end

function InterruptDeathLoop(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local playerAvatar = object:GetPlayerAvatar(0)

	if not __wf_atom_7e8ad928(playerAvatar) and playerAvatar:IsKilled() then
		local position = playerAvatar:GetPosition()

		if p then
			Sleep(1.6)

			if not __wf_atom_7e8ad928(playerAvatar) and playerAvatar:__wf_atom_8efce136() then
				gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(1, 1)
			end

			Sleep(1)
		end

		if gRegion:IsMaster() then
			if not __wf_atom_7e8ad928(playerAvatar) then
				position = playerAvatar:GetPosition()
			end

			if p then
				local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

				for _, v4 in ipairs(__wf_atom_ef7900cf) do
					if not v4:IsKilled() then
						position = v4:GetPosition()
					end
				end
			end

			local v4

			if _T.lastPickedShrine ~= nil then
				v4 = _T.lastPickedShrine[object:__wf_atom_ef151cfd()]
			end

			if __wf_atom_7e8ad928(v4) then
				if module.IsInOverworld() then
					print("We didn't get an unlocked shrine, picking the nearest one")
					v4 = module3.GetBlightZoneShrine()
					local v5

					if __wf_atom_7e8ad928(v4) then
						v4 = module.GetReviveShrinePreference()
						v5 = module.IsReviveShrineImperative()
					else
						v5 = true
					end

					if __wf_atom_7e8ad928(v4) or not v5 then
						v4 = gRegion:FindNearestTagged(Symbol("ResShrine"), position)
					end
				else
					v4 = fn(Symbol("ResShrine"), position)
				end
			end

			if not __wf_atom_7e8ad928(v4) then
				local __wf_atom_bb3e7833 = v4:__wf_atom_bb3e7833(__wf_atom_0f45538d)

				if __wf_atom_bb3e7833 == nil then
					__wf_atom_bb3e7833 = v4
				end

				local __wf_atom_a2a18137 = __wf_atom_bb3e7833:__wf_atom_a2a18137()
				local v5 = v4:__wf_atom_2f2bada0() + Rotation(90, 0, 0)
				local v6 = Vector(0, 0, 2.5)
				local v7 = __wf_atom_a2a18137 + __wf_atom_9341614d(v6, v5)
				local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v7)
				_T.StatsReviveSparrow = false
				RespawnPlayer(object)

				if (p == nil or not p) and not __wf_atom_7e8ad928(_T.EnabledShrine) then
					local v8 = _T.EnabledShrine[object:__wf_atom_ef151cfd()]

					if not __wf_atom_7e8ad928(v8) then
						v8:Destroy()
					end
				end

				local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

				while __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e == playerAvatar do
					Sleep(0)
					__wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
				end

				__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("PlayReviveAnim"), false)
				__wf_atom_50a7d83e:PlaySound(shrineReviveSound, false)
				__wf_atom_50a7d83e:Attach(reviveAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				print("respawned as " .. tostring(__wf_atom_50a7d83e))
				__wf_atom_50a7d83e:Teleport(__wf_atom_0e0a6fee, v5)
			end
		end
	end
end

function StartDeathLoop(object, p, data, p2, p3)
	if __wf_atom_7e8ad928(object) then
		return
	end

	print("StartDeathLoop for " .. object:__wf_atom_6be84646())
	local v4 = Rotation(data.x, data.y, data.z)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:__wf_atom_bedb4e3f() then
		print("We won't deathloop", __wf_atom_50a7d83e)
		return
	end

	while not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and __wf_atom_50a7d83e:__wf_atom_40a4ba6c() do
		Sleep(0)
	end

	if p3 then
		if _T.BlightZoneRespawning then
			__wf_atom_50a7d83e:__wf_atom_7470861b():__wf_atom_4807c4aa()

			if _T.BlightZone.mPermaDeath or _T.BlightZone.mSpectatorMode then
				__wf_atom_50a7d83e:__wf_atom_399cdc29(false)
			end

			if _T.BlightZone.mPermaDeath then
				__wf_atom_50a7d83e:Damage(1, 20)
			else
				__wf_atom_50a7d83e:__wf_atom_7470861b():__wf_atom_0e3d6320(false)
				__wf_atom_50a7d83e:__wf_atom_7470861b():__wf_atom_bbcba13b(true)
			end

			__wf_atom_50a7d83e:Damage(1, 20)
			return
		else
			__wf_atom_50a7d83e:__wf_atom_7470861b():__wf_atom_4807c4aa()
			__wf_atom_50a7d83e:Damage(1, 20)
		end
	end

	Sleep(1.6)

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and __wf_atom_50a7d83e:__wf_atom_8efce136() then
		gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(1, 1)
	end

	Sleep(1)
	local v5 = nil
	local v6

	if module2.QuestIsActive(v3) then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("TutorialShrineWp"))

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			v6 = p2
		else
			v6 = gRegion:__wf_atom_f738b4af(Symbol("ResShrine"), __wf_atom_0a6a5887:GetPosition(), 0, 30)
		end
	else
		v6 = p2
	end

	if __wf_atom_7e8ad928(p2) then
		if module.IsInOverworld() then
			print("We didn't get an unlocked shrine, picking the nearest one")
			v6 = module3.GetBlightZoneShrine()
			local v7

			if __wf_atom_7e8ad928(v6) then
				v6 = module.GetReviveShrinePreference()
				v7 = module.IsReviveShrineImperative()
			else
				v7 = true
			end

			if __wf_atom_7e8ad928(v6) or not v7 then
				v6 = gRegion:FindNearestTagged(Symbol("ResShrine"), p)
			end
		else
			v6 = fn(Symbol("ResShrine"), p)
		end
	end

	if not __wf_atom_7e8ad928(v6) and gRegion:IsMaster() then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_bb3e7833 = v6:__wf_atom_bb3e7833(noCombatContainerType)

		if
			module.IsInOverworld()
			and not __wf_atom_7e8ad928(noCombatContainerType)
			and __wf_atom_7e8ad928(__wf_atom_bb3e7833)
		then
			__wf_atom_7d789620:__wf_atom_ccbb5582((v6:Attach(noCombatContainerType, EMPTY_SYMBOL)))
		end

		local __wf_atom_bb3e7833_2 = v6:__wf_atom_bb3e7833(__wf_atom_0f45538d)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
			if _T.BlightZoneRespawning == nil then
				if __wf_atom_72884638("Ghost.Sparrow") then
					local __wf_atom_a2a18137 = __wf_atom_bb3e7833_2:__wf_atom_a2a18137()
					local __wf_atom_2f2bada0 = __wf_atom_bb3e7833_2:__wf_atom_2f2bada0()
					local v7 = Vector(0, 3.8, 0)
					local v8 = __wf_atom_a2a18137 + __wf_atom_9341614d(v7, __wf_atom_2f2bada0)
					local __wf_atom_be0bea4a = v6:__wf_atom_be0bea4a()

					for i = 1, #__wf_atom_be0bea4a do
						local v9 = __wf_atom_be0bea4a[i]

						if v9:__wf_atom_db682341() ~= v then
							continue
						end

						v8 = v9:__wf_atom_a2a18137()
						__wf_atom_2f2bada0 = v9:__wf_atom_2f2bada0()
					end

					local v9 = __wf_atom_fa8d0177(v8, p)
					v9.pitch = 0
					v9.bank = 0
					v5 = gGameRules:__wf_atom_9fea9c7b(object, v8, __wf_atom_2f2bada0)

					if __wf_atom_7e8ad928(v5) then
						print("Failed to spawn ghost avatar")
					else
						v5:Teleport(v8, __wf_atom_2f2bada0)
						v5:__wf_atom_f0f9fb38(v9)
					end
				else
					local __wf_atom_a2a18137 = __wf_atom_bb3e7833_2:__wf_atom_a2a18137()
					local __wf_atom_2f2bada0 = __wf_atom_bb3e7833_2:__wf_atom_2f2bada0()
					local v7 = Vector(0, 0, 2.5)
					local v8 = __wf_atom_a2a18137 + __wf_atom_9341614d(v7, __wf_atom_2f2bada0)
					local __wf_atom_0e0a6fee = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v8)
					v5 = gGameRules:__wf_atom_9fea9c7b(object, __wf_atom_0e0a6fee, __wf_atom_2f2bada0)
				end
			else
				print("Blighted zone respawn")
				Sleep(blightedZoneRespawnDelay)
				RespawnPlayer(object)
				local __wf_atom_50a7d83e2 = object:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(v6) then
					local v7 = Vector(0, 3.8, 0)
					local __wf_atom_2f2bada0 = v6:__wf_atom_2f2bada0()
					local v8 = v6:__wf_atom_a2a18137() + __wf_atom_9341614d(v7, __wf_atom_2f2bada0)
					__wf_atom_50a7d83e2:Teleport(
						gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v8),
						__wf_atom_2f2bada0
					)
				end

				gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, 1)
				return
			end
		end
	end

	gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, 1)

	if __wf_atom_7e8ad928(v5) then
		RespawnPlayer(object)
		return
	end

	local v7

	if __wf_atom_72884638("Ghost.Sparrow") then
		print("ReviveActive.lua::StartDeathLoop sparrowReviveType")
		v7 = gRegion:CreateEntity(sparrowReviveType, p, v4)
	else
		print("ReviveActive.lua::StartDeathLoop reviveType")
		v7 = gRegion:CreateEntity(reviveType, p, v4)
	end

	Sleep(0)

	if not __wf_atom_7e8ad928(v6) then
		if _T.lastPickedShrine == nil then
			_T.lastPickedShrine = {}
		end

		_T.lastPickedShrine[object:__wf_atom_ef151cfd()] = v6
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Enable()

		if _T.EnabledShrine == nil then
			_T.EnabledShrine = {}
		end

		_T.EnabledShrine[object:__wf_atom_ef151cfd()] = v7
	end

	gGameRules:__wf_atom_7b58c50c(object)

	if toggleRecoveryTimerDebug then
		return
	end

	local playerAvatar = object:GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) then
		return
	end

	local recoveryTime2 = recoveryTime

	if not __wf_atom_7e8ad928(playerAvatar:__wf_atom_d2b2176d()) then
		local __wf_atom_e55d02aa = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		local __wf_atom_9fb9a1d6 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

		if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			if __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
				recoveryTime2 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(recoveryTime, 132)
			else
				recoveryTime2 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(
					recoveryTime,
					132,
					__wf_atom_9fb9a1d6:__wf_atom_1bb5b1ff(),
					__wf_atom_9fb9a1d6
				)
			end
		else
			recoveryTime2 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(
				recoveryTime,
				132,
				__wf_atom_e55d02aa:__wf_atom_1bb5b1ff(),
				__wf_atom_e55d02aa
			)
		end
	end

	local v8 = 0

	while v8 < recoveryTime2 and (__wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled()) do
		Sleep(0.5)
		v8 = v8 + __wf_atom_084b3e93() + 0.5

		if __wf_atom_7e8ad928(object) then
			playerAvatar = nil
		else
			playerAvatar = object:GetPlayerAvatar(0)
		end
	end

	if not (__wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled()) then
		return
	end

	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(v7)) then
		local __wf_atom_50a7d83e2 = object:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e2) and v5 == __wf_atom_50a7d83e2 then
			RespawnPlayer(object)
			v7:Destroy()
			local __wf_atom_50a7d83e3 = object:__wf_atom_50a7d83e()
			__wf_atom_50a7d83e3:__wf_atom_8a035cd5(Symbol("PlayReviveAnim"), false)
			__wf_atom_50a7d83e3:PlaySound(shrineReviveSound, false)
			__wf_atom_50a7d83e3:Attach(reviveAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			print("respawned as " .. tostring(__wf_atom_50a7d83e3))

			if __wf_atom_72884638("Ghost.Sparrow") then
				local __wf_atom_bb3e7833 = v6:__wf_atom_bb3e7833(__wf_atom_0f45538d)
				local __wf_atom_a2a18137 = __wf_atom_bb3e7833:__wf_atom_a2a18137()
				local __wf_atom_2f2bada0 = __wf_atom_bb3e7833:__wf_atom_2f2bada0()
				local v9 = Vector(0, 0, 2.5)
				local v10 = __wf_atom_a2a18137 + __wf_atom_9341614d(v9, __wf_atom_2f2bada0)
				__wf_atom_50a7d83e3:Teleport(
					gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v10),
					__wf_atom_2f2bada0
				)
			end
		end
	end
end

function CheckAtShrine(object, _)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not (module.IsInOverworld() or __wf_atom_7e8ad928(__wf_atom_3d96ddcd)) then
		module.SetReviveShrinePreference(__wf_atom_3d96ddcd)
	end
end