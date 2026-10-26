function AttachedActionOnActivated(object, object2)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:Activate()
	end

	if not __wf_atom_7e8ad928(playerTouchAnim) then
		object2:__wf_atom_921c1a5f(playerTouchAnim, true, 3, 1, true)
	end

	Sleep(delay)

	if disableOnUse then
		object:Disable()
	else
		object:Enable()
	end
end

function ButtonOnEnabled(object)
	local flag = false
	local v = nil
	local v2 = nil
	object:FirePort("Show")
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_0f45538d)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Enable()
	end

	if not returnPickUp then
		return
	end

	while not __wf_atom_7e8ad928(object) do
		if flag then
			if not object:__wf_atom_b81a6e66() then
				if not __wf_atom_7e8ad928(pickupType) then
					v2 = gRegion:CreateEntity(pickupType, object:GetPosition(), object:__wf_atom_dc309f8a())
					object:Deactivate()
					object:FirePort("Hide")

					if not __wf_atom_7e8ad928(v) then
						v:FirePort("Destroy")
					end

					if not reusable then
						object:Disable()
						break
					end
				end

				flag = false
			end
		else
			if object:__wf_atom_b81a6e66() then
				if not __wf_atom_7e8ad928(droppedEffect) then
					v = object:Attach(droppedEffect, EMPTY_SYMBOL)
				end

				if autoDeactivate then
					Sleep(autoDeactivateDelay)
					object:FirePort("Deactivate")
				end

				flag = true
			end

			if reusable and __wf_atom_7e8ad928(v2) then
				__wf_atom_bb3e7833:Enable()
			end
		end

		Sleep(0.1)
	end
end

function EvaluateIfCarriesItems(_, object)
	for _, v in disallowedItemTypes do
		if object:HasItem(v) then
			return false
		end
	end

	return true
end

local function fn(object) -- 1 equivalent call inferred from this helper
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_9d6c02e9 = __wf_atom_d2b2176d:__wf_atom_9d6c02e9(4)

	if __wf_atom_9d6c02e9 < 4 then
		__wf_atom_d2b2176d:__wf_atom_08ff49d5(__wf_atom_9d6c02e9)
	end
end

function DropPickUpOneShot(object)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and object:__wf_atom_8a6b8fc3(__wf_atom_c4f78a8f) < maxPickUpForceDropRange
	then
		fn(__wf_atom_c4f78a8f) -- inferred equivalent call
	end
end