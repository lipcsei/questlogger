-- questlogger.lua

local Quest = {}
Quest.__index = Quest

function Quest:New(eventID, id, title, description, objectiveText, rewardText)
    local self = setmetatable({}, Quest)
    self.eventID = eventID
    self.questID = id
    self.title = title
    self.description = description
    self.objectiveText = objectiveText
    self.rewardText = rewardText
    self.playerName = UnitName("player")
    self.playerClass = UnitClass("player")

    return self
end

local Gossip = {}
Gossip.__index = Gossip

function Gossip:New(gossipID, gossipText)
    local self = setmetatable({}, Gossip)
    self.gossipID = gossipID
    self.gossipText = gossipText
    self.playerName = UnitName("player")
    self.playerClass = UnitClass("player")

    return self
end


-- Saved Variables inicializálása
local defaults = {
    questLog = {},
    gossipLog = {}
}

local function ClearSavedVariables()
    QuestLoggerDB = nil
    ReloadUI()
end

local function WriteToSavedVariables(dataType, data)
    if not QuestLoggerDB then
        QuestLoggerDB = defaults
    end

    table.insert(QuestLoggerDB[dataType], data)
end

local function NewQuest(eventID)
    local q = Quest:New(eventID, GetQuestID(), GetTitleText(), GetQuestText(), GetObjectiveText(), GetRewardText())
    local questCompletionData = {
        eventID = eventID,
        questID = q.questID,
        title = q.title,
        description = q.description,
        objective = q.objectiveText,
        reward = q.rewardText,
        playerName = q.playerName,
        playerClass = q.playerClass
    }
    WriteToSavedVariables("questLog", questCompletionData)
    print("QuestLogger - Quest mentve: " .. q.title)
end

local function NewGossip()

        local g = Gossip:New( C_GossipInfo.GetOptions(), C_GossipInfo.GetText())
        local gossipData = {
            gossipID = g.gossipID,
            gossipText = g.gossipText,
            playerName = g.playerName,
            playerClass = g.playerClass
        }
        WriteToSavedVariables("gossipLog", gossipData)
        print("QuestLogger - Gossip mentve: " .. g.gossipText)
end

local frame = CreateFrame("Frame")

frame:RegisterEvent("QUEST_DETAIL")
frame:RegisterEvent("QUEST_GREETING")
frame:RegisterEvent("QUEST_ACCEPTED")
frame:RegisterEvent("QUEST_TURNED_IN")
frame:RegisterEvent("QUEST_LOG_UPDATE")
frame:RegisterEvent("QUEST_WATCH_UPDATE")
frame:RegisterEvent("QUEST_POI_UPDATE")
frame:RegisterEvent("QUEST_GREETING")
frame:RegisterEvent("QUEST_ITEM_UPDATE")

frame:RegisterEvent("QUEST_COMPLETE")
frame:RegisterEvent("GOSSIP_SHOW")
-- További események regisztrálása...

frame:SetScript("OnEvent", function(self, event, message, sender,...)
    print(self)
    print(event)
    print(message)
    print(sender)

    if event == "QUEST_DETAIL" then
        NewQuest("QUEST_DETAIL")
    elseif event == "QUEST_COMPLETE" then
        NewQuest("QUEST_COMPLETE")
    elseif event == "QUEST_GREETING" then
        NewQuest("QUEST_GREETING")
    elseif event == "QUEST_ACCEPTED" then
        NewQuest("QUEST_ACCEPTED")
    elseif event == "QUEST_TURNED_IN" then
        NewQuest("QUEST_TURNED_IN")
    elseif event == "QUEST_LOG_UPDATE" then
        NewQuest("QUEST_LOG_UPDATE")
    elseif event == "QUEST_WATCH_UPDATE" then
        NewQuest("QUEST_WATCH_UPDATE")
    elseif event == "QUEST_POI_UPDATE" then
        NewQuest("QUEST_POI_UPDATE")
    elseif event == "QUEST_ITEM_UPDATE" then
        NewQuest("QUEST_ITEM_UPDATE")
    elseif event == "GOSSIP_SHOW" then
        local name, unitID = UnitName("npc"), UnitGUID("npc")
        print(name)
        print(unitID)
        local npcID = unitID and select(6, strsplit("-", unitID))
        print("NPC Név: " .. (name or "Ismeretlen"))
        print("NPC ID: " .. (npcID or "Ismeretlen"))
        print("Gossip event")
        print( C_GossipInfo.GetText())
        local numOptions = C_GossipInfo.GetNumOptions()
        print(numOptions)
        print(C_GossipInfo.G)


        --NewGossip()
    end

end)

SLASH_QUESTLOGGER1 = "/questlogger"
SlashCmdList["QUESTLOGGER"] = function(msg)
    if msg == "clear" then
        ClearSavedVariables()
    end
end