local v = Symbol("BlockingBehavior")

function PreDeathTeleport(instance)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, instance, 1)
	end

	instance:__wf_atom_921c1a5f(nil, false, 3, 2)
	Sleep(0)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local position = nil

	if destinationWpTag ~= EMPTY_SYMBOL then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(destinationWpTag)

		if not (__wf_atom_7e8ad928(destinationFxType) or __wf_atom_7e8ad928(__wf_atom_0a6a5887)) then
			position = __wf_atom_0a6a5887:GetPosition()
			gRegion:CreateEntity(
				destinationFxType,
				__wf_atom_0a6a5887:GetPosition(),
				__wf_atom_0a6a5887:__wf_atom_dc309f8a(),
				instance
			)
		end
	end

	Sleep(kneelTime)

	if despawnOnProximity then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local v2 = false

		while not (__wf_atom_7e8ad928(instance) or v2) do
			for _, v3 in ipairs(__wf_atom_ef7900cf) do
				if __wf_atom_7e8ad928(v3) or not proximityRange:Contains(v3:__wf_atom_8a6b8fc3(instance)) then
					continue
				end

				v2 = true
			end

			Sleep(0)
		end
	end

	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_9fba31e6(Symbol("POST_DEATH_ABILITY_ACTIVE"), 26, 6, 0)
	__wf_atom_7470861b:__wf_atom_77b5f32e(Symbol("POST_DEATH_ABILITY_ACTIVE"))
	__wf_atom_7470861b:__wf_atom_77fc7548(-1)
	Sleep(1)

	if not __wf_atom_7e8ad928(teleportOutFxType) then
		instance:Attach(teleportOutFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	local v2 = 0

	while v2 < 1 do
		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / 0.75, 0, 1)
		instance:__wf_atom_68f2c268(v2)
		Sleep(0)
	end

	instance:__wf_atom_8d98f2fc(false, false, false)
	instance:SetFaction(Symbol("Neutral"))

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, instance, 1)
		__wf_atom_30e3d82b:__wf_atom_c6afb966(0)
		__wf_atom_30e3d82b:__wf_atom_0a399e71(true, 0)
	end

	local position2 = instance:GetPosition()
	local v3 = position2 - Vector(0, 3, 0)
	local v4

	if not __wf_atom_7e8ad928(teleportMovingFXType) then
		v4 = gRegion:CreateEntity(teleportMovingFXType, v3, __wf_atom_80368bb1)
	end

	local v5 = 0

	while v5 < 1 do
		if not __wf_atom_7e8ad928(v4) then
			v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93() / 10, 0, 1)
			local v6 = __wf_atom_24a82b69(v5)
			local v7 = math.sin(3.141592653589793 * v6)
			v4:SetPosition(__wf_atom_f55d6358(v3, position, v6) * Vector(1, fxMoveHeight * -v7, 1) + Vector(0, position2.y, 0))
		end

		Sleep(0)
	end

	instance:Destroy()
end