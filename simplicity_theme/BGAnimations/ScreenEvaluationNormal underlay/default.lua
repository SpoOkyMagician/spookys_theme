-- ScreenEvaluationNormal underlay

local t = Def.ActorFrame{
	Name="ScreenEvaluationNormalUnderlayActorFrame";
	-- GLOBAL Function Theme Color
	refresh_color(),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL screen text
	common_text("Evaluation"),
	-- results P1 text
	LoadFont("SpoOky")..{
		Text="Results P1";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_BOTTOM/2;diffuse,color(theme_color);zoom,0.75;align,0,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			self:queuecommand('Results');
		end;
		ResultsCommand=function(self)
			local results = STATSMAN:GetCurStageStats();
			local tableresults =  results:GetPlayerStageStats('PlayerNumber_P1');
			local points = tableresults:GetScore();
			local combo = tableresults:MaxCombo();
		--	local calories = tableresults:GetCaloriesBurned();
			local maxpoints = tableresults:GetCurMaxScore();
			local grade = tableresults:GetGrade();
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
				--[ something went wrong...
				stringgrade = "ERROR";
			end;
			self:finishtweening();
			self:zoom(0.75);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+8);
			self:y(SCREEN_BOTTOM/2);
			self:settext("Here are your results Player 1!\n\n\n\n\nGrade: " .. stringgrade .. "\nPercent: " .. tostring(round(percent,1)) .. "%\n\n\n\n\nFlawless: " .. tostring(flawless) .. "\nPerfects: " .. tostring(perfects) .. "\nGreats: " .. tostring(greats) .. "\nGoods: " .. tostring(goods) .. "\nBads: " .. tostring(bads) .. "\nMiss: " .. tostring(misses) .. "\nHeld: " .. tostring(held) .. "\nReleased: " .. tostring(released) .. "\nCombo: " .. tostring(combo) .. "\n\n\n\n\nScore: " .. tostring(points) .. "/" .. tostring(maxpoints))
		end;
	},
	-- results P2 text
	LoadFont("SpoOky")..{
		Text="Results P2";
		InitCommand=cmd(x,SCREEN_RIGHT-8;y,SCREEN_BOTTOM/2;diffuse,color(theme_color);zoom,0.75;align,1,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			self:queuecommand('Results');
		end;
		ResultsCommand=function(self)
			local results = STATSMAN:GetCurStageStats();
			local tableresults =  results:GetPlayerStageStats('PlayerNumber_P2');
			local points = tableresults:GetScore();
			local combo = tableresults:MaxCombo();
		--	local calories = tableresults:GetCaloriesBurned();
			local maxpoints = tableresults:GetCurMaxScore();
			local grade = tableresults:GetGrade();
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
				--[ something went wrong...
				stringgrade = "ERROR";
			end;
			self:finishtweening();
			self:zoom(0.75);
			self:align(1,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_RIGHT-8);
			self:y(SCREEN_BOTTOM/2);
			self:settext("Here are your results Player 2!\n\n\n\n\nGrade: " .. stringgrade .. "\nPercent: " .. tostring(round(percent,1)) .. "%\n\n\n\n\nFlawless: " .. tostring(flawless) .. "\nPerfects: " .. tostring(perfects) .. "\nGreats: " .. tostring(greats) .. "\nGoods: " .. tostring(goods) .. "\nBads: " .. tostring(bads) .. "\nMiss: " .. tostring(misses) .. "\nHeld: " .. tostring(held) .. "\nReleased: " .. tostring(released) .. "\nCombo: " .. tostring(combo) .. "\n\n\n\n\nScore: " .. tostring(points) .. "/" .. tostring(maxpoints))
		end;
	},
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","evaluation_theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- GLOBAL play music
	main_song
};

return t;