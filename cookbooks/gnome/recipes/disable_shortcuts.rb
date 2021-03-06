GNOME_SCHEMAS = ["org.gnome.desktop.wm.keybindings", "org.gnome.settings-daemon.plugins.media-keys"]
user = node[:gnome][:user]
node[:gnome][:disable_shortcuts].each do |shortcut|
  ruby_block "remove_shortcut #{shortcut}" do
    block do
      schemas = ['org.gnome.desktop.wm.keybindings',
                 'org.gnome.settings-daemon.plugins.media-keys']
      key = GSettings.key(user, schemas, shortcut)
      GSettings.clear(user, schemas, key) if key
    end
  end
end



