-- ScreenNetSelectMusic underlay

-- these global variables needs to be reset here.

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
steps_p1_table[9] = 1;

steps_p2_table[1] = 0;
steps_p2_table[2] = 0;
steps_p2_table[3] = 0;
steps_p2_table[4] = 0;
steps_p2_table[5] = 0;
steps_p2_table[6] = 0;
steps_p2_table[7] = 0;
steps_p2_table[8] = 0;
steps_p2_table[9] = 1;

-- some day...

player_name_table = {};

player_name_table[1] = "-";
player_name_table[2] = "-";
player_name_table[3] = "-";
player_name_table[4] = "-";
player_name_table[5] = "-";
player_name_table[6] = "-";
player_name_table[7] = "-";
player_name_table[8] = "-";
player_name_table[9] = "-";
player_name_table[10] = "-";
player_name_table[11] = "-";
player_name_table[12] = "-";
player_name_table[13] = "-";
player_name_table[14] = "-";
player_name_table[15] = "-";
player_name_table[16] = "-";
player_name_table[17] = "-";
player_name_table[18] = "-";
player_name_table[19] = "-";
player_name_table[20] = "-";
player_name_table[21] = "-";
player_name_table[22] = "-";
player_name_table[23] = "-";
player_name_table[24] = "-";
player_name_table[25] = "-";
player_name_table[26] = "-";
player_name_table[27] = "-";
player_name_table[28] = "-";
player_name_table[29] = "-";
player_name_table[30] = "-";
player_name_table[31] = "-";
player_name_table[32] = "-";

p1_percentage = 0;
p2_percentage = 0;

local t = Def.ActorFrame{
	Name="ScreenNetSelectMusicUnderlayActorFrame";
	-- Function (scripts)
	common_text("Select Music"),
	-- Actor (Last Known Difficulty Variable Online Hidden)
	-- SMO Edit: Technically, it only uses P1. P2 does not work online.
	Def.Actor{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		VariablesACommand=function(self)
			p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
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
			self:finishtweening();
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"VariablesA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"VariablesA");
	},
	-- Actor (Sort Icon)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_RIGHT-26;y,SCREEN_TOP+15;scaletoclipped,50,28;Load,THEME:GetPathG("", "sort_icon_unknown"));
		WheelSortACommand=function(self)
			-- Thanks Jousway.
			sort = GAMESTATE:GetSortOrder();
			if sort ~= nil then
				self:Load(THEME:GetPathG("icon", sort));
			else
				self:Load(THEME:GetPathG("", "sort_icon_unknown"));
			end;
			self:finishtweening();
			self:scaletoclipped(50,28);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("#FFFFFFFF"));
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"WheelSortA");
	},
	-- Actor (Info Quad Part 1)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+40,SCREEN_LEFT+280,SCREEN_TOP+204;diffuse,color(theme_background);basealpha,0.75);
	},
	-- Actor (Info Quad Part 2)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+284,SCREEN_TOP+40,SCREEN_RIGHT-8,SCREEN_TOP+204;diffuse,color(theme_background);basealpha,0.75);
	},
	-- Actor (Chat Output)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+208,SCREEN_LEFT+280,SCREEN_TOP+372;diffuse,color(theme_background);basealpha,0.75);
	},
	-- Actor (Chat Input)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+376,SCREEN_LEFT+280,SCREEN_TOP+446;diffuse,color(theme_background);basealpha,0.75);
	},
	-- Actor (Other Stuff)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+284,SCREEN_TOP+208,SCREEN_RIGHT-8,SCREEN_TOP+446;diffuse,color(theme_background);basealpha,0.75);
	},
	-- Actor (Song Banner)
	-- SMO Edit: I cant get music wheel online? -_-' I'll use this one for now then...
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+138;y,SCREEN_TOP+82;scaletoclipped,256,80;Load,THEME:GetPathG("", "no_banner"));
		NetBannerCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song ~= nil then
				local group = song:GetGroupName();
				local banner = SONGMAN:GetSongGroupBannerPath(group);
				if song:HasBanner() == true then
					self:Load(song:GetBannerPath());
				elseif song:HasBanner() == false and banner ~= nil then
					self:Load(banner);
				else
					self:Load(THEME:GetPathG("", "no_banner"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_banner"));
			end;
			self:finishtweening();
			self:scaletoclipped(256,80);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("#FFFFFFFF"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"NetBanner");
	},
	-- Actor (Song Difficulty P1)
	LoadActor(THEME:GetPathG("", "difficulty_unknown"))..{
		InitCommand=cmd(x,SCREEN_LEFT+318;y,SCREEN_TOP+74;scaletoclipped,64,64);
		DifficultyPACommand=function(self)
			-- let's try something else...
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if steps ~= nil then
				local difficulty = steps:GetDifficulty();
				if difficulty ~= nil then
					self:Load(THEME:GetPathG("other", difficulty));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown"));
				end;
			end;
			self:finishtweening();
			self:scaletoclipped(64,64);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("#FFFFFFFF"));
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"DifficultyPA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyPA");
	},
	-- Actor (Song Meter P1)
	LoadActor(THEME:GetPathG("", "meter_0_display"))..{
		InitCommand=cmd(x,SCREEN_LEFT+448;y,SCREEN_TOP+74;scaletoclipped,192,64);
		MeterPACommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if steps ~= nil then
				-- Thanks Kyzentun
				local half_meter=clamp(math.round(steps:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter.."_display"));
			else
				self:Load(THEME:GetPathG("", "meter_0_display"));
			end;
			self:finishtweening();
			self:scaletoclipped(192,64);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("#FFFFFFFF"));
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"MeterPA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"MeterPA");
	},
	-- Actor (Song Difficulty P1 Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+360;y,SCREEN_TOP+89;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
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
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StringPA");
	},
	-- Actor (Radar)
	LoadActor(THEME:GetPathG("", "radar_values"))..{
		InitCommand=cmd(x,SCREEN_LEFT+414;y,SCREEN_TOP+144;zoomto,256,69);
	},
	-- Actor (P1 Taps)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarTapsPACommand=function(self)
			p1_percentage = (steps_p1_table[1] / steps_p1_table[9])*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+114,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+118);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
	},
	-- Actor (P1 Jumps)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarJumpsPACommand=function(self)
			p1_percentage = (steps_p1_table[2] / steps_p1_table[9])*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+121,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+125);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
	},
	-- Actor (P1 Holds)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarHoldsPACommand=function(self)
			p1_percentage = (steps_p1_table[3] / steps_p1_table[9])*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+128,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+132);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
	},
	-- Actor (P1 Mines)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarMinesPACommand=function(self)
			p1_percentage = (steps_p1_table[4] / steps_p1_table[9])*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+135,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+139);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
	},
	-- Actor (P1 Hands)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarHandsPACommand=function(self)
			p1_percentage = (steps_p1_table[5] / steps_p1_table[9])*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+142,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+146);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
	},
	-- Actor (P1 Rolls)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarRollsPACommand=function(self)
			p1_percentage = (steps_p1_table[6] / steps_p1_table[9])*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+149,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+153);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
	},
	-- Actor (P1 Lifts)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarLiftsPACommand=function(self)
			p1_percentage = (steps_p1_table[7] / steps_p1_table[9])*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+156,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+160);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
	},
	-- Actor (P1 Fakes)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarFakesPACommand=function(self)
			self:finishtweening();
			local p1_percentage = (steps_p1_table[8] / steps_p1_table[9])*100;
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+163,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+167);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
	},
	-- Actor (Song Information)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
		InformationACommand=function(self)
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
				self:settext(song:GetDisplayMainTitle() .. "\n" .. song:GetDisplaySubTitle() .. "\n" .. song:GetDisplayArtist() .. "\n" .. results_tempo .. " BPM\n" .. song:GetGenre() .. "\n" .. song:GetGroupName() .. "\n" .. length_result .. "\n" .. round(song:MusicLengthSeconds(),1) .. " Seconds");
			else
				self:settext("N/A" );
			end;
			self:finishtweening();
			self:scaletofit(SCREEN_LEFT+548,SCREEN_TOP+50,SCREEN_LEFT+800,SCREEN_TOP+196);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"InformationA");
	},
	-- Actor (Song Background)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT+565;y,SCREEN_TOP+327;scaletoclipped,559,234;Load,THEME:GetPathG("", "no_background"));
		NetBackgroundCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song ~= nil then
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
			self:scaletoclipped(559,234);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("#FFFFFFFF"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"NetBackground");
	},
	-- Actor (Song CD)
	LoadActor(THEME:GetPathG("", "no_cd"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-52;y,SCREEN_TOP+252;scaletoclipped,80,80);
		CDNetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song ~= nil then
				if song:HasCDTitle() == true then
					self:Load(song:GetCDTitlePath());
				else
					self:Load(THEME:GetPathG("", "no_cd"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_cd"));
			end;
			self:finishtweening();
			self:scaletoclipped(80,80);
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("#FFFFFFFF"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"CDNet");
	},
	-- Actor (Experiment)
	--LoadFont("Common","normal")..{
	--	Text="Experimental Text";
	--	InitCommand=cmd(x,SCREEN_CENTER_X+128;y,SCREEN_CENTER_Y-16;diffuse,color(theme_color);align,0.5,0.5;shadowlength,1;zoom,0.5);
	--	PackCommand=function(self)
	--		self:finishtweening();
	--		local song = GAMESTATE:GetCurrentSong();
	--		local group = "Nothing";
	--		local last_known_group = "Nothing";
	--		if song ~= nil then
	--			group = song:GetGroupName();
	--			-- the fun part...
	--			if group == "SHARPNELSTREAMZ v2" and last_known_group ~= "SHARPNELSTREAMZ v2" then
	--				last_known_group = group;
	--				self:settext("http://stepmaniaonline.net/downloads/packs/SHARPNELSTREAMZ%20v2.zip");
	--				GAMESTATE:ApplyGameCommand("urlnoexit,http://stepmaniaonline.net/downloads/packs/SHARPNELSTREAMZ%20v2.zip");
	--			else
	--				self:settext("Nothing");
	--			end;
	--		else
	--			self:settext("Nothing");
	--		end;
	--		Trace("Pack Name: " .. group);
	--	end;
	--	CurrentSongChangedMessageCommand=cmd(playcommand,"Pack");
	--},
	-- Actor (Player List Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+286,SCREEN_TOP+210,SCREEN_LEFT+426,SCREEN_BOTTOM-36;diffuse,color("0,0,0,0.8"));
	},
	-- Actor (Step Table Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-150,SCREEN_TOP+210,SCREEN_RIGHT-10,SCREEN_BOTTOM-36;diffuse,color("0,0,0,0.8"));
	},
	-- Actor (P1 Step Table)
	LoadFont("Common","normal")..{
		Text="Step Table P1";
		InitCommand=cmd(x,SCREEN_CENTER_X+282;y,SCREEN_CENTER_Y+130;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
		OnCommand=function(self)
			self:queuecommand("StepTableP1Net");
		end;
		StepTableP1NetCommand=function(self)
			self:finishtweening();
			self:settext("TAPS: " .. tostring(steps_p1_table[1]) .. "\n" .. "JUMPS: " .. tostring(steps_p1_table[2]) .. "\n" .. "HOLDS: " .. tostring(steps_p1_table[3]) .. "\n" .. "MINES: " .. tostring(steps_p1_table[4]) .. "\n" .. "HANDS: " .. tostring(steps_p1_table[5]) .. "\n" .. "ROLLS: " .. tostring(steps_p1_table[6]) .. "\n" .. "LIFTS: " .. tostring(steps_p1_table[7]) .. "\n" .. "FAKES: " .. tostring(steps_p1_table[8]) .. "\n" .. "TOTAL: " .. tostring(steps_p1_table[9]));
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StepTableP1Net");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StepTableP1Net");
	},
	-- Actor (Player List) ...some day...
	LoadFont("Common","normal")..{
		Text="Player List";
		InitCommand=cmd(x,SCREEN_CENTER_X-132;y,SCREEN_CENTER_Y+85;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.4);
		OnCommand=function(self)
			self:finishtweening();
			self:settext("- Player List -" .. "\n" .. "Player 1" .. " " .. "Player 2" .. "\n" .. "Player 3" .. " " .. "Player 4" .. "\n" .. "Player 5" .. " " .. "Player 6" .. "\n" .. "Player 7" .. " " .. "Player 8" .. "\n" .. "Player 9" .. " " .. "Player 10" .. "\n" .. "Player 11" .. " " .. "Player 12" .. "\n" .. "Player 13" .. " " .. "Player 14" .. "\n" .. "Player 15" .. " " .. "Player 16" .. "\n" .. "Player 17" .. " " .. "Player 18" .. "\n" .. "Player 19" .. " " .. "Player 20" .. "\n" .. "Player 21" .. " " .. "Player 22" .. "\n" .. "Player 23" .. " " .. "Player 24" .. "\n" .. "Player 25" .. " " .. "Player 26" .. "\n" .. "Player 27" .. " " .. "Player 28" .. "\n" .. "Player 29" .. " " .. "Player 30" .. "\n" .. "Player 31" .. " " .. "Player 32");
		end;
	},
	-- Actor/Function (scripts/BugFix: Sort Icon)
	theme_skin("theme_skin"),
	-- Actor/Function (scripts)
	theme_skin("online_theme_skin")
};

return t;