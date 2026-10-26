Symbol("LightMirrorButton")
local v = Symbol("LightMirrorMover")
require("SF.Scripts.Libs.CommonFunctionsLib")

function MirrorOnHit(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_9c4e6f99)
	local total = 0

	while __wf_atom_7e8ad928(__wf_atom_bb3e7833) and total < 0.1 do
		__wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_9c4e6f99)
		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		local __wf_atom_9f2332e5 = __wf_atom_bb3e7833:__wf_atom_9f2332e5()
		local v2

		if not __wf_atom_7e8ad928(__wf_atom_9f2332e5) then
			v2 = __wf_atom_9f2332e5:__wf_atom_6009c8ed() or nil
		end

		local v3

		if not __wf_atom_7e8ad928(v2) then
			v3 = v2:__wf_atom_a96eb2aa() or nil
		end

		if not __wf_atom_7e8ad928(v3) and v3:IsLocal() then
			__wf_atom_bb3e7833:__wf_atom_696c19a3(__wf_atom_28d5d4aa)
		end
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	if gRegion:IsMaster() then
		if not __wf_atom_7e8ad928(hitSound) then
			object:PlaySound(hitSound, false)
		end

		if not isImmuneToProjectiles then
			object:__wf_atom_0eb78444()
		end

		if not __wf_atom_7e8ad928(object) then
			object:SetHealth((object:__wf_atom_95174740()))
		end
	end
end

function MirrorOnTouched(object, object2)
	if not isRemoteAction then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
		__wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_6a50bd07)
		__wf_atom_3d96ddcd:__wf_atom_0eb78444()
	end

	object2:__wf_atom_921c1a5f(playerTouchAnim, true, 3, 1, true)
	Sleep(1)

	if disableOnUse then
		object:Disable()
	else
		object:Enable()
	end
end

function LightBeam(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_d00f34c2)
	local v2 = nil
	local v3 = false
	local v4 = nil
	local v5 = nil
	local v6 = nil

	while __wf_atom_7e8ad928(gGameRules) or not gGameRules:__wf_atom_adfb052a() do
		Sleep(0)
	end

	if not beamAlwaysOn then
		object:Disable()
		Sleep(0.1)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:TurnOff()
		end
	end

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_81548e8e = object:__wf_atom_81548e8e()
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
		local v7 = __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and true or false

		if v2 == __wf_atom_81548e8e and object:IsActive() == v3 then
			if
				__wf_atom_81548e8e ~= v4
				and not __wf_atom_7e8ad928(v5)
				and v5:__wf_atom_b81a6e66()
				and v6:__wf_atom_95e72410() == object
			then
				v5:Deactivate()
			end
		else
			local v8

			if __wf_atom_7e8ad928(__wf_atom_81548e8e) then
				v8 = false
			else
				v8 = string.match(tostring(__wf_atom_81548e8e:__wf_atom_db682341()), (tostring(v)))
			end

			if not __wf_atom_7e8ad928(v2) then
				string.match(tostring(v2:__wf_atom_db682341()), (tostring(v)))
			end

			if v8 then
				if __wf_atom_81548e8e:__wf_atom_1bb5b1ff() == __wf_atom_6a50bd07 then
					v6 = __wf_atom_81548e8e
				else
					local __wf_atom_bb3e7833_2 = __wf_atom_81548e8e:__wf_atom_bb3e7833(__wf_atom_6a50bd07)

					if
						not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2)
						and __wf_atom_bb3e7833_2:__wf_atom_1bb5b1ff() ~= __wf_atom_6a50bd07
					then
						v6 = __wf_atom_bb3e7833_2
					end
				end

				if
					not __wf_atom_7e8ad928(v6)
					and (v7 or v6:__wf_atom_bb3e7833(__wf_atom_872ff757) ~= __wf_atom_3d96ddcd:__wf_atom_95e72410())
				then
					if object:IsActive() then
						v6:Activate()
						v6:SetOwner(object)
					end

					v4 = __wf_atom_81548e8e
					v5 = v6
				end
			end

			v2 = __wf_atom_81548e8e
		end

		if object:IsActive() then
			v3 = v3 or true
		elseif v3 then
			if not __wf_atom_7e8ad928(v5) and v5:__wf_atom_b81a6e66() and v6:__wf_atom_95e72410() == object then
				v5:Deactivate()
			end

			v3 = false
		end

		Sleep(0)
	end
end

function MirrorOnEnabled(object)
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local v5 = false

	while __wf_atom_7e8ad928(gGameRules) or not gGameRules:__wf_atom_adfb052a() do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		print("Light mirror script exited, most likely due to streaming out of the level or host migration.")
		return
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_872ff757)
	local __wf_atom_bb3e7833_2 = __wf_atom_bb3e7833:__wf_atom_bb3e7833(__wf_atom_d00f34c2)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		v2 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_0f45538d)
		v3 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_7b01f9ce)
		v4 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(__wf_atom_465d956f)

		if not __wf_atom_7e8ad928(v2) then
			v2:Enable()
		end

		if not __wf_atom_7e8ad928(v3) then
			v3:Enable()
		end

		if not __wf_atom_7e8ad928(v4) then
			v4:Enable()
		end

		__wf_atom_3d96ddcd:FirePort("Enable")
	end

	while not __wf_atom_7e8ad928(object) and object:IsEnabled() do
		if object:__wf_atom_b81a6e66() and not v5 then
			__wf_atom_bb3e7833:Enable()

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
				__wf_atom_bb3e7833_2:TurnOn()
			end

			if not __wf_atom_7e8ad928(lightOnSound) then
				__wf_atom_bb3e7833:PlaySound(lightOnSound, false)
			end

			v5 = true
		elseif not object:__wf_atom_b81a6e66() and v5 then
			__wf_atom_bb3e7833:Disable()

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
				__wf_atom_bb3e7833_2:TurnOff()
			end

			if not __wf_atom_7e8ad928(lightOffSound) then
				__wf_atom_bb3e7833:PlaySound(lightOffSound, false)
			end

			v5 = false
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		if not __wf_atom_7e8ad928(v2) then
			v2:Disable()
		end

		if not __wf_atom_7e8ad928(v3) then
			v3:Disable()
		end

		if not __wf_atom_7e8ad928(v4) then
			v4:Disable()
		end

		__wf_atom_3d96ddcd:FirePort("Disable")
	end
end

function OnDisabled(object)
	local __wf_atom_81548e8e = object:__wf_atom_81548e8e()

	if not string.match(tostring(__wf_atom_81548e8e:__wf_atom_db682341()), (tostring(v))) then
		__wf_atom_81548e8e = nil
	end

	if not __wf_atom_7e8ad928(__wf_atom_81548e8e) then
		__wf_atom_81548e8e:Deactivate()
	end
end