Some knife commands, such as `knife data bag edit`, require that
information be edited as JSON data using a text editor. For example, the
following command:

``` bash
$ knife data bag edit admins admin_name
```

will open up the text editor with data similar to:

``` javascript
{
  "id": "admin_name"
}
```

Changes to that file can then be made:

``` javascript
{
  "id": "Justin C."
  "description": "I am passing the time by letting time pass over me ..."
}
```

The type of text editor that is used by knife can be configured by
adding an entry to your config.rb file, or by setting an `EDITOR`
environment variable. For example, to configure knife to open the `vim`
text editor, add the following to your config.rb file:

``` ruby
knife[:editor] = "/usr/bin/vim"
```

When a Microsoft Windows file path is enclosed in a double-quoted string
(" "), the same backslash character (`\`) that is used to define the
file path separator is also used in Ruby to define an escape character.
The config.rb file is a Ruby file; therefore, file path separators must
be escaped. In addition, spaces in the file path must be replaced with
`~1` so that the length of each section within the file path is not more
than 8 characters. For example, if EditPad Pro is the text editor of
choice and is located at the following path:

    C:\\Program Files (x86)\EditPad Pro\EditPad.exe

the setting in the config.rb file would be similar to:

``` ruby
knife[:editor] = "C:\\Progra~1\\EditPa~1\\EditPad.exe"
```

One approach to working around the double- vs. single-quote issue is to
put the single-quotes outside of the double-quotes. For example, for
Notepad++:

``` ruby
knife[:editor] = '"C:\Program Files (x86)\Notepad++\notepad++.exe" -nosession -multiInst'
```

for Sublime Text:

``` ruby
knife[:editor] = '"C:\Program Files\Sublime Text 2\sublime_text.exe" --wait'
```

for TextPad:

``` ruby
knife[:editor] = '"C:\Program Files (x86)\TextPad 7\TextPad.exe"'
```

and for vim:

``` ruby
knife[:editor] = '"C:\Program Files (x86)\vim\vim74\gvim.exe"'
```