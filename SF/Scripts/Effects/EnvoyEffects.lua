function ArmTransition(instance, p, p2, p3, p4, p5)
	local specificAvatar = specificAvatar
	local v = p2 or transitionTime
	local v2 = p3 or newArmSpeedMultiplier
	local v3 = p4 or isTemporary
	local v4 = p or useFeyArm
	local v5 = p5 or temporaryDelay

	if __wf_atom_7e8ad928(armTransitionFx) then
		armTransitionFx = Type("/SF/Fx/Characters/ForgetFire/ArmTransitionFX")
	end

	if useCinematicInstigator and instance:IsA(__wf_atom_804af126) then
		specificAvatar = instance:__wf_atom_02a7a2f4()
	end

	if __wf_atom_7e8ad928(specificAvatar) then
		specificAvatar = instance:__wf_atom_575542c8()
	end

	if __wf_atom_7e8ad928(specificAvatar) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			specificAvatar = __wf_atom_eab484a7:__wf_atom_50a7d83e()
		end
	end

	if __wf_atom_7e8ad928(specificAvatar) then
		return
	end

	local __wf_atom_b6b760b5 = specificAvatar:__wf_atom_b6b760b5()
	local v6

	if __wf_atom_7e8ad928(__wf_atom_b6b760b5) then
		v6 = false
	else
		local name = __wf_atom_b6b760b5:GetName()
		v6 = string.find(name, "Fem")
	end

	if v4 then
		if v6 then
			newArmDeco = Type("/SF/Characters/PlayerCharacters/ForgetFire/ForgetFireFemBlightArmDeco")
		else
			newArmDeco = Type("/SF/Characters/PlayerCharacters/ForgetFire/ForgetFireBlightArmDeco")
		end
	end

	local __wf_atom_be0bea4a = specificAvatar:__wf_atom_be0bea4a()
	local v7 = nil
	local v8 = nil

	for i = 1, #__wf_atom_be0bea4a do
		if not __wf_atom_be0bea4a[i]:HasTag(Symbol("IdolAvatarAttach")) then
			continue
		end

		v7 = __wf_atom_be0bea4a[i]
		v8 = v7:__wf_atom_e14d8a8c()
	end

	local __wf_atom_e55d02aa = specificAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local __wf_atom_6e6983c7 = __wf_atom_e55d02aa:__wf_atom_6e6983c7(1)

	if __wf_atom_7e8ad928(__wf_atom_6e6983c7) or __wf_atom_6e6983c7:IsA(newArmDeco) and skipTransitionIfSame then
		return
	end

	local v9 = {}
	local name = __wf_atom_6e6983c7:GetName()

	if string.find(name, "Orengal") then
		table.insert(
			v9,
			(specificAvatar:__wf_atom_bb3e7833(Type("/SF/Characters/PlayerCharacters/Orengal/OrengalClawDeco")))
		)
	end

	local v10

	if not __wf_atom_7e8ad928(specificAvatar) then
		v10 = specificAvatar:Attach(newArmDeco, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, specificAvatar)
	end

	if useDither and not __wf_atom_7e8ad928(v10) then
		v10:__wf_atom_68f2c268(1)
	end

	if not (useDither or __wf_atom_7e8ad928(v10)) then
		v10:__wf_atom_a763aa1a(1)
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end

	if not (__wf_atom_7e8ad928(armTransitionFx) or __wf_atom_7e8ad928(specificAvatar)) then
		specificAvatar:Attach(armTransitionFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, specificAvatar)
	end

	local v11 = 0

	while v11 < 1 do
		v11 = __wf_atom_421b01aa(v11 + __wf_atom_084b3e93() / v, 0, 1)
		local v12 = __wf_atom_24a82b69(v11)
		local v13 = __wf_atom_421b01aa(v12, 0, 1)
		local v14 = 1 - __wf_atom_421b01aa(v12 * v2, 0, 1)

		if useDither then
			if not __wf_atom_7e8ad928(__wf_atom_6e6983c7) then
				__wf_atom_6e6983c7:__wf_atom_68f2c268(v13)

				for i = 1, #v9 do
					if not __wf_atom_7e8ad928(v9[i]) then
						v9[i]:__wf_atom_68f2c268(v13)
					end
				end
			end

			if not __wf_atom_7e8ad928(v10) then
				v10:__wf_atom_68f2c268(v14)
			end
		else
			if not __wf_atom_7e8ad928(__wf_atom_6e6983c7) then
				__wf_atom_6e6983c7:__wf_atom_a763aa1a(v13)

				for i = 1, #v9 do
					if not __wf_atom_7e8ad928(v9[i]) then
						v9[i]:__wf_atom_a763aa1a(v13)
					end
				end
			end

			if not __wf_atom_7e8ad928(v10) then
				v10:__wf_atom_a763aa1a(v14)
			end
		end

		Sleep(0)
	end

	if __wf_atom_7e8ad928(specificAvatar) then
		return
	end

	if v3 then
		if delayWithEvent then
			specificAvatar:__wf_atom_8914dfde("RestoreArm", eventTimeOut)
		else
			Sleep(v5)
		end

		if not (__wf_atom_7e8ad928(armTransitionFx) or __wf_atom_7e8ad928(specificAvatar)) then
			specificAvatar:Attach(armTransitionFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, specificAvatar)
		end

		local v12 = 0

		while v12 < 1 do
			v12 = __wf_atom_421b01aa(v12 + __wf_atom_084b3e93() / v, 0, 1)
			local v13 = __wf_atom_24a82b69(v12)
			local v14 = __wf_atom_421b01aa(v13, 0, 1)
			local v15 = 1 - __wf_atom_421b01aa(v13 * v2, 0, 1)

			if useDither then
				if not __wf_atom_7e8ad928(__wf_atom_6e6983c7) then
					__wf_atom_6e6983c7:__wf_atom_68f2c268(v15)
				end

				if not __wf_atom_7e8ad928(v10) then
					v10:__wf_atom_68f2c268(v14)
				end
			else
				if not __wf_atom_7e8ad928(__wf_atom_6e6983c7) then
					__wf_atom_6e6983c7:__wf_atom_a763aa1a(v15)
				end

				if not __wf_atom_7e8ad928(v10) then
					v10:__wf_atom_a763aa1a(v14)
				end
			end

			Sleep(0)
		end

		if not __wf_atom_7e8ad928(v10) then
			gRegion:__wf_atom_dd1e4d10(v10)
		end

		if not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(specificAvatar)) then
			specificAvatar:Attach(v8, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	elseif not __wf_atom_7e8ad928(__wf_atom_6e6983c7) then
		gRegion:__wf_atom_dd1e4d10(__wf_atom_6e6983c7)
	end
end

function GenderAttach(instance)
	if not instance:IsA(__wf_atom_4ebf67cb) then
		instance = instance:__wf_atom_575542c8()
	end

	if __wf_atom_7e8ad928(instance) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			instance = __wf_atom_eab484a7:__wf_atom_50a7d83e()
		end
	end

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_b6b760b5 = instance:__wf_atom_b6b760b5()
	local v

	if __wf_atom_7e8ad928(__wf_atom_b6b760b5) then
		v = false
	else
		local name = __wf_atom_b6b760b5:GetName()
		v = string.find(name, "Fem")
	end

	if v then
		for _, v2 in ipairs(femaleDecos) do
			instance:Attach(v2, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	else
		for _, v2 in ipairs(maleDecos) do
			instance:Attach(v2, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end
end

function IdleAttach(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(idleFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	local position = Vector(0, 0, 0)
	local v = Vector(0, 0, 0)
	local v2 = WeakResource("/SF/Interface/Character.swf")
	local v3 = WeakResource("/SF/Interface/ColourCustomization.swf")
	local v4 = WeakResource("/SF/Interface/NewConversationMenu.swf")
	local v5 = false

	while not __wf_atom_7e8ad928(__wf_atom_575542c8) do
		local __wf_atom_1574f76f = __wf_atom_575542c8:__wf_atom_1574f76f()

		if __wf_atom_1574f76f then
			position = __wf_atom_575542c8:GetPosition()

			if position ~= v then
				__wf_atom_1574f76f = false
			end
		end

		local isVisible = __wf_atom_575542c8:IsVisible()

		if
			isVisible
			and (__wf_atom_575542c8:__wf_atom_f83a55c6() == 1 or __wf_atom_575542c8:__wf_atom_f43b1463() == 1)
		then
			isVisible = false
		end

		local v6 = __wf_atom_8e4fda44:FindMovie(v2) and true or false
		local v7 = __wf_atom_8e4fda44:FindMovie(v3) and true or v6
		local v8 = __wf_atom_8e4fda44:FindMovie(v4) and true or v7
		local v9 = 0.1

		if __wf_atom_1574f76f and not v5 and isVisible and not v8 then
			__wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(idleFxType)

			if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833 = __wf_atom_3d96ddcd:Attach(idleFxType, EMPTY_SYMBOL)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) and __wf_atom_bb3e7833:IsA(__wf_atom_032e921b) then
					__wf_atom_bb3e7833:__wf_atom_1be41a2f(object)
				end
			end

			v9 = 1
		elseif __wf_atom_1574f76f or not v5 then
			if v8 or not isVisible then
				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end

				v9 = 1
			end
		else
			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			v9 = 1
		end

		Sleep(v9)
		v5 = __wf_atom_1574f76f
		v = position
	end
end

function FemMeshSwap(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			__wf_atom_575542c8 = __wf_atom_eab484a7:__wf_atom_50a7d83e()
		end
	end

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local __wf_atom_b6b760b5 = __wf_atom_575542c8:__wf_atom_b6b760b5()

	if not __wf_atom_7e8ad928(__wf_atom_b6b760b5) then
		local name = __wf_atom_b6b760b5:GetName()
		string.find(name, "Fem")
	end

	object:__wf_atom_45cf0e1a(femMesh, false, false)
end