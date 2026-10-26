local module = require("Lotus.Interface.LotusUtilities")
local v = false

local function fn(object)
	for i = 0, #object:__wf_atom_8ffd7933() do
		__wf_atom_f2daf912(tostring(i) .. " = " .. tostring(__wf_atom_5f46a6d4(object:__wf_atom_94176709(i):c_str())))
	end
end

function OnResponse()
	v = true
end

function SetQuestStage(p)
	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	local v2 = Resource(__wf_atom_9be88b01:GetInventory():GetActiveQuest())
	local questInfo, v3 = module.GetQuestInfo(__wf_atom_9be88b01, v2, false)

	if __wf_atom_7e8ad928(v2) then
		__wf_atom_f2daf912("No active quest.")
	elseif p == nil or tonumber(p) == nil then
		__wf_atom_f2daf912("Invalid quest stage.")
		__wf_atom_f2daf912("Current stage " .. tostring(questInfo - 1))
		fn(v2)
	else
		local v4 = math.max(math.floor((tonumber(p))), 0)

		if v2:__wf_atom_59f1738a() < v4 then
			__wf_atom_f2daf912("Invalid quest stage.")
			fn(v2)
		else
			__wf_atom_f2daf912("Changing quest stage, please wait...")
			v = false
			SF.ResetQuestProgressCommand(v2, v3 > 0 and 0 or -1, "OnResponse"):Execute()

			while not v do
				Sleep(0.1)
			end

			for i = 1, v4 do
				v = false
				__wf_atom_9be88b01:CompleteQuestStage(i - 1, "OnResponse")

				while not v do
					Sleep(0.1)
				end
			end

			local v5 = v2:__wf_atom_8ffd7933()[v4]

			if not __wf_atom_7e8ad928(v5) then
				local mBootLevelOverride = v5.mBootLevelOverride or WeakResource("/Lotus/Levels/Proc/PlayerShip")
				__wf_atom_c67f9605:__wf_atom_d4f03428(mBootLevelOverride)
			end

			__wf_atom_f2daf912("Quest stage set to " .. v4)
			module.UpdateQuests()
		end
	end
end