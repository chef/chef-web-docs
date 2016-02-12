################################################################################
# Welcome to the unit phase
#
# This phase is run as the delivery user
################################################################################

# Setup the handler goodness as was discussed in the default recipe
include_recipe 'build-cookbook::_handler'

# Run unit tests on the cookbooks that are in cookbooks/
include_recipe 'delivery-truck::unit'

