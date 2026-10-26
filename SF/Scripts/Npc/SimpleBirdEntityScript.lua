local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Scripts.Libs.SparrowLib")
local v = nil
local v2 = nil
local v3 = nil
local v4 = false
local v5 = false
local v6 = {}
local v7 = Symbol("SparrowWait")
local v8 = Symbol("SparrowPerchPoint")
local v9 = Symbol("SparrowHoverPoint")
local v10 = nil
local landAnim2 = nil
local toHoverAnim2 = nil
local idleHoverAnim2 = nil

local function fn(p)
	if __wf_atom_7e8ad928(p) then
		v6 = {}
		return
	end

	local v11 = nil
	local v12

	if not __wf_atom_7e8ad928(landAnim) then
		v12 = gRegion:__wf_atom_439c0d29(v8, p, 0, 5)
	end

	if not __wf_atom_7e8ad928(toHoverAnim) then
		v11 = gRegion:__wf_atom_439c0d29(v9, p, 0, 5)
	end

	v6 = module.MergeTables(v12, v11)
end

local function fn2(object)
	local v11 = {
		__wf_atom_7b01f9ce,
		__wf_atom_d127f143,
		__wf_atom_43e0c427,
		__wf_atom_3feeb44a,
		__wf_atom_4ebf67cb
	}
	local __wf_atom_cea57010 = object:__wf_atom_cea57010()
	__wf_atom_cea57010.bank = 0
	local v12 = 1 - __wf_atom_421b01aa(math.abs(__wf_atom_cea57010.pitch / 90), 0, 1)
	local v13 = birdDestOffset.z * v12
	local v14 = birdDestOffset.y * v12
	local selected = object:EyePosition() + __wf_atom_9341614d(Vector(birdDestOffset.x, v14, v13), __wf_atom_cea57010)
	local v15 = Vector()

	if not __wf_atom_7e8ad928((gRegion:__wf_atom_fbb89790(object:EyePosition(), selected, 0.2, nil, v11, nil, v15))) then
		selected = v15
	end

	selected.y = object:EyePosition().y
	return selected
end

local function fn3(instance)
	Sleep(10)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local v11 = 2.5

	while v11 >= 0 do
		instance:__wf_atom_a763aa1a(__wf_atom_421b01aa(1 - v11 / 5, 0, 1))
		Sleep(0)
		v11 -= __wf_atom_03df4e1d()
	end

	instance:Destroy()
end

local function fn4()
	local v11 = {}

	for _, v12 in ipairs(v6) do
		if v12:IsEnabled() then
			table.insert(v11, v12)
		end
	end

	if #v11 == 0 then
		return
	end

	local __wf_atom_e919fb8e = v2:__wf_atom_e919fb8e()
	local perchPoint

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.perchPoint) then
		perchPoint = v11[__wf_atom_5784a397(1, #v11)]
	else
		perchPoint = __wf_atom_e919fb8e.perchPoint
	end

	local v12 = perchPoint:__wf_atom_db682341() == v9
	local position = perchPoint:GetPosition()
	local __wf_atom_dc309f8a = perchPoint:__wf_atom_dc309f8a()
	v:__wf_atom_5a0e15fd(v7, 1)

	if v12 then
		toHoverAnim2 = toHoverAnim
		idleHoverAnim2 = idleHoverAnim
	else
		idleHoverAnim2 = perchLoopAnim[__wf_atom_5784a397(1, #perchLoopAnim)]
		landAnim2 = landAnim
		toHoverAnim2 = rotateAnim
	end

	if not __wf_atom_7e8ad928(landAnim2) then
		v2:__wf_atom_e4df34a5(false)
		v2:__wf_atom_3c986cd9(position, __wf_atom_dc309f8a, false)
		v2:__wf_atom_921c1a5f(landAnim2, true, 3, 1, true)

		while not __wf_atom_7e8ad928(v2) and v2:__wf_atom_c138b19b(landAnim2) do
			Sleep(0)
		end

		v2:__wf_atom_e4df34a5(true)
	end

	if not __wf_atom_7e8ad928(toHoverAnim2) then
		local v13

		if __wf_atom_7e8ad928(nil) then
			v13 = v2:GetPosition()
		else
			v13 = (nil):GetPosition()
		end

		local v14 = __wf_atom_fa8d0177(position, v13)
		v2:__wf_atom_3c986cd9(position, v14, false)
		v2:__wf_atom_921c1a5f(toHoverAnim2, true, 3, 1, true)
	end

	if not __wf_atom_7e8ad928(idleHoverAnim2) then
		v2:__wf_atom_921c1a5f(idleHoverAnim2, false, 3, 2, true)
	end

	local _sparrowDebugDraw = _T.SparrowDebugDraw
	v3 = perchPoint

	if v12 then
		v5 = true
	else
		v4 = true
	end

	return true
end

local function fn5()
	v:__wf_atom_b783ff91((fn2(v2)))

	if not __wf_atom_7e8ad928(v2) then
		if v2:__wf_atom_c138b19b(idleHoverAnim2) then
			v2:__wf_atom_921c1a5f(takeOffAnim, false, 3, 1, true)
		elseif v2:__wf_atom_c138b19b(idleHoverAnim) then
			v2:__wf_atom_921c1a5f(fromHoverAnim, false, 0, 1, true)
		end
	end

	v3 = nil
	v4 = false
	v5 = false
	v:ClearAgentBlackboardEntry(v7)

	while v2:__wf_atom_c138b19b(takeOffAnim) or v2:__wf_atom_c138b19b(fromHoverAnim) do
		Sleep(1)
	end

	local postFeedLifeTime = postFeedLifeTime

	while postFeedLifeTime > 0 do
		postFeedLifeTime = -__wf_atom_084b3e93()
		Sleep(0)
	end

	fn3(v2)
end

function BirdEntityScript(p)
	v2 = p
	v = v2:__wf_atom_30e3d82b()

	while __wf_atom_7e8ad928(v) do
		v = v2:__wf_atom_30e3d82b()
		Sleep(0)
	end

	local __wf_atom_e919fb8e = v2:__wf_atom_e919fb8e()

	if not (__wf_atom_7e8ad928(v) and __wf_atom_7e8ad928(v2)) then
		v10 = v:__wf_atom_049aa7d4()
		fn(v10)
		local v11 = __wf_atom_5784a397(perchLoopLength.minValue, perchLoopLength.maxValue)
		local flag = true

		while flag do
			if __wf_atom_7e8ad928(__wf_atom_e919fb8e.ForcePerch) then
				if (v4 or v5) and (__wf_atom_7e8ad928(v3) or not v3:IsEnabled()) then
					fn5()
					flag = false
				elseif
					v4
					or v5 and not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.ForcePerch) or __wf_atom_e919fb8e.ForcePerch)
				then
					if v11 <= 0 then
						v3:Disable()
					end

					v11 -= __wf_atom_084b3e93()
				elseif not __wf_atom_7e8ad928(v10) then
					local __wf_atom_a5304c35 = v2:__wf_atom_a5304c35(v10)

					if v4 or v5 or not (__wf_atom_a5304c35 <= 4) then
						if not v4 and not v5 and __wf_atom_a5304c35 < 3 then
							v:__wf_atom_24ddbdc3()
							v2:__wf_atom_e06358f3(Symbol("SearchHover"))
						end
					else
						fn4()
					end
				end
			elseif __wf_atom_e919fb8e.ForcePerch and not v4 then
				fn4()
			elseif __wf_atom_e919fb8e.ForcePerch == false then
				fn5()
				flag = false
			end

			Sleep(0)
		end
	end
end