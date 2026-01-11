namespace Umenu
{
    public class SimpleClipboardStorage : GLib.Object
    {
        private List<IClipboardItem> history;
        private HashTable<ClipboardType, IClipboardItem> current_items;

        public signal void on_items_inserted();
        public signal void on_items_deleted();

        public SimpleClipboardStorage() {
            this.history = new List<IClipboardItem>();
            this.current_items = new HashTable<ClipboardType, IClipboardItem>(null, null);
        }

        public bool is_privacy_mode_enabled() { return false; }

        public IClipboardItem get_current_item(ClipboardType type) {
            return current_items.get(type);
        }

        public async void add_item(IClipboardItem item, Cancellable? cancellable = null) {
            history.prepend(item);
            current_items.set(item.get_clipboard_type(), item);
            on_items_inserted();
        }

        public async List<IClipboardItem> get_recent_items(uint32 num_items, ClipboardCategory[]? cats = null,
                ClipboardTimerange date_copied = ClipboardTimerange.ALL, Cancellable? cancellable = null) {
            List<IClipboardItem> result = new List<IClipboardItem>();
            uint count = 0;
            foreach (IClipboardItem item in history) {
                if (count >= num_items) break;
                result.append(item);
                count++;
            }
            return result;
        }

        public async IClipboardItem? get_item_by_checksum(string checksum, Cancellable? cancellable = null) {
            foreach (IClipboardItem item in history) {
                if (item.get_checksum() == checksum) return item;
            }
            return null;
        }

        public async void select_item(IClipboardItem item, bool use_clipboard, bool use_primary, Cancellable? cancellable = null) {
        // Перемістити наверх
            history.remove(item);
            history.prepend(item);
            if (use_clipboard) current_items.set(ClipboardType.CLIPBOARD, item);
            if (use_primary) current_items.set(ClipboardType.PRIMARY, item);
            on_items_inserted();
        }

        public async void remove_item(IClipboardItem item, Cancellable? cancellable = null) {
            history.remove(item);
            on_items_deleted();
        }

        public async void clear(Cancellable? cancellable = null) {
            history = new List<IClipboardItem>();
            current_items.remove_all();
            on_items_deleted();
        }

        // Заглушка для пошуку
        public async List<IClipboardItem> get_items_by_search_query(string search_query, ClipboardCategory[]? cats = null,
                ClipboardTimerange date_copied = ClipboardTimerange.ALL, Cancellable? cancellable = null) {
            return yield get_recent_items(100);
        }
    }
}
