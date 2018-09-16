echo "pushing docker image"
gcloud builds submit --tag gcr.io/your-project-name/scraping-sample .

echo "beginnng deployment"
kubectl delete deployments --all
kubectl delete pods --all
kubectl delete services --all
kubectl create -f kube/deploy.yml

echo ""
echo "--- deployment complete! ---"
kubectl get pods
echo ""
echo "if you want to use port-forwarding, please run this command"
echo "$ kubectl port-forward pod/<pod-id> 5900 5900"
