local module = require("SF.Scripts.Libs.SparrowLib")
local v = Type("/SF/Types/NeutralCreatures/SimpleSparrow")
local v2 = Type("/SF/Animations/Player/Emotes/SitEmoteStart")
local v3 = Type("/SF/Animations/Player/Emotes/SitEmoteLoop")
local v4 = Type("/SF/Animations/Player/Emotes/SitEmoteEnd")
local v5 = Type("/SF/Fx/Abilities/Common/Bird/AppearFX")
local v6 = { NONE = 0, STARTED = 1, LOOPED = 2, ENDED = 3 }

local function fn(p, object, emoteSparrow)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	if _T.SitEmoteData == nil then
		_T.SitEmoteData = {}
	end

	local __wf_atom_ef151cfd = __wf_atom_a96eb2aa:__wf_atom_ef151cfd()

	if _T.SitEmoteData[__wf_atom_ef151cfd] == nil then
		return
	end

	local v7 = _T.SitEmoteData[__wf_atom_ef151cfd]
	gRegion:__wf_atom_dd1e4d10(v7.CurrentEmoteCin)
	local entity = gRegion:CreateEntity(p, object:GetPosition(), object:__wf_atom_2f2bada0())
	entity:__wf_atom_a3d2b66b(object, Symbol("Envoy"))
	entity:__wf_atom_a3d2b66b(emoteSparrow, Symbol("Sparrow"))
	entity:StartRelative(Symbol("Envoy"), object:__wf_atom_a2a18137(), object:__wf_atom_2f2bada0())
	return entity
end

function EMO_START(object)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	if _T.SitEmoteData == nil then
		_T.SitEmoteData = {}
	end

	_T.SitEmoteData[__wf_atom_a96eb2aa:__wf_atom_ef151cfd()] = { CinState = v6.NONE }
	object:__wf_atom_aeb02c14(Resource("/SF/Types/Input/SitEmoteInputFilter"))
	local v7 = _T.SitEmoteData[__wf_atom_a96eb2aa:__wf_atom_ef151cfd()]
	local motionControl = object:MotionControl()
	local v8

	if not __wf_atom_7e8ad928(motionControl) then
		v8 = motionControl:__wf_atom_282af4d6() or nil
	end

	if not __wf_atom_7e8ad928(v8) then
		v7.MoverToPlayer = object:GetPosition() - v8:GetPosition()
	end

	if gRegion:IsMaster() then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			__wf_atom_d2b2176d:Unequip(0, 2)
		end

		if gGameRules:__wf_atom_95862cc1() then
			object:__wf_atom_84b48bf2(1)
			local v9 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
			gGameRules:SendControlMessage(v9)
		end
	end
end

function _UpdateCinPosition(object)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	if _T.SitEmoteData == nil then
		_T.SitEmoteData = {}
	end

	local __wf_atom_ef151cfd = __wf_atom_a96eb2aa:__wf_atom_ef151cfd()

	if _T.SitEmoteData[__wf_atom_ef151cfd] == nil then
		return
	end

	local v7 = _T.SitEmoteData[__wf_atom_ef151cfd]

	while _T.SitEmoteData[__wf_atom_ef151cfd] ~= nil do
		if not __wf_atom_7e8ad928(v7.CurrentEmoteCin) and v7.MoverToPlayer ~= nil then
			local currentEmoteCin = v7.CurrentEmoteCin
			local motionControl = object:MotionControl()
			local v8

			if not __wf_atom_7e8ad928(motionControl) then
				v8 = motionControl:__wf_atom_282af4d6() or nil
			end

			if not __wf_atom_7e8ad928(v8) then
				currentEmoteCin:SetPosition(v8:GetPosition() + v7.MoverToPlayer)
			end
		end

		Sleep(0)
	end
end

function EMO_LOOP(object, _)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	if _T.SitEmoteData == nil then
		_T.SitEmoteData = {}
	end

	local __wf_atom_ef151cfd = __wf_atom_a96eb2aa:__wf_atom_ef151cfd()

	if _T.SitEmoteData[__wf_atom_ef151cfd] == nil then
		_T.SitEmoteData[__wf_atom_ef151cfd] = { CinState = v6.NONE }
	end

	local v7 = _T.SitEmoteData[__wf_atom_ef151cfd]

	if
		v7.CinState == v6.LOOPED
		or v7.CinState == v6.STARTED
		and not __wf_atom_7e8ad928(v7.CurrentEmoteCin)
		and v7.CurrentEmoteCin:__wf_atom_7d4910e4()
	then
		return
	end

	if v7.CinState == v6.NONE then
		v7.EmoteSparrow = gRegion:CreateEntity(v, object:GetPosition(), object:__wf_atom_2f2bada0())
		module.ApplySparrowCustomizationToDeco(object, v7.EmoteSparrow)
		v7.CurrentEmoteCin = fn(v2, object, v7.EmoteSparrow)
		v7.CinState = v6.STARTED

		if object:__wf_atom_8efce136() then
			object:__wf_atom_8a035cd5(Symbol("_UpdateCinPosition"), false)
		end
	else
		v7.CurrentEmoteCin = fn(v3, object, v7.EmoteSparrow)
		v7.CinState = v6.LOOPED
	end
end

function _WaitForAnimAndDestroy(object)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	if _T.SitEmoteData == nil then
		_T.SitEmoteData = {}
	end

	local __wf_atom_ef151cfd = __wf_atom_a96eb2aa:__wf_atom_ef151cfd()

	if _T.SitEmoteData[__wf_atom_ef151cfd] == nil then
		return
	end

	local v7 = _T.SitEmoteData[__wf_atom_ef151cfd]
	local emoteSparrow = v7.EmoteSparrow

	if v7.CinState == v6.ENDED and not v7.Interrupted then
		Sleep(2)
	elseif not __wf_atom_7e8ad928(emoteSparrow) then
		gRegion:CreateEntity(v5, emoteSparrow:GetPosition(), emoteSparrow:__wf_atom_2f2bada0())
	end

	gRegion:__wf_atom_dd1e4d10(emoteSparrow)
	gRegion:__wf_atom_dd1e4d10(v7.CurrentEmoteCin)
	_T.SitEmoteData[__wf_atom_ef151cfd] = nil
end

function EMO_END(object, _, interrupted)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	if _T.SitEmoteData == nil then
		_T.SitEmoteData = {}
	end

	local __wf_atom_ef151cfd = __wf_atom_a96eb2aa:__wf_atom_ef151cfd()

	if _T.SitEmoteData[__wf_atom_ef151cfd] == nil then
		_T.SitEmoteData[__wf_atom_ef151cfd] = { CinState = v6.NONE }
	end

	local v7 = _T.SitEmoteData[__wf_atom_ef151cfd]
	v7.Interrupted = interrupted

	if not interrupted and not __wf_atom_7e8ad928(v7.EmoteSparrow) and v7.CinState == v6.LOOPED then
		v7.CurrentEmoteCin = fn(v4, object, v7.EmoteSparrow)
		v7.CinState = v6.ENDED
	end

	if interrupted and not __wf_atom_7e8ad928(v7.CurrentEmoteCin) then
		v7.CurrentEmoteCin:Stop()
		gRegion:__wf_atom_dd1e4d10(v7.CurrentEmoteCin)
	end

	if gRegion:IsMaster() and gGameRules:__wf_atom_95862cc1() then
		object:__wf_atom_84b48bf2(0)
		local v8 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
		gGameRules:SendControlMessage(v8)
	end

	object:__wf_atom_cf966a74(Resource("/SF/Types/Input/SitEmoteInputFilter"))
	object:__wf_atom_8a035cd5(Symbol("_WaitForAnimAndDestroy"), false)
end