local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.NightFoldLib")

function RunScriptTrigger(object)
	module.WaitForLevel()
	object:FirePort("Execute")
end

function TeleportPlayersHere(instance)
	module.WaitForLevel()
	Sleep(0.5)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	while __wf_atom_7e8ad928(__wf_atom_c4f78a8f) do
		Sleep(0)
		__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_3a0953be) then
		__wf_atom_3d96ddcd = instance
	else
		local __wf_atom_31c6f706 = __wf_atom_3d96ddcd:__wf_atom_31c6f706()
		local __wf_atom_ef151cfd = __wf_atom_c4f78a8f:__wf_atom_a96eb2aa():__wf_atom_ef151cfd()

		if
			__wf_atom_ef151cfd > 0
			and not (__wf_atom_7e8ad928(__wf_atom_31c6f706) or __wf_atom_7e8ad928(__wf_atom_31c6f706[__wf_atom_ef151cfd]))
		then
			__wf_atom_3d96ddcd = __wf_atom_31c6f706[__wf_atom_ef151cfd]
		end
	end

	local position = __wf_atom_3d96ddcd:GetPosition()
	local __wf_atom_dc309f8a = __wf_atom_3d96ddcd:__wf_atom_dc309f8a()

	if module.IsInNightFold(__wf_atom_c4f78a8f) then
		_T.mWorldPosition = position
		__wf_atom_c4f78a8f:__wf_atom_43b67ec1(position)
		_T.mWorldView = __wf_atom_dc309f8a
	elseif teleportInstantly then
		__wf_atom_c4f78a8f:Teleport(position, __wf_atom_dc309f8a)
		__wf_atom_c4f78a8f:__wf_atom_f0f9fb38(__wf_atom_dc309f8a)
	else
		module2.RegisterPreventNighfoldUsage(true)
		module.Fade(true, 0.5, 1, true)

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:Teleport(position, __wf_atom_dc309f8a)
			__wf_atom_c4f78a8f:__wf_atom_f0f9fb38(__wf_atom_dc309f8a)
			Sleep(0.5)
		end

		module.Fade(false, 0.5, 1, true)
		module2.RegisterPreventNighfoldUsage(false)
	end

	Sleep(5)
	instance:Destroy()
end

function TeleportToPoint(object, instance)
	if __wf_atom_7e8ad928(teleportWaypoint) then
		print("No teleport waypoint for " .. object:__wf_atom_5b41f63b() .. "!")
		return
	end

	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_67c46eba) or instance:IsKilled() then
		return
	end

	local position = teleportWaypoint:GetPosition()
	local __wf_atom_dc309f8a = teleportWaypoint:__wf_atom_dc309f8a()

	if teleportInstantly then
		instance:Teleport(position, __wf_atom_dc309f8a)
		instance:__wf_atom_f0f9fb38(__wf_atom_dc309f8a)
	else
		module2.RegisterPreventNighfoldUsage(true)
		module.Fade(true, 0.5, 1, true)

		if not __wf_atom_7e8ad928(instance) then
			instance:Teleport(position, __wf_atom_dc309f8a)
			instance:__wf_atom_f0f9fb38(__wf_atom_dc309f8a)
		end

		module.Fade(false, 0.5, 1, true)
		module2.RegisterPreventNighfoldUsage(false)
	end
end