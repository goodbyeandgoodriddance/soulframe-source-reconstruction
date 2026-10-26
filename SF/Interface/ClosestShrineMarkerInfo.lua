local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil

local function fn()
	if __wf_atom_7e8ad928(gRegion) or not module.IsInOverworld() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local nearestTagged = gRegion:FindNearestTagged(Symbol("ResShrine"), __wf_atom_c4f78a8f:GetPosition())

	if __wf_atom_7e8ad928(nearestTagged) then
		return
	end

	v:SetPosition(nearestTagged:GetPosition())
end

function ClosestShrineMarker(p)
	v = p

	while not __wf_atom_7e8ad928(p) do
		fn()
		Sleep(1)
	end
end