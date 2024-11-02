
### Ansible Cheat Sheet

```markdown
# Ansible Cheat Sheet

## 1. Basics

### Inventory
- **Definition**: Lists the hosts on which to run commands.
- **Syntax**: Define in an `inventory.ini` file.
  
Example:
```ini
[webservers]
web1.example.com
web2.example.com

Playbooks

    Definition: YAML files that define tasks to be run on hosts.

Example:

yaml

- hosts: webservers
  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present

2. Modules
Commonly Used Modules

    apt: Package management for Debian-based systems.

Example:

yaml

- name: Install package
  apt:
    name: git
    state: latest

    copy: Copy files from local to remote.

Example:

yaml

- name: Copy file
  copy:
    src: /local/file.txt
    dest: /remote/file.txt

3. Variables
Defining Variables

    Syntax: Define variables in playbooks.

Example:

yaml

vars:
  package_name: git

tasks:
  - name: Install package
    apt:
      name: "{{ package_name }}"
      state: present

4. Handlers
Definition

    Purpose: Run tasks when notified.

Example:

yaml

tasks:
  - name: Restart Apache
    service:
      name: apache2
      state: restarted
    notify: Restart Apache

handlers:
  - name: Restart Apache
    service:
      name: apache2
      state: restarted

5. Templates
Using Jinja2 Templates

    Purpose: Create dynamic files.

Example:

yaml

- name: Deploy configuration
  template:
    src: template.j2
    dest: /etc/config.conf

6. Best Practices

    Use YAML Best Practices: Maintain indentation and structure.
    Use Roles for Reusability: Structure playbooks in roles.