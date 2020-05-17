echo "pushing docker image"
docker build . -t gcr.io/your-project-name/scraping-sample
docker push gcr.io/your-project-name/scraping-sample

echo "Running setup job"
kubectl delete cronjob scraping-sample-setup-job
kubectl create -f kube/setup-job.yml
sleep 10

echo "Start CronJob"
kubectl delete cronjob scraping-sample-cronjob
kubectl create -f kube/cronjob.yml

echo ""
echo "--- configuration complete! ---"
kubectl get cronjob scraping-sample-cronjob
kubectl get jobs --watch

echo ""
echo "if you want to use port-forwarding, please run this command"
echo "$ kubectl port-forward pod/<pod-id> 5900 5900"
