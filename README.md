Charles Sanquer's desktop install ansible configuration
=======================================================

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

create a `custom_vars.yml` file like this :

```yml
---
account_default_user_fullname: <Your Name>
account_default_user_email: <your email>
```

Then just run :

```bash
./install.sh
```
