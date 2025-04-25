@echo off

echo "Uninstalling configurations"

echo "-- Uninstall alacritty config from %AppData%\alacritty"
rmdir /s /q "%AppData%\alacritty"

echo "-- Uninstall nvim config from %LocalAppData%\nvim"
rmdir /s /q "%LocalAppData%\nvim"
rmdir /s /q "%LocalAppData%\nvim-data"

echo "Finished ..."
pause
