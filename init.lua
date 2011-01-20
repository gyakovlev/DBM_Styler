local addon, ns = ...

-- safe functions if style is not loaded correctrly
local SkinBars=ns.dummy
local SkinBoss=ns.dummy
local SkinRange=ns.dummy
local f=CreateFrame"Frame"
f:RegisterEvent"VARIABLES_LOADED"
f:SetScript("OnEvent", function(self, event, addon)
	-- lookup style functions from namespace
	if ns.SkinBars and type(ns.SkinBars)=="function" then
		SkinBars=ns.SkinBars
	end
	if ns.SkinRange and type(ns.SkinRange)=="function" then
		SkinRange=ns.SkinRange
	end
	
	hooksecurefunc(DBT,"CreateBar", SkinBars)
	DBM.RangeCheck:Show()
	DBM.RangeCheck:Hide()
	DBMRangeCheck:HookScript("OnShow",SkinRange)
	self:UnregisterEvent"VARIABLES_LOADED"
end)

NS=ns
