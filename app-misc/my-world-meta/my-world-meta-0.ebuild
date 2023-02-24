EAPI="7"
KEYWORDS="amd64"
SLOT="0"

IUSE="admin desktop pulseaudio xfce"
HOMEPAGE="https://github.com/bell07/gentoo-bell07_overlay"

DESCRIPTION="My favorite software preselection - meta package"

# Base packages that should be on any system
RDEPEND+="
app-admin/logrotate
app-admin/sudo
app-admin/syslog-ng
sys-apps/mlocate
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
app-text/dos2unix
dev-util/strace
dev-vcs/git
net-analyzer/nettop
sys-apps/lm-sensors
sys-apps/pciutils
sys-apps/usbutils
sys-auth/rtkit
sys-boot/efibootmgr
sys-fs/dosfstools
sys-fs/exfatprogs
sys-fs/ntfs3g
sys-kernel/gentoo-kernel
sys-kernel/kernel-cfg
sys-kernel/linux-firmware
sys-power/powertop
sys-process/htop
sys-process/iotop
sys-process/lsof
"

# System and network analysis, monitoring and recovery tools
RDEPEND+=" admin? (
app-admin/testdisk
app-antivirus/clamav
app-antivirus/fangfrisch
app-crypt/chntpw
app-crypt/fcrackzip
media-video/cheese
net-analyzer/nmap
net-analyzer/traceroute
net-analyzer/wireshark
net-dialup/minicom
net-ftp/filezilla
net-misc/whois
sys-apps/gptfdisk
sys-apps/gsmartcontrol
sys-apps/memtest86+
sys-block/gparted
sys-block/partimage
sys-boot/unetbootin
sys-boot/woeusb
sys-apps/memtest86+
sys-fs/ddrescue
)"

# Desktop applications for usual Workstation
RDEPEND+=" desktop? (
app-admin/keepassxc
app-cdr/xfburn
|| ( app-office/libreoffice app-office/libreoffice-bin )
app-text/evince
media-gfx/gimp
media-sound/grip
media-video/vlc
net-print/hplip
net-print/hplip-plugin
)"

# Advanced Audio setup
RDEPEND+=" pulseaudio? (
media-sound/alsa-utils
)"

# X and XFCE base packages, that should be on any device with graphical interface
RDEPEND+=" xfce? (
app-benchmarks/glmark2
app-arch/xarchiver
app-editors/leafpad
dev-util/meld
media-fonts/fonts-meta
media-gfx/ristretto
net-wireless/blueman
sci-calculators/galculator
sys-apps/baobab
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

pulseaudio? (
media-sound/pavucontrol
xfce-extra/xfce4-pulseaudio-plugin
xfce-extra/xfce4-volumed-pulse
)

)"
