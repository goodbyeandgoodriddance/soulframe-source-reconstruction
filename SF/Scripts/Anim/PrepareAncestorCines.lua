local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.CinematicLib")
local v = nil

function SetAncestorAnimName(object)
	local __wf_atom_02a7a2f4 = object:__wf_atom_02a7a2f4()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(ancestorTag, __wf_atom_02a7a2f4:__wf_atom_a2a18137(), 0, 10)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_f738b4af:__wf_atom_e5d015a7(animName)
	end
end

function SetRatGuideCineScale(object)
	v = gRegion:__wf_atom_0a6a5887(Symbol("FreedRatGuide"))

	if not __wf_atom_7e8ad928(v) then
		v:SetMeshScale(1)
		local taggedChild = module.FindTaggedChild(v:__wf_atom_be0bea4a(), Symbol("GuideTrigger"))
		object:__wf_atom_a3d2b66b(v, Symbol("GuidePoppet"))

		if not __wf_atom_7e8ad928(taggedChild) then
			taggedChild:Disable()
		end
	end
end

function RemoveRatGuide()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		v = gRegion:__wf_atom_f738b4af(Symbol("FreedRatGuide"), __wf_atom_c4f78a8f:__wf_atom_a2a18137(), 0, 10)
	end

	if not __wf_atom_7e8ad928(v) then
		v:SetVisibility(true, true)
		v:Destroy()
	end
end

function ShowDiorama()
	module.StreamAndPlayCinematicLevel(dioramaLevel, false, false)
end

function PrepOrlickCine(object)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(ancestorTag, object:__wf_atom_a2a18137(), 0, 5)

	while __wf_atom_7e8ad928(__wf_atom_f738b4af) do
		__wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(ancestorTag, object:__wf_atom_a2a18137(), 0, 5)
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		return
	end

	local taggedChild = module.FindTaggedChild(__wf_atom_f738b4af:__wf_atom_be0bea4a(), Symbol("AttachedBaby"))

	if not __wf_atom_7e8ad928(taggedChild) then
		taggedChild:__wf_atom_e5d015a7(animName)
		object:__wf_atom_a3d2b66b(taggedChild, animName)
	end

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_f738b4af:SetVisibility(true, true)
		__wf_atom_f738b4af:__wf_atom_d927a2a4(nil)
	end
end

function AttachProps()
	if __wf_atom_7e8ad928(attachTarget) or __wf_atom_7e8ad928(attachProp) then
		return
	end

	attachProp:AttachToInPlace(attachTarget, attachBoneName)
end

function SetPropAttachementVis()
	if __wf_atom_7e8ad928(prop) then
		return
	end

	local taggedChild = module.FindTaggedChild(prop:__wf_atom_be0bea4a(), attachmentTag)

	if not __wf_atom_7e8ad928(taggedChild) then
		taggedChild:SetVisibility(visibility)
	end
end

function PrepareTuvalkaneLegendaryWeaponForgeCin(p)
	module2.SetEntitysAttachmentVisibility(false, tuvalkaneTag, coalsPoker)
	module2.CreateAttachedDeco(p, tuvalkanesHammerType, Symbol("BlacksmithVendor"))
end

function TeardownTuvalkaneLegendaryWeaponForgeCin(p)
	module2.DestroyAttachedDeco(p, tuvalkanesHammerType, Symbol("BlacksmithVendor"))
end