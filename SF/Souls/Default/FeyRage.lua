local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 5
local v2 = 35

local function fn(p, p2)
	local magikForceCalc = module.magikForceCalc(p2, p, mOwner)
	module.magikEnergyCalc(p2, p, mOwner)

	if p == 1 then
		v = 0.15
		v2 = 15
	elseif p == 2 then
		v = 0.25
		v2 = 18
	elseif p == 3 then
		v = 0.3
		v2 = 20
	else
		v = 0.4
		v2 = 22
	end

	v *= magikForceCalc
	v2 *= magikForceCalc
end

function NpcEvaluateAbility(_, _)
	return 0
end

function GetAbilityUpgradeLevelInfo()
	fn(_T.AbilityLevelQueryParms.Level, _T.AbilityLevelQueryParms.Avatar)
	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/DAMAGE",
		Value = v + 1,
		ValueUnit = "/Lotus/Language/Game/UNIT_MULTIPLIER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "DAMAGE REDUCTION",
		Value = 1.25,
		ValueUnit = "/Lotus/Language/Game/UNIT_MULTIPLIER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/ABILITY_RADIUS",
		Value = 16,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/POWER_DURATION",
		Value = v2,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function ActivateAbility(object, object2, _, p)
	fn(p, object2)
	local v3 = { allies = {}, enemies = {} }
	module.SetAbilityStats(object, mOwner, v3)
	module.EnableWeaponFiring(object2, mOwner, false)
	local isMaster = gRegion:IsMaster()
	local v4 = Symbol("FeyRageDuff")
	local v5 = Symbol("FeyRageReduc")

	if isMaster then
		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
		__wf_atom_d2b2176d:__wf_atom_56004282(v4, 366, 3, v)
		__wf_atom_d2b2176d:__wf_atom_56004282(v5, 46, 3, -0.25)
	end

	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	Sleep(0)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v6

	if not __wf_atom_7e8ad928(pactFxType) then
		v6 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Destroy()
	end

	if __wf_atom_7e8ad928((object2:__wf_atom_bb3e7833(attachFxType))) then
		mOwner:__wf_atom_7ccf4243(attachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	object2:Attach(WindType, EMPTY_SYMBOL, Vector(0, 0.75, 0), __wf_atom_80368bb1)
	mOwner:__wf_atom_d14eed1a()
	object:__wf_atom_6a4cf64f()
	module.RemoveCastImmunity(object2)
	object2:__wf_atom_2f3f52aa(5)
	local v7 = true

	while v2 > 0 do
		if v7 and not object2:__wf_atom_c138b19b(activateAnim) then
			module.EnableWeaponFiring(object2, mOwner, true)
			v7 = false
		end

		local position = object2:GetPosition()

		if isMaster then
			local all = gRegion:FindAll(__wf_atom_7e6ed5fa, position, 0, 16)
			local allies = {}
			local enemies = {}

			for _, v8 in ipairs(all) do
				local __wf_atom_18aa6e58 = v8:__wf_atom_18aa6e58()

				if v8:__wf_atom_129d1aba(object2) then
					if v8 ~= object2 and v8:__wf_atom_8a6b8fc3(object2) < 0 then
						if not v3.allies[__wf_atom_18aa6e58] then
							local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
							__wf_atom_d2b2176d:__wf_atom_56004282(v4, 366, 3, v)
							__wf_atom_d2b2176d:__wf_atom_56004282(v5, 46, 3, -0.25)
						end

						allies[__wf_atom_18aa6e58] = v8
						v3.allies[__wf_atom_18aa6e58] = nil
					end
				elseif v8:__wf_atom_8a6b8fc3(object2) <= 16 then
					local __wf_atom_30e3d82b = v8:__wf_atom_30e3d82b()

					if
						not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
						and __wf_atom_30e3d82b:__wf_atom_04ea4887()
						and not __wf_atom_30e3d82b:__wf_atom_b10cc64b()
						and __wf_atom_30e3d82b:__wf_atom_216d6edd() ~= object2
					then
						__wf_atom_30e3d82b:__wf_atom_f23858e5(object2)
						enemies[__wf_atom_18aa6e58] = v8
						v3.enemies[__wf_atom_18aa6e58] = nil
					end
				end
			end

			for _, ally in pairs(v3.allies) do
				if __wf_atom_7e8ad928(ally) then
					continue
				end

				local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
				__wf_atom_d2b2176d:__wf_atom_066a9716(v4, 366, 3, v)
				__wf_atom_d2b2176d:__wf_atom_066a9716(v5, 46, 3, -0.25)
			end

			for _, enemy in pairs(v3.enemies) do
				if __wf_atom_7e8ad928(enemy) then
					continue
				end

				local __wf_atom_30e3d82b = enemy:__wf_atom_30e3d82b()

				if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_216d6edd() ~= object2 then
					continue
				end

				__wf_atom_30e3d82b:__wf_atom_f23858e5(nil)
				__wf_atom_30e3d82b:__wf_atom_920a5a62()
			end

			v3.allies = allies
			v3.enemies = enemies
		end

		Sleep(0.2)
		v2 -= 0.2
	end
end

function DeactivateAbility(p, object, _, p2)
	fn(p2, object)
	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if gRegion:IsMaster() then
		local v3 = Symbol("FeyRageDuff")
		local v4 = Symbol("FeyRageReduc")

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:__wf_atom_066a9716(v3, 366, 3, v)
			__wf_atom_d2b2176d:__wf_atom_066a9716(v4, 46, 3, -0.25)
		end

		for _, ally in pairs(abilityStats.allies) do
			if __wf_atom_7e8ad928(ally) then
				continue
			end

			local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:__wf_atom_066a9716(v3, 366, 3, v)
			__wf_atom_d2b2176d:__wf_atom_066a9716(v4, 46, 3, -0.25)
		end

		for _, enemy in pairs(abilityStats.enemies) do
			if __wf_atom_7e8ad928(enemy) then
				continue
			end

			local __wf_atom_30e3d82b = enemy:__wf_atom_30e3d82b()

			if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_216d6edd() ~= object then
				continue
			end

			__wf_atom_30e3d82b:__wf_atom_f23858e5(nil)
			__wf_atom_30e3d82b:__wf_atom_920a5a62()
		end
	end

	object:__wf_atom_2f3f52aa(0)

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	module.EnableWeaponFiring(object, mOwner, true)
end