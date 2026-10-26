function HackIdle(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	local v = object:Attach(attachEffect, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)
	Sleep(1)

	while not __wf_atom_7e8ad928(v) and object:__wf_atom_f63d17c0() do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v) then
		v:Destroy()
	end
end

function PositionMarker(instance)
	if gGameRules:IsA(__wf_atom_1316e0c2) then
		if not __wf_atom_7e8ad928(instance) then
			instance:Destroy()
		end
	else
		local __wf_atom_f7e7be53 = instance:__wf_atom_f7e7be53()

		if __wf_atom_7e8ad928(__wf_atom_f7e7be53) or not __wf_atom_f7e7be53:IsA(__wf_atom_4ebf67cb) then
			return
		end

		if __wf_atom_f7e7be53 ~= instance:__wf_atom_3d96ddcd() then
			instance:__wf_atom_dc5956fc(__wf_atom_f7e7be53, Symbol())
		end

		local position = __wf_atom_f7e7be53:GetPosition()
		local __wf_atom_7470861b = __wf_atom_f7e7be53:__wf_atom_7470861b()
		local __wf_atom_bf9d0dc4 = __wf_atom_7470861b:__wf_atom_bf9d0dc4(1)
		local v = (math.max(
			__wf_atom_f7e7be53:EyePosition().y,
			__wf_atom_f7e7be53:__wf_atom_1c374cc9(__wf_atom_bf9d0dc4).y
		) + 0.3 - position.y) / __wf_atom_f7e7be53:__wf_atom_c082fc3d()

		if __wf_atom_f7e7be53:__wf_atom_a586ea4c(WeakResource("/Lotus/Types/Enemies/Corpus/Spaceman/AIWeek/NullifierCapBaseHitProxy")) then
			v += 0.5
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v2 = not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
			and __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_84479917()
			and 5
			or v
		instance:__wf_atom_e310f01f(Vector(0, v2, 0), __wf_atom_80368bb1)
		instance:Attach(markerAddedEffect, EMPTY_SYMBOL)
		instance:PlaySound(markerSoundEffect, false)
		local total = 0

		while not (__wf_atom_7e8ad928(__wf_atom_f7e7be53) or __wf_atom_7e8ad928(__wf_atom_7470861b)) do
			local __wf_atom_f808eed9 = __wf_atom_7470861b:__wf_atom_f808eed9()
			local __wf_atom_bedb4e3f = __wf_atom_7470861b:__wf_atom_bedb4e3f()

			if __wf_atom_f808eed9 <= 3 or __wf_atom_bedb4e3f then
				local v3 = __wf_atom_f808eed9 - 3

				if __wf_atom_bedb4e3f then
					v3 = total * 0.5
				end

				local v4 = 1 - math.abs((math.sin(v3 * 2 * 3.141592653589793)))
				local v5 = Color(255, 56, 52, 255)
				local __wf_atom_104bfe98 = Color(0, 0, 0, 0):__wf_atom_104bfe98(v5, v4)
				instance:__wf_atom_8cd234d5(__wf_atom_104bfe98, __wf_atom_104bfe98)
			end

			total += __wf_atom_084b3e93()
			Sleep(0)
		end
	end
end