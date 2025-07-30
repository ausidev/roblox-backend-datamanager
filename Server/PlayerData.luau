--[[

This module loads PlayerData and saves it periodically, this module uses the
Knit Framwork and needs it to function, alongside it relies on DataManger Module


]]


local Settings = {
	SAVE_INT = 12, -- save player data every 5 minute
	SAVE_ON_LEAVE = true, -- save player data on leave
	MAIN_SAVE = "PlayerData" -- the datastore key
}

local Knit = require(game:GetService('ReplicatedStorage').Packages.Knit)
local Players = game:GetService("Players")

local PlayerData = Knit.CreateService{
	Name = 'PlayerData',
	Client = {},
}

PlayerData.LoadedPlayers = {}

-- these are what the playerstats base will be
-- you can add stats to here and it will load them
-- anytime you add a stat or change the name increment the _version property
PlayerData.PlayerStats = { 
	TownLevel = 1,
	Gold = 0,
	_version = 1
}

function PlayerData.new()
	return table.clone(PlayerData.PlayerStats)
end

function PlayerData:LoadPlayer(player: Player)
	local PlayersData = self.DataManager.getData(Settings.MAIN_SAVE, player.UserId)
	if PlayersData == 1 then
		PlayersData = PlayerData.new()
	end
	
	if PlayersData._version < PlayerData.PlayerStats._version then
		for i, v in next, PlayerData.PlayerStats do
			if PlayersData[i] == nil then
				PlayersData[i] = v
			end
		end
		for i, v in next, PlayersData do
			if PlayerData.PlayerStats[i] == nil then
				PlayersData[i] = nil
			end
		end
		PlayersData._version = PlayerData.PlayerStats._version
	end

	self.DataManager.update(Settings.MAIN_SAVE, player.UserId, PlayersData)
	PlayerData.LoadedPlayers[player] = PlayersData
	return 0
end

function PlayerData:SavePlayer(player: Player)
	local PlayersData = self.LoadedPlayers[player]
	assert(PlayersData, "Players data not found")
	self.DataManager.update(Settings.MAIN_SAVE, player.UserId, PlayersData)
end

function PlayerData:KnitStart()
	PlayerData.DataManager = Knit.GetService('DataService')
	PlayerData.DataStore = self.DataManager.get(Settings.MAIN_SAVE)
	Players.PlayerAdded:Connect(function(player: Player)
		self:LoadPlayer(player)
	end)
	Players.PlayerRemoving:Connect(function(player: Player)
		if not Settings.SAVE_ON_LEAVE then
			return
		end
		self.LoadedPlayers[player] = nil
		self:SavePlayer(player)
	end)
	
	while task.wait(Settings.SAVE_INT) do
		for i, v in next, Players:GetPlayers() do
			self:SavePlayer(v)
		end
	end
end

return PlayerData
