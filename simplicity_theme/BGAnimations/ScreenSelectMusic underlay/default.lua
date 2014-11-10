-- ScreenSelectMusic underlay
-- having some issues with this screen... not much i can do about it right now...

local t = Def.ActorFrame{
	-- last known difficulty variable P1/P2 hidden actor
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('Vars');
		end;
		VarsCommand=function(self)
			local p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			local p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if p1_steps ~= nil then
				last_known_difficulty_P1 = p1_steps:GetDifficulty();
			else
				last_known_difficulty_P1 = 'Difficulty_Edit';
			end;
			if p2_steps ~= nil then
				last_known_difficulty_P2 = p2_steps:GetDifficulty();
			else
				last_known_difficulty_P2 = 'Difficulty_Edit';
			end;
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Vars");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Vars");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Vars");
	},
	-- radar variables P1/P2 hidden actor
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('Values');
		end;
		ValuesCommand=function(self)
			local p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			local p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if p1_steps ~= nil then
				local p1_values = p1_steps:GetRadarValues('PlayerNumber_P1');
				steps_p1_taps = p1_values:GetValue('RadarCategory_TapsAndHolds');
				steps_p1_jumps = p1_values:GetValue('RadarCategory_Jumps');
				steps_p1_holds = p1_values:GetValue('RadarCategory_Holds');
				steps_p1_mines = p1_values:GetValue('RadarCategory_Mines');
				steps_p1_hands = p1_values:GetValue('RadarCategory_Hands');
				steps_p1_rolls = p1_values:GetValue('RadarCategory_Rolls');
				steps_p1_lifts = p1_values:GetValue('RadarCategory_Lifts');
				steps_p1_fakes = p1_values:GetValue('RadarCategory_Fakes');
				steps_p1_total = steps_p1_taps + steps_p1_jumps + steps_p1_holds + steps_p1_mines + steps_p1_hands + steps_p1_rolls + steps_p1_lifts + steps_p1_fakes;
			else
				steps_p1_taps = 0;
				steps_p1_jumps = 0;
				steps_p1_holds = 0;
				steps_p1_mines = 0;
				steps_p1_hands = 0;
				steps_p1_rolls = 0;
				steps_p1_lifts = 0;
				steps_p1_fakes = 0;
				steps_p1_total = 0;
				steps_p1_total = 1;
			end;
			if p2_steps ~= nil then
				local p2_values = p2_steps:GetRadarValues('PlayerNumber_P2');
				steps_p2_taps = p2_values:GetValue('RadarCategory_TapsAndHolds');
				steps_p2_jumps = p2_values:GetValue('RadarCategory_Jumps');
				steps_p2_holds = p2_values:GetValue('RadarCategory_Holds');
				steps_p2_mines = p2_values:GetValue('RadarCategory_Mines');
				steps_p2_hands = p2_values:GetValue('RadarCategory_Hands');
				steps_p2_rolls = p2_values:GetValue('RadarCategory_Rolls');
				steps_p2_lifts = p2_values:GetValue('RadarCategory_Lifts');
				steps_p2_fakes = p2_values:GetValue('RadarCategory_Fakes');
				steps_p2_total = steps_p2_taps + steps_p2_jumps + steps_p2_holds + steps_p2_mines + steps_p2_hands + steps_p2_rolls + steps_p2_lifts + steps_p2_fakes;
			else
				steps_p2_taps = 0;
				steps_p2_jumps = 0;
				steps_p2_holds = 0;
				steps_p2_mines = 0;
				steps_p2_hands = 0;
				steps_p2_rolls = 0;
				steps_p2_lifts = 0;
				steps_p2_fakes = 0;
				steps_p2_total = 0;
				steps_p2_total = 1;
			end;
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Values");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Values");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Values");
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
	common_text("Select Music"),
	-- sort icon
	LoadActor(THEME:GetPathG("", "sort_icon_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-26;y,SCREEN_TOP+15;zoomto,50,28);
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
			self:stoptweening();
			self:zoomto(50,28);
			self:diffusealpha(0);
			self:diffusealpha(0.25);
			self:diffusealpha(0.5);
			self:diffusealpha(0.75);
			self:diffusealpha(1.0);
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
			local song = GAMESTATE:GetCurrentSong();
			if song ~= nil then
				local group = song:GetGroupName();
				local banner = SONGMAN:GetSongGroupBannerPath(group);
				if song:HasBanner() == true then
					self:Load(song:GetBannerPath());
				elseif song:HasBanner() == false and banner ~= nil then
					self:Load(banner);
				else
					self:Load(THEME:GetPathG("", "no_banner.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_banner.png"));
			end;
			self:finishtweening();
			self:stoptweening();
			self:zoomto(256,80);
			self:diffusealpha(0);
			self:diffusealpha(0.25);
			self:diffusealpha(0.5);
			self:diffusealpha(0.75);
			self:diffusealpha(1.0);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Banner");
	},
	-- song background
	LoadActor(THEME:GetPathG("", "no_background.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;zoomto,592,420);
		OnCommand=function(self)
			self:queuecommand('BG');
		end;
		BGCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song ~= nil then
				if song:HasBackground() == true then
					self:Load(GetSongBackground());
				else
					self:Load(THEME:GetPathG("", "no_background.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_background.png"));
			end;
			self:finishtweening();
			self:stoptweening();
			self:zoomto(592,420);
			self:diffusealpha(0);
			self:diffusealpha(0.25);
			self:diffusealpha(0.5);
			self:diffusealpha(0.75);
			self:diffusealpha(1.0);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"BG");
	},
	-- song cd
	LoadActor(THEME:GetPathG("", "no_cd.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+300;y,SCREEN_TOP+69;zoomto,80,80);
		OnCommand=function(self)
			self:queuecommand('CD');
		end;
		CDCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song ~= nil then
				if song:HasCDTitle() == true then
					self:Load(song:GetCDTitlePath());
				else
					self:Load(THEME:GetPathG("", "no_cd.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_cd.png"));
			end;
			self:finishtweening();
			self:stoptweening();
			self:zoomto(80,80);
			self:diffusealpha(0);
			self:diffusealpha(0.25);
			self:diffusealpha(0.5);
			self:diffusealpha(0.75);
			self:diffusealpha(1.0);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"CD");
	},
	-- song difficulty p1
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+286;zoomto,64,64);
		OnCommand=function(self)
			self:queuecommand('DifficultyPA');
		end;
		DifficultyPACommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if steps ~= nil then
				if steps:GetDifficulty() == 'Difficulty_Beginner' then
					self:Load(THEME:GetPathG("", "difficulty_beginner.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Easy' then
					self:Load(THEME:GetPathG("", "difficulty_easy.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Medium' then
					self:Load(THEME:GetPathG("", "difficulty_normal.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Hard' then
					self:Load(THEME:GetPathG("", "difficulty_hard.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Challenge' then
					self:Load(THEME:GetPathG("", "difficulty_challenge.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Edit' then
					self:Load(THEME:GetPathG("", "difficulty_edit.png"));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
			end;
			self:finishtweening();
			self:stoptweening();
			self:zoomto(64,64);
			self:diffusealpha(0);
			self:diffusealpha(0.25);
			self:diffusealpha(0.5);
			self:diffusealpha(0.75);
			self:diffusealpha(1.0);
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"DifficultyPA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyPA");
	},
	-- song difficulty p2
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+350;zoomto,64,64);
		OnCommand=function(self)
			self:queuecommand('DifficultyPB');
		end;
		DifficultyPBCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if steps ~= nil then
				if steps:GetDifficulty() == 'Difficulty_Beginner' then
					self:Load(THEME:GetPathG("", "difficulty_beginner.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Easy' then
					self:Load(THEME:GetPathG("", "difficulty_easy.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Medium' then
					self:Load(THEME:GetPathG("", "difficulty_normal.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Hard' then
					self:Load(THEME:GetPathG("", "difficulty_hard.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Challenge' then
					self:Load(THEME:GetPathG("", "difficulty_challenge.png"));
				elseif steps:GetDifficulty() == 'Difficulty_Edit' then
					self:Load(THEME:GetPathG("", "difficulty_edit.png"));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
			end;
			self:finishtweening();
			self:stoptweening();
			self:zoomto(64,64);
			self:diffusealpha(0);
			self:diffusealpha(0.25);
			self:diffusealpha(0.5);
			self:diffusealpha(0.75);
			self:diffusealpha(1.0);
		end;
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"DifficultyPB");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyPB");
	},
	-- song meter p1
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+286;zoomto,192,64);
		OnCommand=function(self)
			self:queuecommand('MeterPA');
		end;
		MeterPACommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if steps ~= nil then
				--[ use this instead... thanks again Kyzentun
				local half_meter=clamp(math.round(steps:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
			else
				self:Load(THEME:GetPathG("", "meter_0.png"));
			end;
			self:finishtweening();
			self:stoptweening();
			self:zoomto(192,64);
			self:diffusealpha(0);
			self:diffusealpha(0.25);
			self:diffusealpha(0.5);
			self:diffusealpha(0.75);
			self:diffusealpha(1.0);
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"MeterPA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"MeterPA");
	},
	-- song meter p2
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+350;zoomto,192,64);
		OnCommand=function(self)
			self:queuecommand('MeterPB');
		end;
		MeterPBCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if steps ~= nil then
				--[ use this instead... thanks again Kyzentun
				local half_meter=clamp(math.round(steps:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
			else
				self:Load(THEME:GetPathG("", "meter_0.png"));
			end;
			self:finishtweening();
			self:stoptweening();
			self:zoomto(192,64);
			self:diffusealpha(0);
			self:diffusealpha(0.25);
			self:diffusealpha(0.5);
			self:diffusealpha(0.75);
			self:diffusealpha(1.0);
		end;
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"MeterPB");
		CurrentSongChangedMessageCommand=cmd(playcommand,"MeterPB");
	},
	-- song/trail information
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(scaletofit,SCREEN_LEFT+2,SCREEN_TOP+110,SCREEN_LEFT+256,SCREEN_TOP+250;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand('Information');
		end;
		InformationCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local length_result = "Normal";
			if song ~= nil then
				local tempo = song:GetDisplayBpms();
				local length_long = song:IsLong();
				local length_marathon = song:IsMarathon();
				local results_tempo = 1;
				if tempo[1] == tempo[2] then
					results_tempo = tostring(round(tempo[1],1));
				else
					results_tempo = tostring(round(tempo[1],1) .. " - " .. round(tempo[2],1));
				end;
				if length_long == true then
					length_result = "Long";
				elseif length_marathon == true then
					length_result = "Marathon";
				else
					length_result = "Normal";
				end;
				self:settext("Title: " .. song:GetDisplayMainTitle() .. "\nSub Title: " .. song:GetDisplaySubTitle() .. "\nSong Artist: " .. song:GetDisplayArtist() .. "\nTempo: " .. results_tempo .. "\nGenre: " .. song:GetGenre() .. "\nGroup: " .. song:GetGroupName() .. "\nLength: " .. length_result .. "\nSeconds: " .. round(song:MusicLengthSeconds(),1) );
			else
				self:settext("Title: " .. "N/A" .. "\nSub Title: " .. "N/A" .. "\nSong Artist: " .. "N/A" .. "\nTempo: " .. "N/A" .. "\nGenre: " .. "N/A" .. "\nGroup: " .. "N/A" .. "\nLength: " .. "N/A" .. "\nSeconds: " .. "N/A" );
			end;
			self:finishtweening();
			self:stoptweening();
			self:scaletofit(SCREEN_LEFT+2,SCREEN_TOP+110,SCREEN_LEFT+256,SCREEN_TOP+250);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Information");
	},
	-- song/trail difficulty P1 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+300;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:queuecommand('StringPA');
		end;
		StringPACommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			local stdifficulty = "Easy";
			if steps ~= nil then
				local difficultysteps = steps:GetDifficulty();
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
					stdifficulty = "Edit (" .. steps:GetChartName() .. ")";
				end;
				self:settext("" .. stdifficulty .. " - " .. tostring(steps:GetMeter()) );
			else
				self:settext("N/A");
			end;
			self:finishtweening();
			self:stoptweening();
			self:x(SCREEN_LEFT+72);
			self:y(SCREEN_TOP+300);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StringPA");
	},
	-- song/trail difficulty P2 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+365;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:queuecommand('StringPB');
		end;
		StringPBCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			local stdifficulty = "Easy";
			if steps ~= nil then
				local difficultysteps = steps:GetDifficulty();
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
					stdifficulty = "Edit (" .. steps:GetChartName() .. ")";
				end;
				self:settext("" .. stdifficulty .. " - " .. tostring(steps:GetMeter()) );
			else
				self:settext("N/A");
			end;
			self:finishtweening();
			self:stoptweening();
			self:x(SCREEN_LEFT+72);
			self:y(SCREEN_TOP+365);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"StringPB");
	},
	LoadActor(THEME:GetPathG("", "radar_values"))..{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+416;zoomto,256,69);
	},
	-- quad p1 taps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15,SCREEN_TOP+390;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarTapsPA");
		end;
		RadarTapsPACommand=function(self)
			local percentage = (steps_p1_taps / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15+percentage,SCREEN_TOP+390);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
	},
	-- quad p1 jumps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15,SCREEN_TOP+397;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarJumpsPA");
		end;
		RadarJumpsPACommand=function(self)
			local p1_percentage = (steps_p1_jumps / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+397);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
	},
	-- quad p1 holds
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15,SCREEN_TOP+404;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHoldsPA");
		end;
		RadarHoldsPACommand=function(self)
			local p1_percentage = (steps_p1_holds / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+404);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
	},
	-- quad p1 mines
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15,SCREEN_TOP+411;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarMinesPA");
		end;
		RadarMinesPACommand=function(self)
			local p1_percentage = (steps_p1_mines / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+411);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
	},
	-- quad p1 hands
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15,SCREEN_TOP+418;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHandsPA");
		end;
		RadarHandsPACommand=function(self)
			local p1_percentage = (steps_p1_hands / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+418);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
	},
	-- quad p1 rolls
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15,SCREEN_TOP+425;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarRollsPA");
		end;
		RadarRollsPACommand=function(self)
			local p1_percentage = (steps_p1_rolls / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+425);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
	},
	-- quad p1 lifts
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15,SCREEN_TOP+432;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarLiftsPA");
		end;
		RadarLiftsPACommand=function(self)
			local p1_percentage = (steps_p1_lifts / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+432);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
	},
	-- quad p1 fakes
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15,SCREEN_TOP+438;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarFakesPA");
		end;
		RadarFakesPACommand=function(self)
			local p1_percentage = (steps_p1_fakes / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+438);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
	},
	-- quad p2 taps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143,SCREEN_TOP+390;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarTapsPB");
		end;
		RadarTapsPBCommand=function(self)
			local p2_percentage = (steps_p2_taps / steps_p2_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+390);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarTapsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarTapsPB");
	},
	-- quad p2 jumps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143,SCREEN_TOP+397;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarJumpsPB");
		end;
		RadarJumpsPBCommand=function(self)
			local p2_percentage = (steps_p2_jumps / steps_p2_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+397);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsPB");
	},
	-- quad p2 holds
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143,SCREEN_TOP+404;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHoldsPB");
		end;
		RadarHoldsPBCommand=function(self)
			local p2_percentage = (steps_p2_holds / steps_p2_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+404);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsPB");
	},
	-- quad p2 mines
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143,SCREEN_TOP+411;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarMinesPB");
		end;
		RadarMinesPBCommand=function(self)
			local p2_percentage = (steps_p2_mines / steps_p2_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+411);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarMinesPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarMinesPB");
	},
	-- quad p2 hands
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143,SCREEN_TOP+418;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHandsPB");
		end;
		RadarHandsPBCommand=function(self)
			local p2_percentage = (steps_p2_hands / steps_p2_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+418);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHandsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHandsPB");
	},
	-- quad p2 rolls
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143,SCREEN_TOP+425;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarRollsPB");
		end;
		RadarRollsPBCommand=function(self)
			local p2_percentage = (steps_p2_rolls / steps_p2_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+425);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarRollsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarRollsPB");
	},
	-- quad p2 lifts
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143,SCREEN_TOP+432;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarLiftsPB");
		end;
		RadarLiftsPBCommand=function(self)
			local p2_percentage = (steps_p2_lifts / steps_p2_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+432);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsPB");
	},
	-- quad p2 fakes
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143,SCREEN_TOP+438;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarFakesPB");
		end;
		RadarFakesPBCommand=function(self)
			local p2_percentage = (steps_p2_fakes / steps_p2_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+438);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
	},
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	}
};

return t;