<?php

require 'vendor/autoload.php';

use Slim\Factory\AppFactory;
use Prometheus\CollectorRegistry;
use Prometheus\Storage\APC;
use Prometheus\RenderTextFormat;
use Monolog\Logger;
use Monolog\Handler\StreamHandler;

$registry = new CollectorRegistry(new APC());

$histogram = $registry->getOrRegisterHistogram(
    'php_app', 'response_time_seconds', 'Application Response Time',
    ['status']
);

$counter = $registry->getOrRegisterCounter(
    'php_app', 'http_requests_total', 'Total HTTP Requests',
    ['status']
);

$log = new Logger('php_app');
$log->pushHandler(new StreamHandler('/var/log/php_app/app.log', Logger::INFO));

$app = AppFactory::create();
$app->addErrorMiddleware(true, true, true);

$app->get('/200', function ($request, $response) use ($histogram, $counter, $log) {
    $start = microtime(true);
    $counter->inc(['200']);
    usleep(rand(10000, 200000));
    $histogram->observe(microtime(true) - $start, ['200']);
    $log->info("200 OK");
    $response->getBody()->write("OK");
    return $response->withStatus(200);
});

$app->get('/404', function ($request, $response) use ($histogram, $counter, $log) {
    $start = microtime(true);
    $counter->inc(['404']);
    usleep(rand(10000, 200000));
    $histogram->observe(microtime(true) - $start, ['404']);
    $log->warning("404 Not Found");
    $response->getBody()->write("Not Found");
    return $response->withStatus(404);
});

$app->get('/500', function ($request, $response) use ($histogram, $counter, $log) {
    $start = microtime(true);
    $counter->inc(['500']);
    usleep(rand(10000, 200000));
    $histogram->observe(microtime(true) - $start, ['500']);
    $log->error("500 Internal Server Error");
    $response->getBody()->write("Internal Server Error");
    return $response->withStatus(500);
});

$app->get('/metrics', function ($request, $response) use ($registry) {
    $renderer = new RenderTextFormat();
    $metrics = $registry->getMetricFamilySamples();
    $result = $renderer->render($metrics);
    $response->getBody()->write($result);
    return $response->withHeader('Content-Type', RenderTextFormat::MIME_TYPE);
});

$app->run();
