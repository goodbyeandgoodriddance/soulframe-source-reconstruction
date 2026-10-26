local v = Symbol("FOCUSED_SKILL_IGNORE_DODGE_COUNT")

local function fn(object, object2)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) then
		return 0
	end

	return (math.floor((object:__wf_atom_d2b2176d():__wf_atom_2a745663(
		0,
		461,
		object2:__wf_atom_1bb5b1ff(),
		object2,
		26,
		v
	))))
end

function ChargeHandler(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local v2 = Rotation()
	local focusedSkillPrimaryWeapon = nil
	local total = 0
	local v3 = 0
	local v4 = 0
	local v5 = 0

	while not __wf_atom_7e8ad928(__wf_atom_575542c8) do
		local __wf_atom_e919fb8e = __wf_atom_575542c8:__wf_atom_e919fb8e()

		if object == __wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance then
			focusedSkillPrimaryWeapon = __wf_atom_e919fb8e.FocusedSkillPrimaryWeapon
		elseif object == __wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance then
			focusedSkillPrimaryWeapon = __wf_atom_e919fb8e.FocusedSkillSecondaryWeapon
		end

		local focusedSkillStacks = __wf_atom_e919fb8e.FocusedSkillStacks
		local v6 = __wf_atom_7e8ad928(focusedSkillStacks) and 0 or focusedSkillStacks
		local v7 = __wf_atom_575542c8:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0) ~= focusedSkillPrimaryWeapon and 0
			or v6
		total += __wf_atom_084b3e93()

		if __wf_atom_7e8ad928(focusedSkillPrimaryWeapon) or not focusedSkillPrimaryWeapon:__wf_atom_ead6242d() then
			v3 = __wf_atom_421b01aa(v3 - __wf_atom_084b3e93() * 0.4, 0, 1)
		else
			v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() * 1, 0, 1)
		end

		if v4 < v7 then
			for _ = v4 + 1, v7 do
				object:Attach(chargeDecoType, EMPTY_SYMBOL, attachOffset, v2)
			end

			v5 = 1
		elseif v7 < v4 then
			v5 = 1
		end

		if v5 > 0 then
			local __wf_atom_f582136d = object:__wf_atom_f582136d(chargeDecoType)
			v4 = v7

			for i, v8 in ipairs(__wf_atom_f582136d) do
				if __wf_atom_7e8ad928(v8) then
					continue
				end

				v2 = v8:__wf_atom_45c0553e()

				if doRotationAdjustment and v7 > 0 then
					local v9 = 1 - v5
					v2.heading = __wf_atom_104bfe98(v2.heading, (i - 1) * 360 / v4 - 180, v9 * v9)
				else
					v2.heading = (i - 1) * 360 / 4 - 180
				end

				v8:__wf_atom_e310f01f(attachOffset, v2)
			end

			if doRotationAdjustment then
				v5 -= __wf_atom_084b3e93()
			end
		else
			v4 = v7
		end

		Sleep(0)
	end
end

local function fn2(object, p, object2)
	if gRegion:IsMaster() then
		if p > 1 then
			object:__wf_atom_d2b2176d():RemoveUpgrade(315, 3, 0.05 * (p - 1), object2:__wf_atom_1bb5b1ff(), object2)
			object:__wf_atom_d2b2176d():RemoveUpgrade(368, 3, 0.05 * (p - 1), object2:__wf_atom_1bb5b1ff(), object2)
		end

		object:__wf_atom_d2b2176d():AddUpgrade(315, 3, 0.05 * p, object2:__wf_atom_1bb5b1ff(), object2)
		object:__wf_atom_d2b2176d():AddUpgrade(368, 3, 0.05 * p, object2:__wf_atom_1bb5b1ff(), object2)
	end
end

local function fn3(object, p, object2)
	if gRegion:IsMaster() and p > 0 then
		object:__wf_atom_d2b2176d():RemoveUpgrade(315, 3, 0.05 * p, object2:__wf_atom_1bb5b1ff(), object2)
		object:__wf_atom_d2b2176d():RemoveUpgrade(368, 3, 0.05 * p, object2:__wf_atom_1bb5b1ff(), object2)
	end
end

function OnMeleeAttack(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if
		__wf_atom_7e8ad928(__wf_atom_6009c8ed)
		or __wf_atom_21ed1a39:__wf_atom_55da7898() ~= 5 and __wf_atom_21ed1a39:__wf_atom_55da7898() ~= 1
	then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.FocusedSkillStartedAttack = true
	__wf_atom_e919fb8e.FocusedSkillCasterLastWeapon = __wf_atom_21ed1a39
end

function SetFocusedSkillDecoType(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		return
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if
		__wf_atom_7e8ad928(__wf_atom_6009c8ed)
		or __wf_atom_21ed1a39:__wf_atom_55da7898() ~= 5 and __wf_atom_21ed1a39:__wf_atom_55da7898() ~= 1
	then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if __wf_atom_21ed1a39:__wf_atom_55da7898() == 5 then
		__wf_atom_e919fb8e.FocusedSkillPrimaryFXType = focusedSkillFXType
	else
		__wf_atom_e919fb8e.FocusedSkillSecondaryFXType = focusedSkillFXType
	end
end

function FocusedSkillUpdate(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_7b82e9e1 = object:__wf_atom_7b82e9e1(15)
	local v2 = false
	local v3 = false
	local count = 0
	local v4 = 0

	while
		not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillUpdateRunning)
		and __wf_atom_e919fb8e.FocusedSkillUpdateRunning
	do
		local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
		local v5 = fn(object, __wf_atom_35a10d3c)
		local focusedSkillStartedAttack = not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillStartedAttack)
			and __wf_atom_e919fb8e.FocusedSkillStartedAttack
		local v6 = not (object:__wf_atom_ae149090() or object:__wf_atom_cbe1b54d())
		local __wf_atom_7b82e9e1_2 = object:__wf_atom_7b82e9e1(4)
		local __wf_atom_ee41ca3e = object:__wf_atom_ee41ca3e()

		if not v2 and __wf_atom_7b82e9e1_2 then
			count += 1
		end

		if __wf_atom_ee41ca3e and not v3 then
			count += 1
		end

		if __wf_atom_7b82e9e1_2 and v5 < count then
			v6 = false
		end

		if v6 and not __wf_atom_7b82e9e1_2 then
			local __wf_atom_b4b1510d = object:__wf_atom_b4b1510d()
			__wf_atom_b4b1510d.y = 0

			if Length(__wf_atom_b4b1510d) > 0.5 then
				v4 -= __wf_atom_084b3e93()

				if v4 < 0 then
					v6 = false
				end
			else
				v4 = 0.5
			end
		end

		local __wf_atom_7b82e9e1_3 = object:__wf_atom_7b82e9e1(15)

		if __wf_atom_7b82e9e1_3 and not __wf_atom_7b82e9e1 then
			v6 = false
		end

		local focusedSkillStacks = __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillStacks) and 0
			or __wf_atom_e919fb8e.FocusedSkillStacks

		if focusedSkillStacks > 0 and not v6 then
			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryWeapon) then
				fn3(object, focusedSkillStacks, __wf_atom_e919fb8e.FocusedSkillPrimaryWeapon)
			end

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryWeapon) then
				fn3(object, focusedSkillStacks, __wf_atom_e919fb8e.FocusedSkillSecondaryWeapon)
			end

			focusedSkillStacks = 0
		end

		if focusedSkillStartedAttack and v6 then
			if focusedSkillStacks < 4 then
				focusedSkillStacks += 1

				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryWeapon) then
					fn2(object, focusedSkillStacks, __wf_atom_e919fb8e.FocusedSkillPrimaryWeapon)
				end

				if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryWeapon) then
					fn2(object, focusedSkillStacks, __wf_atom_e919fb8e.FocusedSkillSecondaryWeapon)
				end
			end

			count = 0
		end

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryFXType) then
			if
				__wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance)
				and __wf_atom_35a10d3c == __wf_atom_e919fb8e.FocusedSkillPrimaryWeapon
				and focusedSkillStacks > 0
			then
				__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance = object:Attach(
					__wf_atom_e919fb8e.FocusedSkillPrimaryFXType,
					EMPTY_SYMBOL,
					Vector(0, 0.2, 0),
					__wf_atom_80368bb1
				)
			elseif
				not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance)
				and (__wf_atom_35a10d3c ~= __wf_atom_e919fb8e.FocusedSkillPrimaryWeapon or focusedSkillStacks == 0)
			then
				__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance:PlayTriggeredFade()
				__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance = nil
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryFXType) then
			if
				__wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance)
				and __wf_atom_35a10d3c == __wf_atom_e919fb8e.FocusedSkillSecondaryWeapon
				and focusedSkillStacks > 0
			then
				__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance = object:Attach(
					__wf_atom_e919fb8e.FocusedSkillSecondaryFXType,
					EMPTY_SYMBOL,
					Vector(0, 0.2, 0),
					__wf_atom_80368bb1
				)
			elseif
				not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance)
				and (__wf_atom_35a10d3c ~= __wf_atom_e919fb8e.FocusedSkillSecondaryWeapon or focusedSkillStacks == 0)
			then
				__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance:PlayTriggeredFade()
				__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance = nil
			end
		end

		__wf_atom_e919fb8e.FocusedSkillStacks = focusedSkillStacks
		__wf_atom_e919fb8e.FocusedSkillStartedAttack = false
		Sleep(0)
		__wf_atom_7b82e9e1 = __wf_atom_7b82e9e1_3
		v3 = __wf_atom_ee41ca3e
		v2 = __wf_atom_7b82e9e1_2
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance) then
		__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance:PlayTriggeredFade()
		__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance = nil
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance) then
		__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance:PlayTriggeredFade()
		__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance = nil
	end
end

function OnFocusedSkillUpgradeApplied(object, object2, _, _, _)
	if
		__wf_atom_7e8ad928(object2)
		or __wf_atom_7e8ad928(object)
		or object2:__wf_atom_55da7898() ~= 5 and object2:__wf_atom_55da7898() ~= 1
	then
		return
	end

	local v2 = object2:__wf_atom_55da7898() == 5
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillStacks) and __wf_atom_e919fb8e.FocusedSkillStacks > 0 then
		local focusedSkillStacks = __wf_atom_e919fb8e.FocusedSkillStacks

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryWeapon) then
			fn3(object, focusedSkillStacks, __wf_atom_e919fb8e.FocusedSkillPrimaryWeapon)
		end

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryWeapon) then
			fn3(object, focusedSkillStacks, __wf_atom_e919fb8e.FocusedSkillSecondaryWeapon)
		end
	end

	__wf_atom_e919fb8e.FocusedSkillStacks = 0

	if v2 then
		__wf_atom_e919fb8e.FocusedSkillPrimaryWeapon = object2
		__wf_atom_e919fb8e.FocusedSkillPrimaryFXType = nil
		__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance = nil
	else
		__wf_atom_e919fb8e.FocusedSkillSecondaryWeapon = object2
		__wf_atom_e919fb8e.FocusedSkillSecondaryFXType = nil
		__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance = nil
	end

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillUpdateRunning)
		or not __wf_atom_e919fb8e.FocusedSkillUpdateRunning
	then
		__wf_atom_e919fb8e.FocusedSkillUpdateRunning = true
		object:__wf_atom_8a035cd5(Symbol("FocusedSkillUpdate"), false)
	end
end

function OnFocusedSkillUpgradeUnapplied(object, object2, _, _, _)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		object2 ~= __wf_atom_e919fb8e.FocusedSkillPrimaryWeapon
		or object2 ~= __wf_atom_e919fb8e.FocusedSkillSecondaryWeapon
	then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillStacks) and __wf_atom_e919fb8e.FocusedSkillStacks > 0 then
		local focusedSkillStacks = __wf_atom_e919fb8e.FocusedSkillStacks

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryWeapon) then
			fn3(object, focusedSkillStacks, __wf_atom_e919fb8e.FocusedSkillPrimaryWeapon)
		end

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryWeapon) then
			fn3(object, focusedSkillStacks, __wf_atom_e919fb8e.FocusedSkillSecondaryWeapon)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance) then
		__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance:PlayTriggeredFade()
		__wf_atom_e919fb8e.FocusedSkillPrimaryFXInstance = nil
	end

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance) then
		__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance:PlayTriggeredFade()
		__wf_atom_e919fb8e.FocusedSkillSecondaryFXInstance = nil
	end

	__wf_atom_e919fb8e.FocusedSkillStacks = 0

	if object2:__wf_atom_0395f752() == 5 then
		__wf_atom_e919fb8e.FocusedSkillPrimaryWeapon = nil
		__wf_atom_e919fb8e.FocusedSkillPrimaryFXType = nil
	else
		__wf_atom_e919fb8e.FocusedSkillSecondaryWeapon = nil
		__wf_atom_e919fb8e.FocusedSkillSecondaryFXType = nil
	end

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillPrimaryWeapon)
		and __wf_atom_7e8ad928(__wf_atom_e919fb8e.FocusedSkillSecondaryWeapon)
	then
		__wf_atom_e919fb8e.FocusedSkillUpdateRunning = false
	end
end