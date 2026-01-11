
namespace Umenu
{
    /**
     * A gtk menu item holding a checksum of a clipboard item. It only keeps
     * the checksum as it would waste memory to keep the hole item available.
     */
    class ClipboardMenuItem : Gtk.ImageMenuItem
    {
        private string _checksum;

        /**
         * Clipboard item constructor
         *
         * @param item clipboard item
         */
        public ClipboardMenuItem(IClipboardItem item)
        {
            _checksum = item.get_checksum();
            set_label(item.get_label());

            // check if image needs to be shown
            Gtk.Image? image = item.get_image();
            if(image != null) {
                set_image(image);
                set_always_show_image(true);
            }
        }

        /**
         * Get encapsulated clipboard item checksum
         *
         * @return clipboard item checksum
         */
        public string get_item_checksum()
        {
            return _checksum;
        }

        /**
         * Highlight item by changing label to bold
         * TODO: get this up and running
         */
        /*public void highlight_item()
        {
            Gtk.Label label = get_menu_label();
            label.set_markup("<b>%s</b>".printf(get_label()));
        }*/

        /**
         * Gets the child of Gtk.Bin base class which represents
         * a Gtk.Label object.
         *
         * @return gtk label
         */
        /*private Gtk.Label get_menu_label()
        {
            Gtk.Label menu_label = (Gtk.Label) get_child();
            return menu_label;
        }*/
    }
}

