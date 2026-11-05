# Monitoring Stack

This directory provisions Prometheus and Grafana for the Go API. Prometheus scrapes the backend's token-protected `/metrics` endpoint every 15 seconds and retains samples for 30 days. Grafana automatically loads the Prometheus datasource and the **LogPulse Overview** dashboard.

## Start

Two local secret files are used by this stack and ignored by Git:

- `.secrets/prometheus_metrics_token` protects the backend metrics endpoint.
- `.secrets/grafana_admin_password` stores the Grafana `admin` password.

Prometheus joins the token file's group to read it without making it world-readable. If that file's group ID is not `1000` on your host, set `PROMETHEUS_SECRET_GID` in `.env` to the value from `stat -c %g .secrets/prometheus_metrics_token`.

Start or update the monitoring services from the repository root:

```sh
docker compose up --build -d
```

Open `https://grafana.cloudeskaerp.test` and sign in as `admin`. Read the generated password with `cat .secrets/grafana_admin_password`. Ensure that this hostname resolves to the Docker host and that the wildcard certificate in `certs/` is trusted by the browser.

Prometheus has no published host port, and Caddy does not route `/metrics`; the Go endpoint requires the Prometheus bearer token. Grafana and Prometheus data are retained in the `grafana-data` and `prometheus-data` Docker volumes.
