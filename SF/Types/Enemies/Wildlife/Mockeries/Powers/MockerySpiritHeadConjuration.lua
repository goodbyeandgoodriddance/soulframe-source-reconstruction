local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function ShowMockeryHead(object)
	local taggedChild = module.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("MockerySpectralHead"))

	if __wf_atom_7e8ad928(taggedChild) then
		return
	end

	taggedChild:SetVisibility(true)
end

function HideMockeryHead(object)
	local taggedChild = module.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("MockerySpectralHead"))

	if __wf_atom_7e8ad928(taggedChild) then
		return
	end

	taggedChild:SetVisibility(false)
end

function HideOnStart(object)
	Sleep(0)

	if not __wf_atom_7e8ad928(object) then
		object:SetVisibility(false)
	end
end