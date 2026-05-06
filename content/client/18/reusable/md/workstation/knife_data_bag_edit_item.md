To edit an item named `charlie` that's contained in a data bag named `admins`, enter:

```bash
knife data bag edit admins charlie
```

Once opened in the \$EDITOR, update the data before saving it to Chef Infra Server. For example, by changing:

```javascript
{
   "id": "charlie"
}
```

to:

```javascript
{
   "id": "charlie",
   "uid": 1005,
   "gid": "ops",
   "shell": "/bin/zsh",
   "comment": "Crazy Charlie"
}
```
