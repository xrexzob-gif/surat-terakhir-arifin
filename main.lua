local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // SETTINGAN OWNER & KEY
local MyUsername = "tolongggggs" -- GANTI JADI USERNAME ROBLOX LO!
local CorrectKey = "XREX" -- Key buat orang lain

-- // LOGIKA AUTO-PASS (Cek Nama Akun)
local UseKey = true
if game.Players.LocalPlayer.Name == MyUsername then
    UseKey = false -- Lo langsung masuk tanpa nanya key
end

-- // WINDOW UTAMA
local Window = Rayfield:CreateWindow({
   Name = "XREXZOB",
   LoadingTitle = "Verifying Owner Access...",
   LoadingSubtitle = "by XREXZOB Team",
   ConfigurationSaving = { Enabled = false },
   KeySystem = UseKey,
   KeySettings = {
      Title = "XREXZOB | PRIVATE ACCESS",
      Subtitle = "Key: XREX",
      Note = "Owner bypass active for: " .. MyUsername,
      FileName = "XREXKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {CorrectKey}
   }
})

-- // !!! LOGIKA PELANGI NGEBUT (RGB FLOW) !!!
local function applyFlow(obj)
    if not obj:FindFirstChild("NeonFlow") then
        local gradient = Instance.new("UIGradient")
        gradient.Name = "NeonFlow"
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        })
        gradient.Parent = obj
    end
end

task.spawn(function()
    local offset = 0
    while task.wait() do 
        offset = offset + 0.05
        if offset >= 1 then offset = 0 end
        for _, v in pairs(game.CoreGui:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("UIStroke") then
                applyFlow(v)
                local f = v:FindFirstChild("NeonFlow")
                if f then f.Offset = Vector2.new(-offset, 0) end
            end
        end
    end
end)

-- // TAB MOVEMENT (DENGAN SPEED SLIDER)
local TabMove = Window:CreateTab("Movement", 4483362458)

_G.WSValue = 16
TabMove:CreateSlider({
   Name = "Set Speed (Slider)",
   Range = {0, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)
      _G.WSValue = v
      if _G.SpeedToggle and game.Players.LocalPlayer.Character then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
      end
   end,
})

TabMove:CreateToggle({
   Name = "Aktifkan Speed",
   CurrentValue = false,
   Callback = function(v)
      _G.SpeedToggle = v
      task.spawn(function()
         while _G.SpeedToggle do
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.WSValue
            end
            task.wait(0.1)
         end
         if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
         end
      end)
   end,
})

TabMove:CreateToggle({
   Name = "Fly (Terbang)",
   CurrentValue = false,
   Callback = function(v)
      _G.Flying = v
      local char = game.Players.LocalPlayer.Character
      local root = char:WaitForChild("HumanoidRootPart")
      if v then
         local bv = Instance.new("BodyVelocity", root)
         bv.Name = "XREXFly"
         bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         task.spawn(function()
            while _G.Flying do
               bv.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 100
               task.wait()
            end
            bv:Destroy()
         end)
      else
         if root:FindFirstChild("XREXFly") then root.XREXFly:Destroy() end
      end
   end,
})

-- // TAB EMOTES (HYPE & OLD SCHOOL)
local TabEmote = Window:CreateTab("Emotes", 4483362458)

_G.EMSpeed = 1
_G.Track = nil

TabEmote:CreateSlider({
   Name = "Kecepatan Joget",
   Range = {0, 20},
   Increment = 0.5,
   CurrentValue = 1,
   Callback = function(v) _G.EMSpeed = v end,
})

local function PlayEm(id)
    local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if _G.Track then _G.Track:Stop() _G.Track:Destroy() end
    local a = Instance.new("Animation")
    a.AnimationId = "rbxassetid://"..id
    _G.Track = hum:LoadAnimation(a)
    _G.Track.Looped = true
    _G.Track:Play()
    task.spawn(function()
        while _G.Track do
            _G.Track:AdjustSpeed(_G.EMSpeed)
            task.wait(0.1)
        end
    end)
end

TabEmote:CreateButton({ Name = "Hype Dance", Callback = function() PlayEm("3695333486") end })
TabEmote:CreateButton({ Name = "Old School", Callback = function() PlayEm("3333499508") end })
TabEmote:CreateButton({ 
    Name = "STOP DANCE", 
    Callback = function() 
        if _G.Track then _G.Track:Stop() _G.Track:Destroy() _G.Track = nil end 
    end 
})
