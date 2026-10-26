local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil

function MaintainAlertness(object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	while not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(object) or object:IsKilled()) do
		if
			__wf_atom_7e8ad928(__wf_atom_30e3d82b:__wf_atom_1793a706())
			or __wf_atom_30e3d82b:__wf_atom_1793a706() == 1
		then
			__wf_atom_30e3d82b:__wf_atom_30b587a4()
		end

		Sleep(1)
	end
end

function AlertEnemies(object, p, p2)
	local v2

	if p then
		v2 = object:__wf_atom_be637430()
	else
		v2 = object:__wf_atom_6199ef01()
	end

	for _, v3 in ipairs(v2) do
		v3:__wf_atom_30b587a4()
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local nearestObject = module2.NearestObject(v3:__wf_atom_50a7d83e():GetPosition(), __wf_atom_ef7900cf)

		if not __wf_atom_7e8ad928(nearestObject) then
			v3:StormTarget(nearestObject)
		end

		if p2 then
			v3:__wf_atom_50a7d83e():__wf_atom_8a035cd5(Symbol("MaintainAlertness"), false)
		end
	end
end

local function fn()
	local __wf_atom_e529dedd = v:__wf_atom_e529dedd()

	for _, v2 in ipairs(__wf_atom_e529dedd) do
		module.SetEncounterAlerted(v2, true)
	end

	AlertEnemies(v, true, true)

	if not __wf_atom_7e8ad928(alertPerceptionHint) then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v2 in pairs(__wf_atom_ef7900cf) do
			v2:Attach(alertPerceptionHint, Symbol("GAME_C1_ROOT"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end
end

function LocalAlertMonitor(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	v = __wf_atom_3d96ddcd
	v:__wf_atom_b447e001(fn, Symbol("OnAlertedAgents"), alertedAgentsNum, true)

	while
		not __wf_atom_7e8ad928(v)
		and v:__wf_atom_4026dfb5() ~= 6
		and not (v:__wf_atom_3634e6d2(true) <= 0 or v:__wf_atom_0cc670d2() <= 0)
	do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(alertPerceptionHint) then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v2 in pairs(__wf_atom_ef7900cf) do
			v2:__wf_atom_0650fed7(alertPerceptionHint)
		end
	end

	if __wf_atom_7e8ad928(v) then
		return
	end

	v:__wf_atom_4ab4e145(Symbol("OnAlertedAgents"))
	local __wf_atom_e529dedd = v:__wf_atom_e529dedd()

	for _, v2 in ipairs(__wf_atom_e529dedd) do
		module.SetEncounterAlerted(v2, false)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end