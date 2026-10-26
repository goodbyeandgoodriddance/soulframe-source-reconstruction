local function fn(object, object2, p)
	local damageData = Engine.DamageData()
	damageData.baseAmount = math.floor(p)
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_d6f4d914(19, true)
	damageData:__wf_atom_8e0ba0ec(-2)
	damageData:__wf_atom_34a8a27a(object2)
	damageData:__wf_atom_12cf5317(object:__wf_atom_a06d543c() * 10 * 1)
	object:__wf_atom_649bf33e(damageData)
end

function OdeProximityMineDamage(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local position = __wf_atom_3d96ddcd:GetPosition()
	local nearestTagged = gRegion:FindNearestTagged(Symbol("OdeTowerElectricRod"), position)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local total = 0
	local v = nil

	for _, v2 in ipairs(__wf_atom_ef7900cf) do
		if __wf_atom_7e8ad928(v2) or v2:IsKilled() or not object:__wf_atom_4b409d7b(v2) then
			continue
		end

		v = v2
	end

	while total <= aimingTime do
		if not object:__wf_atom_4b409d7b(v) then
			return
		end

		local v2 = total / aimingTime
		local v3 = __wf_atom_104bfe98(0, range, v2 * v2 * v2)
		gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), v3, Color(255, 0, 0), Rotation(0, 90, 0), 0)

		if not __wf_atom_7e8ad928(nearestTagged) then
			gRegion:__wf_atom_c189a462(nearestTagged:GetPosition(), position, Color(255, 0, 0), 0)
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(nearestTagged) then
		gRegion:__wf_atom_c189a462(nearestTagged:GetPosition(), position, Color(255, 0, 0), warningTime)
	end

	__wf_atom_3d96ddcd:__wf_atom_e792b90b(true)
	__wf_atom_3d96ddcd:Attach(threatGlowAttachment, EMPTY_SYMBOL)
	__wf_atom_3d96ddcd:Attach(threatSoundAttachment, EMPTY_SYMBOL)
	gRegion:__wf_atom_b5c21154(position + Vector(0, 1, 0), 10, Color(255, 0, 0), Rotation(0, 90, 0), warningTime)
	Sleep(warningTime)
	__wf_atom_3d96ddcd:Destroy()
end

function OnDestroyed(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_62e6d04b)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	local __wf_atom_6f4fd712 = __wf_atom_bb3e7833:__wf_atom_6f4fd712()

	if #__wf_atom_6f4fd712 > 0 then
		for _, v in pairs(__wf_atom_6f4fd712) do
			if __wf_atom_7e8ad928(v) then
				continue
			end

			if v:__wf_atom_e93896ba() == Symbol("TENNO") then
				fn(v, object, 1)
			else
				fn(v, object, damageAmount)
			end
		end
	end
end