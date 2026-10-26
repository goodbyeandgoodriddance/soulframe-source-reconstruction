local v = nil
local v2 = Vector(0.001, 0.001, 0.001)
local v3 = nil
local v4 = nil
local mainDeco2 = nil
local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")

local function fn()
	if __wf_atom_7e8ad928(mainDeco2) then
		return
	end

	if __wf_atom_7e8ad928(v3) then
		mainDeco2:__wf_atom_83fac646(Symbol("GAME_L1_EYEHEAD1"), __wf_atom_80368bb1, __wf_atom_28d5d4aa, v2)
		mainDeco2:__wf_atom_83fac646(Symbol("GAME_L1_EYEHEAD2"), __wf_atom_80368bb1, __wf_atom_28d5d4aa, v2)
	end

	if __wf_atom_7e8ad928(v4) then
		mainDeco2:__wf_atom_83fac646(Symbol("GAME_R1_EYEHEAD1"), __wf_atom_80368bb1, __wf_atom_28d5d4aa, v2)
		mainDeco2:__wf_atom_83fac646(Symbol("GAME_R1_EYEHEAD2"), __wf_atom_80368bb1, __wf_atom_28d5d4aa, v2)
	end
end

local function fn2(p)
	local __wf_atom_bb3e7833 = mainDeco:__wf_atom_bb3e7833(WeakResource("/SF/Objects/Ode/Props/OdePollutorAFluidDeco"))

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:SetVisibility(p, true)
	end

	local v5 = WeakResource("/SF/Objects/Ode/Props/OdePollutorAPaddleDeco")
	local __wf_atom_f582136d = mainDeco:__wf_atom_f582136d(v5)

	for _, v6 in ipairs(__wf_atom_f582136d) do
		v6:SetVisibility(p, true)
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("RiverPolluterScript"), mainDeco:GetPosition(), 0, 15)

	if p then
		mainDeco:__wf_atom_7b7015c9(ambientAnim)
		mainDeco:__wf_atom_45cf0e1a(intactMesh, true, true)

		if gRegion:IsMaster() then
			__wf_atom_f738b4af:Enable()

			if not gameplayObject:IsEnabled() then
				gameplayObject:Enable()
			end

			local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(
				WeakResource("/SF/Fx/Gameplay/Interactables/OdePollution/OdePollutorDestroyedFX"),
				mainDeco:GetPosition(),
				15
			)

			if not __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
				__wf_atom_e2db08ce:Destroy()
			end
		end
	else
		mainDeco:__wf_atom_7b7015c9(nil)
		mainDeco:__wf_atom_45cf0e1a(destroyedMesh, true, true)

		if gRegion:IsMaster() then
			__wf_atom_f738b4af:Disable()

			if gameplayObject:IsEnabled() then
				gameplayObject:Disable()
			end
		end
	end
end

function EnablePolluter()
	fn2(true)
end

function DisablePolluter()
	fn2(false)
end

local function fn3(object, p, position)
	local v5 = p or dropTable

	if __wf_atom_7e8ad928(v5) then
		local v6 = __wf_atom_7e8ad928(v) and "" or v:__wf_atom_5b41f63b()
		print("Drop or loot (" .. v6 .. ") that doesn't have a dropTable! (So the players will collect nothing from it)")
	elseif gRegion:IsMaster() then
		local __wf_atom_e93896ba = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e93896ba(0)
		local enemyLevel = module.GetEnemyLevel(object)
		local v6 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)

		if giveDirectlyToPlayers then
			v = object
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			for i = 1, #__wf_atom_ef7900cf do
				local v7 = __wf_atom_ef7900cf[i]

				if __wf_atom_ef7900cf[i]:__wf_atom_a5304c35(v:GetPosition()) < maxRewardDistance then
					v5:__wf_atom_0ad20b11(v7, __wf_atom_c4f78a8f, __wf_atom_e93896ba, v6)
				end
			end
		else
			v5:__wf_atom_6ba3aebe(object, __wf_atom_e93896ba, v6, position - object:GetPosition())
		end

		_T.idleTimoutReset = true
	end
end

local function fn4(object) -- 4 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(object) then
		return true
	end

	return #object:__wf_atom_6f4fd712() == 0
end

function PollutionMachine(object)
	while __wf_atom_7e8ad928(mainDeco) do
		Sleep(0)

		if __wf_atom_7e8ad928(object) or fn4(nil) then -- inferred equivalent call
			return
		end
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("EyeHitProxyWpLeft"), object:GetPosition(), 0, 15)
	local __wf_atom_f738b4af2 = gRegion:__wf_atom_f738b4af(Symbol("EyeHitProxyWpRight"), object:GetPosition(), 0, 15)
	local flag = false
	mainDeco2 = mainDeco

	while not flag do
		v3 = gRegion:CreateEntity(
			hitProxyType,
			__wf_atom_f738b4af:GetPosition(),
			__wf_atom_f738b4af:__wf_atom_dc309f8a()
		)
		v3:PlaySound(eyeRestoreSound, false)
		v4 = gRegion:CreateEntity(
			hitProxyType,
			__wf_atom_f738b4af2:GetPosition(),
			__wf_atom_f738b4af:__wf_atom_dc309f8a()
		)
		v4:PlaySound(eyeRestoreSound, false)

		while not flag do
			if (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v4)) and not __wf_atom_7e8ad928(gameplayObject) then
				gameplayObject:Activate()
				break
			end

			if fn4(object) then -- inferred equivalent call
				__wf_atom_7e8ad928(v3)
				__wf_atom_7e8ad928(v4)

				if not __wf_atom_7e8ad928(gameplayObject) then
					gameplayObject:Deactivate()
				end

				return
			else
				Sleep(0)
			end
		end

		fn()
		local nearbyEnemies = module.FindNearbyEnemies(object:GetPosition(), 30)

		for _, nearbyEnemy in ipairs(nearbyEnemies) do
			if __wf_atom_7e8ad928(nearbyEnemy) or nearbyEnemy:IsKilled() then
				continue
			end

			local __wf_atom_30e3d82b = nearbyEnemy:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_30b587a4()
			end
		end

		local total = 0

		while total < 30 do
			if __wf_atom_7e8ad928(v3) and __wf_atom_7e8ad928(v4) then
				flag = true
				break
			end

			if fn4(object) then -- inferred equivalent call
				__wf_atom_7e8ad928(v3)
				__wf_atom_7e8ad928(v4)

				if not __wf_atom_7e8ad928(gameplayObject) then
					gameplayObject:Deactivate()
				end

				return
			else
				total += __wf_atom_084b3e93()
				Sleep(0)
			end
		end

		gameplayObject:Deactivate()
		fn()

		if flag then
			continue
		end

		__wf_atom_7e8ad928(v3)
		__wf_atom_7e8ad928(v4)

		if not __wf_atom_7e8ad928(gameplayObject) then
			gameplayObject:Deactivate()
		end

		if fn4(object) then -- inferred equivalent call
			return
		end
	end

	if flag then
		local __wf_atom_6f4fd712 = object:__wf_atom_6f4fd712()

		if #__wf_atom_6f4fd712 > 0 then
			for _, v5 in ipairs(__wf_atom_6f4fd712) do
				module2.GiveXpToPlayer(destroyXp / #__wf_atom_6f4fd712, v5)
			end

			local v5 = math.random()
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("PollutionBallDropPoint"))

			if v5 <= spawnChance then
				fn3(object, nil, __wf_atom_0a6a5887:GetPosition())
			end
		end

		gRegion:CreateEntity(destructionFx, mainDeco:GetPosition(), mainDeco:__wf_atom_dc309f8a())
		gRegion:CreateEntity(destroyedFx, mainDeco:GetPosition(), mainDeco:__wf_atom_dc309f8a())
		gameplayObject:Disable()
	end
end