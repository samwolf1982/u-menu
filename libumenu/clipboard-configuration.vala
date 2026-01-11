
namespace Umenu
{
    /**
     * Clipboard configuration encapsulating configuration state.
     */
    public class ClipboardConfiguration : GLib.Object
    {
        private int _recent_items_size = 25;
        /**
         * flag whether primary selection is enabled
         */
        public bool use_primary { get; set; default = false; }

        /**
         * flag whether images should be aded to clipboard history
         */
        public bool add_images { get; set; default = false; }

        /**
         * flag whether clipboard is enabled
         */
        public bool use_clipboard { get; set; default = true; }

        /**
         * flag whether clipboards should be in sync
         */
        public bool synchronize_clipboards { get; set; default = false; }

        /**
         * flag whether clipboard content should be restored when lost.
         */
        public bool keep_clipboard_content { get; set; default = true; }

        /**
         * flag whether clipboard content should be automatically pasted
         */
        public bool instant_paste { get; set; default = true; }

        /**
         * regex pattern so all clipboard items matching this pattern will
         * be filtered and not added to clipboard history.
         */
        public string filter_pattern { get; set; default = "^\\s+$"; }

        /**
         * a lookup dictionary for application using different paste keybindings
         * than <Ctrl>V.
         * pattern of each string in this array is path-app|<keybinding>
         * e.g. /usr/bin/gnome-terminal|<Ctrl><Shift>V
         */
        public string[] app_paste_keybindings { get; set; }

        /**
         * Lookup whether app paste keybinding
         *
         * @return app paste keybinding or null if not available
         */
        public string? lookup_app_paste_keybinding(string? apppath)
        {
            if(app_paste_keybindings != null && apppath != null) {
                foreach(string keybinding in app_paste_keybindings) {
                    string[] path_keybinding = keybinding.split("|");
                    if(path_keybinding.length == 2) {
                        if(strcmp(apppath, path_keybinding[0]) == 0) {
                            return path_keybinding[1];
                        }
                    }
                }
            }

            return null;
        }

        /**
         * number of recent items to be shown.
         * Value must be bigger than 0 and lower or equal than 100.
         */
        public int recent_items_size
        {
            get {
                return _recent_items_size;
            }
            set {
                if(value > 0 && value <= 100) {
                    _recent_items_size = value;
                }
            }
        }
    }
}

