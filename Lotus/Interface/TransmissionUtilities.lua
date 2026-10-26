module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CrossPlatformUtilities")
require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.SentimentUtility")
local v = Symbol("Archwing")
local v2 = Symbol("SpeechEmissive")
local v3 = Symbol("offsetAmount")
local TransmissionUtilities = {}
TransmissionUtilities.mCachedRegion = nil
TransmissionUtilities.mZoomer = 1
TransmissionUtilities.mScale = 1
TransmissionUtilities.mAnimateMouth = true
TransmissionUtilities.mSmoothHead = nil
TransmissionUtilities.mSmoothAmp = __wf_atom_10cd16b2(0, 0.1)
TransmissionUtilities.mSmoothAmpQuick = __wf_atom_10cd16b2(0, 0.02)
TransmissionUtilities.mSkeletalMeshType = WeakResource("/EE/Types/GraphicsRes/SkeletalMesh")
TransmissionUtilities.mLotusAvatarType = WeakResource("/Lotus/Types/Friendly/TheNewWar/LotusHubAvatar")
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
TransmissionUtilities.ORDIS_TAG = Symbol("Ordis")
TransmissionUtilities.ORDIS_ADVANCED_TAG = Symbol("AdvancedOrdisDeco")
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
TransmissionUtilities.OPERATOR_SYMBOL = Symbol("OPERATOR")
TransmissionUtilities.BALLAS_SYMBOL = Symbol("BallasThroneDeco")
TransmissionUtilities.CameraWaypointType = Resource("/Lotus/Interface/TransmissionCameraWaypoint")
TransmissionUtilities.mVisemeState = {}
TransmissionUtilities.mVisemeAnticipation = 0.1
TransmissionUtilities.mVisemeFadeIn = 0
TransmissionUtilities.mOperatorMood = nil
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
TransmissionUtilities.mShakeVoice = false
TransmissionUtilities.mLastCamTag = nil
TransmissionUtilities.mEyeTracking = true
TransmissionUtilities.mPriorBlendInfos = {}
TransmissionUtilities.mBlendOut = 1
TransmissionUtilities.mTime = 0

function TransmissionUtilities:CalcLevelSpecificHacks(object, p)
	self.TransmissionCameraOffset = nil
	self.TransmissionHeadingOffset = nil
	self.mForcedMaterialIndex = nil

	if __wf_atom_7e8ad928(object) or not __wf_atom_7e8ad928(p) then
		return
	end

	local __wf_atom_5b41f63b = object:__wf_atom_5b41f63b()

	if string.find(__wf_atom_5b41f63b, "LotusMurexNewWarPortrait") then
		self.mUseHeadTarget = false
		self.mEyeTracking = false
		self.mTrackCamera = false
		self.mHeadTurnAmount = 0
		self.mNodAmount = 0
		self.mMinFOV = 25
		self.mMaxFOV = 30
	elseif string.find(__wf_atom_5b41f63b, "ThraxSpeaking") then
		self.mEyeTracking = false
		self.mEmissives = true
		self.mEmissiveBase = 0.5
		self.mMinFOV = 25
		self.mMaxFOV = 25
	elseif string.find(__wf_atom_5b41f63b, "Thrax") then
		self.mUseHeadTarget = false
		self.mEyeTracking = false
		self.mTrackCamera = false
		self.mEmissives = true
		self.mEmissiveBase = 0.5
		self.mHeadTurnAmount = 0
		self.mNodAmount = 0
		self.mMinFOV = 25
		self.mMaxFOV = 25
	elseif string.find(__wf_atom_5b41f63b, "ZarimanActual") then
		self.mUseHeadTarget = false
		self.mMinFOV = 40
		self.mMaxFOV = 40
	elseif string.find(__wf_atom_5b41f63b, "EidolonLotusPortrait") then
		self.mUseHeadTarget = false
		self.mMinFOV = 17
		self.mMaxFOV = 22
		self.mNodAmount = 0
	elseif string.find(__wf_atom_5b41f63b, "DuviriStartChoiceAlt") then
		self.mUseHeadTarget = false
		self.mMinFOV = 17
		self.mMaxFOV = 22
		self.mNodAmount = 0
		self.mPlayVisemeOnDeco = true
	elseif string.find(__wf_atom_5b41f63b, "Archon") then
		self.mUseHeadTarget = false
		self.mMinFOV = 25
		self.mMaxFOV = 25
	elseif string.find(__wf_atom_5b41f63b, "NatahWatching") then
		self.mAnimateMouth = false
		self.mUseHeadTarget = false
		self.mMinFOV = 25
		self.mMaxFOV = 25
	elseif string.find(__wf_atom_5b41f63b, "Ballas") then
		self.mEyeTracking = false
	elseif string.find(__wf_atom_5b41f63b, "RedVeil") then
		self.mUseHeadTarget = false
	elseif string.find(__wf_atom_5b41f63b, "ProfitTaker") then
		self.mUseHeadTarget = false
		self.mMinFOV = 30
		self.mMaxFOV = 35
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "FrohdBekAmbulasPortrait") then
		self.mUseHeadTarget = false
		self.mMinFOV = 25
		self.mMaxFOV = 33
	elseif
		string.find(__wf_atom_5b41f63b, "Meridian")
		or string.find(__wf_atom_5b41f63b, "Sprag")
		or string.find(__wf_atom_5b41f63b, "Venkra")
	then
		self.mMouth = {}
		self.mMorphHack = true
		self.mNodAmount = 4
		self.mUseHeadTarget = false
	elseif string.find(__wf_atom_5b41f63b, "Operator") then
		self.mTrackCamera = false
		self.mMaxFOV = 19
		self.mNodAmount = 3
		self.mHeadTurnAmount = 20
		self.mUseSmoothAmp = true
		self.mNodBasePitch = -10
	elseif string.find(__wf_atom_5b41f63b, "Liset") or string.find(__wf_atom_5b41f63b, "Simaris") then
		self.mMinFOV = 21
		self.mMaxFOV = 25
	elseif string.find(__wf_atom_5b41f63b, "VisemeTest") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "Teshin") then
		self.mTrackCamera = false
		self.mNodAmount = 3
		self.mHeadTurnAmount = 5
		self.mEyeTracking = false
	elseif string.find(__wf_atom_5b41f63b, "Onkko") then
		self.mMinFOV = 18
		self.mMaxFOV = 24
		self.mHeadOffset = Vector(0.05, 0.06, 0)
	elseif string.find(__wf_atom_5b41f63b, "BoonReading") then
		self.mTrackCamera = false
		self.mHeadTurnAmount = 0
		self.mTaggedActors = true
	elseif string.find(__wf_atom_5b41f63b, "Boon") then
		self.mHeadOffset = Vector(0, 0.08, 0)
		self.mTaggedActors = false
	elseif string.find(__wf_atom_5b41f63b, "LoidPortrait") then
		self.mTrackCamera = false
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "Pazuul") then
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "Chipper") then
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "KelaNewPortrait") then
		self.mTrackCamera = false
		self.mAmpScale = 1.5
	elseif string.find(__wf_atom_5b41f63b, "AssemblyPortrait") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "Raptor") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "RailJackPortrait.level") then
		self.mTrackCamera = false
		self.mUseHeadTarget = false
	elseif string.find(__wf_atom_5b41f63b, "/RandomWarframe.level") then
		self.mHeadOffset = Vector(0, -0.15, 0)
	elseif string.find(__wf_atom_5b41f63b, "/Portrait.level") then
		self.mMaxFOV = 19
		self.mJawPitch = 6
		self.mLipPitch = 3
		self.mNodAmount = 3
		self.mHeadTurnAmount = 10
		self.mMouth[2][2] = -0.5
		self.mMouth[3][2] = -0.8
		self.mMouth[4][2] = -0.5
		self.mMouth[5][2] = 1
		self.mMouth[6][2] = 1
		self.mMouth[7][2] = 1
		self.mUseSmoothAmp = true
	elseif string.find(__wf_atom_5b41f63b, "NewLoka") then
		self.mJawPitch = 4
		self.mLipPitch = 3
		self.mNodAmount = 3
		self.mHeadTurnAmount = 10
		self.mMouth[2][2] = -0.5
		self.mMouth[3][2] = -0.8
		self.mMouth[4][2] = -0.5
		self.mMouth[5][2] = 1
		self.mMouth[6][2] = 1
		self.mMouth[7][2] = 1
		self.mUseSmoothAmp = true
	elseif string.find(__wf_atom_5b41f63b, "/AladPortrait") then
		self.mJawPitch = 6
		self.mLipPitch = 3
		self.mUseSmoothAmp = true
	elseif string.find(__wf_atom_5b41f63b, "/AladPrivatePortrait") then
		self.mJawPitch = 6
		self.mLipPitch = 3
		self.mUseSmoothAmp = true
		self.mTrackCamera = false
		self.mMinFOV = 23
		self.mMaxFOV = 24
	elseif string.find(__wf_atom_5b41f63b, "Perrin") then
		self.mJawPitch = 5
		self.mLipPitch = 3
		self.mNodAmount = 3
		self.mHeadTurnAmount = 20
		self.mMouth[2][2] = -0.5
		self.mMouth[3][2] = -0.8
		self.mMouth[4][2] = -0.5
		self.mMouth[5][2] = 1
		self.mMouth[6][2] = 1
		self.mMouth[7][2] = 1
		self.mHeadOffset = Vector(0, 0.1, 0)
	elseif string.find(__wf_atom_5b41f63b, "/Vay") or string.find(__wf_atom_5b41f63b, "VayHek") then
		self.mMinFOV = 14
		self.mMaxFOV = 21
		self.mHeadTrackBone = self.GAME_R1_EYE1
		self.mMouth[2][2] = -1
		self.mMouth[3][2] = 1
		self.mMouth[4][2] = -0.5
		self.mMouth[5][2] = 1.5
		self.mMouth[6][2] = 0.5
		self.mMouth[7][2] = 1.5
	elseif string.find(__wf_atom_5b41f63b, "/MarooPortrait.level") or string.find(__wf_atom_5b41f63b, "Maroo") then
		self.mHeadOffset = Vector(0, -0.01, 0)
	elseif string.find(__wf_atom_5b41f63b, "/LephantusPortrait") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "Friends") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "Suda") then
		self.mMinFOV = 16
		self.mMaxFOV = 25
		self.mSpeakingTag = "SudaSpeaking"
	elseif string.find(__wf_atom_5b41f63b, "Nakak") then
		self.mMinFOV = 21
		self.mMaxFOV = 25
	elseif
		string.find(__wf_atom_5b41f63b, "GrineerDeathSquad")
		or string.find(__wf_atom_5b41f63b, "KuvaLich")
		or string.find(__wf_atom_5b41f63b, "CorpusLich")
	then
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "CrewMemberPortrait") then
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "Arbiters") then
		self.mAvatarIndex = 1
		self.mNodAmount = 3
		self.mUseHeadTarget = false
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "/VorTwoPortrait") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "/VorScrambledPortrait") then
		self.mHeadOffset = Vector(0, 0.03, 0)
	elseif string.find(__wf_atom_5b41f63b, "/LisetPortrait") then
		self.mSpeakingTag = "OrdisSpeaking"
	elseif string.find(__wf_atom_5b41f63b, "/HunhowSwordPortrait") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "/HunhowOcean") then
		self.mTrackCamera = false
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "/GrineerCrowd") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "GrineerQueensPortrait") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "Palladino") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "Natah") then
		self.mEyeTracking = false
		self.mEmissives = true
		self.mNodAmount = 0
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "Eudico") then
		self.mEmissives = true
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "TheBusiness") then
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "Legs") then
		self.mEmissives = true
		self.mHeadTrackBone = Symbol("GAME_C1_ROBOHEAD1")
		self.mMinFOV = 21
		self.mMaxFOV = 25
	elseif string.find(__wf_atom_5b41f63b, "Ticker") then
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "VoxHeist") then
		self.mTrackCamera = false
		self.mTrackCameraTag = true
	elseif string.find(__wf_atom_5b41f63b, "Vox") then
		self.mTrackCamera = false
	elseif string.find(__wf_atom_5b41f63b, "Nora") then
		self.mTrackCamera = false
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "Neewa") then
		self.mNodAmount = 3
		self.mHeadTurnAmount = 20

		if string.find(__wf_atom_5b41f63b, "NeewaCaptive") then
			self.mUseHeadTarget = false
			self.mTrackCamera = false
			self.mAnimateMouth = false
			self.mMouth = {}
			self.mMorphHack = false
		end
	elseif string.find(__wf_atom_5b41f63b, "GrineerPilot") then
		self.mMinFOV = 25
		self.mMaxFOV = 30
	elseif string.find(__wf_atom_5b41f63b, "NemesisPreview") then
		self.mTrackCamera = false
		self.mEmissives = true
	elseif
		string.find(__wf_atom_5b41f63b, "ZarimanHoldfastsRankUpPortrait")
		or string.find(__wf_atom_5b41f63b, "FamilyPortrait")
		or string.find(__wf_atom_5b41f63b, "MotherSon")
		or string.find(__wf_atom_5b41f63b, "FatherSon")
		or string.find(__wf_atom_5b41f63b, "FatherDaughter")
		or string.find(__wf_atom_5b41f63b, "MotherFather")
		or string.find(__wf_atom_5b41f63b, "DaughterSon")
	then
		self.mTrackCamera = false
		self.mTaggedActors = true
		self.mPulseFlares = false
	elseif string.find(__wf_atom_5b41f63b, "DeimosDaughter") then
		self.mTrackCamera = false
		self.mHeadTurnAmount = 0

		if _T.HudType == 1 then
			self.mForcedMaterialIndex = 1
		end
	elseif string.find(__wf_atom_5b41f63b, "Deimos") then
		self.mTrackCamera = false
		self.mHeadTurnAmount = 0
	elseif string.find(__wf_atom_5b41f63b, "CephalonTeacher") then
		self.mTrackCamera = false
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "OrdisNext") then
		self.mTrackCamera = false
		self.mEmissives = true
	elseif string.find(__wf_atom_5b41f63b, "Cavalero") then
		self.mTaggedActors = true
		self.mAnimateMouth = true
	elseif string.find(__wf_atom_5b41f63b, "Hombask") then
		self.mTaggedActors = true
		self.mAnimateMouth = true
	elseif string.find(__wf_atom_5b41f63b, "Quinn") then
		self.mTaggedActors = true
		self.mAnimateMouth = true
	elseif string.find(__wf_atom_5b41f63b, "Yonta") then
		self.mTaggedActors = true
		self.mAnimateMouth = true
	elseif string.find(__wf_atom_5b41f63b, "HombaskGardener") then
		self.mTrackCamera = false
		self.mEmissives = true
	end

	if _T.InSyndicateScreen then
		self.NECK_BONE = Symbol("GAME_C1_HEAD1")
		self.mHeadTrackBone = Symbol("GAME_C1_HEAD1")

		if string.find(__wf_atom_5b41f63b, "Meridian") then
			self.TransmissionCameraOffset = Vector(0.28, -0.1, 0)
		elseif string.find(__wf_atom_5b41f63b, "Perrin") then
			self.TransmissionCameraOffset = Vector(0, -0.35, -0.25)
			self.TransmissionHeadingOffset = -8
		elseif string.find(__wf_atom_5b41f63b, "Onkko") then
			self.TransmissionCameraOffset = Vector(0.1, -0.2, 0.3)
			self.TransmissionHeadingOffset = -8
		elseif
			string.find(__wf_atom_5b41f63b, "Arbiters")
			or string.find(__wf_atom_5b41f63b, "Suda")
			or string.find(__wf_atom_5b41f63b, "RedVeil")
		then
			self.TransmissionCameraOffset = Vector(0.2, 0, 0)
		elseif string.find(__wf_atom_5b41f63b, "EudicoRevealed") then
			self.TransmissionCameraOffset = Vector(-0.2, 0, 0)
			self.TransmissionHeadingOffset = -20
			self.NECK_BONE = Symbol("GAME_C1_HEADCNCT")
		elseif string.find(__wf_atom_5b41f63b, "Eudico") then
			self.TransmissionCameraOffset = Vector(-0.65, 0.2, -0.65)
			self.TransmissionHeadingOffset = -30
		elseif string.find(__wf_atom_5b41f63b, "Simaris") then
			self.TransmissionCameraOffset = Vector(0.3, -0.1, -0.1)
		elseif string.find(__wf_atom_5b41f63b, "Roky") then
			self.TransmissionCameraOffset = Vector(-0.5, 0, -0.1)
			self.TransmissionHeadingOffset = -8
		elseif string.find(__wf_atom_5b41f63b, "Teshin") then
			self.TransmissionCameraOffset = Vector(-0.2, -0.05, 0)
			self.TransmissionHeadingOffset = -15
		elseif string.find(__wf_atom_5b41f63b, "LittleDuckRevealed") then
			self.TransmissionCameraOffset = Vector(-0.4, 0, 0.45)
			self.TransmissionHeadingOffset = -9
			self.mHeadTrackBone = Symbol("GAME_C1_HEADCNCT")
		elseif string.find(__wf_atom_5b41f63b, "LittleDuck") then
			self.TransmissionCameraOffset = Vector(-0.4, 0, 0.45)
			self.TransmissionHeadingOffset = -9
			self.mHeadTrackBone = Symbol("GAME_C1_HEAD1")
		elseif string.find(__wf_atom_5b41f63b, "Nakak") then
			self.TransmissionCameraOffset = Vector(-0.5, 0, 0)
			self.TransmissionHeadingOffset = -8
		elseif string.find(__wf_atom_5b41f63b, "DeimosMother") then
			self.TransmissionCameraOffset = Vector(-0.5, 0, 0)
			self.TransmissionHeadingOffset = -16
		elseif string.find(__wf_atom_5b41f63b, "Loid") then
			self.TransmissionCameraOffset = Vector(0.05, 0, 0)
			self.TransmissionHeadingOffset = -8
		else
			self.TransmissionHeadingOffset = -8
		end
	end
end

function TransmissionUtilities:FindAll(object, p)
	local all = object:FindAll(p)
	return all == nil and {} or all
end

function TransmissionUtilities:UpdateRegion(object, mCachedRegion, p, instance, mTrackCamera)
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
		self.mOperatorMood = nil
		self.mShakeVoice = false
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
			local c_str = _T.curTransmission:__wf_atom_db682341():c_str()

			if string.find(c_str, "Tree") then
				gRegion:__wf_atom_8ad59546().postProcessBias:__wf_atom_54a04966(math.pow(__wf_atom_31aab74c, 0.5) * 6)
				gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(__wf_atom_104bfe98(0, 0.15, __wf_atom_31aab74c))
			end

			if string.find(c_str, "Helminth") then
				self.mSpeakingTag = "HelminthSpeaking"
				_T[self.mSpeakingTag] = __wf_atom_31aab74c
			end
		end
	else
		self.mCachedRegion = mCachedRegion
		local v4 = __wf_atom_084b3e93()
		self.mTime += v4
		local v5

		if __wf_atom_7e8ad928(object) or not self.mAnimateMouth then
			v5 = 0
		else
			v5 = object:__wf_atom_31aab74c()

			if object:__wf_atom_bda39a69() then
				self.mVisemeData = object:__wf_atom_61ea8025(self.mVisemeAnticipation)
			end
		end

		self.mSmoothAmp:__wf_atom_09294a87(v5)
		self.mSmoothAmpQuick:__wf_atom_09294a87(v5)
		self.mSmoothAmp:Update(v4)
		self.mSmoothAmpQuick:Update(v4)
		local v6 = nil
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
			self.mOperatorMood = nil
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
			self.mShakeVoice = false
			self.mLastCamTag = nil
			self.mEyeTracking = true
			self.mPriorBlendInfos = {}
			self.mBlendOut = 1
			self:CalcLevelSpecificHacks(__wf_atom_22941262, instance)
		end

		if self.mTrackDelay > 0 then
			self.mTrackDelay -= 1
			mTrackCamera = false
		end

		if self.mUseSmoothAmp then
			v5 = __wf_atom_104bfe98(v5, self.mSmoothAmp:__wf_atom_9e368823(), 1)
		end

		if self.mSpeakingTag then
			_T[self.mSpeakingTag] = v5
		end

		if mTrackCamera == nil then
			mTrackCamera = self.mTrackCamera
		end

		if p then
			self.mMinFOV = self.mMaxFOV
		end

		local ordisCurrentVolume = __wf_atom_104bfe98(v5, self.mSmoothAmp:__wf_atom_9e368823(), 1)
		local v7 = Noise(self.mTime * 0.05)
		local v8 = __wf_atom_a3cc989c(self.mTime * 0.3)

		if __wf_atom_7e8ad928(instance) and self.mPulseFlares then
			if not self.mAllFlares then
				self.mAllFlares = self:FindAll(mCachedRegion, __wf_atom_fac7b40a)
			end

			if #self.mAllFlares > 0 then
				local v9 = math.min(1, ordisCurrentVolume * 0.5 + 0.5)

				for i = 1, #self.mAllFlares do
					if __wf_atom_7e8ad928(self.mAllFlares[i]) then
						continue
					end

					if self.mAllFlares[i]:HasTag(self.VOICE_TAG) then
						self.mAllFlares[i]:__wf_atom_008aae7f(ordisCurrentVolume * ordisCurrentVolume)
					elseif not self.mAllFlares[i]:HasTag(self.ORDIS_TAG) then
						self.mAllFlares[i]:__wf_atom_008aae7f(v9)
					end
				end
			end
		end

		if __wf_atom_7e8ad928(instance) or not instance:HasTag(self.ORDIS_ADVANCED_TAG) then
			_T.OrdisCurrentVolume = 0
		else
			_T.OrdisCurrentVolume = ordisCurrentVolume
		end

		if not __wf_atom_7e8ad928(_T.PortraitOperatorAvatar) then
			_T.PortraitOperatorAvatar:__wf_atom_f7e4d343(object)

			if self.mOperatorMood == nil and not __wf_atom_7e8ad928(object) then
				self.mOperatorMood = module3.CalcMood(self.mCurrentLocTag:c_str())
				_T.PortraitOperatorAvatar:__wf_atom_83ca28fa(self.mOperatorMood, 1)
			end
		end

		local v9 = false

		if self.mAllDecos and #self.mAllDecos ~= 0 then
			if not __wf_atom_7e8ad928(instance) then
				v9 = true
			end
		else
			if __wf_atom_7e8ad928(instance) then
				self.mAllDecos = self:FindAll(mCachedRegion, __wf_atom_8d0b7f88)
			else
				self.mAllDecos = { instance }
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

			if v9 and instance == deco then
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
						self:UpdateVisemeState(
							deco,
							self.mVisemeData,
							ordisCurrentVolume,
							object,
							mCachedRegion,
							instance
						)
					elseif self.mAnimateMouth then
						if self.mMorphHack then
							local v10 = __wf_atom_104bfe98(ordisCurrentVolume, v5, (math.pow(v8, 0.25)))
							deco:__wf_atom_f3f3bb0e(self.MORPH_NAME_OPEN, v10 * 0.3)
						end

						for j = 1, #self.mMouth do
							local v10

							if j == 1 then
								v10 = ordisCurrentVolume * self.mJawPitch * __wf_atom_104bfe98(1, 2, v8)
							else
								v10 = (self.mSmoothAmp:__wf_atom_9e368823() * 2 - 1) * ordisCurrentVolume * self.mLipPitch * __wf_atom_104bfe98(1, 2, v8)
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
							v6 = deco:__wf_atom_1c374cc9(self.mHeadTrackBone) + self.mHeadOffset
						end
					end
				end

				if self.mEmissives and (i == self.mAvatarIndex or deco:HasTag(v2)) then
					local v10 = v5 * v5
					local v11 = __wf_atom_104bfe98(self.mEmissiveBase, 6, v10)
					deco:SetMaterialParam(self.EMISSIVE_MAP_ATTEN, v11, 0, 0, 0, true)
				end
			end

			if i == #self.mAllDecos and v9 then
				local __wf_atom_b6b760b5 = instance:__wf_atom_b6b760b5()
				local v10 = {
					deco = instance,
					isRootSkeletal = not __wf_atom_7e8ad928(__wf_atom_b6b760b5) and __wf_atom_b6b760b5:IsA(self.mSkeletalMeshType) and __wf_atom_7e8ad928(instance:__wf_atom_3d96ddcd())
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

				local v10 = not (self.mSmoothAmp:__wf_atom_9e368823() > 0.15) and 0
					or __wf_atom_104bfe98(0, 20, ordisCurrentVolume)
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

				v10:SetMaterialParam(SF.__wf_atom_f35beb09, ordisCurrentVolume * 4 + 0.5)
				v10:SetMaterialParam(v3, ordisCurrentVolume * 0.04)

				for j = 1, #self.WAVEPARAMS do
					local v11 = (j - 1) * 4
					local v12 = __wf_atom_421b01aa(4 * __wf_atom_a3cc989c(j * __wf_atom_4658d645(self.mTime)), 0.5, 1)
					v10:SetMaterialParam(
						self.WAVEPARAMS[j],
						self.WAVEVALUES[v11 + 1],
						v12 * math.min(1, ordisCurrentVolume) * self.WAVEVALUES[v11 + 2],
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
			and (__wf_atom_7e8ad928(instance) or instance:IsA(self.mLotusAvatarType))
			and not _T.DisableCameraTracking
			and #self.mAllCameraSpots > 0
			and not __wf_atom_7e8ad928(self.mAllCameraSpots[1])
		then
			local v10 = __wf_atom_482dad48(2, 1, self.mTime * 0.05, __wf_atom_4658d645(self.mTime * 0.1)) * 3
			self.mZoomer = __wf_atom_421b01aa(self.mZoomer + v10 * __wf_atom_084b3e93(), 0, 1)
			local v11 = __wf_atom_104bfe98(self.mMinFOV, self.mMaxFOV, __wf_atom_24a82b69(self.mZoomer))
			self.mAllCameraSpots[1]:__wf_atom_888efbe9(v11)

			if v6 and self.mUseHeadTarget then
				v6.y -= 0.05

				if not self.mSmoothHead then
					self.mSmoothHead = Vector(v6.x, v6.y, v6.z)
				end

				self.mSmoothHead = __wf_atom_f55d6358(self.mSmoothHead, v6, __wf_atom_084b3e93() * self.mTrackSpeed)
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

function TransmissionUtilities:PhonemeToViseme(p)
	return self.mPhonemeToVisemeName[p + 1]
end

function TransmissionUtilities.FadeVisemes(state, object)
	state.mBlendOut = math.max(0, state.mBlendOut - __wf_atom_084b3e93() * 4)
	local v4 = math.pow(state.mBlendOut, 3)
	local total = 1
	local v5 = 12

	for _ = 1, #state.mPriorBlendInfos / 2 do
		object:__wf_atom_6e6edf68(state.mPriorBlendInfos[total], v5, state.mPriorBlendInfos[total + 1] * v4)
		v5 += 1
		total += 2
	end
end

function TransmissionUtilities:UpdateVisemeState(instance, list, _, object, _, p)
	self:PhonemeToViseme(list[1])
	self:PhonemeToViseme(list[2])
	local v4 = list[3]

	if
		not __wf_atom_7e8ad928(_T.PortraitOperatorAvatar) and instance:HasTag(self.OPERATOR_SYMBOL)
		or instance:HasTag(self.BALLAS_SYMBOL)
	then
		return
	end

	if self.mPlayVisemeOnDeco then
		instance:__wf_atom_f7e4d343(object)
		return
	end

	local v5 = list[1] == list[2] and 0 or v4
	local v6 = instance:IsA(__wf_atom_b39fdada) or instance:IsA(__wf_atom_67c46eba)

	if not v6 then
		local v7 = nil

		if __wf_atom_7e8ad928(p) and #self.mAllCameraSpots > 0 then
			v7 = self.mAllCameraSpots[1]
		end

		if not __wf_atom_7e8ad928(v7) and self.mEyeTracking then
			local position = v7:GetPosition()
			local __wf_atom_1c374cc9 = instance:__wf_atom_1c374cc9(self.NECK_BONE)
			local v8 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, position)
			instance:__wf_atom_5372d35c(self.GAME_R1_EYE1, v8)
			instance:__wf_atom_5372d35c(self.GAME_L1_EYE1, v8)
		end

		if not self.mVisemeState.Blink then
			self.mVisemeState.Blink = math.random(2, 7)
		end

		local blink = self.mVisemeState.Blink - __wf_atom_084b3e93()

		if blink < 0.2 then
			local v8 = 1 - math.abs(__wf_atom_421b01aa(blink / 0.2, 0, 1) * 2 - 1)
			instance:__wf_atom_6e6edf68(100, 1, __wf_atom_24a82b69(v8))
		end

		if blink <= 0 then
			blink = math.random(2, 7)
		end

		self.mVisemeState.Blink = blink
	end

	if v6 then
		instance:__wf_atom_f7e4d343(nil)
		v6 = false
	end

	if v6 then
		return
	end

	local v7 = 12
	self.mVisemeFadeIn = __wf_atom_421b01aa(self.mVisemeFadeIn + __wf_atom_084b3e93() * 4, 0, 1)

	if __wf_atom_7e8ad928(object) or not object:__wf_atom_f9e5bbc0() then
		if __wf_atom_7e8ad928(instance:__wf_atom_d5dd43f6()) then
			if self.mPriorBlendInfos and self.mPriorBlendInfos[1] ~= nil then
				self.FadeVisemes(self, instance)
				return
			end

			instance:__wf_atom_6e6edf68(list[1], 22, 1 - v5)
			instance:__wf_atom_6e6edf68(list[2], 23, v5)
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
		local v8 = __wf_atom_24a82b69(self.mVisemeFadeIn)

		while total < #__wf_atom_49b6ca2f do
			local v9 = __wf_atom_49b6ca2f[total + 1] * v8
			instance:__wf_atom_6e6edf68(__wf_atom_49b6ca2f[total], v7, v9)
			total += 2
			v7 += 1
		end

		while v7 < 30 do
			instance:__wf_atom_6e6edf68(0, v7, 0)
			v7 += 1
		end
	end
end

TransmissionUtilities.mRandomWeaponIdx = { 1, 2, 3 }

function TransmissionUtilities:GetPlayerWeapon(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return nil
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local v4 = self.mRandomWeaponIdx[0]

	if v4 == 1 then
		return (__wf_atom_d2b2176d:__wf_atom_9fb9a1d6())
	elseif v4 == 2 then
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
		local v4 = ""

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

			if v4 == "" and __wf_atom_7933a10d ~= "" then
				v4 = __wf_atom_7933a10d
			elseif v4 ~= "" and __wf_atom_7933a10d ~= "" then
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

			local __wf_atom_33428e7b = gRegion:__wf_atom_e23b2855()[1]:__wf_atom_33428e7b()

			if __wf_atom_33428e7b ~= EMPTY_SYMBOL then
				return Localize(__wf_atom_33428e7b:c_str(), false)
			end

			if __wf_atom_679e0b25("LotusGameRules.AlwaysStalk") > 0 then
				return "Captain Vor"
			end
		elseif p == "NODE_NAME" then
			local __wf_atom_aaa23ad1 = gGameRules:__wf_atom_aaa23ad1()

			if __wf_atom_7e8ad928(__wf_atom_aaa23ad1) then
				return nil
			end

			return (tostring((__wf_atom_aaa23ad1:__wf_atom_28a454ee(gGameRules:__wf_atom_72fc675e().location))))
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
	local v4 = true
	local result = {}
	local count = 0
	local v5 = 1

	while v4 ~= nil do
		v4 = string.find(value, "|", v5)

		if v4 == nil then
			continue
		end

		v5 = string.find(value, "|", v4 + 1)

		if v5 == nil then
			v4 = nil
		else
			result[string.sub(value, v4 + 1, v5 - 1)] = ""
			v5 += 1
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
		local v4

		if not (__wf_atom_7e8ad928(__wf_atom_e23b2855) or not (#__wf_atom_e23b2855 > 0)) then
			v4 = __wf_atom_e23b2855[1]
		end

		if not (__wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v4:__wf_atom_50a7d83e())) then
			local __wf_atom_50a7d83e = v4:__wf_atom_50a7d83e()
			local v5 = 1

			for i = 1, #self.mPlayerAvatars do
				if self.mPlayerAvatars[i] == __wf_atom_50a7d83e then
					v5 = i
				end
			end

			local mPlayerAvatar = self.mPlayerAvatars[1]
			self.mPlayerAvatars[1] = self.mPlayerAvatars[v5]
			self.mPlayerAvatars[v5] = mPlayerAvatar
		end
	end

	self.mCurrentLocTag = mCurrentLocTag
	local __wf_atom_74e80bd6 = __wf_atom_8e4fda44:__wf_atom_74e80bd6(mCurrentLocTag)
	self.mRandomWeaponIdx = { 1, 2, 3 }
	self.mRandomWeaponIdx = module.ShuffleTable(self.mRandomWeaponIdx)
	local tokenizeArgs, v4 = self:TokenizeArgs(__wf_atom_74e80bd6)
	local v5

	if not (v4 > 0) then
		v5 = {}
		return Localize(tostring(mCurrentLocTag), v5), true
	end

	v5 = self:SatisfyArgs(tokenizeArgs)

	if v5 == nil then
		return __wf_atom_74e80bd6, false
	end

	return Localize(tostring(mCurrentLocTag), v5), true
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
		local v4 = math.random(1, #_T.transmissionShuffler[__wf_atom_5b41f63b])
		local v5 = _T.transmissionShuffler[__wf_atom_5b41f63b][v4]
		table.remove(_T.transmissionShuffler[__wf_atom_5b41f63b], v4)
		local localizeWithSubstitution, v6 = self:LocalizeWithSubstitution(v5)

		if v6 then
			return localizeWithSubstitution, v5
		end
	end

	local localizeWithSubstitution, _ = self:LocalizeWithSubstitution(object:GetText())
	return localizeWithSubstitution, EMPTY_SYMBOL
end

function TransmissionUtilities.GetTransmissionResponse(_, p, object, object2, p2)
	local v4

	if gGameRules:IsA(__wf_atom_311a7128) then
		v4 = false
	else
		v4 = module.Ternary(gGameRules:__wf_atom_d163c8e5(Symbol("StopNormalTransmissions"), 0) == 0, false, true)
	end

	if
		p == EMPTY_SYMBOL
		or __wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object2)
		or not (p2 or object:__wf_atom_403220f7())
		or v4
	then
		return nil
	end

	local v5 = nil

	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_311a7128) then
		local __wf_atom_a96eb2aa = object2:__wf_atom_a96eb2aa()

		if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			v5 = __wf_atom_a96eb2aa:__wf_atom_a4299765()
		end
	else
		v5 = gGameData:__wf_atom_a4299765()
	end

	if not v5 then
		return nil
	end

	local mAdultOperatorCustomization

	if v5.mOperatorType == 4 then
		mAdultOperatorCustomization = v5.mAdultOperatorCustomization
	else
		mAdultOperatorCustomization = v5.mOperatorCustomization
	end

	local v6 = {}

	if not __wf_atom_7e8ad928(_T.faction) then
		table.insert(v6, _T.faction)
	end

	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

	if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) and __wf_atom_d2b2176d:__wf_atom_84479917() then
		table.insert(v6, v)
	end

	local __wf_atom_c4774ee9 = mAdultOperatorCustomization:__wf_atom_c4774ee9(9)

	if __wf_atom_7e8ad928(__wf_atom_c4774ee9.mItemType) then
		return nil
	end

	local v7 = Resource(__wf_atom_c4774ee9.mItemType)

	if not __wf_atom_7e8ad928(v7) then
		local __wf_atom_d0c8d09f = v7:__wf_atom_d0c8d09f()

		if not __wf_atom_7e8ad928(__wf_atom_d0c8d09f) then
			return (__wf_atom_d0c8d09f:__wf_atom_89fb3a41(p, v6))
		end
	end

	return nil
end

return TransmissionUtilities