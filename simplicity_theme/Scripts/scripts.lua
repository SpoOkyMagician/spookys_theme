-- i need to update this a lot soon...

local prefs = {
	ColorPref =
	{
		Default = 1,
		Choices = { "Gold", "Red", "Green", "Blue", "Yellow", "Teal", "Purple", "Orange", "Magenta", "Lime", "Sky Blue", "Grey" },
		Values = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
	}
}

ThemePrefs.InitAll( prefs )

-- Original Gold - Primary Theme Color
theme_color="1,0.9,0,1";
theme_dark_color="0.5,0.4,0,1";
theme_background="0,0,0,1";

-- Red (Common)
--theme_color="1,0,0,1";
--theme_dark_color="0.5,0,0,1";
--theme_background="0,0,0,1";

-- Orange (MIX)
--theme_color="1,1,0,1";
--theme_dark_color="0.5,0.5,0,1";
--theme_background="0,0,0,1";

-- Green (Common)
--theme_color="0,1,0,1";
--theme_dark_color="0,0.5,0,1";
--theme_background="0,0,0,1";

-- Teal (MIX)
--theme_color="0,1,1,1";
--theme_dark_color="0,0.5,0.5,1";
--theme_background="0,0,0,1";

-- Blue (Common)
--theme_color="0,0,1,1";
--theme_dark_color="0,0,0.5,1";
--theme_background="0,0,0,1";

-- Purple (MIX)
--theme_color="1,0,1,1";
--theme_dark_color="0.5,0,0.5,1";
--theme_background="0,0,0,1";

-- IMPORTANT: Remember to use comma's in actorframes from now on...

-- play specific music...

main_song = LoadActor(THEME:GetPathS("", "rave_party"))..{ InitCommand=cmd(stop); OnCommand=cmd(play); OffCommand=cmd(stop); };
fast_song = LoadActor(THEME:GetPathS("", "hurry_up"))..{ InitCommand=cmd(stop); OnCommand=cmd(play); OffCommand=cmd(stop); };
slow_song = LoadActor(THEME:GetPathS("", "chill_n_bass"))..{ InitCommand=cmd(stop); OnCommand=cmd(play); OffCommand=cmd(stop); };

-- quad draws...

--grid_a = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_background)); };
grid_b = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_TOP+30;diffuse,color(theme_dark_color);diffusebottomedge,color(theme_background)); };
grid_c = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-30,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_dark_color);diffusebottomedge,color(theme_background)); };
--grid_d = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_TOP+2;diffuse,color(theme_color)); };
--grid_e = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-2,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_color)); };
--grid_f = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_LEFT+2,SCREEN_BOTTOM;diffuse,color(theme_color)); };
--grid_g = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_RIGHT-2,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_color)); };
--grid_h = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-30,SCREEN_RIGHT,SCREEN_BOTTOM-28;diffuse,color(theme_color)); };
--grid_i = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP+28,SCREEN_RIGHT,SCREEN_TOP+30;diffuse,color(theme_color)); };

--grid_s = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_RIGHT/2-2,SCREEN_BOTTOM-28,SCREEN_RIGHT/2,SCREEN_BOTTOM+2;diffuse,color(theme_color)); };

--grid_j = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP+110,SCREEN_RIGHT,SCREEN_TOP+112;diffuse,color(theme_color)); };
--grid_k = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT+258,SCREEN_TOP+28,SCREEN_LEFT+260,SCREEN_TOP+240;diffuse,color(theme_color)); };
--grid_l = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT+340,SCREEN_TOP+28,SCREEN_LEFT+342,SCREEN_TOP+112;diffuse,color(theme_color)); };
--grid_m = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT+258,SCREEN_TOP+240,SCREEN_LEFT+260,SCREEN_TOP+450;diffuse,color(theme_color)); };
--grid_n = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+380,SCREEN_LEFT+260,SCREEN_TOP+382;diffuse,color(theme_color)); };

--grid_o = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT+100,SCREEN_TOP+2,SCREEN_LEFT+102,SCREEN_TOP+28;diffuse,color(theme_color)); };
--grid_p = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT+403,SCREEN_TOP+2,SCREEN_LEFT+405,SCREEN_TOP+28;diffuse,color(theme_color)); };
--grid_q = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_RIGHT-405,SCREEN_TOP+2,SCREEN_RIGHT-403,SCREEN_TOP+28;diffuse,color(theme_color)); };
--grid_r = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_RIGHT-102,SCREEN_TOP+2,SCREEN_RIGHT-100,SCREEN_TOP+28;diffuse,color(theme_color)); };

grid_t = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-30,SCREEN_RIGHT-2,SCREEN_TOP+30;diffuse,color("0,0,0,0.75")); };

grid_u = Def.Quad{ InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_color);basealpha,0.25); };

-- grab the preference set in theme color picker
function refresh_color()
	return Def.Actor{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;playcommand,"ColorPicked");
		-- this should be okay. i have to call it somehow... can't use init...
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

function common_text(string_text)
	return LoadFont("SpoOky")..{
		Text=string_text;
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	};
end

-- test function...
-- works fine...
--function test_text(string_text, xa, ya, color_text)
--	return LoadFont("SpoOky")..{ Text=string_text; InitCommand=cmd(x,xa;y,ya;diffuse,color(color_text);zoom,0.5;align,0.5,0.5;shadowlength,1); };
--end

grid_fast_fade_out = Def.Quad{ OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,0");sleep,0.025;diffuse,color("0,0,0,0.1");sleep,0.025;diffuse,color("0,0,0,0.2");sleep,0.025;diffuse,color("0,0,0,0.3");sleep,0.025;diffuse,color("0,0,0,0.4");sleep,0.025;diffuse,color("0,0,0,0.5");sleep,0.025;diffuse,color("0,0,0,0.6");sleep,0.025;diffuse,color("0,0,0,0.7");sleep,0.025;diffuse,color("0,0,0,0.8");sleep,0.025;diffuse,color("0,0,0,0.9");sleep,0.025;diffuse,color("0,0,0,1")); };
grid_fast_fade_in = Def.Quad{ OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,1");sleep,0.025;diffuse,color("0,0,0,0.9");sleep,0.025;diffuse,color("0,0,0,0.8");sleep,0.025;diffuse,color("0,0,0,0.7");sleep,0.025;diffuse,color("0,0,0,0.6");sleep,0.025;diffuse,color("0,0,0,0.5");sleep,0.025;diffuse,color("0,0,0,0.4");sleep,0.025;diffuse,color("0,0,0,0.3");sleep,0.025;diffuse,color("0,0,0,0.2");sleep,0.025;diffuse,color("0,0,0,0.1");sleep,0.025;diffuse,color("0,0,0,0")); };
grid_slow_fade_out = Def.Quad{ OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,0");sleep,0.25;diffuse,color("0,0,0,0.1");sleep,0.25;diffuse,color("0,0,0,0.2");sleep,0.25;diffuse,color("0,0,0,0.3");sleep,0.25;diffuse,color("0,0,0,0.4");sleep,0.25;diffuse,color("0,0,0,0.5");sleep,0.25;diffuse,color("0,0,0,0.6");sleep,0.25;diffuse,color("0,0,0,0.7");sleep,0.25;diffuse,color("0,0,0,0.8");sleep,0.25;diffuse,color("0,0,0,0.9");sleep,0.25;diffuse,color("0,0,0,1")); };
grid_slow_fade_in = Def.Quad{ OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;finishtweening;diffuse,color("0,0,0,1");sleep,0.25;diffuse,color("0,0,0,0.9");sleep,0.25;diffuse,color("0,0,0,0.8");sleep,0.25;diffuse,color("0,0,0,0.7");sleep,0.25;diffuse,color("0,0,0,0.6");sleep,0.25;diffuse,color("0,0,0,0.5");sleep,0.25;diffuse,color("0,0,0,0.4");sleep,0.25;diffuse,color("0,0,0,0.3");sleep,0.25;diffuse,color("0,0,0,0.2");sleep,0.25;diffuse,color("0,0,0,0.1");sleep,0.25;diffuse,color("0,0,0,0")); };