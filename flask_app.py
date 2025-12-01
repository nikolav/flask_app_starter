import os
from datetime import datetime
from datetime import timezone

from flask import Flask

from src.config import Config


FLASKAPP_PATH = os.path.dirname(__file__)

app = Flask(__name__,
            template_folder = Config.FLASK_TEMPLATES_FOLDER,
          )

app.config['SECRET_KEY'] = Config.SECRET_KEY


# routes
@app.route('/', methods = ('GET',))
def route_home():
  return { 
          'status' : 'ok',
          'time'   : datetime.now(timezone.utc).timestamp(),
        }
