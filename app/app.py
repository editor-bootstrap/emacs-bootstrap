import os
import shutil
from flask import (
    Flask,
    request,
    Response,
    render_template,
    send_from_directory
)

from app.generator import TemplateGenerator


app = Flask(__name__)
app.config.from_pyfile('config.cfg')


@app.route('/')
def index():
    return render_template(
        'index.html',
        langs=app.config['LANGS'],
        themes=app.config['THEMES'],
        completion_frontends=app.config['COMPLETION_FORNTENDS'],
    )


@app.route('/generate', methods=['POST'])
def generate_configs():
    theme = request.form.get('theme', None)
    frontend = request.form.get('frontend', None)
    languages = request.form.getlist('langs')

    if not all([languages, theme, frontend]):
        return Response("All fields are mandatory", 400)

    templates_path = os.path.join(
        app.config['EMACS_TEMPLATES_PATH'],
        app.config['DEFAULT_EDITOR']
    )

    generator = TemplateGenerator(templates_path)
    generator.set_param('languages', languages)
    generator.set_param('theme', theme)
    generator.set_param('theme_package', _get_theme_package(theme))
    generator.set_param('frontend', frontend)
    generator.set_param('generated_files', app.config['GENERATED_FILES'])
    directory = generator.generate_files()

    shutil.make_archive(
        os.path.join(directory, 'emacs.d'),
        'zip',
        root_dir=directory,
        base_dir='emacs.d'
    )
    return send_from_directory(directory=directory, filename='emacs.d.zip')


def _get_theme_package(theme_name):
    themes = app.config['THEMES']
    for theme in themes:
        if theme['id'] == theme_name:
            return theme['pkg']
