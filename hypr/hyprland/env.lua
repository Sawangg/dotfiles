local runtime_dir = os.getenv("XDG_RUNTIME_DIR") or "$XDG_RUNTIME_DIR"

-- Toolkit Backend Variables --
hl.env("GDK_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- XDG Specifications --
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Qt Variables --
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECOREATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Theme variables --
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- SSH Agent socket --
hl.env("SSH_AUTH_SOCK", runtime_dir .. "/ssh-agent.socket")
