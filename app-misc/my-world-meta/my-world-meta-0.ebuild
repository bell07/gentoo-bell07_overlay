EAPI="7"
KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="admin +bell07-config cdr gaming gui minimal mediacenter multiuser networkmanager pulseaudio vaapi video_cards_intel vulkan wayland workstation X xfce wifi"
HOMEPAGE="https://github.com/bell07/gentoo-bell07_overlay"

DESCRIPTION="My favorite software preselection - meta package"

### Base system ###
# Base packages that should be on any system
RDEPEND+="
	app-arch/lz4
	app-arch/p7zip
	app-arch/unzip
	app-editors/nano
	app-misc/mc
	app-misc/screen
	app-misc/tmux
	net-fs/cifs-utils
	net-misc/iperf
	net-misc/openssh
	sys-apps/pciutils
	sys-apps/usbutils
	sys-fs/dosfstools
	sys-fs/exfatprogs
	sys-fs/f2fs-tools
	sys-fs/ntfs3g
	sys-libs/gpm
	sys-process/htop
	sys-process/iotop
	sys-process/lsof
"

# amd64 only base packages
RDEPEND+=" amd64? (
	app-misc/resolve-march-native
	sys-boot/efibootmgr
	sys-kernel/gentoo-kernel
	sys-kernel/kernel-cfg
)"

# My configuration files
RDEPEND+=" bell07-config? ( app-misc/my-gentoo-config )"

# Additional packages for non minimal systems
# sys-fs/fuse:0 is for AppImage support
RDEPEND+=" !minimal? (
	app-admin/logrotate
	app-admin/syslog-ng
	app-arch/unrar
	app-eselect/eselect-repository
	app-misc/evtest
	app-portage/cpuid2cpuflags
	app-portage/genlop
	app-portage/gentoolkit
	app-portage/smart-live-rebuild
	app-portage/eix
	dev-debug/strace
	app-text/dos2unix
	dev-vcs/git
	net-analyzer/nettop
	net-dns/bind-tools
	net-misc/chrony
	sys-apps/lm-sensors
	sys-apps/mlocate
	sys-fs/fuse:0
	sys-kernel/linux-firmware
	sys-power/powertop
)"

# Advanced Audio setup
RDEPEND+=" pulseaudio? (
	media-sound/alsa-utils
)"

# Vulkan tools for vulkan
RDEPEND+=" vulkan? ( dev-util/vulkan-tools )"

# Minimal wifi settings
RDEPEND+=" wifi? ( !networkmanager? ( net-misc/netifrc net-wireless/wpa_supplicant ) )"


### By role ###
# System and network analysis, monitoring and recovery tools
RDEPEND+=" admin? (
	app-admin/testdisk
	app-misc/evtest
	net-analyzer/traceroute
	net-misc/whois
	sys-apps/gptfdisk
	sys-block/f3
	sys-block/partimage
	sys-apps/system-chroot
	sys-fs/ddrescue
	sys-fs/ext4magic
	www-client/lynx

	amd64? (
		sys-apps/memtest86+
		!minimal? (
			sys-boot/woeusb-ng
			app-crypt/chntpw
		)

		xfce? (
			sys-boot/unetbootin
		)
	)

	!minimal? (
		app-antivirus/clamav
		app-antivirus/fangfrisch
		net-analyzer/nmap
		net-dialup/minicom
	)

	gui? (
		app-antivirus/clamtk
		media-video/cheese
		net-analyzer/wireshark
		net-ftp/filezilla
		sys-apps/gsmartcontrol
		sys-block/gparted
	)
)"

# CD recorder software
RDEPEND+=" cdr? (
	app-cdr/bin2iso
	app-cdr/cuetools
	gui? (
		app-cdr/isomaster
		app-cdr/xfburn
	)
)"

# Base GUI, xfce or wayland/wayfire
# Note:
# Supertux does not build on switch, therefore excluded from arm64.
# Lutris requires desktop-portal that requires pipewire that does not build.
# Use gamehub instead.
RDEPEND+=" gaming? (
	games-action/supertuxkart
	amd64? (
		app-emulation/dxvk
		app-emulation/vkd3d-proton
		app-emulation/wine-proton
		app-emulation/wine-staging
		app-emulation/winetricks
		games-emulation/dosbox-staging
		games-emulation/dosbox-x
		games-util/gamemode
		media-libs/openglide-xtra

		games-arcade/supertux
		games-util/lutris
	)
	!amd64? (
		games-util/gamehub
	)
)"


# Base GUI, xfce or wayland/wayfire
RDEPEND+=" gui? (
	app-benchmarks/glmark2
	app-arch/xarchiver
	app-editors/mousepad
	dev-util/catfish
	dev-util/meld
	games-util/joystick
	gui-libs/display-manager-init
	media-fonts/fonts-meta
	media-gfx/ristretto
	net-fs/autofs
	net-wireless/blueman
	sci-calculators/galculator
	sys-apps/baobab
	sys-auth/rtkit
	x11-terms/xfce4-terminal
	xfce-base/thunar
	xfce-base/thunar-volman
	xfce-base/tumbler
	xfce-extra/thunar-archive-plugin
	xfce-extra/thunar-media-tags-plugin
	|| ( www-client/firefox www-client/firefox-bin )

	networkmanager? ( gnome-extra/nm-applet )

	pulseaudio? (
		media-sound/pavucontrol
	)

	!multiuser? (
		gui-libs/greetd
	)
)"

# desktop-portal  requires pipewire that does not build.
RDEPEND+=" gui? (
	amd64? (
		sys-apps/xdg-desktop-portal-gtk
	)
)
"


# Media Center
# app-text/doxygen required by dev-cpp/waylandpp required by kodi
RDEPEND+=" mediacenter? (
	media-tv/kodi
	media-plugins/kodi-inputstream-adaptive
	media-plugins/kodi-inputstream-rtmp
	media-plugins/kodi-peripheral-joystick
	media-plugins/kodi-pvr-hts
	app-text/doxygen
 )
"


RDEPEND+=" vaapi? (
	media-video/libva-utils
	video_cards_intel? (
		media-libs/libva-intel-media-driver
	)
)"

# Office Workstation
RDEPEND+=" workstation? (
	app-admin/keepassxc
	app-crypt/fcrackzip
	|| ( app-office/libreoffice app-office/libreoffice-bin )
	app-text/evince
	app-text/crqt-ng
	app-text/pdfarranger
	media-gfx/gimp
	media-sound/grip
	media-video/vlc
	net-print/hplip
	net-print/hplip-plugin
	media-gfx/simple-scan
	media-gfx/xsane
	media-sound/easytag
)"

### By Desktop ###
## Wayland base packages, that should be on any device with graphical interface (WIP)
## Mako required to fulfill virtual/notification-daemon. The wf-shell panel provide own notification client
## xeyes is for testing apps if wayland native or xwayland
RDEPEND+=" wayland? (
	gui-apps/kanshi
	gui-apps/mako
	gui-apps/wf-shell
	gui-apps/wcm
	gui-apps/wlr-randr
	gui-wm/wayfire
	sys-power/acpilight
	sys-power/upower

	X? ( x11-apps/xeyes )
)"


# X and XFCE base packages, that should be on any device with graphical interface
RDEPEND+=" xfce? (
	app-admin/sudo
	x11-apps/xinput
	x11-apps/xkill
	x11-apps/xrandr
	x11-base/xorg-server
	x11-misc/autorandr
	x11-misc/menulibre
	x11-misc/wmctrl
	x11-misc/xdotool
	x11-terms/xterm
	x11-themes/elementary-xfce-icon-theme
	x11-themes/light-themes
	x11-themes/papirus-icon-theme
	x11-themes/xfwm4-themes
	xfce-base/xfce4-meta
	xfce-extra/xfce4-cpufreq-plugin
	xfce-extra/xfce4-cpugraph-plugin
	xfce-extra/xfce4-mount-plugin
	xfce-extra/xfce4-netload-plugin
	xfce-extra/xfce4-notifyd
	xfce-extra/xfce4-panel-profiles
	xfce-extra/xfce4-screenshooter
	xfce-extra/xfce4-sensors-plugin
	xfce-extra/xfce4-taskmanager
	xfce-extra/xfce4-whiskermenu-plugin

	pulseaudio? (
		xfce-extra/xfce4-pulseaudio-plugin
	)

	multiuser? (
		x11-misc/lightdm
	)
)"
