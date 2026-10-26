local v = {
	"AncestorNode1",
	"AncestorNode2",
	"AncestorNode3",
	"AncestorNode4",
	"AncestorNode5",
	"AncestorNode6"
}
local v2 = nil
local count = 0
local v3 = nil

function DissolveOut(object)
	local v4 = 0

	while v4 < 1 do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() * 0.5, 0, 1)
		object:__wf_atom_68f2c268(v4)
		Sleep(0)
	end
end

function DissolveIn(object)
	local v4 = 0

	while v4 < 1 do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() * 0.5, 0, 1)
		object:__wf_atom_68f2c268(1 - v4)
		Sleep(0)
	end
end

function InitNodes()
	count = 0
	local __wf_atom_a87d87b5 = gGameData:GetInventory():__wf_atom_a87d87b5()

	for _, v4 in ipairs(__wf_atom_a87d87b5) do
		if v4.mRank >= 0 then
			count += 1
		end
	end

	for i = 1, #v do
		if i <= count then
			mMovie:__wf_atom_7f57ab2f(v[i], "Missing", 13, false)
		else
			mMovie:__wf_atom_7f57ab2f(v[i], "Found", 13, false)
		end

		mMovie:__wf_atom_e57658c2(v[i], 4, -1000)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v[i], 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v[i], 1)
		mMovie:__wf_atom_e57658c2(v[i], 12, 0)
		mMovie:__wf_atom_e57658c2(v[i], 0, 960)
		mMovie:__wf_atom_e57658c2(v[i], 1, 1080)
		mMovie:__wf_atom_e57658c2(v[i], 11, 14540253)
		local v4 = v[i]
		__wf_atom_ec43d06e(mMovie, v4, 0, { function(p)
				local v5 = __wf_atom_24a82b69(p)
				local v6 = __wf_atom_104bfe98(960, __wf_atom_5e6e15c8, v5 * v5)
				local v7 = __wf_atom_104bfe98(1080, __wf_atom_5e6e15c8_2, v5)
				local v8 = v6 + math.sin(v5 * 3.141592653589793 * 2) * 50 + Noise(Time() * 0.3) * 50 * v5
				local v9 = v7 + math.abs((math.sin(v5 * 3.141592653589793 * 1))) * -150 * v5
				mMovie:__wf_atom_e57658c2(v4, 0, v8)
				mMovie:__wf_atom_e57658c2(v4, 1, v9)
				mMovie:__wf_atom_e57658c2(v4, 12, v5 * v5 * 100)
			end }, { 1 }, 2, math.random())
	end
end

function Initialize()
	if __wf_atom_7e8ad928((__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))) then
		mMovie:Close()
		return
	end

	local module = require("Lotus.Interface.Libs.TimerMgr")
	v3 = module.CreateTimerMgr()
	local nearestTagged = gRegion:FindNearestTagged(
		Symbol("BabyAncestralTree"),
		gRegion:__wf_atom_c4f78a8f():GetPosition()
	)
	local _ = Vector(0, 2, 0) * (1 / 6)
	mMovie:__wf_atom_8a679cf7(nearestTagged, Vector(0.05, 0.8, 0), Rotation(130, 0, 0), Vector(7.199999999999999, 6, 6))
	mMovie:__wf_atom_e57658c2("_root", 11, 14540253)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 2, 0)
	mMovie:__wf_atom_e57658c2("Tree", 5, 80)
	mMovie:__wf_atom_e57658c2("Tree", 6, 80)
	__wf_atom_ec43d06e(mMovie, "Tree", 8, { 5, 6 }, { 100, 100 }, 2, 0)
	gRegion:FindNearestTagged(Symbol("BabyAncestralTree"), gRegion:__wf_atom_c4f78a8f():GetPosition()):__wf_atom_8a035cd5(
		Symbol("DissolveOut"),
		false
	)
	InitNodes()
	gRegion:__wf_atom_c4f78a8f():PlaySound(startSound, false)
	mMovie:OverrideMaterial("LocationHint", locationHintMaterial)
	mMovie:__wf_atom_e57658c2("LocationHint", 4, -1000)
	mMovie:__wf_atom_e57658c2("LocationHint", 12, 0)
	mMovie:__wf_atom_e57658c2("LocationHint", 5, 75)
	mMovie:__wf_atom_e57658c2("LocationHint", 6, 75)
end

local function fn()
	if count ~= 0 then
		return
	end

	local gameCamera = gRegion:GetGameCamera()
	local position = gameCamera:GetPosition()
	local __wf_atom_a06d543c = gameCamera:__wf_atom_a06d543c()
	local v4 = 0.997
	local v5 = -1

	for i = 1, #v do
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v[i], 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v[i], 1)
		local v6 = mMovie:__wf_atom_09e83ac4(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2) - position
		Normalize(v6)
		local v7 = Dot(v6, __wf_atom_a06d543c)

		if not (v4 < v7) then
			continue
		end

		v5 = i
		v4 = v7
	end

	if v5 == 1 and v2 ~= v5 then
		v2 = 1
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v[1], 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v[1], 1)
		local v6

		if __wf_atom_5e6e15c8 > 960 then
			v6 = __wf_atom_5e6e15c8 + 100
		else
			v6 = __wf_atom_5e6e15c8 - 100
		end

		mMovie:__wf_atom_e57658c2("LocationHint", 0, v6)
		mMovie:__wf_atom_e57658c2("LocationHint", 1, __wf_atom_5e6e15c8_2)
		__wf_atom_ec43d06e(mMovie, "LocationHint", 8, { 5, 6, 12 }, { 100, 100, 100 }, 2, 0)
	elseif v2 ~= v5 then
		v2 = v5
		__wf_atom_ec43d06e(mMovie, "LocationHint", 8, { 5, 6, 12 }, { 75, 75, 0 }, 2, 0)
	end
end

function Update()
	local v4 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v4)

	if not __wf_atom_7e8ad928(v3) then
		v3:Update(v4)
	end

	fn()
end

function CloseAsync()
	gRegion:__wf_atom_c4f78a8f():PlaySound(closeSound, false)
	gRegion:FindNearestTagged(Symbol("BabyAncestralTree"), gRegion:__wf_atom_c4f78a8f():GetPosition()):__wf_atom_8a035cd5(
		Symbol("DissolveIn"),
		false
	)

	for i = 1, #v do
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v[i], 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v[i], 1)
		local v4 = v[i]
		__wf_atom_ec43d06e(mMovie, v4, 0, { function(p)
				local v5 = 1 - p
				local v6 = __wf_atom_24a82b69(v5)
				local v7 = __wf_atom_104bfe98(960, __wf_atom_5e6e15c8, v6 * v6)
				local v8 = __wf_atom_104bfe98(1080, __wf_atom_5e6e15c8_2, v6)
				local v9 = v7 + math.sin(v6 * 3.141592653589793 * 2) * 50 + Noise(Time() * 0.3) * 50 * v6
				local v10 = v8 + math.abs((math.sin(v6 * 3.141592653589793 * 1))) * -150 * v6
				mMovie:__wf_atom_e57658c2(v4, 0, v9)
				mMovie:__wf_atom_e57658c2(v4, 1, v10)
				mMovie:__wf_atom_e57658c2(v4, 12, v6 * v6 * 100)
			end }, { 1 }, 1.5, math.random())
	end

	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 2, 0, function()
		_T.gToolTip = nil
		mMovie:Close()
	end)
end