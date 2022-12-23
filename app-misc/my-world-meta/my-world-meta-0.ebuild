EAPI="7"
KEYWORDS="amd64"
SLOT="0"

IUSE="xfce"
HOMEPAGE="https://github.com/bell07/gentoo-bell07_overlay"

DESCRIPTION="My favorite software preselection - meta package"

# Base packages that should be on any system
RDEPEND+="
app-admin/logrotate
app-admin/sudo
app-admin/syslog-ng
app-arch/p7zip
app-arch/unrar
app-arch/unzip
app-editors/nano
app-misc/evtest
app-misc/mc
app-misc/screen
app-portage/eix
app-portage/genlop
app-portage/gentoolkit
app-portage/portage-lostfiles
app-portage/smart-live-rebuild
dev-vcs/git
sys-apps/pciutils
sys-apps/usbutils
sys-boot/efibootmgr
sys-fs/dosfstools
sys-process/htop
sys-process/iotop
sys-process/lsof
"

# XFCE packages
RDEPEND+=" xfce? (
app-arch/xarchiver
app-editors/leafpad
dev-util/meld
media-gfx/ristretto
media-sound/pavucontrol
sci-calculators/galculator
x11-misc/menulibre
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
xfce-extra/xfce4-pulseaudio-plugin
xfce-extra/xfce4-screenshooter
xfce-extra/xfce4-sensors-plugin
xfce-extra/xfce4-taskmanager
xfce-extra/xfce4-volumed-pulse
xfce-extra/xfce4-whiskermenu-plugin
)"
