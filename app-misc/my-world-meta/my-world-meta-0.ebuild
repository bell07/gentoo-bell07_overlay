EAPI="7"
KEYWORDS="amd64"
SLOT="0"

IUSE="admin pulseaudio xfce"
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
app-eselect/eselect-repository
app-misc/evtest
app-misc/mc
app-misc/screen
app-portage/cpuid2cpuflags
app-portage/eix
app-portage/genlop
app-portage/gentoolkit
app-portage/smart-live-rebuild
dev-vcs/git
net-analyzer/nettop
sys-apps/pciutils
sys-apps/usbutils
sys-boot/efibootmgr
sys-fs/dosfstools
sys-fs/exfatprogs
sys-fs/ntfs3g
sys-kernel/gentoo-kernel
sys-kernel/linux-firmware
sys-process/htop
sys-process/iotop
sys-process/lsof
"

# System and network analysis and monitoring tools
RDEPEND+=" admin? (
app-antivirus/clamav
app-antivirus/fangfrisch
app-crypt/chntpw
app-crypt/fcrackzip
net-analyzer/nmap
net-analyzer/wireshark
net-dialup/minicom
net-ftp/filezilla
net-misc/whois
sys-apps/gptfdisk
sys-apps/gsmartcontrol
sys-apps/memtest86+
sys-block/gparted
sys-boot/unetbootin
sys-boot/woeusb
sys-fs/ddrescue
)"


# XFCE packages
RDEPEND+=" xfce? (
app-arch/xarchiver
app-editors/leafpad
dev-util/meld
media-fonts/fonts-meta
media-gfx/ristretto
media-sound/pavucontrol
net-wireless/blueman
sci-calculators/galculator
sys-apps/baobab
x11-apps/xinput
x11-apps/xrandr
x11-base/xorg-server
x11-misc/autorandr
x11-misc/menulibre
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
xfce-extra/xfce4-pulseaudio-plugin
xfce-extra/xfce4-screenshooter
xfce-extra/xfce4-sensors-plugin
xfce-extra/xfce4-taskmanager
xfce-extra/xfce4-volumed-pulse
xfce-extra/xfce4-whiskermenu-plugin
)"

# Audio packages for desktop
RDEPEND+=" pulseaudio? (
media-sound/alsa-utils
media-sound/pavucontrol
)"
