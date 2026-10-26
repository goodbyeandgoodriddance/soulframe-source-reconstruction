local module = require("EE.Interface.Utilities")

local function fn(_, p, _) -- 5 equivalent calls inferred from this helper
	return 5.2 + p * 0.8
end

function GetDescriptionInfo(p, _)
	local v = {
		DAMAGE = module.FormatNumber(fn(nil, p), 1), -- inferred equivalent call
		RANGE = module.FormatNumber(fn(nil, p), 1) -- inferred equivalent call
	}
	return cjson.encode(v)
end

function NpcEvaluateAbility(_, object, p, _)
	local v = fn(nil, p) -- inferred equivalent call
	local v2 = { __wf_atom_4ebf67cb }
	local __wf_atom_f0db2b89 = object:__wf_atom_30e3d82b():__wf_atom_f0db2b89(v, v2)
	local __wf_atom_d8853f2a = object:__wf_atom_30e3d82b():__wf_atom_d8853f2a()
	local v3 = false

	for i = 1, #__wf_atom_d8853f2a do
		if
			not __wf_atom_d8853f2a[i]:__wf_atom_a3309443()
			or __wf_atom_7e8ad928(__wf_atom_d8853f2a[i].avatar:__wf_atom_30e3d82b())
		then
			continue
		end

		if not __wf_atom_d8853f2a[i].avatar:__wf_atom_30e3d82b():__wf_atom_351e924e() then
			continue
		end

		v3 = true
		break
	end

	if not v3 then
		return 0
	end

	if __wf_atom_f0db2b89 >= 2 then
		return 1
	end

	return 0
end

function ActivateAbility(object, object2, _, _)
	local __wf_atom_2a745663 = object2:__wf_atom_d2b2176d():__wf_atom_2a745663(
		1,
		31,
		object:__wf_atom_1bb5b1ff(),
		object
	)
	object2:__wf_atom_8914dfde("Attack", object2:__wf_atom_9b5dcd3b(castAnim, false, 2, 1, true, __wf_atom_2a745663))
	object2:Attach(stunExplosionFX, EMPTY_SYMBOL)

	if gRegion:IsMaster() then
		Sleep(0.2)
	end
end

function DeactivateAbility(p, object, _, p2, _)
	local v = fn(nil, p2) -- inferred equivalent call
	local v2 = fn(nil, p2) -- inferred equivalent call
	local v3 = nil
	local __wf_atom_dbb22a12 = object:__wf_atom_dbb22a12()

	if not __wf_atom_7e8ad928(__wf_atom_dbb22a12) and __wf_atom_dbb22a12:__wf_atom_129d1aba(object) then
		v3 = __wf_atom_dbb22a12
	end

	if gRegion:IsMaster() then
		gRegion:__wf_atom_f6ec80de(object, object:__wf_atom_a2a18137(), v, v2, 600, 10, v3, p, 20, true, true, true, 0)
	end
end