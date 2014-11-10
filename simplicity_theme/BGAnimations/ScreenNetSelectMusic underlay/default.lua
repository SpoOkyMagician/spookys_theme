-- ScreenNetSelectMusic underlay
-- having some issues with this screen... not much i can do about it right now...

local t = Def.ActorFrame{
	-- GLOBAL screen text
	common_text("Select Music"),
	-- last known difficulty variable online hidden actor
	-- smo edit: technically, it only uses p1. p2 does not work online.
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('Vars');
		end;
		VarsCommand=function(self)
			local p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			if p1_steps ~= nil then
				last_known_difficulty_P1 = p1_steps:GetDifficulty();
			else
				last_known_difficulty_P1 = 'Difficulty_Edit';
			end;
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Vars");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Vars");
	},
	-- radar variables P1 hidden actor
	-- smo edit: technically, it only uses p1. p2 does not work online.
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('Values');
		end;
		ValuesCommand=function(self)
			local p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
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
			end;
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Values");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Values");
	},
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
	-- moding info quad into two... part 1...
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+40,SCREEN_LEFT+280,SCREEN_TOP+204;diffuse,color(theme_background);basealpha,0.75);
	},
	-- moding info quad into two... part 2...
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+284,SCREEN_TOP+40,SCREEN_RIGHT-8,SCREEN_TOP+204;diffuse,color(theme_background);basealpha,0.75);
	},
	-- chat output quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+208,SCREEN_LEFT+280,SCREEN_TOP+372;diffuse,color(theme_background);basealpha,0.75);
	},
	-- chat input quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+376,SCREEN_LEFT+280,SCREEN_TOP+446;diffuse,color(theme_background);basealpha,0.75);
	},
	-- other stuff quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+284,SCREEN_TOP+208,SCREEN_RIGHT-8,SCREEN_TOP+446;diffuse,color(theme_background);basealpha,0.75);
	},
	-- song banner
	LoadActor(THEME:GetPathG("", "no_banner.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+138;y,SCREEN_TOP+82;zoomto,256,80);
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
	-- song difficulty p1
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+318;y,SCREEN_TOP+74;zoomto,64,64);
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
	-- song meter p1
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+448;y,SCREEN_TOP+74;zoomto,192,64);
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
	-- song/trail difficulty P1 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+360;y,SCREEN_TOP+89;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
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
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StringPA");
	},
	LoadActor(THEME:GetPathG("", "radar_values"))..{
		InitCommand=cmd(x,SCREEN_LEFT+414;y,SCREEN_TOP+144;zoomto,256,69);
	},
	-- quad p1 taps
	Def.Quad{
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarTapsPA");
		end;
		RadarTapsPACommand=function(self)
			local percentage = (steps_p1_taps / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+114,(SCREEN_LEFT+299)+percentage,SCREEN_TOP+118);
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
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarJumpsPA");
		end;
		RadarJumpsPACommand=function(self)
			local p1_percentage = (steps_p1_jumps / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+121,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+125);
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
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHoldsPA");
		end;
		RadarHoldsPACommand=function(self)
			local p1_percentage = (steps_p1_holds / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+128,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+132);
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
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarMinesPA");
		end;
		RadarMinesPACommand=function(self)
			local p1_percentage = (steps_p1_mines / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+135,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+139);
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
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarHandsPA");
		end;
		RadarHandsPACommand=function(self)
			local p1_percentage = (steps_p1_hands / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+142,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+146);
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
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarRollsPA");
		end;
		RadarRollsPACommand=function(self)
			local p1_percentage = (steps_p1_rolls / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+149,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+153);
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
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarLiftsPA");
		end;
		RadarLiftsPACommand=function(self)
			local p1_percentage = (steps_p1_lifts / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+156,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+160);
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
		InitCommand=cmd(stretchto,0,0,0,0;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("RadarFakesPA");
		end;
		RadarFakesPACommand=function(self)
			local p1_percentage = (steps_p1_fakes / steps_p1_total)*100;
			self:finishtweening();
			self:stoptweening();
			self:stretchto(SCREEN_LEFT+299,SCREEN_TOP+163,(SCREEN_LEFT+299)+p1_percentage,SCREEN_TOP+167);
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
	-- song/trail information
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
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
			self:scaletofit(SCREEN_LEFT+548,SCREEN_TOP+42,SCREEN_LEFT+800,SCREEN_TOP+204);
			self:diffuse(color("#FFFFFF00"));
			self:diffuse(color("#FFFFFF44"));
			self:diffuse(color("#FFFFFF88"));
			self:diffuse(color("#FFFFFFCC"));
			self:diffuse(color(theme_color));
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Information");
	},
	-- song background
	LoadActor(THEME:GetPathG("", "no_background.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+565;y,SCREEN_TOP+327;zoomto,559,234);
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
			self:zoomto(559,234);
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
		InitCommand=cmd(x,SCREEN_LEFT+326;y,SCREEN_TOP+251;zoomto,80,80);
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
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	}
};

return t;