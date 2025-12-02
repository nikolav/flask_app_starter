cors_resources = {
  r'/auth'    : {'origins': '*'},
  r'/graphql' : {'origins': '*'},
  # r'/webhook_viber_channel.*' : {'origins': '*'},
}

CORS_ALLOWED_ALL = { r'.*': { 'origins': '*' } }
