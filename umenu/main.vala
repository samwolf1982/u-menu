namespace Umenu
{
    public class UmenuApplication : Gtk.Application
    {
        /**
         * collects all non-option arguments which would otherwise be left in argv.
         */
        private const string OPTION_REMAINING = "";

        /**
         * determine whether version information should be printed
         */
        private static bool show_version = false;

        /**
         * main clipboard controller
         */
        private Controller? controller = null;

        /**
         * determine whether help information should be printed
         */
        private static bool show_help = false;

        /**
         * store unmached options and possible actions
         */
        private static string[] remaining_options;

        /**
         * list of available command line options
         */
        private const OptionEntry[] options = {
            { OPTION_REMAINING, '\0', 0, OptionArg.STRING_ARRAY, ref remaining_options, null, "<action> | [CHECKSUM]" },
            { "help", 'h', 0, OptionArg.NONE, ref show_help, "Show help options", null },
            { "version", 'v', 0, OptionArg.NONE, ref show_version, "Print version information", null },
            { null }
        };

        public UmenuApplication()
        {
            Object(application_id: "com.biryukwolf.umenu", flags: ApplicationFlags.HANDLES_COMMAND_LINE);

            command_line.connect (handle_command_line);

            // add supported actions
            SimpleAction paste_action = new SimpleAction("paste", VariantType.STRING);
            paste_action.activate.connect(activate_paste_action);
            add_action(paste_action);
        }

        public void activate_paste_action(GLib.Variant? parameter)
        {
            hold();

            string checksum = parameter.get_string();
            debug("Execute paste with checksum %s", checksum);
            controller.select_item_by_checksum.begin(checksum);

            release();
        }

        public override void activate()
        {
            debug("Activate UmenuApplication (Version %s)", Config.VERSION);

            if(controller == null) {
                // setup controller
                controller = new Controller();
                controller.init.begin();

                Gtk.main();
            } else {
                // Umenu running already, let's show history
                controller.show_history();
            }
        }

        /**
         * Process command line arguments
         */
        private int handle_command_line (ApplicationCommandLine command_line)
        {
            string[] args = command_line.get_arguments();
            show_version = false;
            show_help = false;
            remaining_options = new string[args.length];

            StringBuilder summary = new StringBuilder("Actions:\n");
            if (controller != null)
            {
                HashTable<string,string> descs = controller.get_command_descriptions ();
                if(descs.length > 0) {
                    descs.foreach((key, val) => summary.append_printf ("  %-25s%s\n", key, val));
                } else {
                    summary.append ("  None");
                }

            } else {
                summary.append("  Actions are only available while umenu is running.");
            }

            try
            {
                OptionContext opt_context = new OptionContext("- GTK+ Clipboard Manager");
                opt_context.set_summary (summary.str);
                opt_context.set_help_enabled(false);
                opt_context.add_main_entries(options, null);
                opt_context.add_group(Gtk.get_option_group(true));
                opt_context.parse_strv (ref args);

                if(show_help) {
                    command_line.print(opt_context.get_help (true, null));
                    return 0;
                }

                if(show_version) {
                    command_line.print("Umenu %s\n", Config.VERSION);
                    return 0;
                }

                if (remaining_options.length > 0 && remaining_options[0] != null
                    && controller != null)
                {
                    // it might be an uri so we have to remove uri first before
                    // TODO:
                    // see ZeitgeistClipboardStorage.CLIPBOARD_URI why clipboard:
                    // is used statically here
                    string option = remaining_options[0].replace("clipboard:", "");

                    // check if umenu has been called with a registered action
                    if (has_action(option))
                    {
                        uint i = 1;
                        while (remaining_options[i] != null) {
                            i++;
                        }
                        activate_action(option, new Variant.strv(remaining_options[1:i]));
                        return 0;
                    }
                    // check if it is a checksum (length 40) and paste action can be executed
                    else if (option.length == 40) {
                        activate_action("paste", new Variant.string(option));
                        return 0;
                    } else  {
                        warning("Invalid action '%s'", remaining_options[0]);
                        return 1;
                    }
                }

                // no options - activate Umenu by either starting or showing menu
                activate ();
                return 0;
            } catch(OptionError e) {
                stdout.printf("Option parsing failed: %s\n", e.message);
            }

            return 1;
        }

        public static int main(string[] args)
        {
            // setup gettext
            Intl.textdomain(Config.GETTEXT_PACKAGE);
            Intl.bindtextdomain(Config.GETTEXT_PACKAGE, Config.LOCALE_DIR);
            Intl.bind_textdomain_codeset(Config.GETTEXT_PACKAGE, "UTF-8");
            Intl.setlocale(LocaleCategory.ALL, "");

            // umenu should only show up in gnome
            DesktopAppInfo.set_desktop_env("GNOME");

            // Ensure GSettings schemas are available when running uninstalled
            string schema_dir_env = Environment.get_variable("GSETTINGS_SCHEMA_DIR");
            if (schema_dir_env == null || schema_dir_env == "") {
                string dev_dir = Config.DEV_GSETTINGS_DIR;
                try {
                    File compiled = File.new_for_path(Path.build_filename(dev_dir, "gschemas.compiled"));
                    if (compiled.query_exists(null)) {
                        Environment.set_variable("GSETTINGS_SCHEMA_DIR", dev_dir, true);
                    }
                } catch (Error e) {
                    // ignore, fall back to system schemas
                }
            }

            // requires x11 to run
//            Gdk.set_allowed_backends("x11");

            UmenuApplication app = new UmenuApplication();
            return app.run(args);
        }
    }
}

