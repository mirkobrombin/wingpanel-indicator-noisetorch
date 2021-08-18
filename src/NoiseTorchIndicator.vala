/*
 * Copyright (c) 2019 Mirko Brombin (https://linuxhub.it)
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 */
public class NoiseTorch.Indicator : Wingpanel.Indicator 
{
    public bool is_in_session { get; construct; default = false; }

    private Wingpanel.Widgets.OverlayIcon display_widget;
    private Gtk.Dialog confirm_dialog;
    private Gtk.Grid popover_widget;
    private Gtk.Label current_status_label;
    private Gtk.ModelButton toggle_suppression_button;
    int status = 0;

    public Indicator () 
    {
        Object (code_name: "noisetorch-indicator");
    }

    construct 
    {
        string icon = "noisetorch";

        display_widget = new Wingpanel.Widgets.OverlayIcon (icon);

        // create menu items
        current_status_label = new Gtk.Label (_("Supressor unloaded"));
        current_status_label.hexpand = true;
        
        toggle_suppression_button = new Gtk.ModelButton ();
        current_status_label.hexpand = true;
        toggle_suppression_button.text = _("Enable supressor");

        var settings_button = new Gtk.ModelButton ();
        settings_button.text = _("Settings");

        // add items to menu
        popover_widget = new Gtk.Grid ();
        popover_widget.orientation = Gtk.Orientation.VERTICAL;
        popover_widget.attach (current_status_label, 0, 0);
        popover_widget.attach (new Gtk.Separator (Gtk.Orientation.HORIZONTAL), 0, 1);
        popover_widget.attach (toggle_suppression_button, 0, 2);
        popover_widget.attach (settings_button, 0, 3);

        // indicator should be visible at startup
        this.visible = true;

        toggle_suppression_button.clicked.connect (() => 
        {
            if (status == 1)
            {
                Posix.system ("noisetorch -u");
                current_status_label.set_text(_("Supressor unloaded"));
                toggle_suppression_button.text = _("Enable supressor");
                status = 0;
            }
            else
            {
                Posix.system ("noisetorch -i");
                current_status_label.set_text(_("Supressor loaded"));
                toggle_suppression_button.text = _("Disable supressor");
                status = 1;
            }
        });

        settings_button.clicked.connect (() => 
        {
            Posix.system ("noisetorch &");
        });
    }


    // method called to get the widget that is displayed in the panel
    public override Gtk.Widget get_display_widget () 
    {
        return display_widget;
    }

    // method called to get the widget that is displayed in the popover
    public override Gtk.Widget? get_widget () 
    {
        return popover_widget;
    }

    public override void opened () {}
    public override void closed () {}
}

public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) 
{
    debug ("Activating NoiseTorch Indicator");

    // indicator creation
    var indicator = new NoiseTorch.Indicator ();

    // return the newly created indicator
    return indicator;
}   
