# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:
# 13.125.108.242 rorlab.dev

server 'rorlab.local', user: 'deployer', roles: %w[app db web]

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.

# set :nginx_use_ssl, false
# set :nginx_ssl_certificate, 'rorlab.org.crt'
# set :nginx_ssl_certificate_key, 'server.key'

# set :rails_env, :production
set :nginx_server_name, 'www.rorlab.org'
set :nginx_domain_name, 'rorlab.org'

# set :puma_threads, [1, 4]
# set :puma_workers, 4

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }

set :ssh_options, {
  keys: [File.join(ENV["HOME"], ".ssh", "id_rsa")],
  forward_agent: true,
  auth_methods: %w(publickey)
}
