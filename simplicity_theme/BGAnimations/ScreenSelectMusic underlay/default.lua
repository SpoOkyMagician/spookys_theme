-- ScreenSelectMusic underlay
-- COME BACK TO THIS LAST

-- good lord, thank you for helping me out with this Kyzentun...
-- now i understand the problem...

-- let's set some variables to organize/re-use later...
local wheel = false; -- SCREENMAN:GetTopScreen():GetMusicWheel();
local p1_steps = false; -- GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
local p2_steps = false; -- GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
local p1_values = 0; -- p1_steps:GetRadarValues('PlayerNumber_P1');
local p2_values = 0; -- p2_steps:GetRadarValues('PlayerNumber_P2');
local difficulty_p1_steps = 0; -- p1_steps:GetDifficulty();
local difficulty_p2_steps = 0; -- p2_steps:GetDifficulty();
local sort = false; -- GAMESTATE:GetSortOrder();
local song = false; -- GAMESTATE:GetCurrentSong();
local group = false; -- GAMESTATE:GetExpandedSectionName();

steps_p1_table[1] = 0;
steps_p1_table[2] = 0;
steps_p1_table[3] = 0;
steps_p1_table[4] = 0;
steps_p1_table[5] = 0;
steps_p1_table[6] = 0;
steps_p1_table[7] = 0;
steps_p1_table[8] = 0;
steps_p1_table[9] = 0;

steps_p2_table[1] = 0;
steps_p2_table[2] = 0;
steps_p2_table[3] = 0;
steps_p2_table[4] = 0;
steps_p2_table[5] = 0;
steps_p2_table[6] = 0;
steps_p2_table[7] = 0;
steps_p2_table[8] = 0;
steps_p2_table[9] = 0;

p1_percentage = 0;
p2_percentage = 0;

local t = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Actor (Last Known Difficulty/Radar Variables P1/P2 hidden)
	Def.Actor{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			-- this MUST be after the screen is done or it will not work correctly.
			wheel = SCREENMAN:GetTopScreen():GetMusicWheel();
			self:queuecommand("Variables");
		end;
		VariablesCommand=function(self)
			self:finishtweening();
			self:sleep(0.1);
			p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if p1_steps ~= nil then
				last_known_difficulty_P1 = p1_steps:GetDifficulty();
				p1_values = p1_steps:GetRadarValues('PlayerNumber_P1');
				steps_p1_table[1] = p1_values:GetValue('RadarCategory_TapsAndHolds');
				steps_p1_table[2] = p1_values:GetValue('RadarCategory_Jumps');
				steps_p1_table[3] = p1_values:GetValue('RadarCategory_Holds');
				steps_p1_table[4] = p1_values:GetValue('RadarCategory_Mines');
				steps_p1_table[5] = p1_values:GetValue('RadarCategory_Hands');
				steps_p1_table[6] = p1_values:GetValue('RadarCategory_Rolls');
				steps_p1_table[7] = p1_values:GetValue('RadarCategory_Lifts');
				steps_p1_table[8] = p1_values:GetValue('RadarCategory_Fakes');
				steps_p1_table[9] = steps_p1_table[1] + steps_p1_table[2] + steps_p1_table[3] + steps_p1_table[4] + steps_p1_table[5] + steps_p1_table[6] + steps_p1_table[7] + steps_p1_table[8];
			else
				last_known_difficulty_P1 = 'Difficulty_Edit';
				steps_p1_table[1] = 0;
				steps_p1_table[2] = 0;
				steps_p1_table[3] = 0;
				steps_p1_table[4] = 0;
				steps_p1_table[5] = 0;
				steps_p1_table[6] = 0;
				steps_p1_table[7] = 0;
				steps_p1_table[8] = 0;
				steps_p1_table[9] = 1;
			end;
			if p2_steps ~= nil then
				last_known_difficulty_P2 = p2_steps:GetDifficulty();
				p2_values = p2_steps:GetRadarValues('PlayerNumber_P2');
				steps_p2_table[1] = p2_values:GetValue('RadarCategory_TapsAndHolds');
				steps_p2_table[2] = p2_values:GetValue('RadarCategory_Jumps');
				steps_p2_table[3] = p2_values:GetValue('RadarCategory_Holds');
				steps_p2_table[4] = p2_values:GetValue('RadarCategory_Mines');
				steps_p2_table[5] = p2_values:GetValue('RadarCategory_Hands');
				steps_p2_table[6] = p2_values:GetValue('RadarCategory_Rolls');
				steps_p2_table[7] = p2_values:GetValue('RadarCategory_Lifts');
				steps_p2_table[8] = p2_values:GetValue('RadarCategory_Fakes');
				steps_p2_table[9] = steps_p2_table[1] + steps_p2_table[2] + steps_p2_table[3] + steps_p2_table[4] + steps_p2_table[5] + steps_p2_table[6] + steps_p2_table[7] + steps_p2_table[8];
			else
				last_known_difficulty_P2 = 'Difficulty_Edit';
				steps_p2_table[1] = 0;
				steps_p2_table[2] = 0;
				steps_p2_table[3] = 0;
				steps_p2_table[4] = 0;
				steps_p2_table[5] = 0;
				steps_p2_table[6] = 0;
				steps_p2_table[7] = 0;
				steps_p2_table[8] = 0;
				steps_p2_table[9] = 1;
			end;
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Variables");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Variables");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Variables");
	},
	-- Function (scripts)
	common_text("Select Music"),
	-- Actor (Sort Icon)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_RIGHT-26;y,SCREEN_TOP+15;zoomto,50,28;Load,THEME:GetPathG("", "sort_icon_unknown"));
		OnCommand=function(self)
			self:queuecommand("WheelSort");
		end;
		WheelSortCommand=function(self)
			-- Thanks Jousway
			sort = GAMESTATE:GetSortOrder();
			if sort ~= nil then
				self:Load(THEME:GetPathG("icon", sort));
			else
				self:Load(THEME:GetPathG("", "sort_icon_unknown"));
			end;
			self:finishtweening();
			self:zoomto(50,28);
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"WheelSort");
	},
	-- Actor (Song Banner)
	Def.Banner{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+70;zoomto,256,80;Load,THEME:GetPathG("", "no_banner"));
		OnCommand=function(self)
			self:queuecommand("SongBanner");
		end;
		SongBannerCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			group = GAMESTATE:GetExpandedSectionName();
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Roulette' then
				self:Load(THEME:GetPathG("", "roulette"))
			end;
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Section' then
				self:LoadFromSongGroup(group);
			end;
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				if song:HasBanner() == true then
					self:LoadFromSong(song);
				else
					self:LoadFromSongGroup(group);
				end;
			end;
			self:finishtweening();
			self:zoomto(256,80);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongBanner");
	},
	-- Actor (Song Background)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;zoomto,592,420;Load,THEME:GetPathG("", "no_background"));
		OnCommand=function(self)
			self:queuecommand("SongBackground");
		end;
		SongBackgroundCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				if song:HasBackground() == true then
					self:Load(GetSongBackground());
				else
					self:Load(THEME:GetPathG("", "no_background"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_background"));
			end;
			self:finishtweening();
			self:zoomto(592,420);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongBackground");
	},
	-- Actor (Song CD)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+300;y,SCREEN_TOP+69;zoomto,80,80;Load,THEME:GetPathG("", "no_cd"));
		OnCommand=function(self)
			self:queuecommand("SongCD");
		end;
		SongCDCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				if song:HasCDTitle() == true then
					self:Load(song:GetCDTitlePath());
				else
					self:Load(THEME:GetPathG("", "no_cd"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_cd"));
			end;
			self:finishtweening();
			self:zoomto(80,80);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongCD");
	},
	-- Actor (Song Difficulty P1)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+286;zoomto,64,64;Load,THEME:GetPathG("", "difficulty_unknown"));
		OnCommand=function(self)
			self:queuecommand("DifficultyP1");
		end;
		DifficultyP1Command=function(self)
			-- good lord, thank you for helping me out with this Kyzentun...
			p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' and p1_steps ~= nil then
				local difficulty = p1_steps:GetDifficulty();
				if difficulty ~= nil then
					self:Load(THEME:GetPathG("other", difficulty));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown"));
				end;
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown"));
			end;
			self:finishtweening();
			self:zoomto(64,64);
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"DifficultyP1");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyP1");
	},
	-- song difficulty p2
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+350;scaletoclipped,64,64;Load,THEME:GetPathG("", "difficulty_unknown"));
		OnCommand=function(self)
			self:queuecommand("DifficultyP2");
		end;
		DifficultyP2Command=function(self)
			p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' and p2_steps ~= nil then
				local difficulty = p2_steps:GetDifficulty();
				if difficulty ~= nil then
					self:Load(THEME:GetPathG("other", difficulty));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown"));
				end;
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown"));
			end;
			self:finishtweening();
		end;
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"DifficultyP2");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyP2");
	},
	-- Actor (Song Meter P1)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+286;scaletoclipped,192,64;Load,THEME:GetPathG("", "meter_0"));
		OnCommand=function(self)
			self:queuecommand("MeterP1");
		end;
		MeterP1Command=function(self)
			p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' and p1_steps ~= nil then
				-- Thanks Kyzentun.
				local half_meter=clamp(math.round(p1_steps:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_" .. half_meter .. "_display"));
			else
				self:Load(THEME:GetPathG("", "meter_0"));
			end;
			self:finishtweening();
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"MeterP1");
		CurrentSongChangedMessageCommand=cmd(playcommand,"MeterP1");
	},
	-- Actor (Song Meter P2)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+350;scaletoclipped,192,64;Load,THEME:GetPathG("", "meter_0"));
		OnCommand=function(self)
			self:queuecommand("MeterP2");
		end;
		MeterP2Command=function(self)
			p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' and p2_steps ~= nil then
				-- Thanks Kyzentun.
				local half_meter=clamp(math.round(p2_steps:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter.."_display"));
			else
				self:Load(THEME:GetPathG("", "meter_0"));
			end;
			self:finishtweening();
		end;
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"MeterP2");
		CurrentSongChangedMessageCommand=cmd(playcommand,"MeterP2");
	},
	-- Actor (Song/Group/Sort/etc. Information)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(scaletofit,SCREEN_LEFT+2,SCREEN_TOP+118,SCREEN_LEFT+256,SCREEN_TOP+242;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand("Information");
		end;
		InformationCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			local length_result = "Normal";
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' and song ~= nil then
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
				self:settext(song:GetDisplayMainTitle() .. "\n" .. song:GetDisplaySubTitle() .. "\n" .. song:GetDisplayArtist() .. "\n" .. results_tempo .. " BPM" .. "\n" .. song:GetGenre() .. "\n" .. song:GetGroupName() .. "\n" .. length_result .. "\n" .. round(song:MusicLengthSeconds(),1) .. " Seconds" );
			end;
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Roulette' then
				self:settext("Random");
			end;
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Section' then
				self:settext(wheel:GetSelectedSection());
			end;
			self:finishtweening();
			self:scaletofit(SCREEN_LEFT+2,SCREEN_TOP+118,SCREEN_LEFT+256,SCREEN_TOP+242);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Information");
	},
	-- Actor (Song Difficulty P1 Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+300;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:queuecommand("StringP1");
		end;
		StringP1Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
				local stdifficulty = "Unknown";
				if p1_steps ~= nil then
					local difficultysteps = p1_steps:GetDifficulty();
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
						stdifficulty = "Edit (" .. p1_steps:GetChartName() .. ")";
					else
						stdifficulty = "Unknown";
					end;
					self:settext("" .. stdifficulty .. " - " .. tostring(p1_steps:GetMeter()) );
				end;
			else
				self:settext("");
			end;
			self:finishtweening();
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StringP1");
	},
	-- Actor (Song Difficulty P2 Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+365;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:queuecommand("StringP2");
		end;
		StringP2Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
				local stdifficulty = "Unknown";
				if p2_steps ~= nil then
					local difficultysteps = p2_steps:GetDifficulty();
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
						stdifficulty = "Edit (" .. p2_steps:GetChartName() .. ")";
					else
						stdifficulty = "Unknown";
					end;
					self:settext("" .. stdifficulty .. " - " .. tostring(p2_steps:GetMeter()) );
				end;
			else
				self:settext("");
			end;
			self:finishtweening();
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"StringP2");
	},
	-- Actor (Radar)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+417;scaletoclipped,256,70;Load,THEME:GetPathG("", "radar_values"));
	},
	-- Actor (P1 Taps)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15,SCREEN_TOP+390;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarTapsP1");
		end;
		RadarTapsP1Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[1] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+390);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarTapsP1");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarTapsP1");
	},
	-- Actor (P1 Jumps)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15,SCREEN_TOP+397;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarJumpsP1");
		end;
		RadarJumpsP1Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[2] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+397);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsP1");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsP1");
	},
	-- Actor (P1 Holds)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15,SCREEN_TOP+404;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHoldsP1");
		end;
		RadarHoldsP1Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[3] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+404);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsP1");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsP1");
	},
	-- Actor (P1 Mines)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15,SCREEN_TOP+411;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarMinesP1");
		end;
		RadarMinesP1Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[4] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+411);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarMinesP1");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarMinesP1");
	},
	-- Actor (P1 Hands)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15,SCREEN_TOP+418;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHandsP1");
		end;
		RadarHandsP1Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[5] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+418);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHandsP1");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHandsP1");
	},
	-- Actor (P1 Rolls)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15,SCREEN_TOP+425;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarRollsP1");
		end;
		RadarRollsP1Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[6] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+425);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarRollsP1");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarRollsP1");
	},
	-- Actor (P1 Lifts)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15,SCREEN_TOP+432;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarLiftsP1");
		end;
		RadarLiftsP1Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[7] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+432);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsP1");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsP1");
	},
	-- Actor (P1 Fakes)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15,SCREEN_TOP+438;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarFakesP1");
		end;
		RadarFakesP1Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[8] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+438);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarFakesP1");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarFakesP1");
	},
	-- Actor (P2 Taps)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143,SCREEN_TOP+390;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarTapsP2");
		end;
		RadarTapsP2Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[1] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+390);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsP2");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarTapsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarTapsP2");
	},
	-- Actor (P2 Jumps)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143,SCREEN_TOP+397;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarJumpsP2");
		end;
		RadarJumpsP2Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[2] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+397);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsP2");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsP2");
	},
	-- Actor (P2 Holds)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143,SCREEN_TOP+404;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHoldsP2");
		end;
		RadarHoldsP2Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[3] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+404);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsP2");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsP2");
	},
	-- Actor (P2 Mines)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143,SCREEN_TOP+411;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarMinesP2");
		end;
		RadarMinesP2Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[4] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+411);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesP2");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarMinesP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarMinesP2");
	},
	-- Actor (P2 Hands)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143,SCREEN_TOP+418;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHandsP2");
		end;
		RadarHandsP2Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[5] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+418);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsP2");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHandsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHandsP2");
	},
	-- Actor (P2 Rolls)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143,SCREEN_TOP+425;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarRollsP2");
		end;
		RadarRollsP2Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[6] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+425);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsP2");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarRollsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarRollsP2");
	},
	-- Actor (P2 Lifts)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143,SCREEN_TOP+432;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarLiftsP2");
		end;
		RadarLiftsP2Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[7] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+432);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsP2");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsP2");
	},
	-- Actor (P2 Fakes)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143,SCREEN_TOP+438;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarFakesP2");
		end;
		RadarFakesP2Command=function(self)
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[8] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+438);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesP2");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarFakesP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarFakesP2");
	},
	-- Function (scripts)
	theme_skin("theme_skin"),
	-- Function (scripts)
	theme_skin("music_theme_skin")
};

return t;