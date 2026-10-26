function AttachEffectToSpecificChildren(object)
	local __wf_atom_be0bea4a = object:__wf_atom_3d96ddcd():__wf_atom_be0bea4a()

	for i = 1, #SearchNames do
		for j = 1, #__wf_atom_be0bea4a do
			if __wf_atom_7e8ad928(__wf_atom_be0bea4a[j]) then
				continue
			end

			local name = __wf_atom_be0bea4a[j]:GetName()

			if string.find(name, (tostring(SearchNames[i]))) then
				__wf_atom_be0bea4a[j]:Attach(EffectType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		end
	end
end

function RemoveEffectByParentName(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	for i = 1, #SearchNames do
		if not string.find(__wf_atom_3d96ddcd:GetName(), (tostring(SearchNames[i]))) then
			continue
		end

		instance:Destroy()
	end
end

function RemoveAllChildEffectByType(object)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_3d96ddcd()) then
		return
	end

	local __wf_atom_f582136d = object:__wf_atom_3d96ddcd():__wf_atom_f582136d(ChildType)

	if __wf_atom_7e8ad928(__wf_atom_f582136d) then
		return
	end

	for i = 1, #__wf_atom_f582136d do
		if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
			__wf_atom_f582136d[i]:Destroy()
		end
	end
end

function CameraEffects(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local cameraControl = __wf_atom_575542c8:CameraControl()

	if __wf_atom_7e8ad928(cameraControl) then
		return
	end

	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

	if CurrentAsStartEnd then
		FOVStart = cameraControl:__wf_atom_31f8207e()
		FOVEnd = FOVStart
	end

	if not __wf_atom_7e8ad928(colorCorrection) then
		cameraControl:__wf_atom_dc7b15db(colorCorrection, 0, -1, 0)
	end

	if upTime > 0 then
		local v = 0

		while v < 1 do
			v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / upTime, 0, 1)
			local v2 = __wf_atom_24a82b69(v)

			if not __wf_atom_7e8ad928(cameraControl) then
				cameraControl:__wf_atom_25382a0d((__wf_atom_104bfe98(FOVStart, FOVTarget, Pow(v2, upFOVTimeExponent))))
			end

			if
				__wf_atom_575542c8:__wf_atom_a96eb2aa()
				and __wf_atom_575542c8:__wf_atom_a96eb2aa():__wf_atom_ce4e872c()
			then
				gRegion:GetGameCamera():__wf_atom_888efbe9(cameraControl:__wf_atom_c277aed8())
			end

			local v3 = Pow(v2, upCCTimeExponent)

			if not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(colorCorrection)) then
				cameraControl:__wf_atom_344d785e(colorCorrection, v3 * ccOpacity)
			end

			if fadeToWhite then
				__wf_atom_8ad59546:__wf_atom_47f0b80b(v3 * -1)
				__wf_atom_8ad59546.postProcessBias.bloom = __wf_atom_104bfe98(0, 4, v2)
			end

			if fadeToBlack then
				__wf_atom_8ad59546:__wf_atom_47f0b80b(v3)
			end

			Sleep(0)
		end
	end

	Sleep(holdTime)

	if downTime > 0 then
		local v = 0

		while v < 1 do
			v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / downTime, 0, 1)
			local v2 = __wf_atom_24a82b69(v)

			if not __wf_atom_7e8ad928(cameraControl) then
				cameraControl:__wf_atom_25382a0d((__wf_atom_104bfe98(FOVTarget, FOVEnd, Pow(v2, downFOVTimeExponent))))
			end

			if
				__wf_atom_575542c8:__wf_atom_a96eb2aa()
				and __wf_atom_575542c8:__wf_atom_a96eb2aa():__wf_atom_ce4e872c()
			then
				gRegion:GetGameCamera():__wf_atom_888efbe9(cameraControl:__wf_atom_c277aed8())
			end

			local v3 = Pow(1 - v2, downCCTimeExponent)

			if not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(colorCorrection)) then
				cameraControl:__wf_atom_344d785e(colorCorrection, v3 * ccOpacity)
			end

			if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
				if fadeToWhite then
					__wf_atom_8ad59546:__wf_atom_47f0b80b(v3 * -1)
					__wf_atom_8ad59546.postProcessBias.bloom = __wf_atom_104bfe98(4, 0, v2)
				end

				if fadeToBlack then
					__wf_atom_8ad59546:__wf_atom_47f0b80b(v3)
				end
			end

			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(cameraControl) then
		if not __wf_atom_7e8ad928(colorCorrection) then
			cameraControl:__wf_atom_928a45c5(colorCorrection)
		end

		cameraControl:__wf_atom_25382a0d(FOVEnd)
	end

	if __wf_atom_575542c8:__wf_atom_a96eb2aa() and __wf_atom_575542c8:__wf_atom_a96eb2aa():__wf_atom_ce4e872c() then
		gRegion:GetGameCamera():__wf_atom_888efbe9(cameraControl:__wf_atom_c277aed8())
	end
end

function Dissolve(object)
	Sleep(delay)
	local specificInstance2

	if dissolveParent then
		specificInstance2 = object:__wf_atom_3d96ddcd()
	else
		specificInstance2 = specificInstance
	end

	if __wf_atom_7e8ad928(specificInstance2) then
		specificInstance2 = object
	end

	print(specificInstance2:GetName())
	local v = 0

	while v < 1 and not __wf_atom_7e8ad928(specificInstance2) do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / math.max(0.001, timer), 0, 1)
		local v2 = __wf_atom_24a82b69(v)
		local v3 = __wf_atom_104bfe98(startDissolve, endDissolve, v2)

		if useDitherDissolve then
			specificInstance2:__wf_atom_68f2c268(v3)
		else
			specificInstance2:__wf_atom_a763aa1a(v3)
		end

		Sleep(0)
	end

	if destroyWhenComplete and not __wf_atom_7e8ad928(specificInstance2) then
		specificInstance2:Destroy()
	end
end

function CinDissolve(_, object)
	local specificInstance2

	if dissolveParent then
		specificInstance2 = object:__wf_atom_3d96ddcd()
	else
		specificInstance2 = specificInstance
	end

	if __wf_atom_7e8ad928(specificInstance2) then
		specificInstance2 = object
	end

	if delay > 0 then
		Sleep(delay)
	end

	local v = 0

	while v < 1 and not __wf_atom_7e8ad928(specificInstance2) do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / math.max(0.001, timer), 0, 1)
		local v2 = __wf_atom_24a82b69(v)
		local v3 = __wf_atom_104bfe98(startDissolve, endDissolve, v2)

		if useDitherDissolve then
			specificInstance2:__wf_atom_68f2c268(v3)
		else
			specificInstance2:__wf_atom_a763aa1a(v3)
		end

		Sleep(0)
	end

	if destroyWhenComplete and not __wf_atom_7e8ad928(specificInstance2) then
		specificInstance2:Destroy()
	end
end

function AttachLocalFx(object)
	Sleep(0)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if
		__wf_atom_575542c8:__wf_atom_a96eb2aa() == gRegion:__wf_atom_eab484a7()
		and not __wf_atom_7e8ad928(EffectType)
	then
		object:Attach(EffectType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, __wf_atom_575542c8)
	end
end

function AttachToInstance(_)
	if not (__wf_atom_7e8ad928(specificInstance) or __wf_atom_7e8ad928(EffectType)) then
		specificInstance:Attach(EffectType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

function AttachToPlayer(_)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(EffectType) then
		if onlyAllowOneInstance then
			if __wf_atom_7e8ad928((__wf_atom_c4f78a8f:__wf_atom_bb3e7833(EffectType))) then
				__wf_atom_c4f78a8f:Attach(EffectType, EMPTY_SYMBOL)
			end
		else
			__wf_atom_c4f78a8f:Attach(EffectType, EMPTY_SYMBOL)
		end
	end
end

function ShowAttachedMarkerInfo(object)
	local __wf_atom_c0312a64 = object:__wf_atom_c0312a64(__wf_atom_17f001c3)

	for i = 1, #__wf_atom_c0312a64 do
		__wf_atom_c0312a64[i]:Enable()
	end
end

function HideAttachedMarkerInfo(object)
	local __wf_atom_c0312a64 = object:__wf_atom_c0312a64(__wf_atom_17f001c3)

	for i = 1, #__wf_atom_c0312a64 do
		__wf_atom_c0312a64[i]:Disable()
	end
end

function WindToPlayer(object)
	local __wf_atom_06db1fb1 = gRegion:__wf_atom_06db1fb1(object:GetPosition())

	while not __wf_atom_7e8ad928(__wf_atom_06db1fb1) do
		object:SetPosition((__wf_atom_06db1fb1:__wf_atom_1c374cc9(targetBone)))
		Sleep(0)
	end
end

function AttachToMeleeWeapon(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if not __wf_atom_7e8ad928(__wf_atom_575542c8) then
		local __wf_atom_66088189 = __wf_atom_575542c8:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6():__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:Attach(weaponAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end
end

function DynamicPortDestroyedInstanceToggle(object)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol(tag), object:GetPosition(), 0, searchRadius)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_55142dd4(__wf_atom_f738b4af, "OnDestroyed")
	end
end

function OnDestroyed(_)
	for _, v in ipairs(instancesToShow) do
		if not __wf_atom_7e8ad928(v) then
			v:SetVisibility(true)
		end
	end

	for _, v in ipairs(instancesToHide) do
		if not __wf_atom_7e8ad928(v) then
			v:SetVisibility(false)
		end
	end

	for _, v in ipairs(instancesToEnable) do
		if not __wf_atom_7e8ad928(v) then
			v:Enable()
		end
	end

	for _, v in ipairs(instancesToDisable) do
		if not __wf_atom_7e8ad928(v) then
			v:Disable()
		end
	end
end

function BeamToParentBone(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	object:__wf_atom_b2394158(__wf_atom_575542c8, BoneName)
end

function BeamParentEndPoint(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		object:__wf_atom_a64eca67((__wf_atom_3d96ddcd:__wf_atom_fdf659dc()))
		Sleep(0)
	end
end

function DestroyAttachedType(object)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(EffectType)

	for _, v in ipairs(__wf_atom_f582136d) do
		v:Destroy()
	end
end

function DestroyAllChildren(_)
	for _, v in ipairs(targetEntities) do
		local __wf_atom_be0bea4a = v:__wf_atom_be0bea4a()

		for _, v2 in ipairs(__wf_atom_be0bea4a) do
			v2:Destroy()
		end
	end
end

function PassDissolveToParent(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_f7e7be53)) do
		local v

		if useDitherDissolve then
			local __wf_atom_f43b1463 = object:__wf_atom_f43b1463()
			v = minDissolve + __wf_atom_f43b1463 * (maxDissolve - minDissolve)
		else
			v = object:__wf_atom_f83a55c6()
		end

		if useDitherDissolve then
			__wf_atom_f7e7be53:__wf_atom_68f2c268(v)
		else
			__wf_atom_f7e7be53:__wf_atom_a763aa1a(v)
		end

		Sleep(0)
	end
end

function LightInheritParentScale(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	object:__wf_atom_400189c4(object:__wf_atom_4e28532a() * __wf_atom_3d96ddcd:__wf_atom_c082fc3d())
end

function BeamToAvatarAttachment(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_575542c8:__wf_atom_bb3e7833(targetAttachmentType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	object:__wf_atom_b2394158(__wf_atom_bb3e7833, EMPTY_SYMBOL)
end