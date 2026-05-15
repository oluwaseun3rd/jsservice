# jsservice
ASSESSMENT repo

1. How to start the cluster 
    "minikube start --driver=docker"

2.  How to apply Terraform
     "cd terraform/
      terraform init
      terraform apply
        # confirm with: yes"

3.   How to deploy/access the app
      "kubectl create namespace argocd
        kubectl apply -n argocd -f \
          https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

         # Wait for pods to be ready
            kubectl get pods -n argocd -w"
      # Port-forward ArgoCD (keep running in a separate terminal)
      kubectl port-forward svc/argocd-server -n argocd 8080:443

            # Log in
            argocd login localhost:8080 --username admin --insecure

                # Create the application
              argocd app create js-service \
                --repo https://github.com/oluwaseun3rd/jsservice.git \
                --path k8s \
                --dest-server https://kubernetes.default.svc \
                --dest-namespace apps \
                --sync-policy automated \
                --auto-prune \
                --self-heal    
      ArgoCD will automatically sync and deploy 2 replicas of the JSservice into the apps namespace.

  # Port-forward the JS service (keep running in a separate terminal)
       kubectl port-forward svc/js-service 9090:80 -n apps

       # Test the endpoints
              curl http://localhost:9090/health   # → {"status":"ok"}
              curl http://localhost:9090/         # → {"message":"hello","env":"dev"}


4.  How to access ArgoCD
  
       # Port-forward must be running (see step 4)
        # Open in browser:
              https://localhost:8080

           # Username: admin
           # Password:
                kubectl -n argocd get secret argocd-initial-admin-secret \
                  -o jsonpath="{.data.password}" | base64 -d && echo



                  <img width="1440" height="900" alt="Screenshot 2026-05-15 at 4 53 58 AM" src="https://github.com/user-attachments/assets/b11cbcb7-8501-4851-b239-9683cfa566e5" />
