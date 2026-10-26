local v = Symbol("CC_GROUND_PERFECT_HEAVY")
local v2 = Symbol("CC_GROUND_BRANCH_HEAVY")
local v3 = Symbol("CC_RUN_PERFECT_HEAVY")
local v4 = Symbol("CC_RUN_BRANCH_HEAVY")

local function fn(object, object2, p)
	if not gRegion:IsMaster() then
		return
	end

	if p then
		object:AddUpgrade(368, 3, 1, object2:__wf_atom_1bb5b1ff(), object2)
		object:AddUpgrade(292, 3, 0.2, object2:__wf_atom_1bb5b1ff(), object2)
		object:AddUpgrade(292, 3, 0.3, object2:__wf_atom_1bb5b1ff(), object2, 26, v2)
		object:AddUpgrade(292, 3, 0.3, object2:__wf_atom_1bb5b1ff(), object2, 26, v)
		object:AddUpgrade(292, 3, 0.3, object2:__wf_atom_1bb5b1ff(), object2, 26, v4)
		object:AddUpgrade(292, 3, 0.3, object2:__wf_atom_1bb5b1ff(), object2, 26, v3)
	else
		object:RemoveUpgrade(368, 3, 1, object2:__wf_atom_1bb5b1ff(), object2)
		object:RemoveUpgrade(292, 3, 0.2, object2:__wf_atom_1bb5b1ff(), object2)
		object:RemoveUpgrade(292, 3, 0.3, object2:__wf_atom_1bb5b1ff(), object2, 26, v2)
		object:RemoveUpgrade(292, 3, 0.3, object2:__wf_atom_1bb5b1ff(), object2, 26, v)
		object:RemoveUpgrade(292, 3, 0.3, object2:__wf_atom_1bb5b1ff(), object2, 26, v4)
		object:RemoveUpgrade(292, 3, 0.3, object2:__wf_atom_1bb5b1ff(), object2, 26, v3)
	end
end

local function fn2(object, p)
	local __wf_atom_ca3e110b = object:__wf_atom_ca3e110b()

	for i = 3, 5 do
		if not (i < __wf_atom_ca3e110b) then
			continue
		end

		local __wf_atom_3d08948b = object:__wf_atom_3d08948b(i)

		if __wf_atom_7e8ad928(__wf_atom_3d08948b) or not __wf_atom_3d08948b:IsA(__wf_atom_0cf1ac41) then
			continue
		end

		if p then
			__wf_atom_3d08948b:__wf_atom_2a75bc9b(1)
		else
			__wf_atom_3d08948b:__wf_atom_2a75bc9b(0)
		end
	end
end

function DoSelfStagger(object)
	Sleep(0)
	Sleep(0)
	local damageData = Engine.DamageData()
	damageData.baseAmount = 0
	damageData:__wf_atom_6b472125(object)
	damageData:__wf_atom_d6f4d914(17, true)
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_12cf5317(object:__wf_atom_a06d543c() * -1)
	object:__wf_atom_649bf33e(damageData)
end

function OnSlam(object)
	local v5

	if __wf_atom_7e8ad928(object) or not object:__wf_atom_9f71ab59() then
		v5 = false
	else
		local __wf_atom_75a0566d = object:__wf_atom_75a0566d()

		if __wf_atom_7e8ad928(__wf_atom_75a0566d) then
			v5 = false
		else
			v5 = __wf_atom_75a0566d:__wf_atom_f824cfe6() == 1
		end
	end

	if v5 then
		object:__wf_atom_6f32f2cb(0)
		object:__wf_atom_0d8c36a3(300)
	end
end

function StartMod(object, object2, _, _, p)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_6f24c148 = object2:__wf_atom_6f24c148()
	local v5 = false
	local v6 = false

	while not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_d2b2176d)) do
		local __wf_atom_04eb25d8 = object2:__wf_atom_04eb25d8()
		local clipSize = object2:GetClipSize()

		if v5 or __wf_atom_04eb25d8 ~= 0 then
			if v5 and __wf_atom_04eb25d8 == clipSize then
				object2:__wf_atom_0d8c36a3(__wf_atom_6f24c148)
				v5 = false
			end
		else
			v5 = true
			local v7

			if __wf_atom_7e8ad928(object2) or not object2:__wf_atom_9f71ab59() then
				v7 = false
			else
				local __wf_atom_75a0566d = object2:__wf_atom_75a0566d()

				if __wf_atom_7e8ad928(__wf_atom_75a0566d) then
					v7 = false
				else
					v7 = __wf_atom_75a0566d:__wf_atom_f824cfe6() == 1
				end
			end

			if not v7 then
				object2:__wf_atom_0d8c36a3(10)

				if object:__wf_atom_8efce136() then
					object:__wf_atom_8a035cd5(Symbol("DoSelfStagger"), false)
				end
			end
		end

		local v7 = not (clipSize > 0) or __wf_atom_04eb25d8 / clipSize <= 0.67

		if v6 ~= v7 then
			if v7 then
				Sleep(0)
				Sleep(0)
				object:PlaySound(hotStateStartSound, false, 1, false)
				local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.ZapCasterOverheat = true
				fn(__wf_atom_d2b2176d, object2, true)
				fn2(object2, true)
			else
				local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.ZapCasterOverheat = nil
				fn(__wf_atom_d2b2176d, object2, false)
				fn2(object2, false)
			end

			v6 = v7
		end

		if
			object:__wf_atom_8efce136()
			and not v5
			and not object2:__wf_atom_9f71ab59()
			and __wf_atom_04eb25d8 <= 1
			and object:__wf_atom_7b82e9e1(26)
		then
			object2:__wf_atom_01e1d257(1)
			Sleep(0)
		end

		Sleep(0)
	end
end