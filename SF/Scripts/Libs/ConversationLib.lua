module(..., package.seeall)
local v = Resource("/SF/Interface/NewConversationMenu.swf")
local module = require("SF.Interface.Libs.UIUtilities")
turn180Anim = Resource("/SF/Animations/Player/Contextual/ArsenalEnterRLeg_anim.fbx")

local function fn(heading, p) -- 1 equivalent call inferred from this helper
	local v2 = heading + p

	if v2 >= 180 then
		return v2 - 360
	end

	if v2 < -180 then
		return v2 + 360
	end

	return v2
end

function MovePlayerToPosition(object, object2)
	local motionControl = object:MotionControl()
	local position = object2:GetPosition()
	local v2 = fn(object2:__wf_atom_dc309f8a().heading, 180) -- inferred equivalent call
	motionControl:__wf_atom_d327aef9(position, 0, false, false, Rotation(v2, 0, 0), 1.75, false, true)

	while motionControl:__wf_atom_5b89cdd7() do
		Sleep(0)
	end
end

function MovePlayerToAndTurn180(object, p)
	MovePlayerToPosition(object, p)
	object:__wf_atom_921c1a5f(turn180Anim, true, 3, 1, true)
end

function SlidePlayer(object, object2, p, p2)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local position = object2:GetPosition()
	local __wf_atom_dc309f8a = object2:__wf_atom_dc309f8a()
	local v2 = p == 0 and 2 or p
	local position2 = object:GetPosition()
	local __wf_atom_d9cb4b97 = object:MotionControl():__wf_atom_d9cb4b97()
	local total = 0

	while total <= v2 do
		local v3 = __wf_atom_24a82b69((math.min(total / v2, 1)))
		object:Teleport(
			__wf_atom_f55d6358(position2, position, v3),
			(__wf_atom_9d2f097a(__wf_atom_d9cb4b97, __wf_atom_dc309f8a, v3))
		)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(p2) or p2 then
		object:__wf_atom_f0f9fb38(__wf_atom_dc309f8a)
	end
end

function RotateHead(object, p, value)
	if _T.DialogueHeadRotations == nil then
		_T.DialogueHeadRotations = {}
	end

	local name = object:GetName()
	local id = _T.DialogueHeadRotations[name] == nil and 1 or _T.DialogueHeadRotations[name].Id + 1
	_T.DialogueHeadRotations[name] = { Id = id }
	local v2 = Symbol("GAME_C1_HEAD1")
	local __wf_atom_d604ec21 = object:__wf_atom_d604ec21(v2)
	local total = 0
	local v3 = value or 1

	while total <= v3 and (_T.DialogueHeadRotations[name] == nil or _T.DialogueHeadRotations[name].Id == id) do
		local v4 = __wf_atom_24a82b69((math.min(total / v3, 1)))
		local v5 = __wf_atom_9d2f097a(__wf_atom_d604ec21, p, v4)
		total += __wf_atom_084b3e93()
		object:__wf_atom_5372d35c(v2, v5)
		Sleep(0)
	end

	if _T.DialogueHeadRotations[name] ~= nil and _T.DialogueHeadRotations[name].Id == id then
		_T.DialogueHeadRotations[name] = nil
	end
end

function SetCamSpot(p, value, object)
	if __wf_atom_7e8ad928(object) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			object = __wf_atom_c4f78a8f:CameraControl()
		end
	end

	local __wf_atom_1b3db7e0 = object:__wf_atom_1b3db7e0()
	object:__wf_atom_fd14c463(0)
	object:SetCameraSpot(p, value or 0.5)
	object:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
end

function ClearCamSpot(value, object)
	if __wf_atom_7e8ad928(object) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			object = __wf_atom_c4f78a8f:CameraControl()
		end
	end

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_5fcdec2b() then
		SetCamSpot(nil, value or 0.5, object)
	end
end

local function fn2(speaker, cameraSpot, transitionToCamTime)
	_T.Conversations = _T.Conversations or {}
	return {
		["mConvoMovie"] = nil,
		mConvoInfo = {
			Speaker = speaker,
			Choices = {},
			CameraSpot = cameraSpot,
			TransitionToCamTime = transitionToCamTime,
			Callback = function(p)
				if __wf_atom_7e8ad928(_T.Conversations) then
					return
				end

				local conversation = _T.Conversations[speaker]

				if __wf_atom_7e8ad928(conversation) then
					return
				end

				local text = p.Text

				for _, v2 in ipairs(conversation:GetChoices()) do
					if not (text == v2.Text or text == v2.Tag) then
						continue
					end

					conversation.mConvoInfo.Choices = nil

					if v2.Callback then
						v2.Callback(conversation)
					end

					break
				end
			end,
			AllowExit = true,
			Skippable = false,
			CursorSnapping = true
		},
		mSubConversation = nil,
		mResume = false,
		mRoot = true,
		SetChoices = function(self, options)
			self.mConvoInfo.Choices = options or {}
			_T.ConversationInfo = self.mConvoInfo
		end,
		GetChoices = function(self)
			return self.mConvoInfo.Choices
		end,
		Start = function(self, conversationSoundOverrides)
			if __wf_atom_7e8ad928(_T.Conversations) then
				return
			end

			if self.mRoot then
				module.SetChatVisible(false)
			end

			_T.SubtitleText = nil
			_T.ForceDialogClose = nil
			_T.ConversationInfo = self.mConvoInfo
			_T.Conversations[self.mConvoInfo.Speaker] = self

			if self.mRoot and not __wf_atom_7e8ad928(self.mConvoInfo.CameraSpot) then
				SetCamSpot(self.mConvoInfo.CameraSpot, self.mConvoInfo.TransitionToCamTime)
			end

			_T.ConversationSoundOverrides = conversationSoundOverrides

			if __wf_atom_7e8ad928(self.mConvoMovie) and not __wf_atom_7e8ad928(self.CONV_MOVIE_WRES) then
				local movie = __wf_atom_8e4fda44:FindMovie(self.CONV_MOVIE_WRES)

				if not __wf_atom_7e8ad928(movie) then
					movie:Close()
				end

				self.mConvoMovie = __wf_atom_8e4fda44:__wf_atom_8b74c30b(self.CONV_MOVIE_WRES)
			end

			_T.ConversationSoundOverrides = nil
			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

			if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				__wf_atom_eab484a7:__wf_atom_915c3883(true)
			end
		end,
		SetSubConversation = function(state, instance, mResume, p, mClosedCallback)
			if state.mSubConversation and not __wf_atom_7e8ad928(state.mSubConversation.mConvoMovie) then
				return nil
			end

			if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_c9dca5b1) then
				state.mSubConversation = CreateConversation(
					state.mConvoInfo.Speaker,
					state.mConvoInfo.CameraSpot,
					instance
				)
			else
				state.mSubConversation = CreateConversationFromOpenMovie(
					state.mConvoInfo.Speaker,
					state.mConvoInfo.CameraSpot,
					instance
				)
			end

			state.mSubConversation.mClosedCallback = mClosedCallback
			state.mSubConversation.mRoot = false
			state.mSubConversation:SetChoices(p)
			state.mSubConversation:Start()
			state.mResume = mResume
			return state.mSubConversation
		end,
		Update = function(self)
			if self.mSubConversation then
				if not self.mSubConversation:Update() then
					self.mSubConversation = nil

					if self.mResume then
						self:Start()
					end
				end
			elseif __wf_atom_7e8ad928(self.mConvoMovie) or self.mConvoMovie:Execute("IsClosing", "") then
				if self.mClosedCallback ~= nil then
					self.mClosedCallback()
				end

				return false
			end

			if self.mRoot and _T.ForceDialogClose then
				_T.ForceDialogClose = nil
				self:Close(true)
				return false
			else
				local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

				if
					__wf_atom_7e8ad928(__wf_atom_c4f78a8f)
					or not __wf_atom_c4f78a8f:__wf_atom_e919fb8e().nightfoldTransition
				then
					return true
				end

				return false
			end
		end,
		ChangeAffinity = function(p, p2)
			if __wf_atom_7e8ad928(p.mConvoMovie) then
				return
			end

			p.mConvoMovie:Execute("ChangeAffinity", p2)
		end,
		SetBackChoice = function(p, p2)
			p.mConvoMovie:Execute("SetBackChoice", p2)
		end,
		Close = function(self, p)
			if self.mRoot then
				module.SetChatVisible(true)
			end

			if self.Closed then
				return
			end

			self.Closed = true

			if self.OnClose ~= nil then
				self:OnClose(p)
			end

			if not __wf_atom_7e8ad928(self.mConvoMovie) then
				if p then
					self.mConvoMovie:Close()
				else
					self.mConvoMovie:Execute("TransitionOut", nil)
				end
			end

			if self.mSubConversation then
				self.mSubConversation:Close(p)

				if p and not __wf_atom_7e8ad928(self.mSubConversation.mConvoMovie) then
					self.mSubConversation.mConvoMovie:Close()
				end
			end

			if self.mRoot and self.mConvoInfo.CameraSpot then
				ClearCamSpot(p and 0.01 or nil)

				if not __wf_atom_7e8ad928(_T.Conversations) then
					_T.Conversations[self.mConvoInfo.Speaker] = nil
				end
			end

			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

			if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				__wf_atom_eab484a7:__wf_atom_915c3883(false)
			end
		end,
		AllowExit = function(p, allowExit)
			p.mConvoInfo.AllowExit = allowExit
		end,
		SetSkippable = function(p, skippable)
			p.mConvoInfo.Skippable = skippable
		end,
		UseCursorSnapping = function(p, cursorSnapping)
			p.mConvoInfo.CursorSnapping = cursorSnapping
		end
	}
end

function CreateConversationFromOpenMovie(p, p2, mConvoMovie)
	if __wf_atom_7e8ad928(mConvoMovie) then
		print("Could not create conversation from null movie instance!")
		return nil
	end

	local v2 = fn2(p, p2)
	v2.CONV_MOVIE_WRES = mConvoMovie:__wf_atom_6d61d595()
	v2.mConvoMovie = mConvoMovie
	return v2
end

function CreateConversation(speaker, cameraSpot, p, transitionToCamTime)
	local v2 = fn2(speaker, cameraSpot, transitionToCamTime)
	v2.CONV_MOVIE_WRES = p or v
	return v2
end