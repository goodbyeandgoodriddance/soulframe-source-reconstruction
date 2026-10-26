local v = nil
local v2 = nil
local module = require("SF.Scripts.Libs.SparrowLib")

local function fn(object)
	for i = 1, #v do
		if
			not __wf_atom_7e8ad928(v[i])
			and v[i]:__wf_atom_8a6b8fc3(object) < 6
			and not v[i]:IsKilled()
			and v[i]:__wf_atom_3a6b0cbb()
		then
			return true
		end
	end
end

local function fn2(instance, object, callback, p, p2, p3, p4)
	if not __wf_atom_7e8ad928(object) and object ~= gRegion:__wf_atom_c4f78a8f() then
		return
	end

	if hideWhenInCombat and __wf_atom_7e8ad928(v) then
		local v3 = Symbol("Neutral")
		v = gRegion:FindAll(__wf_atom_9e85eea2)

		for i = #v, 1, -1 do
			if not (v[i]:__wf_atom_e93896ba() == v3 or v[i]:__wf_atom_129d1aba(object)) then
				continue
			end

			table.remove(v, i)
		end
	end

	local flag = false
	local v3 = p or tostring(tutorialMessage)
	local total = 0
	local v4 = p2 or duration

	if startDelay > 0 then
		if not __wf_atom_7e8ad928(_T.HideImpactMessage) then
			_T.HideImpactMessage()
		end

		Sleep(startDelay)
	end

	while
		(not useBounds or useBounds and not __wf_atom_7e8ad928(object) and not object:IsKilled() and instance:__wf_atom_4b409d7b(object))
		and not (v4 > 0 and v4 <= total)
		and instance:IsEnabled()
		and (__wf_atom_7e8ad928(callback) or not callback())
	do
		if hideWhenInCombat and fn(object) then
			if not __wf_atom_7e8ad928(_T.HideImpactMessage) then
				_T.HideImpactMessage()
				Sleep(2)
				flag = false
			end
		elseif not (flag or __wf_atom_7e8ad928(_T.ShowImpactMessage)) then
			_T.FocusCodexMovie = focusCodexTab ~= EMPTY_SYMBOL
			_T.FocusCodexTab = focusCodexTab
			_T.FocusCodexEntry = focusCodexEntry
			_T.ShowImpactMessage(v3, -1, nil, nil, p3)
			total += 2
			Sleep(2)
			flag = true
		end

		if flag then
			total += 0.1
		end

		Sleep(0.1)
	end

	if not __wf_atom_7e8ad928(_T.HideImpactMessage) then
		_T.HideImpactMessage()
	end

	if destroyWhenDone and not (p4 or __wf_atom_7e8ad928(instance)) then
		instance:Destroy()
	end

	Sleep(500)

	if _T.FocusCodexTab == focusCodexTab and _T.FocusCodexEntry == focusCodexEntry then
		_T.FocusCodexMovie = nil
		_T.FocusCodexTab = nil
		_T.FocusCodexEntry = nil
	end
end

local function fn3(object, p)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return false
	end

	if p then
		__wf_atom_d2b2176d:AddUpgrade(283, 4, 1)
	else
		__wf_atom_d2b2176d:RemoveUpgrade(283, 4, 1)
	end

	return true
end

function SimpleTutorialMessageTrigger(p, p2)
	fn2(p, p2)
end

function MultiTutorialMessageTrigger(p, p2)
	for i, v3 in ipairs(multiTutorialMessages) do
		fn2(p, p2, nil, tostring(v3), multiTutorialDuration[i], nil, i < #multiTutorialMessages)
	end
end

function SparrowTutorialMessageTrigger(p, p2)
	fn2(p, p2, function()
		return module.SparrowGuidingForPlayer(p2)
	end)
end

function SoulModeTutorialMessageTrigger(p, p2)
	fn2(p, p2, function()
		if __wf_atom_7e8ad928(v2) then
			v2 = gRegion:__wf_atom_c4f78a8f()
		end

		if __wf_atom_7e8ad928(v2) or not (v2:__wf_atom_92aa9d91():__wf_atom_3911136e() or _T.ForceSoulMode) then
			return false
		end

		return true
	end)
end

function HealTutorial(p, object)
	local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()
	local maxHealth = object:GetMaxHealth()
	local v3 = __wf_atom_c6f1f83d

	local function fn4()
		v3 = object:__wf_atom_c6f1f83d()

		if __wf_atom_c6f1f83d < v3 or maxHealth <= v3 then
			return true
		end
	end

	local v4 = { INPUT = "GEAR_HOTKEY_0" }

	if Engine.IsPlayingWithController() then
		v4.INPUT = "GAMEPAD_UP"
	end

	fn2(p, object, fn4)
end

function ThrowSwordTutorial(object, object2)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("TrapDeco"))
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local v3 = 8

	local function fn4()
		if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) and __wf_atom_9fb9a1d6:__wf_atom_c5d04cb3() then
			return true
		end

		for _, v4 in ipairs(__wf_atom_2226b35c) do
			if __wf_atom_7e8ad928(v4) then
				return true
			end
		end
	end

	local function fn5()
		if __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) or __wf_atom_9fb9a1d6:__wf_atom_c5d04cb3() then
			return
		else
			return true
		end
	end

	local function fn6()
		v3 -= 0.1
	end

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) and __wf_atom_e55d02aa:__wf_atom_5b41f63b() == "ChampionSoul" then
		if not (__wf_atom_7e8ad928(__wf_atom_9fb9a1d6) or __wf_atom_9fb9a1d6:__wf_atom_c5d04cb3()) then
			fn2(object, object2, fn4, "/SF/Language/Tutorial/SwordThrow", 0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) and __wf_atom_9fb9a1d6:__wf_atom_c5d04cb3() then
			fn2(object, object2, fn5, "/SF/Language/Tutorial/SwordRecall", 0)
		end
	end

	fn2(object, object2, fn6, "/SF/Language/Tutorial/HeavyAttack", 0)

	if not __wf_atom_7e8ad928(object) and v3 <= 0 then
		object:FirePort("Disable")
	end
end

function SmiteTutorial(object, p)
	if not fn3(p, true) then
		return
	end

	if not __wf_atom_7e8ad928(npcSpawnControl) then
		local v3 = WeakResource("/SF/Types/Gameplay/EnergyRestoreTrigger")
		local v4 = false

		while not (__wf_atom_7e8ad928(npcSpawnControl) or v4) do
			local __wf_atom_cfb1f23d = npcSpawnControl:__wf_atom_cfb1f23d()

			if #__wf_atom_cfb1f23d == 0 then
				fn3(p, false)
				return
			end

			for _, v5 in ipairs(__wf_atom_cfb1f23d) do
				if not v5:__wf_atom_a586ea4c(v3) then
					continue
				end

				v4 = true
				break
			end

			Sleep(0.1)
		end

		if __wf_atom_7e8ad928(npcSpawnControl) then
			fn3(p, false)
			return
		end
	end

	fn2(object, p, function()
		if __wf_atom_7e8ad928(npcSpawnControl) or npcSpawnControl:__wf_atom_76c21920() ~= 0 then
			return
		else
			return true
		end
	end)
	fn3(p, false)
	Sleep(2)
	_T.ShowImpactMessage("/SF/Language/Tutorial/SmiteContext", 5)

	if not __wf_atom_7e8ad928(object) then
		object:Disable()
	end
end