local module = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(object) -- 2 equivalent calls inferred from this helper
	local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
	__wf_atom_4e50d390.pitch = 0
	__wf_atom_4e50d390.bank = 0
	return __wf_atom_e97f3142(__wf_atom_4e50d390)
end

local function fn2(position, p, object) -- 1 equivalent call inferred from this helper
	local position2 = object:GetPosition()
	position2.y = position.y
	local v = position2 - position
	Normalize(v)
	return __wf_atom_d08b2f29(p, v) <= 50
end

function NpcEvaluateAbility(_, object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not (__wf_atom_9a1e4ed3.distanceToTarget > 6 and __wf_atom_9a1e4ed3.distanceToTarget < 16)
	then
		return 0
	end

	if __wf_atom_9a1e4ed3.avatar:__wf_atom_535d5cbb() then
		local v = fn(__wf_atom_9a1e4ed3.avatar) -- inferred equivalent call

		if not fn2(__wf_atom_9a1e4ed3.avatar:GetPosition(), v, object) then -- inferred equivalent call
			return 0
		end
	end

	local __wf_atom_be152500 = __wf_atom_d2b2176d:__wf_atom_be152500(0)

	if
		__wf_atom_7e8ad928(__wf_atom_be152500)
		or __wf_atom_d2b2176d:__wf_atom_9f71ab59()
		or __wf_atom_be152500:GetState() ~= 0
	then
		return 0
	end

	return 1
end

function StealWait(_)
	Sleep(30)

	if not __wf_atom_7e8ad928(mOwner) then
		mOwner:SetEnabled(false)
	end
end

function InitializeAbility(_, object)
	if object:__wf_atom_535d5cbb() then
		object:__wf_atom_8a035cd5(Symbol("StealWait"), false)
	end
end

function ActivateAbility(p, object)
	local activateAnim = activateAnim
	local animEvent = animEvent

	if not object:__wf_atom_535d5cbb() then
		local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_929bb30b() then
			local __wf_atom_1149884c = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3():__wf_atom_1149884c()
			__wf_atom_4e50d390 = __wf_atom_fa8d0177(object:GetPosition(), __wf_atom_1149884c)
		end

		object:__wf_atom_51075230(__wf_atom_4e50d390)
		object:__wf_atom_84d66e8e(__wf_atom_4e50d390)

		if not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) then
			object:__wf_atom_30e3d82b():__wf_atom_b414eabf()
		end

		activateAnim = activateAnimNpc
		animEvent = animEventNpc
	end

	if not module.PlayAnimAndSuspendUntilEvent(p, activateAnim, animEvent, false, 2, 1, false) then
		return
	end

	local v = fn(object) -- inferred equivalent call
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v2 = __wf_atom_a2a18137 + v * 20
	local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(pathEffect, __wf_atom_a2a18137, Rotation(0, -90, 0))
	local __wf_atom_7ccf4243_2 = mOwner:__wf_atom_7ccf4243(spikeSound, __wf_atom_a2a18137, __wf_atom_80368bb1)
	local v3 = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
	local damageData = Engine.DamageData()
	damageData.baseAmount = 100
	damageData:__wf_atom_7498285f(4, 1)
	damageData:__wf_atom_d6f4d914(4, true)
	damageData:__wf_atom_6b472125(object)
	damageData:__wf_atom_34a8a27a(p)
	local v4 = Distance(__wf_atom_a2a18137, v2)
	local v5 = __wf_atom_a2a18137
	local total = 0
	local v6 = {}

	while total <= 1 do
		local v7 = __wf_atom_f55d6358(__wf_atom_a2a18137, v2, total)

		while Distance(v5, v7) >= 4 do
			v5 += v * 4
			local v8 = Vector(v7.x, v7.y + 2, v7.z)
			local v9 = Vector(v7.x, v7.y - 8, v7.z)
			local v10 = Vector()

			if not gRegion:__wf_atom_c20d246a(v8, v9, v3, nil, v10) then
				v10 = v7
			end

			local v11 = __wf_atom_fa8d0177(__wf_atom_a2a18137, v2) + Rotation(
				__wf_atom_5784a397(-10, 10),
				0,
				__wf_atom_5784a397(-10, 10)
			)
			local entity = gRegion:CreateEntity(decos[math.random(1, #decos)], v10, v11, object)

			if not __wf_atom_7e8ad928(entity) then
				entity:__wf_atom_921c1a5f(decoAnims[math.random(1, #decoAnims)], false, false)
				entity:SetMeshScale(0.8 + math.random() * 0.3)
			end

			if gRegion:IsMaster() then
				local all = gRegion:FindAll(__wf_atom_7e6ed5fa, v10, 0, 2)

				for _, v12 in ipairs(all) do
					local __wf_atom_18aa6e58 = v12:__wf_atom_18aa6e58()

					if v12:__wf_atom_129d1aba(object) or v6[__wf_atom_18aa6e58] then
						continue
					end

					v6[__wf_atom_18aa6e58] = true
					v12:__wf_atom_649bf33e(damageData)
				end
			end

			if not __wf_atom_7e8ad928(__wf_atom_7ccf4243_2) then
				__wf_atom_7ccf4243_2:SetPosition(v10)
			end

			if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
				__wf_atom_7ccf4243:SetPosition(v10)
			end
		end

		Sleep(0)
		total += __wf_atom_084b3e93() * (20 / v4)
	end
end