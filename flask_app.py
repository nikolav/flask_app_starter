import os
from datetime import datetime
from datetime import timezone

from flask          import Flask
from flask_cors     import CORS
from flask_talisman import Talisman

from src.config import Config


FLASKAPP_PATH = os.path.dirname(__file__)

app = Flask(__name__,
            template_folder = Config.FLASK_TEMPLATES_FOLDER,
          )

app.config['SECRET_KEY'] = Config.SECRET_KEY

# services:cors
_CORS_ALLOWED_ALL = { r'.*': { 'origins': '*' } }
from src.config.cors import cors_resources
CORS(app, 
    resources = cors_resources if Config.PRODUCTION else _CORS_ALLOWED_ALL,
    supports_credentials = True, 
  )

# services:talisman
# content security headers
Talisman(app, 
         force_https=False,
        )

# routes:home
@app.route('/', methods = ('GET',))
def route_home():
  return { 
          'status' : 'ok',
          'time'   : datetime.now(timezone.utc).timestamp(),
        }

# middleware:before
from src.middleware.auth import authenticate
@app.before_request
def handle_before_request():
  return authenticate()

