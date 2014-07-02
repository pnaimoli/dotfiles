import sublime, sublime_plugin
import os.path
import platform

def compare_file_names(x, y):
    if platform.system() == 'Windows' or platform.system() == 'Darwin':
        return x.lower() == y.lower()
    else:
        return x == y

class AutoSwitchCommand(sublime_plugin.WindowCommand):
    def run(self, extensions=[], nextPane=False):
        print "test"
        if not self.window.active_view():
            return

        fname = self.window.active_view().file_name()
        if not fname:
            return

        path = os.path.dirname(fname)
        base, ext = os.path.splitext(fname)

        start = 0
        count = len(extensions)

        if ext != "":
            ext = ext[1:]

            for i in xrange(0, len(extensions)):
                if compare_file_names(extensions[i], ext):
                    start = i + 1
                    count -= 1
                    break

        for i in xrange(0, count):
            idx = (start + i) % len(extensions)

            new_path = base + '.' + extensions[idx]

            if os.path.exists(new_path):
                currentIndex = self.window.active_group()
                view = self.window.open_file(new_path)
                if nextPane == True and currentIndex + 1 < self.window.num_groups():
                    self.window.set_view_index(view, currentIndex + 1, 0)
                break
