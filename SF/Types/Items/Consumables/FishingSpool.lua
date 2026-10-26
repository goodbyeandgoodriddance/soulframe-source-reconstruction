local v = Range(-2, 2)
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.FishingLib")

local function fn(object)
	local nearestWaterVolume = module2.FindNearestWaterVolume(gRegion:__wf_atom_3bc831e3(), object:GetPosition(), v)

	if __wf_atom_7e8ad928(nearestWaterVolume) then
		return false
	end

	local v2 = object:GetPosition() + __wf_atom_9341614d(
		Vector(0, 0, 2),
		Rotation(object:__wf_atom_4e50d390().heading, 0, 0)
	)

	if _T.fishingDebugDrawWaterCheck then
		gRegion:__wf_atom_628723a6(v2 + Vector(0, 10, 0), v2 + Vector(0, -10, 0), Color(255, 0, 0), 30)
		gRegion:__wf_atom_49f801a3(
			nearestWaterVolume:__wf_atom_0aa77159(),
			nearestWaterVolume:__wf_atom_ee03557f(),
			Color(255, 0, 0),
			30
		)
	end

	if not module2.IsPointInWaterVolume2D(nearestWaterVolume, v2) then
		return false
	end

	local v3 = Vector()
	local raycastResult = gRegion:Raycast(v2 + Vector(0, 10, 0), v2 + Vector(0, -10, 0), nil, nil, v3, true, true)

	if _T.fishingDebugDrawWaterCheck and not __wf_atom_7e8ad928(raycastResult) then
		gRegion:__wf_atom_8d991675(v3, 0.1, Color(255, 0, 0), 30)
	end

	if __wf_atom_7e8ad928(raycastResult) or not (v3.y > nearestWaterVolume:__wf_atom_ee03557f().y - 0.2) then
		return true
	end

	return false
end

local function fn2(object)
	local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
	local v2 = object:GetPosition() + __wf_atom_9341614d(
		Vector(0, 2.8, -3.3),
		Rotation(__wf_atom_4e50d390.heading, 0, 0)
	)
	local v3 = __wf_atom_f55d6358(object:GetPosition(), v2, 0.1)
	local v4 = Vector()

	if __wf_atom_7e8ad928((gRegion:__wf_atom_3ec9f18c(v3, v2, 0.25, nil, v4, true, true))) then
		return true
	end

	return false
end

local function fn3(object, p)
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if p then
		__wf_atom_d2b2176d:__wf_atom_f5bb7c84(0, 1)
		__wf_atom_d2b2176d:__wf_atom_f5bb7c84(1, 1)
	else
		__wf_atom_d2b2176d:__wf_atom_f5bb7c84(0, 2)
		__wf_atom_d2b2176d:__wf_atom_f5bb7c84(1, 2)
	end

	for i = 1, 12 do
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(i)

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			__wf_atom_28224c27:__wf_atom_cfecab5d(p)
		end
	end
end

local function fn4(object)
	if
		__wf_atom_7e8ad928(object)
		or object:IsKilled()
		or object:__wf_atom_bedb4e3f()
		or object ~= gRegion:__wf_atom_c4f78a8f()
	then
		return false
	end

	if not module.IsInOverworld() then
		return false
	end

	if
		object:__wf_atom_58dabbc7()
		or object:__wf_atom_47fbd15c()
		or not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8())
	then
		return false
	end

	if object:__wf_atom_7b82e9e1(15) or object:__wf_atom_7b82e9e1(4) then
		return false
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if
		__wf_atom_7e8ad928(__wf_atom_a96eb2aa)
		or __wf_atom_7e8ad928(gRegion:__wf_atom_2202ffb6())
		or __wf_atom_7e8ad928(gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620())
		or gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_37241977(__wf_atom_a96eb2aa)
	then
		return false
	end

	local motionControl = object:MotionControl()

	if not __wf_atom_7e8ad928(motionControl) and motionControl:__wf_atom_1360ebf5() then
		return false
	end

	local __wf_atom_296472bc = object:__wf_atom_296472bc()

	if (__wf_atom_7e8ad928(__wf_atom_296472bc) or not __wf_atom_296472bc.mIsFishing) and fn2(object) and fn(object) then
		return true
	end

	return false
end

function Evaluate(object, _)
	return not object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true) and fn4(object)
end

function ActivateAbility(object, _)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if fn4(__wf_atom_f7e7be53) then
		print("Fishing Minigame Started!")
		__wf_atom_8e4fda44:__wf_atom_3e5e23c0(fishingMovieWeakResource, "")
	elseif __wf_atom_f7e7be53 == gRegion:__wf_atom_c4f78a8f() then
		_T.ShowImpactMessage(invalidWaterMessage, 5)
	end
end

function QuickActivateAbility(p, _)
	if not fn4(p) then
		return
	end

	print("Fishing Minigame Started!")
	__wf_atom_8e4fda44:__wf_atom_3e5e23c0(fishingMovieWeakResource, "")
end

function AddFishingWeapon(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_296472bc = object:__wf_atom_296472bc()

	if not __wf_atom_7e8ad928(__wf_atom_296472bc) and __wf_atom_296472bc.mIsFishing then
		return
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(spoolType) then
		local __wf_atom_97d575cf = object:__wf_atom_d2b2176d():__wf_atom_97d575cf(4)

		if
			not __wf_atom_7e8ad928(__wf_atom_97d575cf)
			and __wf_atom_97d575cf:__wf_atom_3e33d5dd() == 0
			and __wf_atom_97d575cf:IsA(__wf_atom_2dc5c74e)
			and __wf_atom_97d575cf:__wf_atom_1bb5b1ff() ~= spoolType
		then
			object:__wf_atom_d2b2176d():__wf_atom_124699b9(4)
		end

		if not __wf_atom_7e8ad928(spoolType) then
			object:GiveItem(spoolType, false)
			fn3(object, true)
		end
	end

	QuickActivateAbility(object, p)
end

function showWeapons(object, _)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if not __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		fn3(__wf_atom_f7e7be53, false)
	end
end