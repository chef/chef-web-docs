A data bag item may be encrypted using [shared secret
encryption](https://en.wikipedia.org/wiki/Symmetric-key_algorithm). This
allows each data bag item to store confidential information (such as a
database password) or to be managed in a source control system (without
plain-text data appearing in revision history). Each data bag item may
be encrypted individually; if a data bag contains multiple encrypted
data bag items, these data bag items aren't required to share the same
encryption keys.

<!-- markdownlint-disable-file MD033 -->

<div class="admonition-note">
<p class="admonition-note-title">Note</p>
<div class="admonition-note-text">

Because the contents of encrypted data bag items aren't visible to the
Chef Infra Server, search queries against data bags with encrypted items
won't return any results.

</div>
</div>
