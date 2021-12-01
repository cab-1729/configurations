from xerox import copy
from subprocess import Popen
from os import listdir
from os.path import exists
from shutil import move
from urllib.parse import quote
from ranger.api.commands import Command
from datetime import datetime
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
class trash(Command):
    def execute(self):
        notif=''
        for i in self.fm.thistab.get_selection():
            new_name=i.basename
            try:
                dot_index=new_name.rindex('.')
            except ValueError:#no '.' in name
                dot_index=len(new_name)
            new_path=f'/home/cab1729/.local/share/Trash/files/{new_name}'
            n=2
            while exists(new_path):
                new_name=f'{i.basename[:dot_index]}.{n}{i.basename[dot_index:]}'
                new_path=f'/home/cab1729/.local/share/Trash/files/{new_name}'
                n+=1
            with open(f'/home/cab1729/.local/share/Trash/info/{new_name}.trashinfo','w') as trashinfo:
                trashinfo.write(f'''[Trash Info]
Path={quote(i.path)}
DeletionDate={datetime.now().strftime("%Y-%m-%dT%H:%M:%S")}
''')
            move(i.basename,new_path)
            notif+=f'{i.basename}, '
        self.fm.notify(f'Sent {notif[:-2]} to Trash')
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
