from xerox import copy
from subprocess import Popen
from os import listdir
from send2trash import send2trash
from ranger.api.commands import Command
class yank(Command):#yanks text to clipboard
    def execute(self):
        selected=self.fm.thistab.get_selection()#items selected
        option=self.args[1]
        string=''
        if option=='name':
            for f in selected:
                string+='\"'+f.basename+'\" '
        elif option=='content':
            for f in selected:
                if f.is_directory:
                    string+='\n'.join(listdir(f.path))
                else:
                    with open(f.path,'r') as f:
                        string+=f.read()+'\n'
        elif option=='name_without_extension':
            for f in selected:
                string+='\"'+f.basename[:f.basename.rindex('.')]+'\" '
        elif option=='path':
            for f in selected:
                string+='\"'+f.path+'\" '
        elif option=='cwd':
            string=self.fm.thisdir.path
        copy(string)
class trash(Command):#sends stuff to windows recycle bin
    def execute(self):
        names=[i.basename for i in self.fm.thistab.get_selection()]
        send2trash(names)
        self.fm.notify(f'Sent {",".join(names)} to root Trash')
class unzip(Command):#unzip zip files
    def execute(self):
        fails=[]
        for f in self.fm.thistab.get_selection():
            name=f.basename
            if name.endswith('.zip'):
                Popen(['unzip','-qq',name])
            if name.endswith('.tar.gz') or name.endswith('.tar.xz'):
                Popen(['tar','-xf',name])
            else:
                fails.append(name)
        if fails:
            self.fm.notify(f'{",".join(fails)} not a zip files',bad=True)
