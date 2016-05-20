################################################################################
# Welcome to the unit phase
#
# This phase is run as the delivery user
################################################################################

# Run unit tests on the cookbooks that are in cookbooks/
include_recipe 'delivery-truck::unit'
