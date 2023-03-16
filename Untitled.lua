--LEAKED BY ALLAHLEAKS
if not isfolder("Lith") then
    makefolder("Lith")
    makefolder("/Assets")
    makefolder("Lith/Sound")
    makefolder("Lith/Sound/mc")
end

        --defining the UiLib
        local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/UiLib.lua'))()

        --loading menu
        local Window = Rayfield:CreateWindow({
            Name = "Lithium",
            LoadingTitle = "~vine boom~",
            LoadingSubtitle = "Lithium",
            ConfigurationSaving = {
                Enabled = true,
                FolderName = "Lithium",
                FileName = "ConfigurationBedwars"
            },
            KeySystem = false,
            KeySettings = {
                Title = "Lithium",
                Subtitle = "Key Sys",
                Note = "Enter the key you were whitelisted with!",
                FileName = "KSNlknKLSkw20sKSskmlKSlilSmx",
                SaveKey = true,
                GrabKeyFromSite = false,
                Key = "Lith"
            }
        })

        --notifs
        --examples 
        --[[Notification.new("error", "Disabled", "modules has been disabled!.") -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        Notification.new("success", "Enabled", "modules has been enabled!.", 1) -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        Notification.new("info", "Disabling", "Disabling anticheat dont move.") -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        Notification.new("warning", "YOu died", "Imagine dying bozo.") -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        Notification.new("message", "Message Heading", "Message body message.") -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        ]]
        local Notification = loadstring(game:HttpGet('https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/Notifs.lua'))()

        --end of notifications

        --creating tabs
        --examples of tab - local Tab = Window:CreateTab("Tab Example", 4483362458) -- Title, Image
        local Combat = Window:CreateTab("Combat")
        local Blatant = Window:CreateTab("Blatant")
        local Visuals = Window:CreateTab("Visuals")
        --end of creating tabs

        --locals
        local lplr = game:GetService("Players").LocalPlayer
        local cam = game:GetService("Workspace").CurrentCamera
        local uis = game:GetService("UserInputService")
        local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
        local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
        local getremote = function(tab)
            for i,v in pairs(tab) do
                if v == "Client" then
                    return tab[i + 1]
                end
            end
            return ""
        end
        local bedwars = {
            ["SprintController"] = KnitClient.Controllers.SprintController,
            ["ClientHandlerStore"] = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
            ["KnockbackUtil"] = require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil,
            ["PingController"] = require(lplr.PlayerScripts.TS.controllers.game.ping["ping-controller"]).PingController,
            ["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
            ["SwordController"] = KnitClient.Controllers.SwordController,
            ["ViewmodelController"] = KnitClient.Controllers.ViewmodelController,
            ["SwordRemote"] = getremote(debug.getconstants((KnitClient.Controllers.SwordController).attackEntity)),
        }

        --functions
        function isalive(plr)
            plr = plr or lplr
            if not plr.Character then return false end
            if not plr.Character:FindFirstChild("Head") then return false end
            if not plr.Character:FindFirstChild("Humanoid") then return false end
            return true
        end
        function canwalk(plr)
            plr = plr or lplr
            if not plr.Character then return false end
            if not plr.Character:FindFirstChild("Humanoid") then return false end
            local state = plr.Character:FindFirstChild("Humanoid"):GetState()
            if state == Enum.HumanoidStateType.Dead then
                return false
            end
            if state == Enum.HumanoidStateType.Ragdoll then
                return false
            end
            return true
        end
        function getbeds()
            local beds = {}
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and v:FindFirstChild("Covers").Color ~= lplr.Team.TeamColor then
                    table.insert(beds,v)
                end
            end
            return beds
        end
        function getplayers()
            local players = {}
            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                if v.Team ~= lplr.Team and isalive(v) and v.Character:FindFirstChild("Humanoid").Health > 0.11 then
                    table.insert(players,v)
                end
            end
            return players
        end
        function getserverpos(Position)
            local x = math.round(Position.X/3)
            local y = math.round(Position.Y/3)
            local z = math.round(Position.Z/3)
            return Vector3.new(x,y,z)
        end
        function getnearestplayer(maxdist)
            local obj = lplr
            local dist = math.huge
            for i,v in pairs(game:GetService("Players"):GetChildren()) do
                if v.Team ~= lplr.Team and v ~= lplr and isalive(v) and isalive(lplr) then
                    local mag = (v.Character:FindFirstChild("HumanoidRootPart").Position - lplr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
                    if (mag < dist) and (mag < maxdist) then
                        dist = mag
                        obj = v
                    end
                end
            end
            return obj
        end
        function getmatchstate()
            return bedwars["ClientHandlerStore"]:getState().Game.matchState
        end
        function getqueuetype()
            local state = bedwars["ClientHandlerStore"]:getState()
            return state.Game.queueType or "bedwars_test"
        end
        function getitem(itm)
            if isalive(lplr) and lplr.Character:FindFirstChild("InventoryFolder").Value:FindFirstChild(itm) then
                return true
            end
            return false
        end

        local dwEntities = game:GetService("Players")
        local dwLocalPlayer = dwEntities.LocalPlayer 
        local dwRunService = game:GetService("RunService")

        local settings_tbl = {
            ESP_Enabled = true,
            ESP_TeamCheck = false,
            Chams = true,
            Chams_Color = Color3.fromRGB(93, 63, 211),
            Chams_Transparency = 0.3,
            Chams_Glow_Color = Color3.fromRGB(93, 63, 211)
        }

        function destroy_chams(char)

            for k,v in next, char:GetChildren() do 

                if v:IsA("BasePart") and v.Transparency ~= 1 then

                    if v:FindFirstChild("Glow") and 
                    v:FindFirstChild("Chams") then

                        v.Glow:Destroy()
                        v.Chams:Destroy() 

                    end

                end

            end

        end

        --[[dwRunService.Heartbeat:Connect(function()

            if settings_tbl.ESP_Enabled then

                for k,v in next, dwEntities:GetPlayers() do 

                    if v ~= dwLocalPlayer then

                        if v.Character and
                        v.Character:FindFirstChild("HumanoidRootPart") and 
                        v.Character:FindFirstChild("Humanoid") and 
                        v.Character:FindFirstChild("Humanoid").Health ~= 0 then

                            if settings_tbl.ESP_TeamCheck == false then

                                local char = v.Character 

                                for k,b in next, char:GetChildren() do 

                                    if b:IsA("BasePart") and 
                                    b.Transparency ~= 1 then
                                        
                                        if settings_tbl.Chams then

                                            if not b:FindFirstChild("Glow") and
                                            not b:FindFirstChild("Chams") then

                                                local chams_box = Instance.new("BoxHandleAdornment", b)
                                                chams_box.Name = "Chams"
                                                chams_box.AlwaysOnTop = true 
                                                chams_box.ZIndex = 4 
                                                chams_box.Adornee = b 
                                                chams_box.Color3 = settings_tbl.Chams_Color
                                                chams_box.Transparency = settings_tbl.Chams_Transparency
                                                chams_box.Size = b.Size + Vector3.new(0.02, 0.02, 0.02)

                                                local glow_box = Instance.new("BoxHandleAdornment", b)
                                                glow_box.Name = "Glow"
                                                glow_box.AlwaysOnTop = false 
                                                glow_box.ZIndex = 3 
                                                glow_box.Adornee = b 
                                                glow_box.Color3 = settings_tbl.Chams_Glow_Color
                                                glow_box.Size = chams_box.Size + Vector3.new(0.13, 0.13, 0.13)

                                            end

                                        else

                                            destroy_chams(char)

                                        end
                                    
                                    end

                                end

                            else

                                if v.Team == dwLocalPlayer.Team then
                                    destroy_chams(v.Character)
                                end

                            end

                        else

                            destroy_chams(v.Character)

                        end

                    end

                end

            else 

                for k,v in next, dwEntities:GetPlayers() do 

                    if v ~= dwLocalPlayer and 
                    v.Character and 
                    v.Character:FindFirstChild("HumanoidRootPart") and 
                    v.Character:FindFirstChild("Humanoid") and 
                    v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                        
                        destroy_chams(v.Character)

                    end

                end

            end

        end)]]

        -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
        --functions for notification_gui_library start
        function notify(type, heading, body, time)
            Notification.new(type, heading, body, time)
        end

        function disabled(heading, body, time)
            Notification.new("error", heading, body, time)
        end

        function enabled(heading, body, time)
            Notification.new("success", heading, body, time)
        end

        function warning(heading, body, time)
            Notification.new("warning", heading, body, time)
        end

        function info(heading, body, time)
            Notification.new("info", heading, body, time)
        end

        function message(heading, body, time)
            Notification.new("message", heading, body, time)
        end

        --end of functions

        --ArrayList

        local array = loadstring(game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/MemzwareAllahLeak/main/ArrayList.lua"))()
        shared["CometConfigs"] = {
            Enabled = true
        }

        --End of ArrayList

        --creating modules!

        --Visuals
        do
            Visuals:CreateSection("HUD")
            local Enabled = false
            local ArrayListToggle = Visuals:CreateToggle({
                Name = "ArrayList",
                CurrentValue = true,
                Flag = "ArrayListToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        enabled("ArrayList", "ArrayList has been set to enabled", 1)
                        shared["CometConfigs"] = {
                            Enabled = true
                        }
                    else
                        disabled("ArrayList", "ArrayList has been set to disabled", 1)
                        shared["CometConfigs"] = {
                            Enabled = false
                        }
                    end
                end
            })
        end

        do
            Visuals:CreateSection("Indicators")
            local Enabled = false
            local Messages = {"cry?", "Lithinum Power", ":skull"}
            local old
            local DamageIndicatorst = Visuals:CreateToggle({
                Name = "Custom Damage Indicators",
                CurrentValue = false,
                Flag = "CustomDamageIndicators",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("CustomDamageIndicators")
                        enabled("Indicators", "Indicators has been set to enabled", 1)
                        old = debug.getupvalue(bedwars["DamageIndicator"],10,{Create})
                        debug.setupvalue(bedwars["DamageIndicator"],10,{
                            Create = function(self,obj,...)
                                spawn(function()
                                    pcall(function()
                                        obj.Parent.Text = Messages[math.random(1,#Messages)]
                                        obj.Parent.TextColor3 = Color3.new(0.2, 0.2, 0.2)
                                    end)
                                end)
                                return game:GetService("TweenService"):Create(obj,...)
                            end
                        })
                    else
                        disabled("Indicators", "Indicators has been set to disabled", 1)
                        debug.setupvalue(bedwars["DamageIndicator"],10,{
                            Create = old
                        })
                        old = nil
                        array.Remove("CustomDamageIndicators")
                    end
                end
            })
        end

            local Enabled = false
            local CustomSound = Combat:CreateToggle({
                Name = "MC sounds",
                CurrentValue = false,
                Flag = "CustomSoundsToggle",
                Callback = function(val)
                    Enabled = val
                    if Enabled then
                        array.Add("MC sounds", "RektSky")
                        enabled("MC sounds", "MC sounds has been set to enabled!", 1)
                        local getasset = getsynasset or getcustomasset
                        local gamesound = require(game:GetService("ReplicatedStorage").TS.sound["game-sound"]).GameSound
                        lplr.leaderstats.Bed:GetPropertyChangedSignal("Value"):Connect(function()
                        if lplr.leaderstats.Bed.Value ~= "✅" then
                            local sound = Instance.new("Sound")
                            sound.Parent = workspace
                            writefile("Lith/Sound/mc/bedbroken.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/LithAllahLeak/main/bedbroken.mp3"))
                            sound.SoundId = getasset("Lith/Sound/mc/bedbroken.mp3") -- path to where ever the sound is in ur workspace
                            sound:Play()
                            wait(7)
                            sound:remove()
                        end
                        end)
                        spawn(function()
                            Client:WaitFor("BedwarsBedBreak"):andThen(function(p13)
                                p13:Connect(function(p14)
                                    local sound = Instance.new("Sound")
                                    sound.Parent = workspace
                                    writefile("Lith/Sound/mc/bedbreak.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/LithAllahLeak/main/bedbreak.mp3"))
                                    sound.SoundId = getasset("Lith/Sound/mc/bedbreak.mp3")-- path to where ever the sound is in ur workspace
                                    sound:Play()
                                    wait(4)
                                    sound:remove()
                                end)
                            end)
                        end)
                        local oldsounds = gamesound
                        local newsounds = gamesound
                        newsounds.UI_CLICK = "rbxassetid://535716488"
                        writefile("Lith/Sound/mc/pickup.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/LithAllahLeak/main/pickup.mp3"))
                        newsounds.PICKUP_ITEM_DROP = getasset("Lith/Sound/mc/pickup.mp3")
                        newsounds.KILL = "rbxassetid://1053296915"
                        newsounds.ERROR_NOTIFICATION = ""
                        newsounds.DAMAGE_1 = "rbxassetid://6361963422"
                        newsounds.DAMAGE = "rbxassetid://6361963422"
                        newsounds.DAMAGE_2 = "rbxassetid://6361963422"
                        newsounds.DAMAGE_3 = "rbxassetid://6361963422"
                        newsounds.SWORD_SWING_1 = ""
                        newsounds.SWORD_SWING_2 = ""
                        writefile("Lith/Sound/mc/buyitem.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/LithAllahLeak/main/buyitem.mp3"))
                        newsounds.BEDWARS_PURCHASE_ITEM = getasset("Lith/Sound/mc/buyitem.mp3")
                        newsounds.STATIC_HIT = "rbxassetid://6361963422"
                        newsounds.STONE_BREAK = "rbxassetid://6496157434"
                        writefile("Lith/Sound/mc/woolbreak.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/LithAllahLeak/main/woolbreak.mp3"))
                        newsounds.WOOL_BREAK = getasset("Lith/Sound/mc/woolbreak.mp3")
                        writefile("Lith/Sound/mc/breakwood.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/LithAllahLeak/main/breakwood.mp3"))
                        newsounds.WOOD_BREAK = getasset("Lith/Sound/mc/breakwood.mp3")
                        writefile("Lith/Sound/mc/glassbreak.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/LithAllahLeak/main/glassbreak.mp3"))
                        newsounds.GLASS_BREAK = getasset("Lith/Sound/mc/glassbreak.mp3")
                        writefile("Lith/Sound/mc/tnthiss.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/LithAllahLeak/main/tnthiss.mp3"))
                        newsounds.TNT_HISS_1 = getasset("Lith/Sound/mc/tnthiss.mp3")
                        writefile("Lith/Sound/mc/tntexplode.mp3",game:HttpGet("https://raw.githubusercontent.com/AllahbloxLeaks/LithAllahLeak/main/tntexplode.mp3"))
                        newsounds.TNT_EXPLODE_1 = getasset("Lith/Sound/mc/tntexplode.mp3")
                        gamesound = newsounds
                    else
                        array.Remove("MC sounds")
                        disabled("MC sounds", "MC sounds has been set to disabled", 1)
                    end
                end
            })
        end
