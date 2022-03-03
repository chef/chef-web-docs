set -eou pipefail

# test on one repo
repos=[chef/workstation]
# repos=["chef/automate", "chef/chef-server", "chef/desktop-config", "chef/supermarket", "chef/workstation", "inspec/inspec", "inspec/CLOUD_RESOURCES", "habitat-sh/habitat"]

for i in ${repos}

do
  repo=$i
  branch="expeditor/update_docs_lints_${EXPEDITOR_REPO}"
  git checkout -b "$branch"
  git add .

  # give a friendly message for the commit and make sure it's noted for any future
  # audit of our codebase that no DCO sign-off is needed for this sort of PR since
  # it contains no intellectual property

  dco_safe_git_commit "Update ${repo} docs lints."

  open_pull_request

  # Get back to main and cleanup the leftovers - any changed files left over at
  # the end of this script will get committed to main.
  git checkout -
  git branch -D "$branch"
done
