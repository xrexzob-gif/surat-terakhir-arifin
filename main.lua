local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // SETTINGAN OWNER & KEY
local MyUsername = "tolongggggs" -- AKUN LO LANGSUNG TEMBUS
local CorrectKey = "XREX"

-- // LOGIKA AUTO-PASS
local UseKey = true
if game.Players.LocalPlayer.Name == MyUsername then
    UseKey = false
end

local Window = Rayfield:CreateWindow({
   Name = "XREXZOB",
   LoadingTitle = "Owner Detected: " .. MyUsername,
   LoadingSubtitle = "by XREXZOB Team",
   ConfigurationSaving = { Enabled = false },
   KeySystem = UseKey,
   KeySettings = {
      Title = "XREXZOB | PRIVATE ACCESS",
      Subtitle = "Key: XREX",
      Note = "Owner bypass aktif buat " .. MyUsername,
      FileName = "XREXKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {CorrectKey}
   }
})

-- // !!! LOGIKA PELANGI NGEBUT (RGB FLOW) - BALIK LAGI !!!
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

-- // TAB MOVEMENT
local TabMove = Window:CreateTab("Movement", 4483362458)

_G.WSValue = 16
TabMove:CreateSlider({
   Name = "Set Speed",
   Range = {0, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)
      _G.WSValue = v
      if _G.SpeedToggle then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end
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
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
      end)
   end,
})

-- // TAB PLAYER TOOLS (TP & NEMPEL)
local TabPlayer = Window:CreateTab("Player Tools", 4483362458)
local TargetName = ""

TabPlayer:CreateInput({
   Name = "Ketik Nama Player",
   PlaceholderText = "Nama/Username...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) TargetName = Text end,
})

TabPlayer:CreateButton({
   Name = "Teleport ke Player",
   Callback = function()
      for _, p in pairs(game.Players:GetPlayers()) do
         if string.find(string.lower(p.Name), string.lower(TargetName)) then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
            break
         end
      end
   end,
})

TabPlayer:CreateButton({
   Name = "Nempel (Carry Position)",
   Callback = function()
      _G.Nempel = true
      for _, p in pairs(game.Players:GetPlayers()) do
         if string.find(string.lower(p.Name), string.lower(TargetName)) then
            task.spawn(function()
               while _G.Nempel do
                  if p.Character and game.Players.LocalPlayer.Character then
                     game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0.5)
                  end
                  task.wait()
               end
            end)
            break
         end
      end
   end,
})

TabPlayer:CreateButton({
   Name = "Lepas Nempel",
   Callback = function() _G.Nempel = false end,
})

-- // TAB EMOTES
local TabEmote = Window:CreateTab("Emotes", 4483362458)
_G.EMSpeed = 1
_G.Track = nil

TabEmote:CreateSlider({
   Name = "Kecepatan Emote",
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
TabEmote:CreateButton({ Name = "STOP DANCE", Callback = function() if _G.Track then _G.Track:Stop() _G.Track:Destroy() _G.Track = nil end end })
