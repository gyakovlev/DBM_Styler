local addon, ns = ...

-- some basic functions used by all styles
ns.dummy=function()end
ns.print=function(text)
	print("|cffFF5555DBM|r Styler:", tostring(text))
end
-- create table for style list
ns.styles={}

-- set default style on first launch
if not DBM_StylerDB then
	DBM_StylerDB={
	["style"] = "thin",
	}
end

-- options frame
local cfg = CreateFrame("Frame", "DBM_Styler")
cfg.name = "DBM Styler"


cfg.default=function()
	DBM_StylerDB.style="thin"
	ns.print("loaded default settings")
end
	
cfg.style=CreateFrame("Button", "$parent_SelectStyle", cfg, "UIDropDownMenuTemplate")
cfg.style:SetPoint("TOPRIGHT", 0, -10)
  
local function OnClick(self)
   UIDropDownMenu_SetSelectedID(cfg.style, self:GetID())
end
 
local function initialize(self, level)
   local info = UIDropDownMenu_CreateInfo()
   for k,v in pairs(ns.styles) do
      info = UIDropDownMenu_CreateInfo()
      info.text = v
      info.value = v
      info.func = OnClick
      UIDropDownMenu_AddButton(info, level)
   end
end
 
 
UIDropDownMenu_Initialize(cfg.style, initialize)
UIDropDownMenu_SetWidth(cfg.style, 100);
UIDropDownMenu_SetButtonWidth(cfg.style, 124)
UIDropDownMenu_SetSelectedID(cfg.style, 1)
UIDropDownMenu_JustifyText(cfg.style, "LEFT")





InterfaceOptions_AddCategory(cfg)
