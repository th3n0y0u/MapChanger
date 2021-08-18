local replicatedstorage = game:WaitForChild("ReplicatedStorage")
local minutesvalue = replicatedstorage:WaitForChild("Minutes")
local secondsvalue = replicatedstorage:WaitForChild("Seconds")
local minutes = 20
local seconds = 0

while wait() do
	
	if #game.Players:GetChildren() < 2 then
		game.Workspace.Lobby.SpawnLocation.Neutral = true
		repeat wait()
			for i, v in pairs(game.Players:GetChildren()) do
				v.PlayerGui:WaitForChild("TopGUI").Time.Text = "Waiting for more players..."
				wait(0.5)
				v.PlayerGui:WaitForChild("TopGUI").Time.Text = "Waiting for more players.." 
				wait(0.5)
			end 
		until #game.Players:GetChildren() >= 2
	end
	
	game.Workspace.Lobby.SpawnLocation.Neutral = false 
	for i, v in pairs(game.Workspace:GetChildren()) do
		if v:IsA("Folder") then
			v:Destroy()
		end
	end

	for i, v in pairs(game.Players:GetChildren()) do
		local character = v.Character
		character:BreakJoints()
	end

	local maps = game.ReplicatedStorage.Maps:GetChildren()
	local map = maps[math.random(1, #maps)]

	local clone = map:Clone()
	clone.Parent = game.Workspace
	
	while true do
		minutesvalue.Value = minutes
		secondsvalue.Value = seconds
		
		repeat wait(1)
			if secondsvalue.Value <= 0 then
				minutesvalue.Value -= 1
				secondsvalue.Value = 59
			else
				secondsvalue.Value -= 1
			end
		until secondsvalue.Value <= 0 and minutesvalue.Value <= 0 
		
		if secondsvalue.Value <= 0 and minutesvalue.Value <= 0 then
			for i, v in pairs(game.Players:GetChildren()) do
				local character = v.Character
				character:BreakJoints()
			end
			clone:Destroy()
			break
		end
		 
	end 
	
end
