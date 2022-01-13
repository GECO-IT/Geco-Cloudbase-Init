import os
import shutil
import ctypes

def remove_drive():
    drive_letter = os.popen('wmic logicaldisk where VolumeName="config-2" get Caption | findstr /I ":"').read()
    if drive_letter:
        LOG.debug('Eject metadata drive: %s', str(drive_letter).rstrip())
        ctypes.windll.WINMM.mciSendStringW(u"open " + str(drive_letter).rstrip() + " type cdaudio alias d_drive", None, 0, None)
        ctypes.windll.WINMM.mciSendStringW(u"set d_drive door open", None, 0, None)