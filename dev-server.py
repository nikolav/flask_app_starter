if __name__ == '__main__':    
  from flask_app  import app
  from src.config import Config
  
  _port = Config.PORT

  app.run(
    debug = True,
    host  = '0.0.0.0',
    port  = _port if None != _port else 5000,
  )

