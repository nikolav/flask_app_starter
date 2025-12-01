import os

from dotenv import load_dotenv


load_dotenv()

_ENV = os.getenv('ENV')

class Config:
  PRODUCTION  = 'production'  == _ENV
  DEVELOPMENT = 'development' == _ENV

  PORT        = os.getenv('PORT')
  SECRET_KEY  = os.getenv('SECRET_KEY')
  
  FLASK_TEMPLATES_FOLDER = os.getenv('FLASK_TEMPLATES_FOLDER')


