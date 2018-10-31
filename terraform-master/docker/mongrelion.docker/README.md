<p><img src="http://1000logos.net/wp-content/uploads/2017/07/Logo-Docker-500x394.jpg" alt="docker logo" title="docker" align="right" height="60" /></p>

# Ansible role: docker

[![Build Status](https://travis-ci.org/mongrelion/ansible-role-docker.svg?branch=master)](https://travis-ci.org/mongrelion/ansible-role-docker)
[![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)
[![Ansible Role](https://img.shields.io/badge/ansible%20role-mongrelion.docker-blue.svg)](https://galaxy.ansible.com/mongrelion/docker/)

## Description

Install and configure [docker](https://www.docker.com) containerization platform.

## Requirements

- Ansible >= 2.3

## Role Variables

All variables which can be overridden are stored in [defaults/main.yml](defaults/main.yml) file as well as in table below.

| Name           | Default Value | Description                        |
| -------------- | ------------- | -----------------------------------|
| `docker_compose` | yes | Install docker-compose package |
| `docker_proxy` | no | Enable HTTP proxy setup |
| `docker_http_proxy` | "" | HTTP proxy server address |
| `docker_https_proxy` | "" | HTTPS proxy server address |
| `docker_no_proxy` | "" | Comma-separated list of hosts which won't use HTTP proxy |
| `docker_version` | "17.06" | docker version which should be installed on target server. Can use `latest` for updates |
| `docker_default_config` | [ storage-driver: devicemapper, log-level: info ] | Docker daemon configuration |
| `docker_users` | [] | Add users to docker group. Users must exist before adding. Construct like `- {{ ansible_env['SUDO_USER'] \| default(ansible_user_id) }}` could be used to specify user which is used for ansible connection to host. |

## Example

### Playbooks

Just install Docker with default config
```yaml
- hosts: servers
  roles:
    - mongrelion.docker
```

Install and configure docker daemon
```yaml
- hosts: servers
  roles:
    - role: mongrelion.docker
      docker_config:
        live-restore: true
        userland-proxy: false
```

