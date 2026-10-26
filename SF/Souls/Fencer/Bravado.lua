local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 0.1
local v2 = 0.5
local v3 = {}
local v4 = {}
local v5 = 10
local v6 = 5

local function fn(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v = 0.05
		v2 = 0.18
		v5 = 15
	end

	if p == 2 then
		v = 0.1
		v2 = 0.2
		v5 = 18
	end

	if p == 3 then
		v = 0.15
		v2 = 0.25
		v5 = 20
	end

	if p >= 4 then
		v = 0.2
		v2 = 0.3
		v5 = 25
	end

	v *= magikForceCalc
	v2 = __wf_atom_421b01aa(v2 * magikForceCalc, 0.25, 0.6)
	v5 *= magikForceCalc
	v6 = v5 / 3
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and __wf_atom_9a1e4ed3.distanceToTarget >= npcMinRange
		and __wf_atom_9a1e4ed3.distanceToTarget <= npcMaxRange
	then
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	else
		return 0
	end
end

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

function ActivateAbility(object, object2, _, p)
	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v7

	if not __wf_atom_7e8ad928(pactFxType) then
		v7 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	local v8 = object2:Attach(
		GuitarAttachType,
		Symbol("GAME_L1_WEAPON1"),
		__wf_atom_28d5d4aa,
		Rotation(0, 0, 0),
		object2
	)

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	object2:Attach(castFxType, EMPTY_SYMBOL)
	local v9 = object2:Attach(rangeDecoType, Symbol("GAME_C1_SPINE3"))

	if not __wf_atom_7e8ad928(v9) then
		v9:SetMeshScale(15)
	end

	fn(p, object2)
	object:__wf_atom_6a4cf64f()
	local position = object2:GetPosition()
	local all = gRegion:FindAll(__wf_atom_67c46eba, position, 0, 15)
	table.clear(v3)
	table.clear(v4)

	for i = 1, #all do
		local v10 = all[i]

		if __wf_atom_7e8ad928(v10) then
			continue
		end

		if v10:__wf_atom_129d1aba(object2) then
			if v10:__wf_atom_535d5cbb() then
				local attribute = v10:GetAttribute(0)
				local attribute2 = v10:GetAttribute(1)
				local v11 = {
					{ attribute = 23, amnt = v10:GetAttribute(2) },
					{ attribute = 22, amnt = attribute2 }
				}
				local v12 = {
					{ attribute = 21, amnt = attribute }
				}

				for j = 1, #v11 do
					local v13 = v11[j]

					if v12[1].amnt < v13.amnt then
						table.clear(v12)
						v12[1] = v13
					elseif v12[1].amnt == v13.amnt then
						table.insert(v12, v13)
					end
				end

				local v13 = v / #v12

				for j = 1, #v12 do
					v10:__wf_atom_d2b2176d():__wf_atom_3c88d02d(v5, v12[j].attribute, 2, v13 + 1)

					if v12[j].attribute == 21 then
						v10:__wf_atom_d50c5af7(
							attachFxCourageType,
							EMPTY_SYMBOL,
							__wf_atom_28d5d4aa,
							__wf_atom_80368bb1,
							v5
						)
					end

					if v12[j].attribute == 22 then
						v10:__wf_atom_d50c5af7(
							attachFxSpiritType,
							EMPTY_SYMBOL,
							__wf_atom_28d5d4aa,
							__wf_atom_80368bb1,
							v5
						)
					end

					if v12[j].attribute == 23 then
						v10:__wf_atom_d50c5af7(
							attachFxGraceType,
							EMPTY_SYMBOL,
							__wf_atom_28d5d4aa,
							__wf_atom_80368bb1,
							v5
						)
					end
				end

				table.insert(v3, v10)
			end
		else
			local v11 = v2

			if v10:__wf_atom_464a4772() then
				v11 = v2 / 3
			end

			v10:__wf_atom_986f733d(Symbol("Bravado"), 1 - v11)
			table.insert(v4, v10)
		end
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end

	local v10 = v5

	while v6 < v10 do
		if not (object2:__wf_atom_c138b19b(activateAnim) or __wf_atom_7e8ad928(v8)) then
			v8:Destroy()
		end

		Sleep(0)
		v10 -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(v4) then
		for i = 1, #v4 do
			local v11 = v4[i]

			if not __wf_atom_7e8ad928(v11) then
				v11:__wf_atom_558ce619(Symbol("Bravado"))
			end
		end
	end

	while v10 > 0 do
		Sleep(0)
		v10 -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:PlayTriggeredFade()
	end
end

function DeactivateAbility(_, _, _, _) end