local total = 0
local v = false
local v2 = nil

function SetMessage(p)
	print("SaveSpinner:SetMessage(" .. tostring(p) .. ")")

	if not __wf_atom_7e8ad928(v2) then
		v2:SetText(p)
	end

	return true
end

function Initialize()
	print("SaveSpinner:Initialize")
	local module = require("Lotus.Interface.Components.ThemedSpinner")
	v2 = module.Create(mMovie, "Spinner")
	v2:SetActive(true)
end

function Finished()
	if not v then
		print("SaveSpinner:Finished")
		v = true
	end

	return true
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not v2:IsVisible() then
		mMovie:Close()
	end

	if v2:IsActive() then
		v2:Update()
		total += __wf_atom_fa1258d0()

		if v and total >= 1 then
			v2:SetActive(false)
		end
	end
end

function SupportsThemes()
	return true
end