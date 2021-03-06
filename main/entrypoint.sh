#!/bin/bash

# wait for postgres to boot
while !</dev/tcp/postgres/5432; do
	echo "Waiting for postgres..."
	sleep 1
done

# create / migrate db
bin/rails db:prepare

# start beanstalkd
beanstalkd &

while !</dev/tcp/localhost/11300; do
	echo "Waiting for beanstalkd..."
	sleep 1
done

# start background worker (send/recv line messages)
QUEUE="backburner.worker.queue.default" bin/rails backburner:work &
QUEUE="backburner.worker.queue.default" bin/rails backburner:work &

# start remote job worker
bin/remote-job-report.rb &

# start web service
# TODO: add nginx to service static files
RAILS_SERVE_STATIC_FILES=true bin/bundle exec puma -b 'ssl://0.0.0.0:443?key=/var/cert.key&cert=/var/cert.pem'
