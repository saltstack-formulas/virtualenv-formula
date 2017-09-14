# -*- coding: utf-8 -*-
# vim: ft=sls

# state:    virtualenv/config.sls
# author:   @dseira
# date:     2017-09-11
# version:  0.0.1
# comment:  Configure virtualenv projects

{% from "virtualenv/map.jinja" import virtualenv with context %}

{% if 'project' in virtualenv %}
{% for project,options in virtualenv.project.items() %}

{% if ( 'enabled' in options and options.enabled ) or 'enabled' not in options %}

virtualenv.create_folder_{{ project }}:
    file.directory:
        - names:
            - {{ options.name }}
        - user: {{ options.user | default('root') }}
        - group: {{ options.group | default('root') }}
        - dir_mode: '{{ options.mode | default('755') }}'
        - makedirs: True

virtualenv.deploy_{{ project }}:
    virtualenv.managed:
        - name: {{ options.name }}
        {% if 'cwd' in options %}
        - cwd: {{ options.cwd }}
        {% endif %}
        - user: {{ options.user | default('root') }}
        {% if 'requirements' in options %}
        - requirements: {{ options.requirements }}
        {% endif %}
        {% if 'pip_pkgs' in options %}
        - pip_pkgs:
            {% for pkg in options.pip_pkgs %}
            - {{ pkg }}
            {% endfor %}
        {% endif %}
        - use_wheel: {{ options.use_wheel | default('False') }}
        {% if 'python' in options %}
        - python: {{ options.python }}
        {% endif %}
        - no_chown: {{ options.no_chown | default('False') }}
        - no_deps: {{ options.no_deps | default('False') }}
        {% if 'pip_exists_action' in options %}
        - pip_exists_action: {{ options.pip_exists_action }}
        {% endif %}
        {% if 'proxy' in options %}
        - proxy: {{ options.proxy }}
        {% endif %}
        {% if 'env_vars' in options %}
        - env_vars:
            {% for var,var_options in options.env_vars.items() %}
            {{ var }}: '{{ var_options }}'
            {% endfor %}
        {% endif %}
        - no_use_wheel: {{ options.no_use_wheel | default('False') }}
        - pip_upgrade: {{ options.pip_upgrade | default('False') }}
        - process_dependency_links: {{ options.process_dependency_links | default('False') }}
        - system_site_packages: {{ options.system_site_packages | default('False') }}
        - distribute: {{ options.distribute | default('False') }}
        {% if 'extra_search_dir' in options %}
        - extra_search_dir: {{ options.extra_search_dir }}
        {% endif %}
        {% if 'never_download' in options %}
        - never_download: {{ options.never_download }}
        {% endif %}
        {% if 'prompt' in options %}
        - prompt: {{ options.prompt }}
        {% endif %}
        {% if 'index_url' in options %}
        - index_url: {{ options.index_url }}
        {% endif %}
        {% if 'extra_index_url' in options %}
        - extra_index_url: {{ options.extra_index_url }}
        {% endif %}
        - pre_releases: {{ options.pre_releases | default('False') }}
        {% if 'pip_download' in options %}
        - pip_download: {{ options.pip_download }}
        {% endif %}
        {% if 'pip_download_cache' in options %}
        - pip_download_cache: {{ options.pip_download_cache }}
        {% endif %}
        - pip_ignore_installed: {{ options.pip_ignore_installed | default('False') }}
        - use_vt: {{ options.use_vt | default('False') }}
        - pip_no_cache_dir: {{ options.pip_no_cache_dir | default('False') }}
        {% if 'pip_cache_dir' in options %}
        - pip_cache_dir: {{ options.pip_cache_dir }}
        {% endif %}
        - process_dependency_links: {{ options.process_dependency_links | default('False') }}

{% else %}

virtualenv.delete_{{ project }}:
    file.absent:
        - name: {{ options.name }}

{% endif %}
{% endfor %}
{% endif %}
