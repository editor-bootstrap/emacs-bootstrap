import os
import shutil
import tempfile
from flask import (
    Flask,
    request,
    render_template,
    render_template_string,
    send_from_directory
)

app = Flask(__name__)
app.config.from_pyfile('config.cfg')


@app.route('/')
def index():
    return render_template('index.html', langs=app.config['LANGS'])


@app.route('/generate', methods=['POST'])
def generate_configs():
    languages = request.form.getlist('langs[]')
    # Prepare Jinja
    temp_dir = tempfile.mkdtemp()
    temp_emacs_dir = os.path.join(temp_dir, 'emacs.d')
    temp_elisp_dir = os.path.join(temp_emacs_dir, 'elisp')
    os.mkdir(temp_emacs_dir)
    os.mkdir(temp_elisp_dir)

    templates_path = os.path.join(
        app.config['EMACS_TEMPLATES_PATH'],
        app.config['DEFAULT_EDITOR']
    )
    templates_elisp_path = os.path.join(
        templates_path,
        'elisp'
    )
    init_template_filename = os.path.join(
        templates_path,
        'init.el'
    )

    with open(init_template_filename) as template:
        init_template_content = template.read()

    # Generate init.el file
    with open(os.path.join(temp_emacs_dir, 'init.el'), 'w+') as init_file:
        content = render_template_string(
            init_template_content,
            langs=languages
        )
        init_file.write(content)

    # Copy non-language files
    base_files = [
        'base.el',
        'base-extensions.el',
        'base-theme.el'
    ]
    for base_file in base_files:
        base_path = os.path.join(
            templates_elisp_path,
            base_file
        )
        shutil.copyfile(base_path, os.path.join(temp_elisp_dir, base_file))

    for lang in languages:
        lang_filename = 'base-{}.el'.format(lang)
        lang_path = os.path.join(
            templates_elisp_path,
            lang_filename
        )
        shutil.copyfile(lang_path, os.path.join(temp_elisp_dir, lang_filename))

    shutil.make_archive(
        os.path.join(temp_dir, 'emacs.d'),
        'zip',
        root_dir=temp_dir,
        base_dir='emacs.d'
    )
    return send_from_directory(directory=temp_dir, filename='emacs.d.zip')
