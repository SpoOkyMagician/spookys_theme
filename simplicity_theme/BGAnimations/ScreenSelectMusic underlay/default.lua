-- ScreenSelectMusic underlay

-- good lord, thank you for helping me out with this Kyzentun...
-- now i understand the problem...

-- note: I figured out even more... I feel like a dumbass not using trace more... wheel/type was not updating because I was not redeclaring the variables... finally fixed it.
-- note: Crap! That crashed the game... Thankfully, I found a fix that seems to prevent the crash. I still need to do some further testing though...

-- let's set some variables to organize/re-use later...
local wheel = {}; -- SCREENMAN:GetTopScreen():GetMusicWheel();
local type = {}; -- wheel:GetSelectedType();
local p1_steps = {}; -- GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
local p2_steps = {}; -- GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
local p1_values = 0; -- p1_steps:GetRadarValues('PlayerNumber_P1');
local p2_values = 0; -- p2_steps:GetRadarValues('PlayerNumber_P2');
local difficulty_p1_steps = 'Difficulty_Edit'; -- p1_steps:GetDifficulty();
local difficulty_p2_steps = 'Difficulty_Edit'; -- p2_steps:GetDifficulty();
local sort = 'SortOrder_Group'; -- GAMESTATE:GetSortOrder();
local song = {}; -- GAMESTATE:GetCurrentSong();
local group = "N/A"; -- GAMESTATE:GetExpandedSectionName();

-- These global variables needs to be reset.

steps_p1_table = {};
steps_p2_table = {};

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
	-- Actor (Last Known Difficulty/Radar Variables P1/P2 hidden)
	Def.Actor{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			wheel = SCREENMAN:GetTopScreen():GetMusicWheel();
			type = wheel:GetSelectedType();
			self:queuecommand("VariablesB");
		end;
		WheelAndTypeCommand=function(self)
			wheel = SCREENMAN:GetTopScreen():GetMusicWheel();
			type = wheel:GetSelectedType();
		end;
		VariablesBCommand=function(self)
			p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if p1_steps ~= nil and type == "WheelItemDataType_Song" then
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
			if p2_steps ~= nil and type == "WheelItemDataType_Song" then
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
			Trace("+--------+");
			Trace("| DEBUG  |");
			Trace("+--------+");
			Trace("| LKD P1: " .. tostring(last_known_difficulty_P1));
			Trace("| ST P1: " .. tostring(steps_p1_table[1]) .. ", " .. tostring(steps_p1_table[2]) .. ", " .. tostring(steps_p1_table[3]) .. ", " .. tostring(steps_p1_table[4]) .. ", " .. tostring(steps_p1_table[5]) .. ", " .. tostring(steps_p1_table[6]) .. ", " .. tostring(steps_p1_table[7]) .. ", " .. tostring(steps_p1_table[8]) .. " = " .. tostring(steps_p1_table[9]));
			Trace("+--------+");
			Trace("| LKD P2: " .. tostring(last_known_difficulty_P2));
			Trace("| ST P2: " .. tostring(steps_p2_table[1]) .. ", " .. tostring(steps_p2_table[2]) .. ", " .. tostring(steps_p2_table[3]) .. ", " .. tostring(steps_p2_table[4]) .. ", " .. tostring(steps_p2_table[5]) .. ", " .. tostring(steps_p2_table[6]) .. ", " .. tostring(steps_p2_table[7]) .. ", " .. tostring(steps_p2_table[8]) .. " = " .. tostring(steps_p2_table[9]));
			Trace("+--------+");
			Trace("| type: " .. tostring(type));
			Trace("+--------+");
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"VariablesB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"VariablesB");
		CurrentSongChangedMessageCommand=cmd(playcommand,"WheelAndType",playcommand,"VariablesB");
	},
	-- Function (scripts)
	common_text("Select Music"),
	-- Actor (Sort Icon)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_RIGHT-26;y,SCREEN_TOP+15;scaletoclipped,50,28;Load,THEME:GetPathG("", "sort_icon_unknown"));
		OnCommand=function(self)
			self:queuecommand("WheelSortB");
		end;
		WheelSortBCommand=function(self)
			-- Thanks Jousway
			sort = GAMESTATE:GetSortOrder();
			if sort ~= nil then
				self:Load(THEME:GetPathG("icon", sort));
			else
				self:Load(THEME:GetPathG("", "sort_icon_unknown"));
			end;
			self:finishtweening();
			self:linear(0.025);
			self:scaletoclipped(50,28);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("#FFFFFFFF"));
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"WheelSortB");
	},
	-- Actor (Song Banner)
	Def.Banner{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+70;scaletoclipped,256,80;Load,THEME:GetPathG("", "no_banner"));
		OnCommand=function(self)
			self:queuecommand("SongBanner");
		end;
		SongBannerCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			group = GAMESTATE:GetExpandedSectionName();
			if wheel and type == 'WheelItemDataType_Roulette' then
				self:Load(THEME:GetPathG("", "roulette"))
			end;
			if wheel and type == 'WheelItemDataType_Section' then
				Trace("+--------+");
				Trace("| DEBUG  |");
				Trace("+--------+");
				Trace("| group: " .. group);
				Trace("+--------+");
				self:LoadFromSongGroup(group);
			end;
			if wheel and type == 'WheelItemDataType_Song' and song ~= nil then
				if song:HasBanner() == true then
					self:LoadFromSong(song);
				else
					self:LoadFromSongGroup(group);
				end;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:scaletoclipped(256,80);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("#FFFFFFFF"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongBanner");
		WheelChangedMessageCommand=cmd(playcommand,"SongBanner");
	},
	-- Actor (Song Background)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;scaletoclipped,592,420;Load,THEME:GetPathG("", "no_background"));
		OnCommand=function(self)
			self:queuecommand("SongBackground");
		end;
		SongBackgroundCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			if wheel and type == 'WheelItemDataType_Song' and song ~= nil then
				if song:HasBackground() == true then
					last_known_background = song:GetBackgroundPath();
					self:Load(GetSongBackground());
				else
					local path = THEME:GetPathG("", "no_background");
					last_known_background=path;
					self:Load(THEME:GetPathG("", "no_background"));
				end;
			else
				local path = THEME:GetPathG("", "no_background");
				last_known_background=path;
				self:Load(THEME:GetPathG("", "no_background"));
			end;
			self:finishtweening();
			self:linear(0.025);
			self:scaletoclipped(592,420);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("#FFFFFFFF"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongBackground");
	},
	-- Actor (Song CD)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_RIGHT-44;y,SCREEN_TOP+72;scaletoclipped,80,80;Load,THEME:GetPathG("", "no_cd"));
		OnCommand=function(self)
			self:queuecommand("SongCD");
		end;
		SongCDCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			if wheel and type == 'WheelItemDataType_Song' and song ~= nil then
				if song:HasCDTitle() == true then
					self:Load(song:GetCDTitlePath());
				else
					self:Load(THEME:GetPathG("", "no_cd"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_cd"));
			end;
			self:finishtweening();
			self:linear(0.025);
			self:scaletoclipped(80,80);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("#FFFFFFFF"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongCD");
	},
	-- Actor (Song Difficulty P1)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+286;scaletoclipped,64,64;Load,THEME:GetPathG("", "difficulty_unknown"));
		OnCommand=function(self)
			self:queuecommand("DifficultyP1");
		end;
		DifficultyP1Command=function(self)
			-- good lord, thank you for helping me out with this Kyzentun...
			p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if wheel and type == 'WheelItemDataType_Song' and p1_steps ~= nil then
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
			self:linear(0.025);
			self:scaletoclipped(64,64);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("#FFFFFFFF"));
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"DifficultyP1");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyP1");
	},
	-- Actor (Song Difficulty P2)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+350;scaletoclipped,64,64;Load,THEME:GetPathG("", "difficulty_unknown"));
		OnCommand=function(self)
			self:queuecommand("DifficultyP2");
		end;
		DifficultyP2Command=function(self)
			p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if wheel and type == 'WheelItemDataType_Song' and p2_steps ~= nil then
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
			self:linear(0.025);
			self:scaletoclipped(64,64);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("#FFFFFFFF"));
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
			if wheel and type == 'WheelItemDataType_Song' and p1_steps ~= nil then
				-- Thanks Kyzentun.
				local half_meter=clamp(math.round(p1_steps:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_" .. half_meter .. "_display"));
			else
				self:Load(THEME:GetPathG("", "meter_0"));
			end;
			self:finishtweening();
			self:linear(0.025);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("#FFFFFFFF"));
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
			if wheel and type == 'WheelItemDataType_Song' and p2_steps ~= nil then
				-- Thanks Kyzentun.
				local half_meter=clamp(math.round(p2_steps:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter.."_display"));
			else
				self:Load(THEME:GetPathG("", "meter_0"));
			end;
			self:finishtweening();
			self:linear(0.025);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("#FFFFFFFF"));
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
		InformationBCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			local length_result = "Normal";
			if wheel and type == 'WheelItemDataType_Song' and song ~= nil then
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
			if wheel and type == 'WheelItemDataType_Roulette' then
				self:settext("Random");
			end;
			if wheel and type == 'WheelItemDataType_Section' then
				self:settext(wheel:GetSelectedSection());
			end;
			self:finishtweening();
			self:linear(0.025);
			self:scaletofit(SCREEN_LEFT+2,SCREEN_TOP+118,SCREEN_LEFT+256,SCREEN_TOP+242);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"InformationB");
	},
	-- Actor (Song Difficulty P1 Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+300;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand("StringP1");
		end;
		StringP1Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
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
			self:linear(0.025);
			self:zoom(0.5);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StringP1");
	},
	-- Actor (Song Difficulty P2 Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+365;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand("StringP2");
		end;
		StringP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
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
			self:linear(0.025);
			self:zoom(0.5);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color(theme_color));
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
			if wheel and type == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[1] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+390);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarTapsP1");
	},
	-- Actor (P1 Jumps)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15,SCREEN_TOP+397;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarJumpsP1");
		end;
		RadarJumpsP1Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[2] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+397);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsP1");
	},
	-- Actor (P1 Holds)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15,SCREEN_TOP+404;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHoldsP1");
		end;
		RadarHoldsP1Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[3] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+404);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsP1");
	},
	-- Actor (P1 Mines)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15,SCREEN_TOP+411;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarMinesP1");
		end;
		RadarMinesP1Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[4] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+411);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarMinesP1");
	},
	-- Actor (P1 Hands)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15,SCREEN_TOP+418;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHandsP1");
		end;
		RadarHandsP1Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[5] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+418);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHandsP1");
	},
	-- Actor (P1 Rolls)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15,SCREEN_TOP+425;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarRollsP1");
		end;
		RadarRollsP1Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[6] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+425);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarRollsP1");
	},
	-- Actor (P1 Lifts)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15,SCREEN_TOP+432;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarLiftsP1");
		end;
		RadarLiftsP1Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[7] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+432);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsP1");
	},
	-- Actor (P1 Fakes)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15,SCREEN_TOP+438;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarFakesP1");
		end;
		RadarFakesP1Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p1_percentage = (steps_p1_table[8] / steps_p1_table[9])*100;
			else
				p1_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+438);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarFakesP1");
	},
	-- Actor (P2 Taps)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143,SCREEN_TOP+390;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarTapsP2");
		end;
		RadarTapsP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[1] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+390);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarTapsP2");
	},
	-- Actor (P2 Jumps)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143,SCREEN_TOP+397;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarJumpsP2");
		end;
		RadarJumpsP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[2] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+397);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsP2");
	},
	-- Actor (P2 Holds)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143,SCREEN_TOP+404;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHoldsP2");
		end;
		RadarHoldsP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[3] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+404);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsP2");
	},
	-- Actor (P2 Mines)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143,SCREEN_TOP+411;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarMinesP2");
		end;
		RadarMinesP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[4] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+411);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarMinesP2");
	},
	-- Actor (P2 Hands)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143,SCREEN_TOP+418;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHandsP2");
		end;
		RadarHandsP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[5] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+418);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHandsP2");
	},
	-- Actor (P2 Rolls)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143,SCREEN_TOP+425;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarRollsP2");
		end;
		RadarRollsP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[6] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+425);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarRollsP2");
	},
	-- Actor (P2 Lifts)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143,SCREEN_TOP+432;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarLiftsP2");
		end;
		RadarLiftsP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[7] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+432);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsP2");
	},
	-- Actor (P2 Fakes)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143,SCREEN_TOP+438;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("RadarFakesP2");
		end;
		RadarFakesP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p2_percentage = (steps_p2_table[8] / steps_p2_table[9])*100;
			else
				p2_percentage = 1;
			end;
			self:finishtweening();
			self:linear(0.025);
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+438);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarFakesP2");
	},
	-- Actor (Step Table Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+260,SCREEN_TOP+30,SCREEN_LEFT+650,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- Actor (P1 Step Table)
	LoadFont("Common","normal")..{
		Text="Step Table P1";
		InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y-128;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:queuecommand("StepTableP1");
		end;
		StepTableP1Command=function(self)
			self:finishtweening();
			self:linear(0.025);
			self:settext("TAPS: " .. tostring(steps_p1_table[1]) .. "\n" .. "JUMPS: " .. tostring(steps_p1_table[2]) .. "\n" .. "HOLDS: " .. tostring(steps_p1_table[3]) .. "\n" .. "MINES: " .. tostring(steps_p1_table[4]) .. "\n" .. "HANDS: " .. tostring(steps_p1_table[5]) .. "\n" .. "ROLLS: " .. tostring(steps_p1_table[6]) .. "\n" .. "LIFTS: " .. tostring(steps_p1_table[7]) .. "\n" .. "FAKES: " .. tostring(steps_p1_table[8]) .. "\n" .. "TOTAL: " .. tostring(steps_p1_table[9]));
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StepTableP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StepTableP1");
	},
	-- Actor (P1 Highscore)
	LoadFont("Common","normal")..{
		Text="P1 Highscore";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-128;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		HighscoreP1Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
				if p1_steps ~= nil then
					song = GAMESTATE:GetCurrentSong();
					local profile = GetPlayerOrMachineProfile('PlayerNumber_P1');
					local highscore_list = profile:GetHighScoreListIfExists(song, p1_steps);
					local highscore = highscore_list:GetHighScores();
					if highscore ~= nil and highscore[1] ~= nil then
						local highest_grade = highscore[1]:GetGrade();
						local string_grade = "AAAA";
						if highest_grade == 'Grade_Tier01' then
							string_grade = "AAAA";
						elseif highest_grade == 'Grade_Tier02' then
							string_grade = "AAA";
						elseif highest_grade == 'Grade_Tier03' then
							string_grade = "AA";
						elseif highest_grade == 'Grade_Tier04' then
							string_grade = "A";
						elseif highest_grade == 'Grade_Tier05' then
							string_grade = "B";
						elseif highest_grade == 'Grade_Tier06' then
							string_grade = "C";
						elseif highest_grade == 'Grade_Tier07' then
							string_grade = "D";
						elseif highest_grade == 'Grade_Failed' then
							string_grade = "F";
						else
							string_grade = "ERROR";
						end;
						local highest_score = highscore[1]:GetScore();
						local highest_percent = round(highscore[1]:GetPercentDP() * 100, 2);
						local highest_maxcombo = highscore[1]:GetMaxCombo();
						local highest_datetime = highscore[1]:GetDate();
						self:settext("Grade: " .. tostring(string_grade) .. "\nPercent: " .. tostring(highest_percent) .. "%\nScore: " .. tostring(highest_score) .. "\nMax Combo: " .. tostring(highest_maxcombo) .. "\nDate/Time: " .. tostring(highest_datetime) );
					else
						self:settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
					end;
				else
					self:settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
				end;
			else
				self:settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
			end;
			self:finishtweening();
			self:linear(0.025);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"HighscoreP1");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"HighscoreP1");
	},
	-- Actor (P2 Step Table)
	LoadFont("Common","normal")..{
		Text="Step Table P2";
		InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y+128;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:queuecommand("StepTableP2");
		end;
		StepTableP2Command=function(self)
			self:finishtweening();
			self:linear(0.025);
			self:settext("TAPS: " .. tostring(steps_p2_table[1]) .. "\n" .. "JUMPS: " .. tostring(steps_p2_table[2]) .. "\n" .. "HOLDS: " .. tostring(steps_p2_table[3]) .. "\n" .. "MINES: " .. tostring(steps_p2_table[4]) .. "\n" .. "HANDS: " .. tostring(steps_p2_table[5]) .. "\n" .. "ROLLS: " .. tostring(steps_p2_table[6]) .. "\n" .. "LIFTS: " .. tostring(steps_p2_table[7]) .. "\n" .. "FAKES: " .. tostring(steps_p2_table[8]) .. "\n" .. "TOTAL: " .. tostring(steps_p2_table[9]));
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StepTableP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"StepTableP2");
	},
	-- Actor (P2 Highscore)
	LoadFont("Common","normal")..{
		Text="P2 Highscore";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+128;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		HighscoreP2Command=function(self)
			if wheel and type == 'WheelItemDataType_Song' then
				p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
				if p2_steps ~= nil then
					song = GAMESTATE:GetCurrentSong();
					local profile = GetPlayerOrMachineProfile('PlayerNumber_P2');
					local highscore_list = profile:GetHighScoreListIfExists(song, p2_steps);
					local highscore = highscore_list:GetHighScores();
					if highscore ~= nil and highscore[1] ~= nil then
						local highest_grade = highscore[1]:GetGrade();
						local string_grade = "AAAA";
						if highest_grade == 'Grade_Tier01' then
							string_grade = "AAAA";
						elseif highest_grade == 'Grade_Tier02' then
							string_grade = "AAA";
						elseif highest_grade == 'Grade_Tier03' then
							string_grade = "AA";
						elseif highest_grade == 'Grade_Tier04' then
							string_grade = "A";
						elseif highest_grade == 'Grade_Tier05' then
							string_grade = "B";
						elseif highest_grade == 'Grade_Tier06' then
							string_grade = "C";
						elseif highest_grade == 'Grade_Tier07' then
							string_grade = "D";
						elseif highest_grade == 'Grade_Failed' then
							string_grade = "F";
						else
							string_grade = "ERROR";
						end;
						local highest_score = highscore[1]:GetScore();
						local highest_percent = round(highscore[1]:GetPercentDP() * 100, 2);
						local highest_maxcombo = highscore[1]:GetMaxCombo();
						local highest_datetime = highscore[1]:GetDate();
						self:settext("Grade: " .. tostring(string_grade) .. "\nPercent: " .. tostring(highest_percent) .. "%\nScore: " .. tostring(highest_score) .. "\nMax Combo: " .. tostring(highest_maxcombo) .. "\nDate/Time: " .. tostring(highest_datetime) );
					else
						self:settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
					end;
				else
					self:settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
				end;
			else
				self:settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
			end;
			self:finishtweening();
			self:linear(0.025);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF11"));
			self:diffuse(color("#FFFFFF33"));
			self:diffuse(color("#FFFFFF55"));
			self:diffuse(color("#FFFFFF77"));
			self:diffuse(color("#FFFFFF99"));
			self:diffuse(color("#FFFFFFBB"));
			self:diffuse(color("#FFFFFFDD"));
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"HighscoreP2");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"HighscoreP2");
	},
	-- Actor (Step Table Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-196,SCREEN_BOTTOM-96,SCREEN_RIGHT-3,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- Actor (P1 NPS Results Test)
	LoadFont("Common","normal")..{
		Text=" ";
		InitCommand=cmd(x,SCREEN_RIGHT-8;y,SCREEN_BOTTOM-64;align,1,0.5;diffuse,color(theme_color);shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:settext("Last Song NPS Stats:\nAverage NPS: " .. tostring(average_p1) .. "\nPeak NPS: " .. tostring(peak_p1) );
		end;
	},
	-- Actor/Function (scripts)
	theme_skin("theme_skin"),
	-- Actor/Function (scripts)
	theme_skin("music_theme_skin")
};

return t;