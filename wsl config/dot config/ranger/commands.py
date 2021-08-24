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
        string=''
        #neutral yanks
        if option1=='name':
            for f in selected:
                string+='\"'+f.basename+'\" '
        elif option1=='content':
            for f in selected:
                if f.is_directory:
                    string+='\n'.join(listdir(f.path))
                else:
                    with open(f.path,'r') as f:
                        string+=f.read()+'\n'
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
class trash(Command):#sends stuff to windows recycle bin
    def execute(self):
        selected=self.fm.thistab.get_selection()
        names=[i.basename for i in selected]
        Popen(['recycle.exe',*names])
        self.fm.notify(f'Sent {",".join(names)} to Recycle Bin')
class unzip(Command):#unzip zip files
    def execute(self):
        if self.fm.thisfile.basename.endswith('.zip'):
            Popen(['unzip','-qq',self.fm.thisfile.basename])
        else:
            self.fm.notify('Not a zip file',bad=True)
