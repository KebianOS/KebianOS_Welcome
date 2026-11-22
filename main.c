#include <gtk/gtk.h>


static void abrir_config (GtkWidget *widget, gpointer data) {
    g_spawn_command_line_async("systemsettings", NULL);
}

static void activated (GtkApplication *app, gpointer user_data) {
    GtkWidget *window;
    GtkWidget *box;
    GtkWidget *image;
    GtkWidget *button;

    window = gtk_application_window_new (app);
    gtk_window_set_title (GTK_WINDOW (window), "Welcome to KebianOS");
    gtk_window_set_default_size (GTK_WINDOW (window), 500, 400);

    box = gtk_box_new (GTK_ORIENTATION_HORIZONTAL, 12);
    gtk_container_set_border_width (GTK_CONTAINER (box), 12);
    gtk_container_add (GTK_CONTAINER (window), box);

    image = gtk_image_new_from_icon_name ("preferences-system", GTK_ICON_SIZE_DIALOG);
    gtk_box_pack_start (GTK_BOX (box), image, FALSE, FALSE, 0);

    button = gtk_button_new_with_label ("Abrir ajustes");
    g_signal_connect (button, "clicked", G_CALLBACK (abrir_config), NULL);
    gtk_widget_set_valign (button, GTK_ALIGN_CENTER);
    gtk_box_pack_start (GTK_BOX (box), button, FALSE, FALSE, 0);
    gtk_widget_set_size_request (button, 10, 10);

    gtk_widget_show_all (window);

}

int main (int argc, char **argv) {
    GtkApplication *app;
    int status;

    app = gtk_application_new ("org.kebianos.welcome", 0);
    g_signal_connect (app, "activate", G_CALLBACK (activated), NULL);
    status = g_application_run (G_APPLICATION (app), argc, argv);

    return status;
}
