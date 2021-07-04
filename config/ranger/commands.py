from pyperclip import copy
from os import listdir
from ranger.api.commands import Command
def linux2windows(lin_path):#converts a linux path to the windows equivalent
    if not lin_path.startswith("/mnt/"):#file not in windows
        print('path cannot be converted to windows')
        return ''
    else:
        return lin_path[5].upper()+':'+lin_path[6:].replace('/','\\')
class yank(Command):
    def execute(self):
        option1=self.args[1]
        under=self.fm.thisfile#item under cursor
        #neutral yanks
        if option1=='content':#content to clipboard
            if under.is_directory:
                copy('\n'.join(listdir(under.path)))
            else:
                with open(under.path,'r') as file:copy(file.read())
        elif option1=='name':
            copy(under.basename)
        elif option1=='name_without_extension':
            copy(under.basename[:under.basename.rindex('.')])
        #linux yanks
        elif option1=='linux':
            option2=self.args[2]
            if option2=='path':copy(under.path)
            elif option2=='cwd':copy(self.fm.thisdir.path)
        #windows yanks
        elif option1=='windows':#windows yanks
            option2=self.args[2]
            if option2=='path':copy(linux2windows(under.path))
            elif option2=='cwd':copy(linux2windows(self.fm.thisdir.path))
