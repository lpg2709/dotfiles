@echo off

echo "Starting copy configurations"

echo "-- Copy alacritty config to %AppData%"
xcopy alacritty "%AppData%\alacritty\*" /E /Y

echo "-- Copy nvim config to %LocalAppData%"
xcopy nvim "%LocalAppData%\nvim\*" /E  /Y

echo "Finished ..."
