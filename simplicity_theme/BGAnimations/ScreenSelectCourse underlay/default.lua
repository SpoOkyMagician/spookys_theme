-- ScreenSelectCourse underlay
-- having some issues with this screen... not much i can do about it right now...

local t = Def.ActorFrame{
	Name="ScreenSelectCourseUnderlayActorFrame";
	-- last known difficulty/radar variables P1/P2 (hidden actor)
	Def.Actor{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('Vars');
		end;
		VarsCommand=function(self)
			local p1_trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			local p2_trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			if p1_trail ~= nil then
				last_known_difficulty_P1 = p1_trail:GetDifficulty();
				local p1_values = p1_trail:GetRadarValues('PlayerNumber_P1');
				trail_p1_taps = p1_values:GetValue('RadarCategory_TapsAndHolds');
				trail_p1_jumps = p1_values:GetValue('RadarCategory_Jumps');
				trail_p1_holds = p1_values:GetValue('RadarCategory_Holds');
				trail_p1_mines = p1_values:GetValue('RadarCategory_Mines');
				trail_p1_hands = p1_values:GetValue('RadarCategory_Hands');
				trail_p1_rolls = p1_values:GetValue('RadarCategory_Rolls');
				trail_p1_lifts = p1_values:GetValue('RadarCategory_Lifts');
				trail_p1_fakes = p1_values:GetValue('RadarCategory_Fakes');
				trail_p1_total = trail_p1_taps + trail_p1_jumps + trail_p1_holds + trail_p1_mines + trail_p1_hands + trail_p1_rolls + trail_p1_lifts + trail_p1_fakes;
			else
				last_known_difficulty_P1 = 'Difficulty_Edit';
				trail_p1_taps = 0;
				trail_p1_jumps = 0;
				trail_p1_holds = 0;
				trail_p1_mines = 0;
				trail_p1_hands = 0;
				trail_p1_rolls = 0;
				trail_p1_lifts = 0;
				trail_p1_fakes = 0;
				trail_p1_total = 0;
			end;
			if p2_trail ~= nil then
				last_known_difficulty_P2 = p2_trail:GetDifficulty();
				local p2_values = p2_trail:GetRadarValues('PlayerNumber_P2');
				trail_p2_taps = p2_values:GetValue('RadarCategory_TapsAndHolds');
				trail_p2_jumps = p2_values:GetValue('RadarCategory_Jumps');
				trail_p2_holds = p2_values:GetValue('RadarCategory_Holds');
				trail_p2_mines = p2_values:GetValue('RadarCategory_Mines');
				trail_p2_hands = p2_values:GetValue('RadarCategory_Hands');
				trail_p2_rolls = p2_values:GetValue('RadarCategory_Rolls');
				trail_p2_lifts = p2_values:GetValue('RadarCategory_Lifts');
				trail_p2_fakes = p2_values:GetValue('RadarCategory_Fakes');
				trail_p2_total = trail_p2_taps + trail_p2_jumps + trail_p2_holds + trail_p2_mines + trail_p2_hands + trail_p2_rolls + trail_p2_lifts + trail_p2_fakes;
			else
				last_known_difficulty_P2 = 'Difficulty_Edit';
				trail_p2_taps = 0;
				trail_p2_jumps = 0;
				trail_p2_holds = 0;
				trail_p2_mines = 0;
				trail_p2_hands = 0;
				trail_p2_rolls = 0;
				trail_p2_lifts = 0;
				trail_p2_fakes = 0;
				trail_p2_total = 0;
			end;
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Vars");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Vars");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Vars");
	},
	-- banner bottom/text top border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP+110,SCREEN_LEFT+258,SCREEN_TOP+112;diffuse,color(theme_color));
	},
	-- left side/right side divider border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+258,SCREEN_TOP+28,SCREEN_LEFT+260,SCREEN_TOP+450;diffuse,color(theme_color));
	},
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+252,SCREEN_LEFT+258,SCREEN_TOP+254;diffuse,color(theme_color));
	};
	-- GLOBAL screen text
	common_text("Select Course"),
	-- sort icon
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_RIGHT-26;y,SCREEN_TOP+15;scaletoclipped,50,28;Load,THEME:GetPathG("", "sort_icon_unknown.png"));
		OnCommand=function(self)
			self:queuecommand("Sort");
		end;
		SortCommand=function(self)
			-- thanks Jousway.
			local sort = GAMESTATE:GetSortOrder();
			if sort ~= nil then
				self:Load(THEME:GetPathG("icon", sort)); -- and call them "icon SortOrder_Preferred.png"
			else
				self:Load(THEME:GetPathG("", "sort_icon_unknown.png"));
			end;
			self:finishtweening();
			self:diffusealpha(0);
			self:sleep(0.02);
			self:diffusealpha(0.25);
			self:sleep(0.02);
			self:diffusealpha(0.5);
			self:sleep(0.02);
			self:diffusealpha(0.75);
			self:sleep(0.02);
			self:diffusealpha(1.0);
			self:sleep(0.02);
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"Sort");
	},
	-- song banner
	Def.Banner{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+70;scaletoclipped,256,80;Load,THEME:GetPathG("", "no_banner.png"));
		OnCommand=function(self)
			self:queuecommand("Banner");
		end;
		BannerCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			local wheel = SCREENMAN:GetTopScreen():GetMusicWheel();
			if wheel:GetSelectedType() == 'WheelItemDataType_Course' and course ~= nil then
				if course:HasBanner() == true then
					self:LoadFromCourse(course);
				else
					self:Load(THEME:GetPathG("", "no_banner.png"));
				end;
			end;
			self:finishtweening();
			self:diffusealpha(0);
			self:sleep(0.02);
			self:diffusealpha(0.25);
			self:sleep(0.02);
			self:diffusealpha(0.5);
			self:sleep(0.02);
			self:diffusealpha(0.75);
			self:sleep(0.02);
			self:diffusealpha(1.0);
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Banner");
	},
	-- song background
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;scaletoclipped,592,420;Load,THEME:GetPathG("", "no_background.png"));
		OnCommand=function(self)
			self:queuecommand('BG');
		end;
		BGCommand=function(self)
				local course = GAMESTATE:GetCurrentCourse();
				if course ~= nil then
					if course:HasBackground() == true then
						self:LoadFromCurrentSongBackground();
					else
						self:Load(THEME:GetPathG("", "no_background.png"));
					end;
				else
					self:Load(THEME:GetPathG("", "no_background.png"));
				end;
			self:finishtweening();
			self:diffusealpha(0);
			self:sleep(0.02);
			self:diffusealpha(0.25);
			self:sleep(0.02);
			self:diffusealpha(0.5);
			self:sleep(0.02);
			self:diffusealpha(0.75);
			self:sleep(0.02);
			self:diffusealpha(1.0);
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"BG");
	},
	-- song difficulty p1
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+286;scaletoclipped,64,64;Load,THEME:GetPathG("", "difficulty_unknown.png"));
		OnCommand=function(self)
			self:queuecommand('DifficultyPA');
		end;
		DifficultyPACommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			if trail ~= nil then
				if trail:GetDifficulty() == 'Difficulty_Beginner' then
					self:Load(THEME:GetPathG("", "difficulty_beginner.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Easy' then
					self:Load(THEME:GetPathG("", "difficulty_easy.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Medium' then
					self:Load(THEME:GetPathG("", "difficulty_normal.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Hard' then
					self:Load(THEME:GetPathG("", "difficulty_hard.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Challenge' then
					self:Load(THEME:GetPathG("", "difficulty_challenge.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Edit' then
					self:Load(THEME:GetPathG("", "difficulty_edit.png"));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
			end;
			self:finishtweening();
			self:diffusealpha(0);
			self:sleep(0.02);
			self:diffusealpha(0.25);
			self:sleep(0.02);
			self:diffusealpha(0.5);
			self:sleep(0.02);
			self:diffusealpha(0.75);
			self:sleep(0.02);
			self:diffusealpha(1.0);
			self:sleep(0.02);
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"DifficultyPA");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"DifficultyPA");
	},
	-- song difficulty p2
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+350;scaletoclipped,64,64;Load,THEME:GetPathG("", "difficulty_unknown.png"));
		OnCommand=function(self)
			self:queuecommand('DifficultyPB');
		end;
		DifficultyPBCommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			if trail ~= nil then
				if trail:GetDifficulty() == 'Difficulty_Beginner' then
					self:Load(THEME:GetPathG("", "difficulty_beginner.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Easy' then
					self:Load(THEME:GetPathG("", "difficulty_easy.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Medium' then
					self:Load(THEME:GetPathG("", "difficulty_normal.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Hard' then
					self:Load(THEME:GetPathG("", "difficulty_hard.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Challenge' then
					self:Load(THEME:GetPathG("", "difficulty_challenge.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Edit' then
					self:Load(THEME:GetPathG("", "difficulty_edit.png"));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
			end;
			self:finishtweening();
			self:diffusealpha(0);
			self:sleep(0.02);
			self:diffusealpha(0.25);
			self:sleep(0.02);
			self:diffusealpha(0.5);
			self:sleep(0.02);
			self:diffusealpha(0.75);
			self:sleep(0.02);
			self:diffusealpha(1.0);
			self:sleep(0.02);
		end;
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"DifficultyPB");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"DifficultyPB");
	},
	-- song meter p1
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+286;scaletoclipped,192,64;Load,THEME:GetPathG("", "meter_0.png"));
		OnCommand=function(self)
			self:queuecommand('MeterPA');
		end;
		MeterPACommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			if trail ~= nil then
				-- use this instead... thanks again Kyzentun
				local half_meter=clamp(math.round(trail:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
			else
				self:Load(THEME:GetPathG("", "meter_0.png"));
			end;
			self:finishtweening();
			self:diffusealpha(0);
			self:sleep(0.02);
			self:diffusealpha(0.25);
			self:sleep(0.02);
			self:diffusealpha(0.5);
			self:sleep(0.02);
			self:diffusealpha(0.75);
			self:sleep(0.02);
			self:diffusealpha(1.0);
			self:sleep(0.02);
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"MeterPA");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"MeterPA");
	},
	-- song meter p2
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+350;scaletoclipped,192,64;Load,THEME:GetPathG("", "meter_0.png"));
		OnCommand=function(self)
			self:queuecommand('MeterPB');
		end;
		MeterPBCommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			if trail ~= nil then
				-- use this instead... thanks again Kyzentun
				local half_meter=clamp(math.round(trail:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
			else
				self:Load(THEME:GetPathG("", "meter_0.png"));
			end;
			self:finishtweening();
			self:diffusealpha(0);
			self:sleep(0.02);
			self:diffusealpha(0.25);
			self:sleep(0.02);
			self:diffusealpha(0.5);
			self:sleep(0.02);
			self:diffusealpha(0.75);
			self:sleep(0.02);
			self:diffusealpha(1.0);
			self:sleep(0.02);
		end;
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"MeterPB");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"MeterPB");
	},
	-- song/trail information
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_TOP+170;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand('Information');
		end;
		InformationCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			if course ~= nil then
				self:settext("Title: " .. course:GetDisplayFullTitle() .. "\nDescription: " .. course:GetDescription() .. "\nCreator: " .. course:GetScripter() .. "\nStages: " .. tostring(course:GetEstimatedNumStages()) );
			else
				self:settext("Title:\n" .. "N/A" .. "\nDescription:\n" .. "N/A" .. "\nCreator:\n" .. "N/A" .. "\nStages:\n" .. "N/A");
			end;
			self:finishtweening();
			self:scaletofit(SCREEN_LEFT+2,SCREEN_TOP+110,SCREEN_LEFT+256,SCREEN_TOP+250);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color(theme_color));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Information");
	},
	-- song/trail difficulty P1 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+300;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:queuecommand('StringPA');
		end;
		StringPACommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			local course_difficulty = "Easy";
			if trail ~= nil then
				local difficulty_trail = trail:GetDifficulty();
				if difficulty_trail == 'Difficulty_Beginner' then
					course_difficulty = "Beginner";
				elseif difficulty_trail == 'Difficulty_Easy' then
					course_difficulty = "Easy";
				elseif difficulty_trail == 'Difficulty_Medium' then
					course_difficulty = "Medium";
				elseif difficulty_trail == 'Difficulty_Hard' then
					course_difficulty = "Hard";
				elseif difficulty_trail == 'Difficulty_Challenge' then
					course_difficulty = "Challenge";
				elseif difficulty_trail == 'Difficulty_Edit' then
					course_difficulty = "Edit (" .. trail:GetChartName() .. ")";
				end;
				self:settext("" .. course_difficulty .. " - " .. tostring(trail:GetMeter()) );
			else
				self:settext("N/A");
			end;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color(theme_color));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"StringPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"StringPA");
	},
	-- song/trail difficulty P2 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+365;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:queuecommand('StringPB');
		end;
		StringPBCommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			local course_difficulty = "Easy";
			if trail ~= nil then
				local difficulty_trail = trail:GetDifficulty();
				if difficulty_trail == 'Difficulty_Beginner' then
					course_difficulty = "Beginner";
				elseif difficulty_trail == 'Difficulty_Easy' then
					course_difficulty = "Easy";
				elseif difficulty_trail == 'Difficulty_Medium' then
					course_difficulty = "Medium";
				elseif difficulty_trail == 'Difficulty_Hard' then
					course_difficulty = "Hard";
				elseif difficulty_trail == 'Difficulty_Challenge' then
					course_difficulty = "Challenge";
				elseif difficulty_trail == 'Difficulty_Edit' then
					course_difficulty = "Edit (" .. trail:GetChartName() .. ")";
				end;
				self:settext("" .. course_difficulty .. " - " .. tostring(trail:GetMeter()) );
			else
				self:settext("N/A");
			end;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color(theme_color));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"StringPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"StringPB");
	},
	LoadActor(THEME:GetPathG("", "radar_values"))..{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+417;zoomto,256,70);
	},
	-- quad p1 taps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+115,SCREEN_TOP+390;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarTapsPA");
		end;
		RadarTapsPACommand=function(self)
			local percentage = (trail_p1_taps / trail_p1_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15+percentage,SCREEN_TOP+390);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
	},
	-- quad p1 jumps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+115,SCREEN_TOP+397;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarJumpsPA");
		end;
		RadarJumpsPACommand=function(self)
			local p1_percentage = (trail_p1_jumps / trail_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+397);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
	},
	-- quad p1 holds
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+115,SCREEN_TOP+404;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHoldsPA");
		end;
		RadarHoldsPACommand=function(self)
			local p1_percentage = (trail_p1_holds / trail_p1_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+404);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
	},
	-- quad p1 mines
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+115,SCREEN_TOP+411;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarMinesPA");
		end;
		RadarMinesPACommand=function(self)
			local p1_percentage = (trail_p1_mines / trail_p1_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+411);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
	},
	-- quad p1 hands
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+115,SCREEN_TOP+418;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHandsPA");
		end;
		RadarHandsPACommand=function(self)
			local p1_percentage = (trail_p1_hands / trail_p1_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+418);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
	},
	-- quad p1 rolls
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+115,SCREEN_TOP+425;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarRollsPA");
		end;
		RadarRollsPACommand=function(self)
			local p1_percentage = (trail_p1_rolls / trail_p1_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+425);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
	},
	-- quad p1 lifts
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+115,SCREEN_TOP+432;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarLiftsPA");
		end;
		RadarLiftsPACommand=function(self)
			local p1_percentage = (trail_p1_lifts / trail_p1_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+432);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
	},
	-- quad p1 fakes
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+115,SCREEN_TOP+438;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarFakesPA");
		end;
		RadarFakesPACommand=function(self)
			local p1_percentage = (trail_p1_fakes / trail_p1_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+438);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
	},
	-- quad p2 taps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+243,SCREEN_TOP+390;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarTapsPB");
		end;
		RadarTapsPBCommand=function(self)
			local p2_percentage = (trail_p2_taps / trail_p2_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+390);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("0,0.5,1,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarTapsPB");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarTapsPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarTapsPB");
	},
	-- quad p2 jumps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+243,SCREEN_TOP+397;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarJumpsPB");
		end;
		RadarJumpsPBCommand=function(self)
			local p2_percentage = (trail_p2_jumps / trail_p2_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+397);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("0,0.5,1,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarJumpsPB");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsPB");
	},
	-- quad p2 holds
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+243,SCREEN_TOP+404;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHoldsPB");
		end;
		RadarHoldsPBCommand=function(self)
			local p2_percentage = (trail_p2_holds / trail_p2_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+404);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("0,0.5,1,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarHoldsPB");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsPB");
	},
	-- quad p2 mines
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+243,SCREEN_TOP+411;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarMinesPB");
		end;
		RadarMinesPBCommand=function(self)
			local p2_percentage = (trail_p2_mines / trail_p2_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+411);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("0,0.5,1,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarMinesPB");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarMinesPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarMinesPB");
	},
	-- quad p2 hands
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+243,SCREEN_TOP+418;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHandsPB");
		end;
		RadarHandsPBCommand=function(self)
			local p2_percentage = (trail_p2_hands / trail_p2_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+418);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("0,0.5,1,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarHandsPB");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarHandsPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarHandsPB");
	},
	-- quad p2 rolls
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+243,SCREEN_TOP+425;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarRollsPB");
		end;
		RadarRollsPBCommand=function(self)
			local p2_percentage = (trail_p2_rolls / trail_p2_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+425);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("0,0.5,1,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarRollsPB");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarRollsPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarRollsPB");
	},
	-- quad p2 lifts
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+243,SCREEN_TOP+432;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarLiftsPB");
		end;
		RadarLiftsPBCommand=function(self)
			local p2_percentage = (trail_p2_lifts / trail_p2_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+432);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("0,0.5,1,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarLiftsPB");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsPB");
	},
	-- quad p2 fakes
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+243,SCREEN_TOP+438;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarFakesPB");
		end;
		RadarFakesPBCommand=function(self)
			local p2_percentage = (trail_p2_fakes / trail_p2_total)*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+438);
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF44"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFF88"));
			self:sleep(0.02);
			self:diffuse(color("#FFFFFFCC"));
			self:sleep(0.02);
			self:diffuse(color("0,0.5,1,1"));
			self:sleep(0.02);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
	},
	-- new theme skin i am experimenting with...
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;Load,THEME:GetPathG("","theme_skin"));
	},
	-- new theme skin i am experimenting with...
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;Load,THEME:GetPathG("","music_theme_skin"));
	}
};

return t;