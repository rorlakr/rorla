DockerAlias.configure do |config|
  config.repo = 'rorla/rorla'
  config.tag = 'latest'
  config.options = ['--link mysql:mysql']
  config.enviroments = {
    'SECRET_KEY_BASE' => ENV['RORLA_SECRET_KEY_BASE']
  }
  config.port_maps = ['80:80']
end