-- Made by Inferion 2012. You may use this as a reference, and if you decide to copy & paste, please leave credit in the script. =)
local PlayerA
local NPC_SPAWNER_A
local NPC_SPAWNER_B

local PlayerB
local NPC_A
local NPC_B
local Count = 0

function cc_OnGhoulSpawn(pUnit, Event)
    NPC_A=pUnit
end

RegisterUnitEvent(26515, 18, "cc_OnGhoulSpawn")

function cc_OnNecroSpawn(pUnit, Event)
	NPC_B=pUnit
end

RegisterUnitEvent(90008, 18, "cc_OnNecroSpawn")

function cc_OnFirstEnterWorld(event, pPlayer)
	pPlayer:SetPlayerLock(1)
	pPlayer:CastSpell(46940)
	pPlayer:SetStandState(7)
	PlayerB=pPlayer
	RegisterTimedEvent("GHOUL_PLAY_EMOTE", 1000, 1)
	RegisterTimedEvent("GHOUL_PLAY_EMOTE_STOP", 5000, 1)
end

function GHOUL_PLAY_EMOTE(pUnit, Event)
	NPC_A:Emote(398, 10000)
	PlayerB:SetStandState(7)
	NPC_B:SetNPCFlags(1)
end

function GHOUL_PLAY_EMOTE_STOP(pUnit, Event)
	NPC_B:SendChatMessage(12, 0,"What are you digging at ghoul?")
	NPC_B:MoveTo(476.599182, -303.103241, 155.499100, 0.875724)
	NPC_B:RegisterEvent("Wait_for_Necro_Nub", 4500, 1)
end

function Wait_for_Necro_Nub(pUnit, Event)
	NPC_B:SendChatMessage(12, 0,"Ah, another knight. I can resurrect this creature.")
	NPC_B:Emote(1, 4000)
	NPC_B:RegisterEvent("cWait_for_Necro_Nub", 2000, 1)
end

function cWait_for_Necro_Nub(pUnit, Event)
	NPC_B:ChannelSpell(57797, PlayerB)
	NPC_B:RegisterEvent("ccWait_for_Necro_Nub", 5000, 1)
end

function ccWait_for_Necro_Nub(pUnit, Event)
	NPC_B:StopChannel()
	PlayerB:SetStandState(0)
	NPC_B:SendChatMessage(12, 0,"Stand up, knight. You're fine. Speak to Mathias over there.")
	PlayerB:SetPlayerLock(0)
	PlayerB:RemoveAura(46940) --Bleed
	PlayerB:CastSpell(63660) --Explosion visual, pending change.
	NPC_B:RegisterEvent("cccWait_for_Necro_Nub", 3000, 1)
end

function cccWait_for_Necro_Nub(pUnit, Event)
	PlayerB = nil
	NPC_B:ReturnToSpawnPoint()
end

RegisterServerHook(3, "cc_OnFirstEnterWorld")