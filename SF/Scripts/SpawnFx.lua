local module = require("Lotus.Scripts.Libs.AudioLib")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("SF.Scripts.Libs.RaycastLib")

function SpawnFx(object)
	local v

	if not __wf_atom_7e8ad928(object) then
		v = object:__wf_atom_50a7d83e()
	end

	if __wf_atom_7e8ad928(v) then
		return
	end

	local v2 = Random(1.1, 1.35)
	local __wf_atom_a2a18137 = v:__wf_atom_a2a18137()
	local v3 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)

	if raycastToGround then
		local groundAlignedSpawnPosRot, v4 = module3.GetGroundAlignedSpawnPosRot(effects, __wf_atom_a2a18137, v3)

		if __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
			__wf_atom_a2a18137 = module3.GetGroundPos(__wf_atom_a2a18137)
		else
			v3 = v4
			__wf_atom_a2a18137 = groundAlignedSpawnPosRot
		end
	end

	__wf_atom_a2a18137.y -= 0.05
	v:SetMeshScale(v2, true)
	local entity = gRegion:CreateEntity(effects, __wf_atom_a2a18137, v3)
	gRegion:CreateEntity(spawneffects, __wf_atom_a2a18137, v3)
	local entity2 = gRegion:CreateEntity(morespawneffects, __wf_atom_a2a18137, v3)
	local v4 = 1

	while v4 > 0 and not __wf_atom_7e8ad928(entity) do
		entity:__wf_atom_a763aa1a(v4)
		Sleep(0)
		v4 -= __wf_atom_084b3e93() * 3
	end

	while v:__wf_atom_06a75154() do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(entity2) then
		entity2:Destroy()
	end

	while v4 < 1 and not __wf_atom_7e8ad928(entity) do
		entity:__wf_atom_a763aa1a(v4)
		Sleep(0)
		v4 += __wf_atom_084b3e93() * 2
	end
end

function SproutSpawnFx(object)
	local v

	if not __wf_atom_7e8ad928(object) then
		v = object:__wf_atom_50a7d83e()
	end

	if __wf_atom_7e8ad928(v) then
		return
	end

	local __wf_atom_a2a18137 = v:__wf_atom_a2a18137()
	gRegion:CreateEntity(spawneffects, __wf_atom_a2a18137, __wf_atom_80368bb1)
end

function SpiderSpawn(object)
	local v

	if not __wf_atom_7e8ad928(object) then
		v = object:__wf_atom_50a7d83e()
	end

	if __wf_atom_7e8ad928(v) then
		return
	end

	local __wf_atom_a2a18137 = v:__wf_atom_a2a18137()
	v:__wf_atom_921c1a5f(SpiderStart, true, 3, 3)
	v:__wf_atom_921c1a5f(SpiderLoop, false, 2, 2)
	Sleep(0)
	local v2 = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
	local v3 = Vector(0, 0, 0)
	gRegion:__wf_atom_c20d246a(__wf_atom_a2a18137, __wf_atom_a2a18137 + Vector(0, -20, 0), v2, nil, v3)
	v3.y += 3
	local __wf_atom_a2a18137_2 = v:__wf_atom_a2a18137()

	while __wf_atom_a2a18137_2.y >= v3.y do
		Sleep(0)
		__wf_atom_a2a18137_2 = v:__wf_atom_a2a18137()
	end

	v:__wf_atom_921c1a5f(SpiderEnd, false, 3, 1)
	v:__wf_atom_8914dfde("LandHeavy", 5)
	v:Attach(spawneffects, Symbol("GAME_C1_ROOT"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
end

local function fn(object) -- 4 equivalent calls inferred from this helper
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			return __wf_atom_d2b2176d:__wf_atom_e55d02aa()
		end
	end

	return nil
end

function RemovePowerSuitAbilities()
	local v = fn(gRegion:__wf_atom_c4f78a8f()) -- inferred equivalent call
	local v2 = {}

	if not __wf_atom_7e8ad928(v) then
		local __wf_atom_36b4a6e5 = v:__wf_atom_36b4a6e5()
		local v3 = Symbol("SOUL_STEAL")

		for _, v4 in ipairs(__wf_atom_36b4a6e5) do
			if not (__wf_atom_7e8ad928(v4) or v4:__wf_atom_660d6fd4(v3)) then
				table.insert(v2, v4:__wf_atom_37768748())
			end
		end

		if #v2 > 0 then
			for _, v4 in ipairs(v2) do
				v:__wf_atom_404a220d(true, v4)
				module.PlaySound(removeAbilitySound)
				Sleep(0.5)
			end
		end
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Wazzard"))

	while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled()) do
		Sleep(0)
	end

	if #v2 > 0 and not __wf_atom_7e8ad928(v) then
		v:__wf_atom_c62d97c1(false, v2)
	end
end

function RemovePowers(object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	module2.RegisterHideHudSelective(true)
	Sleep(0.5)

	if object:__wf_atom_7d4910e4() then
		_T.SetForceShowAbilities(true)
		_T.SetForceShowHUD(true)
		Sleep(0.5)
	end

	local v = fn(__wf_atom_c4f78a8f) -- inferred equivalent call
	local v2 = {}

	if not __wf_atom_7e8ad928(v) then
		local __wf_atom_36b4a6e5 = v:__wf_atom_36b4a6e5()
		local v3 = Symbol("SOUL_STEAL")

		for _, v4 in ipairs(__wf_atom_36b4a6e5) do
			if not (__wf_atom_7e8ad928(v4) or v4:__wf_atom_660d6fd4(v3)) then
				table.insert(v2, v4:__wf_atom_37768748())
			end
		end

		if #v2 > 0 then
			for _, v4 in ipairs(v2) do
				v:__wf_atom_404a220d(true, v4)

				if not object:__wf_atom_7d4910e4() then
					continue
				end

				module.PlaySound(removeAbilitySound)
				Sleep(1)
			end
		end
	end

	while gRegion:__wf_atom_c3b255b8() do
		Sleep(0)
	end

	module2.RegisterHideHudSelective(false)

	if object:__wf_atom_7d4910e4() then
		Sleep(0.5)
	end

	_T.SetForceShowHUD(false)
	_T.SetForceShowAbilities(false)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("Wazzard"))

	while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:IsKilled()) do
		Sleep(0)
	end

	if #v2 > 0 and not __wf_atom_7e8ad928(v) then
		v:__wf_atom_c62d97c1(false, v2)
	end
end

function GivePower(object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if object:__wf_atom_02fe8d73() ~= __wf_atom_c4f78a8f then
		return
	end

	local v = fn(__wf_atom_c4f78a8f) -- inferred equivalent call

	if not __wf_atom_7e8ad928(v) then
		local __wf_atom_c497b0ae = v:__wf_atom_c497b0ae(PowerIndex)

		if not __wf_atom_7e8ad928(__wf_atom_c497b0ae) and __wf_atom_c497b0ae:__wf_atom_31446586() then
			v:__wf_atom_c62d97c1(false, { __wf_atom_c497b0ae:__wf_atom_37768748() })
			module.PlaySound(restoreAbilitySound)
			object:PlaySound(acornDestroySound, false)
		end
	end

	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()
	print("Acorn " .. object:GetName() .. " on tree " .. __wf_atom_f7e7be53:GetName() .. " giving powers back to local player")
	local v2 = false

	for i = 1, #onDestroyOtherDecoCleanups do
		if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
			continue
		end

		local __wf_atom_bb3e7833 = __wf_atom_f7e7be53:__wf_atom_bb3e7833(onDestroyOtherDecoCleanups[i])

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_bb3e7833 == object then
			continue
		end

		print("Acorn " .. __wf_atom_bb3e7833:GetName() .. " removed in power giving process")
		gRegion:__wf_atom_dd1e4d10(__wf_atom_bb3e7833)
		v2 = true
	end

	if not v2 then
		print("No other acorns found to destroy! Either that was the last one, or there was an error.")

		for i = 1, #onDestroyOtherDecoCleanups do
			local all = gRegion:FindAll(onDestroyOtherDecoCleanups[i])

			if not (#all > 0) then
				continue
			end

			for j = 1, #all do
				if not (all[j]:__wf_atom_9af7625d(__wf_atom_f7e7be53) < 100) then
					continue
				end

				print("Acorn " .. all[j]:GetName() .. " removed as failsafe logic.")
				gRegion:__wf_atom_dd1e4d10(all[j])
			end
		end
	end
end

function AttachAcornToSelf(object)
	local v = fn(gRegion:__wf_atom_c4f78a8f()) -- inferred equivalent call

	if not __wf_atom_7e8ad928(v) then
		local __wf_atom_c497b0ae = v:__wf_atom_c497b0ae(PowerIndex)

		if __wf_atom_7e8ad928(__wf_atom_c497b0ae) or not __wf_atom_c497b0ae:__wf_atom_31446586() then
			return
		end
	end

	if not __wf_atom_7e8ad928(attachEntity) then
		local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

		if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
			object:Attach(attachEntity, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, 4)
		else
			local __wf_atom_f5bac0e4 = object:__wf_atom_f5bac0e4()
			local __wf_atom_fa6a8faf = object:__wf_atom_fa6a8faf()
			local __wf_atom_45c0553e = object:__wf_atom_45c0553e()
			__wf_atom_f7e7be53:Attach(
				attachEntity,
				__wf_atom_f5bac0e4,
				__wf_atom_fa6a8faf,
				__wf_atom_45c0553e,
				object,
				4
			)
		end
	end
end