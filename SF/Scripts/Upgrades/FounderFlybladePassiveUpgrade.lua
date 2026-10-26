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

function OrbitingGlaiveUpdate(object)
	while not object:__wf_atom_01084142() do
		Sleep(0)
	end

	object:__wf_atom_49c08f3b(extension)
end

function RemoveUpgradeOnThrown(object)
	Sleep(1)

	if not __wf_atom_7e8ad928(object) and gRegion:IsMaster() then
		local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(1)

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			object:__wf_atom_d2b2176d():RemoveUpgrade(
				461,
				0,
				1,
				__wf_atom_28224c27:__wf_atom_1bb5b1ff(),
				__wf_atom_28224c27,
				26,
				upgradeSymbol
			)
		end
	end
end

function OnNewProjectileFlyblade(object, instance)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object) or not instance:IsA(__wf_atom_a7ef6cab) then
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
		if not __wf_atom_7e8ad928(projAttachFxType) then
			instance:Attach(gemAttachFxType, EMPTY_SYMBOL, gemAttachOffset, __wf_atom_80368bb1)
		end

		instance:__wf_atom_8a035cd5(Symbol("OrbitingGlaiveUpdate"), false)
		__wf_atom_95e72410:__wf_atom_8a035cd5(Symbol("RemoveUpgradeOnThrown"), false)
	end
end

function ApplyUpgradeFlyblade(object, object2, _, _, _)
	local v = false
	local v2 = false

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

		if v or not __wf_atom_c1f9859f then
			if v and not __wf_atom_c1f9859f then
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
			object2:__wf_atom_f354682d(upgradeSymbol, "OnNewProjectileFlyblade")

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

		local v3 = false

		if __wf_atom_c1f9859f and object2:__wf_atom_9f71ab59() then
			local __wf_atom_75a0566d = object2:__wf_atom_75a0566d()

			if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
				local __wf_atom_f824cfe6 = __wf_atom_75a0566d:__wf_atom_f824cfe6()

				if __wf_atom_f824cfe6 == 4 or __wf_atom_f824cfe6 == 16 then
					v3 = not object2:__wf_atom_160ce839() or false
				end
			end
		end

		if v2 or not v3 then
			if v2 and not v3 then
				if not __wf_atom_7e8ad928(__wf_atom_66088189) then
					local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(heavyAttackFxType)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end
				end

				if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
					local __wf_atom_bb3e7833 = __wf_atom_66088189_2:__wf_atom_bb3e7833(heavyAttackFxType)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end
				end
			end
		else
			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				__wf_atom_66088189:Attach(gemBurstFxType, EMPTY_SYMBOL, gemAttachOffset, __wf_atom_80368bb1)
				__wf_atom_66088189:Attach(heavyAttackFxType, EMPTY_SYMBOL)
			end

			if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
				__wf_atom_66088189_2:Attach(gemBurstFxType, EMPTY_SYMBOL, gemOffhandAttachOffset, __wf_atom_80368bb1)
				__wf_atom_66088189_2:Attach(heavyAttackFxType, EMPTY_SYMBOL)
			end
		end

		Sleep(0)
		v2 = v3
		v = __wf_atom_c1f9859f
	end
end

function UnapplyUpgradeFlyblade(object, object2, _, _, _)
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