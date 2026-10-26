module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CrossPlatformUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local v = Symbol("SpeechEmissive")
local v2 = Symbol("offsetAmount")
local TransmissionUtilities = {}
TransmissionUtilities.mCachedRegion = nil
TransmissionUtilities.mZoomer = 1
TransmissionUtilities.mScale = 1
TransmissionUtilities.mAnimateMouth = true
TransmissionUtilities.mSmoothHead = nil
TransmissionUtilities.mSmoothAmp = __wf_atom_10cd16b2(0, 0.1)
TransmissionUtilities.mSmoothAmpQuick = __wf_atom_10cd16b2(0, 0.02)
TransmissionUtilities.mSkeletalMeshType = WeakResource("/EE/Types/GraphicsRes/SkeletalMesh")
TransmissionUtilities.mLastLevel = nil
TransmissionUtilities.mTrackDelay = 1
TransmissionUtilities.mCurrentLocTag = nil
TransmissionUtilities.mMouthRotation = Rotation()
TransmissionUtilities.mMouth = {
	{ Symbol("GAME_C1_JAWBONE1"), 1, 0 },
	{ Symbol("GAME_L1_LIPU1"), -0.75, 0 },
	{ Symbol("GAME_C1_LIPU1"), -1.125, 0 },
	{ Symbol("GAME_R1_LIPU1"), -0.75, 0 },
	{ Symbol("GAME_L1_LIPD1"), 1.5, 0 },
	{ Symbol("GAME_C1_LIPD1"), 2.25, 0 },
	{ Symbol("GAME_R1_LIPD1"), 1.5, 0 }
}
TransmissionUtilities.NECK_BONE = Symbol("GAME_C1_HEAD1")
TransmissionUtilities.GAME_R1_EYE1 = Symbol("GAME_R1_EYE1")
TransmissionUtilities.GAME_L1_EYE1 = Symbol("GAME_L1_EYE1")
TransmissionUtilities.MORPH_NAME_OPEN = Symbol("Morphs.Open")
TransmissionUtilities.VOICE_TAG = Symbol("Voice")
TransmissionUtilities.CHATTER_TAG = Symbol("Chatter")
TransmissionUtilities.WAVEPARAMS = {
	Symbol("waveOne"),
	Symbol("waveTwo"),
	Symbol("waveThree"),
	Symbol("waveFour")
}
TransmissionUtilities.EMISSIVE_MAP_ATTEN = Symbol("EmissiveMapAtten")
TransmissionUtilities.WAVEVALUES = {
	2,
	0.25,
	0,
	0.6,
	4,
	0.12,
	0.3,
	-0.3,
	8,
	0.05,
	0.5,
	0.4,
	16,
	0.03,
	0.1,
	-0.3
}
TransmissionUtilities.CameraWaypointType = Resource("/Lotus/Interface/TransmissionCameraWaypoint")
TransmissionUtilities.mVisemeState = {}
TransmissionUtilities.mVisemeAnticipation = 0.1
TransmissionUtilities.mVisemeFadeIn = 0
TransmissionUtilities.mAmpScale = 1
TransmissionUtilities.mMorphHack = false
TransmissionUtilities.mJawPitch = 8
TransmissionUtilities.mLipPitch = 4
TransmissionUtilities.mNodAmount = 4
TransmissionUtilities.mHeadTurnAmount = 20
TransmissionUtilities.mCamFOV = 0
TransmissionUtilities.mMinFOV = 16
TransmissionUtilities.mMaxFOV = 21
TransmissionUtilities.mUseHeadTarget = true
TransmissionUtilities.mPlayVisemeOnDeco = false
TransmissionUtilities.mTrackCamera = true
TransmissionUtilities.mTrackCameraTag = nil
TransmissionUtilities.mEmissives = false
TransmissionUtilities.mEmissiveBase = 0.1
TransmissionUtilities.mPulseFlares = true
TransmissionUtilities.mHeadTrackBone = Symbol("GAME_C1_HEAD1")
TransmissionUtilities.mTrackSpeed = 2
TransmissionUtilities.mHeadOffset = Vector()
TransmissionUtilities.mUseSmoothAmp = false
TransmissionUtilities.mSpeakingTag = nil
TransmissionUtilities.mNodBasePitch = 0
TransmissionUtilities.mAvatarIndex = 1
TransmissionUtilities.mLastCamTag = nil
TransmissionUtilities.mEyeTracking = true
TransmissionUtilities.mPriorBlendInfos = {}
TransmissionUtilities.mBlendOut = 1
TransmissionUtilities.mTime = 0

function TransmissionUtilities:CalcLevelSpecificHacks(p, p2)
	self.TransmissionCameraOffset = nil
	self.TransmissionHeadingOffset = nil
	self.mForcedMaterialIndex = nil

	if __wf_atom_7e8ad928(p) or not __wf_atom_7e8ad928(p2) then
		return
	end

	self.mUseHeadTarget = false
	self.mEyeTracking = false
	self.mTrackCamera = false
	self.mHeadTurnAmount = 0
	self.mNodAmount = 0
	self.mMinFOV = 30
	self.mMaxFOV = 30
end

function TransmissionUtilities:FindAll(object, p)
	local all = object:FindAll(p)
	return all == nil and {} or all
end

function TransmissionUtilities:UpdateRegion(object, mCachedRegion, p, object2, mTrackCamera)
	if mCachedRegion ~= self.mCachedRegion then
		self.mSmoothHead = nil
		self.mTrackDelay = 1
		self.mVisemeState = {}
		self.mVisemeData = nil
		self.mPriorBlendInfos = {}
		self.mVisemeFadeIn = 0
		self.mBlendOut = 1
		self.mAllFlares = nil
		self.mAllDecos = nil
		self.mVoiceParticles = nil
		self.mChatterDeco = nil
		self.mAllCameraSpots = nil
		self.mCachedRegion = mCachedRegion
		self.mAnimateMouth = true
		self.mLastCamTag = nil

		if self.mSpeakingTag then
			_T[self.mSpeakingTag] = nil
		end

		self.mLastLevel = nil
	end

	if __wf_atom_7e8ad928(mCachedRegion) then
		if
			not __wf_atom_7e8ad928(object)
			and not __wf_atom_7e8ad928(_T.curTransmission)
			and _T.curTransmission:__wf_atom_e193a78e()
		then
			local __wf_atom_31aab74c = object:__wf_atom_31aab74c()
			_T.FullscreenOverlayTransmissionAmplitude = __wf_atom_31aab74c
		end
	else
		self.mCachedRegion = mCachedRegion
		local v3 = __wf_atom_084b3e93()
		self.mTime += v3
		local v4

		if __wf_atom_7e8ad928(object) or not self.mAnimateMouth then
			v4 = 0
		else
			v4 = object:__wf_atom_31aab74c()

			if object:__wf_atom_bda39a69() then
				self.mVisemeData = object:__wf_atom_61ea8025(self.mVisemeAnticipation)
			end
		end

		self.mSmoothAmp:__wf_atom_09294a87(v4)
		self.mSmoothAmpQuick:__wf_atom_09294a87(v4)
		self.mSmoothAmp:Update(v3)
		self.mSmoothAmpQuick:Update(v3)
		local v5 = nil
		local __wf_atom_22941262 = mCachedRegion:__wf_atom_22941262()

		if __wf_atom_22941262 ~= self.mLastLevel then
			self.mMouth = {
				{ Symbol("GAME_C1_JAWBONE1"), 1, 0 },
				{ Symbol("GAME_L1_LIPU1"), -0.75, 0 },
				{ Symbol("GAME_C1_LIPU1"), -0.75, 0 },
				{ Symbol("GAME_R1_LIPU1"), -0.75, 0 },
				{ Symbol("GAME_L1_LIPD1"), 1.5, 0 },
				{ Symbol("GAME_C1_LIPD1"), 2.25, 0 },
				{ Symbol("GAME_R1_LIPD1"), 1.5, 0 }
			}
			self.mSmoothAmp:__wf_atom_4453e49c(0)
			self.mSmoothAmpQuick:__wf_atom_4453e49c(0)
			self.mLastLevel = __wf_atom_22941262
			self.mVisemeState = {}
			self.mAllFlares = nil
			self.mAllDecos = nil
			self.mVoiceParticles = nil
			self.mChatterDeco = nil
			self.mAllCameraSpots = nil
			self.mAmpScale = 1
			self.mMorphHack = false
			self.mJawPitch = 8
			self.mLipPitch = 4
			self.mNodAmount = 4
			self.mHeadTurnAmount = 20
			self.mCamFOV = 0
			self.mMinFOV = 16
			self.mMaxFOV = 21
			self.mUseHeadTarget = true
			self.mPlayVisemeOnDeco = false
			self.mTrackCamera = true
			self.mTrackCameraTag = nil
			self.mEmissives = false
			self.mPulseFlares = true
			self.mHeadTrackBone = self.NECK_BONE
			self.mTrackSpeed = 2
			self.mHeadOffset = Vector()
			self.mUseSmoothAmp = false
			self.mSpeakingTag = nil
			self.mNodBasePitch = 0
			self.mAvatarIndex = 1
			self.mLastCamTag = nil
			self.mEyeTracking = true
			self.mPriorBlendInfos = {}
			self.mBlendOut = 1
			self:CalcLevelSpecificHacks(__wf_atom_22941262, object2)
		end

		if self.mTrackDelay > 0 then
			self.mTrackDelay -= 1
			mTrackCamera = false
		end

		if self.mUseSmoothAmp then
			v4 = __wf_atom_104bfe98(v4, self.mSmoothAmp:__wf_atom_9e368823(), 1)
		end

		if self.mSpeakingTag then
			_T[self.mSpeakingTag] = v4
		end

		if mTrackCamera == nil then
			mTrackCamera = self.mTrackCamera
		end

		if p then
			self.mMinFOV = self.mMaxFOV
		end

		local v6 = __wf_atom_104bfe98(v4, self.mSmoothAmp:__wf_atom_9e368823(), 1)
		local v7 = Noise(self.mTime * 0.05)
		local v8 = __wf_atom_a3cc989c(self.mTime * 0.3)

		if __wf_atom_7e8ad928(object2) and self.mPulseFlares then
			if not self.mAllFlares then
				self.mAllFlares = self:FindAll(mCachedRegion, __wf_atom_fac7b40a)
			end

			if #self.mAllFlares > 0 then
				local v9 = math.min(1, v6 * 0.5 + 0.5)

				for i = 1, #self.mAllFlares do
					if __wf_atom_7e8ad928(self.mAllFlares[i]) then
						continue
					end

					if self.mAllFlares[i]:HasTag(self.VOICE_TAG) then
						self.mAllFlares[i]:__wf_atom_008aae7f(v6 * v6)
					else
						self.mAllFlares[i]:__wf_atom_008aae7f(v9)
					end
				end
			end
		end

		local v9 = false

		if self.mAllDecos and #self.mAllDecos ~= 0 then
			if not __wf_atom_7e8ad928(object2) then
				v9 = true
			end
		else
			if __wf_atom_7e8ad928(object2) then
				self.mAllDecos = self:FindAll(mCachedRegion, __wf_atom_8d0b7f88)
			else
				if p then
					self.mAllDecos = {}
				else
					self.mAllDecos = self:FindAll(mCachedRegion, __wf_atom_8d0b7f88)
				end

				if not table.find(self.mAllDecos, object2) then
					table.insert(self.mAllDecos, object2)
				end
			end

			for i = 1, #self.mAllDecos do
				local mAllDeco = self.mAllDecos[i]
				local __wf_atom_b6b760b5 = mAllDeco:__wf_atom_b6b760b5()
				self.mAllDecos[i] = {
					deco = mAllDeco,
					isRootSkeletal = not __wf_atom_7e8ad928(__wf_atom_b6b760b5) and __wf_atom_b6b760b5:IsA(self.mSkeletalMeshType) and __wf_atom_7e8ad928(mAllDeco:__wf_atom_3d96ddcd())
				}
			end
		end

		for i = 1, #self.mAllDecos do
			local mAllDeco = self.mAllDecos[i]
			local deco = mAllDeco.deco

			if v9 and object2 == deco then
				v9 = false
			end

			if
				self.mTaggedActors
				and not __wf_atom_7e8ad928(_T.curTransmission)
				and mAllDeco.isRootSkeletal
				and not (__wf_atom_7e8ad928(deco) or deco:HasTag(_T.curTransmission:__wf_atom_cefccdc5()))
			then
				deco = nil
			end

			if not __wf_atom_7e8ad928(deco) then
				if mAllDeco.isRootSkeletal then
					if self.mVisemeData and deco:__wf_atom_b8f1de8f() and self.mAnimateMouth then
						self:UpdateVisemeState(deco, self.mVisemeData, v6, object, mCachedRegion, object2)
					elseif self.mAnimateMouth then
						if self.mMorphHack then
							local v10 = __wf_atom_104bfe98(v6, v4, (math.pow(v8, 0.25)))
							deco:__wf_atom_f3f3bb0e(self.MORPH_NAME_OPEN, v10 * 0.3)
						end

						for j = 1, #self.mMouth do
							local v10

							if j == 1 then
								v10 = v6 * self.mJawPitch * __wf_atom_104bfe98(1, 2, v8)
							else
								v10 = (self.mSmoothAmp:__wf_atom_9e368823() * 2 - 1) * v6 * self.mLipPitch * __wf_atom_104bfe98(1, 2, v8)
							end

							self.mMouthRotation.pitch = v10 * self.mMouth[j][2] * __wf_atom_104bfe98(1, 0.5 + v8 * 3, self.mMouth[j][3])
							deco:__wf_atom_2f0092a2(self.mMouth[j][1], self.mMouthRotation)
						end
					end

					if mTrackCamera then
						local __wf_atom_9e368823 = self.mSmoothAmp:__wf_atom_9e368823()
						local v10 = __wf_atom_9e368823 * __wf_atom_9e368823 * 2 - 1
						local v11 = Rotation(
							v7 * self.mHeadTurnAmount,
							v10 * v8 * self.mNodAmount + self.mNodBasePitch,
							v7 * -10
						)
						deco:__wf_atom_2f0092a2(self.NECK_BONE, v11)

						if self.mUseHeadTarget and i == self.mAvatarIndex then
							v5 = deco:__wf_atom_1c374cc9(self.mHeadTrackBone) + self.mHeadOffset
						end
					end
				end

				if self.mEmissives and (i == self.mAvatarIndex or deco:HasTag(v)) then
					local v10 = v4 * v4
					local v11 = __wf_atom_104bfe98(self.mEmissiveBase, 6, v10)
					deco:SetMaterialParam(self.EMISSIVE_MAP_ATTEN, v11, 0, 0, 0, true)
				end
			end

			if i == #self.mAllDecos and v9 then
				local __wf_atom_b6b760b5 = object2:__wf_atom_b6b760b5()
				local v10 = {
					deco = object2,
					isRootSkeletal = not __wf_atom_7e8ad928(__wf_atom_b6b760b5) and __wf_atom_b6b760b5:IsA(self.mSkeletalMeshType) and __wf_atom_7e8ad928(object2:__wf_atom_3d96ddcd())
				}
				table.insert(self.mAllDecos, v10)
				v9 = false
			end

			__wf_atom_83c14687(0)
		end

		if not p then
			if self.mVoiceParticles == nil then
				self.mVoiceParticles = mCachedRegion:__wf_atom_2226b35c(self.VOICE_TAG)

				if self.mVoiceParticles == nil then
					self.mVoiceParticles = {}
				else
					for i = #self.mVoiceParticles, 1, -1 do
						if not self.mVoiceParticles[i]:IsA(__wf_atom_8939e086) then
							table.remove(self.mVoiceParticles, i)
						end
					end
				end
			end

			for i = 1, #self.mVoiceParticles do
				if __wf_atom_7e8ad928(self.mVoiceParticles[i]) then
					continue
				end

				local v10 = not (self.mSmoothAmp:__wf_atom_9e368823() > 0.15) and 0 or __wf_atom_104bfe98(0, 20, v6)
				self.mVoiceParticles[i]:__wf_atom_2f54f673(v10, v10, false)
			end
		end

		if not self.mChatterDeco then
			self.mChatterDeco = mCachedRegion:__wf_atom_2226b35c(self.CHATTER_TAG)
		end

		if #self.mChatterDeco > 0 then
			for i = 1, #self.mChatterDeco do
				local v10 = self.mChatterDeco[i]

				if __wf_atom_7e8ad928(v10) then
					continue
				end

				v10:SetMaterialParam(SF.__wf_atom_f35beb09, v6 * 4 + 0.5)
				v10:SetMaterialParam(v2, v6 * 0.04)

				for j = 1, #self.WAVEPARAMS do
					local v11 = (j - 1) * 4
					local v12 = __wf_atom_421b01aa(4 * __wf_atom_a3cc989c(j * __wf_atom_4658d645(self.mTime)), 0.5, 1)
					v10:SetMaterialParam(
						self.WAVEPARAMS[j],
						self.WAVEVALUES[v11 + 1],
						v12 * math.min(1, v6) * self.WAVEVALUES[v11 + 2],
						v12 * 12 + self.WAVEVALUES[v11 + 3],
						self.WAVEVALUES[v11 + 4]
					)
				end
			end
		end

		if not self.mAllCameraSpots then
			self.mAllCameraSpots = self:FindAll(mCachedRegion, __wf_atom_7369b1a2)

			if mCachedRegion ~= gRegion and self.TransmissionCameraOffset ~= nil then
				for _, mAllCameraSpot in ipairs(self.mAllCameraSpots) do
					if not __wf_atom_7e8ad928(mAllCameraSpot:__wf_atom_bb3e7833(self.CameraWaypointType)) then
						continue
					end

					local __wf_atom_dc309f8a = mAllCameraSpot:__wf_atom_dc309f8a()

					if self.TransmissionHeadingOffset ~= nil then
						__wf_atom_dc309f8a.heading += self.TransmissionHeadingOffset
					end

					mAllCameraSpot:Teleport(
						mAllCameraSpot:GetPosition() + self.TransmissionCameraOffset,
						__wf_atom_dc309f8a
					)
					mAllCameraSpot:Attach(self.CameraWaypointType, EMPTY_SYMBOL)
				end
			end
		end

		if
			self.mTrackCamera
			and mTrackCamera
			and __wf_atom_7e8ad928(object2)
			and not _T.DisableCameraTracking
			and #self.mAllCameraSpots > 0
			and not __wf_atom_7e8ad928(self.mAllCameraSpots[1])
		then
			local v10 = __wf_atom_482dad48(2, 1, self.mTime * 0.05, __wf_atom_4658d645(self.mTime * 0.1)) * 3
			self.mZoomer = __wf_atom_421b01aa(self.mZoomer + v10 * __wf_atom_084b3e93(), 0, 1)
			local v11 = __wf_atom_104bfe98(self.mMinFOV, self.mMaxFOV, __wf_atom_24a82b69(self.mZoomer))
			self.mAllCameraSpots[1]:__wf_atom_888efbe9(v11)

			if v5 and self.mUseHeadTarget then
				v5.y -= 0.05

				if not self.mSmoothHead then
					self.mSmoothHead = Vector(v5.x, v5.y, v5.z)
				end

				self.mSmoothHead = __wf_atom_f55d6358(self.mSmoothHead, v5, __wf_atom_084b3e93() * self.mTrackSpeed)
				local v12 = __wf_atom_fa8d0177(self.mAllCameraSpots[1]:GetPosition(), self.mSmoothHead)
				v12.heading = v12.heading + self.mScale * 2 + module.Ternary(
					self.TransmissionHeadingOffset ~= nil,
					self.TransmissionHeadingOffset,
					0
				)
				self.mAllCameraSpots[1]:__wf_atom_9b788a35(v12)
			end
		end

		if self.mTrackCameraTag and not __wf_atom_7e8ad928(_T.curTransmission) then
			if not self.mAllCameraSpots then
				self.mAllCameraSpots = self:FindAll(mCachedRegion, __wf_atom_7369b1a2)
			end

			local __wf_atom_db682341 = _T.curTransmission:__wf_atom_db682341()

			if __wf_atom_db682341 ~= self.mLastCamTag then
				self.mLastCamTag = __wf_atom_db682341

				for i = 1, #self.mAllCameraSpots do
					if self.mAllCameraSpots[i]:HasTag(__wf_atom_db682341) then
						self.mAllCameraSpots[i]:Activate()
					else
						self.mAllCameraSpots[i]:Deactivate()
					end
				end
			end
		end
	end
end

TransmissionUtilities.mPhonemeToVisemeName = {
	"VIS_SILENCE",
	"VIS_AA",
	"VIS_EY_EH_UH",
	"VIS_H",
	"VIS_AO",
	"VIS_AW",
	"VIS_AY",
	"VIS_SH_CH_JH_SZ",
	"VIS_K_G_NG",
	"VIS_EY_EH_UH",
	"VIS_R",
	"VIS_EY_EH_UH",
	"VIS_AY",
	"VIS_Y_IY_IH_IX",
	"VIS_K_G_NG",
	"VIS_AW",
	"VIS_OY",
	"VIS_SH_CH_JH_SZ",
	"VIS_K_G_NG",
	"VIS_OY",
	"VIS_OY",
	"VIS_SH_CH_JH_SZ",
	"VIS_P_B_M",
	"VIS_K_G_NG",
	"VIS_F_V",
	"VIS_K_G_NG",
	"VIS_H",
	"VIS_SH_CH_JH_SZ",
	"VIS_K_G_NG",
	"VIS_L",
	"VIS_P_B_M",
	"VIS_K_G_NG",
	"VIS_P_B_M",
	"VIS_R",
	"VIS_K_G_NG",
	"VIS_K_G_NG",
	"VIS_F_V",
	"VIS_W_UW",
	"VIS_Y_IY_IH_IX",
	"VIS_K_G_NG"
}

function TransmissionUtilities.PhonemeToViseme(p, p2)
	return p.mPhonemeToVisemeName[p2 + 1]
end

function TransmissionUtilities.FadeVisemes(state, object)
	state.mBlendOut = math.max(0, state.mBlendOut - __wf_atom_084b3e93() * 4)
	local v3 = math.pow(state.mBlendOut, 3)
	local total = 1
	local v4 = 12

	for _ = 1, #state.mPriorBlendInfos / 2 do
		object:__wf_atom_6e6edf68(state.mPriorBlendInfos[total], v4, state.mPriorBlendInfos[total + 1] * v3)
		v4 += 1
		total += 2
	end
end

function TransmissionUtilities:UpdateVisemeState(instance, list, _, object, _, p)
	local v3 = list[3]

	if instance:IsA(__wf_atom_b39fdada) then
		return
	end

	if self.mPlayVisemeOnDeco then
		instance:__wf_atom_f7e4d343(object)
		return
	end

	local v4 = list[1] == list[2] and 0 or v3
	local v5 = instance:IsA(__wf_atom_b39fdada) or instance:IsA(__wf_atom_67c46eba)

	if not v5 then
		local v6 = nil

		if __wf_atom_7e8ad928(p) and #self.mAllCameraSpots > 0 then
			v6 = self.mAllCameraSpots[1]
		end

		if not __wf_atom_7e8ad928(v6) and self.mEyeTracking then
			local position = v6:GetPosition()
			local __wf_atom_1c374cc9 = instance:__wf_atom_1c374cc9(self.NECK_BONE)
			local v7 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, position)
			instance:__wf_atom_5372d35c(self.GAME_R1_EYE1, v7)
			instance:__wf_atom_5372d35c(self.GAME_L1_EYE1, v7)
		end

		if not self.mVisemeState.Blink then
			self.mVisemeState.Blink = math.random(2, 7)
		end

		local blink = self.mVisemeState.Blink - __wf_atom_084b3e93()

		if blink < 0.2 then
			local v7 = 1 - math.abs(__wf_atom_421b01aa(blink / 0.2, 0, 1) * 2 - 1)
			instance:__wf_atom_6e6edf68(100, 1, __wf_atom_24a82b69(v7))
		end

		if blink <= 0 then
			blink = math.random(2, 7)
		end

		self.mVisemeState.Blink = blink
	end

	if v5 then
		instance:__wf_atom_f7e4d343(nil)
		v5 = false
	end

	if v5 then
		return
	end

	local v6 = 12
	self.mVisemeFadeIn = __wf_atom_421b01aa(self.mVisemeFadeIn + __wf_atom_084b3e93() * 4, 0, 1)

	if __wf_atom_7e8ad928(object) or not object:__wf_atom_f9e5bbc0() then
		if __wf_atom_7e8ad928(instance:__wf_atom_d5dd43f6()) then
			if self.mPriorBlendInfos and self.mPriorBlendInfos[1] ~= nil then
				self.FadeVisemes(self, instance)
				return
			end

			instance:__wf_atom_6e6edf68(list[1], 22, 1 - v4)
			instance:__wf_atom_6e6edf68(list[2], 23, v4)
		else
			self.FadeVisemes(self, instance)
		end
	else
		local __wf_atom_49b6ca2f = object:__wf_atom_49b6ca2f(self.mVisemeAnticipation)
		local total = 1

		if #__wf_atom_49b6ca2f == 0 then
			self.FadeVisemes(self, instance)
			return
		end

		self.mPriorBlendInfos = __wf_atom_49b6ca2f
		local v7 = __wf_atom_24a82b69(self.mVisemeFadeIn)

		while total < #__wf_atom_49b6ca2f do
			local v8 = __wf_atom_49b6ca2f[total + 1] * v7
			instance:__wf_atom_6e6edf68(__wf_atom_49b6ca2f[total], v6, v8)
			total += 2
			v6 += 1
		end

		while v6 < 30 do
			instance:__wf_atom_6e6edf68(0, v6, 0)
			v6 += 1
		end
	end
end

TransmissionUtilities.mRandomWeaponIdx = { 1, 2, 3 }

function TransmissionUtilities:GetPlayerWeapon(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return nil
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local v3 = self.mRandomWeaponIdx[0]

	if v3 == 1 then
		return (__wf_atom_d2b2176d:__wf_atom_9fb9a1d6())
	elseif v3 == 2 then
		return (__wf_atom_d2b2176d:__wf_atom_28224c27(0))
	end

	return (__wf_atom_d2b2176d:__wf_atom_28224c27(1))
end

function TransmissionUtilities:SatisfyArg(p)
	if p == "ENEMY_NAME" then
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
		return Localize(__wf_atom_72fc675e.uniqueName, false)
	elseif p == "ENEMY_WEAPON" then
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
		return Resource(__wf_atom_72fc675e.vipAgent):__wf_atom_cd832b8c()
	end

	if p == "PLAYER_NAME" then
		if
			__wf_atom_7e8ad928(self.mPlayerAvatars[1])
			or __wf_atom_7e8ad928(self.mPlayerAvatars[1]:__wf_atom_a96eb2aa())
		then
			return nil
		end

		return module2.GetCrossPlatformUniquePlayerName(
			self.mPlayerAvatars[1]:__wf_atom_a96eb2aa():__wf_atom_6be84646(),
			gRegion:__wf_atom_3c8e1a7a(),
			nil,
			true
		)
	elseif p == "PLAYER_NAMEB" then
		if self.mPlayerAvatars[2] == nil or __wf_atom_7e8ad928(self.mPlayerAvatars[2]:__wf_atom_a96eb2aa()) then
			return nil
		end

		return module2.GetCrossPlatformUniquePlayerName(
			self.mPlayerAvatars[2]:__wf_atom_a96eb2aa():__wf_atom_6be84646(),
			gRegion:__wf_atom_3c8e1a7a(),
			nil,
			true
		)
	elseif p == "LOCAL_PLAYER_NAME" then
		if _G.StalkerMode then
			return "Tenno"
		end

		local __wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()

		if __wf_atom_7e8ad928(__wf_atom_e23b2855) or not (#__wf_atom_e23b2855 > 0) then
			return Localize("/Lotus/Language/Menu/Codex_Tenno", false)
		end

		return Engine.__wf_atom_746f9d1b(__wf_atom_e23b2855[1]:__wf_atom_6be84646())
	elseif p == "PLAYER_WEAPON" then
		local playerWeapon = self:GetPlayerWeapon(self.mPlayerAvatars[1])

		if __wf_atom_7e8ad928(playerWeapon) then
			return nil
		end

		local __wf_atom_014a76a2 = playerWeapon:__wf_atom_014a76a2()
		return __wf_atom_8e4fda44:__wf_atom_74e80bd6(__wf_atom_014a76a2)
	elseif p == "PLAYER_WEAPON_RANK" then
		local playerWeapon = self:GetPlayerWeapon(self.mPlayerAvatars[1])

		if __wf_atom_7e8ad928(playerWeapon) then
			return nil
		end

		return (tostring(playerWeapon:__wf_atom_22941262()))
	elseif p == "PLAYER_WEAPON_MODCOUNT" then
		if __wf_atom_7e8ad928((self:GetPlayerWeapon(self.mPlayerAvatars[1]))) then
		end

		return nil
	elseif p == "CLAN_NAME" then
		if module.IsUGCRestricted() then
			return nil
		end

		for i = 1, #self.mPlayerAvatars do
			if
				__wf_atom_7e8ad928(self.mPlayerAvatars[i])
				or __wf_atom_7e8ad928(self.mPlayerAvatars[i]:__wf_atom_a96eb2aa())
			then
				continue
			end

			local __wf_atom_7933a10d = self.mPlayerAvatars[i]:__wf_atom_a96eb2aa():__wf_atom_7933a10d()

			if __wf_atom_7933a10d ~= "" then
				return __wf_atom_7933a10d
			end
		end

		return nil
	elseif p == "CLAN_NAMEB" then
		local v3 = ""

		if module.IsUGCRestricted() then
			return nil
		end

		for i = 1, #self.mPlayerAvatars do
			if
				__wf_atom_7e8ad928(self.mPlayerAvatars[i])
				or __wf_atom_7e8ad928(self.mPlayerAvatars[i]:__wf_atom_a96eb2aa())
			then
				continue
			end

			local __wf_atom_7933a10d = self.mPlayerAvatars[i]:__wf_atom_a96eb2aa():__wf_atom_7933a10d()

			if v3 == "" and __wf_atom_7933a10d ~= "" then
				v3 = __wf_atom_7933a10d
			elseif v3 ~= "" and __wf_atom_7933a10d ~= "" then
				return __wf_atom_7933a10d
			end
		end

		return nil
	else
		if p == "PLAYER_WARFRAME" then
			local mPlayerAvatar = self.mPlayerAvatars[1]

			if not (__wf_atom_7e8ad928(mPlayerAvatar) or mPlayerAvatar:IsKilled() or mPlayerAvatar:__wf_atom_e1ecda10()) then
				local __wf_atom_e55d02aa = mPlayerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

				if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
					local __wf_atom_014a76a2 = __wf_atom_e55d02aa:__wf_atom_014a76a2()
					return __wf_atom_8e4fda44:__wf_atom_74e80bd6(__wf_atom_014a76a2)
				end
			end
		elseif p == "BOSS_TAG" then
			if _G.StalkerMode then
				return "an innoncent"
			end
		elseif p == "NODE_NAME" then
			local __wf_atom_aaa23ad1 = gGameRules:__wf_atom_aaa23ad1()

			if __wf_atom_7e8ad928(__wf_atom_aaa23ad1) then
				return nil
			end

			return (tostring((__wf_atom_aaa23ad1:__wf_atom_28a454ee(gGameRules:__wf_atom_72fc675e().location))))
		elseif p == "UNFINISHED_MAP_NODES" then
			local _, _, v3 = module3.__wf_atom_9edf7eac()
			local v4 = ""

			for i = 1, #v3 do
				v4 ..= Localize(tostring(v3[i].locTag), false)

				if i > 5 then
					break
				end

				if i < #v3 then
					v4 ..= ", "
				end
			end

			if #v3 > 5 then
				local num = #v3 - 5
				return v4 .. " " .. Localize(
					"/Lotus/Language/Syndicates/Syndicates_ArbitersEliteAlertAdditionalMissions",
					{ NUM = num }
				)
			end

			return v4
		end

		return nil
	end
end

function TransmissionUtilities:SatisfyArgs(items)
	for k, _ in pairs(items) do
		items[k] = self:SatisfyArg(k)

		if items[k] == nil or items[k] == "" then
			return nil
		end
	end

	return items
end

function TransmissionUtilities:TokenizeArgs(value)
	local v3 = true
	local result = {}
	local count = 0
	local v4 = 1

	while v3 ~= nil do
		v3 = string.find(value, "|", v4)

		if v3 == nil then
			continue
		end

		v4 = string.find(value, "|", v3 + 1)

		if v4 == nil then
			v3 = nil
		else
			result[string.sub(value, v3 + 1, v4 - 1)] = ""
			v4 += 1
			count += 1
		end
	end

	return result, count
end

function TransmissionUtilities:LocalizeWithSubstitution(mCurrentLocTag)
	if not __wf_atom_7e8ad928(gRegion) then
		self.mPlayerAvatars = gRegion:__wf_atom_ef7900cf()
		self.mPlayerAvatars = module.ShuffleTable(self.mPlayerAvatars)
		local __wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()
		local v3

		if not (__wf_atom_7e8ad928(__wf_atom_e23b2855) or not (#__wf_atom_e23b2855 > 0)) then
			v3 = __wf_atom_e23b2855[1]
		end

		if not (__wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v3:__wf_atom_50a7d83e())) then
			local __wf_atom_50a7d83e = v3:__wf_atom_50a7d83e()
			local v4 = 1

			for i = 1, #self.mPlayerAvatars do
				if self.mPlayerAvatars[i] == __wf_atom_50a7d83e then
					v4 = i
				end
			end

			local mPlayerAvatar = self.mPlayerAvatars[1]
			self.mPlayerAvatars[1] = self.mPlayerAvatars[v4]
			self.mPlayerAvatars[v4] = mPlayerAvatar
		end
	end

	self.mCurrentLocTag = mCurrentLocTag
	local __wf_atom_74e80bd6 = __wf_atom_8e4fda44:__wf_atom_74e80bd6(mCurrentLocTag)
	self.mRandomWeaponIdx = { 1, 2, 3 }
	self.mRandomWeaponIdx = module.ShuffleTable(self.mRandomWeaponIdx)
	local tokenizeArgs, v3 = self:TokenizeArgs(__wf_atom_74e80bd6)
	local v4

	if not (v3 > 0) then
		v4 = {}
		return Localize(tostring(mCurrentLocTag), v4), true
	end

	v4 = self:SatisfyArgs(tokenizeArgs)

	if v4 == nil then
		return __wf_atom_74e80bd6, false
	end

	return Localize(tostring(mCurrentLocTag), v4), true
end

function TransmissionUtilities:GetText(object)
	local __wf_atom_0edd93a0 = object:__wf_atom_0edd93a0()

	if #__wf_atom_0edd93a0 == 0 then
		local localizeWithSubstitution, _ = self:LocalizeWithSubstitution(object:GetText())
		return localizeWithSubstitution, EMPTY_SYMBOL
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if _T.transmissionShuffler == nil then
		_T.transmissionShuffler = {}
	end

	if _T.transmissionShuffler[__wf_atom_5b41f63b] == nil or #_T.transmissionShuffler[__wf_atom_5b41f63b] == 0 then
		_T.transmissionShuffler[__wf_atom_5b41f63b] = module.SeededShuffleTable(__wf_atom_0edd93a0)
	end

	while #_T.transmissionShuffler[__wf_atom_5b41f63b] > 0 do
		local v3 = math.random(1, #_T.transmissionShuffler[__wf_atom_5b41f63b])
		local v4 = _T.transmissionShuffler[__wf_atom_5b41f63b][v3]
		table.remove(_T.transmissionShuffler[__wf_atom_5b41f63b], v3)
		local localizeWithSubstitution, v5 = self:LocalizeWithSubstitution(v4)

		if v5 then
			return localizeWithSubstitution, v4
		end
	end

	local localizeWithSubstitution, _ = self:LocalizeWithSubstitution(object:GetText())
	return localizeWithSubstitution, EMPTY_SYMBOL
end

function TransmissionUtilities.GetTransmissionResponse(_, _, _, _, _)
	return nil
end

return TransmissionUtilities