Charles Sanquer's desktop install ansible configuration
=======================================================

* Main Gitlab repository https://gitlab.com/csanquer/install-scripts
* Read Only GIthub Mirror https://github.com/csanquer/install-scripts

Ansible configuration to setup my desktop development environment.

OS supported (currently):
* Ubuntu


Install
-------

clone the repository with submodules

```bash
git clone --recursive https://github.com/csanquer/install-scripts.git
cd install-scripts
```

copy `custom_vars.yml.dist` to `custom_vars.yml` and edit it like this :

```yml
---
account_default_user_fullname: <Your Name>
account_default_user_email: <your email>
```

Then just run :

```bash
./install.sh
```
