# Scraping Sample
An easy and powerful template with the minimun you need to start web scraping with Ruby + Selenium + Docker + Google Kubernetes Engine

## Setup for local development on docker
```sh
git clone git@github.com:nullnull/scraping_sample.git
cd scraping_sample
docker-compose build
docker-compose up -d
docker-compose exec scraper sh setup.sh
docker-compose exec scraper bundle exec ruby app/fetch_search_results.rb
```

## Monitor scraping progress wth VNC
You can use [VNC server](https://qiita.com/yszk0123/items/840f16ed388fb52b0e21) to monitor selenium. Run `open vnc://localhost:5900/` and type `secret` for password.

## Deploy and Run Scraper
```sh
$ sh cronjob.sh

# to check progress with VNC
$ kubectl get pods
$ kubectl port-forward pod/<pod-id> 5900 5900
$ open vnc://localhost:5900/
```

## Slack Integration (Optional)
Set your webhook url to `SLACK_WEBHOOK_URL` on `docker-compose.yml` and `kube/cronjob.yml` / `kube/deploy.yml`.

## Data Visualization (Optional)
We recommends [redash](https://redash.io/) to visualize your scraping results. It's easy to setup and have powerful visualization features.

##### Run redash on GCE
https://redash.io/help/open-source/setup

```sh
$ gcloud compute images create "redash-2-0-0" --source-uri gs://redash-images/redash.2.0.0.b2990.tar.gz
$ gcloud compute instances create redash \
--image redash-2-0-0 --scopes storage-ro,bigquery \
--machine-type g1-small --zone asia-east1-a
# and please finsh configuraton on your GCE console.
```
