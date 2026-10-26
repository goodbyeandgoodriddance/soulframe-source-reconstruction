local v = Symbol("FOUNDER_GS_PASSIVE_SPIRIT")
local v2 = Symbol("FOUNDER_GS_PASSIVE_GRACE")
local v3 = Symbol("FOUNDER_GS_PASSIVE_COURAGE")
local v4 = Symbol("FOUNDER_GS_PASSIVE_SPIRIT_PH")
local v5 = Symbol("FOUNDER_GS_PASSIVE_GRACE_PH")
local v6 = Symbol("FOUNDER_GS_PASSIVE_COURAGE_PH")
local v7 = Symbol("FOUNDER_GS_PASSIVE_SPIRIT_RUN")
local v8 = Symbol("FOUNDER_GS_PASSIVE_GRACE_RUN")
local v9 = Symbol("FOUNDER_GS_PASSIVE_COURAGE_RUN")
local v10 = Symbol("FOUNDER_GS_PASSIVE_SPIRIT_RUN_PH")
local v11 = Symbol("FOUNDER_GS_PASSIVE_GRACE_RUN_PH")
local v12 = Symbol("FOUNDER_GS_PASSIVE_COURAGE_RUN_PH")
local v13 = Symbol("CC_GROUND_PERFECT_HEAVY")
local v14 = Symbol("CC_GROUND_BRANCH_HEAVY")
local v15 = Symbol("CC_RUN_BRANCH_HEAVY")
local v16 = Symbol("CC_RUN_PERFECT_HEAVY")
local v17 = { 0.01, 0.01, 0.25, 0.5 }
local v18 = { 0.01, 0.01, 0.25, 0.5 }
local v19 = { 0.01, 0.01, 0.3, 0.3 }
local v20 = { 0.01, 0.01, 15, 0.5 }
local v21 = { 0.01, 0.01, 15, 0.5 }
local v22 = { 0.01, 0.01, 15, 0.3 }
local v23 = Symbol("ParallaxEnergyParamsB")

function OnSoulStealWithWeapon(object, object2, _, _, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.LastSoulStealEnergyType) then
		return
	end

	if gRegion:IsMaster() then
		if
			__wf_atom_e919fb8e.LastSoulStealEnergyType == 1
			and not object:__wf_atom_d2b2176d():__wf_atom_66066571(v)
		then
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v4,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v13
			)
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v14
			)
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v10,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v15
			)
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v7,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v16
			)
			object:__wf_atom_d2b2176d():AddUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, v)
		elseif
			__wf_atom_e919fb8e.LastSoulStealEnergyType == 2
			and not object:__wf_atom_d2b2176d():__wf_atom_66066571(v2)
		then
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v5,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v13
			)
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v2,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v14
			)
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v11,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v15
			)
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v8,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v16
			)
			object:__wf_atom_d2b2176d():AddUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, v2)
		elseif
			__wf_atom_e919fb8e.LastSoulStealEnergyType == 0
			and not object:__wf_atom_d2b2176d():__wf_atom_66066571(v3)
		then
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v6,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v13
			)
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v3,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v14
			)
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v12,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v15
			)
			object:__wf_atom_d2b2176d():__wf_atom_56004282(
				v9,
				366,
				3,
				0.2,
				object2:__wf_atom_1bb5b1ff(),
				object2,
				26,
				v16
			)
			object:__wf_atom_d2b2176d():AddUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, v3)
		end
	end
end

local function fn(object, object2)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v4)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v2)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v5)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v3)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v6)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v7)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v10)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v8)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v11)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v9)
	object:__wf_atom_d2b2176d():__wf_atom_c9ea4908(v12)

	if not __wf_atom_7e8ad928(object2) then
		object:__wf_atom_d2b2176d():RemoveUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, v)
		object:__wf_atom_d2b2176d():RemoveUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, v2)
		object:__wf_atom_d2b2176d():RemoveUpgrade(461, 0, 1, object2:__wf_atom_1bb5b1ff(), object2, 26, v3)
	end
end

function ApplyPassiveUpgrade(object, object2, _, _, _)
	local v24 = false
	local v25 = false
	local v26 = false
	local v27 = false

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_c1f9859f = object:__wf_atom_d2b2176d():__wf_atom_c1f9859f(
			461,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			nil,
			v
		)
		local __wf_atom_c1f9859f2 = object:__wf_atom_d2b2176d():__wf_atom_c1f9859f(
			461,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			nil,
			v2
		)
		local __wf_atom_c1f9859f3 = object:__wf_atom_d2b2176d():__wf_atom_c1f9859f(
			461,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			nil,
			v3
		)
		local __wf_atom_66088189 = object2:__wf_atom_66088189(1, 0)

		if v24 or not __wf_atom_c1f9859f then
			if v24 and not (__wf_atom_c1f9859f or __wf_atom_7e8ad928(__wf_atom_66088189)) then
				__wf_atom_66088189:__wf_atom_fd3ec680(v23, 0, v17[1], v17[2], v17[3], v17[4])
				local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(spiritAttachFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end
			end
		elseif not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_fd3ec680(v23, 0, v20[1], v20[2], v20[3], v20[4])
			__wf_atom_66088189:Attach(spiritAttachFxType, EMPTY_SYMBOL, spiritGemOffset, __wf_atom_80368bb1)
		end

		if v25 or not __wf_atom_c1f9859f2 then
			if v25 and not (__wf_atom_c1f9859f2 or __wf_atom_7e8ad928(__wf_atom_66088189)) then
				__wf_atom_66088189:__wf_atom_fd3ec680(v23, 1, v18[1], v18[2], v18[3], v18[4])
				local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(graceAttachFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end
			end
		elseif not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_fd3ec680(v23, 1, v21[1], v21[2], v21[3], v21[4])
			__wf_atom_66088189:Attach(graceAttachFxType, EMPTY_SYMBOL, graceGemOffset, __wf_atom_80368bb1)
		end

		if v26 or not __wf_atom_c1f9859f3 then
			if v26 and not (__wf_atom_c1f9859f3 or __wf_atom_7e8ad928(__wf_atom_66088189)) then
				__wf_atom_66088189:__wf_atom_fd3ec680(v23, 2, v19[1], v19[2], v19[3], v19[4])
				local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(courageAttachFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end
			end
		elseif not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_fd3ec680(v23, 2, v22[1], v22[2], v22[3], v22[4])
			__wf_atom_66088189:Attach(courageAttachFxType, EMPTY_SYMBOL, courageGemOffset, __wf_atom_80368bb1)
		end

		local v28 = false

		if __wf_atom_c1f9859f or __wf_atom_c1f9859f2 or __wf_atom_c1f9859f3 then
			if object2:__wf_atom_9f71ab59() then
				local __wf_atom_75a0566d = object2:__wf_atom_75a0566d()

				if not (__wf_atom_7e8ad928(__wf_atom_75a0566d) or __wf_atom_75a0566d:__wf_atom_dedeec57()) then
					local __wf_atom_f824cfe6 = __wf_atom_75a0566d:__wf_atom_f824cfe6()

					if __wf_atom_f824cfe6 == 4 or __wf_atom_f824cfe6 == 16 then
						v28 = object2:__wf_atom_745fda4a() and not object2:__wf_atom_160ce839() and true or false
					end
				end
			end

			if v27 and not v28 and gRegion:IsMaster() then
				fn(object, object2)
			end
		end

		if v27 or not v28 then
			if v27 and not (v28 or __wf_atom_7e8ad928(__wf_atom_66088189)) then
				local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(courageSwingFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Destroy()
				end

				local __wf_atom_bb3e7833_2 = __wf_atom_66088189:__wf_atom_bb3e7833(spiritSwingFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
					__wf_atom_bb3e7833_2:Destroy()
				end

				local __wf_atom_bb3e7833_3 = __wf_atom_66088189:__wf_atom_bb3e7833(graceSwingFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_3) then
					__wf_atom_bb3e7833_3:Destroy()
				end
			end
		elseif not __wf_atom_7e8ad928(__wf_atom_66088189) then
			if v26 then
				__wf_atom_66088189:Attach(courageSwingFxType, EMPTY_SYMBOL, courageGemOffset, __wf_atom_80368bb1)
			end

			if v24 then
				__wf_atom_66088189:Attach(spiritSwingFxType, EMPTY_SYMBOL, spiritGemOffset, __wf_atom_80368bb1)
			end

			if v25 then
				__wf_atom_66088189:Attach(graceSwingFxType, EMPTY_SYMBOL, graceGemOffset, __wf_atom_80368bb1)
			end
		end

		Sleep(0)
		v27 = v28
		v26 = __wf_atom_c1f9859f3
		v25 = __wf_atom_c1f9859f2
		v24 = __wf_atom_c1f9859f
	end
end

function UnapplyPassiveUpgrade(p, p2, _, _, _)
	if not __wf_atom_7e8ad928(p) and gRegion:IsMaster() then
		fn(p, p2)
	end
end