local v = Symbol("GAME_R1_WEAPON1")
WeakResource("/SF/Types/Gameplay/Puzzles/PuzzleTorchPermittedTrigger")
local v2 = Symbol("TorchPermittedArea")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local v3 = {}

local function fn(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local position = object:GetPosition()

	if #v3 == 0 then
		v3 = gRegion:__wf_atom_439c0d29(v2, position, 0, 1000)
	end

	for _, v4 in pairs(v3) do
		if not __wf_atom_7e8ad928(v4) and v4:__wf_atom_1eaf335c(position) then
			return true
		end
	end

	return false
end

function OnOwnerSet(object)
	local extinguishAfter2 = extinguishAfter
	local __wf_atom_95e72410 = object:__wf_atom_95e72410()

	while extinguishAfter2 >= 0 do
		if module.IsInOverworld() then
			if fn(__wf_atom_95e72410) then
				extinguishAfter2 = extinguishAfter
			else
				extinguishAfter2 -= __wf_atom_084b3e93()
			end
		else
			extinguishAfter2 = extinguishAfter
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_95e72410) then
		local __wf_atom_d2b2176d = __wf_atom_95e72410:__wf_atom_d2b2176d()

		if __wf_atom_d2b2176d:__wf_atom_97d575cf(4) == object then
			local __wf_atom_8e4cf043 = __wf_atom_95e72410:__wf_atom_8e4cf043(v)
			local v4 = __wf_atom_95e72410:__wf_atom_1c374cc9(v) + __wf_atom_9341614d(decoOffset, __wf_atom_8e4cf043)
			gRegion:CreateEntity(unlitTorchDeco, v4, __wf_atom_8e4cf043, __wf_atom_95e72410)

			if gRegion:IsMaster() then
				__wf_atom_d2b2176d:__wf_atom_6cdc5077()
			end
		end
	end
end

function OnPickUpSpawn(object)
	Sleep(0)

	if module.IsInOverworld() and not fn(object) then
		gRegion:CreateEntity(unlitTorchDeco, object:GetPosition(), object:__wf_atom_dc309f8a())
		gRegion:__wf_atom_dd1e4d10(object)
	end
end