local v = Symbol("DisabledShrine")
local v2 = Symbol("ResShrine")

function RevivePreDeathPlayers(list)
	for i = 1, #list do
		if list[i]:__wf_atom_bedb4e3f() then
			list[i]:InstantRevive()
		end
	end
end

local fn

local function fn2(mShrine, mBlightSpawning, mSpectatorMode, mPermaDeath, mAllPlayersKilledCallback, mAllPlayersRespawnedCallback)
	fn()
	_T.BlightZone = {}
	_T.BlightZone.mShrine = mShrine
	_T.BlightZone.mBlightSpawning = mBlightSpawning
	_T.BlightZone.mSpectatorMode = mSpectatorMode
	_T.BlightZone.mAllPlayersKilledCallback = mAllPlayersKilledCallback
	_T.BlightZone.mAllPlayersRespawnedCallback = mAllPlayersRespawnedCallback
	_T.BlightZone.mPermaDeath = mPermaDeath

	if
		gRegion:IsMaster()
		and not __wf_atom_7e8ad928(_T.BlightZone.mShrine)
		and _T.BlightZone.mShrine:IsA(__wf_atom_7e616794)
	then
		_T.BlightZone.mShrine:__wf_atom_b811702e(v2)
	end

	if mSpectatorMode then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		print("RespawnLib::ActivateBlightZone")

		for i = 1, #__wf_atom_ef7900cf do
			if not __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				__wf_atom_ef7900cf[i]:__wf_atom_e0be859e(true)
			end

			__wf_atom_ef7900cf[i]:__wf_atom_399cdc29(false)
		end
	end

	if _T.BlightZone.mBlightSpawning then
		_T.BlightZoneRespawning = true
	end
end

fn = function(p)
	local v3 = p or false

	if _T.BlightZone == nil then
		return
	end

	if
		gRegion:IsMaster()
		and not __wf_atom_7e8ad928(_T.BlightZone.mShrine)
		and _T.BlightZone.mShrine:IsA(__wf_atom_7e616794)
	then
		_T.BlightZone.mShrine:__wf_atom_b811702e(v)
	end

	if _T.BlightZone.mBlightSpawning or _T.BlightZone.mSpectatorMode then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		print("RespawnLib::DeactivateBlightZone")

		for i = 1, #__wf_atom_ef7900cf do
			if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				continue
			end

			if _T.BlightZone.mSpectatorMode then
				__wf_atom_ef7900cf[i]:__wf_atom_e0be859e(false)
				__wf_atom_ef7900cf[i]:__wf_atom_399cdc29(true)
			end

			if _T.BlightZone.mPermaDeath or v3 then
				__wf_atom_ef7900cf[i]:__wf_atom_399cdc29(true)
			end

			if not _T.BlightZone.mBlightSpawning or _T.BlightZone.mPermaDeath then
				continue
			end

			__wf_atom_ef7900cf[i]:__wf_atom_7470861b():__wf_atom_0e3d6320(true)
			__wf_atom_ef7900cf[i]:__wf_atom_7470861b():__wf_atom_bbcba13b(false)
		end

		_T.BlightZoneRespawning = nil
	end

	_T.BlightZone = nil
end

local RespawnLib = {}
RespawnLib.ActivateBlightZone = fn2
RespawnLib.DeactivateBlightZone = fn

function RespawnLib.UpdateBlightZone()
	if _T.BlightZone == nil then
		return
	end

	gRegion:__wf_atom_ef7900cf()

	if _T.BlightZone.mBlightSpawning then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for i = 1, #__wf_atom_ef7900cf do
			if __wf_atom_7e8ad928(__wf_atom_ef7900cf[i]) then
				continue
			end

			if _T.BlightZone.mSpectatorMode then
				__wf_atom_ef7900cf[i]:__wf_atom_e0be859e(true)
				__wf_atom_ef7900cf[i]:__wf_atom_399cdc29(false)
			end

			if _T.BlightZone.mPermaDeath then
				__wf_atom_ef7900cf[i]:__wf_atom_399cdc29(false)
			end

			if not _T.BlightZone.mBlightSpawning or _T.BlightZone.mPermaDeath then
				continue
			end

			__wf_atom_ef7900cf[i]:__wf_atom_7470861b():__wf_atom_0e3d6320(false)
			__wf_atom_ef7900cf[i]:__wf_atom_7470861b():__wf_atom_bbcba13b(true)
		end

		if not gRegion:IsMaster() then
			return
		end

		local v3 = #__wf_atom_ef7900cf == 0

		for i = 1, #__wf_atom_ef7900cf do
			if
				__wf_atom_7e8ad928(__wf_atom_ef7900cf[i])
				or __wf_atom_ef7900cf[i]:__wf_atom_bedb4e3f()
				or __wf_atom_ef7900cf[i]:IsKilled()
			then
				continue
			end

			v3 = true
		end

		if not v3 then
			local flag = false

			if gRegion:IsMaster() and (_T.BlightZone.mSpectatorMode or _T.BlightZone.mPermaDeath) then
				print("All players dead -- Kill them all if necessary")
				local __wf_atom_ef7900cf2 = gRegion:__wf_atom_ef7900cf()

				for i = 1, #__wf_atom_ef7900cf2 do
					if
						__wf_atom_7e8ad928(__wf_atom_ef7900cf2[i])
						or not __wf_atom_ef7900cf2[i]:__wf_atom_7470861b():__wf_atom_bedb4e3f()
					then
						continue
					end

					__wf_atom_ef7900cf2[i]:__wf_atom_7470861b():__wf_atom_0ab36782()
					flag = true
				end

				if flag then
					Sleep(0)
				end

				local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

				for i = 1, #__wf_atom_3c8e1a7a do
					gGameRules:__wf_atom_bca0553b(__wf_atom_3c8e1a7a[i])
				end

				_T.BlightZone.mDeadPlayers = {}

				if _T.BlightZone.mAllPlayersKilledCallback ~= nil then
					_T.BlightZone.mAllPlayersKilledCallback()
				end
			else
				_T.BlightZone.mDeadPlayers = {}

				if _T.BlightZone.mAllPlayersKilledCallback ~= nil then
					_T.BlightZone.mAllPlayersKilledCallback()
				end
			end

			if _T.BlightZone ~= nil and _T.BlightZone.mAllPlayersRespawnedCallback ~= nil then
				local v4 = false

				while not v4 do
					local __wf_atom_ef7900cf2 = gRegion:__wf_atom_ef7900cf()
					v4 = true

					for i = 1, #__wf_atom_ef7900cf2 do
						local v5 = __wf_atom_ef7900cf2[i]

						if not (__wf_atom_7e8ad928(v5) or v5:__wf_atom_bedb4e3f() or v5:IsKilled()) then
							continue
						end

						v4 = false
						break
					end

					Sleep(0)
				end

				_T.BlightZone.mAllPlayersRespawnedCallback()
			end
		end
	end
end

function RespawnLib.RefillHealthPotions(p)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v3 in ipairs(__wf_atom_3c8e1a7a) do
		if not v3:IsLocal() then
			continue
		end

		local v4 = p - v3:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_c9e583ca(WeakResource("/SF/Types/Items/Consumables/HealingPotion"))
		v3:__wf_atom_36b99b9d(Resource("/SF/Types/Items/Consumables/HealingPotion"), v4, false)
	end
end

function RespawnLib.GetBlightZoneShrine()
	if _T.BlightZone == nil then
		return nil
	end

	return _T.BlightZone.mShrine
end

function RespawnLib.LockRespawnShrine(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local nearestTagged = gRegion:FindNearestTagged(Symbol("ResShrine"), object:GetPosition())

	if __wf_atom_7e8ad928(nearestTagged) then
		return
	end

	local v3

	if _T.BlightZone ~= nil then
		v3 = _T.BlightZone.mShrine
	end

	if v3 == nearestTagged then
		return
	end

	nearestTagged:__wf_atom_b811702e(p)
end

function RespawnLib.UnlockRespawnShrine(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:__wf_atom_b811702e(Symbol("ResShrine"))
end

return RespawnLib