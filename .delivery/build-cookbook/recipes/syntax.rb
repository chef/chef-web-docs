################################################################################
# Welcome to the syntax phase
#
# This recipe is executed as the delivery user
################################################################################

# This is as DRY as it gets
include_recipe 'build-cookbook::_handler'

# Check the syntax on the cookbooks in cookbooks/
include_recipe 'delivery-truck::syntax'

# Syntax checking for the actual project would go here
#
# TODO add a syntax check for the ruby files
