
namespace Umenu.Plugins
{
    /**
     * Providing access to clipboard history through an application
     * indicator.
     */
    public class IndicatorPlugin : Peas.ExtensionBase, Peas.Activatable
    {
        private AppIndicator.Indicator indicator;
        public Object object { owned get; construct; }

        public IndicatorPlugin()
        {
            Object();
        }

        public void activate()
        {
            Controller controller = object as Controller;

            if(indicator == null) {
                indicator = new AppIndicator.Indicator("Umenu", "umenu-panel",
                    AppIndicator.IndicatorCategory.APPLICATION_STATUS);

                indicator.set_menu(controller.get_recent_menu());

                controller.on_recent_menu_changed.connect(change_menu);
            }

            indicator.set_status(AppIndicator.IndicatorStatus.ACTIVE);
        }

        public void deactivate()
        {
            Controller controller = object as Controller;

            if(indicator != null) {
                indicator.set_status(AppIndicator.IndicatorStatus.PASSIVE);
                controller.on_recent_menu_changed.disconnect(change_menu);
            }
        }

        public void update_state()
        {
        }

        private void change_menu(Gtk.Menu recent_menu)
        {
            indicator.set_menu(recent_menu);
        }
    }
}

[ModuleInit]
public void peas_register_types (GLib.TypeModule module)
{
  Peas.ObjectModule objmodule = module as Peas.ObjectModule;
  objmodule.register_extension_type (typeof (Peas.Activatable),
                                     typeof (Umenu.Plugins.IndicatorPlugin));
}

