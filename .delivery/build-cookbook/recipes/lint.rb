################################################################################
# Welcome to the lint phase
#
# This recipe is run as the delivery user
################################################################################

# Are you seeing a patern yet?
include_recipe 'build-cookbook::_handler'

# Run lint against the cookbooks
include_recipe 'delivery-truck::lint'

# Here is where your lint tests for your app would go...
#
# TODO rubocop an_project (this will likely need to involve 🍸 or 🍺 )
