# Written by Adnan Shameem
# License: CC0 - do whatever you want with it

# This script relies on xfce-notifyd. It is lightweight and saves the
#  notifications in a ~/.cache/xfce4/notifyd/log file which is formatted
#  in INI type format.
# To make this script work,
# 1. Install notification-daemon
# 2. Install xfce4-notifyd
# 3. Run either:
# /usr/lib/xfce4/notifyd/xfce4-notifyd
# or
# systemctl --user start xfce4-notifyd
# 4. Run xfce4-notifyd-config and go to Log and Turn ON Notifications
#  and then set Log notifications to "always"
# Now get some notifications from your apps.
# Run this script to show them as a sidebar list.

# If you want to toggle the panel, run this with a toggle script like:
#  https://gist.github.com/adnan360/8b223bd54a01dc7a20110808aef003b3
# Something like ./python-invert.sh path/to/notification-sidebar.py
# It will invert the panel everytime this is run.
# You can then run this on a button on a panel.
# Would be great for lightweight desktops, such as, jwm, openbox, i3 etc.
#  where DE does not have a notification list panel available.

# TODO: Fix height to fill from top to bottom

# Screenshot: https://imgur.com/wah27HZ or http://i63.tinypic.com/1r6poo.png

## -------- Imports -------- ##

# Python GTK3
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

# Especially for getting screen dimensions
from gi.repository import Gdk

# For processing INI
try:
    from configparser import ConfigParser
except ImportError:
    from ConfigParser import ConfigParser  # ver. < 3.0

# For getting full path to home directory
import os


# -------- Classes/Implementation -------- ##

def deletefile(filename):
    if os.path.isfile(filename):
        os.remove(filename)

# Get/expand real userpath from "~"
# We will keep the xfce notofications log
inipath = os.path.expanduser("~/.cache/xfce4/notifyd/log")

# Panel width
panel_width = 400

# Class to handle multiline list items
class ListBoxRowWithData(Gtk.ListBoxRow):
    def __init__(self, data1, data2):
        super(Gtk.ListBoxRow, self).__init__()
        self.data1 = data1
        self.data2 = data2

        box = Gtk.VBox(False, 2)
        box.set_homogeneous(True)
        item_line1 = Gtk.Label()
        item_line1.set_markup("<b>"+data1+"</b>")
        item_line1.set_line_wrap(True)
        box.pack_start(item_line1, False, False, 10)

        if data2 != '':
            item_line2 = Gtk.Label()
            item_line2.set_markup(data2)
            item_line2.set_line_wrap(True)
            box.pack_start(item_line2, False, False, 0)

        self.add(box)


class MyWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Notifications")

        # Get screen dimensions
        s = self.get_screen()
        m = s.get_monitor_at_window(s.get_active_window())
        monitor = s.get_monitor_geometry(m)

        # Size the window
        self.move(monitor.width - panel_width,0)
        self.set_default_size(panel_width, monitor.height)

        main_grid = Gtk.Grid()
        self.add(main_grid)

        btnquit = Gtk.Button(label="Close")
        btnquit.connect("clicked", Gtk.main_quit)

        btnclear = Gtk.Button(label="Clear")
        btnclear.connect("clicked", self.on_btnclear_clicked)

        notif_list = Gtk.ListBox()
        notif_scroller = Gtk.ScrolledWindow()
        #notif_scroller.set_policy(Gtk.PolicyType.NEVER,
                               #Gtk.PolicyType.AUTOMATIC)

        # Read INI file
        inidata = ConfigParser()
        # Sometimes some weird characters appear on the INI.
        # ", encoding="ISO-8859-1" stops it from crashing.
        inidata.read(inipath, encoding="ISO-8859-1")

        # Get all sections
        sections = inidata.sections()
        # Reverse to show the latest ones first
        sections.sort(reverse=True)

        for section in sections:
            notif_list.add(ListBoxRowWithData(section+': '+inidata.get(section, 'summary'), inidata.get(section, 'body')))

        #notif_scroller.attach(notif_list, 1, 0, 2, 1)
        main_grid.attach(notif_scroller, 1, 0, 2, 1)
        notif_scroller.add_with_viewport(notif_list)
        main_grid.attach(btnquit, 1, 2, 1, 1)
        main_grid.attach_next_to(btnclear, btnquit, Gtk.PositionType.RIGHT, 1, 1)
        notif_list.set_hexpand(True)
        notif_list.set_vexpand(True)


    def on_btnclear_clicked(self, widget):
        deletefile(inipath)
        Gtk.main_quit()

win = MyWindow()
win.connect("destroy", Gtk.main_quit)
# Close this panel when mouse gets outside of window
win.connect("leave-notify-event", Gtk.main_quit, "")
# Remove taskbar button
win.set_skip_taskbar_hint(True)
win.show_all()
# Remove titlebar
win.get_window().set_decorations(Gdk.WMDecoration.BORDER)
# No decorations/border at all
# Uncomment this if you want no border at all
#win.set_decorated(False)

Gtk.main()
