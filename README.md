# Monitoring and Observability

This project demonstrates a monitoring and observability setup for a PHP application. It includes various tools and services to monitor application performance, log analysis, and system metrics.

**Disclaimer**: This project is not production-ready and is intended solely for educational purposes to showcase how to build an observability and monitoring system.

To know more about me and what I do, visit [my website](https://simonedamico.com).

## Services

The following services are included in this project:

- **PHP**: Runs the PHP application.
- **Nginx**: Serves the PHP application.
- **PostgreSQL**: Database for the application.
- **Prometheus**: Collects and stores metrics from the application and other services.
- **Grafana**: Visualizes metrics collected by Prometheus.
- **Elasticsearch**: Stores and indexes logs for analysis.
- **Logstash**: Processes and forwards logs to Elasticsearch.
- **Kibana**: Visualizes logs stored in Elasticsearch.

## Setup

To set up the project, run the following commands:

```bash
make up
make stress-test
```

## How it works 

The `stress-test/stress-test.sh` script simulates traffic to the application by sending HTTP requests:  

- **200 OK**: Sent continuously.
- **404 Not Found**: Sent every 10 successful requests.
- **500 Internal Server Error**: Sent every 20 successful requests.

The `stress-test/stress-test-500.sh` script simulates traffic to the application by sending HTTP requests with a 500 error response.

This helps test the monitoring and logging setup under different conditions.

## Accessing Services

Once the setup is complete, you can access the services at the following URLs:

* PHP Application: http://localhost:8080/200
* Grafana: http://localhost:3000
* Prometheus: http://localhost:9090
* Kibana: http://localhost:5601
