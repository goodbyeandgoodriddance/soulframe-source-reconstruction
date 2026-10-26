local v = 0
local v2 = false
local v3 = Symbol("HEAL_POTION_HEAL_PCT")
local v4 = Symbol("HEAL_POTION_HEAL_MIN")
local v5 = Symbol("HealingPotion")

function Evaluate(object, _)
	if
		__wf_atom_7e8ad928(object)
		or object:IsKilled()
		or object:__wf_atom_bedb4e3f()
		or object:__wf_atom_c6f1f83d() >= object:GetMaxHealth()
	then
		return false
	end

	if object:__wf_atom_58dabbc7() or object:__wf_atom_47fbd15c() then
		return false
	end

	return not object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true)
end

local function fn(p, object, p2)
	if __wf_atom_7e8ad928(object) then
		return p
	end

	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(
		p,
		473,
		nil,
		nil,
		26,
		Symbol("HEAL_FROM_CAST")
	)

	if not __wf_atom_7e8ad928(p2) and p2 > 0 and p2 < 1 then
		local v6 = object:GetMaxHealth(true) * p2

		if v6 < __wf_atom_2a745663 then
			__wf_atom_2a745663 = v6
		end
	end

	return __wf_atom_2a745663
end

function HealPrc(object, object2)
	if gRegion:IsMaster() and not (object:IsKilled() or object:__wf_atom_bedb4e3f() or __wf_atom_7e8ad928(object2)) then
		local maxHealth = object:GetMaxHealth(true)
		local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0.3, 473, nil, nil, 26, v3)
		local v6 = maxHealth * __wf_atom_2a745663
		local __wf_atom_2a745663_2 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(50, 473, nil, nil, 26, v4)

		if debugEnabled then
			print("Player Max Health: " .. tostring(maxHealth) .. " Player Current Health: " .. tostring(object:__wf_atom_c6f1f83d()))
			print("Player Inital Heal Amount: " .. tostring(v6) .. " HealPerct: " .. tostring(__wf_atom_2a745663) .. " Min Heal: " .. tostring(__wf_atom_2a745663_2))
		end

		if v6 < __wf_atom_2a745663_2 then
			v6 = __wf_atom_2a745663_2
		end

		object:Heal(object, v6, object)

		if debugEnabled then
			print("Final HealAmount: " .. tostring(v6) .. " Final Health: " .. tostring(object:__wf_atom_c6f1f83d()))
		end

		object:__wf_atom_d2b2176d():__wf_atom_5106368a(object2:__wf_atom_e14d8a8c())
	end
end

function HealOverTime(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local maxHealth = object:GetMaxHealth()
	__wf_atom_e919fb8e.StartHealOverTime = true

	while
		gRegion:IsMaster()
		and not object:IsKilled()
		and not object:__wf_atom_bedb4e3f()
		and object:__wf_atom_c6f1f83d() ~= maxHealth
		or healDuration <= 0
	do
		if __wf_atom_e919fb8e.Damaged then
			print("Heal Ended")
			break
		else
			object:Heal(object, __wf_atom_e919fb8e.healOverTimeAmount, object)
			Sleep(healOverTimeSpeed)
		end
	end

	__wf_atom_e919fb8e.StartHealOverTime = false
	__wf_atom_e919fb8e.ChugCount = nil
	__wf_atom_e919fb8e.healOverTimeAmount = nil
	object:__wf_atom_3ede53b4(v5)
end

function ChughHeal(object, object2)
	object:__wf_atom_51cd6126(v5, "OnDamaged")

	if gRegion:IsMaster() and not (object:IsKilled() or object:__wf_atom_bedb4e3f() or __wf_atom_7e8ad928(object2)) then
		object:__wf_atom_d2b2176d():__wf_atom_5106368a(object2:__wf_atom_e14d8a8c())
		local maxHealth = object:GetMaxHealth(true)
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.Damaged = false

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.ChugCount) then
			__wf_atom_e919fb8e.ChugCount = 0
			__wf_atom_e919fb8e.healOverTimeAmount = fn(healOverTimeBaseAmount, object)

			if debugEnabled then
				print("HealOverTimeAmount: " .. tostring(__wf_atom_e919fb8e.healOverTimeAmount))
			end
		else
			__wf_atom_e919fb8e.ChugCount += 1
			v = fn(chugIncreasebaseAmount * __wf_atom_e919fb8e.ChugCount, object)
			__wf_atom_e919fb8e.healOverTimeAmount += __wf_atom_e919fb8e.healOverTimeAmount * v

			if debugEnabled then
				print("ChunkIncreasePrc: " .. tostring(v))
				print("HealOverTimeAmount: " .. tostring(__wf_atom_e919fb8e.healOverTimeAmount))
			end
		end

		object:Heal(object, fn(maxHealth * chunkHealPrc, object, 0.6), object)

		if not __wf_atom_e919fb8e.StartHealOverTime then
			object:__wf_atom_8a035cd5(Symbol("HealOverTime"), false)
		end
	end
end

function Activate(object, p)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		__wf_atom_e55d02aa:__wf_atom_244b2bb5()
	end

	object:__wf_atom_2596a9fb(Symbol("<GEAR_HOTKEY_0>"))
	local flag = true
	local v6 = false

	if not __wf_atom_7e8ad928(animation) then
		if __wf_atom_d2b2176d:__wf_atom_0cc2386b(0) == 0 then
			__wf_atom_d2b2176d:__wf_atom_f5bb7c84(0, 1)
			v6 = true
		end

		local __wf_atom_33b8b73f = object:__wf_atom_33b8b73f(animation, false, 2, 1, true, false)
		object:Attach(castFx, EMPTY_SYMBOL)

		if animEvent:__wf_atom_8598f3a9() then
			__wf_atom_33b8b73f = animation:__wf_atom_091354f5(animEvent) * __wf_atom_33b8b73f
		end

		if __wf_atom_33b8b73f > 0 then
			local motionControl = object:MotionControl()
			local __wf_atom_e384400a = motionControl:__wf_atom_e384400a()
			motionControl:__wf_atom_99fc7a82(true)
			object:__wf_atom_aeb02c14(healingInputFilter)

			while
				not __wf_atom_7e8ad928(object)
				and (__wf_atom_33b8b73f > 0 and not v2 and object:__wf_atom_c138b19b(animation) or object:__wf_atom_3c281634(animation))
			do
				Sleep(0)
				__wf_atom_33b8b73f -= __wf_atom_084b3e93()
			end

			if __wf_atom_7e8ad928(object) then
				flag = false
			else
				object:__wf_atom_33b8b73f(nil, false, 0, 0, false, false)
				motionControl:__wf_atom_99fc7a82(__wf_atom_e384400a)
				object:__wf_atom_cf966a74(healingInputFilter)
			end
		end
	end

	if flag then
		if DoPercentHeal then
			HealPrc(object, p)
		elseif DoChugHeal then
			ChughHeal(object, p)
		end

		if not __wf_atom_7e8ad928(animation) then
			while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(animation) do
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) and v6 then
				__wf_atom_d2b2176d:__wf_atom_f5bb7c84(0, 0)
			end

			Sleep(0.3)
		end

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_6a4cf64f()
		end
	end
end

function OnDamaged(object)
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()
	object:__wf_atom_e919fb8e()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_9d766292:__wf_atom_871aeeac() == 7 then
		return
	end

	__wf_atom_e919fb8e.Damaged = true
	v2 = true
end