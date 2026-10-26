local v = WeakResource("/Lotus/Powersuits/Harlequin/IllusionMirrorAvatar")
local v2 = Symbol("impactPoint")

function KillAttached()
	if not __wf_atom_7e8ad928(typeToKill) then
		local __wf_atom_bb3e7833 = isAttachedToThis:__wf_atom_bb3e7833(typeToKill)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function KillAttachedOnSelf(object)
	if not __wf_atom_7e8ad928(typeToKill) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(typeToKill)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function KillAttachedToGameCamera()
	Sleep(delay)
	local gameCamera = gRegion:GetGameCamera()

	if not (__wf_atom_7e8ad928(typeToKill) or __wf_atom_7e8ad928(gameCamera)) then
		local __wf_atom_bb3e7833 = gameCamera:__wf_atom_bb3e7833(typeToKill)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function KillThisAttachedToParent(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(typeToKill)) then
		local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(typeToKill)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			if stopSpewing then
				__wf_atom_bb3e7833:__wf_atom_2f54f673(0, 0, false)
			else
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end
end

function KillArrayAttachedToParent(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(typesToKill)) then
		for i = 1, #typesToKill do
			local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(typesToKill[i])

			if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				continue
			end

			if stopSpewing then
				__wf_atom_bb3e7833:__wf_atom_2f54f673(0, 0, false)
			else
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end
end

function KillArrayAttachedToSelf(object)
	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(typesToKill)) then
		for i = 1, #typesToKill do
			local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(typesToKill[i])

			if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				continue
			end

			if stopSpewing then
				__wf_atom_bb3e7833:__wf_atom_2f54f673(0, 0, false)
			else
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end
end

function KillThisAttachedToParentOnBone(object)
	if __wf_atom_7e8ad928(bone) or bone == EMPTY_SYMBOL then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(typeToKill)) then
		local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(typeToKill)

		if not __wf_atom_7e8ad928(__wf_atom_f582136d) then
			for i = 1, #__wf_atom_f582136d do
				if __wf_atom_7e8ad928(__wf_atom_f582136d[i]) or __wf_atom_f582136d[i]:__wf_atom_f5bac0e4() ~= bone then
					continue
				end

				__wf_atom_f582136d[i]:Destroy()
			end
		end
	end
end

function KillAttachedArray()
	if not (__wf_atom_7e8ad928(isAttachedToThisArray) or __wf_atom_7e8ad928(typeToKill)) then
		for i = 1, #isAttachedToThisArray do
			local __wf_atom_bb3e7833 = isAttachedToThisArray[i]:__wf_atom_bb3e7833(typeToKill)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end
end

function Attach()
	Sleep(delay)

	if not (__wf_atom_7e8ad928(attachToThis) or __wf_atom_7e8ad928(typeToAttach)) then
		attachToThis:Attach(typeToAttach, bone, attachPos, attachRot)
	end
end

function AttachArray()
	if not (__wf_atom_7e8ad928(attachToArray) or __wf_atom_7e8ad928(typeToAttach)) then
		for i = 1, #attachToArray do
			attachToArray[i]:Attach(typeToAttach, EMPTY_SYMBOL, attachPos, attachRot)
		end
	end
end

function AttachProjector(object)
	Sleep(0)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_7e8ad928(typeToAttach)) then
		__wf_atom_3d96ddcd:__wf_atom_26f3807f(typeToAttach, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, true)
	end
end

function KillParent(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:Destroy()
	end
end

function AttachToMe(object)
	if masterOnly and not gRegion:IsMaster() then
		return
	end

	if not __wf_atom_7e8ad928(typeToAttach) then
		object:Attach(typeToAttach, bone, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
	end
end

function AttachToTouchingAvatar(_, object)
	if not __wf_atom_7e8ad928(object) then
		if isEnable then
			if not object:__wf_atom_a586ea4c(typeToAttach) then
				object:Attach(typeToAttach, bone)
			end
		else
			local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(typeToAttach)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end
end

function AttachToAvatarFromBehavior(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_7e8ad928(typeToAttach)) then
		__wf_atom_50a7d83e:Attach(typeToAttach, EMPTY_SYMBOL)
	end
end

function KillParticleCenterTypeIfIllusionAvatar(instance)
	local creator = instance:GetCreator()

	if __wf_atom_7e8ad928(creator) then
		return
	end

	local __wf_atom_f7e7be53 = creator:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		return
	end

	if __wf_atom_f7e7be53:IsA(v) then
		if instance:IsA(__wf_atom_d00f34c2) then
			instance:TurnOff()
		else
			instance:Destroy()
		end
	end
end

function EnableDisableAttachment()
	local __wf_atom_f582136d = isAttachedToThis:__wf_atom_f582136d(attachmentType)

	if not __wf_atom_7e8ad928(__wf_atom_f582136d) then
		for _, v3 in ipairs(__wf_atom_f582136d) do
			if isEnable then
				v3:Enable()
			else
				v3:Disable()
			end
		end
	end
end

function EnableDisableAttachmentOnParent(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(attachmentType)

	if not __wf_atom_7e8ad928(__wf_atom_f582136d) then
		for _, v3 in ipairs(__wf_atom_f582136d) do
			if isEnable then
				v3:Enable()
			else
				v3:Disable()
			end
		end
	end
end

function SwapParentMesh(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:__wf_atom_45cf0e1a(newMesh, false, false)
	end
end

function ProjUpdateWorldPos(object)
	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
		object:SetMaterialParam(v2, __wf_atom_a2a18137.x, __wf_atom_a2a18137.y, __wf_atom_a2a18137.z)
		Sleep(0)
	end
end

function SleepToDisable(object)
	Sleep(delay)

	if not __wf_atom_7e8ad928(object) then
		object:Disable()
	end
end

function ApplyToParentIfLocal(instance)
	Sleep(delay)

	if not __wf_atom_7e8ad928(instance) then
		local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_7e6ed5fa) then
			if __wf_atom_3d96ddcd:__wf_atom_8efce136() then
				__wf_atom_3d96ddcd:Attach(typeToAttach, bone)
			elseif destrySelfIfNotLocal then
				instance:Destroy()
			end
		end
	end
end

function AttachBeamsToThis(object)
	Sleep(delay)

	if
		not __wf_atom_7e8ad928(object)
		and not __wf_atom_7e8ad928(beamAttachBones)
		and not __wf_atom_7e8ad928(beamEndBones)
		and #beamAttachBones == #beamEndBones
	then
		for i = 1, #beamAttachBones do
			local v3 = object:Attach(typeToAttach, beamAttachBones[i])

			if not __wf_atom_7e8ad928(v3) then
				v3:__wf_atom_b2394158(object, beamEndBones[i])
			end
		end
	end
end

function BeamEndPoint(object)
	Sleep(delay)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_a64eca67(attachPos)
	end
end

function UnattachMe(object)
	if delay >= 0 then
		Sleep(delay)
	end

	object:__wf_atom_e6ed03c8()
end