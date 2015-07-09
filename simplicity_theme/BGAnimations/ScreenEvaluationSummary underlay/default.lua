-- ScreenEvaluationSummary underlay

local t = Def.ActorFrame{
	Name="ScreenEvaluationSummaryUnderlayActorFrame";
	-- Actor (song background)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:LoadBackground(last_known_background);
			self:stretchto(SCREEN_LEFT,SCREEN_TOP+32,SCREEN_RIGHT,SCREEN_BOTTOM-32);
		end;
	},
	-- Actor/Function (scripts)
	grid_c(),
	-- Actor/Function (scripts)
	common_text("Summary"),
	-- Actor (Results P1 Translation Text)
	LoadFont("Common", "normal")..{
		Text=ScreenString("Here are your results Player 1") .. "!" .. "\n\n" .. ScreenString("Grade") .. ":" .. "\n" .. ScreenString("Percent") .. ":" .. "\n\n" .. ScreenString("Flawless") .. ":" .. "\n" .. ScreenString("Perfects") .. ":" .. "\n" .. ScreenString("Greats") .. ":" .. "\n" .. ScreenString("Goods") .. ":" .. "\n" .. ScreenString("Bad") .. ":" .. "\n" .. ScreenString("Missed") .. ":" .. "\n" .. ScreenString("Held") .. ":" .. "\n" .. ScreenString("Released") .. ":" .. "\n" .. ScreenString("Combo") .. ":" .. "\n\n" .. ScreenString("Score") .. ":";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_BOTTOM/2;diffuse,color(theme_color);zoom,0.75;align,0,0.5;shadowlength,1);
	},
	-- Actor (Results P1 Actual Text)
	LoadFont("Common", "normal")..{
		Text="";
		InitCommand=cmd(x,SCREEN_RIGHT/2-8;y,SCREEN_BOTTOM/2;diffuse,color(theme_color);zoom,0.75;align,1,0.5;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand('ResultsP1B');
		end;
		ResultsP1BCommand=function(self)
			local results = STATSMAN:GetAccumPlayedStageStats();
			local tableresults = results:GetPlayerStageStats('PlayerNumber_P1');
			local points = tableresults:GetScore();
			local combo = tableresults:MaxCombo();
			local maxpoints = tableresults:GetCurMaxScore();
			local grade = STATSMAN:GetBestFinalGrade();
			local released = tableresults:GetHoldNoteScores('HoldNoteScore_LetGo');
			local held = tableresults:GetHoldNoteScores('HoldNoteScore_Held');
			local percent = tableresults:GetPercentDancePoints()*100;
			local flawless = tableresults:GetTapNoteScores('TapNoteScore_W1');
			local perfects = tableresults:GetTapNoteScores('TapNoteScore_W2');
			local greats = tableresults:GetTapNoteScores('TapNoteScore_W3');
			local goods = tableresults:GetTapNoteScores('TapNoteScore_W4');
			local bads = tableresults:GetTapNoteScores('TapNoteScore_W5');
			local misses = tableresults:GetTapNoteScores('TapNoteScore_Miss');
			local stringgrade = "X";
			if grade == 'Grade_Tier01' then
				stringgrade = "AAAA";
			elseif grade == 'Grade_Tier02' then
				stringgrade = "AAA";
			elseif grade == 'Grade_Tier03' then
				stringgrade = "AA";
			elseif grade == 'Grade_Tier04' then
				stringgrade = "A";
			elseif grade == 'Grade_Tier05' then
				stringgrade = "B";
			elseif grade == 'Grade_Tier06' then
				stringgrade = "C";
			elseif grade == 'Grade_Tier07' then
				stringgrade = "D";
			elseif grade == 'Grade_Failed' then
				stringgrade = "F";
			else
				stringgrade = "ERROR";
			end;
			self:finishtweening();
			self:zoom(0.75);
			self:align(1,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_RIGHT/2-8);
			self:y(SCREEN_BOTTOM/2);
			self:settext("\n" .. "\n" .. stringgrade .. "\n" .. tostring(round(percent,1)) .. "%\n\n" .. tostring(flawless) .. "\n" .. tostring(perfects) .. "\n" .. tostring(greats) .. "\n" .. tostring(goods) .. "\n" .. tostring(bads) .. "\n" .. tostring(misses) .. "\n" .. tostring(held) .. "\n" .. tostring(released) .. "\n" .. tostring(combo) .. "\n\n" .. tostring(points) .. "/" .. tostring(maxpoints))
		end;
	},
	-- Actor (Results P2 Translation Text)
	LoadFont("Common", "normal")..{
		Text=ScreenString("Here are your results Player 2") .. "!" .. "\n\n" .. ScreenString("Grade") .. ":" .. "\n" .. ScreenString("Percent") .. ":" .. "\n\n" .. ScreenString("Flawless") .. ":" .. "\n" .. ScreenString("Perfects") .. ":" .. "\n" .. ScreenString("Greats") .. ":" .. "\n" .. ScreenString("Goods") .. ":" .. "\n" .. ScreenString("Bad") .. ":" .. "\n" .. ScreenString("Missed") .. ":" .. "\n" .. ScreenString("Held") .. ":" .. "\n" .. ScreenString("Released") .. ":" .. "\n" .. ScreenString("Combo") .. ":" .. "\n\n" .. ScreenString("Score") .. ":";
		InitCommand=cmd(x,SCREEN_RIGHT/2+8;y,SCREEN_BOTTOM/2;diffuse,color(theme_color);zoom,0.75;align,0,0.5;shadowlength,1);
	},
	-- Actor (Results P2 Actual Text)
	LoadFont("Common", "normal")..{
		Text="";
		InitCommand=cmd(x,SCREEN_RIGHT-8;y,SCREEN_BOTTOM/2;diffuse,color(theme_color);zoom,0.75;align,1,0.5;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand('ResultsP2B');
		end;
		ResultsP2BCommand=function(self)
			local results = STATSMAN:GetAccumPlayedStageStats();
			local tableresults = results:GetPlayerStageStats('PlayerNumber_P2');
			local points = tableresults:GetScore();
			local combo = tableresults:MaxCombo();
			local calories = tableresults:GetCaloriesBurned();
			local maxpoints = tableresults:GetCurMaxScore();
			local grade = STATSMAN:GetBestFinalGrade();
			local released = tableresults:GetHoldNoteScores('HoldNoteScore_LetGo');
			local held = tableresults:GetHoldNoteScores('HoldNoteScore_Held');
			local percent = tableresults:GetPercentDancePoints()*100;
			local flawless = tableresults:GetTapNoteScores('TapNoteScore_W1');
			local perfects = tableresults:GetTapNoteScores('TapNoteScore_W2');
			local greats = tableresults:GetTapNoteScores('TapNoteScore_W3');
			local goods = tableresults:GetTapNoteScores('TapNoteScore_W4');
			local bads = tableresults:GetTapNoteScores('TapNoteScore_W5');
			local misses = tableresults:GetTapNoteScores('TapNoteScore_Miss');
			local stringgrade = "X";
			if grade == 'Grade_Tier01' then
				stringgrade = "AAAA";
			elseif grade == 'Grade_Tier02' then
				stringgrade = "AAA";
			elseif grade == 'Grade_Tier03' then
				stringgrade = "AA";
			elseif grade == 'Grade_Tier04' then
				stringgrade = "A";
			elseif grade == 'Grade_Tier05' then
				stringgrade = "B";
			elseif grade == 'Grade_Tier06' then
				stringgrade = "C";
			elseif grade == 'Grade_Tier07' then
				stringgrade = "D";
			elseif grade == 'Grade_Failed' then
				stringgrade = "F";
			else
				stringgrade = "ERROR";
			end;
			self:finishtweening();
			self:zoom(0.75);
			self:align(1,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_RIGHT-8);
			self:y(SCREEN_BOTTOM/2);
			self:settext("\n" .. "\n" .. stringgrade .. "\n" .. tostring(round(percent,1)) .. "%\n\n" .. tostring(flawless) .. "\n" .. tostring(perfects) .. "\n" .. tostring(greats) .. "\n" .. tostring(goods) .. "\n" .. tostring(bads) .. "\n" .. tostring(misses) .. "\n" .. tostring(held) .. "\n" .. tostring(released) .. "\n" .. tostring(combo) .. "\n\n" .. tostring(points) .. "/" .. tostring(maxpoints))
		end;
	},
	-- Actor/Function (scripts)
	theme_skin("evaluation_theme_skin"),
	-- Actor/Function (scripts)
	main_song()
};

return t;