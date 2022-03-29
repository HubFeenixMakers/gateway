
# The server-based syntax can be used to override options:
# ------------------------------------
 server "web-server.local",
   user: "feenix",
   roles: %w{web app db},
   ssh_options: {
#     auth_methods: %w(publickey)
     # password: "please use keys"
   }
