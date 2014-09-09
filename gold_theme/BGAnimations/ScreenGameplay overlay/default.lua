-- ScreenGameplay overlay

local t = Def.ActorFrame{
	-- GLOBAL dark gold header quad
	grid_b,
	-- GLOBAL dark gold footer quad
	grid_c,
	-- GLOBAL top border
	grid_d,
	-- GLOBAL bottom border
	grid_e,
	-- GLOBAL left border
	grid_f,
	-- GLOBAL right border
	grid_g,
	-- GLOBAL profile border
	grid_h,
	-- GLOBAL screen border
	grid_i,
	-- GLOBAL profile divider
	grid_s,
	-- GLOBAL life meter p1 left border
	grid_o,
	-- GLOBAL life meter p1 right border
	grid_p,
	-- GLOBAL life meter p2 left border
	grid_q,
	-- GLOBAL life meter p2 right border
	grid_r,
	-- score quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-30,SCREEN_RIGHT-2,SCREEN_BOTTOM-52;diffuse,color("0,0,0,0.75"));
	},
	-- progress quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+30,SCREEN_RIGHT-2,SCREEN_TOP+52;diffuse,color("0,0,0,0.75"));
	},
	-- left quad experimental
--	Def.Quad{
--		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+62,SCREEN_LEFT+34,SCREEN_BOTTOM-62;diffuse,color("0,0,0,0.75"));
--	},
	-- right quad experimental
--	Def.Quad{
--		InitCommand=cmd(stretchto,SCREEN_RIGHT-2,SCREEN_TOP+62,SCREEN_RIGHT-34,SCREEN_BOTTOM-62;diffuse,color("0,0,0,0.75"));
--	},
	-- stage icon
	LoadActor(THEME:GetPathG("", "stage_icon_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_RIGHT/2;y,SCREEN_TOP+15);
		OnCommand=function(self)
			self:queuecommand('StageIcon');
		end;
		StageIconCommand=function(self)
			-- GLOBAL variable check
			if last_known_stage == 'Stage_1st' then
				self:Load(THEME:GetPathG("", "stage_icon_1st.png"));
			elseif last_known_stage == 'Stage_2nd' then
				self:Load(THEME:GetPathG("", "stage_icon_2nd.png"));
			elseif last_known_stage == 'Stage_3rd' then
				self:Load(THEME:GetPathG("", "stage_icon_3rd.png"));
			elseif last_known_stage == 'Stage_4th' then
				self:Load(THEME:GetPathG("", "stage_icon_4th.png"));
			elseif last_known_stage == 'Stage_5th' then
				self:Load(THEME:GetPathG("", "stage_icon_5th.png"));
			elseif last_known_stage == 'Stage_6th' then
				self:Load(THEME:GetPathG("", "stage_icon_6th.png"));
			elseif last_known_stage == 'Stage_Next' then
				self:Load(THEME:GetPathG("", "stage_icon_next.png"));
			elseif last_known_stage == 'Stage_Final' then
				self:Load(THEME:GetPathG("", "stage_icon_final.png"));
			elseif last_known_stage == 'Stage_Extra1' then
				self:Load(THEME:GetPathG("", "stage_icon_extra.png"));
			elseif last_known_stage == 'Stage_Extra2' then
				self:Load(THEME:GetPathG("", "stage_icon_encore.png"));
			elseif last_known_stage == 'Stage_Nonstop' then
				self:Load(THEME:GetPathG("", "stage_icon_nonstop.png"));
			elseif last_known_stage == 'Stage_Oni' then
				self:Load(THEME:GetPathG("", "stage_icon_oni.png"));
			elseif last_known_stage == 'Stage_Endless' then
				self:Load(THEME:GetPathG("", "stage_icon_endless.png"));
			elseif last_known_stage == 'Stage_Event' then
				self:Load(THEME:GetPathG("", "stage_icon_event.png"));
			elseif last_known_stage == 'Stage_Demo' then
				self:Load(THEME:GetPathG("", "stage_icon_demo.png"));
			else
				self:Load(THEME:GetPathG("", "stage_icon_unknown.png"));
			end;
		end;
	},
	-- song difficulty icon p1
	LoadActor(THEME:GetPathG("", "icon_edit.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+51;y,SCREEN_TOP+15);
		OnCommand=function(self)
			self:queuecommand('IconPA');
		end;
		IconPACommand=function(self)
			-- GLOBAL variable check
			local enabled_p1 = GAMESTATE:IsPlayerEnabled('PlayerNumber_P1');
			if last_known_difficulty_P1 == 'Difficulty_Beginner' then
				self:Load(THEME:GetPathG("", "icon_beginner.png"));
			elseif last_known_difficulty_P1 == 'Difficulty_Easy' then
				self:Load(THEME:GetPathG("", "icon_easy.png"));
			elseif last_known_difficulty_P1 == 'Difficulty_Medium' then
				self:Load(THEME:GetPathG("", "icon_normal.png"));
			elseif last_known_difficulty_P1 == 'Difficulty_Hard' then
				self:Load(THEME:GetPathG("", "icon_hard.png"));
			elseif last_known_difficulty_P1 == 'Difficulty_Challenge' then
				self:Load(THEME:GetPathG("", "icon_challenge.png"));
			elseif last_known_difficulty_P1 == 'Difficulty_Edit' then
				self:Load(THEME:GetPathG("", "icon_edit.png"));
			else
				self:Load(THEME:GetPathG("", "icon_unknown.png"));
			end;
			if enabled_p1 == false then
				self:Load(THEME:GetPathG("", "icon_unknown.png"));
			end;
		end;
	},
	-- song difficulty icon p2
	LoadActor(THEME:GetPathG("", "icon_edit.png"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-51;y,SCREEN_TOP+15);
		OnCommand=function(self)
			self:queuecommand('IconPB');
		end;
		IconPBCommand=function(self)
			-- GLOBAL variable check
			local enabled_p2 = GAMESTATE:IsPlayerEnabled('PlayerNumber_P2');
			if last_known_difficulty_P2 == 'Difficulty_Beginner' then
				self:Load(THEME:GetPathG("", "icon_beginner.png"));
			elseif last_known_difficulty_P2 == 'Difficulty_Easy' then
				self:Load(THEME:GetPathG("", "icon_easy.png"));
			elseif last_known_difficulty_P2 == 'Difficulty_Medium' then
				self:Load(THEME:GetPathG("", "icon_normal.png"));
			elseif last_known_difficulty_P2 == 'Difficulty_Hard' then
				self:Load(THEME:GetPathG("", "icon_hard.png"));
			elseif last_known_difficulty_P2 == 'Difficulty_Challenge' then
				self:Load(THEME:GetPathG("", "icon_challenge.png"));
			elseif last_known_difficulty_P2 == 'Difficulty_Edit' then
				self:Load(THEME:GetPathG("", "icon_edit.png"));
			else
				self:Load(THEME:GetPathG("", "icon_unknown.png"));
			end;
			if enabled_p2 == false then
				self:Load(THEME:GetPathG("", "icon_unknown.png"));
			end;
		end;
	},
	-- back life meter p1
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	},
	-- front life meter p1
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:diffuseleftedge(color("0,0,0,0.5"));
			self:queuecommand("PALife");
		end;
		PALifeCommand=function(self)
			-- shows error but, I cannot fix it... sorry...
			local screen = SCREENMAN:GetTopScreen();
			if screen:GetLifeMeter('PlayerNumber_P1') ~= nil then
				local meter_pa = screen:GetLifeMeter('PlayerNumber_P1');
				local life_pa = meter_pa:GetLife();
				self:diffuse(color("1,0.5,0,1"));
				self:stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+102+(300*life_pa),SCREEN_TOP+28);
				self:sleep(0.05);
				self:diffuse(color("1,0.25,0,1"));
				self:stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+102+(300*life_pa),SCREEN_TOP+28);
				self:diffuse(color("1,0.25,0,1"));
			end;
		end;
		LifeMeterChangedP1MessageCommand=cmd(playcommand,"PALife");
	},
	-- cover life meter p1
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28;diffuseleftedge,color("0,0,0,0.5");diffusealpha,0.25);
	},
	-- back life meter p2
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	},
	-- front life meter p2
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("PBLife");
		end;
		PBLifeCommand=function(self)
			-- shows error but, I cannot fix it... sorry...
			local screen = SCREENMAN:GetTopScreen();
			if screen:GetLifeMeter('PlayerNumber_P2') ~= nil then
				local meter_pb = screen:GetLifeMeter('PlayerNumber_P2');
				local life_pb = meter_pb:GetLife();
				self:diffuse(color("0,0.75,1,1"));
				self:stretchto(SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-402+(300*life_pb),SCREEN_TOP+28);
				self:sleep(0.05);
				self:diffuse(color("0,0.5,1,1"));
				self:stretchto(SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-402+(300*life_pb),SCREEN_TOP+28);
				self:diffuse(color("0,0.5,1,1"));
			end;
		end;
		-- BUG: dunno why but, this works... for now...
		-- change it to P2 when fixed...
		-- edit: seems to be fixed in nightly build 844... :)
		LifeMeterChangedP2MessageCommand=cmd(playcommand,"PBLife");
	},
	-- cover life meter p2
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuseleftedge,color("0,0,0,0.5");diffusealpha,0.25);
	},
	-- p1 combo number text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT/2-8;y,SCREEN_BOTTOM-40;align,1,0.5;diffuse,color("1,0.25,0,1");visible,false;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand("PACombo");
		end;
		PAComboCommand=function(self)
			local stats = STATSMAN:GetCurStageStats();
			local player_stats = stats:GetPlayerStageStats('PlayerNumber_P1');
			local combo = player_stats:GetCurrentCombo();
			if combo >=2 then
				self:visible(true);
				self:settext(tostring(combo));
				self:zoom(1.25);
				self:diffuse(color("1,0.5,0.5,1"));
				self:sleep(0.05);
				self:zoom(1.0);
				self:diffuse(color("1,0.25,0,1"));
			else
				self:visible(false);
			end;
		end;
		CurrentComboChangedP1MessageCommand=cmd(playcommand,"PACombo");
	},
	-- p2 combo number text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT/2+8;y,SCREEN_BOTTOM-40;align,0,0.5;diffuse,color("0,0.5,1,1");visible,false;shadowlength,1);
		OnCommand=function(self)
			self:queuecommand("PBCombo");
		end;
		PBComboCommand=function(self)
			local stats = STATSMAN:GetCurStageStats();
			local player_stats = stats:GetPlayerStageStats('PlayerNumber_P2');
			local combo = player_stats:GetCurrentCombo();
			if combo >=2 then
				self:visible(true);
				self:settext(tostring(combo));
				self:zoom(1.25);
				self:diffuse(color("0.5,0.75,1,1"));
				self:sleep(0.05);
				self:zoom(1.0);
				self:diffuse(color("0,0.5,1,1"));
			else
				self:visible(false);
			end;
		end;
		CurrentComboChangedP2MessageCommand=cmd(playcommand,"PBCombo");
	},
	-- p1 score text
	LoadFont("SpoOky")..{
		Text="000000000";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_BOTTOM-40;align,0,0.5;diffuse,color("1,0.25,0,1");shadowlength,1);
		OnCommand=function(self)
			self:queuecommand("PAScore");
		end;
		PAScoreCommand=function(self)
			local stats = STATSMAN:GetCurStageStats();
			local player_stats = stats:GetPlayerStageStats('PlayerNumber_P1');
			local score = player_stats:GetScore();
			self:settext(tostring(score));
			self:diffuse(color("1,0.5,0.5,1"));
			self:sleep(0.05);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentComboChangedP1MessageCommand=cmd(playcommand,"PAScore");
	},
	-- p2 score text
	LoadFont("SpoOky")..{
		Text="000000000";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_BOTTOM-40;align,1,0.5;diffuse,color("0,0.5,1,1");shadowlength,1);
		OnCommand=function(self)
			self:queuecommand("PBScore");
		end;
		PBScoreCommand=function(self)
			local stats = STATSMAN:GetCurStageStats();
			local player_stats = stats:GetPlayerStageStats('PlayerNumber_P2');
			local score = player_stats:GetScore();
			self:settext(tostring(score));
			self:diffuse(color("0.5,0.75,1,1"));
			self:sleep(0.05);
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentComboChangedP2MessageCommand=cmd(playcommand,"PBScore");
	},
	-- song remaining length back quad...
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+32,SCREEN_TOP+33,SCREEN_RIGHT-32,SCREEN_TOP+49;diffuse,color("0.2,0.1,0,1"));
	},
	-- song remaining length front quad...
	-- somewhat buggy but it works for now...
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+32,SCREEN_TOP+33,SCREEN_RIGHT-32,SCREEN_TOP+49;diffuse,color("1,0.9,0,1"));
		OnCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			beat_start = 0;
			beat_end = song:GetLastBeat();
			self:queuecommand("Progress");
		end;
		ProgressCommand=function(self)
			if song ~= nil then
				if beat_start < beat_end then
					beat_start = beat_start + 1;
				end;
				local beat_current = (beat_start / beat_end) * 790;
				self:stretchto(SCREEN_LEFT+32,SCREEN_TOP+33,(SCREEN_LEFT+32)+beat_current,SCREEN_TOP+49);
			end;
		end;
		BeatCrossedMessageCommand=cmd(playcommand,"Progress");
	},
	-- cover front quad...
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+32,SCREEN_TOP+33,SCREEN_RIGHT-32,SCREEN_TOP+49;diffuseleftedge,color("0,0,0,0.5");diffusealpha,0.25);
	},
	-- progress meter actor
	LoadActor(THEME:GetPathG("", "progress_meter.png"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+41);
	}
};

return t;