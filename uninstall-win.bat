@echo off

echo "Uninstalling configurations"

echo "-- Uninstall alacritty config from %AppData%\alacritty"
rmdir /s /q "%AppData%\alacritty"

echo "-- Uninstall nvim config from %LocalAppData%\nvim"
rmdir /s /q "%LocalAppData%\nvim"

echo "-- Uninstall vifm config from %AppData%\Vifm"
rmdir /s /q "%AppData%\Vifm"

echo "Finished ..."
pause
