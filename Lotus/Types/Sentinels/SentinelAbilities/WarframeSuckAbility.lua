local function fn(p) -- 2 equivalent calls inferred from this helper
	local v = nil

	if p <= #triggerRadii then
		return triggerRadii[p]
	end

	if #v > 0 then
		return triggerRadii[1]
	end

	return v
end

function GetDescriptionInfo(p)
	local v = { RADIUS = fn(p) } -- inferred equivalent call
	return cjson.encode(v)
end

local function fn2(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	if not __wf_atom_7e8ad928(object:__wf_atom_a96eb2aa()) then
		return object:__wf_atom_a96eb2aa()
	end

	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		return nil
	end

	if __wf_atom_f7e7be53:IsA(__wf_atom_47cae841) and __wf_atom_f7e7be53:__wf_atom_a96eb2aa() then
		return __wf_atom_f7e7be53:__wf_atom_a96eb2aa()
	end

	return nil
end

function NpcEvaluateAbility(_, object, _, _)
	local __wf_atom_6115a2e2 = object:__wf_atom_6115a2e2()

	if __wf_atom_7e8ad928(__wf_atom_6115a2e2) or __wf_atom_6115a2e2:IsKilled() then
		return 0
	end

	local v = fn2(__wf_atom_6115a2e2)

	if __wf_atom_7e8ad928(v) or not v:__wf_atom_cc1fa73e() then
		return 0
	end

	return 1
end

function ActivateAbility(object, object2, _, p, _)
	local __wf_atom_6115a2e2 = object2:__wf_atom_6115a2e2()

	if __wf_atom_7e8ad928(__wf_atom_6115a2e2) then
		return
	end

	if __wf_atom_6115a2e2:__wf_atom_631bafa1() then
		local __wf_atom_6115a2e2_2 = object2:__wf_atom_6115a2e2()
		local v

		if __wf_atom_7e8ad928(__wf_atom_6115a2e2_2) or __wf_atom_6115a2e2_2:IsKilled() then
			v = 0
		else
			local v2 = fn2(__wf_atom_6115a2e2_2)
			v = (__wf_atom_7e8ad928(v2) or not v2:__wf_atom_cc1fa73e()) and 0 or 1
		end

		if v <= 0 then
			return
		end

		local __wf_atom_5b41f63b = object2:__wf_atom_5b41f63b()

		if __wf_atom_7e8ad928(_T.gSuckTriggers) then
			_T.gSuckTriggers = {}
		end

		if __wf_atom_7e8ad928(_T.gSuckTriggers[__wf_atom_5b41f63b]) then
			local v2 = fn(p) -- inferred equivalent call

			if __wf_atom_7e8ad928(v2) then
				return
			end

			_T.gSuckTriggers[__wf_atom_5b41f63b] = __wf_atom_6115a2e2:Attach(
				triggerType,
				triggerAttachBone,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1,
				object2
			)
			_T.gSuckTriggers[__wf_atom_5b41f63b]:__wf_atom_400189c4(v2)
		end

		local gSuckTrigger = _T.gSuckTriggers[__wf_atom_5b41f63b]
		gSuckTrigger:Enable()
		local __wf_atom_f7e7be53 = gSuckTrigger:__wf_atom_f7e7be53()

		while not (__wf_atom_7e8ad928(gSuckTrigger) or __wf_atom_7e8ad928(object2)) do
			local __wf_atom_6115a2e2_3 = object2:__wf_atom_6115a2e2()

			if __wf_atom_7e8ad928(fn2(__wf_atom_6115a2e2_3)) then
				break
			end

			if __wf_atom_6115a2e2_3 ~= __wf_atom_f7e7be53 then
				gSuckTrigger:__wf_atom_dc5956fc(__wf_atom_6115a2e2_3, triggerAttachBone)
				__wf_atom_f7e7be53 = __wf_atom_6115a2e2_3
			end

			if gRegion:IsMaster() then
				local __wf_atom_6115a2e2_4 = object2:__wf_atom_6115a2e2()
				local v2

				if __wf_atom_7e8ad928(__wf_atom_6115a2e2_4) or __wf_atom_6115a2e2_4:IsKilled() then
					v2 = 0
				else
					local v3 = fn2(__wf_atom_6115a2e2_4)
					v2 = (__wf_atom_7e8ad928(v3) or not v3:__wf_atom_cc1fa73e()) and 0 or 1
				end

				if v2 <= 0 then
					object:__wf_atom_e8954328()
					return
				end
			end

			Sleep(0)
		end
	elseif gRegion:IsMaster() then
		while true do
			local __wf_atom_6115a2e2_2 = object2:__wf_atom_6115a2e2()
			local v

			if __wf_atom_7e8ad928(__wf_atom_6115a2e2_2) or __wf_atom_6115a2e2_2:IsKilled() then
				v = 0
			else
				local v2 = fn2(__wf_atom_6115a2e2_2)
				v = (__wf_atom_7e8ad928(v2) or not v2:__wf_atom_cc1fa73e()) and 0 or 1
			end

			if v > 0 then
				Sleep(1)
			else
				break
			end
		end

		object:__wf_atom_e8954328()
	else
		while true do
			Sleep(10)
		end
	end
end

function DeactivateAbility(_, object, _, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if not (__wf_atom_7e8ad928(_T.gSuckTriggers) or __wf_atom_7e8ad928(_T.gSuckTriggers[__wf_atom_5b41f63b])) then
		_T.gSuckTriggers[__wf_atom_5b41f63b]:Disable()
	end
end