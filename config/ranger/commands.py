from pyperclip import copy
from subprocess import Popen
from os import listdir
from ranger.api.commands import Command
def linux2windows(lin_path):#converts a linux path to the windows equivalent
    if not lin_path.startswith("/mnt/"):#file not in windows
        return False
    else:
        return lin_path[5].upper()+':'+lin_path[6:].replace('/','\\')
class yank(Command):#yanks text to clipboard
    def execute(self):
        selected=self.fm.thistab.get_selection()#items selected
        option1=self.args[1]
        if selected:
            string=''
            if option1=='name':
                for f in selected:
                    string+='\"'+{f.basename}+'\" '
            elif option1=='name_without_extension':
                for f in selected:
                    string+='\"'+f.basename[:f.basename.rindex('.')]+'\" '
            #linux yanks
            elif option1=='linux':
                option2=self.args[2]
                if option2=='path':
                    for f in selected:
                        string+='\"'+f.path+'\" '
                elif option2=='cwd':
                    string=self.fm.thisdir.path
            #windows yanks
            elif option1=='windows':#windows yanks
                option2=self.args[2]
                if option2=='path':
                    for f in selected:
                        converted=linux2windows(f.path)
                        if converted:
                            string+='\"'+converted+'\" '
                elif option2=='cwd':
                    converted=linux2windows(self.fm.thisdir.path)
                    if converted:
                        string=converted
                    else:
                        self.fm.notify('Cannot converted path to windows',bad=True)
            copy(string)
        else:
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
                if option2=='path':
                    converted=linux2windows(under.path)
                    if converted:
                        copy(converted)
                    else:
                        self.fm.notify('Cannot converted path to windows',bad=True)
                elif option2=='cwd':
                    converted=linux2windows(self.fm.thisdir.path)
                    if converted:
                        copy(converted)
                    else:
                        self.fm.notify('Cannot converted path to windows',bad=True)
class trash(Command):#sends stuff to windows recycle bin
    def execute(self):
        selected=self.fm.thistab.get_selection()
        if selected:#if selected trash items selected
            names=[i.basename for i in selected]
            Popen(['recycle.exe',*names])
            self.fm.notify(f'Sent {",".join(names)} to Recycle Bin')
        else:#trash items under cursor
            name=self.fm.thisfile.basename
            Popen(['recycle.exe',name])
            self.fm.notify(f'Sent {name} to Recycle Bin')
class unzip(Command):#unzip zip files
    def execute(self):
        Popen(['unzip','-qq',self.fm.thisfile.basename])
