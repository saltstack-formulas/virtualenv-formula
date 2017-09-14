{% from "virtualenv/map.jinja" import virtualenv with context %}

virtualenv:
  pkg.installed:
    - name: {{ virtualenv.pkg }}
