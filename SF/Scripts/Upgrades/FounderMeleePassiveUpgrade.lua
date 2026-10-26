local v = Symbol("CC_GROUND_PERFECT_HEAVY")
local v2 = Symbol("CC_GROUND_BRANCH_HEAVY")
local v3 = Symbol("CC_RUN_PERFECT_HEAVY")
local v4 = Symbol("CC_RUN_BRANCH_HEAVY")

function OnSoulStealWithWeapon(object, object2, _, _, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.LastSoulStealEnergyType) then
		return
	end

	if
		gRegion:IsMaster()
		and __wf_atom_e919fb8e.LastSoulStealEnergyType == validEnergyType
		and not object:__wf_atom_d2b2176d():__wf_atom_66066571(upgradeSymbol)
	then
		object:__wf_atom_d2b2176d():__wf_atom_56004282(
			upgradeSymbolPerfectHeavy,
			366,
			3,
			heavyAttackdamageBuff,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			26,
			v
		)
		object:__wf_atom_d2b2176d():__wf_atom_56004282(
			upgradeSymbol,
			366,
			3,
			heavyAttackdamageBuff,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			26,
			v2
		)
		object:__wf_atom_d2b2176d():__wf_atom_56004282(
			upgradeSymbolPerfectHeavyRun,
			366,
			3,
			heavyAttackdamageBuff,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			26,
			v3
		)
		object:__wf_atom_d2b2176d():__wf_atom_56004282(
			upgradeSymbolRun,
			366,
			3,
			heavyAttackdamageBuff,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			26,
			v4
		)
		object:__wf_atom_d2b2176d():AddUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, upgradeSymbol)
	end
end

function ApplyPassiveUpgrade(object, object2, _, _, _)
	local v5 = false
	local v6 = false

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_c1f9859f = object:__wf_atom_d2b2176d():__wf_atom_c1f9859f(
			461,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			nil,
			upgradeSymbol
		)
		local __wf_atom_66088189 = object2:__wf_atom_66088189(1, 0)

		if v5 or not __wf_atom_c1f9859f then
			if v5 and not (__wf_atom_c1f9859f or __wf_atom_7e8ad928(__wf_atom_66088189)) then
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
		elseif not __wf_atom_7e8ad928(__wf_atom_66088189) then
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

		local v7 = false

		if __wf_atom_c1f9859f then
			if object2:__wf_atom_9f71ab59() then
				local __wf_atom_75a0566d = object2:__wf_atom_75a0566d()

				if not (__wf_atom_7e8ad928(__wf_atom_75a0566d) or __wf_atom_75a0566d:__wf_atom_dedeec57()) then
					local __wf_atom_f824cfe6 = __wf_atom_75a0566d:__wf_atom_f824cfe6()

					if __wf_atom_f824cfe6 == 4 or __wf_atom_f824cfe6 == 16 then
						v7 = object2:__wf_atom_745fda4a() and not object2:__wf_atom_160ce839() and true or false
					end
				end
			end

			if v6 and not v7 and gRegion:IsMaster() then
				object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(upgradeSymbol)
				object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(upgradeSymbolPerfectHeavy)
				object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(upgradeSymbolRun)
				object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(upgradeSymbolPerfectHeavyRun)
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

		if v6 or not v7 then
			if v6 and not (v7 or __wf_atom_7e8ad928(__wf_atom_66088189)) then
				local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(virtueSwingFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end
			end
		elseif not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:Attach(gemBurstFxType, EMPTY_SYMBOL, gemAttachOffset, __wf_atom_80368bb1)
			__wf_atom_66088189:Attach(virtueSwingFxType, EMPTY_SYMBOL)
		end

		Sleep(0)
		v6 = v7
		v5 = __wf_atom_c1f9859f
	end
end

function UnapplyPassiveUpgrade(object, object2, _, _, _)
	if not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(object) and gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(upgradeSymbol)
		object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(upgradeSymbolPerfectHeavy)
		object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(upgradeSymbolRun)
		object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(upgradeSymbolPerfectHeavyRun)
		object:__wf_atom_d2b2176d():RemoveUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, upgradeSymbol)
	end
end