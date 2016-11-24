import os
import tempfile
from flask import render_template_string


class TemplateGenerator:
    def __init__(self, templates_dir):
        self.generation_params = {}

        self.templates_dir = templates_dir
        self.templates_elisp_path = os.path.join(
            self.templates_dir,
            'elisp'
        )

        # Prepare temp directory to store generated configs
        self.temp_dir = tempfile.mkdtemp()
        self.temp_emacs_dir = os.path.join(self.temp_dir, 'emacs.d')
        self.temp_elisp_dir = os.path.join(self.temp_emacs_dir, 'elisp')
        os.mkdir(self.temp_emacs_dir)
        os.mkdir(self.temp_elisp_dir)

    def set_param(self, key, value):
        self.generation_params[key] = value

    def generate_files(self):
        generated_files = self.generation_params['generated_files']

        for filename in generated_files:
            print(filename)
            source_file = os.path.join(
                self.templates_dir,
                filename
            )

            target_file = os.path.join(
                self.temp_emacs_dir,
                filename
            )

            print(source_file, target_file)

            self.render_file(source_file, target_file)

        languages = self.generation_params['languages']
        for lang in languages:
            print("LANG", lang)
            lang_file = 'lang-{}.el'.format(lang)
            source_file = os.path.join(
                 self.templates_elisp_path,
                 lang_file
            )

            target_file = os.path.join(
                self.temp_elisp_dir,
                lang_file
            )

            print(source_file)
            print(target_file, end="\n\n\n")

            self.render_file(source_file, target_file)
        return self.temp_dir

    def render_file(self, source_file, target_file):
        template_content = self._get_template(source_file)

        print("11", target_file)
        print(self.generation_params)
        self._write_template(
            target_file,
            template_content,
            **self.generation_params
        )

    def _get_template(self, filename):
        print("Get template: %s" % filename)
        with open(filename) as template:
            content = template.read()
        return content

    def _write_template(self, filename, template_content, **kwargs):
        print("22", filename)
        print("\n\n")
        with open(filename, 'w+') as template_file:
            content = render_template_string(
                template_content,
                **kwargs
            )
            template_file.write(content)
