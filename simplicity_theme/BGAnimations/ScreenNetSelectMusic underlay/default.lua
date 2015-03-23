-- ScreenNetSelectMusic underlay

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
	refresh_color(),
	-- Function (scripts)
	common_text("Select Music"),
	-- Actor (Last Known Difficulty Variable Online Hidden)
	-- SMO Edit: Technically, it only uses P1. P2 does not work online.
	Def.Actor{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		VariablesCommand=function(self)
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
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Variables");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Variables");
	},
	-- Actor (Sort Icon)
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_RIGHT-26;y,SCREEN_TOP+15;zoomto,50,28;Load,THEME:GetPathG("", "sort_icon_unknown"));
		WheelSortCommand=function(self)
			-- Thanks Jousway.
			sort = GAMESTATE:GetSortOrder();
			if sort ~= nil then
				self:Load(THEME:GetPathG("icon", sort));
			else
				self:Load(THEME:GetPathG("", "sort_icon_unknown"));
			end;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFFF"));
			self:sleep(0.025);
			self:zoomto(50,28);
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"WheelSort");
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
	LoadActor(THEME:GetPathG("", "no_banner"))..{
		InitCommand=cmd(x,SCREEN_LEFT+138;y,SCREEN_TOP+82;zoomto,256,80);
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
					self:Load(THEME:GetPathG("", "no_banner"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_banner"));
			end;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFFF"));
			self:sleep(0.025);
			self:zoomto(256,80);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Banner");
	},
	-- Actor (Song Difficulty P1)
	LoadActor(THEME:GetPathG("", "difficulty_unknown"))..{
		InitCommand=cmd(x,SCREEN_LEFT+318;y,SCREEN_TOP+74;zoomto,64,64);
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
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFFF"));
			self:sleep(0.025);
			self:zoomto(64,64);
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"DifficultyPA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyPA");
	},
	-- Actor (Song Meter P1)
	LoadActor(THEME:GetPathG("", "meter_0_display"))..{
		InitCommand=cmd(x,SCREEN_LEFT+448;y,SCREEN_TOP+74;zoomto,192,64);
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
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFFF"));
			self:sleep(0.025);
			self:zoomto(192,64);
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
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color(theme_color));
			self:sleep(0.025);
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
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.025);
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+114,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+118);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarTapsPA");
	},
	-- Actor (P1 Jumps)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarJumpsPACommand=function(self)
			p1_percentage = (steps_p1_table[2] / steps_p1_table[9])*100;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.025);
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+121,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+125);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarJumpsPA");
	},
	-- Actor (P1 Holds)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarHoldsPACommand=function(self)
			p1_percentage = (steps_p1_table[3] / steps_p1_table[9])*100;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.025);
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+128,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+132);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHoldsPA");
	},
	-- Actor (P1 Mines)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarMinesPACommand=function(self)
			p1_percentage = (steps_p1_table[4] / steps_p1_table[9])*100;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.025);
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+135,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+139);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarMinesPA");
	},
	-- Actor (P1 Hands)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarHandsPACommand=function(self)
			p1_percentage = (steps_p1_table[5] / steps_p1_table[9])*100;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.025);
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+142,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+146);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarHandsPA");
	},
	-- Actor (P1 Rolls)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarRollsPACommand=function(self)
			p1_percentage = (steps_p1_table[6] / steps_p1_table[9])*100;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.025);
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+149,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+153);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarRollsPA");
	},
	-- Actor (P1 Lifts)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarLiftsPACommand=function(self)
			p1_percentage = (steps_p1_table[7] / steps_p1_table[9])*100;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.025);
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+156,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+160);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarLiftsPA");
	},
	-- Actor (P1 Fakes)
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		RadarFakesPACommand=function(self)
			local p1_percentage = (steps_p1_table[8] / steps_p1_table[9])*100;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("1,0.25,0,1"));
			self:sleep(0.025);
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+163,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+167);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"RadarFakesPA");
	},
	-- Actor (Song Information)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
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
				self:settext(song:GetDisplayMainTitle() .. "\n" .. song:GetDisplaySubTitle() .. "\n" .. song:GetDisplayArtist() .. "\n" .. results_tempo .. " BPM\n" .. song:GetGenre() .. "\n" .. song:GetGroupName() .. "\n" .. length_result .. "\n" .. round(song:MusicLengthSeconds(),1) .. " Seconds");
			else
				self:settext("N/A" );
			end;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color(theme_color));
			self:sleep(0.025);
			self:scaletofit(SCREEN_LEFT+548,SCREEN_TOP+50,SCREEN_LEFT+800,SCREEN_TOP+196);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Information");
	},
	-- Actor (Song Background)
	LoadActor(THEME:GetPathG("", "no_background"))..{
		InitCommand=cmd(x,SCREEN_LEFT+565;y,SCREEN_TOP+327;zoomto,559,234);
		BGCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				if song ~= nil then
					if song:HasBackground() == true then
						self:Load(GetSongBackground());
					else
						self:Load(THEME:GetPathG("", "no_background"));
					end;
				else
					self:Load(THEME:GetPathG("", "no_background"));
				end;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFFF"));
			self:sleep(0.025);
			self:zoomto(559,234);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"BG");
	},
	-- Actor (Song CD)
	LoadActor(THEME:GetPathG("", "no_cd"))..{
		InitCommand=cmd(x,SCREEN_LEFT+326;y,SCREEN_TOP+251;zoomto,80,80);
		CDCommand=function(self)
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
			self:diffuse(color("#FFFFFF00"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF11"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF33"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF55"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF77"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFF99"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFBB"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFDD"));
			self:sleep(0.025);
			self:diffuse(color("#FFFFFFFF"));
			self:sleep(0.025);
			self:zoomto(80,80);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"CD");
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
	-- Actor (Player List) ...some day...
	LoadFont("Common","normal")..{
		Text="Player List";
		InitCommand=cmd(x,SCREEN_CENTER_X-132;y,SCREEN_CENTER_Y+85;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.4);
		OnCommand=function(self)
			self:settext("- Player List -" .. "\n" .. "Player 1" .. " " .. "Player 2" .. "\n" .. "Player 3" .. " " .. "Player 4" .. "\n" .. "Player 5" .. " " .. "Player 6" .. "\n" .. "Player 7" .. " " .. "Player 8" .. "\n" .. "Player 9" .. " " .. "Player 10" .. "\n" .. "Player 11" .. " " .. "Player 12" .. "\n" .. "Player 13" .. " " .. "Player 14" .. "\n" .. "Player 15" .. " " .. "Player 16" .. "\n" .. "Player 17" .. " " .. "Player 18" .. "\n" .. "Player 19" .. " " .. "Player 20" .. "\n" .. "Player 21" .. " " .. "Player 22" .. "\n" .. "Player 23" .. " " .. "Player 24" .. "\n" .. "Player 25" .. " " .. "Player 26" .. "\n" .. "Player 27" .. " " .. "Player 28" .. "\n" .. "Player 29" .. " " .. "Player 30" .. "\n" .. "Player 31" .. " " .. "Player 32");
		end;
	},
	-- Function (scripts/BugFix: Sort Icon)
	theme_skin("theme_skin"),
	-- Function (scripts)
	theme_skin("online_theme_skin")
};

return t;