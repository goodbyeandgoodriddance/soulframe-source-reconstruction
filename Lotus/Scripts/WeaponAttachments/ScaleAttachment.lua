local module = require("Lotus.Scripts.WeaponAttachments.WeaponUtil")

local function fn(object, p)
	local v = 1

	for i = 1, 4 do
		local v2 = i - 1

		if object:__wf_atom_66088189(v, v2) == p then
			return v2
		end
	end

	return -1
end

local function fn2(__wf_atom_21ed1a39, object)
	local v = fn(__wf_atom_21ed1a39, object)

	if v < 0 then
		return nil
	end

	local userData = module.GetUserData(__wf_atom_21ed1a39)

	if userData == nil then
		userData = module.CreateUserData(__wf_atom_21ed1a39, { mScaleAttachment = {} })
	elseif userData.mScaleAttachment == nil then
		userData.mScaleAttachment = {}
	end

	local mScaleAttachment = userData.mScaleAttachment
	local v2 = mScaleAttachment[v]

	if v2 == nil then
		mScaleAttachment[v] = { t = 1, i = 0 }
		return mScaleAttachment[v]
	end

	return v2
end

local function fn3(object)
	Sleep(0)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if __wf_atom_7e8ad928(__wf_atom_21ed1a39:__wf_atom_6009c8ed()) then
		return
	end

	local v = fn2(__wf_atom_21ed1a39, object)

	if v == nil then
		return
	end

	local v2

	if fadeAttachedDecos then
		v2 = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)
	end

	v.i += 1
	local i = v.i
	local t = v.t

	while i == v.i do
		if t > 0 then
			t = __wf_atom_421b01aa(t - __wf_atom_084b3e93() / fadeDuration, 0, 4)

			for j = 1, #v2 do
				local v3 = v2[j]

				if not __wf_atom_7e8ad928(v3) then
					v3:SetMaterialParam(SF.__wf_atom_f35beb09, t)
				end
			end
		end

		t = __wf_atom_21ed1a39:__wf_atom_bb46daaa() and 2 or t
		Sleep(0)
	end
end

local function fn4(_) -- 2 equivalent calls inferred from this helper
	if next(holsterCustomizations) == nil or true then
		return smallScale
	end

	return smallScaleOverride
end

local function fn5(object)
	Sleep(0)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if
		__wf_atom_7e8ad928(__wf_atom_21ed1a39)
		or __wf_atom_7e8ad928(gClient)
		or __wf_atom_7e8ad928(__wf_atom_21ed1a39:__wf_atom_6009c8ed())
	then
		return
	end

	local v = fn2(__wf_atom_21ed1a39, object)

	if v == nil then
		return
	end

	local v2

	if fadeAttachedDecos then
		v2 = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)
	end

	v.i += 1
	local i = v.i
	local t = v.t
	local v3 = fn4() -- inferred equivalent call

	while i == v.i do
		t = __wf_atom_421b01aa(t - __wf_atom_084b3e93() / scaleDuration, 0, 1)

		for j = 1, #v2 do
			v2[j]:SetMaterialParam(SF.__wf_atom_f35beb09, t)
		end

		object:SetMaterialParam(SF.__wf_atom_f35beb09, t)
		object:SetMeshScale(__wf_atom_104bfe98(v3, largeScale, t), true)
		v.t = t

		if t <= 0 then
			break
		else
			Sleep(0)
		end
	end
end

local function fn6(object)
	Sleep(0)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	if doMeleeCheck then
		local __wf_atom_35a10d3c = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

		if
			not __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_9f71ab59()
			and __wf_atom_21ed1a39 ~= __wf_atom_35a10d3c
			and __wf_atom_21ed1a39:__wf_atom_e5141e5b()
			and not (__wf_atom_6009c8ed:__wf_atom_611b620c() or __wf_atom_6009c8ed:IsA(shipAvatar))
		then
			return
		end
	end

	local v = fn2(__wf_atom_21ed1a39, object)

	if v == nil then
		return
	end

	local v2

	if fadeAttachedDecos then
		v2 = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)
	end

	v.i += 1
	local i = v.i
	local t = v.t
	local v3 = fn4() -- inferred equivalent call

	while i == v.i do
		t = __wf_atom_421b01aa(t + __wf_atom_084b3e93() / scaleDuration, 0, 1)
		object:SetMaterialParam(SF.__wf_atom_f35beb09, t)
		object:SetMeshScale(__wf_atom_104bfe98(v3, largeScale, t), true)
		v.t = t

		for j = 1, #v2 do
			v2[j]:SetMaterialParam(SF.__wf_atom_f35beb09, t)
		end

		if t >= 1 then
			break
		else
			Sleep(0)
		end
	end

	if fadeAttachedDecos then
		fn3(object)
	end
end

function ScaleDown(object)
	if applyScaleWhileOnShip then
		fn5(object)
	elseif not _T.ArsenalOpen then
		local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

		if not __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
			local __wf_atom_95e72410 = __wf_atom_21ed1a39:__wf_atom_95e72410()

			if not (__wf_atom_7e8ad928(__wf_atom_95e72410) or __wf_atom_95e72410:IsA(shipAvatar)) then
				fn5(object)
			end
		end
	end
end

function ScaleUp(object)
	if applyScaleWhileOnShip then
		fn6(object)
		return
	end

	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	if not __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
		local __wf_atom_95e72410 = __wf_atom_21ed1a39:__wf_atom_95e72410()

		if not (__wf_atom_7e8ad928(__wf_atom_95e72410) or __wf_atom_95e72410:IsA(shipAvatar)) then
			fn6(object)
		end
	end
end

function AnimateAndScaleDown(object)
	Sleep(0)

	if _T.ArsenalOpen then
		local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

		if not __wf_atom_7e8ad928(__wf_atom_21ed1a39) then
			__wf_atom_21ed1a39:__wf_atom_5c0dc45b(false)
		end
	elseif gRegion:IsMaster() and runHost or not gRegion:IsMaster() and runClient then
		object:__wf_atom_921c1a5f(animation, false, false, 0)
		fn5(object)
	end
end

function OnSkinApplied(object, object2, _)
	Sleep(0)

	if
		_T.ArsenalOpen
		and not __wf_atom_7e8ad928(object2)
		and not __wf_atom_7e8ad928(object)
		and object2 == object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	then
		object2:ProcessAnimEvent(Symbol("WeaponForceOpen"))
	end
end