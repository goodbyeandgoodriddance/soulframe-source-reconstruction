local module = require("Lotus.Scripts.Libs.EasingLib")

function StartCameraShake(object)
	local total = 0
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	Sleep(Delay)

	if Length(__wf_atom_c4f78a8f:__wf_atom_a2a18137() - object:__wf_atom_a2a18137()) > Radius then
		return
	end

	if damageLocalPlayer then
		local damageData = Engine.DamageData()
		damageData.baseAmount = damageAmount
		damageData:__wf_atom_7498285f(damageType, 1)
		damageData:__wf_atom_d6f4d914(procType, true)
		damageData:__wf_atom_6b472125(object)
		__wf_atom_c4f78a8f:__wf_atom_649bf33e(damageData)
	end

	while total < shakeTime do
		__wf_atom_8ad59546.postProcess:__wf_atom_54a04966(Abs(Sin(total * timeMod)) * shakeMultiplier)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	__wf_atom_8ad59546.postProcess:__wf_atom_54a04966(0)
end

function StartCameraShakeOnVolume(object)
	local total = 0
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		__wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		or __wf_atom_7e8ad928(postVolume)
		or not postVolume:IsA(__wf_atom_266572b1)
	then
		return
	end

	Sleep(Delay)

	if Length(__wf_atom_c4f78a8f:__wf_atom_a2a18137() - object:__wf_atom_a2a18137()) > Radius then
		return
	end

	local __wf_atom_e35eb214 = postVolume:__wf_atom_e35eb214()

	while total < shakeTime and not __wf_atom_7e8ad928(__wf_atom_e35eb214) do
		__wf_atom_e35eb214:__wf_atom_54a04966(Abs(Sin(total * timeMod)) * shakeMultiplier)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_e35eb214) then
		__wf_atom_e35eb214:__wf_atom_54a04966(0)
	end
end

function CameraShakeBounce(object)
	local total = 0
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	Sleep(Delay)

	if Length(__wf_atom_c4f78a8f:__wf_atom_a2a18137() - object:__wf_atom_a2a18137()) > Radius then
		return
	end

	while total < shakeTime do
		__wf_atom_8ad59546.postProcess:__wf_atom_54a04966(module.inElastic(
			total,
			shakeMultiplier,
			-shakeMultiplier,
			shakeTime,
			shakeAmp,
			shakePeriod
		))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	__wf_atom_8ad59546.postProcess:__wf_atom_54a04966(0)
end