local v = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/Attachements/MockeriesHuskDeco")
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Libs.Query")
local positions = {}

function Evaluate(_, _)
	return 1
end

function Activate(object, _)
	if not CalculatePoints(object) then
		return false
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
	local v2 = 1

	while v2 < #positions do
		local v3

		if v2 + 1 < #positions then
			v3 = __wf_atom_fa8d0177(positions[v2], positions[v2 + 1])
		else
			v3 = Rotation(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
		end

		__wf_atom_30e3d82b:__wf_atom_b783ff91(positions[v2], v3.heading)
		local v4 = 10

		while
			not __wf_atom_7e8ad928(object)
			and object:__wf_atom_c215662d(positions[v2]) > math.sqrt(stopRange)
			and v4 > 0
			and not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
			and __wf_atom_30e3d82b:__wf_atom_6132e1f6()
		do
			v4 -= __wf_atom_084b3e93()
			Sleep(0.1)
		end

		v2 += 1
		Sleep(waitTime:__wf_atom_ff1686f2())
	end
end

function CalculatePoints(object)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local __wf_atom_7d789620 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	local __wf_atom_6f4c1c1b = object:__wf_atom_6f4c1c1b()
	local __wf_atom_6f4c1c1bs = {}

	if __wf_atom_7e8ad928(__wf_atom_6f4c1c1b) then
		__wf_atom_6f4c1c1bs = gRegion:__wf_atom_439c0d29(
			Symbol("MockeriesHusk"),
			object:GetPosition(),
			0,
			huskSearchRange
		)
		module.ShuffleTable(__wf_atom_6f4c1c1bs)
	else
		table.insert(__wf_atom_6f4c1c1bs, __wf_atom_6f4c1c1b)
	end

	if #__wf_atom_6f4c1c1bs == 0 then
		return false
	end

	local v2 = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }

	for _, v3 in pairs(__wf_atom_6f4c1c1bs) do
		if __wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(object) then
			continue
		end

		local position = v3:GetPosition()
		local __wf_atom_28ce676a = __wf_atom_7d789620:__wf_atom_28ce676a()
		__wf_atom_28ce676a:__wf_atom_267bfc41(position, Range(2, 7.5), 2)
		__wf_atom_28ce676a:__wf_atom_4a7833f4()
		__wf_atom_28ce676a:__wf_atom_06c7577b()
		__wf_atom_28ce676a:__wf_atom_0f52bdf4(object:GetPosition(), Range(2, 15), -1, 1, 1, 0, false)
		__wf_atom_28ce676a:__wf_atom_bacad54b()
		__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("PatrolSpirit"), Color("0x00FFFF"))
		local positions2 = module2.GetPositions(5, __wf_atom_28ce676a)

		for _, position2 in pairs(positions2) do
			if __wf_atom_7e8ad928(position2) or __wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(object) then
				continue
			end

			if debugDraw then
				gRegion:__wf_atom_5b35a0c8(position2, Color(255, 255, 255), object:GetName(), 1, 60)
				gRegion:__wf_atom_8d991675(position2, 0.25, Color(0, 200, 0), 60)
			end

			local __wf_atom_fbb89790 = gRegion:__wf_atom_fbb89790(
				position2 + Vector(0, 0.5, 0),
				position2,
				0.5,
				{ object },
				v2,
				nil,
				Vector()
			)
			local __wf_atom_e6b7a771 = gRegion:__wf_atom_2202ffb6():__wf_atom_e6b7a771(
				v3:GetPosition(),
				position2,
				object:__wf_atom_30e3d82b()
			)

			if
				(__wf_atom_7e8ad928(__wf_atom_fbb89790) or not __wf_atom_fbb89790:IsA(v))
				and __wf_atom_e6b7a771 >= 1
				and __wf_atom_2202ffb6:__wf_atom_3c37bceb(position2, 2.5)
			then
				table.insert(positions, position2)

				if debugDraw then
					gRegion:__wf_atom_8d991675(position2 + Vector(0, 0.5, 0), 0.25, Color(0, 0, 200), 60)
				end
			elseif debugDraw then
				gRegion:__wf_atom_8d991675(position2 + Vector(0, 0.5, 0), 0.25, Color(200, 0, 0), 60)

				if not __wf_atom_7e8ad928(__wf_atom_fbb89790) and __wf_atom_fbb89790:IsA(v) then
					gRegion:__wf_atom_5b35a0c8(position2 + Vector(0, 0.5, 0), Color(255, 255, 255), "HitEntity", 1, 60)
				end

				if not (__wf_atom_e6b7a771 >= 1) then
					gRegion:__wf_atom_5b35a0c8(position2 + Vector(0, 0.5, 0), Color(255, 255, 255), "NavTrace", 1, 60)
				end

				if not __wf_atom_2202ffb6:__wf_atom_3c37bceb(position2, 2.5) then
					gRegion:__wf_atom_5b35a0c8(position2 + Vector(0, 0.5, 0), Color(255, 255, 255), "navPos", 1, 60)
				end
			end
		end
	end

	return #__wf_atom_6f4c1c1bs > 0
end

function Deactivate(object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_24ddbdc3()
	end
end