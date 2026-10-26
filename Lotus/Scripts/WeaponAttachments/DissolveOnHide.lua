local v = Symbol("PinchAtten")
local v2 = Symbol("PinchLength")
local v3 = Symbol("AxisVector")
local v4 = Symbol("Size")

local function fn(object)
	local __wf_atom_3de89c8e = object:__wf_atom_3de89c8e(0)
	local v5 = Vector(0, 0, 1)
	local v6

	if __wf_atom_7e8ad928(__wf_atom_3de89c8e) then
		v6 = 1
	else
		v6 = __wf_atom_3de89c8e:__wf_atom_b90af225(v2, 1)
		v5.x = __wf_atom_3de89c8e:__wf_atom_b90af225(v3, 1)
		v5.y = __wf_atom_3de89c8e:__wf_atom_b90af225(v3, 2)
		v5.z = __wf_atom_3de89c8e:__wf_atom_b90af225(v3, 3)
	end

	local v7 = (v6 <= 0 or v6 > 10) and 1 or v6

	if Length(v5) > 5 then
		v5 = Vector(0, 0, 1)
	end

	return v7, v5
end

function DissolveOnHide(object, p)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	object:__wf_atom_f582136d(__wf_atom_8d0b7f88)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()
	local v5 = p or object:__wf_atom_a5040fdf() == __wf_atom_392793db

	if
		not __wf_atom_7e8ad928(__wf_atom_f7e7be53)
		and __wf_atom_f7e7be53:IsA(__wf_atom_7e6ed5fa)
		and __wf_atom_f7e7be53:__wf_atom_8efce136()
		and not v5
	then
		object:PlaySound(hideSound, false, 0, false)
	end

	local v6, v7 = fn(object)
	local v8

	if not v5 then
		object:Attach(dissolveEffects, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)
		v8 = object:Attach(projType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)

		if not __wf_atom_7e8ad928(v8) then
			v8:SetMaterialParam(v2, v6)
			v8:SetMaterialParam(v4, v6)
			v8:SetMaterialParam(v3, v7.x, v7.y, v7.z)
		end
	end

	local v9 = Symbol("ManageVisibilityOnEquipmentChange")
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

	for i = 1, #__wf_atom_f582136d do
		__wf_atom_f582136d[i]:__wf_atom_6d11d81e(v3)
		__wf_atom_f582136d[i]:__wf_atom_6d11d81e(v2)

		if __wf_atom_f582136d[i]:HasTag(v9) then
			__wf_atom_f582136d[i]:SetVisibility(false, true)
		end
	end

	local __wf_atom_f582136d2 = object:__wf_atom_f582136d(__wf_atom_afd78c4b)

	for i = 1, #__wf_atom_f582136d2 do
		if not __wf_atom_7e8ad928(__wf_atom_f582136d2[i]) then
			__wf_atom_f582136d2[i]:Disable()
		end
	end

	local v10 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, v7)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(particleType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = object:Attach(particleType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, v10, __wf_atom_21ed1a39)
	end

	local dissolveTime2 = dissolveTime * object:__wf_atom_f83a55c6()

	if v5 and not overrideInstantToOff then
		dissolveTime2 = dissolveTime
	end

	local v11 = Vector()

	while dissolveTime2 < dissolveTime and not __wf_atom_7e8ad928(object) do
		local v12 = dissolveTime2 / dissolveTime
		object:SetMaterialParam(v, (1 - v12) * 0.5)

		for i = 1, #__wf_atom_f582136d do
			if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
				__wf_atom_f582136d[i]:__wf_atom_a763aa1a((math.min(1, v12 * 3)))
			end
		end

		if not __wf_atom_7e8ad928(v8) then
			v8:SetMaterialParam(v, (1 - v12) * 0.5)
		end

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			local v13 = v6 * v12
			v11.x = v13 * v7.x
			v11.y = v13 * v7.y
			v11.z = v13 * v7.z
			__wf_atom_bb3e7833:__wf_atom_e310f01f(v11, v10)
		end

		Sleep(0)
		dissolveTime2 += __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_a763aa1a(1)
		object:SetMaterialParam(v, 0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Disable()
	end

	for i = 1, #__wf_atom_f582136d2 do
		if not __wf_atom_7e8ad928(__wf_atom_f582136d2[i]) then
			__wf_atom_f582136d2[i]:Disable()
		end
	end
end

function MaterializeOnShow(object, p, _)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	local v5 = object:__wf_atom_06adb5a9(v, 1) * 0.5
	local v6 = (not object:IsVisible() or v5 > 1) and 0 or v5
	object:__wf_atom_f582136d(__wf_atom_8d0b7f88)
	local v7 = Symbol("ManageVisibilityOnEquipmentChange")
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

	for i = 1, #__wf_atom_f582136d do
		__wf_atom_f582136d[i]:__wf_atom_6d11d81e(v3)
		__wf_atom_f582136d[i]:__wf_atom_6d11d81e(v2)

		if __wf_atom_f582136d[i]:HasTag(v7) then
			__wf_atom_f582136d[i]:SetVisibility(true, true)
		end
	end

	local v8 = (0.5 - v6) / 0.5
	object:__wf_atom_a763aa1a(0)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()
	local v9 = p or object:__wf_atom_a5040fdf() == __wf_atom_392793db

	if
		not __wf_atom_7e8ad928(__wf_atom_f7e7be53)
		and __wf_atom_f7e7be53:IsA(__wf_atom_7e6ed5fa)
		and __wf_atom_f7e7be53:__wf_atom_8efce136()
		and not v9
	then
		object:PlaySound(showSound, false, 0, false)
	end

	local v10, v11 = fn(object)
	local v12 = v9 or math.abs(v6 - 0.25) < 0.01
	local v13

	if not v12 then
		v13 = object:Attach(projType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)
		object:Attach(dissolveEffects, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)
	end

	if forceDissolveEffects then
		object:Attach(dissolveEffects, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_21ed1a39)
	end

	if not __wf_atom_7e8ad928(v13) then
		v13:SetMaterialParam(v2, v10)
		v13:SetMaterialParam(v4, v10)
		v13:SetMaterialParam(v3, v11.x, v11.y, v11.z)
	end

	local v14 = dissolveInTime * v8
	local v15 = v12 and not overrideInstantToOff and 0 or v14
	local v16 = Vector()

	while v15 > 0 and not __wf_atom_7e8ad928(object) do
		local v17 = 0.5 * (1 - v15 / dissolveInTime)
		object:SetMaterialParam(v, 1 - v17)

		for i = 1, #__wf_atom_f582136d do
			if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
				__wf_atom_f582136d[i]:__wf_atom_a763aa1a(v15 / dissolveInTime)
			end
		end

		if not __wf_atom_7e8ad928(v13) then
			v13:SetMaterialParam(v, 1 - v17)
		end

		if not __wf_atom_7e8ad928(nil) then
			local v18 = v10 * v17 * 2.4
			v16.x = v18 * v11.x
			v16.y = v18 * v11.y
			v16.z = v18 * v11.z;
			(nil):__wf_atom_e310f01f(v16, __wf_atom_80368bb1)
		end

		Sleep(0)
		v15 -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(object) then
		object:SetMaterialParam(v, 0.5)
		object:__wf_atom_a763aa1a(0)
	end
end

function InstantHolster(object)
	local creator = object:GetCreator()
	Sleep(0)
	local __wf_atom_b6b760b5 = object:__wf_atom_b6b760b5()

	if __wf_atom_7e8ad928(__wf_atom_b6b760b5) then
		return
	end

	local __wf_atom_ee03557f = __wf_atom_b6b760b5:__wf_atom_ee03557f()
	local __wf_atom_0aa77159 = __wf_atom_b6b760b5:__wf_atom_0aa77159()
	Sleep(0)
	Vector()
	local v5 = Rotation()
	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local v6 = Vector()

	for _ = 1, math.floor((__wf_atom_421b01aa(
		math.max(__wf_atom_ee03557f.y - __wf_atom_0aa77159.y, __wf_atom_ee03557f.z - __wf_atom_0aa77159.z) * 4,
		2,
		8
	))) do
		v6.y = __wf_atom_104bfe98(__wf_atom_0aa77159.y, __wf_atom_ee03557f.y, __wf_atom_7abf2d2f())
		v6.z = __wf_atom_104bfe98(__wf_atom_0aa77159.z, __wf_atom_ee03557f.z, __wf_atom_7abf2d2f())
		local v7 = __wf_atom_9341614d(v6, __wf_atom_dc309f8a)
		v5.heading = Random(-180, 180)
		v5.pitch = Random(-180, 180)
		VectorAdd(v7, v7, position)
		gRegion:CreateNano(particleType, v7, v5, creator)
	end
end

function ForceHideWhenHolstered(object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_cfecab5d(true)
	end
end

function TestFade(object)
	Sleep(1)

	while not __wf_atom_7e8ad928(object) do
		object:SetMaterialParam(v, Time() * 1 / dissolveTime % 1)
		Sleep(0)
	end
end