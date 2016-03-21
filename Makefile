bench_build:
	@docker build -t docker-bench -f bench/Dockerfile bench

bench_run:
	@docker run -i --name docker-bench docker-bench 

bench_cleanup_image:
	@echo "Removing old image..."
	@ssh $(CONNECT) docker images -q --filter "dangling=true" | xargs -r ssh $(CONNECT) docker rmi

bench_cleanup_container:
	@echo "Removing container..."
	@ssh $(CONNECT) docker stop docker-bench | xargs -r ssh $(CONNECT) docker rm 

bench_deploy: bench_build bench_cleanup_image


bench: bench_run bench_cleanup_container