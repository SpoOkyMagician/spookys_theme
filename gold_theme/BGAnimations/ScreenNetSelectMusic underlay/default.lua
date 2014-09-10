-- ScreenNetSelectMusic underlay

local t = Def.ActorFrame{
	-- screen text
	LoadFont("SpoOky")..{
		Text="Select Music";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	},
	-- last known difficulty variable online hidden actor
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
	-- last round info quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+40,SCREEN_RIGHT-8,SCREEN_TOP+204;diffuse,color(theme_background);basealpha,0.75);
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
	}
};

return t;