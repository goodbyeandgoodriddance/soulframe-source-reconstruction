module(..., package.seeall)
local module = require("SF.Scripts.Libs.QuestLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")

local function fn(p) -- 2 equivalent calls inferred from this helper
	local v = math.fmod(p + 180, 360)

	if v < 0 then
		v += 360
	end

	return v - 180
end

local function fn2(mCompassSpring, p)
	local v = __wf_atom_421b01aa(p, 0, 1 / 15)
	mCompassSpring.position = fn(mCompassSpring.position) -- inferred equivalent call
	mCompassSpring.targetPosition = fn(mCompassSpring.targetPosition) -- inferred equivalent call
	local v2 = mCompassSpring.position - mCompassSpring.targetPosition

	if v2 > 180 then
		mCompassSpring.position -= 360
		v2 = mCompassSpring.position - mCompassSpring.targetPosition
	end

	if v2 < -180 then
		mCompassSpring.position += 360
		v2 = mCompassSpring.position - mCompassSpring.targetPosition
	end

	local v3 = v2 * mCompassSpring.stiffness * v
	mCompassSpring.velocity -= v3
	mCompassSpring.position += mCompassSpring.velocity * v
	mCompassSpring.velocity *= math.max(0, 1 - mCompassSpring.dampening * v)
end

local function fn3(p) -- 1 equivalent call inferred from this helper
	local v = p % 360

	if v > 180 then
		v -= 360
	elseif v < -180 then
		v += 360
	end

	return v / 360 * 640
end

local function fn4(data, p, p2) -- 1 equivalent call inferred from this helper
	local v = false
	local v2 = false

	if p > 6 then
		v = true
	elseif p < -6 then
		v2 = true
	end

	data.mMovie:__wf_atom_7f57ab2f(data.baseClip, p2 .. ".Up", 13, v)
	data.mMovie:__wf_atom_7f57ab2f(data.baseClip, p2 .. ".Down", 13, v2)
end

local function fn5(data, p, p2, p3, p4, p5, p6, p7, p8, p9, value, p10, value2)
	local v = value or 0
	local v2 = p10 or false
	local v3 = value2 or 0.35

	if p5 <= 0 then
		if not data.mCompassClipAlphas[p2] or data.mCompassClipAlphas[p2] ~= 0 then
			data.mCompassClipAlphas[p2] = p5
			__wf_atom_ec43d06e(
				data.mMovie,
				data.baseClip .. "." .. p2,
				8,
				{ 12, 5, 6 },
				{ 0, 25 * p6, 25 * p6 },
				0.3334,
				0
			)
		end
	else
		if data.mMovie:__wf_atom_1b848254(data.baseClip .. "." .. p2) then
			data.mMovie:__wf_atom_290807ee(data.baseClip .. "." .. p2)
		end

		local v4 = fn3(p3) -- inferred equivalent call

		if p9 then
			v4 = __wf_atom_421b01aa(v4, -170, 170)
		end

		data.mMovie:__wf_atom_4c1c1986(data.baseClip, p2, 0, v4)
		local v5 = 1 - math.abs((__wf_atom_421b01aa(v4, -200, 200))) / 200
		local v6, v7

		if p9 then
			local v8 = math.max(math.pow(v5, 1.5), v3)
			v6 = p5 * v8
			v7 = __wf_atom_104bfe98(0.7 * p6, p6, v8)
		else
			local v8 = math.pow(v5, 0.5)
			v6 = p5 * v8
			v7 = __wf_atom_104bfe98(0.5 * p6, p6, v8)
		end

		if not data.mCompassClipAlphas[p2] then
			data.mCompassClipAlphas[p2] = 0
		end

		data.mCompassClipAlphas[p2] = math.min(1, data.mCompassClipAlphas[p2] + p * 3)
		local mCompassClipAlpha = data.mCompassClipAlphas[p2]
		local v8 = v7 * __wf_atom_104bfe98(0.25, 1, __wf_atom_24a82b69(mCompassClipAlpha))
		data.mMovie:__wf_atom_4c1c1986(data.baseClip, p2, 5, v8)
		data.mMovie:__wf_atom_4c1c1986(data.baseClip, p2, 6, v8)

		if not __wf_atom_7e8ad928(p7) then
			data.mMovie:__wf_atom_48bd5a59(data.baseClip, p2 .. ".Label", 36, Localize(p7, nil))
		end

		if not __wf_atom_7e8ad928(p8) and v2 then
			data.mMovie:__wf_atom_c90af43a(data.baseClip .. "." .. p2 .. ".Icon", p8)
		end

		local v9 = data.baseClip .. "." .. p2 .. ".StatusIcons"

		if v == 0 then
			data.mMovie:__wf_atom_2dedec1a(v9, 13, false)
		else
			data.mMovie:__wf_atom_2dedec1a(v9, 13, true)
			local v10 = 1

			while data.mMovie:__wf_atom_253d7085(v9 .. ".Icon" .. v10) do
				local v11 = v9 .. ".Icon" .. v10

				if v10 <= v then
					data.mMovie:__wf_atom_2dedec1a(v11, 13, true)
				else
					__wf_atom_86cbd68d(data.mMovie, v11 .. ".removeMovieClip")
				end

				v10 += 1

				if v10 > 1000 then
					LogBug("Compass marker stars overflow")
				end
			end

			for i = 1, v do
				if v10 - 1 < i then
					__wf_atom_86cbd68d(data.mMovie, v9 .. ".Icon1.duplicateMovieClip", "Icon" .. i, i)
				end

				if not v2 then
					continue
				end

				local v11 = v9 .. ".Icon" .. i
				data.mMovie:__wf_atom_c90af43a(v11, data.resources.questStarIcon)
				data.mMovie:__wf_atom_e57658c2(v11, 5, 100)
				data.mMovie:__wf_atom_e57658c2(v11, 6, 100)
			end

			for i = 1, v do
				local total = -100
				local v11

				if i <= v / 2 then
					v11 = i * -1
				else
					v11 = i - math.ceil(v / 2)
				end

				local v12

				if v % 2 == 1 then
					local v13

					if i == math.ceil(v / 2) then
						v13 = 0
					elseif i < v / 2 then
						v13 = v11 - 1
					else
						v13 = v11 + 1
					end

					total += math.abs(v13 * 4)
					v12 = v13 * 10
				else
					v12 = v11 * 12
				end

				local v13 = v9 .. ".Icon" .. i
				data.mMovie:__wf_atom_e57658c2(v13, 0, v12)
				data.mMovie:__wf_atom_e57658c2(v13, 1, total)
			end
		end

		local v10 = v6 * (__wf_atom_24a82b69(mCompassClipAlpha) * 100)
		data.mMovie:__wf_atom_4c1c1986(data.baseClip, p2, 12, v10)
		fn4(data, p4, p2) -- inferred equivalent call
	end
end

local function fn6(object, object2, p, p2, p3, p4)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local position = object2:GetPosition()

	for i, v in ipairs(__wf_atom_3c8e1a7a) do
		if v:IsLocal() then
			continue
		end

		local __wf_atom_ef151cfd = v:__wf_atom_ef151cfd()
		local playerAvatar = v:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			continue
		end

		local mCompassSquadMarker = object.mCompassSquadMarkers[__wf_atom_ef151cfd]

		if __wf_atom_7e8ad928(mCompassSquadMarker) then
			mCompassSquadMarker = {
				ClipName = "MarkerSquadMember" .. i,
				Id = __wf_atom_ef151cfd,
				PlayerName = v:__wf_atom_6be84646(),
				Visible = false
			}
			object.mCompassSquadMarkers[__wf_atom_ef151cfd] = mCompassSquadMarker
		end

		local position2 = playerAvatar:GetPosition()
		local visible = not (p2 or object2:__wf_atom_799d95f5() or playerAvatar:__wf_atom_799d95f5())
		local v2

		if mCompassSquadMarker.Visible == visible then
			v2 = false
		else
			mCompassSquadMarker.Visible = visible
			v2 = true

			if mCompassSquadMarker.Visible then
				if not object.mMovie:__wf_atom_253d7085(object.baseClip .. "." .. mCompassSquadMarker.ClipName) then
					__wf_atom_86cbd68d(
						object.mMovie,
						object.baseClip .. ".Marker.duplicateMovieClip",
						mCompassSquadMarker.ClipName,
						1100 + i
					)
				end
			else
				object:ShowMarker(p, mCompassSquadMarker.ClipName, 0, 0, 0, 1, nil, nil, true)
			end
		end

		if not mCompassSquadMarker.Visible then
			continue
		end

		local __wf_atom_d5fda8be = object2:__wf_atom_d5fda8be(position2)
		local v3 = __wf_atom_a6515464(position, Rotation(0, 0, 0), position2)
		local v4 = __wf_atom_104bfe98(1, 0.55, __wf_atom_421b01aa((__wf_atom_d5fda8be - 10) / 200, 0, 1))
		object:ShowMarker(
			p,
			mCompassSquadMarker.ClipName,
			v3 - p3,
			position2.y - position.y,
			2,
			p4 * v4,
			nil,
			object.resources.squadMemberCompassIcon,
			true,
			0,
			v2,
			0.5
		)
	end

	for k, mCompassSquadMarker in pairs(object.mCompassSquadMarkers) do
		local flag = true

		for _, v in ipairs(__wf_atom_3c8e1a7a) do
			if v:__wf_atom_ef151cfd() ~= mCompassSquadMarker.Id then
				continue
			end

			flag = false
			break
		end

		if not flag then
			continue
		end

		object.mCompassClipAlphas[mCompassSquadMarker.ClipName] = nil
		local clipName = mCompassSquadMarker.ClipName
		__wf_atom_ec43d06e(
			object.mMovie,
			object.baseClip .. "." .. clipName,
			8,
			{ 12, 5, 6 },
			{ 0, 25, 25 },
			0.3334,
			0,
			function()
				__wf_atom_86cbd68d(object.mMovie, object.baseClip .. "." .. clipName .. ".removeMovieClip")
			end
		)
		object.mCompassSquadMarkers[k] = nil
	end
end

local function fn7(object, object2, object3, p, p2, p3, total)
	local __wf_atom_301e8d97 = object3:__wf_atom_301e8d97()
	local v

	if not __wf_atom_7e8ad928(__wf_atom_301e8d97) then
		v = __wf_atom_301e8d97:__wf_atom_a49f5825()
	end

	local v2 = {}

	for i = 1, #v do
		if __wf_atom_7e8ad928(v[i]) or v[i]:__wf_atom_cd79d6f3() ~= object.resources.paintedMarkerType then
			continue
		end

		table.insert(v2, v[i])
	end

	local position = object2:GetPosition()

	for i = 1, #v2 do
		local v3 = v2[i]
		local v4 = "PlayerMarker" .. i

		if not object.mMovie:__wf_atom_253d7085(object.baseClip .. "." .. v4) then
			__wf_atom_86cbd68d(object.mMovie, object.baseClip .. ".Marker.duplicateMovieClip", v4, 1300 + i)
			table.insert(object.mPlayerMarkers, i, v4)
		end

		if __wf_atom_7e8ad928(v3) then
			continue
		end

		local v5 = __wf_atom_a6515464(position, Rotation(0, 0, 0), v3.pos)
		local v6, v7

		if v3:__wf_atom_cd79d6f3():__wf_atom_6a3d8b57() == object3 then
			v6 = p3 * (0.5 + total)
			v7 = 1
		else
			v6 = p3
		end

		object:ShowMarker(
			p,
			v4,
			v5 - p2,
			v3.pos.y - position.y,
			1,
			v6,
			nil,
			v3:__wf_atom_cd79d6f3():__wf_atom_4cb5b869(),
			true,
			0,
			true,
			v7
		)
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v3 = math.min(#v2, #__wf_atom_3c8e1a7a)

	for i = #object.mPlayerMarkers, 1, -1 do
		if not (v3 < i) then
			continue
		end

		__wf_atom_86cbd68d(object.mMovie, object.baseClip .. "." .. object.mPlayerMarkers[i] .. ".removeMovieClip")
		table.remove(object.mPlayerMarkers, i)
	end
end

local function fn8(object, p, object2, p2, object3, p3, p4)
	local v = false
	local v2 = false

	if __wf_atom_7e8ad928(object.mSettings) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			object.mSettings = __wf_atom_18a5d83b:Settings()
		end
	else
		local v3

		if _T.HideHud == nil then
			v3 = false
		else
			v3 = _T.HideHud > 0
		end

		if object.mSettings:__wf_atom_9e2b12c5() and not (v3 or _T.TopMenuOpen) then
			v2 = true
			v = true
		end
	end

	local flag, v3

	if module2.SparrowGuidingForPlayer(gRegion:__wf_atom_c4f78a8f()) then
		flag = true
		v = true
		v3 = true
	else
		flag = false
	end

	local v4 = 3
	local v5 = 3
	local __wf_atom_799d95f5 = object2:__wf_atom_799d95f5()
	local v6 = false
	local v7

	if __wf_atom_7e8ad928(object3) then
		v7 = false
	else
		v7 = object3:__wf_atom_a984878b()

		if v7 then
			v5 = 0.25
			v4 = 0
		end
	end

	if
		__wf_atom_799d95f5
		or _T.TopMenuOpen
		or not __wf_atom_7e8ad928(__wf_atom_8e4fda44:FindMovie(object.notificationMovie))
		or v7
	then
		v6 = true
		v = false
		v4 = 0
	end

	local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()

	if not __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) then
		__wf_atom_4e50d390 = gRegion:__wf_atom_c4f78a8f():__wf_atom_4e50d390()
	end

	object.mCompassSpring.targetPosition = __wf_atom_4e50d390.heading
	fn2(object.mCompassSpring, p)
	__wf_atom_4e50d390.heading = object.mCompassSpring.position
	object:ShowMarker(p, "Marker", 0, 0, 0, 0, 0, nil, nil, false)
	local v8 = { "TickN", "TickNE", "TickE", "TickSE", "TickS", "TickSW", "TickW", "TickNW" }
	local v9 = { "N", "NE", "E", "SE", "S", "SW", "W", "NW" }
	local v10 = __wf_atom_4e50d390.heading + 360
	local v11 = object.baseClip .. ".Sparrow"

	if not object.mMovie:__wf_atom_253d7085(v11) then
		__wf_atom_86cbd68d(object.mMovie, object.baseClip .. ".Marker.duplicateMovieClip", "Sparrow", 1200)
	end

	local total = 0.25

	if flag then
		total += math.abs((math.sin(Time() * 2 * 3.141592653589793))) * 0.35
	end

	fn7(object, object2, p2, p, v10, 40, total)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local currentSparrowDestinationId = module2.GetCurrentSparrowDestinationId()

	if
		_T.GetFlashMarker
		and not (__wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(_T.GetFlashMarker(object.resources.paintedMarkerType, p2)))
	then
		currentSparrowDestinationId = nil
	end

	if currentSparrowDestinationId ~= object.mCurrentSparrowDestinationId then
		object.mCurrentSparrowDestinationId = currentSparrowDestinationId
		v = true
	end

	local sparrowDestinationCompassInfos = module2.GetSparrowDestinationCompassInfos()
	local v12 = nil

	if not __wf_atom_7e8ad928(sparrowDestinationCompassInfos) then
		for _, sparrowDestinationCompassInfo in ipairs(sparrowDestinationCompassInfos) do
			if
				__wf_atom_7e8ad928(sparrowDestinationCompassInfo)
				or sparrowDestinationCompassInfo.mId ~= currentSparrowDestinationId
			then
				continue
			end

			v12 = sparrowDestinationCompassInfo
			break
		end
	end

	if v12 == nil and not flag then
		v3 = false
	end

	local v13 = 1
	local v14

	if not (__wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(v12:__wf_atom_e32e2012())) then
		v14 = v12:__wf_atom_e32e2012()
	end

	local flag2 = false
	local v15 = false
	local mOwnerType = nil
	local mOwnerFullName = nil
	local v16 = 5

	if not __wf_atom_7e8ad928(v12) then
		v16 = math.max(v16, v12.mRange.minValue)
	end

	local trackedJournalEntry = module.GetTrackedJournalEntry()
	local position = object2:GetPosition()
	local v17 = 3.4028234663852886e38
	local v18 = 50
	local v19 = nil
	local mEntityPosition = nil

	for _, sparrowDestinationCompassInfo in ipairs(sparrowDestinationCompassInfos) do
		if
			__wf_atom_7e8ad928(sparrowDestinationCompassInfo)
			or __wf_atom_7e8ad928(sparrowDestinationCompassInfo.mEntityType)
		then
			continue
		end

		local mId = sparrowDestinationCompassInfo.mId or tostring(v13)
		local mSparrowDestinationMarker = object.mSparrowDestinationMarkers[mId]

		if __wf_atom_7e8ad928(mSparrowDestinationMarker) then
			mSparrowDestinationMarker = {
				ClipName = "Marker" .. mId,
				Id = sparrowDestinationCompassInfo.mId,
				Visible = false
			}
			object.mSparrowDestinationMarkers[mId] = mSparrowDestinationMarker
		end

		v19 = object2:__wf_atom_d5fda8be(sparrowDestinationCompassInfo.mEntityPosition)
		local v20 = __wf_atom_7d789620:__wf_atom_3c9cb048(object2:GetPosition()) == __wf_atom_7d789620:__wf_atom_3c9cb048(sparrowDestinationCompassInfo.mOwnerPosition)
		local v21 = not v6 and v20 and v19 < sparrowDestinationCompassInfo.mRange.maxValue

		if __wf_atom_7e8ad928(v12) or sparrowDestinationCompassInfo.mId ~= v12.mId then
			if not flag2 then
				if
					__wf_atom_7e8ad928(sparrowDestinationCompassInfo.mOwnerType)
					or not sparrowDestinationCompassInfo.mOwnerType:IsA(__wf_atom_f806fd7a)
				then
					v19 = object2:__wf_atom_d5fda8be(sparrowDestinationCompassInfo.mEntityPosition)

					if v19 < v16 then
						mOwnerType = sparrowDestinationCompassInfo.mOwnerType
						mOwnerFullName = sparrowDestinationCompassInfo.mOwnerFullName
						mEntityPosition = sparrowDestinationCompassInfo.mEntityPosition
						v21 = false
						flag2 = true
					end
				elseif object2:__wf_atom_d5fda8be(sparrowDestinationCompassInfo.mOwnerPosition) < v16 then
					mOwnerType = sparrowDestinationCompassInfo.mOwnerType
					mOwnerFullName = sparrowDestinationCompassInfo.mOwnerFullName
					mEntityPosition = sparrowDestinationCompassInfo.mOwnerPosition
					v21 = false
					flag2 = true
				end
			end
		else
			v21 = false

			if not v15 then
				if __wf_atom_7e8ad928(v12.mOwnerType) or not v12.mOwnerType:IsA(__wf_atom_f806fd7a) then
					v19 = object2:__wf_atom_d5fda8be(sparrowDestinationCompassInfo.mEntityPosition)

					if v19 < v16 then
						mOwnerType = sparrowDestinationCompassInfo.mOwnerType
						mOwnerFullName = sparrowDestinationCompassInfo.mOwnerFullName
						mEntityPosition = sparrowDestinationCompassInfo.mEntityPosition
						v18 = v16
						flag2 = true
						v15 = true
					end
				elseif object2:__wf_atom_d5fda8be(sparrowDestinationCompassInfo.mOwnerPosition) < v16 then
					mOwnerType = sparrowDestinationCompassInfo.mOwnerType
					mOwnerFullName = sparrowDestinationCompassInfo.mOwnerFullName
					mEntityPosition = sparrowDestinationCompassInfo.mOwnerPosition
					v18 = v16
					flag2 = true
					v15 = true
				end
			end

			if __wf_atom_7e8ad928(v14) then
				v14 = sparrowDestinationCompassInfo:__wf_atom_e32e2012()
			end
		end

		if v21 and __wf_atom_7e8ad928(sparrowDestinationCompassInfo:__wf_atom_e32e2012()) then
			v21 = false
		end

		if
			v21
			and not (__wf_atom_7e8ad928(sparrowDestinationCompassInfo:__wf_atom_eaadc920()) or module.IsQuestTracked(sparrowDestinationCompassInfo:__wf_atom_eaadc920()))
		then
			v21 = false
		end

		if
			v21
			and _T.SparrowDestinations ~= nil
			and _T.SparrowDestinations[sparrowDestinationCompassInfo.mId] ~= nil
			and _T.SparrowDestinations[sparrowDestinationCompassInfo.mId].taleHudId ~= nil
			and (__wf_atom_7e8ad928(trackedJournalEntry) or _T.SparrowDestinations[sparrowDestinationCompassInfo.mId].taleHudId ~= trackedJournalEntry.mId)
		then
			v21 = false
		end

		if
			v21
			and sparrowDestinationCompassInfo.mOwnerType ~= mOwnerType
			and sparrowDestinationCompassInfo.mOwnerFullName ~= mOwnerFullName
		then
			local v22 = __wf_atom_a6515464(position, Rotation(0, 0, 0), sparrowDestinationCompassInfo.mEntityPosition)
			local v23 = sparrowDestinationCompassInfo ~= v12 and 1
				or __wf_atom_104bfe98(1, 0.55, __wf_atom_421b01aa((v19 - 10) / 200, 0, 1)) + total
			local v24

			if mSparrowDestinationMarker.Id == sparrowDestinationCompassInfo.mId then
				v24 = false
			else
				mSparrowDestinationMarker.Id = sparrowDestinationCompassInfo.mId
				v24 = true
			end

			if not mSparrowDestinationMarker.Visible then
				v24 = true

				if not object.mMovie:__wf_atom_253d7085(object.baseClip .. "." .. mSparrowDestinationMarker.ClipName) then
					__wf_atom_86cbd68d(
						object.mMovie,
						object.baseClip .. ".Marker.duplicateMovieClip",
						mSparrowDestinationMarker.ClipName,
						v13 + 1000
					)
				end
			end

			object:ShowMarker(
				p,
				mSparrowDestinationMarker.ClipName,
				v22 - v10,
				sparrowDestinationCompassInfo.mEntityPosition.y - position.y,
				2,
				v23 * 40,
				nil,
				sparrowDestinationCompassInfo:__wf_atom_e32e2012(),
				true,
				sparrowDestinationCompassInfo.mNumStars,
				v24
			)
			mSparrowDestinationMarker.Visible = true
		elseif mSparrowDestinationMarker.Visible then
			object:ShowMarker(p, mSparrowDestinationMarker.ClipName, 0, 0, 0, 1, nil, nil, true)
			mSparrowDestinationMarker.Visible = false
		end

		if not sparrowDestinationCompassInfo.mEntityType:IsA(__wf_atom_f806fd7a) and v19 < v17 then
			v17 = v19
		end

		v13 += 1
	end

	local count = 0

	for k, mSparrowDestinationMarker in pairs(object.mSparrowDestinationMarkers) do
		count += 1
		local flag3 = true

		for _, sparrowDestinationCompassInfo in ipairs(sparrowDestinationCompassInfos) do
			if sparrowDestinationCompassInfo.mId ~= mSparrowDestinationMarker.Id then
				continue
			end

			flag3 = false
			break
		end

		if flag3 then
			object.mCompassClipAlphas[mSparrowDestinationMarker.ClipName] = nil
			local clipName = mSparrowDestinationMarker.ClipName
			__wf_atom_ec43d06e(
				object.mMovie,
				object.baseClip .. "." .. clipName,
				8,
				{ 12, 5, 6 },
				{ 0, 25, 25 },
				0.3334,
				0,
				function()
					__wf_atom_86cbd68d(object.mMovie, object.baseClip .. "." .. clipName .. ".removeMovieClip")
				end
			)
			object.mSparrowDestinationMarkers[k] = nil
		end

		if count > 1000 then
			LogBug("Compass markers overflow")
		end
	end

	if v6 or __wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(v12.mEntityType) or v15 then
		object:ShowMarker(p, "Sparrow", 0, 0, 0, 1, nil, v14 or object.resources.sparrowRespawnIcon, true)
	else
		local v20 = __wf_atom_a6515464(object2:GetPosition(), Rotation(0, 0, 0), v12.mEntityPosition)
		local __wf_atom_d5fda8be = object2:__wf_atom_d5fda8be(v12.mEntityPosition)
		local v21 = __wf_atom_421b01aa((__wf_atom_d5fda8be - v16) / 100, 0, 1)
		local v22 = __wf_atom_104bfe98(1, 0.5, v21)
		object:ShowMarker(
			p,
			"Sparrow",
			v20 - v10,
			v12.mEntityPosition.y - position.y,
			2,
			40 * (v22 + total),
			nil,
			v14 or object.resources.sparrowRespawnIcon,
			true,
			v12.mNumStars,
			true,
			1
		)
	end

	fn6(object, object2, p, v6, v10, 25)
	local mSparrowVis = not v6 and flag2 and true or v
	local mCompassArrowVis = 0

	if flag2 then
		local v20 = math.min(v17, v18)
		local v21 = 1 - math.pow(__wf_atom_421b01aa(v20 / v18, 0, 1), 0.4)
		local v22 = __wf_atom_104bfe98(0.25, 1, v21)
		object.mCompassPulseTime += p * v22 * 1.5
		local v23 = math.abs((math.sin(object.mCompassPulseTime * 3.141592653589793 * 2)))

		if v19 < 4 then
			local v24 = __wf_atom_421b01aa(v19 - 3, 0, 1)
			v23 = __wf_atom_104bfe98(1, v23, v24)
		end

		local v24 = __wf_atom_104bfe98(0, 50, v23)
		object.mMovie:__wf_atom_e57658c2(object.baseClip .. ".Glow", 12, v24)
		local v25 = mEntityPosition - object2:GetPosition()
		mCompassArrowVis = v25.y > 6 and 1 or v25.y < -6 and -1 or mCompassArrowVis
		object.mMovie:__wf_atom_e57658c2(object.baseClip .. ".Glow", 12, v24)
		object.mMovie:__wf_atom_e57658c2(object.baseClip .. ".Glow", 14, v23 * 128 + 512)
		object.mMovie:__wf_atom_e57658c2(object.baseClip .. ".Glow", 15, v23 * 32 + 64)
		object.mMovie:__wf_atom_e57658c2(object.baseClip .. ".BackerOuter", 6, v23 * 200 + 100)
	elseif object.mCompassPulseTime > 0 then
		object.mCompassPulseTime = 0
		__wf_atom_ec43d06e(object.mMovie, object.baseClip .. ".Glow", 8, { 12 }, { 0 }, 0.25, 0)
		__wf_atom_ec43d06e(object.mMovie, object.baseClip .. ".BackerOuter", 8, { 6 }, { 100 }, 0.25, 0)
	end

	if object.mCompassArrowVis ~= mCompassArrowVis then
		object.mCompassArrowVis = mCompassArrowVis

		if mCompassArrowVis == 1 then
			__wf_atom_ec43d06e(object.mMovie, object.baseClip .. ".Up", 8, { 12 }, { 100 }, 0.25, 0)
			__wf_atom_ec43d06e(object.mMovie, object.baseClip .. ".Down", 8, { 12 }, { 0 }, 0.25, 0)
		else
			if mCompassArrowVis == -1 then
				__wf_atom_ec43d06e(object.mMovie, object.baseClip .. ".Down", 8, { 12 }, { 100 }, 0.25, 0)
			else
				__wf_atom_ec43d06e(object.mMovie, object.baseClip .. ".Down", 8, { 12 }, { 0 }, 0.25, 0)
			end

			__wf_atom_ec43d06e(object.mMovie, object.baseClip .. ".Up", 8, { 12 }, { 0 }, 0.25, 0)
		end
	end

	for i = 1, #v8 do
		local v20 = (i - 1) % 2 == 0 and 50 or 30
		object:ShowMarker(
			p,
			v8[i],
			(i - 1) * 45 - v10,
			0,
			1,
			v20,
			"/SF/Language/Game/CompassDirection" .. v9[i],
			nil,
			false
		)
	end

	if not v6 then
		mSparrowVis = mSparrowVis or v3
	end

	if p3 and not v2 or p4 then
		object.mNextCompassFadeInDelay = 3
		mSparrowVis = false
		v5 = 0.5
		v4 = 0
	end

	if object.mSparrowVis ~= mSparrowVis then
		if mSparrowVis then
			__wf_atom_ec43d06e(object.mMovie, object.baseClip, 8, { 12 }, { 75 }, 1, object.mNextCompassFadeInDelay)
			object.mNextCompassFadeInDelay = 0
		else
			__wf_atom_ec43d06e(object.mMovie, object.baseClip, 8, { 12 }, { 0 }, v5, v4)
		end

		object.mSparrowVis = mSparrowVis
	end
end

function Create(mMovie, baseClip, resources)
	local v = {
		mMovie = mMovie,
		baseClip = baseClip,
		resources = resources,
		mSettings = resources.mSettings,
		mCompassSpring = {
			velocity = 0,
			position = 0,
			targetPosition = 0,
			stiffness = 90,
			dampening = 10
		},
		mCompassClipAlphas = {},
		mCompassArrowVis = nil,
		mCompassPulseTime = 0,
		mCompassSquadMarkers = {},
		mCurrentSparrowDestinationId = nil,
		mNextCompassFadeInDelay = 0,
		mPlayerMarkers = {},
		mSparrowDestinationMarkers = {},
		mSparrowVis = false,
		Initialize = function(self)
			self.mMovie:__wf_atom_e57658c2(self.baseClip, 12, 0)
			self.mMovie:__wf_atom_e57658c2(self.baseClip, 1, 40)
			self.mMovie:__wf_atom_c90af43a(self.baseClip .. ".Glow", self.resources.compassGlowIcon)
			self.mMovie:__wf_atom_e57658c2(self.baseClip .. ".Glow", 14, 512)
			self.mMovie:__wf_atom_e57658c2(self.baseClip .. ".Glow", 15, 64)
			self.mMovie:__wf_atom_e57658c2(self.baseClip .. ".Glow", 12, 0)
			self.mMovie:__wf_atom_e57658c2(self.baseClip .. ".Glow", 11, _G.UIColor_Yellow)
			self.mMovie:__wf_atom_e57658c2(self.baseClip .. ".Up", 11, _G.UIColor_Yellow)
			self.mMovie:__wf_atom_e57658c2(self.baseClip .. ".Down", 11, _G.UIColor_Yellow)
			self.mMovie:__wf_atom_e57658c2(self.baseClip .. ".Up", 12, 0)
			self.mMovie:__wf_atom_e57658c2(self.baseClip .. ".Down", 12, 0)
		end,
		Update = function(p, p2, p3, p4, p5, p6, p7)
			fn8(p, p2, p3, p4, p5, p6, p7)
		end,
		ShowMarker = function(self, p, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
			fn5(self, p, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
		end
	}
	v:Initialize()
	return v
end