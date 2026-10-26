local module = require("Lotus.Scripts.Libs.AudioLib")

function PlaySound(object)
	if useAttachParent then
		object = object:__wf_atom_3d96ddcd()
	elseif useInstigator then
		object = object:__wf_atom_7be51ede()
	end

	local sound = sounds[__wf_atom_5784a397(1, #sounds)]

	if is2D then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v in pairs(__wf_atom_ef7900cf) do
			v:__wf_atom_51eabc16(sound, false)
		end
	elseif not __wf_atom_7e8ad928(object) then
		object:PlaySound(sound, false, 1, replicate)
	end
end

function PlaySpeech(object)
	if useAttachParent then
		object = object:__wf_atom_3d96ddcd()
	elseif useInstigator then
		object = object:__wf_atom_7be51ede()
	end

	local sound = sounds[__wf_atom_5784a397(1, #sounds)]

	if not __wf_atom_7e8ad928(object) then
		object:PlaySpeech(sound, false, 1)
	end
end

function PlaySoundOnDamaged(instance, object)
	if #sounds == 0 or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) then
		return
	end

	if not __wf_atom_7e8ad928(activateOnTargetHitProxy) or activateOnOvershield then
		local v = false

		if not __wf_atom_7e8ad928(activateOnTargetHitProxy) then
			local __wf_atom_64c2ae79 = object:__wf_atom_64c2ae79()
			v = not __wf_atom_7e8ad928(__wf_atom_64c2ae79)
				and __wf_atom_64c2ae79:IsA(Type(activateOnTargetHitProxy))
				and true
				or false
		end

		if
			(v or not (activateOnOvershield and instance:IsA(__wf_atom_7e6ed5fa) and instance:__wf_atom_7470861b():__wf_atom_7faf4619() / instance:__wf_atom_7470861b():__wf_atom_2bf72530() > 1))
			and not v
		then
			return
		end
	end

	local __wf_atom_679ed446 = object:__wf_atom_679ed446()
	local v = not __wf_atom_7e8ad928(__wf_atom_679ed446)
		and __wf_atom_679ed446:IsA(__wf_atom_67c46eba)
		and __wf_atom_679ed446:__wf_atom_8efce136()
		and not __wf_atom_679ed446:IsA(__wf_atom_3d23b036)
		and 1
		or 0
	instance:PlaySound(sounds[__wf_atom_5784a397(1, #sounds)], false, 1, replicate, nil, v)
end

function PlaySoundOnHit(object, instance)
	if #sounds == 0 or __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object) then
		return
	end

	local v = not __wf_atom_7e8ad928(instance)
		and instance:IsA(__wf_atom_67c46eba)
		and instance:__wf_atom_8efce136()
		and not instance:IsA(__wf_atom_3d23b036)
		and 1
		or 0
	object:PlaySound(sounds[__wf_atom_5784a397(1, #sounds)], false, 1, replicate, nil, v)
end

function SoundShake(_)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local v = Random(soundDelay.maxValue, soundDelay.minValue)
	_T.ShakeSounds = {}
	local v2 = nil

	while true do
		if __wf_atom_7e8ad928(v2) then
			v -= __wf_atom_084b3e93()

			if v <= 0 then
				local sound = sounds[__wf_atom_5784a397(1, #sounds)]
				local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

				if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
					v2 = __wf_atom_c4f78a8f:__wf_atom_51eabc16(sound, false)
				end
			end
		end

		if __wf_atom_7e8ad928(v2) and not (#_T.ShakeSounds > 0) then
			postProcess:__wf_atom_54a04966(0)
		else
			local v3 = __wf_atom_7e8ad928(v2) and 0 or v2:__wf_atom_31aab74c() * shakeFactor

			for i = #_T.ShakeSounds, 0, -1 do
				local shakeSound = _T.ShakeSounds[i]

				if __wf_atom_7e8ad928(shakeSound) or __wf_atom_7e8ad928(shakeSound.soundInstance) then
					table.remove(_T.ShakeSounds, i)
				else
					local soundInstance = shakeSound.soundInstance
					local shakeFactor = shakeSound.shakeFactor or 1
					v3 = math.max(v3, soundInstance:__wf_atom_31aab74c() * shakeFactor)
				end
			end

			postProcess:__wf_atom_54a04966(v3)
			v = Random(soundDelay.maxValue, soundDelay.minValue)
		end

		Sleep(0)
	end
end

function AddShakeSound(object)
	if __wf_atom_7e8ad928(shakeSound) then
		print("ShakeSound is null")
		return
	end

	if delay > 0 then
		Sleep(delay)
	end

	local v

	if not is2D then
		v = object:GetPosition()
	end

	module.AddShakeSound(shakeSound, shakeFactor, v)
end