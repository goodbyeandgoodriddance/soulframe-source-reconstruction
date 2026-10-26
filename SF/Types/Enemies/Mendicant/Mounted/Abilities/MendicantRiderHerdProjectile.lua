local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}
local v2 = Vector(0, 1, 0)

function HandleProjectileMovement(object)
	object:__wf_atom_53bcb18b(__wf_atom_28d5d4aa)
	Sleep(0)
	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()
	local taggedChild = module.FindTaggedChild(object:__wf_atom_be0bea4a(), Symbol("HerdDeco"))

	if __wf_atom_7e8ad928(taggedChild) then
		return
	end

	taggedChild:__wf_atom_de14bbe2()
	Sleep(0)
	taggedChild:SetVisibility(true, true)
	local v3 = triggeredAnim:__wf_atom_091354f5(Symbol("MoveStart")) * triggeredAnim:__wf_atom_8bb4ded3()
	Sleep(v3)
	local v4 = Vector(0, 1, 0)
	local v5 = Vector(0, -10, 0)
	object:__wf_atom_53bcb18b(object:__wf_atom_a06d543c() * object:__wf_atom_510474d7())
	local __wf_atom_dcc5c1a1 = object:__wf_atom_dcc5c1a1()
	__wf_atom_dcc5c1a1.y = 0
	Normalize(__wf_atom_dcc5c1a1)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local droppedProjectileRate2 = droppedProjectileRate
	local v6 = false

	while not (__wf_atom_7e8ad928(object) or object:__wf_atom_503c55a5()) do
		droppedProjectileRate2 += __wf_atom_084b3e93()

		if droppedProjectileRate < droppedProjectileRate2 then
			droppedProjectileRate2 = 0
			local position = object:GetPosition()
			local v7 = __wf_atom_d919c2d7(object:__wf_atom_dc309f8a(), Rotation(180, 0, 0))
			local entity = gRegion:CreateEntity(droppedProjectile, position, v7, __wf_atom_9f2332e5, __wf_atom_9f2332e5)

			if not __wf_atom_7e8ad928(entity) then
				entity:__wf_atom_8fcdea81(object:__wf_atom_7be51ede())
				entity:__wf_atom_c6dbdab6(__wf_atom_9f2332e5)
				entity:__wf_atom_53bcb18b(entity:__wf_atom_a06d543c() * entity:__wf_atom_510474d7())
			end
		end

		local __wf_atom_a2a18137_2 = object:__wf_atom_a2a18137()

		if not v6 then
			local __wf_atom_dcc5c1a1_2 = object:__wf_atom_dcc5c1a1()
			local v7 = Length(__wf_atom_dcc5c1a1_2)

			if v7 == 0 then
				v7 = object:__wf_atom_510474d7()
			end

			local v8 = __wf_atom_a2a18137_2 + __wf_atom_dcc5c1a1 * v7 * __wf_atom_084b3e93() * 2
			local v9 = Vector()
			local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v8 + v4, v8 + v5, v, nil, v9)

			if
				__wf_atom_c20d246a
				and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
			then
				local v10 = v9 + v2 - object:__wf_atom_a2a18137()
				Normalize(v10)
				object:__wf_atom_53bcb18b(v10 * v7)
			else
				__wf_atom_dcc5c1a1_2.y = 0
				Normalize(__wf_atom_dcc5c1a1_2)
				object:__wf_atom_53bcb18b(__wf_atom_dcc5c1a1_2 * v7)
			end
		end

		if v6 then
			if __wf_atom_a2a18137_2 - __wf_atom_a2a18137 ~= __wf_atom_28d5d4aa then
				local v7 = Vector()
				local v8 = __wf_atom_9341614d(Vector(0, 0.5, 0), object:__wf_atom_2f2bada0())
				local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(
					__wf_atom_a2a18137 + v8,
					__wf_atom_a2a18137_2 + v8,
					v,
					nil,
					v7
				)

				if __wf_atom_c20d246a and not __wf_atom_c20d246a:HasTag(Symbol("TreeDeco")) then
					if __wf_atom_c20d246a:__wf_atom_83a62c41() == __wf_atom_c20d246a then
						break
					end

					print(__wf_atom_c20d246a:__wf_atom_83a62c41())
					break
				end
			end

			__wf_atom_a2a18137 = object:__wf_atom_a2a18137()
		end

		Sleep(0)
		v6 = not v6
	end
end