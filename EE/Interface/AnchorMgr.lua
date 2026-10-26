module(..., package.seeall)
ANCHOR_V_TOP = 1
ANCHOR_V_CENTRE = 2
ANCHOR_V_BOTTOM = 3
ANCHOR_H_CENTRE = 4
ANCHOR_H_RIGHT = 5
ANCHOR_H_LEFT = 6

function Create(movie, p)
	local v = {
		ANCHOR_V_TOP = ANCHOR_V_TOP,
		ANCHOR_V_CENTRE = ANCHOR_V_CENTRE,
		ANCHOR_V_CENTER = -ANCHOR_V_CENTRE,
		ANCHOR_V_BOTTOM = ANCHOR_V_BOTTOM,
		ANCHOR_H_CENTRE = ANCHOR_H_CENTRE,
		ANCHOR_H_CENTER = -ANCHOR_H_CENTRE,
		ANCHOR_H_RIGHT = ANCHOR_H_RIGHT,
		ANCHOR_H_LEFT = ANCHOR_H_LEFT,
		viewportW = 0,
		viewportH = 0,
		stageWidth = movie:__wf_atom_97cd8326(),
		stageHeight = movie:__wf_atom_54eeda24(),
		list = {},
		movie = movie,
		HorizontalPadding = 0,
		VerticalPadding = 0
	}
	local module = require("EE.Interface.Utilities")

	if movie:__wf_atom_3dc387fe() == 0 and not (movie:__wf_atom_c6b73328() or p) then
		function v.Register(_, _, _, _) end

		function v.Unregister(_, _) end

		function v.Update(_, _, _) end
	else
		function v.Register(data, object, clip, p2)
			local v2 = {
				clip = clip,
				originalX = object:__wf_atom_5e6e15c8(clip, 0),
				originalY = object:__wf_atom_5e6e15c8(clip, 1),
				alignVertical = nil,
				alignHorizontal = nil,
				movie = object
			}

			if p2 ~= nil then
				for i = 1, #p2 do
					local v3 = p2[i]
					assert(v3)
					v2.IgnoreHudMargins = false

					if v3 < 0 then
						print("AnchorMgr uses CENTRE, not CENTER")
						v3 = -v3
						p2[i] = v3
					end

					if v3 == data.ANCHOR_V_TOP or v3 == data.ANCHOR_V_CENTRE or v3 == data.ANCHOR_V_BOTTOM then
						v2.alignVertical = v3
					elseif v3 == data.ANCHOR_H_LEFT or v3 == data.ANCHOR_H_RIGHT or v3 == data.ANCHOR_H_CENTRE then
						v2.alignHorizontal = v3
					elseif string.find(tostring(v3), "function") ~= nil then
						v2.callback = v3
					end

					if p2.IgnoreHudMargins ~= nil then
						v2.IgnoreHudMargins = p2.IgnoreHudMargins
					end
				end
			end

			data.list[#data.list + 1] = v2
		end

		function v.Unregister(p2, p3, p4)
			for i = 1, #p2.list do
				if not (p2.list[i].movie == p3 and p2.list[i].clip == p4) then
					continue
				end

				table.remove(p2.list, i)
				break
			end
		end

		function v.Update(data, p2, p3, p4, p5)
			if __wf_atom_7e8ad928(data.movie) then
				return
			end

			local v2 = p5 or { 0, 0 }
			local v3 = data.stageWidth * data.movie:__wf_atom_68d996b1()
			local v4 = data.stageHeight * data.movie:__wf_atom_68d996b1()
			local viewportW = tonumber(p2)
			local viewportH = tonumber(p3)

			if data.movie:__wf_atom_3dc387fe() == 0 then
				viewportH = v4
				viewportW = v3
			end

			v.viewportW = viewportW
			v.viewportH = viewportH
			local v5, v6

			if (data.movie:__wf_atom_c6b73328() or p4) and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
				local settings = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings()
				local v7 = data.movie:__wf_atom_5e6e15c8("_root", 5) / 100
				local v8 = data.movie:__wf_atom_5e6e15c8("_root", 6) / 100
				v5 = math.floor(viewportW * settings:__wf_atom_2968f251() / v7)
				v6 = math.floor(viewportH * settings:__wf_atom_147dcfd3() / v8)
				v.HorizontalPadding = v5 + v2[1]
				v.VerticalPadding = v6 + v2[2]
			else
				v5 = 0
				v6 = 0
			end

			local v7 = viewportW < v3
			local v8 = viewportH < v4
			local v9 = v7 or v8

			if data.movie:__wf_atom_3dc387fe() == 2 then
				viewportW, viewportH = data.movie:__wf_atom_6efc7cd1(viewportW, viewportH)
			else
				if v7 or v9 then
					viewportW = v3
				end

				if v8 or v9 or data.movie:__wf_atom_3dc387fe() == 2 then
					viewportH = v4
				end
			end

			local __wf_atom_c1b77578 = data.movie:__wf_atom_c1b77578()

			for i = 1, #data.list do
				local v10 = data.list[i]
				local horizontalPadding = data.HorizontalPadding
				local verticalPadding = data.VerticalPadding

				if v10.IgnoreHudMargins then
					horizontalPadding -= v5
					verticalPadding -= v6
				end

				if not __wf_atom_7e8ad928(v10.movie) then
					local originalX = v10.originalX

					if v10.alignHorizontal ~= nil then
						local v11 = (viewportW - v3) * (1 / data.movie:__wf_atom_68d996b1())

						if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 6 then
							if v10.alignHorizontal == data.ANCHOR_H_RIGHT then
								originalX = originalX + v11 - horizontalPadding
							elseif v10.alignHorizontal == data.ANCHOR_H_LEFT then
								originalX += horizontalPadding
							elseif v10.alignHorizontal == data.ANCHOR_H_CENTRE then
								originalX += v11 / 2
							end
						elseif __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 7 then
							if v10.alignHorizontal == data.ANCHOR_H_RIGHT then
								originalX = originalX + v11 / 2 - horizontalPadding
							elseif v10.alignHorizontal == data.ANCHOR_H_LEFT then
								originalX = originalX - v11 / 2 + horizontalPadding
							else
								local _ = v10.alignHorizontal == data.ANCHOR_H_CENTRE
							end
						elseif __wf_atom_c1b77578 == 2 or __wf_atom_c1b77578 == 5 or __wf_atom_c1b77578 == 8 then
							if v10.alignHorizontal == data.ANCHOR_H_RIGHT then
								originalX -= horizontalPadding
							elseif v10.alignHorizontal == data.ANCHOR_H_LEFT then
								originalX = originalX - v11 + horizontalPadding
							elseif v10.alignHorizontal == data.ANCHOR_H_CENTRE then
								originalX -= v11 / 2
							end
						end
					end

					v10.NewX = module.Round(originalX)
					v10.movie:__wf_atom_e57658c2(v10.clip, 0, v10.NewX)
					local originalY = v10.originalY

					if v10.alignVertical ~= nil then
						local v11 = (viewportH - v4) * (1 / data.movie:__wf_atom_68d996b1())

						if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 2 then
							if v10.alignVertical == data.ANCHOR_V_TOP then
								originalY += verticalPadding
							elseif v10.alignVertical == data.ANCHOR_V_BOTTOM then
								originalY = originalY + v11 - verticalPadding
							elseif v10.alignVertical == data.ANCHOR_V_CENTRE then
								originalY += v11 / 2
							end
						elseif __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 5 then
							if v10.alignVertical == data.ANCHOR_V_TOP then
								originalY = originalY - v11 / 2 + verticalPadding
							elseif v10.alignVertical == data.ANCHOR_V_BOTTOM then
								originalY = originalY + v11 / 2 - verticalPadding
							else
								local _ = v10.alignVertical == data.ANCHOR_V_CENTRE
							end
						elseif __wf_atom_c1b77578 == 6 or __wf_atom_c1b77578 == 7 or __wf_atom_c1b77578 == 8 then
							if v10.alignVertical == data.ANCHOR_V_TOP then
								originalY = originalY - v11 + verticalPadding
							elseif v10.alignVertical == data.ANCHOR_V_BOTTOM then
								originalY -= verticalPadding
							elseif v10.alignVertical == data.ANCHOR_V_CENTRE then
								originalY -= v11 / 2
							end
						end
					end

					v10.NewY = module.Round(originalY)
					v10.movie:__wf_atom_e57658c2(v10.clip, 1, v10.NewY)
				end

				if v10.callback ~= nil then
					v10.callback()
				end
			end
		end

		function v.GetCoords(p2, p3)
			for i = 1, #p2.list do
				if p2.list[i].clip == p3 then
					return { x = p2.list[i].NewX, y = p2.list[i].NewY }
				end
			end
		end

		function v.GetOriginalCoords(p2, p3)
			for i = 1, #p2.list do
				if p2.list[i].clip == p3 then
					return { x = p2.list[i].originalX, y = p2.list[i].originalY }
				end
			end
		end

		function v.ChangeOriginalCoords(p2, p3, originalX, originalY)
			for i = 1, #p2.list do
				local v2 = p2.list[i]

				if v2.clip ~= p3 then
					continue
				end

				if originalX ~= nil then
					v2.originalX = originalX
				end

				if originalY ~= nil then
					v2.originalY = originalY
				end
			end
		end

		function v.ChangeAnchorPoints(p2, p3, alignVertical, alignHorizontal)
			for i = 1, #p2.list do
				local v2 = p2.list[i]

				if v2.clip ~= p3 then
					continue
				end

				if alignVertical ~= nil then
					v2.alignVertical = alignVertical
				end

				if alignHorizontal ~= nil then
					v2.alignHorizontal = alignHorizontal
				end
			end
		end

		if Engine.__wf_atom_b6edc589() then
			function v.ConvertViewportCoordsToOriginalCoords(data, p2, p3, p4, p5, p6)
				if __wf_atom_7e8ad928(data.movie) then
					return
				end

				local v2 = data.stageWidth * data.movie:__wf_atom_68d996b1()
				local v3 = data.stageHeight * data.movie:__wf_atom_68d996b1()
				local v4 = p5 < v2
				local v5 = p6 < v3
				local v6 = v4 or v5
				local viewportW = data.viewportW
				local viewportH = data.viewportH

				if data.movie:__wf_atom_3dc387fe() == 2 then
					viewportW, viewportH = data.movie:__wf_atom_6efc7cd1(viewportW, viewportH)
				else
					if v4 or v6 then
						viewportW = v2
					end

					if v5 or v6 or data.movie:__wf_atom_3dc387fe() == 2 then
						viewportH = v3
					end
				end

				local __wf_atom_c1b77578 = data.movie:__wf_atom_c1b77578()

				for i = 1, #data.list do
					local v7 = data.list[i]

					if v7.clip ~= p2 then
						continue
					end

					if __wf_atom_7e8ad928(v7.movie) then
						break
					end

					if v7.alignHorizontal ~= nil then
						local v8 = (viewportW - v2) * (1 / data.movie:__wf_atom_68d996b1())

						if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 6 then
							if v7.alignHorizontal == data.ANCHOR_H_RIGHT then
								p3 -= v8 - data.HorizontalPadding
							elseif v7.alignHorizontal == data.ANCHOR_H_LEFT then
								p3 -= data.HorizontalPadding
							elseif v7.alignHorizontal == data.ANCHOR_H_CENTRE then
								p3 -= v8 / 2
							end
						elseif __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 7 then
							if v7.alignHorizontal == data.ANCHOR_H_RIGHT then
								p3 = p3 - v8 / 2 - data.HorizontalPadding
							elseif v7.alignHorizontal == data.ANCHOR_H_LEFT then
								p3 -= -(v8 / 2) + data.HorizontalPadding
							else
								local _ = v7.alignHorizontal == data.ANCHOR_H_CENTRE
							end
						elseif __wf_atom_c1b77578 == 2 or __wf_atom_c1b77578 == 5 or __wf_atom_c1b77578 == 8 then
							if v7.alignHorizontal == data.ANCHOR_H_RIGHT then
								p3 -= -data.HorizontalPadding
							elseif v7.alignHorizontal == data.ANCHOR_H_LEFT then
								p3 -= -v8 + data.HorizontalPadding
							elseif v7.alignHorizontal == data.ANCHOR_H_CENTRE then
								p3 -= -(v8 / 2)
							end
						end
					end

					v7.originalX = module.Round(p3)

					if v7.alignVertical ~= nil then
						local v8 = (viewportH - v3) * (1 / data.movie:__wf_atom_68d996b1())

						if __wf_atom_c1b77578 == 0 or __wf_atom_c1b77578 == 1 or __wf_atom_c1b77578 == 2 then
							if v7.alignVertical == data.ANCHOR_V_TOP then
								p4 -= data.VerticalPadding
							elseif v7.alignVertical == data.ANCHOR_V_BOTTOM then
								p4 -= v8 - data.VerticalPadding
							elseif v7.alignVertical == data.ANCHOR_V_CENTRE then
								p4 -= v8 / 2
							end
						elseif __wf_atom_c1b77578 == 3 or __wf_atom_c1b77578 == 4 or __wf_atom_c1b77578 == 5 then
							if v7.alignVertical == data.ANCHOR_V_TOP then
								p4 -= -(v8 / 2) + data.VerticalPadding
							elseif v7.alignVertical == data.ANCHOR_V_BOTTOM then
								p4 -= v8 / 2 - data.VerticalPadding
							else
								local _ = v7.alignVertical == data.ANCHOR_V_CENTRE
							end
						elseif __wf_atom_c1b77578 == 6 or __wf_atom_c1b77578 == 7 or __wf_atom_c1b77578 == 8 then
							if v7.alignVertical == data.ANCHOR_V_TOP then
								p4 -= -v8 + data.VerticalPadding
							elseif v7.alignVertical == data.ANCHOR_V_BOTTOM then
								p4 -= -data.VerticalPadding
							elseif v7.alignVertical == data.ANCHOR_V_CENTRE then
								p4 -= -(v8 / 2)
							end
						end
					end

					v7.originalY = module.Round(p4)
					break
				end
			end
		end
	end

	return v
end