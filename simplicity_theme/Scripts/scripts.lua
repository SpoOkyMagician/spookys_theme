-- This file uses global functions, variables, actors, etc. Whenever i need to call something often, it should be in here.

local prefs = {
	ColorPref =
	{
		Default = 1,
		Choices = { "Gold", "Red", "Green", "Blue", "Yellow", "Teal", "Purple", "Orange", "Magenta", "Lime", "Sky Blue", "Grey" },
		Values = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
	}
}

ThemePrefs.InitAll(prefs)

-- Global Varaibles
last_known_stage='Stage_1st';
last_known_difficulty_p1='Difficulty_Edit';
last_known_difficulty_p2='Difficulty_Edit';
-- 1 = taps, 2 = jumps, 3 = holds, 4 = mines, 5 = hands, 6 = rolls, 7 = lifts, 8 = fakes, 9 = total
steps_p1_table = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
steps_p2_table = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
p1_percentage = 0;
p2_percentage = 0;

-- Original Gold - Primary Theme Color

theme_color="1,0.9,0,1";
theme_dark_color="0.5,0.4,0,1";
theme_background="0,0,0,1";

-- Common Music

main_song = LoadActor(THEME:GetPathS("", "rave_party"))..{ InitCommand=cmd(stop); OnCommand=cmd(play); OffCommand=cmd(stop); };
fast_song = LoadActor(THEME:GetPathS("", "hurry_up"))..{ InitCommand=cmd(stop); OnCommand=cmd(play); OffCommand=cmd(stop); };
slow_song = LoadActor(THEME:GetPathS("", "chill_n_bass"))..{ InitCommand=cmd(stop); OnCommand=cmd(play); OffCommand=cmd(stop); };

-- Common Quad Actors

grid_b = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_TOP+30;diffuse,color(theme_dark_color);diffusebottomedge,color(theme_background)); };
grid_c = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-30,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_dark_color);diffusebottomedge,color(theme_background)); };
grid_t = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-30,SCREEN_RIGHT-2,SCREEN_TOP+30;diffuse,color("0,0,0,0.75")); };
grid_u = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_color);basealpha,0.25); };

-- Common Quad Actors (Fading)

grid_fast_fade_out = Def.Quad{ OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,0");sleep,0.025;diffuse,color("0,0,0,0.1");sleep,0.025;diffuse,color("0,0,0,0.2");sleep,0.025;diffuse,color("0,0,0,0.3");sleep,0.025;diffuse,color("0,0,0,0.4");sleep,0.025;diffuse,color("0,0,0,0.5");sleep,0.025;diffuse,color("0,0,0,0.6");sleep,0.025;diffuse,color("0,0,0,0.7");sleep,0.025;diffuse,color("0,0,0,0.8");sleep,0.025;diffuse,color("0,0,0,0.9");sleep,0.025;diffuse,color("0,0,0,1")); };
grid_fast_fade_in = Def.Quad{ OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,1");sleep,0.025;diffuse,color("0,0,0,0.9");sleep,0.025;diffuse,color("0,0,0,0.8");sleep,0.025;diffuse,color("0,0,0,0.7");sleep,0.025;diffuse,color("0,0,0,0.6");sleep,0.025;diffuse,color("0,0,0,0.5");sleep,0.025;diffuse,color("0,0,0,0.4");sleep,0.025;diffuse,color("0,0,0,0.3");sleep,0.025;diffuse,color("0,0,0,0.2");sleep,0.025;diffuse,color("0,0,0,0.1");sleep,0.025;diffuse,color("0,0,0,0")); };
grid_slow_fade_out = Def.Quad{ OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,0");sleep,0.25;diffuse,color("0,0,0,0.1");sleep,0.25;diffuse,color("0,0,0,0.2");sleep,0.25;diffuse,color("0,0,0,0.3");sleep,0.25;diffuse,color("0,0,0,0.4");sleep,0.25;diffuse,color("0,0,0,0.5");sleep,0.25;diffuse,color("0,0,0,0.6");sleep,0.25;diffuse,color("0,0,0,0.7");sleep,0.25;diffuse,color("0,0,0,0.8");sleep,0.25;diffuse,color("0,0,0,0.9");sleep,0.25;diffuse,color("0,0,0,1")); };
grid_slow_fade_in = Def.Quad{ OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,1");sleep,0.25;diffuse,color("0,0,0,0.9");sleep,0.25;diffuse,color("0,0,0,0.8");sleep,0.25;diffuse,color("0,0,0,0.7");sleep,0.25;diffuse,color("0,0,0,0.6");sleep,0.25;diffuse,color("0,0,0,0.5");sleep,0.25;diffuse,color("0,0,0,0.4");sleep,0.25;diffuse,color("0,0,0,0.3");sleep,0.25;diffuse,color("0,0,0,0.2");sleep,0.25;diffuse,color("0,0,0,0.1");sleep,0.25;diffuse,color("0,0,0,0")); };

-- Common Function (Refreshes the theme colors)

function theme_skin(skin_name)
	return Def.Sprite{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;Load,THEME:GetPathG("",skin_name));
	}
end

function refresh_color()
	return Def.Actor{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;playcommand,"ColorPicked");
		ColorPickedCommand=function(self)
			local pref = GetThemePref("ColorPref");
			if pref == 1 then
				-- Original Gold - Primary Theme Color
				theme_color="1,0.9,0,1";
				theme_dark_color="0.5,0.4,0,1";
				theme_background="0,0,0,1";
			elseif pref == 2 then
				-- Red (Common)
				theme_color="1,0,0,1";
				theme_dark_color="0.5,0,0,1";
				theme_background="0,0,0,1";
			elseif pref == 3 then
				-- Green (Common)
				theme_color="0,1,0,1";
				theme_dark_color="0,0.5,0,1";
				theme_background="0,0,0,1";
			elseif pref == 4 then
				-- Blue (Common)
				theme_color="0,0.5,1,1";
				theme_dark_color="0,0.25,0.5,1";
				theme_background="0,0,0,1";
			elseif pref == 5 then
				-- Yellow (MIX)
				theme_color="1,1,0,1";
				theme_dark_color="0.5,0.5,0,1";
				theme_background="0,0,0,1";
			elseif pref == 6 then
				-- Teal (MIX)
				theme_color="0,1,1,1";
				theme_dark_color="0,0.5,0.5,1";
				theme_background="0,0,0,1";
			elseif pref == 7 then
				-- Purple (MIX)
				theme_color="1,0,1,1";
				theme_dark_color="0.5,0,0.5,1";
				theme_background="0,0,0,1";
			elseif pref == 8 then
				-- Orange (MIX)
				theme_color="1,0.5,0,1";
				theme_dark_color="0.5,0.25,0,1";
				theme_background="0,0,0,1";
			elseif pref == 9 then
				-- Magenta (MIX)
				theme_color="1,0,0.5,1";
				theme_dark_color="0.5,0,0.25,1";
				theme_background="0,0,0,1";
			elseif pref == 10 then
				-- Lime (MIX)
				theme_color="0.5,1,0,1";
				theme_dark_color="0.25,0.5,0,1";
				theme_background="0,0,0,1";
			elseif pref == 11 then
				-- Sky Blue (MIX)
				theme_color="0,0.75,1,1";
				theme_dark_color="0,0.25,0.5,1";
				theme_background="0,0,0,1";
			elseif pref == 12 then
				-- Grey (MIX)
				theme_color="0.75,0.75,0.75,1";
				theme_dark_color="0.5,0.5,0.5,1";
				theme_background="0,0,0,1";
			else
				-- Original Gold - Primary Theme Color
				theme_color="1,0.9,0,1";
				theme_dark_color="0.5,0.4,0,1";
				theme_background="0,0,0,1";
			end
		end;
	}
end

function grid_m()
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
end

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

-- Common Function (Set Screen Text)

function common_text(string_text)
	return LoadFont("Common","normal")..{
		Text=ScreenString(string_text);
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	};
end