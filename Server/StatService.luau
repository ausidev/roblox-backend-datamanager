--[[


This module can be used to give players any stat you desire.


]]
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local StatService = Knit.CreateService{
	Name = "StatService",
	Client = {
		StatChanged = Knit.CreateUnreliableSignal()
	}
}

function StatService:GetStat(Player: Player, Stat: string)
	if not self.PlayerData.PlayerStats[Stat] then
		warn"Stat doesn't exist"
		return
	end
	return self.PlayerData.LoadedPlayers[Player][Stat];
end

function StatService:GiveStat(Player: Player, Stat: string, Value: any|number, Step: boolean?)
	local PlayersData = self.PlayerData.LoadedPlayers[Player]
	assert(PlayersData, "PlayersData is not found")
	if not self:GetStat(Player, Stat) then
		return
	end
	
	if Step and type(Value) == "number" then
		self.PlayerData.LoadedPlayers[Player][Stat]+=Value
	else
		self.PlayerData.LoadedPlayers[Player][Stat]=Value
	end
	StatService.Client.StatChanged:Fire(Player, {
		Stat = Stat,
		NewValue  = self.PlayerData.LoadedPlayers[Player][Stat]
	})
end

function StatService:KnitStart()
	self.PlayerData = Knit.GetService("PlayerData")
end

return StatService
