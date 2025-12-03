import os

from flask          import Flask
from flask_cors     import CORS
from flask_talisman import Talisman

from src.config import Config


FLASKAPP_PATH = os.path.dirname(__file__)

# app:init
app = Flask(__name__,
            template_folder = Config.FLASK_TEMPLATES_FOLDER,
          )

app.config['SECRET_KEY'] = Config.SECRET_KEY

# services:cors
from src.config.cors import cors_resources
from src.config.cors import CORS_ALLOWED_ALL
CORS(app, 
    resources = cors_resources if Config.PRODUCTION else CORS_ALLOWED_ALL,
    supports_credentials = True, 
  )

# services:talisman
#   content security headers
Talisman(app, 
         force_https=False,
        )

# routes:home
from src.routes.home import bp_home
app.register_blueprint(bp_home)

# middleware:before
from src.middleware.auth import authenticate
@app.before_request
def handle_before_request():
  return authenticate()

