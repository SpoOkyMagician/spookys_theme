-- ScreenSelectMusic underlay

-- good lord, thank you for helping me out with this Kyzentun...
-- now i understand the problem...

-- let's set some variables to organize/re-use later...
local wheel = false; -- SCREENMAN:GetTopScreen():GetMusicWheel();
local p1_steps = false; -- GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
local p2_steps = false; -- GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
local p1_values = false; -- p1_steps:GetRadarValues('PlayerNumber_P1');
local p2_values = false; -- p2_steps:GetRadarValues('PlayerNumber_P2');
local difficulty_p1_steps = false; -- p1_steps:GetDifficulty();
local difficulty_p2_steps = false; -- p2_steps:GetDifficulty();
local sort = false; -- GAMESTATE:GetSortOrder();
local song = false; -- GAMESTATE:GetCurrentSong();
local group = false; -- GAMESTATE:GetExpandedSectionName();

local last_known_difficulty_P1 = false;
local last_known_difficulty_P2 = false;
local last_known_stage = false;

local steps_p1_taps = false;
local steps_p1_jumps = false;
local steps_p1_holds = false;
local steps_p1_mines = false;
local steps_p1_hands = false;
local steps_p1_rolls = false;
local steps_p1_lifts = false;
local steps_p1_fakes = false;
local steps_p1_total = false;

local steps_p2_taps = false;
local steps_p2_jumps = false;
local steps_p2_holds = false;
local steps_p2_mines = false;
local steps_p2_hands = false;
local steps_p2_rolls = false;
local steps_p2_lifts = false;
local steps_p2_fakes = false;
local steps_p2_total = false;

local t = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrame";
	-- last known difficulty/radar variables P1/P2 (hidden actor)
	Def.Actor{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			-- this MUST be after the screen is done or it will not work correctly.
			wheel = SCREENMAN:GetTopScreen():GetMusicWheel();
		end;
		VariablesCommand=function(self)
			p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if p1_steps ~= nil then
				last_known_difficulty_P1 = p1_steps:GetDifficulty();
				p1_values = p1_steps:GetRadarValues('PlayerNumber_P1');
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
				last_known_difficulty_P1 = 'Difficulty_Edit';
				steps_p1_taps = 0;
				steps_p1_jumps = 0;
				steps_p1_holds = 0;
				steps_p1_mines = 0;
				steps_p1_hands = 0;
				steps_p1_rolls = 0;
				steps_p1_lifts = 0;
				steps_p1_fakes = 0;
				steps_p1_total = 0;
				steps_p1_total = 1; -- i don't think 0 is a good idea...
			end;
			if p2_steps ~= nil then
				last_known_difficulty_P2 = p2_steps:GetDifficulty();
				p2_values = p2_steps:GetRadarValues('PlayerNumber_P2');
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
				last_known_difficulty_P2 = 'Difficulty_Edit';
				steps_p2_taps = 0;
				steps_p2_jumps = 0;
				steps_p2_holds = 0;
				steps_p2_mines = 0;
				steps_p2_hands = 0;
				steps_p2_rolls = 0;
				steps_p2_lifts = 0;
				steps_p2_fakes = 0;
				steps_p2_total = 0;
				steps_p2_total = 1; -- i don't think 0 is a good idea...
			end;
			-- just in case i need to know...
			Trace("P1 Taps: " .. tostring(steps_p1_taps) .. ", P1 Jumps: " .. tostring(steps_p1_jumps) .. ", P1 Holds: " .. tostring(steps_p1_holds) .. ", P1 Mines: " .. tostring(steps_p1_mines) .. ", P1 Hands: " .. tostring(steps_p1_hands) .. ", P1 Rolls: " .. tostring(steps_p1_rolls) .. ", P1 Lifts: " .. tostring(steps_p1_lifts) .. ", P1 Fakes: " .. tostring(steps_p1_fakes) .. ", P1 Total: " .. tostring(steps_p1_total));
			Trace("P2 Taps: " .. tostring(steps_p2_taps) .. ", P2 Jumps: " .. tostring(steps_p2_jumps) .. ", P2 Holds: " .. tostring(steps_p2_holds) .. ", P2 Mines: " .. tostring(steps_p2_mines) .. ", P2 Hands: " .. tostring(steps_p2_hands) .. ", P2 Rolls: " .. tostring(steps_p2_rolls) .. ", P2 Lifts: " .. tostring(steps_p2_lifts) .. ", P2 Fakes: " .. tostring(steps_p2_fakes) .. ", P2 Total: " .. tostring(steps_p2_total));
			Trace("P1 Last Known Difficulty: " .. tostring(last_known_difficulty_P1));
			Trace("P2 Last Known Difficulty: " .. tostring(last_known_difficulty_P2));
			Trace("Last known Stage: " ..tostring(last_known_stage));
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Variables");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Variables");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Variables");
	},
	-- GLOBAL screen text
	common_text("Select Music"),
	-- sort icon
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_RIGHT-26;y,SCREEN_TOP+15;zoomto,50,28;Load,THEME:GetPathG("", "sort_icon_unknown"));
		WheelSortCommand=function(self)
			-- thanks Jousway
			sort = GAMESTATE:GetSortOrder();
			if sort ~= nil then
				self:Load(THEME:GetPathG("icon", sort));
			else
				self:Load(THEME:GetPathG("", "sort_icon_unknown"));
			end;
			self:zoomto(50,28);
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"WheelSort");
	},
	-- song banner
	Def.Banner{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+70;zoomto,256,80;Load,THEME:GetPathG("", "no_banner"));
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
			self:zoomto(256,80);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongBanner");
	},
	-- song background
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;zoomto,592,420;Load,THEME:GetPathG("", "no_background"));
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
			self:zoomto(592,420);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongBackground");
	},
	-- song cd
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+300;y,SCREEN_TOP+69;zoomto,80,80;Load,THEME:GetPathG("", "no_cd"));
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
			self:zoomto(80,80);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"SongCD");
	},
	-- song difficulty p1
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+286;zoomto,64,64;Load,THEME:GetPathG("", "difficulty_unknown"));
		DifficultyP1Command=function(self)
			-- good lord, thank you for helping me out with this Kyzentun...
			p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' and p1_steps ~= nil then
				if p1_steps:GetDifficulty() == 'Difficulty_Beginner' then
					self:Load(THEME:GetPathG("", "difficulty_beginner"));
				elseif p1_steps:GetDifficulty() == 'Difficulty_Easy' then
					self:Load(THEME:GetPathG("", "difficulty_easy"));
				elseif p1_steps:GetDifficulty() == 'Difficulty_Medium' then
					self:Load(THEME:GetPathG("", "difficulty_normal"));
				elseif p1_steps:GetDifficulty() == 'Difficulty_Hard' then
					self:Load(THEME:GetPathG("", "difficulty_hard"));
				elseif p1_steps:GetDifficulty() == 'Difficulty_Challenge' then
					self:Load(THEME:GetPathG("", "difficulty_challenge"));
				elseif p1_steps:GetDifficulty() == 'Difficulty_Edit' then
					self:Load(THEME:GetPathG("", "difficulty_edit"));
				end;
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown"));
			end;
			self:zoomto(64,64);
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"DifficultyP1");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyP1");
	},
	-- song difficulty p2
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+350;scaletoclipped,64,64;Load,THEME:GetPathG("", "difficulty_unknown"));
		DifficultyPBCommand=function(self)
			p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' and p2_steps ~= nil then
				if p2_steps:GetDifficulty() == 'Difficulty_Beginner' then
					self:Load(THEME:GetPathG("", "difficulty_beginner"));
				elseif p2_steps:GetDifficulty() == 'Difficulty_Easy' then
					self:Load(THEME:GetPathG("", "difficulty_easy"));
				elseif p2_steps:GetDifficulty() == 'Difficulty_Medium' then
					self:Load(THEME:GetPathG("", "difficulty_normal"));
				elseif p2_steps:GetDifficulty() == 'Difficulty_Hard' then
					self:Load(THEME:GetPathG("", "difficulty_hard"));
				elseif p2_steps:GetDifficulty() == 'Difficulty_Challenge' then
					self:Load(THEME:GetPathG("", "difficulty_challenge"));
				elseif p2_steps:GetDifficulty() == 'Difficulty_Edit' then
					self:Load(THEME:GetPathG("", "difficulty_edit"));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown"));
				end;
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown"));
			end;
		end;
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"DifficultyPB");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyPB");
	},
	-- song meter p1
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+286;scaletoclipped,192,64;Load,THEME:GetPathG("", "meter_0"));
		MeterPACommand=function(self)
			p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' and p1_steps ~= nil then
				-- use this instead... thanks again Kyzentun.
				local half_meter=clamp(math.round(p1_steps:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_" .. half_meter .. "_display"));
			else
				self:Load(THEME:GetPathG("", "meter_0"));
			end;
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"MeterPA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"MeterPA");
	},
	-- song meter p2
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+350;scaletoclipped,192,64;Load,THEME:GetPathG("", "meter_0"));
		MeterPBCommand=function(self)
			p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Song' and p2_steps ~= nil then
				-- use this instead... thanks again Kyzentun.
				local half_meter=clamp(math.round(p2_steps:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter.."_display"));
			else
				self:Load(THEME:GetPathG("", "meter_0"));
			end;
		end;
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"MeterPB");
		CurrentSongChangedMessageCommand=cmd(playcommand,"MeterPB");
	},
	-- song/trail/group/sort/etc information
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(scaletofit,SCREEN_LEFT+2,SCREEN_TOP+110,SCREEN_LEFT+256,SCREEN_TOP+250;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
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
				self:settext("Title: " .. song:GetDisplayMainTitle() .. "\nSub Title: " .. song:GetDisplaySubTitle() .. "\nSong Artist: " .. song:GetDisplayArtist() .. "\nTempo: " .. results_tempo .. "\nGenre: " .. song:GetGenre() .. "\nGroup: " .. song:GetGroupName() .. "\nLength: " .. length_result .. "\nSeconds: " .. round(song:MusicLengthSeconds(),1) );
			end;
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Roulette' then
				self:settext("Random");
			end;
			if wheel and wheel:GetSelectedType() == 'WheelItemDataType_Section' then
				self:settext(wheel:GetSelectedSection());
			end;
			self:scaletofit(SCREEN_LEFT+2,SCREEN_TOP+110,SCREEN_LEFT+256,SCREEN_TOP+250);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Information");
	},
	-- song difficulty P1 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+300;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		StringPACommand=function(self)
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
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StringPA");
	},
	-- song/trail difficulty P2 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+365;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		StringPBCommand=function(self)
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
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"StringPB");
	},
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+417;scaletoclipped,256,70;Load,THEME:GetPathG("", "radar_values"));
	},
	-- quad p1 taps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15,SCREEN_TOP+390;diffuse,color("1,0.25,0,1"));
		RadarTapsPACommand=function(self)
			local p1_percentage = (steps_p1_taps / steps_p1_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p1_percentage = 1;
			end;	
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+390);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
	},
	-- quad p1 jumps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15,SCREEN_TOP+397;diffuse,color("1,0.25,0,1"));
		RadarJumpsPACommand=function(self)
			local p1_percentage = (steps_p1_jumps / steps_p1_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p1_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+397);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
	},
	-- quad p1 holds
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15,SCREEN_TOP+404;diffuse,color("1,0.25,0,1"));
		RadarHoldsPACommand=function(self)
			local p1_percentage = (steps_p1_holds / steps_p1_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p1_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+404);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
	},
	-- quad p1 mines
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15,SCREEN_TOP+411;diffuse,color("1,0.25,0,1"));
		RadarMinesPACommand=function(self)
			local p1_percentage = (steps_p1_mines / steps_p1_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p1_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+411);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
	},
	-- quad p1 hands
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15,SCREEN_TOP+418;diffuse,color("1,0.25,0,1"));
		RadarHandsPACommand=function(self)
			local p1_percentage = (steps_p1_hands / steps_p1_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p1_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+418);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
	},
	-- quad p1 rolls
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15,SCREEN_TOP+425;diffuse,color("1,0.25,0,1"));
		RadarRollsPACommand=function(self)
			local p1_percentage = (steps_p1_rolls / steps_p1_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p1_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+425);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
	},
	-- quad p1 lifts
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15,SCREEN_TOP+432;diffuse,color("1,0.25,0,1"));
		RadarLiftsPACommand=function(self)
			local p1_percentage = (steps_p1_lifts / steps_p1_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p1_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+432);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
	},
	-- quad p1 fakes
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15,SCREEN_TOP+438;diffuse,color("1,0.25,0,1"));
		RadarFakesPACommand=function(self)
			local p1_percentage = (steps_p1_fakes / steps_p1_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p1_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15+p1_percentage,SCREEN_TOP+438);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
	},
	-- quad p2 taps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143,SCREEN_TOP+390;diffuse,color("0,0.5,1,1"));
		RadarTapsPBCommand=function(self)
			local p2_percentage = (steps_p2_taps / steps_p2_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p2_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+390);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarTapsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarTapsPB");
	},
	-- quad p2 jumps
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143,SCREEN_TOP+397;diffuse,color("0,0.5,1,1"));
		RadarJumpsPBCommand=function(self)
			local p2_percentage = (steps_p2_jumps / steps_p2_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p2_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+397);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsPB");
	},
	-- quad p2 holds
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143,SCREEN_TOP+404;diffuse,color("0,0.5,1,1"));
		RadarHoldsPBCommand=function(self)
			local p2_percentage = (steps_p2_holds / steps_p2_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p2_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+404);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsPB");
	},
	-- quad p2 mines
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143,SCREEN_TOP+411;diffuse,color("0,0.5,1,1"));
		RadarMinesPBCommand=function(self)
			local p2_percentage = (steps_p2_mines / steps_p2_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p2_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+411);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarMinesPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarMinesPB");
	},
	-- quad p2 hands
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143,SCREEN_TOP+418;diffuse,color("0,0.5,1,1"));
		RadarHandsPBCommand=function(self)
			local p2_percentage = (steps_p2_hands / steps_p2_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p2_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+418);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHandsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHandsPB");
	},
	-- quad p2 rolls
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143,SCREEN_TOP+425;diffuse,color("0,0.5,1,1"));
		RadarRollsPBCommand=function(self)
			local p2_percentage = (steps_p2_rolls / steps_p2_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p2_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+425);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarRollsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarRollsPB");
	},
	-- quad p2 lifts
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143,SCREEN_TOP+432;diffuse,color("0,0.5,1,1"));
		RadarLiftsPBCommand=function(self)
			local p2_percentage = (steps_p2_lifts / steps_p2_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p2_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+432);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsPB");
	},
	-- quad p2 fakes
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143,SCREEN_TOP+438;diffuse,color("0,0.5,1,1"));
		RadarFakesPBCommand=function(self)
			local p2_percentage = (steps_p2_fakes / steps_p2_total)*100;
			if wheel and wheel:GetSelectedType() ~= 'WheelItemDataType_Song' then
				p2_percentage = 1;
			end;
			self:stretchto(SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143+p2_percentage,SCREEN_TOP+438);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarFakesPB");
	},
	-- new theme skin i am experimenting with...
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;Load,THEME:GetPathG("", "theme_skin"));
	},
	-- new theme skin i am experimenting with...
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;Load,THEME:GetPathG("", "music_theme_skin"));
	}
};

return t;