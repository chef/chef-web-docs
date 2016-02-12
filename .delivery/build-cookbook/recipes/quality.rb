################################################################################
# Welcome to the quality phase
#
# This phase is run as the delivery user
################################################################################

# Setup the handler goodness as was discussed in the default recipe
include_recipe 'build-cookbook::_handler'

include_recipe 'build-cookbook::_install_dependencies'
