module(..., package.seeall)
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.StatsLib")
local v = WeakResource("/SF/Types/Items/Consumables/WevetSeed")
local v2 = Symbol("FastTravelTeleportCinematic")
local v3 = Symbol("Wazzard")

local function fn(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return false
	end

	for i = 0, __wf_atom_d2b2176d:__wf_atom_62abd325() - 1 do
		local __wf_atom_ba1c3957 = __wf_atom_d2b2176d:__wf_atom_ba1c3957(i)

		if __wf_atom_7e8ad928(__wf_atom_ba1c3957) or not __wf_atom_ba1c3957:IsA(v) then
			continue
		end

		__wf_atom_d2b2176d:__wf_atom_9d2ae6cc(i, 0, true)
		return true
	end

	return false
end

function IsFastTravelInProgress()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v2)

	for _, v4 in pairs(__wf_atom_2226b35c) do
		if v4:__wf_atom_7d4910e4() then
			return true
		end
	end

	return false
end

local function fn2(__wf_atom_0e0a6fee)
	local v4 = Vector()
	local v5 = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
	gRegion:__wf_atom_c20d246a(
		__wf_atom_0e0a6fee + Vector(0, 5, 0),
		__wf_atom_0e0a6fee + Vector(0, -10, 0),
		v5,
		nil,
		v4
	)
	return v4
end

function Teleport(instance)
	if not __wf_atom_7e8ad928(_T.FastTravelArgs) and gRegion:IsMaster() then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local v4 = __wf_atom_edfe0d73(_T.FastTravelArgs.dir, Vector(0, 1, 0))
		Normalize(v4)

		for i, v5 in ipairs(__wf_atom_ef7900cf) do
			if __wf_atom_7e8ad928(v5) or v5:__wf_atom_799d95f5() then
				continue
			end

			local v6 = fn2(__wf_atom_7d789620:__wf_atom_0e0a6fee(_T.FastTravelArgs.pos + v4 * (i - 1) * 2, 10, 10))
			local v7 = __wf_atom_fa8d0177(Vector(), _T.FastTravelArgs.dir)
			v7.pitch = 0
			v7.bank = 0

			if not __wf_atom_7e8ad928(_T.FastTravelArgs.playerAv) and _T.FastTravelArgs.playerAv == v5 then
				instance:Teleport(v6, v7)
			end

			local __wf_atom_d2b2176d = v5:__wf_atom_d2b2176d()

			if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
				local __wf_atom_b725e497 = __wf_atom_d2b2176d:__wf_atom_b725e497()

				if not __wf_atom_7e8ad928(__wf_atom_b725e497) then
					__wf_atom_b725e497:Teleport(fn2(__wf_atom_7d789620:__wf_atom_0e0a6fee(v6 - v4 * 1.5, 10, 10)), v7)
				end
			end

			v5:Teleport(v6, v7)

			if gRegion:IsMaster() then
				v5:__wf_atom_51075230(v7)
			end
		end
	end

	_T.FastTravelArgs = nil
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_c4f78a8f == instance:__wf_atom_02a7a2f4() and not fn(__wf_atom_c4f78a8f) then
		print("Fast Travel: Failed to consume teleport token.")
	end

	if not gRegion:IsMaster() then
		Sleep(0.7)

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_51075230(__wf_atom_c4f78a8f:__wf_atom_2f2bada0())
		end
	end

	module.Fade(false, 1)

	if gRegion:IsMaster() then
		Sleep(5)
		instance:Destroy()
	end
end

function TeleportFadeOut(_)
	module.Fade(true, 1, 1)
end

function FastTravelWithSeed(pos, dir, playerAv)
	if __wf_atom_7e8ad928(playerAv) or not gRegion:IsMaster() then
		return
	end

	if IsFastTravelInProgress() then
		print("Fast Travel request blocked. A Fast Travel is already in progress.")
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v2)
	local entity = gRegion:CreateEntity(Type(__wf_atom_0a6a5887), __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(entity) then
		_T.FastTravelArgs = { pos = pos, dir = dir, playerAv = playerAv }
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(v3)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:Destroy()
		end

		playerAv:__wf_atom_d2b2176d():Unequip(0, 2)
		entity:SetInstigatorAvatar(playerAv)
		entity:FirePort("StartPlaying")
	end
end

function FastTravel(instance)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(gGameRules) then
		return
	end

	print("FastTravel to " .. tostring(instance:__wf_atom_5b41f63b()))
	local __wf_atom_f582136d = instance:__wf_atom_f582136d(__wf_atom_7e616794)
	local v4 = Symbol("FastTravelWaypoint")
	local v5 = nil

	for _, v6 in pairs(__wf_atom_f582136d) do
		if v6:__wf_atom_db682341() ~= v4 then
			continue
		end

		v5 = v6
		break
	end

	local position, v6

	if __wf_atom_7e8ad928(v5) then
		if instance:IsA(__wf_atom_0f45538d) then
			position = instance:GetPosition() - instance:__wf_atom_a06d543c() * 9
		else
			position = instance:GetPosition() + instance:__wf_atom_a06d543c() * 8
		end

		v6 = __wf_atom_fa8d0177(position, instance:GetPosition())
	else
		position = v5:GetPosition()
		v6 = v5:__wf_atom_dc309f8a()
	end

	module2.LogFastTravel(tostring(instance:__wf_atom_db682341()), position)
	gGameRules:FastTravel(position, v6, gRegion:__wf_atom_c4f78a8f())
end