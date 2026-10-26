local function fn(object)
	if __wf_atom_7e8ad928(object) == false then
		object:__wf_atom_069163a3(exitOnAlert)
		object:__wf_atom_7a5ca808(exitOnCombat)
		object:__wf_atom_ae241dc9(exitOnDamage)
		object:__wf_atom_cd7076f3(exitOnEnemySeen, exitOnEnemySeenRadius)

		if neverExit == true then
			object:__wf_atom_f87cd148(false)
		end
	end
end

function SetPerceptions(p)
	if __wf_atom_7e8ad928(p) == false then
		fn(p)
	end
end

function UnawareAgent(object)
	object:__wf_atom_23b51204(distance, distance, hFov, vFov)
	object:__wf_atom_50a7d83e():__wf_atom_d2b2176d():AddUpgrade(111, 2, hearingDistancePercent)
end

function takeCover(object)
	fn(object)

	if __wf_atom_7e8ad928(coverWaypoint) == false then
		object:EnterNearestCover(coverWaypoint, true)
	end

	Sleep(0)
	object:__wf_atom_920a5a62()
end

local function fn2(object) -- 2 equivalent calls inferred from this helper
	object:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_1870de39(true)
end

function moveTo(object)
	if equipWeapon then
		fn2(object) -- inferred equivalent call
	end

	fn(object)
	object:MoveTo(dest, run, align, true)
	Sleep(0)
	object:__wf_atom_920a5a62()
end

function moveToCover(object)
	fn(object)

	if __wf_atom_7e8ad928(coverWaypoint) == false then
		object:EnterNearestCover(coverWaypoint, true)
	end

	Sleep(0)
	object:__wf_atom_920a5a62()
end

function moveToCoverShootPlayer(object)
	fn(object)
	local playerAvatar = gRegion:GetPlayerAvatar()

	if __wf_atom_7e8ad928(coverWaypoint) == false then
		object:EnterNearestCover(coverWaypoint, true)
	end

	Sleep(0)
	object:__wf_atom_ec52e943(playerAvatar, shootTime, align, true)
	object:__wf_atom_920a5a62()
end

function SetPatrolRoute(object)
	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(patrolRoute)) then
		object:SetPatrolRoute(patrolRoute)
	end
end

function HoldPosition(object)
	object:__wf_atom_5a0e15fd(Symbol("HoldPosition"), 1)
end

function holdPositionShootPlayer(object)
	fn(object)
	local playerAvatar = gRegion:GetPlayerAvatar()
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	while __wf_atom_7e8ad928(object) == false or __wf_atom_7e8ad928(__wf_atom_50a7d83e) == false do
		if object:__wf_atom_5f8ed4be() == false or object:__wf_atom_7b1ee685() == true then
			object:__wf_atom_ec52e943(playerAvatar, shootTime, align, true)
		end

		Sleep(0)
	end

	object:__wf_atom_920a5a62()
end

function shootTarget(object)
	fn(object)

	if __wf_atom_7e8ad928(targ) == false then
		object:SetTarget(targ)
		object:__wf_atom_ae219cdf(targ, shootTime, align, true)
	end

	Sleep(0)
	object:__wf_atom_920a5a62()
end

function playAnim(object)
	fn(object)

	if isAnimLooping == true then
		object:__wf_atom_e40d574c(Anim)
	else
		object:__wf_atom_921c1a5f(Anim, true)
	end
end

function playSimpleAnim(object)
	object:__wf_atom_921c1a5f(Anim, true)
end

function moveToAnim(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	fn(object)
	object:MoveTo(dest, run, align, true)
	object:__wf_atom_921c1a5f(Anim, false)

	while isAnimLooping do
		if object:__wf_atom_5f8ed4be() == false then
			object:__wf_atom_921c1a5f(Anim, true)
			Sleep(0)
		end

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) == true or __wf_atom_7e8ad928(object) == true then
			break
		end
	end

	object:__wf_atom_920a5a62()
end

function useContext(object)
	fn(object)

	if __wf_atom_7e8ad928(action) == false then
		object:UseContextAction(action, true)
		__wf_atom_f2daf912("Found Context Action!")
	else
		__wf_atom_f2daf912("Context Action is Nil!")
	end

	object:__wf_atom_920a5a62()
end

function MoveToPointShootTarget(object)
	fn(object)
	object:MoveTo(dest, run, true, true)
	Sleep(0)
	local _targ = targ

	if __wf_atom_7e8ad928(targ) or not targ:IsA(__wf_atom_96b9d246) then
		if not __wf_atom_7e8ad928(targ) and targ:IsA(gNpcSpawnPointType) then
			local __wf_atom_08228110 = targ:__wf_atom_08228110()

			if not (__wf_atom_7e8ad928(__wf_atom_08228110) or __wf_atom_08228110:IsKilled()) then
				__wf_atom_08228110:__wf_atom_bedb4e3f()
			end
		end
	else
		local __wf_atom_cfb1f23d = targ:__wf_atom_cfb1f23d()

		for i = 1, #__wf_atom_cfb1f23d do
			if
				__wf_atom_7e8ad928(__wf_atom_cfb1f23d[i])
				or __wf_atom_cfb1f23d[i]:IsKilled()
				or __wf_atom_cfb1f23d[i]:__wf_atom_bedb4e3f()
			then
				continue
			end

			local _ = __wf_atom_cfb1f23d[i]
			break
		end
	end

	object:__wf_atom_ae219cdf(targ, shootTime, align, true)

	if idleAfterShoot then
		object:__wf_atom_8b514502()
	end

	object:__wf_atom_920a5a62()
end

function moveToDie(object)
	fn(object)
	object:MoveTo(dest, run, true, false)
	Sleep(2)
	hose:FirePort("Start")
end

function ContextMoveTo(object)
	fn(object)

	if __wf_atom_7e8ad928(action) == false then
		object:UseContextAction(action, true)
	end

	Sleep(0)
	object:MoveTo(dest, run, align, true)
	object:__wf_atom_920a5a62()
end

function ContextMoveToCover(object)
	fn(object)

	if __wf_atom_7e8ad928(action) == false then
		object:UseContextAction(action, true)
	end

	if __wf_atom_7e8ad928(coverWaypoint) == false then
		object:EnterNearestCover(coverWaypoint, true)
	end

	object:__wf_atom_920a5a62()
end

function MakeAvatarVIP()
	local __wf_atom_08228110 = spawncontrol:__wf_atom_dcc0a6f8()[1]:__wf_atom_08228110()
	__wf_atom_08228110:__wf_atom_7470861b():__wf_atom_f756036f(true)
	__wf_atom_08228110:__wf_atom_7c8621d6()
	__wf_atom_08228110:__wf_atom_4990969a(4)
end

function StormNearestPlayer(object)
	if delay > 0 then
		Sleep(delay)
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_50a7d83e()) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()
	local v = nil

	for _, v2 in ipairs(__wf_atom_ef7900cf) do
		if v2:__wf_atom_8a6b8fc3(__wf_atom_50a7d83e) < 9999 then
			v = v2
		end
	end

	if not __wf_atom_7e8ad928(v) then
		object:__wf_atom_30b587a4()
		object:StormTarget(v)
	end
end

function EquipWeapon(object)
	fn2(object) -- inferred equivalent call
end

local function fn3(object) -- 1 equivalent call inferred from this helper
	if __wf_atom_7e8ad928(object) == false then
		object:__wf_atom_069163a3(false)
		object:__wf_atom_7a5ca808(false)
		object:__wf_atom_ae241dc9(false)
		object:__wf_atom_cd7076f3(false, exitOnEnemySeenRadius)
	end
end

function LobotomizeAgent(object)
	fn3(object) -- inferred equivalent call
end

function SetHealthPct(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:SetHealth(__wf_atom_50a7d83e:__wf_atom_c6f1f83d() * healthPct)
	end
end

function SetBlackboardBool(object)
	local __wf_atom_50a7d83e = object:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
		__wf_atom_50a7d83e:SetBlackboardBool(blackboardBoolKey, blackboardBoolVal)
	end
end