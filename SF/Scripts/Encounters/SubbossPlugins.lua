local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("EE.Interface.Utilities")

local function fn(object)
	local result = {}

	if not isReinforcement then
		object = object:__wf_atom_26b04ea9() or object
	end

	if __wf_atom_7e8ad928(object) then
		return result
	end

	local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()
	module3.ShuffleTable(__wf_atom_6199ef01)

	for i = 1, math.min(maxAgentsToMark, #__wf_atom_6199ef01) do
		result[i] = __wf_atom_6199ef01[i]
	end

	return result
end

local function fn2(object) -- 1 equivalent call inferred from this helper
	if isReinforcement then
		object = object:__wf_atom_26b04ea9() or object
	end

	local __wf_atom_6199ef01 = object:__wf_atom_6199ef01()

	if #__wf_atom_6199ef01 == 0 then
		return nil
	end

	return __wf_atom_6199ef01[1]
end

function GiveTorch(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local v = fn2(__wf_atom_3d96ddcd) -- inferred equivalent call

	if __wf_atom_7e8ad928(v) then
		instance:Destroy()
		return
	end

	local __wf_atom_50a7d83e = v:__wf_atom_50a7d83e()

	if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled()) then
		local __wf_atom_d2b2176d = __wf_atom_50a7d83e:__wf_atom_d2b2176d()
		__wf_atom_50a7d83e:GiveItem(torchType, true)
		__wf_atom_d2b2176d:Equip(4, 0)
		__wf_atom_d2b2176d:__wf_atom_b9375444(false)
	end

	instance:Destroy()
end

function SubbossImmunity(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local v

	if isReinforcement then
		v = __wf_atom_3d96ddcd:__wf_atom_26b04ea9() or __wf_atom_3d96ddcd
	else
		v = __wf_atom_3d96ddcd
	end

	local __wf_atom_6199ef01 = v:__wf_atom_6199ef01()
	local v2

	if #__wf_atom_6199ef01 ~= 0 then
		v2 = __wf_atom_6199ef01[1]
	end

	if __wf_atom_7e8ad928(v2) then
		instance:Destroy()
		return
	end

	local __wf_atom_50a7d83e = v2:__wf_atom_50a7d83e()

	while not (__wf_atom_7e8ad928(v2) or v2:__wf_atom_351e924e()) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v2) then
		instance:Destroy()
		return
	end

	if not module.WaitForParentEncounterActive(__wf_atom_3d96ddcd) then
		instance:Destroy()
		return
	end

	local v3 = fn(__wf_atom_3d96ddcd)

	if #v3 > 0 then
		local v4 = {}

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and #v3 > 0 then
			module2.SetImmunity(__wf_atom_50a7d83e, true)
			__wf_atom_50a7d83e:__wf_atom_30e3d82b():__wf_atom_aa4361c1(Symbol("Guard"), __wf_atom_3d96ddcd, 5, 1)
			__wf_atom_50a7d83e:__wf_atom_30e3d82b():__wf_atom_4e4078ea(true)

			if not __wf_atom_7e8ad928(healthLinkSubbossAttachFX) then
				__wf_atom_50a7d83e:Attach(
					healthLinkSubbossProjectorFX,
					Symbol("GAME_C1_SPINE1"),
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_50a7d83e,
					1
				)
			end

			if not __wf_atom_7e8ad928(healthLinkActivateSound) then
				__wf_atom_50a7d83e:PlaySound(healthLinkActivateSound, false)
			end

			for i = #v3, 1, -1 do
				v4[i] = __wf_atom_50a7d83e:Attach(
					healthLinkSubbossAttachFX,
					Symbol("GAME_C1_SPINE5"),
					__wf_atom_28d5d4aa,
					Rotation(360 / #v3 * (i - 1), 0, 0),
					__wf_atom_50a7d83e,
					1
				)
				local __wf_atom_50a7d83e2 = v3[i]:__wf_atom_50a7d83e()
				__wf_atom_50a7d83e2:Attach(
					healthLinkAllyAttachFX,
					Symbol("GAME_C1_HEAD1"),
					Vector(0.02, 0.2, 0),
					Rotation(0, 0, 160),
					__wf_atom_50a7d83e2,
					1
				)
				__wf_atom_50a7d83e2:Attach(
					healthLinkAllyProjectorFX,
					Symbol("GAME_C1_SPINE1"),
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1,
					__wf_atom_50a7d83e2,
					1
				)
			end
		end

		while not __wf_atom_7e8ad928(v2) and #v3 > 0 do
			for i = #v3, 1, -1 do
				local v5 = v3[i]

				if __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v5:__wf_atom_50a7d83e()) then
					v4[i]:PlayTriggeredFade()
					table.remove(v4, i)
					table.remove(v3, i)
				elseif v5:__wf_atom_50a7d83e():IsKilled() or v5:__wf_atom_50a7d83e():__wf_atom_bedb4e3f() then
					local __wf_atom_50a7d83e2 = v5:__wf_atom_50a7d83e()
					local __wf_atom_bb3e7833 = __wf_atom_50a7d83e2:__wf_atom_bb3e7833(healthLinkAllyAttachFX)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:Destroy()
					end

					local __wf_atom_bb3e7833_2 = __wf_atom_50a7d83e2:__wf_atom_bb3e7833(healthLinkAllyProjectorFX)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
						__wf_atom_bb3e7833_2:Destroy()
					end

					v4[i]:PlayTriggeredFade()
					table.remove(v4, i)
					table.remove(v3, i)
				end
			end

			Sleep(0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			local __wf_atom_bb3e7833 = __wf_atom_50a7d83e:__wf_atom_bb3e7833(healthLinkSubbossProjectorFX)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			if not __wf_atom_7e8ad928(healthLinkDeactivateSound) then
				__wf_atom_50a7d83e:PlaySound(healthLinkDeactivateSound, false)
			end

			module2.SetImmunity(__wf_atom_50a7d83e, false)
			__wf_atom_50a7d83e:__wf_atom_30e3d82b():__wf_atom_42b767a2(Symbol("Guard"))
			__wf_atom_50a7d83e:__wf_atom_30e3d82b():__wf_atom_4e4078ea(false)
			__wf_atom_50a7d83e:__wf_atom_cecb2d55(
				Symbol("InvulnerabilityEnd"),
				gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_179042e1()
			)
		end
	end

	instance:Destroy()
end

function WaitForBoss(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local __wf_atom_6199ef01 = __wf_atom_3d96ddcd:__wf_atom_6199ef01()

	for _, v in ipairs(__wf_atom_6199ef01) do
		v:__wf_atom_50a7d83e():__wf_atom_52bae0cc(waitForBossLoopAnim, 4, true, true)
	end

	local v = {}

	while __wf_atom_7e8ad928(v) or #v == 0 do
		v = __wf_atom_3d96ddcd:__wf_atom_e529dedd()
		Sleep(0)
	end

	local v2 = v[1]

	while not (__wf_atom_7e8ad928(v2) or v2:__wf_atom_3634e6d2() > 0) do
		Sleep(0)
	end

	Sleep(1)

	for _, v3 in ipairs(__wf_atom_6199ef01) do
		if __wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v3:__wf_atom_50a7d83e()) then
			continue
		end

		v3:__wf_atom_50a7d83e():__wf_atom_921c1a5f(waitForBossEndAnim, false, 4, 1, true, 1)
	end

	instance:Destroy()
end

function FirePortOnSubbossDefeat(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	if useParentCount then
		__wf_atom_3d96ddcd = __wf_atom_3d96ddcd:__wf_atom_26b04ea9()
	end

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:__wf_atom_3634e6d2(true) > 0 do
		Sleep(0)
	end

	local position = __wf_atom_3d96ddcd:GetPosition()
	local nearestTagged = gRegion:FindNearestTagged(portTag, position)

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:FirePort(nameOfPortToFire)
	end

	instance:Destroy()
end