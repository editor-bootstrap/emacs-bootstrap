serve: venv
	. venv/bin/activate ; FLASK_APP=app/application.py flask run

venv:
	python3 -m venv venv
	. venv/bin/activate ; python3 -m pip install -r requirements.txt
