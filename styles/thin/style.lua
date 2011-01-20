----------------------
-- init style
local addon, ns = ...
-- name style
local name="thin"
table.insert(ns.styles, name)
-- make shure vars are available.
local f=CreateFrame"Frame"
f:RegisterEvent"VARIABLES_LOADED"
f:SetScript("OnEvent", function()
-- if not me when die
if not (DBM_StylerDB.style == name) then return end
----------------------

-- skin specific code
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/GetCVar("uiScale")
local function scale(x) return mult*math.floor(x+.5) end
local buttonsize=scale(30)
local font="Interface\\Addons\\DBM_Styler\\styles\\thin\\font.ttf"
local texture="Interface\\Addons\\DBM_Styler\\styles\\thin\\normTex.tga"
local backdrop={
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\Buttons\\WHITE8x8",
		tile = false, tileSize = 0, edgeSize = mult, 
		insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	}
local function SetTemplate(f)
	if f then
		f:SetBackdrop(backdrop)
		f:SetBackdropColor(.1,.1,.1,1)
		f:SetBackdropBorderColor(.3,.3,.3,1)
	end
end
-- timers
-- this will inject our code to all dbm bars.
function ns.SkinBars(self)
	for bar in self:GetBarIterator() do
		if not bar.injected then
				bar.ApplyStyle=function()
				local frame = bar.frame
				local tbar = _G[frame:GetName().."Bar"]
				local spark = _G[frame:GetName().."BarSpark"]
				local texture = _G[frame:GetName().."BarTexture"]
				local icon1 = _G[frame:GetName().."BarIcon1"]
				local icon2 = _G[frame:GetName().."BarIcon2"]
				local name = _G[frame:GetName().."BarName"]
				local timer = _G[frame:GetName().."BarTimer"]

				if (icon1.overlay) then
					icon1.overlay = _G[icon1.overlay:GetName()]
				else
					icon1.overlay = CreateFrame("Frame", "$parentIcon1Overlay", tbar)
					icon1.overlay:SetWidth(buttonsize)
					icon1.overlay:SetHeight(buttonsize)
					icon1.overlay:SetFrameStrata("BACKGROUND")
					icon1.overlay:SetPoint("BOTTOMRIGHT", tbar, "BOTTOMLEFT", -buttonsize/4, scale(-2))
					SetTemplate(icon1.overlay)					
				end

				if (icon2.overlay) then
					icon2.overlay = _G[icon2.overlay:GetName()]
				else
					icon2.overlay = CreateFrame("Frame", "$parentIcon2Overlay", tbar)
					icon2.overlay:SetWidth(buttonsize)
					icon2.overlay:SetHeight(buttonsize)
					icon2.overlay:SetFrameStrata("BACKGROUND")
					icon2.overlay:SetPoint("BOTTOMLEFT", tbar, "BOTTOMRIGHT", buttonsize/4, scale(-2))
					SetTemplate(icon2.overlay)
				end

				if bar.color then
					tbar:SetStatusBarColor(bar.color.r, bar.color.g, bar.color.b)
				else
					tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
				end
				
				if bar.enlarged then frame:SetWidth(scale(bar.owner.options.HugeWidth)) else frame:SetWidth(scale(bar.owner.options.Width)) end
				if bar.enlarged then tbar:SetWidth(scale(bar.owner.options.HugeWidth)) else tbar:SetWidth(scale(bar.owner.options.Width)) end

				frame:SetScale(1)
				if not frame.styled then
					frame:SetHeight(buttonsize/3)
					SetTemplate(frame)
					frame.styled=true
				end

				if not spark.killed then
					spark:SetAlpha(0)
					spark:SetTexture(nil)
					spark.killed=true
				end
	
				if not icon1.styled then
					icon1:SetTexCoord(0.08, 0.92, 0.08, 0.92)
					icon1:ClearAllPoints()
					icon1:SetPoint("TOPLEFT", icon1.overlay, scale(2), scale(-2))
					icon1:SetPoint("BOTTOMRIGHT", icon1.overlay, scale(-2), scale(2))
					icon1.styled=true
				end
				
				if not icon2.styled then
					icon2:SetTexCoord(0.08, 0.92, 0.08, 0.92)
					icon2:ClearAllPoints()
					icon2:SetPoint("TOPLEFT", icon2.overlay, scale(2), scale(-2))
					icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, scale(-2), scale(2))
					icon2.styled=true
				end

				if not texture.styled then
					texture:SetTexture(texture)
					texture.styled=true
				end

				if not tbar.styled then
					tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", scale(2), scale(-2))
					tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", scale(-2), scale(2))
					tbar.styled=true
				end

				if not name.styled then
					name:ClearAllPoints()
					name:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, scale(4))
					name:SetWidth(165)
					name:SetHeight(8)
					name:SetFont(font, 12, "OUTLINE")
					name:SetJustifyH("LEFT")
					name:SetShadowColor(0, 0, 0, 0)
					name.SetFont = ns.dummy
					name.styled=true
				end
				
				if not timer.styled then	
					timer:ClearAllPoints()
					timer:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", scale(-1), scale(2))
					timer:SetFont(font, 12, "OUTLINE")
					timer:SetJustifyH("RIGHT")
					timer:SetShadowColor(0, 0, 0, 0)
					timer.SetFont = ns.dummy
					timer.styled=true
				end

				if bar.owner.options.IconLeft then icon1:Show() icon1.overlay:Show() else icon1:Hide() icon1.overlay:Hide() end
				if bar.owner.options.IconRight then icon2:Show() icon2.overlay:Show() else icon2:Hide() icon2.overlay:Hide() end
				tbar:SetAlpha(1)
				frame:SetAlpha(1)
				texture:SetAlpha(1)
				frame:Show()
				bar:Update(0)
				bar.injected=true
			end
			bar:ApplyStyle()
		end

	end
end

-- range window
ns.SkinRange = function(self)
	SetTemplate(self)
end
f:UnregisterEvent"VARIABLES_LOADED"
end)
