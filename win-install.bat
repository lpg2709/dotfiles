@echo off

if "%1%" == "/u" (
	echo "Uninstalling configurations"

	echo "-- Uninstall alacritty config from %AppData%\alacritty"
	rmdir /s /q "%AppData%\alacritty"

	echo "-- Uninstall nvim config from %LocalAppData%\nvim"
	rmdir /s /q "%LocalAppData%\nvim"
	rmdir /s /q "%LocalAppData%\nvim-data"
) else (
	echo "Starting copy configurations"

	echo "-- Copy alacritty config to %AppData%\alacritty"
	xcopy alacritty "%AppData%\alacritty\*" /E /Y

	echo "-- Copy nvim config to %LocalAppData%\nvim"
	xcopy nvim "%LocalAppData%\nvim\*" /E  /Y
)

echo "Finished ..."
pause
