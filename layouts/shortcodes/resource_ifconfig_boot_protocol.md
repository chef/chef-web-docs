``` ruby
ifconfig "33.33.33.80" do
  bootproto "dhcp"
  device "eth1"
end
```

will create the following interface:

``` none
vagrant@default-ubuntu-1204:~$ cat /etc/network/interfaces.d/ifcfg-eth1
iface eth1 inet dhcp
```