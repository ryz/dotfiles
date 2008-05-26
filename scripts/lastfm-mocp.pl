#!/usr/bin/python -OO
"""
Last.fm-MOCP -- A monitor of MOC Player to update Last.fm
data, via lastfmsubmitd.

Version 0.1 -- 26th of January, 2007.

This program depends on MOC Player, lastfmsubmitd and Python.
You must have the three of them working properly for it to be
of any use:
http://moc.daper.net
http://www.red-bean.com/~decklin/software/lastfmsubmitd/
http://python.org


Denis Fernandez Cabrera (Gatonegro, Anarres, etc.)
<denis@ceibes.org>
http://gatonegro.ceibes.org
http://lastfm.com/user/Anarres

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
"""

import time
import lastfm
import os
import locale

#--------------------------------------
# Base data for the song.
song = {'artist': 'None', 'title': 'None',
        'album': 'None', 'mbid': 'None'}

#--------------------------------------
def mocp_data():
    """Get the song data from a running instance of MOC Player"""

    data = {'artist': 'None', 'title': 'None',
            'album': 'None', 'mbid': 'None'}
    
    log = os.popen("mocp -i")
    for line in log :
        if 'SongTitle' in line :
            data['title']  = unicode(line[line.index(":")+2:-1], "latin-1")
        if 'Artist'    in line :
            data['artist'] = unicode(line[line.index(":")+2:-1], "latin-1")
        if 'Album'     in line :
            data['album']  = unicode(line[line.index(":")+2:-1], "latin-1")
        if 'TotalSec' in line :
            data['length'] = int(line[line.index(":")+2:-1])
    log.close()
    return data

#--------------------------------------
# The main loop:

while True:
    # Store old song title...
    oldsong = song['title']
    # ...and get the new data.
    song    = mocp_data()
    # If the song has changed, update the data.
    if song['title'] != oldsong:
        log = lastfm.logger('MOC')
        log.info('Played song: %s' % lastfm.repr(song))
        song['time'] = time.gmtime()
        lastfm.submit([song])
    # Let's wait a second before repeating the loop.
    time.sleep(1)
