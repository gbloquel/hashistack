
```{include} ../../../roles/grafana/README.md
```

## Variables


```
tf_module_name: "grafana"
tf_action: apply

packages_list:
  - grafana
grafana_url: "https://{{ grafana_public_cluster_address }}"

hs_grafana_use_custom_ca: false
hs_grafana_custom_ca_cert: "{{ hs_workspace_secrets_dir }}/ca.cert.pem"
