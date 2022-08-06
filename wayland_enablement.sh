#!/bin/sh
export GDK_BACKEND=wayland,x11
export MOZ_ENABLE_WAYLAND=1
export CLUTTER_BACKEND=wayland
#export QT_QPA_PLATFORM=wayland-egl
export QT_QPA_PLATFORM=xcb
#export ECORE_EVAS_ENGINE=wayland-egl
#export ELM_ENGINE=wayland_egl
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export NO_AT_BRIDGE=1
# export QT_QPA_PLATFORM="wayland;xcb"
# For Telegram
TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY=1
