local T, C, L, _ = unpack(select(2, ...))
if C.skins.dbm ~= true then return end

----------------------------------------------------------------------------------------
--	DBM skin(by Affli)
----------------------------------------------------------------------------------------
local backdrop = {
	bgFile = C.media.blank,
	insets = {left = 0, right = 0, top = 0, bottom = 0},
}

local DBMSkin = CreateFrame("Frame")
DBMSkin:RegisterEvent("PLAYER_LOGIN")
DBMSkin:RegisterEvent("ADDON_LOADED")
DBMSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("DBM-Core") then
		local function SkinBars(self)
			for bar in self:GetBarIterator() do
				if not bar.injected then
					bar.ApplyStyle = function()
						local frame = bar.frame
						local tbar = _G[frame:GetName().."Bar"]
						local spark = _G[frame:GetName().."BarSpark"]
						local texture = _G[frame:GetName().."BarTexture"]
						local icon1 = _G[frame:GetName().."BarIcon1"]
						local icon2 = _G[frame:GetName().."BarIcon2"]
						local name = _G[frame:GetName().."BarName"]
						local timer = _G[frame:GetName().."BarTimer"]

						if icon1.overlay then
							icon1.overlay = _G[icon1.overlay:GetName()]
						else
							icon1.overlay = CreateFrame("Frame", "$parentIcon1Overlay", tbar)
							icon1.overlay:SetWidth(25)
							icon1.overlay:SetHeight(25)
							icon1.overlay:SetFrameStrata("BACKGROUND")
							icon1.overlay:SetPoint("BOTTOMRIGHT", tbar, "BOTTOMLEFT", -5, -2)
							icon1.overlay:SetTemplate("Transparent")
						end

						if icon2.overlay then
							icon2.overlay = _G[icon2.overlay:GetName()]
						else
							icon2.overlay = CreateFrame("Frame", "$parentIcon2Overlay", tbar)
							icon2.overlay:SetWidth(25)
							icon2.overlay:SetHeight(25)
							icon2.overlay:SetFrameStrata("BACKGROUND")
							icon2.overlay:SetPoint("BOTTOMLEFT", tbar, "BOTTOMRIGHT", 5, -2)
							icon2.overlay:SetTemplate("Transparent")
						end

						if bar.color then
							tbar:SetStatusBarColor(bar.color.r, bar.color.g, bar.color.b)
							tbar:SetBackdrop(backdrop)
							tbar:SetBackdropColor(bar.color.r, bar.color.g, bar.color.b, 0.15)
						else
							tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
							tbar:SetBackdrop(backdrop)
							tbar:SetBackdropColor(unpack(C.skins.color_theme))
						end

						if bar.enlarged then frame:SetWidth(bar.owner.options.HugeWidth) else frame:SetWidth(bar.owner.options.Width) end
						if bar.enlarged then tbar:SetWidth(bar.owner.options.HugeWidth) else tbar:SetWidth(bar.owner.options.Width) end

						if not frame.styled then
							frame:SetScale(1)
							frame:SetHeight(19)
							frame:SetTemplate("Default")
							frame.styled = true
						end

						if not spark.killed then
							spark:SetAlpha(0)
							spark:SetTexture(nil)
							spark.killed = true
						end

						if not icon1.styled then
							icon1:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							icon1:ClearAllPoints()
							icon1:SetPoint("TOPLEFT", icon1.overlay, 2, -2)
							icon1:SetPoint("BOTTOMRIGHT", icon1.overlay, -2, 2)
							icon1.styled = true
						end

						if not icon2.styled then
							icon2:SetTexCoord(0.1, 0.9, 0.1, 0.9)
							icon2:ClearAllPoints()
							icon2:SetPoint("TOPLEFT", icon2.overlay, 2, -2)
							icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, -2, 2)
							icon2.styled = true
						end

						if not texture.styled then
							texture:SetTexture(C.media.texture)
							texture.styled = true
						end

						if not tbar.styled then
							tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
							tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
							tbar.styled = true
						end

						if not name.styled then
							name:ClearAllPoints()
							name:SetPoint("LEFT", frame, "LEFT", 4, 0)
							name:SetWidth(165)
							name:SetHeight(8)
							name:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
							name:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
							name:SetJustifyH("LEFT")
							name.SetFont = T.dummy
							name.styled = true
						end

						if not timer.styled then
							timer:ClearAllPoints()
							timer:SetPoint("RIGHT", frame, "RIGHT", -1, 0)
							timer:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
							timer:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
							timer:SetJustifyH("RIGHT")
							timer.SetFont = T.dummy
							timer.styled = true
						end

						if bar.owner.options.IconLeft then icon1:Show() icon1.overlay:Show() else icon1:Hide() icon1.overlay:Hide() end
						if bar.owner.options.IconRight then icon2:Show() icon2.overlay:Show() else icon2:Hide() icon2.overlay:Hide() end
						tbar:SetAlpha(1)
						frame:SetAlpha(1)
						texture:SetAlpha(1)
						frame:Show()
						bar:Update(0)
						bar.injected = true
					end
					bar:ApplyStyle()
					bar.ApplyPosition = function()
						if C.unitframe.enable ~= true then return end
						self.mainAnchor:ClearAllPoints()
						if bar.owner.options.IconRight then
							self.mainAnchor:SetPoint("BOTTOMRIGHT", "oUF_Player", "BOTTOMLEFT", -127, -69)
						else
							self.mainAnchor:SetPoint("BOTTOMRIGHT", "oUF_Player", "BOTTOMLEFT", -99, -69)
						end
					end
					bar:ApplyPosition()
				end
			end
		end

		local SkinBossTitle = function()
			local anchor = DBMBossHealthDropdown:GetParent()
			if not anchor.styled then
				local header = {anchor:GetRegions()}
				if header[1]:IsObjectType("FontString") then
					header[1]:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
					header[1]:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
					header[1]:SetTextColor(1, 1, 1, 1)
					anchor.styled = true
				end
				header = nil
			end
			anchor = nil
		end

		local SkinBoss = function()
			local count = 1
			while (_G[format("DBM_BossHealth_Bar_%d", count)]) do
				local bar = _G[format("DBM_BossHealth_Bar_%d", count)]
				local background = _G[bar:GetName().."BarBorder"]
				local progress = _G[bar:GetName().."Bar"]
				local name = _G[bar:GetName().."BarName"]
				local timer = _G[bar:GetName().."BarTimer"]
				local prev = _G[format("DBM_BossHealth_Bar_%d", count-1)]

				if count == 1 then
					local _, anch = bar:GetPoint()
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("BOTTOM", anch, "TOP", 0, 3)
					else
						bar:SetPoint("TOP", anch, "BOTTOM", 0, -3)
					end
				else
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("BOTTOMLEFT", prev, "TOPLEFT", 0, 3)
					else
						bar:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -3)
					end
				end

				if not bar.styled then
					bar:SetScale(1)
					bar:SetHeight(19)
					bar:SetTemplate("Default")
					background:SetNormalTexture(nil)
					bar.styled = true
				end

				if not progress.styled then
					progress:SetStatusBarTexture(C.media.texture)
					progress:SetBackdrop(backdrop)
					progress:SetBackdropColor(T.color.r, T.color.g, T.color.b, 0.2)
					progress.styled = true
				end
				progress:ClearAllPoints()
				progress:SetPoint("TOPLEFT", bar, "TOPLEFT", 2, -2)
				progress:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -2, 2)

				if not name.styled then
					name:ClearAllPoints()
					name:SetPoint("LEFT", bar, "LEFT", 4, 0)
					name:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
					name:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
					name:SetJustifyH("LEFT")
					name.styled = true
				end

				if not timer.styled then
					timer:ClearAllPoints()
					timer:SetPoint("RIGHT", bar, "RIGHT", -1, 0)
					timer:SetFont(C.font.stylization_font, C.font.stylization_font_size, C.font.stylization_font_style)
					timer:SetShadowOffset(C.font.stylization_font_shadow and 1 or 0, C.font.stylization_font_shadow and -1 or 0)
					timer:SetJustifyH("RIGHT")
					timer.styled = true
				end
				count = count + 1
			end
		end

		hooksecurefunc(DBT, "CreateBar", SkinBars)
		hooksecurefunc(DBM.BossHealth, "Show", SkinBossTitle)
		hooksecurefunc(DBM.BossHealth, "AddBoss", SkinBoss)
		hooksecurefunc(DBM.BossHealth, "UpdateSettings", SkinBoss)

		hooksecurefunc(DBM.RangeCheck, "Show", function()
			DBMRangeCheck:SetTemplate("Transparent")
			if DBMRangeCheckRadar then
				DBMRangeCheckRadar:SetTemplate("Transparent")
			end
		end)

		hooksecurefunc(DBM.InfoFrame, "Show", function()
			DBMInfoFrame:SetTemplate("Transparent")
		end)

		local replace = string.gsub
		local old = RaidNotice_AddMessage
		RaidNotice_AddMessage = function(noticeFrame, textString, colorInfo)
			if textString:find(" |T") then
				textString = replace(textString,"(:12:12)",":13:13:0:0:64:64:5:59:5:59")
			end
			return old(noticeFrame, textString, colorInfo)
		end
	end
	if IsAddOnLoaded("DBM-GUI") then
		tinsert(UISpecialFrames, "DBM_GUI_OptionsFrame")
		_G["DBM_GUI_OptionsFrame"]:SetTemplate("Transparent")
		_G["DBM_GUI_OptionsFramePanelContainer"]:SetTemplate("Overlay")

		_G["DBM_GUI_OptionsFrameTab1"]:StripTextures()
		_G["DBM_GUI_OptionsFrameTab1"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameTab1"]:SetPoint("TOPLEFT", _G["DBM_GUI_OptionsFrameBossMods"], "TOPLEFT", 10, 27)
		_G["DBM_GUI_OptionsFrameTab2"]:StripTextures()
		_G["DBM_GUI_OptionsFrameTab2"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameTab2"]:SetPoint("TOPLEFT", _G["DBM_GUI_OptionsFrameTab1"], "TOPRIGHT", 6, 0)

		_G["DBM_GUI_OptionsFrameBossMods"]:HookScript("OnShow", function(self) self:SetTemplate("Overlay") end)
		_G["DBM_GUI_OptionsFrameDBMOptions"]:HookScript("OnShow", function(self) self:SetTemplate("Overlay") end)
		_G["DBM_GUI_OptionsFrameHeader"]:SetTexture("")
		_G["DBM_GUI_OptionsFrameHeader"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameHeader"]:SetPoint("TOP", DBM_GUI_OptionsFrame, 0, 7)

		local dbmbskins = {
			"DBM_GUI_OptionsFrameOkay",
			"DBM_GUI_OptionsFrameTab1",
			"DBM_GUI_OptionsFrameTab2"
		}

		for i = 1, getn(dbmbskins) do
			local buttons = _G[dbmbskins[i]]
			if buttons then
				buttons:SkinButton()
			end
		end
	end
end)

----------------------------------------------------------------------------------------
--	DBM settings(by ALZA and help from Affli)
----------------------------------------------------------------------------------------
function T.UploadDBM()
	DBM_SavedOptions.Enabled = true
	DBM_SavedOptions.ShowMinimapButton = C.skins.minimap_buttons and true or false
	DBM_SavedOptions.WarningIconLeft = false
	DBM_SavedOptions.WarningIconRight = false
	DBM_SavedOptions["WarningColors"] = {
		{["b"] = 1.0, ["g"] = 1.0, ["r"] = 1.0,},
		{["b"] = 1.0, ["g"] = 1.0, ["r"] = 1.0,},
		{["b"] = 1.0, ["g"] = 1.0, ["r"] = 1.0,},
		{["b"] = 1.0, ["g"] = 1.0, ["r"] = 1.0,},
	}
	DBM_SavedOptions.HealthFrameGrowUp = false
	DBM_SavedOptions.HealthFrameWidth = 218
	DBM_SavedOptions.HPFrameX = 100
	DBM_SavedOptions.HPFramePoint = "LEFT"
	DBM_SavedOptions.RangeFrameX = 244
	DBM_SavedOptions.RangeFramePoint = "LEFT"
	DBM_SavedOptions.ShowSpecialWarnings = true
	DBM_SavedOptions.SpecialWarningFont = C.media.normal_font
	DBM_SavedOptions.SpecialWarningFontSize = 50
	DBM_SavedOptions.SpecialWarningX = 0
	DBM_SavedOptions.SpecialWarningY = 75

	DBT_SavedOptions["DBM"].StartColorR = C.unitframe.uf_color[1]
	DBT_SavedOptions["DBM"].StartColorG = C.unitframe.uf_color[2]
	DBT_SavedOptions["DBM"].StartColorB = C.unitframe.uf_color[3]
	DBT_SavedOptions["DBM"].EndColorR = C.unitframe.uf_color[1]
	DBT_SavedOptions["DBM"].EndColorG = C.unitframe.uf_color[2]
	DBT_SavedOptions["DBM"].EndColorB = C.unitframe.uf_color[3]
	DBT_SavedOptions["DBM"].Scale = 1
	DBT_SavedOptions["DBM"].HugeScale = 1
	DBT_SavedOptions["DBM"].BarXOffset = 0
	DBT_SavedOptions["DBM"].BarYOffset = 7
	DBT_SavedOptions["DBM"].Font = C.font.stylization_font
	DBT_SavedOptions["DBM"].FontSize = C.font.stylization_font_size
	DBT_SavedOptions["DBM"].Width = 189
	DBT_SavedOptions["DBM"].TimerX = 143
	DBT_SavedOptions["DBM"].TimerPoint = "BOTTOMLEFT"
	DBT_SavedOptions["DBM"].FillUpBars = true
	DBT_SavedOptions["DBM"].IconLeft = true
	DBT_SavedOptions["DBM"].ExpandUpwards = true
	DBT_SavedOptions["DBM"].Texture = C.media.texture
	DBT_SavedOptions["DBM"].IconRight = false
	DBT_SavedOptions["DBM"].HugeBarXOffset = 0
	DBT_SavedOptions["DBM"].HugeBarsEnabled = false
	DBT_SavedOptions["DBM"].HugeWidth = 189
	DBT_SavedOptions["DBM"].HugeTimerX = 7
	DBT_SavedOptions["DBM"].HugeTimerPoint = "CENTER"
	DBT_SavedOptions["DBM"].HugeBarYOffset = 7

	if C.actionbar.bottombars == 1 then
		DBM_SavedOptions.HPFrameY = 126
		DBM_SavedOptions.RangeFrameY = 101
		DBT_SavedOptions["DBM"].TimerY = 139
		DBT_SavedOptions["DBM"].HugeTimerY = -136
	elseif C.actionbar.bottombars == 2 then
		DBM_SavedOptions.HPFrameY = 154
		DBM_SavedOptions.RangeFrameY = 129
		DBT_SavedOptions["DBM"].TimerY = 167
		DBT_SavedOptions["DBM"].HugeTimerY = -108
	elseif C.actionbar.bottombars == 3 then
		DBM_SavedOptions.HPFrameY = 182
		DBM_SavedOptions.RangeFrameY = 157
		DBT_SavedOptions["DBM"].TimerY = 195
		DBT_SavedOptions["DBM"].HugeTimerY = -80
	end
	DBM_SavedOptions.InstalledBars = C.actionbar.bottombars
end

StaticPopupDialogs.SETTINGS_DBM = {
	text = L_POPUP_SETTINGS_DBM,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() T.UploadDBM() ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 5,
}

----------------------------------------------------------------------------------------
--	On logon function
----------------------------------------------------------------------------------------
local OnLogon = CreateFrame("Frame")
OnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
OnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	if IsAddOnLoaded("DBM-Core") then
		if DBM_SavedOptions.InstalledBars ~= C.actionbar.bottombars then
			StaticPopup_Show("SETTINGS_DBM")
		end
	end
end)