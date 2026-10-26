local v = Symbol("HeightTotal")
local v2 = Symbol("HeightThreshold")

local function fn(object, p, p2)
	object:SetMaterialParam(p, p2)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)

	for _, v3 in ipairs(__wf_atom_f582136d) do
		local __wf_atom_d0069154 = v3:__wf_atom_d0069154()
		gRegion:CreateEntity(smallShatter, __wf_atom_d0069154, __wf_atom_80368bb1)
		v3:SetMaterialParam(v2, 1)
	end
end

function FxMonitor(instance)
	Sleep(0)
	local creator = instance:GetCreator()

	while not __wf_atom_7e8ad928(creator) do
		if creator:IsA(__wf_atom_4ebf67cb) and not __wf_atom_7e8ad928(creator:__wf_atom_f51f1faa()) then
			instance:Destroy()
		end

		Sleep(0)
	end

	instance:Destroy()
end

local function fn2(object) -- 2 equivalent calls inferred from this helper
	local __wf_atom_0aa77159 = object:__wf_atom_0aa77159()
	return object:__wf_atom_ee03557f().y - __wf_atom_0aa77159.y
end

local function fn3(object, p, total) -- 1 equivalent call inferred from this helper
	object:SetMaterialParam(p, total)
end

function Dissolve(object)
	Sleep(2)
	local total = 0
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(__wf_atom_9578cbaa)

		for i = 1, #__wf_atom_f582136d do
			__wf_atom_f582136d[i]:Destroy()
		end

		local v3 = fn2(__wf_atom_3d96ddcd) -- inferred equivalent call
		fn(__wf_atom_3d96ddcd, v, v3)
		local __wf_atom_a2a18137 = __wf_atom_3d96ddcd:__wf_atom_a2a18137()
		local v4 = __wf_atom_a2a18137 + Vector(0, v3, 0)
		local v5 = Symbol("FxMonitor")
		local entities = {}

		for i = 1, #effectsToCreate do
			local entity = gRegion:CreateEntity(effectsToCreate[i], v4, __wf_atom_80368bb1, __wf_atom_3d96ddcd)

			if __wf_atom_7e8ad928(entity) then
				continue
			end

			entity:__wf_atom_8a035cd5(v5, false)
			table.insert(entities, entity)
		end

		local entity = gRegion:CreateEntity(effectDeco, __wf_atom_a2a18137 + Vector(0, 0, 0.5), Rotation(0, 90, 0))

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_8a035cd5(v5, false)
			table.insert(entities, entity)
		end

		local v6, v7, v8

		if __wf_atom_3d96ddcd:IsA(__wf_atom_4ebf67cb) then
			__wf_atom_3d96ddcd:__wf_atom_7470861b():__wf_atom_f756036f(false)
			v6 = __wf_atom_3d96ddcd:__wf_atom_c6f1f83d()
			v7 = __wf_atom_3d96ddcd:__wf_atom_a96eb2aa()
			v8 = true
		else
			v7 = false
			v8 = false
			v6 = 0
		end

		while total < 1 and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
			fn3(__wf_atom_3d96ddcd, v2, total) -- inferred equivalent call
			VectorAdd(v4, __wf_atom_a2a18137, Vector(0, v3 * (1 - total) - 0.3, 0))

			for _, v9 in ipairs(entities) do
				if not __wf_atom_7e8ad928(v9) then
					v9:SetPosition(v4)
				end
			end

			if v8 and __wf_atom_3d96ddcd:__wf_atom_c6f1f83d() < v6 then
				if total > 0.6 then
					gRegion:CreateEntity(
						smallShatter,
						__wf_atom_a2a18137 + Vector(0, 0.5 * v3 * (1 - total) - 0.3, 0),
						__wf_atom_80368bb1
					)
				else
					gRegion:CreateEntity(
						largeShatter,
						__wf_atom_a2a18137 + Vector(0, 0.5 * v3 * (1 - total), 0),
						__wf_atom_80368bb1
					)
				end

				if not v7 then
					__wf_atom_3d96ddcd:Destroy()
				end
			end

			Sleep(0)
			total += __wf_atom_084b3e93() * 0.25
		end

		for _, _ in ipairs(entities) do

		end

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			if v7 then
				__wf_atom_3d96ddcd:SetVisibility(false, true)
			else
				__wf_atom_3d96ddcd:Destroy()
			end
		end
	end
end

function DissolveStone(object)
	Sleep(sleepTime)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	local total = 0

	while __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		Sleep(0)
		__wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(__wf_atom_9578cbaa)

		for i = 1, #__wf_atom_f582136d do
			__wf_atom_f582136d[i]:Destroy()
		end

		local v3 = fn2(__wf_atom_3d96ddcd) -- inferred equivalent call
		local __wf_atom_a2a18137 = __wf_atom_3d96ddcd:__wf_atom_a2a18137()
		local v4, v5, v6

		if __wf_atom_3d96ddcd:IsA(__wf_atom_4ebf67cb) then
			__wf_atom_3d96ddcd:__wf_atom_7470861b():__wf_atom_f756036f(false)
			v4 = __wf_atom_3d96ddcd:__wf_atom_c6f1f83d()
			v5 = __wf_atom_3d96ddcd:__wf_atom_a96eb2aa()
			v6 = true
		else
			v5 = false
			v6 = false
			v4 = 0
		end

		while total < 1 and not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
			__wf_atom_3d96ddcd:__wf_atom_a763aa1a(total)

			if v6 and __wf_atom_3d96ddcd:__wf_atom_c6f1f83d() < v4 then
				if total > 0.6 then
					gRegion:CreateEntity(
						smallShatter,
						__wf_atom_a2a18137 + Vector(0, 0.5 * v3 * (1 - total) - 0.3, 0),
						__wf_atom_80368bb1
					)
				else
					gRegion:CreateEntity(
						largeShatter,
						__wf_atom_a2a18137 + Vector(0, 0.5 * v3 * (1 - total), 0),
						__wf_atom_80368bb1
					)
				end

				if not v5 then
					__wf_atom_3d96ddcd:Destroy()
				end
			end

			Sleep(0)
			total += __wf_atom_084b3e93() * dissolveSpeed
		end

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			if v5 then
				__wf_atom_3d96ddcd:SetVisibility(false, true)
			else
				__wf_atom_3d96ddcd:Destroy()
			end
		end
	end
end

function LeadUpFrozenCheck(instance)
	local __wf_atom_f7e7be53 = instance:__wf_atom_f7e7be53()

	if not __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		local __wf_atom_3de89c8e = __wf_atom_f7e7be53:__wf_atom_3de89c8e(0)

		if __wf_atom_7e8ad928(__wf_atom_3de89c8e) then
			return
		end

		if __wf_atom_3de89c8e:IsA(frozenMaterial) then
			instance:Destroy()
		end
	end
end

function SmallShatterFade(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		return
	end

	__wf_atom_f7e7be53:SetMaterialParam(v, 1)
	local total = 0

	while total < 1 do
		__wf_atom_f7e7be53:SetMaterialParam(v2, total)
		total += __wf_atom_084b3e93() * 3
		Sleep(0)
	end
end

function SmallStoneShatterFade(object)
	local __wf_atom_f7e7be53 = object:__wf_atom_f7e7be53()

	if __wf_atom_7e8ad928(__wf_atom_f7e7be53) then
		return
	end

	local total = 0

	while total < 1 do
		__wf_atom_f7e7be53:__wf_atom_a763aa1a(total)
		total += __wf_atom_084b3e93() * 3
		Sleep(0)
	end
end