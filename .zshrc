# Filename:      .zshrc
# Purpose:       config file for zsh
# Authors:       grml-team (grml.org), (c) Michael Prokop <mika@grml.org>
# Bug-Reports:   see http://grml.org/bugs/
# License:       This file is licensed under the GPL v2.
################################################################################

# source ~/.zshrc.global {{{

# see /etc/zsh/zshrc for some general settings
# If you don't have write permissions to /etc/zsh/zshrc on your own
# copy the file to your $HOME as /.zshrc.global and we source it:

# Note, that xsource() is defined in the global file, so here,
# we will have to do the sourcing manually for once:

[[ -z "$ZSHRC_GLOBAL_HAS_BEEN_READ" ]]  \
&& [[ -r "${HOME}/.zshrc.global" ]]     \
&& source "${HOME}/.zshrc.global"
# }}}

# check whether global file has been read {{{
if [[ -z "$ZSHRC_GLOBAL_HAS_BEEN_READ" ]] ; then
    print 'Warning: global zsh config has not been read.' >&2
    print '         prepare for possible errors!'         >&2
    print '' >&2
    print 'See our refcard for info on how to get the complete configuration:' >&2
    print '    <http://grml.org/zsh/grml-zsh-refcard.pdf>' >&2
fi
# }}}

# completion system {{{
# just make sure it is loaded in this file too
# TODO: is this *really* needed? compsys should be run in the global zshrc already.
check_com compinit || { autoload -U compinit && compinit }
# }}}

# make sure isgrmlsmall is defined {{{
check_com isgrmlsmall || function isgrmlsmall () { return 1 }
# }}}

# variables {{{

# do you want grmlsmall-specific adjustments?
GRMLSMALL_SPECIFIC=1

# set terminal property (used e.g. by msgid-chooser)
export COLORTERM="yes"

# set default browser
if [[ -z "$BROWSER" ]] ; then
    if [[ -n "$DISPLAY" ]] ; then
        #v# If X11 is running
        check_com -c firefox && export BROWSER=firefox
    else
        #v# If no X11 is running
        check_com -c w3m && export BROWSER=w3m
    fi
fi

#m# v QTDIR \kbd{/usr/share/qt[34]}\quad [for non-root only]
[[ -d /usr/share/qt3 ]] && export QTDIR=/usr/share/qt3
[[ -d /usr/share/qt4 ]] && export QTDIR=/usr/share/qt4

# support running 'jikes *.java && jamvm HelloWorld' OOTB:
#v# [for non-root only]
[[ -f /usr/share/classpath/glibj.zip ]] && export JIKESPATH=/usr/share/classpath/glibj.zip
# }}}

# set options {{{

# Allow comments even in interactive shells i. e.
# $ uname # This command prints system informations
# zsh: bad pattern: #
# $ setopt interactivecomments
# $ uname # This command prints system informations
# Linux
#  setopt interactivecomments

# ctrl-s will no longer freeze the terminal.
#  stty erase "^?"

# }}}

# {{{ global aliases
# These do not have to be at the beginning of the command line.
# Avoid typing cd ../../ for going two dirs down and so on
# Usage, e.g.: "$ cd ...' or just '$ ...' with 'setopt auto_cd'
# Notice: deactivated by 061112 by default, we use another approach
# known as "power completion / abbreviation expansion"
#  alias -g '...'='../..'
#  alias -g '....'='../../..'
#  alias -g BG='& exit'
#  alias -g C='|wc -l'
#  alias -g G='|grep'
#  alias -g H='|head'
#  alias -g Hl=' --help |& less -r'
#  alias -g K='|keep'
#  alias -g L='|less'
#  alias -g LL='|& less -r'
#  alias -g M='|most'
#  alias -g N='&>/dev/null'
#  alias -g R='| tr A-z N-za-m'
#  alias -g SL='| sort | less'
#  alias -g S='| sort'
#  alias -g T='|tail'
#  alias -g V='| vim -'
# }}}

# aliases {{{

# general
#a2# Execute \kbd{du -sch}
alias da='du -sch'
#a2# Execute \kbd{jobs -l}
alias j='jobs -l'
#  alias u='translate -i'          # translate

# compile stuff
#a2# Execute \kbd{./configure}
alias CO="./configure"
#a2# Execute \kbd{./configure --help}
alias CH="./configure --help"

# listing stuff
#a2# Execute \kbd{ls -lSrah}
alias dir="ls -lSrah"
#a2# Only show dot-directories
alias lad='ls -d .*(/)'                # only show dot-directories
#a2# Only show dot-files
alias lsa='ls -a .*(.)'                # only show dot-files
#a2# Only files with setgid/setuid/sticky flag
alias lss='ls -l *(s,S,t)'             # only files with setgid/setuid/sticky flag
#a2# Only show 1st ten symlinks
alias lsl='ls -l *(@[1,10])'           # only symlinks
#a2# Display only executables
alias lsx='ls -l *(*[1,10])'           # only executables
#a2# Display world-{readable,writable,executable} files
alias lsw='ls -ld *(R,W,X.^ND/)'       # world-{readable,writable,executable} files
#a2# Display the ten biggest files
alias lsbig="ls -flh *(.OL[1,10])"     # display the biggest files
#a2# Only show directories
alias lsd='ls -d *(/)'                 # only show directories
#a2# Only show empty directories
alias lse='ls -d *(/^F)'               # only show empty directories
#a2# Display the ten newest files
alias lsnew="ls -rl *(D.om[1,10])"     # display the newest files
#a2# Display the ten oldest files
alias lsold="ls -rtlh *(D.om[1,10])"   # display the oldest files
#a2# Display the ten smallest files
alias lssmall="ls -Srl *(.oL[1,10])"   # display the smallest files

# chmod
#a2# Execute \kbd{chmod 600}
alias rw-='chmod 600'
#a2# Execute \kbd{chmod 700}
alias rwx='chmod 700'
#m# a2 r-{}- Execute \kbd{chmod 644}
alias r--='chmod 644'
#a2# Execute \kbd{chmod 755}
alias r-x='chmod 755'

# some useful aliases
#a2# Execute \kbd{mkdir -o}
alias md='mkdir -p'

check_com -c ipython && alias ips='ipython -p sh'

# archlinux stuff
alias p='pacman'
alias psy'pacman -Sy'
alias y='yaourt'

# misc stuff
alias mp='mplayer'
alias cls='clear'
alias qiv='qiv -tI'

# be more verbose
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -v'

# ignore ~/.ssh/known_hosts entries
#  alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -o "PreferredAuthentications=keyboard-interactive"'
#a2# ssh with StrictHostKeyChecking=no \\&\quad and UserKnownHostsFile unset
alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias insecscp='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'

# Use 'g' instead of 'git':
check_com g || alias g='git'

# use colors when browsing man pages, but only if not using LESS_TERMCAP_* from /etc/zsh/zshenv:
if [[ -z "$LESS_TERMCAP_md" ]] ; then
    [[ -d ~/.terminfo/ ]] && alias man='TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man'
fi

# }}}

# useful functions {{{

# searching
#f4# Search for newspostings from authors
agoogle() { ${=BROWSER} "http://groups.google.com/groups?as_uauthors=$*" ; }

#f4# Search DMOZ
dmoz()    { ${=BROWSER} http://search.dmoz.org/cgi-bin/search\?search=${1// /_} }
#f4# Search German   Wiktionary
dwicti()  { ${=BROWSER} http://de.wiktionary.org/wiki/${(C)1// /_} }
#f4# Search English  Wiktionary
ewicti()  { ${=BROWSER} http://en.wiktionary.org/wiki/${(C)1// /_} }
#f4# Search Google Groups
ggogle()  { ${=BROWSER} "http://groups.google.com/groups?q=$*" }
#f4# Search Google
google()  { ${=BROWSER} "http://www.google.com/search?&num=100&q=$*" }
#f4# Search Google Groups for MsgID
mggogle() { ${=BROWSER} "http://groups.google.com/groups?selm=$*" }
#f4# Search Netcraft
netcraft(){ ${=BROWSER} "http://toolbar.netcraft.com/site_report?url=$1" }
#f4# Use German Wikipedia's full text search
swiki()   { ${=BROWSER} http://de.wikipedia.org/wiki/Spezial:Search/${(C)1} }
#f4# search \kbd{dict.leo.org}
oleo()    { ${=BROWSER} "http://dict.leo.org/?search=$*" }
#f4# Search German   Wikipedia
wikide()  { ${=BROWSER} http://de.wikipedia.org/wiki/"${(C)*}" }
#f4# Search English  Wikipedia
wikien()  { ${=BROWSER} http://en.wikipedia.org/wiki/"${(C)*}" }

#m# f4 gex() Exact search via Google
check_com google && gex () { google "\"[ $1]\" $*" } # exact search at google

# misc
#f5# Backup \kbd{file {\rm to} file\_timestamp}
bk()      { cp -b ${1} ${1}_`date --iso-8601=m` }
#f5# Copied diff
cdiff()   { diff -crd "$*" | egrep -v "^Only in |^Binary files " }
#f5# cd to directoy and list files
cl()      { cd $1 && ls -a }        # cd && ls
#f5# Disassemble source files using gcc and as
disassemble(){ gcc -pipe -S -o - -O -g $* | as -aldh -o /dev/null }
#f5# Firefox remote control - open given URL
fir()     { firefox -a firefox -remote "openURL($1)" }
#f5# Create Directoy and \kbd{cd} to it
mcd()     { mkdir -p "$@"; cd "$@" } # mkdir && cd
#f5# Unified diff to timestamped outputfile
mdiff()   { diff -udrP "$1" "$2" > diff.`date "+%Y-%m-%d"`."$1" }
#f5# Memory overview
memusage(){ ps aux | awk '{if (NR > 1) print $5; if (NR > 2) print "+"} END { print "p" }' | dc }
#f5# Show contents of tar file
shtar()   { gunzip -c $1 | tar -tf - -- | $PAGER }
#f5# Show contents of tgz file
shtgz()   { tar -ztf $1 | $PAGER }
#f5# Show contents of zip file
shzip()   { unzip -l $1 | $PAGER }
#f5# Greps signature from file
sig()     { agrep -d '^-- $' "$*" ~/.Signature }
#f5# Unified diff
udiff()   { diff -urd $* | egrep -v "^Only in |^Binary files " }
#f5# (Mis)use \kbd{vim} as \kbd{less}
viless()  { vim --cmd 'let no_plugin_maps = 1' -c "so \$VIMRUNTIME/macros/less.vim" "${@:--}" }

# Function Usage: uopen $URL/$file
#f5# Download a file and display it locally
uopen() {
    if ! [[ -n "$1" ]] ; then
        print "Usage: uopen \$URL/\$file">&2
        return 1
    else
        FILE=$1
        MIME=$(curl --head $FILE | grep Content-Type | cut -d ' ' -f 2 | cut -d\; -f 1)
        MIME=${MIME%$'\r'}
        curl $FILE | see ${MIME}:-
    fi
}

# Function Usage: doc packagename
#f5# \kbd{cd} to /usr/share/doc/\textit{package}
doc() { cd /usr/share/doc/$1 && ls }
_doc() { _files -W /usr/share/doc -/ }
check_com compdef && compdef _doc doc

#f5# Make screenshot
sshot() {
    [[ ! -d ~/shots  ]] && mkdir ~/shots
    #cd ~/shots ; sleep 5 ; import -window root -depth 8 -quality 80 `date "+%Y-%m-%d--%H:%M:%S"`.png
    cd ~/shots ; sleep 5; import -window root shot_`date --iso-8601=m`.jpg
}

# list images only
limg() {
    local -a images
    images=( *.{jpg,gif,png}(.N) )

    if [[ $#images -eq 0 ]] ; then
        print "No image files found"
    else
        ls "$@" "$images[@]"
    fi
}

# zsh with perl-regex - use it e.g. via:
# regcheck '\s\d\.\d{3}\.\d{3} Euro' ' 1.000.000 Euro'
#f5# Checks whether a regex matches or not.\\&\quad Example: \kbd{regcheck '.\{3\} EUR' '500 EUR'}
regcheck() {
    zmodload -i zsh/pcre
    pcre_compile $1 && \
    pcre_match $2 && echo "regex matches" || echo "regex does not match"
}

#f5# List files which have been modified within the last {\it n} days
new() { print -l *(m-$1) }

#f5# Grep in history
greph() { history 0 | grep $1 }
# use colors when GNU grep with color-support
#a2# Execute \kbd{grep -{}-color=auto}
(grep --help 2>/dev/null |grep -- --color) >/dev/null && alias grep='grep --color=auto'
#a2# Execute \kbd{grep -i -{}-color=auto}
alias GREP='grep -i --color=auto'

# one blank line between each line
if [[ -r ~/.terminfo/m/mostlike ]] ; then
#   alias man2='MANPAGER="sed -e G |less" TERMINFO=~/.terminfo TERM=mostlike /usr/bin/man'
    #f5# Watch manpages in a stretched style
    man2() { PAGER='dash -c "sed G | /usr/bin/less"' TERM=mostlike /usr/bin/man "$@" ; }
fi

# d():Copyright 2005 Nikolai Weibull <nikolai@bitwi.se>
# notice: option AUTO_PUSHD has to be set
#f5# Jump between directories
d() {
    emulate -L zsh
    autoload -U colors
    local color=$fg_bold[blue]
    integer i=0
    dirs -p | while read dir; do
        local num="${$(printf "%-4d " $i)/ /.}"
        printf " %s  $color%s$reset_color\n" $num $dir
        (( i++ ))
    done
    integer dir=-1
    read -r 'dir?Jump to directory: ' || return
    (( dir == -1 )) && return
    if (( dir < 0 || dir >= i )); then
        echo d: no such directory stack entry: $dir
        return 1
    fi
    cd ~$dir
}

# usage example: 'lcheck strcpy'
#f5# Find out which libs define a symbol
lcheck() {
    if [[ -n "$1" ]] ; then
        nm -go /usr/lib/lib*.a 2>/dev/null | grep ":[[:xdigit:]]\{8\} . .*$1"
    else
        echo "Usage: lcheck <function>" >&2
    fi
}

#f5# Clean up directory - remove well known tempfiles
purge() {
    FILES=(*~(N) .*~(N) \#*\#(N) *.o(N) a.out(N) *.core(N) *.cmo(N) *.cmi(N) .*.swp(N))
    NBFILES=${#FILES}
    if [[ $NBFILES > 0 ]] ; then
        print $FILES
        local ans
        echo -n "Remove these files? [y/n] "
        read -q ans
        if [[ $ans == "y" ]] ; then
            rm ${FILES}
            echo ">> $PWD purged, $NBFILES files removed"
        else
            echo "Ok. .. than not.."
        fi
    fi
}

#f5# List all occurrences of programm in current PATH
plap() {
    if [[ $# = 0 ]] ; then
        echo "Usage:    $0 program"
        echo "Example:  $0 zsh"
        echo "Lists all occurrences of program in the current PATH."
    else
        ls -l ${^path}/*$1*(*N)
    fi
}

# Found in the mailinglistarchive from Zsh (IIRC ~1996)
#f5# Select items for specific command(s) from history
selhist() {
    emulate -L zsh
    local TAB=$'\t';
    (( $# < 1 )) && {
        echo "Usage: $0 command"
        return 1
    };
    cmd=(${(f)"$(grep -w $1 $HISTFILE | sort | uniq | pr -tn)"})
    print -l $cmd | less -F
    echo -n "enter number of desired command [1 - $(( ${#cmd[@]} - 1 ))]: "
    local answer
    read answer
    print -z "${cmd[$answer]#*$TAB}"
}

# Use vim to convert plaintext to HTML
#f5# Transform files to html with highlighting
2html() { vim -u NONE -n -c ':syntax on' -c ':so $VIMRUNTIME/syntax/2html.vim' -c ':wqa' $1 &>/dev/null }

# Usage: simple-extract <file>
#f5# Smart archive extractor
simple-extract () {
    if [[ -f $1 ]] ; then
        case $1 in
            *.tar.bz2)  bzip2 -v -d $1      ;;
            *.tar.gz)   tar -xvzf $1        ;;
            *.rar)      unrar $1            ;;
            *.deb)      ar -x $1            ;;
            *.bz2)      bzip2 -d $1         ;;
            *.lzh)      lha x $1            ;;
            *.gz)       gunzip -d $1        ;;
            *.tar)      tar -xvf $1         ;;
            *.tgz)      gunzip -d $1        ;;
            *.tbz2)     tar -jxvf $1        ;;
            *.zip)      unzip $1            ;;
            *.Z)        uncompress $1       ;;
            *)          echo "'$1' Error. Please go away" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Usage: smartcompress <file> (<type>)
#f5# Smart archive creator
smartcompress() {
    if [[ -n $2 ]] ; then
        case $2 in
            tgz | tar.gz)   tar -zcvf$1.$2 $1 ;;
            tbz2 | tar.bz2) tar -jcvf$1.$2 $1 ;;
            tar.Z)          tar -Zcvf$1.$2 $1 ;;
            tar)            tar -cvf$1.$2  $1 ;;
            gz | gzip)      gzip           $1 ;;
            bz2 | bzip2)    bzip2          $1 ;;
            *)
                echo "Error: $2 is not a valid compression type"
                ;;
        esac
    else
        smartcompress $1 tar.gz
    fi
}

# Usage: show-archive <archive>
#f5# List an archive's content
show-archive() {
    if [[ -f $1 ]] ; then
        case $1 in
            *.tar.gz)      gunzip -c $1 | tar -tf - -- ;;
            *.tar)         tar -tf $1 ;;
            *.tgz)         tar -ztf $1 ;;
            *.zip)         unzip -l $1 ;;
            *.bz2)         bzless $1 ;;
            *.deb)         dpkg-deb --fsys-tarfile $1 | tar -tf - -- ;;
            *)             echo "'$1' Error. Please go away" ;;
        esac
    else
        echo "'$1' is not a valid archive"
    fi
}

# It's shameless stolen from <http://www.vim.org/tips/tip.php?tip_id=167>
#f5# Use \kbd{vim} as your manpage reader
vman() { man $* | col -b | view -c 'set ft=man nomod nolist' - }

# function readme() { $PAGER -- (#ia3)readme* }
#f5# View all README-like files in current directory in pager
readme() {
    local files
    files=(./(#i)*(read*me|lue*m(in|)ut)*(ND))
    if (($#files)) ; then
        $PAGER $files
    else
        print 'No README files.'
    fi
}

# function ansi-colors()
#f5# Display ANSI colors
ansi-colors() {
    typeset esc="\033[" line1 line2
    echo " _ _ _40 _ _ _41_ _ _ _42 _ _ 43_ _ _ 44_ _ _45 _ _ _ 46_ _ _ 47_ _ _ 49_ _"
    for fore in 30 31 32 33 34 35 36 37; do
        line1="$fore "
        line2="   "
        for back in 40 41 42 43 44 45 46 47 49; do
            line1="${line1}${esc}${back};${fore}m Normal ${esc}0m"
            line2="${line2}${esc}${back};${fore};1m Bold   ${esc}0m"
        done
        echo -e "$line1\n$line2"
    done
}

# suidfind() { ls -latg $path | grep '^...s' }
#f5# Find all files in \$PATH with setuid bit set
suidfind() { ls -latg $path/*(sN) }

# See above but this is /better/ ... anywise ..
findsuid() {
    print 'Output will be written to ~/suid_* ...'
    $SUDO find / -type f \( -perm -4000 -o -perm -2000 \) -ls > ~/suid_suidfiles.`date "+%Y-%m-%d"`.out 2>&1
    $SUDO find / -type d \( -perm -4000 -o -perm -2000 \) -ls > ~/suid_suiddirs.`date "+%Y-%m-%d"`.out 2>&1
    $SUDO find / -type f \( -perm -2 -o -perm -20 \) -ls > ~/suid_writefiles.`date "+%Y-%m-%d"`.out 2>&1
    $SUDO find / -type d \( -perm -2 -o -perm -20 \) -ls > ~/suid_writedirs.`date "+%Y-%m-%d"`.out 2>&1
    print 'Finished'
}

#f5# Reload given functions
refunc() {
    for func in $argv ; do
        unfunction $func
        autoload $func
    done
}

# a small check to see which DIR is located on which server/partition.
# stolen and modified from Sven's zshrc.forall
#f5# Report diskusage of a directory
dirspace() {
    if [[ -n "$1" ]] ; then
        for dir in $* ; do
            if [[ -d "$dir" ]] ; then
                ( cd $dir; echo "-<$dir>"; du -shx .; echo);
            else
                echo "warning: $dir does not exist" >&2
            fi
        done
    else
        for dir in $path; do
            if [[ -d "$dir" ]] ; then
                ( cd $dir; echo "-<$dir>"; du -shx .; echo);
            else
                echo "warning: $dir does not exist" >&2
            fi
        done
    fi
}

# % slow_print `cat /etc/passwd`
#f5# Slowly print out parameters
slow_print() {
    for argument in "${@}" ; do
        for ((i = 1; i <= ${#1} ;i++)) ; do
            print -n "${argument[i]}"
            sleep 0.08
        done
        print -n " "
    done
    print ""
}

#f5# Show some status info
status() {
    print ""
    print "Date..: "$(date "+%Y-%m-%d %H:%M:%S")""
    print "Shell.: Zsh $ZSH_VERSION (PID = $$, $SHLVL nests)"
    print "Term..: $TTY ($TERM), $BAUD bauds, $COLUMNS x $LINES cars"
    print "Login.: $LOGNAME (UID = $EUID) on $HOST"
    print "System: $(cat /etc/[A-Za-z]*[_-][rv]e[lr]*)"
    print "Uptime:$(uptime)"
    print ""
}


#f5# Create an ISO image. You are prompted for\\&\quad volume name, filename and directory
mkiso() {
    echo " * Volume name "
    read volume
    echo " * ISO Name (ie. tmp.iso)"
    read iso
    echo " * Directory or File"
    read files
    mkisofs -o ~/$iso -A $volume -allow-multidot -J -R -iso-level 3 -V $volume -R $files
}

#f5# Set all ulimit parameters to \kbd{unlimited}
allulimit() {
    ulimit -c unlimited
    ulimit -d unlimited
    ulimit -f unlimited
    ulimit -l unlimited
    ulimit -n unlimited
    ulimit -s unlimited
    ulimit -t unlimited
}

#f5# RFC 2396 URL encoding in Z-Shell
urlencode() {
    setopt localoptions extendedglob
    input=( ${(s::)1} )
    print ${(j::)input/(#b)([^A-Za-z0-9_.!~*\'\(\)-])/%${(l:2::0:)$(([##16]#match))}}
}

# highlight important stuff in diff output, usage example: hg diff | hidiff
#m# a2 hidiff \kbd{histring} oneliner for diffs
check_com -c histring && \
    alias hidiff="histring -fE '^Comparing files .*|^diff .*' | histring -c yellow -fE '^\-.*' | histring -c green -fE '^\+.*'"

# open file in vim and jump to line
# http://www.downgra.de/archives/2007/05/08/T19_21_11/
j2v() {
    local -a params
    params=(${*//(#m):[0-9]*:/\\n+${MATCH//:/}}) # replace ':23:' to '\n+23'
    params=(${(s|\n|)${(j|\n|)params}}) # join array using '\n', then split on all '\n'
    vim ${params}
}

# get_ic() - queries imap servers for capabilities; real simple. no imaps
ic_get() {
    local port
    if [[ ! -z $1 ]] ; then
        port=${2:-143}
        print "querying imap server on $1:${port}...\n";
        print "a1 capability\na2 logout\n" | nc $1 ${port}
    else
        print "usage:\n  $0 <imap-server> [port]"
    fi
}

# creates a Maildir/ with its {new,cur,tmp} subdirs
mkmaildir() {
    local root subdir
    root=${MAILDIR_ROOT:-${HOME}/Mail}
    if [[ -z ${1} ]] ; then print "Usage:\n $0 <dirname>" ; return 1 ; fi
    subdir=${1}
    mkdir -p ${root}/${subdir}/{cur,new,tmp}
}

# hl() highlighted less
# http://ft.bewatermyfriend.org/comp/data/zsh/zfunct.html
if check_com -c highlight ; then
    function hl() {
        local theme lang
        theme=${HL_THEME:-""}
        case ${1} in
            (-l|--list)
                ( printf 'available languages (syntax parameter):\n\n' ;
                    highlight --list-langs ; ) | less -SMr
                ;;
            (-t|--themes)
                ( printf 'available themes (style parameter):\n\n' ;
                    highlight --list-themes ; ) | less -SMr
                ;;
            (-h|--help)
                printf 'usage: hl <syntax[:theme]> <file>\n'
                printf '    available options: --list (-l), --themes (-t), --help (-h)\n\n'
                printf '  Example: hl c main.c\n'
                ;;
            (*)
                if [[ -z ${2} ]] || (( ${#argv} > 2 )) ; then
                    printf 'usage: hl <syntax[:theme]> <file>\n'
                    printf '    available options: --list (-l), --themes (-t), --help (-h)\n'
                    (( ${#argv} > 2 )) && printf '  Too many arguments.\n'
                    return 1
                fi
                lang=${1%:*}
                [[ ${1} == *:* ]] && [[ -n ${1#*:} ]] && theme=${1#*:}
                if [[ -n ${theme} ]] ; then
                    highlight --xterm256 --syntax ${lang} --style ${theme} ${2} | less -SMr
                else
                    highlight --ansi --syntax ${lang} ${2} | less -SMr
                fi
                ;;
        esac
        return 0
    }
    # ... and a proper completion for hl()
    # needs 'highlight' as well, so it fits fine in here.
    function _hl_genarg()  {
        local expl
        if [[ -prefix 1 *: ]] ; then
            local themes
            themes=(${${${(f)"$(LC_ALL=C highlight --list-themes)"}/ #/}:#*(Installed|Use name)*})
            compset -P 1 '*:'
            _wanted -C list themes expl theme compadd ${themes}
        else
            local langs
            langs=(${${${(f)"$(LC_ALL=C highlight --list-langs)"}/ #/}:#*(Installed|Use name)*})
            _wanted -C list languages expl languages compadd -S ':' -q ${langs}
        fi
    }
    function _hl_complete() {
        _arguments -s '1: :_hl_genarg' '2:files:_path_files'
    }
    compdef _hl_complete hl
fi

# create small urls via tinyurl.com using wget, grep and sed
zurl() {
    [[ -z ${1} ]] && print "please give an url to shrink." && return 1
    local url=${1}
    local tiny="http://tinyurl.com/create.php?url="
    #print "${tiny}${url}" ; return
    wget  -O-             \
          -o/dev/null     \
          "${tiny}${url}" \
        | grep -Eio 'value="(http://tinyurl.com/.*)"' \
        | sed 's/value=//;s/"//g'
}

#f2# Find history events by search pattern and list them by date.
whatwhen()  {
# {{{
    local usage help ident format_l format_s first_char remain first last
    usage='USAGE: whatwhen [options] <searchstring> <search range>'
    help='Use' \`'whatwhen -h'\'' for further explanations.'
    ident=${(l,${#${:-Usage: }},, ,)}
    format_l="${ident}%s\t\t\t%s\n"
    format_s="${format_l//(\\t)##/\\t}"
    # Make the first char of the word to search for case
    # insensitive; e.g. [aA]
    first_char=[${(L)1[1]}${(U)1[1]}]
    remain=${1[2,-1]}
    # Default search range is `-100'.
    first=${2:-\-100}
    # Optional, just used for `<first> <last>' given.
    last=$3
    case $1 in
        ("")
            printf '%s\n\n' 'ERROR: No search string specified. Aborting.'
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (-h)
            printf '%s\n\n' ${usage}
            print 'OPTIONS:'
            printf $format_l '-h' 'show help text'
            print '\f'
            print 'SEARCH RANGE:'
            printf $format_l "'0'" 'the whole history,'
            printf $format_l '-<n>' 'offset to the current history number; (default: -100)'
            printf $format_s '<[-]first> [<last>]' 'just searching within a give range'
            printf '\n%s\n' 'EXAMPLES:'
            printf ${format_l/(\\t)/} 'whatwhen grml' '# Range is set to -100 by default.'
            printf $format_l 'whatwhen zsh -250'
            printf $format_l 'whatwhen foo 1 99'
        ;;
        (\?)
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (*)
            # -l list results on stout rather than invoking $EDITOR.
            # -i Print dates as in YYYY-MM-DD.
            # -m Search for a - quoted - pattern within the history.
            fc -li -m "*${first_char}${remain}*" $first $last
        ;;
    esac
# }}}
}

# retrieve weather information on the console
# Usage example: 'weather LOWG'
weather() {
    [[ -n "$1" ]] || {
        print 'Usage: weather <station_id>' >&2
        print 'List of stations: http://en.wikipedia.org/wiki/List_of_airports_by_ICAO_code'>&2
        return 1
    }

    local PLACE="${1:u}"
    local FILE="$HOME/.weather/$PLACE"
    local LOG="$HOME/.weather/log"

    [[ -d $HOME/.weather ]] || {
        print -n "Creating $HOME/.weather: "
        mkdir $HOME/.weather
        print 'done'
    }

    print "Retrieving information for ${PLACE}:"
    print
    wget -T 10 --no-verbose --output-file=$LOG --output-document=$FILE --timestamping http://weather.noaa.gov/pub/data/observations/metar/decoded/$PLACE.TXT

    if [[ $? -eq 0 ]] ; then
        if [[ -n "$VERBOSE" ]] ; then
            cat $FILE
        else
            DATE=$(grep 'UTC' $FILE | sed 's#.* /##')
            TEMPERATURE=$(awk '/Temperature/ { print $4" degree Celcius / " $2" degree Fahrenheit" }' $FILE| tr -d '(')
            echo "date: $DATE"
            echo "temp:  $TEMPERATURE"
        fi
    else
        print "There was an error retrieving the weather information for $PLACE" >&2
        cat $LOG
        return 1
    fi
}
# }}}



# finally source a local zshrc and grmlsmall-specific configuration {{{

# The following file is used to remove zsh-config-items that do not work
# in grml-small by default.
# If you do not want these adjustments (for whatever reason),
# there are three ways to accomplish that:
#  a) at the beginning of this file (variables section), set
#     $GRMLSMALL_SPECIFIC to 0 or comment out the variable definition.
#  b) remove/rename .zshrc.grmlsmall
#  c) comment out the following line
(( GRMLSMALL_SPECIFIC > 0 )) && isgrmlsmall && source ~/.zshrc.grmlsmall

# this allows us to stay in sync with /etc/skel/.zshrc
# through 'ln -s /etc/skel/.zshrc ~/.zshrc' and put own
# modifications in ~/.zshrc.local
xsource "${HOME}/.zshrc.local"

# }}}

## END OF FILE #################################################################
# vim:foldmethod=marker autoindent expandtab shiftwidth=4
