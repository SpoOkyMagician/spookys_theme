-- ScreenSelectCourse underlay

local t = Def.ActorFrame{
	-- last known difficulty variable P1/P2 hidden actor
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('Vars');
		end;
		VarsCommand=function(self)
			local p1_trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			local p2_trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			if p1_trail ~= nil then
				last_known_difficulty_P1 = p1_trail:GetDifficulty();
			else
				last_known_difficulty_P1 = 'Difficulty_Edit';
			end;
			if p2_trail ~= nil then
				last_known_difficulty_P2 = p2_trail:GetDifficulty();
			else
				last_known_difficulty_P2 = 'Difficulty_Edit';
			end;
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Vars");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Vars");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Vars");
	},
	-- radar variables P1/P2 hidden actor
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('Values');
		end;
		ValuesCommand=function(self)
			local p1_trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			local p2_trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			if p1_trail ~= nil then
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
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Values");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Values");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Values");
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
	LoadActor(THEME:GetPathG("", "sort_icon_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-26;y,SCREEN_TOP+15;zoomto,50,28);
		OnCommand=function(self)
			self:queuecommand("Sort");
		end;
		SortCommand=function(self)
			local sort = GAMESTATE:GetSortOrder();
			if sort ~= nil then
				if sort == 'SortOrder_Preferred' then
					self:Load(THEME:GetPathG("", "sort_icon_preferred.png"));
				elseif sort == 'SortOrder_Group' then
					self:Load(THEME:GetPathG("", "sort_icon_group.png"));
				elseif sort == 'SortOrder_Title' then
					self:Load(THEME:GetPathG("", "sort_icon_title.png"));
				elseif sort == 'SortOrder_BPM' then
					self:Load(THEME:GetPathG("", "sort_icon_bpm.png"));
				elseif sort == 'SortOrder_Popularity' then
					self:Load(THEME:GetPathG("", "sort_icon_popularity.png"));
				elseif sort == 'SortOrder_TopGrades' then
					self:Load(THEME:GetPathG("", "sort_icon_top_grades.png"));
				elseif sort == 'SortOrder_Artist' then
					self:Load(THEME:GetPathG("", "sort_icon_artist.png"));
				elseif sort == 'SortOrder_BeginnerMeter' then
					self:Load(THEME:GetPathG("", "sort_icon_beginner.png"));
				elseif sort == 'SortOrder_EasyMeter' then
					self:Load(THEME:GetPathG("", "sort_icon_easy.png"));
				elseif sort == 'SortOrder_MediumMeter' then
					self:Load(THEME:GetPathG("", "sort_icon_medium.png"));
				elseif sort == 'SortOrder_HardMeter' then
					self:Load(THEME:GetPathG("", "sort_icon_hard.png"));
				elseif sort == 'SortOrder_ChallengeMeter' then
					self:Load(THEME:GetPathG("", "sort_icon_challenge.png"));
				elseif sort == 'SortOrder_DoubleEasyMeter' then
					self:Load(THEME:GetPathG("", "sort_icon_double_easy.png"));
				elseif sort == 'SortOrder_DoubleMediumMeter' then
					self:Load(THEME:GetPathG("", "sort_icon_double_medium.png"));
				elseif sort == 'SortOrder_DoubleHardMeter' then
					self:Load(THEME:GetPathG("", "sort_icon_double_hard.png"));
				elseif sort == 'SortOrder_DoubleChallengeMeter' then
					self:Load(THEME:GetPathG("", "sort_icon_double_challenge.png"));
				elseif sort == 'SortOrder_ModeMenu' then
					self:Load(THEME:GetPathG("", "sort_icon_mode_menu.png"));
				elseif sort == 'SortOrder_AllCourses' then
					self:Load(THEME:GetPathG("", "sort_icon_all_courses.png"));
				elseif sort == 'SortOrder_Nonstop' then
					self:Load(THEME:GetPathG("", "sort_icon_nonstop.png"));
				elseif sort == 'SortOrder_Oni' then
					self:Load(THEME:GetPathG("", "sort_icon_oni.png"));
				elseif sort == 'SortOrder_Endless' then
					self:Load(THEME:GetPathG("", "sort_icon_endless.png"));
				elseif sort == 'SortOrder_Length' then
					self:Load(THEME:GetPathG("", "sort_icon_length.png"));
				elseif sort == 'SortOrder_Roulette' then
					self:Load(THEME:GetPathG("", "sort_icon_roulette.png"));
				elseif sort == 'SortOrder_Recent' then
					self:Load(THEME:GetPathG("", "sort_icon_recent.png"));
				else
					self:Load(THEME:GetPathG("", "sort_icon_unknown.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "sort_icon_unknown.png"));
			end;
			self:zoomto(50,28);
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"Sort");
	},
	-- song banner
	LoadActor(THEME:GetPathG("", "no_banner.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+70;zoomto,256,80);
		OnCommand=function(self)
			self:queuecommand("Banner");
		end;
		BannerCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			if course ~= nil then
				local group = course:GetGroupName();
				local banner = SONGMAN:GetSongGroupBannerPath(group);
				if course:HasBanner() == true then
					self:Load(course:GetBannerPath());
				elseif course:HasBanner() == false and banner ~= nil then
					self:Load(banner);
				else
					self:Load(THEME:GetPathG("", "no_banner.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_banner.png"));
			end;
			self:zoomto(256,80);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Banner");
	},
	-- song background
	LoadActor(THEME:GetPathG("", "no_background.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;zoomto,592,420);
		OnCommand=function(self)
			self:queuecommand('BG');
		end;
		BGCommand=function(self)
				local course = GAMESTATE:GetCurrentCourse();
				if course ~= nil then
					if course:HasBackground() == true then
						self:Load(GetBackgroundPath());
					else
						self:Load(THEME:GetPathG("", "no_background.png"));
					end;
				else
					self:Load(THEME:GetPathG("", "no_background.png"));
				end;
			self:zoomto(592,420);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"BG");
	},
	-- song difficulty p1
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+286;zoomto,64,64);
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
			self:zoomto(64,64);
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"DifficultyPA");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"DifficultyPA");
	},
	-- song difficulty p2
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+350;zoomto,64,64);
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
			self:zoomto(64,64);
		end;
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"DifficultyPB");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"DifficultyPB");
	},
	-- song meter p1
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+286;zoomto,192,64);
		OnCommand=function(self)
			self:queuecommand('MeterPA');
		end;
		MeterPACommand=function(self)
				local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
				if trail ~= nil then
					--[ use this instead... thanks again Kyzentun
					local half_meter=clamp(math.round(trail:GetMeter() / 2), 0, 10);
					self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
				else
					self:Load(THEME:GetPathG("", "meter_0.png"));
				end;
			self:zoomto(192,64);
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"MeterPA");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"MeterPA");
	},
	-- song meter p2
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+350;zoomto,192,64);
		OnCommand=function(self)
			self:queuecommand('MeterPB');
		end;
		MeterPBCommand=function(self)
				local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
				if trail ~= nil then
					--[ use this instead... thanks again Kyzentun
					local half_meter=clamp(math.round(trail:GetMeter() / 2), 0, 10);
					self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
				else
					self:Load(THEME:GetPathG("", "meter_0.png"));
				end;
			self:zoomto(192,64);
		end;
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"MeterPB");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"MeterPB");
	},
	-- song/trail information
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_TOP+170;diffuse,color(theme_color);align,1,0;shadowlength,1);
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
			self:scaletofit(SCREEN_LEFT+2,SCREEN_TOP+110,SCREEN_LEFT+256,SCREEN_TOP+250);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Information");
	},
	-- song/trail difficulty P1 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,1,0;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand('StringPA');
		end;
		StringPACommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			local stdifficulty = "Easy";
			if trail ~= nil then
				local difficultysteps = trail:GetDifficulty();
				if difficultysteps == 'Difficulty_Beginner' then
					stdifficulty = "Beginner";
				elseif difficultysteps == 'Difficulty_Easy' then
					stdifficulty = "Easy";
				elseif difficultysteps == 'Difficulty_Medium' then
					stdifficulty = "Medium";
				elseif difficultysteps == 'Difficulty_Hard' then
					stdifficulty = "Hard";
				elseif difficultysteps == 'Difficulty_Challenge' then
					stdifficulty = "Challenge";
				elseif difficultysteps == 'Difficulty_Edit' then
					stdifficulty = "Edit (" .. trail:GetChartName() .. ")";
				end;
				self:settext("" .. stdifficulty .. " - " .. tostring(trail:GetMeter()) );
			else
				self:settext("N/A");
			end;
			self:zoom(0.5);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+72);
			self:y(SCREEN_TOP+300);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"StringPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"StringPA");
	},
	-- song/trail difficulty P2 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,1,0;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand('StringPB');
		end;
		StringPBCommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			local stdifficulty = "Easy";
			if trail ~= nil then
				local difficultysteps = trail:GetDifficulty();
				if difficultysteps == 'Difficulty_Beginner' then
					stdifficulty = "Beginner";
				elseif difficultysteps == 'Difficulty_Easy' then
					stdifficulty = "Easy";
				elseif difficultysteps == 'Difficulty_Medium' then
					stdifficulty = "Medium";
				elseif difficultysteps == 'Difficulty_Hard' then
					stdifficulty = "Hard";
				elseif difficultysteps == 'Difficulty_Challenge' then
					stdifficulty = "Challenge";
				elseif difficultysteps == 'Difficulty_Edit' then
					stdifficulty = "Edit (" .. trail:GetChartName() .. ")";
				end;
				self:settext("" .. stdifficulty .. " - " .. tostring(trail:GetMeter()) );
			else
				self:settext("N/A");
			end;
			self:zoom(0.5);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+72);
			self:y(SCREEN_TOP+365);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"StringPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"StringPB");
	},
	LoadActor(THEME:GetPathG("", "radar_values"))..{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+416;zoomto,256,69);
	},
	-- quad p1 taps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+115,SCREEN_TOP+390;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarTapsPA");
		end;
		RadarTapsPACommand=function(self)
			local percentage = (steps_p1_taps / steps_p1_total)*100;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15+percentage,SCREEN_TOP+390);
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
			local p1_percentage = (steps_p1_jumps / steps_p1_total)*100;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+397);
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
			local p1_percentage = (steps_p1_holds / steps_p1_total)*100;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+404);
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
			local p1_percentage = (steps_p1_mines / steps_p1_total)*100;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+411);
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
			local p1_percentage = (steps_p1_hands / steps_p1_total)*100;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+418);
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
			local p1_percentage = (steps_p1_rolls / steps_p1_total)*100;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+425);
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
			local p1_percentage = (steps_p1_lifts / steps_p1_total)*100;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+432);
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
			local p1_percentage = (steps_p1_fakes / steps_p1_total)*100;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+438);
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
			local p2_percentage = (steps_p2_taps / steps_p2_total)*100;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+390);
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
			local p2_percentage = (steps_p2_jumps / steps_p2_total)*100;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+397);
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
			local p2_percentage = (steps_p2_holds / steps_p2_total)*100;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+404);
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
			local p2_percentage = (steps_p2_mines / steps_p2_total)*100;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+411);
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
			local p2_percentage = (steps_p2_hands / steps_p2_total)*100;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+418);
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
			local p2_percentage = (steps_p2_rolls / steps_p2_total)*100;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+425);
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
			local p2_percentage = (steps_p2_lifts / steps_p2_total)*100;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+432);
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
			local p2_percentage = (steps_p2_fakes / steps_p2_total)*100;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+438);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
	}
};

return t;