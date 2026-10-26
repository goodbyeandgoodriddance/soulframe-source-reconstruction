local function fn(p) -- 2 equivalent calls inferred from this helper
	for k, _ in pairs(_T[p]) do
		_T[p][k] = false
	end
end

local function fn2(p)
	local v = tostring(p) .. "Time"

	if _T[v] == nil then
		local v2 = {}

		for i = 1, #requiredTags do
			v2[tostring(requiredTags[i])] = false
		end

		_T[p] = v2
		_T[v] = Time()

		if attackEvent then
			_T[p].TTAAttackEvent = false
		end
	else
		if timeLimit <= 0 then
			return
		end

		if Time() - _T[v] >= timeLimit then
			print("TimedTagChallenge: " .. p .. " - Progress reset")
			_T[v] = Time()
			fn(p) -- inferred equivalent call
		end
	end
end

local function fn3(p)
	for k, v in pairs(_T[p]) do
		if v ~= false then
			continue
		end

		print("TimedTagChallenge: " .. p .. " - " .. k .. " is incomplete, challenge not done yet")
		return false
	end

	_T[p .. "Time"] = 0
	fn(p) -- inferred equivalent call
	print("TimedTagChallenge: " .. p .. " - Challenge success")
	return true
end

local function fn4(object, p) -- 2 equivalent calls inferred from this helper
	tostring(object:__wf_atom_6be84646())
	return tostring(uniqueChallengeId) .. p .. tostring(object:__wf_atom_6be84646())
end

function MatchTagEvent(object, p, _, _, _, p2)
	local v = fn4(object, p2) -- inferred equivalent call

	if _T[v] ~= nil and _T[v][p] == nil then
		return
	end

	fn2(v)

	if _T[v][p] ~= false then
		return false
	end

	_T[v][p] = true
	print("TimedTagChallenge: " .. v .. " - " .. p .. " triggered!")
	return (fn3(v))
end

function MatchAttackEvent(_, object, _, p)
	if not attackEvent then
		return false
	end

	local v = fn4(object, p) -- inferred equivalent call
	fn2(v)
	_T[v].TTAAttackEvent = true
	print("TimedTagChallenge: " .. v .. " - TTAAttackEvent triggered!")
	return (fn3(v))
end