sync:
	git submodule update --init --remote --rebase

serve: sync
	cd site && hugo server --buildDrafts
