@echo off

echo "Starting copy configurations"

echo "-- Copy alacritty config to %AppData%\alacritty"
xcopy alacritty "%AppData%\alacritty\*" /E /Y

echo "-- Copy wezterm config to %USERPROFILE%"
xcopy wezterm\.wezterm.lua "%USERPROFILE%" /E /Y

echo "-- Copy nvim config to %LocalAppData%\nvim"
xcopy nvim "%LocalAppData%\nvim\*" /E  /Y

echo "-- Copy vifm config to %AppData%\Vifm"
xcopy vifm "%AppData%\Vifm\*" /E /Y

echo "Finished ..."
pause
