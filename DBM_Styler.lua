local addon, ns = ...

-- some basic functions used by all styles
ns.dummy=function()end

--
ns.styles={}

-- options frame
local frame = CreateFrame("Frame", "DBM_Styler")
frame.name = "DBM Styler"
InterfaceOptions_AddCategory(frame)

-- set default style on first launch
if not DBM_StylerDB then
	DBM_StylerDB={
	["style"] = "thin",
	}
end
