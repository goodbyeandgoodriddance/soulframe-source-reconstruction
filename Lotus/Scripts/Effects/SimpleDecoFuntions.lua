local v = Type("/SF/Types/Game/SFEffectDecoration")

function Move(object)
	Sleep(Delay)
	local position = object:GetPosition()
	Vector()
	local total = 0

	while total < TimeLength do
		object:SetPosition(position + OffsetPosition * total / TimeLength)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function MoveTarget()
	Sleep(Delay)

	if not __wf_atom_7e8ad928(TargetDeco) then
		local position = TargetDeco:GetPosition()
		Vector()
		local total = 0

		while total < TimeLength and not __wf_atom_7e8ad928(TargetDeco) do
			local v2 = OffsetPosition * total / TimeLength

			if not __wf_atom_7e8ad928(TargetDeco) then
				TargetDeco:SetPosition(position + v2)
			end

			total += __wf_atom_084b3e93()
			Sleep(0)
		end
	end
end

function ToggleDistortionOnTarget()
	TargetDeco:__wf_atom_6c093e3b(DistortOn, DistortMat)

	if applyToChildren then
		local __wf_atom_f582136d = TargetDeco:__wf_atom_f582136d(__wf_atom_7e616794)

		for _, v2 in ipairs(__wf_atom_f582136d) do
			if __wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v2:__wf_atom_b6b760b5()) then
				continue
			end

			v2:__wf_atom_6c093e3b(DistortOn, DistortMat)
		end
	end
end

function MeshScaleMultiplier(object)
	Sleep(0)
	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()
	local total = 0

	while total < TimeLength do
		object:SetMeshScale(__wf_atom_c082fc3d * __wf_atom_104bfe98(scaleStart, scaleFinish, total / TimeLength))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function SetMeshScale(object)
	Sleep(Delay)

	if not __wf_atom_7e8ad928(object) then
		object:SetMeshScale(scaleFinish)
	end
end

function MeshSwap(object)
	if applyToParent then
		object = object:__wf_atom_3d96ddcd()
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if not __wf_atom_7e8ad928(newMesh) then
		object:__wf_atom_45cf0e1a(newMesh, false, false)
	end
end

function SetTestRotateTargetted()
	if not __wf_atom_7e8ad928(TargetDeco) and TargetDeco:IsA(__wf_atom_8d0b7f88) then
		TargetDeco:__wf_atom_82dcfcd4(newTestRotateSpeed)
	end
end

function MaterialSwapOnParent(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		return
	end

	__wf_atom_f7e7be53:__wf_atom_a887a262(materialSlot, newMaterial, false)
end

function PlayTriggeredFade()
	Sleep(Delay)

	if not __wf_atom_7e8ad928(TargetDeco) and TargetDeco:IsA(v) then
		TargetDeco:PlayTriggeredFade()
	end
end

function PlayMultipleTriggeredFades()
	Sleep(Delay)

	if not __wf_atom_7e8ad928(TargetDecos) then
		for i = 1, #TargetDecos do
			if __wf_atom_7e8ad928(TargetDecos[i]) or not TargetDecos[i]:IsA(v) then
				continue
			end

			TargetDecos[i]:PlayTriggeredFade()
		end
	end
end

function MatchRotationToInstance(object)
	Sleep(Delay)

	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(TargetDeco)) then
		local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
		TargetDeco:__wf_atom_9b788a35(__wf_atom_2f2bada0)
	end
end

function SetRotationOnDeco(object)
	Sleep(Delay)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_9b788a35(newRotation)
	end
end

function SetRotationTarget()
	Sleep(Delay)

	if not __wf_atom_7e8ad928(TargetDeco) then
		TargetDeco:__wf_atom_9b788a35(newRotation)
	end
end

function SetTestRotateOnDeco(object)
	Sleep(Delay)
	local newTestRotateSpeed2 = newTestRotateSpeed

	if DoRandomRotationRange then
		newTestRotateSpeed2 = Rotation(
			math.random(-newTestRotateSpeed.pitch, newTestRotateSpeed.pitch),
			math.random(-newTestRotateSpeed.heading, newTestRotateSpeed.heading),
			math.random(-newTestRotateSpeed.bank, newTestRotateSpeed.bank)
		)
	end

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_82dcfcd4(newTestRotateSpeed2)
	end
end

function HideShowTargets()
	Sleep(Delay)

	if not __wf_atom_7e8ad928(TargetDecos) then
		for i = 1, #TargetDecos do
			if not __wf_atom_7e8ad928(TargetDecos[i]) then
				TargetDecos[i]:SetVisibility(isShowVisibility, true)
			end
		end
	end
end

function EnableMoveNoiseTarget()
	if not __wf_atom_7e8ad928(TargetDeco) then
		local __wf_atom_2f2bada0 = TargetDeco:__wf_atom_2f2bada0()
		TargetDeco:__wf_atom_e792b90b(enableNoise)
		TargetDeco:__wf_atom_9b788a35(__wf_atom_2f2bada0)
	end
end

function EnableMoveNoiseTargets()
	if not __wf_atom_7e8ad928(TargetDecos) then
		for i = 1, #TargetDecos do
			local __wf_atom_2f2bada0 = TargetDecos[i]:__wf_atom_2f2bada0()
			TargetDecos[i]:__wf_atom_e792b90b(enableNoise)
			TargetDecos[i]:__wf_atom_9b788a35(__wf_atom_2f2bada0)
		end
	end
end

function FreezeFxMaterials(object)
	Sleep(Delay)
	object:SetMaterialParam(Symbol("Pan"), 0, 0, 0, 0, true)
	object:SetMaterialParam(Symbol("PanSecond"), 0, 0, 0, 0, true)
	object:SetMaterialParam(Symbol("TimeScalar"), 0, 0, 0, 0, true)
end

function CloakVectorFromCenter(object)
	local v2 = Symbol("CloakVector")
	local __wf_atom_d0069154 = object:__wf_atom_d0069154()
	object:SetMaterialParam(v2, __wf_atom_d0069154.x, __wf_atom_d0069154.y, __wf_atom_d0069154.z, 1)
end