DockerAlias.configure do |config|
  config.repo = 'rorla/rorla'
  config.tag = 'latest'
  config.options = ['--link mysql:mysql']
  config.enviroments = {
    'SECRET_KEY_BASE'   => ENV['RORLA_SECRET_KEY_BASE'],
    'MANDRILL_USERNAME' => ENV['MANDRILL_USERNAME'],
    'MANDRILL_APIKEY'   => ENV['MANDRILL_APIKEY'],
    'RORLA_HOST'        => ENV['RORLA_HOST']
  }
  config.port_maps = ['80:80']
end if defined?(DockerAlias)