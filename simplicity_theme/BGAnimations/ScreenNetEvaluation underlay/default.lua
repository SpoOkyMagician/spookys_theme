-- ScreenNetEvaluation underlay
-- this screen needs work yet...
-- Online mode is still in progress with SM5. I cannot really do much here sorry...

local t = Def.ActorFrame{
	Name="ScreenNetEvaluationUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("StepMania Online Evaluation"),
	-- GLOBAL dark quad
	grid_t,
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
	-- results MP text
--	LoadFont("SpoOky")..{
--		Text="Results MP";
--		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_BOTTOM/2;diffuse,color(theme_color);zoom,0.75;align,0,0.5;shadowlength,1);
--		OnCommand=function(self)
--			self:queuecommand('MPResults');
--		end;
--		MPResultsCommand=function(self)
			-- this is messy right now... i have a lot to do with this screen...
			-- these do not work currently. I will have to wait for this sorry...
			-- edit: no... just... no...
		--	local results = STATSMAN:GetCurStageStats();
		--	local tableresults_p1 =  results:GetMultiPlayerStageStats('MultiPlayer_P1');
		--	local tableresults_p2 =  results:GetMultiPlayerStageStats('MultiPlayer_P2');
		--	local tableresults_p3 =  results:GetMultiPlayerStageStats('MultiPlayer_P3');
		--	local tableresults_p4 =  results:GetMultiPlayerStageStats('MultiPlayer_P4');
		--	local tableresults_p5 =  results:GetMultiPlayerStageStats('MultiPlayer_P5');
		--	local tableresults_p6 =  results:GetMultiPlayerStageStats('MultiPlayer_P6');
		--	local tableresults_p7 =  results:GetMultiPlayerStageStats('MultiPlayer_P7');
		--	local tableresults_p8 =  results:GetMultiPlayerStageStats('MultiPlayer_P8');
		--	local tableresults_p9 =  results:GetMultiPlayerStageStats('MultiPlayer_P9');
		--	local tableresults_p10 =  results:GetMultiPlayerStageStats('MultiPlayer_P10');
		--	local tableresults_p11 =  results:GetMultiPlayerStageStats('MultiPlayer_P11');
		--	local tableresults_p12 =  results:GetMultiPlayerStageStats('MultiPlayer_P12');
		--	local tableresults_p13 =  results:GetMultiPlayerStageStats('MultiPlayer_P13');
		--	local tableresults_p14 =  results:GetMultiPlayerStageStats('MultiPlayer_P14');
		--	local tableresults_p15 =  results:GetMultiPlayerStageStats('MultiPlayer_P15');
		--	local tableresults_p16 =  results:GetMultiPlayerStageStats('MultiPlayer_P16');
		--	local tableresults_p17 =  results:GetMultiPlayerStageStats('MultiPlayer_P17');
		--	local tableresults_p18 =  results:GetMultiPlayerStageStats('MultiPlayer_P18');
		--	local tableresults_p19 =  results:GetMultiPlayerStageStats('MultiPlayer_P19');
		--	local tableresults_p20 =  results:GetMultiPlayerStageStats('MultiPlayer_P20');
		--	local tableresults_p21 =  results:GetMultiPlayerStageStats('MultiPlayer_P21');
		--	local tableresults_p22 =  results:GetMultiPlayerStageStats('MultiPlayer_P22');
		--	local tableresults_p23 =  results:GetMultiPlayerStageStats('MultiPlayer_P23');
		--	local tableresults_p24 =  results:GetMultiPlayerStageStats('MultiPlayer_P24');
		--	local tableresults_p25 =  results:GetMultiPlayerStageStats('MultiPlayer_P25');
		--	local tableresults_p26 =  results:GetMultiPlayerStageStats('MultiPlayer_P26');
		--	local tableresults_p27 =  results:GetMultiPlayerStageStats('MultiPlayer_P27');
		--	local tableresults_p28 =  results:GetMultiPlayerStageStats('MultiPlayer_P28');
		--	local tableresults_p29 =  results:GetMultiPlayerStageStats('MultiPlayer_P29');
		--	local tableresults_p30 =  results:GetMultiPlayerStageStats('MultiPlayer_P30');
		--	local tableresults_p31 =  results:GetMultiPlayerStageStats('MultiPlayer_P31');
		--	local tableresults_p32 =  results:GetMultiPlayerStageStats('MultiPlayer_P32');
		--	local points = { tableresults_p1:GetScore(), tableresults_p2:GetScore(), tableresults_p3:GetScore(), tableresults_p4:GetScore(), tableresults_p5:GetScore(), tableresults_p6:GetScore(), tableresults_p7:GetScore(), tableresults_p8:GetScore(), tableresults_p9:GetScore(), tableresults_p10:GetScore(), tableresults_p11:GetScore(), tableresults_p12:GetScore(), tableresults_p13:GetScore(), tableresults_p14:GetScore(), tableresults_p15:GetScore(), tableresults_p16:GetScore(), tableresults_p17:GetScore(), tableresults_p18:GetScore(), tableresults_p19:GetScore(), tableresults_p20:GetScore(), tableresults_p21:GetScore(), tableresults_p22:GetScore(), tableresults_p23:GetScore(), tableresults_p24:GetScore(), tableresults_p25:GetScore(), tableresults_p26:GetScore(), tableresults_p27:GetScore(), tableresults_p28:GetScore(), tableresults_p29:GetScore(), tableresults_p30:GetScore(), tableresults_p31:GetScore(), tableresults_p32:GetScore() }
		--	local combo = tableresults_p1:MaxCombo();
		--	local calories = tableresults:GetCaloriesBurned();
--			local maxpoints = tableresults:GetCurMaxScore();
--			local grade = tableresults:GetGrade();
--			local released = tableresults:GetHoldNoteScores('HoldNoteScore_LetGo');
--			local held = tableresults:GetHoldNoteScores('HoldNoteScore_Held');
--			local percent = tableresults:GetPercentDancePoints()*100;
--			local flawless = tableresults:GetTapNoteScores('TapNoteScore_W1');
--			local perfects = tableresults:GetTapNoteScores('TapNoteScore_W2');
--			local greats = tableresults:GetTapNoteScores('TapNoteScore_W3');
--			local goods = tableresults:GetTapNoteScores('TapNoteScore_W4');
--			local bads = tableresults:GetTapNoteScores('TapNoteScore_W5');
--			local misses = tableresults:GetTapNoteScores('TapNoteScore_Miss');
--			local stringgrade = "X";
--			if grade == 'Grade_Tier01' then
--				stringgrade = "AAAA";
--			elseif grade == 'Grade_Tier02' then
--				stringgrade = "AAA";
--			elseif grade == 'Grade_Tier03' then
--				stringgrade = "AA";
--			elseif grade == 'Grade_Tier04' then
--				stringgrade = "A";
--			elseif grade == 'Grade_Tier05' then
--				stringgrade = "B";
--			elseif grade == 'Grade_Tier06' then
--				stringgrade = "C";
--			elseif grade == 'Grade_Tier07' then
--				stringgrade = "D";
--			elseif grade == 'Grade_Failed' then
--				stringgrade = "F";
--			else
--				--[ something went wrong...
--				stringgrade = "ERROR";
--			end;
--			self:zoom(0.75);
--			self:align(0,0.5);
--			self:diffuse(color(theme_color));
--			self:x(SCREEN_LEFT+8);
--			self:y(SCREEN_BOTTOM/2);
			-- this... doesn't work?
--			self:settext("Here are your results!\n\nScore: " .. "\n\nStepMania Online is very broken right now... I will come back to this screen...\n- SpoOkyMagician");
--			self:settext("Here are your results!\n\nScore: " .. tostring(points[1]) .. "," .. tostring(points[2]) .. "," .. tostring(points[3]) .. "," .. tostring(points[4]) tostring(points[5]) .. "," .. tostring(points[6]) .. "," .. tostring(points[7]) .. "," .. tostring(points[8]) .. "," .. tostring(points[9]) .. "," .. tostring(points[10]) .. "," .. tostring(points[11]) .. "," .. tostring(points[12]) .. "," .. tostring(points[13]) .. "," .. tostring(points[14]) .. "," .. tostring(points[15]) .. "," .. tostring(points[16]) .. "," .. tostring(points[17]) .. "," .. tostring(points[18]) .. "," .. tostring(points[19]) .. "," .. tostring(points[20]) .. "," .. tostring(points[21]) .. "," .. tostring(points[22]) .. "," .. tostring(points[23]) .. "," .. tostring(points[24]) .. "," .. tostring(points[25]) .. "," .. tostring(points[26]) .. "," .. tostring(points[27]) .. "," .. tostring(points[28]) .. "," .. tostring(points[29]) .. "," .. tostring(points[30]) .. "," .. tostring(points[31]) .. "," .. tostring(points[32]) );
--			self:settext("Here are your results!\n\n\n\n\nGrade: " .. stringgrade .. "\nPercent: " .. tostring(round(percent,1)) .. "%\n\n\n\n\nFlawless: " .. tostring(flawless) .. "\nPerfects: " .. tostring(perfects) .. "\nGreats: " .. tostring(greats) .. "\nGoods: " .. tostring(goods) .. "\nBads: " .. tostring(bads) .. "\nMiss: " .. tostring(misses) .. "\nHeld: " .. tostring(held) .. "\nReleased: " .. tostring(released) .. "\nCombo: " .. tostring(combo) .. "\n\n\n\n\nScore: " .. tostring(points) .. "/" .. tostring(maxpoints));
--		end;
--	},
	-- GLOBAL play music
	fast_song
};

return t;