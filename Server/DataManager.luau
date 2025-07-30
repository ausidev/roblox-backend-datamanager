local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local DataService = Knit.CreateService{
	Name = "DataService",
	Client = {
		Saving = Knit.CreateUnreliableSignal()
	}
}

local DataStoreService:DataStoreService = game:GetService("DataStoreService")
local Players:Players = game:GetService("Players")

local E_CODES = {
	[1] = "Data store not created or not fetched yet"
}
DataService.DataStores = {}

function DataService.get(name: string)
	if DataService.DataStores[name] then
		return DataService.DataStores[name]
	end
	DataService.DataStores[name] = DataStoreService:GetDataStore(name)
end


function DataService.getData(dataStoreName: string, key: string)
	local DataStore:DataStore = DataService.DataStores[dataStoreName]
	assert(DataStore, E_CODES[1])
	local data = nil
	local success, errorMessage = pcall(function()
		data = DataStore:GetAsync(key)
	end)
	if not success then
		return 1
	end
	return data
end

function DataService.update(dataStoreName: string, key: string, data: any)
	local DataStore: DataStore = DataService.DataStores[dataStoreName]
	assert(DataStore, E_CODES[1])
	
	local success, errorMessage = pcall(function()
		DataStore:SetAsync(key, data)
	end)
	if not success then
		return
	end
	
	if dataStoreName == "PlayerData" then
		local TargetPlayer = Players:GetPlayerByUserId(key)
		if not TargetPlayer then
			return
		end
		DataService.Client.Saving:Fire(TargetPlayer)
	end
end

return DataService
