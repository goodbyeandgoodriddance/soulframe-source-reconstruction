module(..., package.seeall)
local module = require("Lotus.Interface.MissionRequirementUtilities")
local module2 = require("Lotus.Interface.CrossPlatformUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.LotusNetworkUtilities")
local module5 = require("EE.Interface.Utilities")
local module6 = require("SF.Interface.SFUtilities")
local module7 = require("SF.Scripts.Libs.QuestLib")
local v = WeakResource("/SF/Types/Quests/PreAlpha/Q1WakeUp")
local mMovie = nil

function Create(state, mClipName)
	mMovie = state.mMovie
	local v2 = {
		VoipState = { DISABLED = 1, ENABLED = 3, MUTED = 2, TALKING = 4 },
		mClipName = mClipName,
		mLastPlayerCount = 0,
		mPlayerInfo = {},
		mVisible = false,
		mHideVoipWhenInactive = true,
		mVoipEnabled = true,
		mMaximized = false,
		mShowDesc = true,
		mPrevMMVisible = false,
		mPrevInviteVisible = false,
		mMMVisible = false,
		mChildMovies = {},
		mCachedPlayers = nil,
		mNeedsInit = true,
		mFindInvitedSessionQueued = false,
		mJoinDelay = 0,
		mPendingLobbyJoinTimer = -1,
		mPendingDisconnectRemotePlayers = false,
		GetPlayerInfoByOnlineId = function(p, p2)
			for _, v2 in p.mPlayerInfo do
				if not __wf_atom_7e8ad928(v2.Player) and v2.Player.onlineId == p2 then
					return v2
				end
			end

			return nil
		end,
		GetLocalPlayerInfo = function(p)
			for _, v2 in p.mPlayerInfo do
				if not __wf_atom_7e8ad928(v2.Player) and v2.Player.isLocal then
					return v2
				end
			end

			return nil
		end,
		CanLeaveSquadInMission = function(self)
			local gGameRules2 = gGameRules

			if gGameRules2 then
				if gGameRules:__wf_atom_e22d6f15() == 28 then
					gGameRules2 = gGameRules:__wf_atom_13d8a544() > 25
				else
					gGameRules2 = false
				end
			end

			return gGameRules2
		end,
		ValidateMode = function(self, p)
			if p == module3.UI_MODE_IN_SPACE_SHIP then
				return true
			end

			return not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_adfb052a()
		end,
		CanLeaveSquad = function(self)
			local uiMode = module3.GetUIMode()
			return self.mNumSquadMembers > 1
				and (uiMode == module3.UI_MODE_IN_SPACE_SHIP or uiMode == module3.UI_MODE_IN_SPACE_HUB or uiMode == module3.UI_MODE_IN_DOJO or self:CanLeaveSquadInMission())
				and self:ValidateMode(uiMode)
		end,
		UpdateVisibility = function(self)
			self.mVisible = __wf_atom_a0f6588f:__wf_atom_f89aa44a()
				and (not _T.HideSquadOverlay or _T.HideSquadOverlay <= 0)
				and (__wf_atom_7e8ad928(gRegion) or not gRegion:__wf_atom_c3b255b8())
				and (_T.gPendingMission ~= nil or _T.UIInputEnabled)
				and true
				or false
		end,
		JoinInviteConfirm = function(self, p)
			if __wf_atom_7e8ad928(gGameData) then
				return
			end

			if tonumber(p) == 4 then
				if Engine.__wf_atom_84bb79c2() then
					local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

					if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
						__wf_atom_18a5d83b:__wf_atom_b2098de3(1)
					end

					if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or not __wf_atom_18a5d83b:__wf_atom_b2644498() then
						self:ClearInvite(true)
						return
					end

					if
						not __wf_atom_7e8ad928(self.mGameInviteInfo)
						and __wf_atom_18a5d83b:__wf_atom_e75653c3() ~= self.mGameInviteInfo.targetAccountId
					then
						module5.ShowConfirmMessage(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ConfirmInviteOtherProfile", false),
							"OnConfirmJoinForOtherPlayer"
						)
						return
					end
				end

				local movie = __wf_atom_8e4fda44:FindMovie(module5.GetChatMovie())

				if not __wf_atom_7e8ad928(movie) and movie:Execute("IsMaximized", "") then
					movie:Execute("MinimizeButton", "")
				end

				if Engine.__wf_atom_fc67ba71() then
					_T.gTransitioningToLobby = true
					_T.gLobbyFromInvite = true
				end

				local v2

				if module6.GetIsBlockingPartyInvites() then
					v2 = module7.QuestIsActive(v) and "/SF/Language/SystemMessages/JoinPartyDisabledBlockedInvites"
						or "/SF/Language/SystemMessages/JoinPartyDisabledGeneric"
				end

				if v2 == nil then
					if self.mGameInviteInfo then
						local v3

						if self.mGameInviteInfo.squadMission then
							v3 = cjson.decode(self.mGameInviteInfo.squadMission)
						end

						v2 = module4.CheckInvitation(self.mGameInviteInfo, v3)
					else
						v2 = "/Menu/NoSessionFound"
					end
				end

				if v2 then
					_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
					module5.ShowMessage(v2)
					self:ClearInvite()
				else
					_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
					self.mFindInvitedSessionQueued = true
				end
			else
				self:ClearInvite(false, 3)
				self:CheckForInvites()
			end
		end,
		OnHostSessionFromInviteFriend = function(self, p)
			if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
			end

			if not p and p ~= "true" then
				return
			end

			self:OnInvite()
		end,
		CheckForInvites = function(self)
			local __wf_atom_8a8c610f = gGameData:__wf_atom_8a8c610f()

			if __wf_atom_8a8c610f ~= "" then
				self:GameInviteReceivedCallback(__wf_atom_8a8c610f)
			end
		end,
		CanInvite = function(self)
			return #self:GetSquadPlayers() < 3 and _T.UIInputEnabled and not module3.InQuestCommitment(gGameData)
		end,
		OnInvite = function(self)
			if not _T.InvitePanelOpen then
				local v2 = module4.CheckGameInvitePermission()

				if v2 then
					module5.ShowMessage(v2, nil, 0)
				elseif module4.InSession() or gMatchingService:IsBlockingTaskPending() then
					local inviteFriends = module4.InviteFriends()

					if inviteFriends then
						table.insert(self.mChildMovies, inviteFriends)
					end
				else
					print("Host squad session - OnHostSessionFromInviteFriend")
					_T.BackgroundMovie:__wf_atom_f62a8704("ShowBlockingMessage", {
						"2",
						"/Lotus/Language/Menu/Session_Creating"
					})

					if module3.GetUIMode() == module3.UI_MODE_IN_DOJO then
						module4.HostSquadSession(
							"OnHostSessionFromInviteFriend",
							module3.BuildGameModeIdForClanDojo(),
							nil,
							gGameRules:__wf_atom_5ff594a3()
						)
					else
						module4.HostSquadSession("OnHostSessionFromInviteFriend")
					end
				end
			end
		end,
		InitializeSquadPlayerInfo = function(self, p, mPlayer, p2)
			self.mPlayerInfo[p2] = p
			p.mPlayer = mPlayer
			self:UpdateSquadPlayer(mPlayer, p2, true)
		end,
		UpdateSquadPlayer = function(self, mPlayer, p, p2)
			if module6.MAX_SQUAD_SIZE < p or __wf_atom_7e8ad928(gRegion) then
				return
			end

			local v2 = self.mPlayerInfo[p]

			if v2 == nil or __wf_atom_7e8ad928(mPlayer) then
				return
			end

			if not v2.mInitialized or p2 then
				v2.mInitialized = true

				if v2.mPlayer ~= mPlayer then
					v2.mPlayer = mPlayer
				end

				local decoded = cjson.decode(mPlayer.loadout)
				local playerLevel = nil
				local playerXp = nil

				if decoded.PlayerLevel == nil or decoded.PlayerLevel == "" then
					if mPlayer.isLocal and not __wf_atom_7e8ad928(gGameData) then
						playerLevel = gGameData:__wf_atom_a04e4a53()
						playerXp = gGameData:__wf_atom_d5bed0b3()
					end
				else
					playerLevel = decoded.PlayerLevel
					playerXp = decoded.PlayerXp
				end

				if playerLevel ~= nil then
					if playerXp ~= nil and not __wf_atom_7e8ad928(gGameData) and v2.mXP ~= playerXp then
						v2.mXP = playerXp
						local __wf_atom_05cd7ba0 = gGameData:__wf_atom_05cd7ba0(playerLevel)
						local __wf_atom_05cd7ba0_2 = gGameData:__wf_atom_05cd7ba0(playerLevel + 1)
						local _ = (playerXp - __wf_atom_05cd7ba0) / (__wf_atom_05cd7ba0_2 - __wf_atom_05cd7ba0)

						if mPlayer.isLocal then
							if __wf_atom_05cd7ba0_2 <= playerXp then
								self.mLevelUpAvailable = true
							else
								self.mLevelUpAvailable = false
							end
						else
							local _ = __wf_atom_05cd7ba0_2 < playerXp
						end
					end

					v2.mPlayerLevel = module3.ProcessPlayerLevel(playerLevel)
				end

				local name = mPlayer.name

				if v2.mName ~= name then
					v2.mName = name
				end

				local profileImage = decoded.ProfileImage
				local iconTexture = nil

				if #profileImage > 0 then
					local v3 = Resource(profileImage)

					if not __wf_atom_7e8ad928(v3) then
						iconTexture = v3:GetIconTexture()
					end
				end

				if __wf_atom_7e8ad928(iconTexture) then
					iconTexture = _G.UITexture_ProfilePlaceHolder
				end

				v2.mIcon = iconTexture
				self:UpdateIcon(v2)
				local ternary = module5.Ternary(decoded.NORMAL_PVP ~= nil, decoded.NORMAL_PVP, decoded.NORMAL)
				local ternary2 = module5.Ternary(decoded.NORMAL_PVP ~= nil, 2, 0)
				local mItems

				if not __wf_atom_7e8ad928(ternary) then
					if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_dd9a0bb8) then
						for _, v3 in ipairs(gRegion:__wf_atom_3c8e1a7a()) do
							if v3:__wf_atom_6be84646() ~= v2.mName then
								continue
							end

							local __wf_atom_eff0517e = v3:__wf_atom_eff0517e()

							if __wf_atom_7e8ad928(__wf_atom_eff0517e) then
								break
							end

							local __wf_atom_d2b2176d = __wf_atom_eff0517e:__wf_atom_d2b2176d()
							local v4 = 0
							local v5 = v4 + 1

							if ternary and ternary[v5] and ternary[v5].ItemType ~= "" then
								ternary[v5].Level = __wf_atom_d2b2176d:__wf_atom_0efc9109(ternary2, v4)
							end

							local v6 = 1
							local v7 = v6 + 1

							if ternary and ternary[v7] and ternary[v7].ItemType ~= "" then
								ternary[v7].Level = __wf_atom_d2b2176d:__wf_atom_0efc9109(ternary2, v6)
							end

							local v8 = 2
							local v9 = v8 + 1

							if ternary and ternary[v9] and ternary[v9].ItemType ~= "" then
								ternary[v9].Level = __wf_atom_d2b2176d:__wf_atom_0efc9109(ternary2, v8)
							end

							local v10 = 3
							local v11 = v10 + 1

							if ternary and ternary[v11] and ternary[v11].ItemType ~= "" then
								ternary[v11].Level = __wf_atom_d2b2176d:__wf_atom_0efc9109(ternary2, v10)
							end

							if ternary2 == 0 then
								local sentinel = decoded.SENTINEL
								local v12 = 1
								local v13 = 0
								local v14 = v13 + 1

								if sentinel and sentinel[v14] and sentinel[v14].ItemType ~= "" then
									sentinel[v14].Level = __wf_atom_d2b2176d:__wf_atom_0efc9109(v12, v13)
								end
							end

							break
						end
					end

					mItems = {
						{ Type = ternary[1], isWeapon = true },
						{ Type = decoded.DragonKey, isDragonKey = true },
						{ Type = decoded.VoidProjection, isProjection = true },
						{ Type = ternary[3], isWeapon = true },
						{ Type = ternary[2], isWeapon = true },
						{ Type = ternary[4], isWeapon = true }
					}
				end

				v2.mItems = mItems
			end

			if self.mVisible or p2 then
				if
					__wf_atom_7e8ad928(__wf_atom_597fcbc7)
					or not __wf_atom_597fcbc7:__wf_atom_5e6e39e2(mPlayer.matchMakingString)
				then
					if v2.mPlayerTalking ~= nil and v2.mPlayerTalking > 0 then
						v2.mPlayerTalking -= __wf_atom_fa1258d0()
					end
				else
					v2.mPlayerTalking = 0.25
				end

				local disabled = self.VoipState.DISABLED

				if self.mVoipEnabled and not (mPlayer.isLocal or __wf_atom_7e8ad928(__wf_atom_597fcbc7)) then
					if __wf_atom_597fcbc7:__wf_atom_29cd1ff1(mPlayer.matchMakingString) then
						disabled = self.VoipState.MUTED
					elseif __wf_atom_7e8ad928(v2.mPlayerTalking) or not (v2.mPlayerTalking > 0) then
						disabled = self.VoipState.ENABLED
					else
						disabled = self.VoipState.TALKING
					end
				end

				if v2.mVoipState ~= disabled then
					v2.mVoipState = disabled

					if disabled ~= self.VoipState.DISABLED and self.mHideVoipWhenInactive then
						local _ = disabled == self.VoipState.ENABLED
					end

					if disabled ~= self.VoipState.DISABLED then
						local _voipTalkingTexture = self.VoipTalkingTexture

						if disabled == self.VoipState.MUTED then
							local _voipMutedTexture = self.VoipMutedTexture
						end
					end
				end
			end
		end,
		GetSquadPlayers = function(self)
			if not self.mCachedPlayers then
				local mCachedPlayers

				if module3.GetUIMode() == module3.UI_MODE_IN_SPACE_SHIP then
					mCachedPlayers = gMatchingService:__wf_atom_bb46d8b6()
				else
					local localSquadMember = module4.GetLocalSquadMember()

					if localSquadMember then
						if localSquadMember.teamId == 255 then
							local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()
							mCachedPlayers = {}

							for i = 1, #__wf_atom_bb46d8b6 do
								local v2 = __wf_atom_bb46d8b6[i]

								if localSquadMember.name == v2.name or v2.name ~= module3.HIDDEN_PLAYER_NAME then
									table.insert(mCachedPlayers, v2)
								end
							end
						else
							local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()
							mCachedPlayers = {}

							for i = 1, #__wf_atom_bb46d8b6 do
								local v2 = __wf_atom_bb46d8b6[i]

								if v2.teamId == localSquadMember.teamId then
									table.insert(mCachedPlayers, v2)
								end
							end
						end
					else
						mCachedPlayers = {}
					end
				end

				self.mCachedPlayers = mCachedPlayers
				self.mNumCachedPlayers = #mCachedPlayers
			end

			return self.mCachedPlayers or {}
		end,
		RefreshSquadPlayers = function(self)
			self.mCachedPlayers = nil
		end,
		GetInfoForMatchMakingGameMode = function(p, p2)
			local v2 = { Label = "", Icon = nil }
			local v3 = nil
			local v4 = ""

			if p2 == _T.MATCHMAKING_QUICKMATCH_GAMEMODE then
				v2.Icon = p.MMTextures[1]
				v3 = "NavBar_QuickMatch"
				v4 = "<MM_PUBLIC>"
			elseif p2 == _T.MATCHMAKING_PRIVATE_GAMEMODE then
				v2.Icon = p.MMTextures[2]
				v3 = "NavBar_Host"
				v4 = "<MM_FRIEND>"
			elseif p2 == _T.MATCHMAKING_INVITE_ONLY_GAMEMODE then
				v2.Icon = p.MMTextures[3]
				v3 = "NavBar_InviteOnly"
				v4 = "<MM_INVITE>"
			elseif p2 == _T.MATCHMAKING_OFFLINE_GAMEMODE then
				v2.Icon = p.MMTextures[4]
				v3 = "NavBar_Offline"
				v4 = "<MM_SOLO>"
			end

			if v3 ~= nil then
				v2.Label = mMovie:__wf_atom_8e9ac384(v4, true) .. "  " .. mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Menu/" .. v3,
					false
				)
			end

			return v2
		end,
		DisconnectRemotePlayers = function(self)
			self.mPendingDisconnectRemotePlayers = true
		end,
		FlushPendingDisconnects = function(p)
			if not p.mPendingDisconnectRemotePlayers then
				return
			end

			p.mPendingDisconnectRemotePlayers = false

			if __wf_atom_7e8ad928(gRegion) or not gRegion:IsMaster() then
				return
			end

			for _, v2 in gRegion:__wf_atom_3c8e1a7a() do
				if not v2:IsLocal() then
					gMatchingService:__wf_atom_369780a2(v2, false)
				end
			end
		end,
		ClearVoting = function(self) end,
		OnSquadMemberJoined = function(self, p)
			__wf_atom_f2daf912("OnSquadMemberJoined" .. " " .. p)

			if _T.EtherealHubSquadMembersChanged then
				_T.EtherealHubSquadMembersChanged(p)
			end
		end,
		OnSquadMemberLeft = function(self, p)
			__wf_atom_f2daf912("OnSquadMemberLeft" .. " " .. p)
		end,
		OnLeaveSquadDone = function(self)
			print("OnLeaveSquadDone")
			self:RefreshSquadPlayers()
		end,
		LeaveSquad = function(self)
			print("LeaveSquad")

			if gGameRules:__wf_atom_09e81034() and gRegion:IsMaster() then
				self:DisconnectRemotePlayers()
			end

			if
				_T.ScenarioSquadMembersChanged
				and gMatchingService:__wf_atom_a676a953()
				and gMatchingService:__wf_atom_1b24a1bb()
			then
				_T.ScenarioSquadMembersChanged(
					__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646(),
					false,
					true
				)
			end

			gMatchingService:LeaveSquad("OnLeaveSquadDone")
			self:ClearVoting()
		end,
		RequiresSquadHost = function(self)
			return gGameRules:__wf_atom_09e81034()
		end,
		LeaveSquadPressed = function(self)
			print("Leave squad Pressed")

			if
				module3.GetUIMode() ~= module3.UI_MODE_IN_SPACE_SHIP
				and (__wf_atom_7e8ad928(gGameRules) or not gGameRules:__wf_atom_adfb052a())
			then
				print("Can't leave squad right now (starting/ending game)")
				return
			end

			_G.matchmakingTimeoutActive = nil

			if gGameRules:__wf_atom_af3bd666() then
				self:CancelTrade()
			end

			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsMaster() ~= gGameRules:IsMaster() then
				print("Leaving squad when we don't have our client avatar yet")

				if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
					print("avatar: " .. __wf_atom_c4f78a8f:__wf_atom_5b41f63b())
				end

				Engine.Disconnect(true)
			elseif gGameRules:__wf_atom_dc0a2fe6() or gGameRules:__wf_atom_e22d6f15() ~= 28 then
				if self:RequiresSquadHost() then
					if gRegion:IsMaster() then
						self:DisconnectRemotePlayers()
					else
						Engine.Disconnect(true)
					end
				end
			else
				if gRegion:IsMaster() then
					self:DisconnectRemotePlayers()
				else
					self:RefreshSquadPlayers()
					gGameRules:__wf_atom_3033c325(false)
					gClient:ForceHostMigration()
				end

				return true
			end

			if #gMatchingService:__wf_atom_bb46d8b6() <= 1 and gMatchingService:__wf_atom_1b24a1bb() then
				self:ClearVoting()
				print("We're the only one in our squad and we're the host, ignoring.")
			else
				self:LeaveSquad()
				return true
			end
		end,
		ClearInvite = function(self, p, p2)
			local v2 = p or false
			self.mFindInvitedSessionQueued = false

			if not v2 and Engine.__wf_atom_fc67ba71() then
				_T.gTransitioningToLobby = false
				_T.gLobbyFromInvite = false
			end

			if __wf_atom_7e8ad928(gGameData) then
				return
			end

			if v2 then
				gGameData:ClearInvite("all")
			elseif self.mGameInviteInfo ~= nil then
				local v3 = p2 == nil and 4 or p2
				gMatchingService:__wf_atom_c415a49f(
					self.mGameInviteInfo.accountId,
					self.mGameInviteInfo.bindingServerId,
					v3
				)
				gGameData:ClearInvite(self.mGameInviteInfo.accountId)
			end

			_T.UserInvitePending = nil
			_T.UserInGameInvitePending = nil
		end,
		GameInviteReceivedCallback = function(self, p)
			if not __wf_atom_7e8ad928(_T.UserInvitePending) or __wf_atom_7e8ad928(mMovie) then
				return
			end

			self:RefreshGameData()

			if __wf_atom_7e8ad928(gGameData) then
				print("Ignoring invitation; no game data")
				return
			end

			local __wf_atom_367d3242 = gGameData:__wf_atom_367d3242()
			local __wf_atom_d417dc97 = gGameData:__wf_atom_d417dc97(p)

			if __wf_atom_367d3242 == 2 then
				print("Ignoring invitation; INVITE_MODE_NONE")
				gMatchingService:__wf_atom_c415a49f(p, __wf_atom_d417dc97.bindingServerId, 2)
				gGameData:ClearInvite(p)
			elseif __wf_atom_367d3242 == 1 and not gGameData:__wf_atom_139834cf(p) then
				print("Ignoring invitation; INVITE_MODE_FRIENDS")
				gMatchingService:__wf_atom_c415a49f(p, __wf_atom_d417dc97.bindingServerId, 2)
				gGameData:ClearInvite(p)
			else
				if not __wf_atom_d417dc97.playerName then
					self.mGameInviteInfo = nil
					return
				end

				self.mGameInviteInfo = __wf_atom_d417dc97

				if gGameData:__wf_atom_56f280e3(__wf_atom_d417dc97.playerName) then
					print("Ignoring invitation; " .. __wf_atom_d417dc97.playerName .. " is being ignored")
					gMatchingService:__wf_atom_c415a49f(p, __wf_atom_d417dc97.bindingServerId, 2)
					gGameData:ClearInvite(p)
				else
					local squadPlayers = self:GetSquadPlayers()
					local userInvitePending = module2.GetCrossPlatformUniquePlayerName(
						__wf_atom_d417dc97.playerName,
						squadPlayers,
						"name"
					) .. " " .. Localize("/Lotus/Language/Menu/GameInviteRequest", nil)

					if _G.mDoNotDisturb then
						self:ClearInvite(false, 5)
						self:CheckForInvites()
					else
						module5.PlaySound(_G.UISound_SweetenerOne)

						if not __wf_atom_7e8ad928(_T.ShowNotification) then
							_T.ShowNotification(userInvitePending, "SquadMemberInvited")
						end

						local uiMode = module3.GetUIMode()

						if
							uiMode == module3.UI_MODE_IN_SPACE_SHIP
							or uiMode == module3.UI_MODE_IN_SPACE_HUB
							or uiMode == module3.UI_MODE_IN_DOJO
						then
							if
								__wf_atom_72884638("Debug.Multiplayer.AutoAcceptInvites")
								and _T.AcceptInvitePanel ~= nil
							then
								_T.AcceptInvitePanel:Execute("OnAccept", "")
							else
								_T.UserInvitePending = userInvitePending
							end
						else
							_T.UserInvitePending = userInvitePending .. "\r\n\r\n" .. mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Labels/PendingInGameInvite",
								false
							)
							_T.UserInGameInvitePending = true
						end
					end
				end
			end
		end,
		CancelTrade = function(self)
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if gGameRules:__wf_atom_af3bd666() then
				gGameRules:__wf_atom_f996d5df()
				local __wf_atom_c88ae023 = gGameRules:__wf_atom_c88ae023()

				if not __wf_atom_7e8ad928(__wf_atom_c88ae023) then
					__wf_atom_c88ae023:CancelTrade(false)
				end
			end

			if
				not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
				and (__wf_atom_c4f78a8f:__wf_atom_9cc7b1b4() or __wf_atom_c4f78a8f:__wf_atom_7b686578())
			then
				__wf_atom_c4f78a8f:__wf_atom_d02c2c68(false)
				__wf_atom_c4f78a8f:__wf_atom_014225b8(false)
				gGameRules:OnAvatarTradeStatusChanged(__wf_atom_c4f78a8f)
				local v2 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
				gGameRules:SendControlMessage(v2)
			end
		end,
		RefreshConfig = function(self)
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local settings = __wf_atom_18a5d83b:Settings()

				if not __wf_atom_7e8ad928(settings) then
					self.mVoipEnabled = settings:__wf_atom_d6069beb()
				end
			end
		end,
		RefreshGameData = function(self)
			if not _T.gActiveMatchMakingMode then
				_T.gActiveMatchMakingMode = _T.MATCHMAKING_QUICKMATCH_GAMEMODE
			end

			if __wf_atom_7e8ad928(gGameData) then
				self.mNeedsInit = true
				return
			end

			if not self.mNeedsInit then
				return
			end

			self.mNeedsInit = false
			_T.gActiveMatchMakingMode = gGameData:__wf_atom_bdcb3fb9()
			__wf_atom_55142dd4(gGameData, "OnProfileSaved")
			self:RefreshConfig()
			gGameData:__wf_atom_82f3800f("GameInviteReceivedCallback")
			self:CheckForInvites()
			gMatchingService:__wf_atom_a55a86f9("OnSquadMemberJoined")
			gMatchingService:__wf_atom_f008492e(Symbol("SquadOverlay"), "OnSquadMemberLeft")
			gMatchingService:__wf_atom_e6083394(Symbol("SquadOverlay"), "OnSquadLoadoutChanged")
		end,
		ConfirmJoinExtraCondition = function(self, p)
			print("ConfirmJoinExtraCondition(" .. tostring(p) .. ")")

			if tonumber(p) == 4 then
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
				self.mPendingJoinSession = self.mExtraConfirmationSessionToJoin
				self.mJoiningSessionOnInvite = true
			end
		end,
		OnFindInvitedSessionComplete = function(self, p)
			if __wf_atom_7e8ad928(self.mGameInviteInfo) or __wf_atom_7e8ad928(self.mGameInviteInfo.session) then
				self:ClearInvite()
				return
			end

			local session = self.mGameInviteInfo.session
			local v2, v3 = module4.CheckSingleSessionResults(
				p,
				true,
				session.teamId,
				nil,
				mMovie,
				"OnFindInvitedSessionComplete"
			)

			if type(v2) == "string" then
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

				if v2 == "" then
					self:ClearInvite(false, 3)
					return
				end

				if v3 then
					module.ShowMissionRequirementsError(v3)
				else
					module5.ShowMessage(v2)
				end

				self:ClearInvite()
			else
				if v2:__wf_atom_855a3505() == session.id then
					print("System invite matching game invite, clearing")
					self:ClearInvite(true)
				end

				local latency = v2:Latency()
				local __wf_atom_517d18d6 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings():__wf_atom_517d18d6()
				print("Ping: " .. tostring(latency) .. " - max: " .. tostring(__wf_atom_517d18d6))
				v2:__wf_atom_366d49f7()

				if __wf_atom_517d18d6 < latency then
					_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
					self.mExtraConfirmationSessionToJoin = v2
					module5.ShowConfirmMessage(
						mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ConfirmJoinHighPing", false, {
							PING = latency
						}),
						"ConfirmJoinExtraCondition"
					)
					self:ClearInvite(true)
				else
					self.mPendingJoinSession = v2
					self.mJoiningSessionOnInvite = true
				end
			end
		end,
		DoFindInvitedSession = function(self)
			if __wf_atom_7e8ad928(gGameData) then
				return
			end

			local mGameInviteInfo = self.mGameInviteInfo
			local session = mGameInviteInfo.session

			if mGameInviteInfo.playerName and mGameInviteInfo.accountId and session.id then
				if self.mJoinDelay > 0 then
					self.mJoinDelay -= __wf_atom_fa1258d0()

					if self.mJoinDelay < 0 then
						self.mJoinDelay = 0
					end
				elseif module4.InSession() then
					print("DoFindInvitedSession")
					self:LeaveSquad()
					self.mJoinDelay = 1
				else
					local sessionSearch = Engine.SessionSearch()

					if gMatchingService:__wf_atom_c5171bd3() then
						sessionSearch.matchType = 0
					else
						sessionSearch.matchType = 2
					end

					sessionSearch.sessionId = session.id
					sessionSearch.ignoreBadReputation = true
					local v2 = session.strictNAT == "" and "" or " (StrictNAT: " .. session.strictNAT .. ")"
					local v3 = mGameInviteInfo.accountId == session.hostAccountId and ""
						or " hosted by " .. session.hostAccountId
					local v4 = session.teamId == 255 and "" or " team: " .. session.teamId
					print("Accepting invitation to join " .. mGameInviteInfo.playerName .. " in " .. session.id .. " (mode: " .. session.gameModeId .. v4 .. ")" .. v3 .. v2)
					local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
					gMatchingService:FindSessions(__wf_atom_18a5d83b, sessionSearch, "OnFindInvitedSessionComplete")
					self.mFindInvitedSessionQueued = false
				end
			else
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
				module5.ShowMessage("/Lotus/Language/Menu/SocialOverlay_SessionExpired")
				self:ClearInvite()
			end
		end,
		GetPlayerTeamId = function(self)
			if self.mGameInviteInfo == nil then
				return 255
			end

			return self.mGameInviteInfo.session.teamId
		end,
		OnJoinLobbyComplete = function(self, p)
			print("SquadOverlay.lua - OnJoinLobbyComplete(" .. tostring(p) .. ")")
			self.mJoinOperationInProgress = false
			local mJoiningSessionOnInvite = self.mJoiningSessionOnInvite
			self.mJoiningSessionOnInvite = false

			if mJoiningSessionOnInvite then
				gMatchingService:__wf_atom_7027399a(2)
			else
				gMatchingService:__wf_atom_7027399a(0)
			end

			if p then
				self.mPendingLobbyJoinTimer = 0.3

				if mJoiningSessionOnInvite then
					local __wf_atom_6c164199 = gMatchingService:__wf_atom_15811761():__wf_atom_6c164199()
					gMatchingService:__wf_atom_8b36b57b(__wf_atom_6c164199)
				end

				if _T.EtherealHubActive and gGameRules:IsA(__wf_atom_589d05aa) then
					gGameRules:__wf_atom_94b3a9e1(true)
				end
			else
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
				local __wf_atom_91952c92 = gMatchingService:__wf_atom_91952c92()
				local v2 = __wf_atom_91952c92 == "" and "/Lotus/Language/Menu/SocialOverlay_SessionJoinFail"
					or __wf_atom_91952c92
				module5.ShowMessage(v2)
			end
		end,
		CheckSessionUpdate = function(self)
			local isBlockingTaskPending = gMatchingService:IsBlockingTaskPending()

			if self.mFindInvitedSessionQueued and not isBlockingTaskPending then
				self:DoFindInvitedSession()
			elseif __wf_atom_7e8ad928(self.mPendingJoinSession) or isBlockingTaskPending then
				if self.mPendingLobbyJoinTimer > 0 and not __wf_atom_7e8ad928(_T.BackgroundMovie) then
					if __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) then
						_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
						self.mPendingLobbyJoinTimer = -1
					elseif not isBlockingTaskPending then
						self.mPendingLobbyJoinTimer -= __wf_atom_fa1258d0()

						if self.mPendingLobbyJoinTimer < 0 then
							_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
							self.mPendingLobbyJoinTimer = -1
						end
					end
				end
			else
				print("SquadOverlay.lua - JoinSquadSession")
				self:CancelTrade()
				self.mJoinOperationInProgress = true
				local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
				gMatchingService:JoinSquadSession(
					__wf_atom_18a5d83b,
					self.mPendingJoinSession,
					false,
					self:GetPlayerTeamId(),
					"OnJoinLobbyComplete"
				)
				self.mPendingJoinSession = nil
				self.mGameInviteInfo = nil
			end
		end,
		Update = function(self, p)
			if not __wf_atom_7e8ad928(gMatchingService) then
				self.mNumSquadMembers = gMatchingService:__wf_atom_8b3e33a6()
			end

			self:RefreshGameData()
			self:UpdateVisibility()
			self:CheckSessionUpdate()

			for k, v2 in self.mPlayerInfo do
				self:UpdateSquadPlayer(v2.mPlayer, k, false)
			end

			if self.mNumCachedPlayers ~= self.mNumSquadMembers then
				self.mCachedPlayers = nil
				p = true
			end

			local mHasSession2 = not (__wf_atom_7e8ad928(gMatchingService) or __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()))
			local mHasSession = not mHasSession2 and self.mHasSession
			self.mHasSession = mHasSession2

			if p or mHasSession then
				state.PlayersChanged()

				if self.mCachedPlayers == nil then
					self:GetSquadPlayers()
				end
			end
		end
	}

	function state:OnJoinLobbyComplete()
		v2:OnJoinLobbyComplete(self)
	end

	function state:OnHostSessionFromInviteFriend()
		v2:OnHostSessionFromInviteFriend(self)
	end

	function state:OnFindInvitedSessionComplete()
		v2:OnFindInvitedSessionComplete(self)
	end

	function state:GameInviteReceivedCallback()
		v2:GameInviteReceivedCallback(self)
	end

	function state:ConfirmJoinExtraCondition()
		v2:ConfirmJoinExtraCondition(self)
	end

	function state:JoinInviteConfirm()
		v2:JoinInviteConfirm(self)
	end

	function state:OnSquadMemberJoined()
		v2:OnSquadMemberJoined(self)
	end

	function state:OnSquadMemberLeft()
		v2:OnSquadMemberLeft(self)
	end

	function state.OnLeaveSquadDone()
		v2:OnLeaveSquadDone()
	end

	function state.OnProfileSaved()
		v2:RefreshConfig()
	end

	return v2
end