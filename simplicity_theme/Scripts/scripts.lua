-- This file uses global functions, variables, actors, etc. Whenever i need to call something often, it should be listed in here.

-- CUSTOM MESSAGE COMMANDS (IN USE)

-- UpLeft (scripts)
-- DownRight (scripts)

-- ResultsP1A (ScreenEvaluationNormal underlay)
-- ResultsP2A (ScreenEvaluationNormal underlay)

-- ResultsP1B (ScreenEvaluationSummary underlay)
-- ResultsP2B (ScreenEvaluationSummary underlay)

-- StageIcon (ScreenGameplay overlay)
-- IconPA (ScreenGameplay overlay)
-- IconPB (ScreenGameplay overlay)
-- PALife (ScreenGameplay overlay)
-- PBLife (ScreenGameplay overlay)
-- CustomTime (ScreenGameplay overlay)
-- Recalculate (ScreenGameplay overlay)
-- ResultsP1C (ScreenGameplay overlay)
-- ResultsP2C (ScreenGameplay overlay)
-- SoundCombo (ScreenGameplay overlay)
-- PACombo (ScreenGameplay overlay)
-- GradePA (ScreenGameplay overlay)
-- PBCombo (ScreenGameplay overlay)
-- GradePB (ScreenGameplay overlay)
-- PAScore (ScreenGameplay overlay)
-- PBScore (ScreenGameplay overlay)
-- Progress (ScreenGameplay overlay)
-- Reset (ScreenGameplay overlay)
-- P1Performance (ScreenGameplay overlay)
-- P2Performance (ScreenGameplay overlay)
-- P1P2Performance (ScreenGameplay overlay)

-- ResultsNet (ScreenNetEvaluation underlay)

-- VariablesA (ScreenNetSelectMusic underlay)
-- WheelSortA (ScreenNetSelectMusic underlay)
-- NetBanner (ScreenNetSelectMusic underlay)
-- DifficultyPA (ScreenNetSelectMusic underlay)
-- MeterPA (ScreenNetSelectMusic underlay)
-- StringPA (ScreenNetSelectMusic underlay)
-- RadarTapsPA (ScreenNetSelectMusic underlay)
-- RadarJumpsPA (ScreenNetSelectMusic underlay)
-- RadarHoldsPA (ScreenNetSelectMusic underlay)
-- RadarMinesPA (ScreenNetSelectMusic underlay)
-- RadarHandsPA (ScreenNetSelectMusic underlay)
-- RadarRollsPA (ScreenNetSelectMusic underlay)
-- RadarLiftsPA (ScreenNetSelectMusic underlay)
-- RadarFakesPA (ScreenNetSelectMusic underlay)
-- InformationA (ScreenNetSelectMusic underlay)
-- NetBackground (ScreenNetSelectMusic underlay)
-- CDNet (ScreenNetSelectMusic underlay)
-- StepTableP1Net (ScreenNetSelectMusic underlay)

-- WheelAndType (ScreenSelectMusic underlay)
-- VariablesB (ScreenSelectMusic underlay)
-- WheelSortB (ScreenSelectMusic underlay)
-- SongBanner (ScreenSelectMusic underlay)
-- SongBackground (ScreenSelectMusic underlay)
-- SongCD (ScreenSelectMusic underlay)
-- DifficultyP1 (ScreenSelectMusic underlay)
-- DifficultyP2 (ScreenSelectMusic underlay)
-- MeterP1 (ScreenSelectMusic underlay)
-- MeterP2 (ScreenSelectMusic underlay)
-- Information (ScreenSelectMusic underlay)
-- StringP1 (ScreenSelectMusic underlay)
-- StringP2 (ScreenSelectMusic underlay)
-- RadarTapsP1 (ScreenSelectMusic underlay)
-- RadarJumpsP1 (ScreenSelectMusic underlay)
-- RadarHoldsP1 (ScreenSelectMusic underlay)
-- RadarMinesP1 (ScreenSelectMusic underlay)
-- RadarHandsP1 (ScreenSelectMusic underlay)
-- RadarRollsP1 (ScreenSelectMusic underlay)
-- RadarLiftsP1 (ScreenSelectMusic underlay)
-- RadarFakesP1 (ScreenSelectMusic underlay)
-- RadarTapsP2 (ScreenSelectMusic underlay)
-- RadarJumpsP2 (ScreenSelectMusic underlay)
-- RadarHoldsP2 (ScreenSelectMusic underlay)
-- RadarMinesP2 (ScreenSelectMusic underlay)
-- RadarHandsP2 (ScreenSelectMusic underlay)
-- RadarRollsP2 (ScreenSelectMusic underlay)
-- RadarLiftsP2 (ScreenSelectMusic underlay)
-- RadarFakesP2 (ScreenSelectMusic underlay)
-- StepTableP1 (ScreenSelectMusic underlay)
-- HighscoreP1 (ScreenSelectMusic underlay)
-- StepTableP2 (ScreenSelectMusic underlay)
-- HighscoreP2 (ScreenSelectMusic underlay)

-- CheckTime (ScreenTitleMenu underlay)
-- RecheckTime (ScreenTitleMenu underlay)
-- MoveSun (ScreenTitleMenu underlay)
-- MoveMoon (ScreenTitleMenu underlay)

-- GLOBAL VARIABLES

-- Last Known Variables

last_known_stage='Stage_1st';
last_known_difficulty_p1='Difficulty_Edit';
last_known_difficulty_p2='Difficulty_Edit';
last_known_background="no_background";

-- Step Table

-- 1 = taps
-- 2 = jumps
-- 3 = holds
-- 4 = mines
-- 5 = hands
-- 6 = rolls
-- 7 = lifts
-- 8 = fakes
-- 9 = total

steps_p1_table = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
steps_p2_table = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
p1_percentage = 0;
p2_percentage = 0;

-- NPS Variables

total_p1 = 0;
count_p1 = 0;
nps_p1 = 0;
average_p1 = 0;
peak_p1 = 0;
chord_p1 = 0;

-- Original Gold - Primary Theme Color

theme_color="1,0.9,0,1";
theme_dark_color="0.5,0.4,0,1";
theme_background="0,0,0,1";

-- FUNCTIONS

-- Common Music

function main_song()
	return LoadActor(THEME:GetPathS("", "rave_party"))..{
		InitCommand=cmd(stop);
		OnCommand=cmd(play);
		OffCommand=cmd(stop);
	}
end;

function fast_song()
	return LoadActor(THEME:GetPathS("", "hurry_up"))..{
		InitCommand=cmd(stop);
		OnCommand=cmd(play);
		OffCommand=cmd(stop);
	}
end;

function slow_song()
	return LoadActor(THEME:GetPathS("", "chill_n_bass"))..{
		InitCommand=cmd(stop);
		OnCommand=cmd(play);
		OffCommand=cmd(stop);
	}
end;

-- Common Quad Actors

-- was grid_b
function grid_a()
	return Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_TOP+30;diffuse,color(theme_dark_color);diffusebottomedge,color(theme_background));
	}
end;

-- was grid_c
function grid_b()
	return Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-30,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_dark_color);diffusebottomedge,color(theme_background));
	}
end;

-- was grid_t
function grid_c()
	return Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-30,SCREEN_RIGHT-2,SCREEN_TOP+30;diffuse,color("0,0,0,0.75"));
	}
end;

-- was grid_u
function grid_d()
	return Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_color);basealpha,0.25);
	}
end;

-- Common Quad Actors (Fading)

function grid_fast_fade_out()
	return Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,0");sleep,0.025;diffuse,color("0,0,0,0.1");sleep,0.025;diffuse,color("0,0,0,0.2");sleep,0.025;diffuse,color("0,0,0,0.3");sleep,0.025;diffuse,color("0,0,0,0.4");sleep,0.025;diffuse,color("0,0,0,0.5");sleep,0.025;diffuse,color("0,0,0,0.6");sleep,0.025;diffuse,color("0,0,0,0.7");sleep,0.025;diffuse,color("0,0,0,0.8");sleep,0.025;diffuse,color("0,0,0,0.9");sleep,0.025;diffuse,color("0,0,0,1"));
	}
end;

function grid_fast_fade_in()
	return Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,1");sleep,0.025;diffuse,color("0,0,0,0.9");sleep,0.025;diffuse,color("0,0,0,0.8");sleep,0.025;diffuse,color("0,0,0,0.7");sleep,0.025;diffuse,color("0,0,0,0.6");sleep,0.025;diffuse,color("0,0,0,0.5");sleep,0.025;diffuse,color("0,0,0,0.4");sleep,0.025;diffuse,color("0,0,0,0.3");sleep,0.025;diffuse,color("0,0,0,0.2");sleep,0.025;diffuse,color("0,0,0,0.1");sleep,0.025;diffuse,color("0,0,0,0"));
	}
end;

function grid_slow_fade_out()
	return Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,0");sleep,0.25;diffuse,color("0,0,0,0.1");sleep,0.25;diffuse,color("0,0,0,0.2");sleep,0.25;diffuse,color("0,0,0,0.3");sleep,0.25;diffuse,color("0,0,0,0.4");sleep,0.25;diffuse,color("0,0,0,0.5");sleep,0.25;diffuse,color("0,0,0,0.6");sleep,0.25;diffuse,color("0,0,0,0.7");sleep,0.25;diffuse,color("0,0,0,0.8");sleep,0.25;diffuse,color("0,0,0,0.9");sleep,0.25;diffuse,color("0,0,0,1"));
	}
end;

function grid_slow_fade_in()
	return Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,1");sleep,0.25;diffuse,color("0,0,0,0.9");sleep,0.25;diffuse,color("0,0,0,0.8");sleep,0.25;diffuse,color("0,0,0,0.7");sleep,0.25;diffuse,color("0,0,0,0.6");sleep,0.25;diffuse,color("0,0,0,0.5");sleep,0.25;diffuse,color("0,0,0,0.4");sleep,0.25;diffuse,color("0,0,0,0.3");sleep,0.25;diffuse,color("0,0,0,0.2");sleep,0.25;diffuse,color("0,0,0,0.1");sleep,0.25;diffuse,color("0,0,0,0"));
	}
end;

function theme_skin(skin_name)
	return Def.Sprite{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;Load,THEME:GetPathG("",skin_name));
	}
end;

-- was grid_m
function grid_e()
	return Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+314,SCREEN_BOTTOM/2-18,SCREEN_RIGHT-314,SCREEN_BOTTOM/2+18;diffuse,color("0,0,0,0.5"));
	}
end;

function neat_arrow_left()
	return LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-96;y,SCREEN_CENTER_Y;baserotationz,90;SetSize,32,32);
		UpLeftCommand=function(self)
			self:finishtweening();
			self:x(SCREEN_CENTER_X-96-2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X-96-1);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X-96+2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X-96+1);
			self:sleep(0.02);
		end;
		MenuLeft1MessageCommand=cmd(playcommand,"UpLeft");
		MenuUp1MessageCommand=cmd(playcommand,"UpLeft");
		MenuLeft2MessageCommand=cmd(playcommand,"UpLeft");
		MenuUp2MessageCommand=cmd(playcommand,"UpLeft");
		MenuSelectionChangedMessageCommand=cmd(playcommand,"UpLeft");
	}
end;

function neat_arrow_right()
	return LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+96;y,SCREEN_CENTER_Y;baserotationz,-90;SetSize,32,32);
		DownRightCommand=function(self)
			self:finishtweening();
			self:x(SCREEN_CENTER_X+96+2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X+96+1);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X+96-2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X+96-1);
			self:sleep(0.02);
		end;
		MenuRight1MessageCommand=cmd(playcommand,"DownRight");
		MenuDown1MessageCommand=cmd(playcommand,"DownRight");
		MenuRight2MessageCommand=cmd(playcommand,"DownRight");
		MenuDown2MessageCommand=cmd(playcommand,"DownRight");
		MenuSelectionChangedMessageCommand=cmd(playcommand,"DownRight");
	}
end;

function transition_door_left_open()
	return LoadActor(THEME:GetPathG("", "screen_transition_left"))..{
		InitCommand=cmd(x,SCREEN_LEFT+213;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:x(SCREEN_LEFT+200);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+180);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+160);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+140);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+120);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+100);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+80);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+60);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+40);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+20);
			self:sleep(0.01);
			self:x(SCREEN_LEFT);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-20);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-40);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-60);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-80);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-100);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-120);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-140);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-160);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-180);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-200);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-213);
			self:sleep(0.01);
		end;
	}
end;

function transition_door_right_open()
	return LoadActor(THEME:GetPathG("", "screen_transition_right"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-213;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:x(SCREEN_RIGHT-200);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-180);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-160);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-140);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-120);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-100);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-80);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-60);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-40);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-20);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+20);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+40);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+60);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+80);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+100);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+120);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+140);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+160);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+180);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+200);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+213);
			self:sleep(0.01);
		end;
	}
end;

function transition_door_left_close()
	return LoadActor(THEME:GetPathG("", "screen_transition_left"))..{
		InitCommand=cmd(x,SCREEN_LEFT+213;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:x(SCREEN_LEFT-213);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-200);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-180);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-160);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-140);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-120);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-100);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-80);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-60);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-40);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-20);
			self:sleep(0.01);
			self:x(SCREEN_LEFT);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+20);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+40);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+60);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+80);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+100);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+120);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+140);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+160);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+180);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+200);
			self:sleep(0.01);
		end;
	}
end;

function transition_door_right_close()
	return LoadActor(THEME:GetPathG("", "screen_transition_right"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-213;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:x(SCREEN_RIGHT+213);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+200);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+180);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+160);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+140);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+120);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+100);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+80);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+60);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+40);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+20);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-20);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-40);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-60);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-80);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-100);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-120);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-140);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-160);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-180);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-200);
			self:sleep(0.01);
		end;
	}
end;

-- Common Function (Set Screen Text)

function common_text(string_text)
	return LoadFont("Common","normal")..{
		Text=ScreenString(string_text);
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			self:diffuse(color(theme_color));
		end;
	}
end;