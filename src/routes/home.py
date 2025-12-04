from datetime import datetime
from datetime import timezone

from flask      import Blueprint
from flask_cors import CORS


bp_home = Blueprint('home', __name__, url_prefix = '/')

# cors blueprints as wel for cross-domain requests
CORS(bp_home)

@bp_home.route('/', methods = ('GET',))
def status_ok():
  return {
    'status' : 'ok:foo:1',
    'time'   : datetime.now(timezone.utc).timestamp(),
  }

@bp_home.route('/healthcheck', methods = ('GET',))
def resolve_healthcheck():
  return { 'ok': True }, 200

