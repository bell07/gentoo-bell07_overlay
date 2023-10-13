EAPI="7"
KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="admin +bell07-config desktop minimal mediacenter multiuser networkmanager pulseaudio vulkan wayland xfce wifi"
HOMEPAGE="https://github.com/bell07/gentoo-bell07_overlay"

DESCRIPTION="My favorite software preselection - meta package"

# Base packages that should be on any system
RDEPEND+="
	app-arch/p7zip
	app-arch/unzip
	app-editors/nano
	app-misc/mc
	app-misc/screen
	net-fs/cifs-utils
	net-misc/iperf
	net-misc/openssh
	sys-apps/pciutils
	sys-apps/usbutils
	sys-fs/dosfstools
	sys-fs/exfatprogs
	sys-fs/ntfs3g
	sys-libs/gpm
	sys-process/htop
	sys-process/iotop
	sys-process/lsof
"

# My configuration files
RDEPEND+=" bell07-config? ( app-misc/my-gentoo-config )"

# amd64 only base packages
RDEPEND+="
 amd64? (
	sys-boot/efibootmgr
	sys-kernel/gentoo-kernel
	sys-kernel/kernel-cfg
)"

# Additional packages for non minimal systems
RDEPEND+="
 !minimal? (
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
	dev-util/strace
	app-text/dos2unix
	dev-vcs/git
	net-analyzer/nettop
	sys-apps/lm-sensors
	sys-apps/mlocate
	sys-kernel/linux-firmware
	sys-power/powertop
)"

# System and network analysis, monitoring and recovery tools
RDEPEND+="
 admin? (
	app-admin/testdisk
	app-misc/evtest
	net-analyzer/traceroute
	net-misc/whois
	sys-apps/gptfdisk
	sys-block/partimage
	sys-apps/system-chroot
	sys-fs/ddrescue
	sys-fs/ext4magic
	www-client/lynx

	amd64? (
		sys-apps/memtest86+
		!minimal? (
			sys-boot/woeusb
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

	xfce? (
		media-video/cheese
		net-analyzer/wireshark
		net-ftp/filezilla
		sys-apps/gsmartcontrol
		sys-block/gparted
	)
)"

# Desktop applications for usual Office Workstation
RDEPEND+="
 desktop? (
	app-admin/keepassxc
	app-cdr/xfburn
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

# Advanced Audio setup
RDEPEND+="
 pulseaudio? (
	media-sound/alsa-utils
)"

# Media Center
RDEPEND+="
 mediacenter? (
	media-tv/kodi
	media-plugins/kodi-inputstream-adaptive
	media-plugins/kodi-inputstream-ffmpegdirect
	media-plugins/kodi-inputstream-rtmp
	media-plugins/kodi-peripheral-joystick
	media-plugins/kodi-pvr-hts
 )
"

# X and XFCE base packages, that should be on any device with graphical interface
RDEPEND+="
 xfce? (
	app-benchmarks/glmark2
	app-admin/sudo
	app-arch/xarchiver
	app-editors/mousepad
	dev-util/meld
	games-util/joystick
	media-fonts/fonts-meta
	media-gfx/ristretto
	net-wireless/blueman
	sci-calculators/galculator
	sys-apps/baobab
	sys-auth/rtkit
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
	x11-themes/xfwm4-themes
	x11-themes/light-themes
	xfce-base/thunar
	xfce-base/xfce4-meta
	xfce-extra/thunar-archive-plugin
	xfce-extra/thunar-media-tags-plugin
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
	|| ( www-client/firefox www-client/firefox-bin )

	networkmanager? ( gnome-extra/nm-applet )

	pulseaudio? (
		media-sound/pavucontrol
		xfce-extra/xfce4-pulseaudio-plugin
	)

	multiuser? (
		x11-misc/lightdm
	)

	!multiuser? (
		gui-libs/greetd
	)
)"


# Wayland base packages, that should be on any device with graphical interface
# (WIP)
RDEPEND+="
 wayland? (
	gui-apps/wf-shell
	gui-wm/wayfire

	!multiuser? (
		gui-libs/greetd
	)
)"

# Vulkan tools for vulkan
RDEPEND+="
 vulkan? ( dev-util/vulkan-tools )"

RDEPEND+=" wifi? ( !networkmanager? ( net-misc/netifrc net-wireless/wpa_supplicant ) )"
