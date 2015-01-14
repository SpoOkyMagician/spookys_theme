-- ScreenStageInformation underlay

local t = Def.ActorFrame{
	Name="ScreenStageInformationUnderlayActorFrame";
	-- GLOBAL Function Theme Color
	refresh_color(),
	-- GLOBAL screen text
	common_text("Stage Information"),
	-- GLOBAL dark quad
	grid_t,
	-- stage text
	LoadFont("SpoOky")..{
		Text="Stage";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5;zoom,2.0;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			self:queuecommand('FindStage');
		end;
		FindStageCommand=function(self)
			local stage = GAMESTATE:GetCurrentStage();
			if stage == 'Stage_1st' then
				self:settext("Stage 1");
				last_known_stage = 'Stage_1st';
			elseif stage == 'Stage_2nd' then
				self:settext("Stage 2");
				last_known_stage = 'Stage_2nd'
			elseif stage == 'Stage_3rd' then
				self:settext("Stage 3");
				last_known_stage = 'Stage_3rd'
			elseif stage == 'Stage_4th' then
				self:settext("Stage 4");
				last_known_stage = 'Stage_4th'
			elseif stage == 'Stage_5th' then
				self:settext("Stage 5");
				last_known_stage = 'Stage_5th'
			elseif stage == 'Stage_6th' then
				self:settext("Stage 6");
				last_known_stage = 'Stage_6th'
			elseif stage == 'Stage_Next' then
				self:settext("Next Stage");
				last_known_stage = 'Stage_Next'
			elseif stage == 'Stage_Final' then
				self:settext("Final Stage");
				last_known_stage = 'Stage_Final'
			elseif stage == 'Stage_Extra1' then
				self:settext("Extra Stage");
				last_known_stage = 'Stage_Extra1'
			elseif stage == 'Stage_Extra2' then
				self:settext("Encore Extra Stage");
				last_known_stage = 'Stage_Extra2'
			elseif stage == 'Stage_Nonstop' then
				self:settext("Non Stop");
				last_known_stage = 'Stage_Nonstop'
			elseif stage == 'Stage_Oni' then
				self:settext("Oni");
				last_known_stage = 'Stage_Oni'
			elseif stage == 'Stage_Endless' then
				self:settext("Endless");
				last_known_stage = 'Stage_Endless'
			elseif stage == 'Stage_Event' then
				self:settext("Event");
				last_known_stage = 'Stage_Event'
			elseif stage == 'Stage_Demo' then
				self:settext("Demo");
				last_known_stage = 'Stage_Demo'
			else
				-- something went wrong...
				self:settext("ERROR!");
				last_known_stage = 'Stage_Event'
			end;
			self:finishtweening();
		end;
	}
};

return t;