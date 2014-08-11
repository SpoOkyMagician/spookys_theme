local t = Def.ActorFrame{
	-- screen text
	LoadFont("SpoOky")..{
		Text="Title Screen | Select Profile | Select Style | Select Game Mode | Select Music | Select Player Options | Select Song Options | Stage |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	-- stage text
	LoadFont("SpoOky")..{
		Text="Stage";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5;zoom,2.0);
		OnCommand=function(self)
			self:queuecommand('FindStage');
		end;
		FindStageCommand=function(self)
			local stage = GAMESTATE:GetCurrentStage();
			if stage == 'Stage_1st' then
				self:settext("Stage 1");
			elseif stage == 'Stage_2nd' then
				self:settext("Stage 2");
			elseif stage == 'Stage_3rd' then
				self:settext("Stage 3");
			elseif stage == 'Stage_4th' then
				self:settext("Stage 4");
			elseif stage == 'Stage_5th' then
				self:settext("Stage 5");
			elseif stage == 'Stage_6th' then
				self:settext("Stage 6");
			elseif stage == 'Stage_Next' then
				self:settext("Next Stage");
			elseif stage == 'Stage_Final' then
				self:settext("Final Stage");
			elseif stage == 'Stage_Extra1' then
				self:settext("Extra Stage");
			elseif stage == 'Stage_Extra2' then
				self:settext("Encore Extra Stage");
			elseif stage == 'Stage_Nonstop' then
				self:settext("Non Stop");
			elseif stage == 'Stage_Oni' then
				self:settext("Oni");
			elseif stage == 'Stage_Endless' then
				self:settext("Endless");
			elseif stage == 'Stage_Event' then
				self:settext("Event");
			elseif stage == 'Stage_Demo' then
				self:settext("Demo");
			else
				-- something went wrong...
				self:settext("ERROR!");
			end;
		end;
	}
};

return t;