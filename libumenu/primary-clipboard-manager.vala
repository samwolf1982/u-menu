
namespace Umenu
{
    /**
     * Specific clipboard manager for primary selection extending
     * basic functionality with primary selection specific use cases.
     * Note that primary selection clipboard manager only supports text.
     */
    class PrimaryClipboardManager : ClipboardManager
    {
        /**
         * Type is alwawys ClipboardType.PRIMARY for this specific primary
         * selection manager.
         */
        public PrimaryClipboardManager(ClipboardConfiguration configuration)
        {
            base(ClipboardType.PRIMARY, configuration);
        }

        /**
         * Primary selection only supports text therefore ignoring
         * all others.
         *
         * @param item clipboard item to be selected
         */
        public override void select_item(IClipboardItem item)
        {
            if(item is TextClipboardItem) {
                base.select_item(item);
            }
        }

        /**
         * Check if the mouse button or shift button is pressed
         * before primary selection gets accepted. As otherwise the history
         * gets flooded with several clipboard items.
         *
         * @return true if button are in an acceptable state; otherwise false.
         */
        private bool check_button_state()
        {
            Gdk.Window rootwin = Gdk.get_default_root_window();
            Gdk.Display display = rootwin.get_display();
            Gdk.ModifierType modifier = 0;

            Gdk.Device device = display.get_device_manager().get_client_pointer();
            device.get_state(rootwin, (double[])null, out modifier);

            // only accepted when left mouse button and shift button
            // are not pressed
            if((modifier & Gdk.ModifierType.BUTTON1_MASK) == 0) {
                if((modifier & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    return true;
                }
            }

            return false;
        }

        /*
         * Check requesting of primary tes
         * Helper method for requesting primary text within a timer
         */
        protected override void check_clipboard()
        {
            // checking for text
            string? text = request_text();
            if(text != null && text != "") {
                if(check_button_state()) {
                    string? origin = Utility.get_path_of_active_application();
                    on_text_received(type, text, origin);
                }
            }
            // checking if clipboard might be empty
            else {
                check_clipboard_emptiness();
            }
        }
    }
}

