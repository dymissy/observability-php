<?php

require 'vendor/autoload.php';

use Prometheus\CollectorRegistry;
use Prometheus\Storage\APC;
use Prometheus\RenderTextFormat;

$registry = new CollectorRegistry(new APC());

header('Content-Type: text/plain');

$renderer = new RenderTextFormat();
echo $renderer->render($registry->getMetricFamilySamples());
