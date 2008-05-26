#!/usr/bin/perl
use Switch;
use strict;

####################
## Config options ##
####################

## What distro logo to use to use, Available "Archlinux Debian None" ##
my $distro = "Archlinux";

## what values to display. Use "OS Kernel DE WM win_theme Theme Font Icons" ##
my $display = "OS Kernel WM Theme Font";

## Takes a screen shot if set to 0 ##
my $shot = 1;
## Command to run to take screen shot ##
my $command = "scrot";

## What colors to use for the variables. ##
my $textcolor = "\e[0m";

## Prints little debugging messages if set to 0 ##
my $quite = 0;



########################
## Script starts here ##
########################
## Define some thing to work with strict ##
my @line = ();
my $found = 0;
my $DE = "NONE";
my $WM = "NONE";

## Hash of WMs and the process they run ##
my %WMlist = ("Beryl", "beryl",
              "Fluxbox", "fluxbox",
              "Openbox", "openbox",
              "Blackbox", "blackbox",
              "Xfwm4", "xfwm4",
              "Metacity", "metacity",
              "Kwin", "kwin",
              "FVWM", "fvwm",
              "Enlightenment", "enlightenment",
              "IceWM", "icewm",
              "Window Maker", "wmaker",
              "Compiz-Fusion", "compiz",
              "PekWM","pekwm","dwm" );

## Hash of DEs and the process they run ##     
my %DElist = ("Gnome", "gnome-session",
              "Xfce4", "xfce-mcs-manage",
              "KDE", "ksmserver");

## Get Kernel version ##
if ( $display =~ "Kernel"){
  print "\::$textcolor Finding Kernel version\n" unless $quite == 1;
  my $kernel = `uname -r`;
  $kernel =~ s/\s+/ /g;
  $kernel = " Kernel:$textcolor $kernel";
  push(@line, "$kernel");
}

## Find running processes ##
print "\::$textcolor Getting processes \n" unless $quite == 1;
my $processes = `ps -A | awk {'print \$4'}`;

## Find DE ##
while( (my $DEname, my $DEprocess) = each(%DElist) ) {
  print "\::$textcolor Testing $DEname process: $DEprocess \n" unless $quite == 1;
  if ( $processes =~ m/$DEprocess/ ) {
    $DE = $DEname;
    print "\::$textcolor DE found as $DE\n" unless $quite == 1;
    if( $display =~ m/DE/ ) {
      push(@line, " DE:$textcolor $DE");
    }
    last;
  }
}

## Find WM ##
while( (my $WMname, my $WMprocess) = each(%WMlist) ) {
 print "\::$textcolor Testing $WMname process: $WMprocess \n" unless $quite == 1;
  if ( $processes =~ m/$WMprocess/ ) {
    $WM = $WMname;
    print "\::$textcolor WM found as $WM\n" unless $quite == 1;
    if( $display =~ m/WM/ ) {
      push(@line, " WM:$textcolor $WM");
    }
    last;
  }
}

## Find WM theme ##
if ( $display =~ m/Win_theme/ ){
  switch($WM) {
    case "Openbox" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.config/openbox/rc.xml")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
        if( /<name>(.+)<\/name>/ ) {
          while ( $found == 0 ) {
            print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
            push(@line, " WM Theme:$textcolor $1");
            $found = 1;
          }
        }
      }
      close(FILE);
    }
    case "Beryl" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.emerald/themes/schoensyDarkgreen/theme.ini")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
        if( /name=(.+)/ ) {
          print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
          push(@line, " WM Theme:$textcolor $1");
        }
      }
      close(FILE);
    }
    case "Compiz-Fusion" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.emerald/themes/schoensyDarkgreen/theme.ini")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
        if( /name=(.+)/ ) {
          print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
          push(@line, " WM Theme:$textcolor $1");
        }
      }
      close(FILE);
    }
    case "Metacity" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      my $gconf = `gconftool-2 -g /apps/metacity/general/theme`;
      print "\::$textcolor $WM theme found as $gconf\n" unless $quite == 1;
      chomp ($gconf);
      push(@line, " WM Theme:$textcolor $gconf");
    }
    case "Fluxbox" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.fluxbox/init")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
        if( /session.styleFile:.*\/(.+)/ ) {
          print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
          push(@line, " WM Theme:$textcolor $1");
        }
      }
      close(FILE);
    }
    case "Blackbox" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.blackboxrc")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
        if( /session.styleFile:.*\/(.+)/ ) {
          print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
          push(@line, " WM Theme:$textcolor $1");
        }
      }
      close(FILE);
    }
    case "Xfwm4" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.config/xfce4/mcs_settings/xfwm4.xml")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
        if( /<option name="Xfwm\/ThemeName" type="string" value="(.+)"\/>/ ) {
          print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
          push(@line, " WM Theme:$textcolor $1");
        }
  } 
      close(FILE);
    }
    case "Kwin" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.kde/share/config/kwinrc")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
        if( /PluginLib=kwin3_(.+)/ ) {
          print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
          push(@line, " WM Theme:$textcolor $1");
        }
      }
      close(FILE);
    }
    case "Enlightenment" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      my $remote = `enlightenment_remote -theme-get theme` ;
      if( $remote =~ m/.*FILE="(.+).edj"/ ) {
        print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
        push(@line, " WM Theme:$textcolor $1");
      }     
    }       
    case "IceWM" { 
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.icewm/theme")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
        if( /Theme="(.+)\/.*.theme/ ) {
          while( $found == 0 ) {
            print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
            push(@line, " WM Theme:$textcolor $1");
            $found = 1;
          }
        }
      }   
      close(FILE);
    }   
    case "PekWM" {
      print "\::$textcolor Finding $WM theme\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.pekwm/config")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
        if( /Theme.*\/(.*)"/ ) {
            print "\::$textcolor $WM theme found as $1\n" unless $quite == 1;
            push(@line, " WM Theme:$textcolor $1");
        }
      }
      close(FILE); 
    } 
  }   
}     
      
## Find Theme Icon ans Font ##
if ( $display =~ m/[Theme, Icons, Font,]/) {
  switch($DE) {
    case "Gnome" {
      print "\::$textcolor Finding $DE variables\n" unless $quite == 1;
      if ( $display =~ m/Theme/ ) {
        my $gconf = `gconftool-2 -g /desktop/gnome/interface/gtk_theme`;
        chomp ($gconf);
        print "\::$textcolor GTK Theme found as $1\n" unless $quite == 1;
        push(@line, " GTK Theme:$textcolor $gconf");
      }
      if ( $display =~ m/Icons/ ) {
        my $gconf = `gconftool-2 -g /desktop/gnome/interface/icon_theme`;
        chomp ($gconf);
        push(@line, " Icons:$textcolor $gconf");
      } 
      if ( $display =~ m/Font/ ) {
        my $gconf = `gconftool-2 -g /desktop/gnome/interface/font_name`;
        chomp ($gconf);
        push(@line, " Font:$textcolor $gconf");
      }
    } 
    case "Xfce4" {
      my @sort = ();
      print "\::$textcolor Finding $DE variables\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.config/xfce4/mcs_settings/gtk.xml")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) {
     if ( $display =~ m/Theme/ ) {
          if (/<option name="Net\/ThemeName" type="string" value="(.+)"\/>/ ) {
            print "\::$textcolor GTK Theme found as $1\n" unless $quite == 1;
            unshift(@sort, " GTK Theme:$textcolor $1");
          } 
        }
        if ( $display =~ m/Icons/ ) {
          if (/<option name="Net\/IconThemeName" type="string" value="(.+)"\/>/ ) {
            print "\::$textcolor Icons found as $1\n" unless $quite == 1;
            unshift(@sort, " Icons:$textcolor $1");
          }
        }
        if ( $display =~ m/Font/ ) {
          if ( /<option name="Gtk\/FontName" type="string" value="(.+)"\/>/ ) {
            print "\::$textcolor Font found as $1\n" unless $quite == 1;
            unshift(@sort, " Font:$textcolor $1");
          } 
        }
      }
      close(FILE);
      ## Sort variables so they're ordered "Theme Icon Font" ##
      foreach my $i (@sort) {
        push(@line, "$i");
      }
    } 
    case "KDE" { 
      print "\::$textcolor Finding $DE variables\n" unless $quite == 1;
      open(FILE, "$ENV{HOME}/.kde/share/config/kdeglobals")
      || die "\e[0;31m<Failed>\n";
      while( <FILE> ) { 
        if ( $display =~ m/Theme/ ) {
          if ( /widgetStyle=(.+)/  ) {
            print "\::$textcolor Wiget Style found as $1\n" unless $quite == 1;
            push(@line, " Wiget Style:$textcolor $1");
          }
          if (/colorScheme=(.+).kcsrc/ ) {
            print "\::$textcolor Color Scheme found as $1\n" unless $quite == 1;
            push(@line, " Color Scheme:$textcolor $1");
          }
        }
        if ( $display =~ m/Icons/ ) {
          if ( /Theme=(.+)/ ) {
            print "\::$textcolor Icons found as $1\n" unless $quite == 1;
            push(@line, " Icons:$textcolor $1");
          } 
        }   
        if ( $display =~ m/Font/ ) {
          if ( /font=(.+)/ ) {
            my $font = (split/,/, $1)[0];
            print "\::$textcolor Font found as $font\n" unless $quite == 1;
            push(@line, " Font:$textcolor $font");
          }
        }
      }
      close(FILE);
  
    }
    else {
      my @files = ("$ENV{HOME}/.gtkrc-2.0", "$ENV{HOME}/.gtkrc.mine",);
      foreach my $file (@files) {
        if ( -e $file ) {
          print "\::$textcolor Opening $file\n" unless $quite == 1; 
          open(FILE, $file)
          || die "\e[0;31m<Failed>\n";
          while( <FILE> ) {
            if ( $display =~ m/Theme/ ) {
              if( /include ".*themes\/(.+)\/gtk-(1|2)\.0\/gtkrc"/ ){
                print "\::$textcolor GTK theme found as $1\n" unless $quite == 1;
                push(@line, " GTK Theme:$textcolor $1");
              }
            }
            if ( $display =~ m/Icons/ ) {
              if( /.*gtk-icon-theme-name.*"(.+)"/ ) {
                print "\::$textcolor Icons found as $1\n" unless $quite == 1;
                push(@line, " Icons:$textcolor $1");
              }
            }
            if ( $display =~ m/Font/ ) {
              if( /.*gtk-font-name.*"(.+)"/ ) {
                print "\::$textcolor Font found as $1\n" unless $quite == 1;
                push(@line, " Font:$textcolor $1");
             }
            }
          }
          close(FILE);
        }
      }
    }
  }
}

## Display the system info ##

if ( $distro =~ m/Archlinux/ ) {

## Get Archlinux version ##
if ( $display =~ "OS"){
  print "\::$textcolor Finding Archlinux version\n" unless $quite == 1;
  my $version = `cat /etc/arch-release`;
  $version =~ s/\s+/ /g;
  $version = " OS:$textcolor $version";
  unshift(@line, "$version");
}

my $c1 = "\e[0;32m";
my $c2 = "\e[1;32m";

print "$c1              __
$c1          _=(SDGJT=_
$c1        _GTDJHGGFCVS)                $c1@line[0]
$c1       ,GTDJGGDTDFBGX0               $c1@line[1]
$c1      JDJDIJHRORVFSBSVL$c2-=+=,_        $c1@line[2]
$c1     IJFDUFHJNXIXCDXDSV,$c2  \"DEBL      $c1@line[3]
$c1    [LKDSDJTDU=OUSCSBFLD.$c2   '?ZWX,   $c1@line[4]
$c1   ,LMDSDSWH'     \`DCBOSI$c2     DRDS], $c1@line[5]
$c1   SDDFDFH'         !YEWD,$c2   )HDROD  $c1@line[6]
$c1  !KMDOCG            &GSU|$c2\_GFHRGO'   $c1@line[7]
$c1  HKLSGP'$c2           __$c1\TKM0$c2\GHRBV)'    $c1@line[8]
$c1 JSNRVW'$c2       __+MNAEC$c1\IOI,$c2\BN'
$c1 HELK['$c2    __,=OFFXCBGHC$c1\FD)
$c1 ?KGHE $c2\_-#DASDFLSV='$c1    'EF
$c1 'EHTI                   !H
$c1  \`0F'                   '!
\e[0m";
}


if ( $distro =~ m/None/ ) {
my $color = "\e[0;34m";
  foreach my $filled ( @line ) {
    print "$color $filled\n"
  }
}

if ( $distro =~ m/Debian/ ) {

## Get Debian version ##
if ( $display =~ "OS"){
  print "\::$textcolor Finding Debian version\n" unless $quite == 1;
  my $version = `cat /etc/Debian_release`;
  $version =~ s/\s+/ /g;
  $version = " OS:$textcolor $version";
  unshift(@line, "$version");
}

my $c1 = "\e[0;31m";

print "
$c1       _,met\$\$\$\$\$gg.
$c1    ,g\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$P.
$c1  ,g\$\$P\"\"       \"\"\"Y\$\$.\".              @line[0]
$c1 ,\$\$P'              \`\$\$\$.              @line[1]
$c1',\$\$P       ,ggs.     \`\$\$b:            @line[2]
$c1\`d\$\$'     ,\$P\"'   .    \$\$\$             @line[3]
$c1 \$\$P      d\$'     ,    \$\$P             @line[4]
$c1 \$\$:      \$\$.   -    ,d\$\$'             @line[5]
$c1 \$\$\;      Y\$b._   _,d\$P'               @line[6]
$c1 Y\$\$.    \`.\`\"Y\$\$\$\$P\"'                  @line[7]
$c1 \`\$\$b      \"-.__                       @line[8]
$c1  \`Y\$\$
$c1   \`Y\$\$.
$c1     \`\$\$b.
$c1       \`Y\$\$b.
$c1          \`\"Y\$b._
$c1              \`\"\"\"\"
\e[0m";   
}       
      
## Run screen shot graper ##
`$command` unless $shot != 0;
