import yaml

with (config.configdir / 'colors.yml').open() as f:
    yaml_data = yaml.load(f)

def dict_attrs(obj, path=''):
    if isinstance(obj, dict):
        for k, v in obj.items():
            yield from dict_attrs(v, '{}.{}'.format(path, k) if path else k)
    else:
        yield path, obj

for k, v in dict_attrs(yaml_data):
    config.set(k, v)


c.aliases = {'w': 'session-save', 'q': 'quit', 'wq': 'quit --save'}


c.hints.chars = "qwerasdzxc"
c.auto_save.interval = 15000
c.auto_save.session = False
c.backend = 'webengine'
c.completion.quick = True
c.confirm_quit = ['downloads']
c.content.cache.appcache = True
c.content.cookies.accept = 'no-3rdparty'
c.content.cookies.store = True
c.content.dns_prefetch = True
c.content.headers.do_not_track = True
c.content.javascript.prompt = True
c.content.local_content_can_access_file_urls = True
c.content.local_storage = True
c.content.media_capture = 'ask'
c.content.notifications = 'ask'
c.content.user_stylesheets = "user.css"
c.content.webgl = True
c.content.windowed_fullscreen = True
c.downloads.location.directory = "~/downloads"
c.downloads.location.prompt = False
c.downloads.location.suggestion = 'filename'
c.downloads.position = 'top'
c.downloads.remove_finished = 20000
c.editor.encoding = 'utf-8'
c.fonts.completion.category = 'bold 12pt Fira Code'
c.fonts.completion.entry = '12pt Fira Code'
c.fonts.debug_console = '12pt Fira Code'
c.fonts.downloads = '12pt Fira Code'
c.fonts.hints = 'bold 12pt Fira Code'
c.fonts.keyhint = '12pt Fira Code'
c.fonts.messages.error = '12pt Fira Code'
c.fonts.messages.info = '12pt Fira Code'
c.fonts.messages.warning = '12pt Fira Code'
c.fonts.prompts = '12pt Fira Code'
c.fonts.statusbar = '12pt Fira Code'
c.fonts.tabs = '12pt Fira Code'
c.hints.hide_unmatched_rapid_hints = True
c.hints.scatter = True
c.hints.uppercase = True
c.input.insert_mode.auto_enter = True
c.input.insert_mode.auto_leave = True
c.input.insert_mode.auto_load = False
c.input.insert_mode.plugins = True
c.input.spatial_navigation = False
c.messages.timeout = 2000
c.new_instance_open_target = 'tab'
c.prompt.filebrowser = True
c.prompt.radius = 0
c.qt.highdpi = False
#c.scrolling.bar = True
c.scrolling.smooth = True
c.statusbar.hide = False
c.statusbar.padding = {'top': 1, 'bottom': 1, 'left': 0, 'right': 0}
c.statusbar.position = 'bottom'
c.statusbar.widgets = ['keypress', 'url', 'scroll', 'history', 'tabs', 'progress']
c.tabs.background = True
c.tabs.favicons.scale = 1.0
c.tabs.favicons.show = 'never'
c.tabs.last_close = 'startpage'
c.tabs.mousewheel_switching = True
c.tabs.new_position.related = 'next'
c.tabs.new_position.unrelated = 'last'
c.tabs.position = 'top'
c.tabs.select_on_remove = 'prev'
c.tabs.show = 'multiple'
c.tabs.show_switching_delay = 2000
c.tabs.tabs_are_windows = False
c.tabs.title.alignment = 'center'
c.tabs.title.format = '{title}'
c.tabs.title.format_pinned = '{index}'
c.tabs.wrap = True
c.url.auto_search = 'never'
c.url.default_page = 'file:///home/sublime/git/start-page/index.html'

c.url.searchengines = {'DEFAULT': 'https://google.com/?q={}'}
c.url.start_pages = ['file:///home/sublime/git/start-page/index.html']
c.zoom.default = '100%'
c.zoom.levels = ['25%', '30%', '40%', '50%', '60%', '70%', '80%', '90%', '100%', '125%', '150%', '175%', '200%', '225%', '250%', '275%']

# Custom Keybindings

config.bind("Z", 'spawn mpv --ytdl-format=best {url}')
config.bind("z", 'hint links spawn mpv --ytdl-format=best {hint-url}')
config.bind('=', 'zoom-in')
config.bind('-', 'zoom-out')
config.bind(';d', 'hint links download')
config.bind('<Ctrl-D>', 'tab-close -o')
config.bind('F', 'hint all tab')
config.bind('K', 'tab-next')
config.bind('J', 'tab-prev')
config.bind('M', 'bookmark-add')
config.bind('N', 'search-prev')
config.bind('<Ctrl-d>', 'tab-close')
config.bind('f', 'hint')
config.bind('B', 'set-cmd-text -s :bookmark-load -t')


