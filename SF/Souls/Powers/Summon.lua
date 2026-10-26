mSpawnedAgents = {}
local module = require("Lotus.Scripts.Libs.Query")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and npcRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
		and __wf_atom_7d789620:__wf_atom_0e4e9fc6(object2, maxAgentSearchRange, false, false, summonAgentType) < spawnCount
		and __wf_atom_7d789620:__wf_atom_faef7b5d(true) < __wf_atom_7d789620:__wf_atom_eac910df()
	then
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	else
		return 0
	end
end

function Unsummon(instance)
	if not __wf_atom_7e8ad928(instance) then
		instance:__wf_atom_58c8ffec(Symbol("UNSUMMON"), true, 3, 3, true)
		instance:Destroy()
	end
end

function PostAvatarSummonsMonitor(object)
	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and #mSpawnedAgents > 0 do
		Sleep(0)
	end

	if #mSpawnedAgents > 0 then
		for _, v in pairs(mSpawnedAgents) do
			if __wf_atom_7e8ad928(v) then
				continue
			end

			if unsummonWhenKilled then
				local __wf_atom_50a7d83e = v:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("Unsummon"), false)
				end
			else
				v:__wf_atom_aa4361c1(Symbol("Flee"), object)
			end
		end
	end
end

local function fn(object)
	local total = 0

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and #mSpawnedAgents > 0 do
		for i = #mSpawnedAgents, 1, -1 do
			if not (__wf_atom_7e8ad928(mSpawnedAgents[i]) or mSpawnedAgents[i]:__wf_atom_50a7d83e():IsKilled()) then
				continue
			end

			table.remove(mSpawnedAgents, i)
		end

		if summonTimeoutTimer > 0 and summonTimeoutTimer < total then
			break
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end
end

function ActivateAbility(object, object2, _, _)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if __wf_atom_7e8ad928(__wf_atom_7d789620) or not gRegion:IsMaster() then
		return false
	end

	local v = spawnCount - __wf_atom_7d789620:__wf_atom_0e4e9fc6(
		object2,
		maxAgentSearchRange,
		false,
		false,
		summonAgentType
	)

	if v <= 0 then
		return false
	end

	local __wf_atom_28ce676a = __wf_atom_7d789620:__wf_atom_28ce676a()
	local position = object2:GetPosition()
	local __wf_atom_a06d543c = object2:__wf_atom_a06d543c()
	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if spawnNearTarget and not __wf_atom_7e8ad928(avatar) then
		position = avatar:GetPosition()
		__wf_atom_a06d543c = __wf_atom_e97f3142(avatar:__wf_atom_4e50d390())
	end

	__wf_atom_28ce676a:__wf_atom_267bfc41(position, spawnRange, 2)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(5, 5, -5)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(30)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_9b7f7161(position, __wf_atom_a06d543c, 1, 1, 0, 0, false)
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	local positions = module.GetPositions(v, __wf_atom_28ce676a)
	object2:__wf_atom_8914dfde(
		"Summon",
		object2:__wf_atom_921c1a5f(summonAnim, false, 3, summonAnimType, not interruptible)
	)

	if hiddenWhileSummonsActive and not (__wf_atom_7e8ad928(object2) or object2:__wf_atom_c138b19b(summonAnim)) then
		object2:SetVisibility(false)
		object2:SetDisableGravity(true)
		object2:__wf_atom_d1b42aad(false)
		object2:__wf_atom_30964595(false)
	end

	Sleep(summonStartDelay)

	if __wf_atom_7e8ad928(object2) then
		return false
	end

	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return false
	end

	object2:__wf_atom_d2b2176d():__wf_atom_56004282(Symbol("SummonDamageReduction"), 46, 3, -mDamageReduc)
	local secondaryScriptArgs = SF.SecondaryScriptArgs(true, true)
	secondaryScriptArgs:__wf_atom_a17e41c6(object2)
	object:__wf_atom_e6831c5c(mOwner, Symbol("SelfHeal"), secondaryScriptArgs)
	local __wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()

	while
		#mSpawnedAgents < v
		and not __wf_atom_7e8ad928(object2)
		and (not interruptible or object2:__wf_atom_c138b19b(summonAnim))
	do
		local randomPointInRangeOnNav

		if __wf_atom_7e8ad928(positions) or __wf_atom_7e8ad928(positions[#mSpawnedAgents + 1]) then
			randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(
				position,
				spawnRange.minValue,
				spawnRange.maxValue,
				true,
				0.5
			)
		else
			randomPointInRangeOnNav = positions[#mSpawnedAgents + 1]
		end

		if not __wf_atom_7e8ad928(spawnFX) then
			gRegion:CreateEntity(spawnFX, randomPointInRangeOnNav, __wf_atom_80368bb1)
		end

		if __wf_atom_7e8ad928(randomPointInRangeOnNav) then
			continue
		end

		if useInstigatorLevel then
			spawnLevel = __wf_atom_421b01aa(
				object2:__wf_atom_68de036a() + instigatorLevelDifference,
				1,
				object2:__wf_atom_68de036a()
			)
		end

		local __wf_atom_80368bb1 = __wf_atom_80368bb1

		if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.entity) then
			__wf_atom_80368bb1 = __wf_atom_fa8d0177(randomPointInRangeOnNav, __wf_atom_9a1e4ed3.entity:GetPosition())
		end

		local __wf_atom_e93896ba = object2:__wf_atom_e93896ba()
		local __wf_atom_402b3832 = __wf_atom_7d789620:__wf_atom_402b3832(
			summonAgentType,
			randomPointInRangeOnNav,
			__wf_atom_80368bb1,
			__wf_atom_e93896ba,
			spawnLevel,
			spawnAnims[math.random(1, #spawnAnims)]
		)

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			if not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.entity) then
				__wf_atom_402b3832:StormTarget(__wf_atom_9a1e4ed3.entity)
			end

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_76724198()) then
				__wf_atom_30e3d82b:__wf_atom_76724198():__wf_atom_97f955c1(__wf_atom_402b3832)
			end
		end

		__wf_atom_402b3832:__wf_atom_30b587a4()
		table.insert(mSpawnedAgents, __wf_atom_402b3832)
		Sleep(spawningDelayRange:__wf_atom_ff1686f2())
	end

	if hiddenWhileSummonsActive then
		while not __wf_atom_7e8ad928(object2) and object2:__wf_atom_c138b19b(summonAnim) do
			Sleep(0)
		end

		object2:SetVisibility(false)
		object2:SetDisableGravity(true)
		object2:__wf_atom_d1b42aad(false)
		object2:__wf_atom_30964595(false)
	end

	if #mSpawnedAgents > 0 then
		object2:__wf_atom_8a035cd5(Symbol("PostAvatarSummonsMonitor"), false)

		if waitUntilSummonsAreKilled then
			fn(object2)
		end
	end
end

function DeactivateAbility(_, object, _, _)
	Sleep(summonEndDelay)

	if not __wf_atom_7e8ad928(object) then
		if reappearNearPlayer then
			local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

			if __wf_atom_7e8ad928(__wf_atom_7d789620) then
				return false
			end

			local __wf_atom_28ce676a = __wf_atom_7d789620:__wf_atom_28ce676a()
			local __wf_atom_4e9476e3 = __wf_atom_7d789620:__wf_atom_4e9476e3(object:__wf_atom_a2a18137())
			local position = __wf_atom_4e9476e3:GetPosition()
			local v = __wf_atom_e97f3142(__wf_atom_4e9476e3:__wf_atom_4e50d390())
			__wf_atom_28ce676a:__wf_atom_267bfc41(position, reappearRange, 1)
			__wf_atom_28ce676a:__wf_atom_62a3e89b(1, 2, -2)
			__wf_atom_28ce676a:__wf_atom_4a7833f4()
			__wf_atom_28ce676a:__wf_atom_655394dc()
			__wf_atom_28ce676a:__wf_atom_06c7577b()
			__wf_atom_28ce676a:__wf_atom_7e9d12f8(30)
			__wf_atom_28ce676a:__wf_atom_9b7f7161(position, v, 1, 1, 0, 0, false)
			local positions = module.GetPositions(1, __wf_atom_28ce676a)
			local flag = false
			local v2

			if __wf_atom_7e8ad928(positions) or #positions == 0 then
				if gRegion:__wf_atom_2202ffb6():__wf_atom_3c37bceb(position, reappearRange.maxValue) then
					v2 = position
					flag = true
				else
					v2 = position
				end
			else
				v2 = positions[1]
				flag = true
			end

			if flag then
				local __wf_atom_0d7d47e6 = object:__wf_atom_0d7d47e6(v2)
				local v3 = __wf_atom_fa8d0177(__wf_atom_0d7d47e6, position)
				v3.pitch = 0
				object:Teleport(__wf_atom_0d7d47e6, v3)
			end
		end

		if hiddenWhileSummonsActive then
			object:SetVisibility(true)
			object:SetDisableGravity(false)
			object:__wf_atom_d1b42aad(true)
			object:__wf_atom_30964595(true)
		end

		if not __wf_atom_7e8ad928(summonEndAnim) then
			object:__wf_atom_921c1a5f(summonEndAnim, false, 3)
		end

		object:__wf_atom_d2b2176d():__wf_atom_066a9716(Symbol("SummonDamageReduction"), 46, 3, -mDamageReduc)
	end
end