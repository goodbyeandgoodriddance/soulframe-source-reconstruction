function LoreMoteMovement(object)
	local position = object:GetPosition()
	Vector()
	local v = position
	local v2 = 0

	while not __wf_atom_7e8ad928(object) do
		local v3 = Time()
		local v4 = __wf_atom_084b3e93()
		v2 = math.max(v2 - v4, 0)
		local v5 = Noise(v3 * 0.3)
		local v6 = Noise(7 + v3 * 0.3)
		local v7 = Noise(11 + v3 * 0.3)
		local v8 = Vector(v5, v6, v7)
		local v9 = Vector()
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local v10 = __wf_atom_c4f78a8f:GetPosition() + Vector(0, 1, 0)
			v10.y = v.y
			local v11 = v10 - v
			local v12 = Length(v11)

			if v12 < 10 then
				if v12 < 5 and v2 <= 0 then
					object:PlaySound(scurrySound, false)
					v2 = math.random(3, 10)
				end

				local v13 = v11 / v12 * -1
				local v14 = math.pow(1 - v12 / 10, 5)
				local v15 = __wf_atom_edfe0d73(v13, Vector(0, 1, 0)) * __wf_atom_104bfe98(1, 3, v14) * Noise(31 + v3 * 0.4)
				v15.y += Noise(97 + v3 * 0.4) * __wf_atom_104bfe98(1, 2, v14)
				v9 = (v13 + v15) * v14 * 10
			end
		end

		local v10 = __wf_atom_104bfe98(1, 10, Noise(17 + v3 * 0.2))
		local v11 = position - v
		local v12 = Length(v11)

		if v12 > 0.01 then
			v11 = v11 / v12 * 0.15
		end

		v = v + (v8 + v11) * v4 * v10 + v9 * v4
		object:SetPosition(v)
		Sleep(0)
	end
end