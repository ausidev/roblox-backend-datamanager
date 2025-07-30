--[[
This module is used to tell the client when the server is saving their data,
Its not needed but if you wanted to make a saving icon/text you could via this
]]

local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local DataController = Knit.CreateController{
	Name = "DataController"
}

function DataController:KnitStart()
	self.DataService = Knit.GetService("DataService")
	self.DataService.Saving:Connect(function()
		warn("Recieved client saving packet!")
	end)
	
	self.StatService = Knit.GetService("StatService")
	self.StatService.StatChanged:Connect(function(Data)
		print("Recieved stat changed packet!")
		for i, v in next, Data do
			print(i,v)
		end
	end)
end

return DataController
