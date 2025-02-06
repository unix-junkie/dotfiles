# .bash_profile

[ -f /etc/profile ] && . /etc/profile

if [ "${TERM}" = 'cygwin' ]
then
	export LANG='C'
	export LC_CTYPE='ru_RU.CP1251'
	export LC_TIME='ru_RU.CP1251'
	export LC_COLLATE='ru_RU.CP1251'
	export LC_MONETARY='ru_RU.CP1251'
	export LC_PAPER='ru_RU.CP1251'
	export LC_NAME='ru_RU.CP1251'
	export LC_ADDRESS='ru_RU.CP1251'
	export LC_TELEPHONE='ru_RU.CP1251'
	export LC_MEASUREMENT='ru_RU.CP1251'
	export LC_IDENTIFICATION='ru_RU.CP1251'
fi

# Affects floating point evaluation in ksh
export LC_NUMERIC='C'
export LC_MESSAGES='C'

[ -f ~/.bashrc ] && . ~/.bashrc

if [ -d ~/.bash_profile.d ]
then
	for f in $(find ~/.bash_profile.d -type f)
	do
		. "${f}"
	done
fi

# Common
#export VISUAL='vim'
export VISUAL='emacsclient -a "" -c -nw'
export EDITOR="${VISUAL}"
export PAGER='less'
export LESS='-P--More--?Pt(%Pt\%)'
export BROWSER='seamonkey'
export NNTPSERVER='news.mozilla.org'
export MC_XDG_OPEN='run-mailcap'
emacs --daemon >/dev/null 2>&1

# Development
export CVS_RSH='ssh'
export P4CONFIG='.p4settings'
export P4IGNORE='.gitignore'

# Java
if [ $(uname -s) == 'DragonFly' ]
then
	JAVA_HOME='/usr/local/openjdk8'
else
	JAVA_HOME='/usr/lib/jvm/zulu-fx-17-amd64'
fi
export JAVA_HOME
if [ -d "${JAVA_HOME}/jre" ]
then
	export JRE_HOME="${JAVA_HOME}/jre"
fi
#export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.motif.MotifLookAndFeel'
export _JAVA_OPTIONS='-Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel -Dswing.metalTheme=steel -Dswing.noxp=true -Dswing.aatext=false -Dswing.plaf.metal.controlFont="Arial-BOLD-12" -Dswing.plaf.metal.userFont="Arial--12" -Dswing.plaf.metal.systemFont="Arial--11" -Dswing.plaf.metal.smallFont="Arial--10"'
export _JAVA_OPTIONS="${_JAVA_OPTIONS} -Djdk.gtk.version=2"
export _JAVA_OPTIONS="${_JAVA_OPTIONS} -Dsun.java2d.uiScale=1"
export MAVEN_OPTS='-DdownloadSources=true -DdownloadJavadocs=true'

if [ -d "${HOME}/.sdkman" ]
then
	export SDKMAN_DIR="${HOME}/.sdkman"
	if [ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]
	then
		. "${SDKMAN_DIR}/bin/sdkman-init.sh"
	fi
fi

# Fall back to the system's gradle if sdkman provides nothing.
if [ -z "${GRADLE_HOME}" -a -d '/usr/share/gradle' ]
then
	export GRADLE_HOME='/usr/share/gradle'
fi

# Debian
export DEBFULLNAME="Andrey \`\`Bass'' Shcheglov"
export EMAIL='andrewbass@gmail.com'
export DEBEMAIL="${EMAIL}"

#Oracle
export ORACLE_HOME='/opt/oracle/product/11.2.0/client'
# 8i and 9i
##export NLS_LANG='RUSSIAN_CIS.AL32UTF8'
# 10g+
export NLS_LANG='RUSSIAN_RUSSIA.AL32UTF8'
export NLS_COMP='LINGUISTIC'
export NLS_SORT='RUSSIAN_AI'

export PATH="\
${JAVA_HOME}/bin:\
${JRE_HOME}/bin:\
${PATH}:\
/sbin:\
/usr/sbin:\
/opt/trinity/bin:\
/opt/trinity/sbin:\
/opt/trinity/games:\
/opt/p4v/bin:\
/opt/eclipse:\
/opt/idea/bin:\
/opt/GitExtensions:\
/opt/smartcvs/bin:\
/opt/seamonkey:\
/opt/acroread/bin:\
${ORACLE_HOME}/bin:\
${HOME}/bin"

# X11
export XAPPLRESDIR="${HOME}/.app-defaults"
##export XUSERFILESEARCHPATH="%L/%N.ad:%N.ad:${XAPPLRESDIR}/%L/%N:${XAPPLRESDIR}/%N:/etc/X11/app-defaults/%N"
export XUSERFILESEARCHPATH="\
%L/%N.ad:\
%l/%N.ad:\
%N.ad:\
${XAPPLRESDIR}/%L/%N:\
${XAPPLRESDIR}/%l/%N:\
${XAPPLRESDIR}/%N"

# In order for server-side vector fonts to look good
# when rasterized using newer (2.7+) FreeType versions.
export FREETYPE_PROPERTIES=truetype:interpreter-version=35

# GTK3
export GTK_CSD=0
export GTK_DISABLE_CSD=1
export GTK_THEME='Raleigh-Reloaded'
export GTK_OVERLAY_SCROLLING=0
if [[ -f /usr/lib/i386-linux-gnu/libgtk3-nocsd.so.0 || -f /usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0 ]]
then
	export LD_PRELOAD="libgtk3-nocsd.so.0${LD_PRELOAD:+:$LD_PRELOAD}"
fi

# Make Eclipse use GTK2 by default
export SWT_GTK3=0
export QT_STYLE_OVERRIDE='gtk2'
export QT_QPA_PLATFORMTHEME='gtk2'
# Disable automatic UI scaling in Qt5 on HiDPI displays (e. g.: in vlc). We'll set screen DPI ourselves.
export QT_AUTO_SCREEN_SCALE_FACTOR=0
# The same for GTK+:
export GDK_SCALE=1
export GDK_DPI_SCALE=1

# Make DrRacket use GTK2 by default
export PLT_GTK2=1

ulimit -c unlimited

# D-Bus
if [[ -z "${DBUS_SESSION_BUS_ADDRESS}" && -x "$(which dbus-launch)" ]]
then
	export $(dbus-launch)
fi

# gvfsd
export GVFS_DISABLE_FUSE=1

# LibreOffice
export SAL_USE_VCLPLUGIN='qt5'

# Fix PuTTY line drawing in UTF-8 mode.
if [ "$(locale charmap)" = 'UTF-8' ] && [[ "${TERM}" =~ ^xterm.*$ ]]
then
	# This is probably PuTTY, but let's check the answerback string.
	if [ -x "$(which stty)" ]
	then
		old_stty=$(stty -g)
		stty raw min 0 time 5
		echo -ne '\005'
		read -s
		# Mere 'stty cooked' may be insufficient, as we may also
		# need UTF-8 input (iutf8) enabled
		stty "${old_stty}"
		unset old_stty
		answerbackString="${REPLY}"
	else
		answerbackString=''
		echo -ne '\005'
		while read -n1 -s -t1
		do
			answerbackString="${answerbackString}${REPLY}"
		done
	fi

	if [ "${answerbackString}" = 'PuTTY' ]
	then
		export NCURSES_NO_UTF8_ACS=1
	else
		unset NCURSES_NO_UTF8_ACS
	fi

	unset answerbackString
else
	unset NCURSES_NO_UTF8_ACS
fi
