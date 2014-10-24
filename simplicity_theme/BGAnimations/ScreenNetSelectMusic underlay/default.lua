-- ScreenNetSelectMusic underlay

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
			self:zoomto(256,80);
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
			self:zoomto(64,64);
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
			self:zoomto(192,64);
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
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StringPA");
	},
	LoadActor(THEME:GetPathG("", "radar_values"))..{
		InitCommand=cmd(x,SCREEN_LEFT+414;y,SCREEN_TOP+144;zoomto,256,69);
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
			self:scaletofit(SCREEN_LEFT+548,SCREEN_TOP+42,SCREEN_LEFT+800,SCREEN_TOP+204);
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
			self:zoomto(559,234);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"BG");
	}
};

return t;