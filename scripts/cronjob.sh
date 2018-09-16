echo "pushing docker image"
gcloud builds submit --tag gcr.io/your-project-name/scraping-sample .

echo "Initializing CronJob"
kubectl delete cronjob scraping-sample-cronjob
echo "Setting CronJob configuration"
kubectl create -f kube/cronjob.yml

echo ""
echo "--- configuration complete! ---"
kubectl get cronjob scraping-sample-cronjob
kubectl get jobs --watch

echo ""
echo "if you want to use port-forwarding, please run this command"
echo "$ kubectl port-forward pod/<pod-id> 5900 5900"
