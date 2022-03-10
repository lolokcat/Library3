local Library = {}

local function CheckIfLoaded()
    local function IsLoaded()
      if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Lib") then 
        return true
      else
        return false
      end
    end
    if IsLoaded() then 
      game.Players.LocalPlayer.PlayerGui:FindFirstChild("Lib"):Destroy()
    end
end

CheckIfLoaded()

function Library:Construct(name)
    local function Default()
        name = name or "Mogus Hub"
    end
    Default()
    local internal = {
        loadguiasset = function(Id, Parent)
		    local enc = false
		    local object
			local succ, err = pcall(function()
				local Loaded = game:GetObjects("rbxassetid://"..Id)[1]
				Loaded.Parent = Parent
				object = Loaded
				enc = true
			end)
			if succ and enc ~= false then 
				return object
			else
			    warn(err)
			    return false
			end
		end;
		tweenasset = function(asset, propertiestable, info)
			local Tween = game:GetService("TweenService")
			local T = Tween:Create(asset, info, propertiestable)
			
			T:Play()
		end;
	}
	local Lib = internal.loadguiasset(9062053213, game.Players.LocalPlayer.PlayerGui)
	Lib.Loader.Hello.Text = "Hello, "..game.Players.LocalPlayer.Name 
	Lib.Loader.HubName.Text = name 
	local function Intro()
	    local times = 0
	    
	    spawn(function()
	        local ToRot = Lib.Loader.polymer
	        while times < 6 do wait()
	            ToRot.Rotation = ToRot.Rotation + 1 * 2
	        end 
	    end)
	    
	    while times < 6 do
	        times = times + 1
	        local Label = Lib.Loader.NowLoading
	        Label.Text = "Now Loading."
	        wait(0.1)
	        Label.Text = "Now Loading.."
	        wait(0.1)
	        Label.Text = "Now Loading..."
	        wait(0.1)
	    end
	    
	    Lib.Loader.Visible = false
	    Lib.Main.Visible = true
	end 
	
    Intro()
    
    local TabLibrary = {
        new = function(name)
            name = name or "Button"
            local Page = internal.loadguiasset(9057623746, Lib.Main.Pages)
            local TabButton = internal.loadguiasset(9057919587, Lib.Main.Tabs)
            
            Page.Visible = false
            
            local function UpdateSize() 
                wait() 
                local contentsize = Page.UIListLayout.AbsoluteContentSize
                Page.CanvasSize = UDim2.new(0,contentsize.X,0,contentsize.Y)
            end
                                        
            Page.ChildAdded:Connect(UpdateSize)
            
            TabButton.T.Text = name
            
            TabButton.MouseButton1Down:Connect(function()
                for index,page in next,Lib.Main.Pages:GetChildren() do
                    page.Visible = false
                end
                Page.Visible = true
            end)
            
            local ElementLibrary = {
                new = function(type, name, description, callback, options)
                    local function newButton(name, description, callback)
                        local Button = internal.loadguiasset(9057870190, Page)
                        Button:WaitForChild("J").Text = name
                        Button:WaitForChild("Description").Text = description
                        
                        internal.tweenasset(Button, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, TweenInfo.new(0.3))
                        
                        Button.MouseButton1Down:Connect(function()
                            callback()
                        end)
                        Button.MouseEnter:Connect(function()
                            internal.tweenasset(Button, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, TweenInfo.new(0.3))
                        end)
                        Button.MouseLeave:Connect(function()
                            internal.tweenasset(Button, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, TweenInfo.new(0.3))
                        end)
                    end
                    local function newToggle(name, description, callback)
                        local Toggle = internal.loadguiasset(9057928325, Page) 
                        local tog = false
                        Toggle:WaitForChild("Name").Text = name
                        Toggle:WaitForChild("Description").Text = description
                        Toggle.MouseButton1Down:Connect(function()
                            tog = not tog 
                            if tog == true then 
                                internal.tweenasset(Toggle.Frame, {BackgroundTransparency = 0.5}, TweenInfo.new(0.3))
                                internal.tweenasset(Toggle.Frame1, {BackgroundTransparency = 0}, TweenInfo.new(0.3))
                            else
                                internal.tweenasset(Toggle.Frame, {BackgroundTransparency = 0.5}, TweenInfo.new(0.3))
                                internal.tweenasset(Toggle.Frame1, {BackgroundTransparency = 0.5}, TweenInfo.new(0.3))
                            end
                            callback(tog)
                        end)
                        Toggle.MouseEnter:Connect(function()
                            internal.tweenasset(Toggle, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, TweenInfo.new(0.3))
                        end)
                        Toggle.MouseLeave:Connect(function()
                            internal.tweenasset(Toggle, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, TweenInfo.new(0.3))
                        end)
                    end
                    local function newDropDown(name, description, callback, options)
                        local DropdownButton = internal.loadguiasset(9062156461, Page) 
                        local DropdownFrame = internal.loadguiasset(9061933159, Lib.Main.Frame)
                        
                        local function UpdateSize() 
                            wait() 
                            local contentsize = DropdownFrame.Container.UIListLayout.AbsoluteContentSize
                            DropdownFrame.Container.CanvasSize = UDim2.new(0,contentsize.X,0,contentsize.Y)
                        end
                                                
                        DropdownFrame.Container.ChildAdded:Connect(UpdateSize)
                        
                        DropdownFrame.Visible = false
                        
                        DropdownButton:WaitForChild("Name").Text = name
                        DropdownButton:WaitForChild("Description").Text = description
                        
                        local Container = DropdownFrame.Container
                        
                        local Selected = DropdownButton:WaitForChild("Selected")
                        
                        local Toggled = false
                        
                        DropdownButton.MouseButton1Down:Connect(function()
                            Toggled = not Toggled
                            if Toggled == true then
                                for i,v in pairs(DropdownButton:GetChildren()) do 
                                    if v:IsA("TextLabel") then 
                                        internal.tweenasset(v, {TextColor3 = Color3.fromRGB(203, 108, 30)}, TweenInfo.new(0.3))
                                    end
                                end
                                DropdownFrame.Visible = true
                            else
                                for i,v in pairs(DropdownButton:GetChildren()) do 
                                    if v:IsA("TextLabel") then 
                                        internal.tweenasset(v, {TextColor3 = Color3.fromRGB(154, 154, 154)}, TweenInfo.new(0.3))
                                    end
                                end
                                DropdownFrame.Visible = false
                            end
                        end)
                        
                        for index,option in pairs(options) do 
                            local Option = internal.loadguiasset(9061999036, Container)
                            Option:WaitForChild("Name").Text = option 
                            
                            Option.MouseButton1Down:Connect(function()
                                callback(option)
                                Selected.Text = "Selected: "..option
                            end)
                        end
                        
                        DropdownButton.MouseEnter:Connect(function()
                            internal.tweenasset(DropdownButton, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, TweenInfo.new(0.3))
                        end)
                        DropdownButton.MouseLeave:Connect(function()
                            internal.tweenasset(DropdownButton, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, TweenInfo.new(0.3))
                        end)
                    end
                    local function newTextBox(name, description, callback)
                        local Textbox = internal.loadguiasset(9062192492, Page) 
                        
                        Textbox:WaitForChild("Name").Text = name 
                        Textbox:WaitForChild("Description").Text = description
                        
                        Textbox.TextBox.FocusLost:Connect(function(enterPressed)
                            if enterPressed then 
                                callback(Textbox.TextBox.Text)
                            end
                        end)
                        
                        Textbox.MouseEnter:Connect(function()
                            internal.tweenasset(Textbox, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, TweenInfo.new(0.3))
                        end)
                        Textbox.MouseLeave:Connect(function()
                            internal.tweenasset(Textbox, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, TweenInfo.new(0.3))
                        end)
                    end
                    if type == "Button" then 
                        if not name or not callback or not description then 
                            return
                        else 
                            newButton(name, description, callback)
                        end
                    elseif type == "Toggle" then 
                        if not name or not callback or not description then 
                            return
                        else
                            newToggle(name, description, callback)
                        end
                    elseif type == "Dropdown" then 
                        if not name or not callback or not description or not options then
                            return 
                        else
                            newDropDown(name, description, callback, options)
                        end 
                    elseif type == "Textbox" then 
                        if not name or not callback or not description then 
                            return 
                        else
                            newTextBox(name, description, callback)
                        end 
                    end
                end;
            };
            return ElementLibrary
        end;
    };
    return TabLibrary
end
return Library
