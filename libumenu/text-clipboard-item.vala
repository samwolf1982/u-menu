
namespace Umenu
{
    /**
     * Represents a text clipboard item holding simple text.
     */
    public class TextClipboardItem : GLib.Object, IClipboardItem
    {
        private string _text;
        private string? _origin;
        private ClipboardType _clipboard_type;
        private DateTime _date_copied;

        /**
         * Default data constructor needed for reflection.
         *
         * @param clipboard_type clipboard type item is coming from
         * @param data simple text
         * @param origin origin of clipboard item as application path
         */
        public TextClipboardItem(ClipboardType clipboard_type, string data, string? origin, DateTime date_copied)
        {
            _clipboard_type = clipboard_type;
            _text = data;
            _origin = origin;
            _date_copied = date_copied;
        }

        /**
	     * {@inheritDoc}
	     */
        public ClipboardType get_clipboard_type()
        {
            return _clipboard_type;
        }

        /**
	     * {@inheritDoc}
	     */
	    public DateTime get_date_copied()
        {
            return _date_copied;
        }

        /**
	     * {@inheritDoc}
	     */
	    public string get_text()
        {
            return _text;
        }

        /**
	     * {@inheritDoc}
	     */
	    public string? get_origin()
        {
            return _origin;
        }

        /**
	     * {@inheritDoc}
	     */
        public string get_label()
        {
            // label should not be longer than 50 letters
            string label = _text.replace("\n", " ");
            if (label.char_count() > 50) {
                long index_char = label.index_of_nth_char(50);
                label = label.substring(0, index_char) + "...";
            }

            return label;
        }

        /**
	     * {@inheritDoc}
	     */
        public string get_mime_type()
        {
            return "text/plain";
        }

        /**
	     * {@inheritDoc}
	     */
        public ClipboardCategory get_category()
        {
            return ClipboardCategory.TEXT;
        }

        /**
	     * {@inheritDoc}
	     */
        public Gtk.Image? get_image()
        {
            return null; // no image available for text content
        }

        /**
	     * {@inheritDoc}
	     */
        public Icon get_icon()
        {
            return ContentType.get_icon(get_mime_type());
        }

        /**
	     * {@inheritDoc}
	     */
        public ByteArray? get_payload()
        {
            return null;
        }

        /**
	     * {@inheritDoc}
	     */
        public string get_checksum()
        {
            return Checksum.compute_for_string(ChecksumType.SHA1, _text);
        }

        /**
	     * {@inheritDoc}
	     */
        public void to_clipboard(Gtk.Clipboard clipboard)
        {
            clipboard.set_text(_text, -1);
            clipboard.store();
        }

        /**
	     * {@inheritDoc}
	     */
	    public bool equals(IClipboardItem* item)
        {
            bool equals = false;

            if(item is TextClipboardItem) {
                equals = strcmp(_text, item->get_text()) == 0;
            }

            return equals;
        }

        /**
	     * {@inheritDoc}
	     */
	    public uint hash()
        {
            return str_hash(_text);
        }
    }
}
