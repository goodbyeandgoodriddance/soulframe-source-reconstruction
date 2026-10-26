local module = require("Lotus.Scripts.Libs.AudioLib")

function DestroyParentOnAutosimChildDestroy(object)
	if __wf_atom_7e8ad928(object) or not (object:__wf_atom_c6f1f83d() <= 0) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:FirePort("Destroy")
	end
end

function DestroyParentOnAllAutosimSiblingsDestroyed(object)
	if __wf_atom_7e8ad928(object) or not (object:__wf_atom_c6f1f83d() <= 0) then
		return
	end

	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if #__wf_atom_3d96ddcd:__wf_atom_f582136d((object:__wf_atom_1bb5b1ff())) ~= 1 then
		return
	end

	__wf_atom_3d96ddcd:FirePort("Destroy")
end

function AddAttachment(object)
	if not __wf_atom_7e8ad928(object) then
		if ignoreIfHasThisAttachment and not object:__wf_atom_a586ea4c(attachmentType) then
			object:Attach(attachmentType, attachBoneSymbol, attachPosition, attachRotation)
		end

		if ignoreIfHasThisAttachment and not object:__wf_atom_a586ea4c(attachementSoundSequencer) then
			object:Attach(attachementSoundSequencer, attachBoneSymbol, attachPosition, attachRotation)

			if not __wf_atom_7e8ad928(disableSoundSeqTag) then
				module.EnableTaggedSequencers(Symbol(disableSoundSeqTag), false)
			end
		end
	end
end

function MoveFlare(object)
	local position = object:GetPosition()
	local x = position.x
	local y = position.y
	local v = Time()
	local v2 = 1

	while not __wf_atom_7e8ad928(object) and v2 > 0 do
		v2 = math.max(0, v2 - __wf_atom_084b3e93() * 0.5)
		position.y = __wf_atom_104bfe98(y - 3, y + 2, v2)
		position.x = x + math.sin(v + 3.141592653589793 * v2 * 2 * 3) * 0.4
		object:SetPosition(position)
		Sleep(0)
	end
end

function UnattachInstance(_)
	if not __wf_atom_7e8ad928(childInstance) then
		childInstance:__wf_atom_e6ed03c8()
	end
end

function AttachToInPlace()
	if not (__wf_atom_7e8ad928(attachmentInstance) or __wf_atom_7e8ad928(parentInstance)) then
		attachmentInstance:AttachToInPlace(parentInstance, attachBoneSymbol)
	end
end