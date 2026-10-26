local v = Vector(0, -0.15, 0)
local v2 = nil
local activeFightController = nil
local v3 = nil
local v4 = Symbol("WSP13_BOSSFIGHTTRIGGER")

function TempestBayorEntityScript(p)
	local playerAvatars = gRegion:__wf_atom_ef7900cf()
	activeFightController = _T.ActiveFightController

	if __wf_atom_7e8ad928(activeFightController) then
		activeFightController = gRegion:__wf_atom_0a6a5887(v4)
	end

	if not __wf_atom_7e8ad928(activeFightController) then
		v3 = activeFightController:__wf_atom_e919fb8e()
	end

	if __wf_atom_7e8ad928(p) then
		return
	end

	local v5 = playerAvatars[1]

	if __wf_atom_7e8ad928(v5) then
		return
	end

	local __wf_atom_e919fb8e = v5:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.soulStealVictimSetup) then
		__wf_atom_e919fb8e.soulStealVictimSetup = true
		__wf_atom_e919fb8e.CanSpawnSoul = true
		v5:__wf_atom_51cd6126(Symbol("CritDamage"), "OnDamagedEvaluateSoulSpawn")
	end

	while true do
		if not (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v3.PlayerAvatars)) then
			playerAvatars = v3.PlayerAvatars
		end

		if v5 ~= playerAvatars[1] then
			v5 = playerAvatars[1]
			local __wf_atom_e919fb8e2 = v5:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e2.soulStealVictimSetup = true
			__wf_atom_e919fb8e2.CanSpawnSoul = true
			v5:__wf_atom_51cd6126(Symbol("CritDamage"), "OnDamagedEvaluateSoulSpawn")
		end

		Sleep(1)
	end
end

function CooldownBetweenSoulSpawns(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local total = 0

	while not __wf_atom_7e8ad928(__wf_atom_e919fb8e.attachedSoul) do
		Sleep(0)
	end

	while total <= soulSpawnCooldown do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	__wf_atom_e919fb8e.CanSpawnSoul = true
end

function OnDamagedEvaluateSoulSpawn(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_e919fb8e.CanSpawnSoul then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()
	local __wf_atom_483e7ddc = __wf_atom_9d766292:__wf_atom_483e7ddc()
	local __wf_atom_679ed446 = __wf_atom_9d766292:__wf_atom_679ed446()
	local _requiredAvatarDamageSource = requiredAvatarDamageSource

	if
		__wf_atom_7e8ad928(__wf_atom_679ed446)
		or not __wf_atom_679ed446:IsA(__wf_atom_4ebf67cb)
		or not __wf_atom_679ed446:IsA(requiredAvatarDamageSource)
		or __wf_atom_483e7ddc.hitType ~= 3
	then
		return
	end

	if
		__wf_atom_7e8ad928((object:__wf_atom_bb3e7833(__wf_atom_faccb0cf)))
		and not __wf_atom_483e7ddc:__wf_atom_6e062502()
		and __wf_atom_5784a397(1, chanceRange) <= chance
	then
		__wf_atom_5784a397(1, 3)

		if __wf_atom_483e7ddc:__wf_atom_bf612a92(19) > 0 then
			return
		end

		v2 = Symbol("GAME_C1_SPINE3")
		__wf_atom_e919fb8e.attachedSoul = object:Attach(soulStealType, v2, v, __wf_atom_80368bb1, __wf_atom_679ed446, 1)
		__wf_atom_e919fb8e.CanSpawnSoul = false
		object:__wf_atom_8a035cd5(Symbol("CooldownBetweenSoulSpawns"), false)
	end
end