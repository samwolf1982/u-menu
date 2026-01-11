
namespace Umenu
{
    /**
     * Preferences dialog view loading user interface from preferences.ui
     */
    class PreferencesView : GLib.Object
    {
        private Gtk.Dialog preferences;

        public PreferencesView()
        {
        }

        /**
         * Show preferences view
         *
         * @param configuraiton configuration to initialize dialog
         */
        public void show(ClipboardConfiguration configuration)
        {
            // check if preferences window is already open
            if(preferences == null) {
                try {
                    // builder
                    Gtk.Builder builder = new Gtk.Builder();
                    builder.set_translation_domain(Config.GETTEXT_PACKAGE);
                    builder.add_from_file(Path.build_filename(Utility.get_pkg_data_dir(), "preferences.ui"));

                    // use_clipboard
                    Gtk.ToggleButton use_clipboard =
                        builder.get_object("checkbutton_use_clipboard") as Gtk.ToggleButton;
                    use_clipboard.active = configuration.use_clipboard;
                    use_clipboard.toggled.connect(() => {
                        configuration.use_clipboard = !configuration.use_clipboard;
                    } );

                    // use_primary
                    Gtk.ToggleButton use_primary = builder.get_object("checkbutton_use_primary") as Gtk.ToggleButton;
                    use_primary.active = configuration.use_primary;
                    use_primary.toggled.connect(() => {
                        configuration.use_primary = !configuration.use_primary;
                    } );

                    // add images
                    Gtk.ToggleButton add_images = builder.get_object("checkbutton_add_images") as Gtk.ToggleButton;
                    add_images.active = configuration.add_images;
                    add_images.toggled.connect(() => {
                        configuration.add_images = !configuration.add_images;
                    } );

                    // synchronize_clipboards
                    Gtk.ToggleButton synchronize_clipboards =
                        builder.get_object("checkbutton_synchronize_clipboards") as Gtk.ToggleButton;
                    synchronize_clipboards.active = configuration.synchronize_clipboards;
                    synchronize_clipboards.toggled.connect(() => {
                        configuration.synchronize_clipboards = !configuration.synchronize_clipboards;
                    } );

                    // keep clipboard content
                    Gtk.ToggleButton keep_clipboard_content =
                        builder.get_object("checkbutton_keep_clipboard_content") as Gtk.ToggleButton;
                    keep_clipboard_content.active = configuration.keep_clipboard_content;
                    keep_clipboard_content.toggled.connect(() => {
                        configuration.keep_clipboard_content = !configuration.keep_clipboard_content;
                    } );

                    // instant paste
                    Gtk.ToggleButton instant_paste =
                        builder.get_object("checkbutton_instant_paste") as Gtk.ToggleButton;
                    instant_paste.active = configuration.instant_paste;
                    instant_paste.toggled.connect(() => {
                        configuration.instant_paste = !configuration.instant_paste;
                    } );

                    // recent_items_size
                    Gtk.SpinButton recent_items_size =
                        builder.get_object("spinbutton_recent_items_size") as Gtk.SpinButton;
                    recent_items_size.value = configuration.recent_items_size;
                    recent_items_size.value_changed.connect(() => {
                        configuration.recent_items_size = recent_items_size.get_value_as_int();
                    });
                    recent_items_size.editing_done.connect(() => {
                        configuration.recent_items_size = recent_items_size.get_value_as_int();
                    });

                    // plugins
                    PeasGtk.PluginManager manager = new PeasGtk.PluginManager(
                        Peas.Engine.get_default());
                    Gtk.Box plugins_box = builder.get_object("plugins_box") as Gtk.Box;
                    plugins_box.pack_start(manager);

                    // close
                    Gtk.Button close = builder.get_object("button_close") as Gtk.Button;
                    close.clicked.connect(hide);

                    // preferences
                    preferences = builder.get_object("dialog_preferences") as Gtk.Dialog;
                    preferences.destroy.connect_after(reset);
                    preferences.show_all();
                }
                catch(Error e) {
                    warning("Could not initialize preferences dialog. Error: " + e.message);
                }
            }
        }

        /**
         * Hide preferences view
         */
        public void hide()
        {
            preferences.close();
        }

        /**
         * Reset preferences dialog
         */
        public void reset()
        {
            preferences = null;
        }
    }
}

