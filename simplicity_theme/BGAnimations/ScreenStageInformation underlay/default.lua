-- ScreenStageInformation underlay
-- Kyzentun: THEME:GetString('ScreenStageInformation', 'foo')"

local t = Def.ActorFrame{
	Name="ScreenStageInformationUnderlayActorFrame";
	-- Function (scripts)
	common_text("Stage Information"),
	-- Actor (scripts)
	grid_t,
	-- Actor (Stage Text)
	LoadFont("Common","normal")..{
		Text="Stage";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5;zoom,2.0;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand('FindStage');
		end;
		FindStageCommand=function(self)
			local stage = GAMESTATE:GetCurrentStage();
			if stage == 'Stage_1st' then
				self:settext(THEME:GetString('ScreenStageInformation', "First Stage"));
				last_known_stage = 'Stage_1st';
			elseif stage == 'Stage_2nd' then
				self:settext(THEME:GetString('ScreenStageInformation', "Second Stage"));
				last_known_stage = 'Stage_2nd'
			elseif stage == 'Stage_3rd' then
				self:settext(THEME:GetString('ScreenStageInformation', "Third Stage"));
				last_known_stage = 'Stage_3rd'
			elseif stage == 'Stage_4th' then
				self:settext(THEME:GetString('ScreenStageInformation', "Fourth Stage"));
				last_known_stage = 'Stage_4th'
			elseif stage == 'Stage_5th' then
				self:settext(THEME:GetString('ScreenStageInformation', "Fifth Stage"));
				last_known_stage = 'Stage_5th'
			elseif stage == 'Stage_6th' then
				self:settext(THEME:GetString('ScreenStageInformation', "Sixth Stage"));
				last_known_stage = 'Stage_6th'
			elseif stage == 'Stage_Next' then
				self:settext(THEME:GetString('ScreenStageInformation', "Next Stage"));
				last_known_stage = 'Stage_Next'
			elseif stage == 'Stage_Final' then
				self:settext(THEME:GetString('ScreenStageInformation', "Final Stage"));
				last_known_stage = 'Stage_Final'
			elseif stage == 'Stage_Extra1' then
				self:settext(THEME:GetString('ScreenStageInformation', "Extra Stage"));
				last_known_stage = 'Stage_Extra1'
			elseif stage == 'Stage_Extra2' then
				self:settext(THEME:GetString('ScreenStageInformation', "Encore Extra Stage"));
				last_known_stage = 'Stage_Extra2'
			elseif stage == 'Stage_Event' then
				self:settext(THEME:GetString('ScreenStageInformation', "Event"));
				last_known_stage = 'Stage_Event'
			else
				self:settext(ScreenString("ERROR"));
				last_known_stage = 'Stage_Event'
			end;
			self:finishtweening();
		end;
	}
};

return t;