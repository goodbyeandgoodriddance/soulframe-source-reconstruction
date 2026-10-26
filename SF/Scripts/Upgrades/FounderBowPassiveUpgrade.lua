local v = Symbol("PERFECT_PROJECTILE")

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

function OnNewProjectileBow(object, object2)
	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object) or object2:__wf_atom_197d43b1() ~= v then
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
			object2:__wf_atom_5856e05f(projBlastFxType, true)
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

function ApplyUpgradeBow(object, object2, _, _, _)
	local v2 = false

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2)) do
		local __wf_atom_c1f9859f = object:__wf_atom_d2b2176d():__wf_atom_c1f9859f(
			461,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			nil,
			upgradeSymbol
		)
		local __wf_atom_66088189 = object2:__wf_atom_66088189(1, 1)
		local __wf_atom_66088189_2 = object2:__wf_atom_66088189(1, 0)

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
			object2:__wf_atom_f354682d(upgradeSymbol, "OnNewProjectileBow")

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				__wf_atom_66088189:__wf_atom_fd3ec680(
					paramName,
					materialSlot,
					litParam[1],
					litParam[2],
					litParam[3],
					litParam[4]
				)
				__wf_atom_66088189:Attach(gemAttachFxType, EMPTY_SYMBOL, gemOffhandAttachOffset, __wf_atom_80368bb1)
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
				__wf_atom_66088189_2:Attach(gemAttachFxType, EMPTY_SYMBOL, gemAttachOffset, __wf_atom_80368bb1)
			end
		end

		if __wf_atom_c1f9859f and object2:GetState() == 14 then
			__wf_atom_7e8ad928(__wf_atom_66088189_2)
		end

		Sleep(0)
		v2 = __wf_atom_c1f9859f
	end
end

function UnapplyUpgradeBow(object, object2, _, _, _)
	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_308a9a4d(upgradeSymbol)
	end

	if not __wf_atom_7e8ad928(object) and gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():RemoveUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, upgradeSymbol)
	end
end