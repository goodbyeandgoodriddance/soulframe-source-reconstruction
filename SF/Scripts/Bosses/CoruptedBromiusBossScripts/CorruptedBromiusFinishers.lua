local module = require("SF.Scripts.Effects.EnvoyEffects")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil
local v2 = Symbol("RemaningHeads")

local function fn(object, headBonesToHide, targetProxyToDisable)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(headBonesToHide) then
		return
	end

	for _, v3 in ipairs(headBonesToHide) do
		object:__wf_atom_83fac646(v3, __wf_atom_80368bb1, __wf_atom_28d5d4aa, Vector(0.001, 0.001, 0.001))
	end

	for _, v3 in ipairs(targetProxyToDisable) do
		object:__wf_atom_7470861b():__wf_atom_724ee596(v3, false)
	end
end

function HideArm()
	module.ArmTransition(v, true, armTransitionTime, armSpeedMult, true, transtionBackDelay)
end

function BromiusProgressFinisherFinished(object, object2, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	v = object2
	local __wf_atom_ccd337ec = object:__wf_atom_ccd337ec(v2)

	if __wf_atom_7e8ad928(__wf_atom_ccd337ec) then
		object:__wf_atom_cecb2d55(v2, 2)
	end

	object2:__wf_atom_8914dfde("HidePact", 1)
	object2:__wf_atom_8a035cd5(Symbol("HideArm"), false)
	object2:__wf_atom_8914dfde("RemoveHead", 6)

	if not __wf_atom_7e8ad928(object) then
		if not p then
			object:Attach(headRemovalVfx, headFxAttachBone, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			fn(object, headBonesToHide, targetProxyToDisable)
			object:SetBlackboardBool(postFinisherBlackBoardBoolSymbol, false)
		end

		object:__wf_atom_cecb2d55(v2, __wf_atom_ccd337ec - 1)
	end
end

function StartFightEnd(instance, object, p)
	if not gRegion:IsMaster() then
		return
	end

	if instance:IsA(vadagarBearAvatarType) then
		while instance:__wf_atom_40a4ba6c() do
			Sleep(0)
		end

		Sleep(0.1)
		local damageData = Engine.DamageData()
		damageData.baseAmount = instance:__wf_atom_c6f1f83d() + 10
		damageData:__wf_atom_6b472125(object)
		damageData:__wf_atom_7498285f(0, 1)
		instance:__wf_atom_649bf33e(damageData)
	else
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ButtSlam"))
		local flag

		if instance:__wf_atom_1c8f7b2d(__wf_atom_0a6a5887) >= 20 then
			flag = true
		else
			flag = false
		end

		while not __wf_atom_7e8ad928(instance) and instance:__wf_atom_40a4ba6c() do
			Sleep(0)
		end

		if flag then
			instance:Teleport(__wf_atom_0a6a5887:GetPosition(), instance:__wf_atom_dc309f8a())
			Sleep(0)
		end

		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(postSecondHeadRemovalCineTag)
		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("BromiusMidCorruptionFightDeco"))

		if not (__wf_atom_7e8ad928(__wf_atom_0a6a5887_2) or p) then
			__wf_atom_0a6a5887_2:__wf_atom_a3d2b66b(object, Symbol("Envoy"))
			__wf_atom_0a6a5887_2:__wf_atom_a3d2b66b(instance, Symbol("CorruptedBromius"))
			__wf_atom_0a6a5887_2:__wf_atom_a3d2b66b(__wf_atom_0a6a5887_3, Symbol("BromiusMidCorruption"))
			Sleep(0)
			__wf_atom_0a6a5887_2:StartRelative(
				Symbol("Envoy"),
				object:__wf_atom_a2a18137(),
				object:__wf_atom_2f2bada0()
			)
			instance:__wf_atom_8d98f2fc(false, false, false)
			__wf_atom_0a6a5887_3:SetVisibility(false)
			module2.WaitForCinematicToFinish(__wf_atom_0a6a5887_2)
			_T.AllHeadsRemoved = true
			print("FinalFinisher Completed, Fight ending now")
		end
	end
end