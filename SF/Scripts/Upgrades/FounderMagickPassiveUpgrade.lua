local v = {
	Symbol("CC_GROUND_BRANCH_HEAVY"),
	Symbol("CC_GROUND_PERFECT_HEAVY"),
	Symbol("CC_RUN_BRANCH_HEAVY"),
	Symbol("CC_RUN_PERFECT_HEAVY"),
	Symbol("CC_AIR_HEAVY")
}

function OnSoulStealWithWeapon(object, object2, _, _, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.LastSoulStealEnergyType) then
		return
	end

	if
		gRegion:IsMaster()
		and __wf_atom_e919fb8e.LastSoulStealEnergyType == validEnergyType
		and not object:__wf_atom_d2b2176d():__wf_atom_c1f9859f(
			461,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			nil,
			upgradeSymbol
		)
	then
		object:__wf_atom_d2b2176d():AddUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, upgradeSymbol)
	end
end

function OnNewProjectileMagick(object, object2)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_197d43b1 = object2:__wf_atom_197d43b1()
	local v2 = false

	for _, v3 in pairs(v) do
		if __wf_atom_197d43b1 ~= v3 then
			continue
		end

		v2 = true
		break
	end

	if not v2 then
		return
	end

	local __wf_atom_95e72410 = object:__wf_atom_95e72410()

	if
		not __wf_atom_7e8ad928(__wf_atom_95e72410)
		and __wf_atom_95e72410:__wf_atom_d2b2176d():__wf_atom_c1f9859f(
			461,
			object:__wf_atom_1bb5b1ff(),
			object,
			nil,
			upgradeSymbol
		)
	then
		object2:__wf_atom_9fba31e6(3, heavyAttackdamageBuff)

		if not __wf_atom_7e8ad928(projAttachFxType) then
			object2:Attach(projAttachFxType, EMPTY_SYMBOL)
		end

		if not __wf_atom_7e8ad928(projBlastFxType) then
			object2:__wf_atom_5856e05f(projBlastFxType, false)
		end

		if gRegion:IsMaster() then
			__wf_atom_95e72410:__wf_atom_d2b2176d():RemoveUpgrade(
				461,
				0,
				1,
				object:__wf_atom_1bb5b1ff(),
				object,
				26,
				upgradeSymbol
			)
		end
	end
end

function ApplyUpgradeMagick(object, object2, _, _, _)
	local v2 = false
	local v3 = false

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2)) do
		local __wf_atom_c1f9859f = object:__wf_atom_d2b2176d():__wf_atom_c1f9859f(
			461,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			nil,
			upgradeSymbol
		)
		local __wf_atom_66088189 = object2:__wf_atom_66088189(1, 0)
		local __wf_atom_66088189_2 = object2:__wf_atom_66088189(1, 1)

		if v2 or not __wf_atom_c1f9859f then
			if v2 and not __wf_atom_c1f9859f then
				object2:__wf_atom_308a9a4d(upgradeSymbol)

				if not __wf_atom_7e8ad928(__wf_atom_66088189) then
					__wf_atom_66088189:__wf_atom_fd3ec680(
						paramName,
						materialSlot,
						unlitParam[1],
						unlitParam[2],
						unlitParam[3],
						unlitParam[4]
					)
					local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(gemAttachFxType)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end
				end

				if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
					__wf_atom_66088189_2:__wf_atom_fd3ec680(
						paramName,
						materialSlot,
						unlitParam[1],
						unlitParam[2],
						unlitParam[3],
						unlitParam[4]
					)
					local __wf_atom_bb3e7833 = __wf_atom_66088189_2:__wf_atom_bb3e7833(gemAttachFxType)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end
				end
			end
		else
			object2:__wf_atom_f354682d(upgradeSymbol, "OnNewProjectileMagick")

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				__wf_atom_66088189:__wf_atom_fd3ec680(
					paramName,
					materialSlot,
					litParam[1],
					litParam[2],
					litParam[3],
					litParam[4]
				)
				__wf_atom_66088189:Attach(gemAttachFxType, EMPTY_SYMBOL, gemAttachOffset, __wf_atom_80368bb1)
			end

			if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
				__wf_atom_66088189_2:__wf_atom_fd3ec680(
					paramName,
					materialSlot,
					litParam[1],
					litParam[2],
					litParam[3],
					litParam[4]
				)
				__wf_atom_66088189_2:Attach(gemAttachFxType, EMPTY_SYMBOL, gemOffhandAttachOffset, __wf_atom_80368bb1)
			end
		end

		local v4 = false

		if __wf_atom_c1f9859f and object2:__wf_atom_9f71ab59() then
			local __wf_atom_75a0566d = object2:__wf_atom_75a0566d()

			if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
				local __wf_atom_f824cfe6 = __wf_atom_75a0566d:__wf_atom_f824cfe6()

				if __wf_atom_f824cfe6 == 4 or __wf_atom_f824cfe6 == 16 then
					v4 = not object2:__wf_atom_160ce839() or false
				end
			end
		end

		if not v3 and v4 then
			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				__wf_atom_66088189:Attach(gemBurstFxType, EMPTY_SYMBOL, gemAttachOffset, __wf_atom_80368bb1)
			end

			if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
				__wf_atom_66088189_2:Attach(gemBurstFxType, EMPTY_SYMBOL, gemOffhandAttachOffset, __wf_atom_80368bb1)
			end
		end

		Sleep(0)
		v3 = v4
		v2 = __wf_atom_c1f9859f
	end
end

function UnapplyUpgradeMagick(object, object2, _, _, _)
	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_308a9a4d(upgradeSymbol)

		if not __wf_atom_7e8ad928(object) and gRegion:IsMaster() then
			object:__wf_atom_d2b2176d():RemoveUpgrade(
				461,
				0,
				1,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				upgradeSymbol
			)
		end
	end
end