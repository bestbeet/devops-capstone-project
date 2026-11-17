# Capstone Evidence Checklist

Only submit screenshots, logs, and curl responses captured from real successful operations. Code and templates by themselves are not sufficient evidence of completion.

## Planning / GitHub Project
Project: https://github.com/users/bestbeet/projects/2/views/1

1. Add Issues #1-#10 from this repository to the Project (helper: `bash scripts/add-issues-to-project.sh`).
2. Use a board grouped by Status. Create: New Issues, Ice Box, Product Backlog, Sprint Backlog, In Progress, Done.
3. Create Project fields (or iteration/number fields) for Sprint and Estimate. The issue descriptions contain suggested values.
4. Take these screenshots while the appropriate stories are visibly in the relevant stage:
   - Task 3: `planning-userstories-done.png` (New Issues)
   - Task 4: `planning-productbacklog-done.png` (Ice Box)
   - Task 5: `planning-labels-done.png` (Product Backlog, issue labels visible)
   - Task 6: `planning-kanban-done.png` (Sprint 1, estimated)
   - Task 8: `rest-techdebt-done.png` (development environment Done)
   - Task 9: `read-accounts.png` (Read Done)
   - Task 10: `list-accounts.png` (List Done)
   - Task 11: `update-accounts.png` (Update Done)
   - Task 12: `delete-accounts.png` (Delete Done)
   - Task 18: `sprint2-plan.png` (two Sprint 2 stories)
   - Task 20: `ci-kanban-done.png` (CI Done after successful run)
   - Task 24: `security-kanban-done.png` (Security Done after tests)
   - Task 25: `sprint3-plan.png` (three Sprint 3 stories)
   - Task 27: `kube-docker-done.png` (Docker Done after build)
   - Task 28: `kube-kubernetes-done.png` (Kubernetes Done after deployment)
   - Task 33: `cd-pipeline-done.png` (CD Done after successful Tekton run)

Capture each intermediate stage BEFORE moving cards forward; otherwise the expected board state will no longer be visible.

## API evidence / Tasks 13-17
Install project requirements, start PostgreSQL, and run `make run`; then:
```sh
bash scripts/capture-rest-evidence.sh
```
It creates actual `evidence/rest-create-done`, `rest-list-done`, `rest-read-done`, `rest-update-done`, `rest-delete-done`.

## Tests / Tasks 19, 23
```sh
make tests 2>&1 | tee evidence/security-headers-done
```
For CI output, open GitHub Actions and download/copy the successful run's complete build job logs to `evidence/ci-workflow-done`.

## Kubernetes / Tasks 26, 29-31
```sh
docker build -t accounts:1.0 .
kubectl apply -f deploy/kubernetes/accounts.yaml
kubectl rollout status deploy/accounts --timeout=180s
bash scripts/capture-deployment-evidence.sh
kubectl port-forward svc/accounts 8080:8080
```
In a separate terminal:
```sh
curl --fail-with-body -sS http://localhost:8080/ | tee evidence/kube-app-output
```
On k3d you must ensure the image is available to cluster nodes (push into a configured registry or import the image); building locally alone does not make it deployable. Adjust the YAML image reference for your registry.

## Tekton / Tasks 32-33
These manifest examples target a **local lab k3d cluster** with a reachable **insecure** registry, not a production deployment.
```sh
kubectl apply -f tekton/rbac.yaml
kubectl apply -f tekton/tasks.yaml
kubectl apply -f tekton/pipeline.yaml
kubectl create -f tekton/run.yaml
tkn pipelinerun list
tkn pipelinerun logs <actual-run-name> --all > evidence/pipelinerun.txt
```
Change the image parameter in `tekton/run.yaml` to your actual registry endpoint before executing. The RoleBinding assumes the default namespace. Confirm rollout and only then move the CD issue to Done.

## Source links / public submission URLs
- Task 1: https://github.com/bestbeet/devops-capstone-project/blob/main/README.md (must display successful CI badge)
- Task 2: https://github.com/bestbeet/devops-capstone-project/blob/main/user-story.md
- Task 7: https://github.com/bestbeet/devops-capstone-project/blob/main/setup.cfg
- Task 21: https://github.com/bestbeet/devops-capstone-project/blob/main/.github/workflows/ci-build.yaml (must pass)
- Task 22: https://github.com/bestbeet/devops-capstone-project/blob/main/service/__init__.py
- Task 29: https://github.com/bestbeet/devops-capstone-project/blob/main/Dockerfile

**Note:** Assignment header reports 50 total points, but the supplied per-item weights add to 52. Check the grader's official weighting; aim for a margin over the threshold.
