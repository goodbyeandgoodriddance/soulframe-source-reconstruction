local flag = false
Symbol("BromiusLegCollisionProxy")
Symbol("BromiusHeadCollisionProxy")
Symbol("BromiusBodyCollisionProxy")

function DetectPlayerUnder(object, _)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if
		__wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		or __wf_atom_3d96ddcd:IsKilled()
		or __wf_atom_3d96ddcd:__wf_atom_bedb4e3f()
	then
		return
	end

	local total = 0

	while not flag and object:__wf_atom_6f4fd712() do
		if minUnderneathTime <= total then
			flag = true
			break
		else
			total += __wf_atom_084b3e93()
			Sleep(0)
		end
	end

	if flag then
		__wf_atom_3d96ddcd:SetBlackboardBool(Symbol("IsUnderneath"), flag)
	else
		__wf_atom_3d96ddcd:SetBlackboardBool(Symbol("IsUnderneath"), false)
	end
end

function OnExit(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	Sleep(underneethBufferTime)

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:SetBlackboardBool(Symbol("IsUnderneath"), false)
	end
end